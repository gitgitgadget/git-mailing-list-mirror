Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4351E5B9A
	for <git@vger.kernel.org>; Sat, 20 Sep 2025 16:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758386701; cv=none; b=dC2Jj3FssyJwT0P6qEJMPzwQLn97FekdySUSVCxEL6fVop7wKLgoYSlYiLqDIkFwj4vQaYYcN3rkf1j69xT4u9aa/0ClLtyhXEnR7PbOgXD221UcEgYKm+eiWYrg5sHnUMz/o0Hq0rQtz7fHCU7LFpMZb2ROUwOgZ+13UpNhv+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758386701; c=relaxed/simple;
	bh=wVdFz2LgGb+LD4sP8kUQclgMDXq6tRkhOfZuMo4i0AA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dRPn/dgg/TAA8Vhpn/BIfWQBoXWFbMxoADD47YpKqhqv9kxLRY/TyOKyO1X7nmaRSBGdCa7WGisrQFK+oWUZS1qN9cKMFdJ4e7EoYDWB2IGpoIkXt9LXpxsC/NY1IBGNu0+/Xvx4sMnltn2nQw2ZsHADkRceiHm99uBRSc2G+t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=R0ZXW0jB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=En4hKtsZ; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="R0ZXW0jB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="En4hKtsZ"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 12D1914000BC;
	Sat, 20 Sep 2025 12:44:58 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Sat, 20 Sep 2025 12:44:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758386698; x=1758473098; bh=cRd9IORNOd
	ehBgJ2gJL/mkhRhfs0fxmDaX5juDXw2Fw=; b=R0ZXW0jB6U7HPEQwHeGdEL1rNP
	ishakytOrp2IFh4Ehs7zeu0+P6htMa++Pu03Mm0mjyzLNmCfpRFUm4jpQ6QBkD/G
	VQKA2fLXMm5bxBcsukMKIPUxJC109IoLudRJtDqupcdGu6GLop9F2mdmSSxqppOt
	EYHr94KMtqif2RaNN31VxlimWszrBV6ZfG8x1D8jtPrG7d2HaRCsX527wptWXtny
	+xJXpo1ck5KVXzTI5NRTe9O3bZPKt+CNoFX25PgLj1yNEW84MCKpuIXsKfJY+lZS
	1ozXA+iqX9VIR3oLvu1m/wCkUt6GKZuH1T0LLg3oadXsOe2zsvsMMhSyoBVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758386698; x=1758473098; bh=cRd9IORNOdehBgJ2gJL/mkhRhfs0fxmDaX5
	juDXw2Fw=; b=En4hKtsZ/tvOtBOYFAr1o/eWWK+Sh+WwGFibjdvVxRm+4QLbYUq
	OwW70B7lQSZMyqgDTYv4MKdHGLfp/7NGEZF0lUZVrOAuDH1fIDq2Gq4TVJCsoVrE
	qF5djYPiD8QGc5SuctcAPcJvF7tZwG3Ishy1QKfKKLOLc3hzEdWIZ1SMxVpC1NID
	8OBoJxykR0NUHN2zWbjamIrCLGD7eCdhOjbknbLi+95jA0cay79lLrOiMO15SlN6
	DW6NWfuNT8Ll/N7x+/xSN3c7B2VfVotVgYlRBOymGLlVvn4SpGqOYoPiMijLF56j
	qJbUp64SHi3773sSEnf/F2UI1mxdaj3ZeDw==
X-ME-Sender: <xms:CdrOaK0cHlYxh5xtEgT5x32df7ZzTKeLaxE-2wFUxCNgMFK8lY521w>
    <xme:CdrOaKp_VRlMGPQfmXZqVPxvBE4HXAhoxGBwnj6qv7MyyNlY_V37WfH8lasRx4LYm
    mxGSHPDzxHn74EfRw>
X-ME-Received: <xmr:CdrOaJWFgUWE60Fql0W7GqYJBjp9HC4bYiKMmf7094CDUJtI-b1BnmDyEmFoL9vc0llH9bRPG2UAGsmefTJ0LILLrF4UTRcvxZjb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehvdeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpefgtedugfdtkeeivdevleehueeuteduleejtdfggfefudekvdeihfefjeevvdel
    veenucffohhmrghinheprhhushhtqdhlrghnghdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgt
    ohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    gtohhllhhinhdrfhhunhhkudesghhmrghilhdrtghomhdprhgtphhtthhopegviigvkhhi
    vghlnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvse
    hsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghp
    thhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:CdrOaNaSOpntqPuPKhnFwk_8j3YD5cmEnHIS5j0vvUGk9-7N8C2S7g>
    <xmx:CdrOaOcociEXni6zlNyLF422tYV3ixPLIsDf_PC-Fk4iWWdIcYmbwg>
    <xmx:CdrOaP1PKUm28PsuL5ZwtdV57T4fNi0c6cp3FGrmoGzp7X5KZ3wwmw>
    <xmx:CdrOaNJXGfZqbvi94DT_7vDWlAF27aNU721JFeZ2SlVLHguwRl-QOA>
    <xmx:CtrOaIhb2XS1nP0oq1K5njzEDurjHnyvp7HqYKTO7m9qrsmglCkATxdD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 20 Sep 2025 12:44:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Collin Funk <collin.funk1@gmail.com>
Cc: Ezekiel Newren <ezekielnewren@gmail.com>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Patrick Steinhardt <ps@pks.im>,  Ezekiel
 Newren via GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v2 02/18] make: add -fPIE flag
In-Reply-To: <87plbmyox4.fsf@gmail.com> (Collin Funk's message of "Fri, 19 Sep
	2025 16:59:19 -0700")
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
	<pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com>
	<7082e32c5975d2aaa277eddae7497eba0f2131e0.1758071798.git.gitgitgadget@gmail.com>
	<CAPig+cRGtMX9bQhb+7g5aXRVjpLKY-qDdQP95f9TmbY8j_BweQ@mail.gmail.com>
	<CAH=ZcbAOBnEVfyNy_4hdpe_dvsqDxsKVTcvurJz_iUWiqOzG3g@mail.gmail.com>
	<xmqq5xde435i.fsf@gitster.g>
	<CAH=ZcbDvwbCdnpeNv6vp=+Zy1h8RpG125ZCQNUzNOc5qLi8gNg@mail.gmail.com>
	<xmqqa52qypo8.fsf@gitster.g> <87plbmyox4.fsf@gmail.com>
Date: Sat, 20 Sep 2025 09:44:55 -0700
Message-ID: <xmqq1po1ysxk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Collin Funk <collin.funk1@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Ezekiel Newren <ezekielnewren@gmail.com> writes:
>>
>>> I don't know, but I have another question to add to yours. Why does
>>> Make need -fPIE in order for the Rust compiler to link against
>>> libgit.a created by Make, when Meson doesn't seem to specify PIE
>>> anywhere and yet the Rust compiler can work with Meson's libgit.a
>>> output?
>>
>> I do not know what the build procedure using meson exactly does to
>> create a library archive.  On the Make side, we do not compile for
>> position independence, and don't do anything other than bog standard
>> "ar rcs".  Patrick, any hint?
>
> Not too familiar with Rust, but looks like the answer is here [1].
> Specificially, this part:
>
>     pic - fully relocatable position independent code, machine
>     instructions need to use relative addressing modes. Equivalent to
>     the "uppercase" -fPIC or -fPIE options in other compilers, depending
>     on the produced crate types. This is the default model for majority
>     of supported targets.
>
> Collin
>
> [1] https://doc.rust-lang.org/rustc/codegen-options/index.html#relocation-model

Well, thanks for joining the conversation, but that much I think is
already shared by those who are involved in this thread.

The background was that Ezekiel did not have to do anything special
as far as he knows to get things compiled in a relocatable way with
meson based build, and with make based build, (which I know has
never used nor required any PIE-ness) he of course needs to add it
in a way that is portable across platforms and compilers we care
about if we wanted to have PIE objects.

And the question was what, if anything, does meson do specially to
do so in a portable way to enable PIE.  We'd want to see if it meets
our needs (it could be that Ezekiel is getting lucky and meson based
build covered the platform+compiler combinations that he happened to
be working with) and if so mimick that on the Makefile side.

