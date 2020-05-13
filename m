Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15028C433E1
	for <git@archiver.kernel.org>; Wed, 13 May 2020 16:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 501832064E
	for <git@archiver.kernel.org>; Wed, 13 May 2020 16:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UM56o8oO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389646AbgEMQ12 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 12:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730831AbgEMQ11 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 May 2020 12:27:27 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B11C061A0C
        for <git@vger.kernel.org>; Wed, 13 May 2020 09:27:27 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id q11so1851075oti.6
        for <git@vger.kernel.org>; Wed, 13 May 2020 09:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V3CWMTe2/c8mYDNo8UznnGpToaS4UQT6zlQI5/3X1Lc=;
        b=UM56o8oOlhnXQ0YhjXKffPow5tIXqnxt8cW/12UbJoe5VJIXzIojzqAfC2y6rLUMZv
         EuqskdVJoeedkRWNqDcnSArH44cwyykBllAmxYJ0/NSROdwv1m3TNoe8/1Q7t0C1Buk9
         s+x/KRNHQUumh0y0uoHDk47euA7vxUpwhdSszDD2X7e2tHtJMHn4f0UUjgeTKCDmsP5n
         Sj8f+T9lHJszNJt3BLNINpbFyoOWvd3OJcgejrzZ9o8i7TfBtziRl2O+REbAu/Ro0/a1
         Gm7p073r5R56LFFwy2iZg8YLp57FLxv+fkq8UI5Kiwrm7M5BY+A1I/JSh4XEWEM5+orG
         TUrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V3CWMTe2/c8mYDNo8UznnGpToaS4UQT6zlQI5/3X1Lc=;
        b=GuFkOjK7HviHRQbtpgKftEUXOvZj1gQGPb6nwoXM6WzOzudHjZQqrik+gyp1kJ3kTc
         DyjY7AqBDM0bZ/CE70HWWloRD3sK/kFY2wo/XhpKDVgJ1vAxg307F5oKdEZcfou62tKi
         kwKxahofmNV5RcFmTLMfCJzrNMpreGyTKo6ClxCW9dEvSFTBlqBFc4OXF4IbOynQJ0ez
         jvLUc0FR6Txb54kz6RCOdC59+jZ6Q4kgxugvwk4kB/0sgMBYJWhkASRLJJa8KI9530zZ
         MPdfuVtMZrnThjoPDkQWXwvSUQeH9vSWTr3S5E5HbMclYZRdYcj2ok00uGsBmm7fvmzN
         gDJA==
X-Gm-Message-State: AOAM533Qmbf+uWgup7QXRaHkCJmzF1K2N6az8EGfjdhr10rB3HLjq41Z
        6y+6s4h43Nnv+hBYO/0ixbhjc5wyabU7Y2OUaYg=
X-Google-Smtp-Source: ABdhPJz/jwhdjAWL2mF6AiEcCQv8pv6g5+v03nkHMqY/ID42rcYJX6/JChibnvf/GNdjbeF9CJaIuYxEVWBSMhBqk9A=
X-Received: by 2002:a05:6830:12:: with SMTP id c18mr174107otp.363.1589387247151;
 Wed, 13 May 2020 09:27:27 -0700 (PDT)
MIME-Version: 1.0
References: <CALN-EhTpiLERuB16-WPZaLub6GdaRHJW8xDeaOEqSFtKe0kCYw@mail.gmail.com>
 <d963242a-72f3-7f42-7c95-ea5148f74804@web.de> <xmqqpnbduiec.fsf@gitster.c.googlers.com>
 <938f0818-7e57-b883-009f-01db88ef8f65@web.de> <xmqqh7wovoop.fsf@gitster.c.googlers.com>
 <aab9512b-a70a-0f5b-5cdc-5d40acd343d0@web.de> <2937d635-52a9-5e69-b3d2-fbde415b7315@web.de>
 <xmqq4ksmsaks.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq4ksmsaks.fsf@gitster.c.googlers.com>
From:   Brandon Williams <bwilliamseng@gmail.com>
Date:   Wed, 13 May 2020 09:27:16 -0700
Message-ID: <CALN-EhQ91HDQ_VZ_+y2bPgFPhZ-_YWPAMZry4AhHTx+4w-DSJA@mail.gmail.com>
Subject: Re: invalid tree and commit object
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for coming up with a solution so quickly! Glad it wasn't too
difficult to solve.
