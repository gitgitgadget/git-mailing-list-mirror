Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746AE21CFF6
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 01:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772673394; cv=none; b=LlNTf8aqtPReHQ2h+qznynT9ISsGHH4yrz34TMJK7+6WQm1cm7RfPeoRQIue3fqHSF4hRGIKe8y6la9qpd7RGfG4y6IQoqmubyw2lR4GXTx0KqwN05FxOwIRkZjP30uX2+W+uSIoJZTq0EVx32F/4dISFw43J5Uft3ME74lTmDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772673394; c=relaxed/simple;
	bh=jcgDwukSC1DVSos1K65JQ8LumLuP+q4tiK46hKwGcgU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=JSKfeU370ZAGnXXkaxKQARyPy+UfMfyNdomJAHYsEnsNQPAeBdyn+S5uuIUXU5cGW3LDYVWXe/GA3jL5U+RzSicV2jVu4TEK12vWvrQi71JVWG0t57HERxOE2j2sZBhym5d5xcu94CEMbxADMD0AWaf8Unv698bJ23g5AlBk7DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wb0H02Bo; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wb0H02Bo"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8cb3fb47559so869780885a.1
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 17:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772673392; x=1773278192; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WtJtoOT4vLVqvqSvGza5m+d2MopKw+gtTn3DLzAHGPc=;
        b=Wb0H02BolRObvscNcxo9i1yWJmJ0Tv/JJLNZnU04QhXS6ezhy3oNpo8iwcjyFsgKqQ
         19jbqps7MhZn1PIEahdpv5YmvuLp756JJDKok/AnvsKMOu+0NLfTuGl7zw05EQ4jAYhX
         J18hd9dEO13WGsITBSIoyei2xFaKlGNLAOJ8+PT5deHIL4kk4S8av9yf/r8XXQwFHZ/f
         hAKNt0MNf0wKuP2n8Uw3QJfAGbNpWvZ4kItgb0IxqTkZBkgLG5NPdVpkR182TTlQQLCQ
         LkWsU5uzQE2k7L6a6YYjxiplOl/tz+H8ymKygkXa4QGExmHiCjPKkE/zQiGxshnBYtTw
         +t0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772673392; x=1773278192;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WtJtoOT4vLVqvqSvGza5m+d2MopKw+gtTn3DLzAHGPc=;
        b=a+YXYpiCNhSmt23t2U9+5D9ZvijAZZCLP0DSN18Pi1CZSlIGEVG7+XYSV0KewjaXto
         RK+fIdmU5wOjiH9xXfHWTa+YJDDTH1VqtjUvHZ5oFFG97t8W3UOddMJgaQQG5kxKw6JS
         PsmvdtDXUWwNwSr1FAA+AbVX0r0/6UobbpnzMbG4ZM3DNyFrEe+MJpgpyLtGM4PdT7jK
         Tvps7arOJCzwdpnsMpeT08TzLyz0xYrWWc3DMk2kNFsB8E3K3i8/UeVsXZ8vAboUoArI
         /wc9uWOP3VoMD12kTouuQmhFeyqy5quxMQ3KEKjaypyfb5ydMntueT1jv1+0XAej/jBV
         9eAg==
X-Gm-Message-State: AOJu0YyyToXKVztSoaChfXVNTNV7KLl+KsLMN2BkJcexUJFZpIGiHVzl
	EaE/1KTBLdceQ7P5VdHWXaQAy6CV7/wrHIOirCDbhS7V8GL01enaT/8Jvb8RXa+b
X-Gm-Gg: ATEYQzyOXwnzrGHkXe1u5Rpg6a1e5Cq+RMRDjdq3a4DYt5Pq+C5SxyE+f/iK2Uynvu+
	xzrWOuhJuqd1j47IfdzPJ2X+XZ9YIfVO31iNYMloWqjXiQzByaABy4ME0golG7eQUS7ZloLCJEf
	Xmzsb476aXPrT6J748h49P8GL9HmCr/00t2joGXufLWQog1sl942aK9sDxVRjNYVQpg4DCuHhFj
	mygRjof7fzxHoFr+drmfSDWYfVlxKlgX/hY+I7WHgbChpZFuoffTLBr0v4w01FiqH5D3DPBOYMN
	Tk3NAo8Ad3pEi0ozolFPqhITJtwLW+KjYPk4baRTUctOX7ADq8yXGo1e7hRUkOeh+op/Wv4L09d
	YEMk6ArD9jOo3RqHmUaCjiPKgpQVizLyUk6AMQ4sdINE3ZsWTlX3nRIRC1yWnrxS/mUBKLM36fP
	3zlRC1TubPC1NxrQsIkUio/O0=
X-Received: by 2002:a05:620a:6ccc:b0:8b1:2853:673f with SMTP id af79cd13be357-8cd5aebfa5emr537994985a.15.1772673391747;
        Wed, 04 Mar 2026 17:16:31 -0800 (PST)
Received: from [127.0.0.1] ([51.8.152.229])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf6f9261sm1754656585a.26.2026.03.04.17.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 17:16:30 -0800 (PST)
Message-Id: <b2aaadb4aea37729989c6cd08838d7aee5b9dc4c.1772673378.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v10.git.git.1772673378.gitgitgadget@gmail.com>
References: <pull.2147.v9.git.git.1772671920.gitgitgadget@gmail.com>
	<pull.2147.v10.git.git.1772673378.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 05 Mar 2026 01:16:12 +0000
Subject: [PATCH v10 06/12] fsmonitor: rename fsm-settings-darwin.c to
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

