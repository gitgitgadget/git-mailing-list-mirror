Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1C12DFA40
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 20:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756932254; cv=none; b=Stsgm2SFBAwTwyJhhaMgAmC9yCFxkMGBjMGskiWLrLtmNAQLuR0N81a14q76GLtQKHRptqBLH+qeRcpJrlLKH8cL7w2UHVr3jX2uEYIKSh+DNGJ7kmU7U2q+zwuQ+OsV1JLjhaLGjyUx/eEOim8y7hNlsMNXmvdl0HMC3CpC+Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756932254; c=relaxed/simple;
	bh=dTFrMKSMhgTlbqjUZjqc/wtbisK9GgZ5T5umB8TzSpU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=a4/Lvj0cC0iALbSCmg7UVnwMW6THUhzDig0qCQfieEUebSq+IbilnwPidI7bT4b7FB5SeewcZ5v4+yDYdV4XRm2GxnMpF/KVBlNTp0UkVHQ8ChdCNtclVi5gwWG/bKR8rPsUoEtRz4dFs8RreQTQYHyPWVt0bN5YEiUeMqCP+9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=bD2X8lfW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ycz6u6z/; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="bD2X8lfW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ycz6u6z/"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 29EB51D00347;
	Wed,  3 Sep 2025 16:44:11 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Wed, 03 Sep 2025 16:44:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756932251;
	 x=1757018651; bh=UpNd+QqzPzRCsGTl7zcW5slR67vBaCeV02dY8o43Pts=; b=
	bD2X8lfW/GtqqmobT9bM4qipJFjDLQJ/1gVw5SyVmPp3RFQZvfFyZYL/zOcVEqmq
	V/6GZY0wCYqX7Ov3BRJDPXKUG1bn/Z+yaJgHUU8Gb28SOeOgI63qYY5a62PxNGcN
	dyAlZ/dcG98jV8S/vJW5K8n1973FiXmOxgBJUkgujh5R7CjCjZj7m9LMXMarKcLF
	0qp6BsPt5FI/9XMkirCS9UiZT9nt18WTi020rsgqb7cgH7uNq4drGD885DkIdWdh
	rGrA8lcc4PT6N5jsHgyraW7p7WbatLk3C26MeE2rLTrBMdNgM8hSTLZWUkqej01l
	gRNEj9OJ6G3YhgRJCHPIyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756932251; x=
	1757018651; bh=UpNd+QqzPzRCsGTl7zcW5slR67vBaCeV02dY8o43Pts=; b=Y
	cz6u6z/7KskTH3b7a2SDaYzXul/kviQqD/kGhk0fNg8P5iraqonwxObfuLimPRNM
	mquVqq/okIXTQ5ekwio11YgHapWtV6vpXGlerRJ8BhDLQZ4nADHJMCjSO9Si6uyb
	JrXSNgtKwJbuDv74MDhIbJ14akJrLkNU3p/FsNbFfzJM/H5QVWqj9cFRw1u1OXWm
	1Yo3xu6gEDIMSAAj46/OwuWvjkkNDi3G+ZzY/O87QUvHyObtJ5q7kWuGVnuITvs5
	rkJAYDEcZMh1AbCjXNxoV/AbZ3i5eGh+sGNt/WDmMrzBouinBYO0zB/ATt4WOFt8
	NcgkhjB/QSrKPnz7aks8g==
X-ME-Sender: <xms:mqi4aIuPonwZWqTudDLYwfI0ugZsFltLuenL69em0uhOFhH4feLwuGo>
    <xme:mqi4aFccSESBsocczKEWuXPKOv-R8CsCR5BpFzJC3IOzkqBxEq04WagDpNGe-E736
    k1QXeURwM4aIaHa0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhsthho
    fhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssggrkh
    hksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepgedtjeeiteeghfeu
    tdeutddtiefgvdegteektdeutddugfekleeugfelteffjeffnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhg
    shgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehjvghsshgvsehmsghukhhiqdhmvhhukhhirdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:mqi4aDUXsGGAvZBKPQopuQHuPh1rNK1qHmuCHc9uOSjn-kuNl3c1Dw>
    <xmx:mqi4aCf7EJI-_KCdoFBQ-GkFYTgfeKiPTK5gfFc-jWED-lWPgoQCzg>
    <xmx:mqi4aMV6Zde_M89U34z4Wh8IsvjlsE-XWTFbZFD9NanAAWgBAtA41g>
    <xmx:mqi4aLdN8VNANg_NqA7MJv11CqgQWR94GP19-kgSrTDDmd0FYIaNZw>
    <xmx:m6i4aB0bLalR--GRkyy5NkUR4cErp6EFs4MZxbVMajMwYl9OXLQD367z>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A76A21EA0068; Wed,  3 Sep 2025 16:44:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ATSJx5N2MTR7
Date: Wed, 03 Sep 2025 22:43:44 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Jesse Hathaway" <jesse@mbuki-mvuki.org>
Cc: git@vger.kernel.org
Message-Id: <0219828e-4f7b-418d-9d5e-87c0b5fbd4d1@app.fastmail.com>
In-Reply-To: <xmqqwm6fe2d9.fsf@gitster.g>
References: 
 <CANSNSoWZNx3j3eLAayW64iC+bvC9XfetV+wZAkK6Zy8Zm0DWSw@mail.gmail.com>
 <xmqqwm6fe2d9.fsf@gitster.g>
Subject: Re: git whatchanged
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Sep 3, 2025, at 21:56, Junio C Hamano wrote:a
> The "raw" output spews meaningless hexadecimal strings.  Why not
> learn to use a more meaningful option, now you are switching out of
> the command that is going away anyway, perhaps like "--status",

* --stat

Probably.

> which lets you see the extent of damage to each path, for example?

-- 
Kristoffer Haugsbakk

