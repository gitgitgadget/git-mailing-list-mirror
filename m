Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BD737701D
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 20:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773346818; cv=none; b=cIsjau+Rf4wf8iiaV/70FB0pcoJwB7ZmGGhINOdAvPtabhkiHPxVBzlTPVrZX4GRf74F11UlmEhRGxyuXU4INHzKFLZa9JuovvQFb6x48t/cwrZlsKxRhvnMp+n+WolTn/DnuVfs0CIFAu5Wyvfw/X4LLlnLf1kcUWdk0dmFb+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773346818; c=relaxed/simple;
	bh=kOHQQP91QRx7FHyIj3z8JpazhWJ2+2pawie3SPoAbsA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qhWGTMBGrZePHN+AkYgrAwd4dCqnR8vnhiURzhr5e2TG2tj8wzHnkwJ2cvr7eZH/umWrRgNnZD9lgzA1AWDHsLFSF50IU4s3kE2WKyVhtr3aWUvpBVtylqRRiXDGAmHHPc73MHjAByPQ3Jy014ENPrqm/eEhCfpJ3E/DupU94y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WP8QyqE9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xgFFKVNT; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WP8QyqE9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xgFFKVNT"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id E8E99EC0955;
	Thu, 12 Mar 2026 16:20:16 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 12 Mar 2026 16:20:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773346816; x=1773433216; bh=uhoirUiirn
	XIidYGjhLcEV8bdjPTq7ZI2Ca7d3xv8co=; b=WP8QyqE9zJZ+pqbNYk/BMw7cpe
	sXJzKZezkECeD2VXz2IRxwXGiu5w216H2lHA0D3TlFrIEcV75T0pygGvYlHCXKGm
	qq2508d4rhJnD/frwx7b3FhHgeqUsgqyEJ2TKli2PcAAFRZ+8j8RNbZd4lRvOckD
	WwsXOgCECdyHGwg93Qgflt3bnuLX/83O6laxXOBPl5SVtnqqR7sL7KKQv9fETbQw
	sYm1HGrIBInpXEvZqiqIq2PEk9R1UKrQUXmiAsupSWQ2l7zjrrK+4UNYacZPJgxO
	Tl6ESd3su0DlOQgMoCYz5ApuYD6X8PP9py7j9ApNKiQGOGMGakfsTMfttQPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773346816; x=1773433216; bh=uhoirUiirnXIidYGjhLcEV8bdjPTq7ZI2Ca
	7d3xv8co=; b=xgFFKVNTAKk2rl/XdmIdTpZFY5jlJDpzy5lRokMrvZP+GxBR/kV
	Yd2dO3fulLMiiiF+5D1dhth068HE5lX9Z5/co/egS5Ur465CMAC8/vpbNbcVCd+R
	9L9VnKyInrePxLldLSJQ0I6Pas7mtP1AiKlizWa3UOi8ZFXTYIlHuoz+0zLh1Lop
	hEw894zHW85iLp2mJOqn4Wn8h96RwJQV2O9MNKoNEfWdSh6AiSi9NexooSljO+iX
	C4WZswe7Y4tVc6DLc2HCXm+W0DgfGtvfQ/k6JYLvuSWz9Qo6kHbGvGUGnTSo6Y+5
	e85Yw2HZTwONW0dLmbtQAokk4TOUHVW673A==
X-ME-Sender: <xms:ACCzabzs2KUx6i-neGDeCf96GOxOLtsWVwHdPMHzC9ndamvYAE3yFg>
    <xme:ACCzaW_1zr5NSASVflSzUF5_eJ_IHqtyVjVutHPbMpzEapa6joUzD0RGGtmvzBmzs
    Cg8lvCLuXBseTOehLxjWuBYnslP2AcTu2uJtzWZsXlbEVRgqY-3>
X-ME-Received: <xmr:ACCzafKUt_t8mnhEnekNGxoP3M-GyPnJxlS2dSKzu6cMB83IHPPci8RsIgkVbFOYtm62B-iXn8j-UuNAVaHetCDAb1-1a2bxfg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeejjedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghn
    uggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopegthh
    hrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehpshes
    phhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ACCzacdGASzjwChsMM6M6-feeAutxnOurh4GEPeAX9-w6Ejr4DhcqA>
    <xmx:ACCzae-7CxpNcjXPbVi01i0SGZuBPuV_9QZeJuYk2ORemexguiquNw>
    <xmx:ACCzaZrdW7MVPrRi6_FNEirAsfrzsh6uHcbhbEqXpz5HXeRxeFNPxA>
    <xmx:ACCzaTAtNsvzFdzsWOvbK1zTJvL-6iMiPY6jUOqgn1HgC80tL8METg>
    <xmx:ACCzae9VfguP0wznNec43q3nLxP_SG5xh-7GscRG_8-iLsTSl0Y6MplV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 16:20:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  sandals@crustytoothpaste.net,
  christian.couder@gmail.com,  ps@pks.im
Subject: Re: [PATCH v5 2/3] gpg-interface: allow sign_buffer() to use
 default signing key
In-Reply-To: <20260312192228.481134-3-jltobler@gmail.com> (Justin Tobler's
	message of "Thu, 12 Mar 2026 14:22:27 -0500")
References: <20260311173147.2336432-1-jltobler@gmail.com>
	<20260312192228.481134-1-jltobler@gmail.com>
	<20260312192228.481134-3-jltobler@gmail.com>
Date: Thu, 12 Mar 2026 13:20:15 -0700
Message-ID: <xmqqsea4dclc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> -	return use_format->sign_buffer(buffer, signature, signing_key);
> +	if (flags & SIGN_BUFFER_USE_DEFAULT_KEY && (!signing_key || !*signing_key))
> +		signing_key = keyid_to_free = get_signing_key();

Micronit.

I would have preferred to see an extra pair of parentheses here, i.e.,

	if ((flags & SIGN_BUFFER_USE_DEFAULT_KEY) &&
	    (!signing_key || !*signing_key))
                    
It would make it more obvious what two conditions are required to
enter the body, even to those who well know the operator precedence
rules between & and &&.

