Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD0F2F4A03
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 16:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752682172; cv=none; b=iyG5LTu6Fz6K8ATUoOVl9D1Xxa0z/IGYaS5+695ryXb2IiOJ6XQobPnCH5ZIPoNHCLnnKJ+8grUXFzSRqHRHMtAhxAqsR9IhUH+oOROFSZiAN/fx7d0vty5MD5nVWiCKUbniYZVupy6onKWbTuddRmcAfco0KTI/Ppxuk+I6nH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752682172; c=relaxed/simple;
	bh=QVIcDFpO20YZhnBhqqKC2FQrnr7U38M/MmLb40FzQiE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PBPNu/dIh0Iupgx/fR2sGlSDRMVdg40CM+nGVquz/xPpnFEt54POVaYCslf5Q6U9jGDFh7xc2wKCHAp+voD+Os+lmV1nZKNQTdUkOwBbdr9bW9mDz0lmvKNKn+dajiefLYJ9HFOWV/zlqHv2CVfyFEc+tRfMgbiFWsbUdG2rnC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=a2Pgq0/P; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BhnqDfwZ; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="a2Pgq0/P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BhnqDfwZ"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 70FE67A00A0;
	Wed, 16 Jul 2025 12:09:29 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 16 Jul 2025 12:09:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752682169; x=1752768569; bh=JwwvMqavO+
	NzRGgDgO4BI0l+mKoyD1B6sB1L+58PXSE=; b=a2Pgq0/PSr2R3HVPGzQpToCLHG
	+91SIuUsinUt9waXpu1ur0Dw6N5ADOMrBlRX0f5JGXNeSRGKuO8amZRVkMX1Q1lK
	PsG3xC7dE4RXtZ+tx6TzytBh5/qY42dh0b0yRes+3Xg6z52f6MJ+cR1Ai/vs17AU
	XMkWScVM67XhVjY+T00mMkE8NJJ9mOloZamig9OlGovXp1M+t4pqhyzYy7j73Sr5
	G5uecbc/HXmOENxSxz/rDD4Ck6iEWb/pKm7FoUjkcwRWRBg1t7aE0vMbqbaIRW5j
	WSP7DIV47IgU63v0UsRaZ+2PSwVxe1kIovx2qyNIHAw7MuFcKxA8TKuUHQgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752682169; x=1752768569; bh=JwwvMqavO+NzRGgDgO4BI0l+mKoyD1B6sB1
	L+58PXSE=; b=BhnqDfwZ/LKorxai7wK/GR/XcBZUWK2P9pZARbguUfjs6vVwTVW
	wpIDzN26/Qxt9BMbr9TLNByUprVP3FPiYSalfXRgulmbIczKaT7qYVJHXI7l1oi0
	mCAP0ZPTC4Y2XC3z/9VRJblrbP/b/sg6+II/2CeFCZn9kB5ByhhoZ2jwrLmKHPNi
	WWRFfeQxQ2+64Vjdwqq1ptWUM2UKvJHwAI4Uez4g/zA3YP3lumDg3QBZkdJsaCKZ
	XbzISFmGP7BnbZDzKWjtHw4I+EtNWpAcI4ZceKExnmrQooxyhxXKB+J39l4yZ7zU
	w2w3966RKIWsJU4BkUoKM+6PilvdermxPBQ==
X-ME-Sender: <xms:uM53aDp-WIpJOHS8MPuffyMjeHb_KtmETDhY4XPEshaTB1N4giFyYw>
    <xme:uM53aGE1UVuwXyUXqsCf570PZ12nM1aY3L_He9PLniemLd1whpTypngh5tQ1fxLVU
    gQZaigIc90Wxq1z1A>
X-ME-Received: <xmr:uM53aApQ4g6U5_K9QVm693bS1FpGyBgizuLVIo5iskf3u6eMbV0zjrkDBy2iw5NmA6RXvdctWnObP_v9a0_QOqTPpptBAyiix8-noeQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehkeduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileff
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhrihhsthhofhhf
    vghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepshhtoh
    hlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtgho
    mhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:uM53aHbf8oXOrgFUVLmqrnMOzSEqFgdjA8HMefOobb37UAy1pCmpeg>
    <xmx:uM53aBVIJSH0awBEB1ao5SR26MMO5g8Lf10I0PXdvu0rMcH7uSRrJQ>
    <xmx:uM53aI8FB1P--qP8oE2-XVa9vrtTGIMGdHS4HesDGm45sHeufSJ4LQ>
    <xmx:uM53aC_cncktpSeIgzcGucakmWieqm_c6s4rohwrGFFclNLJZGER0w>
    <xmx:uc53aIWlSAtkYv_RnLeCTt48ludWRboC9I0TkeRYmPuic9B-Dkeq9vfm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Jul 2025 12:09:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Derrick Stolee <stolee@gmail.com>,
  Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v5 5/6] last-modified: support --extended format
In-Reply-To: <20250716133518.1788126-5-toon@iotcl.com> (Toon Claes's message
	of "Wed, 16 Jul 2025 15:35:17 +0200")
References: <20250630-toon-new-blame-tree-v3-0-3516025dc3bc@iotcl.com>
	<20250716133518.1788126-5-toon@iotcl.com>
Date: Wed, 16 Jul 2025 09:09:27 -0700
Message-ID: <xmqqldooazig.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> +OUTPUT
> +------
> +
> +The default format prints for each path:
> +
> +	<oid> TAB <path> LF
> +
> +When the commit is at boundary, it's prefixed with a caret `^`.
> +
> +Or when option `-z` is given:
> +
> +	<oid> TAB <path> NUL
> +
> +When `--extended` is provided, the output will be in the format:
> +
> +	path SP <path> LF
> +	commit SP <oid> LF
> +	tree SP <tree> LF
> +	parent SP <parent> LF
> +	author SP <author> LF
> +	    <message>
> +
> +Each line of the commit message is indented with four spaces.
> +
> +Unless together with `--extended` option `-z` is given, then the output is:

"If" would probably have been more readable.

I can see why you wrote "Unless" here, i.e.

    We indent by four spaces.
    Unless you use "-z" and "--extended" together, that is.

but I do not think it is a good idea to use such a construct here.
The reason why I do not think you want to phrase it that way is
because the next block that illustrates what happens when "-z" and
"--extended" are used together has more differences than just a mere
"is the message indented?" single bit.  Unlike "--extended" without
"-z" that uniformly use LF as inter-item separator, some items are
NUL terminated while others are LF terminated.

> +	path SP <path> NUL
> +	commit SP <oid> LF
> +	tree SP <tree> LF
> +	parent SP <parent> LF
> +	author SP <author> LF
> +	<message>
> +
> +In this situation the commit message is not indented.
> +
> +A path containing SP or special characters is enclosed in double-quotes in the C
> +style as needed, unless option `-z` is provided.

Another thing I find the above output description somewhat lacking
is that, while it is clear how each output entry ends when
"--extended" is not given (i.e. it shows what terminates each output
entry.  The output is one entry per path and either LF or NUL
terminates an entry), the description of "--extended", with or
without "-z" is silent about how the reader program is expected to
notice when the message ends.

Without "-z" and indented, the end of the <message> part if either
EOF or any unindented line, whichever comes earlier, I presume?  I
am planning to teach pretty_print_commit() to stop indenting an
empty line by 4 spaces, by the way---non-"-z" format needs to be
designed to withstand such a change.

How would this extended format gain more fields in the future?  A
free-text <message> has to be at the end?  What if we later need to
add another free-text thing (e.g., notes ttached to the commit that
is responsible for that latest state of the path)?  I suspect that
you'd want an explicit tag (perhaps "message SP <message>") so that
the log message does not have to be anything special among others.

In any case, the above considerations need to be documented.

With "-z", a message body can begin with "path ", so you'd need to
arrange some terminator (like NUL) after the message body anyway.

Unless your format is "we tell about one path and then always exit",
that is, but that is probably not what we want.

Thanks.

