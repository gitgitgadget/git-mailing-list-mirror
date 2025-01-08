Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D2B202F8E
	for <git@vger.kernel.org>; Wed,  8 Jan 2025 18:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736361486; cv=none; b=F9xKYt6n5bxtlait4TP/2eIQ5h93jk47/x/ayks9EX60eTPoCUP7y+3DyEdL1IaGS4XwIoKPGUm1O8TGcSgHugITtNuvynkoj2mG2HPlljhVfr7WkfvipvTDzQsY4oSKByzgJweFLbSjhzjlZzrZBrU1rG9GSbMhTkhIgwhV1So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736361486; c=relaxed/simple;
	bh=DgBA291+j6ejZVIrtQoPG7txaLVr23L8sLBk2ll5bUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=euOuTabTd8GwoGTge1Va2qQ1YKmtY+GrfyM3wqL6prUC8KIj9zfrFO0F9qM0PQsERFhQyC/+9UFymna6t5LCmt6jKgb/d3gai+zO5mptTDlma/m7NfpDA5JYkUD15lA3UDuULhnevgJIzcYzideBiaPmL7o0oIQ6uZog8f1h9ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZRhzlQF; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZRhzlQF"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6d8fd060e27so1239896d6.1
        for <git@vger.kernel.org>; Wed, 08 Jan 2025 10:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736361484; x=1736966284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nq2fqDypuUUjO63eoWLT+d8CeGIKnq0xPOyYXXa21L0=;
        b=IZRhzlQFb7igf8z/Hi9lKWlU92kKlyGkQGp2tG8h+YlC/HLtkSckciOdGp8zLISfZ4
         BANBeD6qBVpLztU+9K/UESUuiKHCTornRUfxq+V0ZThWrKl1aivjKETUlMqpMtLL9I7Q
         8U7KCqAGJcNoKaCQKWpdMqGY7QVjpIEdOlq8YRCeME9EVgsU/w9U8aJDUfh5ONPel1zt
         kNGFIILbwTO9PhoM2IM9AIrDchxBdLZCqxjBxaHZs3r2LchzpOFeUKCj88vFvdAx4MJq
         v28JKaUYKgoVJ3kXD3mROy51atkudPg/5RCJy03KFVbBdnzex61nCMCHXftujdOjcmpj
         DSMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736361484; x=1736966284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nq2fqDypuUUjO63eoWLT+d8CeGIKnq0xPOyYXXa21L0=;
        b=NPhS8tV9sN9bNoXYqQvG/YeTWrtn7rYcRyUr2C8hIgfpAo4HH3yl3D9dUxucjtHrZx
         TlqnyuQn61A2iLjbxdExtwNJdbcHrxuqEufp05qQ89Ub9HRMoTdQtc2NZTpW55LdRuA9
         3YVZnD3Yg5LbhLxk4w+XQMzQtnMEEKEEYPaO7Od8Hlkuio3UAo3W5IsD5jW7CcsGjWnt
         5PC81ddvfWEU32kod22aCm62Izl2f+kXmFiOuvpP/JrnQjf523jqPuiNeLoc7mGa9GPG
         ocgZYild3+mR6NfVihCJFKZ89TeIcbA5trwD4rsBBK2YCI3FhodZthP0v0GRPyvNgBEA
         lWbg==
X-Gm-Message-State: AOJu0YzZ1dEAgxJdHF6pQ1ZhoWZYFJwe372Z7bZpm+MVLwZR68CqpeFo
	/ChcAhtm/zX4G08QN0J1H97D7u87Tk4ZHHPtn7cWpr3CckHLANJzBPWsznUHRpo=
X-Gm-Gg: ASbGncu9VwiQUqhBstdzALbvdZJ8RnoZUrXpVTwlJ1BNFPhQuA8IvtoIxnba8eii9IS
	OhkDrA9cfDw9NHxIcTuR8PqBXRpwLC1uSZU+MsLbBpbaFrpTPLznSmTiJ1iKOSRcPOXudE1/d8C
	EJg1kSIGC83sjwFTsPPjI8F7SDJAuD9B7BmsESbDAaGykWtA9yeLfngSfCKMBJKMjpgrebHafdQ
	2ro0iylwPR0pkgUDfBsE7B0rCRkslwrLNvOOflYHGi+LLwU9VQv7uNspnNk1DYCMgqj9e20N3I4
	TUneRhwBOQ==
X-Google-Smtp-Source: AGHT+IE+kkXqk1TgZL7iW6VajxLG3Exu6hKhellc/pBHXFm3Qa3JaCDt9KUvV0zZc699rdjU2oyhHQ==
X-Received: by 2002:ad4:5747:0:b0:6d8:8fdd:9797 with SMTP id 6a1803df08f44-6df9b2b1a16mr66386626d6.36.1736361484137;
        Wed, 08 Jan 2025 10:38:04 -0800 (PST)
Received: from localhost.localdomain ([184.148.194.219])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd180ea74bsm193228036d6.25.2025.01.08.10.38.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Jan 2025 10:38:03 -0800 (PST)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	jltobler@gmail.com
Subject: [PATCH v9 6/8] serve: advertise object-info feature
Date: Wed,  8 Jan 2025 13:37:37 -0500
Message-ID: <20250108183740.67022-7-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250108183740.67022-1-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20250108183740.67022-1-eric.peijian@gmail.com>
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

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Eric Ju  <eric.peijian@gmail.com>
---
 serve.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/serve.c b/serve.c
index c8694e3751..7a388d26d9 100644
--- a/serve.c
+++ b/serve.c
@@ -70,7 +70,7 @@ static void session_id_receive(struct repository *r UNUSED,
 	trace2_data_string("transfer", NULL, "client-sid", client_sid);
 }
 
-static int object_info_advertise(struct repository *r, struct strbuf *value UNUSED)
+static int object_info_advertise(struct repository *r, struct strbuf *value)
 {
 	if (advertise_object_info == -1 &&
 	    repo_config_get_bool(r, "transfer.advertiseobjectinfo",
@@ -78,6 +78,8 @@ static int object_info_advertise(struct repository *r, struct strbuf *value UNUS
 		/* disabled by default */
 		advertise_object_info = 0;
 	}
+	if (value && advertise_object_info)
+		strbuf_addstr(value, "size");
 	return advertise_object_info;
 }
 
-- 
2.47.0

