Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA4E1E260A
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 14:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757342426; cv=none; b=B4UZ6x0UAKNgMOuh06wsABRD7qDnjEz8UIM4Xwvxyc8glILLE6F/rXK05x2IKQDNPh9yXn0YwVwNuApYXvqD/zEinTZ/h3NDP8i+AVWNsDCzPWOfRntFSWvg6ULL5yFc9D72lIShqyTi7ZfLa8REW6SF6I+Q1R96Frbz+GMb9Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757342426; c=relaxed/simple;
	bh=HLO+QSbFQUqNFV12nYOdIb32d9sqkv2Rduye93qlV3I=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=BYz1i/eULsO3k0EG7A3k9xI73u1UmsTzgppWPE5g0p4rtPja8Gh81aF14ljhRp0/AQU6k9fs04oakB9o85pK6gzD1feekkI4l6I7TJrm7TdUYwrmwiYVCZ0wyQ36pzsMZ8ds/+eJLKkNa4iqtAL/4S4IRcOpkISbrWCYjlENlUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=QUzw83uS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l8E/Nqp7; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="QUzw83uS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l8E/Nqp7"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 7B234EC0237;
	Mon,  8 Sep 2025 10:40:23 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Mon, 08 Sep 2025 10:40:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757342423;
	 x=1757428823; bh=8PQL9WuJos9QhDiZTaQNthiFUl82wvtpbNG/gi0qXh8=; b=
	QUzw83uSsjvmy99ow0B5vLScEKLOIgN47gtjmNPH2ZGuO8PXD53hUeA1T4qE1xU2
	MpLIhN7owLEv+Mdse3FcL3vuHtw7E9f6a90TabFpXWLIw3VidpzKPxf6X/UvWSko
	t8Y2RLUdZCl4Cla8CWaVyRFMJY8Q69kSHU0gPu6oiPie5xAoF8fc5EiolpZvGpm0
	FpVLf2u+PvBxDrJDflZs4F4gK9UYZIrjJje2eWACKQxvxfEie+B3Xbpttde1fzrK
	akJd3sAyU9eqIYT2u6VvaqT6k5Cq2DMIXx/HNNV1vQ1DHsj9t3B8rxg7xtnNCjMl
	I8dtwPOWhNGSPUPrEwBd4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757342423; x=
	1757428823; bh=8PQL9WuJos9QhDiZTaQNthiFUl82wvtpbNG/gi0qXh8=; b=l
	8E/Nqp7zrSTu1vj7zqGzsvTPhzHpL2YKZV2HA1aGHyl1yV72CqMsoHAU+nNQtPNy
	Ly3jvU2fLoQyWzBTdEVCdiBNWnmFdFAMr8xbnETcTTv++5rdBkIOzSWXOPD+Gowr
	3bEh9sszgrDCPeo2KbjqT7AMoN5QF7P+S3oZrwVh4JE66sojtTk72LIpXrVpgVZm
	zD7Qq4gMk9KO2HeAL5tHNI5UOOp473SHuhO3b9ZYfc11+jYWvlJZB9rCZZ+y3eQe
	xD4flX0RPO8wZCMTkPVDvPvdC3SrV2ADjFXY7ccb+Z/5cgaWpyhPuuOm+YHs/9jb
	51AA8OkGujc7weutuJiMA==
X-ME-Sender: <xms:1-q-aNl9theQdbCy8bIhfcPLwlnhdcM_1xUEipQQqU9rFA3i-12pdjE>
    <xme:1-q-aI2nxofdQPBdIs_BsbNy-WppqM4wkc2eicZwdyTKTWMGFwSAzmb49JNCE6s6Y
    9P58QvP1oavLf_fVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeektdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeegtdejieetgefh
    uedtuedttdeigfdvgeetkedtuedtudfgkeeluefgleetffejffenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepuddupdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhes
    ghhmrghilhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
    dprhgtphhtthhopehjohhhnhgtrghikeeisehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    khgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgvnh
    esghhmrghilhdrtghomhdprhgtphhtthhopehsihguughhrghrthhhrghsthhhrghnrgef
    udesghhmrghilhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvg
    hlihhnsehgmhigrdguvgdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgt
    phhtthhopehpshesphhkshdrihhm
X-ME-Proxy: <xmx:1-q-aEcv9bJeXuRcOBw5MB55eLJzhLc4i_TW6Vi740QEvMtB4rvYzQ>
    <xmx:1-q-aO0uoZk4ImxMOv64AgGEmsI30sCxVCEg2FXouLLPCevydFllDQ>
    <xmx:1-q-aM-7KvkFh7DSGIj9DaeEZANxEnUbWFGa_O1cA6Y6b9-W5urmUA>
    <xmx:1-q-aD4MjfCIGjoAOf4wVIPbb29RcIVk5HuPhF05evXeXqL25RqxVw>
    <xmx:1-q-aETlTApML6_RaL5t-J1l6PY9QhFrRgvM7I4ypJpB0E09epG0GK2b>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 00CE51EA0068; Mon,  8 Sep 2025 10:40:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Acg5J5VCLpxV
Date: Mon, 08 Sep 2025 16:40:02 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Siddharth Asthana" <siddharthasthana31@gmail.com>, git@vger.kernel.org
Cc: "Junio C Hamano" <gitster@pobox.com>,
 "Christian Couder" <christian.couder@gmail.com>,
 "Karthik Nayak" <karthik.188@gmail.com>,
 "Justin Tobler" <jltobler@gmail.com>, "Elijah Newren" <newren@gmail.com>,
 "Patrick Steinhardt" <ps@pks.im>, "Toon Claes" <toon@iotcl.com>,
 "John Cai" <johncai86@gmail.com>,
 "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
Message-Id: <ecdd1191-844b-47ca-9737-cc2ffb72b37d@app.fastmail.com>
In-Reply-To: <20250908043620.57848-3-siddharthasthana31@gmail.com>
References: <20250908043620.57848-1-siddharthasthana31@gmail.com>
 <20250908043620.57848-3-siddharthasthana31@gmail.com>
Subject: Re: [PATCH 2/2] replay: document --update-refs and --batch options
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Sep 8, 2025, at 06:36, Siddharth Asthana wrote:
>[snip]
> diff --git a/Documentation/git-replay.adoc
> b/Documentation/git-replay.adoc
> index 0b12bf8aa4..cc9f868c2f 100644
> --- a/Documentation/git-replay.adoc
> +++ b/Documentation/git-replay.adoc
> @@ -9,16 +9,17 @@ git-replay - EXPERIMENTAL: Replay commits on a new
> base, works with bare repos t
>  SYNOPSIS
>  --------
>  [verse]
> -(EXPERIMENTAL!) 'git replay' ([--contained] --onto <newbase> |
> --advance <branch>) <revision-range>...
> +(EXPERIMENTAL!) 'git replay' ([--contained] --onto <newbase> | --advance <branch>) [--update | --update-refs [--batch]] <revision-range>...

Another downside of making a separate commit for the documentation is
that now `t/t0450-txt-doc-vs-help.sh` will likely fail for your first
commit.  One of the tests makes sure that the synopsis and the `.adoc`
is in synch.

>
>  DESCRIPTION
>  -----------
>[snip]
