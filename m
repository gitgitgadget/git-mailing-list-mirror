Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E05D40D57B
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 21:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782768096; cv=none; b=Efh9VsmUc70AYE4kc/CgSDMtfiH7cr8iSJhPsCCjvg6mu3jfQZOIY2+JHZuOtBYUd/7Z8QMGIOmbA+d4yZ+qU5RwOUYjUrgw7OgPw8xlRz2L6bwRf+7zuxGjESY1jo7Z9YpQq01Jt2NSqt0BXJGht/0hvbr+ofzrEGN3BsSb3sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782768096; c=relaxed/simple;
	bh=pxOiCOk/cnKYQJ1sk+MkBscShwPmejuCoZpsHbGJhhY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jNTSlw0L3679NmB/1YayS+ruPy3DLAT83xeuyFAWLsvVXQmb9Gxy0x2ejFEg5NIDSXAXOy7HW5kCyVNMZo69SrijDAi1USuZN+ibaMVSCTkQnU0eKEdKMO4FXu6FhbL25WnqXbAjCCCbLr97uxl61IREEjHSjfe1ZkF++42wQII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Js0imkiw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OjTffQ2O; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Js0imkiw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OjTffQ2O"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7759F7A009B;
	Mon, 29 Jun 2026 17:21:34 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 29 Jun 2026 17:21:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782768094; x=1782854494; bh=xzMUfeedgM
	tnipnQ08OPw2S4+jAIhgAN/KdoZw7qJtA=; b=Js0imkiwOTvG3KImerrdzL+onT
	jiUV1NuYQIW9SwmDDih8zYykyUJMs+Jdgyti0l30fWHUBRdAIIuGpIfnWk8uqp6E
	nFSuD5sB750NtAmC71i6FxEz3K3cxeEqYqotbzKi+QjFYP6dN4b2LgAhrJuBch2x
	Klf93KhaqyA8Ug4cdyBNCh0hAnaV+057eCdsSGf8t2eplY9MW+6mzwmokIpM/dGq
	B4zLew0tgrzgghqPaD7C/cGRmh7VIH55I55SF/BlRcWeVrQPZw8mXEWhK+X/3R0c
	KDV8b/chEFuy7wcn7yYm0yjAaQFsxfg4If4ZWAyrQgv9s+dudLiahWUbK/zw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782768094; x=1782854494; bh=xzMUfeedgMtnipnQ08OPw2S4+jAIhgAN/Kd
	oZw7qJtA=; b=OjTffQ2OULkpRF1xZr+HyKKX/Mx/ccxZOhsGAutHIJsDaVhc0vk
	64rr1+JcpG8NEPCOoFqMl7sORl8f+d65tDEpa8jAYBM5g81lbc/IjTGLGFoVZOX1
	QxYuDzHOtDBDqq/zTW0985d2F9/wCwYpdWBlXu3OPp9Dt7t807vC0C1Ojga9UGCA
	0hS0YXUsyDeCc9o5sKBefrTmEREUH0RQvXUz7lt40Z3q3CUnwWpjxJYGg/upFI95
	+XSjBLgZ06Wy70mLvNS2i2vxtgS41KSpnMD+7hw+Ul6mn2S3lclU4PgvjafU/sau
	53cjLcxabmaVjr+ObZoC8wcFwxBCtFEMqow==
X-ME-Sender: <xms:3uFCaodw9n032FqRwBOavUuRxB_MDuYQxGp113URpJs1RWfTs_gyEg>
    <xme:3uFCasc3SdgU8b-72_1NgyJL-qWq6jthdyYe7P_uSZGPY6-ODcKxsyDoIyWgcre_8
    R7VF6WNbBA_1Fa47y6smy_SkTmqAIB0NK_z73o4dkrLgeAtuB7_>
X-ME-Received: <xmr:3uFCarxlAciKn8EYySsN2aRleSBSSccQTVpI7LOglupd77Vqd-4IQ_jirn9Ihml4A6m3MIpn6TzzKCor03_dIWfLC2cfLAxOpne1KM4>
X-ME-Proxy-Cause: dmFkZTF7JBhc/pqy/nvZB/tP10WPdikgGPj6cZ4NR4vFUOtwgOXBx3B7t8GWlKbppD7Mcr
    1Yn19KgMT5K8lz7/yrbqRAKfOJTYH9RJMk3KInTmuNsf7bLL8Hoq8Hbe3xmyG6VJW0QfgV
    YBQS7qOWOTJw2BY0smP8Yd6Lmo3XBGnpem4dg9262sOoePsK0w/5C5WY/gCMERD+LmMQO0
    UeGLsF6/XWzsotTClhjRvJGgv8+ogJK0xRLWSAV2BL82oG+7vVaTp43LGJUIYRWYtKYXzR
    yvFoBfB+EIs9JsX/QjMndp4+XCYBEShKkZFa/970Sfp+uzwM21veoWJJergHxwR5GQKEon
    e0sOraGCWUQ8cR3Z/zyNdIozymHi5IxlBYsFrDxp4BA9vEIYuae1XWUtSG5/oAAfIV7Krq
    119CA1RAL16k0c6sqtsr0AiZUCTah7FbYGVhnbs4jsqJmFEWMD13DgvUEpOuhBfxXoGfpG
    OMkZ5sjZvJyaLawF29s3RC5SNhjUZGvEj6PjZpLt/vmsGHp9aOa/OwyauExq9kGXQKyXWI
    BCnAsAE+iPaglv9yHaPP3dnr9xCR+PW8v4WeARHYvPr6wXZhToZs8izLHtjCWnfKltQwno
    JWKZNhKUpzRyNnG6GM+uesvjy7hoIKf4NLUVO8Ht8lf0nr/XwzGY/pF9qVqQ
X-ME-Proxy: <xmx:3uFCaj-n_smU1HjE_idwfGWIvRezAE8qijolG3l2lE0QdylgA-vRkg>
    <xmx:3uFCajikeOP3d4ToAAphEchhmCEBy3g1JURv8fPasdhyJcJCF7wIlQ>
    <xmx:3uFCaqGb1YP6OaBYz8VFI2-Jgf1P6U76eYsqXHy9npgKynqoAlWGbQ>
    <xmx:3uFCai9FDJbd5-ngkvTMQ_d_3sMdNyd5DGk-X8x32CG27YNOop4efw>
    <xmx:3uFCapqkyRmx5_FT0W2QfGbWKcJ5nyS6FNSJyi5TmLGP_QGvJlfH4KaE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 17:21:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Michael Montalbo via GitGitGadget <gitgitgadget@gmail.com>, SZEDER
 =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Eric
 Sunshine <sunshine@sunshineco.com>,  Michael Montalbo
 <mmontalbo@gmail.com>
Subject: Re: [PATCH v2 5/6] t: convert grep assertions to test_grep
In-Reply-To: <xmqq4iin4e1i.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
	27 Jun 2026 19:03:21 -0700")
References: <pull.2135.git.1780559158.gitgitgadget@gmail.com>
	<pull.2135.v2.git.1781323575.gitgitgadget@gmail.com>
	<3a589ef7386303075413f388e61c203c4e325d44.1781323575.git.gitgitgadget@gmail.com>
	<aj93BE8MYatQAjoy@szeder.dev> <xmqq4iio59uv.fsf@gitster.g>
	<xmqqldbz4f1a.fsf@gitster.g> <xmqq4iin4e1i.fsf@gitster.g>
Date: Mon, 29 Jun 2026 14:21:32 -0700
Message-ID: <xmqqqzlpt543.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Ah, of course.  Michael sidesteps this mechanism by not using
> "test_grep !", with
>
>        ! grep dirty file3 && # lint-ok: file may not exist after --quit
>
> and if we realize that "may not exist" is actually "never exists",
> then your other patch from 5 years ago would become the most
> sensible fix for this line.
>
> It may not be a bad idea to go through "# lint-ok:" introduced by
> Michael's series with finer toothed comb (there are only a handful
> of them) and see if there are similar "look, the file we are
> grepping in never exists with correctly running Git" gotchas.

In any case, I think SZEDER's fix to stop grepping in the file but
instead insisting on its absense does make sense and it is now in
'next'.  So perhaps this topic can have a small and final reroll v3
that omits change to this particular line (and possibly fix other
lines that punts with "# lint-ok" if needed) and we can declare
victory after that?

Thanks, all.
