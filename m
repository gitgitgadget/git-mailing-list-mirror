Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11215196C86
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 13:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728480323; cv=none; b=q2KJJHuwg8qpN//KlsZQSM/aIxodZdCb751nen1soa0iKSSeiSSQfWKsq0t2G2V+dSYpjxJRpLXKRk/UiZTOmqil2T5it/RUGLxDthLTEXp/JNsrouV4ZsC+BY4s2w+DbNX5F2nDc7hekK42sDIu/29/4vkqExZ4D6+zV4Fft2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728480323; c=relaxed/simple;
	bh=1yCIAfjhdKFTfj0dZfdiqbEjfI+ddB9eZ4/UfhxhG4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XRE0dDz2aLbK3kP+glJ5pX2qKpsSekE5yRph96stDuYqS95oP1qCU1oNu3CwSD0p4WvdNHZ9bV0PnT3X6F+RLXAlnkTeo6rvf97Je1QnoKf97NFnZqsaTSEfRL6wU6CzrBnDFaoMPRI6vNCJdI3kDWYKGWGmf/fQPRFZanFVAKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=a1/zdaKZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F0athtRU; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="a1/zdaKZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F0athtRU"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2E3C81140126;
	Wed,  9 Oct 2024 09:25:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 09 Oct 2024 09:25:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728480321; x=1728566721; bh=Pwhz13NUWE
	Z66UKZevT+M3aaoVZtSCY2uliqi+YYyXU=; b=a1/zdaKZfUywnhhfYFNkiuyqD6
	FXItfww3v1DmJc/0lF4DInq2DByCgmEsdZx9ceUprZI9EOopfih2holTu88atLjA
	UISS6UorbpEE35zO0tFWRjUyBRzKMksdUpChBtpyC1e3c9CFOsTCmXRUYM/L3PWW
	fv8AxspTiGZ2HKQLmpnu6pV7wGm1Q7C/eoscTuj2rlfc4DYuT6+DPlOkvQ23MNHG
	RAD5x6qgMBbubRMxgCzV1Xv1G0eM0bGP0XVskyM/ZMI0tUSUH+1RfR+Ty8beq9HF
	VVx7y2KxyduShRbXzm39e2VALQBYM9EbueGMjswGECU67Mv2Mo2NVYJLt6EQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728480321; x=1728566721; bh=Pwhz13NUWEZ66UKZevT+M3aaoVZt
	SCY2uliqi+YYyXU=; b=F0athtRU9gaCL8SiPXx4aBVzY1cXanb84GeAjyL/Rtoe
	DPSE87wqGdSfj458M1AjTFLiPJbqec+cZ2FugEf23CKPovYx3HmnXvR2FD/DlSIl
	EBzmjQB9zXwAIpaHRDxGTJeKr8PFZcE4pkzaQPOJEzTTfrBqvr9zaHyNtIcmcre9
	JZpTIeNFbsmEyhZlapsF3IMNWTMRi57DmCbqmmdUqv6syIvUu03IQ3cssp7zGKhI
	m2MQK7LRJfmMollg8aXvL6bUEtxOr8cS7mVWA9ejzLdM0XgzvgIR2oFPfE1S25tI
	KbchdnR1APAtqDjSXg7FMAhU3GHVP56+4AqSp79cGA==
X-ME-Sender: <xms:QIQGZ46scryDICNs_sdfQC6EIf6xrU2NkrinjkapwrtGjzCyxDTV5w>
    <xme:QIQGZ54oucIGFyJFAfzClliIB9xxlETrkKELL-bJhq_zzSWog3OMDd7pqnmDKLxmj
    N3hMqa2ogPRW1ACTg>
X-ME-Received: <xmr:QIQGZ3eXXLBaDaiJXJcrhT_hjAA7Ye5xXlsNj34COBUcyphwn1qhN70WtccszGtGebnBuC4yHAkcjoSsbbABtyV4D9JFqhMlKyiE0HKlFGM1Sw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeffedgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvg
X-ME-Proxy: <xmx:QIQGZ9LTGGBGNyJ6k1QilRuTTPg9CKTI63NBe8elstbcDz7HwScpsw>
    <xmx:QIQGZ8KgvNaxj3ZewzVXxPGXHcP7dyooc4_B5sYA6HfrPPd_R5yw1w>
    <xmx:QIQGZ-xafda2nb7awN91-4H1wNM_AAiWN2Cmcbv3ceWYPjZFqa44Tw>
    <xmx:QIQGZwJQPd-tmeg6B9_XDJJX25Wyc127HXCP_6DVzvc2NTh61Oj39g>
    <xmx:QYQGZzVE_kzudaaStYAh_OS8pZ1cY1m3jmxSfCxXwAzhEh4eICuJTrk7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 09:25:20 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6a860483 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Oct 2024 13:24:17 +0000 (UTC)
Date: Wed, 9 Oct 2024 15:25:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 1/5] t7300: work around platform-specific behaviour with long
 paths on MinGW
Message-ID: <bdaf16a06168b7320e8dd1115258f00745a104c7.1728480039.git.ps@pks.im>
References: <cover.1728480039.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728480039.git.ps@pks.im>

Windows by default has a restriction in place to only allow paths up to
260 characters. This restriction can nowadays be lifted by setting a
registry key, but is still active by default.

In t7300 we have one test that exercises the behaviour of git-clean(1)
with such long paths. Interestingly enough, this test fails on my system
that uses Windows 10 with mingw-w64 installed via MSYS2: instead of
observing ENAMETOOLONG, we observe ENOENT. This behaviour is consistent
across multiple different environments I have tried.

I cannot say why exactly we observe a different error here, but I would
not be surprised if this was either dependent on the Windows version,
the version of MinGW, the current working directory of Git or any kind
of combination of these.

Work around the issue by handling both errors.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t7300-clean.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 0aae0dee67..12ab25296b 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -747,7 +747,7 @@ test_expect_success MINGW 'handle clean & core.longpaths = false nicely' '
 	test_must_fail git clean -xdf 2>.git/err &&
 	# grepping for a strerror string is unportable but it is OK here with
 	# MINGW prereq
-	test_grep "too long" .git/err
+	test_grep -e "too long" -e "No such file or directory" .git/err
 '
 
 test_expect_success 'clean untracked paths by pathspec' '
-- 
2.47.0.rc1.33.g90fe3800b9.dirty

