Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEEC26F473
	for <git@vger.kernel.org>; Tue, 20 May 2025 19:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747768488; cv=none; b=LA7+2B7EYuZYHIQAkmlymV+oBhyoqaeIkfk7bUWoLbbH8Hml8L0IukPdhMRXtvYy/TJwWLZyHM1iSTvFb5eceTI9jffCrXR6iSbAGtbMkQvU2wikeQud2H1dFMd/iQ6WjQzwAz8E1A+D8aAd1YKU8Y2VSBLpol5FPO95TET79zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747768488; c=relaxed/simple;
	bh=2ODqEgO4qgO5q/78KO1qX1npgLLOa2DQLoRVOoa+RWc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Dlbv8AXblfOP887DhfEI2wqg+HDtk1bC/jC+HIykcjQ63svBbzxZ5mGVVkLgJWNVpuA4V59b77DY/GDEdHjY293cfWX3OPwJs2UtlGeVZmeucw0P+rlcrkD5vT7/mQgzoUcOCDXNxNz8NXqlfAB70aHLG6IRDDV/+xbJrBHlLLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FG+mpRS8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f+rtZWa3; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FG+mpRS8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f+rtZWa3"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8F27A25400AC;
	Tue, 20 May 2025 15:14:45 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 20 May 2025 15:14:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747768485; x=1747854885; bh=LGg+WpYvBx
	3AIk8Aq/dD6xTJllirH3CCzenmRfo+ijY=; b=FG+mpRS8QdRgsxccZmRcfxYZND
	QPYov04WtyFZuRdTB5Q+B+8RlWm/3INyYrWB8eSR2S6B696Mj8EhW9bW4+xOCcFd
	24KiFoYLmku02khaItkDEc6dhl/joOOR4gTW5Gy34+6YqBBjJrk+Ez5ZXHh4rh9M
	Tctlzul50CQ+IJDiV/2nvRSJEucuD9pHbiwaGBhhoEimPcUzrwFJMc7MDO0KIfdE
	SxMoO/fdghzCCtOeYcE6upOHY+9byMgg3quaFOxsx6Lf/yyZGdnZUuJMZdwJBGp0
	I2Qffz0n/uzLzvQ462/EYtkDisRno3ykpfS/cx/L7yFBY/3W1KSo6gt1tcQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747768485; x=1747854885; bh=LGg+WpYvBx3AIk8Aq/dD6xTJllirH3CCzen
	mRfo+ijY=; b=f+rtZWa3N29w5Yx7BeYwiKyH6d1CVUkVUtdI4mjAtYC7tfmxVBd
	e9+cTfQyIUsTsAXWRf9Xy/jVXOdYPnT6dCLNMWFZ7NLoyWbUEkL1Y2tie4nnug39
	2Dks7L1wr6E3OM91eQ2TuN8HVtRElKLNhBQrJxaYsXajufZPC+BxRug5Imq7lnfu
	1hPH+78QI/1UeXrHVi+Yz/ewDB9LDNOPbnSkBOuNvl5ghgUjnQUu9AHGA9zdW9xi
	0xkUC0i9OIU6otPILX2ic1pfGk7CP91QjaLMOZC+fUugzNys6fY51kYWruCd2vzU
	x/d1R+UMVGCO+OnLQMUDTtzP6XvHW680rcw==
X-ME-Sender: <xms:pdQsaNRaOMbmb8uPdjZ1orFCXgimtM1pjg1zK9hEEvdbMAo1rx1iVg>
    <xme:pdQsaGxA_-IwJ0In-AJ7OLW9r-BxZ6yc-tHQ_AtfJCXUGd3FBcvBhVcwBr6o8aWIf
    KrrefwiMyuMXp7tIQ>
X-ME-Received: <xmr:pdQsaC3Of_3eHjh0ppuuaB7_w9RKbS0Su34P9qIX5IwJlD69_teO7XFKNFyrfm7TwxCuz6u_N4LmhYjO38RoGspamDv3jVawZobJ4y8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddutddvucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefl
    uhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffg
    fedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmh
    gvpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopeguhihrohhn
    vghtvghnghesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:pdQsaFCjBh_TN90nZcmoE3ekGY25O3cJOVkv7Q5u_dY7iCpbG0IiNA>
    <xmx:pdQsaGgtkVY3xb8YhIZzBLqBMa_syNTxw-a3mL7AOaGKpXtIxn39nw>
    <xmx:pdQsaJphYtclnkRBCukijYgbd-sBgPpdVjRUzLCf284rxFUVj7z-dg>
    <xmx:pdQsaBh8KRFdNQ2lCTdGzR47pRRj5oA9AvtOi7H4qoWt4-Njgg4GpQ>
    <xmx:pdQsaBG1cs3IrMLCApwJ9NTb6AxzBWyNTMT31Pk8yyzJeh4Niev6daPy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 May 2025 15:14:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,  Jeff
 King <peff@peff.net>,  Teng Long <dyroneteng@gmail.com>
Subject: Re: [PATCH 4/6] doc: notes: mention comment character configuration
In-Reply-To: <f3f54a3537f71d8d4e3755d93ce58cf6472a2b7a.1747763769.git.code@khaugsbakk.name>
	(kristofferhaugsbakk@fastmail.com's message of "Tue, 20 May 2025
	19:57:22 +0200")
References: <cover.1747763769.git.code@khaugsbakk.name>
	<f3f54a3537f71d8d4e3755d93ce58cf6472a2b7a.1747763769.git.code@khaugsbakk.name>
Date: Tue, 20 May 2025 12:14:43 -0700
Message-ID: <xmqqbjrnhz6k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

kristofferhaugsbakk@fastmail.com writes:

> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
>  Documentation/git-notes.adoc | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-notes.adoc b/Documentation/git-notes.adoc
> index 8706b33f2ee..1b714eb9e81 100644
> --- a/Documentation/git-notes.adoc
> +++ b/Documentation/git-notes.adoc
> @@ -186,9 +186,12 @@ OPTIONS
>  `--no-stripspace`::
>  	Strip leading and trailing whitespace from the note message.
>  	Also strip out empty lines other than a single line between
> -	paragraphs. Lines starting with `#` will be stripped out
> +	paragraphs. Lines starting with the comment character
> +	(default `#`) will be stripped out
>  	in non-editor cases like `-m`, `-F` and `-C`, but not in
>  	editor case like `git notes edit`, `-c`, etc.
> ++
> +See `core.commentChar` in linkgit:git-config[1].
>  
>  `--ref <ref>`::
>  	Manipulate the notes tree in _<ref>_.  This overrides

The above is more like [1/6] I commented on, rather than [2/6], so
the same comment "why is it suggested that I go read about that
variable?" applies.  Perhaps

    ... starting with the comment character (the `core.commentChar`
    configuration variable, if set, otherwise `#`) will be ...

or something?  I dunno.

