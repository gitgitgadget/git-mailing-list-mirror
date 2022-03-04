Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905AAC433F5
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 10:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237734AbiCDKnz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 05:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237758AbiCDKnx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 05:43:53 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E941AC299
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 02:43:04 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 27so7169172pgk.10
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 02:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rS9RLmJeaLN/NF1gn+rcBH3G3sV9jboIhHegjMfhSjo=;
        b=O6R6Iwxk+XZUs7FqdygpB0FuLfumLPil730X2KI/OovX06I86fTt3kl+b5V+8qzh4c
         KOsZP2a+qVnu47+E5UGAnh0FN5jmSj0WGb/Cbc1QTUUorX03hTKp9rZxkzt21oV5YWAU
         ZIR/CRRf0SH16C5ZuKxqrUPB6jHrRDG3KCMR4xBkiXXAQji+FX6uz433QNieMoo8H0MM
         zymwODS6i8ANvWSa6L9SbHTRPnlo7MS4O4aKQCRVM8hRP7m0sEd4Yn2KaNNK/NS10/Cy
         O16alCRuCB/xwHohsQzO1re4DYTAIn6TisgBoJgxwklAc9drxgC5sJExFQ4rFdhXfc4d
         zmyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rS9RLmJeaLN/NF1gn+rcBH3G3sV9jboIhHegjMfhSjo=;
        b=muRP+NECeRKKhHMALPjUTCRluMfzDfZY/V2myzqMQE9RmwJ6No+XhtYaXiSOGtswC5
         R7Et8tbcNaceYMhhDD02tLDD3yFODgltQLh97saErW6TbjTVGnPZ+JcWUybsyc3SOQUl
         44wDfvjghGHqR6dudJY4l9AyYLDr1Z4z9rydZVUxAh/EinL19u4A56Dc1KeznMxG8KRl
         4yYuSKI0r8b1Lr9k0PzAQLw74N/ccoE7uyest6oAX/Z/JlMvPRkwVMcxvqwOYMUuEAFU
         YPQXSJ8qzZQVXiNCFDwZcxXkJ0vCylKcPccunkKSxzm+KhhZpZeny3PzewwPLvk4DIiM
         w0Lg==
X-Gm-Message-State: AOAM5338y5GqJnk+AR+IT3xrDoWVetT1C0nDWdNPuF40q8Sb7KtRMOqa
        S98CAH5HkBCNC0M0ieO7pW4=
X-Google-Smtp-Source: ABdhPJy3a5d9THKnZ66TVXb3CllYDTpjMi67u+Xz6/1+PYMAlnpW4jpHFSCayY/feDefqtTR/mvGJA==
X-Received: by 2002:a05:6a00:23d4:b0:4c9:f1b6:8e97 with SMTP id g20-20020a056a0023d400b004c9f1b68e97mr42473947pfc.27.1646390583553;
        Fri, 04 Mar 2022 02:43:03 -0800 (PST)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.53])
        by smtp.gmail.com with ESMTPSA id k7-20020a6555c7000000b0034e101ca75csm4236253pgs.6.2022.03.04.02.42.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Mar 2022 02:43:03 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: [PATCH v12 02/12] ls-tree: add missing braces to "else" arms
Date:   Fri,  4 Mar 2022 18:42:28 +0800
Message-Id: <6fd1dd938303192d5b0a4cdc2914b2ff72cf5a3d.1646390152.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.402.gef0f5bd184
In-Reply-To: <cover.1646390152.git.dyroneteng@gmail.com>
References: <cover.1646390152.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

Add missing {} to the "else" arms in show_tree() per the
CodingGuidelines.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/ls-tree.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 5f7c84950c..0a28f32ccb 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -92,14 +92,16 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 				else
 					xsnprintf(size_text, sizeof(size_text),
 						  "%"PRIuMAX, (uintmax_t)size);
-			} else
+			} else {
 				xsnprintf(size_text, sizeof(size_text), "-");
+			}
 			printf("%06o %s %s %7s\t", mode, type,
 			       find_unique_abbrev(oid, abbrev),
 			       size_text);
-		} else
+		} else {
 			printf("%06o %s %s\t", mode, type,
 			       find_unique_abbrev(oid, abbrev));
+		}
 	}
 	baselen = base->len;
 	strbuf_addstr(base, pathname);
-- 
2.34.1.402.gef0f5bd184

