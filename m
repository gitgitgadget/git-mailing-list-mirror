Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82656C433B4
	for <git@archiver.kernel.org>; Tue,  4 May 2021 18:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 534C961076
	for <git@archiver.kernel.org>; Tue,  4 May 2021 18:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbhEDSB6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 May 2021 14:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbhEDSB5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 May 2021 14:01:57 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1867DC06174A
        for <git@vger.kernel.org>; Tue,  4 May 2021 11:01:01 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id j3-20020ac874c30000b02901bab5879d6aso4116279qtr.0
        for <git@vger.kernel.org>; Tue, 04 May 2021 11:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SK7BbjvxEYaMM91PsSni4excjp9o9d6sYCBieKWoghc=;
        b=ViDyRGpBtaaqY+7pchZ/N2EZLDvl0MyPURDou8dmZVTZzXuxiA9r1v0qoXntkCkYdu
         uD4+Z8DigR3HFPHaiKwRIcRiJrBTvhq6Mr2799x1vsaAWwvTNEnsBovRblEGYbxv/fwB
         XGV58APfDzRo5yiPysI+po7VzQKgppb+slEeYAJjCA7efsSraAh0uv2TDghffG9EfV1P
         Dcj1ms3fvbelg2VrvnN4uGPBIrwMIW2FCMVOu7c0ZQbdm+bD6IuLkVBx6t16lD4loA/J
         GMfFYRwxC1HRdXLNzVmMg3w+vgEUnAtJCSFQUleKlkd5Rbt59awVFuSG6nNFMSb3iZT5
         DnOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SK7BbjvxEYaMM91PsSni4excjp9o9d6sYCBieKWoghc=;
        b=FsIzbc+rdlD2f1Bx8IQPqH+RGNrCn1+oG3bJb4UsZPy3r8MtpzNPs742fAg2csKhva
         liapsLkceZ7OWhd1mDfHhdxrIMSjecTB4953yEURjVdcgHtIS41l4rZbBH3/ghGjTgPv
         kzgVaKDZGtREdZAuz8YYJnC9UBWgMmPmDB9T7m2WNiqHgum6P3O9Gt1PJzVYS+2KIsCW
         aIAUkWsc3PPd+ehcuohAquBE10r3GQTqB+kmme041VzxxUmoMX9pHOYXHt0aV0/xtVQV
         NtV2HdSAZQCN3pfX1zrFhEH4Q8T/x0rSt/8PG2Qifbh/Ag+oNvhbEeWZBJ0wTeQVE34P
         3GgQ==
X-Gm-Message-State: AOAM531xrezUUD/BkrxCcSi0kyQzlapFapF7cPgZ7MhvsKQUhCdIpy+v
        WaeNlQ24+sLi0ubWF7z2v5qPW3lRM99t2YX9gDuc
X-Google-Smtp-Source: ABdhPJz9Wb/ZnAGgswNIcmZdoHfn0SnqGBbiBHQW5AvcSYCyF0gLaa8fVc9WstiEJ3hdCF8VM98Gs33mawY21B1KyzTl
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:ad4:4634:: with SMTP id
 x20mr26957023qvv.49.1620151260204; Tue, 04 May 2021 11:01:00 -0700 (PDT)
Date:   Tue,  4 May 2021 11:00:58 -0700
In-Reply-To: <b75b534446088b20e77cbaa7f09705510ddec908.1617991824.git.me@ttaylorr.com>
Message-Id: <20210504180058.2988580-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <b75b534446088b20e77cbaa7f09705510ddec908.1617991824.git.me@ttaylorr.com>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
Subject: Re: [PATCH 22/22] p5326: perf tests for MIDX bitmaps
From:   Jonathan Tan <jonathantanmy@google.com>
To:     me@ttaylorr.com
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        gitster@pobox.com, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> There is slight overhead in "simulated clone", "simulated partial
> clone", and "clone (partial bitmap)". Unsurprisingly, that overhead is
> due to using the MIDX's reverse index to map between bit positions and
> MIDX positions.

Thanks - it's great to see that accessing a MIDX bitmap doesn't add much
overhead (as compared to accessing a single-pack bitmap of the same
size).

All the remaining patches up to and including this one look good.
Overall, I did have some comments here and there, but I am happy with
the overall design.
