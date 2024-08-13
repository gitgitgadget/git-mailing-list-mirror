Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A892194C8F
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 09:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723540466; cv=none; b=LJAcGhMmjK8zV1xAdWCnFD6ngpiGQdz/CZ5YY4/Mm4tfeRr9RiVaQzxOa+7fPZ4zEAcnbgeuTadjBKiWGdO/A5kd3L7qI+/KlQLMNsSxNoudSZohoAFetTis2ruDsodGa1miXT3/iDVdsqVggyyzf0b/cvQHVqV4SODBuVTnEsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723540466; c=relaxed/simple;
	bh=VhN2nusBpNsoMcZDNAFmuU6DoxySUd43/Ce+5JS6sGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WVZE8QUMbVf6/0zPgKRQgrHpuX5XQlD2GWG6HEg+MaHOZKSi3ire3NkYXPIKqWiGCefmN8Dbl7YGystdoL0A4JWAetfVrztv3oOj873RtFyqnyiLBimmiHO4KJd5yCAIn7M2SwEwarai/EIgn8p9gC1f8B40zYevfY1/SxgoQ0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iGpniZqN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DyC32p+U; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iGpniZqN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DyC32p+U"
Received: from phl-compute-02.internal (phl-compute-02.nyi.internal [10.202.2.42])
	by mailfout.nyi.internal (Postfix) with ESMTP id 4E1F21389D07;
	Tue, 13 Aug 2024 05:14:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 13 Aug 2024 05:14:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723540463; x=1723626863; bh=MU2tiuBb5o
	l5NBLzvQpEwX0N5Kc+8hyadx1oWbbrORo=; b=iGpniZqNnRKPN0QLpuOCXg+BP9
	g6AUeEuHS98OA/R9Bzwu2WVrDCTVVwkZwsIi2nGPCgQytw8RgJ0X/vh1f3HQIZNk
	lCGXaUsSwBhkCrMeyGnS3vJ3ku1Am9z1CsG2uycVQWbotUUkYQNeURHO0DR/1v1b
	YIJvxHqgtPR0COkR4XOjAfejWO8D8r74l5XSXgQwgpFrPmCPrnQZ6F/yx58auNQb
	X02wN3DtYH1WWb79YmmxfCtOyQnQ83iIJo+7O28Nz3Tsd4rp6ckWqyZZwyFeoRae
	2liZ3jWHiRgrLXPsgSUbuiXOlAdfffl6/7yerZEb2NKcyA4WkoS9zz2Uht5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723540463; x=1723626863; bh=MU2tiuBb5ol5NBLzvQpEwX0N5Kc+
	8hyadx1oWbbrORo=; b=DyC32p+UBkEi/xGC9cPbfX/vlfndwhchIMWrFBiBzN4G
	37kOoxD50bqxO2qSc6qBpk6U+M4BMIOnGADb2Bt/oQUXWM6ofIXj/T2uU1r/doQj
	lPlgix6pHfNvRo8LVaPs41Vr5G1WIzOBcPOPkLG8cLrjoUDUS97KS7DILxnz61/Q
	6C9Hv8KV+SFZeLIJgfOUgTdovKGHUaoGmFKKrY8gLmg2Xy7nK1wwe45FbT031Egb
	s5ThSGpSriDlVH7Gf9UpL+6nzUz7sPl4iGwexRlTVSuKgGeY8JanVQJm9cHUuiB5
	SE188RFyxMxjzq2F9CkcsnSQSAUfrlYvZbWd5Tr0sA==
X-ME-Sender: <xms:7yO7ZtbTpBqmKJc6ltUdD8ciRASUxNyVTaRiWPjDK6fF2t_1UFEdDg>
    <xme:7yO7ZkaSvpMrTLQXsa-mfrGVBtkOPzpJ8o_rPD42jl7CGaNqvD16jXoLv-H73Ww8Q
    QCCOtXnQ3oRuMU8TA>
X-ME-Received: <xmr:7yO7Zv-Dd6P0T-L26Za9hnBFJn70Ch9eWnLtQJpUjzLEOcj1wuLhQEqNfAEEY-5ZNKkQr0Nk8Cu8fEF967y3Sut0_I2T7hp1vz1aNPt4Odpf0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepieduieeitdehieeutdejudehkedvgfejudefgfeiuefg
    jeekudegfefgffeftdehnecuffhomhgrihhnpehgnhhurdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgs
    pghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:7yO7Zrq5cRBL4MQASc8rybZbXGzEtrBmM0FTWoFqcG2YZk7tdHldJQ>
    <xmx:7yO7Zor0BO02aW9SmwSWBpg6ZFTKslOPel9WtxMP8hl02mlCJNxnJw>
    <xmx:7yO7ZhS37vqYkpfS8oUlIZSEgloJzHMAWTt4kGgPMVWojc10hIxgUw>
    <xmx:7yO7Zgp9LeH0Hdrbo4mglLTUDsElcemgvk_jeAJ_7prv-NBPaqAIeg>
    <xmx:7yO7ZjVrB2QKMssPJupDLW9aqiWhVKhjIbZRAFdO4TwBW7jFzbJHAGfB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 05:14:22 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f9d29248 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Aug 2024 09:14:06 +0000 (UTC)
Date: Tue, 13 Aug 2024 11:14:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 19/20] global: prepare for hiding away repo-less config
 functions
Message-ID: <124f5794e6677da0ca3cac1e90c381ebb43fdca6.1723540226.git.ps@pks.im>
References: <cover.1723013714.git.ps@pks.im>
 <cover.1723540226.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723540226.git.ps@pks.im>

We're about to hide config functions that implicitly depend on
`the_repository` behind the `USE_THE_REPOSITORY_VARIABLE` macro. This
will uncover a bunch of dependents that transitively relied on the
global variable, but didn't define the macro yet.

Adapt them such that we define the macro to prepare for this change.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 compat/fsmonitor/fsm-ipc-darwin.c | 2 ++
 compat/precompose_utf8.c          | 1 +
 connect.c                         | 2 ++
 credential.c                      | 2 ++
 daemon.c                          | 2 ++
 editor.c                          | 2 ++
 fsmonitor.c                       | 2 ++
 gpg-interface.c                   | 2 ++
 graph.c                           | 2 ++
 imap-send.c                       | 2 ++
 mailinfo.c                        | 2 ++
 merge-ll.c                        | 2 ++
 parallel-checkout.c               | 2 ++
 protocol.c                        | 2 ++
 refs.c                            | 2 ++
 refs/packed-backend.c             | 2 ++
 refs/reftable-backend.c           | 2 ++
 sideband.c                        | 2 ++
 t/helper/test-advise.c            | 2 ++
 t/helper/test-config.c            | 2 ++
 t/helper/test-userdiff.c          | 2 ++
 trailer.c                         | 2 ++
 versioncmp.c                      | 2 ++
 23 files changed, 45 insertions(+)

diff --git a/compat/fsmonitor/fsm-ipc-darwin.c b/compat/fsmonitor/fsm-ipc-darwin.c
index 52f4f29720..fe149a1b37 100644
--- a/compat/fsmonitor/fsm-ipc-darwin.c
+++ b/compat/fsmonitor/fsm-ipc-darwin.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "config.h"
 #include "gettext.h"
diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
index 0bd5c24250..f7cc7b3be5 100644
--- a/compat/precompose_utf8.c
+++ b/compat/precompose_utf8.c
@@ -4,6 +4,7 @@
  */
 
 #define PRECOMPOSE_UNICODE_C
+#define USE_THE_REPOSITORY_VARIABLE
 
 #include "git-compat-util.h"
 #include "config.h"
diff --git a/connect.c b/connect.c
index cf84e631e9..6829ab3974 100644
--- a/connect.c
+++ b/connect.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "config.h"
 #include "environment.h"
diff --git a/credential.c b/credential.c
index 4b1a2b94fe..ee46351ce0 100644
--- a/credential.c
+++ b/credential.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "config.h"
diff --git a/daemon.c b/daemon.c
index 17d331b2f3..c65b068b76 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "config.h"
diff --git a/editor.c b/editor.c
index e93b4fdb09..6b9ce81d5f 100644
--- a/editor.c
+++ b/editor.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "advice.h"
diff --git a/fsmonitor.c b/fsmonitor.c
index 2b17d60bbb..28130f748f 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "config.h"
 #include "dir.h"
diff --git a/gpg-interface.c b/gpg-interface.c
index 5c824aeb25..6587085cd1 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "commit.h"
 #include "config.h"
diff --git a/graph.c b/graph.c
index 1ca34770ee..091c14cf4f 100644
--- a/graph.c
+++ b/graph.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "config.h"
diff --git a/imap-send.c b/imap-send.c
index 01404e5047..b2eb3d2dd0 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -21,6 +21,8 @@
  *  along with this program; if not, see <https://www.gnu.org/licenses/>.
  */
 
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "config.h"
 #include "credential.h"
diff --git a/mailinfo.c b/mailinfo.c
index 94b9b0abf2..95228531a6 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "config.h"
 #include "gettext.h"
diff --git a/merge-ll.c b/merge-ll.c
index 180c19df67..badb6dea57 100644
--- a/merge-ll.c
+++ b/merge-ll.c
@@ -4,6 +4,8 @@
  * Copyright (c) 2007 Junio C Hamano
  */
 
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "config.h"
 #include "convert.h"
diff --git a/parallel-checkout.c b/parallel-checkout.c
index 08b960aac8..01736f1352 100644
--- a/parallel-checkout.c
+++ b/parallel-checkout.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "config.h"
 #include "entry.h"
diff --git a/protocol.c b/protocol.c
index 079ba75acf..bae7226ff4 100644
--- a/protocol.c
+++ b/protocol.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "config.h"
 #include "environment.h"
diff --git a/refs.c b/refs.c
index 0afc70b51b..284c64dfc5 100644
--- a/refs.c
+++ b/refs.c
@@ -2,6 +2,8 @@
  * The backend-independent part of the reference module.
  */
 
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "advice.h"
 #include "config.h"
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 89976aa359..ba2ad90d10 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "../git-compat-util.h"
 #include "../config.h"
 #include "../dir.h"
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index bf4446afd3..df67923d21 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "../git-compat-util.h"
 #include "../abspath.h"
 #include "../chdir-notify.h"
diff --git a/sideband.c b/sideband.c
index 5d8907151f..5b6b872a1c 100644
--- a/sideband.c
+++ b/sideband.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "color.h"
 #include "config.h"
diff --git a/t/helper/test-advise.c b/t/helper/test-advise.c
index 8a3fd0009a..6967c8e25c 100644
--- a/t/helper/test-advise.c
+++ b/t/helper/test-advise.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "test-tool.h"
 #include "advice.h"
 #include "config.h"
diff --git a/t/helper/test-config.c b/t/helper/test-config.c
index ed444ca4c2..e193079ed5 100644
--- a/t/helper/test-config.c
+++ b/t/helper/test-config.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "test-tool.h"
 #include "config.h"
 #include "setup.h"
diff --git a/t/helper/test-userdiff.c b/t/helper/test-userdiff.c
index 0ce31ce59f..94c48ababb 100644
--- a/t/helper/test-userdiff.c
+++ b/t/helper/test-userdiff.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "test-tool.h"
 #include "setup.h"
 #include "userdiff.h"
diff --git a/trailer.c b/trailer.c
index 72e5136c73..682d74505b 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "config.h"
 #include "environment.h"
diff --git a/versioncmp.c b/versioncmp.c
index 45e676cbca..e3b2a6e330 100644
--- a/versioncmp.c
+++ b/versioncmp.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "config.h"
 #include "strbuf.h"
-- 
2.46.0.46.g406f326d27.dirty

