Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815961D90B9
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 09:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737019050; cv=none; b=KDV2YeZ3gbCFFkGMzzC47czBffRbtj/apmXlmo1Ig30JRJksIwvhyY8fm1JOuhSq5lnITmCYjHEkTqfqW4rQ45ht04gRrkuiFrZ1kKKW6w+8G4UDcNhUjGMXtXFoFfktVGht4C0RvfOQu6jBAdqQtZ2stZVIIYfHLnS+atQwHjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737019050; c=relaxed/simple;
	bh=CjD4JYvNfbtl50C7gX0wpUR8oYrzDqvXvYaHjl3guyY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XgrrC7OQJ5Z9C3I+LuWkIJ43ljbaYdLUCmahNuKv+elXFHgBjbOsRUAJSbaWNMBLFqjdIre7t2DNKc+i1xAyMeWytO/g3C8KAdp1iNPKnrOAN+EAhL4DhP5ELa1YufcXtYXwIMYHk6JkvLicKqCmFlNOPCGZ/Og4LM9KZnCMLoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JrNaTNj4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iV+/XZ/Z; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JrNaTNj4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iV+/XZ/Z"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3A5FB2540178;
	Thu, 16 Jan 2025 04:17:26 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 16 Jan 2025 04:17:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1737019046;
	 x=1737105446; bh=fSuuTx9zUmmyP0zK0xaqXvV3Tbcp2Ba/VN6U99rSX+E=; b=
	JrNaTNj4d9TNbbznoNcNYtV9yQuIm60Qg520zeTv4dkExG4tE3IvOfKVNYnJE6Jw
	QVUE6UpeIE6pT2Y+xYaE05eBsJepthAm88xd8qZeeLJBzOzYgM06KyjAsHMhkP1B
	0WWND0/ympJrpKLbZPGa7hpcuE2WvhwPY3JJB0kA8w/phJbfbOnPdfvahjdVXZip
	ES822THM1Str4BV1hBAEG1j5KV+T0DhR7MiUFfmE/3ZQ5M4FIjPDy24gbaU4Il+a
	hh/P99ESTEXhqwld+Qb9zVSUNWWxKggUaUOQagfJ+88CI2ORe6ZaNBpP0xtOKsNV
	DW3Tm5SIJ/AvWRRmC5m9mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1737019046; x=
	1737105446; bh=fSuuTx9zUmmyP0zK0xaqXvV3Tbcp2Ba/VN6U99rSX+E=; b=i
	V+/XZ/ZCAPLCBATupI2KLH76Ms75zg3FYFpCNzqjrGrSyJi5YvA4ZSFeaW7dQsrX
	dZUWyt4WPztizSAp3k47VG9pJRszBaGSOWCd/uW9MsHonQpfaddjN5bPBlRvClF0
	JT9LQtGFBbokmbJb3Ycz/04ebH8RCkqGMjJbREtQC92ikp1UFDaKPY9BxwSzZcrg
	Bbvq37mwhCMTJ6pihaZnyzfhEBCCQlZpwh+Gbtm/1iaB/wS3eqL4LZEE3xrfiEYM
	u4KNy3iCFsohYTQORXkUP+ziMrkALKU3o4eXf7PueJ8XISwOlMs8rwjAE95Rgdln
	B7ks3AHi+Rqe7r+5cwVdA==
X-ME-Sender: <xms:pc6IZ1LCqrOS7xFQBol-qIFlF2FBQCntKInpO8wOMWldZNvXyELBwQ>
    <xme:pc6IZxKF2HFzmMwsTBnuCAHQpE7ieku-r1SjH-awoDbh952tzBOBKyndFqOtS59xs
    bCbtkWBtJBh8BK7tA>
X-ME-Received: <xmr:pc6IZ9sst0BEZ9SwV3qJP8VdN1jbPVcqOiiNNOhMYirpV5xhZhjUs-3XCH3qSgeV4_nhikTSQzg9EXz-50WGkI0orpQAdFBGJ4jRg4WxlN5MsAFE3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehkrghrthhh
    ihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:pc6IZ2ZHEqmJ5lOFieHnM2SAwSqbZPRs1dYpNFBfb9ZNdrMqlWB4vg>
    <xmx:pc6IZ8bOOeuE6yxb7GVA6gjKYNnOeV8hukU0mUA3IH2z5BxWAbDpug>
    <xmx:pc6IZ6CK0eqoulyiM6rGxPgzSdqD91ZV-i1V5ZRne-lnlg-FkQ3LEw>
    <xmx:pc6IZ6ZX4TvfisegJpoAY8gbr6JJ5pqjDmxJFrIN4aZ9mmwimpO3Pw>
    <xmx:ps6IZ0Gk5LgPGyzr1gVeL_e4lKsR8Yo84FAcD4b2Y5GXInRPsAk2hh1s>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jan 2025 04:17:25 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ddcd7034 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 Jan 2025 09:17:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 16 Jan 2025 10:17:17 +0100
Subject: [PATCH v3 04/10] git-compat-util: move include of "compat/zlib.h"
 into "git-zlib.h"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-b4-pks-compat-drop-uncompress2-v3-4-f2af1f5c4a06@pks.im>
References: <20250116-b4-pks-compat-drop-uncompress2-v3-0-f2af1f5c4a06@pks.im>
In-Reply-To: <20250116-b4-pks-compat-drop-uncompress2-v3-0-f2af1f5c4a06@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2

We include "compat/zlib.h" in "git-compat-util.h", which is
unnecessarily broad given that we only have a small handful of files
that use the zlib library. Move the header into "git-zlib.h" instead and
adapt users of zlib to include that header.

One exception is the reftable library, as we don't want to use the
Git-specific wrapper of zlib there, so we include "compat/zlib.h"
instead. Furthermore, we move the include into "reftable/system.h" so
that users of the library other than Git can wire up zlib themselves.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 archive.c         | 1 +
 config.c          | 1 +
 csum-file.c       | 3 ++-
 environment.c     | 1 +
 git-compat-util.h | 2 --
 git-zlib.h        | 2 ++
 reftable/block.c  | 1 -
 reftable/system.h | 1 +
 8 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/archive.c b/archive.c
index b9c200cba6..8be4e7ac8d 100644
--- a/archive.c
+++ b/archive.c
@@ -7,6 +7,7 @@
 #include "convert.h"
 #include "environment.h"
 #include "gettext.h"
+#include "git-zlib.h"
 #include "hex.h"
 #include "object-name.h"
 #include "path.h"
diff --git a/config.c b/config.c
index 50f2d17b39..36f76fafe5 100644
--- a/config.c
+++ b/config.c
@@ -19,6 +19,7 @@
 #include "convert.h"
 #include "environment.h"
 #include "gettext.h"
+#include "git-zlib.h"
 #include "ident.h"
 #include "repository.h"
 #include "lockfile.h"
diff --git a/csum-file.c b/csum-file.c
index 5716016e12..78e04356d3 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -11,9 +11,10 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "git-compat-util.h"
-#include "progress.h"
 #include "csum-file.h"
+#include "git-zlib.h"
 #include "hash.h"
+#include "progress.h"
 
 static void verify_buffer_or_die(struct hashfile *f,
 				 const void *buf,
diff --git a/environment.c b/environment.c
index 8389a27270..e5b361bb5d 100644
--- a/environment.c
+++ b/environment.c
@@ -16,6 +16,7 @@
 #include "convert.h"
 #include "environment.h"
 #include "gettext.h"
+#include "git-zlib.h"
 #include "repository.h"
 #include "config.h"
 #include "refs.h"
diff --git a/git-compat-util.h b/git-compat-util.h
index 1ca2671322..fb25fbf503 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1537,8 +1537,6 @@ int cmd_main(int, const char **);
 int common_exit(const char *file, int line, int code);
 #define exit(code) exit(common_exit(__FILE__, __LINE__, (code)))
 
-#include "compat/zlib-compat.h"
-
 /*
  * This include must come after system headers, since it introduces macros that
  * replace system names.
diff --git a/git-zlib.h b/git-zlib.h
index d8a670aff9..1e8d9aabcb 100644
--- a/git-zlib.h
+++ b/git-zlib.h
@@ -1,6 +1,8 @@
 #ifndef GIT_ZLIB_H
 #define GIT_ZLIB_H
 
+#include "compat/zlib-compat.h"
+
 typedef struct git_zstream {
 	z_stream z;
 	unsigned long avail_in;
diff --git a/reftable/block.c b/reftable/block.c
index bc9b079634..38e3081c61 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -13,7 +13,6 @@ license that can be found in the LICENSE file or at
 #include "record.h"
 #include "reftable-error.h"
 #include "system.h"
-#include "compat/zlib-compat.h"
 
 int header_size(int version)
 {
diff --git a/reftable/system.h b/reftable/system.h
index 5274eca1d0..f194a38686 100644
--- a/reftable/system.h
+++ b/reftable/system.h
@@ -14,6 +14,7 @@ license that can be found in the LICENSE file or at
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
+#include "compat/zlib-compat.h"
 
 /*
  * An implementation-specific temporary file. By making this specific to the

-- 
2.48.0.257.gd3603152ad.dirty

