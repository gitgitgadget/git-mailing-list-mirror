Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05301C5D76
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 22:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741039282; cv=none; b=jrRwisd62UXCFp3Zxdqbif0G/uamoES2tAfrO77mbxvWRrY0TcXEQWwyw4+9Oa1WYEZunAbkvP0UsxPBasPlvFKKscxJaJULoFedCdhQnWNmGpfH3/BQRglPKPBGC42osbOz7bN4VriWoYFMN8u3bbcD+6/tHb7MNpalkrfpSbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741039282; c=relaxed/simple;
	bh=FIt5Rma8Ddosq3geQdgFOFfHgIQc+emsR2js9AGorRo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eWtX1F33m5KYQTzH449cuuVgW3fpZiYQ2Z54Bljs6HtRcrNDQEDJzTPysqfZ4NGw8L2nO0cjgTn7fxcmycsFdEHLejMGKRxkN4MepZ8+Q7sV9hIFqdavmAgz9fhp2+gNgrS6rn/Juoavy29QLIOkNBEiZhyC0XAXd94Hgp1q/4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZj61Q7S; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZj61Q7S"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22337bc9ac3so94248165ad.1
        for <git@vger.kernel.org>; Mon, 03 Mar 2025 14:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741039279; x=1741644079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1NoC3TVZQIV70pMT6wG4GaGvTXkiZ/B6lTfMypKM9ek=;
        b=QZj61Q7SijnvCEDmQjbHwoVuPEFivTL/SfFwTQ7rJRu4/yjd0bEouFMLwT3CeA+G3r
         7H7HiVGXg3m2EJEtWY9SnLrY4kI7A7rdfBBpVQNwxZlUxng7EN2mCuoAEYz9jSxWlfPf
         0Ka1N2l2rj+CtYutq8AxMgNiMnsOVXSEWS8O71xjiKf+IoUGCtGOeP3CXUWMJl+OPuoD
         JRQvC0Un7BANvSN6BuR1+ZkzQIOArU4Hw1C9saSk+wppBncVaQ5/6+a/9qUIn9idoGcs
         uKPDNZGxIiNp2fMv3GOhzrGGjmrS2bjILcKizthH6A4+erddIFI33JM/2UcAhop4GJ8I
         pfXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741039279; x=1741644079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1NoC3TVZQIV70pMT6wG4GaGvTXkiZ/B6lTfMypKM9ek=;
        b=naadlhwpa0xuaiRBKX5RGThWz9DKwHDkQNfxK1SWeUxBD9VqkF2tqaiP9JZ5G0X/Fj
         GWj+sG4+q9TeA8aqh7vko2gpts1+/t9TOdV+XfYT2H/wtJthKoVTgDjyKH0sNsjzIFM1
         3PGHIAcueXJxaoW88Lw3t2dlwSDG7tL827W+/1G7fNAlbkh3ooS17ikVut80SqkgXbZ6
         IosYGW55SL5wqIoyz5edqCF2q+ha1+isS4jXuUAox6L+XZB/f83wMfdEB8MKd+FzKuzt
         2hsYy/P6trft0OL8KFeBDmfxl/wax71GhrqqwSXURn3uCdJLd4nLSxQQGDiwGWQRAlg5
         8+ZA==
X-Gm-Message-State: AOJu0YzQZOQW4OisgL6GIL0gojO2i6m55CufWLi+aSDLWCbffqHTzx+E
	wsjZ4ZkVB6XURbA+F3bpY4DE57Hb+sQ5wvqXsr/cDDfisiR4EgORHJxaLQ==
X-Gm-Gg: ASbGnctZEt0qvij74Fi0u4oK9ImsDyJ0+tg7vuEm/hgTLkoci+/GDO2r73amf0pM1TL
	b7r6XWYIfqqdeYGWzsfg/aK4AhBScUzhfIrpCrea7cRSkEbJk6nU5RGDCrbvSSf4VEnriHgBn0b
	cJaAXbT02aQsAeSTmV3xJ+3xtUuBXleGvUSzyZMkAaitmmSm4MRZQkoV1TV2hMIwKI+TKnJoOEu
	ydJiSZMpXuaC6AQ/Ny/z3OBdkK9qtxgU/qezmaA6f0ar/5pv8b2iObc0kXieFp8HqomAGuVblV9
	n991IcIpaMPJtf1T4xli+D2av7IMfKvLwH7mwF9BRtZIAC6uJzJziGq4yaYokWFbhdGGvHV8imQ
	zn7Skx0Py9g==
X-Google-Smtp-Source: AGHT+IGSYK3fC56k4u8objD8LlBP0C8mUOoA8IYPOol+VQxgQnTFmP4OgE50Gz01tWDEF4QnWV5Iew==
X-Received: by 2002:a17:903:17c8:b0:223:49cb:5eaa with SMTP id d9443c01a7336-22369213d6fmr229383595ad.35.1741039278905;
        Mon, 03 Mar 2025 14:01:18 -0800 (PST)
Received: from localhost.localdomain ([2804:7f0:b77d:283:5dd5:8e9e:2c56:864a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504dc7e1sm82746565ad.176.2025.03.03.14.01.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 03 Mar 2025 14:01:18 -0800 (PST)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC][RFC PATCH 1/6] builtin/log: add subject-extra-prefix flag to format-patch
Date: Mon,  3 Mar 2025 19:00:24 -0300
Message-Id: <20250303220029.10716-2-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250303220029.10716-1-lucasseikioshiro@gmail.com>
References: <20250303220029.10716-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new flag --subject-extra-prefix to format-patch. This flag is
primarily targeted for new contributors that send emails with the suject
starting with "[Newbie]", "[FirstTimer]" or "[Newcomer]" and developers
from mentoring programs, which may start the subject with "[GSoC]",
"[Outreachy]" or similar.

Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 builtin/log.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/builtin/log.c b/builtin/log.c
index e41f88945e..95667c93ca 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -2036,6 +2036,7 @@ int cmd_format_patch(int argc,
 	struct strbuf rdiff2 = STRBUF_INIT;
 	struct strbuf rdiff_title = STRBUF_INIT;
 	const char *rfc = NULL;
+	const char *extra_prefix = NULL;
 	int creation_factor = -1;
 	const char *signature = git_version_string;
 	char *signature_to_free = NULL;
@@ -2079,6 +2080,9 @@ int cmd_format_patch(int argc,
 		OPT_CALLBACK_F(0, "subject-prefix", &cfg, N_("prefix"),
 			    N_("use [<prefix>] instead of [PATCH]"),
 			    PARSE_OPT_NONEG, subject_prefix_callback),
+		OPT_STRING(0, "subject-extra-prefix", &extra_prefix,
+			   N_("subject-extra-prefix"),
+			   N_("add an extra prefix at the beginning of the subject")),
 		OPT_CALLBACK_F('o', "output-directory", &output_directory,
 			    N_("dir"), N_("store resulting files in <dir>"),
 			    PARSE_OPT_NONEG, output_directory_callback),
-- 
2.39.5 (Apple Git-154)

