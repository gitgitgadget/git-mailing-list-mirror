From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] tests: use "env" to run commands with temporary env-var settings
Date: Thu, 20 Mar 2014 12:25:48 -0700
Message-ID: <xmqqd2hgy8n7.fsf@gitster.dls.corp.google.com>
References: <1395312670-1843-1-git-send-email-unsignedzero@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Tran <unsignedzero@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 20:26:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQibn-0000ip-CM
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 20:26:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759731AbaCTT0T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 15:26:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45852 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759725AbaCTT0Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 15:26:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E94A74B5F;
	Thu, 20 Mar 2014 15:26:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xBjht659jv7JsCekH00X6bOoQYk=; b=EOFDQr
	GK8lUvu+IlMKWRJtixnz9kIM3KBE73IZCK0y8dWQtOfCyKhFpnfA5qaazRB5raV5
	j5/eYyObjC6lLPAZCHpl4MQp2CZKlwaQJWwY11xWIFou22EeuDXE6mil5yEpNH/4
	GhP28vTKEPek/M6LctLJ0mZ+UP93+7/bRLFCM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K+QdWTO556hrXo1Q8t17OW7IInFJe7hW
	0taEath5w3H4UeQnIkBFsYioPzTrNChklybjfmHc0Ga+q0lWrjOiuZu4VN9o2lfr
	fxJpkz8Kbt+cpHTmbueeIF1bYf3xeaOjSya/ABdehMvmAUDVuuhXz7GRtHqyZV8V
	NRBmf3vX6ec=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3851174B5B;
	Thu, 20 Mar 2014 15:26:16 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D2CF474ADD;
	Thu, 20 Mar 2014 15:25:50 -0400 (EDT)
In-Reply-To: <1395312670-1843-1-git-send-email-unsignedzero@gmail.com> (David
	Tran's message of "Thu, 20 Mar 2014 10:51:10 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7266933E-B065-11E3-9EE0-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244574>

David Tran <unsignedzero@gmail.com> writes:

> Ordinarily, we would say "VAR=VAL command" to execute a tested command with
> environment variable(s) set only for that command. This however does not work
> if 'command' is a shell function (most notably 'test_must_fail'); the result
> of the assignment is retained and affects later commands.
>
> To avoid this, we assigned and exported the environment variables and run such
> test(s) in a subshell like this,
>
> 	(
> 		VAR=VAL &&
> 		export VAR &&
> 		test_must_fail git command to be tested
> 	)
>
> Using the "env" utility, we should be able to say
>
> 	test_must_fail git command to be tested
>
> which is much shorter and easier to read.
>
> Signed-off-by: David Tran <unsignedzero@gmail.com>
>
> ---
> ...
>>Looks familiar ;-) but it seems the changes from the original you
>>took it from all look worsening, not improvements, to me.
> I learn more from rewriting than copying and pasting but I'll change most of it
> back then.

Sigh.  Your edits again butchered the correctness.

Re-read your "this is a new and better way to write test_must_fail"
example above, and compare it with what was queued on 'pu'.

I think we are hitting the point of diminishing or negative returns
at this point.  Let's keep 512477b1 (tests: use "env" to run
commands with temporary env-var settings, 2014-03-18) and go forward
with it.

Thanks.
