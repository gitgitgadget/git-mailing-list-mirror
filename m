Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D332E92D2
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 05:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756186825; cv=none; b=kqfjjORmxCsJ7nj+U/OBhE6NK+Qbeq0bsLalsQH+zevo5/eo4GJwdabfetlUW7Ye61URHsw0Paoz45bP4Os8ipJQVLaWR3f+k+4jKDMiU9jQHAfeffKM/OmdGl6r4Lz0OEDQ6uQhOF0Bl58WAVRLoFtHfRmGw2gjSBu16xv/R3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756186825; c=relaxed/simple;
	bh=rSVDoU5CBL7iGhpPh829oi73Xpv6h8QyCna4xZRK+z0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fHirmmNGqw2xvvrUr7w+/qh2obriBc2WGrODhEosdJupUEGEmEIEhke6p3zCfs2gPn5wfOr0zQQfT/ecWZYs4ps4RfFWRFdFHYQtHl/sJsqkcFv11c6d60wz9bGeBPkl2pD0+ItQeDMs6Z9z2f+ouI7lVwvgDAQrcMCOsHSfma0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=c+6TXD5M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J8LVfJR4; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="c+6TXD5M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J8LVfJR4"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 1849CEC045B;
	Tue, 26 Aug 2025 01:40:21 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Tue, 26 Aug 2025 01:40:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1756186821; x=1756273221; bh=J8SViA1B2I
	rwwSs33Ds5Tn0WC5+YoeVPV92FSiNBEq0=; b=c+6TXD5M5/zqxoA8afRyqZ38O+
	R24bYktQEXDwyhOnbTdJ3Fm2XrEaYe3eVR+LD56qRzpotU92+xYnTBk/6xXotfIa
	/K/fAfqqbPsO+hQgCxCE++o8OgvghXBYgvKsvGeymmi7pjlK+9q3aqO2D72nGmzo
	mKh+IBJq3kSJyb/Biu92FRpwSYkGs/xVmm8MukcpE32r9FcfwsCW5dN3hOc+JfIY
	w49pDcCvq8gTYifH65XMBHbjp95UXrcl2Et3Ka+JjFr0CATpOx8raGfAP/vtbPZY
	oBLUK+NUAnmFlO3iomazF/erAvQVyZsv03UifVQKHobGr+Nlle3bqs4fRLgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756186821; x=1756273221; bh=J8SViA1B2IrwwSs33Ds5Tn0WC5+YoeVPV92
	FSiNBEq0=; b=J8LVfJR4Z1x34pVJ+9M4WIDJ6GJrGpjeeELJMiFiz1aL/cv7+YF
	+WxiA6mlL5EKlOsvvJQUBMyDk+byfvm4l6JJj8kqqfN7KKnGaNNVx0/AZjHEhO9V
	FuFQbMbSiDvHVbVVySixGzpeY/0cpDhR/DTql5xAwztisU6kKEJdNMhLT95UOPHV
	xLODuSQBceKuLGH098/liDICqBFxRoeFkqEx9aHGG6v/wG1Ko65XPTG9RPp/o52K
	HTqZAYJQd3ROHnnH/Xv65zvuWgjRuPxoX7nmv5ZIKFuNTFRjtlB0cAVbEAONj9+M
	B3HA0r8+f2AN6EUHSYEJslUnwlJHxJst4QA==
X-ME-Sender: <xms:w0itaKgSq1C3WLSatLTXqGyHyU6NnGlWpNZoN1iipvLGIH4vXCh8JQ>
    <xme:w0itaALW2AhPEg2WtYbz0ekYJOHAOhdgDbegEn3I2_hGkSB7NkVHM1F-xaerbDvLf
    ZbGdeGW9hsspFn87w>
X-ME-Received: <xmr:w0itaFDCQhfZRq9bO8d9MSOZrijLaXAukA9j_BuClZeMpAgeCNWoyj7q8XxsxgX8ZN1oAp5Yp4O8QC9cLrNClwJSd7d6H22bcQXUFbk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeeggeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepvddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrnhgurghlshestg
    hruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepmhgvsehtthgrhihl
    ohhrrhdrtghomhdprhgtphhtthhopegtsgesvdehiegsihhtrdhorhhgpdhrtghpthhtoh
    epphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopegv
    shgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopegtohhnthgrtghtse
    hhrggtkhhtihhvihhsrdhmvg
X-ME-Proxy: <xmx:w0itaJTkDJcz7XuMAanfQ2DowL0FjxcwY4lXJHH91pZUk1eQnBGOpA>
    <xmx:w0itaOqZTdI8tJLrWF5w2WiJWr2B7bCtIGYLI1qaFcvxStG1ZbVahw>
    <xmx:w0itaKWrHhzebeZln9l8scAr8k3hGYNaqvMP_jqbJutsuWTztUO2xQ>
    <xmx:w0itaE891Cxa2PohNgsUhPPrGXwure0qQsutkAe1bfdXOOnAqFXatA>
    <xmx:xUitaEqA13oENLkCuJSK_doGMRxKirwtHOIhHCm9aHDVbRA32EVWOHX->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Aug 2025 01:40:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  "brian m. carlson" <sandals@crustytoothpaste.net>,
  Taylor Blau <me@ttaylorr.com>,  Christian Brabandt <cb@256bit.org>,
  Phillip Wood <phillip.wood123@gmail.com>,  Eli Schwartz
 <eschwartz@gentoo.org>,  "Haelwenn (lanodan) Monnier"
 <contact@hacktivis.me>,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,  Patrick Steinhardt
 <ps@pks.im>,  Sam
 James <sam@gentoo.org>,  Collin Funk <collin.funk1@gmail.com>,  Mike
 Hommey <mh@glandium.org>,  Pierre-Emmanuel Patry
 <pierre-emmanuel.patry@embecosm.com>,  Ben Knoble <ben.knoble@gmail.com>,
  Ramsay Jones <ramsay@ramsayjones.plus.com>,  Ezekiel Newren
 <ezekielnewren@gmail.com>
Subject: Re: [PATCH v3 06/15] ivec: create a vector type that is
 interoperable between C and Rust
In-Reply-To: <CABPp-BF44xgh5uJhCKXE8aSN5otyHOAJYNqB_bfLj1Z7_FANCw@mail.gmail.com>
	(Elijah Newren's message of "Mon, 25 Aug 2025 12:16:24 -0700")
References: <pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
	<pull.1980.v3.git.git.1755921356.gitgitgadget@gmail.com>
	<db5d22b188740bcb830e4ccf7f19dcc4e6b557bd.1755921357.git.gitgitgadget@gmail.com>
	<xmqq8qj9vrpf.fsf@gitster.g>
	<CABPp-BF44xgh5uJhCKXE8aSN5otyHOAJYNqB_bfLj1Z7_FANCw@mail.gmail.com>
Date: Mon, 25 Aug 2025 22:40:18 -0700
Message-ID: <xmqqo6s2myil.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

>> > +#include "../git-compat-util.h"
>>
>> As we use -I. on the command line, there is no need to add "../"
>> here; just writing
>>
>>         #include <git-compat-util.h>
>>
>> should be enough.  Also, if this file does not depend on the
>> services compat-util header provides (and I do not think it does
>> from a brief look at its contents), it is better not to include it.
>
> Should this rather be
>
>    #include "git-compat-util.h"

I meant <>; when "" included header is not found, it falls back as
if it were <> included, IIRC, so writing <> when you specify exactly
where your headers are with -I. avoids such unnecessary fallback in
theory, but as both <> and "" search for implementation-defined
places, the distinction does not make much practical difference.

> Still, our current project practice appears to be double quotes; is
> that fine here or are you suggesting you'd like the current project
> practice to be changed?

It would be nice if we could do so, but I do not think it is worth
the patch churn.

