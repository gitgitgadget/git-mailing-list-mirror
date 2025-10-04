Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC7B223DDA
	for <git@vger.kernel.org>; Sat,  4 Oct 2025 14:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759588962; cv=none; b=O728l/BJoF7G+YFNkyMF1UAjiaFTrDKv8PpvjDTaYYI48Jseq0rHZ9eVb/q/eL5S4BEAmEf4cUywbStqcjGmN0GfWS19pTyr2LI/d85y/vE4O/Hmka4GYwMaELKWiSFmufat8XQjdBU/okxOliYW8ek0fwDPIokx+u89SevC7L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759588962; c=relaxed/simple;
	bh=w9D3k9efVybhw3KejWB9Yr9jFeexYaUzrmNbUettmkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bT0ZRuCJVgHNY/3aH9WJi+WAIv5rge6ct2KTKQGeyTM7pjnyZqu5BJoOOhGF1BuXjzI2Sg0vEjlPl5djS6knxc0egwAayy6JY7/Cf1BKCvATkyemgIaR9Y16RBmDI9xc/ptmhY4YqxeXASdly0DIzsISx9YTDKaeXzcaOI6ob+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=TGNTFWkO; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="TGNTFWkO"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-27eceb38eb1so33160705ad.3
        for <git@vger.kernel.org>; Sat, 04 Oct 2025 07:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1759588960; x=1760193760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GkH0ee2BTav4xUsA15sZ/GLvpRec27BKm9SBk4ND3oM=;
        b=TGNTFWkO8P0/43VGe0F7qOMkaYBf0v+TtlcO2dHkQL9tFSfZdMYTmtGWP1Ar3Hy6Vh
         6acp/mj8u4QUGDLQ1g99BlhMX3VjL05D8SOP6GUYyFEnhocWseltRsSuaWUp+7zAZbJW
         FKgVkt7BE3qZI31eYxUhfJmdW22Ia5Z/wrIny9bYeje/YMnw7WcMNY5EnsCUvU12ronA
         uhYmCr267dNTdAjBlfNxYIO8XBe9cWMCMAzyPwlm8svudpAcXtFZ8jeECwHrTjt2uFa3
         GPGugSj7D/2eeAmxRrd+jdlMbGnT2k1FsKbvzyzijIHwSTUx283+5hcC14l2Z6EG7YeJ
         WBVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759588960; x=1760193760;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GkH0ee2BTav4xUsA15sZ/GLvpRec27BKm9SBk4ND3oM=;
        b=s1SPsYmUhIlSmHomDjL4DIgiyI34W5soVMVEcrX5E6kro6wvfpKH7EpBGfa866pPtU
         iRscpqXW1SjuPlj1RYZEp3tTML4WKVnSY0nyRcQVSBljKT/J/CyIb40RSh9j6a3DN3wg
         kuSDg7Xe4Zc/RtP/mZM5/CZacpLZNf4Zj53lk57lQU4ikdcA+GJmOZKdAXER4VJQLhyb
         rvhwzekeJ0HbqA6xHZQUpP4QzDXN9GEmVXVHdME9U6giyMGj7tc61j2kA6M489bV0c9s
         l4dgjRu3oQuCnis8Td9vvZ8kBF8vOIiDDqEbj0JWzCIXoeg8V6Y+leEFz/JnnIG0UyPV
         1PpQ==
X-Gm-Message-State: AOJu0YyO1otJx6sYkNO+p3dLXpfv9HSXq+Ho1dP0+uWUVA+HWhC9r+IC
	SrOquKzyT7ZrD6EWve2uP+qQk6jogrQZlHoGEk1aplEFiPZcjwa8mo9IrAJjO1lzhUwsEbU+mEV
	7zVDZ
X-Gm-Gg: ASbGnctbTVdw0F5IeszobA846TQ5o8FAEQfprwbnaZrnRO2OSiyLDLIbOTbG9Laer9F
	kUjCZ3q1Xm/DPNzigeRQSgfnElsaLSlSKnnk3Rw21MCy1gh9sSMQ0xvRx/lT+Z0UBG1k+p4e2Hs
	9wdhM6ibKuVc39b3GGu23gTyte4qqqgtOfaeyP1K2y6zVb1mxrNqwjCtbmT0iwsca170P9L33LZ
	yXNm802eFZKh3E8OdMZpDpdbVOEDDUA6e9XBsG4vJTx+zgUGz1OGPDgesdLTI1/aEAQbh+YEU84
	UJevUQX/2IeraKzVC2SQidgWEyWLs+o5vc9UkuQsUpJAeXr0T0ZZ684QZKYX53aNmVr71D81/w0
	9DU00pzcO2kq51Fr1kx6vyrwxlSRbXA2rfA6gsyWRNxupLp5e5CXEW4Evx3NJRhzohXJy4iMhaw
	uUPdrta+511HrNdZoCoLbDZNXB1w==
X-Google-Smtp-Source: AGHT+IEyvXjWgLe1l9AZdNrnYA21hwdkzcR9mGqGzb+ryrhgE8+ps//+3Hp/8z7XTVuqRxdhk+DjuQ==
X-Received: by 2002:a17:902:ebd2:b0:277:9193:f2ca with SMTP id d9443c01a7336-28e9a5135c2mr64486085ad.9.1759588959745;
        Sat, 04 Oct 2025 07:42:39 -0700 (PDT)
Received: from LTY2K703JV.bytedance.net ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1dc00esm80477475ad.117.2025.10.04.07.42.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 04 Oct 2025 07:42:39 -0700 (PDT)
From: Han Young <hanyang.tony@bytedance.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com,
	gitster@pobox.com,
	ps@pks.im,
	Han Young <hanyoung@protonmail.com>,
	Sigma <git@sigma-star.io>
Subject: [PATCH v=2 1/1] files-backend: check symref name before update
Date: Sat,  4 Oct 2025 22:42:23 +0800
Message-ID: <20251004144223.23436-2-hanyang.tony@bytedance.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251004144223.23436-1-hanyang.tony@bytedance.com>
References: <20251004144223.23436-1-hanyang.tony@bytedance.com>
Reply-To: 20251001150805.9652-1-hanyang.tony@bytedance.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Han Young <hanyoung@protonmail.com>

In the ref files backend, the symbolic reference name is not checked
before an update. This could cause reference and lock files to be created
outside the refs/ directory. Validate the reference before adding it to
the ref update transaction.

Reported-by: Sigma <git@sigma-star.io>
Signed-off-by: Han Young <hanyoung@protonmail.com>
---
 refs/files-backend.c | 10 ++++++++++
 t/t7102-reset.sh     |  8 ++++++++
 2 files changed, 18 insertions(+)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index bc3347d18..d47a8c392 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2516,6 +2516,16 @@ static enum ref_transaction_error split_symref_update(struct ref_update *update,
 	struct ref_update *new_update;
 	unsigned int new_flags;
 
+	/*
+	 * Check the referent is valid before adding it to the transaction.
+	 */
+	if (!refname_is_safe(referent)) {
+		strbuf_addf(err,
+			    "reference '%s' appears to be broken",
+			    update->refname);
+		return -1;
+	}
+
 	/*
 	 * First make sure that referent is not already in the
 	 * transaction. This check is O(lg N) in the transaction
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index 0503a64d3..1dc314474 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -634,4 +634,12 @@ test_expect_success 'reset handles --end-of-options' '
 	test_cmp expect actual
 '
 
+test_expect_success 'reset should fail when HEAD is corrupt' '
+	head=$(cat .git/HEAD) &&
+	hex=$(git log -1 --format="%h") &&
+	echo "ref: refs/../foo" > .git/HEAD &&
+	test_must_fail git reset $hex &&
+	echo $head > .git/HEAD
+'
+
 test_done
-- 
2.51.0.373.g2c26b26d9

