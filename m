Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35730C433EF
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 07:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344931AbiCUHfM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 03:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344928AbiCUHfI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 03:35:08 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA29854BD8
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 00:33:43 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id m11-20020a17090a7f8b00b001beef6143a8so13639530pjl.4
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 00:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+OdBXWAZOjwpWgkNLycV7jv8YJ07vdbO6u3OAvzfWCQ=;
        b=WVMeo1QeOOYlwRN8CdSt7CQYSvl9SHtHTrprc7Fc51azBBL2D/2lk+8a+PRzRZpxrS
         o0AoUgX0ewI/cKJZKIGpdNvM74+Ll/NmOpDKNHfzJExYfgg/4AhsWRSryQAUmgAB/i+G
         Gl6Wu840suEzhYd9c0t9o3tH9YhPpY5ZXIOwq8LYkQimaCONrBQ/6HfGJoVa0WQ3Nmm8
         XAGnpH+zY94a1yOzgt+7yEXT4GJyy+roQLP41F68I0lAOSexgE1jurdRT84DKGAhKJj8
         QR9+O899a4Z36NmRcwp2aOdd2heSYNGbMHy5r0m8WGr+Eu+ag/CE0EsV3KYcDBcR1bxu
         7n+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+OdBXWAZOjwpWgkNLycV7jv8YJ07vdbO6u3OAvzfWCQ=;
        b=ysq0Z7i6yUrtk4rFemb3TJEvrkJ2RfKxCf43Y/lMmshWywLOktV+0K4TpXO2L/uOBZ
         G0byudORF8L2mfiJ2AIpuu/Uj0SxpA5q+5iCffYIACISyjESbTIFvLHWDkQyBW9YpT+o
         ulCWf0T5UnKkrd5YlVl+DGLinF35wH01cvLrfh0QXbFixrWJxDybGjN65XBV2leJAcjB
         wk2tx2LY4hdhcoNRrd9dEfLo6CL4cUczPi7iCJaVdtnLfrmllf8YPHyTKR+/sMr3sb8Y
         5qOkAX6+6JfIcBuNicS2FyJhHWmuKeab3gC8HwYa1yrPJFFEG8S6DWpxdeJsUHytklM+
         gNfA==
X-Gm-Message-State: AOAM530wBTmX1baw5FaiLwo0GmX7etAzLbgCLJIZ2kVOtyNs0NogP+hk
        vn8TooOihplrnzCTRiaZsyk=
X-Google-Smtp-Source: ABdhPJxpIMKNBQUc+S7PazR8u1L5paSIkqELc4TlVvU9nxWZNG0+rRyAqcvMoW1sFfSl0S/aJldNug==
X-Received: by 2002:a17:902:cec8:b0:154:6dd6:255d with SMTP id d8-20020a170902cec800b001546dd6255dmr743291plg.62.1647848023166;
        Mon, 21 Mar 2022 00:33:43 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.46])
        by smtp.gmail.com with ESMTPSA id o6-20020a17090ad20600b001b8d01566ccsm18914422pju.8.2022.03.21.00.33.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Mar 2022 00:33:42 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: [PATCH v13 02/16] ls-tree: add missing braces to "else" arms
Date:   Mon, 21 Mar 2022 15:33:16 +0800
Message-Id: <6fd1dd938303192d5b0a4cdc2914b2ff72cf5a3d.1647846935.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.406.g2e0e55130e
In-Reply-To: <cover.1647846935.git.dyroneteng@gmail.com>
References: <cover.1647846935.git.dyroneteng@gmail.com>
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
2.34.1.406.g2e0e55130e

