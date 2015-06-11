From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation clarification on git-checkout regarding ours/theirs
Date: Thu, 11 Jun 2015 08:37:27 -0700
Message-ID: <xmqqwpzafe88.fsf@gitster.dls.corp.google.com>
References: <1434022766-45397-1-git-send-email-simon.eu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, "Simon A. Eugster" <simon.eugster@eps.ch>
To: "Simon A. Eugster" <simon.eu@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 11 17:37:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z34Xv-0002un-Gc
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 17:37:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbbFKPhb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 11:37:31 -0400
Received: from mail-ie0-f194.google.com ([209.85.223.194]:36664 "EHLO
	mail-ie0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750698AbbFKPha (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 11:37:30 -0400
Received: by ierx19 with SMTP id x19so2717258ier.3
        for <git@vger.kernel.org>; Thu, 11 Jun 2015 08:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=8qROeUYX57aRFxSHRdzplTvKZXQwN2EazTV0Lqg70BY=;
        b=lvKr6mBNeqHwhzgS5IVquQvBFTGmNu3U1Oi3926QKZSBq29GquEsrpgDXIwhQGgCNO
         sH19g5ux8ae3MXhe176SPVGA7Yk4ASq5U7ttkArdjb4zTK6yksFjKzf47uNepuOHaIJ0
         h4a59Lkna/jXXqNd9X4zEmZqlMzjOLKkkyVXBx0wrGeORe6p//mzImysTgrVK9lSWvy2
         V4PxsL+D/fLp76BzvDBCVLGWqCztOnrpTIJhUNc9YFyjt3oO4hNFH9pqkz70punGZk4c
         lmRH09QQDusyD8BJ6b2Jl0+jI9l39UhpTQaThOlEKv+yBytCqHff3oF/DAwviSofIKGt
         k8aQ==
X-Received: by 10.107.169.157 with SMTP id f29mr12146093ioj.74.1434037049700;
        Thu, 11 Jun 2015 08:37:29 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:683f:a599:6eb8:1b1d])
        by mx.google.com with ESMTPSA id j20sm742062igt.16.2015.06.11.08.37.28
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 11 Jun 2015 08:37:29 -0700 (PDT)
In-Reply-To: <1434022766-45397-1-git-send-email-simon.eu@gmail.com> (Simon
	A. Eugster's message of "Thu, 11 Jun 2015 13:39:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271419>

"Simon A. Eugster" <simon.eu@gmail.com> writes:

> From: "Simon A. Eugster" <simon.eugster@eps.ch>
>
> Signed-off-by: Simon A. Eugster <simon.eugster@eps.ch>
> ---
>  Documentation/git-checkout.txt | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
> index d263a56..5c3ef86 100644
> --- a/Documentation/git-checkout.txt
> +++ b/Documentation/git-checkout.txt
> @@ -115,7 +115,11 @@ entries; instead, unmerged entries are ignored.
>  --ours::
>  --theirs::
>  	When checking out paths from the index, check out stage #2
> -	('ours') or #3 ('theirs') for unmerged paths.
> +	('ours', HEAD) or #3 ('theirs', MERGE_HEAD) for unmerged paths.
> ++
> +After a `git pull --rebase`, for example, 'ours' points to the remote
> +version and 'theirs' points to the local version. See linkgit:git-merge[1]
> +for details about stages #2 and #3.

I think it is a good idea to mention that it takes a switching of
viewpoint [*1*] when reading ours/theirs during "git rebase" (and by
extension "git pull --rebase").

But I am afraid that it may be detrimental to say 'for example' and
mentioning _only that_ for two reasons:

 - it does not make it clear what is said in that paragraph is an
   exception, which would mislead those who are doing "git pull"
   without rebase (for them, --ours is their own work, --theirs is
   what they are pulling from outside).

 - it does not make it clear that the paragraph is giving a
   warning---many people who think they know what they are doing
   would stop reading carefully after seeing 'for example', so those
   who do use 'rebase' (either 'git rebase' or 'git pull --rebase')
   would miss the subtlety.

Perhaps rephrasing it to make it clear that this describes a warning
about an exception may be needed?  Starting the paragraph like so,
perhaps:

    Note that during `git rebase` and `git pull -rebase`, 'ours' and
    'theirs' may appear to be swapped (i.e. 'ours' is the history
    from the remote or the history onto which you are rebasing, and
    'theirs' is the history of your private work).  This is for such
    and such reasons...


[Footnote]

*1* The reason why ours/theirs appear to be swapped during a rebase
is because you are temporarily assuming the role of the keeper of
the canonical history while doing so.  A rebase is to treat the
history that came from the remote as the canonical one, and then
treat what you did as the "third party" work that need to be
integrated into the canonical history.  That makes what you obtained
from the remote "ours" (i.e. the shared history of our project we
collectively own) and yoru work "theirs" (i.e. other people's work
to be integrated into "our" shared history, but you happen to be
that "other people" in this case).
