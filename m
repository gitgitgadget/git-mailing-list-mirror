Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F067C4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 13:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D43FE60231
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 13:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbhHKNya (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 09:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbhHKNya (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 09:54:30 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD73C061765
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 06:54:06 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id i4so2942433ila.1
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 06:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xE0ICxaoGMgmOssKHh4SqJ0WRI7px/hYdtIahfrvXDA=;
        b=ihaUtsysqoArZ7m8ii/Cf7fh3TxeWmLo3CzQ5+mXPbvmS+5Y3a1TPFspBUbjT1/x9U
         fhvChm0CzVLdwGl9dwbW3et9h6zpvRGnovFccQbixu8YkJegEcCoAKp+erBdoH3HmtqB
         eWWOGUe8pu7AyOaY0Q0WQsvqiMn2NT3A6VQ2F3zPhOVwCcOE074Lo85sGjviIFXSchSj
         FblM4pHUbNkpP9hCi9WVLu+WaVXVCMM2PUVzrrqxbeaiDTZTdBluAPmEvtn1JkPVGop1
         WXxJUempO4Rrvgn6olCbxq53CwhoFOMcoDHpgkqKCLjoP84/UE/UJerdbDZtuqjq4rMC
         43Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xE0ICxaoGMgmOssKHh4SqJ0WRI7px/hYdtIahfrvXDA=;
        b=dgYBh/LXU4loOoRxlKxFTNTOYNCZ+O9Yg69FTEd2w9YIRQCW+gQsFPaGvciN8dgygh
         Bpmo+L5qE2IkeATrmARtE4iCAI/2PMChtfDPlRnb2MlDSX0HKbJujlENn9kFwB1f6NJH
         VBuCCC3lv3D0a+prshKGZcYHOHvw2terQclaOCfujFOtHqaTpGCdf0BnTr/wNcE6LEpu
         DxKJdVub52/10jPCNj9yC9UTiFxzhBIZYSMQlsYLyQmzxMuXR6QADiDg1fKQCX5XntQC
         FLpbdD1rSQjRLXQqPBLo8ZUDGFDRpW5xBg2NyEy5gNxDzd2Xw2NUP/2EZlWJwsK2mZoD
         Qm5w==
X-Gm-Message-State: AOAM530Dw/Za08ikqd14OtoMFN8g2aVgjV7wT6KTT+Jj7Gx6p6Ny/kmy
        OvcxW9ac3gsbsrgXsnGAZ00=
X-Google-Smtp-Source: ABdhPJwoqP64bd/fEaztW8RmjsXG0QEk09xPazlfdkOqhpvQilPGB1LbLk4P+M1unfdpv/tH5iWhLg==
X-Received: by 2002:a05:6e02:190e:: with SMTP id w14mr320958ilu.61.1628690045975;
        Wed, 11 Aug 2021 06:54:05 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:c8e6:437c:9315:4f5b? ([2600:1700:e72:80a0:c8e6:437c:9315:4f5b])
        by smtp.gmail.com with ESMTPSA id n144sm4626801iod.32.2021.08.11.06.54.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 06:54:05 -0700 (PDT)
Subject: Re: [QUESTION]Is it possible that git would support two-factor
 authentication?
To:     "lilinchao@oschina.cn" <lilinchao@oschina.cn>,
        git <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, mjcheetham@github.com
References: <66e42438fa9311ebaeb60026b95c99cc@oschina.cn>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <7c5df686-79ad-1cd8-6f14-d97e1b88bbfb@gmail.com>
Date:   Wed, 11 Aug 2021 09:54:03 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <66e42438fa9311ebaeb60026b95c99cc@oschina.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/11/2021 7:00 AM, lilinchao@oschina.cn wrote:
> Many websites support two-factor authentication(2FA) to log in, like Github, I wander if we can support it in application layer.
> When client clone something, they need  input username and password, it is like a website login process. For security, we can
> enable  2FA during this process.

Typically, this is handled at the credential helper layer, which
is a tool outside of the Git codebase that can more closely work
with such 2FA/MFA requirements. For example, GCM Core [1] supports
2FA with GitHub, Azure DevOps, and BitBucket.

[1] https://github.com/microsoft/Git-Credential-Manager-Core

The mechanism is that Git attempts an operation and gets an error
code, so it asks for a credential from the helper. The helper
then communicates with the server to do whatever authentication
is required, including possibly performing multi-factor auth.
All of these details are hidden from Git, which is good.

I've CC'd Matthew Cheetham who is the maintainer of GCM Core to
correct me if I misstated anything here.

Thanks,
-Stolee
