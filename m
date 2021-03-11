Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06549C433E9
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 14:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABAED64FF3
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 14:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233865AbhCKOz1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 09:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233892AbhCKOzP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 09:55:15 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D04C061574
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 06:55:14 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id d20so23368400oiw.10
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 06:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hWdIOCNz/eni0erJ+lof5x/O26NDoVw7+WqDsRujcWU=;
        b=b3xP1jSIScRRdUXcX/K4WAWxwKuVPb8lR2ATDY1IH4O5AwsOIwDof6ELJCj/m9KOh/
         3jn8U9It/KY+0GTT64aBXYs6Uv3MxzbFgNYvq08G+w8JXkVtB9/8Bg5IwsWnMguV+/9e
         bXuP8Pzp/PA2XPA+Z2bQXDRuTUCCHbN4TKSS6YkdrgO7zNFpZzReABdLwZQ5VNQwZsGh
         PkqEaa9W4YiZ4D5PW1262tsXoB1nIJt9m1EqEVzSuNzB3FmAhS8svYPjnaoK7ffGy54X
         3XADhLJCi5Mv4I+/HK0I6wbZiGK3qW8/XOXXCFjE5zx5F1+wv8hpo4R/ZO4zLO6F6I8h
         +YcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hWdIOCNz/eni0erJ+lof5x/O26NDoVw7+WqDsRujcWU=;
        b=PliXjTkdFe3iToZAn8t/l9BpUUPaPeRR/Fx0BZqcKzqC0hTVbsLVLipQYmGxXLeJSf
         zB2MPXDOJdlf3mbgQT0vc4NdRMbuSH0aY7Ue0qt20y1tG7nL0EbP10hzSPvmIvDulf18
         K7NV+mQMrZ4qAl3+3400OXFnbMuYmGZW9qS+WBRaU4xy3mVtYKjdD5sr6apzbjzUjItw
         pAQgmeZPZMTTKah7SdD8qrHEOSaA6stQHFdIhCsdQN00a96wkStkKk9i/9gKU9zBRZLY
         QoeaVcUx6OlAlaqMDaOHJ7qZWCaPqUw/VPq7HMFkVjXWdLBTZmypmkHX3SGVYumX9cgA
         pSkg==
X-Gm-Message-State: AOAM5309UubIC6bqwOKS9+e6+bnHK94cOJV6jPCRzLiPH2IJeg91o8vB
        PrO+8BVHZQGkBJVy+7i4/ls=
X-Google-Smtp-Source: ABdhPJyRPWP6RDebtWwFcu5uItybsqnMF2/T3Rg5NxlUAT50qF7X23GWzBd61DZiGKwTJGINvFXZbg==
X-Received: by 2002:aca:a8c2:: with SMTP id r185mr631722oie.76.1615474514224;
        Thu, 11 Mar 2021 06:55:14 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:6d39:6117:2464:aeb7? ([2600:1700:e72:80a0:6d39:6117:2464:aeb7])
        by smtp.gmail.com with ESMTPSA id d26sm544330oos.32.2021.03.11.06.55.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Mar 2021 06:55:13 -0800 (PST)
Subject: Re: [PATCH v2 06/10] t6428: new test for SKIP_WORKTREE handling and
 conflicts
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.973.git.git.1614905738.gitgitgadget@gmail.com>
 <pull.973.v2.git.git.1615271086.gitgitgadget@gmail.com>
 <d1d8c017b23ff227bbf4b8b500e8a5b1f2a0ebca.1615271086.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <a478e63e-164e-9d38-0d23-5312fedf0953@gmail.com>
Date:   Thu, 11 Mar 2021 09:55:12 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <d1d8c017b23ff227bbf4b8b500e8a5b1f2a0ebca.1615271086.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/9/2021 1:24 AM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> If there is a conflict during a merge for a SKIP_WORKTREE entry, we
> expect that file to be written to the working copy and have the
> SKIP_WORKTREE bit cleared in the index.  If the user had manually
> created a file in the working tree despite SKIP_WORKTREE being set, we
> do not want to clobber their changes to that file, but want to move it
> out of the way.  Add tests that check for these behaviors.

Thank you for this test!
 
-Stolee
