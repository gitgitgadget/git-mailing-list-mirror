Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5C631F993
	for <git@vger.kernel.org>; Wed, 27 May 2026 14:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779890926; cv=none; b=hjhiZiKQHQ/M9TlixFSeyRMSRXesxd/lvwhLTfAy/dV6rEYNDDbdh8tiWemYdUAI2QqsmwK26UgCnIIfdFCaUMj/bHRNHCtrr6WXCK2QXeC3jO8YJ9oylA9wqzjUkF6S21RB6PDKhMraVTeIPqsyAHDsSIjqeZtGXBybjbB9CiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779890926; c=relaxed/simple;
	bh=GjOEWrGPrIzjSW78iUZlGqs+oLp0krsw1DRGx0jEkhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lrsgf1qMQKhthafGZ0qFxrXbJbxcX7p/a22C8QPVwnv6ouE6Sk28gCgNlcCkiOxYeI0AIhhcJQsVNRSKW73rPqlMf4zd69vHh0B+tP+crlZgkXC3zShaF5d//xNi7UTPkK1G0l6/JsoigRreqMHr7IFnpE1oFMxQg9cVOV/IRvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fr/b/mzT; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fr/b/mzT"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6870f904c6bso13645362a12.0
        for <git@vger.kernel.org>; Wed, 27 May 2026 07:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779890923; x=1780495723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O4+MqYTX8H+Q3WdFNZMIKwooBRQTqE+CzJ2nJOEPUro=;
        b=Fr/b/mzT3LMD/Ra+Qe3w69o7l7c9frSGqd5V8thaVGPzRQ7GKhulZQRK6N5tadsPBE
         YvPnDe62K/MhqWxNKYBoVgmfw4146Le0WeVO4AwEyXJuTaM6FAqzDMBcNxhhe7Rbg/xf
         /sWSGe9WAyc5eIeN2r96iIpxfgjjvF97hZv3NTEBTLSWQUkdbE11cHmxIaklYuaZgwqC
         634xK+pPgDFIwvpTFEwY/UevdE+EHdWVfVRc8wajTaW781irbaNkNJGfqr7teetJqo1J
         v61lhRgk0feBNHMe0hOfRcQZDyhHpzbtk1YJrjHrY60JJA70EFtfjuDmcKvwoHPLHEOC
         KdZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779890923; x=1780495723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O4+MqYTX8H+Q3WdFNZMIKwooBRQTqE+CzJ2nJOEPUro=;
        b=ErqKyay1SnVRB/YeaOFqnb+8vaTD+HudeyHjov/9jsjJ+a7H54ZYgB7aMmi3rXPVKX
         udDNR+eY8wmFFTM9D3N28p1xgeBJ33fVe/7yZ2rpl2c4ImoGkdPNkYBn9JffG09jUICz
         gy7zJn8Sg56om7SX0gbCmKeF3NhF8yeVs8RP8DnHFXnnOzQg8U1WgTnzIo0nXI94TLb8
         f1Tn5WTORmuPn003ZHBapHRcbHgmLupRctmktvWOJdDauszm8tVSgyl3XbnWFqwzmtcW
         0UkJ8k59gNjQZaA5mZqO3RfbSJkxGo6t+HkdrtDlJbuhs4we85ZpEIlESDgdc+VspU7z
         oLLA==
X-Gm-Message-State: AOJu0YzgSYQGJ5JHlsxOGUkAVmRSSFbD7ThD+GJeJw33i8y5RxY26MWy
	MBNpjUFGE4Zog7LdeLq9z1yKP235GvWTq+sCB1bJJMdrj6YW7DNhfyetrLJ0cA==
X-Gm-Gg: Acq92OHCBY5InP9g7Y4+pHMywnj1Ou6bKcSuqbmRrGLVeWiCljF/7tVwF1+6STWRO21
	Du5tqi1qSkpj5Yx2H+TNgt6rkGk/rLKaN+n6ZYbW059aOtpjG9W6K4BXyUOtz/NxrHdfvbSSSj+
	/J9VPhy9qE2uaoX5dw3RvdpGdHlHR7dEy8AH9fz5ByuLpL/yBMcs9S3e7lAGLSTP0WHHYdClGkA
	Z3Gd1dSYD8ndd3dTSICfrwyvWzdWXFDlPSn02uviDfDlWgkYAbAQkXzsTZYEzGWrEh/S7KiT7eY
	x9FgPfd+r0ncc/DVB70XMief5y82GYo3HP1P9nR5e41QOyxJeC4QTKO5uCFHqhrAEq2iumO4n4n
	O/frxKPrTRUfLBw7M4/g8xFnPx5eoCumPap/7375Cw7p5R6hoNWI5M2zTym+GF79GyCIQ1ynsVS
	nJGDDTmDflMUMD9Yykpe6Dv+rOiO6uoevS3be85cXeEPX0bS/XKHcKmGGZe3DDAMM4puiVkSsMY
	VddFkzV06IbD0O7DOuhcdy3GlV0jdefOEhMTlwKcHQTzvyVtg==
X-Received: by 2002:a17:906:8a64:b0:bda:916b:c87e with SMTP id a640c23a62f3a-bdd28b6f18emr1054688566b.12.1779890922772;
        Wed, 27 May 2026 07:08:42 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-be1ca138bc7sm268122366b.41.2026.05.27.07.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 07:08:42 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Toon Claes <toon@iotcl.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 2/8] urlmatch: change 'allow_globs' arg to bool
Date: Wed, 27 May 2026 16:08:14 +0200
Message-ID: <20260527140820.1438165-3-christian.couder@gmail.com>
X-Mailer: git-send-email 2.54.0.275.g96c817d129.dirty
In-Reply-To: <20260527140820.1438165-1-christian.couder@gmail.com>
References: <20260519153808.494105-1-christian.couder@gmail.com>
 <20260527140820.1438165-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The last argument of url_normalize_1() is `char allow_globs` but it is
used as a boolean, not as a char.

Let's convert it to a `bool`, and while at it convert the two calls to
url_normalize_1() so they pass 'true' or 'false' instead of '1' or '0'.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 urlmatch.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/urlmatch.c b/urlmatch.c
index bf8cce6de9..b2d88a5289 100644
--- a/urlmatch.c
+++ b/urlmatch.c
@@ -112,7 +112,7 @@ static int match_host(const struct url_info *url_info,
 	return (!url_len && !pat_len);
 }
 
-static char *url_normalize_1(const char *url, struct url_info *out_info, char allow_globs)
+static char *url_normalize_1(const char *url, struct url_info *out_info, bool allow_globs)
 {
 	/*
 	 * Normalize NUL-terminated url using the following rules:
@@ -438,7 +438,7 @@ static char *url_normalize_1(const char *url, struct url_info *out_info, char al
 
 char *url_normalize(const char *url, struct url_info *out_info)
 {
-	return url_normalize_1(url, out_info, 0);
+	return url_normalize_1(url, out_info, false);
 }
 
 char *url_parse(const char *url_orig, struct url_info *out_info)
@@ -704,7 +704,7 @@ int urlmatch_config_entry(const char *var, const char *value,
 		struct url_info norm_info;
 
 		config_url = xmemdupz(key, dot - key);
-		norm_url = url_normalize_1(config_url, &norm_info, 1);
+		norm_url = url_normalize_1(config_url, &norm_info, true);
 		if (norm_url)
 			retval = match_urls(url, &norm_info, &matched);
 		else if (collect->fallback_match_fn)
-- 
2.54.0.275.g96c817d129.dirty

