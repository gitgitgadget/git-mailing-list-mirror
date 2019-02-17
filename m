Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03BF91F453
	for <e@80x24.org>; Sun, 17 Feb 2019 10:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbfBQKJ3 (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Feb 2019 05:09:29 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34769 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfBQKJ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Feb 2019 05:09:28 -0500
Received: by mail-pf1-f196.google.com with SMTP id j18so7084594pfe.1
        for <git@vger.kernel.org>; Sun, 17 Feb 2019 02:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=39KRP2jc3b1yxd8B42jdhhA+pN3F9IoxU+JyG5/AIkw=;
        b=iHq/Az1ZKeL5fG39IiDzLpzNINDAUopaN4+HDzinZ6ta3f1zTC57mPgoGO9/kWTcFA
         RN1bc7aT7s90g74ouRe3/tBaHdaGEcTBxpIYafv/G8KOFC4QZFkaMCYuEkYUYqnxeBWz
         c2NNEz0ySdqEJvsJD0+haANwC2M1sv/Aeh8/3SJkYLWQUJL9b8/UHY7DMiqdlU6X5RnC
         6CzpA0jNu1NKSh9XkKcHch0pwhH/ELF9bqLhajUV6VJ38cTwM8iMjaET2+VyebS6PGtp
         D/CFGHR6b9sQfPq+d7CiOYfJ5D7Cq3L3Z1IHJ9lTqXMpkFy/9uDm9HGuBu5WKQd6w17P
         LouA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=39KRP2jc3b1yxd8B42jdhhA+pN3F9IoxU+JyG5/AIkw=;
        b=LaiW7Q3kaKJz9n4y4I6OS/ATpYcidUoComTgyRJ8r0QLcqAW0+P65cfw+9K1nh0GD9
         J/AcdzWyQTO59qUbM5qS2aT8/jNfzbjLhDDxqsyRUg+5xdyAiMnkY3Sx1UG4VflQzGUv
         2WmvDqk3i1WXJL2AQ1Qia7ahQJWbG2VUuEU9VkPu22fIKwFpvS/Sv4i0lASkMEgzFL5D
         7xr8pXaJWGcpp7EKzi6dOLYQ/vigRujzHe2MrJ231QbeSkgw3jVeEi+0s5V0yookLMds
         A1MHrtQRoJEV3j3SB6jnEzdrfR1tFZMAIMrQDBiyKkGRcWK6zPMbQWzt1FGd1ft2NInM
         0Ylw==
X-Gm-Message-State: AHQUAub5Y6LSDJJ+rofA0kl8WuZO2jsVRVsKhEq6xeEtxaDR0ZMCuE92
        sY8BFnJ2KMuGkiyT9hxkKb3aGkA/
X-Google-Smtp-Source: AHgI3IaLd8bCDtVv26+clQkVDPO7IJZas/ltLyydBW8yYL+eG1h6CNCZIpnTTahtmlKV2B9hjdpsRg==
X-Received: by 2002:a62:3888:: with SMTP id f130mr18256108pfa.132.1550398167888;
        Sun, 17 Feb 2019 02:09:27 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id k19sm11174331pfi.126.2019.02.17.02.09.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 02:09:27 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sun, 17 Feb 2019 17:09:23 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 02/31] refs.c: add refs_ref_exists()
Date:   Sun, 17 Feb 2019 17:08:44 +0700
Message-Id: <20190217100913.4127-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc0.328.g0e39304f8d
In-Reply-To: <20190217100913.4127-1-pclouds@gmail.com>
References: <20190217100913.4127-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 142888a40a..b869f32d8b 100644
--- a/refs.c
+++ b/refs.c
@@ -241,9 +241,14 @@ int read_ref(const char *refname, struct object_id *oid)
 	return read_ref_full(refname, RESOLVE_REF_READING, oid, NULL);
 }
 
+static int refs_ref_exists(struct ref_store *refs, const char *refname)
+{
+	return !!refs_resolve_ref_unsafe(refs, refname, RESOLVE_REF_READING, NULL, NULL);
+}
+
 int ref_exists(const char *refname)
 {
-	return !!resolve_ref_unsafe(refname, RESOLVE_REF_READING, NULL, NULL);
+	return refs_ref_exists(get_main_ref_store(the_repository), refname);
 }
 
 static int match_ref_pattern(const char *refname,
-- 
2.21.0.rc0.328.g0e39304f8d

