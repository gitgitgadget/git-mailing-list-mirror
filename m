Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF782459DC
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 13:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741786997; cv=none; b=XPRQKNDUn2G96hZhP8U2rPq3Mt/IztontZq0ybP3F53005Kxskkzx37q6skEMvCdkTdH9zv0I072Z1hJ6j4GSKk6le+PrAVpcYkLtgQvR3gwuQFl60sNNfkshIzHi9RcpOLROcQGrFGeEqliDg8bLU6QfE/INaEUtgse0DcT1q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741786997; c=relaxed/simple;
	bh=Ws3MociJZ8RxRtotJ2aCKh2BRT/PwBYodqAeqmB9KiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TggPaOe3/bgSUso2Gb4KqadTVlwPUKPrrPKJ1U8ZAd04D3Y93tq1SQLNdbyJFAK081jNdMbCy9vm1vCIceshRNGXJcPUejij/DjoegXQH4i/en4n1/Hk8MIe8XQEa+AKgF3EF81U46O5pUgUIrLhW0SwhUvDP5y3sdKocmqhDtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=acNHUbLv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IMVNIJfx; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="acNHUbLv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IMVNIJfx"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 8B36C11401F0;
	Wed, 12 Mar 2025 09:43:14 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 12 Mar 2025 09:43:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1741786994; x=1741873394; bh=lelNplem8x
	WiypZjA0UjSFDR5bfE0FOoJSmMX5WvRoI=; b=acNHUbLvHqgr8SHe3VJKa6jKGa
	Iz4Jw8uZIM+7IE5lgLYyHFtpRxYoXujdRzNMrrycxNIcpSlU/rfE/V7Oavx0zAon
	OMNcVx8MC0sovnONiBMXL3s2xuyxga/Sokfu8M1teFb5EM9RqNxcWsXjY5d3HHME
	DWh/k1Gvu1vJmzrGfZLvZZ0ZJ6FHeCRerEwicYf+WIawSz2FTgBMWZY2eXPXaoJw
	e2fIQiuWciDh4xy2ixWMVWmzs1yAU7eC4aJJa6UrbESCI+kVR+8MEGjXHHcMl/yO
	Mr3YvtQNP6koP2n8F8ddZI6n+D6azD17dl+BzTMo2KJr6ELks3O1WduHVplA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741786994; x=1741873394; bh=lelNplem8xWiypZjA0UjSFDR5bfE0FOoJSm
	MX5WvRoI=; b=IMVNIJfxkuXBisLCIfkhe0Fdi9prhX86ZqeIJJL7XzDpLQsc7Ye
	PZCqFuxYJT+i++dFhk7B5KbxsdSxKPCsCTkiXy2iqmTXJT8UU8ky4LvW6QIbfOeX
	g2XeGaW+xqk9DHaB2aGHpk8oUk2X+L0UVY5kvjNnyQ2ymtjLXju1qRBsGBEr2P/F
	UC16H3mHmwreYQ8hUFENVzNMO8h5AzgiaZp6LZAY49XL9IP1S5P1kM7gA7eiMLhE
	CURAyCOvoLM8Ic7g29EX5P/26PfiCWJTliPRmHyNEumDzYDl9EgsMcrx8MvvFsLY
	CJpiatxWwmZ0epMFC8TW35VYQ5h/6syux2Q==
X-ME-Sender: <xms:cY_RZ5zigi8BhCm3Nlx7GMxnwmn1vu1d8XsKLY4S3CLZ0mGaEnam4g>
    <xme:cY_RZ5TAGEoaXR0-g6CFJ0I5c8CjE4q6kFgYLc3MzNnedc0jMMzTqOZc-xfqd8jiB
    FSnVOrOrJJsqQh6lQ>
X-ME-Received: <xmr:cY_RZzVPX6EV3iK1G9dWKBF0eZmDRvaUDBkqF55l-9s7Bd--5eib7k4_3xzOdHSNGeoQYYbafYIZ2Xi2zdF9QbJQN3zXpz2QY-HAHt5bI-hQoGg7Xg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdehvdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekff
    fhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdho
    rhhgrdhukh
X-ME-Proxy: <xmx:co_RZ7jDfZbP3VZ3h93nXQkRN742zS_UHCK8sMUU5VRWXoQSQfUScw>
    <xmx:co_RZ7BpR0tvlIyVJaChvwkPjOg6Uxekct8rXPIiNGojR8wc4buIDQ>
    <xmx:co_RZ0K8gsWxlkmBQmXmtB9BE4D7JrvPPdMEtAjVKfshAUrkgDQCEg>
    <xmx:co_RZ6AFQ8lkQtV0XqT_z9ASnIdBoiu1uBhj-9uhP3tAIqbg_2sRiQ>
    <xmx:co_RZyOo-cF4Qyfj11C2aS5LxMJcmd8MarBPxfmkeEXsMlYdEIsfxbOt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Mar 2025 09:43:13 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3899f5b1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Mar 2025 13:43:11 +0000 (UTC)
Date: Wed, 12 Mar 2025 14:43:10 +0100
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] docs: fix check-docs with WITH_BREAKING_CHANGES
Message-ID: <Z9GPbggliX7asG2a@pks.im>
References: <pull.1871.git.1741018310447.gitgitgadget@gmail.com>
 <pull.1871.v2.git.1741171357627.gitgitgadget@gmail.com>
 <xmqqzfhzlbie.fsf_-_@gitster.g>
 <082af6a3-a7ba-440d-af84-6c59827a2929@gmail.com>
 <56cf842a-7c1f-4354-b191-35bcc1e139bd@gmail.com>
 <b5fb3292-216a-4456-b456-e9ed38affc22@gmail.com>
 <Z86Jze2qZ5s5OyOB@pks.im>
 <Z9BLZWUarN0kC4CQ@pks.im>
 <75a8b321-4cf0-4d75-93a7-b616ae818d81@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75a8b321-4cf0-4d75-93a7-b616ae818d81@gmail.com>

On Wed, Mar 12, 2025 at 10:39:49AM +0000, phillip.wood123@gmail.com wrote:
> Hi Patrick
> 
> On 11/03/2025 14:40, Patrick Steinhardt wrote:
> > On Mon, Mar 10, 2025 at 07:42:25AM +0100, Patrick Steinhardt wrote:
> > 
> > To set expectations: do you have the time/intent to work on this and
> > polish it up into a patch? Otherwise I'm happy to pick it up.
> 
> If you're happy to pick this up that would be great. I'm unlikely to have
> time for git related things for the next week or so and you're also much
> more familiar with meson than me.

Okay, I've sent the patch series in [1]. Thanks!

[1]: <20250312-b4-pks-meson-breaking-changes-v1-0-b89e9a59d228@pks.im>

Patrick
