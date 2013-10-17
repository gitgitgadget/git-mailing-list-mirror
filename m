From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/config.txt: denyDeleteCurrent applies to bare repos too
Date: Thu, 17 Oct 2013 15:23:20 -0700
Message-ID: <xmqq4n8fy1t3.fsf@gitster.dls.corp.google.com>
References: <1381886818-14337-1-git-send-email-bcasey@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <bcasey@nvidia.com>
X-From: git-owner@vger.kernel.org Fri Oct 18 00:23:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWvyb-0001lc-0I
	for gcvg-git-2@plane.gmane.org; Fri, 18 Oct 2013 00:23:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757286Ab3JQWXZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Oct 2013 18:23:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35590 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753053Ab3JQWXY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Oct 2013 18:23:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3AFBC4B0A5;
	Thu, 17 Oct 2013 22:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0GNzvR4lzTlkjPr82yfmRka2ris=; b=GmIkX9
	cbVXZIW8o0OUdNkD2s9FQs2zbSjlOvvV71yx/LCusmtbfIgAsJ29peGsUVsC9s4B
	4It6n3mp6JP5+muo39oOl9Q38kCK9g+45eay9bf420kq5lpHkg/WI4Yd+DoKtQNR
	MMz2MGudx7pp5ysnS8Sfbkhp0kblst5OFkQJg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lqU5G6XwwkunPuC0zFeiVzRjmCDLQEcY
	0LD9qSxlLy2eEdhS9BNNArGvodTdzidP7iydHsJvsAq9gwf4QoZbTB0VdR18Zj5j
	D/3D1dpxvO2DpxSjcuBdAthGvQK2K4tmoGcgSOPq0SEvIeHk65rec+osCOfYNhJ9
	hE7zQpb15XQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2ED934B0A4;
	Thu, 17 Oct 2013 22:23:23 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 82ABF4B09E;
	Thu, 17 Oct 2013 22:23:22 +0000 (UTC)
In-Reply-To: <1381886818-14337-1-git-send-email-bcasey@nvidia.com> (Brandon
	Casey's message of "Tue, 15 Oct 2013 18:26:58 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BBACE6D8-377A-11E3-A421-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236328>

Brandon Casey <bcasey@nvidia.com> writes:

> From: Brandon Casey <drafnel@gmail.com>
>
> The setting of denyDeleteCurrent applies to both bare and non-bare
> repositories.  Correct the description on this point, and expand it to
> provide some background justification for the current behavior and
> describe the full suite of settings.
>
> Signed-off-by: Brandon Casey <drafnel@gmail.com>
> ---
>  Documentation/config.txt | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index c3f7002..3d416ec 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1993,8 +1993,15 @@ receive.denyDeletes::
>  	the ref. Use this to prevent such a ref deletion via a push.
>  
>  receive.denyDeleteCurrent::
> -	If set to true, git-receive-pack will deny a ref update that
> -	deletes the currently checked out branch of a non-bare repository.
> +	If set to true or "refuse", git-receive-pack will deny a ref update
> +	that deletes the currently checked out branch of a non-bare repository,
> +	or the "default" branch in a bare repository.  i.e. the branch
> +	that HEAD refers to.

It reads just fine without the part that you found the need for
clarification with "i.e.", i.e.

	or the branch that HEAD points at in a bare repository.

without introducing a new word "default branch" that is not defined
in the glossary.

> +	Deleting the current branch from a remote will
> +	cause the HEAD symbolic ref to become dangling and will result in the
> +	next clone from it to not check out anything.

This sentence tells truth but does not fit in the logic flow in the
paragraph. I am reading it as primarily meant to be an explanation
why it would be a good idea to apply this seemingly non-bare only
option (implied by "current" in its name---it is so rare for a bare
repository to repoint its HEAD that the concept of "current" does
not mesh well with a bare one) to a bare one. It may be a good thing
to have, but the thought-process may flow better if it is made as a
FYI after the main text, i.e.

                If set to true or "refuse", `git-receive-pack` will deny a
                ref update that deletes the branch that HAED points at.  If
                set to "warn", ... If set to false or "ignore", ... Defaults
                to "refuse".
        +
        Deleting the branch that HEAD points at will cause the HEAD symbolic
        ref to become dangling.  This causes the next commit to become a
        "root" commit, disconnected from the old history, in a non-bare
        repository.  It also causes the next clone from such a repository
        (either bare or non-bare) not to check out anything.

perhaps?
