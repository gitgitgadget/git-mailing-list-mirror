Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964B03FE7
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 23:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755644425; cv=none; b=JM5Lro758bbKS7Fu33Ed8+N6s6yTCIbY4KTzU4Al7JZVzIVRyD2d7AzTiiCTHzMBu2MTs+a3nMQ81aazCtbdUfEx29Nn7LjWKAPx+Zy4bGQxjKZao79ZGLPyNsQBOHCV9d0RKTOvidio+7sKfU2UnL8R4vO0AlR3woz3xS2P2rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755644425; c=relaxed/simple;
	bh=7Iv2xAX/ZdQyoGg+lzDjVl3kgUmn2KMoYkdTXC6fClk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tT+qGuCLvvGFT/2X3lkX5kWdBm04G3cH7EfwmCia3gVgO8oQM4gvyqzsPOrFva560IdahmMY3xZgZlspFSqTDAXPHbHaobZuMx/1hi4rmp2AQ2bErkDVPUzdLFG2Xx4efvySz14dNJhoriDUnXLNaNyPJTB7fX5qqmbQKb7nczA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KT1YTWXR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I14hCeO1; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KT1YTWXR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I14hCeO1"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ABCE71400098;
	Tue, 19 Aug 2025 19:00:21 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 19 Aug 2025 19:00:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755644421; x=1755730821; bh=aYGPpwW33h
	E40f9ZPQoHZovvr3cW7IE43mEMmUbKjX8=; b=KT1YTWXRu49TlP8B2Gg7glU4ql
	QeHmCQJe+eMe20T0IFrVnizyrR5ytwDm/sJoiRaTBqhppofnNQ4VULGmyimO5boi
	s6eXUC2IiQrzPkFjbTTY3ua1dNPM/PdFOuhVuG9NMZEA9Io2QT+KyZwxyR4JTVsj
	5MFkvzSRSj6OHs2EbTYaX8KxR+DosEG0Z0RFNRtN+Mc+cJ1TzAWN3LRZvEdE+AHF
	Fc9db4Zn6RhNE4GbGZtHIdRnLFiNHsmmHqzedrT1T0thVazHFbOQud3Yj3+d5b33
	Ms4+zB6uLr2uY7/LiKb+UwKQaKMj9r/R0tIL3gEWik77+v7fvP/c7XYxoReQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755644421; x=1755730821; bh=aYGPpwW33hE40f9ZPQoHZovvr3cW7IE43mE
	MmUbKjX8=; b=I14hCeO16/YDQx2GzYuXtEQiTUEB+KBPX1kgg2ZRmOSIcaYb9Vb
	d7ihRX+4UL9jTwB/zROGjghoGWjYQgotBzqYMLr6iZXJu0TCeF1PnJuZ2BDbE+9v
	J7RKwc5cmxXU1GzT0Ui476ze12jar5UbyU86GTFnmLUg9heKBQQpKJ7U0YvsOMS2
	7ceXTWe7kTtYrryIVNboobEsx8cskt4eDj3Qpw8TalWOBVfr+fdIKTqhGYC9cOik
	blZKki6lkLLlARYxBlpgUDcz6rurwMpZTeZ/Fy+diPiNQkdkmW/lDG8xVw9ZTaoO
	lwqN8DYrEIb7tiGvOTx9NUGBTxNVuwGswlw==
X-ME-Sender: <xms:BQKlaH3pY_HjDxkqVeAlINkIoDldNNoH42R-0pk3CAIX3pVsqgSOhw>
    <xme:BQKlaArGdp5qo-oXbcl0N-cL-_lWUx6NCD1wMcf6GQ71WCRa3hupTVlMBkCr1IqYX
    mdrQDN6fR3iznioXg>
X-ME-Received: <xmr:BQKlaEdc10S09JfQA9VbNILunndn4-641-ZgLLckFjMYokjB7Tm_VD9D-hdFhDy2dx-wZhIS0I6YUoUde70uV7GqNetcOfaCWVqTz6w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheeijeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepgeetieegveeiveekhfehjeetvdffvefhjeefveejfeegffffudevieehjeej
    feehnecuffhomhgrihhnpehgihhtqdhstghmrdgtohhmpdguihhstghorhgurdhgghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnh
    hivghlvghsrghsshholhhisehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:BQKlaPpJTx2pxxnXoGbkq_nFCq7BSX65JP-GBhVWBSMfifMA9wCYzA>
    <xmx:BQKlaFFpRwT1JHdTynDp7c84fNGYDfhfPNWPzpuSfeGtxMqqPbvn0A>
    <xmx:BQKlaPuwndcsd1fOxg-NTLKlIWSp8Ka_Dm_OYD3kltdyXECx7DnddQ>
    <xmx:BQKlaHXDtmdwOi2hMp0Mn8plwQ0JT8HbeDZKthVeLE59WsnYSfAW7w>
    <xmx:BQKlaNEIszS59dgSlOxLo-8jZIReXVCameciBcvf2qvTxFpa0cLZQ-r6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Aug 2025 19:00:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Daniele Sassoli via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Daniele Sassoli <danielesassoli@gmail.com>
Subject: Re: [PATCH v2] doc: add discord to ways of getting help
In-Reply-To: <pull.2033.v2.git.git.1755641032154.gitgitgadget@gmail.com>
	(Daniele Sassoli via GitGitGadget's message of "Tue, 19 Aug 2025
	22:03:51 +0000")
References: <pull.2033.git.git.1755630128134.gitgitgadget@gmail.com>
	<pull.2033.v2.git.git.1755641032154.gitgitgadget@gmail.com>
Date: Tue, 19 Aug 2025 16:00:19 -0700
Message-ID: <xmqq4iu2diik.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Daniele Sassoli via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Daniele Sassoli <danielesassoli@gmail.com>
>
> Discord is a great way of receiving help for members of the community
> that are not on the mailing list or not familiar with Libera.
>
> Adding it to the official documentation will aid discoverability of it.
>
> The link is the same as the one at https://git-scm.com/community.
>
> Signed-off-by: Daniele Sassoli <danielesassoli@gmail.com>
> ---
>        
>       +==== https://discord.gg/dxGanGcBSP[#discord] on Discord
>      -+This is the unofficial Git Discord server for everyone, from people just
>      ++This is an unofficial Git Discord server for everyone, from people just

Forgot to commit the update of the link?  Shall I amend it to point
at

	https://discord.gg/GRFVkzgxRd

locally?

>       +starting out with Git to those who develop it. It's a great place to ask
>       +questions, share tips, and connect with the broader Git community in real time.
>       +
>
>
>  Documentation/MyFirstContribution.adoc | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
> index aca7212cfe2..35f18ab9f7e 100644
> --- a/Documentation/MyFirstContribution.adoc
> +++ b/Documentation/MyFirstContribution.adoc
> @@ -52,6 +52,15 @@ respond to you. It's better to ask your questions in the channel so that you
>  can be answered if you disconnect and so that others can learn from the
>  conversation.
>  
> +==== https://discord.gg/dxGanGcBSP[#discord] on Discord
> +This is an unofficial Git Discord server for everyone, from people just
> +starting out with Git to those who develop it. It's a great place to ask
> +questions, share tips, and connect with the broader Git community in real time.
> +
> +The server has channels for general discussions and specific channels for those
> +who use Git and those who develop it. The server's search functionality also
> +allows you to find previous conversations and answers to common questions.
> +
>  [[getting-started]]
>  == Getting Started
>  
>
> base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
