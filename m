Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF4A3C3C02
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 17:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791394027; cv=none; b=Yp8ce/8k/vtDybZ3NgksikVJQLj3ybg39Ca6n2b+V3tSeffa5zpzMs1K20x7so3KDZF2WRuQ2vyQC40Zkx9gPUXL/hKF6bQ/IjIdoCp92zh8niA3jJbDpPYLMJb7wHgGB8lzo5WFPguLDRlcYC07FsGzWLAv9rRFdmZ1WJBevGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791394027; c=relaxed/simple;
	bh=gQxhhGEhsbik8zsjvgaaqnBNdd0nSr/Sy5A790GfDic=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SV257GJxYpSAzZAGsy0PMLVEytkXyEwXANGm4U399VmlEY/wMjBrWE8hv4G6hmqjm8P6RwcZtpGZ1aWK/eK286SFCfANVNGMRYKMYB2+okDekOvzlg2CGOEwjMMk7dFXoju85dQUuuIVDXEKzXpc7z7UeRhWS3sa2zF268k7Oag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=c2/ThUNE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HQhtfQci; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="c2/ThUNE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HQhtfQci"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id D1D4AEC03EC
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 13:27:05 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Wed, 07 Oct 2026 13:27:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791394025; x=1791480425; bh=gQxhhGEhsb
	ik8zsjvgaaqnBNdd0nSr/Sy5A790GfDic=; b=c2/ThUNEPsJJ3GAJt26/r+oz6m
	IDOvcXwiYT8VX5Vx71cF/4eNDu50rWteSlA8k5cegLzJnVYYpUfYXqAYD3RQVSog
	wsWRedyxOJfjfH7QeCcPJa0WYa3dJjfJ0FnvUXHEByMbl3z9OvOS7LH8Kx+SdPrd
	w4VoF4oKxij82D8n/s8kwvpBLSKizGWKmczz8GGimTL/wtu328Wo5Pryiidonsw1
	FbjdhJEMFb8NGAjWqNxM3vYPmjx3aI8QDZXaH5b66F4JClwC1g42Ne2oO+WHnJnA
	CVBJ6q9HKJW0A+kB0rXWl28XhaM0Cu88QUqCcdqTd/XC35OwvGBHa4NBaR+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791394025; x=1791480425; bh=gQxhhGEhsbik8zsjvgaaqnBNdd0nSr/Sy5A
	790GfDic=; b=HQhtfQciCg2H4PmtYD4BjSQ8eOvmLmrXfU15DTEsyW1WfN9W4kJ
	FVfZrof/IvwBsgP/Dl/qIIj+TO7v0okl3N+cNTQDb+o1qtAnwQQ2umoli0fXCTFZ
	1DPKDdT6e1RymlipYlJrDgGUdq5XfyjU/2O9f3Cwe6MANiR85haO0QMPuiCO4UNd
	79PUSIs4vonxh6f+4XVP7q0CCYDf5DhhZy5F+Mkalxd+VO8g5jtYQTvi2XRZT9v+
	rSTbUH2jf8brXWtsnjHhU5LLaKMKIL/b8Icm9kpx7Pq28QZwyB1kEucZXmZ+FVld
	ts31r7wf6aBgcuwdPf4qBR7RdNwZXvfsI7g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791394025; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:P1zWBzEWRl3XrOv6DC9BEjD732ZuuCv9g48P2P/vATrURWJ
	BK7iTm9PQ+BzCPBqWpM9RiQkiuJ7lJU9tZ6JrWJR6XenesRbEFtnCyPNrI+nBAfh
	9k5ZwXmEE11d7pAOrVvaBgi17hGbAQE5c496I6NaefwXVN5hBK1RyoZX4QYIiwYz
	gqRyxM7ZoDZKVzPbb78QLRNew4VRELHK5t/NNuyqXCTaIKb1MVVElicqRx0epNc/
	5E7hgbC8Sn3zCLGin/8+UEqHQm1583thpf8AiA7lUkVHmg+7zWnzsOSTzQFaylo0
	WpSW+Fkcyw3qjtxBA1JN/ylMuIZoL0ZRL0E6MKQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:zPnrls99AudobvDfT4k6WP18wx5gWVyu4kk/3/Z3Wl4=:gQxhhGEhsbik8zsjvgaaqnBNdd0nSr/Sy5A790GfDic=;
X-ME-Sender: <xms:6YDGauuZ1ypP0ON6tz6XPSufuguCYbmP_5uwZIp5F75G1zUHRlzdsQ>
    <xme:6YDGaqdr6ANf1o8lDtPz9HBfB7VnWh-5YPhParfuthN86KE9klKyQHOWqAQt1QiIs
    1___Le8UOpvelUXvmr1rFKrWBLeSd6X7zk5mkN-sFekO_4rfuh->
X-ME-Received: <xmr:6YDGauzti_gB-BbEacw9HZKI-LsOPkcxPQp-oItFJ9DRhZUpRBiMi8bHLyYqtwceyy8-w4q5l_kQcowFoNFdrEI4MM72MtkBky3n>
X-ME-Proxy-Cause: dmFkZTGwY2w2ZWtuwJl+xQznpFEPqt+O1d6aw2vh2n5Xlo0RtGj1q0esRUiIxlJ002piFT
    cBwqrjOK0a4SrF7ajFlWpPF47MKKJDau+F25QOHKwhW4hzJldUnweQARlAYycCPAmfpkii
    6+RC4NqLWkFlmic9RIW3qocXfhSTmgk0cb2x7rbenvZTjccRv4YXfT1hUq9JaYnk4yMi/r
    yOlv0Vh7B17x/6JjuUtfiUfIxltChsDtaQYe8w1bq3RIMAxIxM5ehoyIJs/VsuO4FOCGCa
    J34GYCfdSPOWvW3i+niovDHgkb+HCyC1vFsA4VfNkRL0/sF5vLdbCJJ6lB/W/X+jd1mBJ3
    /4gPFXDIJMLCJEWwEco5Gn32oZEr9W9Fte3kXP/4FQ+43aB9vhie7LMg1Jj6Jr9VuHFojQ
    hJuS4czWo1vhilubc1rGS3D0BPob3cz5cVYdlk6n2kFDcmwlUkHhdxnHDPGs3CqZZEuDsD
    x1eOb5Ijt2wNcg1zcNuy0mqHqfRVzN180V/djdVZVcVuS5O1+K7a8dsVvLJfWMFawmpT3T
    Ff/requwgvcPDvKLweTh9ThuKTojbPLYUH98Y1aO1WBqCsJkt6NUVfbCinYhQN8J3D9qpa
    znHibC7xcyrQ/6zabq7S9s2qn3+nzhFrzPy22a2gU7JXux+fF3DpHPg8rsaw
X-ME-Proxy: <xmx:6YDGaoFjBmKHWBWN12COuiyu6UzfuztokLhwnYsSzavXvTTLlGg7Fw>
    <xmx:6YDGaqx5S8C9wnGJQ8gRwnMpfXY0yfUadjGBMYgT57arZghbGo6BUA>
    <xmx:6YDGahukmVBdsIrVAPqVgERIpA1qr6D51DzwdY52Sd7jZ9IQa4Vlfw>
    <xmx:6YDGav00qpXZ0BYamcGByDVWKqiRmkN--00f30P-SF_vYMfEbUzSxA>
    <xmx:6YDGaiQzvwb134Dz_o_0PyYm6g7lkpCXWoEjOpq9j-dOUOQc0l0Qs6Id>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Oct 2026 13:27:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Muhammed Dilshad A <dilsheddilu123@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] test-mergesort: plug memory leaks in sort_stdin()
In-Reply-To: <asXi-1RlWhqPMWjL@pks.im> (Patrick Steinhardt's message of "Wed,
	7 Oct 2026 08:13:15 +0200")
References: <20261007034205.32619-1-dilsheddilu123@gmail.com>
	<asXi-1RlWhqPMWjL@pks.im>
Date: Wed, 07 Oct 2026 10:27:03 -0700
Message-ID: <xmqqzewp8lqw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> I was briefly wondering whether we could get rid of t0071 altogether in
> favor of converting the tests into a unit test, and then drop the test
> helper. And that's certainly doable, and I'd argue it would also be the
> right thing to do.

Yup, unlike any "test-tool" feature that is specific to some Git
operation, things like mergesort does not need to be part of
end-to-end t[0-9]{4}-*.sh test suite.

> But anyway, that's of course a much bigger scope, and I'm fine to just
> fix the bugs for now.

;-).

> I noticed that there's another "generate" subcommand here that is
> entirely unused. Do we maybe want to also remove it while at it? The
> test suite passes with the below diff.

Great.

Thanks.
