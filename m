Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC522D73BD
	for <git@vger.kernel.org>; Mon, 10 Nov 2025 17:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762795927; cv=none; b=Fc4pxX4/JbbJYVryf3ku9qKJuNCcZ4bVOo96Dd7ya9GPprId2xV1WWaAHhoZKc+StUyKOmzD9Mk85fzPcGtGZLVlb1aUUCkJNjChB76qm+nzINWInzCB0sUsi/urZ58pdJCTEnQ0BLPP2d6ObAQEVm8Sni+zZ3ToGTIRoCn7ceU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762795927; c=relaxed/simple;
	bh=OfNTckHoIrI1L7aT5IUn0HtYFb0NKUpvTcK+MOiQLw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hIYAwkMPoj1exYIiTQorMQnXeyTqmctrBDI9BSZSE8I0zSTz1LvPhyLa05wGz7Uvp4LusgjDgvgVTb7ci72oq83Ang1EaYHnQJqqFPqttaXGxgI+3asvuoKCkgmjwFKlMfydcUTe/PNhrFT+eT8BpvufWVXmRfShiuaEiH/gdWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schrab.com; spf=pass smtp.mailfrom=schrab.com; dkim=pass (2048-bit key) header.d=schrab.com header.i=@schrab.com header.b=DSbWjxf2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oPZG9EZo; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schrab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schrab.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=schrab.com header.i=@schrab.com header.b="DSbWjxf2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oPZG9EZo"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 28CAEEC1F27;
	Mon, 10 Nov 2025 12:31:57 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 10 Nov 2025 12:31:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=schrab.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1762795917; x=1762882317; bh=3fM2OIS2Mx
	+rsMPbRtDeh/sQDntqtN8jMOJoPQC1krE=; b=DSbWjxf2c1wIZDkA6HTX2rNads
	azaRai2/OrPz04mwRbijtbZhJHhmhSDN8JXZO3pd5Vvop8wRB2EXm1oQd3Guq2Oh
	E7UMOjVe0f6DGtUW76RhbG5UFi18aMrlcostyES/ROijEJGwCaucrmZm4HSFg4R8
	PKRi+HU52ia1T/2XsC7DiWIvj3Oxl9FElpv2Whsw4o5U63CqT5EFGPT7JTJcy7VO
	F1EF3eMcGfmsPoWLBz7aWAduo9C24qADAvZPn89masmBf/+gi/6rsBYBb8SNvp7W
	Jqea2p72EZN8I+NcAFmM2eoTUNNPXb7mhqQgqZLAvyubMJXmhDIPRDon3jaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762795917; x=1762882317; bh=3fM2OIS2Mx+rsMPbRtDeh/sQDntqtN8jMOJ
	oPQC1krE=; b=oPZG9EZoNKtEPV1Ews+jUIGZSwDQs8I1pVDwW6e4ymYVlYabR4U
	lLbxmejNI35Md15AU3vON/bfe1E9rp2wb7xhos8k2qGHvZFdSyuUNMZ/WL1Dtr4w
	10qoF1th44p6wfkNyVb+9kRcfwTpcsiSGkJidmyzNrbaX05c0fYK1EyjaJ7J4ycq
	7OFPdr69iPxD6pz304X1QVZDu2oXIk5fvxmeNOUfxCzWVLCbnp2T1ml5l29MrvSr
	1pUAKGZgdioFv5NFB9YYLRHWDBJvVMd0D9oQRCinEweJpWPAgv3/lt/wF2cSDKt+
	mAVPtjzBH1TD6omzWTAEycW48HqUj8ETy/w==
X-ME-Sender: <xms:jCESacIU354OMhXjYJ1dRZiJPPJZzmLyPshhdGDYiHa6SVxn8z9UUA>
    <xme:jCESaUUz7DK9jTsVvYVGKnlgX0L8v7w3k6T4vgfUjf6XpMjDluJnCNew5qrhuxSCF
    W3CEVDXevqX28c32tOn-Afh4l3cM4inVr10YNz-VqBsMUoAs1x-Kw>
X-ME-Received: <xmr:jCESaYSUuIc0EHpUPuu6xEpggRmP5x2XOKnUMSoo0LyJCErb7UvFXv2hM25MmSLJeQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleekledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheptegrrhhonhcu
    ufgthhhrrggsuceorggrrhhonhesshgthhhrrggsrdgtohhmqeenucggtffrrghtthgvrh
    hnpefhtdefvdeivdfhieehueeuteelveekhedvuedvhfffgefhieevgeekudevgeetueen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrghroh
    hnsehstghhrhgrsgdrtghomhdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopegrughrihgrnhdrrhgrthhiuhestgholhhlrggsohhrrgdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepvghmihhlhihshhgrfhhfvghrsehgohhoghhlvgdrtghomhdprhgtphhtthhopehrug
    grmhgriihiohesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdr
    nhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoh
    epjhhrnhhivgguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhi
    mhdprhgtphhtthhopehsthgvrggumhhonhesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:jCESaUBaLmNyTE-iSZATajKChkTHqKbDE0-bfg2NHmie3qxPaH1dJA>
    <xmx:jCESafIwIIo1yEWPSfjsIpUDDoWOw-_TShvgC0BrYKgRAKxdgzB6kQ>
    <xmx:jCESafAVq60CBJAtrAJy9NQ1_E-i_xhSOI4Xlc0HU-hU2J49j-eiXg>
    <xmx:jCESaUsSmdAiP0wvT1j8rQsJHoWg8LREXE6ZKHbvc_BryMHuy619tw>
    <xmx:jSESaYYWRc-958ZDPRejeRANu7xr2eoCcTaLV2o57FhksSSzvliMYq8i>
Feedback-ID: i1fd14616:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Nov 2025 12:31:56 -0500 (EST)
Date: Mon, 10 Nov 2025 12:31:54 -0500
From: Aaron Schrab <aaron@schrab.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v4 4/4] submodule: fix case-folding gitdir filesystem
 colisions
Message-ID: <20251110T173154Z.Hhi6cUjqDOat@fnord.qqx.org>
Mail-Followup-To: Adrian Ratiu <adrian.ratiu@collabora.com>,
	git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251107150547.3272180-1-adrian.ratiu@collabora.com>
 <20251107150547.3272180-5-adrian.ratiu@collabora.com>
 <20251108T182050Z.vbNv4y2kizC1@fnord.qqx.org>
 <87ecq5ke2m.fsf@gentoo.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87ecq5ke2m.fsf@gentoo.mail-host-address-is-not-set>

At 19:11 +0200 10 Nov 2025, Adrian Ratiu <adrian.ratiu@collabora.com> wrote:
>On Sat, 08 Nov 2025, Aaron Schrab <aaron@schrab.com> wrote:
>>What happens if `Foo` is added first and doesn't conflict with 
>>anything,  then later a new submodule is added which would naturally 
>>get the name  `foo` which would conflict and doesn't have any upper 
>>case characters to  encode to avoid the conflict?

>Right now, in v4, in this case the user adding the second `foo` module 
>will have to manually set the submodule.foo.gitdir config to avoid the 
>conflict, because Foo already uses the coliding path.

I think that description minimizes the impact. I'd think that anyone 
with a prior clone (on a case-folding file system) would need to take 
that action after pulling the change that added the new submodule.

If action were needed only when running `git submodule add`, I think 
that would be fine. But requiring that action in all clones seems a bit 
much. Some of those clones may even be managed with automation making it 
even more of a problem to add that new configuration.

The action may even be required in new clones, unless the submodule 
setup process for new clones sorts entries so that ones with capital 
letters come later. Since some common collation rules (thinking mainly 
of the `C` locale) will put capital letters first I think that's 
unlikely to be the case.

>Maybe we could derive a new path automatically (eg foo2 or foo_, 
>suggestions welcome) and use it if valid. This way, there is no user 
>intervention.
>
>Do you have any preference?

I certainly don't have a *strong* preference. But, I think `foo2` seems 
a bit clearer. Although the implied strategy there for multiple 
conflicting names may be too complex for a situation that will likely be 
exceedingly rare.
