Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DA723B61A
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 22:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752185780; cv=none; b=Z32zXgE3gMhcPy1c3g46dSTjLVGCe0qsVaNkha0SaArmLfqV9BhpownLkO/ZBMTGAA6onz1w1arsL8bP2rIeeTaOw08S+hhAmpul4fWou326dHajLWic8IEw3IKd+fPeHMoLmGKI4K0/WhQ0Q+VtLOUPiSGV2CIhyHZrI0ynvQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752185780; c=relaxed/simple;
	bh=VlEiNG0zK52FLXS0+ATihgp6L8H/DQU/z5qGpyb6SjE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oQbAhy5aOq7DApmJyj/0GBLfKF/k2FZAmVGK/fAQ6Y96DotPOfO9+fFtRglf4B+i3OQoaLSr+5gjfdBycvHOd+aMn5zLOVQRLsua9r+4IE7obc3kpjMWQYLZT782fN6kpqlUKvIITix6K6CCwyBJ374hdbl9BS/sxip4mRgY2mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WZX2vRt6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h3ms7llb; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WZX2vRt6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h3ms7llb"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 83E701D000F1;
	Thu, 10 Jul 2025 18:16:16 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 10 Jul 2025 18:16:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1752185776; x=1752272176; bh=roFFUibW8RQ1tiMsgwujI2rxdiAAdF4v
	Z2oTkzsINAY=; b=WZX2vRt6WuqqbLrZH48a1Qt7SkZUPKsDGlvxI/zadJeKgUt3
	iZI5WDwdgLFBiQCP/5gBmACRepLWTzNS96qt3J+zZK9wf/1wVp3tnE3gktRl1aHX
	ZcNtxNB/aX0r2RNic/BJdlUa4Y7O/ySPY/uaUNKq+RgQ1g3P8E+VZ/xVBT3vGoxq
	25CrNNR19FP1qa6heFBuwPP+7oh5WvrSXo4QYmR880piYYfBl88VgWPz09QEEwuX
	PHR3447kqlC7lf7INriTZQn2h6ylw/KOW+b+ko7xYwek8376xmx+cFoGZqSrTniq
	h3IEZQR5w5Fmq685/w5UM3aShwx4pYJE5qBTZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752185776; x=
	1752272176; bh=roFFUibW8RQ1tiMsgwujI2rxdiAAdF4vZ2oTkzsINAY=; b=h
	3ms7llbaUAybBqAKaLrqpi/VC7OgBtz4JkHDD/zKYgQT+xbWVDYzaP6SxnhOYMSA
	9/r/MMY9qeH68Gi6mcaE2DOxclciaOD+qd+shRAj6StF/bP/sbL9jYPBHFbOi5gO
	ECJwfaRvGjLwyVAe73VQit5WH6z/BqsKMrnf5eptc2ZuGIIEZFPa5qdhsPhIqISo
	tbS569PeaAv6gsckMTuvGazkJpQhSvbNcr18o6dwwZ2M4MVXyxqezO0W3my1STo/
	D9e8e0EGd1ugFCseCx+8e3P+X9detSpdcV4OB3gWMWcwuqIeJlJT1ZF14jb/n4eu
	8YPjbiohV98KlKEajqvpw==
X-ME-Sender: <xms:sDtwaD9rx99cO8cL8aI5a1N7Y7K-mfgbBwbU6g6TZ2PVWmL28nitbw>
    <xme:sDtwaP45oCZ_4NdDhfIS4iTYii4aeclkOEjl9mLIFdtq5aJYGXdZhOe14y_hmEOe0
    CMo2T8Iq3ZWN54R4g>
X-ME-Received: <xmr:sDtwaC0uVUiDXVLgsr04s2R6frnNF27dicLwmTb0CJBmQ9rSD5WsllU35CDj-fUTi2BEXLYAMb-jjEk1SQwHxC-zWbfy6pqK55JzOLk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegudeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvufffkfgfgggtsehttdertddtredtne
    cuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohig
    rdgtohhmqeenucggtffrrghtthgvrhhnpeelvdeftdeftdekfeeuveelgfelteeiueffff
    ekhffgkeevheekhffgteejhfffgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtph
    htthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:sDtwaOCUA9W1HJIqJtkS1S5nvHoV742k3KEPg8MpF6G3wUTlkh7nog>
    <xmx:sDtwaM2OXwZoLc9xsMajTIvKAXdzuq1kKti8BxBBIGbaMFLThOGjZg>
    <xmx:sDtwaAuujNf0p2X-rf43IFUy4HtPFOQR2s1hNcT-71ELnPqUIYaOZg>
    <xmx:sDtwaE70OdluN0gDe2IcgQmTVAyZEB-cenE_YLurDfYzKLqEBlx9ZQ>
    <xmx:sDtwaGjy4WT8j2vozTmwOvKFg6KVcZo8f_8SaMWdgkjn4YK-oLO9YqPp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Jul 2025 18:16:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [RFD] helping distributors by changing the release schedule?
Date: Thu, 10 Jul 2025 15:16:14 -0700
Message-ID: <xmqqldov4rpt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Seeing that some distros seem to have botched their own backporting
of gitk patches to maintenance tracks that are older than what we
would support, I am wondering if we can do something to help them,
without bending over backwards beyond reasonable effort that should
be expected of us.  The latest security fixes went to 8 maintenance
tracks but I suspect it is probably 5 or 6 too many.

Here is an idea.

What would happen if we stop tagging any releases, and instead
change the "release" model to tag the commit that happens to be at
the tip of "master" once a month, strictly based on time (so after
Git 2.50.0, we would have Git 2.50.202508 and then the next one
would be Git 2.50.202509, if we decided to do this once every
month)?

If we "release" reasonably often enough to make the distinction
between the tags so smooth and meaningless, would it help in weaning
the distros off of their mentality that pick one "major" version and
stick to that version unless the user upgrades the Operating System
version as a whole?  After all, we do not make changes that are
backward-incompatible at the end-user level, and the "we stick to a
given single major released version to give stability to our users"
mantra that leads distros to ship and support an ancient version is
hurting them (and their users) more than helping.

