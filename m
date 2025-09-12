Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF4C1DFD8F
	for <git@vger.kernel.org>; Fri, 12 Sep 2025 21:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757711979; cv=none; b=M0JZQtTFPVNQB9SZRwovudxB+ew6P7llQlCSuDpeVyReIudes5ukV2MrDrosqcAV37OHEr8lvlneYUM2ID0YuSa2hIEMZhcf7DajuBYSBrYlieTYlWEiC8/VhwWZW/SbENwIXmg3VfiVa+tAvU5401Po8DlSjbh4gKc1cv9Ad+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757711979; c=relaxed/simple;
	bh=J4UmqX/r3REF9pElP51UnvN4r02RU2IQv524KVL1TkU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eXNaoNjbpGh2jId6bnw+H8F5u5PcGcUIpt4+oaO+zpQDNH0zcmozNHX78lzVgZ+JnLx+2SBITgHUcJewKFutSRBfu67kq7grwJJZyivp+ZsGKlQIjKpJ6HO/VnKUaDADHdzPW3+a8fTCpzOEzIf5u2GsOpb7NdSopT/PuiIqbiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ngwQ2zv4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SW4H684r; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ngwQ2zv4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SW4H684r"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8CCAA14001F5;
	Fri, 12 Sep 2025 17:19:37 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 12 Sep 2025 17:19:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757711977; x=1757798377; bh=+8W4ulRIKW
	VmZOUCTDLnQrDmIKvK/EpkfLyp1SsiSEQ=; b=ngwQ2zv4Us5zhG5VYC/TNahg+x
	yFTUcqUs/5Ct/HtLieZrJzdpJFo576HIGVxmLUn18HnaCOyDGr9I8bNnUhxVmSnD
	mqjub8qN14ZDsEaH0b2KCTmkYtCYk3GWE1vT7EQ8AjYAkXMofdDRujfH3fSGly2Z
	mBLwVc2EHBNQdjpVd3Lg704VgOGv3immgimsJh/5vhNb6QuMni1d4G4/ERMEWdtt
	k5v4H0dtK5jntIuUOxB1HRzg2BGAtBMJtlZ8zaQ8dS1UaRs+Sek/yPoLJ5HB6mRH
	vzhg5s6ebm7Q+uLbBtjCBPwVDkltIra4dgon+Tt8+05vwQbtCbIcXuYNgvMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757711977; x=1757798377; bh=+8W4ulRIKWVmZOUCTDLnQrDmIKvK/EpkfLy
	p1SsiSEQ=; b=SW4H684rJDBdNc4npCimC24gwTnDPSTODnvzy8nn3qWtG97loC6
	A+QMztoNk/+2zA/at1Yorkj8CKSv2v/UbiHuCzH25dzfxk7XmEZWlVWaQfwfWipR
	daJhed9Cwy0mth7VHdyhB6HwUPhTStg8BIvoPG3bG1/JHUe92CsKegVD0R4vfZhY
	DUUq9Lm3cjyyfO0Vy0eoS/o/5qu7KY8bBr24TVlhU/RFuL9so9aKTGh8E0UowI5g
	DcajSWY0+2QOeLuz5pj8dnk3GO0A2J9nTmAsvNKvyxhIYKbRyxbCTXnuV80htdF6
	1Sg7+1/fjd4wZPgd2u5SggsTZMpNUEuSkQw==
X-ME-Sender: <xms:aY7EaCrs84tDcrBaVqDRDvMutW0O-GHGdsQFk6dYSXxVVuK-O4ShFA>
    <xme:aY7EaJGkhCiB4_5Um_Ba-esX6NWsFanihCnaEDJKG1jinwDHScHQHvSUftaqlzXp5
    FF-0orqGc5Bd-OT7Q>
X-ME-Received: <xmr:aY7EaHrH7cMywbUH6UrYQrl85ge3KXce8ZPs_-PZPTLQiQjDT40cv-a2-BcdY3OkxzQBHrREII4o8cVFcH6h9oGjzuRC45uZV8sCE3c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeftdduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    sggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofh
    hfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepjhhu
    lhhirgesjhhvnhhsrdgtrgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:aY7EaCZaYyQhHrUCxAFIREq45-NHPb7FLzK35NFDvfNTdCmOqAl2YA>
    <xmx:aY7EaAWlg1-gWoCVp6iyY7xq0ZdOR6GEjdF-kOPv0zlfALwRPP7mUQ>
    <xmx:aY7EaL839HWuL1I42kppkFrWn4JL3p4iBODfQxlE12nXu8XFwhooWQ>
    <xmx:aY7EaJ9a86dSAvkp7izSw8JupgYv2ISD3_XmYal3pwb449UPKzY5hw>
    <xmx:aY7EaDay5ynOCdT6g2ft75D9YeqxusasX5LcOSeLqjCvlAiIHALeMSVA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Sep 2025 17:19:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Julia Evans
 <julia@jvns.ca>
Subject: Re: [PATCH v2 3/4] doc: git-push: clarify "where to push"
In-Reply-To: <374740c678a62edd5cb5bace7517a36ce7ac00b5.1757703309.git.gitgitgadget@gmail.com>
	(Julia Evans via GitGitGadget's message of "Fri, 12 Sep 2025 18:55:08
	+0000")
References: <pull.1964.git.1756240823.gitgitgadget@gmail.com>
	<pull.1964.v2.git.1757703309.gitgitgadget@gmail.com>
	<374740c678a62edd5cb5bace7517a36ce7ac00b5.1757703309.git.gitgitgadget@gmail.com>
Date: Fri, 12 Sep 2025 14:19:35 -0700
Message-ID: <xmqq1pobl66w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Julia Evans <julia@jvns.ca>
>
> Be clearer about what we're describing ("which repository" instead of
> "what to push"), and start with a positive "try X, then Y, then Z"

I forgot to say, even though I did spot:

    "what to push" -> "where to push"

"what to push" is the topic of the next patch.
