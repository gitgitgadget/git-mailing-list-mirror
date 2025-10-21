Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE11633C503
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 18:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761071198; cv=none; b=IqLPjWk1v9b+crqRrAc2i0tnIR/lqm2loQ0vzNGQqFh7o67DrlUs/1b3UxIyppWzK43Ye6spaeJnlGl+usDNFX8417gEzzQkDixyfm7QLklivMMdGzUfqkN7oz9ntk4pSy6aRIFTvTc3vozM/lm4iKo4pbsYAC20tOaZzM2ucVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761071198; c=relaxed/simple;
	bh=rhL7z2JuUNObAPJolsKbTI6C1GU/Lgrn+nn1ssbaLoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DBkIWPyygoRRxNlVlkU18HiW3u68tun9fMfcWvg3f2JovXRbodCsyxuZSw4XZ24YUyMitEaSDRG6KerBfWr/kCrnyji49X6vr5X8xHR2TLmBaIpbVeA4zZbSL7Vt7ZxwdVQsI6SnPO6yBwhkJBNxp7gBADZb0kblFbgR2++n6s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ieVcA9lJ; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ieVcA9lJ"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7c28c21aba1so2798243a34.0
        for <git@vger.kernel.org>; Tue, 21 Oct 2025 11:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761071196; x=1761675996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xISjwdtj2GzvnStBEQ4LDObogRyfw+Z5+EIiFS62pTU=;
        b=ieVcA9lJTaovaPu9ployR4n6/WAr2HlPABqxyfe6mlS3XEsbkE1XlstYEJ/CiiZ9jo
         NJwI2xMI5yF7KUcrRlNNAM5cA0mzSDxKsuzhsO3l3pdHqKREn2uqcjdx3FtFjq5wf/o+
         P0IhdNojJypHGJp20mQ0DfSA+/2xqtVbDmNOOJDnjFBi3lkfz2RQgIfOYdp4xmmfLx9z
         NgWwQ0CIFLhSm7A2wRv5wzm+Q2qRLep83wYtJETn30A9ZXvB4ULtW/aHWSEYMqW7TeO4
         4lFcGvQbl9HJZSzRzuFmAn38svg0b0onuwwjpxcqS2Qg7zGtIDiHEEenxzSdYClG2JRc
         PUPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761071196; x=1761675996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xISjwdtj2GzvnStBEQ4LDObogRyfw+Z5+EIiFS62pTU=;
        b=u+2wdxZv7MgEnTJk3xdU4m7JoTgE1Wr9f1gSEk/RTqNcO4XMSV8w1O8gUfQd9i+W2a
         XnrJBMM10JMgRkX+JakPXNYyX54gV7Qb4qnrHGZLNO86lnej/n6AO1WyIJ7/xZ9sD51K
         XciMVcQG1+oTPDdS8pcm8qDCEmiAxOj5qE6u3tJ7qejZKqISkNpmqiFuhG9ZusIJY038
         BF6L6irKcVZpMi82OW0ZVKa+O2IjgcI9YCd6zFknlAw6FYSaQula6vzZAUVv0elFYE41
         rbRRw8s/8h0b1U1FMYbGRD4TGyosVfbx3qcnhFyWEzku6lO0P5X+dckFz15ttGksMTa1
         /+3A==
X-Gm-Message-State: AOJu0YxoGmve2+OzTFw3eBXXTRQevuuzC6AnDWjTpUKyjrNXpK5LtFAO
	aruSIj1pOmXBgMUcA2mr5XdFM4AH0W5Hn54BNgcokSDEvYFRdcLt5OVbx5lYtA==
X-Gm-Gg: ASbGnctDJDyRJeGT/fcfrlC/RNi9vR5AHSRXtDS4uX4tAkxYjMr1rB4sWAELXfQV79/
	bb2BKGIhz/7CEqiq15LTvIksS5Ms3BU8sQSTy+HKKmsRZg0gLkTXrq/hKN4alSn/BRc2JYLnc1/
	5SoQn/Kha1aq4RxHfPe46UzQLU1rek8fp4OTohyUaIZV3ap5z6x7dpm13vQMQClkdeHvycLEPnS
	eGC+8IfnmmWwv+iHOjnKCAOqe+y+0hX7VZR7asTbb2hc6hX96wTszv2PQvmWopn9KAvGuDe5LoR
	O4FryxgG7vhSnnoJkAL7NLLw1BbXkrpIGtLTMUCgvAf16FCRN6Lsn+HV1ywFz6CbX+YwoB4KtpL
	fRAhE3ZWih9QNB9W96Mmiidj5XHa1f3dlwNhtuFpPD+Ki4NL3/V2BfWmA2TiTDr2gpimTGekVnm
	7jfmwL66UDJZu4pVM0Qkg=
X-Google-Smtp-Source: AGHT+IHae5f/GWR5HT7oyIOz0REonGRTSDLE5pNMx+mSLlUgnpznRhGhe0gN0qWAfML838gtuRvSSg==
X-Received: by 2002:a05:6808:14c4:b0:441:8f74:fc4 with SMTP id 5614622812f47-443a31e8287mr8246687b6e.65.1761071195673;
        Tue, 21 Oct 2025 11:26:35 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-443df722e5csm2795853b6e.24.2025.10.21.11.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 11:26:35 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	sunshine@sunshineco.com,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v6 1/7] builtin/repo: rename repo_info() to cmd_repo_info()
Date: Tue, 21 Oct 2025 13:25:55 -0500
Message-ID: <20251021182601.2687284-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b
In-Reply-To: <20251021182601.2687284-1-jltobler@gmail.com>
References: <20251015211213.361797-1-jltobler@gmail.com>
 <20251021182601.2687284-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Subcommand functions are often prefixed with `cmd_` to denote that they
are an entrypoint. Rename repo_info() to cmd_repo_info() accordingly.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/repo.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index bbb0966f2d..eeeab8fbd2 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -136,8 +136,8 @@ static int parse_format_cb(const struct option *opt,
 	return 0;
 }
 
-static int repo_info(int argc, const char **argv, const char *prefix,
-		     struct repository *repo)
+static int cmd_repo_info(int argc, const char **argv, const char *prefix,
+			 struct repository *repo)
 {
 	enum output_format format = FORMAT_KEYVALUE;
 	struct option options[] = {
@@ -161,7 +161,7 @@ int cmd_repo(int argc, const char **argv, const char *prefix,
 {
 	parse_opt_subcommand_fn *fn = NULL;
 	struct option options[] = {
-		OPT_SUBCOMMAND("info", &fn, repo_info),
+		OPT_SUBCOMMAND("info", &fn, cmd_repo_info),
 		OPT_END()
 	};
 
-- 
2.51.0.193.g4975ec3473b

