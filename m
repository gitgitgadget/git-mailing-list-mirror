Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F6C1DED6B
	for <git@vger.kernel.org>; Tue, 28 Jan 2025 08:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738053698; cv=none; b=fOPRz/O0V812BNqyP8ZS2QsgLTc8XVhydg+rdzr4O8iOvwF37v765re93Qi+idZ+Im6ecvLIUBxya3w+MeO5qoAPDIOkg36dJxzmmbc32LDEat5e1EW/KW8LRhjwCfwzkqIVqXwQxLiNRTPq56zKZvkYpXksAlJmvoDNrXJvfI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738053698; c=relaxed/simple;
	bh=ypt6qw+kA612FMG6906YUMzDrT0P0OkgVB2an3FEa7U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GkFIAchnYxxMlwD6cC7w2CWugVL/sCVbmnsXzMCxoUPDm/LRCKjFA82SQMBM9YtJgMwIA7hTk/mSTXDweAdaqIJu8OlhQ4o+CdaCvzVoxdjzC4/w0Rbut57rP0xnH4tC+2NrW92mKd9izQXL/TaQ8J6fihQn3BxYqnVOUcysa9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JdduHQcK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=alzrN8kQ; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JdduHQcK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="alzrN8kQ"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 8191F1140169;
	Tue, 28 Jan 2025 03:41:36 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 28 Jan 2025 03:41:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738053696;
	 x=1738140096; bh=uCwQBjTHtgJvAUT5JP82ZNSh0Ha7tkiM3vo5jrq4WPg=; b=
	JdduHQcKAqxYx5JqanzEaLTB1QfoWWzdwXu/cLuFiaAUmGCU+yEJzsCive9t+8I9
	FeWWjkbLhp63iyFdq7I8ZRN8eRJa+Uacets5YDQEMc4DIhKUx+nq+7UfrP/Ikaeq
	/Or6Upmd+Mnjyp/lnKOGqgwGiSb6S7jsj7j5DiOHai5AH4N7K08BwmoCqE1RMzbU
	eyv4AIr4NBkOhIaDB7SKjjXaJsk7aCyOgiMFrZ9udwxl8jYqgMJKfsGuUWz44pnP
	PyuyOKit03l406sx+UgxDShflpdaGpmFrFL87lUnM9LtZwSmD/OqprP0CCIj1WIU
	t2f8rIz9I0TVeWzBB9nNTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738053696; x=
	1738140096; bh=uCwQBjTHtgJvAUT5JP82ZNSh0Ha7tkiM3vo5jrq4WPg=; b=a
	lzrN8kQzysQfFHBBLsKiY1q7qWASnj+ScA5AEjSGAxrGASzNxMxlfH2XOCetNEz3
	4A3Z3sqzfUuNHSYMQg+sGne2bM3iLEi+Czz0TJbjV1kogPh7ChF8KK4ZJPH5BcSn
	CCrdcRvhf1sruNZS6fZXv6XGMBdGDDwKg96ffXnt0nbiW3Thu5KLoBouj7hZTrb4
	AJaIQYlGGdqq4yfysuwmKKd6oh1ZBrpnCgQmodtXTH0SmM1QLOsvp1kIUreWC7Wx
	w9NgS3W3d+X0YwehPtfmg2X2kcuAqs+LoY2W367GUxkiN2kUsJYdALsw92yNsJ1G
	XynRbbP33wtWj/Qc9scHw==
X-ME-Sender: <xms:QJiYZ9t5i1ikHiZddvbW-M4G8EVTosBnNJzPLIc689yxW4UU12w1mw>
    <xme:QJiYZ2fAt4pIcT-yJvRAUcJPzr-89IP72daniPVAqopqonZKjAuDULe2V604tkwst
    fah7a5ll88juln1Dw>
X-ME-Received: <xmr:QJiYZwzObc_Jt40lAQx150A-mAIDTVe4NH4VP4-skJlJhNzF3_8REguz_j59UOfozIMi5Jg6JcQaJ85tJHM5k4VgYMxh537K1O0InX3GhZs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudehieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtg
    hpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:QJiYZ0Pv0pghh0g9GtIiMSg6yIldBGBOuZCE7gYRJLJfFIeSMu8jOA>
    <xmx:QJiYZ9_VzXxI_f3qa0cWVv6ZnwjkyrkVoIA5x273Syjhxpvkx668Xg>
    <xmx:QJiYZ0UGRR7ql0azsZpvShn0V_Z4dzojJUzHPDNAyoDWgJWXgS5EUg>
    <xmx:QJiYZ-c6P_exWJuq6YkFy8YnrZDWAOeg3FPQgHs_myT9Oh_yt_ofxQ>
    <xmx:QJiYZ4YPbG4uGgeB7f2z7wknqDtKfKDFcpCmsc5O45_aAchFKpdkkfws>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jan 2025 03:41:35 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d43129ad (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 Jan 2025 08:41:33 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 28 Jan 2025 09:41:30 +0100
Subject: [PATCH v4 04/10] git-compat-util: move include of "compat/zlib.h"
 into "git-zlib.h"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-b4-pks-compat-drop-uncompress2-v4-4-129bc36ae8f5@pks.im>
References: <20250128-b4-pks-compat-drop-uncompress2-v4-0-129bc36ae8f5@pks.im>
In-Reply-To: <20250128-b4-pks-compat-drop-uncompress2-v4-0-129bc36ae8f5@pks.im>
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
2.48.1.362.g079036d154.dirty

