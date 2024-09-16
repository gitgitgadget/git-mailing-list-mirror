Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CF0156669
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 11:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726487150; cv=none; b=fw5pcYvQJhACx2bgs2Ync8g4pI380MUzJYaik4hVw2NAQVMtJBVbA9EP6RM7uXyLPwML7MX5nMvxDUKr+kV/VcvEy2IpizKeaupHMp4sQDkXywzMgWy55V39w6L9qGbheGnPRhLm/GDCjXFwSEM1fC+RybWUBfeZJhI0ifKA7SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726487150; c=relaxed/simple;
	bh=e3g4VidDMiObT3hWMTmpg80MitqmqhQKOWyLj05S7z8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c94N4aTnDFxWf7Bz7K68An1I3dwdhi6IPL6rlWva8hCEZrzsbBc392CVSeGrGNLmGPWAdYAK29g8V0zIHGSeCnWQYz9IoFIgg0smUE9PvnXWIHwkNyiWgWApNFf4fahtADs5fRUkeyAylzwU57ibh+f+LsYhuT/w0vrqy/yA83k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FTXunrRl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qxMRgsAU; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FTXunrRl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qxMRgsAU"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 73CBB114007D
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 07:45:48 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 16 Sep 2024 07:45:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726487148; x=1726573548; bh=2R/0b3T8lc
	oKGTWVu1h3DXnqFc/k86Op4PNIQHs6LD0=; b=FTXunrRlnkOGIkfnbfeHFmJSZZ
	M7KklhrtskrP7Vs4YlU+Bph4VpVJ34Mhormepe9y+fXU+/C40lzp+GVgNsdxj0hy
	J0cDzHEghTvQOg/MOjdMNKTmbW3mQUTw/F3VPGS8EgHgkQlqTF0ud8flV5DeeL1D
	ZQcYQ184tshwQiCykWNdWBtIOJYEDGRXQt4ur2beTixFsueJx5SMEvcUUsCTqHub
	wABYcHA41R7jQ5A8ULsoQWXYXu/oDuDQXt3ODSdfFPdkHiZJwNBFEMTDs7+ftvGr
	gMHMUHxJgK0kL5hj3um4LBonGRB+ffvx10bEhh+qrXEY6DhpSU0CxZq3RIOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726487148; x=1726573548; bh=2R/0b3T8lcoKGTWVu1h3DXnqFc/k
	86Op4PNIQHs6LD0=; b=qxMRgsAUneyTuiwZDc4xay4bRjy8PUqzdmDlwIZpglgB
	X6jia8IqSVSNaxS1WCaK+O5JWNnH1pTCYdnFAb2+87u/NgcZjl96BubxxLxnsH7S
	vm4BOPhQdYyDCOHG5jFQT+3o6vr8ryAoOaHQf3CMQTjIB2Cf1j0yG1DGURO5tWat
	D35bRPS3a6kvElQF2VMSe13OUTQN3CAXzosQumyAWt9+MKJQo3tnZvCD/LTDa98y
	g+rGRO2ijRNmbULRb6x0ei3wL3KeBRYJEdH4BsM6bEKM5ggAAE+qNuvijYaT/Id2
	lsloKVIklmb8+wCmcHZr2O3mRc2skldlay7N7EGQBg==
X-ME-Sender: <xms:bBroZqCO_jtQE5VQZuBN0cZabdwOUuWDRZFbs5Zwf28JwG0HSCmG0w>
    <xme:bBroZkiW_MJGeSyaQcz0VaedX7SlN_kPl5mj0Df5oMLjcBbKgI4Nmtq8cJ7YPQzu4
    nN0kKqNYc1Vpls5DQ>
X-ME-Received: <xmr:bBroZtkEUea593MaNM-JvEcZzr6Ed9-05FNfMov68QCsp5EfCFXh2kJoy3qIIx383j89Bxshpinzn2Bn9A4jjXEynLqGtAV0rg44bo3sYiOtazVv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekhedggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:bBroZoxyycVoxA1y4g0eHa5Q2mwVTo4YhwH5wCAkXGPvRtkmWuhL9Q>
    <xmx:bBroZvRRA3EiNkrC7x-_SqIJnQrEAFG-WIti8h5gVpI87K9rJzg7WA>
    <xmx:bBroZja54b8rIU09sH6N_Pb0WWaax6lq3GIGuXTNjGWcwRdVhMIjJQ>
    <xmx:bBroZoTx54PpHpNstHx32L4mCZCM3eFNRH-UtZk_46GSj03Eilaevg>
    <xmx:bBroZmLDrzqgWTZ2Ek22N_m1VK1VAFJxViCLanGsDhlq6mNOA8CI4Eby>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 16 Sep 2024 07:45:47 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3ac1ffbc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 16 Sep 2024 11:45:30 +0000 (UTC)
Date: Mon, 16 Sep 2024 13:45:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 08/23] builtin/submodule--helper: fix leaking remote ref on
 errors
Message-ID: <d088703d317a8598e1cc4eb068234c105cdeffe6.1726484308.git.ps@pks.im>
References: <cover.1726484308.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726484308.git.ps@pks.im>

When `update_submodule()` fails we return with `die_message()`.
Curiously enough, this causes a memory leak because we use the
`run_process_parallel()` interfaces here, which swap out the die
routine.

Fix the leak by freeing the remote ref.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/submodule--helper.c  | 13 +++++++++----
 t/t7420-submodule-set-url.sh |  1 +
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index ff1376f69fc..a9bd93a7856 100644
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
index bf7f15ee797..d7fe910bbe1 100755
--- a/t/t7420-submodule-set-url.sh
+++ b/t/t7420-submodule-set-url.sh
@@ -10,6 +10,7 @@ as expected.
 '
 
 TEST_NO_CREATE_REPO=1
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
-- 
2.46.0.551.gc5ee8f2d1c.dirty

