Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865FF2417D3
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 23:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738885639; cv=none; b=I6CfpGjBhafNLHxa8RSdrDekWE8gidPP4tX8x27eNHSV8BSK2f4zLwCvDjr/RKKyf7WoISy0Zx9UD3+yj4+PeWjwaCUYCo33dlN6LlosxGR3NGiXfw4GXA/jfiMMhuaLNL0IXgjeSE3vJqBbiALSWKdsATzi7zmylmrxEZmI7YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738885639; c=relaxed/simple;
	bh=RS826BdJleeUaVSiFuwHsyqYextCNQvzVKdXueB2Mfk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V4AUWIYnmIPXULfhqp+6nmJ6d0aCIhbaO6ZorliWz8FUj2x+ReOGZ8w2nsAk9DRejfdvHsrj1kOHzD5k+eviUdDfqZocCKF5aUdwKI8+bMqZ1lltRFYdBpYXesp8Raa+7buU3YqKvY3N6zs+sxDtEDxsT2IqytDlIyDX44SwqQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fCW28WBl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZBC9N1pk; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fCW28WBl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZBC9N1pk"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 74A6811400C0;
	Thu,  6 Feb 2025 18:47:15 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Thu, 06 Feb 2025 18:47:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738885635; x=1738972035; bh=5+/wrt3Cws
	fRq2RZ4YLrZkhmJKPpw4rpsBc2EiGz5Mw=; b=fCW28WBlShKe//y/dVEcIdA7xe
	1KOC/wd9mnAnH1L+WFLmSc4D1BK0rtafeExDIxyhUq9q+VjYw3IvdjxgtOTTV31Y
	NWSRpjRzXYH+Q0q1EgPN6tHe2I1wYmC7YxzsjbButxxp+nNW63pV3NPjLFqUlOAO
	nfosxAe5O1rfPh/k0Mgj5si3Gf/k4LQ3Cv/0VoEZPGNh9rbxZa+vwN9XLQTCIAPf
	Yd1+7jeDviyEUrhGt+AQcax45K0MNI3SGd+zptiQyXjUb7bSVICjPP031ZJVnIRE
	X8HGbGpCB8124mefFAR6ksTZ2+y7Slh49jUbSsg/joS4YR83HoY1/DTvfh4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738885635; x=1738972035; bh=5+/wrt3CwsfRq2RZ4YLrZkhmJKPpw4rpsBc
	2EiGz5Mw=; b=ZBC9N1pkrudUXDdyLTc3bZmE1xEM1IYm2nWT2U2Z++HJnp26sUM
	VS8p8ajKuvdrgSvnHPSHrB4T8gzLsA9ZxdMXqtzclnnbj+XZZR7Rc2VDY3Xx+rc6
	DiTYiZbG4DD7sQVERwBh8f5o6e2UxbbQ+Ch7VFSATfqMTH4JFvifKcQe7pF3jWDT
	+e9+qQm2CB3/sItkec9JAjMMnIvWeAEqYJVMBF3JyW7RODzsqAH34K25VHFBy72v
	quoPUNocK2OeyKOmRpyB9K5ZnYwfxZGbOzKVzfe0Ss9BpwN2uY+HpDNqxsHG/ZCf
	Rf5TKv6R50UnX9z5ysUkuA1F8vSnOzyLlPA==
X-ME-Sender: <xms:A0qlZ4hg_6E8w6jZd_upCKi7aMr1DK7E1Ur__DEWveSQlWeuZmi7Og>
    <xme:A0qlZxBmzJ_IIvFH1CvwXWkj1yqBAFJO4NgFu11gKwwuaGno_FRo6jgkmJyt28S5n
    2Zu_-W8K2OaFiZtQQ>
X-ME-Received: <xmr:A0qlZwEt2psVRIZ2YDk2vi-rwWUbELtEq2yinFwUAPvtH-bDXRkOahclWuFXLYXEZyiE8QrURiDi7C578xmWpcoohlc19tjFurjQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjeejgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmihhrthhhrdhhih
    gtkhhfohhrugesghhmrghilhdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhu
    shhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:A0qlZ5R7IwATliK5KBEg0aM-DjCaaR5NIapyjxqCGgBehpXOB62e-g>
    <xmx:A0qlZ1xa1nA-IMOvj9Gf1Bk4dbJ4QrwUTst5GQJoBSaSISMW33lR2w>
    <xmx:A0qlZ369KTYO-1PlL591YIJMJxGDo68PwJsqxqBXRhUi11ucrMY9AA>
    <xmx:A0qlZyx0yvZd7wgV-nllriR_jnLYWI_vhCcCECXdsszTsjpoTj5hXg>
    <xmx:A0qlZ3vcjQEA-lQgs3Q3jWyeBCpoc5knLYP1G2e4BTAo0SDY5uFndXDe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Feb 2025 18:47:14 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: M Hickford <mirth.hickford@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  git@vger.kernel.org
Subject: Re: [PATCH 4/5] doc: use .adoc extension for AsciiDoc files
In-Reply-To: <xmqqo6zeixnk.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	06 Feb 2025 13:14:07 -0800")
References: <20250120015603.1980991-1-sandals@crustytoothpaste.net>
	<20250120015603.1980991-5-sandals@crustytoothpaste.net>
	<CAGJzqsnFNfK6DEcbRQsUB4S8qVBnQ2PcJBgbvCPYLd-xAVVQBA@mail.gmail.com>
	<xmqqo6zeixnk.fsf@gitster.g>
Date: Thu, 06 Feb 2025 15:47:13 -0800
Message-ID: <xmqqh656hbzy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

>> Hi Brian. How about also renaming SubmittingPatches to
>> SubmittingPatches.adoc? This is AsciiDoc according to 049e64aa50
>> (Documentation: convert SubmittingPatches to AsciiDoc, 2017-11-12).
>
> Do we pass SubmittingPatches (and CodingGuidelines for that matter)
> through AsciiDoc?  They do not even have .txt suffix, so I suspect
> it is not.
>
> I would prefer to see the general rule to be to rename s/txt/adoc/
> ONLY for files that we actually use AsciiDoc to convert to HTML or
> manpages, and leave other sleeping dogs unmolested.

The above is for ultra short-term.

Once the main part of the documentation changes to .adoc graduates
to 'master', I do not mind another topic that updates those without
the .txt suffix to learn to be formatted with AsciiDoc.  And as a
part of such an effort, such files will gain the .adoc suffix since
that is how the Makefile finds which files to format with AsciiDoc.

We might decide not to format them with AsciiDoc simply because we
have nowhere to _install_ them, though.  Even in such a case, we may
still want to give them the .adoc suffix, just to help editors.

Thanks.
