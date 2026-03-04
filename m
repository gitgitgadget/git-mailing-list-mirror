Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6993DBD46
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 18:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772648140; cv=none; b=eaA7tNaKbiQZgBfpHCsByUtN9XxyKkXm+hiqI33cpd060d9VPj4oe2wYFEjC73eWuSWkFUybZ3t48dGRj3J5x0RDw7PMv7H3z2YOVe17031x9Yh+Wen9VSC+KrbjmbhzeMwyCo3nAlhQVpN6pZZ+Pjn23+KelJcHa7EqtrIjev4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772648140; c=relaxed/simple;
	bh=jcgDwukSC1DVSos1K65JQ8LumLuP+q4tiK46hKwGcgU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=d5GdUSetApGNKrbXFjM764L0IfmIxb2s/JKMcCTdqSCDvx8FEM4uK+U3yWSsIF2LyQlmGM9IVWCsaXmtzgFqzvORmWHI4LtKzf4zqw9voV7gx3zBrehEvoJxeIRSWwj6SE+eR3Ulim2cpTN11agKScY9IDEJBYKngDTvtZ42LjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j1Xwfpyt; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1Xwfpyt"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-127380532eeso414336c88.1
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 10:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772648136; x=1773252936; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WtJtoOT4vLVqvqSvGza5m+d2MopKw+gtTn3DLzAHGPc=;
        b=j1XwfpytkDrqBgnFqXdG5bvgHSc33+ZIxk31IvSa5KovG7hWflPviYaqjSsEjoC6Rk
         0qSrqTgro9GE5qV+tDzElfmb7nuHBjCxJkt7HhyR02xsNbkQa6e91qbVvajZly0/wKbd
         95VIquB+MmF2vYh2OBqoxMErPjwv7g0ZAkvAWIRHGXTAAa0LMe9Erdjibjiu/I3aqToA
         5QNZj62UnqJ2VaDzlvncfvpVKB61QYbYTMPt67A/m/39FAhjfmnmPORHpDOIZHfWVGnL
         ejvz9bSZd5Rf2M/wacuxW/x2fKsnIswWjaR9C90Z/44t0Rv/9oPi7D6DVjODNAwRRG2U
         Drvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772648136; x=1773252936;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WtJtoOT4vLVqvqSvGza5m+d2MopKw+gtTn3DLzAHGPc=;
        b=frQbstVUfjFyAL92UIJJwetGdpHV7rTsd54kvhxBQuH+Xn1M+0G8nwGUTjzG7JMa9G
         OTuBfNITYhCNjPr7WXCzfdAn4/ulYajosTsMGArZV8cXdueY6UK+pMAL9wmvLdhvM9B7
         JFfUNyi4Eqr6pXsBnH/E1AU6FpcrvZQ9iofqC+T0xdoXFqg7pGCPCb8cDRs1xuL8a9Rr
         eqdQBIN2zs5Lyms6CcYDaL34WRsN/uS/45JXOFA0LUMNoNAQ6mUadNe8GHuVRDnfbdRi
         tDHMbDrxXzG6OSaP4NJ0MPwuNajqv4tQuCQB6nSsOOivHHsuzT0y8c/3iYRbz1mRMuu/
         SvnA==
X-Gm-Message-State: AOJu0YzJ2izIOzDI1v/7n2gLtYkxG6RYDHqtGLOEIeEPfjGcGGP4ksYr
	ap5mDBb03vQwCsM8XKzsaHVBPZEXr1WdX8JVdGqUv24ulBDcAXNBtkk5selI69Hr
X-Gm-Gg: ATEYQzxKJeh1D6cJBIhjXTryrVlMNEnm3LkidyW+f0xSNq3/ardrR1ChFLCGuzhfLnt
	ZE/43ibu3kirZjSJA09aZ3C3b/9EpVBEVlqwx5Cm8HjIWMoLgi2+xYVXejGiVSYcgj+Gnpay90q
	PNZQKcDi0nW+1F//QJ6NYDyDGqs9Jkz/0SZcOBICNP3gN47MYk0Nt8nxcbm7wLNPbbwH9BSpOW+
	YCM8ieJtxmIchYKUgPz5mV9faoxs4J+lAyf7Z21M1qFtl0WSmG8F6IekdGehy1mFH68f4SrKhTz
	eEK/LMrDi8wEeaPJHs/94eZH1Fwz67gsbw2RvKdlOGV/ZDZQG+snnI0uqa4KLWGHSoR55/n8O1A
	B/az9V6g+hkbLrMjPRZeQWmO+g7rZChxaer5P1EWK6TIEafePgnEOiKDiDIn0w7zFZQb9Pte3Oe
	0zFC3WTjIBUPcYp1OAYFandVhilg==
X-Received: by 2002:a05:7022:438c:b0:119:e56b:c749 with SMTP id a92af1059eb24-128b707b5e7mr1343094c88.14.1772648136473;
        Wed, 04 Mar 2026 10:15:36 -0800 (PST)
Received: from [127.0.0.1] ([57.154.172.168])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-127899d49ccsm22698620c88.3.2026.03.04.10.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 10:15:35 -0800 (PST)
Message-Id: <b2aaadb4aea37729989c6cd08838d7aee5b9dc4c.1772648125.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v8.git.git.1772648125.gitgitgadget@gmail.com>
References: <pull.2147.v7.git.git.1772065643.gitgitgadget@gmail.com>
	<pull.2147.v8.git.git.1772648125.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 04 Mar 2026 18:15:19 +0000
Subject: [PATCH v8 06/12] fsmonitor: rename fsm-settings-darwin.c to
 fsm-settings-unix.c
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Paul Tarjan <paul@paultarjan.com>,
    Paul Tarjan <github@paulisageek.com>,
    Paul Tarjan <github@paulisageek.com>

From: Paul Tarjan <github@paulisageek.com>

The fsmonitor settings logic in fsm-settings-darwin.c is not
Darwin-specific and will be reused by the upcoming Linux
implementation.  Rename it to fsm-settings-unix.c to reflect that it
is shared by all Unix platforms.

Update the build files (meson.build and CMakeLists.txt) to use
FSMONITOR_OS_SETTINGS for fsm-settings, matching the approach already
used for fsm-ipc.

Based-on-patch-by: Eric DeCosta <edecosta@mathworks.com>
Based-on-patch-by: Marziyeh Esipreh <marziyeh.esipreh@gmail.com>
Signed-off-by: Paul Tarjan <github@paulisageek.com>
---
 compat/fsmonitor/{fsm-settings-darwin.c => fsm-settings-unix.c} | 0
 contrib/buildsystems/CMakeLists.txt                             | 2 +-
 meson.build                                                     | 2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename compat/fsmonitor/{fsm-settings-darwin.c => fsm-settings-unix.c} (100%)

diff --git a/compat/fsmonitor/fsm-settings-darwin.c b/compat/fsmonitor/fsm-settings-unix.c
similarity index 100%
rename from compat/fsmonitor/fsm-settings-darwin.c
rename to compat/fsmonitor/fsm-settings-unix.c
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 6197d5729c..d613809e26 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -306,7 +306,7 @@ if(SUPPORTS_SIMPLE_IPC)
 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-path-utils-${FSMONITOR_DAEMON_BACKEND}.c)
 
 		add_compile_definitions(HAVE_FSMONITOR_OS_SETTINGS)
-		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-${FSMONITOR_DAEMON_BACKEND}.c)
+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-${FSMONITOR_OS_SETTINGS}.c)
 	endif()
 endif()
 
diff --git a/meson.build b/meson.build
index 86a68365a9..4f0c0a33b8 100644
--- a/meson.build
+++ b/meson.build
@@ -1338,7 +1338,7 @@ if fsmonitor_backend != ''
     'compat/fsmonitor/fsm-ipc-' + fsmonitor_os + '.c',
     'compat/fsmonitor/fsm-listen-' + fsmonitor_backend + '.c',
     'compat/fsmonitor/fsm-path-utils-' + fsmonitor_backend + '.c',
-    'compat/fsmonitor/fsm-settings-' + fsmonitor_backend + '.c',
+    'compat/fsmonitor/fsm-settings-' + fsmonitor_os + '.c',
   ]
 endif
 build_options_config.set_quoted('FSMONITOR_DAEMON_BACKEND', fsmonitor_backend)
-- 
gitgitgadget

