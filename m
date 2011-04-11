From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] supply '-n' to gzip to produce identical tarballs
Date: Mon, 11 Apr 2011 12:24:05 -0700
Message-ID: <7vei58wq0a.fsf@alter.siamese.dyndns.org>
References: <1302415936-7362-1-git-send-email-frase@frase.id.au>
 <m362qm4kvu.fsf@localhost.localdomain>
 <20110410101345.GD1521@bacardi.wooloowin.frase.id.au>
 <201104101555.09798.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fraser Tweedale <frase@frase.id.au>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 11 21:24:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9Mim-0004MR-8L
	for gcvg-git-2@lo.gmane.org; Mon, 11 Apr 2011 21:24:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755175Ab1DKTYT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2011 15:24:19 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:65283 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754507Ab1DKTYP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2011 15:24:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E446159DB;
	Mon, 11 Apr 2011 15:26:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bLSjfIuwogUozH5glGGYFlIux5A=; b=ZsxwI+
	peRFMGPq7UychpFOBlv3neHWav2M0OHHoeKETzjtiH+qiDVNyHTlcPguj1q16ELg
	O1OJxtdMR26JrqEDily7jDgWbZbaDeVuYTHgRvg3NMRKBrIFVm1cpG752eWCQQ/y
	veuwlYsaZeAxq9QjG/NCsBAs8f1Dl0szeFwBU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Wxf5PvT8ETVL20GGahPTQViGg+ziVFKN
	OSAoMfiN4uisKN1O/fb5Y39uSXOVNqdhJjhXMbu1ZlxLuM1SwiqJwnIJMggg2WXL
	wFgtNqvVaBToRa7O8sh5hnl4ncLID+3ByGBFy81Ue9frbMwtr1HYaQS3ZMNJqw48
	oiwIMxQpcL0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B037D59DA;
	Mon, 11 Apr 2011 15:26:09 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 82A0559D9; Mon, 11 Apr 2011
 15:26:05 -0400 (EDT)
In-Reply-To: <201104101555.09798.jnareb@gmail.com> (Jakub Narebski's message
 of "Sun, 10 Apr 2011 15:55:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8DEDDB1E-6471-11E0-8102-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171350>

Jakub Narebski <jnareb@gmail.com> writes:

>> > Perhaps it would be more clear to use
>> > 
>> >   +		'compressor' => ['gzip', '--no-name']},
>
>> Definitely, if the argument is the same (or even present) on all systems.
>> On FreeBSD and GNU both '-n' and '--no-name' are do the job, but an audit
>> of other systems should be done to ensure they don't break.  I chose '-n'
>> as it seemed the more conservative choice.
>
> So you choose '-n' because it has more chance of being widely supported,
> isn't it?  Good enough for me.

Interesting.  "gzip <COPYING" does get a consistent result because it can
fstat to get the timestamp, but "cat COPYING | gzip" does change its
output every time it is run.  Good catch and a solution.  Thanks, both.

So I should expect a pull request sometime after 1.7.5 final from you,
with "an audit of other systems" done by others on the list noted in the
final commit message?
