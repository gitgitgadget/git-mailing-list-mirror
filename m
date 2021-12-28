Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2BE7C433EF
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 13:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbhL1NzZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 08:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbhL1NzX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 08:55:23 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AE6C061574
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 05:55:23 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id b85so17196428qkc.1
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 05:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=HYPCWSbYTbzvOT3rnuFGKNz4bGdHKuEDwQg4lyzwvC8=;
        b=coMQAu/gpeXZcXVBtHnv08h0/ISfrgphjRvc3F9VDQzix+hdH2hyO+9qsWROwxMyX+
         51oa3RVauFjZD6RFS62FtzE8iy+TsAYR4w6UViesxRMiKef3QUaV108aMFkXTGzfGzH9
         /H7O6PemI5DGmr5IqOIZ0ie94x+RVHAW+CG1wH8Wr31FllTMQSlxNCvamVpMxPrdoXwr
         ZMn6gW1cPAEIaAg9bZ6VBAwhWipITYc+qA8aWbLCm18d4ncm2MecUjI+p+AViiq21avK
         yP6brugEcv/M4JTtuIb59Kjq3NyDIYdMSnmu4XE9SUc6HsVk1d6lri1q6KePFRDQhboo
         vqIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HYPCWSbYTbzvOT3rnuFGKNz4bGdHKuEDwQg4lyzwvC8=;
        b=fOOexgs0WEzGP8ykv85jAEYRK/WIiR9flOadHHaBHcKv7Ey5LcOt3iMCZA4nXqoDFT
         QTyBl37RGUIiW81dkZf8kZTnFapcaGYSrH8e9FkgMBJ5+6G24cDLBzHUnm9PuZJ4SqiA
         RiuqIYFYuLSYnFsKXTrQZcsZSHsD6CRH8UrcKSjWkpRQizKBO86LqaZ/U2xwNBcEeDZj
         2ZGeLIX6fV9ub2QzoIMUZKDVCaOjMvU6HrBZQE+2zAJXg5TBVetuHsUV9bwRQ08V4x6R
         dOL2M25bin/CBoko0Wyo/cdVge0hZOHYqEvj/wZubbESVbc19u7P2peGl1LuYY9/A8n5
         hjiA==
X-Gm-Message-State: AOAM5307zVdfoWgmOWNlHHLsuLUtwFcciDHk8aBOj33ilUbatJefHEyP
        9NbHEzzfZ/N7Ld4H1XOVTeo=
X-Google-Smtp-Source: ABdhPJyDDKBqUMVzN5+Oih6Mx3f2K37LqG2TOM42xeWNm+pWLf2lKqEOb7VckeBYm+aBdHb2Yz09EQ==
X-Received: by 2002:a05:620a:1786:: with SMTP id ay6mr15147240qkb.373.1640699722601;
        Tue, 28 Dec 2021 05:55:22 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:a8af:d265:ced5:e098? ([2600:1700:e72:80a0:a8af:d265:ced5:e098])
        by smtp.gmail.com with ESMTPSA id q12sm15595247qtx.16.2021.12.28.05.55.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Dec 2021 05:55:22 -0800 (PST)
Message-ID: <78ba0d99-246b-d90c-b725-c084c8304f02@gmail.com>
Date:   Tue, 28 Dec 2021 08:55:16 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] merge-ort: fix bug with renormalization and rename/delete
 conflicts
Content-Language: en-US
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
References: <pull.1174.git.git.1640650846612.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <pull.1174.git.git.1640650846612.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/27/2021 7:20 PM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> Ever since commit a492d5331c ("merge-ort: ensure we consult df_conflict
> and path_conflicts", 2021-06-30), when renormalization is active AND a
> file is involved in a rename/delete conflict BUT the file is unmodified
> (either before or after renormalization), merge-ort was running into an
> assertion failure. 

This "the file is unmodified" is critical, as when I looked at the test,
it seemed too simple. I asked myself, "Why does renormalization matter
here?" Turns out it is just an artifact of the carefully organized cases.

>  		if (opt->renormalize &&
>  		    blob_unchanged(opt, &ci->stages[0], &ci->stages[side],
>  				   path)) {
> -			ci->merged.is_null = 1;
> -			ci->merged.clean = 1;
> -			assert(!ci->df_conflict && !ci->path_conflict);
> +			if (!ci->path_conflict) {
> +				/*
> +				 * Blob unchanged after renormalization, so
> +				 * there's no modify/delete conflict after all;
> +				 * we can just remove the file.
> +				 */
> +				ci->merged.is_null = 1;
> +				ci->merged.clean = 1;
> +				 /*
> +				  * file goes away => even if there was a
> +				  * directory/file conflict there isn't one now.
> +				  */
> +				ci->df_conflict = 0;
> +			} else {
> +				/* rename/delete, so conflict remains */
> +			}

This breakdown of the cases is informative, and I like how self-contained
the change is.

> +test_expect_success 'rename/delete vs. renormalization' '
> +	git init subrepo &&
> +	(
> +		cd subrepo &&
> +		echo foo >oldfile &&
> +		git add oldfile &&
> +		git commit -m original &&
> +
> +		git branch rename &&
> +		git branch nuke &&
> +
> +		git checkout rename &&
> +		git mv oldfile newfile &&
> +		git commit -m renamed &&
> +
> +		git checkout nuke &&
> +		git rm oldfile &&
> +		git commit -m deleted &&
> +
> +		git checkout rename^0 &&
> +		test_must_fail git -c merge.renormalize=true merge nuke >out &&
> +
> +		grep "rename/delete" out
> +	)
> +'
> +
>  test_done

I tested this on the latest 'master' and saw the following:

  git: merge-ort.c:3846: process_entry: Assertion `!ci->df_conflict && !ci->path_conflict' failed

so it indeed hits this case.

This patch looks good to me. Thanks!

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>

