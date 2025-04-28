Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAA541760
	for <git@vger.kernel.org>; Mon, 28 Apr 2025 20:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745872530; cv=none; b=oH+Kqp9wM/9cgqXjzmlxsPDoFXC4yMPHjhdxI1R3C6jUYKi5ttQ6gvzY2JP1iTs98GSlegLwOA5cpvY4mRe8wnSrDJtnausr+DWaoEQ+2+qUatcbWUjZKjOhbhG7qoFrqYzE2iPZ8hxzYeRADk1tjMFqJ+FRshr8zH+50u268bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745872530; c=relaxed/simple;
	bh=YLL1s6boWjSOhOi8qr7E/LOcwpopn1J6OCcBSQ1O+fs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qLqOrYCXLiYWT1RfC0xbAGXpKtNOdgOQsnbkY+2096Y078318Oa/XrX3oQ3RfXryRdC8C+8rVkCQnLEH95k0yg+GGhUuG3DTk7B2udT/ua4ABPtrmH8jgbWRGyIcnvwVRFmIKvpW+AlzDvgmGJ8w25wSHf5IwQYOSKpvhOn98+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SLlGsU4F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k5y0PqHI; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SLlGsU4F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k5y0PqHI"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8D8961140296;
	Mon, 28 Apr 2025 16:35:27 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 28 Apr 2025 16:35:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745872527; x=1745958927; bh=c6oZqGGr/P
	PjZUa5OjEby3bP5IHKf+hYwgAkYeDgy4E=; b=SLlGsU4FTBdvrTv39/fJsHCvDX
	yz3/OM4UQgpbyrd5hMp4BBCyBHFHXaKh0yzGhI4nn9ZhsB0mZVfHD46poYLH4SU+
	31XHTHH1MWecMPFThBLJA7JngduNcYazSaIEGn3GofAPUVt+/Lx9wxqaCy2N3bba
	t1pIowfdg2SHw/PSBntsyry6hI1ld5c+zt54NF9RiAXnduW8My4h/7fHAlvkyWaL
	9Zo60GL4eVID4QGxg3G8v+SJ9pB/IvHda9nEB0CW1jYluc33HhCkUBPwcclfGb3w
	fn8W/M9zdJblbwgl3DnegSe/Baxvn6BhVXHSeOflo6sWgeAttv8RSYwYXuPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745872527; x=1745958927; bh=c6oZqGGr/PPjZUa5OjEby3bP5IHKf+hYwgA
	kYeDgy4E=; b=k5y0PqHIMLbJN1Ye3pMAnohJ2cgkDEBJ4TJzMqTab48p+nN/LCo
	rl61AvYnvIWWUOa21776AQCUvGnaRbZytsBnljaTPC5xVbTrum12h8UG4akgiFpD
	7IUGjfTNTwpzhNm78DizhFN0gYHxYVj7QhtB/CwVBrNujfJWXXrKm1mtqASmVRFU
	UVpLHbT6SAyVPyseCBWvr0M9m9nlIbKThmKTkkeEwGo/8giQrqJmn7wibKoB0N9j
	Sx1KW/qnFcUIoU760jP4u1x3qI9YqSX2vGXP+xoo2m3bRhejvyaOvObJU21PQhuh
	8XdN8SOhmwcZhVMlEAZLhAbeBPdgOKI0kHg==
X-ME-Sender: <xms:j-YPaNy30kxaA_H7haHL3eS-4doQ0CrEdUW2WYpIHel5Ikn1SCTTxA>
    <xme:j-YPaNQMrpV1hcIPvIbNRMB_TpfKtvBP_3ddowVJcU_CIMiod8VICDtkwpfbmwEqW
    aDf39_ebji72vzi7A>
X-ME-Received: <xmr:j-YPaHVGcr1ONRVnYjC3rMsH2EFF7e-LFv_xBCjlAkiZoILgS8vjr3rSp_zOwcbwco3MQ7_CKiRPJ12ClA5hG0qUknX321HZ9khe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieduledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtohhlvggvse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehj
    ohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehgih
    htghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:j-YPaPiJtAOVIiL7iAZlqmN5Lhe8heJ6Ukln6Zo4WjuFf4eN-Gh2Jg>
    <xmx:j-YPaPBSt0RVRnk60RLatpCQ2vxmz_Ba9tbpPV3Nax_4x-HXhcGlvw>
    <xmx:j-YPaIKMuAxyJcrBIllPb7G4qAV3rf2YDhFfFHnJpJT-VfavJvTCDg>
    <xmx:j-YPaOAwRu_l2C3vS6qCWeTdJxz6ASsryPGDk0cC1phuaMtHmlCsBg>
    <xmx:j-YPaPuhAHcbhPVWpYICfGVtZco8deZzczXGqYEqeGJMdpGPOfGwDiSt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Apr 2025 16:35:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Derrick Stolee via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  peff@peff.net
Subject: Re: [PATCH 1/3] test-tool: add pack-deltas helper
In-Reply-To: <6df25bf2-6df1-4c3a-9061-e3297dec38ab@gmail.com> (Derrick
	Stolee's message of "Mon, 28 Apr 2025 14:59:22 -0400")
References: <pull.1906.git.1745430004.gitgitgadget@gmail.com>
	<5d4beb202d6ed842de72928462a10a4f5faa2718.1745430004.git.gitgitgadget@gmail.com>
	<aAsQwSfr-YvS2Mvh@pks.im>
	<090ef16f-42a7-8de6-a79e-5a1958e2c103@gmx.de>
	<aAtZuU6Qqfag6OHj@pks.im> <xmqqbjskurz5.fsf@gitster.g>
	<275808ae-7126-4a24-b5f3-283ea8023f5f@gmail.com>
	<xmqqmsc0dyyf.fsf@gitster.g>
	<6df25bf2-6df1-4c3a-9061-e3297dec38ab@gmail.com>
Date: Mon, 28 Apr 2025 13:35:25 -0700
Message-ID: <xmqqwmb4ausy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

> This makes sense as a feature, except that we need to write the number
> of objects present in a packfile in its header. If we wanted to avoid
> the argument, then we'd need to load the data into a list before
> starting to write the packfile. By taking the count in advance, the
> implementation is simpler.

Perhaps, but in the production code we already seek back and update
the header after writing a packfile with fixup_pack_header_footer(),
so which shoulnd't be too much work conceptually.  You earlier said
something about faster development cycles; not having to figure out
how to seek back and fix the header does help faster development of
this helper ;-).

>> One thing it lets
>> us do to have this as a separate number is to create an invalid pack
>> stream where the header gives a wrong number, and as a test tool,
>> that may trump the convenience of not having to give the number
>> explicitly.
> But also, this allows generating bad packfiles which is a bonus.
> A very good point. 

If this were an end-user facing program, we would most likely let it
count but let the count be overridden by the command line argument.

But until then, as I said, I am fine to just declare that it is just
a test helper ;-)

Thanks.
