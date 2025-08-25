Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6A11E8332
	for <git@vger.kernel.org>; Mon, 25 Aug 2025 16:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756138873; cv=none; b=KFXSFtQnFiGUO70hlst6wVdlEjT6QI6XeFjMGsQv6fCCm/m7QmrDl93F8wJmBeSj0KJlv54Izd/ulf/8a8K5F3QX5zeXQkfo6tR9k9VN+lzZvJCimKCp8Xw/OhJmmquoQbCYIsttmeT9ct2bo3lyGtEgfW9T/hR4DHdVE6EXHAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756138873; c=relaxed/simple;
	bh=CtpKEp3Ndn6g2LqhunRqXOdGB9xK9GyKlg3jADOVORU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nkrrWtHo4y0zLjq9FuUEMhkFxdRhX8tWs4K49G49bRE+2Wc07WOvlc+88gAH2st20JothRAuC3SX9LCV7nreSlY32SFHcLfWEt5hZ4NyNaXpVA9p0u+oV+Hzjj93JLPJ+4gA3lP7RxhQHWgdl9uN3EDFv2+2LnlHnbLZNem8pTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eocqSknS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YlvKnow3; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eocqSknS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YlvKnow3"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7214D7A014A;
	Mon, 25 Aug 2025 12:21:08 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Mon, 25 Aug 2025 12:21:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1756138868;
	 x=1756225268; bh=4TFWBXkmYFlv1ij+FPQjNhWDDgsMdzzYmocs9oVV470=; b=
	eocqSknSBcZnk/9jUMp1vZeVcKu17Re8RXnQAcH1aRXhgOhq6GU+9WgqX55duuWX
	bbJoiq764OuaI0Z8JRsCl5BUS1Dfex5LBnC1jqhYKRM4QZnCACYgMxJFIxkBKC54
	xU5ukR6hYGffsgCvXNm1EXMki3hdi/T65ke6Ymlh9gf+NWxaDaNISFj6ve+HPxCc
	k8ODBlJUBT+p3bwqiRRrcF4Ml1iW36VAHJm3JmtzA5cXVTdTQOVuc99BD3Unv7GX
	i9635wwnJrnSlLYFpe7/diy4M46jzaWAZMU8lJx+3lKr1hDcetvfQh1wASfdkhRt
	JxAmbnb84FIU701/CU0pxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1756138868; x=
	1756225268; bh=4TFWBXkmYFlv1ij+FPQjNhWDDgsMdzzYmocs9oVV470=; b=Y
	lvKnow3ITSi6PoYFBbCOz8ieD7ReIO4T3R9XLlokN8ZqiAzaBdGDoQhGDdNQFhQ6
	br+mR8DsEaATLP4dJ7cHXYKea22JPszL/BH3ZOrbgKkjlBGpckWgb3cDe4dE63Ec
	Ug3879r4QqLYs5EIX45lK9CnZ7/qU3T659uPNioTPxXbBkSl+LOKv+fHdMwb3LKe
	WP4nhW6vthIKGwLxfc0jc6Ku+v9RYLHtaXW6YzgXNr18wMh89UzVDFnoMOyYZ8AE
	j3Bdorz1iRVTOpTBmwJgdH7eNSzm6jF52ZYdn2Qrg1kc1iajc8RUpQ7/Y/bIXOSK
	e/XylR+6ff72Uag7A1usQ==
X-ME-Sender: <xms:dI2saIfjgggdbdpSygsDwro7-oeWOg-hbuJHrdinfF0ME-nw3FGl5w>
    <xme:dI2saFu9rK0lwELqwHRIyE4sSmWLVVO4hIFNtYd3FXj4zHqjbhbi6RwjG6EkU_CDV
    msDUdtZB_xbIQUJtA>
X-ME-Received: <xmr:dI2saP-LMSSX1e-8kZeC7Cq6a4PlLdZSfyfGdbE1QblTOxV5lnGuWQzJoiXI8EzQp0-l-jpvqmQRclz1fNW9n3cAHRJfPEVbCU2m8hw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujedvkeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlvghsrg
    hsshholhhisehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:dI2saI1yCVOcq7JdFY6YlKbfa3Xg7e9k4VtzVXW6jBkh8mVuk17QDg>
    <xmx:dI2saMDN6Lvt_p649oAfVCg_8ecSpZrEH7cbDuwroJcKs3AkLHXbGQ>
    <xmx:dI2saMdiM64ySkG9lVSSUUB5u7-hIJuid7zBx4GRH53bu1NhgR3NQA>
    <xmx:dI2saB4ahe9thVYoaDNZ4-u0hNzMGTAqI-05731nToqbGKFXQlP7RA>
    <xmx:dI2saEOG_txPpfTwbW4AwGhCW8SvFSmPX6l9t-5mRklrjmvQqpxGRsS->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Aug 2025 12:21:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Daniele Sassoli via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Daniele Sassoli <danielesassoli@gmail.com>
Subject: Re: [PATCH v2] doc:clarify which remotes can be used when contributing
In-Reply-To: <CABPp-BHCQjFtpr8meUqhGEiTgsqZ9KTWcpLYA8yEPUsCAceAGg@mail.gmail.com>
	(Elijah Newren's message of "Mon, 25 Aug 2025 08:39:00 -0700")
References: <pull.2034.git.git.1755630882418.gitgitgadget@gmail.com>
	<pull.2034.v2.git.git.1755940331248.gitgitgadget@gmail.com>
	<CABPp-BHCQjFtpr8meUqhGEiTgsqZ9KTWcpLYA8yEPUsCAceAGg@mail.gmail.com>
Date: Mon, 25 Aug 2025 09:21:06 -0700
Message-ID: <xmqqtt1vs77x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Elijah Newren <newren@gmail.com> writes:

> On Sat, Aug 23, 2025 at 2:12 AM Daniele Sassoli via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Daniele Sassoli <danielesassoli@gmail.com>
>>
>> The docs mostly point to using git/git as one's remote, however, when it
>> comes to Sending a PR to GitGitGadget section, the reader is told to use
>> gitgitgadget/git, with no mention of git/git, potentially leading to
>> some confusion.
>> ...
>
> This version looks good to me; thanks!

Thanks both.  I'll queue it after reritling.

> doc: clarify which remotes can be used with GitGitGadget

The only reason why you need to even "use" remote is because you are
using GGG; othrewise you would not even be using any when sending
your contribution in, so "when contributing" somewhat misses the
point.


