Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B4433F368
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 06:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789020339; cv=none; b=VzsIq9rldsoUbc02qDPYkI9qMjeQfokQFm+e/n85+aRHHDj1t9GetyCf2ddZBvkmvprg7Naw+jaZxqYXjsJB3PuD0wv8yL7lgfxy6gVTJRdpJ/bbmFFqQo3XdSFfEDH+3RXYzvkGws2r+DoK8GZ2tG4grkvtvhQpXfkL16F/cxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789020339; c=relaxed/simple;
	bh=4HORNT2zcpBWd4uV/5ezBWaNn9ATKQDjtyifonUqf7s=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=A5CzBiptxEXACETthwl/xe+NMEYbzuaR2sIHMrYjggZkKTHZmPUC7K7kJna6Y+0HvfvendMirtq2kwVmPKnH8Jb1ww1ah7MyFLcYSXBVNOim1ETbo2dHh2ailAdtCnn9wAf+sTEaD9YZtLyJJ1p0ovc2Dj5jF8sj7d9oFuXkl6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4c42eoQ; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4c42eoQ"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccc09d65so846406a91.3
        for <git@vger.kernel.org>; Wed, 09 Sep 2026 23:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789020337; x=1789625137; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=L7izhqAUG61oZg+2fHlFEGIkrnc02l5HCAfVhKQ9PCM=;
        b=F4c42eoQFspMya0x0dyLNZRAOvPTskImXoPFs2ZvKtif6FKKPuJGp9k/j5tQDOPCL5
         QQhq9W3QYdv+RnOHd0yOB0pfYfFFvJ/Zkv0mm1O6EAXdnZ499QIfg/MIrFdJZjaYpdgg
         JSZdQ/2nx7uliee2YVQDGiz6tLBEDuftUdkzgW0fj8vTCNdQXeH4nF498efUV+X5cKJU
         FBBkUFDkLb6KMwIoxKbnqvQ71ilbw3ulWPNL3AhtiMIccPsmqK1jIf9Mn8vQwhTzSnCS
         ZWdgRl0N7QUmHUAv6XDuLFWGVW6HcZ7Dw8iPxJvq6DuCngCJS9oW+JtpLf0fmkbvHqC9
         E3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789020337; x=1789625137;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L7izhqAUG61oZg+2fHlFEGIkrnc02l5HCAfVhKQ9PCM=;
        b=duc+3WoetU24VbCgqPuQzSGYO2dHXqhZh6q9x7mQ057W4rttGDZbMrlJ6+GAsLIB2r
         ENWU2d7k9/PW/mQPiy3Yk3lIfEjkj+s8HgceVwWdDe6gPF1km7pGc6uhRkOwp/8kwgUm
         uKfPm0QmHSn2FA2+OahViMTYPLEi+B/gYtAABzX6e8Co5uLStR0v4SKQweUlRZmg1nxY
         UtcuHZ6X327Q3rL1YEvwwwLKg414poTpm5laFsW1dST8Hic6z55dXDMgcRC3oC1UGkYW
         5AmGwMrGhaaaw861A7YIExceiaRTbFjEv5kZ53Tz4flKwzd4EaJSa6REXD2h4AdFJ6YD
         w/Ig==
X-Gm-Message-State: AFuF++miYQg2U4EQuc71IipqQPGy4MS75w+Ce6eVQ7Rc2FQnYJ2uLEpt
	4zQPE1xcxfRbLbNiKMPtO+mSHU/GgiFBGf9fBNrpeiTv4jeuSW8W1j+S5l79wg==
X-Gm-Gg: AYBFou0/jkzXaymPerVnBLovPZDPa0SJ2gl6ZqW6aHzvVVq0U0/+wUjU/iNR9pezGTE
	zFgZVVB8oKQg2vNcvO495MxtAzRdKZwc6OxXNCVa+G+nGUUcTHkb/EtP1C4Tr8XzuNVef6GTMxs
	6UW+OHNsST9/PExFqAazEYJsYOQBraVTmTdjH0yaNuWE7EPBFKKrZKddSoUE2A3NyNwc2J3MmiG
	DVHc500wC2ek+I1+ew3HN+8r459Xe4PJfurLqDROdS3rWTXcZElJbM3cgQTbi6HgZZsHoFfR5AJ
	0jDerqH+sYJd/W99u8yvekeiXukbEZr+sXrbh2lwukOrTtFp7Tc2XqR8/FSdn2xnd2/8itBQ98A
	fxLzGZMX1cgrnP6Fa3IKMXj4qlDMImMYfDV/AZ3jUmOIqJ4Ga5UnV7FK/uHc+1O2nUaO1nFYKjI
	pWRFdaameD7YYAqP33MU0GhRrtEJ3lUooJiJD4o49Uz5PIFmDmmOxXo+8npQRv0keNsMQIw1/O
X-Received: by 2002:a17:90b:1a86:b0:398:ba96:1afd with SMTP id 98e67ed59e1d1-39d709dfda5mr7728508a91.8.1789020337289;
        Wed, 09 Sep 2026 23:05:37 -0700 (PDT)
Received: from [127.0.0.1] ([134.33.70.110])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339af25062sm76683891eec.16.2026.09.09.23.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 23:05:36 -0700 (PDT)
Message-Id: <e03279a0df02d772df112a9ec8ffb9be58485440.1789020327.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2195.v4.git.1789020327.gitgitgadget@gmail.com>
References: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
	<pull.2195.v4.git.1789020327.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 10 Sep 2026 06:05:20 +0000
Subject: [PATCH v4 06/13] mingw: set the prefix and HOST_CPU as per MSYS2's
 settings
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
Cc: Johannes Sixt <j6t@kdbg.org>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

MSYS2 already defines a couple of helpful environment variables, and we
can use those to infer the installation location as well as the CPU. No
need for hard-coding ;-)

Helped-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.mak.uname | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/config.mak.uname b/config.mak.uname
index f6387f4c7b..8363239513 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -754,19 +754,13 @@ ifeq ($(uname_S),MINGW)
         ifneq (,$(findstring -O,$(filter-out -O0 -Og,$(CFLAGS))))
 		BASIC_LDFLAGS += -Wl,--dynamicbase
         endif
-        ifeq (MINGW32,$(MSYSTEM))
-		prefix = /mingw32
-		HOST_CPU = i686
-		BASIC_LDFLAGS += -Wl,--pic-executable -Wl,--large-address-aware
-        else ifeq (MINGW64,$(MSYSTEM))
-		prefix = /mingw64
-		HOST_CPU = x86_64
-		BASIC_LDFLAGS += -Wl,--pic-executable
-        else ifeq (CLANGARM64,$(MSYSTEM))
-		prefix = /clangarm64
-		HOST_CPU = aarch64
+        ifneq (,$(MSYSTEM))
+		prefix = $(MINGW_PREFIX)
+		HOST_CPU = $(patsubst %-w64-mingw32,%,$(MINGW_CHOST))
 		BASIC_LDFLAGS += -Wl,--pic-executable
-        else
+                ifeq (MINGW32,$(MSYSTEM))
+			BASIC_LDFLAGS += -Wl,--large-address-aware
+                endif
         endif
 	COMPAT_CFLAGS += -D__USE_MINGW_ANSI_STDIO=0 -DDETECT_MSYS_TTY \
 		-fstack-protector-strong
-- 
gitgitgadget

