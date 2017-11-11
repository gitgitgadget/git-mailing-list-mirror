Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 188961F43C
	for <e@80x24.org>; Sat, 11 Nov 2017 16:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751497AbdKKQtR (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Nov 2017 11:49:17 -0500
Received: from mail-vk0-f54.google.com ([209.85.213.54]:50102 "EHLO
        mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751286AbdKKQtR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Nov 2017 11:49:17 -0500
Received: by mail-vk0-f54.google.com with SMTP id t184so7848063vka.6
        for <git@vger.kernel.org>; Sat, 11 Nov 2017 08:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=OaPigVLGVto5s4REaZIA8zfeBtaLZFL03kHtw/T0fko=;
        b=g9QMDyNivFym1HKnnfGmuaRkbmI8sPaS2vjEmPFF2j8JvUWiVD5fPtvkrLecZ6l+Qr
         7VZOtcTIVUz22Ql8hL84KC+UcHnzsTsbxa/m67rU7LHGmKi9N3GU0lSSrYh/yrGGkq3B
         JvAWnIbnOXVjQqAq88vAB7cniFWok2BYZ2zXZCwk416TebeLNPNf5izFX3jZOwWVBHOg
         JbQer5oolWMJ/l+VOeTPbb/zktNW1EbAf4WVRqcuM5+bqr9I1bthxNLlWVzrzFOveZc0
         RlPiXvNOgdp1R2OXY/dzoXFL+xET0oJ5eXa4/KIhJXREtX4p3m0eBm3dyyYwArEMmJHU
         V1OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=OaPigVLGVto5s4REaZIA8zfeBtaLZFL03kHtw/T0fko=;
        b=qKOIMpzybdj/8Lsvaa8Amlir4NK+VTILUswB28cUXPCKvui4TLttlHQnQSQcTITGjo
         H1Wg1PqVt6fWsEYGw5eOBdhCym2hACAgk9MXDf2WvGAXVA2A1pVQakG794CmODPnwcNX
         mC6sdKE89cymmPLbcXxymeqq9WuUkmhy4o4NQrCpCDkcAEk72b2gKdlmtT3S/Ll0Vevg
         L2zXXepuQsDlcEBGiFBvcdr+/3OJFXHKcDrU6t+YHJkwzrdYwAAMqi0a/5WmuW5pSvmM
         nKN2JOZpp+RYBHd568NRPvvXrU0zZteqSgmov0epEl2cx+3zbgpq6r7sqxhyKPhilddR
         DNMg==
X-Gm-Message-State: AJaThX5clXQYahbdkP/ihAkf4izfEj5jhvJgXiF6BWoyW3KNEfNIIT94
        hFeIo6ieB7AeXHGHhhbGaAaHdAY4F5r6X9ZpRU8=
X-Google-Smtp-Source: AGs4zMZeoUD4etFx6J84yTH/+czQJgf26FbN+vJ1AD+bT+oKzFK96L/rQbNeW6lLrTnyHRwfqbI9tiCNFrRMKp7WlY0=
X-Received: by 10.31.96.65 with SMTP id u62mr742670vkb.68.1510418955834; Sat,
 11 Nov 2017 08:49:15 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.67.33 with HTTP; Sat, 11 Nov 2017 08:49:15 -0800 (PST)
In-Reply-To: <20171110222156.23221-4-newren@gmail.com>
References: <20171110222156.23221-1-newren@gmail.com> <20171110222156.23221-4-newren@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 11 Nov 2017 08:49:15 -0800
Message-ID: <CABPp-BHhjUp3_UcO2u4sVzj0mbk_aVKWK=-KbBECLvwDhE3tvg@mail.gmail.com>
Subject: Re: [RFC PATCH 3/9] merge-recursive: New function for better
 colliding conflict resolutions
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 10, 2017 at 2:21 PM, Elijah Newren <newren@gmail.com> wrote:
> There are three conflict types that represent two (possibly entirely
> unrelated) files colliding at the same location:
<snip>
> If the files are similar enough, the two-way merge is probably
> preferable, but if they're not similar, recording as separate files is
> probably similar.  (The same logic that applies for the working

That should read, "...recording as separate files is probably preferable".
