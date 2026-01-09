Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB47433CE92
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 14:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767968880; cv=none; b=FY5YhqtcezujD2Q4q2cnmy5vntVWCbnF3KDmwqodzzNswEmJqEiKb1nlYCsJsP0bd5WuHGshCFSwS1MAFSxqjrdGyGdtRl4m/7FmjueLXIYueCrr/KZroX4y+gzr26qWc/8MewMZzm6dm7JGx9bL2+Jg/bsdd+2VRDsof1FgiuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767968880; c=relaxed/simple;
	bh=fd9U3eDWEmyZtZaGwwHTqCemeO1xQ9cyJKu+edegvbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jF7VOcFPlwW0bp9cYGzIWJ9RWV5o3cPcsi4E2CUl6Wgs4GVlTolo28bz0EXNpIMFIbonFuvAUrCz0QvOS2d+3qEuUVbuU2rYohA4V4Rp6rW84bDxgROujoLI4V4JqjEylocFV6QIYJJUcpypeqHpjY0Pr61uVKl12213J/l74JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=GTykoUvE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A6XIhnuV; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="GTykoUvE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A6XIhnuV"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 10A877A014B;
	Fri,  9 Jan 2026 09:27:59 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 09 Jan 2026 09:27:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1767968878; x=
	1768055278; bh=dt/ARekXTnt2F0c5zpLy/hm6XoDgGmHZIcweVLuKfus=; b=G
	TykoUvElPrOy2d6ngl7d6k3YxtAlyiHoy1P22t1kRS56/GCq168nuQyhK6VQao8s
	ZZwkx7uhDlOpNbmJG4kr1B3wKQy0Robo1hcfb5JWyUP65MNqEjEeHR8TfBVqyrIs
	Y10Y6uV2T3n+1jfnkBbNmF3aUYt87NovLtq/ru1HZ9KQj8+XsVxpYizFZgK98QOV
	TRtPN7gsdFW0Sbjr0BYrXIqP709XR66JJsDwl564H1tebK2/+mp3XMvolKz9cpDv
	nw2XZ2k0ZldMvI1jieOO5W7W4e5OFAVIaIJElReQwbm0Umhxhju78rHJLw//fOk/
	z0UMVfNpcxsNbLkzlblGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1767968878; x=1768055278; bh=d
	t/ARekXTnt2F0c5zpLy/hm6XoDgGmHZIcweVLuKfus=; b=A6XIhnuVYc/g4rICc
	zWQHMs2BKi3XGp/kRMS4z+kAu2tKFeU4V87dsRrCrk8NVBPpLjSAX//NMKt0nUSO
	kUo3yPUT/+ihxcQ+d6anrYrAUPCZaYryBAYIYgyJX7ZCgOpxnFzxcuq0Xk0zBzzg
	72ST3PFE9W2acKfFJisAJ3dbTKNSEdqESQqRrcAFeblrzNn+mPWjL8Vf9P0IVsVq
	aLcNYCDoahyPqML+mM/Jw2Wub1vbhI15FTrBLElLkn4p7StwHCLA7Wn9qqcjlJCM
	VylS4sCKvU8xYHxujF/lq3MdqxzX7vyO7M75VJMJhfRdYIdoZZS/+oQs0LexISgg
	YzYjw==
X-ME-Sender: <xms:bhBhad1wU6WdJT7W52wMiGfLtVTqDW0bbWVEEZI1iOB5N_6IupWZWRc>
    <xme:bhBhabFc2HD5eT2-cd-YPUhSwiexZUCX4GyxP4n1PHeRB-CFLgAEwZGrpK5ugCQb2
    4bIsOA5sOzX4_H2h48ZmdgElL0QNgWrBD-vOw1xSE9CB53GGNR_mA>
X-ME-Received: <xmr:bhBhaS6LfM5BZBI2J7-ENDYB0L7wES1qE2ofBsZy877VoswnTSidIssPEOjZ7aDSqY_K0rKiPMjgIHTyWB3v44b_ky2FJ7M5yLohqDU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdeltdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
    hlucfvnfffucdlfeehmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhenucggtffrrghtthgvrhhnpeefheetkeeftdeiffdvjeetueethfeugfetgfdt
    veehhfevffeuffdtheeitdefudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhm
    rghilhdrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohgu
    vgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehpuhhshhhkrghrkhhumh
    grrhhsihhnghhhudeljedtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhs
    rdhimh
X-ME-Proxy: <xmx:bhBhaZukmtsMe3Myl4KWfI9atxq-OkP1lTtwNs44alK5qnNFTnsDTA>
    <xmx:bhBhab6N4EYz2W87bc0mTyQ68HxcS2LOQDcJ1G9qIK3fDcHni_gEDw>
    <xmx:bhBhacVbs6pr24LAmWyZM0jh8u0pER2oRy4BhJNAFViUDPdd-GlUEg>
    <xmx:bhBhaV8kWMoM08Kw9ZKGqWylGAaFaBx7R_2bxltLGg7r8nSYX-I7sA>
    <xmx:bhBhaeY2Hko8TqMSlCAuO06_SSfjdGj7LYp0VLUunC3T1OfYcd3SzW-8>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 09:27:57 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Pushkar Singh <pushkarkumarsingh1970@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 4/6] doc: patch-id: use definite article for the result
Date: Fri,  9 Jan 2026 15:26:00 +0100
Message-ID: <V2_the_result_c.f._1.9.1b6@msgid.xyz>
X-Mailer: git-send-email 2.52.0.421.gc32ead4fc78
In-Reply-To: <V2_CV_doc_patch-id_3.1b2@msgid.xyz>
References: <CV_doc_patch-id_3.1ab@msgid.xyz> <V2_CV_doc_patch-id_3.1b2@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-patch-id.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-patch-id.adoc b/Documentation/git-patch-id.adoc
index 9999f164b58..abd02fccdc0 100644
--- a/Documentation/git-patch-id.adoc
+++ b/Documentation/git-patch-id.adoc
@@ -47,7 +47,7 @@ This is the default if `patchid.verbatim` is `true`.
   as a key to index some meta-information about the change between
   the two trees.
 
-- Result is different from the value produced by Git 1.9 and older
+- The result is different from the value produced by Git 1.9 and older
   or produced when an "unstable" hash (see `--unstable` below) is
   configured - even when used on a diff output taken without any use
   of `-O<orderfile>`, thereby making existing databases storing such
-- 
2.52.0.421.gc32ead4fc78

