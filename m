From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Use 'fast-forward' all over the place
Date: Sat, 24 Oct 2009 10:50:05 -0700
Message-ID: <7v3a587kc2.fsf@alter.siamese.dyndns.org>
References: <1256373092-15126-1-git-send-email-felipe.contreras@gmail.com>
 <1256373092-15126-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 24 19:50:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1kl8-00028k-GX
	for gcvg-git-2@lo.gmane.org; Sat, 24 Oct 2009 19:50:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751597AbZJXRuM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Oct 2009 13:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbZJXRuM
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Oct 2009 13:50:12 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45305 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349AbZJXRuL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Oct 2009 13:50:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A454683B9B;
	Sat, 24 Oct 2009 13:50:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1wY0wL0Q6PbOEn2J/26p2n127Zo=; b=bNjrtv
	3jgAq4endonqfqieZifr/ttIFJxfBnZ0sdRRCsVivCinllHYSMvPU4XFxWvFIJ1c
	4Y9mlX64cm7J64ia/qPSPHaAok+XyQ6fi4uCiv+PDR/5EtZoOBMTDCrk/40oU7qo
	7OoIoCtfoHwDFmIQZlxqs4FOMYx7xGRaJ9zbc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VSA2tlIy8fud6pP4R9X0F4ksOd4XbthW
	KGDdEIgLHbFVIyr0nlSHtbBir3q3uaSevqXcJW/i6xbWqHZwW1WP8JeMvCpri+Uc
	GAkX3VoxoZGLcuW/3D2s2YvcvRy/9iqMcvJ5O4Wz0znDKAi2moNiE3ScngpTpr7j
	8qSBkuaAXRc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7C36783B9A;
	Sat, 24 Oct 2009 13:50:11 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 28F5383B99; Sat, 24 Oct 2009
 13:50:06 -0400 (EDT)
In-Reply-To: <1256373092-15126-2-git-send-email-felipe.contreras@gmail.com>
 (Felipe Contreras's message of "Sat\, 24 Oct 2009 11\:31\:32 +0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AD344496-C0C5-11DE-9251-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131169>

Is this meant to replace the previous one that is already queued: a0c0ecb
(user-manual: use 'fast-forward', 2009-10-11)?

It seems that these mostly match a mechanical token replacement
"s/([fF])ast forward/$1ast-forward/g" in the Documentation area,
but I suspect there may be some manual fixes.

Token-replace is much harder to review than to produce, as the result of
such mechanical substitution needs to be examined to see if each change
makes sense individually.

I suspect the patch would have been much easier to the reviewers it it
stated somewhere in the log message:

 (1) how the mechanical change was produced;

 (2) what criteria was used to choose between leaving the mechanical
     change as-is and rewording them manually; and

 (3) where these non-mechanical changes are.

Here are the list of paths I looked at (during this sitting which did
not go til the end of the patch):

> diff --git a/Documentation/config.txt b/Documentation/config.txt

OK

> diff --git a/Documentation/git-http-push.txt b/Documentation/git-http-push.txt

OK

> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt

OK, except for two hunks below I am not absolutely sure.

> @@ -60,7 +60,7 @@ EXAMPLES below for details.
>  Pushing an empty <src> allows you to delete the <dst> ref from
>  the remote repository.
>  +
> -The special refspec `:` (or `{plus}:` to allow non-fast forward updates)
> +The special refspec `:` (or `{plus}:` to allow non-fast-forward updates)
>  directs git to push "matching" branches: for every branch that exists on
>  the local side, the remote side is updated if a branch of the same name
>  already exists on the remote side.  This is the default operation mode

Hmm, is non-fast-forward a yet another compound word?

> @@ -342,9 +342,9 @@ git push origin :experimental::

Likewise.

> diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
> diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
> diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
> diff --git a/Documentation/git-send-pack.txt b/Documentation/git-send-pack.txt
> diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
> diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
> diff --git a/Documentation/howto/maintain-git.txt b/Documentation/howto/maintain-git.txt
> diff --git a/Documentation/howto/revert-branch-rebase.txt b/Documentation/howto/revert-branch-rebase.txt
> diff --git a/Documentation/howto/update-hook-example.txt b/Documentation/howto/update-hook-example.txt
> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt

OK, except for this hunk I am not sure about.

> @@ -2115,7 +2115,7 @@ $ git checkout release && git pull
>  
>  Important note!  If you have any local changes in these branches, then
>  this merge will create a commit object in the history (with no local
> -changes git will simply do a "Fast forward" merge).  Many people dislike
> +changes git will simply do a fast-forward merge).  Many people dislike
>  the "noise" that this creates in the Linux history, so you should avoid
>  doing this capriciously in the "release" branch, as these noisy commits
>  will become part of the permanent history when you ask Linus to pull

It may be Ok not to emphasize this word but that is not about "fast
forward" vs "fast-forward".  It is more about "in this context, this word
does not have to be emphasized" kind of copy-editing which does not have
to be limited to the case where the "word" is 'fast-forward'.

It is my policy not to look at one patch for more than 30 minutes in one
sitting, because I'll get sloppier toward the end, so I'll stop here for
now.  Help in reviewing the rest is appreciated.
