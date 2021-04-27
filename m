Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 023B5C433B4
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 05:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB33C613B4
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 05:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbhD0FqG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 01:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhD0FqG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 01:46:06 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8C4C061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 22:45:22 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id zl7so8125620ejb.6
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 22:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=fPrfruNeqYattzsrXJXwIFekqz2b7dWvm2iVfkwgNpw=;
        b=PDu1XFQZ1/fwQpNAdjVTVMp8HHLqqOKQmM08FO1x5wHNXKVeOixTLVOtRQF286OEuQ
         YlMeCsjwUwGeS5EfDQbJrv0wbdgReCNUFJ+FQran4UxHqJD+upBvfjYqHg8BqMMdYvBu
         MAd9KJcUCSn1vp8SnVOSTMxFJKcHBPvQ6ZjfoX6PFt8AwLpAFG1bg0s/1omgJTfIFLqf
         A7g3Em1AYu7p7KOlNKQloykSaksjSZEqsnr7/rCWGMooKgWLCGjinYNeoMjQWGDqk/Pw
         kWO+0URDU43Z64STfJUg0fAvc6oeFwa3xL3cLoaR4uBr+e1Sxb8UHeXLGP3Qu/fsPVch
         cMvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=fPrfruNeqYattzsrXJXwIFekqz2b7dWvm2iVfkwgNpw=;
        b=D0R1RexkAxqCvAwVTP9hneAl5FZ0TRiPX7qBIEE4h7os2ujyKlYwE5/3WvqWKCQ3MM
         K7kkPRd2yQOqf33TVaQ86st3buXIxTJrn0RRcOLEjJeL9dOyvaUOzEqF6s75ZB0LyYMY
         bMQOChC2xaQEwol+8Qf0bwhPnVDADB5tvfyJPbjdQ8vEgNBsTUq1UMELDIJfRo8y9n3l
         LwqRo9r2gwgSbRdKGEQH5GXDm8FnCW3BHQfHv+54grDtcxgJpF56WwRbfnMCM93r4KEC
         wmR7KZeisbvsFrAZDzvD77p7bo4lD64V5UboSYNpvc0XMM4h1Imt8Pd/IkMjv036lhpL
         QVSA==
X-Gm-Message-State: AOAM530QuO4z8QtlvqiEU8zOJkgA+EaWupyCafHnWnUSRKvBzLOpF9DP
        vNH4ygvYvpF8jbkyDicPdTXaM1qQ/47S6aVX9s8=
X-Google-Smtp-Source: ABdhPJxA5xfjS1aJz+XvUyY5gQxRyQAUHagASu8IuO2tx19ewnXYTJ88234Wc5PvYj8+jS7auZMrVv7IzkTMD1CzzAc=
X-Received: by 2002:a17:906:3a45:: with SMTP id a5mr22427515ejf.288.1619502321142;
 Mon, 26 Apr 2021 22:45:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210424081447.uxabqbxc54k6yxrg@tb-raspi4> <20210427053916.1977-1-tzadik.vanderhoof@gmail.com>
In-Reply-To: <20210427053916.1977-1-tzadik.vanderhoof@gmail.com>
From:   Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>
Date:   Mon, 26 Apr 2021 22:45:10 -0700
Message-ID: <CAKu1iLUYZRFV4QX2N3o9G89n0efE+2mBC7piV6Ks2+v+xeYvmw@mail.gmail.com>
Subject: Re: [PATCH v5] add git-p4.fallbackEncoding config variable, to
 prevent git-p4 from crashing on non UTF-8 changeset descriptions
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Luke Diamand <luke@diamand.org>, Pete Wyckoff <pw@padd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I modified the test to work on both Linux and Windows.  See the
comments in the test.
