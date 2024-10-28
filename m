Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A0A152E1C
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 06:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730095305; cv=none; b=iHcw2Y0EMRym2nFwNDJ3z2Y11ACHm/0/NznO4qY/hivqZ4OTLRCpTKiQHjGQjpTFaJTWu9INBKIKfgujrMeFIzw6VCRt3nnyuxmN7Wp4hQJJQDtUhlEQAMgxPXfvoFIJJaSUInmCppG1yr13rt0bI32ApAC+jszgDJLfVxJRO9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730095305; c=relaxed/simple;
	bh=suCTDmsAPG5WbIxMmEmiBcgA1chZR9+pd/zFtuKiVIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EcJXDS2ycIlxG6RPSqFLyeqy09ys+Ajmrc38Uk9tHQoXP1cRZkCJOdJJpUQMFh/r9YK9BzPN2tnx870Yi2jxP8PaZKkTvVbjNpFL1KxJb91W1uxK5ht4T1eIdJ4JLWUERL7OS1hK2aI3PgtedUPkOlzmya45Fsd5NZcaYVYNct8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Dmn/qDYj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gw1EXlp7; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Dmn/qDYj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gw1EXlp7"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id C4B1111400F6;
	Mon, 28 Oct 2024 02:01:41 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 28 Oct 2024 02:01:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730095301; x=1730181701; bh=ibTWi2zCQS
	GG6G6PEIawWN6H+F1n4mW0LcrnVxTYCNs=; b=Dmn/qDYjHoHFQbxUlHPXzpNj6e
	jxAAtawRLfuy9bmZQhLImvVIbc6JnfL3m2gX+yvVDUKLZthAsUV7+gkEJ6koZG07
	PtMMMLyslr2GbOfjfXRDpUH4i3z18AE1zSgrkzdIprGKqvyJxE0tk2IwA8z+l5oQ
	jMawPy/LAF5jafcwv6kbgggVbu4uvtcSGZo8WwD5U8dVoBLutCKEVNj7k4pwO7bb
	bbToFSQeBkZI2C4xi8vV6XK+PcAm6jpxzm/RGet08P7dx2FEGiUbw3PxEEaeXcUi
	yIcwb9b4DDQmI7Ee4vZgp3S7JCGEu2nVfKwNaASql5pWx5CYhUkbDmwIrcoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1730095301; x=1730181701; bh=ibTWi2zCQSGG6G6PEIawWN6H+F1n
	4mW0LcrnVxTYCNs=; b=Gw1EXlp7pJ46Fpd+YZBOlKtw6tpReH7mLH+I7yocry8/
	ZLiy6bNQ00/ZtHDLQq2x4boMkt77hr0oBiYEQE36T0hEG5nHfMIe5PBh8XYVZfMe
	TSOL7s1KnRrzN9AUZkK0lf0vhNpd8sT+mUGDXK5NbuRCpBr3y3AySrT/HyOMMx0p
	n3wqXhtrtYb0zfJnkGZL+wwJzh8o500H93HlQLYqxq2YOla4CUyg0jjrXMS5fxfi
	RWKXbsCcsBh3dKgML4Ja7TSecNeByEwAZXF0hBasJifI7/q2HSHWXRnMEmtyrQoT
	SuHH5sgs5ttocBgGf6hXRSeawJEEY7HoyBRATreOiw==
X-ME-Sender: <xms:xSgfZ6d_y511ySw-VlVwtauLtfiJw0QAEmCHCJFRizezfh0Ie1lotQ>
    <xme:xSgfZ0OAP8wuSJOTKZ_7-_aBbcE5NsZofXl2TUk_C4ZCrKHMcenn7Nj_sPzQCZrvn
    UknyqpJAFlIhzB0mw>
X-ME-Received: <xmr:xSgfZ7gmalNziA1YwtXG3ACEmB98CCM5NuBTp5A4V_Z_Rb-9BtPthfqbNWaEpetmeRqkpepTMXMxEq-7RBGc81v5X4Wi2ryqeK4mzqfoy7ZooQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejjedgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehphhhilhhl
    ihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopegthhhiiihosg
    grjhgrmhgvshdvudesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:xSgfZ384f2mXLhIIbFdFqgKDyz9TlhUNDMkHMdB6qqBJ2W0ez7wwyw>
    <xmx:xSgfZ2vsRKsT0ePosEj9fKeZdUOkRXjF85Ym9R07BTTO8UhoN-rjnw>
    <xmx:xSgfZ-FnSxZNo8CLdhiZrZDU7q1AmFlNMWXWNHjY-IFR6CynE7L0hw>
    <xmx:xSgfZ1PyeJEXepspIgwaWMc9NjfSCb1ItEyIm6OjyJ7CH_zsPaO-wg>
    <xmx:xSgfZ6KIal0upcbCrbcDx3zib8SbZwh1h76KphV9QJxZ_4WRGZN7PaJb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Oct 2024 02:01:40 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9309f695 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 28 Oct 2024 06:01:33 +0000 (UTC)
Date: Mon, 28 Oct 2024 07:01:32 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Chizoba ODINAKA <chizobajames21@gmail.com>
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk
Subject: Re: [Outreachy] My Final Application
Message-ID: <Zx8ouGN5ln_VtsHw@pks.im>
References: <CACwP9aqFY6kPOSzv2JWWZejwAiYbMEJJx2qxomEnyxnxKFvkvA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACwP9aqFY6kPOSzv2JWWZejwAiYbMEJJx2qxomEnyxnxKFvkvA@mail.gmail.com>

On Sun, Oct 27, 2024 at 11:48:39PM +0100, Chizoba ODINAKA wrote:

Thanks for your application! If you haven't done so, please don't forget
to also enter it online via Outreachy.

[snip]
> ## Timeline
> 
> Phase 1  (December 9 - December 30)
> Community bonding. Talk with mentors. Read Documentation.
> Write backlog.
> 
> Phase 2  (December 31 - January 27)
> Begin migrating unittests to use Clar framework. Send patches
> implementing the migration, get reviews, make changes based on
> mentors and community recommendations.
> 
> Phase 3 (January 28 - February 25)
> Look at implement additional assert functions for Git-specific types
> 
> Final phase (February 26 - March 7)
> Working with clar upstream to improve shortcomings discovered during
> the integration of Git with Clar.

It's somewhat funny that your timeline mentions backfilling missing
functionality _after_ migrating the unit tests. It's likely that some of
the unit tests will need to use such functionality. So you'll likely
have to:

  - Investigate the next batch of unit tests to convert.

  - Figure out whether these require functionality not yet present in
    either clar or our wrappers thereof.

  - Upstream potentially missing features.

  - Migrate the tests.

  - Send the patches for review and refine them based on feedback.

This would be the core cycle of your work, and you'd probably repeat it
multiple times.

Patrick
