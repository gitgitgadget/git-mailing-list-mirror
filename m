Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AEC8C77B76
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 12:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjDNMSz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 08:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjDNMSt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 08:18:49 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931EEA272
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 05:18:48 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-187a1387021so4081976fac.3
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 05:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681474727; x=1684066727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NcvgWFXKvgw9IRDZJw9QoZqVIf+9jTj1q270nYCiN5E=;
        b=k2VzKvNrJUNkgI3Euf1fOpgz44dH2pBlgRv4hT51otQxHfdVOR7evnLCvqU7BYXR7i
         s3FA7a6n6gCWctUN73l7FKAxSE8SoYfYIqi6eapAEu7kUaC1CooF25uRnAmJkTU8PtgU
         rtO8HiU1Tyg5EDRkY+INfETMD83xaLOhW8KkhZiJ1n1KiKgSP90zDvCyE7vyoBj6yB0S
         eKrYHvM9CoheG8AANAShpGRCHGeSICGQ1zSTgUaRKyufRZN8NrS3+sONYCdT8k82j9l6
         X52pESpQ0g5UwQskZ2wGUdsWcbRAIZvEHR4uZb9DHVIFuLC82+WBIcK6AWKOeWv8ntKK
         WqZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681474727; x=1684066727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NcvgWFXKvgw9IRDZJw9QoZqVIf+9jTj1q270nYCiN5E=;
        b=IdMNC9dDDC5BZPJS/I3Gac1gQR0g73VC1FaYXCaQW4Vpumz7vxglp0Y4Pcn0tfdJC+
         Fmjf4S5lKl0kJXWYsKWm/LY1ZoJsZRCGBx/HvDUgECvnbXxKyzew8KLV0FuaMcC2Wu5K
         VcaYBPSvSsi5h0YxfbUfYoe8KjAxT/8Cwhah7guq9A9vgK4kLsbtZa4NKudy4KonlG8M
         TFi79ZXBZNqhitV0SJnT5DgGVLpzZIitbw5g7hgaLuV3ZxDy0eC7BzbSChkeNc90+Mfk
         uVTG7jeT8qqxbirPoqxU2tkFTgs+hNDa2qnzayWA79tKzecQzfbuYgcW1kVVlNlLWWK5
         eb1A==
X-Gm-Message-State: AAQBX9dOO80RnBmarDwBzyD6oBzQbPgvhVqD8iZMqxoFDwU7JphqOph0
        ynPSqVAIFSmCRuV3sh1lwySIp3xVxMs=
X-Google-Smtp-Source: AKy350ZA8ITQqvQm0X0dAg98eYbGGekC+u4Fvusv0wwuHlpLaTPTg2Of15R3eIfyk9o5eySXMHcJRQ==
X-Received: by 2002:a05:6870:73cd:b0:187:8ab7:c0f6 with SMTP id a13-20020a05687073cd00b001878ab7c0f6mr3735132oan.9.1681474727647;
        Fri, 14 Apr 2023 05:18:47 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id u14-20020a9d4d8e000000b006a2cc609ddasm1645055otk.2.2023.04.14.05.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 05:18:47 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 03/18] version-gen: refactor default version
Date:   Fri, 14 Apr 2023 06:18:26 -0600
Message-Id: <20230414121841.373980-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230414121841.373980-1-felipe.contreras@gmail.com>
References: <20230414121841.373980-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's not clear how `cat version` might fail, but either way if VN is
empty (or unset), assign the default value.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 GIT-VERSION-GEN | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 6dd7683ee7..0d00fa3d9a 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -25,14 +25,14 @@ describe () {
 # then try `git describe`, then default.
 if test -f version
 then
-	VN=$(cat version) || VN="$DEF_VER"
+	VN=$(cat version)
 elif test -d "${GIT_DIR:-.git}" -o -f .git && describe
 then
 	VN=$(echo "$VN" | sed -e 's/-/./g')
-else
-	VN="$DEF_VER"
 fi
 
+: "${VN:=$DEF_VER}"
+
 VN=$(expr "$VN" : 'v*\(.*\)')
 
 if test -r $GVF
-- 
2.40.0+fc1

