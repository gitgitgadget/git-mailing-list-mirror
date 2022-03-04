Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE824C433F5
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 22:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiCDW7z (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 17:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiCDW7z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 17:59:55 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7848AC925
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 14:59:06 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id m3-20020a17090a3f8300b001bd33af55f2so5470477pjc.1
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 14:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=fXwIwfqJ6CCw9w1XWoFqC1VvKnb6qqGzNOc6yaIY+RI=;
        b=mmNIxxR529nCAdfxO7KQ86mPvQxzu8OLQYcai0Fv7JaokMOYlXJJ74I0W+1GHPJjFe
         slCiuDKbyJCSv03Mcy2kqTK2f2QDtGIbpyjJQsN5FLk4BzSChLMP3ZMEWo6EghLBGgUM
         15ByBYnVuXzSBIgn+F1EAHqJeU3ryDoNMj2ydL0jeo1pb1H3PfukdUbrRWvbyUs1BhB3
         0zX74dlfjP7rIS2Wm05gJkr/R6n8Uzb2FrmXjgp5ZNesxbE2SvfO+6wux16GRECHW8zI
         egvnRkbsLTawiHuvsQl/DPHTShklS+a45RAJzMKhf+AZOR0017u9PS333zL2j588as0+
         s2PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=fXwIwfqJ6CCw9w1XWoFqC1VvKnb6qqGzNOc6yaIY+RI=;
        b=o9Yr53faIAI4aJH/etc0HtyUvyywifPaT3SQXeIh5SS2SNlA4GlztEfPYPjMWPXiCR
         4mdJZMfsFchqyY9E5t0wXl/kVX53wH/8geLI6a/kVEbrpKag+JvFExyUKLxEmgzSfZ1C
         LnnnQj1zkI6hXSk2APc88wS3oR7k/XtK0nL8MhqmlKMOfhypYct8/ZmqgfSMKI782itS
         mNlFfcxGLRRhzuM4doqqwKKe1jlWqkXdobMvMVCn8HB/C2u83GAQ5cXeLA47Ib6y4JZk
         mRlIm7tFschHsFi/TdXKpz3Ov42a6d5AGuU7gzygxYxfa5FCp1G8iaVsVHRHi12uVLsh
         2MMw==
X-Gm-Message-State: AOAM531Nq9Uh7x2N+oaSd31RuxncvANRbl4+xwfKAI/aYnlA0CGgLtVR
        fy4niTkZeFgBgh0WEaqFxIXEP8De8tHOtCj4XBrX
X-Google-Smtp-Source: ABdhPJxGrs6Tq2WqcXfTju+2ny7OQGNocP8d6NTetqqItcAOPAhYkxN9ZcDAlNBbsZOOHbAk7loqYGJXVmFxlFkWYtkO
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90b:4a11:b0:1bf:2381:b251 with
 SMTP id kk17-20020a17090b4a1100b001bf2381b251mr6806993pjb.166.1646434746339;
 Fri, 04 Mar 2022 14:59:06 -0800 (PST)
Date:   Fri,  4 Mar 2022 14:59:04 -0800
In-Reply-To: <20220304005757.70107-4-chooglen@google.com>
Message-Id: <20220304225904.640082-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: Re: [PATCH v4 03/10] t5526: create superproject commits with test helper
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:
>  test_expect_success "'--recurse-submodules=on-demand' doesn't recurse when no new commits are fetched in the superproject (and ignores config)" '
> -	add_upstream_commit &&
> -	(
> -		cd submodule &&
> -		(
> -			cd subdir/deepsubmodule &&
> -			git fetch &&
> -			git checkout -q FETCH_HEAD
> -		) &&
> -		git add subdir/deepsubmodule &&
> -		git commit -m "new deepsubmodule" &&
> -		new_head=$(git rev-parse --short HEAD) &&
> -		check_sub $new_head
> -	) &&
> +	add_submodule_commits &&
>  	(
>  		cd downstream &&
>  		git config fetch.recurseSubmodules true &&

The deletion of the block in which we updated
submodule/subdir/deepsubmodule and submodule was a cause for concern,
but now I think it's fine - add_upstream_commit already adds a commit in
the submodule that would be fetched if we were to recurse into it. But
since we are not recursing when no new commits are fetched in the
superproject, we just have to detect that the commit added in
add_upstream_commit wasn't fetched.

OK - patches up to and including this one look good.
