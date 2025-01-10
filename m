Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F168C20B807
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 12:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736513740; cv=none; b=CRIEd26e5Eww4mHQgETBHsEf2NT/AkNiA4GUpuPfBkFp0mu5NqgUPGtU8UcLGCNsW41aeot9YtEUt/IREs7GizxNQNDobeZOfnvJ9OxG9QUyACTR/zg2t8VNGywxUrDdYL8it1mc1hxE2TWyLDP2Gy6TsBuBcbkba3kLovkCXDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736513740; c=relaxed/simple;
	bh=ciX7aY43v6sJVeqZ+FkNqjijossx0TtIXYZX99yoT4Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CWJ58H3XVocpfA6fe5XdWB27NjHMuPab5iR3Fym9S9FFJ48Tp1GbYVEqnJQlaquWSiAu6QdybBszmZe5UXwcQxCuWLw16505/dabo3P6+GesZpI6cZdByZfbp/sdkb1OrGk91q6TaUXVygHStTnigf3I9WHWBc+gfrU/SZ8/QrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DnbWsZqq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M3vl/GgI; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DnbWsZqq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M3vl/GgI"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 28F231140142
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 07:55:38 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 10 Jan 2025 07:55:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736513738;
	 x=1736600138; bh=DL22ZPvvEe1Q+IuGdTS3fKJrHcsZLwmU+kxE223BvuU=; b=
	DnbWsZqq0eRVSAalKhbBNgIllW/5dLh020cEdyZrEyM1mL9VBbZJ7JyU6t4DGrGW
	fG3eOk23eysyF2F0hq1sF8LrrH39r1Bu8Stpehlg6vpIxyfo9IsAZACC8cQZVVU9
	/xUheb0ri8Km06QIsXXMNc8afsp8M6e0/WJ50jdnBEMrlQ2qVpN6Roxu4x4cTMty
	+V8vVwTE+JJG1feYRrg3vIs06/Bn/R3b2ky7so93/U++T+CbG9pn/g+1MKEdOP/K
	wCKvhbvbLTTkgfVw1b04Yy8dxIHM7/nJAkvGy+9JaolzBbv/Lqi5Dfneaw6YkbZe
	OUb66pUgBxFUy6AmwWaZpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736513738; x=
	1736600138; bh=DL22ZPvvEe1Q+IuGdTS3fKJrHcsZLwmU+kxE223BvuU=; b=M
	3vl/GgIY0aqma2Sye8EJ7ifY3nqpmavfzM65c35qSJuRL7tVFkKRXdndp+1x1xZV
	wUDKP4Oig7A8A3sQ3618+qgo8fZwmlx0Iy63aSJ2zIWjMD0YfMcumpbjB581BYyz
	ccnGy/laPhQnvRe1rBYPKORw9+lhqL0OFemDhhNpFZEebOaMftSVlPASau8EbY9I
	Sj55/ZabyvMDwtjdVu9vyqYU9obnJqEYWB6NIqcSBR4mz/FW+A56NkJp6oeGDquQ
	QfCFs5aKtF4KTkrcFH/HCCSPpS9En+ncJ9Ssrix3Z2mFRH0rIk9mIEtViGwHWrAx
	NlmYjtdVTWmWQyKCuFxrQ==
X-ME-Sender: <xms:yRiBZ0GjCy3UsvqNDSkgXz8atwCcdd6DfL_2sb5Ud709IOsGrqx9-g>
    <xme:yRiBZ9UEg8hLE_5YCb6j5A3ZA76v8EowtJ26qvQ8u2fk94uR-pbJ_ebx7G5MXVlRB
    bXy--DiPkRx_8S-Zg>
X-ME-Received: <xmr:yRiBZ-LE3Dcy8MiLHsCUOBJA9POHKMnmJ93rFkNNu7q9wfAosjkpc3G6E-vNP-T35X57BnGfPsBkwx2aHXVoT242TWYgJ9e6_iM8sLCraiLqRQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegkedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:yRiBZ2FMHuM103POxyJX8fl-0VuoHgon0APrXkUsAMo76NiC_-h27A>
    <xmx:yRiBZ6VvNbBrbktMzUGhwx4sC680-lLXMNZRL-rkRYksgur46uXgVQ>
    <xmx:yRiBZ5NjEYzlTzoTMgRpCr9e3gUT_qhmEM3re9Mtob1_uFbLvSQbUA>
    <xmx:yRiBZx0J__psnAQpOVXIB_dn0uhlcFAiznJc79p-sDS8jix6uEsaFQ>
    <xmx:yRiBZ9citHxVieZuNI1T428Cqm7ToNlVfIwWWkZDhFCkECkOUkyy8hHC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 10 Jan 2025 07:55:37 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e932d1da (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 10 Jan 2025 12:55:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 10 Jan 2025 13:55:30 +0100
Subject: [PATCH 3/8] compat: introduce new "zlib.h" header
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-b4-pks-compat-drop-uncompress2-v1-3-965d0022a74d@pks.im>
References: <20250110-b4-pks-compat-drop-uncompress2-v1-0-965d0022a74d@pks.im>
In-Reply-To: <20250110-b4-pks-compat-drop-uncompress2-v1-0-965d0022a74d@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Introduce a new "compat/zlib-compat.h" header that we include instead of
including <zlib.h> directly. This will allow us to wire up zlib-ng as an
alternative backend for zlib compression in a subsequent commit.

Note that we cannot just call the file "compat/zlib.h", as that may
otherwise cause us to include that file instead of <zlib.h>.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 compat/zlib-compat.h | 6 ++++++
 git-compat-util.h    | 2 +-
 reftable/block.c     | 2 +-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/compat/zlib-compat.h b/compat/zlib-compat.h
new file mode 100644
index 0000000000000000000000000000000000000000..bc20b884efab72028d5f696923e9800e39b08ce3
--- /dev/null
+++ b/compat/zlib-compat.h
@@ -0,0 +1,6 @@
+#ifndef COMPAT_ZLIB_H
+#define COMPAT_ZLIB_H
+
+#include <zlib.h>
+
+#endif /* COMPAT_ZLIB_H */
diff --git a/git-compat-util.h b/git-compat-util.h
index c4b4b372b473ca0af2a4f5f60554f6d3df74f112..1ca26713221ba0270818ac61b6940f03cdf8b460 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1537,7 +1537,7 @@ int cmd_main(int, const char **);
 int common_exit(const char *file, int line, int code);
 #define exit(code) exit(common_exit(__FILE__, __LINE__, (code)))
 
-#include <zlib.h>
+#include "compat/zlib-compat.h"
 
 /*
  * This include must come after system headers, since it introduces macros that
diff --git a/reftable/block.c b/reftable/block.c
index 9858bbc7c5f7aa63fbcaf1acf9f4b5738e0b6d27..bc9b07963448e613ae14d2c4194b48764718290d 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -13,7 +13,7 @@ license that can be found in the LICENSE file or at
 #include "record.h"
 #include "reftable-error.h"
 #include "system.h"
-#include <zlib.h>
+#include "compat/zlib-compat.h"
 
 int header_size(int version)
 {

-- 
2.48.0.rc2.279.g1de40edade.dirty

