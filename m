Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BE01D5CF2
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 15:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770649516; cv=none; b=RaB/T86lwxDpVYBnSDPJZrHIeSxPb3DryLHb1MMeNBiQNKrqZH9z+df1vMo4ylnER8ZgpwyOgrd/89O39eDj61xWxsgXhpjNmvgMZbJRR9vyo8y0hoA3Nq6hb9UB00jcpA3t+PGTlN9VABF+Nc7RYEaNF63awpFI1IBSl76MdX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770649516; c=relaxed/simple;
	bh=hIdzpVFKUIJFqF6cuE1JaZStCqM6OdTy25//0JlA85Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQu1fnryCHrxJcBA8CMNw49ydpyBYylIVks/dPfKcOvbPXqYxJxvWpdlMihJcy+Lfl6aVLssEt90FPCAzhrG1zSGA3HjnIIy51oiY9o/4adYVY3L/Hx4iKJ3JsyZzlsmU+mDpmmcobOfWWNaIJccWYVscdXcHyNH3tkM7k5r+V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LzO01ZHZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=atWY9EZy; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LzO01ZHZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="atWY9EZy"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1A7FC7A01A3;
	Mon,  9 Feb 2026 10:05:16 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 09 Feb 2026 10:05:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1770649515; x=1770735915; bh=pud3HoEAFF
	jZASlxwn2qy/ZaKOc1Ch4vahv7Gc5ZfM0=; b=LzO01ZHZvl60D0ZQdHgI7WlY4u
	6qNPvXFFRAcrtUpcdpYNDcjfZKMHLyeJ1lzDulSQ92+Qm6Zb+b/IG3ivA5ZPY/ZO
	i5S/4+7YcJRvWCEE53eUqIYQBpWwFqkU7soxfxYYD7BfRlBDotQ6x6Hz+rSGByMW
	Nm8upP+XCgtsy1HC9BlkukZqhHKA+EXeN4QgOw2nacSVc3vQ5LoLopDB3L5VnjCD
	S2bWa/YqX/d8QUVjF1xyFPzmG83enS1JBMcXDSYT5yd3YqFVUNw+Oq1mUVelZEGC
	1obO1gI4PXU1ZPP+RPIaC436pHc/ftNlp1d7CsipRUynH0yivvW5XIPtozsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770649515; x=1770735915; bh=pud3HoEAFFjZASlxwn2qy/ZaKOc1Ch4vahv
	7Gc5ZfM0=; b=atWY9EZyKK0owX57fliv3UMOwHWHAcxGuUX1wcP5c435OxVa3Bc
	DLnTHL9nXX5/RnKCY/KvOOIjaU3pYupS48hJ+aAfNx9ZxZQVmPOqokmed2qKv0/Z
	5XkauOPVxZFm4+Znwqe149jwvC1UA8QZtoV10CURYjP7NMrlzOHxoFvc6WBr4kAz
	vYUQa7Ii67uK7dEGavvba+gKkEYYFMpz4ZdMyf5cysietIzhqra/5wWVdYGGUt3q
	9aZXexLNBolQESC2DOFI1kklspW9LQ5wGy4xXjSSac2tPkSQjahbczplbHo/wuoH
	NJpjChYJH7v9i3evP5igTdsdM9Sdk8PC/Xw==
X-ME-Sender: <xms:q_eJaWXBNAADVFfY4Ki_UWWmtkq3Zp8rrmycLFBA8PDrd4SYgJBg9g>
    <xme:q_eJaaANJQ16t-NUqMHKNC6X_7SZKIjQ9eF_cuMoxna9KF7ZVdyzBfY1GTGHAnNN6
    U9oW6eI9iMGMu0no2-Gsw-iG1kUWZeCiyi-icVjwudANylXWF7eOCs>
X-ME-Received: <xmr:q_eJaXyVAmc3PdZrJa4bXSzZRwd7ls_QJTtisMaYk1Ew5TpVmWSImO0W4Ddq1Qamx7DjUnRXhpzzwPALFSF6BqqzXsiIwta0sJD0t2O_0lg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleejuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghmsehsrg
    hmsghoshhtohgtkhdrtggrpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgr
    ihhlrdgtohhm
X-ME-Proxy: <xmx:q_eJaXCRgW0X2P9h3e7MnXB0mgrskgKwcg82W-e9q6GxUsy06_1p0Q>
    <xmx:q_eJaUYId6ZhCvO2OzOl2E8622-sOk1sJrIv-yvgs2PvuApiIanlqQ>
    <xmx:q_eJafjqNjEjefWUZlReeagqiiljQG3hUH8Bjz9KiRIguTSZ34prBQ>
    <xmx:q_eJaW7l72VdujOnR_tieieO4uO_7gX_0UEBbYSUZl0XL9X9qE207w>
    <xmx:q_eJaeD_bwnwfQj8YDSX9MJOsLpDcV5BuLHoIl8Y9xo0d_hGlEfTniZK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Feb 2026 10:05:14 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c8074a52 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 9 Feb 2026 15:05:13 +0000 (UTC)
Date: Mon, 9 Feb 2026 16:05:10 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Sam Bostock via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Sam Bostock <sam@sambostock.ca>
Subject: Re: [PATCH v2 0/2] merge-ours: sparse-index integration
Message-ID: <aYn3pnjC7WUr6jfc@pks.im>
References: <pull.2189.git.git.1770345124.gitgitgadget@gmail.com>
 <pull.2189.v2.git.git.1770405383.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.2189.v2.git.git.1770405383.gitgitgadget@gmail.com>

On Fri, Feb 06, 2026 at 07:16:21PM +0000, Sam Bostock via GitGitGadget wrote:
> This short series teaches merge-ours to work with a sparse index as a small
> step toward broader sparse-index support.
> 
> Patch 1 is a preparatory cleanup that converts merge-ours away from
> the_repository global, using the repo parameter instead.
> 
> Patch 2 adds the actual sparse-index integration and tests.
> 
> Changes since v1:
> 
>  * Patch 1: note in commit message that RUN_SETUP guarantees repo is never
>    NULL (Patrick, Junio)
>  * Patch 2: rewrite commit message to follow the project's standard log
>    message structure (Junio)

I'm happy with this version of the patch series, thanks!

Patrick
