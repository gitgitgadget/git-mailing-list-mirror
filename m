Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C591E1C0F
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 09:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729502893; cv=none; b=roVxixXJbFcQrWI1LmHwCwo1ssMiR93iq1tDgwJiUJKd4tfEOZBn26262it0edtvwxjmbT1z7D+9hJ95F1pNr5bRl8zYxup9LwBchypRYrKTGbKkHAW0qVGLkt3WYyiugtyAu7WfNIx9IjEs7bGDxfk/YJdGdXbXS5nwQLy1wtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729502893; c=relaxed/simple;
	bh=D2fSJQ9+ZxXd0X31e/PhWWFaaUEOfgYFFLUWFhJWKwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PAXza/W+lmCdY2guvOdzPcwPFcy1dLcfSMrynYuv2ndSv7XDA/1EvW2R5dnNJR9uZ+mVzY/IJHVYqGJe+zeKcnvt2TMffI0Ng/whdUHCP3bcOtVygOZgCyObjebQJ5Es4uvdijAG2Km/ZAq0+ybHCnN3yFSo3T6YyEFvy6iSFVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=t8kO7nzD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KCMWpRRf; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="t8kO7nzD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KCMWpRRf"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2DB421140231;
	Mon, 21 Oct 2024 05:28:10 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 21 Oct 2024 05:28:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729502890; x=1729589290; bh=ZnOsdoOgQm
	VepR3/YIUCjUjm/kvhyQCxmoiipYAGtz0=; b=t8kO7nzDoOCGtu5615wOP6dY2A
	fLu+086zQC84yyQ+c26Xy7kp1s9adkOC0MhYB4FLm4wGj8c1qJxmvG2T9A/AiXy6
	iUEBtGKmEVTfXbo+5LvLd/Ewp4MIEImTfHAhlveTfX2cHaPD+np8ZSTTgXdXlF4D
	GXd97pXTidNPvafh+K6pCkfsRnxGOjOtgsNhA5cWD7ugnCICEk46/uDJMDnqDJUT
	X/V8TCcAijVxMnIL8/BiRIPFE63RDwZRAEymPhqYGGvhQbnZOqD9h+rYi25HeRAy
	umX5rzPtCCEee2J05VRkU+fqI8Vs4vNOMpReZhxUAWYbD7gfvRrxM9cJgUeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729502890; x=1729589290; bh=ZnOsdoOgQmVepR3/YIUCjUjm/kvh
	yQCxmoiipYAGtz0=; b=KCMWpRRf0swbCNZ6/M4Wl3CmFTbgKodkeKczgs6mCu77
	tY7/FZPJIJXTO7jxce5zQgAURpDrJJfIvT7zyEQ0Ztq4qSbog1VwP4TE2PQy3sNh
	ZYkbhkMXZEMtOTHfHut5c1Awaz0ze0GkFXONHi2JDBu/FP1ECGueYfrtXx0tj2n7
	KM0Ch+r7rOwfLrDY7nMk25P/RHUseDJOn44thzgHAzL2TSfnIJ5yMXdsOpDLYym7
	SK6adnOb4iA4cScJK70eIFoEzClzyGekUme3GUWvHxzWqWBvLP+Dn+RR3NIKQ08B
	P/NyNLufzxVO1NED1pqqNzchahj5i4y6NmRcTs5kAQ==
X-ME-Sender: <xms:qR4WZ0mtkJOh76RDtdTnXEKjg8tJkky-iWKNArtAL9RQ9tAsQXf_uA>
    <xme:qR4WZz16iyWA23DtV3b8w8qOyMZJ1ge-5DpiiDe3yxmJx4O0dmK7DH_OjIc5eJVJ_
    Ago_W7X-Pue2cfQng>
X-ME-Received: <xmr:qR4WZyoy0tnqXZZtPJQqdPucwUAwwcmVhd78XUSc07g6kMSWrIMh7aKWGjD_m2G5V5y9I_DSEnQ0pLNbS7I4PqmkmpA3llQan4zS6mW5XyLT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepthhoohhnsehi
    ohhttghlrdgtohhm
X-ME-Proxy: <xmx:qh4WZwmELIeBb2naJqQuQS-4w8vii6APDuV4mu0y6QCnVN7FHGarfQ>
    <xmx:qh4WZy0SJE-jpyiURF5ukFegu6PaCuvzsjkk-3cCnlG3T7vRPVO8NA>
    <xmx:qh4WZ3vHEmN99y7ObFHyf5EjV7JnVzQTgJAEo8HvkwL33quvvp5d3Q>
    <xmx:qh4WZ-UCORC2kTMZ6U9KtnZJpOb1j5WUTh-lqTr10_HRMbE70LnlGA>
    <xmx:qh4WZ3yBwI7isSdBUTMDFRnQcnqyj4chmo2rOpc4dA7rJRMF0bUiOWTd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 05:28:09 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 877060c8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 21 Oct 2024 09:26:42 +0000 (UTC)
Date: Mon, 21 Oct 2024 11:28:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>
Subject: [PATCH v2 02/22] t/helper: fix leaks in "reach" test tool
Message-ID: <1c42e194b20637ef84c61b62e29fdd9047b1acfb.1729502824.git.ps@pks.im>
References: <cover.1728624670.git.ps@pks.im>
 <cover.1729502823.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729502823.git.ps@pks.im>

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
2.47.0.72.gef8ce8f3d4.dirty

