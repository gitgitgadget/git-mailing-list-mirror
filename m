Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F25B222575
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 01:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758071812; cv=none; b=iRd2fvAyvJ9psxg3ZTd+8GXgA8aUpdBlirJeyJkL7VityqJMRIzXvxvy6RIv7XjHjQXTFZAMP7sxQC8HVRqBd+Gnme7BJTWb7Mz7YrsKw8W4Vp+oQliFhO5jhuPVhYXTJfZa/edvGb0nf/dxU3MGt262OrkvsN6W/APWF3FUBOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758071812; c=relaxed/simple;
	bh=XIFd/T9P3W4SYIW3tbtN7SQ7qzcvisV+Sj+xXzE5jqQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=NEOppr396Ce/HLuMyxComvxhYgDr4uHSB1bpSaTRFQADH+QAldq39j3qAdhoU50N9P1yW7gM0g1WBeBi8hfuPTlBswP2SwT6kNKChVbi/joQqEtIW3iq2vRlE22MmSh0BAdbsHGDn8n5HwBrsCkVw8zi/Swxqg4TpYtwTmOZ7v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f/zrxvF/; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/zrxvF/"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-772843b6057so5540106b3a.3
        for <git@vger.kernel.org>; Tue, 16 Sep 2025 18:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758071810; x=1758676610; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=daFRqVrXr4Cg9xLNqhlavnNRAIxyOVKHeOsQcPo5Vx4=;
        b=f/zrxvF/1Ao4DVFGNwc8LuXRbzvJERgLN793vVQiAcWkEEgVCFhbB7V4R8t2HlARkl
         SCcfDY0LpAhppiwExXAAmjnle7hR1S9Q7PExU74bIpFbKhvgoQ2Bkbx4DSGwsxPF4wev
         mQCDnfge4/MUVInwBRzK+rPUgzorqtFGVmEBK9YcV3RZaV3wb56IGcZB9tQTzcJ2vHk0
         Ji0KP96tWd+t6wSsCjnzKGwFBg9gn3HgYclV73U5DhMMjckjNU31msHmUIAcihwqzaAu
         GEf8Ys2K/LI0k/mpoRn7RXxBpIlDn0bpXqBgJqbAW6RBDXlvK9c8lMXxxvKC2725oZ78
         8Eew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758071810; x=1758676610;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=daFRqVrXr4Cg9xLNqhlavnNRAIxyOVKHeOsQcPo5Vx4=;
        b=OGdAeKxjooJHB+CRwuqlS55ezLVqlAijaE4j7P0TMbRgBqFpFPTDpRcnt/iyFoEN+Q
         MODtHeCB4Fmp24+/yBS56AdNbPn8VPJBL/EUkn4sAGjWGA11wSY6i6dFvKk8udPeYfKA
         ajjwJhhYUUxOkGttYTrDSzQTkP4aicT1Ym/fiWcXgHnNnWsCgOtgBp27Ypacg6kGiqvT
         34zkOtYw9lwT3E2a1BLWOMicKolDHrvrAJBk37kb54cCNHRv4Ce+/AlVNSpY7woQqa6e
         GCNU3jmWXuMrNC6oUWqgfdXWTIuCjNz1unv161QI5oswnhxgnqS1jnzxS0hxf+3LVkAw
         5NLw==
X-Gm-Message-State: AOJu0YwEJXvtcVdqEwxNrBzDgnfSxMbEITXP7x97jltm0EpFbb7gKyqY
	Vm8KQyxhS6d8p835F0V6U0mwwNG0TnUQ5WtAatr4+VH9/PG033m5B3AGX5tOFg==
X-Gm-Gg: ASbGncvoIwORSiUS14o1TY7+8WfOqiqXsnXSRc0IIQr9SBAlhYKG0BqVTXNe51r2Jmx
	1+uBirwwHf+OUzL8dYC0EYGrV0379O043Y33JJq/mh4mgkwzU0wyNGYW6Ilcgr0w5vBiqv/QOit
	Gif6m/jATuaKWgP/Dib3b+viOd8kx+Bzni+2zzTGFFJpENOglCV6JQlQXFfeoExOKoKx2i/nYtA
	piRFM3lBunhFJZafhOia/37XzCUsv24e/+0ennrCbuXhVFVten1y2vKM2u7ZFIsY0uE6LJQV8kb
	F2yuIWJcvkoXftNkpTJcwknYbct/65bp4OHv73+IPoKEKUaq6kxQfgo3gjNSJsPNvuyOSwUrfwd
	SGB1zDdVEV3lFin+BWrIzUk74mWg=
X-Google-Smtp-Source: AGHT+IESzz2+Fdoq5VoDKBWWEPZ+UJH2fX88/D/ckY672csXXB+HkPAm/7xknwxFVY54B+WEOc0yaQ==
X-Received: by 2002:a05:6a00:1814:b0:772:2e00:831f with SMTP id d2e1a72fcca58-77bf71cdf71mr398169b3a.4.1758071809864;
        Tue, 16 Sep 2025 18:16:49 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.209.164])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607a4746dsm17375815b3a.29.2025.09.16.18.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 18:16:49 -0700 (PDT)
Message-Id: <cd04ed5aa707e12df51e34c65f5e5d7361179d58.1758071798.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com>
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
	<pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com>
From: "Patrick Steinhardt via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Sep 2025 01:16:28 +0000
Subject: [PATCH v2 08/18] help: report on whether or not Rust is enabled
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Ezekiel Newren <ezekielnewren@gmail.com>,
    Patrick Steinhardt <ps@pks.im>

From: Patrick Steinhardt <ps@pks.im>

We're about to introduce support for Rust into the core of Git, where
some (trivial) subsystems are converted to Rust. These subsystems will
also retain a C implementation though as Rust is not yet mandatory.
Consequently, it now becomes possible for a Git version to have bugs
that are specific to whether or not it is built with Rust support
overall.

Expose information about whether or not Git was built with Rust via our
build info. This means that both `git version --build-options`, but also
`git bugreport` will now expose that bit of information. Hopefully, this
should make it easier for us to discover any Rust-specific issues.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 help.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/help.c b/help.c
index bb20498cfd..5854dd4a7e 100644
--- a/help.c
+++ b/help.c
@@ -791,6 +791,12 @@ void get_version_info(struct strbuf *buf, int show_build_options)
 		strbuf_addf(buf, "shell-path: %s\n", SHELL_PATH);
 		/* NEEDSWORK: also save and output GIT-BUILD_OPTIONS? */
 
+#if defined WITH_RUST
+		strbuf_addstr(buf, "rust: enabled\n");
+#else
+		strbuf_addstr(buf, "rust: disabled\n");
+#endif
+
 		if (fsmonitor_ipc__is_supported())
 			strbuf_addstr(buf, "feature: fsmonitor--daemon\n");
 #if defined LIBCURL_VERSION
-- 
gitgitgadget

