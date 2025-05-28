Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC51221D98
	for <git@vger.kernel.org>; Wed, 28 May 2025 21:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748469583; cv=none; b=DGqbqSznIwD3XjaZiCdtypInHPNgULvCkNj21+bNcZnl8BclJviya7ou9LH9q4aAUQjpGMim3BDnZ+ydI5T1O2KReM6lWDNzzlLZvz9cl8rii+6pOaPhYNvMXoCTzMCUzpwXEGPZtEW2JqU8SemxwTlsAUbrnvQ5dK0uUbBviME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748469583; c=relaxed/simple;
	bh=k2AZuFYCTJWo9t9XhTLA6sI1x4L07AlgTKopaBn0F3I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ncGfzGiYlSdGoSBRiiYazglNX3ZP3Tnn9hOKa1Mu1pAy8om9mRym5txp0gRUxXh4n4LM0JMXDyC7a8aO7P+ZRl76GijTCTk0Dy+W0e8CDVJEBoW0msAtHgksa1wHbdeYnWSyav+xfVnVDYE+27JZHN8e8AAvj/m4Fwq0cmkaL7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=yl9yl8mM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fU3UY/rS; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="yl9yl8mM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fU3UY/rS"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 50EBD2540106;
	Wed, 28 May 2025 17:59:40 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Wed, 28 May 2025 17:59:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748469580; x=1748555980; bh=25VPMgsJPv
	CUa67adX+K2WK4cEAZtbQIfP2lumSPGWg=; b=yl9yl8mMn7s9jP8ByooqpcWEN6
	OcyOiVlgIFFxgCOxoRBiRiPXbIBci3SB67KGhRRyvaCmtsBGjzW0mmYJIsRV2jZs
	jiYqfUFV1v6OeTQl86jH75lV81RaqjpKYWKqJkZeUUs+t9ITaojF5+wP+ae4j5Bi
	tsmX+kw6C11Q1HoaA2PwuguAvQt8WRzhLTNwga31eh/Hm4xFHC6w2pKHYyYJYwbh
	se/Zi2VbetQZl+WfmWdy/6biKCWg4xzH9onwjHoY6yP0k7b/prBNAbl2KhfGH4AZ
	zJyT7UXhpq2o2R8tppq86I4MrOwMJmBqh6VF0TiqyhdytmtkssZSM0Z3uZVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748469580; x=1748555980; bh=25VPMgsJPvCUa67adX+K2WK4cEAZtbQIfP2
	lumSPGWg=; b=fU3UY/rSGypUDwUQfZoJ4u63+JFhZQMhEew4H41MiIsGI8xNwP1
	hdDzmtfO9UzlsCmrjdcCsst8Nv1gP395v5F+4in1cWMUa8xCwfBRwSI30Cw6K3YJ
	ouCOHEvJuUrmKZ0OKFah3EKCLbRHoIHTW8yaQEVy6th03j8Ewt79IAVGyaWPEhPG
	YgTH6lYjAX7Zp3eLfAfSl5ss2FOnxgxaSuxdOSAQuCCpIPT5ANlkBcIp8GcozD7L
	lgBP1NrXjSpNE8cHD4FkpF5XYvEBNcbJyL3/SRDKBS/KBHSQkcFBxlktnxT2BDPo
	7sprDu9bPiGQtUaayYVhgPEXQuU2a5CggMQ==
X-ME-Sender: <xms:S4c3aBgABJ_4ITclXgqft_C3fnUZ3195Qp3svDXvxvd7RNDAdK2MYQ>
    <xme:S4c3aGC233qvlGkxQnF6Jtb8ueqMXBAZEnB-MlPXmSSoLzyiUmdoe149QOwczr2n5
    HypLEBfpkxEqH1K4Q>
X-ME-Received: <xmr:S4c3aBE_-6bXY843s4tpmjy6UtQeNybxxs7KjRRvMmPtc3iYBtPxBwwxo61xmOvOXOLGYJOMDgCDQDc_KEesp2g_R_W4KYbS9Qdisd8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvgeegudculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteej
    heeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhsthhi
    rghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehluhhkvghshhhuse
    gurghtrgifihhrvgdrihhopdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepphgvfhhfsehpvg
    hffhdrnhgvthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehg
    mhigrdguvgdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorh
    hgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:S4c3aGSMMvpnadAc_2DwW5KIvHC0YLLlmxmyETZag_-0qjACKQ98VQ>
    <xmx:S4c3aOxiG1Kujl1-cHIRwN6xGtR9zqbeI_BO4ar8F0I-fSMrHTDclw>
    <xmx:S4c3aM7C_-rJ0ShIwukVOtG8oumRfv9b1i9j6D7JfHvPlHdgei6fkg>
    <xmx:S4c3aDyXcITjWB2sHRudTn5RMlBnHFeQ00dUGikpptItB0hiyIPA1w>
    <xmx:TIc3aP9wdXtEx-cmTRKR0jF_WrpMPVs71jEmizcqKwZgBnHJLoJTSlzO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 May 2025 17:59:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Christian Couder <christian.couder@gmail.com>,  Luke Shumaker
 <lukeshu@datawire.io>,  git@vger.kernel.org,  Patrick Steinhardt
 <ps@pks.im>,  Jeff King <peff@peff.net>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] fast-(import|export): improve on the signature
 algorithm name
In-Reply-To: <CABPp-BGe6r-X7NOiBFEvLGZH+GQvLkOYWn+qf3ZzzgT4sGAyOg@mail.gmail.com>
	(Elijah Newren's message of "Wed, 28 May 2025 13:06:42 -0700")
References: <20250424203904.909777-1-christian.couder@gmail.com>
	<xmqqselxtfyf.fsf@gitster.g>
	<CABPp-BHudzADoYdBvoBZ1yDRj7Ra_V-or6ddAOV6nmXeMMpMaw@mail.gmail.com>
	<xmqq1pthtbdg.fsf@gitster.g>
	<CAP8UFD0OdqnoFeYY+7y-No_x_DknapoLzvqvsy-+x_602sYQbg@mail.gmail.com>
	<xmqqzfeyqdye.fsf@gitster.g> <xmqq8qmgsky8.fsf@gitster.g>
	<CABPp-BGe6r-X7NOiBFEvLGZH+GQvLkOYWn+qf3ZzzgT4sGAyOg@mail.gmail.com>
Date: Wed, 28 May 2025 14:59:37 -0700
Message-ID: <xmqq4ix4qtva.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

> Often
> when we have deprecated or changed an option our process was to first
> produce an error and update documentation and wait a while, then go
> and change the default after a sufficiently long time.  Here, we had
> kind of stopped at just producing the error with no plans to take
> another step.  If that was the route we took in the past, what makes
> this considered a breakage and not the other changes we made?
>
> (Just curious, I'm not against this change.)

What is wrong is the behaviour change in the original, which luckily
is not in any released versions (except for 2.50-rc0, which should
not count, as I think we should do this toning-down before -rc1).

We used to silently ignore and strip commit signatures and that has
always been the behaviour the existing users have relied upon; we
started requiring these existing users to either explicitly pass
--signed-c=strip or set an environmtne variable.  A new feature
should be opt-in to make the transition smoother, but the topic did
not follow that pattern.

I view this last-minute band-aid patch that flips the default back
to what it used to be as remedying that mistake in the original
series.
