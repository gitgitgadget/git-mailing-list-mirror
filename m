Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE638479
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 17:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738950560; cv=none; b=mYAQoIZ02147r5lIEGAXFU2dDtvCPQiSOoT/ljTbwJjS3AvB8EG8wdpbSQjR9p5BBVaFB9a5fUrqmEBI+xIIqCk3PbguzXylZocSEb+s2tJPqSgHPTCuyv8+E76TXOsp1mWyOf3uGU9spanaUHXsao9hkp1I37+kU4Vvl0qH05s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738950560; c=relaxed/simple;
	bh=YyfSzXRtVYg8VFUxB0cGtsHpIeMEZgHbpBDKXHKjOYY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NhSRO2EHujVJEMi06OLeapUJGcyQHiZLzaf4SlHS6NjgfDp8sOd5dKNVl1Hi4HcWUjgJEOnmNMK+Kvoypa31PZ0YjQ5wA9GSFl2QlBO57LfxdII5HBzmHVQL6BgfJ5jEvx0rj4vroauxf0VoRThiR4+fwMuFpmydMMnf6F6JwpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vbnF3kc3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uFFDkdTx; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vbnF3kc3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uFFDkdTx"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6A9A22540182;
	Fri,  7 Feb 2025 12:49:16 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 07 Feb 2025 12:49:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1738950556;
	 x=1739036956; bh=FN/kde0hlwWHjCmThL6g45Vq7f3eddgeRk+OnWke9fU=; b=
	vbnF3kc35DXZTf1O5O36MfovFNk2vQlzNIkUOag+glPHkhzMlC5SJlOMG1mh//X2
	cz+qTurqWgR/bekQmASUIZs7YITBvJHpjV7zaGRueAhHlt6M0dIinNcW8x4Fyh3o
	e+d+6HUNPGnbH3QIb536FSv3zR8sO1khiQT+ysSDscvBlIjxMdHLqFxocMTgPrWW
	/nVYyYu/1pt105zS2fA6rIsfli9ABPvAm7rDuEROP/qkSjPX7u5EqQpd5SW3aGMq
	Go+TOl79FUvGaAmxXOHM+d9TFhOVyFMbmYqkjRt185xrmoGWwaxW8EiWex3GO7ym
	Wl02sa9tgfexzZw4emcXbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738950556; x=
	1739036956; bh=FN/kde0hlwWHjCmThL6g45Vq7f3eddgeRk+OnWke9fU=; b=u
	FFDkdTxEx9Vz2X0D4gaEkKX8yd9Duk+PgQKkmZ4nklx3siqpDvrYmP+HxD//id2l
	p7RwH4K55AmRo5wG93kxjIdWavzMUEH17GDLGwGp/DeWcadQ6+W+XExQHeYkaBx4
	yM5v/MbwsNOeUaESkMdgZoN8OZAFUig09AaeKI7mqPo91Hl8kzEo8LA4xF998uoF
	mmAqRFOoXzz8dqghzrdM6lqCBmHPwvZR+PPlXYV56dPArNeWXuFH/CMLqBgg15zC
	XDUKoA3wouG2H/62k6ORzaetxL47FXfIHpePufP7NIu54YEpmWLWCx7Q2z4XtqJ9
	qTaTMCZiOvIGz5XIiJJhw==
X-ME-Sender: <xms:m0emZ9kJu31o6PEkqKQJwqlpkm74pL8hGkAJ85t_z5bzqmEYNdnA4g>
    <xme:m0emZ41Dfh0erJP7cNPKyJKTARisXup7S_uNyRHqde9GoQ4Tgzixjkn7wZ5YqEGWc
    He7I-9Nm6LrkTDMfg>
X-ME-Received: <xmr:m0emZzrJz4L4z1kuMJuKi7_Hj397D9g9FBPNLnU0i2Lo8AHCvu1-cU2m76WcFMfuUuH6uzd39DYTw2gx0vzWd6cvZn2EHRszGIBx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvleelfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttder
    jeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuveelgfek
    feehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopegu
    rghvvhhiugesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhes
    ghhmgidruggvpdhrtghpthhtoheprghvrghrrggssehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:m0emZ9k1nnOJ7lS7PrSKDPjxAeuO5ow8Tpv3rxK020AEf67VS0kRAg>
    <xmx:m0emZ72nDW2Uy8shfuaLGPqyuGFmLzkP3pCtL7Ow3XdgA8bVCc2Vgw>
    <xmx:m0emZ8vVprw7MkiUDt7kwJ668-tWHK0T7tYS6dBTCKZfzlqH6y-8ng>
    <xmx:m0emZ_X63srHEEjhh5b22OJK_p04ZXyVLcp7qPRVPA6iigKWJhEw7Q>
    <xmx:nEemZwnL4-eDTj8ij0dJoxTrmthofIQS8PxhccZLegs0AdBud5DWEpKH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Feb 2025 12:49:15 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Elijah Newren <newren@gmail.com>,  David Aguilar <davvid@gmail.com>,
  git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 3/3] difftool: eliminate use of
 USE_THE_REPOSITORY_VARIABLE
In-Reply-To: <Z6WoEjEo9Seffm_q@pks.im> (Patrick Steinhardt's message of "Fri,
	7 Feb 2025 07:28:34 +0100")
References: <20250206042010.865947-1-davvid@gmail.com>
	<20250206042010.865947-3-davvid@gmail.com>
	<CABPp-BGi51EQvPOgaz8p0RjAJ0zDDeTpMDp__puz_wQH5wowXw@mail.gmail.com>
	<Z6WoEjEo9Seffm_q@pks.im>
Date: Fri, 07 Feb 2025 09:49:14 -0800
Message-ID: <xmqq4j15hch1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Feb 06, 2025 at 12:31:14AM -0800, Elijah Newren wrote:
>> On Wed, Feb 5, 2025 at 8:20 PM David Aguilar <davvid@gmail.com> wrote:
>> ...
>> 
>> Nice; thanks for working on this.
>
> Yup, thanks for rerolling. This version is much easier to read indeed
> and looks good to me.

Thanks, all, for working on this and reviewing the patches.
Looking very good.

Let me mark the topic for 'next'.
