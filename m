From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/log: fix description of format.pretty
Date: Mon, 12 Nov 2012 09:42:51 -0800
Message-ID: <7vwqxqk99g.fsf@alter.siamese.dyndns.org>
References: <CALkWK0=hdmYF2VoOZY4F7+yPD8D0rBnPY-tvp5pryRWp-0WBeg@mail.gmail.com>
 <20121112080527.GB3581@elie.Belkin>
 <CALkWK0nR_9mWDKzKygR379x3L=d4bGKKo27AP-2Y=+coc7H+sQ@mail.gmail.com>
 <20121112153855.GA3546@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 18:43:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXy2O-0005CU-50
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 18:43:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753795Ab2KLRmz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 12:42:55 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39860 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751984Ab2KLRmy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 12:42:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6BB569420;
	Mon, 12 Nov 2012 12:42:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=EF1y6VU8Mgi28S2qlV2r0kQ0xlQ=; b=JjPDVlhCoh8WtSw7fUa2
	xiTBha/ZL22Fz4EFhOoLqUNqWq+W4nYO8k7hju3csPmrYQLitfoB0VSdAcZZLH6s
	p2it9dSnfcssCUhVB0IydykCpaZQbXOolm6rV2+yleOGmBOxHEXmcWXdQZ1/NMr3
	LxOWl8ILgne/xGeuKLVbHLg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=eyqxyAjJBhqJ0N0wLPzI3fZtBEoQtEDiE/oQ3GaqSGD4Z2
	S+b5rm9v4dQ3viO3xPpYs8FjbPXFWeoAZutro/5ma4UunrtaXwN5I3F29NOS4meg
	LXfF50bA6TvGb+THN4h3yO8LInRMeoVwd4dZHhoYsLR1tlNevcbKj8KRbDSS0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 59DEE941F;
	Mon, 12 Nov 2012 12:42:53 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A900C941B; Mon, 12 Nov 2012
 12:42:52 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 62451E0C-2CF0-11E2-8D9F-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209496>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Ramkumar Ramachandra wrote:
>
>> Oops, I read about `--pretty` in pretty-formats.txt and didn't realize
>> that `--format` existed.  However, your patch is still wrong because
>> there seems to be a subtle (and confusing) difference between
>> `--pretty` and `--format`.  In the latter, you can't omit the format,
>> and expect it to be picked up from format.pretty:
>>
>>   $ git log --format
>>   fatal: unrecognized argument: --format

We probably should say "--format needs an argument" here.

> ... It is based on the
> following text from Documentation/config.txt:
>
> 	format.pretty::
> 		The default pretty format for log/show/whatchanged command,
> 		See linkgit:git-log[1], linkgit:git-show[1],
> 		linkgit:git-whatchanged[1].
>
> I do imagine it can be made clearer.  s/--format/--pretty/ does not go
> far enough --- it only replaces one confusing explanation with
> another.

The --format and --pretty are more or less the same thing since
3a4c1a5 (Add --format that is a synonym to --pretty, 2009-02-24).
The --format option was added as a synonym because majority of new
users who have never heard of --pretty found it more natural; in
that sense, Ram's patch goes backwards.

The entry in config.txt came from 94c22a5 (log/show/whatchanged:
introduce format.pretty configuration, 2008-03-02) that predates the
synonym, and originally it was to allow

    [format] pretty = fuller

to make "git log" by default use "git log --pretty=fuller" in the
configuration; back then there wasn't a support for custom formats
like

    [format] pretty = "%h %s"

until 3640754 (Give short-hands to --pretty=tformat:%formatstring,
2009-02-24) introduced it.

"The default pretty format" in the description was written to refer
to the original "raw/medium/short/email/full/fuller" set, but these
days, we accept anything that you can write after "--pretty=" (or
its synonym "--format=") on the command line.

This is one of the reasons why I do not want to see abbreviated
descriptions for configuration variables duplicated in the manual
pages of individual commands, as the practice tends to lead to this
kind of confusion.
