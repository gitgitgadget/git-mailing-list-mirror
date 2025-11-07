Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BA12FCC01
	for <git@vger.kernel.org>; Fri,  7 Nov 2025 23:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762556885; cv=none; b=Zu0QuNwu86GhMLOA74pATD5ctBK5TGY/AiOuYPZ8p5Kb57FlywrsL7TJq8zU5ZCeGBLXjsJzUQd5o0311nnR53RIz1GX4UG2P2uxe/rn5GjL0BgquamxDt+qfHGRNnWMUozNWe+MYaMu9VpZngiG2E1psy+2ofVxepI22l19+JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762556885; c=relaxed/simple;
	bh=8uVfGfY82KgleNx+5vSQxQRAszgibl9c/iws9UhAff4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AsIo+S/uvmF+70AQ/95FZHcYszmedQJwT1UFRvQmfJ2iy/Xo4Zi1kX6Zn9s6f+6MOQFpSdWuTlZ6d3lvj6sK1GMEbBvWfhpGIFiPNJDC31k5fcOgo+fLPHHhdX3e+JGu1B/jtFxLA/YUiYAVOIADy3m6sn9mWP4B0zAJzaLE5MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SkJthMJk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dixHgchi; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SkJthMJk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dixHgchi"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 09408EC0475;
	Fri,  7 Nov 2025 18:08:02 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 07 Nov 2025 18:08:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762556882; x=1762643282; bh=FditQV54yz
	vbrPzsARzcUxHQ16MGZNPnJ7YF6vb3d+g=; b=SkJthMJkEbdf4Evci/ztHVD8eI
	LPd4jsWyUO132XbmuDiiLt4msDi6bs1rEVRCgmn5z6qn4s07pIJ3smlUraJtI9sJ
	TbAcs06XoQjmbtRtekoeTF5jrZ3UyW0jbFlXeuTiFwwpW056XuNmqHG0PYY6Kvh5
	i54NO4rq/h65DNhOi5DWN+YKMYk7nCe8BlY06+nhO1+qVe40ghcsrNrMg/pbHj+K
	OJGc8yDQdObjoHbCX70kttv0swLsMrlW2nZYRa1UwTNNZPfK10FWP1VRSBgSTFlZ
	Plogu9TVIhkinc1hb5KdcRDfSurPzE+pm7DCXFFaIWVE622w/imEO2BQf4Fg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762556882; x=1762643282; bh=FditQV54yzvbrPzsARzcUxHQ16MGZNPnJ7Y
	F6vb3d+g=; b=dixHgchifToS9ybDdl+LpmAgnTbwApPIR70l8Zke4yxZ9zZz2Z/
	GuKJWcuqo6yFOXt9USDGXidmwYeIY3NmQ11vIwzdVNSf9N+0sBOANsIPQiKa5gjN
	0j6/UdCqZd2A1xYByGNFyxZOTccJr4mpaRayODfCNzXbQfivv2nF9yZ7P54w+KgT
	ZNodxhr1rXiruSKM6sUUQrtsHQpQkpjmx9l3udvzb8pSLtGIe7uQaKPODCENV9nH
	oG3HgkEDOerjWJ0QXEFoB/C1flPbVu5XhnlcCNisoqvsJxcoCsRskVsoQQl4Nz1W
	60RmAkLrSVbL3gjrxDR1JWNSVRdgRpmh3fg==
X-ME-Sender: <xms:0XsOaT6CCX12SDxSj8EoKiCsAULZSg_Ipjmfpv71WBo86LjnpHG6mw>
    <xme:0XsOabIsBpyf1a-r9-KEmqPGGpagpERgJ_v6TTF9LdUCH5h61ZolgIdkkhBlUEMer
    ZhcEsfhFgXo8dDh2xCR8EOScUJN9qPRg2_XkgIHkiUaVp9T8TfiRUI>
X-ME-Received: <xmr:0XsOacvPJHZUStevL1XKYbIxf3_hs_NqopxWYBhkPtIy_a_R5Fc88kUcjxTtG697D3Sk-rkdV5iNBYsPa66r4hdm6mzYqgq8L-Ub>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduledtleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjuh
    hlihgrsehjvhhnshdrtggrpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdr
    tghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtph
    htthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:0XsOaaJJMIiRsNUuyPvC87_yET4gMNLCGxxBWZV6DQOZFKa6wq10Dw>
    <xmx:0XsOaV-6wwMDuXcdTn8C4Dv8JPdOehO_3ZRkqNNAEA_cvNfnjlqGGQ>
    <xmx:0XsOaTwUqfd_BBPGNw0kYmHRW639e4LK_RS5-AQq5PuDzb-Jv86jbw>
    <xmx:0XsOaS7hVX4Y4l_b_XXkA3lJu7zzqR2Bq11E0lQsyHnSHnPcCgJZDw>
    <xmx:0nsOaX_rxCiIFrT1ghgc3YfkABtd74NvpltdqHtE4Tg7CEKu6aYUc3Ak>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Nov 2025 18:08:01 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "Julia Evans" <gitgitgadget@gmail.com>,  git@vger.kernel.org,
  "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  "Patrick Steinhardt" <ps@pks.im>
Subject: Re: [PATCH v6] doc: add an explanation of Git's data model
In-Reply-To: <07cca81a-10fd-49aa-b175-17b49e4f1116@app.fastmail.com> (Julia
	Evans's message of "Fri, 07 Nov 2025 16:40:08 -0500")
References: <pull.1981.v5.git.1761856336360.gitgitgadget@gmail.com>
	<pull.1981.v6.git.1762545177204.gitgitgadget@gmail.com>
	<xmqqseepedue.fsf@gitster.g>
	<07cca81a-10fd-49aa-b175-17b49e4f1116@app.fastmail.com>
Date: Fri, 07 Nov 2025 15:07:59 -0800
Message-ID: <xmqqo6pde90w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans" <julia@jvns.ca> writes:

> I wonder if it would help to de-emphasize the octal representation
> of the file modes, and instead give them names since (from a
> data model section Git's file modes are really more like an enum with
> 5 values than )
>
> Something like this:
>
> 	Git has 5 file modes:
>
> 	  - *regular file* (with <<object,object type>> `blob`)
> 	  - *executable file* (with type `blob`)
> 	  - *symbolic link* (with type `blob`)
> 	  - *directory* (with type `tree`)
> 	  - *gitlink*, for use with submodules (with type `commit`)
>
> 	NOTE: Git normally displays file modes in the same format as Unix file modes
> 	(100644, 100755, 120000, 040000, and 160000 respectively), but file modes are
> 	only spiritually related to Unix file modes.

Then, I would suggest further deemphasize the "file modes" even
more.  

    * Git stores/tracks 5 different file types, which are
      non-executable files, executable files, symbolic links,
      directories, and gitlinks.

    * Git uses one bitpattern each to mark these 5 different kinds
      of things in tree objects.  These bitpatterns were loosely
      modelled after UNIX file mode bits.

The first half entirely avoids saying "mode" and that is very
deliberate.

> ... I do not understand in what way this rephrasing helps the
> reader, or how you think the current phrasing might cause confusion for the
> reader.

A branch (or any ref) does *not* *REFERENCE* an ID.  They refer to
objects by *recording* an ID.  The distinction is not clear with
your wording.

>> Another thing we discussed and a better alternative offered during
>> the last round was "base directory", to which Patrick mentioned 
>> "we rather consistently use 'root tree'"
>>
>>  cf. https://lore.kernel.org/git/aQhcbHJjiI5GtV6Y@pks.im/
>
> I think it would be better to stick with "directory" here, because I've gotten
> several reader comments saying that they do not understand the
> term "tree" when it is used as a synonym for "directory".
>
> Maybe "root directory"?

I am OK with "root" but that is conditional; only if it is not used
together with the word "directory".  We are not talking about "root
directory" where common directories like /usr, /etc, /dev and /tmp
hang immediately below.  If we use the word "directory", I'd
strongly prefer to see it with adjective like "top-level" that
implies that it is something different from "root directory" but is
relative to the project in question.

Thanks.
