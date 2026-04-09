Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1379D3002DC
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 19:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775764338; cv=none; b=s7Wc9imtsQHsyq58kIpvShHD6Yinx4HARk1atJuMgllBe4748aXWK/YPXccRYTdsDYtNkpCdhNueWsaAQ2J2wZW9h6WaNdB361fiQ1v6+aCtbxdv1oNNiHAyCX0dGRh+b/TRf5+STE6OkV2aXR+vrA8K64h/kj6I9Gh7ffxI/Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775764338; c=relaxed/simple;
	bh=suZFmDG3kuPsc6Kqjj7LudoGXHJLtv3MIlHSMlrNvng=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BUiPM3opcTQ/s/oWYjuUGP2cEbcitYX5XJNpItE3CErLAYKa4aa+fg3EH/PKTW95bBl/wDvWg8+LtzSMmO9c6RPTbqZrxAj8v9XIwE1ioDhaPTDvuHYYIkhl9gZxehatyPyj624J9CRbmGXDcf7JPEHZLkuf1IoNera/B0JS3HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ErdIQ/AG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eenrzuS7; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ErdIQ/AG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eenrzuS7"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 4343A1D000FF;
	Thu,  9 Apr 2026 15:52:16 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Thu, 09 Apr 2026 15:52:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775764336; x=1775850736; bh=3FyOKcRpL6
	4gvIKgoIY1mFAjwVaaWyvp6Xa6D9+feJs=; b=ErdIQ/AGxyv8XzBLLzkGotVqb6
	hV0b8IxRUQPaspXw7kkib9Pia+f1T6k6ICsVL83ln9TMXVjpLjuakBGuBkwOOtny
	ICsd2UDI8cQBhjTL1MFrdDup1shIQ/LNpg4ZgnRtKkssBh0NLDAGBCEk+X1bZzDV
	qtwCIBt0aVZvYUuK4l+DIehDNPItOkx+N7XtwD2sPBP3Yc2YgOM4sZ/43Excu2q9
	J1oBFQccZ7QlE4yIPcazUeC6AojYy3pmXbpfnmoXNfHKtlGu5+EqSQJp2063b0f7
	7i+L1c2C4KjnTPmgXvotSyIrUxH43WeFsOGZbraPjzIoxe1NGg6kIEQL7Xrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775764336; x=1775850736; bh=3FyOKcRpL64gvIKgoIY1mFAjwVaaWyvp6Xa
	6D9+feJs=; b=eenrzuS7kpTccInPDgab94Pb+qBenuQ8h7ZmOsq79QNWiR50Kv7
	1xjtFAYa09leYmaAdiCTHby6tnsyTxrIjXnH2Pyg2PcYtpmPL+rXzNY8ut128kJU
	nhzISnPIhZQEnhsmg1v0/8vQk4Wx5ZI54LYaXl9l8ly1Q9hx1Dxphv6dmWerLIL1
	/khXru9MXuttcnca27jWXuKsiP/c6iHIWrrnOQApG1OEKOv7WTpagVgSG9mIUoSx
	M11J7tbd01fLYSWsvEAEyo8PTERYnC4pU4do4QJWzNG5lq4CXyvAWZTJiY/BYX8B
	8M9d+UP1iLXFDAIgt7mY6KNIni+w0y2HbiQ==
X-ME-Sender: <xms:bwPYafRCJeD1DRqF2UaA8H90g2RaO6WWUiJb3i3l75chMdK20D2kHw>
    <xme:bwPYaUf7ZTIi-Vt-f0_-iK0_JGa93axQZ9KS7hF4khu8_HMpOu5nwtU28_ZKr1Jul
    S6MlT_N5-XZAlHpsmC35INHMndTD9FLWraA-YgWHApj5x6TUzW3zQ>
X-ME-Received: <xmr:bwPYaeohZZX6BgR5DZ10T8WdRPPBg_6ov62Ya9BWqMnKcQMmtQYb_rWWWO-9JeTJMUKx9_G71q6t84QTHJd_jMesDXsa3M-xEA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvjeeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    phhssehpkhhsrdhimhdprhgtphhtthhopeihohgrnhhnrdhvrghlvghrihestggvrgdrfh
    hrpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:bwPYaV8cLYwnD4qdQUEnIlQlvbcq1rWz1vvq2TKFqt8dG8Zpg0-aeg>
    <xmx:bwPYaac9vCarDAtn-52Q8C947xcVX41M1YVGm4zY2WV_WBQeRJmadA>
    <xmx:bwPYafJortRURQ0Vp-BoOgoLfu3mTayM3nsZUBalNHEWQk_v8DlbGg>
    <xmx:bwPYaaiRrOmfwDEhvKTipSypvZR2cwz9PkcLN6M5YkDse0wzXuoq_w>
    <xmx:cAPYaZVphmdC0LqaOFQ5ytRJqS8F4KZ5PN13wjo0vtBMtlxGpOfAAQy->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Apr 2026 15:52:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "VALERI Yoann via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Yoann Valeri
 <yoann.valeri@cea.fr>,  Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 2/2] branch: add 'branch.namePrefix' config param
In-Reply-To: <80d1ffde9d3d55d0ff2b28219e2484fb12d543d9.1775731390.git.gitgitgadget@gmail.com>
	(VALERI Yoann via GitGitGadget's message of "Thu, 09 Apr 2026 10:43:10
	+0000")
References: <pull.2202.v3.git.git.1772802872.gitgitgadget@gmail.com>
	<pull.2202.v4.git.git.1775731390.gitgitgadget@gmail.com>
	<80d1ffde9d3d55d0ff2b28219e2484fb12d543d9.1775731390.git.gitgitgadget@gmail.com>
Date: Thu, 09 Apr 2026 12:52:14 -0700
Message-ID: <xmqqv7dzsyhd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"VALERI Yoann via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +`branch.namePrefix`::
> +	When a new branch is created with `git branch`, use the provided value as
> +	prefix for its name. Can be '@{current}' to use the current branch's name
> +	as prefix. This value can be overriden by using the '--[no-]name-prefix'
> +	option of `git branch`.

Even after reading the cover letter, I am not convinced why this is
a good idea in the first place.

Also, I am not sure if "current branch" really captures what you are
trying to achieve.  When "git branch foo" creates a new branch "foo"
out of _the_ _current_ branch, i.e.

    $ git checkout base
    $ git branch foo

with the nameprefix configuration, it may appear that it is doing
what you want by deriving the name of the new branch taking both
"base" and "foo" into account, but what would you want to happen if
you did this instead:

    $ git checkout base
    $ git branch foo

or while you may be on an unrelated "master" branch, create and
switch to the new branch:

    $ git checkout -b foo base

whose name takes both "base" and "foo" into account.

What I am getting at is that "the current branch" is missing the
point and it may be "the branch the new branch was forked off of"
that is what you really are trying to find that "base" in.

Having said all that, I am fairly negative on this new feature,
simply because it is too much magic and will be confusing,
especially when invoked with a configuration variable.

