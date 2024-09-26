Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF63181B82
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 11:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727351188; cv=none; b=DTDlA850Q5BTlZ8tmcFGsUUtQ6pyEM++XkDaht+GSShCAOr6tVGMS5rNYI5zNKbICoObqENngW+nl3RUshb96JefY4RAR6R4KC4ep447Fz1mJkbmWjJaL3pkdM+5Gwez7p4ptn+nU5pi+buYlB1XQao/aneRnqgAljcamRPNK5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727351188; c=relaxed/simple;
	bh=m45xsLzZm3+sQx2D5IhJpk731io/BkNE0zJFW8aStvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fNHhQQX9SUjlU//5ecbRvUS/aqcEZaWO9s+9PuqWoHdP6puILeOgk5Bw6sm+b/VVRVdilZjdR5QjuwnlJAU+tTFk/ht55awa8cxniil1yCNzfVgDzbyuyO2SkO0T+XS1UTqb0vgMC78WEg/FAiu2c1a22dRdptMi1MH6G400nW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bRdCtLzl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FEY18MPO; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bRdCtLzl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FEY18MPO"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id E7A63138061D;
	Thu, 26 Sep 2024 07:46:25 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Thu, 26 Sep 2024 07:46:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727351185; x=1727437585; bh=L95vkZGbZs
	xHfGmLKvTKlID5Ma+LwgS3inQa1DbKyIQ=; b=bRdCtLzlXU7UDXqGzBpwqEOtE7
	ilPy2NHlWSgeQa4FdHrv+IVzgP1JeGuIYnUz+i8RmGXqw8Ak5YU094QLGYfey3bM
	MqUkFpGn9rOzVvRnJLMkwvLsfHb2KcnP9cUjOXZuASMaJv7ax4EYW/aNlpVGXbGH
	cNE7mSlsAKWooWzrbZfr1gBFRwB5xJxqb+P4NPloHKnxyZrukJnr9kbXyZL2bDoL
	UY3S8gZYVa0krVa6fe/Dy2ZOAgWGSYMZzQDM66gwRdflwh+u4KDBBwF/Plo9oKQc
	lOp4bk00EhJhTPurMpd5J5suDJIKwrJzpDAfCbfgeJdc7ApdVEDufqFLQO5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727351185; x=1727437585; bh=L95vkZGbZsxHfGmLKvTKlID5Ma+L
	wgS3inQa1DbKyIQ=; b=FEY18MPOZqg6gVfUMjUsMEqST0BvOrtZ4m+iK9nLOWV/
	r5FsJ+Vd6vXbNQjZ+jgTfX0cyg7ksh3pcIO4lLMtGA7YhVxmuZ7ByBf63irH06Sd
	rsd4hWtNKwNK1IVVLTpds5dLx5oyUHrSffYChrA6j8aDdphwOovlcy3/J5SzTDNm
	x42EA/iL9uEzIEb+v/mPCusKY5NeA8aP9R9ptl2pPNEVWkYpIcYbCfNl6hvqH6gW
	VhZI1bRvtH3LxY+nswqS0hb4tywlKwLydKS1I9PMI8Grd35q3MSDtbN6hb5a4yMD
	PWb0Z22xLG/PhGrYyLo6i2UlTUddtEUKcg0Uxr4vfA==
X-ME-Sender: <xms:kUn1ZlCydRpiIWkFOB2-O0VxKJpvLKGG04KLTPCHxTyD0xv3uSiI7w>
    <xme:kUn1ZjjoBgwh3RSlDDw6pRWL45hqsVwhTFdBckZby1ASujynwS2kg3nkScEW6KqPR
    4TC_Xk5V_IXUQWcbQ>
X-ME-Received: <xmr:kUn1ZgmIk-7YspT3LxVqgZt_CwtasaCZ48i3vasKzzDbLa6oYDICqiImvu9xFtCq9Ldv94UtCZTrkt-gvccPwKmwIf6CKHNtIGuGCMIh6DA1Og>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtjedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthho
    sghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:kUn1ZvxtOJx22DfqCBYNt2Dc399SnHB2UIQpD8Aiu9aOxnWQ29plRg>
    <xmx:kUn1ZqQAa194vB6qt3lZzTSrUN6T3zBho18DkyWUjzhYU3lXNlhWSw>
    <xmx:kUn1ZiY6ORNzFdzH9VgCRZVLXQQIgQlb4u-6gGJxnBYv8ShHA0VhBg>
    <xmx:kUn1ZrR3QZtLwuoUR4w-hyvU-P6-KQY_0ydRsfBBoUfCdz0l1Glx7g>
    <xmx:kUn1Zod-pOwQkjE4OIIGTNrT4dJ5jCIWyJA7NzcBz6qUIDBM059CXbPp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Sep 2024 07:46:24 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f4f723fe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Sep 2024 11:45:46 +0000 (UTC)
Date: Thu, 26 Sep 2024 13:46:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 08/23] builtin/submodule--helper: fix leaking remote ref
 on errors
Message-ID: <d5e7a24aac145f1018f0dbc34e37204fc300ffc2.1727351062.git.ps@pks.im>
References: <cover.1726484308.git.ps@pks.im>
 <cover.1727351062.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727351062.git.ps@pks.im>

When `update_submodule()` fails we return with `die_message()`, which
only causes us to print the same message as `die()` would without
actually causing the process to die. We don't free memory in that case
and thus leak memory.

Fix the leak by freeing the remote ref.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/submodule--helper.c  | 13 +++++++++----
 t/t7420-submodule-set-url.sh |  1 +
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index ff1376f69f..a9bd93a785 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2648,15 +2648,20 @@ static int update_submodule(struct update_data *update_data)
 
 		if (!update_data->nofetch) {
 			if (fetch_in_submodule(update_data->sm_path, update_data->depth,
-					      0, NULL))
+					      0, NULL)) {
+				free(remote_ref);
 				return die_message(_("Unable to fetch in submodule path '%s'"),
 						   update_data->sm_path);
+			}
 		}
 
 		if (repo_resolve_gitlink_ref(the_repository, update_data->sm_path,
-					     remote_ref, &update_data->oid))
-			return die_message(_("Unable to find %s revision in submodule path '%s'"),
-					   remote_ref, update_data->sm_path);
+					     remote_ref, &update_data->oid)) {
+			ret = die_message(_("Unable to find %s revision in submodule path '%s'"),
+					  remote_ref, update_data->sm_path);
+			free(remote_ref);
+			return ret;
+		}
 
 		free(remote_ref);
 	}
diff --git a/t/t7420-submodule-set-url.sh b/t/t7420-submodule-set-url.sh
index bf7f15ee79..d7fe910bbe 100755
--- a/t/t7420-submodule-set-url.sh
+++ b/t/t7420-submodule-set-url.sh
@@ -10,6 +10,7 @@ as expected.
 '
 
 TEST_NO_CREATE_REPO=1
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
-- 
2.46.2.852.g229c0bf0e5.dirty

