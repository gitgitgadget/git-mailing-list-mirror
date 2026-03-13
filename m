Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AE433689D
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 22:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773439544; cv=none; b=gvkUV6/I7zdd3BvggQOKwwGetBjgfmhnFHKqF5ykUqdSUf0uWFk6t3/yi36fqj8vvB9nP0+REBMzLhMfXMRKRnCQCJ6imHflAsw+ncWcLrk1pnc/cne4DxYaZDEhwpSUGRfnE/6HWq8qDGa4yz3q2JPs9taiwA9thFmZZlI7LOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773439544; c=relaxed/simple;
	bh=rVjx0h/ScQV2KsN3OUE1xtdlnEs2HjmN2tOI9HM9c7c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JYjvpbROT8ZaOSCkXZ+NxQ7OC5iz8HJRAdIcvGpPFcY767et8Rz2p44DsKApNw1eTOAmjOJ5WYioooxiultD2fhWkynFeObq2NHbJR8z8YfNuxp3NPPrvvuMZ5D6kYFZt1QRHL7T60gaKnrukiA/E8FJxojgfpqZZrGRX9XN+bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ciXYot1y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=3yjwYLby; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ciXYot1y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="3yjwYLby"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D93B87A0016;
	Fri, 13 Mar 2026 18:05:41 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 13 Mar 2026 18:05:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773439541;
	 x=1773525941; bh=HSoMf/TBHbNbNLn5La9+nRpik+epZpJBI3eTZV6p8kM=; b=
	ciXYot1yl2m2uflaRa6zUSJIavAVtDtcmyFV6J/uW9K21BO37mosWTNspSEZrDZX
	ouErgZInetWEF80brukx6sLTnGNg4+wfuW4MY2jdKwTAeTJMqlfqVRoxqslFARVn
	OWMpHXZPRBZZ1505UzCa6EHAVNq4vDWKbOi2PR73WdbpiqC8o7BSeVmkZGKfLx00
	oovfexVh1DTtR/4KBGPgJtg/OcGCYi285Rf7DRIc9/5mZJAz36UnBBU+GCO4xL/R
	S06vj9F1dxzRZzQpJKoOqBt2uCBNUgiKERppn37ZzPIxJyQyAUSwpglzJMcuKKVZ
	yPjXVnsTtcTZcDMzjxv8wA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773439541; x=
	1773525941; bh=HSoMf/TBHbNbNLn5La9+nRpik+epZpJBI3eTZV6p8kM=; b=3
	yjwYLbytkAiWeM6lezqatUmpoRu5BJ199YMU0PjIj9XF7sABcQ7iU4PaZWMZgi4f
	KN6H4zcL+OI6nx9zl4+xTIUzabV5UT1LbqBqXJZgXZEe/orgF4hlGieE0tJU5oKl
	ysUfv5yNojwCu2q2w61JCLSCGBkRWZHZIFYVdL4K4mV3eaZM4umTMiHDk2WT7L/H
	cl3lDRidgFGfl+p/+RNbSjO4Rw9gbdPA9B8929qNsG2Dw0yI84BS84fJA2cC5BO4
	Q5oer+f6ejdcFcPtibCcb9EZlXFT0nzG4ffxt2HSqDzShUUxQHnQPDYZU5PvcnKZ
	odtZ2peRl3J1nn3hrW8sQ==
X-ME-Sender: <xms:NYq0abT8jkR3Z8m8jc-o3N_QYl5ukZhzqMWOGHtr--aIilbeyCPOwg>
    <xme:NYq0afBUqbTe3NOgkN0OtPFdEw4_5aP7VxbMysKsdURO8lNzHCuID208q1-q0bBmI
    QffVGAy8DDn4cChzIsyXzujToAlCcTOuwwu2ZAYomdxQniql6E92Sc>
X-ME-Received: <xmr:NYq0aTGm7Ga8nBL6grRCfA9Xl6H8b7N7V-0XDsv2t6Fc5ecRlppaIGh9DqwtqgD8rkaIV-N0OEv-Q71tBw9zlEyL__N0ayyONQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvledtkeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegouf
    hushhpvggtthffohhmrghinhculdegledmnecujfgurhephffvvefujghffffkfgggtgfg
    sehtkeertddtreejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtsh
    htvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeeuueffteeufedvteel
    keetteeiveelleelveeitdetudffvdfggfeghfetvddukeenucffohhmrghinhepghhith
    hhuhgsrdhiohenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhl
    rdgtohhmpdhrtghpthhtoheprghrshhhshhrihhvrghsthgrvhgrtddtsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphh
    hilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehp
    khhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:NYq0aRA37rFrQUfKx63chx1F3R9nPXmzNdU09suPATFe7tiwTbm3Rw>
    <xmx:NYq0aTWmWrJ69JFBPgqWE3pKbG9SK4rifd7OtmDFZYWCZYmgVLKHPw>
    <xmx:NYq0aVrCFePGpA2aFNqluCZ6EYx9me5xqR4A7Js9flJt_brBzwf-dQ>
    <xmx:NYq0afT3suePuGaPCdUDTW5JIsgE0PNedWy6F3yzyriT3AnLDflpAw>
    <xmx:NYq0aR0rr9wPdZtB4hyFapp3xePcCRZczc9lHsXCLSsyl5gGOnGKFL31>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Mar 2026 18:05:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Arsh Srivastava <arshsrivastava00@gmail.com>,  Arsh Srivastava via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Phillip Wood
 <phillip.wood123@gmail.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v7] unpack-trees: suggest using 'git stash' when
 checkout fails
In-Reply-To: <CAOLa=ZTJ1u+cyVZyOGQbdOniK+U3CGrYSJRaeecYsT9+D8gWFQ@mail.gmail.com>
	(Karthik Nayak's message of "Fri, 13 Mar 2026 03:43:11 -0700")
References: <pull.2233.v6.git.git.1773288013936.gitgitgadget@gmail.com>
	<pull.2233.v7.git.git.1773345901659.gitgitgadget@gmail.com>
	<xmqqldfwacyw.fsf@gitster.g>
	<CAOAgETMCb++MnOC9YEN+y0TE9NeVC+-=Zez7UOVY3kt8vv7dRQ@mail.gmail.com>
	<CAOLa=ZTJ1u+cyVZyOGQbdOniK+U3CGrYSJRaeecYsT9+D8gWFQ@mail.gmail.com>
Date: Fri, 13 Mar 2026 15:05:39 -0700
Message-ID: <xmqqbjgr2xn0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Karthik Nayak <karthik.188@gmail.com> writes:

> From the micro-project information [1] for GSoC we have:
>
>   The coding part of the microproject should be very small (say, 10-30
>   minutes). We don’t require that your patch be accepted into the
>   “master” branch by the time of your formal application; we mostly want
>   to see that you have a basic level of competence and especially the
>   ability to interact with the other Git developers.
>
> As such and seeing Junio's previous response, I would say that no
> further work is required here.
>
> [1]: https://git.github.io/General-Microproject-Information/

Thanks ;-).
