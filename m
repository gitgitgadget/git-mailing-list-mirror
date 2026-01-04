Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3118C4C92
	for <git@vger.kernel.org>; Sun,  4 Jan 2026 02:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767494107; cv=none; b=dtwx83nsy6Ru54XKvAjclbGacohDCLtpAEK/Lgo7Fvn+x1/oNThhjJM/LF+kZx9aGZSL4jtv/w9X9cb7GgaJPIRophR2LdHTz1OzhvZqtmMVjxUNHop9VOKTpsxj/jK/HrXWms1XevL8gCvI0BcgiteG9qTP6Zj6mxccYGe1Vc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767494107; c=relaxed/simple;
	bh=bBmE/LO4hrN5qVMPyQU5jDFBRO+ZfsEdZyHyk5PCNZ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TYdzrygo75uX6w11STx8cz5lCAC3w9EpiDJYibfyHfefh4cS0sqdOeeOnyt2kUJ7eWrs+er7iiKYxqsORdwi5TorrCUI87CpbTxPv87G0d4O/nz4odifP4gp0KXlmuU6FIyzPH/8yqz2A8XU82pwgqLiAGwqmEPSDi7t/sO6oRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FfN4qkJj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MCpdPnYW; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FfN4qkJj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MCpdPnYW"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 515547A0076;
	Sat,  3 Jan 2026 21:34:55 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Sat, 03 Jan 2026 21:34:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1767494095; x=1767580495; bh=WPSdZokmhm
	A3it2WKfGqkZif/aWISZQ5aidnGLwmv/c=; b=FfN4qkJjvWSbMNUky4d6Q4Cezt
	CvL/EjqSoBKux5tWcgBYePLPnQFoLDk83Bbbls1eoy5Ft2n9T7/nIo7KexBmFY3y
	5F8PM62WxwUDNHeDm6OSpo4c3omdNFggxyJ1kyqpYL4hYYF6IQVc+wt4cGk1vbZE
	0Z/Gy5NSGk6H8+teoGYMHPZGvHyNHkMnsX7oQOw4VLwDJHqBCBIpLRg3W3OhdQdY
	mNIMur33V8COFSay1yIyIlWYVgydFP4q7V8/gHTYtjSZakhRm2w51gK2Yel5ZNvJ
	nKhH3LwQ00SeEOgzHe2EDgsBtG0d7kcITZ21IPAPkCiok+OoxRu8Xfdp9Grg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767494095; x=1767580495; bh=WPSdZokmhmA3it2WKfGqkZif/aWISZQ5aid
	nGLwmv/c=; b=MCpdPnYW1jhB+JthUABgFl1ztC6WDGezJTAhVR8JTOdoWYj5xzt
	e08s38vW3CN72HqZiRSAa76nPVS40UqgU7BT0kRkTJpdwFJ7JKy1g5j/0bJmAnUw
	4KKdayYukmh3UpvP+C/oRdThhMYbMtj6KTmigvtdJfX3jPl5r29Rgg5qMivBSqDS
	e1BWDdhLxLBjRHj1YpCTC/g8ctGUDg82AVOEjhFWyEn2rt7+C7W+igwma1xrOo88
	fRcGpshX4BJeZKOe6ZxMggkznD3fqwd/t58XuZei7aN48dqQJ09btBV2InjGhqB2
	kpC7aseAKqxoW7QDgh97q6/kIlJJcTqUdfw==
X-ME-Sender: <xms:z9FZaYyI7nlYzOtfLNI54tDAJ9C2aUCYip4D9CSe9V6R4zlewiTYZg>
    <xme:z9FZaf8sv3mp0ul9HGYpSfeBlFNP7K5J1yAp8OdujfovlLpknszzkz3GoV2pMMjoE
    KaURibYlHfzaSrqL8WfvwYTch424VAL1sxkeGLw5NHig5EKZVce>
X-ME-Received: <xmr:z9FZaUKdqn6S_L6BMNQhOsFQqz23FXQXirXvNuuHQu6nm9h7rX6I2ZRtI8nYhDLhUX-7KCzu6x5wrnq-g2U56-HjTsguAYyDj15_CcA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdelfedvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    phhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehprg
    hulhesphgruhhlthgrrhhjrghnrdgtohhmpdhrtghpthhtohepghhithhhuhgssehprghu
    lhhishgrghgvvghkrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:z9FZadews1Ae3nOXhHXKjAMc-r78RiYnanuI5Fa9nEegDzYirtHQ4w>
    <xmx:z9FZab9EDax1vMgWQ64ipBT-NxEAnIQMstWQAvcIzb4ZYqzS03Th1w>
    <xmx:z9FZaSr-rb6DrEQFOD4cs_zdq6kYPf7L30_cIzKM-Rh0F2s7sIvWpw>
    <xmx:z9FZaYBqL0uyCUYcxiW7QsGM_Roku0LPaeYVjUI3rGXHL1CEot0qBw>
    <xmx:z9FZaU5eerUTv9CP7xeW5PMOHidgPKYtVcuihs5oglRKr7h_FONKe3As>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 3 Jan 2026 21:34:54 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  Paul
 Tarjan <paul@paultarjan.com>,  Paul Tarjan <github@paulisageek.com>
Subject: Re: [PATCH v3] t7800: fix racy "difftool --dir-diff syncs worktree"
 test
In-Reply-To: <pull.2149.v3.git.git.1767472809897.gitgitgadget@gmail.com> (Paul
	Tarjan via GitGitGadget's message of "Sat, 03 Jan 2026 20:40:09
	+0000")
References: <pull.2149.v2.git.git.1767292068036.gitgitgadget@gmail.com>
	<pull.2149.v3.git.git.1767472809897.gitgitgadget@gmail.com>
Date: Sun, 04 Jan 2026 11:34:53 +0900
Message-ID: <xmqqjyxyp0ky.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com> writes:

> On Windows, this is more likely to manifest because Git relies on
> inode changes as a fallback when other stat fields match, but Windows
> filesystems lack inodes.

"inode" -> "inode number" (or "ino" / "inum")?

I suspect the same issue would bite users on network file systems,
so while avoiding problematic scenarios in tests may improve the
pass rate of the tests, we may want to fix the underlying issue with
the difftool command for real in the longer term.

Regardless, will queue this updated patch.  Thanks.

