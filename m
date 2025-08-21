Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2440D2E8B80
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 19:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755805969; cv=none; b=uPkdMN63rgusvPr0WvSYhqMNVRZMBl7ECd2dvmd/3KWmdKwzKQ9tT7DkPFwPBVRqCw09v4nkqyHyLLnEBcaO1Ly+hUgGJ1iLPCKaSnNyPbC3xKeIfbdFxKAnIUZPlqAGBDEHNE4jKKLcOzR1xQayuf+nIdxnSt/pQB2zbP/Q7hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755805969; c=relaxed/simple;
	bh=i4PkpHFCcpCt8iHgks5VA2O2b2MExyV5zeKLQl0vNk0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qf2xmsL9/jTLt5CBW4lISQoU1BOsXrEZObcP+xTMJmmP1FvYfJy20R6WNiJ2y/pOqkMoRHbrZ4clp4//J0lc9yZjYxeur5MSpenS5ctrHzeGP85YdndHCDWEGhX0lFxlKuirm63RioDotw4HYhg9LC/F47RIuDDL+sc6J8+5VF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Xq1o95hY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hmHx56bz; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Xq1o95hY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hmHx56bz"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 01CB97A01AE;
	Thu, 21 Aug 2025 15:52:45 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 21 Aug 2025 15:52:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1755805965;
	 x=1755892365; bh=0R3deH1QKn86aX8aCFsnMOHuQIR+L0OSgnhznZZnS3Y=; b=
	Xq1o95hYTOxOxszMKjRiZnT70yKhD6vsc1u/Q0oFPLi2PFqXldZqTXnGgnrAWtj2
	SClZPEf3lQc9MZqlKKxUbsBbDWUaO1YQhqZ+4b2yWGaLAUMDGJuzLkwjdgiCkkDd
	xNYedesj0JXpWX6YAe3vgVqG5Erc958D8cIpotT0R5dKeMQK16oAr1yNaJ+w5zvc
	LD0rqDhlZ4jikXDdQHFTnF2yYrJDILsP9wrMxn7zQfpUFsVVCg7GNWex/w0/XvXO
	+Eoz25cTir/FV7YPdRut2BFqyjv/0I+ihYYG9ykLhtJTItwgT+baVMqt9eHpxDOR
	SJLyNe6ltreN+ZhgXdDyUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755805965; x=
	1755892365; bh=0R3deH1QKn86aX8aCFsnMOHuQIR+L0OSgnhznZZnS3Y=; b=h
	mHx56bzajE5y1/LUiHYZfQqE/ttZf7dP2sboMvijA6oBGpizLFbbFfKYeKM6wUkX
	GBIkoWir8naLRt2x+yP8A0lhAhLAQ8sGQUCIHT2OL3br37M2SOj7BYYj/Cd3rvXG
	TEifIXJOKKoouCdctneLwgTnSsCt8k63KdDyaZl3udtSqVPUscl06dc4llzSwFuv
	e44PNHdt14txecwdjDpLKTWQd7pYxHOu3GJ2+0TmCw8OEJ+oowq0Go7O5TOafHVV
	wdmOp6c6iZx6uEoA9zPBYdHhN41Jmy7F6tGAKW4PQgCT7tL0vAo47sW9eZ8iU5FM
	Mi1My2yGuyfcxitv3dHLw==
X-ME-Sender: <xms:DXmnaBS7qgg3GbZMfEBLBS_v5T7FybBMXeD0NpJrrkdQEwVWj_H-GA>
    <xme:DXmnaDP6-CvbQBggwzLWq7lIop72MDHDeBee5L5MzMyR9sEpp9vUgIxdIXu4PRdXs
    wDSh79gN5Vl7pzQYw>
X-ME-Received: <xmr:DXmnaHTJvS4dze-B2w2ahucA_-1Kx-G9vF22njsVQS9kMDnynki9-5vb0Wq0ZjGFAtjWFh1wtcj8i0yhopUci2PA8oq4JN8gBgaJCkc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedvuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhutggr
    shhsvghikhhiohhshhhirhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkh
    hsrdhimhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:DXmnaJjNMh-r1BcMxN6417LI8a7vQPOpOms4wfC8V0-5UogMNZ0epg>
    <xmx:DXmnaI84qNQNOXMp3kRaQsW97wYMzHEKf2Iwq4HJr3LL5stD6MdwjQ>
    <xmx:DXmnaIEFTeI8WDTncgq514epdfMRVZHCPTm8PWoCWMIDYBVGP8VF7w>
    <xmx:DXmnaDlCd32D2024zUlBDmm-x79ct7uA9qFhZ4U0V4Lw7Rwn0reLfA>
    <xmx:DXmnaByOVe_5tb9m1TXDoSyHiJ4Y9eU0SUV8kZsh4a1CO7_1Ava2wBEE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Aug 2025 15:52:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Cc: git@vger.kernel.org,  Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,
  ps@pks.im,  karthik.188@gmail.com
Subject: Re: [GSoC PATCH 1/2] repo: add the flag -z as an alias for
 --format=nul
In-Reply-To: <6186055.lOV4Wx5bFT@cayenne> (=?utf-8?Q?=22Jean-No=C3=ABl?=
 AVILA"'s message of
	"Thu, 21 Aug 2025 20:23:58 +0200")
References: <20250820144247.79197-1-lucasseikioshiro@gmail.com>
	<20250820144247.79197-2-lucasseikioshiro@gmail.com>
	<6186055.lOV4Wx5bFT@cayenne>
Date: Thu, 21 Aug 2025 12:52:44 -0700
Message-ID: <xmqq5xeg1mgj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Jean-Noël AVILA <jn.avila@free.fr> writes:

>> -git repo info [--format=(keyvalue|nul)] [<key>...]
>> +git repo info [--format=(keyvalue|nul)|-z] [<key>...]
>> 
>
> In fact the correct formatting is:
>
> [--format=(keyvalue|nul) | -z] [<key>...]
>
> As stated in "CodingGuidelines:
>
>  Use spacing around "|" token(s), but not immediately after opening or
>  before closing a [] or () pair:
>    Do: [-q | --quiet]
>    Don't: [-q|--quiet]
>
>  Don't use spacing around "|" tokens when they're used to separate the
>  alternate arguments of an option:
>     Do: --track[=(direct|inherit)]
>     Don't: --track[=(direct | inherit)]

Yup, thanks!
