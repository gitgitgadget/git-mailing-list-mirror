Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AEE1C636D3
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 23:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbjBFXJA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 18:09:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjBFXIj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 18:08:39 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449153252E
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 15:08:24 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id m2so38748333ejb.8
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 15:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a9exlaS/vFmmeUI76ci5dvRddAkFcAU2AdM89oCUXKc=;
        b=GOeVTv+TzV1hJJggptd4UDrtdLEdVpbNva3osHl4a1/SjveFRp0qJrXMdzMOM8EhuD
         XgO2uzmNFqjyDEQzFMcWmIA2uPniyzN7FcNbsItfaCzgYt0Jn83FkWae/yFoqO+WVMBG
         PXQTnZqaFdXalBMxneEuAZGKH9UsjGd4fuF4Z0LOo/2aEfuWMMIVR8s0RP8IocyZS7UQ
         X8WXOSmgu1sX+727vQzYydoWvKiXB58WGTu6gj845YLtJqoyg6FFcWFLyRt6wWwM3pXI
         sxY8G0M9IC8WW/ogh9vGB2X+GOATtr5xzaf3W+IN2/vkZ1QHb2Ha43pq+JhzKuLCWbkD
         /fwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a9exlaS/vFmmeUI76ci5dvRddAkFcAU2AdM89oCUXKc=;
        b=2IcO9/RlIwbei5PFod3D80vsFEADTxCtmXK2VF/XaKtt/a7Mv9p5B7kWimQd8SuiqZ
         8Zvltbs56tk/mf3J1u0gzIfzeKrKwsYaiuFwBJIi7IWrWByiJCYvBvfzuchpHzeS5vgO
         h8/Ga9oTtNS0DkC7iIkrjFICWYstWtEL+7RYce24whEDSWboqnzfEhbzVPSa/TSZmoN7
         NrJjKVEAJZbuTFvu5rJj/CxQIhPpuxJiRv9cCj5XC8GqvsdqAEfMQki/8roxAjnRiXdI
         N2ofIjo7ylNVa658oGZRwPD8IjBEHBt4M6pPOAanNy58M8h6UyjFzHtCuE6QmJrnAkLT
         aaJA==
X-Gm-Message-State: AO0yUKV3r0wEvtX7dDdyJORpo7NePZvK6IiTFaXqX2Z2kvuUKux8qcvm
        +vrNjbdpLrg+6loy86nfMhwKZmjMJyDTInb3
X-Google-Smtp-Source: AK7set8X0TPQJo4wuW6jaDc4XrJkjnByF1j6KlQDsnJwAN4bHPVVjpLHjI0xx9IQE+4uYxldleWoEQ==
X-Received: by 2002:a17:906:e218:b0:871:dd2:4af0 with SMTP id gf24-20020a170906e21800b008710dd24af0mr1126104ejb.26.1675724903005;
        Mon, 06 Feb 2023 15:08:23 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s15-20020a170906a18f00b0089d5aaf85besm2673586ejy.219.2023.02.06.15.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 15:08:22 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 14/19] builtin/merge.c: free "&buf" on "Your local changes..." error
Date:   Tue,  7 Feb 2023 00:07:49 +0100
Message-Id: <patch-v7-14.19-c1223aad2ae-20230206T230142Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1425.gac85d95d48c
In-Reply-To: <cover-v7-00.19-00000000000-20230206T230141Z-avarab@gmail.com>
References: <cover-v6-00.19-00000000000-20230202T094704Z-avarab@gmail.com> <cover-v7-00.19-00000000000-20230206T230141Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Plug a memory leak introduced in [1], since that change didn't follow
the "goto done" pattern introduced in [2] we'd leak the "&buf" memory.

1. e4cdfe84a0d (merge: abort if index does not match HEAD for trivial
   merges, 2022-07-23)
2. d5a35c114ab (Copy resolve_ref() return value for longer use,
   2011-11-13)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/merge.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 32733e551d4..5a834b1f291 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1618,7 +1618,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 				error(_("Your local changes to the following files would be overwritten by merge:\n  %s"),
 				      sb.buf);
 				strbuf_release(&sb);
-				return 2;
+				ret = 2;
+				goto done;
 			}
 
 			/* See if it is really trivial. */
-- 
2.39.1.1425.gac85d95d48c

