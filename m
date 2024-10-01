Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471241CB534
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 17:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727805500; cv=none; b=V9m0ny874ls9ckuobqHVyaTTL3ireOcH3kzp7Yw889s6ZnMlOBhyfiaTbI9sgBt5zW44twK2HG2QQuMoR7ict4nHr+HxCUE6Po3B02dmSx5M9RzCEHSMXAq5bh5OS2gUa+IGQsKwVqE+ovAK9FCSWj055V1Wd4CeZxVkQNt6AIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727805500; c=relaxed/simple;
	bh=it6/+t0jXKYx2AorojXOdTkF4OZwKTPK1oXi2kQU9kM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Xtq/3feLsC5nUNYYxSQTEXELIA6ytemPWD95OrzF5k20wWswE9EcxIa94A1uvLqQ53LbDZ909zp7UEAmkjQTc3BlbvCCiE33ZBvxY8R5A3TuY1AhJs+AY3MLOmp2jXs3/7KCkIVA28md+hNkjoggUnBo8d3UJCsHuzBXfbEkXSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RBiJgv2H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BOVpWh/o; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RBiJgv2H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BOVpWh/o"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 43BBF1140F64;
	Tue,  1 Oct 2024 13:58:17 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Tue, 01 Oct 2024 13:58:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1727805497; x=1727891897; bh=xVBKFMgmn6
	DwPGz7xFbjRsnvqdv9Zgf59zXgyedombI=; b=RBiJgv2HXkZreLYH/bk6qg4Rnx
	WIYBUBt0M1K9oLxXLTBvnt+DsDySw1ycafXJ6gEDgYpyW30DslUDDXgFaDXR42O4
	3YkFatsKiDzVwD5+Omp3+tEHSC8ypcR8dsWpLR2/2dB8RqHztzXjVEdu33se7lx1
	3nJSpUz48A+EQzhLZec40ZySwb7JAEJY/f2JrgkN+7FYCXw1muQY+1YjbCdW/1Sd
	pJ9KXDrUkqKQooH3xOBAIORFRGsO00ODgzpIuJ0U10oDQbQ+tdBWKvuhc1aSqvVC
	r3FovPtC7xI/qvPi9UBlNnkvrLAC8VQ9LmvSK2DQEqamCf2+csW4H1oC5YWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727805497; x=1727891897; bh=xVBKFMgmn6DwPGz7xFbjRsnvqdv9
	Zgf59zXgyedombI=; b=BOVpWh/oBoShyN1RXULOUT7vr561aUowiLb6BdST6sXq
	gSvOQaZuC43ATVsYTnA7U36Veg1oqcUdbQSHUGnvivaHI4Z9mFDuIM4lYiQycM3Q
	CM+IrNuqU5Ae6D/6mgSxr5mJgGHFfO0foFwteWQtkFGaUSwdB6zfAsL4ia+i0yb0
	dGQs8EJGKq195+IWyjyzwnrWJJ3Tua7cH++9y51GEmc+gr/mhpB9U/pqcVRY5P9z
	4w13zceuYZOEWsd1holF6HfwDJnk7Kk3WPZiBXafvplk78aRPdS+3P3QP6U4yf7q
	/rb2iv6qIAlgPQa9j9eTrs8IaThkUpNMhHMmDyf5qA==
X-ME-Sender: <xms:ODj8Zr7FngdqqXh5ctb-n0g_rP6vC-jFIPBGyvR8JcOCtiGVrKz-Lw>
    <xme:ODj8Zg4CYTshiIEPbR9gm4mXx4zKg4llkjf_vY8dieDhMOH4NIJaTuAYYWmtfrWPL
    02X2vOLGmv7Womzng>
X-ME-Received: <xmr:ODj8ZifMbnD3GgK_he5l7TUF-dywHqqtbKU8Tgp31OQSMpb8P0WMfvJF40LLdNBek9dA7BNTr-fvmC-SQ1Ty4FZbgeS_0ZvYYwaCuV8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddujedguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprd
    ifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhhjuhhsthhosehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgt
    phhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ODj8ZsJib7VOFaiUyoYht7C0IKp-b9RMU-DIvlgvNmvsvwc31IhnUg>
    <xmx:ODj8ZvIcQ9atfakNeDBBfhAh6IKiA-srhb061jQzWMlEaSUeYJF10g>
    <xmx:ODj8Zlxbk5LGk3E0VPvPm7_yjo7POD9rFpzxICdmFCj0LDafClQgTg>
    <xmx:ODj8ZrIfQEDuWfc-KqI2KbnYRLsbg_xeGnRYXliXzkX9GKXxi5uhbQ>
    <xmx:OTj8ZsorZ_b4gWIsUO41iVrEwQUHDED40351Aa0sVQWmu52R1z-WsXr1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Oct 2024 13:58:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,  Git List
 <git@vger.kernel.org>,
  Phillip Wood <phillip.wood@dunelm.org.uk>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3] add-patch: edit the hunk again
In-Reply-To: <9c7af640-ee3a-4a17-84f6-f56fee7efe37@gmail.com> (Phillip Wood's
	message of "Tue, 1 Oct 2024 11:03:10 +0100")
References: <21ddf64f-10c2-4087-a778-0bd2e82aef42@gmail.com>
	<4dd5a2c7-26a8-470f-b651-e1fe2d1dbcec@gmail.com>
	<74289d8b-7211-452a-ac76-f733e89112e6@gmail.com>
	<9c7af640-ee3a-4a17-84f6-f56fee7efe37@gmail.com>
Date: Tue, 01 Oct 2024 10:58:15 -0700
Message-ID: <xmqqv7ybyabs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> I hoped that change would be in edit_hunk_manually() but it isn't.
>
> I'm afraid I still don't think that changing the default is a good
> idea as it is often very difficult to correct a badly edited hunk. Can
> we offer the user a choice of
>
>     (e) edit the original hunk again
>     (f) fix the edited hunk
>     (d) discard the edit
>
> In [1] you say you discarded that idea because the wording was too
> verbose but something along like the above should be succinct enough.

I too disagree with the change of the default, but I would not
complain if we offered the feature to re-edit as long as it is
clearly marked as a new optional choice.

Phillip, thanks for being firm yet still constructive.

