Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C2FECAAA1
	for <git@archiver.kernel.org>; Fri,  2 Sep 2022 04:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbiIBE3G (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Sep 2022 00:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiIBE3F (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2022 00:29:05 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF005A1D29
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 21:29:02 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id r27so655400ljn.0
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 21:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ntTZ3OnNHuyJkyhluNlifNcIBJa3+TPjHWqHsWVFF9I=;
        b=iyrxHrYwQJ11MYgpUe1YJuN3K/iW5+ZLLjglO6DUTQeyQIU6R42D9v0hb0j1hoCDrE
         H+o6dYDtCXmkXZ2qvlByI1ww3qkouoR0AWs0cXqQAs+ELXWNfS3b/VkyM3I6ruK4oDoX
         YByoscdzUW/VQt3xj6saa1qTY3RpHz9BCTsDAM+KIBAl70R7Cg0sqZPJFOu4se2p5Mwe
         7AOZc9JmCoBx8JTlvgkghIOLE6OBqK13DkdGBJ51ieX7j0KbwMVA8/ZrBzXW/m+uQZYh
         oBP/I/SL0m0TpCCsGsjsJ93JZ+lk5v6DOldVKn1ne76tfeSTCWieO858QqAAduebwxtx
         HisQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ntTZ3OnNHuyJkyhluNlifNcIBJa3+TPjHWqHsWVFF9I=;
        b=sb/iDbBhUnmGy+Gr+qKe7Clr144fXS2Nn5fet1tM0Mi4i841xKoPYQd4M0r14kDpGS
         u9ffnAtUIi6Gara9h2dRWfqXxFL6vyFlsD/v78f8DhnTLlMOli9ufIVVC4wMF8XYWO3A
         FCnGxzBC37KBtPKOKnWMDrvivaz09JkjuvwJVbZohWzLXAXrDji/fFRguAk3IVXpGlkm
         1zo2PCBxRHX4In4WZoZAXZDy6T0aZQfoa7nfee8gHiaPqzCS6wtyxh/cc5CGNT1byvOm
         se4ArNoEOQ6Z9yRG9p70LK81yWz7wucRYMdmFvvKcJYThVrnqZeY5Ps4urwhexJ0bRbv
         vEGQ==
X-Gm-Message-State: ACgBeo3eOqveAm2mSQZj2ae/LlBAMOf9gGMRQgCTYcsUFSmuUuVXNzp1
        SW0b1l5pvOOVIkHfMQS8nCHydeqjP+M=
X-Google-Smtp-Source: AA6agR4xi3bFZYr1M9qFlUBWNNIkRKT6+hieNHAaPLflIYFAhlCbjITy33Fzo2TMpDwTkiqWnkYD0Q==
X-Received: by 2002:a2e:9e56:0:b0:261:7544:d79d with SMTP id g22-20020a2e9e56000000b002617544d79dmr11297588ljk.296.1662092940984;
        Thu, 01 Sep 2022 21:29:00 -0700 (PDT)
Received: from paasan.lan (150.37-191-137.fiber.lynet.no. [37.191.137.150])
        by smtp.gmail.com with ESMTPSA id o22-20020ac24e96000000b00494a2a0f6cfsm112004lfr.183.2022.09.01.21.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 21:29:00 -0700 (PDT)
From:   =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
To:     ingy@ingy.net
Cc:     git@vger.kernel.org
Subject: Re: [BUG] git crashes on simple rev-parse incantation
Date:   Fri,  2 Sep 2022 06:28:57 +0200
Message-Id: <20220902042857.15767-1-oystwa@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAHJtQJ4uJc2_upHvc-SWVpA3OX2Lpu-XspswGTTDLgXWjG-Gew@mail.gmail.com>
References: <CAHJtQJ4uJc2_upHvc-SWVpA3OX2Lpu-XspswGTTDLgXWjG-Gew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

FWIW, I can reproduce on master and next.

Øsse
