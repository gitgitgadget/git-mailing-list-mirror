Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F44012BE8D
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 21:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709673129; cv=none; b=d952w1nIr4pUu/TqvT+L/dxoasF5K8DqbRHpaCHVsJoK94Cw5HGm6/fVB7kVs34vqnZ2P+ZR6PN0JqCW8kPN2a0a1wJ/qWkvOiNuLASbdPXuzQldCc6TLvCGD4qDY81GcBSJQaptjQOPHe6+634CTtg6zYW7hKzhpME90ELb064=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709673129; c=relaxed/simple;
	bh=eGw1Mrx9b/7kzIPYGp6qBU75e/4E8MOjdZajN+eIoC0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=CtHXTMgu6IQ3gavUR3nwz8Xy8G5gguw5hHNbRxlLqq/GWch84Ywrxa1jfJVxBsIREKHWxvxON322zjjiDrCqXNWMbP18aGJ+72NmdtS6XR+0zuZhgqcNy2PciJcx41LUuwX5opoeyjpyLm3/RzqWjxG+9NaD49ssaUSUTToPo0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HPgnJebj; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HPgnJebj"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-609d8275c70so1347527b3.3
        for <git@vger.kernel.org>; Tue, 05 Mar 2024 13:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709673126; x=1710277926; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vy2896XbLfqkqk469ozluswn4SHbWd5sWCh2CV3cwLY=;
        b=HPgnJebjtibv1d4FO/RuaIbaNA3p7r+JKe3s9OC0zrwuls724FceZaJNaLOC6URbkQ
         9zXtB9VEsFmGlQVXzirMXluQ3MFjNrSpKmCXqJrcAgyE1uYZDVdz4hGgY4rCI1UMiEGL
         p35QLq/FT8eDfM0oXIQTJ2t4BDH2Okq47j2e4hVpjNpdP9m6aXgnKn7n3go81sX6FLmi
         SjK/tCYP0zoWLU6knf6xgBiMk+4nKZYIz/bxynjxpJbzwSTCYcytoNDGHBw1BuVMezIS
         XCOMdugP0RPVHr0ntETo+gczb9znvITNSVDCf61JtxrjLrc9BtC4BIV0Dq6VNHe+SuLM
         feUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709673126; x=1710277926;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vy2896XbLfqkqk469ozluswn4SHbWd5sWCh2CV3cwLY=;
        b=SmG795ITVxAj9z6BE+Z1NNNcNIYNRnEKNz+yuLjidmPyEMcGRyZpE//CfF82BWL/mG
         PtxnfyVVV45sCdDkzy/DltRtDsZ3UjcA+RE7UDfxoTRgPveuTFMBDeS7lcgtK+pGKAPM
         A8sjA0Q3FDM82lE0FN28kFUPQNyAdPiDJFbuE9o80DnIBzB2LP0ddSH/mIrwWQ/XWa9K
         A5BSATHFMZ6pOQbd2XxA7jIavzI/JTJ74B7ZPhwhnynVyPJvnOo3U9P4SVYhHS7uV/d0
         f8n8pUO0FREbIOm1xGrSWLy63APCHTmv33HcOLLOt7UoiboTnjiOGoa71XGTJQ7niIkz
         a5IQ==
X-Gm-Message-State: AOJu0Ywz9MHnQPCLM3QPPiXqo+vadvSZlCD4DYyOQDjapy8KHc+3/+f5
	Os458qFacCxr1CDDeRQ0C1nYigCziiyo/wCEQa31wEmfxAPG/q/2TxvhCUcLbOpdXqd6V2eRR6j
	Uti2njc1wh71OeLPzekYuIWq/ra3ezoiWMF4kKXHJX4fHlYlT1kZ1JWVxCttaU4+BTQzrcK9l7U
	9H1IRDn8It9w6lUt7FeeO3snzmV1woso4kgk50l6U=
X-Google-Smtp-Source: AGHT+IG63BpS8DICNa+Bsqwmx3dV2qQqSNczSvP/Ge48U5eOiu2t09gxW6uBIjdI/0Kf3GEApuR1JU87WHn4Vg==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:f9ac:5d54:eb54:107])
 (user=steadmon job=sendgmr) by 2002:a25:868b:0:b0:dc6:44d4:bee0 with SMTP id
 z11-20020a25868b000000b00dc644d4bee0mr476653ybk.7.1709673126483; Tue, 05 Mar
 2024 13:12:06 -0800 (PST)
Date: Tue,  5 Mar 2024 13:12:00 -0800
In-Reply-To: <cover.1709673020.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1709673020.git.steadmon@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <eef15e3d3da3ca6953fa8bf3ade190da8e68bf46.1709673020.git.steadmon@google.com>
Subject: [PATCH 2/2] fuzz: link fuzz programs with `make all` on Linux
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Since 5e47215080 (fuzz: add basic fuzz testing target., 2018-10-12), we
have compiled object files for the fuzz tests as part of the default
'make all' target. This helps prevent bit-rot in lesser-used parts of
the codebase, by making sure that incompatible changes are caught at
build time.

However, since we never linked the fuzzer executables, this did not
protect us from link-time errors. As of 8b9a42bf48 (fuzz: fix fuzz test
build rules, 2024-01-19), it's now possible to link the fuzzer
executables without using a fuzzing engine and a variety of
compiler-specific (and compiler-version-specific) flags, at least on
Linux. So let's add a platform-specific option in config.mak.uname to
link the executables as part of the default `make all` target.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 Makefile         | 14 +++++++++++---
 config.mak.uname |  1 +
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 4e255c81f2..f74e96d7c2 100644
--- a/Makefile
+++ b/Makefile
@@ -409,6 +409,9 @@ include shared.mak
 # to the "<name>" of the corresponding `compat/fsmonitor/fsm-settings-<name>.c`
 # that implements the `fsm_os_settings__*()` routines.
 #
+# Define LINK_FUZZ_PROGRAMS if you want `make all` to also build the fuzz test
+# programs in oss-fuzz/.
+#
 # === Optional library: libintl ===
 #
 # Define NO_GETTEXT if you don't want Git output to be translated.
@@ -763,9 +766,6 @@ FUZZ_OBJS += oss-fuzz/fuzz-pack-idx.o
 .PHONY: fuzz-objs
 fuzz-objs: $(FUZZ_OBJS)
 
-# Always build fuzz objects even if not testing, to prevent bit-rot.
-all:: $(FUZZ_OBJS)
-
 FUZZ_PROGRAMS += $(patsubst %.o,%,$(filter-out %dummy-cmd-main.o,$(FUZZ_OBJS)))
 
 # Empty...
@@ -2368,6 +2368,14 @@ ifndef NO_TCLTK
 endif
 	$(QUIET_SUBDIR0)templates $(QUIET_SUBDIR1) SHELL_PATH='$(SHELL_PATH_SQ)' PERL_PATH='$(PERL_PATH_SQ)'
 
+# Build fuzz programs if possible, or at least compile the object files; even
+# without the necessary fuzzing support, this prevents bit-rot.
+ifdef LINK_FUZZ_PROGRAMS
+all:: $(FUZZ_PROGRAMS)
+else
+all:: $(FUZZ_OBJS)
+endif
+
 please_set_SHELL_PATH_to_a_more_modern_shell:
 	@$$(:)
 
diff --git a/config.mak.uname b/config.mak.uname
index dacc95172d..6579c36a99 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -68,6 +68,7 @@ ifeq ($(uname_S),Linux)
 	ifneq ($(findstring .el7.,$(uname_R)),)
 		BASIC_CFLAGS += -std=c99
 	endif
+	LINK_FUZZ_PROGRAMS = YesPlease
 endif
 ifeq ($(uname_S),GNU/kFreeBSD)
 	HAVE_ALLOCA_H = YesPlease
-- 
2.44.0.278.ge034bb2e1d-goog

