Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6717BAF1
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 14:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706710867; cv=none; b=s2k6PIdueMZfw6E8VDdzpEBTow8fVrAkJTTpMzvQj2/po9+Vi1e1aofw9FhKjQGkf14NjrZTqrTVuve6As3UY3B+M6KL2pkehWsPcfAA5PgJh6aMmRK+kYQgFgyq0yzYpyvTuBSQxaoTXeNWRroi4HOFEwgD2RneGPSbs66b3Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706710867; c=relaxed/simple;
	bh=woUfjoT+/7SITwjodU7Snnn9kj4ZUet81jdIZuhOP2Q=;
	h=Message-ID:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=N4lz4og9AgC79n39AJ7u1YBQNvIUtK+9qwao/ANHw1Ge+MKQwxSXIeomRt996RoPpRRvrFCRL+wq9ACkh/7qhvmFJb/OGzt9g1e6hMUvg2x7M0EkzEFwapwA48n4E+MmH7dEoKbE/+xQyac74ZDXYXsrRXtzueUvEn7GxWkKPKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TjvGMa26; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjvGMa26"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5110fae7af5so4132585e87.0
        for <git@vger.kernel.org>; Wed, 31 Jan 2024 06:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706710863; x=1707315663; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IkbNhVWhyIvkTtqsjJHdqsZSvh6zJfs3btdqt+OOup8=;
        b=TjvGMa26YDezCpzWgYWEbLB+pP7vFndNPxUphxUiZPiex3o5yq/MyGC2rdjwb0RL13
         ydHuoZVfEb3suTn7EPZEfefycG6z4CWewWMpjmxS7vaGVDo4WyD9dSo/R0hJVCN0f1Of
         qzuhz3TpBmeB/fMYrhSI81uprqUDf08kz1TFoB2Lq+0/eKZ0c4nFP/jyCuVrK6tHAM+W
         5PrwqGWXFLCnlQGnmI/UZJfzpTrcEQDd1izINEsGcUK2UuCUdxGrCom00bQ1+/HxymZ6
         QHsF49Jsd+qHR7b8bultzfvIvb8NpnR0OixfmZBvbZcBc2Rr2SAEU7vQXO2O0lasrrX3
         H2YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706710863; x=1707315663;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IkbNhVWhyIvkTtqsjJHdqsZSvh6zJfs3btdqt+OOup8=;
        b=U6nvB8MFD62Ewl6IegCCigb/5gb3LdjVyw9pwko+FgO1G8lrGJdwMc8FrLYaqiTVzb
         B32SFJ4WEZhP+PxI8CjmvksMHVJRgqa4BrXKAaL/dJ7dr7VTXuEPSuS5xcQF39fC47hP
         VA3ITdsZfc0+ayRf32Vj+7K5rnvDb/6C6OmzSvPUIBWnAinOtpYnbuKd3MmAa8Y2X+sR
         cDAllNTXARGjqdireZZHFdm6toZs4IaIShyZCKjeLMejmta5K5WxGjbf3pMp5vBTk44U
         u7GObc6KhOwhfVYCmjvHX7GTaE0xEG5sxAwAJoFZgNXeTJSAGVR9ZsnlcE3/1PXn6pIc
         7M1g==
X-Gm-Message-State: AOJu0Yzot4Rv8IbEXmfUYziTxX49+3AWzQc5+00jty7EGH9cezhMLUwt
	72q2SpQCrj5QiKhPtWUD6OO1TFzUXKqNcfzqr4/skPtAojMmJzWQiPCbNNv/
X-Google-Smtp-Source: AGHT+IGf7Wlgj9QlAKlhrlsBf4jmctToA0e4pVjaWcFnnL1uyTIfJLX0MfWNsrQfPvaj/t4JAUk8gQ==
X-Received: by 2002:ac2:4d0f:0:b0:510:1625:fec0 with SMTP id r15-20020ac24d0f000000b005101625fec0mr1353887lfi.58.1706710862883;
        Wed, 31 Jan 2024 06:21:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p23-20020a05600c1d9700b0040e9d507424sm1801003wms.5.2024.01.31.06.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 06:21:02 -0800 (PST)
Message-ID: <pull.1663.git.git.1706710861778.gitgitgadget@gmail.com>
From: "Haritha  via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 31 Jan 2024 14:21:01 +0000
Subject: [PATCH] This PR enables a successful git build on z/OS.
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
Cc: Haritha  <harithamma.d@ibm.com>,
    Haritha D <harithamma.d@ibm.com>

From: Haritha D <harithamma.d@ibm.com>

Since the z/OS linker does not support searching dynamic libraries,
and the current setting of CC_LD_DYNPATH results in a directory
to be supplied to the link step with no option as the suffix,
it causes a linker error because the z/OS LD linker
does not accept directories as input.
Therefore, we workaround this by adding the -L option.
And, Introduced z/OS (OS/390) as a platform in config.mak.uname

Signed-off-by: Haritha D <harithamma.d@ibm.com>
---
    This PR enables a successful git build on z/OS.
    
    Since the z/OS linker does not support searching dynamic libraries, and
    the current setting of CC_LD_DYNPATH results in a directory to be
    supplied to the link step with no option as the suffix, it causes a
    linker error because the z/OS LD linker does not accept directories as
    input. Therefore, we workaround this by adding the -L option. And,
    Introduced z/OS (OS/390) as a platform in config.mak.uname

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1663%2FHarithaIBM%2Fzos-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1663/HarithaIBM/zos-v1
Pull-Request: https://github.com/git/git/pull/1663

 config.mak.uname | 12 ++++++++++++
 configure.ac     |  3 +++
 2 files changed, 15 insertions(+)

diff --git a/config.mak.uname b/config.mak.uname
index dacc95172dc..c8006f854e5 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -638,6 +638,18 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
 	SANE_TOOL_PATH = /usr/coreutils/bin:/usr/local/bin
 	SHELL_PATH = /usr/coreutils/bin/bash
 endif
+ifeq ($(uname_S),OS/390)
+        NO_SYS_POLL_H = YesPlease
+        NO_STRCASESTR = YesPlease
+        NO_REGEX = YesPlease
+        NO_MMAP = YesPlease
+        NO_NSEC = YesPlease
+        NO_STRLCPY = YesPlease
+        NO_MEMMEM = YesPlease
+        NO_GECOS_IN_PWENT = YesPlease
+        HAVE_STRINGS_H = YesPlease
+        NEEDS_MODE_TRANSLATION = YesPlease
+endif
 ifeq ($(uname_S),MINGW)
 	ifeq ($(shell expr "$(uname_R)" : '1\.'),2)
 		$(error "Building with MSys is no longer supported")
diff --git a/configure.ac b/configure.ac
index d1a96da14eb..64569a80d53 100644
--- a/configure.ac
+++ b/configure.ac
@@ -463,6 +463,9 @@ else
             CC_LD_DYNPATH=-Wl,+b,
           else
              CC_LD_DYNPATH=
+	     if test "$(uname -s)" = "OS/390"; then
+		     CC_LD_DYNPATH=-L
+	     fi
              AC_MSG_WARN([linker does not support runtime path to dynamic libraries])
           fi
       fi

base-commit: bc7ee2e5e16f0d1e710ef8fab3db59ab11f2bbe7
-- 
gitgitgadget
