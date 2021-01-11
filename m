Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22612C433DB
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 14:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE4602255F
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 14:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388839AbhAKOsS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 09:48:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728671AbhAKOsS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jan 2021 09:48:18 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB65C061794
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 06:47:37 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id p13so3847561ljg.2
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 06:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=oDXeTZspGSFQShjwVMcm1fz8IHA0Ds9DiT/cOcFcMa0=;
        b=DtUZyQV/gS+8dJR88cCxl8zy9jbPTAaq7mCOMlcvEXi1y6Od6kqZC8je9EyfhIrkv2
         Av98wJhPYau8En9EV7sgxB9qk+a3cZ4YX4+GK7wArJh613JZAdHs27rk2PQf3jCzD1lA
         nJeyKHuHwULHjqq3KC2Kegq3pM8BsQOtL51zGdMEsfAGcNcgBosOIargv9ENVBn1Ztz2
         /fG8KE0qkm7R8/OMEq4oHYu7H6v7d5j7t8cKepll7o1Ow5yGi41/2iXUo9pwUktliFXC
         qNa9Q53qqsRjl3pHti1kAfaWhhFoME+2+hAqgSPSEEkTxF3XH3AWlYjbgn0w8tDClzWe
         ZCAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=oDXeTZspGSFQShjwVMcm1fz8IHA0Ds9DiT/cOcFcMa0=;
        b=KH49s0IWphMWAk31eGrkcOiwgDJOSodBUjKC/OoYe/p6HkVT3P81sotqaE5dBH7uVZ
         lU6gSeo4tT57/M48TmRwrho1WvT/NBYAH4FZOLerBg8Lx4aZRJI8TJzG3MlnqhQ4ww1W
         nn0jP7khPx8dSOUmFNlrfbwHATK8gggsezpOcNdhcoYhV2fQn8BmXHAZQ7BUNAL4SFe7
         8Qxd4gpVeYe0GDDANjx5pVadY9U7RiQsEmXBkkX60MCtAPUNuY4h1ogmmrpeoFZgwShx
         cl3dBwSnM3/7jAs1PHf7/Reb+LTWgmORjYBYuCCVvhMXqU5OU9kIds03eONn6PRMmAYj
         HELw==
X-Gm-Message-State: AOAM530mUEOlrxOHxzWkjMSgu2kJuhFMusI2hDiTn7P5FNuJppidboEU
        S2GYz8pHyo8bXpO0JdlHn5bwFVBlW0Sq/AYm5/psgUxU728=
X-Google-Smtp-Source: ABdhPJyvK+rRMTR4Gih/Ltx5Iu1EOsaeq1TBymx4xIEqnmZUei4ovr6BLS4YcEkTfyKLQkwFTbzRml0F28CI4ZnGsbc=
X-Received: by 2002:a05:651c:200a:: with SMTP id s10mr7288143ljo.492.1610376456279;
 Mon, 11 Jan 2021 06:47:36 -0800 (PST)
MIME-Version: 1.0
References: <CAF8BazBFsR5yQ0M5wscCfE-KuXTGZ=i4-1gP9NZZvjCfAD5NrQ@mail.gmail.com>
 <CAF8BazC1kEV+s7vDSAkqcvjYVTCyDaw8gi0ZHpH7K+3Q4CAczA@mail.gmail.com>
In-Reply-To: <CAF8BazC1kEV+s7vDSAkqcvjYVTCyDaw8gi0ZHpH7K+3Q4CAczA@mail.gmail.com>
From:   Aleksey Midenkov <midenok@gmail.com>
Date:   Mon, 11 Jan 2021 17:44:43 +0300
Message-ID: <CAF8BazDLhgtgt1jCD7B64ytguF-NYL60nDS9F8nxbRhhbfX7Cg@mail.gmail.com>
Subject: Fwd: error: 'submodule' does not have a commit checked out
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I used to update last commit with new changes:

git commit --amend .

The project has several submodules:

 e116c89a58af750421d82ece13f80516d2bde02e extra/wolfssl/wolfssl
(v4.3.0-stable-596-ge116c89a5)
a746c3af449a8754e78ad7971e59e79af7957cdb libmariadb (v3.1.3-121-ga746c3a)
b6b02ed516f92055127d416370799d91a82754ea
storage/columnstore/columnstore (columnstore-1.5.3-1-14-gb6b02ed5)
-d172e86c16224b4e0229ca6f102e662a2315aeff storage/maria/libmarias3
-bba5e7bc21093d7cfa765e1280a7c4fdcd284288 storage/rocksdb/rocksdb
-ae4e58ba031587039c8830f2f8ca51fa9fb7d6eb wsrep-lib

Now it fails with this message:

git commit --amend .
error: 'storage/maria/libmarias3' does not have a commit checked out
fatal: updating files failed

How to use amend without specifying explicit paths without
initializing submodules? I don't need to amend submodules and would
prefer them ignored in my commits.

git --version
git version 2.27.0

Works as expected in 2.19.1

--
All the best,

Aleksey Midenkov
@midenok
