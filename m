Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5392870838
	for <git@vger.kernel.org>; Sat,  3 May 2025 00:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746233909; cv=none; b=CcZXWVsG8hnrridRy3Q2+1y6Oxy4iML6o7ld9n+tET1XXdVh2F+AaxfUrXXmKoZjx6lpf+iot6I1c0Ae2uKOFZirguDDcI86zFfxPyGKkb9QZJlgMhNslFlVJI8Jzwa/+c+KLiVp2J8T5QQ8CvvfH4t9kvMgvdElhCHRuvLxpgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746233909; c=relaxed/simple;
	bh=EvH6mTf5uNws3NVbsW/Oj+25JhYxj3xJ59k+IzCV7UM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iLk3NpO8r8HfO+g1oru0bqC68zywbVAkWNgGrfItnUxNgtXE9vBMn4Wwqm1rngJJv0WWzwkTPaoE/29ZVJJ2AhvuhdomJZfCLmOVpPDuayaDwqUr19IXIrDRKCCiwJ8YNs2fnLggk1acv5U7xuFndxKMcydjYhANgGmdeN42v3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DanwgtM9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q09ecZe8; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DanwgtM9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q09ecZe8"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 731A21140205;
	Fri,  2 May 2025 20:58:26 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Fri, 02 May 2025 20:58:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1746233906; x=
	1746320306; bh=4EWJ+HyMEqUdsrWRuBMSD8aHZEogtRVNMILh7M5na/o=; b=D
	anwgtM94vhotO6u55vy2Zc6E5MjhCJL9X+z8SmpTSkMHyLad5ROy0rSkUX5wxUZk
	NOJkYO0xSdukcC+DveueRqTSHzqzg6WjyhmchSQhSHDZfCra+XUJZIJRw1vinCnn
	WpVg8yzEyMNxlCsKsVCfvrIRshnnrceB5qpnvCrSVPjrtfsX5U1NiRRKHN7fsB3p
	x+ywCeMAiK6pm9YIPCbhaE7wSUMbhUb0M3MJBLAp4X/wBtWXduh2BeSkz3xelkuF
	nkSoIYl5TkXeSTVvXnSGlcMtlD6sshHKdT86egawTR5woOtDRoD0meMZiNAW3++e
	mQMYflg2BpgcIP3YBhIdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1746233906; x=1746320306; bh=4EWJ+HyMEqUdsrWRuBMSD8aHZEog
	tRVNMILh7M5na/o=; b=Q09ecZe8aLVYC3dCJWbP25TGCCczClNu9uNaM4cdbtpj
	dMnW5JJ5H64eYOrd6gAdu/QRwNA7W3CZHeKvV3fVhFdLgLDLlTRwHMXuihCrBuHn
	KMqpcX4MC6tb/CdKdUpavqRyldV/iu52pAw40lD5ONBmpbNpkIDm1ESLVzFaMjOU
	orc0XZmiAslMoA/+pU0PJvbmeoo/ejLL/umqgBw96nvTsxHTKRmvSLu2DPafCaZe
	zejPlE5F95nKlj5CLPyRDYA8HEbQyS2zE5GgIyfxBtR5QbB6DHcsH4ibBqHvx//m
	zWwJkBmhWMeeLkdpXwh6/no/oxPvw1awfQy+K+Dmjw==
X-ME-Sender: <xms:MmoVaD1KhfhP67t7-VdlJYbtd5ssqECp_lTMktS8TedvUvMNwbQxMw>
    <xme:MmoVaCGGpS-98hxU59dePs1UHRB2lRgpOIrl001gPK9MZQ2UH6oaG9O8o2g3tQZdf
    mOcoew2NIZFDSHPGw>
X-ME-Received: <xmr:MmoVaD4ayDtoWpNnlMjqyW05z_RQ22XgZp3VaaoVXnUqbGV2HsH46zA-7WCUV1r-seA-YTpMjUVNHNorAdrDVHBBPJw1LzpoJxne>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjeefleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnheple
    evieefieeuffeugefhveeugefgfeevvdefleevuedvfedvudefkeehtdeftdegnecuvehl
    uhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:MmoVaI1M0nXdlHnWinXiT4QMxMjrQTQSeH-QyQfIhCWbfUb-RAif6A>
    <xmx:MmoVaGEKkS8ZnhdaLRVRHznGLfv1ZMEHB5acgkRj0_cn8G1XuzuRMw>
    <xmx:MmoVaJ8tZ8CdqoKXkoqy3j7neeyadLU0OEn8eub0Q23n_DiCmkVPPg>
    <xmx:MmoVaDnYHALGoFbVL-fF8L45F8YjvV66zQt4fBRIIzMNZtCHdccbTg>
    <xmx:MmoVaP1GZQ2HrHdto62lZSS85UrJZvi6pev-UEKqjJ9-__7Iwfcs_1kH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 May 2025 20:58:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v3 6/6] whatschanged: list it in BreakingChanges document
Date: Fri,  2 May 2025 17:58:14 -0700
Message-ID: <20250503005814.3030099-7-gitster@pobox.com>
X-Mailer: git-send-email 2.49.0-601-ga5925c3955
In-Reply-To: <20250503005814.3030099-1-gitster@pobox.com>
References: <20250501225958.2947677-1-gitster@pobox.com>
 <20250503005814.3030099-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This can be squashed into the previous step.  That is how our "git
pack-redundant" conversion did.

Theoretically, however, those who want to gauge the need to keep the
command by exposing their users to patches before this one may want
to wait until their experiment finishes before they formally say
"this will go away".  

This change is made into a separate patch from the previous step
precisely to help those folks.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/BreakingChanges.adoc | 9 +++++++++
 Documentation/git-whatchanged.adoc | 6 ++++++
 2 files changed, 15 insertions(+)

diff --git a/Documentation/BreakingChanges.adoc b/Documentation/BreakingChanges.adoc
index bdfad29d8a..f9026d004c 100644
--- a/Documentation/BreakingChanges.adoc
+++ b/Documentation/BreakingChanges.adoc
@@ -178,6 +178,15 @@ references.
 +
 These features will be removed.
 
+* The git-whatchanged(1) command has outlived its usefulness more than
+  10 years ago, and takes more keystrokes to type than its rough
+  equivalent `git log --raw`.  We have nominated the command for
+  removal, have changed the command to refuse to work unless the
+  `--i-still-use-this` option is given, and asked the users to report
+  when they do so.  So far there hasn't been a single complaint.
++
+The command will be removed
+
 == Superseded features that will not be deprecated
 
 Some features have gained newer replacements that aim to improve the design in
diff --git a/Documentation/git-whatchanged.adoc b/Documentation/git-whatchanged.adoc
index d400b68d4b..d21484026f 100644
--- a/Documentation/git-whatchanged.adoc
+++ b/Documentation/git-whatchanged.adoc
@@ -11,6 +11,12 @@ SYNOPSIS
 [synopsis]
 git whatchanged <option>...
 
+WARNING
+-------
+`git whatchanged` has been deprecated and is scheduled for removal in
+a future version of Git, as it is merely `git log` with different
+default; `whatchanged` is not even shorter to type than `log --raw`.
+
 DESCRIPTION
 -----------
 
-- 
2.49.0-601-ga5925c3955

