Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7C78592A
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717408051; cv=none; b=SIxm59pfVUXMYmb2IBS63Wmnph1ZiTCuJ+jVaKNSUk9qE3/pbYRYc4wORlrohWKBwzdAT+DsT3pm9zIvCuQI/ZiCSPXqUqf5+FztdFr5sUbPdffKieyPZotybqD89rVsWj7XEMBn1Fg/UfxM7iWyrpQkhnd2EiXHunZSdirwyW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717408051; c=relaxed/simple;
	bh=htjz1paN8jOSJ5uJ/1QnBCPMPYaYdBnS9pTxDQ450oE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=me3ys+s2DSUd7kP3SFKbT7BmMPIpIMHk2TF3n3EZcMpX+XcokyUMCNcev9BhOorPq+8GtcbI436NxChmKAXlkEAtqCj2PuAIXXPI6Y6cQF47iupUBPo+3RIZu5StihOV2g8Pw7LDLWHWrwUNE7EUat8n3JjU5ebmZh0Pd2pYO8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HTSTPaFl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eCCHYtC5; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HTSTPaFl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eCCHYtC5"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id B5AEA180009A
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 05:47:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 03 Jun 2024 05:47:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717408049; x=1717494449; bh=EJNwUuZEjQ
	lJMu9nh8Gj2NQXt9pfCjnd1EJEWbnWXCI=; b=HTSTPaFlC0IucczqxzfNoQQ9y8
	C8O8YWBbWk6CuXS6M6fB+DlT2B9u77+EPih5t4YLvgtyk+2Pw9dEoFXPJh5B4EI2
	1IaCnNY9xnFtOt922AqhFZea9bBAoXX1YMpQMuBovM/HCACARd+1QOa+97ZXOvtQ
	S0/HZVLPeIIcwtjNWXUE3Oq0+i/wwo3Sxm/aUj2gnDXVJLXy2EeBFEnBxBXfjma7
	ZSs2cEfchJ8uryDGBrULESphZEVc4ZoU8pc7W651/PvsWYVJrmu8sJy2voOlBIxM
	59Hrw9zYSchUr3XNKxrBLEQDr2NMTLEeZTyD2NN/v1b/XamaSbjNDpl6UDTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717408049; x=1717494449; bh=EJNwUuZEjQlJMu9nh8Gj2NQXt9pf
	Cjnd1EJEWbnWXCI=; b=eCCHYtC5b8egM0DjuXeTphjGgrhXu8gB6roDxz7UojOS
	FqnM/mdJjbG4k117wDVw7LyntsBil56CG7qccZuCHPw8CJyIsTgg+ay2thGb4SfI
	V1131XWpJq3Q1gNXZWvM52KV4q2/SrajOYiGdZ3hH6sP7KBW2Zm0Gd7Bw1AWg+il
	0DGSKFwC/xFCSDWaEeTwmXi2dtCCKhQkJMHGpOH/lE/g/jTcWIhpFL17oPaiuQ3v
	Xb1zXlvyY6me0fLI9kvuKJBQpajRn5D1GGyu5J8+qnII/1FaQh1VmqHI7jozOGd7
	NC3EdAgW6ln2+la/zNRgHVv5dhkB54UNC+/Jm+B59w==
X-ME-Sender: <xms:MZFdZvz8JcKfx6yOG9y6YwPlyaYa0bkcIHEC1LnHLb-EEu4tF0vbJg>
    <xme:MZFdZnQ7vdP1bGusm7P6ih0_yy04_KduVy7ZYplY2XjGPSniL7b2QoB8Sxl_qMbDX
    RaatkAEqKJp_6HeMg>
X-ME-Received: <xmr:MZFdZpXgTIn1qk-MnarBh2n0TvHoSc39NyqJDFRYlSmSoB9L6wPnUT5jtYFaXIiUsxn6g8WGmW2xqCfdt6vTcHn5eu_NZJbKS1oqCw5jE6EZF47C>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:MZFdZpjpwAvqHq7C1ipVKc3WdZWjqIn1HLjKjIS__22AamVwdzUdBg>
    <xmx:MZFdZhDKZbfnQ8OFCC5McgUhYcFTMQgTDWXkxRqqxpZdm9BzXFNEDg>
    <xmx:MZFdZiIFiDHzfHrGqwKn5xtX5_nAVa3eaUHOXaF_LGA0DFH2sdxxQw>
    <xmx:MZFdZgBNfPUVjgWtIGaxC8Q_yXCcr3P--bU_mzrvkeJ9dzIQiWamZA>
    <xmx:MZFdZu6PQpukGTk_SXygLyWf4NkAAB94_L148IG1QuRRnV_vFkOqac2->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 3 Jun 2024 05:47:28 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 8fd8774b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 3 Jun 2024 09:47:04 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:47:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 13/29] merge-recursive: fix memory leak when finalizing merge
Message-ID: <930de119116355f0b6df9e7e1d5d0fe38d93755a.1717402439.git.ps@pks.im>
References: <cover.1717402439.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RmLdCJOgpjfz8ec1"
Content-Disposition: inline
In-Reply-To: <cover.1717402439.git.ps@pks.im>


--RmLdCJOgpjfz8ec1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We do not free some members of `struct merge_options`' private data.
Fix this to plug those leaks.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 merge-recursive.c               | 3 +++
 t/t1004-read-tree-m-u-wf.sh     | 1 +
 t/t1015-read-index-unmerged.sh  | 2 ++
 t/t3509-cherry-pick-merge-df.sh | 1 +
 4 files changed, 7 insertions(+)

diff --git a/merge-recursive.c b/merge-recursive.c
index eff73dac02..832c8ef3f3 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3800,6 +3800,9 @@ static void merge_finalize(struct merge_options *opt)
 	if (show(opt, 2))
 		diff_warn_rename_limit("merge.renamelimit",
 				       opt->priv->needed_rename_limit, 0);
+	hashmap_clear_and_free(&opt->priv->current_file_dir_set,
+			       struct path_hashmap_entry, e);
+	string_list_clear(&opt->priv->df_conflict_file_set, 0);
 	FREE_AND_NULL(opt->priv);
 }
=20
diff --git a/t/t1004-read-tree-m-u-wf.sh b/t/t1004-read-tree-m-u-wf.sh
index 11bf10424f..2b9720b0fe 100755
--- a/t/t1004-read-tree-m-u-wf.sh
+++ b/t/t1004-read-tree-m-u-wf.sh
@@ -5,6 +5,7 @@ test_description=3D'read-tree -m -u checks working tree fil=
es'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-read-tree.sh
=20
diff --git a/t/t1015-read-index-unmerged.sh b/t/t1015-read-index-unmerged.sh
index 55d22da32c..da737a32a2 100755
--- a/t/t1015-read-index-unmerged.sh
+++ b/t/t1015-read-index-unmerged.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
=20
 test_description=3D'Test various callers of read_index_unmerged'
+
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'setup modify/delete + directory/file conflict' '
diff --git a/t/t3509-cherry-pick-merge-df.sh b/t/t3509-cherry-pick-merge-df=
=2Esh
index f4159246e1..171cc6d76b 100755
--- a/t/t3509-cherry-pick-merge-df.sh
+++ b/t/t3509-cherry-pick-merge-df.sh
@@ -4,6 +4,7 @@ test_description=3D'Test cherry-pick with directory/file co=
nflicts'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'Initialize repository' '
--=20
2.45.1.410.g58bac47f8e.dirty


--RmLdCJOgpjfz8ec1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdkS0ACgkQVbJhu7ck
PpSKvg//fjy1sfnTIMZwyBlqBeivInfvowLrO50VTkGuUeurxqgXkW9rSIa+rpk0
NUGNx/T7gd90DOTAxtyf5qgPMa6AeONn7YWKs2gD5sgk33s1EwOywpdww6cW9WDC
2c43FxR6FhRrXV0Bq11FxywidSGHkYo91CGSEq7YwjfAXs6DuVnCE/83zfh9fNrp
p9DRgTphRbzFsGZvMuwKHUBSyo+hd47xcyhqGJ7S6To0p4lITD50cEIxNYL/v2en
WA99wpG7coJuqXfPLvEN+f6+LlaWRhy7+IjW7yKoOeSfpA6+25BJOJ1iLY4G74JV
xnMkKNl2TeRoHddYuGDDRkzYjL1/Kk1CoSOrnuKMhNs3AnraJv3Rm2kFcls7eJkB
p7Rypz71iTZAaPJKNklefSQCOkumIXaH06wkd58jgVxY7Kdwyvh0bJje6n/4gPaA
DdXv862g7Ge0L1YkIQghkWG5gla9iWRcYkf6A+vKldhA3SPWG8mFBRUTAT7dOxIl
j0AC6Whr9Tp+vZy728FoQKKHWEqFHipANGWw9yBlgg2Y/yrt0zyEJqbDSapwOZON
p7DM9xN1zOmYI4GUdNiox0kFsN/YOFRhg591Qs/3cQE8+mZJPuZIW9+5SuwAH2Qb
Uy3LAA8UMNWu/VIMUrkbShAKAVqCtJKQJ9pPuEsdJGWldHYl85Q=
=skhJ
-----END PGP SIGNATURE-----

--RmLdCJOgpjfz8ec1--
