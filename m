Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F11C433EF
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 23:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353179AbiFOXgF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 19:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350721AbiFOXf6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 19:35:58 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AE61E3EA
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 16:35:57 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id q9so18925wrd.8
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 16:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ANsbg2yeJFKLZLs2d33rrXjqBnFMEV8dtSd0djH7nI4=;
        b=AuHtvju0ybGXC9JNBQQcZAYfHZtOydAJvvjSdMv2YeDeyPypyS47U49lkke35dNRia
         bF2xuhxS3AdyEKP+nsWIeNiOtcZ/VmRm2KG0mjy71+SnQ+94Jrc0+7ecTWnoMw4liwPv
         o5Ib0eOsWO06kg3VajOYxVrStu1yNe9+l6n97rBtryXg2pNzRpqjGkhXEMIa5H7munwt
         uRES37OdZMUuH+RfkCYJ+XlTVATsR7ru83sFRBn8K9qJOnBHU2qe+pxFlCstVBvxvdOm
         HqDFD9W91AVPj0jyiIrquW5D/SOvwkBu/CZ3fFjg0ME+AKgkzgn42UZJaAUaOwruS4Ym
         XXSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ANsbg2yeJFKLZLs2d33rrXjqBnFMEV8dtSd0djH7nI4=;
        b=JXmLawGViCe5aZ2TpdqmlMJ/IrsnRGetpb4gcFRL9C8GcQbjFCtG7PKTbtGSBMhqe7
         PaPJIEJj3OeX80B/SdLGKQCWCyn4DTfAhbKVloHiYNvSydmCkTvzZdItvAuqY5AUY0LN
         X8zSEMzPCAcAlsSisjocNR9HpJVrccjSBxGxuRgOXSwOEqGy3WFwAbLH3URrt1BE31zS
         eYku4AA5ZdD2Oxl1V+S1dMuKX0XdxY80NIMNa0O8cQGNbYPdnMMPji5zpPOK4JHChiNR
         wwaFUFINMOdPc0Mlm8Bq0mVGZWbjHkSlT9Gmnl0vBOIzSwZ9KoL13Rj/ig8xwVzHC4QB
         /oTA==
X-Gm-Message-State: AJIora8JiwM2baA3slvFX2jX8hgYXWAar5hv3vErtBsIzQ2yWiecIIcy
        HZBC3A8CvztYB1aTmRsVfbXWvsZj7IOsAg==
X-Google-Smtp-Source: AGRyM1u/e30MPJtET4uZvumv49+nV8eTRRU+FQgbe/Dyu7IxnfRVE0pUIBZmPYNV9/4WXFxIROhnEA==
X-Received: by 2002:a5d:5a94:0:b0:218:531a:eea with SMTP id bp20-20020a5d5a94000000b00218531a0eeamr1949558wrb.703.1655336155176;
        Wed, 15 Jun 2022 16:35:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j19-20020a05600c1c1300b0039c5645c60fsm9223080wms.3.2022.06.15.16.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 16:35:54 -0700 (PDT)
Message-Id: <cf6bcdb43e5b4abab464c30a914d64dc8e7a9925.1655336146.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1264.git.1655336146.gitgitgadget@gmail.com>
References: <pull.1264.git.1655336146.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 15 Jun 2022 23:35:38 +0000
Subject: [PATCH 04/11] get_oid_with_context_1(): avoid use-after-free
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 561287d342cc (object-name: reject trees found in the index,
2022-04-26), we changed the code to release the memory stored under the
`new_path` variable a bit earlier.

However, at that point the variable `cp` still points to `new_path` (if
non-`NULL`), and we _then_ pass that pointer to
`reject_tree_in_index()`.

Let's make sure that the pointer still points to allocated memory by
moving the original `free()` call back where it was, and adding another
one in the early return code path.

Reported by Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 object-name.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/object-name.c b/object-name.c
index 4d2746574cd..228c12a554c 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1971,12 +1971,14 @@ static enum get_oid_result get_oid_with_context_1(struct repository *repo,
 			    memcmp(ce->name, cp, namelen))
 				break;
 			if (ce_stage(ce) == stage) {
-				free(new_path);
 				if (reject_tree_in_index(repo, only_to_die, ce,
-							 stage, prefix, cp))
+							 stage, prefix, cp)) {
+					free(new_path);
 					return -1;
+				}
 				oidcpy(oid, &ce->oid);
 				oc->mode = ce->ce_mode;
+				free(new_path);
 				return 0;
 			}
 			pos++;
-- 
gitgitgadget

