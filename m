Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FCB1D8E01
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 14:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760365681; cv=none; b=oMsMmsYa5qetNs70S1pUBY0vjpQmbrKPIqWrCH25upAXFzMxBBsL1Wkyj6+01gDQNbGNrgExbPQWjwlvPxM8zt/UfMVc70zLOmawvGOUd6VlrYQl+SemddU3p8bXhohUgrvwVuOe511iLCy3pZ3jNROE6+2+RUXGV1tvMW+h/oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760365681; c=relaxed/simple;
	bh=pVoHcMmvdEHzK2EG7hhCiA0P9hJws/rDDQ+/MgjQYiQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hBpKvE113DwiLXwVCsatJasT9oSgeFheLGnqFXaW5lKvukJLNnurCUf4URcDWCVvo+vv9ScpThfIJyD/VBvQpCSXaTkrf0XBnmM6cdn5LtuJsftLjGpxJc/3KBxMlTo2quqIMuV119+vTLnimi6N+/HN67i/HzpEaRD4vvDpf9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DshueXDg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZzkWB6Rp; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DshueXDg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZzkWB6Rp"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 9B33DEC00AF;
	Mon, 13 Oct 2025 10:27:58 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 13 Oct 2025 10:27:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760365678; x=1760452078; bh=2M+0gHbJD4
	SC5oB+rifN3BLxvGe3zqsRNl507Oif33g=; b=DshueXDgEtikr0ov5nE8Ko6y3W
	pXjpaccGkJzRTk6D6qlR16ZQVZvN4KrwVmNCGIqw71uyjbHpPKKHIhUr/t0Ci/N6
	XZ4RkqHu1oLksM/AxXVZGXo5CuzH9CLQhfuCOwVPTXx8Tv9UkuWxcA7Go09USH+J
	osMMKexOdAQvlW+CrR1f2bn48SmUQVeO7urp4H2Zx9W0iX2MZzFshPQpPEdjSv29
	iGhy/Ge9/kGL9cIB+DmbQM5PIdeakjZjuCVU8y1rCxEs2/bS3+KkIVn9bA3MGpnF
	AX/6wOIT5Dbu+LEdiTD6yVt028LTjH3ItsDd37ewWvz0L3J51F+NNNEA9paw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760365678; x=1760452078; bh=2M+0gHbJD4SC5oB+rifN3BLxvGe3zqsRNl5
	07Oif33g=; b=ZzkWB6Rp2MJqhvfgzkK2D8e7SMLbh4AwpGzWABZemSMRnPg/3cz
	f1oUwwM7OKQjARDcdLwSLnD3LegyrL9NJ8Uz7DdXTxpIqn1kIYMeCL6c2Z/t7jjE
	7L1g506k7IhFcnUMyKX+SfEt+P43D9R9b3EKuT+dx/ZqG4KSPdcTjlkN8fKk1AsN
	NIulF/9VIU7WzPT0gg5zI4Jp9njTzpi425zT2KO7qOHW2nBDRoapMfM2UdLsaipH
	If+nvJ8bcNMVhWG4qDvd+aMvLFwmQPe6zUzuQ3HoT2nhvZMmpEA/66yr3lc45YMn
	qDJZyQxPTrgDRDkO8DdMqx1pDk4WccwwQiw==
X-ME-Sender: <xms:bgztaHq-bjDEEQzX4w3R4apbmHPKod8k2CHWHrCV0GsUVBkPDQx4zA>
    <xme:bgztaIp27-Wi2WMpoO_K0-KzSSEzqsL__t7w5xRycjga6BmICjuYQ91TjYPabO_p2
    QygC_iUSxN-oFSF1DKuOpV3yT5HzIkpw34nUCOlT5XGkpIe-jEvag>
X-ME-Received: <xmr:bgztaJOCl2zc7fjk06jppXXEMKRm8BACV00VRXJhoOyyslXDj0sRwevUfFqa5SR1jMx7IKt8X5sfOoRDd39Hd9wVAgz3msP6p81o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudejkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfei
    jedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpsh
    esphhkshdrihhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhp
    rghsthgvrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:bgztaJy4dg7-6PssI-7cHZ-Q2vSYCiz5e3IHJ1WJMelCJmMaoe20Bw>
    <xmx:bgztaCv4eff_10HYi6iwtGfIKSZvk8oAtf76DSN4LeMOrnePi9eX9g>
    <xmx:bgztaC6aH1QJOAMuN8LJKjguI7wf2wTjq-1hfAtzV6WevsKtIYG2Zw>
    <xmx:bgztaBQNTcRBSG-Z1Hwurzjzvc17t1nzh7mQ2l-5yz_-PgdABNCcyA>
    <xmx:bgztaHzJD2Bs7lLKBr-AbBaay1pOpHKSiHh0IqL96Awvxp6V4HUqRk_f>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Oct 2025 10:27:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  git@vger.kernel.org
Subject: Re: [PATCH] ci: fix broken jobs on Ubuntu 25.10 caused by switch to
 sudo-rs(1)
In-Reply-To: <aOo4NC5zZDYMr0po@pks.im> (Patrick Steinhardt's message of "Sat,
	11 Oct 2025 12:57:56 +0200")
References: <20251010-b4-pks-ci-ubuntu-sudo-rs-v1-1-88cc846d251c@pks.im>
	<aOl7jFj9Ftd4wNH6@fruit.crustytoothpaste.net>
	<aOo4NC5zZDYMr0po@pks.im>
Date: Mon, 13 Oct 2025 07:27:56 -0700
Message-ID: <xmqqo6qa511v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Oct 10, 2025 at 09:33:00PM +0000, brian m. carlson wrote:
>> On 2025-10-10 at 09:41:14, Patrick Steinhardt wrote:
>> > Ubuntu 25.10 has been released. One prominent change in this version of
>> > Ubuntu is the switch to some Rust-based utilities. Part of this switch
>> > is also that Ubuntu now defaults to sudo-rs(1).
>> > 
>> > Unfortunately, this breaks our CI because sudo-rs(1) does not support
>> > the `--preserve-env` flag. Let's revert back to the C-based sudo(1)
>> > implementation to fix this.
>> 
>> I've requested that functionality (which I also use in a variety of
>> cases) upstream:
>> https://github.com/trifectatechfoundation/sudo-rs/issues/1299.
>> Hopefully it can be implemented in time for Ubuntu 26.04.
>
> Awesome, thanks!

Yeah, solving the problem at its root instead of having to work
around is a good thing to do.

Thanks.
