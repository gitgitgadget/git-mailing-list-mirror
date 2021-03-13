Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A79AC433E0
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 08:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE2F064E58
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 08:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbhCMI6X (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Mar 2021 03:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbhCMI6N (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Mar 2021 03:58:13 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A51C061574
        for <git@vger.kernel.org>; Sat, 13 Mar 2021 00:58:13 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id bt4so6309271pjb.5
        for <git@vger.kernel.org>; Sat, 13 Mar 2021 00:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=dR3sTx0gOMCRTWScNziF+4f8Z83Es5TwPbcR160zSaY=;
        b=amofO/nUyEfXFrSREbGQG/OZzWyzoeCMmXAp4qa/HZxWWdvqyMVrLfXLVUdug4Clxq
         ZS4Vg/30j1czWJ0cgdZXBr56TN/gI7qDAabAltL/zJXMb5fqMuEK9b6vD5Dh20r1mGLf
         CjYNeEUvTYpG727mS1JbD9IRd4gr8Jau7uUybmLVWxbGwBg0iR2d1v/2cibRNMA1TyMa
         E4Gm6BedvO4Pml5RrB/TIPibLmbqOEm2t0+cpGUG48ktVBAhV0QVYUfOb398sXL3IvRo
         k1SOijbdhM3jxYFYR3DgA0gOFyxUQztAHIMvJNvmuWIcsUuceSqjFz87zrjGKFpTzPkb
         wqHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=dR3sTx0gOMCRTWScNziF+4f8Z83Es5TwPbcR160zSaY=;
        b=m12mEunN4DucdOFwHV4tzb5WQ+8b1yk2C/DzS5FftbM/eZdxGUz0Kl6NLn0dF8vyB8
         df4zuNK7VLbR5HNsam0W0IMRs9d27cAEnAUPe7ycseaDXXwzrY6O4SBmOi3fOxv55GTZ
         t6CIbHuuMzC+SGRhuMcVqmdPzVP307L/DHVMNTQHLwFePzarHm2UZcJ3TvrsvY2T7ZPM
         bRVnisczOWpA3LdTAzsVF7umrcNF74EaBNm0/5eGg1/JBWbR2xeznbacMdS6OPTdK9O9
         mO3xRb3l6lJH5T7VfhJMlC1Dotuy9l5gIGmZy3RVRInxPbxp0RqLVDnyig8rDth6jwrp
         Dd3w==
X-Gm-Message-State: AOAM532SlDmghPyUqYMKcXlbDq8m/IFgQyS9/cybgQ9fognsWmNTlUbl
        k3aP/7U+P6u84SThXrQJIe6uVhgxb4edHUrAJ4QIeKJiMJ4=
X-Google-Smtp-Source: ABdhPJyIALj839nMU/MyAOgAsoElDJpD0vQRL2gmHFzZWzBg6tq27LlqsFOzhZaas4uXi9Xi8LGWPzjqJaEa2PhrXbQ=
X-Received: by 2002:a17:902:be0c:b029:e6:f0b:91ab with SMTP id
 r12-20020a170902be0cb02900e60f0b91abmr2537171pls.2.1615625892373; Sat, 13 Mar
 2021 00:58:12 -0800 (PST)
MIME-Version: 1.0
From:   Divyansh Garg <divyansh.gargsg@gmail.com>
Date:   Sat, 13 Mar 2021 14:28:00 +0530
Message-ID: <CAB=huCZRLGJDqa2qN7CCQbZaKt9xH-d=_kb4hrWmB79jocR0Zg@mail.gmail.com>
Subject: [GSOC] Microproject: Add support for kotlin language in userdiff.c
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was thinking of adding kotlin builtin patterns for userdiff. Can
someone guide me through it, like how to proceed and what is expected.
Divyansh Garg
