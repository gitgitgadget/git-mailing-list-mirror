Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4373E1CACEF
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 06:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730787418; cv=none; b=oUhLFCs5EheTCVXiYDJf5WDjZgsfDRuz7UynpS7aJnrxxkNDAbT7YLtxRHxJz+tOjdI0Z8PrW5yUvZwV5P89r9YGR9echVAdo9Hu1TouEsn7O4EselSVVrPL4Nw2AHxK/F1XyTT3kzL6hod4B+vhhH/iZ26QquId+uolVsHK8cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730787418; c=relaxed/simple;
	bh=0MLZFXeGkvYB3QfhXpiEk8OUmZHrmbZA8PrYdS7Pzhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GBJ7aJgHTt9iwfD5M7leOmu+dLcZtFu0nvzRPBCIGl/RehpMH/l71BAfArUa2v1JsOCPiZyjPHx39Y6r0BJZvvYXVIr/dvdwrVd3aEF52eK5ldefME72UTB2UKqd6d8oVXF69jmjjpUXyVTnMI3MmXK79DZf2yGPKYoz/6znAvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JvrZmS6H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GCxC3SeL; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JvrZmS6H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GCxC3SeL"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 4A709114016D;
	Tue,  5 Nov 2024 01:16:55 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 05 Nov 2024 01:16:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730787415; x=1730873815; bh=6WNRruvS2n
	ZmwmAuGdZXSGwKSxMwNsEyxiW4tm2hJys=; b=JvrZmS6HWNLDlSYMoCqVoBIwFS
	japHt4yeM2cyx3nyq1PRKEDQ4fQ+UxLaL4/sAjoycQi11gSzXUxWWqSTjTV9eSap
	pPL3wskWzk/gMphXorEiPubIm994gLiwlYtU5RDR0EQL8sbkWsWNQ3SM8RjcRXk0
	qPe7Py5QuxaI7mK+jUekRD/9uIAXvKEQeSBrdVnGK7x5zAQ4xgkNvlf540zRm4Z5
	ztHwz47uWUOV1WZpJPCtHXgHFPf1BBPwI2KAKejIRjvyElmDMG4ANW3zWkAuKhAl
	Qww6dCoYDkuRkHFjECWuwPFi/Pg8jb/Fmqk48ONS6l0oSM3CA3qMYCKcMz/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730787415; x=1730873815; bh=6WNRruvS2nZmwmAuGdZXSGwKSxMwNsEyxiW
	4tm2hJys=; b=GCxC3SeLDq6nuz1Uj5uewIaWmsa+KJ+QLaGknWlXdYTaR2Ee2vY
	vbr5QvwQShEF/9WH2S0kJx8C1LUYxIJOxf/o41c4olTs4Xs1Gh4BV/JxKJJi1jyn
	jONtblUPnttiooGMst0zGGfdZowwVrZ+v6czhkyNF4NiNGaX89y8ui3wJaJYmTOw
	mQUm5FzJZGJfndkSGLq2gpvr2E1IGWVH/3+Y0+qH73lsfvmawGdd/a7iqkWrAtb0
	pbrGJpeWM6H5xCMytmMLGVNGZhPnb24njDfI7nT4QzgK5Qnr5YsfOvnaQV1Yqd3t
	zCOdt5nnpXUZckQyxWYpK70e5kbHFvqohaA==
X-ME-Sender: <xms:VrgpZ958VhRiv1K7BYzhyp5-fzAUvwrFJH0ogHTAaKBmKSDWxPOJGQ>
    <xme:VrgpZ666oEVvPs12uH7SaubshYya7XniiZC854ur7KXD16dllRnTTO9SrctWpxZaP
    TgTOAN7SMxHb0JETA>
X-ME-Received: <xmr:VrgpZ0co8AA5wH_8KbuMMnE_2tgQkuMJV23THPfJxneiO1yY2ymbB7MLiNsZypq1lbpjqDoPQ1-SD00ZzX_bALR6kLUdvK0N5hnUhVrD2d0ZSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeljedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfh
    grshhtmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdp
    rhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehtoh
    honhesihhothgtlhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhg
X-ME-Proxy: <xmx:V7gpZ2JcyCK7lrEFYUb_51g0NhIR8wbjfaVZSZSmtbJP_Go_Kjveqg>
    <xmx:V7gpZxIm6zRs5Ywgsd_TWM5JtuCRDej86Hg1f0Yt3MFXoCO2OeB8oQ>
    <xmx:V7gpZ_z90QHo4fIygKJCIx06cOXDoyuL8ua15veidX0XMnHpgMGXLw>
    <xmx:V7gpZ9Idh4_YS9O-v6gaWsmb7F9lRbttxLlxmiUbor5-beMafXFDfg>
    <xmx:V7gpZ_i_cBIBinAmXzq3wEdf9IaG7YjHDDCTB8yUHaa9C1qQkyCVhKud>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 01:16:53 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4937a3f4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 5 Nov 2024 06:16:32 +0000 (UTC)
Date: Tue, 5 Nov 2024 07:16:46 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 02/22] t/helper: fix leaks in "reach" test tool
Message-ID: <17136f4bdb39cb1ccbcc06ec4867d7606fce2202.1730786196.git.ps@pks.im>
References: <cover.1728624670.git.ps@pks.im>
 <cover.1730786195.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730786195.git.ps@pks.im>

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
2.47.0.229.g8f8d6eee53.dirty

