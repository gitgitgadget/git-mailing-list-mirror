Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3731C4A1B
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 05:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730786103; cv=none; b=it709pvYTalfreF9EeXGmNeO4ahulwXAgQ4gOPyzj7qvVHFhvpMJHDVfev1u42ZABXPQEaZdDkfixojyVS0zMZFSlRbh1bVT8lC/5vYGMtjz3w0BXKlOs0s72g/a2odwMpZC1gTlDgEO528C3dKZqz972fZdhpGRA7ib/bJIW3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730786103; c=relaxed/simple;
	bh=d5aCrweTs0kkjiO8/LzDM1lBOZQtiPYu9jLfe5Qh0dA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KRDuYSuBs1vUT8HPEBTgQMvV5/R1jKDN2P0gYL5lvE2DqWOXxylg+RDqtNXFhMCZCbwzN19KSsdJb430YmH0MBkBBY8Od/459PxlNErwB9J6TCYmYqID3FvC7+AmFA2XC4qUbBBNf9PBemrYZzcWFRC4/wlGVecT8dKitiyrYP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YGBZmwlh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B1e+HX1R; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YGBZmwlh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B1e+HX1R"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id D0DE61380540;
	Tue,  5 Nov 2024 00:55:00 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 05 Nov 2024 00:55:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730786100; x=1730872500; bh=SxsVuhLztF
	D+2diNzM7UOkepO4Z0yTFFk/bqRnbRdEs=; b=YGBZmwlhvANM7RLFv46Qr/CqR4
	5mioCrNWpox6vH3D2MDrOLjkifE/IwkMHDwV4vxkATY/WuBhr+4HPgGuv+J2pKVn
	h5wZH18iwAgSwkFYsUzvZrvgobU7KKtw34t1sv5yr9jreYn8fJLL9hxchGkgeSV8
	XKgAblBNNy5H9MSsPp0TaoWBXrB3XJjhcM/sVK40p1wJTpdq8H4jhBcpTaFQ2QX5
	/lbQTRRFsGs5zx7vsC7hlfzJNVjSKKFPcO5s91NXThBUTHQ+OLgRt1ugeGq71kiO
	M1/SUWp1t/hWtMv3laNEd3Y1S7NRK53sRLiES49nJChdtTnta6VSz0xff1GQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730786100; x=1730872500; bh=SxsVuhLztFD+2diNzM7UOkepO4Z0yTFFk/b
	qRnbRdEs=; b=B1e+HX1ROgpk/HsWoVdTzO8m/HGPAza+TP5KC4NenOEFh/G9H3+
	en1Bur6c+jgkvk6BB1xKQahvAHPzA2HUsd1MgLhSA19r6lK6f7kfg4g4d9/IX23V
	X+xQ4MebmDjmteLwJcRCqwZrdO4yuR7pkrBGqb1x5PntUhPK3ojRpM0+hC+ET6vQ
	YuMaYbyIlomQebJfw28wopgyK5xARrwv0r5iuYHfeeSdZKYMQ86CZEaOj4FyR6Mo
	Dcfz7d5QBjRXE/daHXbcueg0kCespouOGNjC3Dl1bpDKU3isNQJPG5BWajrEe4Ex
	wlF9TOp9ngMA194A4zR0MbTKAYnRLQ84FIw==
X-ME-Sender: <xms:NLMpZ9kFOzdEPvhRF-HZILT6qGV5asgEceKAcfssZjmV2J91rU5hnQ>
    <xme:NLMpZ42PZGVjU2b-6MFiYnHXm5-8XtoP26o0kPCeBP1puBuvC0S1KpbjsDhkM760M
    wYN2LuGdEtVTWHi0Q>
X-ME-Received: <xmr:NLMpZzolJhh4UxxaJAGJp181xPiC3U8aLxu0t23yBd8lGg7iVXhOXS07rd60LjxdctkuWEZRYVkgdTOnzlMp-7KjKzK2pEb_cGkiFXGVhlo_eA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeljedgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:NLMpZ9lhC3D7keL9IU4hJYrospGZU2mfJZUiSH-B61_4r_oglZ4QVA>
    <xmx:NLMpZ71jEY2yfmpHsLPjWMGF0gHkFiWsdAxjDMOiwkfioFg8mneR-g>
    <xmx:NLMpZ8vhJQl4LO0F08P_jh1hE8DPrHYJwVlTZkr7VHliW_BtVL0Tnw>
    <xmx:NLMpZ_UWv5HEtwiSEbQ4D25OUoH1wtF7t3x8kStrjBJ31Ib9XXG7XQ>
    <xmx:NLMpZ2SvPkrjGTGEbCqTdszuwU9oQt7O78lOg3k9gx8hjPSnqTya_RYn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 00:54:59 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 468ece52 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 5 Nov 2024 05:54:38 +0000 (UTC)
Date: Tue, 5 Nov 2024 06:54:52 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v2 11/22] trailer: fix leaking strbufs when formatting
 trailers
Message-ID: <ZymzLJ4p7AK_V92K@pks.im>
References: <cover.1728624670.git.ps@pks.im>
 <cover.1729502823.git.ps@pks.im>
 <5b851453bcea945f95c3f29138e510d8448e96e6.1729502824.git.ps@pks.im>
 <ye7hagpn5xmtlndgk5usx7i4xrg2s32eyukcy6fapxitye24ws@ddrg5zrnxkn3>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ye7hagpn5xmtlndgk5usx7i4xrg2s32eyukcy6fapxitye24ws@ddrg5zrnxkn3>

On Mon, Nov 04, 2024 at 04:31:34PM -0600, Justin Tobler wrote:
> On 24/10/21 11:28AM, Patrick Steinhardt wrote:
> > We are populating, but never releasing two string buffers in
> > `format_trailers()`, causing a memory leak. Plug this leak by lifting
> > those buffers outside of the loop and releasing them on function return.
> > This fixes the memory leaks, but also optimizes the loop as we don't
> > have to reallocate the buffers on every single iteration.
> 
> I see that we were previously calling `strbuf_release()` inside of the
> loop. In practice were these never hit? Or just sometimes skipped my the
> "continue" in the loop? The commit message makes it sound like the
> former.

True, "never" is definitely too strong of a wording here. Will adapt,
thanks!

Patrick
