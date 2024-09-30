Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055F818A6A3
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 09:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727687651; cv=none; b=Ynk48J3fGenCLywVFfPt3VjvCt9rmrE2YtQl0zf/vLY0i9CUuOZsQkd/8k8lq+qdN0R3rRSxc3gOToZxCfx6tVbg9zKTa2MGJ7OFMEuZBOD0N0VoROnyPy1H5Xbc54aQBM3KFl7B6FBC2f9JynhNq7C+/Mo7nnh5Eioq8a8b4Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727687651; c=relaxed/simple;
	bh=XzDJxn/SMnT2Lz/5g4O5TmgMVCuwgJV5rok9+sAX6TI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SjlmYXJYiGOtJfAFdGsH/SysfydrkF+y+PUGg+638nbQ2w6Fzg90RLpnHEmaEkB2//Ms8g2imJqLFSoHwbsp3xCcDsfqtpGDvPGucZCuvAMoRS4y/498ilO/CKUjpN6wHXrlv4S82sbAc0z9VfMlBl0rLCLbSXJaseq/iRiCDlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gtcRW0Al; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JwgM7XeD; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gtcRW0Al";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JwgM7XeD"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 65C251140253
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 05:14:09 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 30 Sep 2024 05:14:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727687649; x=1727774049; bh=h04vuwbTD1
	qXwdCwbsWLNCL9Fm5uKXkArL4LSxdnWtM=; b=gtcRW0AlQG953OuDLAbEccP6fg
	gHa3OEsLdW3DO39jZvfvlI4XIZ0cK4mauLFo95tk52lq7XRUlVjbX1SpgJVEvFNN
	maqBpSvZKwEQdUwTsBj7ijwG/458NBSdY3yNFv6hAcHG/YeNSMMODhdQw5wclOqo
	m3P4tHnYW1aTFU79ZmuCytuadycuyXWAs2U/VnwHy7/EBFvv7uQJuLJUHlaSqunT
	K02CMA85cneqXgTc5Yu3/+/ier+QbFQc1ua7BzD7YvScYDcSztv9CDqMZYNKN73K
	GuHMBSpAPzZjsj/HL1ktgh3shrRmyQdfXotkrOPy7gQVpv8dXqiCOPoXkLpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727687649; x=1727774049; bh=h04vuwbTD1qXwdCwbsWLNCL9Fm5u
	KXkArL4LSxdnWtM=; b=JwgM7XeDCnqWi6bKDsnODG4Kd6TnEJakAQHCzccgrQgl
	fVxoir7UpVYGbHLoA8z/Bk1eQXG3RcQj13oKOQgwWZLSAcqoSiGAk+PRzQ3Ivoji
	8T7bbeLawIi7MR9+rMmB+iid5yNpG1AXdKHP0wQ+D/h5fklCFUD3bp/X2ne4tSII
	wIbptIo4ZBt5owtcA5d/sfFakFLEPCxUDaW1Vd3WNgXvj1zKlqoGyOx+yJpj0b2S
	wH5WLWuTLYxYWI+XL/Ze9niNsKywbbuXCkQ/YFEHPwg5MVTTf3AJFkpOwAO73vuj
	zW1NljKhezRCg36AOZgjTBoxrgfI+yh1JDpJftOF1w==
X-ME-Sender: <xms:4Wv6ZueWm8u1jAxMmou45C6LjBZqQjkrE6YfadFJ3cG_QeCWv5b3Hg>
    <xme:4Wv6ZoPmvDEOMVZYTCiELTQjZoOElCZjKpi2JUyO6rKN5n_wF5bfVL9Ff0nZzmDZ8
    FIXJEvF-l9TvxcO-A>
X-ME-Received: <xmr:4Wv6ZvgvrPY9QmCb4t_5gtEdfYtsRouSzJsZXf3HwDelfcdRr2TyE0Kkn9ZoIUiq5KvGFv78UM4wMhp3kl3Y221VGFiSyN8Ka5gLqU0KatcPFz4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduhedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgepgeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:4Wv6Zr-o7EdDC-FBcQoUmRkRA57gcrEpFhUdOuvfHhmjmHaiXqJ8CQ>
    <xmx:4Wv6Zqs3t61z7i7ogLyEqKu30h9tpYibIhiTZDbNwtKCKd8Zlal5QA>
    <xmx:4Wv6ZiHykK_VH2AIC_BK89NPGbS8Ps-c5t4WqiQ0ZRSlwDIc4mYYAg>
    <xmx:4Wv6ZpNPSkGmKZ9N6OHzM_VF78DJ-v2A82t838aT-eXlc9HFhmZIIQ>
    <xmx:4Wv6ZvVsQmJ6svo8SHCztDi5aP4jc9GgHgd41BScNvO6hGH6Ui5zNBx4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 30 Sep 2024 05:14:08 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id aa0c5bac (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 30 Sep 2024 09:13:23 +0000 (UTC)
Date: Mon, 30 Sep 2024 11:14:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 19/23] revision: fix leaking saved parents
Message-ID: <89892e49e5d1cd0aa72364b686950d1bcbbfd92f.1727687410.git.ps@pks.im>
References: <cover.1727687410.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727687410.git.ps@pks.im>

The `saved_parents` slab is used by `--full-diff` to save parents of a
commit which we are about to rewrite. We do not release its contents
once it's not used anymore, causing a memory leak. Plug it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 revision.c                   | 12 ++++++++++--
 t/t6012-rev-list-simplify.sh |  1 +
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/revision.c b/revision.c
index 6b452ea182..f5f5b84f2b 100644
--- a/revision.c
+++ b/revision.c
@@ -4207,10 +4207,18 @@ static void save_parents(struct rev_info *revs, struct commit *commit)
 		*pp = EMPTY_PARENT_LIST;
 }
 
+static void free_saved_parent(struct commit_list **parents)
+{
+	if (*parents != EMPTY_PARENT_LIST)
+		free_commit_list(*parents);
+}
+
 static void free_saved_parents(struct rev_info *revs)
 {
-	if (revs->saved_parents_slab)
-		clear_saved_parents(revs->saved_parents_slab);
+	if (!revs->saved_parents_slab)
+		return;
+	deep_clear_saved_parents(revs->saved_parents_slab, free_saved_parent);
+	FREE_AND_NULL(revs->saved_parents_slab);
 }
 
 struct commit_list *get_saved_parents(struct rev_info *revs, const struct commit *commit)
diff --git a/t/t6012-rev-list-simplify.sh b/t/t6012-rev-list-simplify.sh
index de1e87f162..8ed1a215da 100755
--- a/t/t6012-rev-list-simplify.sh
+++ b/t/t6012-rev-list-simplify.sh
@@ -5,6 +5,7 @@ test_description='merge simplification'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 note () {
-- 
2.46.2.852.g229c0bf0e5.dirty

