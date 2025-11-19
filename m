Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67C832AACA
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 07:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763538693; cv=none; b=fYgOwK/+YP1Q3GbC9WAUmjLzSCI19ctjci0HAsEcOFggT/2nUjmJSvIjFfcr8QrYcz6xlrUTnFPwfTrETcW8pKGFKp70E+jklbINcxFRYc+XkffNL2WKhwbS/XNS3iSLLqyW7U7/HK7b2c+0rmFD5irU4DMW02gzgcMSO0OJ9X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763538693; c=relaxed/simple;
	bh=746uL3E1MYrSB04kedokynxGzYFFTrzuAIPj86K8d2A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i2GluHwTwTfKqORmh1i2f5j9WBkXCnHZe7ihRwkg8FhALT+7NAcCmsWIDmFEdMABEJA0YAEU/RX4oNA5EpXrHrtuUm+r0T6s/Qtl51Ei2v2iLhmqPMbm6BFqBj6H+p2VfuQYzOs1h6E/CN73vA563ouMXKfr31pkRh+EqKiUOj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=V48h1X4X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WNJSzfYm; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="V48h1X4X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WNJSzfYm"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D5FA0140017D
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 02:51:30 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 19 Nov 2025 02:51:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763538690;
	 x=1763625090; bh=2Lq8YUf6VO+uoS+f4ly4N2+oE1FKAplLI/EALTkGfxQ=; b=
	V48h1X4XZUk3ou25WJ7QhrYU4Ta3PcKvmGL+sHOL1BIF9xiW7v96i/UoHi0nmCIE
	WOduKFxP6V4ni+zxlTO3ekZuR73Uy7t6IgFCDLdKZ4vPzic8Vw6z67uyilM+QLQ3
	sWhNWixIbjzJ/R2Mj6pHARLKgBubDNuArOQmtR8ZbsatZaqntpS0aAHFpibOIfSw
	R7H2+zkTW2WrAbXSni6g+Ppw2Sl1MSlVG3pa6cr+PHEWQA34FgflgGYMwkCul27p
	zgqs/qAUYYSqaUczA8OATRSzJ4rrJzrQVjY1caWa540cwDoadkm/NEKnB7dWQHfb
	tyPB2nRHX+JZJYHKziRF7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763538690; x=
	1763625090; bh=2Lq8YUf6VO+uoS+f4ly4N2+oE1FKAplLI/EALTkGfxQ=; b=W
	NJSzfYm7c2PmfZGODBmh0/ACROTy/nGQFQnaRDhExPjm3VxRk2j8acuFXSnE3esw
	nI7Av6ob8UB1mbHMXOiPLlFgCAfmzQkmRPlHq7dBQXIoUQb3/PeDDJePZyveKfxd
	rJ4zLRU6bKmeiC8nb+ckWpd7dzwUWP6SZ4r3qggzYV4V3fIme1LWECo8iM7YCE0+
	sedvFtw+wgTp2FGfG082kBByjJuafOD3uzLrmmnlWmO3lAGtMUVMWykUbx6dNJd6
	39isVP2+nIFAlc50VRR21xFkrxMFAYaroPBG4uGtzlbONPdWr0+7G+86lhl80auc
	diuWrYDZgPRJqgiVdfaCw==
X-ME-Sender: <xms:AncdaSgrMbJ4GY0Z4GlXlfaeXayWC2RbIMKjj3CgDyb8g1ygPKQ6QQ>
    <xme:AncdaZ9kNStzNEUF-PdUOL_iQ9a3m1toUefIearV3BzHF4jyeXGHwcVX5hHbFBGDj
    MpBXwkMOitXdt8pFqJ4scCVklsue0Scju4JyLRL3anNk5NfaOsm>
X-ME-Received: <xmr:Ancdafsc2X7Eli2uzEYmTFAcu_p2-HCudvxzNehrQltMostL4EhGZwhBeYaYzr1vRFqp4uGmggIflxMbv47-qVHFroXvFbICYMtDLR44fg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdefieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:AncdaQZaVNwGtKxwQubZM0fQ0ZgFFk2Nr9OnGUjmTH3a1y2nkbqzRg>
    <xmx:AncdafqteGtGaCy6fKwoWHkpnraXt07HGenlZ1H4BtdlHmx76QiiTQ>
    <xmx:AncdaV-c0x4Dx1zecWfPfUwKCJpLU4MQ9F5L6Joj2UtldcdTKz7uEg>
    <xmx:Ancdae_3KdfKZQwRjYL0zagTRH9cwAlOaamAWtBd8QngUZ8amFxZ9g>
    <xmx:Ancdafg2ywbo8jJagm8i853Oato94EbpS7peofbwTl7oxxY-c6_HDSRP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 19 Nov 2025 02:51:30 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 968099a2 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 19 Nov 2025 07:51:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 19 Nov 2025 08:50:57 +0100
Subject: [PATCH 09/13] http-push: stop setting up `the_repository` for each
 reference
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-b4-pks-odb-creation-v1-9-2b2ed2612cb6@pks.im>
References: <20251119-b4-pks-odb-creation-v1-0-2b2ed2612cb6@pks.im>
In-Reply-To: <20251119-b4-pks-odb-creation-v1-0-2b2ed2612cb6@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

When pushing references via HTTP we call `repo_init_revisions()` in a
loop for each reference that we're about to push. As third argument we
pass the result of `setup_git_directory()`, which causes us to
reinitialize the repository every single time.

This is an obvious waste of compute, as the repository that we're
working in will never change across any of the initializations. The only
reason that we do this is to retrieve the directory of the repository.
Furthermore, this is about to create issues in a subsequent commit,
where reinitializing the repository will cause a `BUG()`.

Address this by storing the Git directory in a variable instead so that
we don't have to call the function repeatedly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 http-push.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/http-push.c b/http-push.c
index a1c01e3b9b..a48ca23799 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1725,6 +1725,7 @@ int cmd_main(int argc, const char **argv)
 	int i;
 	int new_refs;
 	struct ref *ref, *local_refs = NULL;
+	const char *gitdir;
 
 	CALLOC_ARRAY(repo, 1);
 
@@ -1787,7 +1788,7 @@ int cmd_main(int argc, const char **argv)
 	if (delete_branch && rs.nr != 1)
 		die("You must specify only one branch name when deleting a remote branch");
 
-	setup_git_directory();
+	gitdir = setup_git_directory();
 
 	memset(remote_dir_exists, -1, 256);
 
@@ -1941,7 +1942,7 @@ int cmd_main(int argc, const char **argv)
 		if (!push_all && !is_null_oid(&ref->old_oid))
 			strvec_pushf(&commit_argv, "^%s",
 				     oid_to_hex(&ref->old_oid));
-		repo_init_revisions(the_repository, &revs, setup_git_directory());
+		repo_init_revisions(the_repository, &revs, gitdir);
 		setup_revisions_from_strvec(&commit_argv, &revs, NULL);
 		revs.edge_hint = 0; /* just in case */
 

-- 
2.52.0.rc2.482.gaa765fefd0.dirty

