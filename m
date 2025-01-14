Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4932361E3
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 11:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736855872; cv=none; b=jJUiim8AB0kujfjZGjrXK0jNF1QOoYfGzHhNP5EfGaLulKSA96kmiVO1gwqDsaEyQmgL5Fdf7QQWhTE16dWSYuz6Lvh0rC49Vy3WrSsPn6XDPNVvq7Y5KeZVhP/Z8PyqZgoAzBDJBs38/ELIf+FisiICdYu9m+TEVW6/BBHWg7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736855872; c=relaxed/simple;
	bh=Ha5e/dTFNkSMcQSb8w56kvawCoRLH5O/wFZYPJYCzu0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JHMtY8JYj5allgpz31cZj1xq5iTh2RN2BSBTxeeZ5oC8SlolussQEOMF3g+eIWKE1yKq9O7NyFNdELUUqPNMmOmVMxyRB2GnqiPyXIBkQO63UKZ4ZNoZcncQtZpQpymRs3MII+jLbVFYNmMgCag7VJgloV2vFWZSa17FAUzGU9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VIzcI/5m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ao22GT5Z; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VIzcI/5m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ao22GT5Z"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E3CF611400A6;
	Tue, 14 Jan 2025 06:57:49 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 14 Jan 2025 06:57:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736855869;
	 x=1736942269; bh=nORK9R0VMdldsjdRCziJsbI70I1ZsEJ6XpjBBL9oh6A=; b=
	VIzcI/5mlrIy++sBEw/na5KPdwJ/SJMLlP+e8mRbggY/LJ5ZQ1iGSK3DaZvihrMQ
	93KUzck0r6dKQy7PEgHX617MKgn3PVlDs15vD6XpqrVjKif7JdOzWioMQWSL+Kl0
	El7QKvTHicIMacvcp60kk1axdurhPo3LNP+6TwpexiwBFkcyWQY/4hSw3YaXAoxS
	GPoXutLw7qkY8cSz4izCrJvh1G4sPWRaYATNbJp1WjOAVXoi9Wy+0Z9igFrUEKCk
	C6V1nZFCcNKGlymA4qoeTlOhpgkAP/3e6rrwszBq0i4odWVfWTFwzJYVP/40POf8
	yia2FNfxC43ZVDVqabrWhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736855869; x=
	1736942269; bh=nORK9R0VMdldsjdRCziJsbI70I1ZsEJ6XpjBBL9oh6A=; b=a
	o22GT5ZbreuKDLVV+0swK51r9wF1QBhGs+xgMEkFn/82WugLMbPs3uUHlGR22UAJ
	u7Mup7PQJY4HMPgJKJyySols66UIDNRA9D/GiLfntKt8BTx7kdgEEDXnonbl+Q0X
	VSl3SMDkjBV0gF/nsa0tGX9Ih8FMCV7zMliuXvrqbpDVQNNGECMllFOmQqmV+wtm
	Eh8t7hTOvyQLs3ECO/B2EsOFlItpevOwtg3vgngIVqUAE7xUxYdObX53zJbEOGI9
	S9CZ3niLCu5PeMNw1Vcf678t7OP6CRncwjuwiRVc9iqRagOT99a3BemEEgqo8Szf
	dMWu47z8N4eGw6boZmNqw==
X-ME-Sender: <xms:PVGGZyR18J4SEeoLdGTEQubx3MSDCSqF_iAWr-VTVx1ZM5NoiXycYg>
    <xme:PVGGZ3xUxjKkF2Rs0mRCUKSiW0sesywaybYlPS-D98XD3XVWOXTkEekab4QKciDal
    hALU5JEXE0-BOeeqA>
X-ME-Received: <xmr:PVGGZ_24CTAYJssXE05ml0qW-q1wrKgWTb4bEKReClhtYprAXuK5z4hwgp8EGtlSDUkV72l6GlchhLvtk9qLmZwiKpqHpU89qCyh0MX2pZPtYQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehiedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvseht
    thgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:PVGGZ-B9dmQiGNS2iXQXer6oXmHnuGQhgXbs6Lr4astdA-PVY_1e3Q>
    <xmx:PVGGZ7icTsJoZPRvWv9QgrGugCO42AopFktiG7vmqRO5No80WngTOQ>
    <xmx:PVGGZ6qmzOYY-Hagjpqfcd5V48_4cHI5zaF4tJ7ahv5EQ14Mg5UbqA>
    <xmx:PVGGZ-hDNabPwd9DlP865feZuj4r_zszddFowLWuK7lmKw4S7UV3qg>
    <xmx:PVGGZ-uI24qFjeeKtn9ejOZaw2IPPpuxQc2gk03hz_bXJcHXpK1txK24>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jan 2025 06:57:49 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 400b9ef8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 14 Jan 2025 11:57:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 14 Jan 2025 12:57:45 +0100
Subject: [PATCH v2 04/10] git-compat-util: move include of "compat/zlib.h"
 into "git-zlib.h"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250114-b4-pks-compat-drop-uncompress2-v2-4-614a2158e34e@pks.im>
References: <20250114-b4-pks-compat-drop-uncompress2-v2-0-614a2158e34e@pks.im>
In-Reply-To: <20250114-b4-pks-compat-drop-uncompress2-v2-0-614a2158e34e@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
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
index b9c200cba618ebc642859f2b3c58731157ed0eba..8be4e7ac8db50c7ae019ad12099362d9d392e194 100644
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
index 50f2d17b39944626172953475a07a56a9d618740..36f76fafe53ee755c4f18d9ea398b5dbe9a614fe 100644
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
index 5716016e12eec8c35f6495141fb2fcc250732803..78e04356d3ae9eb592f580fff204b28961934c0b 100644
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
index 8389a272700eac7e07710b6899eb045c7df4f69a..e5b361bb5de4c69246098d0d458b567836d174f4 100644
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
index 1ca26713221ba0270818ac61b6940f03cdf8b460..fb25fbf503cd3e4cfc9bf14c30dcc66951175c4e 100644
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
index d8a670aff9fbc476b37e6848a178aec98325d19d..1e8d9aabcb4cb239bdf529926be60b56496e0d4f 100644
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
index bc9b07963448e613ae14d2c4194b48764718290d..38e3081c614ab2240ce0d988db26f2f4f12b17a1 100644
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
index 5274eca1d05b18bdadef9f991ff79fa83f3363e4..f194a3868634ce7806a85518ebe561a50f5a3ac0 100644
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

