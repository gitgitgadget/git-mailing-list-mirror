Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B85323BD17
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 20:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755722812; cv=none; b=HRzJIG41d4OEAeaB32gyUL7lYYJaBKyfZI5OIfqGyS9jgYAm/pTCGWbhnqmw5kudihWFQGub86cVmRr2YLZ67eLqhoZ6zvJ89qQ799IP4cBQVNVb3/99LjyHTuFdXLCSAni4ri8Oz/FiFMQH3OTqXN639RzcOY0Fuj+nmz0IsKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755722812; c=relaxed/simple;
	bh=5vNIHcO5PVj0IOmAxA6p8aeEv2oLVaiByckp1lP5OSg=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Oqu7GtE7eV/iwASLEY95WPMFRkTG++OCM3tzgHDFbczE3Q0vWpWkK9w4AX47rVZ9n78n0Cu5j/+Ixsw9EEvqAayIyRwK3bIyQnRd+YsWYb6/xFgUEkzKb7x11m1TRQv5tADk9G2rr9QLNsEqOtk41rZ3wpJL7gJUbFXrJ2Yk+Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=LPUNChjT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JMBubT9H; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="LPUNChjT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JMBubT9H"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 171CE7A01C4;
	Wed, 20 Aug 2025 16:46:49 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Wed, 20 Aug 2025 16:46:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755722808;
	 x=1755809208; bh=jhILGNNS+B5oMnoPY2tS9RaUYB4puA2FcTkNGSHV7oA=; b=
	LPUNChjTWJs/hGMTCww9EwnsbCesJAPc1RNKOE0UuHMtPJcKcQ6PNHClcJmfDVT0
	8hzqxB92swyTGW4PRR6uhJItoE5+xqm95eBO3enTqtc6Bnu4Re+8L4MIIn6Ur4EN
	J/yDSzjcfoUkPYqVmrGsD9sPCqw0GUDX1KrAK4HsyUvYa6aCN+hRpRYp+uKghHId
	EHWXZ3UGOYo196+O1JUDzf5+RPWFaoc6ZPNA4qbKH63HG6ZpH+Wn95HDRZeD/f5o
	AU7/pDTOB5YIjdu8CdRTiQO/SPr7eIm0cas/5GbPu9JefZ0HruBLm0V01gU5wzaP
	tJYqrgh8eWVyopOrXCGcKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1755722808; x=1755809208; bh=j
	hILGNNS+B5oMnoPY2tS9RaUYB4puA2FcTkNGSHV7oA=; b=JMBubT9H8CrVXD+mA
	DlBwg8g9UDP7tB53dEkjtXTszTIQRzXVvP1jcgF+UrV8/5PouqemvTvrFeMuvQ1H
	H0XXIIe2r811KkQmtTc3m9xsWwdDsiMGIiW5LpKNr7Uj3Jc6ZfMk3IHQ/XhUTn6P
	Fdm8ejPRuZyrD9A2qAMi7iZEB5f4qkZlnonADtjUI30InRqrqLbY/6O3D+yNOfa/
	2sT7ikC8CAsDPoEakIAkq5jLyyXrrzjqiOxEyMkGfsrHFxdrhz9aSxugNvwlx7zs
	KFujCvV0E2oIUjoTgjcRQ2Q+RvLvfHVR/4T3JhEKt59xUFFjYyOg6rXCqX5qyM3T
	aQvnQ==
X-ME-Sender: <xms:ODSmaGe381nIzKqoaB2dxdCklffWCTq_W137lytB1Y9ATD5Gpw43XbA>
    <xme:ODSmaAO9dfCzEfHUBV0nSNpa0ah6PvQI_lo1Q_it7y9WFEzwTASvcOcgymDL6QsyA
    5JGk03GVHPhEryGXA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheelfeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedvieegtdfgteeg
    hfffteetleduveehteefkeffheehfeeihedukeevleevfffhjeenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepuggrnhgrlhhlvghngeeisehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ODSmaGjEaSRSyvW-Obfom3FKdqUTCNfqkkP-mNsRTHkaiFA_pPCYyg>
    <xmx:ODSmaP-NJLHgnr121qfHkVhXpamtvboKrrz5MdMEBH5vFT5eoY6YwQ>
    <xmx:ODSmaAB7z-oV1AS6SRwQ7OmU_UDbqQ1wE0oht1YMtgPVJWcK4G-0Hg>
    <xmx:ODSmaMIRbqIjTgKQsZ3wbmeq6nRN9MSuZIaKqZzOo71WzLxBjs-GtA>
    <xmx:ODSmaH5qC2_T_lkQwhCeyzSKJTuotv4t_jDxpn7Z_Vqx3WLDy4NKtT0H>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id AD41A1EA0066; Wed, 20 Aug 2025 16:46:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AgTgWjfOuUnV
Date: Wed, 20 Aug 2025 22:46:26 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Dan Allen" <danallen46@gmail.com>, git@vger.kernel.org
Message-Id: <868d0df4-992e-41a7-901e-288a4ff8527d@app.fastmail.com>
In-Reply-To: <83241BDE-1E0D-489A-9181-C608E9FCC17B@gmail.com>
References: <83241BDE-1E0D-489A-9181-C608E9FCC17B@gmail.com>
Subject: Re: I use whatchanged!
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Aug 20, 2025, at 21:20, Dan Allen wrote:
> I just updated to git 2.51 and got the spam about whatchanged being
> nominated for removal.
>
> I run an important python script that uses this to set file times to
> the dates of the actual git commits, so as I browse the files I can see
> their last modified date, and not the date that the file was last
> synced.
>
> Now, if there is a different way of setting a git repository's files'
> mod dates to their actual date and time of last commit, please let me
> know!
>
> The exact usage in the script is:
>
>     git whatchanged --pretty=%at

According to git-whatchanged(1)

    replace: git whatchanged <opts>
    with:    git log <opts> --raw --no-merges

Should be enough.

-- 
semantic drift
