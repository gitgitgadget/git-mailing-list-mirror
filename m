Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65E01C8616
	for <git@vger.kernel.org>; Fri, 19 Dec 2025 13:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766151196; cv=none; b=fUPSxtYJ7P1jeXcrpch9kchml+/M4EgyFHphN8G79eDcFOU8V9ubC1JZHmWT9ETsqa0XmQDlUZ0HkM0OBKZAhwEhV1YuMTZ+a20tDEfTR46JQXKgEoqb8k7u/6Lzp9vNvXGQynltc4GIs+y1I0LjAAAWrCGtDd8XRzqrZwv8HNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766151196; c=relaxed/simple;
	bh=1xaf5CuegwhV9n4sruO0IkAp1FNtOxIRfFyw4G9XIkg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KDPD02Y83UiCsx7sOGARU18i25WVdBn4NnIAze6x2pUpIJEeorIdrPSKuVG23MxooESWfONPlYVTMWXZzTVkYTIdDWLNTg2KZzvbNmuUBQZSmmsVBJm8TCYauBGAT0hs8jz2cz7WDxp5JXQgOYf/P0oJxuo+/v7lF42NTn6jkhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UAEaUXJB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OcT2ir12; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UAEaUXJB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OcT2ir12"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BB7247A010E;
	Fri, 19 Dec 2025 08:33:12 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 19 Dec 2025 08:33:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1766151192; x=1766237592; bh=Tqf+wHu3QR
	Qsv071Pc+JdeDhu6VPyOJpOcVexZ/PDL4=; b=UAEaUXJBB0AvvSPY9eV7HDUyHO
	tQLmAJvuh2/d6INc8A9lcO08reUV61l9YXk8blr1Ye/eiReV1G07j7du7sv0B6S1
	T+6nsnwikwRGT9ScRp4A/lgCJ3ePwoPzzaJE+eXF/ybaajD7EwMCqGyTKG1ZkGAt
	6gL2ZK/+nsngq9fnu3ElNzm2e7LBtGhHeF6bNnLkzZVV4VSzrKlz8xKjWmZcM16E
	+tb8YhUmlX2FPJtFCNCxUtc1f4IMfqJZwtTFdHSnX6St3XR2PDXv74DdhYBe0ULx
	LTkSNK020FZy0fRqiYLP+nRR6P3ZWARwZOHoKRLBO5XhBAT+Bjl+3lLF4luw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766151192; x=1766237592; bh=Tqf+wHu3QRQsv071Pc+JdeDhu6VPyOJpOcV
	exZ/PDL4=; b=OcT2ir12283gp99xa7/JMNF/vAmHtufi6YUHsDOyV8AR/Z9oVl4
	MM4tPITYnPANOCWW/WfmUggmdq7MDWzj170/Y4XHQVYiiKDVAnWYpDVbJYF/8rEm
	frSWLY4Q4QewFvhZ9x/skT4efp7ibqKF/lNYC2glW5S6ZlTzVhwHqwcyQ3KcNvBB
	PGxPivF2bjMVnkT0ds97vXvcTjYuXfV9p51s1+lL/5PAupbUQhPn8ivWP1Ghy/mn
	X7DCZ8LIEbu0kX2jsGE2VI47nrWKZkPFVDU8Y6CV3xnSVupA9vs48ADrytC7dbor
	8WR3G+JnRrIG4X0db0PGlEuFaaJ7Ff1Ldkg==
X-ME-Sender: <xms:GFRFaW6NdDjkukkyyTebqFg52PovL6GE0v882GLXS7b7GUSEqmSIxQ>
    <xme:GFRFae8GghT-y05kFBk7NxUbOmyfr6QpDM0KIAU27PNrZomgCmF8635cI_3oV65hV
    UbaagFRp9UKuTgTy0xe9sUPGQkz2rk6JR9DHGGN-4RiceG6qBLaLA>
X-ME-Received: <xmr:GFRFabpreMeBkSbfxFwSeELyrIPku6OmYbHxaixDdNFqHyGdxy5PVrPmTS_Ncn15HpgUWCdPR15IndmsXja4c9878znuOC7DjA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegkeegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeettddtveffueeiieelffeftdeigfefkeevteevveeutdelhfdtudfgledtjeel
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhohh
    grnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhithhg
    ihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohho
    thhhphgrshhtvgdrnhgvthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepshgthhifrggssehlihhnuhigqdhmieekkhdr
    ohhrghdprhgtphhtthhopehophhohhhorhgvlhesrhgvughhrghtrdgtohhmpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:GFRFafoXcC--aYdRLf2cgzycyyJ2MjgD7q6zpMKl72FTrGOLUCgPYQ>
    <xmx:GFRFae1f-_Z7-3x08Fq41UQHZ_2OZYpdq2hw8W1HfcIx1kH47huqVw>
    <xmx:GFRFadHDataKE4FKGvOih_zOOzait04AmBW4lgg_O2UbRONjF6GJ3g>
    <xmx:GFRFaZF20nznCSNVGLY5vPNqscAv5a8N5tkMWf6wVjQKOCctprAeDQ>
    <xmx:GFRFaf0-mpWWh2iieTK2gLEb2ooiOtjiBTMlnwugz69v-6ri5sFBUFXp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Dec 2025 08:33:11 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  "brian m. carlson" <sandals@crustytoothpaste.net>,
  Phillip Wood <phillip.wood123@gmail.com>,  Andreas Schwab
 <schwab@linux-m68k.org>,  Ondrej Pohorelsky <opohorel@redhat.com>
Subject: Re: [PATCH v2 2/4] sideband: introduce an "escape hatch" to allow
 control characters
In-Reply-To: <9dd1aa88-badd-0cae-a2f7-21972548815c@gmx.de> (Johannes
	Schindelin's message of "Thu, 18 Dec 2025 18:59:48 +0100 (CET)")
References: <pull.1853.git.1736878772.gitgitgadget@gmail.com>
	<pull.1853.v2.git.1765981422.gitgitgadget@gmail.com>
	<2615abd8c5d5c55486cf5885c47e09e52fad61b8.1765981422.git.gitgitgadget@gmail.com>
	<xmqqy0n0y1ep.fsf@gitster.g>
	<9dd1aa88-badd-0cae-a2f7-21972548815c@gmx.de>
Date: Fri, 19 Dec 2025 22:33:10 +0900
Message-ID: <xmqqpl8avbop.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Good idea! What do you think about something like this?

It may be easier to hack up to piggyback on the http.*.variable
infrastructure, but I do not like the smell of it very much, because
the implementation ties it too tightly to the http transport; I
think this should live in one layer up (transport?).

> If this is the direction you're thinking, I'll polish it and integrate it
> into v3.

In other words, it would be more like sideband.allowEscapeSequences
that is overridden by sideband.<url>.allowEscapeSequences was what I
had in mind.  Or even transfer.allowEscapeSequencesInSideband that
is overridden by transfer.<url>.allowEscapeSequencesInSideband.

>>  - It may no longer matter but a remote repository that may send
>>    messages as strings encoded in ISO/IEC 2022 would need to set
>>    this, merely to make the messages human-readable.  There may be
>>    other reasons the trusted repositories want to send "escape
>>    sequences".
>
> If the remote side has no way to determine whether the client side is
> connected to a terminal or not (which we have already established in this
> thread), it has even less chance to determine which character encoding is
> in use...

Then I think you need to re-read brian's

  https://lore.kernel.org/git/aS-D5lD2Kk6BHNIl@fruit.crustytoothpaste.net/

In any case, I do not think ISO/IEC 2022 matters as much as it used
to back when the reencode_string_iconv() was written (which was the
topic of another thread regarding the broken iconv on macOS wrt
2022).  But even if we limit ourselves to UTF-8, brian's point that
applications do assume certain characteristics on its clients and
implements unportable stuff.  A project targetting developers and/or
users from certain locale may use their own hooks that assumes the
clients understands strings in certain language in certain encoding.

And to serve these projects better, classes like "pass colors",
"pass cursor movements", might help than just "pass everything" vs
"deny everything", but we probably want to try to keep it as simple
as possible; trying to make it finer grained with extra complexity
would only make our efforts look like whack-a-mole X-<.

>> It might even be a good idea to make the default setting of this
>> variable "allow", except for the initial connections to repositories
>> (i.e., "git clone $URL", and "git fetch/ls-remote $URL" with an
>> explicit $URL without using a nickname recorded in our .git/config),
>> as visiting a potentially malicious remote repository you are not
>> familiar with may not be uncommon, and users may deserve protection
>> over inconvenience.
>> 
>> But once the user establishes a working relationship with a remote
>> repository, would it be a lot more common to trust the contents
>> there than be on the lookout that the repository may spew bad
>> strings of bytes at your standard error stream, I have to wonder.

>   tl;dr remote servers don't get more trustworthy just by successfully
>   serving clones.

The "successfully serving clone" has nothing to do with the reason
why I suggested to deny by default in "clone" and anything that gets
$URL not remote nickname.  I am roughly equating the fact that the
user cloned *and* *then* continues to interact with the project that
is served from that remote repository (hence using the remote
nickname) with the willingness by the user to trust that particular
remote repository.
