Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A56C433EF
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 02:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E0AF619A6
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 02:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239981AbhKICkx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Nov 2021 21:40:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238491AbhKICkw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Nov 2021 21:40:52 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDA7C061570
        for <git@vger.kernel.org>; Mon,  8 Nov 2021 18:38:07 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id j21so70380240edt.11
        for <git@vger.kernel.org>; Mon, 08 Nov 2021 18:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=oUmtwMKczwUbcDNZu0rFvFrViznkTx7yivIAJZtGQE0=;
        b=SY1rzpXSI37/FnHVh2fgBDXmurlt5m8OfX4BaFn+UciCW+5Qz0/V26yzdi+JAGULq+
         p5LLy1mnoFW25rD0m1J3KJrLqlNCqVZ940PNfPQ2zonYpJXp1ytCEbZ1hteqr6siZu/5
         ZxWGuIeDOixpfH7a58207xyKMUC05Rw7XTsP3M1Gs+JjeHGGGW4uG+W5cJVhz8r4ahZy
         aiBK0Ws+VN0iFQ+1Hxllf63XSAS/GX8vVdiPtISlrYXYWDoWcpbdXYAjMqe8Q6YYa35C
         NznouFzdkz6mrMHxjWriMqjJRrKyzgHsFBhDlQBpwEq/vgvVdRtRCcF1xH3AU9iP96lG
         MTCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=oUmtwMKczwUbcDNZu0rFvFrViznkTx7yivIAJZtGQE0=;
        b=pu8tkLELEeB0x4Y/B/EOYbrjC6J0cePjH1p+y0fF8lZFvCJ+jFQ+z7mWfnMP4cdkeM
         6ntvH8mXSh7SRYgW/bZTxMFFRH6xMBVPkVSeK7YZ4ReLwIgQzRcuYiVlqlCpBVlkQKtE
         Vqn5M7mn3M+T4T7JuM15wsDMbpf3ZIRa00vF3rKzy9MrAjZHAXLeOixxBIIEkGcLmru7
         Ef7ooYxK4PgEhMQJybvEZeZxfJmtoJCwysd1DhJCa+yCZhDpsrBa3pU64DM9WDve9y1G
         xQP3b82tgByiSSpsl9URuXhloCD1WTlKwHVjQYX0vaLN4AEA2MD956SgLh7uYsvY0IsC
         ld5g==
X-Gm-Message-State: AOAM531p+VZ6H5hBv/udQKx23OWS0zFrSkHpzsXdW1HefB363cQp0uxY
        brZlYFy5wEiiJ/TrV2U7Wz8eVwvp8SY=
X-Google-Smtp-Source: ABdhPJx7vCN/NTHIPsR25jN/pJtqNFtuGmYr+eIyNo6ko+GStpVehDiS+n7uhrTZpw8fUCiz7fDslA==
X-Received: by 2002:a50:f18c:: with SMTP id x12mr5121371edl.357.1636425485585;
        Mon, 08 Nov 2021 18:38:05 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id b11sm10741390ede.52.2021.11.08.18.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 18:38:05 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mkH1Q-001JyW-Mn;
        Tue, 09 Nov 2021 03:38:04 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Samuel Yvon via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Samuel Yvon <samuelyvon9@gmail.com>
Subject: Re: [PATCH] builtin-commit: re-read file index before launching editor
Date:   Tue, 09 Nov 2021 03:32:34 +0100
References: <pull.1127.git.git.1636423586620.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <pull.1127.git.git.1636423586620.gitgitgadget@gmail.com>
Message-ID: <211109.86wnlicaur.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 09 2021, Samuel Yvon via GitGitGadget wrote:

> From: Samuel Yvon <samuelyvon9@gmail.com>
>
> Changes made within a pre-commit hook are not reflected within
> the editor (for instance, with `git commit --verbose`) because
> the index is re-read after the editor has been used.
>
> This has the consequence of not displaying the actual changes made
> by the pre-commit hook, but committing them anyways.
>
> While it is often argued that the hook's purpose is not to automatically
> write content to the repository, it is acknowledged that using the
> pre-commit to apply mechanical fixes on top of the existing changes
> is a supported use case, along with verifying the content.
>
> I think not seeing these mechanical fixes before commiting is incorrect.
> A developer might expect the commit to look a certain way but if the
> pre-commit goes wrong the invalid changes will go unnoticed until
> committed.
>
> Signed-off-by: Samuel Yvon <samuelyvon9@gmail.com>
> ---
>     builtin-commit: Re-read file index before launching editor
>     
>     Changes made within a pre-commit hook are not reflected within the
>     editor (for instance, with git commit --verbose) because the index is
>     re-read after the editor has been used.
>     
>     This has the consequence of not displaying the actual changes made by
>     the pre-commit hook, but committing them anyways.
>     
>     While it is often argued that the hook's purpose is not to automatically
>     write content to the repository, it is acknowledged that using the
>     pre-commit to apply mechanical fixes on top of the existing changes is a
>     supported use case, along with verifying the content.
>     
>     I think not seeing these mechanical fixes before commiting is incorrect.
>     A developer might expect the commit to look a certain way but if the
>     pre-commit goes wrong the invalid changes will go unnoticed until
>     committed.
>     
>     I had a small exchange in the Google Group before submitting this Pr.
>     Here is a link for cross-referencing:
>     https://groups.google.com/g/git-mentoring/c/FsP83I9mN6c
>     
>     As a side note, I do not know who manages the Github Repo but the
>     following description threw me off a little bit:
>     
>     Git Source Code Mirror - This is a publish-only repository and all pull requests are ignored. 
>     
>     
>     since after looking deeper it seems the PRs are not ignored.
>     
>     Signed-off-by: Samuel Yvon samuelyvon9@gmail.com
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1127%2FSamuelYvon%2Fmaint-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1127/SamuelYvon/maint-v1
> Pull-Request: https://github.com/git/git/pull/1127
>
>  builtin/commit.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 7c9b1e7be3a..e75b11d1c60 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -728,8 +728,17 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  	/* This checks and barfs if author is badly specified */
>  	determine_author_info(author_ident);
>  
> -	if (!no_verify && run_commit_hook(use_editor, index_file, "pre-commit", NULL))
> -		return 0;
> +	if (!no_verify && find_hook("pre-commit")) {
> +		if(run_commit_hook(use_editor, index_file, "pre-commit", NULL))
> +			return 0;
> +
> +		/*
> +		 * Re-read the index as pre-commit hook could have updated it,
> +		 * and write it out as a tree.
> +		 */
> +		discard_cache();
> +		read_cache_from(index_file);
> +	}
>  
>  	if (squash_message) {
>  		/*
> @@ -1051,14 +1060,6 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  		return 0;
>  	}
>  
> -	if (!no_verify && find_hook("pre-commit")) {
> -		/*
> -		 * Re-read the index as pre-commit hook could have updated it,
> -		 * and write it out as a tree.  We must do this before we invoke
> -		 * the editor and after we invoke run_status above.
> -		 */
> -		discard_cache();
> -	}
>  	read_cache_from(index_file);
>  
>  	if (update_main_cache_tree(0)) {
>
> base-commit: 5fbd2fc5997dfa4d4593a862fe729b1e7a89bcf8

This hook logic is actively being changed these days, we're currently at
batch 2/3 of 3/3 (or was it 4/4? I forget) to rewrite all these hook
interfaces.

I haven't looked carefully at this, but I've got a patch that touches
this exact logic here that'll be in-flight before too long:
https://lore.kernel.org/git/patch-v5-36.36-fe056098534-20210902T125111Z-avarab@gmail.com/

Anyway, what you have here seems orthagonal, and it looks like these two
could be combined, but on top of my linked patch we wouldn't be racy
with the new behavior either.

But (and I've got to run) check out the commit message of that patch, perhaps it links to useful past discussions/commits.

I.e. a thing not covered in your commit message is a discussion of if
the current behavior was explicitly desired by anyone, or if we just
ended up with it by accident.

The code you're moving around has a comment which seems to suggest that
what you want *is* the desired behavior, i.e. we re-read it before
invoking the editor, so we should have the updated diff, but just don't?

Or maybe I'm misunderstanding it.
