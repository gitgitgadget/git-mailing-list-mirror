Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAD01D0F6C
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 08:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731053843; cv=none; b=qGWcZTiDMxrWiDGPLz5Bb933sRPwIZCgAwaFkK/zYWxSZkF9NG3TO1SGfVcAvEIrHHnYFiKSYpXzetvuO38suWNLeHRGHL4SBtS7Rg5dzgwCupAp6XSqLLAuOL4LrIgFxtDzE0hFnz3MdHQpQIuIUZnPiuer08Fea4ohtwyJVGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731053843; c=relaxed/simple;
	bh=zf7CPeEuKlo+gdNdMuEl6h6maMdVVl+mYFgopSuHcVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g8fmxFoPbwoHGHJOgenqVaKVhIRQJN4UKuy1aDJRxqy/FOfLusy5m2zKVSKGKCRgCgx4LCbLNzokECbHGuKPM4XvABxLO2SiTjhN/Ze/WQaitmY8qrCOzX7oUi6cjQ/nrfcJ9c4+cm0A3Dwg00zzGyxmS88buHaaFsYg+HSUCT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UiameIhq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fYN5l67b; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UiameIhq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fYN5l67b"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id ED9AE1140187;
	Fri,  8 Nov 2024 03:17:19 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 08 Nov 2024 03:17:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731053839; x=1731140239; bh=8rgfsFw0KS
	EMo/r6TkRSH33g7JT+G6t6YjBl7VQjbJM=; b=UiameIhqqeyDt3RXC2WB2rvYx6
	QilkSmXTz+LkuPVD5TmdbUhlPJ4TxXC1RpV6cdolV3EmIUYrM5a85AiqAdd5IPQS
	uUtyMkHGxSCzEdJkg9YzgrPC4LI/P7Yq9cgjsgtob6xbm8J8N6XbycZUsfg6htmc
	CtT06CR0IzDa8aFW4XT7YGJneYGPLJcKuYPxyelqs5RXuXW+eH92qVMKnivbSZXG
	6o4Ksih3BBTHBdtNmpyibRZMpTTMMgzwnsDS/NbBIKBZTsIGzyrs+YpyFXqfhft+
	+yXZwm23Ldju2fJpITkC6IimYjUV6KlCFJNEps7h8OfJJ2ZfUViK7lQCK/iQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731053839; x=1731140239; bh=8rgfsFw0KSEMo/r6TkRSH33g7JT+G6t6YjB
	l7VQjbJM=; b=fYN5l67bjQenn/mif1c5Kusg9dcez/TRj5pS9WcJre2M23hoA+J
	uHXZmd4wdZIBDN/Vzg9olpLHrV9xHztkt0QXNiFLpgeNNRUcmLt37V5CzOv3aR5Q
	LTYzYIaVnYY5hQz776mJiAH2TbtXVL4L1OKzVd3zlOSI6cY1/BkFIv3XstDURz/+
	AucdeRznP+PA6YY5d1w91jCWfTQG6dQdtV9VGfDFW93rMc3Gk99JO1nvfP7zvoFA
	jbETXqIsOOTaGO+0mXt1abixgDgmv/ZnNSr8JHrGVK3/4C8HvC9Gnu1hibq/IyOF
	khWRBII6juv376cIibppxZdJXlIZ3hOWaeg==
X-ME-Sender: <xms:D8ktZzOQUsIzfCJun6l0MGo_lUfW922w_Xy5KGfgEtDn5aYwryg5SQ>
    <xme:D8ktZ99Tr1upgbSCwHHdOxKiAEf3EMeMC-4So5BeImAbBZJKuICtaj9qjj1Wa8C7N
    UD6E5snWNfLOGBlaA>
X-ME-Received: <xmr:D8ktZyRo9TmxzLV2QQy4zLsz6AnTCRrCzYDJ89WmFkz9L-F8b83yl68PKmNRd3i-GvoCdRw1WUqKwXtvcDb5wxOI5AfxP7zBQ2By2iMwloaOb1k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdehgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsoh
    hnrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtoh
    epjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:D8ktZ3sbIae7X9hO2Szmdm5AfzX39HW5rz-62POZwI596aLBfpnRrg>
    <xmx:D8ktZ7f5cCMZXy0sE1hFcWXKjNA1JQYz6yUsK-zELv2qJECaKnRycw>
    <xmx:D8ktZz1ZD__VKrTwtEbPu9K1N8Ty81A4Zky1tLOUsEZYzMJyxDaQ4Q>
    <xmx:D8ktZ39ejwAx3R5t0wr3JGv6YeNJwQh1lRmPG9kL5l_sqtTiTMSWkg>
    <xmx:D8ktZy6eePy9T0kb19sxASpEQp7DDyfBdCWjKYTTRD4uo89cZGJ3ZBLd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Nov 2024 03:17:18 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 32b65bfd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 8 Nov 2024 08:16:49 +0000 (UTC)
Date: Fri, 8 Nov 2024 09:17:09 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 1/7] reftable/system: move "dir.h" to its only user
Message-ID: <2b7d4e2852977659752f98b782784eaa6780bbdb.1731047193.git.ps@pks.im>
References: <cover.1729677003.git.ps@pks.im>
 <cover.1731047193.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1731047193.git.ps@pks.im>

We still include "dir.h" in "reftable/system.h" even though it is not
used by anything but by a single unit test. Move it over into that unit
test so that we don't accidentally use any functionality provided by it
in the reftable codebase.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/system.h               | 1 -
 t/unit-tests/t-reftable-stack.c | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/reftable/system.h b/reftable/system.h
index 5ec85833434..8564213475e 100644
--- a/reftable/system.h
+++ b/reftable/system.h
@@ -15,7 +15,6 @@ license that can be found in the LICENSE file or at
 #include "lockfile.h"
 #include "tempfile.h"
 #include "hash.h" /* hash ID, sizes.*/
-#include "dir.h" /* remove_dir_recursively, for tests.*/
 
 int hash_size(uint32_t id);
 
diff --git a/t/unit-tests/t-reftable-stack.c b/t/unit-tests/t-reftable-stack.c
index 72f6747064f..1b4363a58fc 100644
--- a/t/unit-tests/t-reftable-stack.c
+++ b/t/unit-tests/t-reftable-stack.c
@@ -8,6 +8,7 @@ license that can be found in the LICENSE file or at
 
 #include "test-lib.h"
 #include "lib-reftable.h"
+#include "dir.h"
 #include "reftable/merged.h"
 #include "reftable/reader.h"
 #include "reftable/reftable-error.h"
-- 
2.47.0.229.g8f8d6eee53.dirty

