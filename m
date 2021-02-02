Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9DFC433DB
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 02:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DDD864DDE
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 02:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbhBBCmY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 21:42:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbhBBCmV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 21:42:21 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF080C06174A
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 18:41:40 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id k142so6779900oib.7
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 18:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=UUz+ByMJcAJJc/lw54/Pqda36nZRmFWeIYYN21yWtWc=;
        b=oVbLwl45imZRbcq6h/JvyyI0zPPd374vIlQ9tTrYwgt2Bn2iAaMooaIMv4DtSwc938
         g3GJUTNVH7muh6lcmzGSlEW2Q6TRboIXzeIdrZzGHG7c8rdDSiatymWGTYyd0vdZxzNn
         IITSkya9a3QvlRpYce7Xy3blX+vgzSjnsyEiN1aMbLjqJdX3nYkjSLw48bGM8BVGhgxG
         R1RTJdSPe6kIkZ5rRcJBTQk76X8RPFzlyXPKTjNcU0n3EAjQJo5wUSlThE5xOZivh4MS
         pJRlZaOW7r1imXoJfhdJchsdLKtlXMAmm8QlgucKlN5JVW4T2ZW/Osz1n6lTf14DYms0
         Wy3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UUz+ByMJcAJJc/lw54/Pqda36nZRmFWeIYYN21yWtWc=;
        b=iJ9tft+Cfvyou402BY3s++2u/Glm5EbRXWUG8NH3Lww3NhGkSrMr3Q7HPKPmBMHcfd
         bR893i3xBj60/B3CFATxWrEVRQPgd31yVoeOc5k4NbuMWVnnusbXaw47MZ7M8Ca4DIUY
         arrU9Hka9fx1ipuGeBHWo/4i0FVJcl529MbNXQibBiTy69F8Gk2E02Uc2cKSCe4HfH/g
         cw/H+cmcgfKvUrRJX+5+89abarn6yHtlxmSyGJki5dtIq+AEUw6L8o4lsRvLkygIWYf/
         BKG5QBZEuUTUFMC/bUZlcu1fhpneBSadmVi2yjB4G1EngpY/LWJr8w1F9qEUD8DTaBCu
         o/rA==
X-Gm-Message-State: AOAM533fPWogPVt2VsL4z6t7GpcnNXMf/jIwsSOM/c9B5tKx4QKxaeYK
        FOydmbVJ/CL8hIqq/AFW/qM=
X-Google-Smtp-Source: ABdhPJyIFIsanydvMAtuAr1JeBmHfSpYoyNYZaKucPEtar/jZc9gQ8aRNZg5PpJzTKWsLl5O3hRZGQ==
X-Received: by 2002:aca:4f94:: with SMTP id d142mr1242692oib.165.1612233700226;
        Mon, 01 Feb 2021 18:41:40 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:cc4:631e:f39f:4032? ([2600:1700:e72:80a0:cc4:631e:f39f:4032])
        by smtp.gmail.com with UTF8SMTPSA id s10sm4582715ool.35.2021.02.01.18.41.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Feb 2021 18:41:39 -0800 (PST)
Message-ID: <37c90f69-2f0f-2ac1-09e8-6ce670dd18ba@gmail.com>
Date:   Mon, 1 Feb 2021 21:41:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: [PATCH 27/27] cache-tree: integrate with sparse directory entries
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.847.git.1611596533.gitgitgadget@gmail.com>
 <05e7548b780da6b2bf2342d91d8757568df0a6b8.1611596534.git.gitgitgadget@gmail.com>
 <CABPp-BGtF+p7D8x0xvSwMz7XveqVcBWhr20iHQ4=Vrxw6LEoKw@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CABPp-BGtF+p7D8x0xvSwMz7XveqVcBWhr20iHQ4=Vrxw6LEoKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/1/2021 6:54 PM, Elijah Newren wrote:
> On Mon, Jan 25, 2021 at 9:42 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> In this test, I also used "echo >>README.md" to append a line to the
>> README.md file, so the 'git add .' command is doing _something_ other
>> than a no-op. Without this edit (and FS Monitor enabled) the small
>> tree case again gains about 30ms on the sparse index case.
> 
> Meaning the small tree is 30 ms faster than reported here, or 30 ms
> slower, or that both sparse index and small tree are faster but the
> small tree decreases its time more than the sparse index one does?
> 
> Sorry, I don't mean to be dense, I'm just struggling with
> understanding words today it seems.  (Also, it seems like there's a
> joke in there about me being "dense" in a review of a "sparse"
> feature...but I'm not quite coming up with it.)

I don't blame you! This is a lot to digest, and I appreciate you
pushing through to the end of it.

Clearly, I was getting a bit inexact near the end. My excitement
to share this RFC clearly overshadowed my attention to grammatical
detail. I'll go through your feedback more carefully soon and
hopefully clarify these and many other questions.

Thanks,
-Stolee
