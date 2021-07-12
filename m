Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A94DC07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 20:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7330C61002
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 20:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234161AbhGLUzJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 16:55:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53274 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbhGLUzJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 16:55:09 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 31172CCF00;
        Mon, 12 Jul 2021 16:52:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eSO+QX5LJ78nigrFcP3CJJanLk7L63YOfon5dg
        5x550=; b=ZcvmS3D1rHWFJhslcNTTHjknilDJYnjrn9wO4me1avQNQ217+MKDo4
        w9z5HHgoh8TRGc0G+ihahbWlvH5jjeDK/KTPx7mzCoCD/wht3eeFE7X9ED9tKQCc
        6XENXMgKQrNMqascF3VjbqKMJ6Wf1acM49wg0zh3jbv4iSLDbEv84=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2986CCCEFF;
        Mon, 12 Jul 2021 16:52:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A63DECCEFD;
        Mon, 12 Jul 2021 16:52:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] git-diff: fix missing --merge-base docs
References: <f0e7ef2433e2836fed579f2765654c5f97d5d778.1625909286.git.liu.denton@gmail.com>
Date:   Mon, 12 Jul 2021 13:52:19 -0700
In-Reply-To: <f0e7ef2433e2836fed579f2765654c5f97d5d778.1625909286.git.liu.denton@gmail.com>
        (Denton Liu's message of "Sat, 10 Jul 2021 02:28:31 -0700")
Message-ID: <xmqqlf6b2r24.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0C87C960-E353-11EB-90A6-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> When `git diff --merge-base` was introduced, the documentation included
> a few errors.
>
> In the example given for `git diff --cached --merge-base`, the
> `--cached` flag was omitted for the `--merge-base` example. Add the
> missing flag.
>
> In the `git diff <commit>` case, we failed to mention that
> `--merge-base` is an available option. Give the usage of `--merge-base`
> as an option there.
>
> Finally, there are two errors in the usage of `git diff`. Firstly, we do
> not mention `--merge-base` in the `git diff --cached` case. Mention it
> so that it's consistent with the documentation. Secondly, we put the
> `[--merge-base]` in between `<commit>` and `[<commit>...]`. Move the
> `[--merge-base]` so that it's beside `[<options>]` which is a more
> logical grouping.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  Documentation/git-diff.txt | 10 +++++++---
>  builtin/diff.c             |  4 ++--
>  2 files changed, 9 insertions(+), 5 deletions(-)

Thanks.  Both hunks look sensible.

>
> diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
> index 7f4c8a8ce7..6236c75c9b 100644
> --- a/Documentation/git-diff.txt
> +++ b/Documentation/git-diff.txt
> @@ -51,16 +51,20 @@ files on disk.
>  	--staged is a synonym of --cached.
>  +
>  If --merge-base is given, instead of using <commit>, use the merge base
> -of <commit> and HEAD.  `git diff --merge-base A` is equivalent to
> -`git diff $(git merge-base A HEAD)`.
> +of <commit> and HEAD.  `git diff --cached --merge-base A` is equivalent to
> +`git diff --cached $(git merge-base A HEAD)`.
>  
> -'git diff' [<options>] <commit> [--] [<path>...]::
> +'git diff' [<options>] [--merge-base] <commit> [--] [<path>...]::
>  
>  	This form is to view the changes you have in your
>  	working tree relative to the named <commit>.  You can
>  	use HEAD to compare it with the latest commit, or a
>  	branch name to compare with the tip of a different
>  	branch.
> ++
> +If --merge-base is given, instead of using <commit>, use the merge base
> +of <commit> and HEAD.  `git diff --merge-base A` is equivalent to
> +`git diff $(git merge-base A HEAD)`.
>  
>  'git diff' [<options>] [--merge-base] <commit> <commit> [--] [<path>...]::
>  
> diff --git a/builtin/diff.c b/builtin/diff.c
> index 2d87c37a17..dd8ce688ba 100644
> --- a/builtin/diff.c
> +++ b/builtin/diff.c
> @@ -26,8 +26,8 @@
>  
>  static const char builtin_diff_usage[] =
>  "git diff [<options>] [<commit>] [--] [<path>...]\n"
> -"   or: git diff [<options>] --cached [<commit>] [--] [<path>...]\n"
> -"   or: git diff [<options>] <commit> [--merge-base] [<commit>...] <commit> [--] [<path>...]\n"
> +"   or: git diff [<options>] --cached [--merge-base] [<commit>] [--] [<path>...]\n"
> +"   or: git diff [<options>] [--merge-base] <commit> [<commit>...] <commit> [--] [<path>...]\n"
>  "   or: git diff [<options>] <commit>...<commit>] [--] [<path>...]\n"
>  "   or: git diff [<options>] <blob> <blob>]\n"
>  "   or: git diff [<options>] --no-index [--] <path> <path>]\n"
