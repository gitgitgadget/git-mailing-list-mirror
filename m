Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E901A1FCFE5
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 10:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737110812; cv=none; b=rWrd/9sCng7dyUC6mJtsc9M0YlL8F9ggNgUaPRVHLkDWId01XbPf7JzMb6Vyk8VvQPz3/RXaXQk+Tc3pEQmIn5Fn5Lff10Nn9gfE6kv5GiThBW6jP1PSknmou6JHkNxM4odQxbG0dRujWlhLPLAm6AOjROQ1Cn4Clxf8OXH87pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737110812; c=relaxed/simple;
	bh=2kwipOWVsc1LH7GWNTDmhiwxrVtruFy42dP0QyaWJN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C6Leg8LSyNj+9rn7Dxazc/67aCAC82LxmAEzvUSO6SFgl2cs3vJ4mR2G2sR58YcqBBn09lLE6j8nXnvRVOEqzy8DSU0EnKzWsXQKCUM6JlRSmhAzlRm5WZYO1LUBLwIxlfw3cEV4oPhf+i9L+eyUyDyM3wM1o8V5ph1sf0lDxps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NHbFfMgd; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHbFfMgd"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-215770613dbso25675905ad.2
        for <git@vger.kernel.org>; Fri, 17 Jan 2025 02:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737110810; x=1737715610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQ08D5EYt9fGb8RdvwDS9a4fT7BarcYCl64xsCCFzEg=;
        b=NHbFfMgdYj5l+hiQ/322Q2+rKJ/qHNexMS3b/f6nn8tPycjBdaL65aEGUmOVdt0A0p
         dU0xkV6+chq77gbsefjebXpBzkEUYLdJUfFTAnx7Lmv4kFr5D9dHMsnJnWZPpb8K8TPh
         MKAS+zPJNGkUa/7wvH5FhZgJCMB4gM6ShTVIyXu5/uRj/QtA+N6BqZVB0rfuot/5YpSx
         3ArIxDPmsYUa2reIuYKLs09H9QzwntLmGdchSFmmV2r18ceTQNnEmlCKiDX5cDjbrTnu
         IqmrRTNe2hRkZ+dfZhxLyu4qWZxnpqQV+79GVJvaMa1BXybB1DlqzXbCV9e7bk7oQ2ko
         n5Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737110810; x=1737715610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qQ08D5EYt9fGb8RdvwDS9a4fT7BarcYCl64xsCCFzEg=;
        b=bAme5sEHf4CUwQ/jhLEfoBQ7KRl6+OYpq886AxD+r28Jv3wyIbvQj+YcTD+5PZq4W9
         OTL0Pp1SPCCkLXuA3BRQqDUx5ieHc7gfYHMVDO9+jEZFUAdhiCsTrX0Oy8z8rkl6od7G
         6KCEFxGGRbye/NjGHq6vg8ICQRfqwa+TuIkeOnPcib5iSn2Hep0jTAQNGddbUBd9yYyY
         I9KMB2hLYqqOcQNqxNZCaqJJGMkS3SCcQak1QhKdDJYJbyiiGlUmegvs/u/e8kqGWenU
         KlPQHIjI2sdbsCsD2hoCKybyUGI1t6UgcnDv/0UXSe1UsY7Y+tPN7d6im5NMz2l9Ey2N
         al/Q==
X-Gm-Message-State: AOJu0YzZqNzSAKCKLz5vN3dTS1zeXhV8NzwIZKNH8pqkVCmf9MCuL0wB
	7mzM1N+r2cKpLQFnxn0kIxbCEGef/WGcUBGSU/09uKFPf6Q0oE1QK3AH9h1DWes=
X-Gm-Gg: ASbGncvgwJCJrzrc42icQh7qYvPsum4xdxYlEmu3yuU1mfamY9dyQzPbZeE6P/wbo4o
	R3M3w5uKoDJSVrYStF3ptRRFk7yZ2+2o69ERhBUvtbuEkFUvDPmSHtykHCJTS5B5kruexxIOu1v
	2C4CENZtAH7haoSULMV2ISkQT0Es5X6KazxBFdAXfi+ly9S1oE5c5jHyFCRAUU70cV/+zzb2snl
	IMDpFxBA9XdBhaqUlydGbo7mQHcJBxK7ZR38qSO64LfS9DG27Sn8TwRy+Sm0HkgJ7c087bcgyA6
	bjeKYg==
X-Google-Smtp-Source: AGHT+IGgNl+TmCh5IpiSmH5mOQ4N2rSPOuj6PZ1/zcMAd8FD2I9AUZpuEeL/W3Att3i9Nbj7eAZhcg==
X-Received: by 2002:a05:6a00:2917:b0:725:b201:2362 with SMTP id d2e1a72fcca58-72dafa409b5mr3663161b3a.11.1737110809916;
        Fri, 17 Jan 2025 02:46:49 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([202.164.41.66])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72daba48eb8sm1574985b3a.136.2025.01.17.02.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 02:46:49 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org,
	christian.couder@gmail.com
Cc: gitster@pobox.com,
	ps@pks.im,
	johncai86@gmail.com,
	Johannes.Schindelin@gmx.de,
	me@ttaylorr.com,
	phillip.wood@dunelm.org.uk,
	sunshine@sunshineco.com,
	rsbecker@nexbridge.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 1/6] version: refactor redact_non_printables()
Date: Fri, 17 Jan 2025 16:16:13 +0530
Message-ID: <20250117104639.65608-2-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250117104639.65608-1-usmanakinyemi202@gmail.com>
References: <20250106103713.1452035-1-usmanakinyemi202@gmail.com>
 <20250117104639.65608-1-usmanakinyemi202@gmail.com>
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
2.48.0

