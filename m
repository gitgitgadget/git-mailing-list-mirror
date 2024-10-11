Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EFA209685
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 05:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728624792; cv=none; b=Ivs7UEJTohPtv5QqBSMxw+Nqoc0ptB7NGGYnzrnjw/NQseHRDHSeCCRoTkoIgcZt7DSIc5vpCCfNasJIvd1vaTv85MSLtYmlScZbM8TT4p+q+bzoD8jNL1X0ncd1MD2YQzJI5ul7RF8Gg2epJ46i6kKtg2r3ZWB0FPffgbGz1yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728624792; c=relaxed/simple;
	bh=rgLYx63ZPfp4w3ctEetrXm/FoDM1vQGpLr/1VgTa97Q=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GoCcIyvfj1/AZYK9N4PCZl1WQum+HFqBQ0IMzDFGA7NFMB7Vcr9ldhKxPA0FP+gYGEqGdRd+ngpLlZOyOBXzms6ryUD7fkDhJZK496OPzlfBoij8WERLhczoN4iYfDmjI3Qnjs6nxEL5ms/9XcUUGWjj1wF8FJLCONLHZ2fnLb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lmGuAVwh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D0Exe5OC; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lmGuAVwh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D0Exe5OC"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id A5F3C1380198
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 01:33:10 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 11 Oct 2024 01:33:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728624790; x=1728711190; bh=076heWZQK1
	tkC3KULbM8M0kyY+OFpanYThebcBezQIg=; b=lmGuAVwhn/CHbh28C7NnDRJZ6Q
	/01vFiQ2lBQ/uidJNULq6WASv1aLpNVBCop8OHdimFAAFaQRku9IzTa9kAvNRMih
	Tu1bHXR7olO8wFscBRQMlp9l2x1F7AxdA323CSlU0IdwmZEIY3PtPp5aNA4b66Vs
	GH34G+3Mmf+CMbV0xNT98I2BDAMP/nzpEJlIJk7tO9v1368Y6tHvi6gxPXGOqocW
	fqwC8KwKf5PP8jNXcDMDgnMt2nszpAXWKrTK5lUUGyGBtm9KsM+Q/syDxoW3o9/X
	w0CKjf22qkjo/AiYtP97GEAvM3k0ZN4oveR6siZ2q75oEYX1O4ZsGHNfSMzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728624790; x=1728711190; bh=076heWZQK1tkC3KULbM8M0kyY+OF
	panYThebcBezQIg=; b=D0Exe5OCh437Y7hCB4+QR+Url4dZDJo5ipnnUoSFgXZi
	Pu1PK/Cd9b8GOhvqgq7u6Ors2TXhxXVmRfwjASv4GxmGyJ6/MEIxL5XGJk1wj/WL
	a3Arrps8wR7vhY3J7l0TPQeW3Jyp3URph31HEfPoxG13WKeoSA1/pILHWzslThLJ
	Dn8Y6Y4ochzJuR58c764IIKs4ZpCGa/wARmve7wcv0PFOq4gTIFW46RtKnhmzCoU
	HjMQb7w6/QNZyLsu2+4IK+oWFH+QsgK7Q1pN2VwgoIpfD1pdIjlxBiI12JYUqs++
	NipBv/bZIrF96DU/PK41fS1rBE5QYVWl3xPXSANpWw==
X-ME-Sender: <xms:lrgIZwsIXk5zLwf6LdG8fTK6iOenv_0FNJr329JuEz0j-nqNdwQ5og>
    <xme:lrgIZ9dqXRUm_nfUOLAlJ-nbh7AiOHZ8scHAoPg0zuqQXb-gslHi1cjumvc1DUh-n
    kQVe1UjjF3ukrpkgw>
X-ME-Received: <xmr:lrgIZ7z_V-5UALgahO4BXWTbWdVbvcKhVbmgltiH_LEdoRBEZ1Hln5E0Kz-PpB6DoIFROP_ZPEfKUe7VKsGamVcdTnNYdcTvGxlEAB-oqda5xLk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefjedgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:lrgIZzM3bpmeDaxo34X4gnYwlSlg1flpbRLU6Nm_A-XpG50lnSvs_w>
    <xmx:lrgIZw8XzbL20s-fdFOBBjO6CwNaZFLEP34d3pZM2to4vMhhCvT8fA>
    <xmx:lrgIZ7XnxChXOE4KjhCLfepf1i9u5tOyhCceNZqUxNy3RcJxIz_tHg>
    <xmx:lrgIZ5fXfEdDTybPH6IKtPGWePwV9R6K7_29dD115U1_COmllKLerA>
    <xmx:lrgIZ-nVM_4D2wdJtWjE2mlL04kvl9D3XnmnjvVXMFbCoDM5Svz2Yu_7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 11 Oct 2024 01:33:09 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1ee76905 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 11 Oct 2024 05:32:03 +0000 (UTC)
Date: Fri, 11 Oct 2024 07:33:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 19/21] dir: fix leak when parsing "status.showUntrackedFiles"
Message-ID: <8ccc246432da8060b4c3a12d17f6fecebe54dff3.1728624670.git.ps@pks.im>
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

We use `repo_config_get_string()` to read "status.showUntrackedFiles"
from the config subsystem. This function allocates the result, but we
never free the result after parsing it.

The value never leaves the scope of the calling function, so refactor it
to instead use `repo_config_get_string_tmp()`, which does not hand over
ownership to the caller.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 dir.c                             | 4 ++--
 t/t7063-status-untracked-cache.sh | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/dir.c b/dir.c
index cb9782fa11f..7f35a3e3175 100644
--- a/dir.c
+++ b/dir.c
@@ -2872,14 +2872,14 @@ static void set_untracked_ident(struct untracked_cache *uc)
 static unsigned new_untracked_cache_flags(struct index_state *istate)
 {
 	struct repository *repo = istate->repo;
-	char *val;
+	const char *val;
 
 	/*
 	 * This logic is coordinated with the setting of these flags in
 	 * wt-status.c#wt_status_collect_untracked(), and the evaluation
 	 * of the config setting in commit.c#git_status_config()
 	 */
-	if (!repo_config_get_string(repo, "status.showuntrackedfiles", &val) &&
+	if (!repo_config_get_string_tmp(repo, "status.showuntrackedfiles", &val) &&
 	    !strcmp(val, "all"))
 		return 0;
 
diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index 8929ef481f9..13fea7931cd 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -5,6 +5,7 @@ test_description='test untracked cache'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # On some filesystems (e.g. FreeBSD's ext2 and ufs) directory mtime
-- 
2.47.0.dirty

