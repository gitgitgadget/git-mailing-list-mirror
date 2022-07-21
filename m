Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE966C43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 14:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiGUON5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 10:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiGUONw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 10:13:52 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1D952FD5
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 07:13:51 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id b133so1876658pfb.6
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 07:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4LRNIFLK8LohSIZtD6wHE3bprQEY24yljhwCLEiA+UI=;
        b=F+RO9T+PrdUZClqAyHOKKz7GZ1+lS9KoKRlkEoWv8woLbQ0aCEImMOwsdKgd5S297U
         Bc/fW7sNaLCXjSPpRaCDfbEyhK1PjnffmPWcP0Z5V2ABLk+vFxjaHcwbNb2AZ5cmiV1o
         OQ5ERbvE5yOKBm83qHgPhte4D4N2I+IQFz3jlW0gs5CW7TLm6qxxXYzOc4k4J250/B8f
         fxAO2EENjUeJrseDeWpOm+5MjDXCaaREwBwRsdDQJlzPcY3cVfcVkGBN0KAe131NDNtZ
         Ysm22s36Dv8qjgVVj/PtLOKchzDGHCxQdSyoE2KpH2G+JsuVDTC3m1gK3z1k5vMzuX0c
         oYsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4LRNIFLK8LohSIZtD6wHE3bprQEY24yljhwCLEiA+UI=;
        b=csVdpwb2jDtX/aXqpo4UkqvI+5NBbeRZUFZ9OXjaTHz1D5yFXQYdjXieWfv8oB7xmn
         74jprgYWHqNV1gSDxh/Q8fWAXIUuWNIEPx82b5N7zXDPpACk1QjStauafkKIzbpz55Lh
         OTT6vW0CC3taZrqVSPzSFYjsciWlfOp9SBudemF4fkJw41CcBxNAGHh8YJRyDzisQjsi
         cQB1ijSdqiCkheoxYu2TGn/o6/VVeLK6TOdwHUd117gj4ncB1JGPDoMH/KT0uPJgQPfM
         bpaigZzbDri1x/+3BJ6CaLEFarcaV0gGUi6F1x0rq5pmEiNCEY7vi8aZf0LuZrEiQw28
         5lIA==
X-Gm-Message-State: AJIora9wQqOJzeNuzmMXIw9WmEaG7FRYLDyNoMaowpFh9bHfNehpwhkO
        RmaZsEr9GDPLUYucbb5ICf4=
X-Google-Smtp-Source: AGRyM1somVUbjq3XW/BiOS++i2k/Smhu5zT/vRmQNy8lDefB01dOb1+XVlj4JEYzWmwcDR2wyQcl3w==
X-Received: by 2002:a63:3fc1:0:b0:41a:604c:9d22 with SMTP id m184-20020a633fc1000000b0041a604c9d22mr8621677pga.519.1658412831124;
        Thu, 21 Jul 2022 07:13:51 -0700 (PDT)
Received: from [127.0.0.1] ([45.138.210.17])
        by smtp.gmail.com with ESMTPSA id j12-20020a170903024c00b00163e06e1a99sm1801527plh.120.2022.07.21.07.13.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 07:13:50 -0700 (PDT)
Message-ID: <ab96cbe0-f256-ea5e-8356-db11d2b773f4@gmail.com>
Date:   Thu, 21 Jul 2022 22:13:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 4/7] mv: check if <destination> is a SKIP_WORKTREE_DIR
Content-Language: en-US
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     vdye@github.com, gitster@pobox.com, git@vger.kernel.org
References: <20220719132809.409247-1-shaoxuan.yuan02@gmail.com>
 <20220719132809.409247-5-shaoxuan.yuan02@gmail.com>
 <95263c88-6894-87bb-4d52-84d8d1cc5671@github.com>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
In-Reply-To: <95263c88-6894-87bb-4d52-84d8d1cc5671@github.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/20/2022 1:59 AM, Derrick Stolee wrote:
 > On 7/19/2022 9:28 AM, Shaoxuan Yuan wrote:
 >> Originally, <destination> is assumed to be in the working tree. If it is
 >> not found as a directory, then it is determined to be either a 
regular file
 >> path, or error out if used under the second form (move into a directory)
 >> of 'git-mv'. Such behavior is not ideal, mainly because Git does not
 >> look into the index for <destination>, which could potentially be a
 >> SKIP_WORKTREE_DIR, which we need to determine for the later "moving from
 >> in-cone to out-of-cone" patch.
 >>
 >> Change the logic so that Git first check if <destination> is a directory
 >> with all its contents sparsified (a SKIP_WORKTREE_DIR). If yes,
 >> then treat <destination> as a directory exists in the working tree, and
 >
 > "treat <destination> as a directory exists in the working tree" is a bit
 > akward, and the rest of the sentence struggles with that. Starting with
 > "If yes," we could rewrite as follows:
 >
 >   If <destination> is such a sparse directory, then we should modify the
 >   index the same way as we would if this were a non-sparse directory. We
 >   must be careful to ensure that the <destination> is marked with
 >   SKIP_WORKTREE_DIR.
 >
 > (Note that I don't equate this as doing the same thing, just operating on
 > the index.)

This wording sounds more natural, thanks for the rewrite!

 >> If no, continue the original checking logic.
 >
 > I think this part doesn't need to be there, but I don't feel strongly
 > about it.
 >
 >> Also add a `dst_w_slash` to reuse the result from `add_slash()`, which
 >> was everywhere and can be simplified.
 >
 >>      else if (!lstat(dest_path[0], &st) &&
 >>              S_ISDIR(st.st_mode)) {
 >> -        dest_path[0] = add_slash(dest_path[0]);
 >> -        destination = internal_prefix_pathspec(dest_path[0], argv, 
argc, DUP_BASENAME);
 >> +        destination = internal_prefix_pathspec(dst_w_slash, argv, 
argc, DUP_BASENAME);
 >
 > Hm. I find it interesting how this works even if the directory is _not_
 > present in the index. Is there a test that checks this kind of setup?
 >
 >     git init &&
 >     >file &&
 >     git add file &&
 >     git commit -m init &&
 >     mkdir dir &&
 >     git mv file dir/
 >
 > Locally, this indeed works with the following 'git status' detail:
 >
 >         renamed:    file -> dir/file

In my impression, 'git-mv' does not seem to care about whether the
<destination> directory is in index? Given that `rename()` works so
long as the directory is in the working tree, and `rename_index_entry_at()`
cares even less about the <destination> dir?

 >>      } else {
 >> -        if (argc != 1)
 >> +        if (!path_in_sparse_checkout(dst_w_slash, &the_index) &&
 >> +            !check_dir_in_index(dst_w_slash)) {
 >> +            destination = internal_prefix_pathspec(dst_w_slash, 
argv, argc, DUP_BASENAME);
 >> +            dst_mode |= SKIP_WORKTREE_DIR;
 >
 > Looks like we are assigning dst_mode here, but not using it. I wonder if
 > you'll get a compiler error if you build this patch with DEVELOPER=1.
 >
 > You can test all of the commits in your series using this command:
 >
 >   git rebase -x "make -j12 DEVELOPER=1" <base>

Oops, it seems that I was doing the wrong way. I only run test on the
tip of the branch, without actually testing individual commits.
Will do this.

 >> +    if (dst_w_slash != dest_path[0])
 >> +        free((char *)dst_w_slash);
 >
 > Good that you are freeing this here. You might also want to set it to 
NULL
 > just in case.

I was using the `FREE_AND_NULL()` macro, but I wasn't sure since other
places in 'git-mv' only use `free()`. Though I think it is better to
`FREE_AND_NULL()`.

--
Thanks,
Shaoxuan

