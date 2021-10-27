Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259B7C433EF
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 19:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0599B6103C
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 19:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240359AbhJ0Thy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 15:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238347AbhJ0Thw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 15:37:52 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832D9C061570
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 12:35:26 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id m199-20020a628cd0000000b0047c3444d941so1081921pfd.11
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 12:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=NYs51rQerQhEaMaz97YK4pZxMutTNJKoDBbuhbfg2m4=;
        b=YyELq0MZI4ru6QRGZ/QRI11dLmNV0835puwEiP+0Ychiv47jqlpSBNOkuXqq0rSm1B
         cPuELR3pqoXA5nliGBTMwRxg1HHxVmyeZf56E6Fvs2VIUMkEzNTMHoNQRoMd4UxQKLXT
         CV1/zDbkIu2uZ8VmDIjkTnV8B1/GRLWcPvteyFCEIn1XjTBmmkmrHF81w3GEoR8UKN9A
         MneFjhTDn/zXkaSdlATw/wmmMrH3sB639kr3B6ERvUUIZG0/P/BN6WGGz/i8LDKCSQzP
         FVlMGOhVBk2kl+kSXazCqXzMW4jTOVfyTT4zOzJl2w6YuAKxj+ztPJbA7Y+WJ86xjPK4
         Pfeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=NYs51rQerQhEaMaz97YK4pZxMutTNJKoDBbuhbfg2m4=;
        b=Ds/pRmR30HhMC4ZCo5n9AdtS8NywrgXH3m9n9kOnoyMLb5oc8G07Saim2rcaZp5N04
         VB5nO1UcquS7kaxjczunE7QxGb36Jqv8SMnxIQ1zp+UvL28DVC8jZVFRann19SHGjtn2
         RQc3jbcDZ4wFlH6blbfLq6iWOEY6v2CTnSEBpM5JlacREVOcVMO4peTq+geByf1m6ED8
         eFw7wHbxKT9es9ETUc65275swnASrwWqwi6pK126YM1BaYL1HorH5lgMaqdbtSHm5epM
         PNFiUcV34aKlhSs3MxRmkSMIGmFTZl+43hNmzaI8FEeslNZSn9Tb2byzjd8RCAUr6deR
         Idfw==
X-Gm-Message-State: AOAM532CCKtVnKuXkE0m0z4u/Haq6tfLMssOW4kXNrBsAbAvRUAaRHY4
        V3arCqokbnIERAPi3p3+NsHLGJxvZRx60vMMxFaUQHwZHpNQ7bnQJnsT2RrHMjxY2PgaAcLerwk
        E/kMexL36Dgj838oEs0Mv0/C41kWAtjCQJmoAyFtyzIGc56AfvfiLXxt7llYy8fUCNg==
X-Google-Smtp-Source: ABdhPJykf4ubZqOz9dFQYG6NSF8RLzQ9YGLgJ4XkIRIGMyKEMDTTtTy8no58IcrCNEbHWp7MA62MEXKe1GCfz2Q=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:902:904b:b0:13f:b0c9:3c5d with SMTP
 id w11-20020a170902904b00b0013fb0c93c5dmr31065751plz.26.1635363325504; Wed,
 27 Oct 2021 12:35:25 -0700 (PDT)
Date:   Wed, 27 Oct 2021 19:35:00 +0000
Message-Id: <20211027193501.556540-1-calvinwan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.664.g0785eb7698
Subject: [RFC PATCH 0/1] protocol-v2.txt: align delim-pkt spec with usage
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the grammar for a command the "delim-pkt" is optional, and a command cou=
ld be followed by a "flush-pkt". On the other hand, JGit code is assuming t=
hat there is ALWAYS a DELIM package after command. I.e. messages valid foll=
owing the grammar would fail in JGit. This is not causing troubles because =
all commands (ls-refs and fetch) have command-args. This problem arose when=
 adding parsing for the "capability-list" So, bug here is align protocol gr=
ammar and code expectations. Given that a. most commands have args, and b. =
having delim-pkt between sections simplifies parsing, delim-pkt should be m=
andatory.

Calvin Wan (1):

 Documentation/technical/protocol-v2.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)


base-commit: 0785eb769886ae81e346df10e88bc49ffc0ac64e
--=20
2.33.0.664.g0785eb7698

