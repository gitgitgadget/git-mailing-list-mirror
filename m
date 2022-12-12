Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7655DC00145
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 22:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233813AbiLLWuT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 17:50:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbiLLWt4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 17:49:56 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34576E14
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 14:48:58 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id n16-20020a056a000d5000b005764608bb24so767562pfv.12
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 14:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lwKbvaXU+L0SbOjSLYra6EM27mGx94iI5RwBlo+OQpM=;
        b=r9mTHvtQ2C9ysTlzJ0PZe4o80TAN5Jpc+lTa8d6ZEWCQRrsi3T6h1AFrZNs2N8QgCs
         JVvpbDdOQeupVcgV12BA0fpZ92MfiM+IaHSQNMnZ85aeuIrMFq+3S9guMbhAdJOQqSA9
         N1Djc2fHOnOy6cCWVh23NKY1dNw/O7xedcmd9jjjI3z4jTrY/HVkwOGkewIaWGD+PJMo
         /+IKdqYyRiNcO/PUcISRJVGQFnbkCuANjRUah/+Y9xJxfpZOUdw1qANMyVqfa3AWCRPC
         3JsMeBTi/K1bp4vTdJ8xbQvjMnccac8LtVgavuxZH6kSZTV08JPY+ktuVEIlHKlOoOk6
         Iq+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lwKbvaXU+L0SbOjSLYra6EM27mGx94iI5RwBlo+OQpM=;
        b=UXUaRQW219YryTCa3l4thKoxWeEuyuR85ZQZ1LGbYD7D+r2hQv7DLSpqnYiKzdamIO
         PAaFlc5YIlpaPSXtCnCOQIIpCYCdYJDUCGN7g6UrHlyYSsjUOaWynymX3LTvg+gEWgGw
         sikI0rMkAkCY7RFoD9g8+NfTegcpcaSWdLbakDad0DcDi3UXSJW3wpdut0orheQdsF2n
         XgpvuSb7OcwKmEveLIBJX4G+E7oyC4MaBHRrGjzdfT/KIpO2gH7eE4xbDL981Kn64raN
         ukCufmNdz19vXA2QYiRBsm/69nZzy9h7tW8E0zZ2HANBftJYzl1Au07RdrpkDiKCG5+u
         7/Ag==
X-Gm-Message-State: ANoB5plTbmteiMYetnelFVDOWtvTlg0gAvaAGqu5Q0kh6vKaJqn0/JqE
        pbGdZFA5CsHoeYFJmSZvoioqHKX65l7TItRfpB0KNpmmAfhKNX1VkEdpG6sDlJmPi0HxswC/DJn
        Ucg5cWRegwJ1DJ5hObkdP+9f1TqzPp6oFHjsBSjPvyR5M6r+tI3JFSWw4/mHS2cJR96CopIf6yf
        zK
X-Google-Smtp-Source: AA0mqf5gVdJEucMREmT/PJFNxotrcOnuDpsqWWdaB4af3QrV1RqIAKDkLVA0nmyNSHuUIGa/leflf1GThCfs9ibHXXhe
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:da88:b0:189:967b:97a5 with
 SMTP id j8-20020a170902da8800b00189967b97a5mr49111707plx.40.1670885337527;
 Mon, 12 Dec 2022 14:48:57 -0800 (PST)
Date:   Mon, 12 Dec 2022 14:48:48 -0800
In-Reply-To: <cover.1670885252.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1669839849.git.jonathantanmy@google.com> <cover.1670885252.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Message-ID: <be0b08cac219357e1ce9cd46fd7ab5c13344699b.1670885252.git.jonathantanmy@google.com>
Subject: [PATCH v5 1/4] object-file: remove OBJECT_INFO_IGNORE_LOOSE
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Its last user was removed in 97b2fa08b6 (fetch-pack: drop
custom loose object cache, 2018-11-12), so we can remove it.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 object-file.c  | 3 ---
 object-store.h | 4 +---
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/object-file.c b/object-file.c
index 26290554bb..cf724bc19b 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1575,9 +1575,6 @@ static int do_oid_object_info_extended(struct repository *r,
 		if (find_pack_entry(r, real, &e))
 			break;
 
-		if (flags & OBJECT_INFO_IGNORE_LOOSE)
-			return -1;
-
 		/* Most likely it's a loose object. */
 		if (!loose_object_info(r, real, oi, flags))
 			return 0;
diff --git a/object-store.h b/object-store.h
index 1be57abaf1..b1ec0bde82 100644
--- a/object-store.h
+++ b/object-store.h
@@ -434,13 +434,11 @@ struct object_info {
 #define OBJECT_INFO_ALLOW_UNKNOWN_TYPE 2
 /* Do not retry packed storage after checking packed and loose storage */
 #define OBJECT_INFO_QUICK 8
-/* Do not check loose object */
-#define OBJECT_INFO_IGNORE_LOOSE 16
 /*
  * Do not attempt to fetch the object if missing (even if fetch_is_missing is
  * nonzero).
  */
-#define OBJECT_INFO_SKIP_FETCH_OBJECT 32
+#define OBJECT_INFO_SKIP_FETCH_OBJECT 16
 /*
  * This is meant for bulk prefetching of missing blobs in a partial
  * clone. Implies OBJECT_INFO_SKIP_FETCH_OBJECT and OBJECT_INFO_QUICK
-- 
2.39.0.rc1.256.g54fd8350bd-goog

