Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B8E3E3C73
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 22:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774909677; cv=none; b=C1Afd3T3fN/zKVWCqFmgpGWq1l17aS4b7TFanmv+tfADHlK2nYs2tUmeDiWT+SihgyCQh1yTmm2lK9fiJBVBP6AaplUrVfq7Vpp0ZHpEYzX/rj99D0xPPXOOo30h7HGJBI8Nu7+MjcB5uKpnpGr1HDR6FSDW4ziAVa45ZZ/BqgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774909677; c=relaxed/simple;
	bh=e+roaEr9Z3XyeGUUX2CgGRP7pGQobL1U+foN2zKe+OU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZFXDjH04tu2LoYD/Fkm7gC3lLnYKC/7Q+ulBf1na1WzMekExOltw24f2BeyYaSOPxY2SNVuq81mfamMNqdIRnuSh6/ltmQT2xz/EHMxtfyE0mHPMfjq0dNzH42tbvx6JjRd2jfODHiLtz0xKhkpOkojIzwLzi4CQp9ew2/nXp7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=P6fDzZwl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ACcK0snv; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="P6fDzZwl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ACcK0snv"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 2C0A7EC0251;
	Mon, 30 Mar 2026 18:27:46 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 30 Mar 2026 18:27:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774909666;
	 x=1774996066; bh=9B1vs8fFRvyQ7VHDUgV3wWuaLhVMWBYp2fvbege0pRY=; b=
	P6fDzZwlLwnIUmV9Nnar4jvJnkQnQTeV+1+9By7po3TnBDOBtqfHt1lBf2elU8N+
	g+rar1A4pc+JsY6m09Pv1FJoBcrdPFkcIzGvIckpeMdxz5AvPRVnk3K32qOh1I7k
	y0vHYhL+2BhxlQ8p1c1adZRusQAi4PF3uK1VQ343eNndVfNANrxk45hOhGT+i2Gg
	Xh1ID/BRmVqXxtkiumYw7XWqWvGbJxw/vxDYJGURwUXA+4i9DRUkTGI3WfkIamqw
	9xwVK6CIgecguz1WNweP1GiUu3yKG4ewSImHEsLbKaI/ENBXFTIMKo7vp4SEw2q4
	UCShcy9XKRUKOY92P8SiIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774909666; x=
	1774996066; bh=9B1vs8fFRvyQ7VHDUgV3wWuaLhVMWBYp2fvbege0pRY=; b=A
	CcK0snvppaCaDcbmvg8mRn3fHvGcYHkmf+jRK4wyH8DFQxqAKLP6KkbcFUWYn0kl
	3GYKQGYGV06tmEzD0UN04tkXnBwLLCl8pz8BdleXKHQA+2kDjYv54sNYcEZsK8q8
	lRFKpKEZY9X4+VHTVxHK3AzHHJchpvOKrOvfKZAoLrt3EmhcHxwWpEmsJSzZ/vZr
	B5DZKWGqmcl7avUbsLGA35GYCP2OL/8KZvorKt2nSkjZhmhWC/CBd22a9dBLVhjs
	zeuOMXH6TnXCR8WSi9byWhrcO5UjvZ/1sKlMVKwH/tds+u2s4+qM+Y7gmlfX/PD/
	wf3N1uGyDNeNSSRHEmQug==
X-ME-Sender: <xms:4vjKadM-n4pkTX-_AmtHwLM1TE5v5I08kzWdKXnd46PDk2DavYNzCA>
    <xme:4vjKaSNWkfvKu2IGBuYPo5plohQ8P9gnIav5RY2NpJfbDC7qA2NtUOs2SWmndhMxB
    fNAKNpWqL2uWPSqI9GnR07CY60jy9o_w-uXztYCUWKunkr0k2SKjQ>
X-ME-Received: <xmr:4vjKaej6zF0bKtgfeq4H4dSAbS2DnoJlFqcBHkFKd8_BR8h2ZqPMXxb_N5qHrGVHSpEVvPM2vv0D0wpZJobaGCXOSOd8xuewZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefgedtudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhkse
    hfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtg
    hpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepjhgrtghkmhgrnhgssehgohhoghhlvgdrtghomhdprhgtphhtthhopehlihhnuh
    hssehutghlrgdrvgguuhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:4vjKafuyQiYfuGrpivuI1VadCT0s5ZS3rzWAVrBrhkMJZCJsvIDEaQ>
    <xmx:4vjKaUSLTChwGdgkWdTM1eEqkkoBoWQ6f5sjh_b9ZfU027yabkJDsg>
    <xmx:4vjKab3Ds5qxCOGa6cTmDgaPKdDTB9Dr_osH-D2J3dC5wacLg7G5OA>
    <xmx:4vjKaRuBfCwqANfG8EXwzQCaHZ6lPeEYOQ9etM7RpCwXsEHskXa1lQ>
    <xmx:4vjKadbOc9MeC2sWVaN5d62AF-Owz-HJwldKnR87SnNKqgN9xvoxbOwL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Mar 2026 18:27:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  christian.couder@gmail.com,  jackmanb@google.com,  Linus Arver
 <linus@ucla.edu>
Subject: Re: [PATCH 1/2] doc: interpret-trailers: stop fixating on RFC 822
In-Reply-To: <doc_int-tr_key_format.534@msgid.xyz>
	(kristofferhaugsbakk@fastmail.com's message of "Mon, 30 Mar 2026
	23:11:32 +0200")
References: <CA+i-1C1DM0CHoFJ0A5CchQg=qDVLi_SSiZqcd0dxsay-Y94WTQ@mail.gmail.com>
	<CV_doc_int-tr_key_format.533@msgid.xyz>
	<doc_int-tr_key_format.534@msgid.xyz>
Date: Mon, 30 Mar 2026 15:27:44 -0700
Message-ID: <xmqqbjg56jhb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

kristofferhaugsbakk@fastmail.com writes:

> Notes (series):
>     The (❦) is meant as a thematic break. There is too much of a thematic jump
>     between these two paragraphs without a section or something else breaking
>     them up.

I do not quite agree with this particular instance.  It rather looks
more like an unnecessary hostile move against folks who prefer to
see plain ASCII on their screen unless absolutely needed (like say
for displaying people's names with letters outside US-ASCII), as the
two paragraphs before and after are not all that unrelated.

One thing that I found a bit wanting after this step is that it lost
hint that the primary way to delimit between the key and value in
the trailer lines is to have a colon immediately after key and with
a single whitespace before the value, which is what is very typical
to see in the e-mail headers.  Sure, if a reader has not heard of
(2)822, hinting that these resemble e-mail headers would not help
them at all, but those of us among the audience of this document who
have seen e-mail headers and how they feel, the "look similar to"
was enough to hint how a colon is typically used in a trailer.  In
the updated text, the readers will have to way around line #65
before seeing the official "both key and value are trimmed for
whitespaces on both ends and then made into 'key: value'".

I mentioned "issues I raised on the previous step" in my review on
2/2, but did not remember that I haven't sent out this one yet ;-)

> @@ -14,9 +14,9 @@ git interpret-trailers [--in-place] [--trim-empty]
>  
>  DESCRIPTION
>  -----------
> -Add or parse _trailer_ lines that look similar to RFC 822 e-mail
> -headers, at the end of the otherwise free-form part of a commit
> -message. For example, in the following commit message
> +Add or parse _trailer_ key-value pairs at the end of the otherwise
> +free-form part of a commit message. For example, in the following commit
> +message
>  
>  ------------------------------------------------
>  subject
