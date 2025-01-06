Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BF619E7EB
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 10:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736159846; cv=none; b=WVh5WCmtxCU1DsIzeLWfLXMAZ6+biGR8GqIdXpiEfDPAb++1Bc1WxzVhwXkirQqhvRT0KGjMbdqLx0o+QGrh+K28ZBC/2kE+5cap+VREK8nEWUb+M3/YFxwsC+Q6WXUQui4Xt6I84/m98ck3kCYoFNDEgpszFQ/GUQJDZk2K1hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736159846; c=relaxed/simple;
	bh=4bfKYyQL8jq4bXVdyRKu2xS4lnHSDoau7SMTXmhJwu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VKExaMwqoveEqcFrbKxnc/9pfQJ4ppcAxTEvhQOy4xP9hV33nnT8SrFGiSuTORoXiU7nhDfSvKNCAX5wuxPr/i5wI/6LbsWVlrDPG6l0q41fTPkFVrRUbsLcQzGeeemRMzOh8ZD+vEfmyS7d0fY88OOdLg4yuCKFwT5iwEP+vFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SoFontv5; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SoFontv5"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2161eb94cceso142388885ad.2
        for <git@vger.kernel.org>; Mon, 06 Jan 2025 02:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736159844; x=1736764644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5FHbSicMzoJx/HMYCpf0z6A+uZyIiYcJHEkn48h7deo=;
        b=SoFontv5D6rTEuzcOXQMQSXwSeY4UEjyy2G2jJHI+g7zxG1SbxpuP+SbOTKRxkAPc2
         Of4ukmXjtDnJjCkYYmW12/8uqSHrDsGe4udGCB9rNY0VzhNri5HrpqrgI5QtubB0Me/E
         0PSi3HVgVgJ1711H6kzNCYMdNF3JRBnvNbspNDEsJvY/umom4wNVCCKZK85/trcpcPah
         sA+/m47RZqN/d70VgXqJ1Yz6kIlghU8wLE3y5SOBsFc4QVcZAURk8uR+W/5Rikh/Pw4h
         hxQbDoZ9db2rXsltiYXAcvWd2RgCAGCUltupGreQ7J5l0Khqm2qFYga4V5KgZB/2NCoY
         bJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736159844; x=1736764644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5FHbSicMzoJx/HMYCpf0z6A+uZyIiYcJHEkn48h7deo=;
        b=LmMlcfrPvlrvex8Nt79/d4IOF94aSPiOuGB5negJK9B8FtvLQXJQgBtOgd1PmBNmgY
         WxsamHPGQ6EeTJCTaX0+AVz6Cp3EvigCVA2YKn9zgQfgdRuWCX5jsicpPeRuMiuvo4my
         Wb0m221zYRgRfo9EzrJJhRofpHtgAPUKLNUIbGW4xBBxN+sq4w0z0qo/1rgSyEzwa/Et
         EZeVRCZdzzQxGMZn2XdYRcSAEH71VVFLFAw9Z+W36ilUo+dQxE9IqLX8WZGboml45pdJ
         w/NVQ1XGIV/Ex2cu7BAM7u7Tw/mttptlRZp/pzA6P07gQ3MYS4LKmk6cQ0LZy584UP1T
         P19w==
X-Gm-Message-State: AOJu0Yw5QjpgY4Xg1CW4rbsezesZLloQrwcCRTqUI5Whtnhfb0j3iES9
	TQkQW8VA660Uw50l4vbXJn2sPqGImLk3zfZegCFWUlVX1kw+DZsh2JeW8kRrwdg=
X-Gm-Gg: ASbGnctJ8OkY4GZB/+j4xHW37hxn6EhZbt+X/Tl0N0pRseCEYkGhnOPwDu/7RkoeZtY
	McK5NwFE9v1XICAf50qV5Cw0t0JdZH2aq4mZiyr73BGfj7pGzbLs9lEHDkAcL+s8oS5UnCb6xGs
	WXdDfH5zuTOr+ogq5i5Ije+9BAFqwziHq16W0BVHonE6QVfTmqkwInXIjBXIPFpCNpboYKJbNe6
	fLnxMoKAd1Zg854fmgI5TuXuTwIdwZO9RaNvtXcjMQaGqSiPqaIvswUShRfjqcplNj64GWN7e+8
	i/d14g==
X-Google-Smtp-Source: AGHT+IE/+KETGJTjEcn65cAgq3H7CQ/jTlbHG3fXeU0VrejXUkT+I9YVlRDubQlsnn5lwiZSziiSIA==
X-Received: by 2002:a17:903:41c3:b0:216:69ca:773b with SMTP id d9443c01a7336-219e6e8c3d6mr871440215ad.5.1736159843678;
        Mon, 06 Jan 2025 02:37:23 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([202.164.41.66])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842b85f00f9sm28774281a12.43.2025.01.06.02.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 02:37:23 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org,
	christian.couder@gmail.com
Cc: gitster@pobox.com,
	ps@pks.im,
	johncai86@gmail.com,
	Johannes.Schindelin@gmx.de,
	me@ttaylorr.com,
	phillip.wood@dunelm.org.uk,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/4] version: refactor redact_non_printables()
Date: Mon,  6 Jan 2025 16:00:49 +0530
Message-ID: <20250106103713.1452035-2-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106103713.1452035-1-usmanakinyemi202@gmail.com>
References: <20250106103713.1452035-1-usmanakinyemi202@gmail.com>
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

While at it, let's also make a few small improvements:
  - use 'size_t' for 'i' instead of 'int',
  - move the declaration of 'i' inside the 'for ( ... )',
  - use strbuf_detach() to explicitly detach the string contained by
    the 'buf' strbuf.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 version.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/version.c b/version.c
index 4d763ab48d..78f025c808 100644
--- a/version.c
+++ b/version.c
@@ -6,6 +6,20 @@
 const char git_version_string[] = GIT_VERSION;
 const char git_built_from_commit_string[] = GIT_BUILT_FROM_COMMIT;
 
+/*
+ * Trim and replace each character with ascii code below 32 or above
+ * 127 (included) using a dot '.' character.
+ * TODO: ensure consecutive non-printable characters are only replaced once
+*/
+static void redact_non_printables(struct strbuf *buf)
+{
+	strbuf_trim(buf);
+	for (size_t i = 0; i < buf->len; i++) {
+		if (buf->buf[i] <= 32 || buf->buf[i] >= 127)
+			buf->buf[i] = '.';
+	}
+}
+
 const char *git_user_agent(void)
 {
 	static const char *agent = NULL;
@@ -27,12 +41,8 @@ const char *git_user_agent_sanitized(void)
 		struct strbuf buf = STRBUF_INIT;
 
 		strbuf_addstr(&buf, git_user_agent());
-		strbuf_trim(&buf);
-		for (size_t i = 0; i < buf.len; i++) {
-			if (buf.buf[i] <= 32 || buf.buf[i] >= 127)
-				buf.buf[i] = '.';
-		}
-		agent = buf.buf;
+		redact_non_printables(&buf);
+		agent = strbuf_detach(&buf, NULL);
 	}
 
 	return agent;
-- 
2.47.1

