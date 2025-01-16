Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EFF282ED
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 01:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736990730; cv=none; b=BlLwfR9VKf3LUk124zcJmt6MX8Xv5P8nT41Fj9EFUuUaEX96XKTIjOhlOuojyUEuBpCvNYUfpPd1he5FrfCu/QiC3qLek1ny1dBAHr6q1fAeOmMJMLW/ubfpP+jdGTroYpwmtxVR2eKZGDNA2z3kojRVfgYZIP8oZplktHLoBu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736990730; c=relaxed/simple;
	bh=UEn3GRybQ5utchFqJne+waThsBuw/MihnOIEbe2YH+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TQkzIUrTxXdSKzPuR5HsSxwrcveSn7qz02SRqDyQEXj6vCbNGU2ut5D8GQJ8HVZNnv2dzIrDuQCImLKiInuxBzg/t5u7bRpl6zu5yu3l+ifAeLrYQI7ByjJcpOGCns9YZpGrSKFu6zuoufHa162Bl6Hgr1aqSu1N4W0e483ov/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EOVlOKIf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bt76Eadx; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EOVlOKIf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bt76Eadx"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id B3017138027A;
	Wed, 15 Jan 2025 20:25:27 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Wed, 15 Jan 2025 20:25:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1736990727; x=
	1737077127; bh=s34lI+/Ty5hLkGPSj8mEBTUOI9QXGYy8naBuvnH7BWs=; b=E
	OVlOKIfCqaTcbftHaSJ36WVXxmLOWmNL/f9hdv6N/6DQLHK/bCgXfS1mUvAIoxK+
	ZvoF67vOpFinlpmICh2+3aGeo1XP8hcPRqHu0YmiYKa1FY0IHZUGdCPwba6o/tk+
	Ma3mnyHOTjdco+mfd5AGCZxxo66e7zaWumJBjlpULvSW1FgtWokjHStpjQ7jqeMa
	0gHLqwg1Q1KjXWEgSY1iB3BvMbYPQiB3t2Fq8lbTxRKEuurctj6NjfZZOFdJ9yh5
	ayVCy8hp2mJ5H4+Bp4NyHQgI5cP36UmJqqDfSvlvQmQ1/iFPgn5D/+trC9YWUxh7
	IKKhokkQnHT5TK3cT/HfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1736990727; x=1737077127; bh=s
	34lI+/Ty5hLkGPSj8mEBTUOI9QXGYy8naBuvnH7BWs=; b=Bt76EadxqoIx3FGDK
	gDDj49pn37QEMzXTeD799vxrYmiB9wtvJNuu4hVPgZtWkscG0BxsYcLefye77l81
	RYejhrK1KeER7PHbPtXjIa5Iuc+5BoYz+MG0Y6060clbnIS6r1jHXzaxhmCsxU6Q
	i2L3Kpds3g5YWXnYcAdSoB6LMGuWSCXM542XW+Z8VMCy2NQSqKvgSjYWvpGNXEAt
	rxiBpvcgdGFZRb89b5jtNkOlQvlP341l0eyHJlT1rdxKFTi0/WQpc3i5AxlKEi6W
	6g7WDDtvLgFKomfJhkrGaVPIsPth82n9R02H8wopR2ja5ck4+3MmkuTUC34CbvE+
	JZ50A==
X-ME-Sender: <xms:B2CIZ6eTw80YOdv7fWp3KWpWJUttSVzx3AsiEWcTP9_Z-wjYwKTWBA>
    <xme:B2CIZ0ME2IoN5CZIN31_iLADn-vvvsYatw5JsspKsvBL59Xg4WZyZE297Up0a9VeY
    Jdu-Wt9zbiM1I8TLg>
X-ME-Received: <xmr:B2CIZ7ha8jBKMlg-Gz3aRZ3umYkO7GssYsyaZcYi4kdOC1HjRL2OgeMigx55m5yltNmn5i79PQRLnjuhIUU5LAWSVCM6EohKKH5d>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeitddgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedvff
    elhfeutefgkeettdfhudelffduteelfeeiueelhfdvudeiueekhfdtvddukeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepph
    gvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:B2CIZ39cNQuO0GBrSKQhTfzYcPfmK-bvkbyN8rvUS4RGDCyHnp5ZXw>
    <xmx:B2CIZ2tAKlo49rVqJWMFYbzw_7iPyglkJvzY_VKbthAnpH7r6xt0FA>
    <xmx:B2CIZ-EraAfnALFLUPsaZBpR0ybmDbTn7D6q5b3wTmj1MI5T17MwdQ>
    <xmx:B2CIZ1Nm0MKIe480D7hY1Aq_HGvGOeE_d9hvZ-htEMdydqoGxI0RLA>
    <xmx:B2CIZ6LM26N15-XeTZ79q6jbshps6qHtVI4yFp5ythU6E7HBy2y5n9uj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jan 2025 20:25:27 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
Subject: [PATCH v3 1/6] parse-options: add show_usage_help_and_exit_if_asked()
Date: Wed, 15 Jan 2025 17:25:18 -0800
Message-ID: <20250116012524.1557441-2-gitster@pobox.com>
X-Mailer: git-send-email 2.48.1-191-gafe818080f
In-Reply-To: <20250116012524.1557441-1-gitster@pobox.com>
References: <20250116012524.1557441-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Many commands call usage_with_options() when they are asked to give
the help message, but it incorrectly sends the help text to the
standard error stream.  When the user asked for it with "git cmd -h",
the help message is the primary output from the command, hence we
should send it to the standard output stream.

Introduce a helper function that captures the common pattern

	if (argc == 2 && !strcmp(argv[1], "-h"))
		usage_with_options(usage, options);

and replaces it with

	show_usage_help_and_exit_if_asked(argc, argv, usage, options);

to help correct code paths (there are 40 or so of them).

Note that this helper function still exits with status 129, and
t0012 insists on it.  After converting all the mistaken callers of
usage_with_options() to call this new helper, we may want to address
it---the end user is asking us to give the help text, and we are
doing exactly as asked, so there is no reason to exit with non-zero
status.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 parse-options.c | 10 ++++++++++
 parse-options.h |  4 ++++
 2 files changed, 14 insertions(+)

diff --git a/parse-options.c b/parse-options.c
index 33bfba0ed4..8a8b934e67 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -1282,6 +1282,16 @@ void NORETURN usage_with_options(const char * const *usagestr,
 	exit(129);
 }
 
+void show_usage_help_and_exit_if_asked(int ac, const char **av,
+				       const char * const *usagestr,
+				       const struct option *opts)
+{
+	if (ac == 2 && !strcmp(av[1], "-h")) {
+		usage_with_options_internal(NULL, usagestr, opts, 0, 0);
+		exit(129);
+	}
+}
+
 void NORETURN usage_msg_opt(const char *msg,
 		   const char * const *usagestr,
 		   const struct option *options)
diff --git a/parse-options.h b/parse-options.h
index d01361ca97..6af4ee148a 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -402,6 +402,10 @@ int parse_options(int argc, const char **argv, const char *prefix,
 NORETURN void usage_with_options(const char * const *usagestr,
 				 const struct option *options);
 
+void show_usage_help_and_exit_if_asked(int ac, const char **av,
+				      const char * const *usage,
+				      const struct option *options);
+
 NORETURN void usage_msg_opt(const char *msg,
 			    const char * const *usagestr,
 			    const struct option *options);
-- 
2.48.1-191-gafe818080f

