Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FECC3A5A7
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 00:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbiLGAlE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 19:41:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiLGAlC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 19:41:02 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3C3266D
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 16:41:01 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id b1-20020a17090a10c100b0020da29fa5e5so14309678pje.2
        for <git@vger.kernel.org>; Tue, 06 Dec 2022 16:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DUOoqQ2SBA0p+uwCDBO+fTPGb95ko5eqZbS+PQhKt14=;
        b=UOrIlLo4V0tApUlKQrhQ8IKDDNd+s+7GYAueb2rt7D/kzcXTX9tzBFPs/tKU26efP5
         bb0PziIeR/7/J0WsiqN+81+USysX073DezaTR3L32ToOTxenVegta1GhwB5xiQXrD+UM
         SQR9fxPym1N57TdmJ14co4VrPM2uhhwZtodia24J/B0Pqh5skvoaHUA6bj0KtQR4GnZZ
         vJV/2loU6XdFqjNKFySck4R0HAOrR+tTgrGK+leV3AJZqWcqyyjJbBU4C7Kw1p1AG++q
         el2JOXHXCbCA1sKbityZfIopvGVcjjFLoPuNpjQ8TKDeVZgaLa6vicNxqb3cwm4MepRG
         DvtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DUOoqQ2SBA0p+uwCDBO+fTPGb95ko5eqZbS+PQhKt14=;
        b=O1tOOoSbQQX+lo9XvSD98j1KRehgIQOAMgByERncK+9Quv0plkRyw+xeoln/aSLcay
         tUw0MUi/9vUbZNjBE+Me3albHGGZ44v++r9r6JXzxxymye9wjsPda7UiBu26ABt8FMzd
         MtwoYzmKz+QU+ND/FFAjg5CJt1Vg8ubHGk/HsHH/C7HFe/i+C0Lle+3pY7gTxmhYAN8C
         /mBw2EpbGiBNtF8kvCIcSgCx5+C0QeEhJM1j1lyJX/9K7Hll92fo/JvTbWAPLoIBUJ1A
         tsZSC805DoflmqhISTBXadjUcwbsMB6bouY601SE6o8PtjtYUgJ/iL2DmuAjtuY+jV88
         XQ9Q==
X-Gm-Message-State: ANoB5plkRYEZhkZNBlMIQDCsffX1FeuZ7WmgG6tbxlcQyKuXa2qx12m2
        8wNOXCadDW5HJX6KstAGfeN3BSV9Sm51J7YTaKpZ+dCbgfvhKEC+r4aER1wxfvfPMZlk9EdwZe3
        WISsjwif76Qs/1n7WsSA/Z5H8ORCbxDRb6kwnjfY3NQpAxK/SEx+xUNmM+sRpZ3wDUYD+AYOPKR
        +R
X-Google-Smtp-Source: AA0mqf7DBXxwHCoSjHzNiyztceFmTOCkJDRJaDGIiWJEE7FPMzwsPQV0iczoBImYNkdhvBCBRUdS0YqqN/CsaM8tHRqQ
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:a589:b0:217:b6d1:968 with
 SMTP id b9-20020a17090aa58900b00217b6d10968mr104951539pjq.52.1670373660910;
 Tue, 06 Dec 2022 16:41:00 -0800 (PST)
Date:   Tue,  6 Dec 2022 16:40:51 -0800
In-Reply-To: <cover.1670373420.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1669839849.git.jonathantanmy@google.com> <cover.1670373420.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <9ad34a1dce977044066de0bfa6e25977215e8dc9.1670373420.git.jonathantanmy@google.com>
Subject: [PATCH v2 1/3] object-file: don't exit early if skipping loose
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead, also search the submodule object stores and promisor remotes.

This also centralizes what happens when the object is not found (the
"return -1"), which is useful for a subsequent patch.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 object-file.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/object-file.c b/object-file.c
index 26290554bb..596dd049fd 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1575,18 +1575,17 @@ static int do_oid_object_info_extended(struct repository *r,
 		if (find_pack_entry(r, real, &e))
 			break;
 
-		if (flags & OBJECT_INFO_IGNORE_LOOSE)
-			return -1;
-
-		/* Most likely it's a loose object. */
-		if (!loose_object_info(r, real, oi, flags))
-			return 0;
-
-		/* Not a loose object; someone else may have just packed it. */
-		if (!(flags & OBJECT_INFO_QUICK)) {
-			reprepare_packed_git(r);
-			if (find_pack_entry(r, real, &e))
-				break;
+		if (!(flags & OBJECT_INFO_IGNORE_LOOSE)) {
+			/* Most likely it's a loose object. */
+			if (!loose_object_info(r, real, oi, flags))
+				return 0;
+
+			/* Not a loose object; someone else may have just packed it. */
+			if (!(flags & OBJECT_INFO_QUICK)) {
+				reprepare_packed_git(r);
+				if (find_pack_entry(r, real, &e))
+					break;
+			}
 		}
 
 		/*
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

