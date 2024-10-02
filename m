Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C1D205E35
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 10:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727866605; cv=none; b=OKyzX44HhpoA2XGpgNFdk0Cyrp4m9mKZZgbkn0w0SSXw42ICbdWMGxCDiMGUryZv1z7mVyPbmXg9YFPofaksyVZ1tussuoklSqCkNjmuFuyync0bwG9mKIctoAqbbht3AXlF9kI+3nJrbzqW2HTYNzpwS/qfnX4o52fPXzCkIf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727866605; c=relaxed/simple;
	bh=9ZFMv2JZWW+TRfc3oBkUE+dawIl0I9Mcfu8paRefvTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NUy5/hu9X4Mcb/xpA6x7N/hUQqLMhVxNV1LtD3gV9dbtCsY9vjajOHNEuTM7U+u2jpNT5+3X/lwqBJLxvJZ8NOf1ye3PxKqWklFG1x3FcFlEM98nX04EklT/8ppKbnOiFgNkUDJZpyDC4pGdAIw9FWzUrywjEH+3/RA9szR7xgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TJLBY0Uu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BOapkdGC; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TJLBY0Uu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BOapkdGC"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 04B48138028E;
	Wed,  2 Oct 2024 06:56:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 02 Oct 2024 06:56:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727866603; x=1727953003; bh=TVlxpys1tf
	cNPIZpDIdXxujPFsiv63h/1MWoXPv87Wk=; b=TJLBY0UuQ1DX39bTXi3Ces6dj0
	otOqTkHBrXvJHc6eHtWzgkV4kYrewX5DIIZ4+6yOPDE/n7OjWI69EY/Y8xcmGhet
	I+hgzZid8S+DcA2H6em5aoI14yoqFN7yjXLIgLCRtntrGmuTgHNmOzHGpHWUfdDW
	DfnMvDbvJDzx4TGrQGzdWfqngFH72x0IGci6TxS4fNyxi2vgjvNLpE+ZBGzEx3Cg
	t9EHfGOrJGhdgcqbTaICdf0zz4SkrVRQiQRzOoT4cIzExknFhcj9ncHiMZEgpDFG
	jMVFDcGUFRCkliCJ9+V6CB4vDoB6YCf9dXdRGyX4bxniF8pVZNwA/uXNrCmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727866603; x=1727953003; bh=TVlxpys1tfcNPIZpDIdXxujPFsiv
	63h/1MWoXPv87Wk=; b=BOapkdGCLlzWAKMiYmTh0tTF+ycSDJEND1nIayDMGicV
	O86OGKqNBu9SjmkGnfaQ75r98O57rwEMwhvCVgywldOTMzaEub3hh5UdMvy0yOms
	SssALX8eT0tCRZcyflP3EEJg/YoFXE0FZz+/Ei03enbNkdAh3qG9uBJ9UKTsDHrs
	amSXxnpsqV/bNFMhDJNbtOpUFHxI0USMQNQLuiXaXfAwp8B8kSKgNLwAACD+qOAo
	qIfxH/C1zcqGhjHQy86OapwuRzjd/ja192Dprm/lUnWW99TGjjEo9e1/QrApCKT0
	a3rNBeOVMrmr7+n2nh5YgsfcHq8HleuqFO6wj44K7A==
X-ME-Sender: <xms:6ib9Ztwh29bF4pR99pAhJ8Dhl-v7z4Jmg8LjMImnfTk2nuSif93Lcg>
    <xme:6ib9ZtQuf6J9G__gQCkK5cQF8hFRG0TLxy6zFFKEB61eCyDiPakoqGniqTF_8XZTa
    UW1GUS6vxbKnxtbFg>
X-ME-Received: <xmr:6ib9ZnXACW9t5Ny0scLTV9TiNKX8mMfm3HtU5Z0GymjIl0MiKiTG0-QywQVhZ8hkV2SM0tIWgNdvBasyj8xvTrbfGm2p4cpz-3LNPox7DerqmgzP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepueeiueduhfevhfekiefgkefggeeljedtffetheehtefh
    hfdvledukeekfffhffdvnecuffhomhgrihhnpehgohhoghhlvgdrtghomhenucevlhhush
    htvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepvghthhhomhhsohhnsegvugif
    rghrughthhhomhhsohhnrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvg
X-ME-Proxy: <xmx:6ib9Zvh7zzD7bTQ6lNmFe_u0E_vCcWyV4iR-qbVX12IHDwBUI2UOxw>
    <xmx:6ib9ZvBcnMY_WCMGurAnJmkko-uo3Ukjq7kN3jI_30fwb4r_EmcMrQ>
    <xmx:6ib9ZoLOOVq7TvYOYtGaQC0bDa7UtC0w5qdQBIsD4QNo1LSNvL-fqA>
    <xmx:6ib9ZuBKm-htbGl32TlVaagSbK6xxZuWLrMC8luTNugWQTLjYOj3DQ>
    <xmx:6ib9Zq9V17Y977InGvTvh-9NNEVlBVFUXhEjdN-EThUI-o6Q-82d_lLm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 06:56:41 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9e37ef50 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Oct 2024 10:55:51 +0000 (UTC)
Date: Wed, 2 Oct 2024 12:56:39 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v5 25/25] reftable/basics: ban standard allocator functions
Message-ID: <bc80f1e7265784ed68436cf1e81b2aa4bdbec309.1727866394.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727866394.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727866394.git.ps@pks.im>

The reftable library uses pluggable allocators, which means that we
shouldn't ever use the standard allocator functions. But it is an easy
mistake to make to accidentally use e.g. free(3P) instead of the
reftable-specific `reftable_free()` function, and we do not have any
mechanism to detect this misuse right now.

Introduce a couple of macros that ban the standard allocators, similar
to how we do it in "banned.h".

Note that we do not ban the following two classes of functions:

  - Macros like `FREE_AND_NULL()` or `REALLOC_ARRAY()`. As those expand
    to code that contains already-banned functions we'd get a compiler
    error even without banning those macros explicitly.

  - Git-specific allocators like `xmalloc()` and friends. The primary
    reason is that there are simply too many of them, so we're rather
    aiming for best effort here. Furthermore, the eventual goal is to
    make them unavailable in the reftable library place by not pulling
    them in via "git-compat-utils.h" anymore.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/basics.c |  1 +
 reftable/basics.h | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

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
index 7f0f20e50c..4c9ef0fe6c 100644
--- a/reftable/basics.h
+++ b/reftable/basics.h
@@ -73,6 +73,20 @@ char *reftable_strdup(const char *str);
 	} while (0)
 #define REFTABLE_FREE_AND_NULL(p) do { reftable_free(p); (p) = NULL; } while (0)
 
+#ifndef REFTABLE_ALLOW_BANNED_ALLOCATORS
+# define REFTABLE_BANNED(func) use_reftable_##func##_instead
+# undef malloc
+# define malloc(sz) REFTABLE_BANNED(malloc)
+# undef realloc
+# define realloc(ptr, sz) REFTABLE_BANNED(realloc)
+# undef free
+# define free(ptr) REFTABLE_BANNED(free)
+# undef calloc
+# define calloc(nelem, elsize) REFTABLE_BANNED(calloc)
+# undef strdup
+# define strdup(str) REFTABLE_BANNED(strdup)
+#endif
+
 /* Find the longest shared prefix size of `a` and `b` */
 struct strbuf;
 int common_prefix_size(struct strbuf *a, struct strbuf *b);
-- 
2.47.0.rc0.dirty

