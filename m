Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC5F6C43334
	for <git@archiver.kernel.org>; Sun, 12 Jun 2022 07:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234742AbiFLHot (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jun 2022 03:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234723AbiFLHom (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Jun 2022 03:44:42 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7880B5250E
        for <git@vger.kernel.org>; Sun, 12 Jun 2022 00:44:38 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id a10so3010568pju.3
        for <git@vger.kernel.org>; Sun, 12 Jun 2022 00:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CGYW5rJc9oYiO4yl5ViLtNl9pO0BDQAqIrKP7lEoxoI=;
        b=E3NEKwGt7U8MmP7u3FSisL9Do9XUxENm0X3siefH3QYoxgSqYYVnV+nG0mR0E+9eBU
         utamATE+zQFZUjzV77AuTK5ngr1ZAinHBnQCxLXPV2Ft3Lxnt6T5fNCnxUhXflW1xOxD
         ugxGCGE5bL5rKorrS3HOm2nGEa65mmWiKoQ9tdxcYh5fhp3HlPcQ6bC0FLQSbLeJ0oaw
         dvJ+e6cKQLYL+Jq8Q5csBrOu5jK2Bne1HsHDEtTPEnqCd7blao+bEJ2cIRY2YM/7yZ17
         RF00D5MrHhI70DYYJfL35+0hV8FefMtMMY1eiJDVwPUcmr8MkQlff1hAO3iGw2EQ9pXA
         6LUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CGYW5rJc9oYiO4yl5ViLtNl9pO0BDQAqIrKP7lEoxoI=;
        b=Md8+QDT6cXLAYunkiJnj1bsPq5+YkKG5MigOT4hzO6ssHWU3PiLzEFrO/2+0rus40+
         1EiAXP7ymre2oDZrwKwh8Ht1cBXC+PSoJvkRyx0FIldpTjw3RISQ2QZiIDNb7Jp2LLPF
         V2F4F/kqGnvYepo6eGuu7S3/pNWVJOrBPxhfknqZ+M37nbyuDju+88K1hHBxnm6k8cm8
         mWEV15ZBiV4XxU7N0VD6QOXpXrbJ0AyRCU8DtWmYnTD/XDudd0c9DkXTUXugBUePk96t
         FdqLpRDMXG0B7qh72bx+WToQ3yDWvC3kzHO+kkrjtZuOelSzsVqp0/0NvlO6RNXo9yaN
         sMEg==
X-Gm-Message-State: AOAM533iZbbBjt25XcWgFKIOG/GYudtVJsc3Ji4ps1VikkgTsjlKtM8w
        o4ki5/yHTS85DHQQF25MSG+22lUjpWiJ4Vnr
X-Google-Smtp-Source: ABdhPJxOxk6MEGxqOhKXJ2OCQaMVDBbwke6aYdTJXdP1EgWeF+q+d8y9OFNSO4EMBoRDCTPp9CYAhQ==
X-Received: by 2002:a17:90a:df16:b0:1e3:1cd:6c6f with SMTP id gp22-20020a17090adf1600b001e301cd6c6fmr9163697pjb.10.1655019877582;
        Sun, 12 Jun 2022 00:44:37 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.44])
        by smtp.gmail.com with ESMTPSA id w14-20020a1709029a8e00b001676f87473fsm2559707plp.302.2022.06.12.00.44.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jun 2022 00:44:37 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        gitster@pobox.com, me@ttaylorr.com, tenglong.tl@alibaba-inc.com
Subject: [PATCH v3 3/5] pack-bitmap.c: make warnings support i18N when opening bitmap
Date:   Sun, 12 Jun 2022 15:44:18 +0800
Message-Id: <d8dfe53dd47b05aa55cfa2ce9eed428212fd17b8.1655018322.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.1.582.g320e881567
In-Reply-To: <cover.1655018322.git.dyroneteng@gmail.com>
References: <cover.1655018322.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When calling the "open_midx_bitmap_1()" or "open_pack_bitmap_1()", there
will be a warning if a normal bitmap or MIDX bitmap already has been
opened, then let's make the warning text supporting for translation.

Discussion in community:

  1. https://public-inbox.org/git/YkPGq0mDL4NG6D1o@nand.local/#t
  2. https://public-inbox.org/git/220330.868rsrpohm.gmgdl@evledraar.gmail.com/

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Helped-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 pack-bitmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index f13a6bfe3a..af0f41833e 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -330,7 +330,7 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 		struct strbuf buf = STRBUF_INIT;
 		get_midx_filename(&buf, midx->object_dir);
 		/* ignore extra bitmap file; we can only handle one */
-		warning("ignoring extra bitmap file: %s", buf.buf);
+		warning(_("ignoring extra bitmap file: %s"), buf.buf);
 		close(fd);
 		strbuf_release(&buf);
 		return -1;
@@ -387,7 +387,7 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
 
 	if (bitmap_git->pack || bitmap_git->midx) {
 		/* ignore extra bitmap file; we can only handle one */
-		warning("ignoring extra bitmap file: %s", packfile->pack_name);
+		warning(_("ignoring extra bitmap file: %s"), packfile->pack_name);
 		close(fd);
 		return -1;
 	}
-- 
2.35.1.582.g320e881567

