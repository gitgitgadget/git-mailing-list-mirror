Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEBA3B8D49
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 01:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765849559; cv=none; b=PDnbpLo/AhrY2FwGMkEslMecl/+IHOWNo5ofrhBqFQ1B0mY2LbcLXrt074CVZRcrrYlqt3sXeJmfXhi2jZYtKMY+AAjG1JhM60wCyiptTYfpoFvtc39gBzrcXGGBSqcSERl7Zi7TjXDxKTVSlsotxm666p3LZ+gX120yLNQ8T3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765849559; c=relaxed/simple;
	bh=d1gnZ42mOoacsOT2+1KS28okXo0fyo65wP9sMSp0hx4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fqv5o+DnA5esjtwTeXa73h/W9f9uj+koHwnufiZK/abHCGe59FtNx/l0rJnKZziD/RGer0vyjPN2RIBp7g6T4m9Q4oaj/sdqVNW8IU4PxQrjdKBY7gjiyhPSSFIy+Aa+vgt3PH4tbUpyKI6LUUVsKCbrFY13Rqyh/+Z9JdSHei0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=H4T1+K6a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gXPc/8LW; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="H4T1+K6a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gXPc/8LW"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id F19F31D0013C;
	Mon, 15 Dec 2025 20:45:55 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 15 Dec 2025 20:45:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1765849555;
	 x=1765935955; bh=z3MpA27EyiK+ltHWKyMuHeqtmbhYVZn63+c8Mh52Slw=; b=
	H4T1+K6aGU3pQbeW/5vNALmiRWcFsO7LEqHzFQ4LFx3ysTeyjv7CbRE5TLog4luK
	ONBJ0wDtq+wm1kpmyeUdr+pcG9ZHIdV7ieA2TbmkvEtcMnt+7gSWdbQBos6aEOqm
	c9nYcesNa1+JTO1Dq331PED2x3CFDKdDM0D2acX9410q/oGyzW3P7E4WIxUBcE9T
	Wj9lcHpZcMCIu+ZKx1e+nFpwI4H1wpPmrT3+eRxr51qXI9XRjQf6hSume90/+b83
	GtAAvS/TMEa9GjnG0/j2jUWamscWl5f5bi7IEexmRBUgXfcxKYuR4sA2da9+7HEZ
	GkOrn3o5RSRRX469gv7W6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765849555; x=
	1765935955; bh=z3MpA27EyiK+ltHWKyMuHeqtmbhYVZn63+c8Mh52Slw=; b=g
	XPc/8LWJRChcg6HA37UKbu9F6oDN6afxWQAAmfYkCXF2bat0K+111o4/b3KVL11t
	clVqWTGwUv8vDQ8O9g5yZktTFKG0z2kU85zHxFkfmaH1ClGr0HXByQ+lPn6pGii9
	2iEn030tfPj4O5BL/R+7GPhow/ski4oUBLNs4dfqrtmnwnGqIEIpD5w/mvy2s80R
	XAx/DriIGBft9GpmCBwHxZm9nvJmWbxGQ+t/A0n8DIVc+4qR8ib7S+sAQWpBbWyP
	zu6lMQ9Z1B6OxCevZFB/IytjxXJVBBp3nEFDFscKMEzAEIea4UbB8fdFZVAnOQDk
	crhCsa2NjQgnfpwT1O4zA==
X-ME-Sender: <xms:07lAaX9kUTf5UMN6j_VfBItLZtYFghk48_EfGB8hSdvRoZT2Gc36vA>
    <xme:07lAaaukNNhEqVOUgJ6lqp6ZsgrzSOKGCtGkS7MPk4z53m_VpljOzhY0PTaZf6_9E
    kCgZ3qiGZsxFW7aQ_7QTPLyg7UUe2qsw4xKr1jZsinWH2Y0L2kBp6w>
X-ME-Received: <xmr:07lAaaDM6d9EIjJ0X9IKv-bBvG3dCtN2pOceVoQlpg_Bq8-wis0FJTjdkT0VdCIItk8it1ROps6ae1gMeX1tZRo_IlI17ekUgg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefkeegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgfgsehtkeertd
    dtreejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevle
    fgkeefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtsghovghg
    ihesfigvsgdruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:07lAaSXuA6HqsfH393KEFCikBOLABIq932oE7pF-B8nVlcP7Ai4Vow>
    <xmx:07lAaYDZ_mNNAdbOOQMq13rluZXD-E31CZxMNbHYmlisuWsa7iHt3g>
    <xmx:07lAaV_pgVtN6bXRTUoZ8ej5oDUndlP8uoIuYijZL2TYSryjujET9w>
    <xmx:07lAafHKersYcb4YHCNIWiuIMmnip9ctlFiVyhOA83C4Ar-7Y9b8ZA>
    <xmx:07lAae8k6IMFXWplLJxhux3cZSe4f4p21zQrd0xXUEcfb6h5ZesDTJtm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Dec 2025 20:45:55 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: tboegi@web.de
Cc: git@vger.kernel.org,  l.s.r@web.de
Subject: Re: [PATCH v0 1/3] utf8.c: Prepare workaround for iconv under macOS
 14/15
In-Reply-To: <20251215204521.1946490-1-tboegi@web.de> (tboegi@web.de's message
	of "Mon, 15 Dec 2025 21:45:21 +0100")
References: <20251215204521.1946490-1-tboegi@web.de>
Date: Tue, 16 Dec 2025 10:45:53 +0900
Message-ID: <xmqqa4zj5hda.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

tboegi@web.de writes:

> From: Torsten Bögershausen <tboegi@web.de>
>
> MacOS14 (Sonoma) has started to ship an iconv library with bugs.
> The same bugs exists even in MacOS 15 (Sequoia)
>
> A bug report running the Git test suite says:
>
> three tests of t3900 fail on macOS 26.1 for me:
>
>   not ok 17 - ISO-2022-JP should be shown in UTF-8 now
>   not ok 25 - ISO-2022-JP should be shown in UTF-8 now
>   not ok 38 - commit --fixup into ISO-2022-JP from UTF-8
>
> Here's the verbose output of the first one:
>
> ----- snip! -----
> expecting success of 3900.17 'ISO-2022-JP should be shown in UTF-8 now':
>                 compare_with ISO-2022-JP "$TEST_DIRECTORY"/t3900/2-UTF-8.txt
>
> --- /Users/x/src/git/t/t3900/2-UTF-8.txt 2024-10-01 19:43:24.605230684 +0000
> +++ current     2025-12-08 21:52:45.786161909 +0000
> @@ -1,4 +1,4 @@
>  はれひほふ
>
>  しているのが、いるので。
> -濱浜ほれぷりぽれまびぐりろへ。
> +濱浜ほれぷりぽれまび$0$j$m$X!#
> not ok 17 - ISO-2022-JP should be shown in UTF-8 now
> 1..17
> ----- snap! -----
>
> compare_with runs git show to display a commit message, which in this
> case here was encoded using ISO-2022-JP and is supposed to be reencoded
> to UTF-8, but git show only does that half-way -- the "$0$j$m$X!#" part
> is from the original ISO-2022-JP representation.

Next time, please try applying your patch to your own tree before
sending.
