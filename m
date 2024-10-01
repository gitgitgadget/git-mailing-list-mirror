Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEC21A08C6
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 09:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727775789; cv=none; b=ncNpyminkxRZQ5QKgNejBfgpJmZApxcj5pLTjtI/StDSDQ1hVSMMCqiKqRwKKhsJxNQnV5UUiaKqiLHyirJm7WDAadPGafLd2p+2LRzkagzCMbGHPvRTxCkR4fa2eYAUCuiXTluQHcEJQMDX2Huc0IVKOQsfgxXtB3CIWWeBzgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727775789; c=relaxed/simple;
	bh=Rva1EG/gdVAIHBBrGwPtuCy3OOvBL8r6Te5yCI5nL1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n42ku7h9UyYc8Q8yTUrj/6ASoTBx4s26b0YRvu3dzs8NqX9sAkwOu8En99Tplkk9fXus2c8zhDDWpwfLcXm2ff0UeA3qk9hCZtIL7YwR5UdwGgeKG/0WXMtZFnx6QCLinSDTvMucezZaOTvNTZLeFRdANYQHzZ0Su02znhO+SE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dH2RY8Ec; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SFCIhulE; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dH2RY8Ec";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SFCIhulE"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 8C111138187F;
	Tue,  1 Oct 2024 05:43:07 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 01 Oct 2024 05:43:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727775787; x=1727862187; bh=fpfhfi84Tu
	5yPA4RiM6WsPGT/mOeFTB0HX14lJWCGPM=; b=dH2RY8EcwmrQtExhoHzoDYKaIX
	6qCEVApYviTqCXZ1JyyygZyJZQJja+Ah5jaS3F8aOEAjoof5lA+SFOYgqeBtL8qQ
	L5qSrsL3Q8cB1+sytArP9Af2S9Drds6iOBZvp4+PJzW6edOpGqRvqh/4m6m1n/Oo
	dVXAOTnf/G2GvAlVaPkBSQwPAXTmW9/0u2lIqnLIgmRPeaZxfZ0gnWW5TFdMRsvh
	/VxVGccJ6W1AA+dVp0Z8mIxkdM7LOBcWgZqeafTUTB1Cf+0UzwSsphjUDzP6jUXa
	EWb9WrrBgPD00ycHha4iFY8rK0slt/W18z+lOhfOkiQKhk+XkqKRsqHd/7CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727775787; x=1727862187; bh=fpfhfi84Tu5yPA4RiM6WsPGT/mOe
	FTB0HX14lJWCGPM=; b=SFCIhulEJUJW1YcQsAHDZRH25A4ZkXFuOPLYflTgjjjv
	8m7WSWQz/8c1LINttMSgq/DheuA++2fsyVVZRKrNURfaoyJZa6GMUAb77g+3amLo
	oHoKx52Jm5FrWpnDtlnaQKY5j28MRNGLUqG/SzZN/f9HQ7Tu0XduhpFrH3RuIg4o
	x0YNNimaxAxV8elRVYFiremvGMZbqQaG+D+Bya/QIRd1Ai1DmkKtyKhFTP16ir+C
	WVrmzFixgPTkXpUZOiMLdXQp4z1le/5Al0cEB7womQa7lQX0IRLcTk/dBuYEmj2r
	+8ae2eBC/1RUuX3oxGbo7qbFzjuPgsDHKyRLsENuPw==
X-ME-Sender: <xms:K8T7ZgjLtfPAq85BZAOaAwhwm0QvMzl6dbT6IjZHX-dGee8CcpZ92w>
    <xme:K8T7ZpC-Jny2lDgECdilRMrLLwEGz7nqY_eoBvZP5twz_PNciVOhAsKE9jvmzIrvq
    lUkJlyq4FQ2PSCXCg>
X-ME-Received: <xmr:K8T7ZoHb1C8MHPMXCZVEfE6OKfMRTfPhCJpTw0xsl9MH7nxj_Z5zluK1TAniNYhZnFLHlvk9BkTJ2oYSy4zL31a4dGEfuxaP-jB9na8m-_yMaQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddujedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepueeiueduhfevhfekiefgkefggeeljedtffetheehtefh
    hfdvledukeekfffhffdvnecuffhomhgrihhnpehgohhoghhlvgdrtghomhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegvth
    hhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomhdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvg
X-ME-Proxy: <xmx:K8T7ZhTIphh3BieHmo75TTYG2bHyWEmSj0d_leGJkk2hi8Z0reGcrw>
    <xmx:K8T7ZtzseF3WBu1TPHTSnlwPcC6WOb0VsS9DpCADftLwKnYx-LC2Ug>
    <xmx:K8T7Zv4dARX0liTbBttAixJYIDhySkOOLxycVaFA8ToKE6zg1ApEoA>
    <xmx:K8T7ZqyKMU_5eCgaj9l0zJNtXhAq8G81Gg29HXaSs6M3fBNAaTGrTg>
    <xmx:K8T7ZvtCUS53H-PNf0q2MzahSYdzMw89ldpBUlT5aOKOj4HgeTvfug67>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Oct 2024 05:43:06 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a259ba69 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 1 Oct 2024 09:42:18 +0000 (UTC)
Date: Tue, 1 Oct 2024 11:43:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v4 25/25] reftable/basics: ban standard allocator functions
Message-ID: <764961e6f02b8e5788bce75830559b70c2e6f231.1727774935.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727774935.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727774935.git.ps@pks.im>

The reftable library uses pluggable allocators, which means that we
shouldn't ever use the standard allocator functions. But it is an easy
mistake to make to accidentally use e.g. free(3P) instead of the
reftable-specific `reftable_free()` function, and we do not have any
mechanism to detect this misuse right now.

Introduce a couple of macros that ban the standard allocators, similar
to how we do it in "banned.h".

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/basics.c | 1 +
 reftable/basics.h | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/reftable/basics.c b/reftable/basics.c
index ea53cf102a..c8396dc525 100644
--- a/reftable/basics.c
+++ b/reftable/basics.c
@@ -6,6 +6,7 @@ license that can be found in the LICENSE file or at
 https://developers.google.com/open-source/licenses/bsd
 */
 
+#define REFTABLE_ALLOW_BANNED_ALLOCATORS
 #include "basics.h"
 #include "reftable-basics.h"
 
diff --git a/reftable/basics.h b/reftable/basics.h
index 7f0f20e50c..428e8d1e57 100644
--- a/reftable/basics.h
+++ b/reftable/basics.h
@@ -73,6 +73,15 @@ char *reftable_strdup(const char *str);
 	} while (0)
 #define REFTABLE_FREE_AND_NULL(p) do { reftable_free(p); (p) = NULL; } while (0)
 
+#ifndef REFTABLE_ALLOW_BANNED_ALLOCATORS
+# define REFTABLE_BANNED(func) use_reftable_##func##_instead
+# define malloc(sz) REFTABLE_BANNED(malloc)
+# define realloc(ptr, sz) REFTABLE_BANNED(realloc)
+# define free(ptr) REFTABLE_BANNED(free)
+# define calloc(nelem, elsize) REFTABLE_BANNED(calloc)
+# define strdup(str) REFTABLE_BANNED(strdup)
+#endif
+
 /* Find the longest shared prefix size of `a` and `b` */
 struct strbuf;
 int common_prefix_size(struct strbuf *a, struct strbuf *b);
-- 
2.47.0.rc0.dirty

