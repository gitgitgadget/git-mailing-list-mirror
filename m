Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA4A1A0BDB
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 09:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729677361; cv=none; b=mO4Q2NxthGz4UpkmaaiYNhZKEeCAzH7WWN1KL2XKLiImsSewlNNLqDTy8LQVheHL7a9mjpdK16YdqWW30pSYVWQmRHS6weGgNwW3EsrTdhLdL3aoIwyZL/Yoob5kdWGKjHD6T6i5vw5iE+npmzA3kjjeJtOCTNcu8xfSkACAqvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729677361; c=relaxed/simple;
	bh=ZvG0CTvviSi6MsKPeBrrV3ItUW/A6ugiRU3MTKkTLeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pd0Y+ToWY2lATUvmG0iMjqX0BxD+dsY3f2Ftw66D6aafaoioQtWKYrJRKWdWyu1xkEThHAkMYXiz0+Tx0ZqL0Vde1vU5/Gw9rJO3omX3q5QO1rbMs28zVCetlgPnh0FYADh+Etig8VudC8vuCxcr20zWv1t+RfvPyzssXYmvyhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SLlQogTL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jq6e+v67; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SLlQogTL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jq6e+v67"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 0FEFE13806D1;
	Wed, 23 Oct 2024 05:55:59 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 23 Oct 2024 05:55:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729677359; x=1729763759; bh=xjBMqbWqrQ
	466h5d+gECwSCcp/pHTI6IuQzDezNE9C4=; b=SLlQogTL6odGXurXcxIwpplwVs
	aaMbWamAQRqK5sjEirMfIfWwgofy0ySu9Ccu1kX5TKlcr5vHwPxedSAkhM6ZhZR4
	kz2+vc2HAXMU6HMUtkun81wx3UwHF6KjAX/b2zpfa/3+v+kS0QZP594/CuIfp1hj
	DM8o+a+i3YA6LpqmfybDIagyNtLH5vOYgW7Mm1WvRCpEj1t+U8s+W55amZkVV/a/
	G3HE96Bxf1qb9NGay547cTcMcyEpmSzeBOQ8/IV1OlHM7oolG5+2x9Xg9dx5YRCZ
	z9sptlpG7V+W9ADwc+agLnmjwwwqXUhaN0FK7Ij52AJ7wxQ9tM5v1hz+EPpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729677359; x=1729763759; bh=xjBMqbWqrQ466h5d+gECwSCcp/pH
	TI6IuQzDezNE9C4=; b=jq6e+v67VyrD0YBbH4p8EzZehYX2erdHMSnU8MCwOoIJ
	qT/OkoRNXjb7B/xq7xApc6aYSdpIVf2NBjPWJ9oGQ9uDyAW7KLn23UUd3GQ50PNi
	5oqp09USnkAwH+21bquFn88dy5iE4jzsIn138Q/GmLZleJBIYZwb8aiPiFqFYwJa
	BH4r/PaL8AfP+QbmTH6fYby/yoOQV1xRJbVaje/RQE8BGVZOTXEswDt/PT3QoISM
	2s2odmEaFjUa3HQ0Udgv9v/TWNnHmZcOchlUsnxKw4EHwJ1e0oDBWHyVtGB9TmJ7
	q6D4SSNgdAmrpBKXa1hBYmoU1oJf3HQsEM6/V4bgzQ==
X-ME-Sender: <xms:LsgYZ3bVvOe9AGDtJPCBae4bMZjhdoSfK7MMi4dJWwMePmd9gNsZ3A>
    <xme:LsgYZ2YD7bebbpp-qD9oAnJL6uRENbhC0sv0yUcyyx4b7Mler4QG6c42l9aaEIcNV
    oPTo247Nv7-bZRxkw>
X-ME-Received: <xmr:LsgYZ59uYM7bxFqD2YWGjDkx1M3ubHqcW-zmW-iJmEaqRlPIfo56HXKA5W-1c5cS8JWUtpUF89FhDriJWJ5QVZ_wu4yVStmK7r61qJvcLo2i>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeijedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomh
X-ME-Proxy: <xmx:LsgYZ9pf6aNZKsfkZZyykYLj9VBQXALnJ5-bM8CKTiKKMgVnBy8Ljg>
    <xmx:LsgYZypwtxs7vYZHHesU0Sgl2WCpcyKEAa7WxQwkGhyCyO92Z_QAsQ>
    <xmx:LsgYZzQaf-9RZk54dXRlj5SjbNeHCj6B2sbFs2I0dLboPsiyijJ4EQ>
    <xmx:LsgYZ6pxNt32LXLwnAfszPLbM8q2Qi93YeyrzCBhfiTvGmYwAT7BIw>
    <xmx:L8gYZ52YLIrmAhqucZojMukScqvCY8wC0WNJY1WXWd1F7e3RmYHX89JF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Oct 2024 05:55:58 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f1377b8d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 23 Oct 2024 09:54:27 +0000 (UTC)
Date: Wed, 23 Oct 2024 11:55:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>
Subject: [PATCH 1/7] reftable/system: move "dir.h" to its only user
Message-ID: <036cc8f9d602a817aa579092bdeaef5d1156214e.1729677003.git.ps@pks.im>
References: <cover.1729677003.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729677003.git.ps@pks.im>

We still include "dir.h" in "reftable/system.h" evne though it is not
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
2.47.0.118.gfd3785337b.dirty

