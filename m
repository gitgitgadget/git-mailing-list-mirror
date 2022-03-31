Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C552EC43219
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 21:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242110AbiCaV6y (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 17:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242140AbiCaV6s (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 17:58:48 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40359243730
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 14:56:53 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id c15-20020a17090a8d0f00b001c9c81d9648so725525pjo.2
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 14:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bZPN6W1IFjghA0h9buuDj+aij3O8pWBeycvwEEu0R5E=;
        b=AJOghP4feO29s/V/VKyTWpJ8uLSavs/MQVtbcIeYrnBLUSdDEOgzAeAElmyJfHUVle
         BH6Mod9Klhch6Uy597OUrSdSj0+p2zo11F35FfoedoVAcJryDnVMSkCuoljNGsgnsPQz
         VWg3GRq2Fu3XDT2Z7ic+V/vV93StxuMHm+8tcEj/EGUpG5BdLzOWqvBsxG1v0dgFNART
         QxrHfuTFLUuweZEmJWja9IN8ogmy/iJjW5KEpsaSGCqwijsnm2d44bM7DchHNJxF/vLn
         okdzFJ0bybP1en67AYD4KIE58ZhrQaJJzp/2HUD0mfB4z9qRbS6wYwv80EB91nmmIMa8
         NXCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bZPN6W1IFjghA0h9buuDj+aij3O8pWBeycvwEEu0R5E=;
        b=OAmXsQW+Ht19tC3OompyQTiUM5YwjbCGbx882ypkJMS/6exLMpqOkgSD7DjXnZeO2v
         9tfQ9WT8S9AphT/ePsAmFd54v+hpxmrlK99KjY+w07KLCl9xm8/PyCMeV3jRa2ard/HT
         nh7hojGH9O7zwSAtCKLSlPItk7pFXTz0mFRom981BSvt7MszBiU7ebLeeb2bCAhM2I5A
         VFU/j2B2jxnhK2JHpdZ5D3Bdmhr72VQTFewVivHy2uYVaVIQpoFFw42mEUP3eT4i13sM
         KnL3W6pg/fyaJeSGOl+ypyVejSaFFAWGoQFzZy6q8lUBrcwViRzB5I/j7lIa3sW9Mvm5
         2GOw==
X-Gm-Message-State: AOAM533TCKDW+06jogM1DB5MOKoDj4ngTw0f38JtmeziuVKT2zFNJQLF
        VTa6pRw2slmcQsKI+3YNDFNM
X-Google-Smtp-Source: ABdhPJyj2DSGF5xANpNR6/snzZZO6ISR8sx/Ne6M9hOJARNS2eDfTfg2aKIKltjpKBLap668VxbYFw==
X-Received: by 2002:a17:903:206:b0:153:ebab:a52f with SMTP id r6-20020a170903020600b00153ebaba52fmr7331932plh.118.1648763812529;
        Thu, 31 Mar 2022 14:56:52 -0700 (PDT)
Received: from [192.168.0.102] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id z6-20020a056a00240600b004e17ab23340sm441152pfh.177.2022.03.31.14.56.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 14:56:52 -0700 (PDT)
Message-ID: <c483c964-3e99-4f43-3739-ca6de6670182@github.com>
Date:   Thu, 31 Mar 2022 14:56:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [WIP v1 3/4] mv: add advise_to_reapply hint for moving file into
 cone
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, git@vger.kernel.org
Cc:     derrickstolee@github.com, gitster@pobox.com
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220331091755.385961-4-shaoxuan.yuan02@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <20220331091755.385961-4-shaoxuan.yuan02@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shaoxuan Yuan wrote:
> Originally, the SKIP_WORKTREE bit is not removed when moving an out-of-cone
> file into sparse cone, thus the moved file does not show up in the working tree.
> Hint the user to use "git sparse-checkout reapply" to reapply the sparsity rules
> to the working tree, by which the SKIP_WORKTREE bit is removed.
> 
> Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
> ---
> I offered this solution becasue I'm not sure how to turn a cache_entry's 
> ce_flags back to a non-sparse state. I tried directly set it to 0 like this:
> 
> 	ce->ce_flags = 0;
> 
> But the behavior after this seems undefined. The file still won't show up
> in the working tree.
> 

What (I think) you're looking for is something like this:

	ce->ce_flags &= ~CE_SKIP_WORKTREE;

This disables only the SKIP_WORKTREE flag on the entry (leaving the others
unchanged). Similarly, you can enable SKIP_WORKTREE with:

	ce->ce_flags |= CE_SKIP_WORKTREE;

> And I found that "git sparse-checkout reapply" seems to be a nice fit for the
> job. But I guess if there is a way (there must be but I don't know) to do it
> direcly in the code, that could also be nice.
> 

This brings up an interesting point - what *do* we want to do when you move
an entry and, based on sparse checkout patterns, the SKIP_WORKTREE status
changes? In the case of sparse-checkout, I like your approach: disable
SKIP_WORKTREE if you're moving inside the sparse checkout definition. And,
this only happens if you're using the '--sparse' flag, so a user will have
to acknowledge that they're moving something sparse to do any of this. 

The other situation to consider is when you're moving something *out* of the
sparse cone; your approach right now is to move it out *without* enabling
SKIP_WORKTREE. I think this is also probably valid - you might not want to
assume a user wants to remove the file from their worktree *just* yet.
However, it does create a situation where a user has a "sparse" file active
in their repo, so *this* might be a situation where you want to advise the
user to call 'git sparse-checkout reapply' to "sparsify" that file.

In any case, you'll only want to do this if the global variable
'core_apply_sparse_checkout' is non-zero. 'SKIP_WORKTREE' can be used when
not in a sparse checkout, so you can't always change the flag based on any
sparse patterns (because there might not be any!). 

>  builtin/mv.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/builtin/mv.c b/builtin/mv.c
> index 9da9205e01..5f511fb8da 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -138,6 +138,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  {
>  	int i, flags, gitmodules_modified = 0;
>  	int verbose = 0, show_only = 0, force = 0, ignore_errors = 0, ignore_sparse = 0;
> +	int advise_to_reapply = 0;
>  	struct option builtin_mv_options[] = {
>  		OPT__VERBOSE(&verbose, N_("be verbose")),
>  		OPT__DRY_RUN(&show_only, N_("dry run")),
> @@ -383,6 +384,11 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  		pos = cache_name_pos(src, strlen(src));
>  		assert(pos >= 0);
>  		rename_cache_entry_at(pos, dst);
> +		if (!advise_to_reapply &&
> +			!path_in_sparse_checkout(src, &the_index) &&
> +			path_in_sparse_checkout(dst, &the_index)) {
> +				advise_to_reapply = 1;
> +			}
>  	}
>  
>  	if (gitmodules_modified)
> @@ -392,6 +398,9 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
>  		die(_("Unable to write new index file"));
>  
> +	if (advise_to_reapply)
> +		printf(_("Please use \"git sparse-checkout reapply\" to reapply the sparsity.\n"));

I know you're hoping to change your implementation so that you don't need
this advice. But, if you *do* end up needing it (or some other advice)
somewhere else, you can implement it using the 'advise()' API. For an
example on how that's used, see how 'ADVICE_SKIPPED_CHERRY_PICKS' is used in
'sequencer.c'. 

In your case, you could have something like 'ADVICE_REAPPLY_SPARSE_PATTERNS'
that, if enabled, prints a message like the one you have here.

> +
>  	string_list_clear(&src_for_dst, 0);
>  	UNLEAK(source);
>  	UNLEAK(dest_path);

As with patch 1, it would help paint a clear picture of what this patch does
if you could incorporate the tests from patch 4 into this one.
