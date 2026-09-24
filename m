Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289C937A48D
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 14:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790258968; cv=none; b=mzozRh68JjiASn9QIPlnf/cPmyIHb9qis6UFgkG5G4QPBHj0yfiuZlObw7Tyxk6hLsdPs6JEftDyPadwQiyiTRhXqg+irJusRkFJJkIgnBbXktP5hZJvAoPBgoJRxrtFkFOv0ThA8ox07G1xm1reoRCARU6/Dm2O1l1sYqGOobw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790258968; c=relaxed/simple;
	bh=B3xNf+x1mEB7pOJc6MjnL4NUD0V7sgokGGe2uvXakNc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nXQ+H5j/Xcva3jt640oLieaYoRRFg5t9CBSmQBRlBufuNRFW5dTrEM+9xfpR9zHGycIkBeFVChePk4C/goF6gUOV7TUXmRMyCAEj2l4RNJXSOTpVlFrhtacasyq2uN3rJ+VUIyuzoKZt4slqIjx7O/yCLS/Aj10UTb+QodOVpy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nrjWnHbI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i19EalRl; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nrjWnHbI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i19EalRl"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4981C7A00F4;
	Thu, 24 Sep 2026 10:09:26 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 24 Sep 2026 10:09:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790258966;
	 x=1790345366; bh=+MyA+96EFUyI0C9XxKcJAzHsZF+Wb7LcjCehDaqqOG4=; b=
	nrjWnHbID7x4Vss77j1qQziaa2iCyFeJ9vHD6IMQgBU7ByxCCwCaaYQdL9hmWSKn
	SSbnx3yd61kDdRUc99Hs84YlrdhqPbV1tFPVPa708pDMd+K+YtxbhYoMC4vxDP/0
	MzrAn/ngUNPK/HZTaBJIgpJIyu0IkDLRmM6m1K2VCjn14sAeqcP5yBfAntrQeGM2
	XzoSngl0H3fgKeqXjln18c4OeSIKUKpUNzAsD7vd8kHALAlf1cN8jjO1pXswvbyL
	0tRyUvdRgLnNFa1LFTVP6d8UTd6/y7R9049o0fL8WNJYGtd7YgOg0LmixOuxoQpU
	o0hnSKCYveNPdrNEZ5zVWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790258966; x=
	1790345366; bh=+MyA+96EFUyI0C9XxKcJAzHsZF+Wb7LcjCehDaqqOG4=; b=i
	19EalRl4a1eOJ3I1/MFb+GR64PZ35zM5BxAzIXdfEZp4QwxB3AbEVINVmYVfBbyh
	vwBPJ/4b5OPLcM+lVezh5YdtBQZVFH7iwjQ3rSI4wOFM6OSg1Spw3tfCT1ftMVbX
	aPQxIa5hX0Up0nJEr5shtZ+jI7DtNhAvzl4xPxIqf9PpkmoXZVcV1cM5xPJTlC+Q
	oXFRSLNx4V8FDGYh+bQETILvTI/uhOB6EwLdM5LfdEaL/iRP4ZLczbfhX21ACqfU
	XR+m7CPyY4CMXjk+3v8iMlfvsWQvEkmCwFWrVZjclgCwiGm0Jh0sfJFldDDytVu7
	OMvuBAunGNjfr6pu4hi0g==
X-ME-Sender: <xms:Fi-1ajoHunTHgdvbnzu12tUgT7pzStUm_czL_tPWjF9uC093KarHpA>
    <xme:Fi-1ajrPvqNlCBDsNwPFPTREQCRloxvs17t3Jpe0lz_SvkvFj9-7M4PntMeJGuLbV
    mWQ3muPyTTl5hMunUFVxjumg-wqDoFj9htZd2ALz35KgHJb_tQFvjE>
X-ME-Received: <xmr:Fi-1at1NLbBqqzuy9bZvZ8FxoI5JcjDXOVwwmH0F90jtY2S3FZY7KuKZilO40GHzkRO7s1w>
X-ME-Proxy-Cause: dmFkZTEe2oZmtb0o+7ktXGHj6AU+Zmd989UzScVbnxGCjxt2/WpNO4oLE5ek2XerOT7J4j
    Mgd1+x5daEZ0OVlwX/vBb15HeLRKlyebjnI3vT+Z5HgqNy2rfJWgk1D5N8Rsv2aN+U7gx9
    1u+20nMtlqtMhJiZRkLIKEr2bspOitfcQvgcSknxrH0plDqJR2dXJErWSZOWHuJ1IzI9Pt
    Pdl09pmJx0PdGuKK63Kty83Fqth/RapvQa77a0455MSYJX36XIEvvZpmZ3yW5JZhk6I6UW
    JQIZExA4oVuwpHC7TX4lb9kk86LwYC4YHY3ZlHJXi40Gg++yq8NFkpW2BohM9WoikUAFgJ
    uOu3L5NWdSHNNxFy9c8ZQ1XtvXzYugNnOO2eKHSgGXow2g74r6vcbLZ5fJwa6jGhFL5P6z
    wVmmCnkjVbd4PXMeEJeqOUpmJx7Kj7LlE7H0OKFoTAgKucRK9mA5Eu1gXGeCQ6IADQUwYs
    0XLrvKfHhldnhH//09plUfqtr1h21LPm2kM7sQczVITmvL+ndqzp25wkJWhYawNOqBbB8l
    RaEr7krv6KjJqtbgxDoZRbJzyTZgpqnRfl2O8CzK4LhHuqwnrNBXYTJNtADQBdkF9dulrU
    o5QlVfUjbjB/TLow/iMrz2qTx1myY6At6tS/b+b+mR1EPTsu68htwenOuClg
X-ME-Proxy: <xmx:Fi-1aiD-1EzH8t2S3pIQoiP17Xpqy-oRFBv7P_8Gv182xfv6IOCCVg>
    <xmx:Fi-1aldxRwL0zPHHWRWcMR9U4dJb_rrOrBGkOwQF6kEOfSv1ME9V5A>
    <xmx:Fi-1anhXC7RumHDLcNMoSHSA1FjTu55XOrq56cyeY26KXFWfp7GTcw>
    <xmx:Fi-1atrAnmd2bhVDcdUaBoKDmGKwWPkrUTlVPE14ksrAnzy2mFGCaw>
    <xmx:Fi-1aiMxfG8rOnBp-9U2BKr2EKGR5yYQJGdAzkLwNgqmUPgFEYwZll6Y>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 10:09:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a5e24f99 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 24 Sep 2026 14:09:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 24 Sep 2026 16:09:12 +0200
Subject: [PATCH 3/7] meson: use precompiled headers for our test-helper
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260924-pks-meson-improvements-v1-3-90b7f79f1c4e@pks.im>
References: <20260924-pks-meson-improvements-v1-0-90b7f79f1c4e@pks.im>
In-Reply-To: <20260924-pks-meson-improvements-v1-0-90b7f79f1c4e@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.15.2

In 671df48df8 (meson: precompile "git-compat-util.h", 2026-03-19) we
have introduced support for precompiled headers into Meson. At that time
though we only converted "libgit.a" to make use of those.

Nowadays though, our test-helper also consists of a bunch of code files,
and all of these include "git-compat-util.h" via "test-tool.h" as the
first header. So they're a natural target to also use precompiled
headers.

Adapt the test-tool executable to make use of them, which results in a
surprisingly large speedup for clean builds:

  Benchmark 1: meson compile (version = HEAD~)
    Time (mean ± σ):      6.363 s ±  0.033 s    [User: 92.858 s, System: 22.500 s]
    Range (min … max):    6.311 s …  6.418 s    10 runs

  Benchmark 2: meson compile (version = HEAD)
    Time (mean ± σ):      5.327 s ±  0.021 s    [User: 75.135 s, System: 20.373 s]
    Range (min … max):    5.299 s …  5.362 s    10 runs

  Summary
    meson compile (version = HEAD) ran
      1.19 ± 0.01 times faster than meson compile (version = HEAD~)

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/helper/meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/helper/meson.build b/t/helper/meson.build
index 3235f10ab8..ae513b4cdc 100644
--- a/t/helper/meson.build
+++ b/t/helper/meson.build
@@ -83,6 +83,7 @@ test_tool_sources = [
 
 test_tool = executable('test-tool',
   sources: test_tool_sources,
+  c_pch: '../../tools/precompiled.h',
   dependencies: [libgit_commonmain],
 )
 bin_wrappers += test_tool

-- 
2.56.0.rc2.329.gd58861e689.dirty

