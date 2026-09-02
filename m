Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840B8377A96
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 16:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788365481; cv=none; b=FFnk5ngV83TsBnD3f2NRqYA6LlZP7XWu7LWiBoJuXiFhJOTVwafjsb2r3axr/qsP+YVPTRVfBCiPLUf1vpwtht/qZyhIU3zdX/kSzmyYm7pH3lF4ftW0G7UK8LMA0vXGEyBV20FiwQ5Qi/twMjraqR9WE+zquKgepyRBTeWKs0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788365481; c=relaxed/simple;
	bh=pBOpOq0Ghv3Bn5e5LAm+RPjXVVUeZJ02/yX7SLy2wpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AZBCJWHWg6+Z7GVqzypFr23J8/U+hwEJvKtt7i14YL667uw8JvvVND/PbDAaA0XxSmWfrCDa5tQifG7FbqUtyfzELTyCeaWsl4nji9bCdyWs3K9f7AN/ulpAGkW5tsK5HH8FDN8pUlaRvgVyvMFsUxg5s25qyyt+VR06N9CyyxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h0acjXf3; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0acjXf3"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49cdc81f40eso8793255e9.2
        for <git@vger.kernel.org>; Wed, 02 Sep 2026 09:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788365477; x=1788970277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h72T+KzqTIOgMByVW/sAoht+np+CLoA7+KeUYsCQNOk=;
        b=h0acjXf35KbMSoYYrd7VEk2aLcWk3Zu3OE3uUPDYFPg2n+t0Ajk9dSdg5KcvlRRiqO
         LG1UjXp4FGxPbig2uUeYLdd+cqtHGSw181rRVtn9jmapt0wJg0xEZhSszxer1UHB5Ld8
         lmKzdC/r0bO82hH7DMGJzXg+Z2Iuskh5WbO3HFro6aGayKHkn6rJqdpp6Y+znldoD2iV
         gWha3faRY1jaNXm/JipzqNghkFLbRnjRglodsnwLQMkrhweRQhIn8/kpgy2yjFS0rTRz
         QiESdDptk3/lDga2Rt6E5hwlTKdsjoIsDb11zyu3BcuriO9q36MVcbXCwQMoSLsZoT6d
         HsvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788365477; x=1788970277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=h72T+KzqTIOgMByVW/sAoht+np+CLoA7+KeUYsCQNOk=;
        b=LAslO6XUdmjL+WshtWdKxOJHObOXZjmpz7xmRG6RSdCIsbPMoX5SEu/FBRG1LLvhHi
         5cuIjnhMoQ5sQrzBiOCaRXpLeaU8JPwMjNA5977YS08J+NAIhPrVkMT2tHtTM9Vd8bXI
         6LXc06EvB2RoK/x0J1t6tM4KdY3WsXmbUTlGrAhzJoBEbH0/wOvqRMM2W1Gr7gzn4QSy
         Q/WCb6MS3KFge4+5+UUMmmhGuKX5iHjFirYbuUfeKqoI53odg42CfZaQJj3/EsYZWfWc
         lt97oXDpVcyt2cUzq4wjffHqV75Rby+zUG/THxjEuAn6vVN1RCElskItcrw6gvDyzjZu
         kYuw==
X-Gm-Message-State: AFuF++k7ZIMWYgRXKwb1HJBP5HrE9UDKwGAefzFypoBI7y3Lsb66JTIo
	+yL/o6HOWBeydMKH6vjqDO6pdYGBOtEZzkOMQvLlwTf2xbCnmUGLtGKbzX+g+Un4
X-Gm-Gg: AR+sD13MPu459S6I596xYXDjGEjfDVkkObVG4lm+sDfROk5AKMtJzDlqPIsEapa4HRD
	KTT4xbVMA0NgwUfPkK8jk/xb/77az0RL4cAWgj8Dbm9nAiXOeJpD5vDxfzFAxreRoie7w1rw1/2
	040zdxAOtPAsOPzr3GurSBbcpIB182DuB2hG8wTKm/4Td5DaWSwhOxCmucCYcpyknUpfdeXAkjo
	lgp0iHYMSO9LPHV8NUSCkqkr0w3Gbk+n6nP2Q7uPqHyR1C47ZS+poG2Q58fhznJk6OgBXd2T4C4
	d5sPoJjNlIVRUn5FSuyd6dgtRScWxxweFoT2LG2pUmc3Wq3Sq9xHFY9XRs+hJF1lHNXHxw95BHF
	xGb/mMNkgMNxkPzphgSJ8ndvK3cCVELqEHBAJv4Crr1UEp6d6ssgTNnqIKJc/9EZpcd//af7qi/
	YEIGYAFb1vzWbSitx6iQZTgAPOT2tRLXn+GkKLPD7KYGYYKlvt8hnZ3aQa94tcqjPB9++m7hSol
	CFGbC6aPWAIsSIFdryGLVs2x3mmjlOwE2VqAdjpibl2o5YEafLKPLQ3s1MlNRZ2PACinmMalaCx
	wl8S6wmHOUsT6xHedzLZzgla4xkuRrlGrbvCh8kS1fKekDYxVdoD7c6qvfhAZHmf9ZalF3jFhaw
	=
X-Received: by 2002:a05:600d:a:b0:49c:e88b:b7ce with SMTP id 5b1f17b1804b1-49ce88bb80emr75703925e9.11.1788365476966;
        Wed, 02 Sep 2026 09:11:16 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce5563c6csm50938075e9.4.2026.09.02.09.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 09:11:15 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Justin Tobler <jltobler@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 2/6] bisect: fix "--" detection when a term name is "--"
Date: Wed,  2 Sep 2026 18:10:43 +0200
Message-ID: <20260902161047.476753-3-christian.couder@gmail.com>
X-Mailer: git-send-email 2.55.0.787.g3f9e2241eb.dirty
In-Reply-To: <20260902161047.476753-1-christian.couder@gmail.com>
References: <20260902161047.476753-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`bisect_start()` walks its arguments twice. The second loop actually
parses the options, and it knows that `--term-good`, `--term-old`,
`--term-bad` and `--term-new` take their value as a separate argument,
so it skips that value.

The first loop, which only looks for the "--" separating revisions from
paths, doesn't know about these options. So when such an option is given
"--" as its value, that "--" is mistaken for the separator and
`has_double_dash` is wrongly set.

This matters because `has_double_dash` makes the second loop die on an
argument that is not a valid revision, instead of treating it as the
first path. So:

  $ git bisect start --term-good -- notarev
  fatal: 'notarev' does not appear to be a valid revision

while the very same command line with any other term name happily takes
"notarev" as a path.

Let's fix this by using early_scan_options(), telling it about the
options taking their value as a separate argument, so that it can skip
those values.

Note: One might argue that accepting a term name that looks like an
option (such as "--") is a misfeature and should be forbidden entirely.
However, whether we should tighten the validation rules for bisect
terms is a separate UI issue that can be dealt with independently. For
now, this commit simply ensures the parser correctly implements the
existing rules.

Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 builtin/bisect.c            | 27 +++++++++++++++++++++------
 t/t6030-bisect-porcelain.sh |  8 ++++++++
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/builtin/bisect.c b/builtin/bisect.c
index 1cfb8a794b..ad089b289f 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -803,6 +803,19 @@ static enum bisect_error bisect_auto_next(struct bisect_terms *terms,
 	return bisect_next(terms, prefix);
 }
 
+/*
+ * The options "git bisect start" accepts. Only the ones taking their
+ * value as a separate argument matter to the scan looking for "--" below,
+ * as their value has to be skipped along with them.
+ */
+static const struct early_scan_option bisect_start_early_options[] = {
+	EARLY_SCAN_SKIP_VALUE("term-good"),
+	EARLY_SCAN_SKIP_VALUE("term-old"),
+	EARLY_SCAN_SKIP_VALUE("term-bad"),
+	EARLY_SCAN_SKIP_VALUE("term-new"),
+	EARLY_SCAN_END()
+};
+
 static enum bisect_error bisect_start(struct bisect_terms *terms, int argc,
 				      const char **argv)
 {
@@ -825,13 +838,15 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, int argc,
 
 	/*
 	 * Check for one bad and then some good revisions
+	 *
+	 * The scan below has to know about the options taking their value
+	 * as a separate argument, or such a value that happens to be "--"
+	 * would be mistaken for the "--" separating revisions from paths.
 	 */
-	for (i = 0; i < argc; i++) {
-		if (!strcmp(argv[i], "--")) {
-			has_double_dash = 1;
-			break;
-		}
-	}
+	i = early_scan_options(argc, argv, bisect_start_early_options,
+			       EARLY_SCAN_STOP_AT_DASHDASH, NULL, NULL);
+	if (i < argc)
+		has_double_dash = 1;
 
 	for (i = 0; i < argc; i++) {
 		const char *arg = argv[i];
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index a7588222a8..464ca53b42 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -1297,6 +1297,14 @@ test_expect_success 'bisect start takes options and revs in any order' '
 	test_cmp expected actual
 '
 
+test_expect_success 'bisect start with "--" as a term name' '
+	git bisect reset &&
+	git bisect start --term-good -- hello &&
+	git bisect terms --term-good >actual &&
+	echo -- >expected &&
+	test_cmp expected actual
+'
+
 # Bisect is started with --term-new and --term-old arguments,
 # then skip. The HEAD should be changed.
 test_expect_success 'bisect skip works with --term*' '
-- 
2.55.0.787.g3f9e2241eb.dirty

