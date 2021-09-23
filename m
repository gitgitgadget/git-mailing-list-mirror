Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E44C433EF
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 00:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDAB8611CA
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 00:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238621AbhIWAHe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 20:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237101AbhIWAHa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 20:07:30 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618A4C061574
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 17:06:00 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id az15so4777770vsb.8
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 17:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IN1q+N+jdOF/yv+9CSpCR8sNJFx2LaTtPFE7ffNRQvo=;
        b=IKd1TOAUJsGPdfMOf6mRHozrz6LGwPtNKe7hZrQI66Q47VzBFzbWQSJoyPYTjv98TA
         1vy1YAtHBW1d7+iVD8Ovai8OJiRg8PY1rb0cegKaSk8SXoBFKso9j+VEEEI22kVUEnpz
         XSlz+2jB4Xa4XVBcNlARlLtgB5gJd4XqiYz7a+i4EAo/Yo5SuDdQA/pY+/wSqo+4oryc
         S65hACZLRED+KekbiwWesd0rSO+ORmUNh4/CSMMbawDqUZi40zWrF5gPAunF2MZhJaKs
         p6DacbKu7RliHasl2wJKcfE0qO40KkQy5XDId+mBsf9OhrxOxe0QfzztJvhNeqcKyRHB
         y09g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IN1q+N+jdOF/yv+9CSpCR8sNJFx2LaTtPFE7ffNRQvo=;
        b=QQ9TF1Ec8R/U4TyIHIZoT9w0cZCJjTF6HimnoexooJtOz1b+li/cO8a+a3Ac6wH4Z9
         jGCuKQl8bACebe0X3qkAl0IVgtGK0ff8R73HDLILm2P7XfRSdsnyNRhl8mYRLkNbqyEF
         7vq/agnw+a0axCVaYt8HB9WWT5I06nMdElneeYK2vz0ue8KdN6N/RR71m2IjNIa99E5b
         hvu8+ZtwptEwOFWrzTjzY3JDsEv1L6Q6tmHE53G+O4GVlLkOaKBmeHReP63IdXpB4X8L
         9MSbMqvOITQvdl3xazT2wlEAIP/rtaeDb6ot5G/asj8efMB3CmDwWAKOfDvLHybYc361
         f6gg==
X-Gm-Message-State: AOAM530mAveqytxRMHclNrWfz/4dCMZRuNMEPouUOyW82onZtrQhjouR
        mfxaeEMxl8enG3emuWUstxj3a4WvETkfbCdwGzlNOdaYVG0=
X-Google-Smtp-Source: ABdhPJwjjWYrQkwQOG1ary1Zbjotw6Eh5Gc5cHi5l/DS6+VOBjGvZ49JVGygTren1f1OqZSGQed3Bf27kPvqYmCiWKQ=
X-Received: by 2002:a67:d51d:: with SMTP id l29mr2077097vsj.46.1632355559544;
 Wed, 22 Sep 2021 17:05:59 -0700 (PDT)
MIME-Version: 1.0
References: <patch-1.1-6b2e9af5e67-20210922T103749Z-avarab@gmail.com>
 <cover-v2-0.2-00000000000-20210922T220532Z-avarab@gmail.com> <patch-v2-2.2-6b18bd08894-20210922T220532Z-avarab@gmail.com>
In-Reply-To: <patch-v2-2.2-6b18bd08894-20210922T220532Z-avarab@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Wed, 22 Sep 2021 17:05:48 -0700
Message-ID: <CAPUEspikbd_YDM1PaEjLZsHoJtdaqv+AqCdg0KdB_xdJ9sUtFg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Makefile: pass -Wno-pendantic under GENERATE_COMPILATION_DATABASE=yes
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

FWIW a simpler fix was posted[1] earlier, and you were CC; sorry for the mess

Carlo

[1] https://lore.kernel.org/git/20210922185702.4328-1-carenas@gmail.com/
