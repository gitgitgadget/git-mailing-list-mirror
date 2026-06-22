Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9493AD526
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 12:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782133026; cv=none; b=I5oycl0GG8GcaF5ni4eFZyVs6BUTuJYIisRnLph3uZeBpZv0sgxcs0DlCl+1xwR0O5zv20w+TtQdYAxXFmOQfv0tzcibui91gsAYuQqabeDrfBLqqp4sz4VL+J+1O/EWPQYNFgQ7abceOP2W1asaauuOmB64quZq0RmSHlg6Djo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782133026; c=relaxed/simple;
	bh=jxU7tfK5M4y9gvYHpdKhj3XrHMAdgyJIFKiz9arn09I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ga3FjIR6NDzvv/iKSdyldMNhxmsHhOr0FXriSH7ZSthaHxoSUYhIzQi4gj6+266fSoUvEX5SYL10T+MoozRxt8GiuItPyGKlXXpKFhO6PeG33Y7pmuoGv08h+VDLBsxq+qwFf2Ur5bLnkSsT/Oap7wzKoMFTo7NQUTk5MCbA+VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TH8vn+LO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jzQ689Eu; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TH8vn+LO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jzQ689Eu"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B6C7B140000E;
	Mon, 22 Jun 2026 08:57:04 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 22 Jun 2026 08:57:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782133024; x=1782219424; bh=JrYg5km9zZ
	EfYhrascTde0vC72xdo/Xr3veVvXhEyKs=; b=TH8vn+LO/tzALn9WPgmUuqXnv6
	2HhgGDmiSdom5SOeTxgxpZAvWH9/tgiIutFnw7Ghn2Oqonvd0EEllADaMuh1UeYc
	abRmcdwjHp3kB6pJdJitcB+5UCjr2ICq7aCAQW+Q1vgO3ptXDZ55WBx0CEAJJSaV
	8FFH0AkjoHa8HsiBCEndaoRe2juO58FqY+HvXawkX/aVteVFoSrwvCmDrLcRu6Ol
	EBgLUXRUwRky+gV06ed/hSQcleyPGxM73vk/XJD/tyI8qIYRb1JqZjmfMH+YS0Xm
	M1sQbL0/KVL5boRSBCDwNgsftJNz5VAmF8rWktOv4QcEpCmSt1mA6yywhpmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782133024; x=1782219424; bh=JrYg5km9zZEfYhrascTde0vC72xdo/Xr3ve
	VvXhEyKs=; b=jzQ689EuWYo0PQ+knuY42N95cnMN+leOOtQ9me9qLZhAv49MXan
	bWPqdLuIwBziza2wn0K19WJgOxI9YnQRAQzFOUZrsX0JQPQV8pWwMnj5A6zE3YKN
	rcZ0AYpT81soAXpxlUBSrZRrm1NHmRyXu7lFNEUkdNYnaBC5k5KztSX6y3N/RwMx
	22A4T3aqQYMfx+S3h/ZJHRtXXPwTRAqX/2Fd+Eq/NCAanZIyau1zPG3XlUpeNlu2
	/rICJcgEW3782aaml8uWEyM3AfjeRXBEUf12e24/dNbJ1tJ9BJiDPZtSHzGjhiYG
	uL/P1f9FcvkT9heA09U2b3X/NO16sRfCA7A==
X-ME-Sender: <xms:IDE5amIqlEBo91YxA1EFLvkjrsJQ2_L62uJbQyIpvpkHfYr6uD_M1Q>
    <xme:IDE5ah1Z86IKDnxfMf9Rn4j-APKDg1j4au5IH2Mbl34lhXsS_5nx34EgYVegLBVmv
    jsbmsFYuufUbs5M0G67rwTCv3QPvgd86P3qmbEiqJYlCiCdmtBnqQ>
X-ME-Received: <xmr:IDE5aghaLJkU8PQSNw2vGU9bjcivpnGHIS_oXJcfKiK_U2PPSmKYqJXa9C0Ks24QxRvcV90TQ-noWt_Mx-6ceWwG2YwzGiYNQ0bWMbQ>
X-ME-Proxy-Cause: dmFkZTFoNUx0pPUnqGaqQ+va8TgeRxDQAUMTA4iWAUtD6649Uoc7n5J8hfwdPLfDWraXpa
    87/zlUZKiW+cEstrXjEfb7Eoh6SivqL5AJVW9D1ZzNsA2N3z8PK0WJxDCvy5lpEK8cKBdU
    2h3zd2ELCY9JEqu5coqfkzemdOmF2cdC9yWmSn6tE9gYmbf8HZxno6UyObPPJdCdfgpu7y
    fBAbPMGks0ZvG9mYVo5Miq5SgbjXXEsTPg+BChyurMYX8/vlYYBLazyBrwwoVAAxuFndgN
    7xb8MdKB+87jGtjSzN0H7AWcQyHXlO+zBWCHqXjM4gFty7Ola7PZcLJW6Y9SLzopYQl3QT
    HlUAJXup/l6UPWFyTgFJ7gxKImvaxpHTIRNNM4eBc4HqtBC++wras/9JskA5Gx/ilyKQaG
    jCgjgN/FsF09KMN/KT7iyZ6aWUhIdSMC4DyJ7Nu2yea+x+3iB33ngqiVm6qB+nCUeeL2bO
    J0gC10Z7rrVhbZSiQTuuAE2nHwhSpwHHLlErqNqCCO9L5sZBTa2JfWjTarxWceKuaYOjO2
    ldaaZ9pbcuJXlvjvTDDcP3Fwoby+FacojHZ72MPXvY+/3WmMK8tVl+fBZqDhD476+Kcct0
    nnm8xy0IPfGryXgOpy2ZgqecuV/3O3HbVv73o3sgrPDPIefES2j3Oqacjslw
X-ME-Proxy: <xmx:IDE5aiX1EuQvBaObNTgMeNRSALCXSzVrueB2d-jY6QkXc64GnL4eyw>
    <xmx:IDE5avVt456dMhp69iN9fbf1dayuluWyil83Ci5ZLkUY7oTrnzdevA>
    <xmx:IDE5aigOrF4ByO_-iSUtAttTGbyY9QqbneKnLNl-V6FRKlmsry9yCQ>
    <xmx:IDE5aqZt4q565EkxWjrdklHAdnezkjUi5zzVeytXv0dKvH8NXkmmJQ>
    <xmx:IDE5avNIF9Hx7EgIehjq54VXFl6vqynPFyIgVyOkKGBOoYBL2qXToM6q>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jun 2026 08:57:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>,  Paolo
 Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3] config.mak.uname: avoid macOS dup-library warning
In-Reply-To: <ajjspU7lJ01GgrBw@pks.im> (Patrick Steinhardt's message of "Mon,
	22 Jun 2026 10:04:53 +0200")
References: <pull.2314.v2.git.git.1780610623006.gitgitgadget@gmail.com>
	<pull.2314.v3.git.git.1781901127385.gitgitgadget@gmail.com>
	<xmqqv7bei2tf.fsf@gitster.g> <ajjspU7lJ01GgrBw@pks.im>
Date: Mon, 22 Jun 2026 05:57:03 -0700
Message-ID: <xmqqldc63f8g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> Yeah, this looks like what I expected.
>> 
>> A few things to note.
>> 
>>  * Can folks with different versions of Xcode (or is 15 sufficiently
>>    old that practically nobody is expected to have anything older?)
>>    test this patch?
>> 
>>  * We only patch Makefile here; can folks who use meson report how
>>    well your build goes?
>
> When using Meson we also see a warning. This got partially fixed in
> Meson itself though via [1], where it started to disable the warning
> when compiling with "--fatal-warnings" so that it doesn't cause builds
> to break. So starting with that commit it really only is a harmless
> (albeit annoying) warning.
>
> Arguably, it might make sense to unconditionally disable this warning,
> as it doesn't seem to add anything of value. I've Cc'd Paolo, one of the
> Meson maintainers.
>
> Thanks!
>
> Patrick
>
> [1]: https://github.com/mesonbuild/meson/commit/17d1cc60ed8246b8e7f0786421bf1cdf5cb19254

I took my inspiration for -Wl,-no-whatever from Paolo's other
attempt, referenced in

    https://github.com/mesonbuild/meson/issues/15553

which is

    https://github.com/mesonbuild/meson/commit/7c901d7a8af214e31788eb6d1a1edd5b75124e66

