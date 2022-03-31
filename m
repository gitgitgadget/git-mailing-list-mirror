Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADDEC433EF
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 16:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240034AbiCaQls (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 12:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238497AbiCaQlq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 12:41:46 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576211BFDF7
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 09:39:59 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id gb19so24508947pjb.1
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 09:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=32UlDRoOZha/+i9Rx7QVw3ptzTofnYTKgLdUgv0RLlU=;
        b=ftuBEPYt7ZqY3y7VEcw4iJ4jybEIoVB8LQvMC+Rq4aZM4BcFouaETF+e9gGxGZ95Wx
         SS4a26IrDKB1Bsg9+I1D8+wlaFEi/GfN0zs6G+/AIPdfh+iv5CXBx8GZgjDtJkr1S2SP
         R5QFsV9e3Dh+YxGTwKPbbr021B1jl4mcGLxyeWI86ytkmOaETdCnfojEkozRW0o63RiS
         GkOn9KB9BSzfWvat8jNiE+DnSzvfvo04JoFYKmLmZB0sbshe17Ls8AAzzFYvPFueoW5e
         /W1+hd/GSXY2gpWlSPUK5MLrfVxehoyhmWOuYu1fu51d6emQTBLOWVZctE8xA1XSQWOl
         tIFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=32UlDRoOZha/+i9Rx7QVw3ptzTofnYTKgLdUgv0RLlU=;
        b=H3juy+mNX7Y7d4fIUM5OroZkApsbAh0t5iMx51E+IIG4Q/X88cmC9woiZn7bbcwNVY
         PeXdJnxi9HAxm8u3anLEBrSCsmt3OIQa32VA0MR8E0hbUgKz+dE+ZE/XG6dgioisj5Ts
         b13wZyX/RW7xy4EuUd/sU7prrpoOZDnKuscGh6k7UFBdYC66eQwaM9fZ3fPnQVcymxI8
         X16Nh6tUkn2gD8cNlw4oaN1R4XKLO/Zqd8BgYgEQm2Vn4a1o1hVItUZDQjnhrCXjwHqo
         wcLH18U+thmBpjro4rD9zlhZSJ6LRuqPXcdgCD+JTO7VEtXo+/8TXKzyHunNrqKUenvT
         7e2g==
X-Gm-Message-State: AOAM531Bkk+23lAjEyGLpIQyu8xTE3yCthyeU60pgVAlm0YrlI6IaI8R
        rO8Zs3nYtzkGh6lN372RtinP
X-Google-Smtp-Source: ABdhPJy9hP2dko+a8dySvRelddkvj2O5zbiw8XOkN3AoOjEvmuhCfd+OCWPJ0kiLH1EtnKeEn3ZRrw==
X-Received: by 2002:a17:90b:1e4b:b0:1c6:edfe:70ad with SMTP id pi11-20020a17090b1e4b00b001c6edfe70admr7139893pjb.198.1648744798739;
        Thu, 31 Mar 2022 09:39:58 -0700 (PDT)
Received: from [192.168.0.102] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id p10-20020a056a000b4a00b004fd9a6a2a39sm8218374pfo.184.2022.03.31.09.39.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 09:39:58 -0700 (PDT)
Message-ID: <180efaaf-7bb5-6ed7-2fc6-3c5d5f1304db@github.com>
Date:   Thu, 31 Mar 2022 09:39:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [WIP v1 1/4] mv: check if out-of-cone file exists in index with
 SKIP_WORKTREE bit
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, git@vger.kernel.org
Cc:     derrickstolee@github.com, gitster@pobox.com
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220331091755.385961-2-shaoxuan.yuan02@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <20220331091755.385961-2-shaoxuan.yuan02@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shaoxuan Yuan wrote:
> Originally, moving a <source> file which is not on-disk but exists in
> index as a SKIP_WORKTREE enabled cache entry, "giv mv" command errors
> out with "bad source".
> 
> Change the checking logic, so that such <source>
> file makes "giv mv" command warns with "advise_on_updating_sparse_paths()"
> instead of "bad source"; also user now can supply a "--sparse" flag so
> this operation can be carried out successfully.
> 

Good commit message, this clearly explains your changes!

> Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
> ---
> I found a new problem introduced by this patch, it is written in the TODO.
> I still haven't found a better way to reconcile this conflict. Please enlighten
> me on this :-)
> 
>  builtin/mv.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/mv.c b/builtin/mv.c
> index 83a465ba83..32ad4d5682 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -185,8 +185,32 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  
>  		length = strlen(src);
>  		if (lstat(src, &st) < 0) {
> +			/*
> +			 * TODO: for now, when you try to overwrite a <destination>
> +			 * with your <source> as a sparse file, if you supply a "--sparse"
> +			 * flag, then the action will be done without providing "--force"
> +			 * and no warning.
> +			 *
> +			 * This is mainly because the sparse <source>
> +			 * is not on-disk, and this if-else chain will be cut off early in
> +			 * this check, thus the "--force" check is ignored. Need fix.
> +			 */
> +

I can clarify this a bit. 'mv' is done in two steps: first the file-on-disk
rename (in the call to 'rename()'), then the index entry (in
'rename_cache_entry_at()'). In the case of a sparse file, you're only
dealing with the latter. However, 'rename_cache_entry_at()' moves the index
entry with the flag 'ADD_CACHE_OK_TO_REPLACE', since it leaves it up to
'cmd_mv()' to enforce the "no overwrite" rule. 

So, in the case of moving *to* a SKIP_WORKTREE entry (where a file being
present won't trigger the failure), you'll want to check that the
destination *index entry* doesn't exist in addition to the 'lstat()' check.
It might require some rearranging of if-statements in this block, but I
think it can be done in 'cmd_mv'. 

> +			int pos = cache_name_pos(src, length);
> +			if (pos >= 0) {
> +				const struct cache_entry *ce = active_cache[pos];
> +
> +				if (ce_skip_worktree(ce)) {
> +					if (!ignore_sparse)
> +						string_list_append(&only_match_skip_worktree, src);
> +					else
> +						modes[i] = SPARSE;
> +				}
> +				else
> +					bad = _("bad source");

This block is good. At first, I thought it was mishandling the
'!ignore_sparse' case (i.e., that case should have included the "bad source"
assignment), but using the 'only_match_skip_worktree' list is the
appropriate way to handle it.

> +			}
>  			/* only error if existence is expected. */
> -			if (modes[i] != SPARSE)
> +			else if (modes[i] != SPARSE)
>  				bad = _("bad source");
>  		} else if (!strncmp(src, dst, length) &&
>  				(dst[length] == 0 || dst[length] == '/')) {

For a change like this, it would be really helpful to include the tests
showing how sparse file moves should now be treated in this commit. I see
that you've added some in patch 4 - could you move the ones related to this
change into this commit?

Another way you could do this is to put your "add tests" commit first in
this series, changing the condition on the ones that are fixed later in the
series to "test_expect_failure". Then, in each commit that "fixes" a test's
behavior, change that test to "test_expect_success". This approach had the
added benefit of showing that, before this series, the tests would fail and
that this series explicitly fixes those scenarios.
