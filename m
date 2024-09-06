Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07FE1D47AF
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 19:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725651980; cv=none; b=WRbXa8b2EsywaSC/5IpAzOFIla9o1cQZjZ9M8RJeTAl0u/nP49rpL+YlxEbZ7bkN0j9XL/mxnpyJ0fZHVQr1gi7gU/veHihQ3EWdDWgh+L7eGnRWawHk+wyGeh5zFhqzz6/mO0R5IcAgSirDDV/z0Ae1t7lkwbM6pRLkjTR+6QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725651980; c=relaxed/simple;
	bh=th15hE2tcz1Jtp9cEcesboste7+G76vXcUokxo4Rq04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XFVN5gsoMwrQhxxGLmKo5ixP74z/RwM/P4ULhXQipUdFmZpACZ8Xfh+/2ph1maZqqei2aQMml9Eh27JhwfniZvHxBldxMuGoG8fXE9gBCjyR5imKkz6BrZnWjQuFYSDlZLwg0YIbkGIxPNNC1cGTutPKHUgPa3Eli3dEZto9JGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=ErpP+6qk; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ErpP+6qk"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e1a82d1ef62so2521952276.0
        for <git@vger.kernel.org>; Fri, 06 Sep 2024 12:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1725651977; x=1726256777; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n5z5LVBw54AQwPy7u5bUYLtuVvsoN7bq2zRUKcEST8M=;
        b=ErpP+6qkYQIbEF1if9yZQaFguT0WDFRp6o6gHRJ0WUfSoH858d66X92WSLP67+PWKX
         mKeIfStS5d9xrlCoozsq08cW8SoKVnJVyPtBaaOW6dC5XAVmTWwJTxcTn1kF+AZBBONS
         mRUbaWM7v3IvtEQcl5z1lnHNsyN0uDjfyDHekIIrwCCzL88x+qjgMpRF5KrJ6kpQ6UUF
         UysZvIHsnhl/AHg107arKFQrPlrGRznQeM1qToIjEJs00FkriM0PzRvy/uCmW7+km9JZ
         Tl8kqjGL3mSQyEuj2UTHbZbcghrgjdlLlMja2iTayZrveUGpso19bN1xoPbDXSA8uTsb
         PADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725651977; x=1726256777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n5z5LVBw54AQwPy7u5bUYLtuVvsoN7bq2zRUKcEST8M=;
        b=tfGYN/3T61PgPFh5E2syeuf56vTyzlqYPqg30UPdHVQKA+rUbTY8IXBVw42PcKJPHw
         Nw60dPhWRHW4C9zCgV/TSAUbjRgsRPcCyRlzZYxQGQRx1M0qMpeoTdMQxarYaylWuvNb
         cW1QOUxhjDbiCtnjfd8sE32EEgAR9fZ5sAkfXUTLlJVk7TU3eBNvMLpM5Ti0SvSkqCEx
         mGls1flADKyOTbhjdaK9PfXaDg6UGh3KPe+GQ63Fcd9TT+T2BTG7GdnwTE7A5UUxZHsO
         aFWivavSAkJa0mpPPqm53HvEwNsBdp9ANYDLx3Wotd/g85v/VD5eWUkwPkOGd3qgfhLq
         c4fA==
X-Gm-Message-State: AOJu0YwhV4R3InxUOmlHIVlJF05isCyHjmCd5PSYxq7bLybCuDslWgmU
	wFxvoN3jONqUIeYWFFPla88vIs4+X6vnD/y+lm132q0TnHvoF0TxcoKZIUJfJSYHxg/QnXggiUi
	aDSo=
X-Google-Smtp-Source: AGHT+IEj7iTZXVDShtZQpQnARjQCzt9FdU4m66GNm8zLq+IFKi4GvsZD1AGsZ/O1YdWrJk6EZL9IwQ==
X-Received: by 2002:a05:6902:2e10:b0:e1d:1434:98a4 with SMTP id 3f1490d57ef6-e1d3486f977mr4166163276.9.1725651977406;
        Fri, 06 Sep 2024 12:46:17 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e1d43fae12asm105518276.37.2024.09.06.12.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 12:46:17 -0700 (PDT)
Date: Fri, 6 Sep 2024 15:46:15 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 4/9] pack-objects: use finalize_object_file() to rename
 pack/idx/etc
Message-ID: <620dde48a9dece56395a442b0f42a157d06adb29.1725651952.git.me@ttaylorr.com>
References: <cover.1725206584.git.me@ttaylorr.com>
 <cover.1725651952.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1725651952.git.me@ttaylorr.com>

In most places that write files to the object database (even packfiles
via index-pack or fast-import), we use finalize_object_file(). This
prefers link()/unlink() over rename(), because it means we will prefer
data that is already in the repository to data that we are newly
writing.

We should do the same thing in pack-objects. Even though we don't think
of it as accepting outside data (and thus not being susceptible to
collision attacks), in theory a determined attacker could present just
the right set of objects to cause an incremental repack to generate
a pack with their desired hash.

This has some test and real-world fallout, as seen in the adjustment to
t5303 below. That test script assumes that we can "fix" corruption by
repacking into a good state, including when the pack generated by that
repack operation collides with a (corrupted) pack with the same hash.
This violates our assumption from the previous adjustments to
finalize_object_file() that if we're moving a new file over an existing
one, that since their checksums match, so too must their contents.

This makes "fixing" corruption like this a more explicit operation,
since the test (and users, who may fix real-life corruption using a
similar technique) must first move the broken contents out of the way.

Note also that we now call adjust_shared_perm() twice. We already call
adjust_shared_perm() in stage_tmp_packfiles(), and now call it again in
finalize_object_file(). This is somewhat wasteful, but cleaning up the
existing calls to adjust_shared_perm() is tricky (because sometimes
we're writing to a tmpfile, and sometimes we're writing directly into
the final destination), so let's tolerate some minor waste until we can
more carefully clean up the now-redundant calls.

Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-write.c                          | 7 ++++---
 t/t5303-pack-corruption-resilience.sh | 7 ++++++-
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/pack-write.c b/pack-write.c
index d07f03d0ab0..e5beecd3a4f 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -8,6 +8,7 @@
 #include "csum-file.h"
 #include "remote.h"
 #include "chunk-format.h"
+#include "object-file.h"
 #include "pack-mtimes.h"
 #include "pack-objects.h"
 #include "pack-revindex.h"
@@ -527,9 +528,9 @@ static void rename_tmp_packfile(struct strbuf *name_prefix, const char *source,
 	size_t name_prefix_len = name_prefix->len;
 
 	strbuf_addstr(name_prefix, ext);
-	if (rename(source, name_prefix->buf))
-		die_errno("unable to rename temporary file to '%s'",
-			  name_prefix->buf);
+	if (finalize_object_file(source, name_prefix->buf))
+		die("unable to rename temporary file to '%s'",
+		    name_prefix->buf);
 	strbuf_setlen(name_prefix, name_prefix_len);
 }
 
diff --git a/t/t5303-pack-corruption-resilience.sh b/t/t5303-pack-corruption-resilience.sh
index 61469ef4a68..e6a43ec9ae3 100755
--- a/t/t5303-pack-corruption-resilience.sh
+++ b/t/t5303-pack-corruption-resilience.sh
@@ -44,9 +44,14 @@ create_new_pack() {
 }
 
 do_repack() {
+    for f in $pack.*
+    do
+	    mv $f "$(echo $f | sed -e 's/pack-/pack-corrupt-/')" || return 1
+    done &&
     pack=$(printf "$blob_1\n$blob_2\n$blob_3\n" |
           git pack-objects $@ .git/objects/pack/pack) &&
-    pack=".git/objects/pack/pack-${pack}"
+    pack=".git/objects/pack/pack-${pack}" &&
+    rm -f .git/objects/pack/pack-corrupt-*
 }
 
 do_corrupt_object() {
-- 
2.46.0.430.gca674632b70

