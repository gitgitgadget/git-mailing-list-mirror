Received: from pfout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2761AD270
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 09:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725354905; cv=none; b=YWAEQUj1qMoqseSs0OLrJ6GnRaQU0TDYGeiDMysx904+yuQp6lgcNcunnMZqGeej42PJnnLYn653TQSQAj7o/OdpHUFtvvjl7xguOUiqaWv0hPJ+rPvBlhgfpaPSFgQ3xhNYxjURsVCj6ZoU5rpBOQjqPI8LEHtJisvVPfF4pvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725354905; c=relaxed/simple;
	bh=9XP0vs65LiszYU0sLs9vKvp/bRjlHKjOHzyyAaWwKv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NOSpyHdTdhOR13meO4S1mkTXQ3+RsX+wTygmvqiqKucbRCPJZ3e6lSYLpLLK3U5Is/gT5KOtAvL8hQFuxnR4HkvsgY6drRMIcjfe3yXt2vSI6iXEe9Go3IfdhTRCYDydKkjYXlvGRWsozFTjnSAa3zkmJiuDIOq3wNkMK9e4Ha8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nJMeZvqG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e2KVUpof; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nJMeZvqG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e2KVUpof"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 407A2138039B;
	Tue,  3 Sep 2024 05:15:03 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Tue, 03 Sep 2024 05:15:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725354903; x=1725441303; bh=18qPGIFS3f
	njLyb+wgq72v/rvEgh6NPfU6ZJ8d8Xx4o=; b=nJMeZvqGa9F7FlOU6eRi4pSrHN
	LRJf8rBZIqkOGJ1fU2r23HMexo9bOxzhdp4HflDKZ1Cb/3TXdu2hlU9l96EYdr6S
	e32cjqZNJPjhr+SbXcahWbllkkTg7vmkHMy4Hon2jpIdEtIGeZAQBJfC1sUIsjoY
	/y5G0PhqQ5y88efXHFeNhGlvueSgxUxDL5amc+rum+ZA/Jq4RtrvYLrwfyH+yQXF
	Zd/dkfRmTQO72p9QLvKPkLq3/ofh7cnDD+VeEnKyCjr5XdouANNQZUWejdV3VDG7
	Gx5pGS3j3NEFscq//MDUUTuePiMDBhX6hdCKWP50S4iZNcFcnTXsNrlt+48g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725354903; x=1725441303; bh=18qPGIFS3fnjLyb+wgq72v/rvEgh
	6NPfU6ZJ8d8Xx4o=; b=e2KVUpofaZzVIgWUbszY7Mc9Z3PQa5Snx75JxUpa9U/i
	a1b7W3LkUzbXFqgADTCcuVGYp1jcxU9DuMB0rnp4k4CNJ4ujQarKIyZbl0dov1Ub
	R3vDhjdOk7G+tPuxL6g5Cc30S8ZroGHYwtptjynTftFOesUbSh5tqu+SZXx3E4+Q
	/Yf8h6GblPKMbucie7oQ7WzGbyFXsu+U3wr7v0g1OZKi6G3igVfLReP8s/RsCoze
	G3ru/EP1Gt6bGHMcUon7eNX7pvP4yOXeYyBbC9wXCssbznP5Npip9/iqjITqZzbC
	4dBnSLajw54mUBL0DA6hyXtPfPY4s4IgCND1v85vMw==
X-ME-Sender: <xms:l9PWZq_MQEZ4j46GNCrQHuQLb9bVtLiSv8jOO1lUewI3yhaQcriEyw>
    <xme:l9PWZqt8xtzzIdBUBYDt4N0U3exUlKppM13cblVYBu6IleOncyJ6aR6OFfbFDxqaD
    lIqrOzPf6HICNFMOA>
X-ME-Received: <xmr:l9PWZgAPiYOIAJ_KF13OZo2jpGILAeB_ZX6xSr2yoz9aZiv0FN9YRZgXCrOxU9plC-t3jJJklo5D4GAJd_6hmPUEe6UgUfvDqUDt1eSqc_25QQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehhedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprh
    gtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgt
    phhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhpvggtthhr
    rghlsehgohhoghhlvgdrtghomhdprhgtphhtthhopegvthhhohhmshhonhesvggufigrrh
    guthhhohhmshhonhdrtghomhdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhssg
    gvtghkvghrsehnvgigsghrihgughgvrdgtohhm
X-ME-Proxy: <xmx:l9PWZifPuD1PWDbcX-BgnATezo6XcO4Jn4SbRg8suTGdDsKwdybMQA>
    <xmx:l9PWZvMBBVi9IYAP_ODZBAeHixpHiGDsNl4zKdLhgpBWZVmqEaPBNA>
    <xmx:l9PWZsnCzAAQ0VEiSsHgPjusw1uhVpghFodPApff8-QLl6JNi_FZUw>
    <xmx:l9PWZhsXGaA6Crw3URbyHa8LRNiK9uW2fhU4wT-KYv_oy8AGny2STA>
    <xmx:l9PWZqoHTLju-dDEondCTyfDFE9lOlLKLQjXAqLpbzZHRtpl99rPRxvw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Sep 2024 05:15:01 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5551cb73 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Sep 2024 09:14:54 +0000 (UTC)
Date: Tue, 3 Sep 2024 11:15:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v7 09/14] Makefile: do not use sparse on third-party sources
Message-ID: <7d0f494850a48e5285e8823ff9252fdcf531439e.1725349234.git.ps@pks.im>
References: <cover.1722415748.git.ps@pks.im>
 <cover.1725349234.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725349234.git.ps@pks.im>

We have several third-party sources in our codebase that we have
imported from upstream projects. These sources are mostly excluded from
our static analysis, for example when running Coccinelle.

Do the same for our "sparse" target by filtering them out.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 8c4487dd0c6..81a47b61327 100644
--- a/Makefile
+++ b/Makefile
@@ -3252,7 +3252,8 @@ t/helper/test-%$X: t/helper/test-%.o GIT-LDFLAGS $(GITLIBS) $(REFTABLE_TEST_LIB)
 check-sha1:: t/helper/test-tool$X
 	t/helper/test-sha1.sh
 
-SP_OBJ = $(patsubst %.o,%.sp,$(OBJECTS))
+SP_SRC = $(filter-out $(THIRD_PARTY_SOURCES),$(patsubst %.o,%.c,$(OBJECTS)))
+SP_OBJ = $(patsubst %.c,%.sp,$(SP_SRC))
 
 $(SP_OBJ): %.sp: %.c %.o $(GENERATED_H)
 	$(QUIET_SP)cgcc -no-compile $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) \
-- 
2.46.0.421.g159f2d50e7.dirty

