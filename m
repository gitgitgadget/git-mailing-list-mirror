Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE371FECBF
	for <git@vger.kernel.org>; Wed,  5 Feb 2025 18:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738781583; cv=none; b=bZE0gDGP48txoxNYaSYLii2TdpQruxQRVMnyJsm8ImTLfB/IfOOTsqo1A8JT9qBz+dHaCkbEQYXkH9PS80KI3X+JRlBQSeIKHHDPYo9TX4KoQZq1HPKxe7FH/sdQZ/E8WsdB2te1g+L6P4xbgC5R93tH99wU1Aq0tM+5HLoIJRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738781583; c=relaxed/simple;
	bh=auT7Nq8j/Oj7j5e0/1qmYiFTBmU1qvLdasGT5WYJd5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CpZytTZZJMj4y5smFaF0yrGc4dCl94enSTVWpTqnEg38dy7kpvITv3i7BwXb3TM3TLsxS2dGKS/w5Vo85ANPomIMKuwj63U5xsBiKJVdE30qDRu3VtFDPg1Vvz0+RbJr6kfRaz8yUuLfgTmzZ0I8E7D+nOl/fyQyMST7Ztu+4Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2Omn+WP; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2Omn+WP"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21f169e9595so2354325ad.2
        for <git@vger.kernel.org>; Wed, 05 Feb 2025 10:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738781581; x=1739386381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TcvhFf9DLoHV/4B16FqnaOvirPJd2dOTFDpMtuyEBGY=;
        b=h2Omn+WPsTdRuL/MvtP74a5+OMS5gtpds8hs42aIkCZSCTqwPf3wNwtp4K5r1zB7FA
         fdqhDcBv2YhIIgCNv53A8iqdqnMtVAqzQjV0KAdb/FjikPMHEieoeiOXgDnPU2WFl3cB
         z/dUbhHX4JomGJRZNrcMyTkbk8YxYKav0yNSmWvoHtA/ttrEYJZtp20dfqc9toe+lfeh
         E4vN73LVEx39xzxSZ8SFCMljbsbRta9g9Mzlzf2mbK+cASS88/gOga84G6K9nOkGOVs6
         eZFttH4OQKFusTXTHqX3qjarJMjp5n8nK+unBOtDflU4wvIxRVrb3sJoVk3MDlxJCJlw
         RGCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738781581; x=1739386381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TcvhFf9DLoHV/4B16FqnaOvirPJd2dOTFDpMtuyEBGY=;
        b=ay6S7r7zDXgNDxDrTDrhbPi0WyPQ1Nf4tLlymvGSuLiqjSJsyO2ITe8P2zK41bBlji
         FYM+eZb5KK2aHV/v48xTBaJAaUWi6m0ZocD08+wvPAnozLVmIFCOe4ZU4MfkY9zh/FFp
         AzzYXEKdo5GU6TrcWpOnT6CWeUYhtrdOoC2t3ge4nCMPXCg36y33RA4cWI/TFB/YB1xa
         kad/1YOAzdpZU4vvAC9GL7TLEUNvoHcXyXwkl+SDBZIeUee4f0rkhqRG1ZcvUukNiZI+
         da0qwU3ipHloDi4zZ9+RKWvfui3wKdZF2zdXAAPsP94ttV9KM09tnArDJrjioB9MoIBc
         /z5Q==
X-Gm-Message-State: AOJu0YyOsc4voBeoi/1QWfmqCXuPG3uzeVw2OL91C74vqVNTjvtV2DbT
	6KP6BhL9DmNTYTcAL8yh6Ip/S2jGTaS1HV1BSlTHW9nLzRVTNcvpC6Joma4kPZg=
X-Gm-Gg: ASbGncupdIcCMeQfKOQE0ru9CqY3Q5oUsWaf7FvbA99eau2UBBZnPHM3KsjY6eDrwRx
	zf17xX37sq5EYq7mIvSliu/P2nh1GAXBt9n+YV7I+PdfuY4UHUl4Cq07LKAr5sB81epsXe6BH1J
	gV5B7Jz3f6i+WSz+ftsHGAk/o4hHqnCRU90G8wgbpUhUURwfmU60J0GqFi8yCPbfrW8ZT0zVIMz
	t9pT3hwutSVGilSZLV7ZYWEyKrjbwt0IOhMcLpVXkhFdXXYoB5VQZCoUSBHTw7XG+Cm2V45r+JN
	h29Op6jpFQBSinX4+uUDS7wgXAOYolBMgaao9prV
X-Google-Smtp-Source: AGHT+IG1lWe42mACnSh2PfMBmwVwr3vLBy2d3b3HfbvEZJtOTs9B54tE7NZG6QDU2C0rzErX/sFezQ==
X-Received: by 2002:a17:903:292:b0:216:485f:bf90 with SMTP id d9443c01a7336-21f17e70242mr59308895ad.27.1738781580959;
        Wed, 05 Feb 2025 10:53:00 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f1e9f3ebbsm13754285ad.190.2025.02.05.10.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 10:53:00 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org,
	=christian.couder@gmail.com
Cc: gitster@pobox.com,
	Johannes.Schindelin@gmx.de,
	johncai86@gmail.com,
	me@ttaylorr.com,
	phillip.wood@dunelm.org.uk,
	ps@pks.im,
	rsbecker@nexbridge.com,
	sunshine@sunshineco.com,
	usmanakinyemi202@gmail.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 2/6] version: refactor redact_non_printables()
Date: Thu,  6 Feb 2025 00:22:32 +0530
Message-ID: <20250205185246.111447-3-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205185246.111447-1-usmanakinyemi202@gmail.com>
References: <20250124122217.250925-7-usmanakinyemi202@gmail.com>
 <20250205185246.111447-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The git_user_agent_sanitized() function performs some sanitizing to
avoid special characters being sent over the line and possibly messing
up with the protocol or with the parsing on the other side.

Let's extract this sanitizing into a new redact_non_printables() function,
as we will want to reuse it in a following patch.

For now the new redact_non_printables() function is still static as
it's only needed locally.

While at it, let's use strbuf_detach() to explicitly detach the string
contained by the 'buf' strbuf.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 version.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/version.c b/version.c
index 6cfbb8ca56..60df71fd0e 100644
--- a/version.c
+++ b/version.c
@@ -7,6 +7,19 @@
 const char git_version_string[] = GIT_VERSION;
 const char git_built_from_commit_string[] = GIT_BUILT_FROM_COMMIT;
 
+/*
+ * Trim and replace each character with ascii code below 32 or above
+ * 127 (included) using a dot '.' character.
+ */
+static void redact_non_printables(struct strbuf *buf)
+{
+	strbuf_trim(buf);
+	for (size_t i = 0; i < buf->len; i++) {
+		if (!isprint(buf->buf[i]) || buf->buf[i] == ' ')
+			buf->buf[i] = '.';
+	}
+}
+
 const char *git_user_agent(void)
 {
 	static const char *agent = NULL;
@@ -28,12 +41,8 @@ const char *git_user_agent_sanitized(void)
 		struct strbuf buf = STRBUF_INIT;
 
 		strbuf_addstr(&buf, git_user_agent());
-		strbuf_trim(&buf);
-		for (size_t i = 0; i < buf.len; i++) {
-			if (!isprint(buf.buf[i]) || buf.buf[i] == ' ')
-				buf.buf[i] = '.';
-		}
-		agent = buf.buf;
+		redact_non_printables(&buf);
+		agent = strbuf_detach(&buf, NULL);
 	}
 
 	return agent;
-- 
2.48.1

