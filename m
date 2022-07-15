Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CBCC43334
	for <git@archiver.kernel.org>; Fri, 15 Jul 2022 07:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbiGOHvh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jul 2022 03:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiGOHvg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jul 2022 03:51:36 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5427C785BD
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 00:51:35 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id az2-20020a05600c600200b003a301c985fcso2289887wmb.4
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 00:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iJg68WbIvqFIK62s1/GtnKBmMoxDc3HkA86Rkitt1Zc=;
        b=GfeVO2AlvbWeOANGdpzT3Nm1vDHnLID1W/sFXalSh1btMWOTkMEfoWRyE7Fpi9XWRv
         Motv1OOhSflYLMEHgJIdTKn2udjfv4L6bAlIl/xs6dFrIyFzOQMXF4JR3qqyJiNJaEMx
         79OuRNq0nPbpjNuXeXBDZv/lWvT4A+du54UG82tB8egTWqs83rAtuWBBXyH5rSHFId3J
         fI+hg1nhqxI5XrzuIbDW9e0/VIi3BhaydQ/pT2lIwo5i3ydbbxRDhX/IMjsfmhaHeKIL
         5fGo5sE3sGZVTJlzHfyL39I0njQLJ2XBvlYqsgHvZC/h8/jMndwE0hBRw1wzR5xLrR2d
         uFkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iJg68WbIvqFIK62s1/GtnKBmMoxDc3HkA86Rkitt1Zc=;
        b=gkQszvd7P6tyTk2fD4k5c0TzdFdk4900bR52rtX24mjIJH6pqNBIDucFAIPUogP11o
         mrB+FbIeYvP8iJtIW2xLcnpOG3HX/exULRgMWpHqVc8oV1c7NAvDiwTX5btGy6kdiT0s
         F2kuSwGFzMUt4a4uw0hlQjtACzIH8SIkri+5Ha599m4lwunPJnIn/9i1WjxyMtSXAOQM
         TWUlqF2NxDdK6RNzl5qcCJwdbky0o821iD3a0/xX/NxDRNL5/qTLY0EUfQIBPXjH+79T
         P5W4rfK28oRkA61JTNFiDfYyJi4R3s7oamuRYsScg1lM57Fz+Im4I8Fkhe4bys6MC0Ff
         emzA==
X-Gm-Message-State: AJIora9ARdMMrysgVu7bms1qRKwVZPjutZRHR4OfnHNhF6RM+i1nxMOz
        Ou+tv9diK9Z1Wd7HVhEvqg/+GOl4Xgyt9g==
X-Google-Smtp-Source: AGRyM1uIMPj9C6BNYhOe8tknzCHzPG/FcvfChQI4DF9SoSPPfQR7f0Klco4ZDVHDTxCSzk+rBnjP4w==
X-Received: by 2002:a05:600c:4f4d:b0:3a1:98de:abde with SMTP id m13-20020a05600c4f4d00b003a198deabdemr19104942wmq.36.1657871493429;
        Fri, 15 Jul 2022 00:51:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ay13-20020a5d6f0d000000b0021d6ef34b2asm3366305wrb.51.2022.07.15.00.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 00:51:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] git-repack doc: remove discussion of ancient caveat
Date:   Fri, 15 Jul 2022 09:51:28 +0200
Message-Id: <patch-1.1-363f84a3fa7-20220715T075114Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.996.g651fc6e809f
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The backwards compatibility caveat discussed her hasn't been a concern
for anyone after Git v1.6.0. Let's simply remove it, I daresay
nobody's concerned these days with having git clients running older
than 2008-era git.

See b6945f570ac (git-repack: repo.usedeltabaseoffset, 2006-10-13) and
9f17688d93c (update git-repack documentation wrt
repack.UseDeltaBaseOffset, 2010-02-04) for the commits that previously
introduced and adjusted this documentation.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-repack.txt | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 0bf13893d81..fe1eac37090 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -218,16 +218,6 @@ CONFIGURATION
 Various configuration variables affect packing, see
 linkgit:git-config[1] (search for "pack" and "delta").
 
-By default, the command passes `--delta-base-offset` option to
-'git pack-objects'; this typically results in slightly smaller packs,
-but the generated packs are incompatible with versions of Git older than
-version 1.4.4. If you need to share your repository with such ancient Git
-versions, either directly or via the dumb http protocol, then you
-need to set the configuration variable `repack.UseDeltaBaseOffset` to
-"false" and repack. Access from old Git versions over the native protocol
-is unaffected by this option as the conversion is performed on the fly
-as needed in that case.
-
 Delta compression is not used on objects larger than the
 `core.bigFileThreshold` configuration variable and on files with the
 attribute `delta` set to false.
-- 
2.37.1.996.g651fc6e809f

