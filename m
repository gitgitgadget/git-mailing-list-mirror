Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB53210E4
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 00:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752624464; cv=none; b=qQXlSo2kH8iL9g3vFVJRMjWDunseHeQNcARDO5C25brsDRVX/1SP0Nc5B0HSuSRKhmLwwWRc1j26Eltlt9IdLQ3Qi0VWImUP7UnOqoYqaXtlNHiVhKPyXF4KPpHeBD4E0PJcL6LM6+CeWBcEMm2ccnX3GgeXbPH/MnB7DC1WieE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752624464; c=relaxed/simple;
	bh=iKR0G52VLaAkh+MCea3JhgtbtNem9rcFC6eH7em/h68=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aQTG0Zn0i08XrKaoYOYy4riQW+OumvNuiYfBR7LFWTbp9d/opPCg/AtaV536L6tQKg3qNT9lRR2PhyK6i9tO2s8jbk9IP/oXJyWbNHmYi0/9lVswEPvXax8mwreM7fbhscbsGajr0O1jXWSXk0iCV+mmjlDFcHYu6WKdrkpO/tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rS7qMB6x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jVDx+rc8; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rS7qMB6x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jVDx+rc8"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 647C41D0006F;
	Tue, 15 Jul 2025 20:07:40 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Tue, 15 Jul 2025 20:07:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1752624460;
	 x=1752710860; bh=sK9j6l+gMHc0Y6Pwj0pCM3KFtLQXI4aDuRJ6Z4VYQD0=; b=
	rS7qMB6xe0Znsl038WNJ+6yWe7J10xSEWfx/zjJAyip+Njt9xiR4JysMACwxFNNC
	t9d1XX3BVuXmaPMLQ2qLl908GCA5loRsalQgi9vakcdhV77sahJH66DO2F4jx6Vw
	lPwhdKpfXolX5INId5gtZQ/rX5J7T5/o0k0x5neN6TeK9TDHa34Gurhfvoc69p7U
	KhyyP1p1SrxZCndpPRBiGJ2p1fD4GFChdZ9K0hskAJdSq+GFsQNffhU+QJoVQujj
	DC7fVcSDfUqDUr4ZzitJLuig+pQNF2fV5EFxtOs+VdR7aLuNCdrxfF+8wzWjQkGL
	TwoDSJCIh1sG/tOQ7A6S9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752624460; x=
	1752710860; bh=sK9j6l+gMHc0Y6Pwj0pCM3KFtLQXI4aDuRJ6Z4VYQD0=; b=j
	VDx+rc8lglf3tZz7X6c+v6CoIWL8iWNxx4S7DHA/IUKOFoat9bp4RRT3tYEDZfq2
	xz+vrncut7WRcpAA4ff0QJ75l3ZF7S/HbeWw/D/3804abQKruxwJ4KH0Yu9p7MMK
	RnwG24sosruNYHge1nUt1zv4x67kGOtw7u8HJrw8MxH5utPhGukDF0V5qrOSj8oZ
	R3uPGo2o6JiTs9aLYrLr+UJuo07qlGCQzaUARsgq6nJaDi2UL9eDLfHvrmtx8nlV
	rsp7LFN2u2gty5o5oH4jIyNWg/o7kITMkIilFI9kCC4YgDnCzLwJN8ZJ+RlMBJ1d
	p9vO1MdibK6/HDVtTigiw==
X-ME-Sender: <xms:S-12aJi0T79wismaKIfm8qzEHJdKjRfr4TCKFZh7AzmpUUfuuUvk9w>
    <xme:S-12aImCOstS9LrdZDNOH94Wj8eQ_dHZbt-FthqTXQK27njN-Zt7MtC-fMoAyIvwT
    h3slDK-n4i1QOneXg>
X-ME-Received: <xmr:S-12aFq4nBaIMtMXZ3IO9s5AX4b_dKnh4uFda9voi7EbFGU0OqxZwPJUBpfiq6oI_dkcn24I8W3t5tE7fVLZuif4fyML4JUJK1g8LSU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehiedvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgfgsehtkeertd
    dtreejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevle
    fgkeefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlrdhsrdhr
    seifvggsrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:TO12aBGQlBrTCjqMH3Vmds4YmCOXY3PUFpAbBblnpPVINiA4y5sv9A>
    <xmx:TO12aBzr8qZLUmirB6Qy3aL0Y43m-V6Aya9zaZwHERVLK_FSoWAk0Q>
    <xmx:TO12aGpWZOLR-kbvBy5zZBmXmtYBBv40P1uPvhpLS5MO0UOUO0mknw>
    <xmx:TO12aLjtQDtPsGkEXQkFb8HAcXx5D1CGe8dOMteHwi5t6Y12JLz1Eg>
    <xmx:TO12aMR9o-PFVLYsjigDQRemc5qj42_98vi1mYXje5r0bLrls4nmceM9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Jul 2025 20:07:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] commit: convert pop_most_recent_commit() to prio_queue
In-Reply-To: <bc079b3c-a472-4f5d-95ca-390f9de25196@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Tue, 15 Jul 2025 16:35:07 +0200")
References: <bc079b3c-a472-4f5d-95ca-390f9de25196@web.de>
Date: Tue, 15 Jul 2025 17:07:38 -0700
Message-ID: <xmqqv7ntdmlx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

> Use prio_queue to improve worst-case performance at the cost of slightly
> worse best-case performance.  Then add and use prio_queue_replace() to
> recover that loss.

Would change in the tiebreaking behaviour (aka sort stability) also
a cost of this change, as this swaps use of sorted linearly linked
list with priority queue?
