Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8067135F61E
	for <git@vger.kernel.org>; Tue, 15 Sep 2026 06:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789452622; cv=none; b=lppBYsyECA2LZaVlekfABqdZuq6zJce7sqiW0bK1rFn4IaZf/7aUa2xt1PEozqS7Nw6kqyHTngOdIOy3Xbwh5Yyh3zMDJXKPHjlogqnto1M3n7tC+sS3QqajvFLRlOnnMWQ1YLsx693EoWNkQ+69eq9w0BFc1keW67KsLBQGvGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789452622; c=relaxed/simple;
	bh=O7j13YPSg5APMj8GBEl6RtnuOxkyws2d/i4k9yByVC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ot0AsPbmYsgyclv6AxEARNgptdmSQ5+9Nc2LpO/tnJ4SNWYfJ2RUkPZAUmaZyVgubfutTW119zKjYO0vZJZtX2+zDKdUCECyceqt/luRd/l/qM+MAQy+3DdPrwaBAcux6oANo8KaebWU8C/T8yfh1Reg2U/nYaMe+NHs5WUtc+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l2sicJfW; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2sicJfW"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f9f0b20so585768166b.3
        for <git@vger.kernel.org>; Mon, 14 Sep 2026 23:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789452619; x=1790057419; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=r/4bDkC2yjQWleNIbNhmt3MnJNqXJ6mIWs4BAphzSiA=;
        b=l2sicJfWKAvPOy+YKSpuENhKywxPOtF0Cv8TC2DnTQ0BmcCClK+VH2AsSaZsVvfpKY
         yKVVBNnTYXiMmvoo13GDHaFI48IKnSuZb02tJ3XZc3h2F8Emhvwl4IurHvyVclbxWpeY
         Xl9tE32cSWal339RXYqTXQXgDH5CZE3sYLb7DNv62JtM2MIOIx1YhcZBN2KMbGQzMcSL
         8sd7Xu+dpzNyAEJp5yH11EEJdB8BjaeK8l4yOMkCp3VKgHR7bMv9PH1FeZJbJmxp9AX5
         A/CxDdq0LQ3VwRUiOtcj3sTE81kZFsFLmxCcBOwuwdxEJwOGbU2lsM4tzTgbxCZqwEhu
         yGxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789452619; x=1790057419;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r/4bDkC2yjQWleNIbNhmt3MnJNqXJ6mIWs4BAphzSiA=;
        b=w1Z2c3c8kvJZh9aS9Inc9IBVaaStapJ8eY/PSKMSw+vcVdPARmDpuLHwckj3NejEXt
         RkjWtcigyYgZa1C5UXnGgXopAWOcA1wvlN2Wmi2H+rdj1S5eZGN4dpAaqlKsdYeah9x7
         sa1ycX5uaGTyQQwQf0DsXDowR0MXgB6p/18UrlePkc3TmXjL6o2WQ897xUqp75M3PLU2
         Oe9n/UNAT8VzKZZudhJTh9tVpWntYVwMVw1x2iNUIPmH7bX7WSy0qFU2VL8NE9gv7AWE
         wP1wk3LTDo27JCXXvuMqQYK4HkGiS4//vDOZWS1+oU8LpkPqZduTNV3CqAYFc3EBFHv1
         FcBg==
X-Gm-Message-State: AFuF++mKtCZM3fEOm/kjX6HjmHtTVe3QFlyMCeXYf3rxsx+mjuxaLJgf
	LGbzjiTEQNFnwht1CbHcd48jyDUrKGO9ykWW6fhgT7cm5QhJfbvwOknCmMKJ5w==
X-Gm-Gg: AYBFou1auRwtCNnw6t0AjoJrtK+cUGc61RNyL+n9evRTe4ZIv4GT0n6Rg9H6Q+NNLUs
	gnc4AXwUQH2OE4jfza4ykgfT3XgGGue+hO1gCdN/2mnbz0YN1y2Rdk4yAhF+7+JmFN9I+nQTvWp
	Nm39yvLxvzaUTOWUkVrzVWHw/9tnOTiVZz83gb78iaUgvUGjW5nxK3QSdknMb5GOAbacf+QEXRL
	dsswzckRczkbTh/+JdLJHhWsikATOOrI2xbyUnHs+j+myNkfpuIBNB7iehmHdCARbsGptmQZBZ9
	pktpev8jBGFYasNeMjzbYHQtfbAs9K8rOTy5BVXHmGOwC5vOzENS/D6UqxXIDvJZFLFlDXloinS
	P6zUbpvyZmSuK/4vxjzMfFk/yTPYTJ3gNvz2P9525T7u56FCq+qjqHb62s9mV79KxwYr9RU1X2E
	X/BPgAocXp44c5AY75/hhrOlm4NpBrn3G3Smk1Km6VPLtkqCVXnWCTyhXFnldtdCZGKftjfHkwu
	P74LWH38iObD4ZlfWJS6rOzLRc1
X-Received: by 2002:a17:907:c5c6:b0:c29:29e1:2a07 with SMTP id a640c23a62f3a-c29b85fb015mr770028766b.7.1789452618555;
        Mon, 14 Sep 2026 23:10:18 -0700 (PDT)
Received: from localhost (78-131-17-112.pool.digikabel.hu. [78.131.17.112])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29d3bad045sm8752766b.32.2026.09.14.23.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 23:10:18 -0700 (PDT)
From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 3/4] Makefile: reintroduce REFTABLE_OBJS
Date: Tue, 15 Sep 2026 08:09:51 +0200
Message-ID: <20260915060952.569535-4-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.56.0.rc0.467.ge054dd0dd6
In-Reply-To: <20260915060952.569535-1-szeder.dev@gmail.com>
References: <20260909195006.2179119-1-szeder.dev@gmail.com>
 <20260915060952.569535-1-szeder.dev@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In the next commit we are about to precompile "git-compat-util.h" with
"make" to reduce build times.  But using the precompiled header should
not change what actually gets compiled, therefore a source file can
only be compiled using the precompiled header if the first included
header file is "git-compat-util.h".

The reftable source files are kind of special, because the reftable
implementation is supposed to be easily includable in other projects.
Therefore, the reftable source files don't include
"git-compat-util.h", with the sole exception of the purposefully
project-specific "reftable/system.c".  Consequently, they shouldn't be
compiled with our precompiled header.

List object files under "reftable" in the REFTABLE_OBJS Makefile
variable, so in the next commit we'll be able to easily filter them
out and keep building them the old way, without the precompiled
header.

Note that object files under "reftable/" used to be listed in
REFTABLE_OBJS so we could build a static library from them.  This
static library was removed in f3b4c89d59 (make: delete REFTABLE_LIB,
add reftable to LIB_OBJS, 2025-10-02), along with filling
REFTALBE_OBJS with object files.  This change essentially reverts the
removal of REFTABLE_OBJS, but not the building of that static library.

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
2.56.0.rc0.467.ge054dd0dd6

