Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2052DC433DB
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 16:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFADF22C9E
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 16:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbhAEQUT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 11:20:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbhAEQUS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 11:20:18 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D23C061793
        for <git@vger.kernel.org>; Tue,  5 Jan 2021 08:19:38 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id a6so15626qtw.6
        for <git@vger.kernel.org>; Tue, 05 Jan 2021 08:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ga9HJs3NH6zr75M7iDJYuZm0pOXzqO101vIgW9e+Fp4=;
        b=C5Dm2DHmPTb4Nzii8sDcgL79lQoZu9TtUXjBDTW5/X/pKr2ehZg895ER+fPmDxNgzC
         CH6bbxzq31FEF0+jW2m8LKtx/ZQ+phbsSL8pbkibQaxd4hHJ4l18hy/Z5GoYLuHhMBbq
         rp0XWpy6SA7QWD1xUSZ1WIu5f3jCABSQ8MVGVd6xqF09NPfJhFxQd5UnKhVXJwdIukvA
         NDaL/uvwB6UiG0/0YVF1yyGIc5dZORG+XHD7xWTAg5ZxYuooNBKfIO/jv+6o4PRIlg/1
         66jo+051V0WSCzkhttfR4zy3LGiTUUcGQftFQ+ImDz5UDZfu0Z/wRDJLmlRwRjzpPnb+
         CFdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ga9HJs3NH6zr75M7iDJYuZm0pOXzqO101vIgW9e+Fp4=;
        b=bb+UFAKgJbXCTDX7LHB1FcPCqsR9zyoI26LbISXWW6NnQOmYDSvvfMefoZ2dYrf/fZ
         rbmFQ+Qez9SDEflL8k49vfU7Uvs/bP1Gi0JrsMw/lN8H0ogOVDTiQG6PgdGhH9f8INJp
         YWhJnXjA/tuNuM2PPs7bstGoG57Ck1bE/sITKt0fvfYFn5Gr1nRFrAbufHTTz+7+j6Rx
         v1+jqhjqP4CyfHYofC00kqLSLh1ABXPd7/BHCBaPFgF5WZIOeesXoWzej1zcIpojLzuu
         /zPOPJJAQwgpV1MfoCzshqMbchZ2cbjXqIx4FToW7rGsCG2Pc+ByeSLv2RQDTCt+bnaa
         7XVQ==
X-Gm-Message-State: AOAM5332zXBEgM3uUr+GwqvIIxf850/CteoGZ25jPTu4FdR0FFxYHMyM
        Ov0s3z6iVsCSrKzyCQorEBVKMmotMQM=
X-Google-Smtp-Source: ABdhPJzhjIhWE6E49juFFlAythgKUW9NxEpRU2/GDJ5rR54dxryeio1R1//8kbC9Ju8pCUTKYPXsaA==
X-Received: by 2002:ac8:4553:: with SMTP id z19mr241156qtn.278.1609863577812;
        Tue, 05 Jan 2021 08:19:37 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id b78sm263094qkg.29.2021.01.05.08.19.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jan 2021 08:19:36 -0800 (PST)
Subject: Re: [PATCH v6 08/13] merge-recursive: move better_branch_name() to
 merge.c
To:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
References: <20201116102158.8365-1-alban.gruin@gmail.com>
 <20201124115315.13311-1-alban.gruin@gmail.com>
 <20201124115315.13311-9-alban.gruin@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <4efb8024-b8c4-a69e-c5ce-4ad43781ecc3@gmail.com>
Date:   Tue, 5 Jan 2021 11:19:36 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <20201124115315.13311-9-alban.gruin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/24/2020 6:53 AM, Alban Gruin wrote:
> better_branch_name() will be used by merge-octopus once it is rewritten
> in C, so instead of duplicating it, this moves this function
> preventively inside an appropriate file in libgit.a.  This function is
> also renamed to reflect its usage by merge strategies.

s/preventively/preemptively/

> diff --git a/cache.h b/cache.h
> index be16ab3215..2d844576ea 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1933,7 +1933,7 @@ int checkout_fast_forward(struct repository *r,
>  			  const struct object_id *from,
>  			  const struct object_id *to,
>  			  int overwrite_ignore);
> -
> +char *merge_get_better_branch_name(const char *branch);
>  
>  int sane_execvp(const char *file, char *const argv[]);

I tend to avoid adding new things to the enormous cache.h, but the
best place I could see was refs.h next to repo_default_branch_name().

Maybe cache.h is fine.

-Stolee

