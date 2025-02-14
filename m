Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2319C263F27
	for <git@vger.kernel.org>; Fri, 14 Feb 2025 12:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739536672; cv=none; b=sYni8oS85KujlICLZxpgP5YrLHTQzmJlZckdsTouDGI9NveOPbzm16hjfgbO7F4sS2TeswscbRGYgZCgsDXQDCnY2+lc9svOjMNibnpUVG/HaNlkADZjSbiqP8L9O9G74T39o2xb/mm19cs4fDVE/UzSrayIGuM9pHYTxgRJKH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739536672; c=relaxed/simple;
	bh=auT7Nq8j/Oj7j5e0/1qmYiFTBmU1qvLdasGT5WYJd5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=atTZF2uW30dQ1uKRqsxuJAxOcj3JZwCDJiygHjmEWCPzZvBb+3LWGMD9dGLv3NKWFsd4C9dWFsOEEGDOpcBEOxQzwqkXZSP4ECBrJsHIO/ypvUFwhoQBbo93kmEUDJlW54FYdKHjUW8oFAeIHkcdO4cWsv6ZvZno03IT9JFT5pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OwjemjRo; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OwjemjRo"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-220d28c215eso26707625ad.1
        for <git@vger.kernel.org>; Fri, 14 Feb 2025 04:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739536669; x=1740141469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TcvhFf9DLoHV/4B16FqnaOvirPJd2dOTFDpMtuyEBGY=;
        b=OwjemjRoDHQuJbNczomAzyblZPTx01nIGVfCT/4WUfCOW9k8A4c0hJoSi0tG79Zy6C
         Sfob61ZYhqHFBLlC57E0XEoI6DtCn7RFk26w1fXZli8zRFzuVjSkC9z3aaMeycPEPvG5
         DxN+7FJcGlZUZEkwVXmYxucZwbfSxX2eCVIecKww/NtxWMjsr2EXtMfoVWJLJZdyk5kI
         3zf6LoWkSeTtnjin+FaQ6BI6VGIMSPiAdohuOZ6wKuxNxHHmZ1hcprZWfW2MqUVhZCsH
         bvRzlkaHjq0bxnVn3HCkLYTp/PeTHQ8fMPAJ6HvuEHCSafabf+zPDsWJBktFwiLr08Ag
         ImDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739536669; x=1740141469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TcvhFf9DLoHV/4B16FqnaOvirPJd2dOTFDpMtuyEBGY=;
        b=RkvsRroAwUIVRDMTkS4HC6/bdcTnUC6h/KYuw3b6rrWnOsWRQa+uzqZFJ8MyuTOypX
         GP9G7ZEj8tBoxV3w36uWPFxGVcmgO2VsBKwEKBYb/LBeqgNdxlEsS4hT338bKyjQg5HN
         ff8unO28oJBY1I+dl+R9MdB8RMNomuMCutSeXheUpxlhuY7kSlZABIx0zSBuD3aPcTx6
         tc2qKORtyaQHPr3M6AQ0Gr0jD+V8W7loEGcHa34q6lZVzXj64+w56h7Yx/BhDPzB33Pn
         v87ANHzQtaiB9QQ5qF1ALTkuC93/EwXgr7c8sVwoUtfzx8GbT0oPCvIPhYaOYFN/cEHI
         t4Hw==
X-Forwarded-Encrypted: i=1; AJvYcCVrT1Kyz5GbN4TFUQ5RXMwr1Qz9KAC8+XH8hx1G2jm3/LXmVu3Yp/tMC8q+sjmd5hXY92k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9TVmDR1q6lexYwHuS/YpXwp3H6O41lXJWvEAOrBkeBjbxATw4
	d0z6AaqeHIm+ar0uXS5AozMpxu4VTLThyoNUBlTqga1jXfEj59Qx
X-Gm-Gg: ASbGncuv6OrFYVGF0qJlo+qh+3APsCFAuI0WyO5QQSjp4BhESPqcdq6UKq5Hez7jH1R
	sZgKGDGekVBXDDY7a0/vtElSHZWnlmnQB8sFs9Qmzcgpe9HGb1/bMJGAo+ed686mwmf8uS5f5F4
	TPrQT+JMNERw1FfE+x7J1+fus0GyTm1qqPfuI4bExxO3ELLLk5/FlDThRfoPQT7E2wJ8l+HQuUZ
	h3Y5X2JuHtAN+ZCkKM13KcazMWzay0w+doGppNvnVueuTHodKvrHo4TbSJvW35vUTAadmAHg/Jd
	a1Pds4sU4abfNv9CKrdz3OxhDdKHQvBbLCEhGSCf
X-Google-Smtp-Source: AGHT+IG7fUA8PD07KgJvDiF57aLbfmUowhYItlcxtoYZ1KyRnxEdXExvyx52+v4Y39zKERdO2h9dew==
X-Received: by 2002:a17:902:db0c:b0:21f:5e9c:c349 with SMTP id d9443c01a7336-220d216b66dmr114637955ad.43.1739536669194;
        Fri, 14 Feb 2025 04:37:49 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545d09esm27814775ad.112.2025.02.14.04.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 04:37:48 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: christian.couder@gmail.com,
	git@vger.kernel.org
Cc: Johannes.Schindelin@gmx.de,
	gitster@pobox.com,
	johncai86@gmail.com,
	me@ttaylorr.com,
	phillip.wood@dunelm.org.uk,
	ps@pks.im,
	rsbecker@nexbridge.com,
	sunshine@sunshineco.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 2/6] version: refactor redact_non_printables()
Date: Fri, 14 Feb 2025 18:06:12 +0530
Message-ID: <20250214123734.1403120-3-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250214123734.1403120-1-usmanakinyemi202@gmail.com>
References: <20250205185246.111447-1-usmanakinyemi202@gmail.com>
 <20250214123734.1403120-1-usmanakinyemi202@gmail.com>
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

