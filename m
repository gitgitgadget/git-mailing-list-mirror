Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FD41DFED
	for <git@vger.kernel.org>; Wed, 28 Aug 2024 14:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724853790; cv=none; b=FS+2KQuw0TUWPYdbWguTDrgj4gvmt4ePKzKmugbOgL3GUGuHTepzDZEDd5EyLcUWGGYjzN7L2SoAI6Mw4J7yniZFYxtVuwsOUMd+VBUJ6ZmLJ9j5U1zg7URehkmLwmCc/57Gz0oChM5jOua+1KTDpjaFwQfye9e+bWs8b3MZcJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724853790; c=relaxed/simple;
	bh=qq+N4rZxU93n7UXtNEFU1IfKIlkH4QvvzLP2aH+BtCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovKColFMl4r1yIrL7BR8dCp4W2BBomR61ReVzlERcLW6EBbYZc1NI9Hzw59RO+ZkWGVBsaFvHPM8wT9kYDO5F6Yim4sEoln7sAVi3blc2hD91vv5EwzXx5hLtUlCX95KArUm6Q2iSwf3odmgt/XlgB9fHux/s7BuIX3SEJYmMzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iJSkAc45; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uOrLzMee; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iJSkAc45";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uOrLzMee"
Received: from phl-compute-02.internal (phl-compute-02.nyi.internal [10.202.2.42])
	by mailfout.nyi.internal (Postfix) with ESMTP id E4751138FF37;
	Wed, 28 Aug 2024 10:03:07 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 28 Aug 2024 10:03:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724853787; x=1724940187; bh=OkcreJjDp8
	ZSXYii3ygmu98oic+GnwwjDWGRlnAe9dI=; b=iJSkAc45DejaksCJWBYV5aKjHo
	UpL1Bok9my5CImVHjrGxO57fY5E0iiuUUweV8hcC/wbuDWCwlZPxMrgaXmQ6ePSa
	QCTO8YIPOoZ3RE1WgqmS5UCl6vq+sAHsTyupAuHT35Sib7rCJwAGNxT1L40wljhr
	118zN37voaZlL/kQ1n/HUiInWKaZraI0ThfuaT78oqEA7zxmn3QDKmA9w3x7/fVy
	/IQtpqb+t36g7bCK9OW6ijk6E3QvjILFlXQjNcoXDX2fKloMxTuuzQtshvm/R3mI
	oYl2cxjNg7HzlJpt0OzKSRY3y22H9XVAvtXZcyj0WlR8gWJGAdmS80/d54tA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724853787; x=1724940187; bh=OkcreJjDp8ZSXYii3ygmu98oic+G
	nwwjDWGRlnAe9dI=; b=uOrLzMeet+Xiy5vYayvV+LZAOHte+Y55lHpt4iYaQG0b
	EVPvkkQnTd6diSpHGgOOckXafwQgDJdKUkW4DWv2bEc9puMS3LD0qWGPq/WiwuCN
	JKqYhhGamUZtvbBqem6rXp9hT3C9iOJDcPap5UddrHgxcgktq2i0DUV/YdavCAsL
	ieGMm3TbOCXBsusY7KEGP9yF0aHe766S/jTZbCoD66tFtpySXuXMCI3alcJ8zczt
	yiWUZEDE+Aa0Mnqb8+IJqnlQmdym5HTG9Z8uXlNkQ+sVOJ2i8fu32u4CVO6teNis
	4qvtA3G91iUhjsubf7v/NmSFvbPk0e2RNcaJTbvO2g==
X-ME-Sender: <xms:Gy7PZic7tW62MKTENe50DIFtmRjsEO4MONGIgZj0SLVcRNfidVjHGA>
    <xme:Gy7PZsNVOZjRE-1vXKL1wEKPoF7qqx45CLjczbJhl2861RX94P8_YaOSUWOMqtt69
    -t9Dfz3QVdUX9UAgg>
X-ME-Received: <xmr:Gy7PZjgOm3RuDdOzxVs8BpuqWtq1g-EQNko7Gm0gxWB_IWv6R6A4iz_y12O0aLFUQyRzyZWm1QtAZqcfEIfPw2EUB1l69OK-5xIums8z7VdGd5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefvddgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesgh
    hmgidruggvpdhrtghpthhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprhgt
    phhtthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomhdprhgtph
    htthhopehrshgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtghomhdprhgtphhtthhopehs
    phgvtghtrhgrlhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepphhhihhllhhiph
    drfihoohguseguuhhnvghlmhdrohhrghdruhhk
X-ME-Proxy: <xmx:Gy7PZv_JTuVeBz9aNI0jCXLRmnzY2OoNaNnPgFTzNuksbvtBrpKghg>
    <xmx:Gy7PZuvfXgEyMZVm48hv0Cliw4BJNDCB7LzVS7CroFfXF29JusR4Aw>
    <xmx:Gy7PZmEVHYos1NYcY7T07Xwh5JOeLN7BLbw4yCML2A1dHkFc_DVqQQ>
    <xmx:Gy7PZtPRoDXa7xbEOEWwrG8IPdJes8H_SUhMoFsdxErQXtjUIKtLOg>
    <xmx:Gy7PZoJoNhsTsklfp78P3yq2RhXp2beMZeLHDITHehTYQrZKNnsJAtyf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Aug 2024 10:03:05 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b2ace139 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 28 Aug 2024 14:02:57 +0000 (UTC)
Date: Wed, 28 Aug 2024 16:03:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v6 00/13] Introduce clar testing framework
Message-ID: <Zs8uDnUAFFKF4DTF@tanuki>
References: <cover.1722415748.git.ps@pks.im>
 <cover.1724159966.git.ps@pks.im>
 <e9c015a6-7fc2-4783-9ef6-05359adf46cc@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9c015a6-7fc2-4783-9ef6-05359adf46cc@gmail.com>

On Wed, Aug 28, 2024 at 02:18:49PM +0100, Phillip Wood wrote:
> On 20/08/2024 15:02, Patrick Steinhardt wrote:
> > Hi,
> > 
> > this is another version of my patch series that introduces the clar
> > testing framework for our C unit tests.
> 
> I've left some comments on the code, most of them are points I made in the
> last round that received no response. My main concern is that the assertions
> offered by clar are not as convinent as the check_* macros.

Did you have a look at my reply at <ZsSTOczuGhT5zwoV@tanuki>, where I
responded to these concerns?

In summary: I'm aware that this is still a rough edge. I'd be happy to
follow up on this and improve usability of the assertions, but doing it
likely is a bit more involved, mostly because I want to upstream all
changes in this context. So I'd rather want to land a basic version
first, and then I'd iterate and improve asserts.

> What's the plan for converting our current tests if this gets merged? If we
> were to add wrappers that provide check_int() etc. that would greatly
> simplify the conversion. I think it would offer a more ergonomic api for
> writing new tests than the verbose and non-typesafe cl_assert_equal_i() and
> friends.

My plan would first be to let things cook for a bit while I sort out the
rough spots upstream. Once done and once we are sufficiently sure that
this is the direction to go I'm happy to do the conversion myself.

Whether we want to have wrappers... I dunno, I don't think the names are
all that bad. They have a clear namespace and say rather directly what
they are doing, which I value more than briefness (to a certain extent,
of course). The type safety is another topic though, and something I
will aim to address.

Thanks!

Patrick
