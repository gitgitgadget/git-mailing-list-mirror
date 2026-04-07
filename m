Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7370C3A6B83
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 11:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775562791; cv=none; b=DRPr8PWyuj70bWu5uPTCPmEKOJSHhgjXNMhMBFUqzWoTVZdrfbD0XHQ7fcFD3TCux6PfcpecfOsYQWY7aBkUY+aJTRLmfnvAJ9t2i8tC0l/9WX0eS1u2anXxxrUs6yeUu0FavvoDksYpSZ6hzZVZMSB7BTYoZq4fO1fTmGvzUM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775562791; c=relaxed/simple;
	bh=hVmAI0tDhz8jEf46dpieGcl9z911r0oJLTIdbrz4Xng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kXLtUxpaRMjX3QAxSJxnlVSPxkuNBOw/hkJxwNV/QJKtVih7fYH9RE0MOFBpjDTgL8zxDtCPVzRRNyOqaGivrOGsa+sBD5dpiQxJ3nHAL4aFTh1g/ukGnbOU+4oJpI9zLdCgEsMwinGDUFJiik1v0YQ8ma4q7v1gncC5TZqsmB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gTzdJbPK; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTzdJbPK"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43cf906b007so2604104f8f.0
        for <git@vger.kernel.org>; Tue, 07 Apr 2026 04:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775562788; x=1776167588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q9LwMGDTe5srAu/izrDXk+9lDvNPSLMDIW31RrS35kA=;
        b=gTzdJbPK1BeVElpMnXBFoSCU5kjIsWeZSmS0xYI/om+rOQ8IiySUizQFPdbd7vxJ4u
         gaTf7vk7bUi/AQ+pPjINVT968OMFGbyjgNT5xXh+RfxIVFRAdOU3fmjMXNcDTENGhMt4
         j+w1ZLEP2XkBwB4+PdZUhAowvY4qSO7AJ0R/ut9h9hCz1aa70yXNkEuMp3uHlTFzSOaK
         VrcMx6Sb7SLsbWc+ffDfvh0cNB2YqCpgrA+G5EGO7lsqrKc1aDeqeN7RJJyKY7hW30un
         iPV5FFmq6mZJaBhubu5amFQY43DcsWAYi4ekM1JocZoEvw59ddXt6uOVhMIVyF8GR6a6
         w8KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775562788; x=1776167588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q9LwMGDTe5srAu/izrDXk+9lDvNPSLMDIW31RrS35kA=;
        b=WTyt0Pp1Ru1zcSwJ1eyW+C8T6U+GmaehUu/dJFSORV7liEzDMXfeq5prjiaBugFlPh
         o8C7UCLAJRyIrdEtkSmV3F3AfLXHdBfrmMSByMsSb4+QDrkQoxE26gJCfgG3rj70KpLM
         UBJwhq87BWP1+cKO4cEJUOalQrPf/UytyAtiLzdsPnvW0Wvuf/ASeDRqKglLFulhZdsi
         g64KqFvGPt14FmCh3xSkZJYBsZfwrFOfqDDzougmEqB1u6nRDeIr5mytr+T63uRlNMrr
         SFFwPsUZUxMmCWPl2HJ9B+DhWOGimzIJ6ZsmkJuSgsbzyWv+y7xdoZCINOTdZOR9bU0G
         IxMg==
X-Gm-Message-State: AOJu0Yykpj1RAwLrcFmx4L1y2e/59ktPJMagmYQDTJyZ2pDqvfftJ7hv
	M2M21Sn9GmOKz0+TcOEHC+jvezv4wT4MOntuKB7Qm5xjMSj3RBWc6DozyOeWpA==
X-Gm-Gg: AeBDievL0Kf41Bk1t8KUC0ccorDvCAlZn/n4QJQnb5bXmM3wouyG41noUqxPZ/FxdmF
	U8vBMjjSvBkxdxaSzMXsgMYk0obgP9yFApavtZViXs/IkGfSITcfvktnTInmBIHlJJJ48hvyeth
	Y0zLH4JHTozbTZmXloyBs+NnQDNPy31XU4UCqjjsuQ22Kgsc/f1lhkxijVndhtPWdb9eewm+mQh
	1e0oSAskO71b+dQpXgZGY4X6kfonX2ZStvd0vL+Uw77qKrTD4NpIvMjS9mpMDsaoGE0Y6d/nhUy
	c3fVPZnUb2qf/uSFnxQM8UrKnxewXkNeVGjmjKzp/CzQrY/TGBZBNl7jYqQWBLFmUzVffxdXxXp
	+Z+0ErfLvcwwyWAvDrtfjFVV59yk4T6o5dZNLsGRtxMIovb0NGcY5LJxbh7Vzp5a8mIyb2E+Lov
	4+PL1VXs6pF209L6LTrZ6vsySQSwaJS8gn61outzBsEBe3IVj0+LZxGKaYxIApHQZIluMugJ4N+
	0hZq+p5w6ozEu3Iy5JanDY1jm678sjQ/lO49aU=
X-Received: by 2002:a05:6000:4020:b0:43c:f4df:923b with SMTP id ffacd0b85a97d-43d292ff5c4mr23911066f8f.50.1775562788332;
        Tue, 07 Apr 2026 04:53:08 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2a6f5bsm45050794f8f.7.2026.04.07.04.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 04:53:07 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 06/10] promisor-remote: refactor has_control_char()
Date: Tue,  7 Apr 2026 13:52:39 +0200
Message-ID: <20260407115243.358642-7-christian.couder@gmail.com>
X-Mailer: git-send-email 2.54.0.rc0.114.g05d466edb8
In-Reply-To: <20260407115243.358642-1-christian.couder@gmail.com>
References: <20260402070613.85934-1-christian.couder@gmail.com>
 <20260407115243.358642-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a future commit we are going to check if some strings contain
control characters, so let's refactor the logic to do that in a new
has_control_char() helper function.

It cleans up the code a bit anyway.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 promisor-remote.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index 5860a3d3f3..d60518f19c 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -642,6 +642,14 @@ static int all_fields_match(struct promisor_info *advertised,
 	return 1;
 }
 
+static bool has_control_char(const char *s)
+{
+	for (const char *c = s; *c; c++)
+		if (iscntrl(*c))
+			return true;
+	return false;
+}
+
 static int should_accept_remote(enum accept_promisor accept,
 				struct promisor_info *advertised,
 				struct string_list *config_info)
@@ -772,18 +780,14 @@ static bool valid_filter(const char *filter, const char *remote_name)
 	return !res;
 }
 
-/* Check that a token doesn't contain any control character */
 static bool valid_token(const char *token, const char *remote_name)
 {
-	const char *c = token;
-
-	for (; *c; c++)
-		if (iscntrl(*c)) {
-			warning(_("invalid token '%s' for remote '%s' "
-				  "will not be stored"),
-				token, remote_name);
-			return false;
-		}
+	if (has_control_char(token)) {
+		warning(_("invalid token '%s' for remote '%s' "
+			  "will not be stored"),
+			token, remote_name);
+		return false;
+	}
 
 	return true;
 }
-- 
2.54.0.rc0.114.g05d466edb8

