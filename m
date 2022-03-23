Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41AACC433EF
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 09:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242509AbiCWJPH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 05:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234230AbiCWJPD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 05:15:03 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CD55D657
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 02:13:30 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id c11so613503pgu.11
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 02:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6eg2+PfrGKe9kMDDOq5YTVuEaSpdzCrMNdfKaE5/kYw=;
        b=T7R4z93MAO+LyZUkA5g1ZwGO35/MJ7juJz3PWmWHFDOz4DfL+xV+yd5pD6tuFxKcfN
         hutt2ESDNXLBQphk3x2sWj/+CjDm+1sJglrom1no+MSKOyxtQmwSQHNVyX1VmK5a8wiL
         jejMNBQCjJtURapxlRVvoVG01iaR/1/5YYvdSmItzHGELuZUsSiaJrXYQzbh1UepTK6J
         d1Nd6dtmGUmBIoFLMjzibd8chty5/yypsbBSmi+/vJtLaeHgrxNRlq4yynqYWgvK4uIT
         ES5ps8dh3AuuGUabpyObvjeY2IlIHDaWIg91sEJLQmsTy8YmKBFAcEm5E7b2EZDAhqmQ
         5dag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6eg2+PfrGKe9kMDDOq5YTVuEaSpdzCrMNdfKaE5/kYw=;
        b=1bnUnh5hhNVoxbOs640i1uWPw7gXnhblE/G5+AMChg4AHjIgmSQu2U8vEWWuUxVB+z
         QxQFkn6rz5rqJxLWo+i+v3n10HPs3dCR02IfW2WgakhpF178LSLpv4DXu31KwMVRRrTo
         A9eEqwPWb/0TW8YhWxpw9DDuU5ixYwxDK7Y3rIzOm7Lh3wNI1tFCHi/osGdIBcl0A8R8
         I+SlXRfaEqPcgiLLOooNHKxiQ0B1nAjA0BXHrkGFQsThWQgU1EAnra6c86o4zFnD58ee
         fA5CsR/WrttKDE7nrLkevUW74rMoOLP/6Zd5OoYV3B3XsRy82W8Uoi4hE8ZziQCsmE1Q
         MwuA==
X-Gm-Message-State: AOAM530oNKbJ60nmSSNnTDsZrCwlZk1x6xhkejg2rEGmAlwm8BJiAScV
        yc1K/OydqBaraPKjEeVw76Q=
X-Google-Smtp-Source: ABdhPJzsWWpJXy36yOvLeezLgF36psfEu/IA8yLBQ2uW4QTQf/Np79MpnoVqvGsKantLDkswDKFCLA==
X-Received: by 2002:a05:6a00:140a:b0:4e0:54d5:d01 with SMTP id l10-20020a056a00140a00b004e054d50d01mr32818107pfu.20.1648026810038;
        Wed, 23 Mar 2022 02:13:30 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.39])
        by smtp.gmail.com with ESMTPSA id s135-20020a63778d000000b0038259e54389sm10224261pgc.19.2022.03.23.02.13.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Mar 2022 02:13:29 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: [PATCH v14 03/15] ls-tree: add missing braces to "else" arms
Date:   Wed, 23 Mar 2022 17:13:03 +0800
Message-Id: <93484b102d5ac22408bc76f7feecc26406b9e0a4.1648026472.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.404.g92931a4a2c.dirty
In-Reply-To: <cover.1648026472.git.dyroneteng@gmail.com>
References: <cover.1648026472.git.dyroneteng@gmail.com>
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
2.34.1.404.g92931a4a2c.dirty

