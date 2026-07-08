Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B3F3264FD
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 01:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783473658; cv=none; b=TB6vFUJjDkU3MAxwMyvlKfI5/8Ncc0dUbX0tpA8vHle3NYdDoaif0jP3C4A+YlX6otpKuoEkCD8mSSyFmHEtkMdmIF4kFxgLzI9xT0kp5qlV2VVrGxkMXIRcNRHuznGNSM6T4XwfmdstkU6hgz+6+mDbsHPJiHnYKGuE7dRv5zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783473658; c=relaxed/simple;
	bh=2v86lOsm5Xq7xLnJ+Qri3f+lLVNkGcCrUT058u3YbZM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MFeWgRjCXhQ6f+37YYvVh9cRXL4ibeZ+nCF4VMTbB70wPzJ8NyAm9/Aa2ssXnM3l6Y5cbEy4NneMKDlVtgT7gTOVgoMdeEZ/dVHKgmlRkDXoQ5+TAwXUYdpDR3DnXmZ3Yxu2v/vSAYHygCRcEOHNhzXgdarkd/VFazEq7NTvHUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DKuZw1Jb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W21tgCB6; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DKuZw1Jb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W21tgCB6"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 64216EC02A8;
	Tue,  7 Jul 2026 21:20:56 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 07 Jul 2026 21:20:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1783473656; x=1783560056; bh=Ybu4lYHd3McYAemu/bWoNpKYXQbbVCjv
	Q6jcAosfeV4=; b=DKuZw1Jb76tdq95v1+3Lhl7LqFr5NijIZhoR/rgagGOE/Tiz
	gLPNNFBgGHCNquu+N3s/Lk3MLzoDH5pCSytzPktAnJaehN7ykwkD0f6U4Y1o+FSh
	QITLtgPQvl6Bk6pkCrXVxw4GIKo5qVFSBdVxN+Q5Bssl0g7WjLwMmcOJ/r5OOomW
	46jc5klQQ/R4AU8J3vPcdfx99M5zoxzspuHp1v2OJVhX4gHV4eXqLh0/UDXz6kZA
	CSl2x4A3Gyn+Jww3Ekvt/jMTSK0ZvJ1YFzGq71C/PYZdmqUbJQWhioMZfNGqG95E
	OAtSab/21hetM/XFCG8x+5UmAQyEnIcKwvxPeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783473656; x=
	1783560056; bh=Ybu4lYHd3McYAemu/bWoNpKYXQbbVCjvQ6jcAosfeV4=; b=W
	21tgCB6EnFYg3LPVCXJae+S2B+mWgVt+8NNHC89nwdPe2MjGsB12/olFzX3FRCMJ
	mjKXAcucYbYYN7wOEnsahJDPZUVZX4q2JjXw66uBWtmb1RlrOBhidNtzuwAJRkqY
	qcIAUPG1dGllXzXpGQtNwCZazxamo/2wS5BwbO5/t1jWiR7vGUuQZXqNDyoW3fO0
	ncZu7StT45GmrsCFNcKKvuT/jISdDWWDlzu/N84SQlOatYMFYm/uDWknyETXWceL
	4K1GpGjv/JehxNJWlK4P+RQV8H3jnniEOrm+TRjdvACivx9LxF2DMylNionOh7ll
	lwchkj16yfI+RJFace4Bg==
X-ME-Sender: <xms:-KVNajN0vCe3Z2v5338VyURgSL2uy_RTOw60ersFsLMnr8v48miK8w>
    <xme:-KVNaj_rOm3yAhBBP0ruxIssNtfDaHS2W0gVVhj2fCZRyYaLYLXWc8w_zPlvSau7Z
    U18TYv8mfQT3Tqa03RjSn2hhLmAy9pUk-aJ7fkbKAiX_E_4H_prgA>
X-ME-Received: <xmr:-KVNav65zSUKdqtva0pG3BFLwUEG4IejjfBifyk18ovtb1ddSKH_qdyUNDNaxGtlX3L5cc5OBphxVUA14zpPggcLNJl-6JY5xdn6Kus>
X-ME-Proxy-Cause: dmFkZTFceMUJwwLVPkoAKLifhodzvJS/3l4ubv2HZbkCRBAPqUP7Nmun040zSCqKadzwQ9
    7v9AeRG1VZyakZS4+4kYMRUpNyUW+Mhd38Yx3yXiRo37o5RqixhnWApQ6Zp9pCIJlXR8Bk
    XDIF4S1iXHst3rePuJTwSNJ9aNuaJvyWcYZsnpOIJladEBmSIGwAwrDAJqFzgIqfG430aM
    40CF3oBJ19cWHn+WpyTPuT8HwmAIRErCUBsygCOUOebyimQ9d4Zu8NhBiUdXBnS0A12WzK
    C1W4tOEegu8AEzYoVhzSqadv6Nvpogdpe6ifvbJYWylGBYf81D7AVjuDOFksfgxbUpfxkq
    BrUwszC3qg6U2WUyDHp8PJFcPYxDsg6ylQg2ZjattG6f1/QNu1Wm+OWoHvjcC1H8ndCtsM
    aCsUgo0MCgGkETCbCNnuU4K7y8CJf4ERYtetWNzO4n2GQmB3bEyFe/KR/VA+NF1hiEjQbR
    uOkcRTLE324ReeCkkzmFhOzePS5iZmIpQtGweM/Fe5937L0/rCQ6yTf7Cssgu2+m5qYAey
    ZM9AMfpa68gBSTS0FCuSLLC0a0tJoqRGFXgG1MWUSirsWScO9dmR9vdQYs1oRX2nLBOVrm
    FpvQx65cUJ3J0W9R4BPxNhiZUKhxzA5lmw5BXOqurtGLqXaae8FErU6/oqHA
X-ME-Proxy: <xmx:-KVNai2utM8v9ECeK5iY2TLN7sJadyBMYyGg6YI_O6S65caTK8ZNqA>
    <xmx:-KVNauAUrUVyKLRvuK29QxDnRcbM30Cj_fXmA3F4iSWl6QZHF1XXDA>
    <xmx:-KVNas0Oi0fuEl9_IjTKa8xXYN_fCFVMNvHkTSvwHTladUiY5685mw>
    <xmx:-KVNagsuEqznsRguscsgkKI3DM0lKS8eJs8fQ5DYA7ckspBmdGMyPA>
    <xmx:-KVNaumXljZSxCJEEhrjsjxBY43EwBHhuj-QteY0RYnRi27NGiV2mbKJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jul 2026 21:20:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] SubmittingPatches: abandoning a series
Date: Tue, 07 Jul 2026 18:20:55 -0700
Message-ID: <xmqqzf02xonc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

The document describes an idealized life cycle for a patch series,
where an author scratches their itch, improves the patch(es) with
help from fellow reviewers, and iterate until their work becomes a
part of Git.

But sometimes a topic may have to be abandoned or retracted, with an
option to later resurrect it when they can, and it is much better
than leaving a topic in limbo.  Clearly state that we encourage
contributors to explicitly retract their topic that did not succeed.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/SubmittingPatches | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git c/Documentation/SubmittingPatches w/Documentation/SubmittingPatches
index f042bb5aaf..f14ae20aaa 100644
--- c/Documentation/SubmittingPatches
+++ w/Documentation/SubmittingPatches
@@ -95,6 +95,21 @@ input and avoids unnecessary churn from many rapid iterations.
   top, it gets merged to the 'master' branch and waits to become part
   of the next major release.
 
+But sometimes things do not work as planned.
+
+. A discussion on the list might convince you that your changes are
+  not such a good idea, in which case you are expected to explicitly
+  retract the topic, to releave the maintainer from having to worry
+  about it.
+
+. You may have to stop pursuing the topic due to various reasons like
+  lack of time, other commitments, shifting priorities, etc.  It is a
+  friendly thing to do to tell the list in such a case, so that others
+  interested in the topic can take over the topic and continue.  When
+  there is no taker, the maintainer may have to discard the topic, but
+  anybody can resurrect the topic later when they (including you) can
+  spend more time on it.
+
 In the following sections, many techniques and conventions are listed
 to help your patches get reviewed effectively in such a life cycle.
 
