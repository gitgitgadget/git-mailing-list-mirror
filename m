Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C22319D07A
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 14:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782482580; cv=none; b=Z1AF9ab2mbg3w6KchA+Jb/F2sVaBPMkBMcIJ8wLgaMSfEe6TBr4isCpY+e00eFa++IronR3sLmgb4K0zc/5MQkPjhuZpk9317DEEhnDkur6I7J6et+Rfjo5Hs6xO1cUZK+HrDbVLctk3Qdjo1k79FXFKAORUTiNmp+Pg+LzoGRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782482580; c=relaxed/simple;
	bh=L75PnqodrQH/g6DlmebXPsYYgujNmNkt+Px7ZEH2dmA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZBoAOnUpMYBJavXgLC2mIR11OZvBDR0uUy8dvBXsz0BemDFsUvafK981xlhN1rkUWOrqNNVFM8TKHifZ3QSKJZzogLrxvcM0bu7v8KDDT7MEWuHgiNvoSldJEQuhJ53Jpt30aQ/aQAZ9tTZ9WBpXTSdxhmECRYXc4L6rcqv2mnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Qorgn3hm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Lzq8w6y8; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Qorgn3hm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Lzq8w6y8"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2D9B57A012D;
	Fri, 26 Jun 2026 10:02:58 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 26 Jun 2026 10:02:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1782482578;
	 x=1782568978; bh=xFFALmIK4XXhJyzPbg12e4kOcqkXFkDIJb2w6pxjvNc=; b=
	Qorgn3hmLmLPPFNE1MGoBlnt+pWY6AI2E5fkFQUDRbIUrQRnHwXPXTEs6Z0Amz3W
	kdZI6DaMrAjXmq7iUuBX1VTCfa6jInWhFsunyGgnoNTYMy3I/iJYgBUC6z3hA8Y6
	H+GI2D4UHg14x1HRdX56ClUWyUu5VYOtpbdoXzT90r19lv9fcjxhoXN6IN19OPLZ
	MqceFB6QIzE6TtCbqWKC1sArpOfaBOP9h2qza7+gfciI7S8JbivAKDMmBSHc+szD
	c+FTPjIlSY0HJmzX5v1or3N8UuqNcOBqV1Nwd08w33Z219MpNP+haaO2XC9lxN1f
	1DfA4rhfGuBv88nZLwO+xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782482578; x=
	1782568978; bh=xFFALmIK4XXhJyzPbg12e4kOcqkXFkDIJb2w6pxjvNc=; b=L
	zq8w6y8P8bK7qHOxtlk4X477Ndqge+HJt5UbTlqsbxEguGVFoML3cU+xh9A4ObLB
	eBjJLAk/IxGZUr6NjFQbl0SnWQbgD4qDxWw6+Tk5kZB5o60tSX+sgxCG6jR3WgZB
	3OgpJW75CPNCqJplwCYaNUJl/dygF7j/VyKA3rpwB9Tcqraw/vhMzoVPgr1kFmvc
	JWJYJQdYXzU64ukz6t7vF9PiyVwXhvAB2qw8sybL/CLpXkuInJ3AwW3cASxIN1cL
	V0l8dOa3aKuXUvn5g9XLOZDSM2tYz4hsk4K7WRp8bO2rJoBrjYBAsJujOeipR9Rx
	ZFqOTmprCg30O+4iX6YPA==
X-ME-Sender: <xms:kYY-ag13_mxoHQZkKue5GNiPoL6-BFjwJQj8UcijbNRBEzA9yKF-og>
    <xme:kYY-arzM-ZsEdKr-17j1wTFWJL2u1bAbSPk1icKyCZaixewbOfsZMnfArc_ADqOFp
    -w_NMoO7S6ekCB1vfurrAVan8PCajgqJB2Cy6-cbYWWVXzrBz2rSw>
X-ME-Received: <xmr:kYY-anHoUeTcUoXyak-gHgVFwyflpXZjWN40FWGtfccYjFuIM8icrO1VhGo-UbHgV4I6yIPVgHgF2luPBY7f4O0sc8J9fe8jKHFeiuI>
X-ME-Proxy-Cause: dmFkZTGAsk4eCRN2D8bgVnfui/JCf/9joYw1CAcwFCXMma3TlZ5WMmb6MFAtbAl7rrZ0eP
    H0YWd6pmqbNgYcYoaBHsPmcQjQiOkUno5mOddViAe17PMkND/d/25g2547F1qtzBhkFDK3
    +cfphmfkpWsxxYp54I5SgA2aw5/HotTNUqV99zqTW1U6a+En2QR2frvq0NECR/qBkE6RKh
    GbF74BB8HLi6EpEPoZuOWtfjDoVJ+WVkwWkKN00nAAcDQnyCHt9KTv6Pn6cjnq7kiIIT1h
    kZ7pcxJQK/CHfXuYGHQtpoUKpPNO25fnQpQHKyMhtGykVrsyD1s72UMHPdSBxz+HjF5Anc
    2qgFAmmX+06uxYTgXlAD4e8/GTnAFQzO0nBROkCZcyyK6DYhduLukA5jcjmHq0LfrVNKjU
    F+2k6QIVu4JJoQLNdUMQ/Q0TS5hNaKMuJGXz3aHUesbz1Y1dQhJ7nE9hLt/ScsNz44jmz6
    Puh4AXLH7goQyGhoYC4rC6HY22XconNG3sjofUmPK7vU8TRitrG8a4oJl9C2mU2LIL47yj
    SGb7qRi80d8fqEHSSEfWRmGnySMW7XPzqEIq3LI7qVkU1XNDbtYsS0FB/d5EVEwj77EQSi
    1MiCEVZG+d/MgxXoXyPNfnBg6sddZ5somBfbeksr+bV8WL8oAkeZ1kAjPJag
X-ME-Proxy: <xmx:kYY-aubdLmZsCPSYHlZO4afnww_VNYv2kcDWs_UJquA2dwGn6OTrog>
    <xmx:kYY-apB6MxXCye4i5g86HvMBP-LiSDnT6CfusRFgorrPTg0aJMR_1A>
    <xmx:kYY-ammKMbJ0VYlMZC1FGYQC-gF1mv1Acaew7c12vKpWgYHAYF5s_w>
    <xmx:kYY-aqwCy5sMGFS6rDGhSR09wtGJDijwWpFjERzx_l_AgsYbWEU78Q>
    <xmx:koY-ap3gKZUkPAg854-Lo95BxN4m46bzGfNZFmk0ylO-6wPxHWH5G-RY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Jun 2026 10:02:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Harald Nordgren <haraldnordgren@gmail.com>,  phillip.wood@dunelm.org.uk,
  Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v5 0/4] history: add squash subcommand to fold a range
In-Reply-To: <4654a3f1-bf79-4c3f-b121-16bb3ab25f07@gmail.com> (Phillip Wood's
	message of "Fri, 26 Jun 2026 14:12:41 +0100")
References: <pull.2337.v4.git.git.1782021195.gitgitgadget@gmail.com>
	<pull.2337.v5.git.git.1782338102.gitgitgadget@gmail.com>
	<d37e8f4f-d1f9-45aa-8c95-ebe676d54671@gmail.com>
	<CAHwyqnWXaG1HGunztVgUdWnVogqCHRbxh8pcS5fGA6f3mB-nEA@mail.gmail.com>
	<4654a3f1-bf79-4c3f-b121-16bb3ab25f07@gmail.com>
Date: Fri, 26 Jun 2026 07:02:55 -0700
Message-ID: <xmqqh5mpcsc0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 26/06/2026 10:57, Harald Nordgren wrote:
>> On Fri, Jun 26, 2026 at 10:53 AM Phillip Wood <phillip.wood123@gmail.com> wrote:>> >> Only accepting a single argument is quite limiting as one
>>> cannot say
>>>
>>>          git history squash ^:/base :/tip
>> 
>> I don't understand why this is limiting? It thought it was clear that
>> it should be one argument REF1..REF2 ? What does '^:/base :/tip'
>> achieve that '^:/base..:/tip' cannot?
>
> '^/:base..:/tip' is not a range - everything after the first '/:' is 
> treated as a regular expression to search for.

This particular case you can do

	HEAD^{/base}..HEAD^{/tip}

(or even go "HEAD^{/tip}~43" and fancier other forms, the point
being with matching {} pair, you can do more than what the lazy
short-hand form can).

But I think your point still stands, I think, as

	git history squash HEAD^{/base}..:/tip ^main

may be something you would want to do to express additional
constraints, like "I want this range squashed, but I should never
ever touch what is already in main".
