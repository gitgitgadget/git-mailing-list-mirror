Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228B91AE003
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 18:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738952954; cv=none; b=f1KTqUsjZtgy7CRPGsXPWV/zKr5toC4+t7CHAwiQpOoceVL/+u7NqpaNbldJbtANUfvHQ4so7R0+CKmnnLj5tnBnMYAcV5yO81lrKYCcKZ9bCzxSrbp+IUMeTozTMe5W60QNvZslDx21+Y3naZcXsKlZlIGDFJTmcg/Vckt/d9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738952954; c=relaxed/simple;
	bh=42mjlQc61V/HInSLCjqqNhH6ZOKj9YZjrJPDMVYdzPc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g8rq5l96nSL2tIJ+hy1eKCKsSTZ7HqDRtV0lj2XvJ/DifGI97x9+K+RGJZWqv6sfX9p46aixG7eScCufZfIpNNkKmXTvJHV1ZyCTssVr6rcz0AiXJV8fWuGCZAgsrJS0LPjzFy3cvaV3oIC5ZspVutkPR5l/AAr/m5k7RT5t2BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IPC+vHu7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PQvDQMef; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IPC+vHu7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PQvDQMef"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 089871140135;
	Fri,  7 Feb 2025 13:29:11 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Fri, 07 Feb 2025 13:29:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738952951; x=1739039351; bh=+ZfYpFsxx9
	K171GBhgEIN+OZY8L84d/R5pbhZ1poT5E=; b=IPC+vHu7pHHZkk9VmxH+Ntu5Bj
	iJGlSzGgEFd8Q4pM30gXIvWE0KN7ZucJOR5Zexrm9gS4Lj/FworZ14Ncy47AfAnl
	pr6wgYFYsQK+tB6DgSxF7LYaf0fG7oAzTOPd8xDB9ZrZsHsxt7GbgWsxldj34l05
	JQOtBbZU+1Fw2X+MruPEkSi/KASesUAei8C30jGYSV7QpoJYISSq6+7abLuNltDR
	6r+8YYBRACyptm6E9NKn+ZxSKG/k9iW76L64kkEJWfhHsqiYBbg/2N5eyECORQXk
	G5+0wmmdb/3Vuaa1UaDKFxUetjDB2hrhj/1Jx8Hs5ELTTuACvVhUOd0xp4zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738952951; x=1739039351; bh=+ZfYpFsxx9K171GBhgEIN+OZY8L84d/R5pb
	hZ1poT5E=; b=PQvDQMefShoDjDeEJ8U8QLxPgv4qTV8RNXnOfzAccWrDv0G1sRD
	u9kZ88Vun7aHOAMwLXbWs8I3aLBM9jWVqo6JWDoksLI0jzmRdq2U/cRgstNqQdtF
	hv96D0inbubo54dikPzE741CIKA1aqs2pbOQjfly6lUMwxVkneLb/zndoQo7krmh
	c6gqPgoxuJMzn4PRKDDlLm/YeG6sG3GDGWiDB4m+ye1qKvyuYtW+BcsTPiUtyNrm
	zlsGoQWIx0sjVn6UDjHmn1SFV2kFcUVTCxMXsKSIse1eDLOCdW1uDZK6WtwxwaY0
	hhmV5flQ1ra9LuuQFLIUv4WYQ83Ka94UKSw==
X-ME-Sender: <xms:9lCmZzmYKQq3ZiXe_Rpce6WK_v9-F0ReIQneZ_f6lAng9zwfKRbssA>
    <xme:9lCmZ20i-7xhT9sbZ2YNdVc6tzZbdNJ64FQdmDBqxkiLz3wZQJ-t5WzzubdS9FmpU
    0g3k1igcRGZuv3P-g>
X-ME-Received: <xmr:9lCmZ5rut1F6ku4L8p0cpYAM0S_WYua5bL1Wnfk_wj03dlnxYdTv1ItgUWovzQxjUhpsUPB2qntHeI6l-El3K1l337O4HMT5X0OY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvghnrdhknhhosg
    hlvgesghhmrghilhdrtghomhdprhgtphhtthhopehmihhrthhhrdhhihgtkhhfohhruges
    ghhmrghilhdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhoth
    hhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:9lCmZ7lfitK2laHquBTUNfO_pmv-CZzMiRNyQNS2pGIADvHzzrLSQg>
    <xmx:9lCmZx28ut829R4wQNK15WPGpI6ZMHcyo9yd3yNQucEREeUgFJTiRA>
    <xmx:9lCmZ6vCJhnBswePY8UEAtRnsI5aKkcV5hAcUekC-v483f0qwYq43Q>
    <xmx:9lCmZ1UWqLoxiTtZNFwhjVAU7TEQFRex6X61QjeD0bNiz0EyIH2jdw>
    <xmx:91CmZ58TUhwcKtL_xwRYsSgrHTCqbZ07JqdjUtnMdSR8xQ6nRePX1EZ8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Feb 2025 13:29:10 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: M Hickford <mirth.hickford@gmail.com>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  git@vger.kernel.org
Subject: Re: [PATCH 4/5] doc: use .adoc extension for AsciiDoc files
In-Reply-To: <xmqqtt95fx62.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	07 Feb 2025 10:05:09 -0800")
References: <20250120015603.1980991-1-sandals@crustytoothpaste.net>
	<20250120015603.1980991-5-sandals@crustytoothpaste.net>
	<CAGJzqsnFNfK6DEcbRQsUB4S8qVBnQ2PcJBgbvCPYLd-xAVVQBA@mail.gmail.com>
	<xmqqo6zeixnk.fsf@gitster.g>
	<CALnO6CAa+6xx885TdKFrpruxHbN80S3RE=STaswnaUz_3QZQ=Q@mail.gmail.com>
	<xmqqtt95fx62.fsf@gitster.g>
Date: Fri, 07 Feb 2025 10:29:08 -0800
Message-ID: <xmqqh655fw23.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> "D. Ben Knoble" <ben.knoble@gmail.com> writes:
>
>>> Do we pass SubmittingPatches (and CodingGuidelines for that matter)
>>> through AsciiDoc?  They do not even have .txt suffix, so I suspect
>>> it is not.
>>
>> I don't know how (I didn't dig), but we do build and package
>> HTML-ified SubmittingPatches as both $(git
>> --html-path)/SubmittingPatches.{html,txt}. I don't see a build output
>
> I was wondering why we remove SubmittingPatches.txt with "make
> clean" there the other day.  There is a Documentation/Makefile
> target to create %.txt from % applied for SubmittingPatches.

Interesting.  I very much am sympathetic to the original reasoning
why Documentation/Makefile is set up this way at 049e64aa
(Documentation: convert SubmittingPatches to AsciiDoc, 2017-11-12).

Here is what its commit log message says:

    Since the makefile needs a .txt extension in order to build with the
    rest of the documentation, simply copy the file.  Ignore the temporary
    file so it doesn't get checked in accidentally, and remove it as part of
    the clean process.  Do this instead of renaming the file so that people
    who have already linked to the documentation (who we're trying to help)
    don't find their links broken.  Avoid symlinking since Windows will not
    like that.

One could argue that we made a lot more damage when we renamed all
the .txt files to .adoc to external links people have had forever,
but I guess SubmittingPatches is more special than say git-add.txt
or git.txt for that matter, as the latter class have preformatted
".html" copies people would link to rather than the original ".txt".

Before the "let's avoid renaming and instead copy to a temporary
.txt file to run AsciiDoc on it" commit, it seems that we kept the
file in our source tree without copying anywhere else?  It is very
much understandable as the target audiences are those who want to
work on our code, so it is a fair assumption that they have local
copies at hand, without others having to give them public URLs to
read on the Web.

"CodingGuidelines" is still treated that way, which is probably what
we want to fix, by exposing it on the Web.  I'd imagine that it is
sufficient to just rename it to "CodingGuidelines.adoc" without
worrying about those who "have already linked to the documentation",
but others may feel differently.  And if we do decide to rename it,
we may want to rethink what we do to "SubmittingPatches" as well.

We've had ".html" versions of the document out there for very long,
so hopefully people would already have updated their links to point
them, not the one without any suffix, in which case we can stop
special casing "SubmittingPatches".

Thanks.





