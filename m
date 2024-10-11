Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1019617BD6
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 05:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728624739; cv=none; b=FE9awuhRZtsOrcHMV6Qf9SsPHGh259NUaujN7pnK93wAF6WUTrjYpjF9PLbJPVklh2xS9uwHT8OYVcnkk+IuMSyVAtwxlvzzflZHKyksSdYM3sHg1JPQfdCkwTAW2akbaGG5xWOVSdr7P5pEHzDgPxEFKkgu/QA2JddstpipCFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728624739; c=relaxed/simple;
	bh=fydoxPwjhJ+k+VtyhOJCFs7cZMyh6z7GSwVga/bf0hw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RTNZFCpO3kogWs+lfu3xs45D4ivFSh294/aWzaykxxZ7jVBC1p7XiYz4oNl5FqpFatfPVJK7eoMgwG5jMhpF+VkCpkKU6aQ50j3MCPYfYS+Lq1d1ZpBK9nSGKtL0yfMeqOx+xWsbigciNwqjhOO98aHwW9IyNnKO1YTi3smvAtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=j93oCPKB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D33R3/MK; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="j93oCPKB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D33R3/MK"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 13C84114012D
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 01:32:16 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 11 Oct 2024 01:32:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728624736; x=1728711136; bh=VrAZbGW7E9
	9kZwLB2Evv4uDBAw/sW+wiqL1oah4mDIQ=; b=j93oCPKBF7H6mSnGnySPTlX+g9
	9gRmS4vY/4dYHdTB6zigX47TEWoGlrEIPAK9DuBeaCb2lZYjMNP3ncIkVK04dO4X
	zqxwMl7CySDry9B/SVGKYDOXcGMB890zjyJi6pK7KmXuYhlWMvJhhj7Ldph29iFq
	mvnlllEJsA8einf2UzhJrnPpMxh71Thi+T1pzF1KEp4d5Zxs0UM1A4IxM3859Lld
	aAvXN/7Icw0LJIvmoWW/sS/f93ik3e2vaqdaEBNYqVXbvWmLejzPrlwnoq/Sp0j3
	qEvXFOctxLCfEvdweV+Tz0lQyxyjePchWfliBsDWpgQnrXal+NRgL3XK5AGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728624736; x=1728711136; bh=VrAZbGW7E99kZwLB2Evv4uDBAw/s
	W+wiqL1oah4mDIQ=; b=D33R3/MKvsw2HJ7EZt6HdSe8mrOv9TuU1Vkfwwtb65LY
	qU1ELtQLLxTpVX3nQY8DC3XW5R/QY7Q4AsI/bVwLgbPlQsr92HEwtf3K18D7MJLy
	3y6X0jvVqzcCHFmHthZPcMygYK8DTASCa8mZQKa6tIG/2Y7gZkpWuMJ7OlsKUpMD
	bmJGl4P3c5XhxcQButWxN+5KgjN8nwcSDhSjtxT/f/8mXPeH8fZhKGauxCh6hruu
	sbUbAojKrr8nlupZ0D4JGmlDT4ErTm/Ur6lrQxsaAqDAdqUDlIQOTzReBn++xUpA
	aiYMF1I/ILVr9TUvxvcGn5mscF78M7U9+ZlY01UL1g==
X-ME-Sender: <xms:X7gIZ1k7X1Fs2XPmhIonGcn72VG5fnZKCCn7t6DCnUn3XBEA2QSHXg>
    <xme:X7gIZw1X4GCGUh9WeWF0sjdQ5tKXdpxUbEo_5fAhADEeECZEyu8isvItlhQwTTmBf
    vXI6Ht_oghl7_a4HA>
X-ME-Received: <xmr:X7gIZ7oWF0sk8hurONZFnu5cJPvMxoLYuymNIEEIlVRQ8QzDklAg3LZCX2GJQ68JH_BLaL1orwBzPLsZ6i45tsCivYMAFSVxtZ-QM2GfVHysTVw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefjedgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:X7gIZ1k1mzsYnqoi4e_DcgSkutxf4v2ZGrTbagsgP1nUIXhhlwhXew>
    <xmx:X7gIZz1xU2vtz3poafVbgsxwx3RXGuvXqiUjLRcqceWKKK2sAEcbVg>
    <xmx:X7gIZ0uhZnUu0OxMacnGEkppfVlOXlGiCwlXG2MsqNnMsIeBdER6tg>
    <xmx:X7gIZ3WgXV_Jq7krQ1OnoehdkRx5ZbmLczTYHQBbjLuDrvhYD--OBw>
    <xmx:YLgIZ88yWC0aCq6iuB9wLKxpq0tiyx9C6RSjuC-35rITBAa8iAYhWwEZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 11 Oct 2024 01:32:15 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5674dc25 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 11 Oct 2024 05:31:08 +0000 (UTC)
Date: Fri, 11 Oct 2024 07:32:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 02/21] t/helper: fix leaks in "reach" test tool
Message-ID: <1c42e194b20637ef84c61b62e29fdd9047b1acfb.1728624670.git.ps@pks.im>
References: <cover.1728624670.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728624670.git.ps@pks.im>

The "reach" test tool doesn't bother to clean up any of its allocated
resources, causing various leaks. Plug them.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/helper/test-reach.c | 10 ++++++++++
 t/t6600-test-reach.sh |  1 +
 2 files changed, 11 insertions(+)

diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
index 995e382863a..84deee604ad 100644
--- a/t/helper/test-reach.c
+++ b/t/helper/test-reach.c
@@ -127,10 +127,12 @@ int cmd__reach(int ac, const char **av)
 			exit(128);
 		printf("%s(A,X):\n", av[1]);
 		print_sorted_commit_ids(list);
+		free_commit_list(list);
 	} else if (!strcmp(av[1], "reduce_heads")) {
 		struct commit_list *list = reduce_heads(X);
 		printf("%s(X):\n", av[1]);
 		print_sorted_commit_ids(list);
+		free_commit_list(list);
 	} else if (!strcmp(av[1], "can_all_from_reach")) {
 		printf("%s(X,Y):%d\n", av[1], can_all_from_reach(X, Y, 1));
 	} else if (!strcmp(av[1], "can_all_from_reach_with_flag")) {
@@ -153,6 +155,7 @@ int cmd__reach(int ac, const char **av)
 			filter.with_commit_tag_algo = 0;
 
 		printf("%s(_,A,X,_):%d\n", av[1], commit_contains(&filter, A, X, &cache));
+		clear_contains_cache(&cache);
 	} else if (!strcmp(av[1], "get_reachable_subset")) {
 		const int reachable_flag = 1;
 		int i, count = 0;
@@ -176,7 +179,14 @@ int cmd__reach(int ac, const char **av)
 			die(_("too many commits marked reachable"));
 
 		print_sorted_commit_ids(list);
+		free_commit_list(list);
 	}
 
+	object_array_clear(&X_obj);
+	strbuf_release(&buf);
+	free_commit_list(X);
+	free_commit_list(Y);
+	free(X_array);
+	free(Y_array);
 	return 0;
 }
diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index 2591f8b8b39..307deefed2c 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -2,6 +2,7 @@
 
 test_description='basic commit reachability tests'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Construct a grid-like commit graph with points (x,y)
-- 
2.47.0.dirty

