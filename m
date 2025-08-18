Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E49021171D
	for <git@vger.kernel.org>; Mon, 18 Aug 2025 19:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755544669; cv=none; b=eyYvVBc+148UN+J8FsKyDpaydnHtX9pvmdPAb282o4V1KiuO789f4Iksxg2Jnyd4/t6aRABMHkTF/8c/Scnu0KsoXzWStTGUPPIEDPJbqoMF/TL3JYBDDfYpr4n5m9M8oLaDEbGNutjYvfh5pikFSGE8lulCw7g2u6iypTydPEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755544669; c=relaxed/simple;
	bh=eIAaa4hc+pxojJgF4q9MARErthWbdXy6XEH/O+e38Xo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bzRVrnZqagCxcGvEqTfrIcOCAKKMSjFmR25jgnhdqu4WySqxS1brTVOqEjnmgsQBq/P3aKr4PULTTa//srjeu3/3SksvGAMUHhD2W6mfpC+I6r7r+8ozC1WBN1vOtpmPnDdKr85ufK44cEe/HI9CCa4tabya7ymwpP/9Zj+74bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=D4KfYkJX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FkaHio8L; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="D4KfYkJX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FkaHio8L"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 03B8F1D0016F;
	Mon, 18 Aug 2025 15:17:45 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Mon, 18 Aug 2025 15:17:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1755544665;
	 x=1755631065; bh=k/6rkIRgzNyNbAa5Zan5ybbCXfvevKOWo3cy+x5ynSQ=; b=
	D4KfYkJX9m65jm33/rY7ERWLNf3lS0uFxhFkqfKgxT49t5JtjTm9nc7ZrO3oslf7
	b228YuuDjahwYubJCPHFqv1fXtBSIcJhmXbSVH59Mt6O2B+uR4TfsC/uBJJFUk7g
	VWIC0sjD+txuBUIBLps8q8t+f9mC0GruEFWmfMf01OGYsA6a8bU9dkEN5woC2hkL
	BKyAPyQkpy0CZ63cmsYRlS3JrvNCp6RF7HZbIh9C3gwwbU43kZ150CywGV5KSYQg
	Euaz6NL6WtfbbM7dnCq/VTHCZ8G1nGwiR+3cy+QChPHhSiYG8Kmib6R8bJswYN3q
	6H7PG0kVYboPY5zaF/H47w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755544665; x=
	1755631065; bh=k/6rkIRgzNyNbAa5Zan5ybbCXfvevKOWo3cy+x5ynSQ=; b=F
	kaHio8LzzSMuHsYuzCX77NNxk6sEJl23S/ImGys0p3jI2dOXNxTokAFl1O5JCMOo
	Jo3r63eyXXqnaUwokY3wWV+Mf3coqqFi7M7Ntb5zc5C4sq5dXxGxP6HcVRw0CjBA
	1chozg3KIFFOTKazLGBSrjN2FSf/Qb9ksPEdvTmTsaErlz/l1Bc7na+boSXf7o+m
	p5nh/Spd6LndT1fPo4OE330FchTZoIuSz2ta76V2FwcorAWx0oe3NeWMSheGJUZ9
	acfZYCjWKqwGa0pUZJLX3xYWYFzHr6jLTms1fTUSZHXhj5NATUe5S8wR+ua00AEU
	Lj6W/E8GLOBKGxJ07I79A==
X-ME-Sender: <xms:WXyjaDqoiFsdPdPJPld5ioyxSDbvoVrbNOxM7TT6OAnZjvdfhLEKlw>
    <xme:WXyjaIPKtY_nobAwYTHK8U07Hq8l_h0lfJJvHO2j8ns58Wag-N_zaqc4QxjFUJFcH
    tGoed5H_s-XVUSBfQ>
X-ME-Received: <xmr:WXyjaMz5PKjwHsnb6Ylr5qKtVoiVQ-zo4x8CvgBwa4CN9QJB6yS8QTgmMAwKTM8MNjHAsDyghJUPs6dCPS63JDc9wnD4PWp_gNdZcVM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheefgeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    vghvghgvnhhirdgthhgrshhnohhvshhkihesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:WXyjaJvZtEezPJBDfVYB3QwJY4TY1OMZ3FoDeAjM-8v_YATBvg4UKQ>
    <xmx:WXyjaN42_Fa4Ns1nkmv-VTOzZX3HJjbfN6Kvp6w3X_4Jm_Jo__2qGA>
    <xmx:WXyjaATkQUM9vT0QYAj2asFjIPkgL1iHdf_fiFeM8AsT_DSDU2DMWA>
    <xmx:WXyjaEqUxpy97BwHI7wH-XadUc4Y-VfiKrw8cvQarPv-H8yLfxH9hg>
    <xmx:WXyjaJbejbm3eg6qhj1F5LCKWyDwogti03aheFlHWMQ9PB2muvMniE-m>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Aug 2025 15:17:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc: git@vger.kernel.org,  Evgeni Chasnovski <evgeni.chasnovski@gmail.com>
Subject: Re: [PATCH 1/2] line-log: fix assertion error
In-Reply-To: <20250818111310.1283932-2-szeder.dev@gmail.com> ("SZEDER
	=?utf-8?Q?G=C3=A1bor=22's?= message of "Mon, 18 Aug 2025 13:13:09 +0200")
References: <20250818111310.1283932-1-szeder.dev@gmail.com>
	<20250818111310.1283932-2-szeder.dev@gmail.com>
Date: Mon, 18 Aug 2025 12:17:44 -0700
Message-ID: <xmqqjz30igmf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

SZEDER Gábor <szeder.dev@gmail.com> writes:

>   - When a commit modifies an interesting path, the line-log machinery
>     first checks which diff range (i.e. hunk) modify any line ranges.
>     This is done in diff_ranges_filter_touched(), where the outer loop
>     iterates over the diff ranges, and in each iteration the inner
>     loop advances the line ranges supposedly until the current line
>     range ends at or after the current diff range starts, and then the
>     current diff and line ranges are checked for overlap.
> ...
>     Fix that loop condition in diff_ranges_filter_touched() to not
>     treat 'end' as part of the line range.
>
>   - With the above fix the assertion error is gone... but, alas, we
>     now get stuck in an endless loop!
> ...
>     Fix this condition in range_set_difference() to not treat 'end' as
>     part of the line range.
>
>   - With the above fix the endless loop is gone... but, alas, the
>     output is now wrong, as it shows both line ranges for HEAD, even
>     though the first line range is not modified by that commit:
> ...
>     Fix this condition to not treat 'end' as part of the line range,
>     just like in the previous cases.
>
> After all this the command in the above example finally finishes and
> produces the right output:

What a lengthy journey X-<.

Thanks for an amusing description.
