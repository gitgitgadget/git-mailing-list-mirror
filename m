Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A429C29408
	for <git@vger.kernel.org>; Fri,  2 May 2025 21:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746220604; cv=none; b=obMmhooeD4BpCBVY1rfoVFO8J1XuUsMYXs5+nHk7uqDba01Nvsom7nGFNUiWlzvmN1wecD1rUfgY35rjTrRaqGJ7QCSulZzbmsVu9gm77QQGjzyQLkuxgwFYOdDDihJo33y0RsyBbN8rw8tXFcIGUJF2WaHrkSASKoWB4/tzqRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746220604; c=relaxed/simple;
	bh=6ivi8MX3+Azpo89l6bkWx8mx4xnnnvK5GZFfKEdYMzE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qycDRmg+h+R5Vr9YsrRKADwhkadwhal66Syd6vOt2rwU5y4exbjZfm1w/t8g8yydjacEUxxx67xRv/TXH6sNXtXIAoF5sw5T4x4adYu1/qEGKOSQ9xtZcal1Zl34s9GRSh1qj7+TYdD95JsqaRB1SSm9h7ylyqNDOFqvdgPK+Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Y2S0JKaJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b8WGqZGD; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Y2S0JKaJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b8WGqZGD"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A60E711401EC;
	Fri,  2 May 2025 17:16:41 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 02 May 2025 17:16:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746220601; x=1746307001; bh=/AcUUqFNnr
	X26Ius2F9mS8XjdHkaKbdsX9OraYr760M=; b=Y2S0JKaJ+alPooP31joO97goY3
	CNm5rFg15Up8xPF4tqWXHouLhD/YFZR2QU23Pd23PDYtFZqmlEjqXl4XdAwOpeBh
	t/l5CCts8dS0S+wBepGY9mDF777zyLchey8G8KrugJwWn0XwjpwhLpjRXqQ7ySQA
	2SlHPgZbW1IdzQLcLQUaTWCtkuGEuqgGU9AqopugwK9KIVeFSqlaa+bSGn+Ar5dI
	jqe9HlvnQOcbVl+kcPrrkuPgr69wYy+Nu0wQiMQkMzulrEqUq8VuLRK7ZH8hkus3
	k9smMMdSlDbpwi3GImqbOuGDxCF5eMYUArsZOQ14i0HNIjdbplae4AlrrnMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746220601; x=1746307001; bh=/AcUUqFNnrX26Ius2F9mS8XjdHkaKbdsX9O
	raYr760M=; b=b8WGqZGDWfAv+O2eZDL2IdGUVoz/IO9tZB3N+Yc6RJvR0rZSTyj
	Bc6hkdgJOoNcGNA6JJ5tUVvsQDtWXRy7Uf6FXwaQIlOW2KxTAEq1ypiK6+A2XT3I
	yQSyaL4VietaOYPDisFLIKpZPwEqf1vi+dslgkF9u4tuP+mdp7vkljZjeHpDYH9J
	e96hvcPVudpEiBfY2LGXfPEENtF5YOCzjhE76Uis4nMWm7xQjrQRF/OJufIIkEOD
	3rhS5RwHAUD9NgKenhwQXzyr7rVMHJ+zwRC9CmjSUPmf90QnZppLdflTUJxHTOcH
	70w1RnasTq+Kfz6/yxV9iVYqZeXrR8354ig==
X-ME-Sender: <xms:OTYVaLyDS8g4CfyEgcLOOVKnOWMXjVwr3h0nxVIDCEhNrAPnfgMuPQ>
    <xme:OTYVaDQbyOG88mg6bZjIilOjD81sY56q5t2kuw-nAr4h0w0c5_0PzQ38f1lZknZ_B
    rKDW7xBWUU3bX8adQ>
X-ME-Received: <xmr:OTYVaFWl9A0s93_CGO5DM8g37oiPNLXHnvIHeEFKFVTCOtnHOGg9kc7F3a5e5NfcEV68IGRo7HwjYm6y9i_FkILl8f8LbS1-KCCV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjeefhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnheptedttdevffeuieeilefffedtiefgfeek
    veetveevuedtlefhtddugfeltdejledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshdrrhgvphhorhhtsehgmhigrd
    hnvghtpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghp
    thhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:OTYVaFgv9CKcvNDfrk3kS-5bjlACBpQNTR7vtGbbRmXJI1cDptXVDA>
    <xmx:OTYVaND85HWxjbwgxx0zvGGHfii6D4rNmPHO5hOlY3738xvbqoQVpQ>
    <xmx:OTYVaOIgSd554Jm-C3VhbIgiIYuK0XyPJl-_oA2XTUj5sJhYLUKgjw>
    <xmx:OTYVaMCdoxcUKUhTiccM5TfmynQG81ruCmuYwilZzwa82R77EOyaww>
    <xmx:OTYVaGK_lWqsCWU5dRbRFKIJgXRLEpy8hqgiYBEydrz8is5o8m9liqmK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 May 2025 17:16:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Peter Seiderer <ps.report@gmx.net>,  Eli Schwartz
 <eschwartz@gentoo.org>,  Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v3 0/2] meson: prefer '/bin/sh' over PATH lookup
In-Reply-To: <20250425-pks-meson-posix-shell-v3-0-01607a2e9334@pks.im>
	(Patrick Steinhardt's message of "Fri, 25 Apr 2025 16:11:27 +0200")
References: <20250424-pks-meson-posix-shell-v1-0-45e06ee4b6ad@pks.im>
	<20250425-pks-meson-posix-shell-v3-0-01607a2e9334@pks.im>
Date: Fri, 02 May 2025 14:16:39 -0700
Message-ID: <xmqqjz6yu30o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> But this made me remember the report from Peter [1] that Debian also
> faced this issue. So I decided to address the issue in Meson directly by
> preferring `/bin/sh` over a PATH-based lookup.
>
> Changes in v2:
>   - Simplify how we generate the summary.
>   - Add a comment to explain ordering of the program path.
>   - Link to v1: https://lore.kernel.org/r/20250424-pks-meson-posix-shell-v1-0-45e06ee4b6ad@pks.im
>
> Changes in v3:
>   - Stop claiming that "/bin/sh" is a POSIX-compliant path.
>   - Link to v2: https://lore.kernel.org/r/20250425-pks-meson-posix-shell-v2-0-fddc6123511b@pks.im

So the discussion seems to have died out.  Have we decided that
unlike Makefile-based approach, it is too cumbersome to teach the
Meson based approach to allow user-specified commands that have
different basename to stand in for the command we expect in the
build based on Meson [*], and what the v3 iteration of this series
does is a good place to stop?




[Footnote]

 * It is trivial to say "make SHELL_PATH=/bin/dash", but we do not
   add support for anything like 'meson -dSHELL_PATH=/bin/dash', and
   we only allow the search path for fixed-name commands to be
   configured and tell our developers that they have to write an
   extra file paths.ini just to be able to do so.
