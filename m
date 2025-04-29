Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C8F262FD9
	for <git@vger.kernel.org>; Tue, 29 Apr 2025 20:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745957261; cv=none; b=ovftfKktaOoYMA8dpo/Jxi5AWE4lRKXsFLO4GuSDk7VaLdYHIIW60vw7K8vEQ8qJXxzwZt9FDsDPPtp1S3HdQFVdVcYmzO2UUXLIlzYs32sT2HKOXuogfYc/LfpzD+Qj9WAogFDKTRM1OMhJKFAik6hav/pRI6b780xKzymR5uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745957261; c=relaxed/simple;
	bh=S7IGjI4ecRt/V//uPPmxtukU2gmAkd66j/Dhxc9EIeQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Mkdp8ls5TSsfIZJ8DlmLRAde0R4DEUEBZZYGMco6LUrSt3o5a9Y7BGt6qhrIX4KHWA62KAfj9J/JOhywvk2O8ibmjEU9EK8DayKcYEpf8PYQxRye3tX3GCg6Tn0aE5RtyMMZNsIJi8Z1OlS2nwsNZ7R2RHOqvRd1RZ6k/SVJR5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nkQKNB/5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jAWJjQ+Z; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nkQKNB/5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jAWJjQ+Z"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F089F114029D;
	Tue, 29 Apr 2025 16:07:37 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 29 Apr 2025 16:07:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745957257; x=1746043657; bh=KoE58IJuEm
	gIR2LDW0/lyXquq5HKMaKCqGBI3C+4qIU=; b=nkQKNB/5MBfNQUGqnEqDlG1Owz
	quKpCU2WndjvnzcVif0lQ1fh22qM1fOowIHH6cj8RIejEs7ZPZtNxSNTfw4E3TNm
	bnVlEXxfoIuzo+sSup+SKpajjLR1EF7bFDBm/00hHrrPM7ejnd975ZAHJeet6KSw
	6V+56qkN5/4bgmBWFBIDLg1MCuI+tr9nz7HM0z9ntVJgvJ/nFCerysdWukUhgDHc
	4ZOYT9g94+HPho/pAAEMgBwSTBWO47p7DXdcaCR7SGjvsbEBQx083xnrVzTNID29
	OzADURBVsnTu/EqLyVfO3FydosnjH0WBOi84/S3dqQM/0fTLX3y5bdWmq6fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745957257; x=1746043657; bh=KoE58IJuEmgIR2LDW0/lyXquq5HKMaKCqGB
	I3C+4qIU=; b=jAWJjQ+Z3BmY3eUhLOHocs8F+k3lYW64RitffwP90nX7WWPnNhp
	O89Y3gbL1UPvJEuIN5qmJbto89/LaVUllvm0FKjyHh/25/oMuuEtOvFuDOdqQp52
	QUO8kDdIiFwtmI7asRgniADV8Fk5VLePCm1mkVAL52pATZs3bdPXXEqE2efy0OLO
	B7OFQEkppZT+1LO4JE+OJNx9s54GdAvPEmR/gDdt2nY6uXRZ/80BXPBgcDGCZeLy
	haPMrwQhwInlf6bWd9IAVciJj1evr+hdtxtY4JT1MosaSDkyC1gQb+yGy3OXa/lJ
	Sb26cTo6VMRa0KLrBEVAS+aqLw1OcAwFxrg==
X-ME-Sender: <xms:iTERaKR4jGxePdP93FaaBbEmh-dT28tRVjg0GZ1T_seKmCwiLvPErg>
    <xme:iTERaPzRWCPqMQ6AewX6CVAL31YgJGQZp1coNjTLvTohsxqWCuu1mdEGx2VyCUXMw
    z0K4PbykeycdHJ1_Q>
X-ME-Received: <xmr:iTERaH0oKu1-9BoxKH37-BXCVvMRfWta0X40zYLuktRlhkuSIy6b6VztbJZJ8iMX0Q69nSIJmeAv0vxOuq1lIMvZMx-mGC0jrDKP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieegjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnheptedttdevffeuieeilefffedtiefgfeek
    veetveevuedtlefhtddugfeltdejledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:iTERaGD3ctmfHSsXGHqpHSnnD86bZfDR_AMjwIDF6C7V4s_sP6EEdQ>
    <xmx:iTERaDhY92jWhN1aOWf5iungUBbPtoWYktK5xzuTATX8rv_8ahYZzQ>
    <xmx:iTERaCp8GU8V9pjvGttug8woGI8usCoqIMcBd-pDdJx86G9PyvDl5g>
    <xmx:iTERaGgrvegNVaQHwxLPJkZaneyuGkqr7DAxkG-R7Q_fUhTAWTUUKQ>
    <xmx:iTERaHsngYBhMLEHLSaeKKrGEiTPc-rXmNUagl3jNIUfNhwTMbNmETWE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Apr 2025 16:07:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 0/7] object-store: a handful of cleanups
In-Reply-To: <20250429-pks-object-store-cleanups-v3-0-42902bad09a1@pks.im>
	(Patrick Steinhardt's message of "Tue, 29 Apr 2025 09:52:14 +0200")
References: <20250423-pks-object-store-cleanups-v1-0-81f8411a5d08@pks.im>
	<20250429-pks-object-store-cleanups-v3-0-42902bad09a1@pks.im>
Date: Tue, 29 Apr 2025 13:07:36 -0700
Message-ID: <xmqq8qni68af.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Changes in v3:
>   - Move around `hash_object_file()`, which I missed in previous
>     iterations.
>   - Don't try to fix up callsites where we end up fetching promised
>     objects. This patch series now only does a trivial 1:1 conversion.
>   - Clarify why we're sunsetting `repo_has_object_file()`.
>   - Link to v2: https://lore.kernel.org/r/20250425-pks-object-store-cleanups-v2-0-63f1695b7700@pks.im

Thanks for a quick reroll.  I think these are all good.

