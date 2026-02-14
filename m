Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BB713AA2F
	for <git@vger.kernel.org>; Sat, 14 Feb 2026 15:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771083778; cv=none; b=WOxYWOyKvdwB1BaFOMbSgvHqQ04RqtyG55H7OrhrHx7hUSTjcxH68EtRSjaM6ejLeHq3id+g7B3z8LEQYp6H97GL/rzhXy0CNXYJ5NwyZfKbYJ/JLAHkeNGf14aS2XrUdeD6sDHm+UTubGdcVVZvzkdoHa2G/hOE7xDGELeiK3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771083778; c=relaxed/simple;
	bh=oDTE+lJiwRlEs8e4pmtzY7guf/qTqK9211o6u1nKq/I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ODLsRu4L2mh14IsrkfyFpvKFtGqHHcLvwYyyrNWBV1YI84kzBuna8yM/Z4oZ8rZwuDU1M2I+Zc/ZPig0ih5/e7TV/PTK5byrl/BxnXLKtvRwOwPVMUnRAS+FbZf/fxuGYNY/IHD7LSQgHzNmxW4sYw56L+1JH9/ig1SKzWm+hpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vkxtHGN+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=llGqB2ML; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vkxtHGN+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="llGqB2ML"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2F8047A02E2;
	Sat, 14 Feb 2026 10:42:56 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Sat, 14 Feb 2026 10:42:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771083776; x=1771170176; bh=gefBwMjIs0
	/PxztIXhauZe2ni2vf85Ihv8HNs1hqbP0=; b=vkxtHGN+rxF70yNWuOHiB7JeOX
	tkfN5gYhBLFpor5meEgUyDwMwsLpZWfUr63dTsR+IEz1rDvsRHxWPOsbblWfjP+a
	A7VopCyXqpCBf2jMhC2uLvnopYwj74HOkg8j9Y33MUXkHemdSffGEmwds3WlYuDF
	Je0Uu7vTx5cL7KMAJSbKJALTKYKuvcyLbSBKe/p7mnGrqy2cNix3ZiDCaGYtvHsu
	IGPNJKUsdLWEb8FbnboYygo+8CVFxqXtkTrdUvq1meqZJMGVcZzz67UkzFeoR0al
	1nV8Hh6Rq/jDos4MY7+cfTrbCWZFLN2ObD8wprgyBP52B8S9qxqTVwU5Gzjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771083776; x=1771170176; bh=gefBwMjIs0/PxztIXhauZe2ni2vf85Ihv8H
	Ns1hqbP0=; b=llGqB2MLSD/cD7LgB5MJBiG8uNoOcdT7jDHp3+bPYNPSBvyeQAH
	VNE3S/oZ9WgRIYowrpTDhSbmlptPE7wKvnPQswb6EY7f5UJJs1X66/h5ox1nxJ7k
	H7zFXf+ZKi59sPjQiaaamDaUGUOhM0bOf9jPXaYh76SR66T2dXldsUdWLeAfqbSB
	conv79fXBTFx19sQ+SYWveNvJRkjAV8kq6NXa4BS1Rlg+BWGa+78zo8Pz2PjNTyr
	MFzlqQwNWrK54EKTxtw51oREhX0SaKZea080iEw6gOz+sgXAOX30ZLi94CBTEbmO
	uszBpX99rg2svYh02gA9GiYDU1McSDrEw1Q==
X-ME-Sender: <xms:_5eQaXtyEXl30vPrm58P5xQAO3a9hA1KGYZ5JdUIHZinxiAYjqAYKg>
    <xme:_5eQaatEemvUI27ftL3gcYKxsbNEz-JBGcbFT4xjwYB33rxFs5DLeYCSG9zVxFOVu
    GGBuKLOKv8cvQkLbq_hycFyz5rRYYygj32YFXArBwJsdGxoZhp0iQ>
X-ME-Received: <xmr:_5eQadC6qB_KbDSrAFP50cPLAsZA_UdmKiPs9Qgno7-jOhPtQkvFOOPoUSyoFi-udo1K9sUAnMbe7B0mF-x0_FujFWJ6NwGwkg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudduhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehmrghilhessggvhigvrh
    hmrghtthhhihgrshdruggvpdhrtghpthhtohepjhgrtghosgdrkhgvlhhlvghrsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepphihohhkrghgrghnsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:_5eQacPYHTnKI8-29D78HAEhXxz7Gmy2HXvarz7e_qK9gNkl5K-ihQ>
    <xmx:_5eQaWxR7Vd75NSZ94Ce_FuUSSf1RtKeatkll9KsAsfwgvidVbUv_w>
    <xmx:_5eQacUSELGnSd3YJd7dPjUu3LBVbPMECsy262c50RjDQeyhOUa3yw>
    <xmx:_5eQaYNXK2xgFLGPNfjqc9BLhrnw-guVq-u3nkFITkYIE9NaBXMA1A>
    <xmx:AJiQaRHgRPnBCwFW7EcIVy8rQk1CpqR1IDmpKz2La1-3uZxjApYziF_J>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Feb 2026 10:42:55 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Matthias Beyer
 <mail@beyermatthias.de>,  Jacob Keller <jacob.keller@gmail.com>,
  pyokagan@gmail.com
Subject: Re: [PATCH v2 2/2] templates: detect commit messages containing diffs
In-Reply-To: <20ed1f26-f60b-4e30-a0a5-8bd01dee19d1@gmail.com> (Phillip Wood's
	message of "Sat, 14 Feb 2026 14:36:39 +0000")
References: <20260206090358.GA2761602@coredump.intra.peff.net>
	<cover.1770993281.git.phillip.wood@dunelm.org.uk>
	<494f4df6865f81eba42584ead81327c9a305d0d4.1770993281.git.phillip.wood@dunelm.org.uk>
	<xmqqfr74msm9.fsf@gitster.g>
	<20ed1f26-f60b-4e30-a0a5-8bd01dee19d1@gmail.com>
Date: Sat, 14 Feb 2026 07:42:54 -0800
Message-ID: <xmqqh5rjgwld.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

>>> The trailing ".*" when matching commented lines
>>> ensures that if the comment string ends with a "$" it is not treated
>>> as an anchor.
>> 
>> I am not sure what this means.  Wouldn't these three
>> 
>> 	sed -e '/^#/d'
>> 	sed -e '/^#.*/d'
>> 	sed -e '/^#.*$/d'
>> 
>> work exactly the same way?
>
> They do, but if the comment string is '$' then these two
>
> 	sed -e '/^$/d'
> 	sed -e '/^$.*/d'
>
> have different meanings

Ahh, that is what you meant.

Having to write "/^\$/" is inconvenient, because others characters
do not generally need the backslash (e.g., "/^\#/" and "/^#/" are
the same) and some characters even may become nonsensical if we
blindly add backslash to everybody (e.g., "/^\1/").

Nobody would use "[" as a commentchar, I hope, as "/^[/d" would not
work, and neither "/^[.*/d" does.

Thanks.
