Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F692F83A5
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 18:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758132888; cv=none; b=D/tD8PU+0gWNsO83FYdp7A1Kl6Q4H0Ni39yU2wKKN0DNNkD8KzqJQAUaJjMWMeD6AXRbtIsJmKlfyHi3i1oEc+OxkuLwVen6f3JPYUVZdUdIp5+o5WV5eS4msD0ID6maUEOp79vAys3GPx9MIpcuLJEsWrX+ekqU24urGHKkwOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758132888; c=relaxed/simple;
	bh=ZSLH+VZXCGstDBgs504oqZObT71/5kRaq5KVEKoUifU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fqRS1V3sXAeuZgX+lHj6cd0u5aBILyj7+LVkWhv44ext13SLoyhf/+hPnXAjOohR5GfF+t0q+IOh43ycN7wJvTJlHrk8/zkYt/c/iZ/OKsJaRAgpoIugGA1h8HtPbZJZEhWqcSjPoabvbZDSqGoaxKlOoQ1hw6iSeCAGXXDGuuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=alcdPvYP; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alcdPvYP"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3ecdf2b1751so17739f8f.0
        for <git@vger.kernel.org>; Wed, 17 Sep 2025 11:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758132884; x=1758737684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AatEYY08t8s6n1tg2gLEUGcUYoZUmrqbspYPbEbBAJw=;
        b=alcdPvYPWLsoNDse2qd1MuPgCWbHe45fWwIsbvFWqhQFSEIgb5lr1CEPpoX38Ylg1D
         Y6b+0cvobEttx+WcNxZQq3Vje5fd6z28glEcpqF8HqvWVgHm2jqso9Ui/jUnBsKNoye2
         sbvj5dGXH9hrd2Mzyx6zxRnZ3yupaUMikQaPM9xLimrw82g+Ti1vcrv1W7/vcwm9l6dP
         6zEM7DsYCXw2th7r8NcBd+eKxp2NP0jzlyzOy54r8gZvy4i+RozRF49JXdYuoZ92ilh9
         CSWN0Dso8zNuKqTy0rkl0QQ8WbuEGCt3SOgQk+OvzIbO0jt7iD6nSnBEVjqYteCiluNj
         Pr7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758132884; x=1758737684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AatEYY08t8s6n1tg2gLEUGcUYoZUmrqbspYPbEbBAJw=;
        b=NWZCFko20I0o9MuwSV2keZiQmNn2Cj36dAI1Y8D3eOMNzZC523dbUBjUfoMcEP1c/p
         xQl9IpPD1bGOgDKM7xOkj3KfSjXRKAwC5Ll9uoOFiUl950b/9vZbn9ilYY/BgvTJVHNi
         YJ35m8tClwi24lMcbQSqnvsF6mFx5aENrch+dI2FyW6/uuJB58Y8ct7HUQ5HeNuFCK+M
         kQAsITjdeRpgXHnEx7eGTYPdrqPQZvExCTZv57mIkC/09mrFG8rlmVwnYZ1txcCL074K
         x1spJc3PLuolh1NMKbNJ0nvE7XS7+E+lPL/LLJ8etINAJbLwgpjcW11m6dp80njXPb6u
         oldw==
X-Gm-Message-State: AOJu0YxB9aAYtQuMPF0HtD3Shv4StmrQ+beuEW8HuH1sqiUHutIYyuMT
	YUuiNNWFPplyClEqofX45nMQ1zq9A7RJYDCov65uwEkh2dOwDf7AnsZj6cZIvA==
X-Gm-Gg: ASbGncv2u+qe0M2TbHuculGXr2+nTm5a8JfMiw0LMFaddH9hlTwIU/2vSX5o2qid9QT
	TyBk+otwMbpfUw7D1v5xfIoKJ2MmraorlP+Nyb9b8ulEARL4Dd8MFDFFtGUQZK+SrLWZ/hCaIVm
	dxw2TX58tWbtM3IbHlcI/E8sinc139E8u8a9KPceeFfl+PbpVUvt5/jHRDL5gVv2dCNzl1qfIGA
	XHwnaoVSUAPWpusGTfnj3DNqeYlf+R6XkT4Ba4msS5TDWAbw3vDBK6R6SNzZK0C3aeUQJTxoJx4
	i37np7n3tGC307LxDqPxtZL1gmyof8NqiL1DOCEjVhLrKggLeP0ep3I5yXGEAXTtvt5NKL0SELS
	obtd34MJZ5yXSmf/bHyaMSZuOpLw6l/gqYmeROsKADRp04gfYdTNNC2D1qRwxT06xPpPYUv20VU
	AU/h2c
X-Google-Smtp-Source: AGHT+IHaOuOhaxWWzvr4CIWu6ERaaKY/mYfwMzJMJI+QmZv+VjJPyXK+bll35Dkvv+qzd5NGvTO68w==
X-Received: by 2002:a05:6000:2207:b0:3ec:db87:fff7 with SMTP id ffacd0b85a97d-3ecdf9d1634mr3283416f8f.26.1758132884525;
        Wed, 17 Sep 2025 11:14:44 -0700 (PDT)
Received: from christian--20230123--2G7D3 (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464eadd7e11sm6956915e9.0.2025.09.17.11.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 11:14:43 -0700 (PDT)
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
Subject: [PATCH v3 1/2] gpg-interface: refactor 'enum sign_mode' parsing
Date: Wed, 17 Sep 2025 20:14:26 +0200
Message-ID: <20250917181427.3193500-2-christian.couder@gmail.com>
X-Mailer: git-send-email 2.51.0.195.ge34f015aea.dirty
In-Reply-To: <20250917181427.3193500-1-christian.couder@gmail.com>
References: <20250912124042.2523683-1-christian.couder@gmail.com>
 <20250917181427.3193500-1-christian.couder@gmail.com>
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
2.51.0.195.ge34f015aea.dirty

