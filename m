Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC75322F08
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 22:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705443793; cv=none; b=IsPuAubUQcucOGM37yO3L49DpON6DmmtbcDmAWkEYRoBw6ZhymwRQx9T0Rp0Cd/5v45n0NMHQejuHbyXR38sPBkvnZfFh9SxM+LY6cwLfIeuPM/2ijnV7kn04tfwKhP05KvWakZ85ZrvQO/BvumPNfMZbQbAsM3CWzVdcXIr3eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705443793; c=relaxed/simple;
	bh=ImnuNHrbsrT107T+Bd7ds0uNe7oxOlaRuZlomJ9sIz4=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Date:
	 In-Reply-To:Mime-Version:References:X-Mailer:Message-ID:Subject:
	 From:To:Cc:Content-Type; b=a8WB+Mva220qXxIBhtHr5GS4Z7EI+0HFs6YmZa+pBSEtf2RQDotnZP1jZWz4DSxRLAEMAqgHlvzUnmWKpCQrrUJdvLLZSgytZRuwOORQF5I5FeoJXamcPPaUhJ15e7NncRXOY6Lmfzt8hXE9zKQBf2SBDfozX61NwaV3oV3NQ6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fH0BjVJF; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fH0BjVJF"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc22fb24e69so1392621276.1
        for <git@vger.kernel.org>; Tue, 16 Jan 2024 14:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705443791; x=1706048591; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=suYFF98iTNG53g1o8dOdQiTVszv6PhwfTv3JUSySOr4=;
        b=fH0BjVJFMfVXKXSg2ACdJlnmDDM++59gA1N7LjkVkaS/SzZNKACz4Nqzqv2A1h6jqL
         YWLG6ubT51f0c4e2EaiM0NkZKFzgr4JGsrfyJloxx8mqP/TSboE1OAilAa7mQ9/CKaek
         gd9fPhzZo10cZPJzTyfX3eaIZDvwB3kJHLUFZu5gzypf+un4qvn8dKiJtmbSgKpTGZMP
         utb6grcueaMd2FoF69zE5Ij7H8i+uEGNYOz/rDBVqiS7wQdDnMd8ZdYxcjKrYSoxOtrA
         tm5zpybB553Fy3AJMmsA3x4LMo4iO7nH7jR+FJUEcn1M6rBI7f/McviqgnCPzmOxBpam
         axSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705443791; x=1706048591;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=suYFF98iTNG53g1o8dOdQiTVszv6PhwfTv3JUSySOr4=;
        b=e8zWweD2/WPtKPPcNo6G0uZqb5USJBourRf2zDBPptU6a6Ah4GVSnD0VjGgB9x7CY9
         XXNVO0YJdKtllRZEWGfIubq3PPH2xweCUUrH1chVxLubJH9Nk4lStsIYNA8eIpSCrqvQ
         hc2Gl/r88Nt6VzemDDQ50oFx3+SPu1dOdivm3ukDurCftspmgZxnAmWF1LbBDt+Iw3jz
         CHjTFP/sqH8JoVr5vGh1SQGmUaTvSqh4lxvNzB4OJPK6H1JZE9aMNw3qCHna2wGwNlT2
         VQ/yjR2S3d81S4/WGMM3Shuc525tKTG7kzQ27snuYTYi930LdYTZgGCoVUOOWARA13nE
         UYJA==
X-Gm-Message-State: AOJu0YzArLaDtMdCCSmaBGYdN5OjBKPEPZsjErczVse7DdbFctlbtCM+
	L+5fNuuDUjpv5ChAzGXAnhD505AngHIMg1NREpA1xicU9fCdDBcEhAJpPnOpyU0mVp//MzCx24p
	ddhbA8qcPXDFH6kuYqIcBEf9v9B/z1XT1qi4VvVCDTT2CI36qbyPVEVnNe6305L/L5AF2Fw==
X-Google-Smtp-Source: AGHT+IGnmk90OHk/y6A/GxBIzi11gmf2HhFMum+ql/p1cu/Y0w/KLfXKRl+VtRDR/de21B5aHD2JkI5fhIKohA==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:a6f6:5624:1895:86a4])
 (user=steadmon job=sendgmr) by 2002:a25:688e:0:b0:dc2:2ab6:699f with SMTP id
 d136-20020a25688e000000b00dc22ab6699fmr543560ybc.9.1705443790947; Tue, 16 Jan
 2024 14:23:10 -0800 (PST)
Date: Tue, 16 Jan 2024 14:23:01 -0800
In-Reply-To: <cover.1705443632.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1705443632.git.steadmon@google.com>
X-Mailer: git-send-email 2.43.0.381.gb435a96ce8-goog
Message-ID: <c823265f0d6710f99668268ba9ae7092740efbab.1705443632.git.steadmon@google.com>
Subject: [RFC PATCH 4/4] t/Makefile: run unit tests alongside shell tests
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: johannes.schindelin@gmx.de, peff@peff.net, phillip.wood@dunelm.org.uk
Content-Type: text/plain; charset="UTF-8"

From: Jeff King <peff@peff.net>

Add a wrapper script to allow `prove` to run both shell tests and unit
tests from a single invocation. This avoids issues around running prove
twice in CI, as discussed in [1].

Additionally, this moves the unit tests into the main dev workflow, so
that errors can be spotted more quickly.

NEEDS WORK: as discussed in previous commits in this series, there's a
desire to avoid `prove` specifically and (IIUC) unnecessary
fork()/exec()ing in general on Windows. This change adds an extra exec()
for each shell and unit test execution, will that be a problem for
Windows?

[1] https://lore.kernel.org/git/pull.1613.git.1699894837844.gitgitgadget@gmail.com/

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 t/Makefile    |  2 +-
 t/run-test.sh | 13 +++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)
 create mode 100755 t/run-test.sh

diff --git a/t/Makefile b/t/Makefile
index ad57ec0a41..0038a25e33 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -61,7 +61,7 @@ failed:
 	test -z "$$failed" || $(MAKE) $$failed
 
 prove: pre-clean check-chainlint $(TEST_LINT)
-	@echo "*** prove ***"; $(CHAINLINTSUPPRESS) $(PROVE) --exec '$(TEST_SHELL_PATH_SQ)' $(GIT_PROVE_OPTS) $(T) :: $(GIT_TEST_OPTS)
+	@echo "*** prove (shell & unit tests) ***"; $(CHAINLINTSUPPRESS) $(PROVE) --exec ./run-test.sh $(GIT_PROVE_OPTS) $(T) $(UNIT_TESTS) :: $(GIT_TEST_OPTS)
 	$(MAKE) clean-except-prove-cache
 
 $(T):
diff --git a/t/run-test.sh b/t/run-test.sh
new file mode 100755
index 0000000000..c29fef48dc
--- /dev/null
+++ b/t/run-test.sh
@@ -0,0 +1,13 @@
+#!/bin/sh
+
+# A simple wrapper to run shell tests via TEST_SHELL_PATH,
+# or exec unit tests directly.
+
+case "$1" in
+*.sh)
+	exec ${TEST_SHELL_PATH:-/bin/sh} "$@"
+	;;
+*)
+	exec "$@"
+	;;
+esac
-- 
2.43.0.381.gb435a96ce8-goog

