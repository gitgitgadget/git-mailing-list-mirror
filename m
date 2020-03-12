Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D4AC10DCE
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 16:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F3C6206F1
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 16:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ct5QNDK1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbgCLQrI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 12:47:08 -0400
Received: from mail-oi1-f202.google.com ([209.85.167.202]:44350 "EHLO
        mail-oi1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgCLQrI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Mar 2020 12:47:08 -0400
Received: by mail-oi1-f202.google.com with SMTP id y82so3453675oig.11
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 09:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GpqYwRFFA4QhP55FNPH4NhqKBr3KKrM7vrEMO6pXyos=;
        b=ct5QNDK1YIDayK5XUakSGLSYsgSKzJaZA26zDJxX9nF8Kcqwtzi4nDluKGcCJiAiH5
         Oc0VOvyIPlFw/d5qkyjcEIKl4il6Q/9EiSj2j+nlhjOqf30lbhPbEMns3lG6uCr+14qY
         iRXkahUUB0FAIc2UgEjuqaf0cFX1OVEvODbvEXTpiZAX8vtnorpgv+GFCMKTKXcqw2Nz
         qm9xyeeCPxXm5z2kBAS17wGT1utZNvEf3Lgbg2e4dt7/REJJ2PSv4eCk42IYhdXVf0Dk
         9iahWc+gbrb0DknhsD/pvSCnri+M4Bf/wrGLMqIl7cJAEx2h+nOF2FWxJxqGPfcI3A65
         1dKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GpqYwRFFA4QhP55FNPH4NhqKBr3KKrM7vrEMO6pXyos=;
        b=TPyz5kltoCFOfbsgKeBAXH5z4gldS/txnnjDgt/cx7ls4GV9N0AA0z8FU2++lnIrND
         SYw4LKeMvROkukNsWkFkamVp6mJLfn/nkEPEgxT6elixp+VtcUS8O/FMNF7u97SybjOf
         f6w/VOHdXWoI32t6gav7XpUd2OgQsPNrd06yYQs/1G4/821k7czGuV3QOdOI+JSl/5My
         eFAmjy8utekiT/3K7sOGsvSC53gV0oC3U0cuC3rwzuGZj+rYbT13NS8i9kjeIw6ezIzT
         Fm3wPJ5dOoROlM+0cLqhYaLhpvmj4qN09HS5BeiIZzA64YoXfWutSs0Fs27eIfhK8cQS
         /lYw==
X-Gm-Message-State: ANhLgQ2MePyI3KMLGbPUuZ9Jmx2h7jvtFDJZPSv/f2HeaKRLuutX2jB5
        qVJgNG37gzqkHO+D0G5ObwUsiUBAeUBhPEEBRtGD
X-Google-Smtp-Source: ADFU+vvBHTPzoHPVZa0CijxcVE0dxvTrb8zMYl4eXqr0c8fTqiavp/JAT1pakUiNMktlrJb8leWvgD4fsRaU6d4ET0cV
X-Received: by 2002:a17:90b:316:: with SMTP id ay22mr5096362pjb.18.1584031182471;
 Thu, 12 Mar 2020 09:39:42 -0700 (PDT)
Date:   Thu, 12 Mar 2020 09:39:39 -0700
In-Reply-To: <pull.579.git.1584027403779.gitgitgadget@gmail.com>
Message-Id: <20200312163939.176298-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <pull.579.git.1584027403779.gitgitgadget@gmail.com>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: Re: [PATCH] connected.c: reprepare packs for corner cases
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com, me@ttaylorr.com,
        dstolee@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Placing a reprepare_packed_git() call inside chck_connected() before
> looping through the packed_git list seems like the safest way to
> avoid this issue in the future. While reprepare_packed_git() does
> another scan of the pack directory, it is not terribly expensive as
> long as we do not run it in a loop. We check connectivity only a
> few times per command, so this will not have a meaningful performance
> impact. In exchange, we get extra safety around this check.

This also means that check_connected() now does the equivalent of
reprepare_packed_git() in both its branches (the rev-list one, which
spawns a new process and thus rereads the pack directory, and the fast
one). This will at least help callers to reason about its behavior more
simply, so it sounds like a good change to me.

>     I included how I found this (integrating v2.26.0-rc0 into Scalar), but I
>     am able to reproduce it on my Linux machine using real fetches from
>     github.com. I'm not sure why I was unable to reproduce the issue in test
>     cases using the file:// URLs or the HTTP tests.

If you remember how to reproduce it using real fetches from github.com,
could you give us reproduction steps?

Thanks for attempting to reproduce it in a test script.

> diff --git a/connected.c b/connected.c
> index 7e9bd1bc622..ac52b07b474 100644
> --- a/connected.c
> +++ b/connected.c
> @@ -61,7 +61,11 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
>  		 * object is a promisor object. Instead, just make sure we
>  		 * received, in a promisor packfile, the objects pointed to by
>  		 * each wanted ref.
> +		 *
> +		 * Before checking for promisor packs, be sure we have the
> +		 * latest pack-files loaded into memory.
>  		 */
> +		reprepare_packed_git(the_repository);
>  		do {
>  			struct packed_git *p;

The code itself looks good to me.
