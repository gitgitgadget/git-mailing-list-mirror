Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BBDC433EF
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 17:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347450AbiA1Rm6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 12:42:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347668AbiA1Rml (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 12:42:41 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605DAC061714
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 09:42:41 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id e16-20020a17090a119000b001b28f7b2a3bso4018650pja.8
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 09:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BFYo/M92IyDHOR31p7Ma3VOUIBJNwgwYFRPFuyPjK38=;
        b=pR+OnmWlW7k8gbMtbmfOVG4UzSE36Vv4ueMz7z1vjJKr74ye8ugSiYs0dPOAU+G3Ua
         ac8O8sgxkeQpqmHR3CO5Xd+RFplNn9+fIUdgNrFnFf7En0a5N+N95R1rjNwQfs0T1z1C
         vy6i6skb05mEY0wnWgC0bmBAMBLnufTuoBzzjoHGUgyN1JDHBp5boK56UiZJEnPttA0i
         fWFs9n+VDIFue22o3sHXyqjWveVTqQrNe6cjn6g3UA/pPAseqdbDJc6QZXkoGIFYH6eG
         6urHDvWsEb4JA7SHZ4IT4gu3eFNo8HW0ixVLnsxVFEzor72IQviZZPzSU83owxJGUBme
         dq9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BFYo/M92IyDHOR31p7Ma3VOUIBJNwgwYFRPFuyPjK38=;
        b=YE116dXgQfBPm2wyaMs90k5Tlus0VIMDukh9BAnESV7EvJ1mNPeKTJuyCEnZeKwULd
         vkaT8jdYhuaIgTSjaqOE+yCapqq8+1HyqqlPzxU2F9bYqdS0izKxYtZMEgepwE1t/nkS
         U+tzv/U1LrKEx6KhNkaMLxWOhl4Oia/uuuscxKYfzWy34yexXeRdDZ0fG61AePAw5tEm
         ehHbCKNJmdscKCDpTpWxcbih1jRK3I3h9UpQML8N7ajQpE8Uoae9rEQfhGv/bFm92k+q
         R4F5NGifRrGfl5FWokXfDoxEHzDOg9JN3IuOBeQXdV2O8ZqM2iAu/C+DO4y4J7uLSqcc
         sKIw==
X-Gm-Message-State: AOAM530g5pqlcr8kssmMPHS+SzpSTAxcVbQY9WmbiK8W7xd6jGf9qXmb
        iN5ZHKxxJNpNv4X1esEwyxZ4TQX3L9dOTKYIK+az
X-Google-Smtp-Source: ABdhPJysBoex7D47iSLKxaDnnD0jupvyk/cyvvByy2z8/2a0RnMKEEQ7Z45pNZpzgMarRUp7aX1Hqbuzzx2UZgNII5Es
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6a00:1992:: with SMTP id
 d18mr8918517pfl.85.1643391760843; Fri, 28 Jan 2022 09:42:40 -0800 (PST)
Date:   Fri, 28 Jan 2022 09:42:36 -0800
In-Reply-To: <20220128143602.31842-1-robert@coup.net.nz>
Message-Id: <20220128174236.3264310-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20220128143602.31842-1-robert@coup.net.nz>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
Subject: Re: [PATCH] fetch: fix negotiate-only error message
From:   Jonathan Tan <jonathantanmy@google.com>
To:     robert@coup.net.nz
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robert Coup <robert@coup.net.nz> writes:
> The error message when invoking a negotiate-only fetch without providing
> any tips incorrectly refers to a --negotiate-tip=* argument. Fix this to
> use the actual argument, --negotiation-tip=*.

Ah, the argument is indeed --negotiation-tip. Thanks for the fix.
Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
