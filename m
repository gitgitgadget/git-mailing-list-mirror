Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C642D25C6E2
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 07:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740469203; cv=none; b=P8xWmfB+eRm/B+22i7i07rWYg2BC+sXGbUBiMg89wn3xsNz7jdoAhFpOMavw84XQ46j/hZvAfzg54EUkoC/LlXPizD3+GCDVjvM7V2cVPBLF6SqnuYJIkl+q9xBuuvOgU9X9UYGVa//7cKq/dRNDlI33KzEnMT5uZMl88E9sHU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740469203; c=relaxed/simple;
	bh=GNKSrqm3OyxS7gls+jhqQul3lJQ60iVu4bCLrD1UsvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wgqch2VhnOMzMC4b/mqybdLanQFJB6zq4LsZwNlddRrQbj4/JWJ44qJ33hqB4XoNL4YZDHD3eJ/6Y1ZkrCcUOXvOm1CM3P/mLtw43mVrKq9UDSaKdo1ksVQ6W4pLHEesEAnp2397IXCJpftRknEn61HQ6G+2hw0DRGFgDCVtwYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ajIpTda9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VbUW8JGY; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ajIpTda9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VbUW8JGY"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id A0712114017F;
	Tue, 25 Feb 2025 02:40:00 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 25 Feb 2025 02:40:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1740469200; x=1740555600; bh=GNKSrqm3Oy
	xS7gls+jhqQul3lJQ60iVu4bCLrD1UsvU=; b=ajIpTda9C1ria2MQ0ZmfMIE5+N
	2z6GubrNKTC1ZK5nTlm3EK3QcB7foiJ0L2Rt8nbIk1pXHL3von8NM45FfjCwK9Zy
	8K5rrPJIow57Mu2jd8+JNrzFJoroNhxMWFGb2PYQykRKIZPCYHOOfeb7KB+D5ITS
	a5s2zP6LnE7UzYDF+Kw0FW74p+pnc3NbdBgWlJjpzZGvINVrPuZFEX7VqZ+7Xn22
	0ackH4TTSuLR3ni9aLCIxLuqGhRZ/DAsp1eGtChKtbY5ngfDRFoAppQrxqY8VfQV
	50qskr5FLXeXUOYeKe8esdkksZErYQUDznhZdR4xdSvSFSOb2S6mzNSwqmNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740469200; x=1740555600; bh=GNKSrqm3OyxS7gls+jhqQul3lJQ60iVu4bC
	LrD1UsvU=; b=VbUW8JGYIEJv2plLEUhX4/n842iTFtz8Jb1aG8QiDRJiOllMkyH
	spG2QARl1lVdUQmslxZFcCZjRtFfho4c6oUOE5Gfn8HG8wv1Nfv4YrqL8a2MzJ4z
	4Q6LWqaX3BtXNIhrUPT65/9Ci29/3jY4NQ2VIeUYmI1baWln6XqEbrCHHsfLwz8I
	ZTEAiqq+DhbjU+CTtgOEBnYytN+UvmGm6jSnBSKxfyT8GDDs7EQBqeXy+yIJoqty
	REJ4BgUWjGD59xL+F33Ns5p6jB/jM30KxO1hbIWI5pTWcd5sHwWAkD+gRuEqRz/B
	2+WqY/G79OA4J6jmFOyjg3YGqypceDsZZdQ==
X-ME-Sender: <xms:0HO9Z4wRK117Jq_QhC4CM_5OFoMx7OO6NO_J5lhafUSRqfUeXp5A_g>
    <xme:0HO9Z8RcIDrHewb800Nto7IUJx7YzeNxc8DkKXylF1D7eVsy8bkuXjqPlzFtoTdHw
    m6awTPpd5Rg7PKc5w>
X-ME-Received: <xmr:0HO9Z6XvL0dm0bkgaPloUU6D6cvOF_7Nojd0l7reBM3-lOxQHfwZ3vAaCZlUjPiQozy5aBZLC_ESD3zEEEXM0AqeyRf9_4H2nBoOyuBg9XeLeQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoh
    epshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehsrghnuggrlhhs
    segtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghm
    ihhlhidrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:0HO9Z2iztqfb61-qBYvonvfWnQNf3ZfjWc5H4QglHWYeu_5TWvLsBQ>
    <xmx:0HO9Z6CXHV7o6_adrsVF0Lrh5ClHE2HeYeyp3a78E37LVYclnY5J9g>
    <xmx:0HO9Z3LrObFikeD3x3KbE2WrZ4Xt518jCazEYtGL0iZ650WYSUy7ag>
    <xmx:0HO9ZxA959qBtM00nG4kOmnMYHOS0WjDPxbPi53YIPHaC3m1LFwTVQ>
    <xmx:0HO9ZwCgKn5e82EZs-WhwtwY27jp9ui6yc_soWFbRj5dWBaiiwdRWpfa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Feb 2025 02:39:59 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a008b0a6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 25 Feb 2025 07:39:58 +0000 (UTC)
Date: Tue, 25 Feb 2025 08:39:57 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 00/16] refs: batch refname availability checks
Message-ID: <Z71zzeDc0AS4ujPS@pks.im>
References: <20250217-pks-update-ref-optimization-v1-0-a2b6d87a24af@pks.im>
 <20250219-pks-update-ref-optimization-v2-0-e696e7220b22@pks.im>
 <Z7yNsqd_28PE6dVI@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7yNsqd_28PE6dVI@ArchLinux>

On Mon, Feb 24, 2025 at 11:18:10PM +0800, shejialuo wrote:
> I have reviewed [PATCH v2 09/16] - [PATCH v2 16/16], leave some
> comments. For other patches, I don't have energy to review. So maybe
> others could help.

Thanks a lot for your review!

Patrick
