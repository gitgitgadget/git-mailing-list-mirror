Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C223C414F
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 19:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788983427; cv=none; b=shauaxMHPa3//oMKZsLAT7qlh1nfNbh04RXSWTAJ3oc2m7VuOCMOWfKktT5IBkMgDKC4ZC6FKQ39niurTBL3Yca/oxc2qkiVh0InzEEK588vX06tfM9/M1XOxcAGgLSYyZD8VRQlmgpt5I0rvVnbX5yQJslRUNOoSzrLjiZhdq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788983427; c=relaxed/simple;
	bh=zPhtSH4FQvuHsZi2HLEMTVRRKQFEYCjVmmElP6VQpfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KOlXP+GqNAUrhcaKA4l5txmZTV4zhijXAmrOsU2WhNrUClh7NnSNKgwPusOgH25hQ9hnprg4nYbt7zf3l5QrykxtAJBxrTINyQBO5ex+8U1ueodB7I4ZsjuldB6NjP9YWZqDLEAbssPoa/PvMKuHK075B48Cir5u+eDHA8czDAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jkUKsBSN; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jkUKsBSN"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a6056be4d2so2038218a12.1
        for <git@vger.kernel.org>; Wed, 09 Sep 2026 12:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788983422; x=1789588222; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/E0nmsAXzcyK79QWLyu6ghZMV3nxLfqkLHI9Wa8KdC8=;
        b=jkUKsBSNEh6ufMcBFERj+VTS24J45NNPFHtF8yUOsaU26RbOJ65aE4vW57m57yjdSF
         +KpObeblhYIsq+42X1i5UYKDxoyiGd4k/s3YUkIo0IqHTu+soVzgx1KjsWbL4juzFVAS
         edEJqjzOyZdqSx/lB4aIEhWEEQTF5sOMqFB1biecapbz9UP8Mp9VHcnzD7ENQ4A/AJXZ
         ayDhnD6iKY9NS4ybaUla2ii0635JJPXsydgWVeszCcvT7ptqZaX16sQ5VWCfXfSdE5k5
         JdWoEA5sDDRILOWAB3As9j4gEeLwzQRNAKK1A5qX0Xntu4jXcFfa05RW4IEtg9xMiY2j
         rx0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788983422; x=1789588222;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/E0nmsAXzcyK79QWLyu6ghZMV3nxLfqkLHI9Wa8KdC8=;
        b=aMRoS/g/aMzXFZrQlgwK3gAj5+dhetHln6g63rNT2Lnb+E/Jm2TrYBZzYr8RoJHPgE
         B7krBUADB2LWQsvU1Y8E4MOw6wREevgyuWc6fShYtugg5tAHRz1pZdOrXtdf9/usPGps
         +uMo3/8rEPxcGcM4BMcnUDbcfgCz1439KsmCNbIk3RGYOmeEA2BDModZfbUuFLQKPrKc
         L5+HE0jx0ag8OUOdR6kSFZ0mLLT60uiZZ1JcKJU8cabf2CHjD0QACYoXyS3BHri5MFOF
         fTqXTBS/fXF5160r8T/Ce9apRqz9PS2flUvBTAtL2j4axak+up7AvvagBvOzx0IZPqnO
         7oUg==
X-Gm-Message-State: AFuF++n20YzT1zbswSpT/SsGaBx/xIW9ekIsDKILcU4bYMI06iQBiDuO
	oxH3wWIp4dNiRiVdmUF8EOnCX7uqqm0Bx1tldIt+UIbgxY0BmOHEyhqe+09cTg==
X-Gm-Gg: AYBFou1PDDoJy1GPMr5dBrrQXb82Fwi8FlJI/ixPRLlDH0uALNQgzeOizH9kvgLXrXY
	oHGwk36zHupVQXLrVw4mbFaMQrwYWSRRzEq9v3+lCL/sMEka39Lpfmkqh/55vJ7F4vEygC+NWjA
	SX/ZUaLaJ0EP5CY6Gcc9FF1jWgBPqRLMU4bh90ea9FiydBVW6rKy6cplXBx0BFucYcoO0Ye8f1M
	CteE6IsTvymuUJR2UZKpu+2yRToi0iqP9WJyiUtwIlGXn2kNBYzJh4TM2iXfztCUbHkpONaVOvI
	qqdlbL4OOq70/pk9VgBX9j7+g0wjbAUVL2uOMHYj+Jx82HSPQZ1KWo5qEHD8Rag4v5PiF/t1Z9D
	UIBuAvXgzj0nRMsr0hhl/d07YfT/LE+eIYLiCFaoPan51o2YK9ql5MR8ouXnXjjWkM0nwAMk7qn
	9iAtZk7v7RpLZKxkHupUgEWJJAm1Kr75GHXVAsD2R1XNAjIu+Q7RFWTGXtnxUneLTybgDdns60e
	R7w4kQoHMFqBIM2VphSTUIDHtY=
X-Received: by 2002:a05:6402:2345:b0:6a9:9443:ec7d with SMTP id 4fb4d7f45d1cf-6a9a3269673mr480870a12.16.1788983422103;
        Wed, 09 Sep 2026 12:50:22 -0700 (PDT)
Received: from localhost (78-131-17-112.pool.digikabel.hu. [78.131.17.112])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a9882a8510sm1668826a12.21.2026.09.09.12.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 12:50:20 -0700 (PDT)
From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 3/4] Makefile: reintroduce REFTABLE_OBJS
Date: Wed,  9 Sep 2026 21:50:05 +0200
Message-ID: <20260909195006.2179119-4-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.55.0.1193.g1b994e35de
In-Reply-To: <20260909195006.2179119-1-szeder.dev@gmail.com>
References: <20260909195006.2179119-1-szeder.dev@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Object files under "reftable/" used to be listed in the REFTABLE_OBJS
Makefile variable so we could build a static library from them.  This
static library was removed in f3b4c89d59 (make: delete REFTABLE_LIB,
add reftable to LIB_OBJS, 2025-10-02), along with filling
REFTALBE_OBJS with object files.

However, the reftable source files are kind of special, because the
reftable implementation is supposed to be easily includable in other
projects.  Therefore, the reftable source files don't include
"git-compat-util.h", with the sole exception of the purposefully
project-specific "reftable/system.c".  Consequently, they shouldn't be
compiled with our precompiled header, as it does include
"git-compat-util.h".

Resurrect listing object files under "reftable/" in REFTABLE_OBJS (but
not the static library), so in the next commit we'll be able to easily
filter them out and keep building them the old way, without the
precompiled header.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 Makefile                            | 32 ++++++++++++++++-------------
 contrib/buildsystems/CMakeLists.txt |  4 ++++
 2 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/Makefile b/Makefile
index 7d9ac15c74..2c4d6f4d4a 100644
--- a/Makefile
+++ b/Makefile
@@ -707,6 +707,7 @@ OBJECTS =
 OTHER_PROGRAMS =
 PROGRAM_OBJS =
 PROGRAMS =
+REFTABLE_OBJS =
 RUST_SOURCES =
 EXCLUDED_PROGRAMS =
 SCRIPT_PERL =
@@ -1284,20 +1285,6 @@ LIB_OBJS += refs/iterator.o
 LIB_OBJS += refs/packed-backend.o
 LIB_OBJS += refs/ref-cache.o
 LIB_OBJS += refspec.o
-LIB_OBJS += reftable/basics.o
-LIB_OBJS += reftable/block.o
-LIB_OBJS += reftable/blocksource.o
-LIB_OBJS += reftable/error.o
-LIB_OBJS += reftable/fsck.o
-LIB_OBJS += reftable/iter.o
-LIB_OBJS += reftable/merged.o
-LIB_OBJS += reftable/pq.o
-LIB_OBJS += reftable/record.o
-LIB_OBJS += reftable/stack.o
-LIB_OBJS += reftable/system.o
-LIB_OBJS += reftable/table.o
-LIB_OBJS += reftable/tree.o
-LIB_OBJS += reftable/writer.o
 LIB_OBJS += remote.o
 LIB_OBJS += repack.o
 LIB_OBJS += repack-cruft.o
@@ -1386,6 +1373,23 @@ LIB_OBJS += xdiff/xpatience.o
 LIB_OBJS += xdiff/xprepare.o
 LIB_OBJS += xdiff/xutils.o
 
+REFTABLE_OBJS += reftable/basics.o
+REFTABLE_OBJS += reftable/block.o
+REFTABLE_OBJS += reftable/blocksource.o
+REFTABLE_OBJS += reftable/error.o
+REFTABLE_OBJS += reftable/fsck.o
+REFTABLE_OBJS += reftable/iter.o
+REFTABLE_OBJS += reftable/merged.o
+REFTABLE_OBJS += reftable/pq.o
+REFTABLE_OBJS += reftable/record.o
+REFTABLE_OBJS += reftable/stack.o
+REFTABLE_OBJS += reftable/system.o
+REFTABLE_OBJS += reftable/table.o
+REFTABLE_OBJS += reftable/tree.o
+REFTABLE_OBJS += reftable/writer.o
+
+LIB_OBJS += $(REFTABLE_OBJS)
+
 BUILTIN_OBJS += builtin/add.o
 BUILTIN_OBJS += builtin/am.o
 BUILTIN_OBJS += builtin/annotate.o
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 241da0d43a..462c1eb5ec 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -668,6 +668,10 @@ include_directories(${CMAKE_BINARY_DIR})
 #libgit
 parse_makefile_for_sources(libgit_SOURCES ${CMAKE_SOURCE_DIR}/Makefile "LIB_OBJS")
 
+#reftable
+parse_makefile_for_sources(reftable_SOURCES ${CMAKE_SOURCE_DIR}/Makefile "REFTABLE_OBJS")
+list(APPEND libgit_SOURCES ${reftable_SOURCES})
+
 list(TRANSFORM libgit_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
 list(TRANSFORM compat_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
 
-- 
2.55.0.1193.g1b994e35de

