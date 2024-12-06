Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A944BA20
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 16:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733501383; cv=none; b=ujDxBIRTTW3Y2MQ3UbIg0OON+G7yawVIyQtZlHNKCAU2QtzCMyTCEOEtX6hZ9aGUwm3i9Q8dq0Iti+XScyZ5D+G5Cs7YuCu89KX73qGL2GPQ15W7asrE3LI+AoNmAnH6rErVBMI0orE1+8/nIIHtZrFNpp+ogyfV7efdqjWWZvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733501383; c=relaxed/simple;
	bh=m0xC9rw2ES6GZNrw8VU14UHB28GtNLlYMQpYSatXN1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=INR3tSjd7d7RHtM6lvmkXCYa0DewUXEAa0SlCFgo7hmV7M2uXJnS7i0QvvhZXlLSpRR6J3HZ5p5KToALUSSo+xC30JLBH+cz0k1UnMCDDFxCpY/pameQifCv0BeG7OfNC6KjcfINNMk1fjG5rtysWpFk81wGK2C4TO6KSAmC9uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Yvxi754D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CvEHkNB6; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Yvxi754D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CvEHkNB6"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5E64125401E6;
	Fri,  6 Dec 2024 11:09:40 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 06 Dec 2024 11:09:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1733501380; x=1733587780; bh=m0xC9rw2ES
	6GZNrw8VU14UHB28GtNLlYMQpYSatXN1A=; b=Yvxi754DJgFMx9WnSVy2C7Ej5Z
	sh+uvLF+Al7bMk6tAm03230CGAg1AMVjErl2ljiPkLqw2/Lo7WDbUZNK1v0IYda5
	JMPkLd+azR4t68F0G5EcCyJD/vcY4hTJecfRCcK8ZDU0OQB3lmESWo7l5sMGWsLT
	Bb0ma4EPfD5Td/q5HUQhoFen2/mBe11C5DVC4W9TQQjnlHFLpjCd2vhOIPegH0Wk
	S2QPbd/oWiG8pK6Kw216sDZCy/7LDDyHeNdatHlZunwCExTEmaKB8XM3aDR398s+
	kgbylJ4nlsfMJzG/U/fLYqgVbU3lVk3NOBUF+532mJgPD7Tw3Zu0oc6M7ppg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733501380; x=1733587780; bh=m0xC9rw2ES6GZNrw8VU14UHB28GtNLlYMQp
	YSatXN1A=; b=CvEHkNB62weNjjFxmSqvFZJdUyiBLKDxfQ/Y8L5pmKv1OdxLm63
	rG7koWUIb0t8FktLu7MX+vs+7XjkgLzUOwuTS+gAsltUqJx0FMW+bWmUvhvYsqvr
	AD50SSrsVEPH2AYz9XbPyiBVmHGP/YDDiqu2X3njynx1iNkf59XH/vP4+6JXOoA7
	yZExHaaARZfew3S75u43u6ILIg76+RqG+ti7Yxh3VUFtCm3DAsr4GsuPhszy4cHR
	A8PwWHwCSHB/vDwO31arCL4BFqcHD+7ioVnHoS+8srmYNyTy7sU28DkKGYXjo0Wt
	qGHajvvEIOTQ16h1dnHhXekNORhlqvxVXcg==
X-ME-Sender: <xms:wyFTZ45uzI38F5227Pbjrunpw_Ptc6lGcasyJklPOtk3opHTt26szA>
    <xme:wyFTZ57CPGIRPO37_51x2_5VMITLlk-XGulDvLQst0IojAHhn7830OYUNXnd-nBUc
    kXY3gakPHfEdF9_zQ>
X-ME-Received: <xmr:wyFTZ3cpwc-C0B2utaXmiXA0r79klEiZNyJ_QjdqYm6DSdCyc3He4nGOO_FujKOud0q6AcOF3kN_HNqvGEQhlxq5k2n67Wf6KKUa2a2YQyR7Gw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieelgdekfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeduuddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtoheptg
    hhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehphhhilhhl
    ihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvghstghhfigrrh
    htiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomhdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrd
    gtohhmpdhrtghpthhtohepuggrvhhvihgusehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    phgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshh
    hinhgvtghordgtohhm
X-ME-Proxy: <xmx:wyFTZ9L9FrEpMgqBl-abU931ymJKrIvh3s3AnBQCYIza3ppNWdMLTg>
    <xmx:wyFTZ8KCsGQ720HqsQ_5MG7R2gcki-xqMrOg--2Z5JPajwtKPbELDA>
    <xmx:wyFTZ-yUYLw0TyczTcHecFdlUvxeXNiCC3eN28T6YyEvBV59Y0y2lA>
    <xmx:wyFTZwICGV-_kUxAmg0_COG45F2w-o5kdspGwG6GSsAHPtOurKYB-w>
    <xmx:xCFTZ6y6Nc8a29pSogAQrjNadoyh77JQtkiTWvxCSDGoXZHBf4TiFI6M>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Dec 2024 11:09:37 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 790ee369 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Dec 2024 16:08:12 +0000 (UTC)
Date: Fri, 6 Dec 2024 17:10:14 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Taylor Blau <me@ttaylorr.com>, David Aguilar <davvid@gmail.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v11 26/26] Revert "meson: fix conflicts with in-flight
 topics"
Message-ID: <Z1Mh4O5sfy70C-Oa@pks.im>
References: <20241206-pks-meson-v11-0-525ed4792b88@pks.im>
 <20241206-pks-meson-v11-26-525ed4792b88@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206-pks-meson-v11-26-525ed4792b88@pks.im>

On Fri, Dec 06, 2024 at 02:25:01PM +0100, Patrick Steinhardt wrote:
> This reverts commit f5e9b17ebcc547ecfb14c542c06e30e95aa80b1a.

Oops, this last patch shouldn't have been sent out as part of this
series. It's what I have locally and push to CI systems so that they
pass on `master`. Please drop this last patch.

Patrick
