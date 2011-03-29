From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-notes.txt: clarify -C vs. copy and -F
Date: Tue, 29 Mar 2011 11:22:02 -0700
Message-ID: <7vbp0tss6t.fsf@alter.siamese.dyndns.org>
References: <09668994f10284cfa5243789a627dce8c2325bc6.1301388217.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Mar 29 20:22:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4dYh-0004Vd-1e
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 20:22:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754138Ab1C2SWS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 14:22:18 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60666 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752259Ab1C2SWQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 14:22:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C57924084;
	Tue, 29 Mar 2011 14:24:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=P/nok6nEIQhCO+4LMi/aDGNt0pk=; b=IiD3Vv
	4exdMBQT+bWT2EnIgb4HM2eINvO0/BIAGhqe+5ml8MQBrwEP/gEfEBvlELTl9lby
	aSSPfUUfIKSr/HWYMHX/LQKAXWf14btF/KO2pi+b/5pUJyxxDElbdbxG1N6ScrtS
	p/pwvC2PJkx8OhTFmppW5N6C96KuJ2r8hNBqk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hMbOFUG61kNkC3ZxYNSkecaCzxG6/wuh
	JXtV6uojyZt8kFE8i+FlEFQ6mV1Rt7/e2slx4TxmDQ/P8xO8i/uP2g8TiJ1NphJW
	MKGEC9cRkrAbV/iqhcweDErrUTVOi7OPj9vvMnI0+xjJPNU97XVEXV+D0sJg8Du9
	63xboC4Ym2Q=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 89C834083;
	Tue, 29 Mar 2011 14:23:56 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5BA024074; Tue, 29 Mar 2011
 14:23:50 -0400 (EDT)
In-Reply-To: <09668994f10284cfa5243789a627dce8c2325bc6.1301388217.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Tue, 29 Mar 2011 10:45:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B564DFC0-5A31-11E0-8886-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170297>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> The current description of '-C' together with the analogy to 'git commit
> -C' can lead to the wrong conclusion that '-C' copies notes between
> objects. Make this clearer by rewording and pointing to 'copy'.
>
> The example for attaching binary notes with 'git hash-object' followed
> by 'git notes add -C' immediately raises the question: "Why not use 'git
> notes add -F'?". Answer it (the latter is not binary-safe).
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
> In fact, the long name '--reuse-message' is really misleading, but I've been
> around long enough to refrain from trying to change it ;)

Yeah, it utterly is broken.  Why not fix it before people start making
serious use of notes?

>  Documentation/git-notes.txt |    7 +++++--
>  1 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
> index 296f314..c63b593 100644
> --- a/Documentation/git-notes.txt
> +++ b/Documentation/git-notes.txt
> @@ -138,8 +138,9 @@ OPTIONS
>  
>  -C <object>::
>  --reuse-message=<object>::
> -	Take the note message from the given blob object (for
> -	example, another note).
> +	Take the given blob object (for	example, another note) as the
> +	note message. (Use `git notes copy <object>` instead to
> +	copy notes between objects.) 
>  
>  -c <object>::
>  --reedit-message=<object>::
> @@ -272,6 +273,8 @@ $ blob=$(git hash-object -w a.out)
>  $ git notes --ref=built add -C "$blob" HEAD
>  ------------
>  
> +(You cannot simply use `git notes --ref=built add -F a.out HEAD`
> +because that is not binary-safe.)
>  Of course, it doesn't make much sense to display non-text-format notes
>  with 'git log', so if you use such notes, you'll probably need to write
>  some special-purpose tools to do something useful with them.
