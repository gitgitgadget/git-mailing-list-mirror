Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB1B15E5D4
	for <git@vger.kernel.org>; Fri, 12 Sep 2025 12:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757680863; cv=none; b=EbWz6c77Z15kX5vwd5FTA6huyvIzSLgL/XjgYun8DnQCHjKsDJOnHA0+ptWwVEbyUGYv8BLNAAF6rTcga4xv1zQFsUtyoiU5mjIt8Nd0EBphVc1LzoN6FrZ9KZwKM/vRgxB5MVxv56QeO2FM7ze/9Wv7boeb7ogdZFomLZlcwik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757680863; c=relaxed/simple;
	bh=XGXGar1xg14fsrEli0O3b8DpWeuhFPqd4p7bdjAs57w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uZ4Aniz86lLf/r6BrL1rMhy7O9yA3CRieUmhAXAvqnugba+lMAT3BovOs5bN7hzY8Uhtk/RMRd1RGfK5S6D1WCFYzdMqsEDYCi7vTbZ2UgFo4LKx7UM9jiXJsDERiHsvfpIi2FCN7EOR6JygW/NhNGTJTL7bXpUSpgOLoJeJ8jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XvzHRfbv; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XvzHRfbv"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3d3ff4a4d6fso1473337f8f.0
        for <git@vger.kernel.org>; Fri, 12 Sep 2025 05:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757680859; x=1758285659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XwsAKwAN9O8daK4Ll8WEX16UnqjVEohT1rCwW+tHXqY=;
        b=XvzHRfbvO/MW0QByHBw4XDKGvBmAklGx+/CADKzSWYb3fmuNnlMPYBu3KyPGbNbDPJ
         tya0FUSY/wXdVRrjWKPFKDkHk8hcyTVEKyA6s/oAyNgBZyODxnRElSDDAGkz3C6CzZhb
         0h0pz1jRkxKbe0j1RqiybOUEMgigBzcCMxJYuvoJYkf0eGw0qa5+zKXgdtMmSC8iidx7
         /gaaCQH7WatAfLe9X/iR8J9PNtnnmqgV4xLSxBxImoXdCC2UQT2u7ne81e57OqMWRvof
         pI0wrc8EDkfHu9ZccOCgdY9ECXaZdRpHZw62ZUQXp86UQY3uqEkuVdDmZGCQ2VODCMHT
         DNWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757680859; x=1758285659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XwsAKwAN9O8daK4Ll8WEX16UnqjVEohT1rCwW+tHXqY=;
        b=jvoTpD7gvDPtNCfO4uSMH0XW4WmvtBmuV6tFx2i565nuEypk1B2DPVFoIdH39M4q3s
         X0DkNAOFDrscURVP4dqa2O0E0vxj9cqumifWLZ4L39Rb56KxWsSl/ecsHFCkmGVUtUUR
         EHrGl9hyxWZUMm3pqRYtebcf67Bqz20FO7TOtKSW/IEUmsMzldmmjZVrDWOUs1LZSt4a
         78u2H29by4sl6nUZFdtWqmF3zMeCibrJRlu65VRmrx2gAu1cOzcz9Ir+1RblTrYwhPHf
         mbL6tqyp/Zc6T5IAMwQFFnBPvRXR9FkyoI3zN2W83KyuFX6KMPOdRQwXxjmRQ1AxiND9
         7n1A==
X-Gm-Message-State: AOJu0YyVGiKAbR8YaKYBhpSCeYDmASWO2TrOKfNwi98RUyrHHpnEy/6c
	n/yxNrp8r2yyhN/AtM2vK3OMkXIw0KTncpevlgyIn26hlnSd+d5ODSnWNmepaw==
X-Gm-Gg: ASbGncsNxMVR1puHn4b+liJXf9HibDhAmhvP5RdmZmDtzXNGlvhqdUb4Ti4mnQDZKUs
	3FlRlJVPeRcS0CYLCaEISHZX2l7LiLFZecQNbBvB2guMftfJQkrwlIBateFnqbb3O+aExg2sxrK
	bOrQ3oLNCjdVi3H0ynEYhDSQXNyA3gnXkObNC7lt1eBWjdJ0BMl1sAT/PBGjnAJ8xgMw2+tbfML
	2wOmy2v55kPzJ0VX9ZUo56lDTMt0UX/D8MALnZ4DqcmP23vJlKnxXoxCEktpXjkYmNXLaGBLnWD
	SfGmQM/MlE0ZvJWTXmyZX3R0dP26He0TQ7fHKxVrwc0hiQQbRJ2MwRZVgSq2j/2gPBO23TCTTHW
	LIedncG2NQ7pQYke7n2KRVuT8QpPPkGp008hkxfAw8VhxH7s4vFtWhcG6JWBSaZ3leJxdJTDsq1
	6igH1u
X-Google-Smtp-Source: AGHT+IER7HcFsAwMy3ZErixot7lEH9YR9p0Wij/yVEsL+myfiCLtujxb7k27973eTwyXVH0w9eBy+Q==
X-Received: by 2002:a5d:5f96:0:b0:3d0:ef30:d332 with SMTP id ffacd0b85a97d-3e765a4a235mr2921311f8f.46.1757680859463;
        Fri, 12 Sep 2025 05:40:59 -0700 (PDT)
Received: from christian--20230123--2G7D3 (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607d7ff9sm6374075f8f.51.2025.09.12.05.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 05:40:58 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 1/2] gpg-interface: refactor 'enum sign_mode' parsing
Date: Fri, 12 Sep 2025 14:40:41 +0200
Message-ID: <20250912124042.2523683-2-christian.couder@gmail.com>
X-Mailer: git-send-email 2.51.0.195.gf8f8f06677
In-Reply-To: <20250912124042.2523683-1-christian.couder@gmail.com>
References: <20250912124042.2523683-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The definition of 'enum sign_mode' as well as its parsing code are in
"builtin/fast-export.c". This was fine because `git fast-export` was the
only command with '--signed-tags=<mode>' or '--signed-commits=<mode>'
options.

In a following commit, we are going to add a similar option to `git
fast-import`, which will be simpler, easier and cleaner if we can reuse
the 'enum sign_mode' defintion and parsing code.

So let's move that definition and parsing code from
"builtin/fast-export.c" to "gpg-interface.{c,h}".

While at it, let's fix a small indentation issue with the arguments of
parse_opt_sign_mode().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/fast-export.c | 19 +++++--------------
 gpg-interface.c       | 17 +++++++++++++++++
 gpg-interface.h       | 15 +++++++++++++++
 3 files changed, 37 insertions(+), 14 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index c06ee0b213..dc2486f9a8 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -37,8 +37,6 @@ static const char *const fast_export_usage[] = {
 	NULL
 };
 
-enum sign_mode { SIGN_ABORT, SIGN_VERBATIM, SIGN_STRIP, SIGN_WARN_VERBATIM, SIGN_WARN_STRIP };
-
 static int progress;
 static enum sign_mode signed_tag_mode = SIGN_ABORT;
 static enum sign_mode signed_commit_mode = SIGN_STRIP;
@@ -59,23 +57,16 @@ static struct hashmap anonymized_seeds;
 static struct revision_sources revision_sources;
 
 static int parse_opt_sign_mode(const struct option *opt,
-				     const char *arg, int unset)
+			       const char *arg, int unset)
 {
 	enum sign_mode *val = opt->value;
+
 	if (unset)
 		return 0;
-	else if (!strcmp(arg, "abort"))
-		*val = SIGN_ABORT;
-	else if (!strcmp(arg, "verbatim") || !strcmp(arg, "ignore"))
-		*val = SIGN_VERBATIM;
-	else if (!strcmp(arg, "warn-verbatim") || !strcmp(arg, "warn"))
-		*val = SIGN_WARN_VERBATIM;
-	else if (!strcmp(arg, "warn-strip"))
-		*val = SIGN_WARN_STRIP;
-	else if (!strcmp(arg, "strip"))
-		*val = SIGN_STRIP;
-	else
+
+	if (parse_sign_mode(arg, val))
 		return error("Unknown %s mode: %s", opt->long_name, arg);
+
 	return 0;
 }
 
diff --git a/gpg-interface.c b/gpg-interface.c
index 06e7fb5060..2f4f0e32cb 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -1125,3 +1125,20 @@ static int sign_buffer_ssh(struct strbuf *buffer, struct strbuf *signature,
 	FREE_AND_NULL(ssh_signing_key_file);
 	return ret;
 }
+
+int parse_sign_mode(const char *arg, enum sign_mode *mode)
+{
+	if (!strcmp(arg, "abort"))
+		*mode = SIGN_ABORT;
+	else if (!strcmp(arg, "verbatim") || !strcmp(arg, "ignore"))
+		*mode = SIGN_VERBATIM;
+	else if (!strcmp(arg, "warn-verbatim") || !strcmp(arg, "warn"))
+		*mode = SIGN_WARN_VERBATIM;
+	else if (!strcmp(arg, "warn-strip"))
+		*mode = SIGN_WARN_STRIP;
+	else if (!strcmp(arg, "strip"))
+		*mode = SIGN_STRIP;
+	else
+		return -1;
+	return 0;
+}
diff --git a/gpg-interface.h b/gpg-interface.h
index 60ddf8bbfa..50487aa148 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -104,4 +104,19 @@ int check_signature(struct signature_check *sigc,
 void print_signature_buffer(const struct signature_check *sigc,
 			    unsigned flags);
 
+/* Modes for --signed-tags=<mode> and --signed-commits=<mode> options. */
+enum sign_mode {
+	SIGN_ABORT,
+	SIGN_WARN_VERBATIM,
+	SIGN_VERBATIM,
+	SIGN_WARN_STRIP,
+	SIGN_STRIP,
+};
+
+/*
+ * Return 0 if `arg` can be parsed into an `enum sign_mode`. Return -1
+ * otherwise.
+ */
+int parse_sign_mode(const char *arg, enum sign_mode *mode);
+
 #endif
-- 
2.51.0.195.gf8f8f06677

