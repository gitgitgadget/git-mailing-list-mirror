Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F211C2FB
	for <git@vger.kernel.org>; Sun,  3 Nov 2024 02:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730601289; cv=none; b=SfsvnuGS/8NL7Bl4ciCSn1GVsmc/xd/yVqYYRIko5BC3HvjC5gUci+Facbrbpl8hpgPYA/sTsFxRRf+b+Mhm4lIP8h9eddQfxJVQTDfOMAWaMg68MDFKL1cdgzI/rkaaM5kwimRb+07v6FJA6As8Um5UwSXK5UXMg5UO4WxFr74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730601289; c=relaxed/simple;
	bh=9U7TnBvHuNLjtW9SBFpJOaGChGh3J5PlgZzR5VFAcZI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Lw24mBHByY8L7T81XBlqx7RpsltBTTTk6ZUJcuvQadqbH0SqWHNav5mm4N8t+xvcB5B2kHQXaAJusBPttzpYhLrr4nW+W7FzfyELGqQJMER2k4H5Gt+NLQ1ZAlkhJKwX7IaY87tVDQXUIdNu3sHTWAihYCbKWyou32rSpw7SVz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=F5SSC9UK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=epyR7tG5; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="F5SSC9UK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="epyR7tG5"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0B192114014E;
	Sat,  2 Nov 2024 22:34:45 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Sat, 02 Nov 2024 22:34:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1730601285;
	 x=1730687685; bh=rGD+v+xrioANuZI8RurXey20pcdXz3Yyw3wJ8A4l+Z0=; b=
	F5SSC9UKHBU3w5Q5sWL1p0s3f8Y9WzKpdvudPTOsqrHhT25u7bTK/ankA6KTnO7Q
	NT5fzGrbhHL/9K099J4/8qSAunGY3OI5Rdzb0AVRhfHMKz7+v1DLjlri+5Wtob01
	U4Ch9OMyRideLL/p4pgNc3+2F+a4ZQkKrQsA+7xk+HH3TSSks82jtyrmm/XRPD58
	v7j+6BV8AvKaH4Pm+EElV3vJPtqsFHAFx2gX9M1hh1siJljoaXx9ZAr8viR2/txc
	3HOElcx0eDreGX9ytpD80TgRIaBoxXIqEasDi/V+UC35unE2ORbJQ/h7aO03Yskv
	3/Ugckkatee3FQaWwVRUPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730601285; x=
	1730687685; bh=rGD+v+xrioANuZI8RurXey20pcdXz3Yyw3wJ8A4l+Z0=; b=e
	pyR7tG574hXLukAY0mzZwORo71maeMS2pvniEoWiWZljFstif3eQm+pQ5z08wtyI
	HhBIVVS0p/dfKqwNPQUWZI+VqiTtqP/5wAiQ90JQGQTt0TITgOsl6XlZUIkTiiHV
	V4ACSU5cDOddEvnjW5AcyHGsqM5+cPpbGozIjrn25wnseQPuFY2EKSQqDzvXgOfX
	hczRMh3KkI2SgfVa9N0hy/X0xyxf81v17sPNmcaS0FCd8CeiIoAmfpJqZiRO7Lr7
	CqqgNP4OKYSOlj1C13TryPbL3jL8+Xs1UY3YubJIXLV83eQs7ODwF/EAezby87ck
	IpL5JgvqTzlu51Q3HsPtw==
X-ME-Sender: <xms:ROEmZ_cBKi7aPZPSg8JzmDnN64lSW1_k_-j0H5QDhLL-zHzFEJRjdw>
    <xme:ROEmZ1PcUK-iY7fkApgkZWJxpKSp-e5LS0NVENvrh1Xufly8lGJYtKAE9tzP1Wn4p
    Et8a1pT2EiMrzxk-A>
X-ME-Received: <xmr:ROEmZ4i5RFkolV2qKX-4mn_f3i-3vBLx-2ursE-gPZpvIGXFz1Zp_6WYtpU7ZyYTX6iODuXcus8aAs_E16TgzU8-mkr2osyQh4nu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdelvddggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddtreej
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeef
    heeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrghrtgdrshhtvg
    hphhgrnhelieeshhhothhmrghilhdruggvpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ROEmZw-bNv_qiRKOGsA0Ymq2A3TBtiBd79m9rjIsr13lE_ECFl4xZw>
    <xmx:ROEmZ7tDp-ndY_ONUmxvOecNqx3wm-bQH6xEbqTHzw-d_v6KPMG0tg>
    <xmx:ROEmZ_F0XN7BX6y39jHMGfNbhogKL2HYvm5WN3KVhLEhBkbBiu4V3Q>
    <xmx:ROEmZyPiN_1z7EqJeqUplVOEnAmk-rNC10zTGbeLekKUuFEtYVh-hw>
    <xmx:ReEmZ7InCpLEF8t6xYIgtpSf8iiZibM_LtqlkItFmhH0fQJr1GvPSX_M>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 2 Nov 2024 22:34:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Marco Stephan <marc.stephan96@hotmail.de>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git revert cannot be aborted if the repository directory has
 been copied
In-Reply-To: <AM0PR02MB4980D186BDC087336C760132E6502@AM0PR02MB4980.eurprd02.prod.outlook.com>
	(Marco Stephan's message of "Sun, 3 Nov 2024 01:25:12 +0000")
References: <AM0PR02MB4980D186BDC087336C760132E6502@AM0PR02MB4980.eurprd02.prod.outlook.com>
Date: Sat, 02 Nov 2024 19:34:43 -0700
Message-ID: <xmqqo72xxcxo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Marco Stephan <marc.stephan96@hotmail.de> writes:

> If you copy a Git repository directory to another path while there is a revert in progress for the Git repository, "git revert --abort" does not work anymore for the copied repository. Instead, it will report an error of the following format:
>       error: Entry '...' not uptodate. Cannot merge.
>       fatal: Could not reset index file to revision '...'.

I wonder if

    $ git update-index --refresh

is all it takes.  The symptom, i.e. Git declares that an otherwise
unmodifed path is not uptodate, is not limited to "revert" or
aborting it, but is a common thing a newbie sees after copyihg a
working tree to elsewhere, and "refresh the index" is an often given
recovery procedure for such a situation.

I'll not comment if this is a bug or not, and let others argue.

