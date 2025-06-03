Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C13231A55
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 14:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748962464; cv=none; b=N3Ya79zfSt9w5za2UJrGYyGDUzRxXGT8co+1++jpnvKzw8H9CGqL+xfpldej7psvteI3fMDqaAZ+pxye8KMryPAhOFn4D2J6ND4XGUq4mLtVL8zifowSJGxZjJ+Nea3iMWMaxVk1QMDklXHgHAMMrVuVzSEVcxnENC71Mbpgsmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748962464; c=relaxed/simple;
	bh=ATjCcvqKZ25+zymCtp96IRqel+xqDD5iXICR3nvTjgE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DYgqNxPXVg0WPB1aAeKQNxszfH5bjyIRAkcgSkRtjyJPz1PmRtY0GDefiP7m+/j7SZKX+Jz7qCM/3XsMD9Pt6aAvsiL0bfWZEjGaAqbcjg8DXL+L+j+QF2w9c+NqRULKV6dgULr/AINXRyUtVgbEEuQcyTSoHK4suud0ro0NxfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vE6IaOF5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UnGKkbdz; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vE6IaOF5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UnGKkbdz"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C7CE0254010F;
	Tue,  3 Jun 2025 10:54:21 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 03 Jun 2025 10:54:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748962461; x=1749048861; bh=QRGmY1TSTi
	9LjyNCCvAVi+KRcrWg/u7ntFeAClF+Z4I=; b=vE6IaOF5lECcbMdgJ2F4Ma6oTF
	kOZChxHq+y4fYeLm1V+sy5/CtpSkPTHJVIWZzBEaDeghaAu0SYuU2lMoSVEjEfb9
	phRuGqURGnsaov5l6xG5z63gtFHZO3TA3mZ3lguodEi3klkFQCnrXzaogkVTjgL6
	iKHpUT4X/uiboHzrdeyOJrrFjJLoH6SNJB1sDvaKPcuHrLQbIINDu4vjU9ruWupm
	46la5SLg/PvwT7FmkH7oy4m0/O+KxzTbEqrM4oKC/H+ix1ZsWqeH53xSyzCpikFW
	7BpJ98PA7j2226nP94ax82NV4a8a8E8CCwPyz5wF8UmCNTMORc6rljNIp3kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748962461; x=1749048861; bh=QRGmY1TSTi9LjyNCCvAVi+KRcrWg/u7ntFe
	AClF+Z4I=; b=UnGKkbdzaWcWWPeS2r2dW6TLmdj+uqQVdQc/vwv+mVBd1qiECHr
	kgDVkBJ7exVAn/AHX76LkTGnz27mF2pY7t4eZ1N/7v4tVK18JjD81XzrcjefktuA
	Kz1jEqo0litBvNTgOOMjYIDPZvo22OpJDd1iFQUbCeyxzb834q67SVpsC20ZkORv
	z8n7eH+xt3UMLOwwYzYcnDRiAPiw3XzxOAYP15q7H6hSD6U+b5nBkE4C0tRrb01t
	ModJEod4ef5jrf7wC+WapxCCsCJbtsAo2OmU2Oq4l5MOfkJlJqh9llpTGhiG5BSZ
	MoHNtXn1KdjcFdoC9oU/l8AUF+BcnUzrZ3w==
X-ME-Sender: <xms:nQw_aAt4Hpyc5xrlhDhLcSdJiNgw99H_SoPHSeeUVjNgYAtzuqBt3g>
    <xme:nQw_aNca7VRMrl9TnlziNTjzNibj0ejH5QxYlRV86ovO-vhXz18i2ZSvN4-HckQ80
    XCYFlQlbhDBRR3Nmw>
X-ME-Received: <xmr:nQw_aLzvpVY5Fmww2NZjCZdku6kgGlTMNZ5f0xCZTQHhctIdWlDSozutwtXczcBRfqb6e8SrSVGCtEapnjNlOrTdkRh-dgidofIZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdehfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeeitdeuieeuveetheelgfegveduhfekvdeluddv
    teefgeehkeevleevgfejuedvtdenucffohhmrghinhepvhgrrhdvrdgrshenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehp
    ohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopegtohhllhhinhdrfhhunhhkudesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhnrdgrvhhilh
    grsehfrhgvvgdrfhhrpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:nQw_aDNnPUiarJUen8qx_kCnqvATeHadwduSiZC3HgW67R6YqLtCZg>
    <xmx:nQw_aA-HJIYa2NU9DVhJkaJcbL7ikpxZ1zPRczhMYm_ACyC_QrGbDQ>
    <xmx:nQw_aLWXn_Ppikwi7PvTSRWkPWzssSK6d1UNtCGr96OM2j7DhjOmlw>
    <xmx:nQw_aJfHuWANhLARkeHWPh648eLk0Rj-NuEq_KTov4ms0v3pFpnC4Q>
    <xmx:nQw_aMi2CQ3CxQIlV1VlPilQ3v1VKi3pTTlP4cgYC8_rvb4l7Vn9zk53>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Jun 2025 10:54:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Collin Funk <collin.funk1@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>
Subject: Re: [PATCH] CodingGuidelines: document formatting required by
 generate-configlist.sh.
In-Reply-To: <45c586122afab8ae3624be6963d64e770b7396b2.1748911713.git.collin.funk1@gmail.com>
	(Collin Funk's message of "Mon, 2 Jun 2025 17:49:12 -0700")
References: <xmqqplflsmic.fsf@gitster.g>
	<45c586122afab8ae3624be6963d64e770b7396b2.1748911713.git.collin.funk1@gmail.com>
Date: Tue, 03 Jun 2025 07:54:19 -0700
Message-ID: <xmqqiklcri3o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Collin Funk <collin.funk1@gmail.com> writes:

> + When documenting multiple related `git config` variables, place them on
> + a separate line instead of separating them by commas. For example:
> +   core.var1::
> +   core.var2::
> +  	This is a description of 'core.var1' and 'core.var2'.

As `core.varN` in the above example are all what the end-user would
give literally, just like `git config` command name in the first
sentence, they should be marked up as literal strings, i.e.

    ... For example, do not write this:

    `core.var1`, `core.var2`::
	Description common to `core.var1` and `core.var2`.
	
    Instead write this:

    `core.var1`::
    `core.var2`::
	Description common to `core.var1` and `core.var2`.

> +This format is required for the `generate-configlist.sh` script to
> +properly generate "config-list.h".

It is not wrong per-se, but this tempts people to "fix" the
generate-configlist.sh script so that it can grok the comma
separated list "again".  And when that fix is done and reviewed
carelessly, we'd again break some implementations of sed the same
way and we will come back full circle ;-)


When we standardized writing negatable options this way

    `--option`::
    `--no-option`::
	Description of `--option` that can be turned off with
	`--no-option`.

instead of

    `--[no-]option`::
	Description of `--option` that can be turned off with
	`--no-option`.

we explained that the reason why we want to do so is because it is
easier to "grep".  Does this "do not comma-list variables, but list
them one per line" also give us better greppability, and if so we
want to explain that way, perhaps?

    $ git grep '`core\.var1`::' Documentation/config/

Thanks.
