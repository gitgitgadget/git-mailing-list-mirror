Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343772561AE
	for <git@vger.kernel.org>; Fri, 14 Nov 2025 20:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763151457; cv=none; b=uVyCx5jNYXt8HxH1u9V88vtXKFfnI2PWpUruEMj7mVkXBPNnn70/JoRm/2NIx3kcy97CZUGsgarXG3euBAATLhbEb5XSQ6ZXE+MWabYuZUOi8dcEg1eyz0X+powYuWbulyDXiFbdlTHeGcPwQKySYDwyM6kUmM1L8pJ3ohLFgYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763151457; c=relaxed/simple;
	bh=/4h/TXxPG2jENzlEVGk3UiozkWW6dMk0XeAY5LEUMvk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cqyelOs1hQ8+sMohi5+f98Lk0cWMpjwXqnMHguteCfhsWyPvYAE8ZHLSly5D4y8yQJJ71FkmtH+AuKbxISWTA5jnXBYZBA+W2lULI4jZAYkr5y65TjaKBXfg0N+7DvcMoABZ10377LxM56aIcducBNzOlM7Yb8x6skD4cq4hPPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Tw+dC9dX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Oth0rXLT; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Tw+dC9dX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Oth0rXLT"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 4249CEC005A;
	Fri, 14 Nov 2025 15:17:34 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 14 Nov 2025 15:17:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1763151454;
	 x=1763237854; bh=qOmNlpoZUn/FAWmoZAP663gWqq94iT8YEXlNOdAzU0w=; b=
	Tw+dC9dXW1Jp0rhpkK/zNnfxvabWvW0+vRfChBugI3svS0DvNjNko9q/WTgI3zcI
	/NVLWVCmILZgsLKRuHAmQzrCtk5FA4sWzbfD60aQjzj/6GN8aCErjsLtUEP+GbLF
	bHC8CHb7Tl2wtuhijqBmv5nHqE+cUy/IWwbzybRNE+VTxVJ+BxdKpjfZODHy53/d
	6nEwjLnXiuJCXUL0T34rXtPosbdoojNXu0zxNEmQbSHCM5IYcqHSXFhyXyveNC7H
	AOkHASWPqem/ZCrc2iTzV2dArUKm9nFiB/m0tVm8fTH5zVXEgVRDOQOC2wmJdzhl
	+3ZevJnwd25vsW99Ypg41g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763151454; x=
	1763237854; bh=qOmNlpoZUn/FAWmoZAP663gWqq94iT8YEXlNOdAzU0w=; b=O
	th0rXLTwVBgSfodO4xsSBMMvhGDxEHYBU4Sitb0p2wlR/MPpi2hXUIac4MsJYwH8
	3sIEjm0hgJ9UhC7PWM2gdlvTY6IsvvAuE8I7Vvz0RwD3FLJDzuDH0LG/COOy8sp0
	52Hx29zz/wIUnt7TgBOS4kyp6ot3cmr98mzuy9/ld0UE9D+dsh35g7/xTzTlExh3
	ltq2Wseuevvk35pky2z7MuW0fbjp7GmE6hDvmoZil2Wd1NRcy+RQ8Q3TlsaMQr1F
	JATlyfSX76SX78xedAGdZ4vc8IwALwcJSieAHy5N6cqHCeQbMXdL7T+6HkY2lFkw
	EzYFN2YMQ1fBcuoCZjdaQ==
X-ME-Sender: <xms:XY4XaX8XadXWFNu5fM-TVvKcZbcj8TJWy4BplZdIaFLtenf9kyLCaA>
    <xme:XY4XabTqgGreSUB8_AxsuzGIcXGaKN6sSbE9j5xKZcvxTlznAowoNBbbryRNuJMmo
    gA1_kVMYIAPDzGhlTxtcgBWrcQA5We1WOSX3qETIB9RznizSVYDsw>
X-ME-Received: <xmr:XY4XaUqxXLw8H7iz-Zj00FiAHlt6jTr7re1PsTJ_JEG1ujzWkyGRjWF93h0q6BQ3P-sh7Q-Z-zYZzFJnoo9XFxKpJEHqhg5NxkSE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvuddtjeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeduiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepfihorhhlughhvghllhhordhnvghtsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopegrshhhse
    hkrghmsggrnhgrrhhirgdrohhrghdprhgtphhtthhopehmihhkvghlrdhfohhrtggruggr
    sehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhgrlhhfrdhthhhivghlohifsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthht
    ohepsggrghgrshguohhtmhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepughjmhdttd
    hnsehmrghilhdrrhhu
X-ME-Proxy: <xmx:XY4XaQNYq8oIw6GHh0J5BdyFsoF9AT-BAb3Ucu3CTWX-CfdDh3GQrw>
    <xmx:XY4XaSyzHA1rSBFWffKmlOkRaADJsMmWOzwFcxPyve_VhOlxecpiJA>
    <xmx:XY4XacwPSJIRFBrzUeMh39qcv-Rguprx5wwmYH6ZkpnxYmCLxBccgw>
    <xmx:XY4XabId7PREmS2qoiVr5pNqhx4tVJimK4AVaKf_C-KuMw8SIKwdxw>
    <xmx:Xo4XaTu4AlE-Tk8sY91nEQGD6-ZpCg32uwa2_pGxPPubo-nOp-coOYCa>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Nov 2025 15:17:33 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jiang Xin <worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,  
    Justin Tobler <jltobler@gmail.com>,  
    Alexander Shopov <ash@kambanaria.org>,  
    Mikel Forcada <mikel.forcada@gmail.com>,  
    Ralf Thielow <ralf.thielow@gmail.com>,  
    =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,  
    Bagas Sanjaya <bagasdotme@gmail.com>,  
    Dimitriy Ryazantcev <DJm00n@mail.ru>,  
    Peter Krefting <peter@softwolves.pp.se>,  
    Emir SARI <bitigchi@me.com>,  
    Arkadii Yakovets <ark@cho.red>,  
    =?utf-8?B?VsWpIFRp4bq/biBIxrBuZw==?= <newcomerminecraft@gmail.com>,  
    Teng Long <dyroneteng@gmail.com>,  
    Yi-Jyun Pan <pan93412@gmail.com>
Subject: Re: [PATCH 1/2] t/unit-tests: add UTF-8 width tests for CJK chars
In-Reply-To: <04ab347ff80e16d49524246a8923cc86cc7355be.1763098804.git.worldhello.net@gmail.com>
	(Jiang Xin's message of "Fri, 14 Nov 2025 00:52:44 -0500")
References: <cover.1763098804.git.worldhello.net@gmail.com>
	<04ab347ff80e16d49524246a8923cc86cc7355be.1763098804.git.worldhello.net@gmail.com>
Date: Fri, 14 Nov 2025 12:17:31 -0800
Message-ID: <xmqqzf8ogyhw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Jiang Xin <worldhello.net@gmail.com> writes:

[jc: the same question about the choice of Cc addresses applies]

> This commit adds a new test suite (u-utf8-width.c) to test the UTF-8
> width functions in Git, particularly focusing on multi-byte characters
> from East Asian languages like Chinese, Japanese, and Korean that
> typically require 2 display columns per character.
>
> The test suite includes:
> - Tests for utf8_strnwidth with Chinese strings
> - Tests for utf8_strwidth with Chinese strings
> - Tests for Japanese and Korean characters
> - Edge case tests with invalid UTF-8 sequences
> - Proper test function naming following the Clar framework convention
>
> Also updated the build configuration in Makefile and meson.build to
> include the new test suite in the build process.

The usual way to compose a log message of this project is to

 - Give an observation on how the current system works in the
   present tense (so no need to say "Currently X is Y", or
   "Previously X was Y" to describe the state before your change;
   just "X is Y" is enough), and discuss what you perceive as a
   problem in it.

 - Propose a solution (optional---often, problem description
   trivially leads to an obvious solution in reader's minds).

 - Give commands to somebody editing the codebase to "make it so",
   instead of saying "This commit does X".

in this order.

> +	/* Test length limiting */
> +	str = "你好世界";
> +	cl_assert_equal_i(2, utf8_strnwidth(str, 3, 0));  /* Only first char "你"(2 columns) within 3 bytes */
> +	cl_assert_equal_i(4, utf8_strnwidth(str, 6, 0));  /* First two chars "你好"(4 columns) in 6 bytes */

We also should test utf8_strwidth() on the same string here.

> +/*
> + * Test edge cases with partial UTF-8 sequences
> + */

All tests before these make sense, but I am not sure if we want to
hold utf8_strnwidth() to the requirement that it will tolerate "len"
to end in the middle of a single character, as such a requirement by
itself does not do application any good.

A caller may have "你好世界" in str, learn that the first 4 bytes
would only need two display columns to show (i.e., 3-byte "你" plus
a single garbage byte, that would make UTF-8 encoded "好" if the
remaining two bytes were included), and may want to learn how to
show only enough to fill the two display columns.  But there is not
enough information given back by utf8_strnwidth() for such a caller
to figure out that it needs to feed only the first three bytes (not
four) of str to printf() to do so.
