Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4372314B950
	for <git@vger.kernel.org>; Fri, 23 May 2025 15:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748015311; cv=none; b=Bm0vzkXkT4zeia2cCwE6CzDNp9a0f4JTHTZZE+QSwSyFC40L7rbifhjVrO6pns7ZiIT/JkxaOwIWI7cGGDirTU5ddWpm11jbW54V00OUz5aIlKD2K8MaShQVvG9HW4Wd4L4d8B6Y1FRdp9aVYc86TPIzcFGHhTjXiFTSldbWkKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748015311; c=relaxed/simple;
	bh=f4xxedCLm8wuilqQ273C8ASJMwbUyQO7ZPmfDltl5LM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a2jBvSKRawwY/zNQqmMhWiNON0QwHYenLPOEyAGL5b503/iT56kixeScOol7baZ6I050eloXLatXKUI4l00C79vVz0vD8zH6MvNkZ6ib9ZBClKqXP0ZJIqJgKAD4s+7Nz9bJgB4306C8eDuFsw+qVag1WUFcEyQnatkBKQdpcH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UwXsi61N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rKZoUQcT; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UwXsi61N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rKZoUQcT"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 3FFA51140159;
	Fri, 23 May 2025 11:48:28 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 23 May 2025 11:48:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1748015308; x=1748101708; bh=Y4VXC2kfUE
	z9s0uMpYE75aFofQR7W0/pjHU86iQu+J4=; b=UwXsi61N3pAcRsHObOgl/PMb2G
	Q8e7BPYq/EC1KLVUbH+Hd2fK103+Felra0W+TYH10EZkdcGKH/pUAc1zwbxF5nGC
	+Ba0kLsyZZJ2RpiUYrHnLShJKXgaD5qIfwNXMOYd3E4HzWG6OV/QX5hB5whzQ7bz
	4OkwppiSccDe7+14Hu4/Tn0zCyJi8lP2cLxpZsxb2KJfjmdc6AJLOzt+iYf4QbUI
	PDWEL4AY35U2OhSEHPV48Fdi2J74ATnfA1dFfNkJ+zXwKZh0YoSScp5uQ+Fw6pCv
	sVFxYuqBsnUM0yByFf738HvbLaM5lQ66aon8+OHU/EqcyZB2QBzejj/6bfkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1748015308; x=1748101708; bh=Y4VXC2kfUEz9s0uMpYE75aFofQR7W0/pjHU
	86iQu+J4=; b=rKZoUQcTtLxjHHTZMv3DqtOZl0AwBfr06Yf3mjXSntvd85qS3gS
	/0UscTeUF2JHM2bqBteTFlFGVduc5nYbLPIfvVMvMQ7ofTeI8gxRl/19M/taV7At
	w/Bvyrj2tDx7q43GpfNDNEnrzuG5bPzk3Q6wEj1g9AnnPfCS3jphg8wcrfxErnsV
	yU+YHjDjDsXNPkZDCxj4Q3xRtHhvWZFcR+CGY2nv/UkGoW0IFOWVOakyNELmDxa8
	MPIrixy7tsKlHscOM4ADivfsvMHE2HtVnOurDdLqk2XHu58O3kaKgnhAYDW4b4l2
	6pxI1RJWUbUhw8rdvRYCRILD8Hw6xIWTReQ==
X-ME-Sender: <xms:y5gwaJLDTbffgAsvGti8i1je6AT08jXLEyyW-ehly_jssbgz7L4YaA>
    <xme:y5gwaFKNXxge58rrtE3VySxq8VhRXQIxrr9gM5Vxykg35IwD8w32_lRszqWMY5f1W
    0TKvqR9bITbyYiAiA>
X-ME-Received: <xmr:y5gwaBswn5SWJCeaFSiirFFFvBTkAc0k0jXEfCbzY38ulbJ87lPjhqPdd_c2mbEAuUNJ6acPyE6tsXdrup4qpswLDNhnAWhQ2n2hAH4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdelvdehucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffffk
    fgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceogh
    hithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeeh
    ueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosgho
    gidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepmhhmohhgihhlvhhiodhgihhtseiiohhhohdrtghomhdprhgtphhtthhopehtmhii
    sehpohgsohigrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtph
    htthhopehophhohhhorhgvlhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepghhithhg
    ihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:y5gwaKYpx1RWAFDD5HX7TfQNBR2SssrNr_FYqRNeWlkt_W9cBTzbsg>
    <xmx:y5gwaAakg51ePpYACrusZ0JV-E5_qoIRkfhImIixrcW0WustOb-Qig>
    <xmx:y5gwaODW2EAnk50rL09woSe2tX3_WBenM73-eIoSKF_TKr8ZA9UX8Q>
    <xmx:y5gwaOZOfja1k3r5SLrYebQ4FQdncaWar8bS0Ni982-qA_HPCEkp9w>
    <xmx:zJgwaAGj-VZyCGRg9DOkLlO0dmn1chWVHJ3ei0oHxMAboC3XBnpFJ9Gm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 May 2025 11:48:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Matthew Ogilvie <mmogilvi+git@zoho.com>
Cc: Todd Zullinger <tmz@pobox.com>,  Jeff King <peff@peff.net>,  Ondrej
 Pohorelsky <opohorel@redhat.com>,  =?utf-8?B?T25kxZllaiBQb2hvxZllbHNrw70=?=
 via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v2] cvsserver: avoid precedence problem between ! and %s
In-Reply-To: <aC_90R3ohRRBVIV7@comcast.net> (Matthew Ogilvie's message of
	"Thu, 22 May 2025 22:47:13 -0600")
References: <pull.1925.git.1747813502225.gitgitgadget@gmail.com>
	<pull.1925.v2.git.1747822992457.gitgitgadget@gmail.com>
	<xmqqh61ear4s.fsf@gitster.g> <xmqq1pshc2vs.fsf@gitster.g>
	<CA+B51BGLK-3R9ev4a8EwkGHQEBi2QhgxvAd0CHMbphrxPM74eg@mail.gmail.com>
	<xmqq7c287i7n.fsf@gitster.g>
	<20250522170536.GB1613@coredump.intra.peff.net>
	<aC9lM12GyntAp2tR@teonanacatl.net> <xmqqtt5c5viq.fsf@gitster.g>
	<aC_90R3ohRRBVIV7@comcast.net>
Date: Fri, 23 May 2025 08:48:26 -0700
Message-ID: <xmqqwma7z5th.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Matthew Ogilvie <mmogilvi+git@zoho.com> writes:

> However, despite writing and (incompletely) testing this code, I
> have never *really* used it, and probably never will.  So I'm not
> in a hurry to try to test or fix it further...
>
> (For that matter, has anyone ever heard of anyone actually using
> git-cvsserver at all?  I think I would be surprised if there was anyone
> using it, especially so many years after CVS stopped being maintained
> at all.)

;-)
