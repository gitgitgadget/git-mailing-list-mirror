Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A666D17C7BF
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 09:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724318288; cv=none; b=kgJe8pV0kYBFlENDHs8kmDSO+3odye80PiD7M98l8Wz9ua4U5SrypN2tBG4Vb6uX3TVeLa6CNIFWYUMeGpgnVvKvhKePgya25U2jGVXtwab6badQnaRvFxskN0YE3Xel+XSqnki4NMHB6crYVt9sQ9gHDoj+bEvdmnV6SFgIs5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724318288; c=relaxed/simple;
	bh=Yv2LFQ9ioVW6DdtzwAVt41x9Yh8dQVMyRci6CX3f9k8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bi+WPSq30LIlV12b+8/zTyFcfuN1OVAmfsafNdV3Cj4dzq4ta6HyT4udb12bbFxVfaa/8PXo37fWMilyx9P9qj9FHAPVmtMwRT0XY8MNgfDMoIg9gnbezHhwtfe1YBG2x8jYrv96MgI70N7L9SKNSYq9vOwqbNCJX84j8rmsbGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lyhKS0WB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ldOmxkAc; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lyhKS0WB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ldOmxkAc"
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id CB45F138FFF2;
	Thu, 22 Aug 2024 05:18:05 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 22 Aug 2024 05:18:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724318285; x=1724404685; bh=cbwJi4s7i9
	nVCQ+fBAzIe7l3AWVi4WR8/NABSIWwcVw=; b=lyhKS0WBcyl7ZkFj+06G59Nxe7
	P20kR/ncyKvAQouTIbxXjRNxPZzLI7/Xz4x7/AIgn2dtGjtBB2uYypvxbIfn49fA
	EMTXImrz6hLjLjBfSHSE0JDwWQkN78ho4iKliCXfBMAMzsxGEUMg/m4A9lABIuSQ
	Ab5QFLbDYEKummx00FO+xmxdtWPtwZBivYtqZj0h6HR4clfFYNU02js3YDh6R9lE
	gk4aCQAe3pOFMwgFyxp9jegiu297RAxnbhNGGqc1glbhVSSJLZ5RGHwLbpr16KDy
	UrFFHEy4Pj0a/tJeIL91cIuKHruVshnLa2Rrt2x98y+wdOyHaX+DfKx6C4CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724318285; x=1724404685; bh=cbwJi4s7i9nVCQ+fBAzIe7l3AWVi
	4WR8/NABSIWwcVw=; b=ldOmxkAcyJLKUT08HBZTAIlXkVyE+jrb2fpL2N7MIEjU
	5QdIArKjsrTLkvXAHtnes7/3LPEXYPrb/zvRWTKvhQZoVbCpredMsImk/y8dQyG6
	OmNDyPUmpZ42VPMt2a6zUZ6HIOgo/vCK63TTGRqHqmqVa4/q3DItzWuT5pWN8pVs
	CIwnlWiFvYoef9LQGHLSC5+DVTeYLZCSa8j+eNRmqhcEuW/LNK5EdeO+lHzX7fjE
	Idmz1b5ivt7ga/hqbOuK8EVp3CVYlWfXg7CjXBjSe9DhqQVpjYD56mExIkiVLoOX
	+aQZw99PSOKie5gSmABbTZ+LzzMM7cYevCB7FBwWkw==
X-ME-Sender: <xms:TQLHZiAWY1jDcMqD69bxu0f1AO9GjwzVRDcspu8W5yOeUEMyrIzQaA>
    <xme:TQLHZshHhxW_tzGOIGvvzNeBbQd_154CCBaHfBNIDlC7DVkJdOE_ozUVkbHhcy1TQ
    70o2YLzi67WgDgfZg>
X-ME-Received: <xmr:TQLHZlmY10hmSTBO_qhnreimZE_sQ_ez8XZWNlYxtNkHyQtxr3URHnrt_6Fd0EoISpGmXT9WHLdzxyAzTPIcHa5FYwi6zDJdJlI33Ioyy4y5Ewg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvtddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:TQLHZgxAm5tEUThwtFAHtfWnMSn0SwTbaBqOOJilUbCdZDWdus-xfw>
    <xmx:TQLHZnTR-Gs_HcNy7sTARP-pJaa2IVGqx9NleiQjRoBHMZ04Lxv7ng>
    <xmx:TQLHZrYC9rQ0WgKEijzTKgbTBfWL3Uy-J6VByi4_nBXcAt_MGrPpLw>
    <xmx:TQLHZgQ9lNlQIwraLHn98hvspv-LNN6eE-JLAnKNO7XWKR4bm5o7WQ>
    <xmx:TQLHZicZuYOompCpWDL-1qcMho_FhsXGUSgXwLRgXoqJgsE761yJVEtj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Aug 2024 05:18:04 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 80322b2c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Aug 2024 09:17:30 +0000 (UTC)
Date: Thu, 22 Aug 2024 11:18:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 17/20] remote: fix leaking peer ref when expanding refmap
Message-ID: <662ec4e6484aa7fc495d528a0b58ef18e3be1953.1724315484.git.ps@pks.im>
References: <cover.1724159575.git.ps@pks.im>
 <cover.1724315484.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724315484.git.ps@pks.im>

When expanding remote refs via the refspec in `get_expanded_map()`, we
first copy the remote ref and then override its peer ref with the
expanded name. This may cause a memory leak though in case the peer ref
is already set, as this field is being copied by `copy_ref()`, as well.

Fix the leak by freeing the peer ref before we re-assign the field.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 remote.c                           | 2 ++
 t/t5536-fetch-conflicts.sh         | 1 +
 t/t5553-set-upstream.sh            | 1 +
 t/t5703-upload-pack-ref-in-want.sh | 1 +
 t/t6050-replace.sh                 | 1 +
 5 files changed, 6 insertions(+)

diff --git a/remote.c b/remote.c
index 6ea81f9665b..8f3dee13186 100644
--- a/remote.c
+++ b/remote.c
@@ -2081,6 +2081,8 @@ static struct ref *get_expanded_map(const struct ref *remote_refs,
 		    !ignore_symref_update(expn_name, &scratch)) {
 			struct ref *cpy = copy_ref(ref);
 
+			if (cpy->peer_ref)
+				free_one_ref(cpy->peer_ref);
 			cpy->peer_ref = alloc_ref(expn_name);
 			if (refspec->force)
 				cpy->peer_ref->force = 1;
diff --git a/t/t5536-fetch-conflicts.sh b/t/t5536-fetch-conflicts.sh
index 23bf6961700..2dcbe790523 100755
--- a/t/t5536-fetch-conflicts.sh
+++ b/t/t5536-fetch-conflicts.sh
@@ -2,6 +2,7 @@
 
 test_description='fetch handles conflicting refspecs correctly'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 D=$(pwd)
diff --git a/t/t5553-set-upstream.sh b/t/t5553-set-upstream.sh
index 70e3376d31b..33e919a17e1 100755
--- a/t/t5553-set-upstream.sh
+++ b/t/t5553-set-upstream.sh
@@ -4,6 +4,7 @@ test_description='"git fetch/pull --set-upstream" basic tests.'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 check_config () {
diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
index 191097171bc..f75fae52c83 100755
--- a/t/t5703-upload-pack-ref-in-want.sh
+++ b/t/t5703-upload-pack-ref-in-want.sh
@@ -2,6 +2,7 @@
 
 test_description='upload-pack ref-in-want'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 get_actual_refs () {
diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index c6e9b33e44e..d7702fc7562 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -7,6 +7,7 @@ test_description='Tests replace refs functionality'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-gpg.sh"
 
-- 
2.46.0.164.g477ce5ccd6.dirty

