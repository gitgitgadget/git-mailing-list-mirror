Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF2A6F2E8
	for <git@vger.kernel.org>; Fri, 28 Jun 2024 19:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719601545; cv=none; b=FWxAS/QvbGwRkQLQ2MveAq9gY94jF6VQhelqT/HpTRV4noaWt2PYXMW/5c//98aEI0Jps8X3acFtl/WdUq7L9dKBa/l/gpy3xo7gsyCGSbcjXmN302TSS+La8OMDxusCN2AvM0A5+Qe74vMvQmkMfWoYBWCX5dnH199c1Vd/zHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719601545; c=relaxed/simple;
	bh=O6VsDUTpWVpNVuU2q5wW6JpdtaOCprl0QqvqIb07puw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S1xEU0YQ7AamH4uPS42Bo/Mpen1f1UT4xztjCqR12QKAUTUGsPZHz1J8AkLaH/C7SXRasORlP2/fIqILpoRH1ivkVQMS8G3/jbB4MRXZKj3dTvEMQJEb9+WeQHYknd9Qh3k7eqc/bv1jW4ZHNjt0psqL/y6+ZYsyxxJ/UTW0hp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W5a/569r; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5a/569r"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6b4ffc2a7abso7521776d6.1
        for <git@vger.kernel.org>; Fri, 28 Jun 2024 12:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719601542; x=1720206342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X2KD7IszvYFQRGgodF0M1Bc6eIEDIxHrXH2LkimTVYw=;
        b=W5a/569rziBCcFqMPEikpkeq8pa8WoqvhCQEpKkym6yuFZ4sJM7TqAuxmSOMrnVtLN
         wfMrx84fxBPuOPzK5016biuWu6W1JFiXtjBOAwGDU5bjjzIJo2fcDctFHNsfRh6cB0EH
         1KRLFQwsLNEDB22FL3Zh62IGZNVexeMZAPUn3UQYLd5lGEjpHvJFJ2ZUa8NaXV6gD3n9
         QY/NwxlXF9RZ6nVIc+dwZejW+ARaWad3SR7frRGAUP/tY8Ru9Viomq2f+JAyJ88jLhgS
         6jUwVTy1YAkr+/n74jPx7410IQNGcCSa3UvbVo6cnVp3zQo/CIgzwbvRB6YCZTWc3Zwp
         eHFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719601542; x=1720206342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X2KD7IszvYFQRGgodF0M1Bc6eIEDIxHrXH2LkimTVYw=;
        b=J2M5UQO9foTbjPoiFL469LIoGkMrZ+6MgqyzvDj41GwSx8tEoa1vgc7s15hDQHLnPE
         ujhYobFrKhg4c3GdjUnx5gLx1xqCIAm2VnAkSO2Gu5w5h+BG0oAl+gdzMU9RiROepoom
         adQkNxPeF+nB6oYL+CVswCisgUtxSQVqUSWXxY4GLPivLJlkqUWzngHGu7+b2iilOVEt
         Jh9U60t2Dv0cDvJONJZ+yJP/MOLUzMMx2qWsVmCPmri2hqe8ewTz9JswBwNvZhboH99U
         +uAiUXiDVk8vczpQZ2bN4qyPN72mkAUI6J1Ks3TtoeKqgoRC9rpkIF3Sqiw1Gp3l7y/t
         RF6g==
X-Gm-Message-State: AOJu0YzmYk/M/OhWWv1VmboKwaVwyicH0DbW6nAkW7b9dZrs4S94gq8s
	+x6aB8xIVbQGNtPOhpX4kXHzeZ/AATT8YJu3MdpWXhyXBgs/QEWILBmemS5t
X-Google-Smtp-Source: AGHT+IHL3LZ6RwrbtHVsWJRPMgxC0ke+2cFzAyFmp5PZl/9ixBCDW2pqNmYfeKjCiT2pjMSIAa1nKg==
X-Received: by 2002:a05:6214:27ef:b0:6b0:8991:a2f7 with SMTP id 6a1803df08f44-6b5a541c10dmr34354196d6.12.1719601542491;
        Fri, 28 Jun 2024 12:05:42 -0700 (PDT)
Received: from localhost.localdomain ([76.71.94.205])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59e574cc4sm10262346d6.53.2024.06.28.12.05.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 28 Jun 2024 12:05:42 -0700 (PDT)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Calvin Wan <calvinwan@google.com>,
	Jonathan Tan <jonathantanmy@google.com>,
	John Cai <johncai86@gmail.com>,
	Eric Ju <eric.peijian@gmail.com>
Subject: [PATCH 3/6] serve: advertise object-info feature
Date: Fri, 28 Jun 2024 15:05:00 -0400
Message-ID: <20240628190503.67389-4-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240628190503.67389-1-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Calvin Wan <calvinwan@google.com>

In order for a client to know what object-info components a server can
provide, advertise supported object-info features. This will allow a
client to decide whether to query the server for object-info or fetch
as a fallback.

Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Eric Ju  <eric.peijian@gmail.com>
Helped-by: Jonathan Tan <jonathantanmy@google.com>
Helped-by: Christian Couder <chriscool@tuxfamily.org>
---
 serve.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/serve.c b/serve.c
index aa651b73e9..fd42fecc15 100644
--- a/serve.c
+++ b/serve.c
@@ -68,7 +68,7 @@ static void session_id_receive(struct repository *r UNUSED,
 	trace2_data_string("transfer", NULL, "client-sid", client_sid);
 }
 
-static int object_info_advertise(struct repository *r, struct strbuf *value UNUSED)
+static int object_info_advertise(struct repository *r, struct strbuf *value)
 {
 	if (advertise_object_info == -1 &&
 	    repo_config_get_bool(r, "transfer.advertiseobjectinfo",
@@ -76,6 +76,8 @@ static int object_info_advertise(struct repository *r, struct strbuf *value UNUS
 		/* disabled by default */
 		advertise_object_info = 0;
 	}
+	if (value && advertise_object_info)
+		strbuf_addstr(value, "size");
 	return advertise_object_info;
 }
 
-- 
2.45.2

