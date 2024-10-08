Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D18A218D95
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 23:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728429589; cv=none; b=NeAXgUQK/gxi3BU/YtK1pVbZtSdGnCP+czyqBmHarvhipsHN8WCgMN6WnyJNOfBk64n5cBT0NC158bWeppSS+8Gss/ke5hVAG6lcwcBFZc2sc9iPmcVP5m3VWK9Krr8PDfXWXqUn6z1UPgdYMQZFjOEBKXUIS3Rw6xWiFkCHVlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728429589; c=relaxed/simple;
	bh=TuAq78OU6knsjT9nouY+PkCmkDf1IBft+fG8fL0vai4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eeFCJs4Eqmnv7x3l/XqnxUvSXXg+gICZuOCnqrmlfQBDxX/gK2p7kg59oQ6CcF8xC5vp7Jy/1GxCzTHfTJeM7Bg8l1Jzku8QSKZ8lpbFVnt3EpvDzb+wZ2AxMDr3nlk3zA68LgLebRbPVGJza0c/mFSn9ZH5bwXUsGk5ywhh9u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y5egI39G; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y5egI39G"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e249fafe1ebso10362762276.2
        for <git@vger.kernel.org>; Tue, 08 Oct 2024 16:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728429587; x=1729034387; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ojv9PmORtHTTAj+ZcCauWaRxsQ7gqK5X5FpuMDe3UEM=;
        b=y5egI39GCt42GgFGij4rJGKv+gxtjg4CiVvbK9YSFu127w86s3FjxiGKqU/EIuRlwN
         YyshMlybWMJq40QdkLnfaCUgwQgPTqUmyOOTBhWAP0oqPXw86BLH34G3FcefzzMXn3jp
         mMSN4e/WGlhYWkTfXQUw4luijOr2aB0CJSGfOrMjTTIe0FEqFaGNvQhrXLi0fyOiAARo
         kBaUndnPsLRWKpNKYOU2K69RN2Oa9tZwj+6M5z2xihk29VJthn1udqesg9ejf6kfPjzA
         TShTtw2nFM3IQWl6px1wRSy/yduclCZ9HtUKfuQgM4mKnX2jaP92fW5Cfd2IwFHpb2k1
         y2NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728429587; x=1729034387;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ojv9PmORtHTTAj+ZcCauWaRxsQ7gqK5X5FpuMDe3UEM=;
        b=HM5yd/abK5rj3mRRKgcylzzxSkCTBq4tB0AmNP+it6IXNGdEaJBNRaeV/VJ15XL3HD
         Y4GdkZlY76aaYW7Xs1qf06+bE31NPjh+91piwF3m/8w8Qhz1PdXxu/P+GYy1S8GdEhyf
         TgnoBpiMsXIVJVunViND/Iobm8yz2UN9TJAv9cyPThrqwoSuEDIUkmWZxmeeLsAUBE4S
         DbQVDSHPohTiwAF6qy4uONfFdVdK4vOENa/1z3WrzLv5wtrBFxFBCD88jDSNjMXm5oah
         nbb7LLGsy0XZK4Eus7/QO4sejLh4AWHEuiZ148ndImT7ukRWJL/9uEn+Xi6sS9BqAFci
         FeQA==
X-Gm-Message-State: AOJu0YxhUQfjCNPqUl9uESszgMaJkAuRxqWX9QIgEeTR1i/QuzWD2kQO
	k1GOX4QpslKdewRgEfxCyE5LfOrG0u7yWq6I68y+r1R9GXyvRKydaZ7f98abNEmWPqxqKqXSN/+
	bgdadymDV9ZvHy5z+nUostYBYoGRQ4WB1bKldLeue1QLMg6q1zHxSrL6CHrKumkHCeczHE51eEv
	vYcBUO8QWpJ7lCNLLN7n3+kz6xNVCaUrjrTyvcg1I=
X-Google-Smtp-Source: AGHT+IEVA4UXeZZJaTsXr6naRASbYs2amOPf68GGFOd3kg8EJudxnRwCF2CyC8MF0kPXQWFEP9/YLyBd4mlWsQ==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:7c00:8752:4498:cc1b])
 (user=steadmon job=sendgmr) by 2002:a25:df41:0:b0:e28:8f62:e735 with SMTP id
 3f1490d57ef6-e28fe44658emr422276.1.1728429586839; Tue, 08 Oct 2024 16:19:46
 -0700 (PDT)
Date: Tue,  8 Oct 2024 16:19:35 -0700
In-Reply-To: <cover.1728429158.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1723054623.git.steadmon@google.com> <cover.1728429158.git.steadmon@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <2ed503216f8e14d7b516c488caf3c76ffcb15697.1728429158.git.steadmon@google.com>
Subject: [PATCH v4 5/5] Makefile: add option to build and test libgit-rs and libgit-rs-sys
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com, spectral@google.com, emilyshaffer@google.com, 
	emrass@google.com, gitster@pobox.com, mh@glandium.org, 
	sandals@crustytoothpaste.net, ps@pks.im, sunshine@sunshineco.com, 
	phillip.wood123@gmail.com, allred.sean@gmail.com
Content-Type: text/plain; charset="UTF-8"

From: Calvin Wan <calvinwan@google.com>

Add libgitrs, libgitrs-sys, libgitrs-test, and libgitrs-sys-test targets
to their respective Makefiles so they can be built and tested without
having to run cargo build/test.

Add environment variable, INCLUDE_LIBGIT_RS, that when set,
automatically builds and tests libgit-rs and libgit-rs-sys when `make
all` is ran.

Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 Makefile   | 16 ++++++++++++++++
 t/Makefile | 16 ++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/Makefile b/Makefile
index abeee01d9e..41ad458aef 100644
--- a/Makefile
+++ b/Makefile
@@ -3870,6 +3870,22 @@ build-unit-tests: $(UNIT_TEST_PROGS)
 unit-tests: $(UNIT_TEST_PROGS) t/helper/test-tool$X
 	$(MAKE) -C t/ unit-tests
 
+.PHONY: libgitrs-sys
+libgitrs-sys:
+	$(QUIET)(\
+		cd contrib/libgit-rs/libgit-sys && \
+		cargo build \
+	)
+.PHONY: libgitrs
+libgitrs:
+	$(QUIET)(\
+		cd contrib/libgit-rs && \
+		cargo build \
+	)
+ifdef INCLUDE_LIBGIT_RS
+all:: libgitrs
+endif
+
 contrib/libgit-rs/libgit-sys/partial_symbol_export.o: contrib/libgit-rs/libgit-sys/public_symbol_export.o libgit.a reftable/libreftable.a xdiff/lib.a
 	$(LD) -r $^ -o $@
 
diff --git a/t/Makefile b/t/Makefile
index b2eb9f770b..066cb5c2b4 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -169,3 +169,19 @@ perf:
 
 .PHONY: pre-clean $(T) aggregate-results clean valgrind perf \
 	check-chainlint clean-chainlint test-chainlint $(UNIT_TESTS)
+
+.PHONY: libgitrs-sys-test
+libgitrs-sys-test:
+	$(QUIET)(\
+		cd ../contrib/libgit-rs/libgit-sys && \
+		cargo test \
+	)
+.PHONY: libgitrs-test
+libgitrs-test:
+	$(QUIET)(\
+		cd ../contrib/libgit-rs && \
+		cargo test \
+	)
+ifdef INCLUDE_LIBGIT_RS
+all:: libgitrs-sys-test libgitrs-test
+endif
-- 
2.47.0.rc0.187.ge670bccf7e-goog

