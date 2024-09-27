Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4331B5EB0
	for <git@vger.kernel.org>; Fri, 27 Sep 2024 22:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727477297; cv=none; b=guQLOlb+9qdKbN1CqifRIv2dFdxXbS5s6Dx2mqbNsmDFVh7AdUKzP304T2E6qaYzt6RZZtDc7Z6wAjSlx5r1PNGlbhgj+Cme/o4D4sqFTOAFWqF0TRc8drFMZArVfYK8rlQZ/z8jyqz8ymhOhudC0II6ExlNqUFNwXonghRG8X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727477297; c=relaxed/simple;
	bh=XfQi2fLNvlizHdmzPTudRa9G0tMNE3dByvGG3wiqR4M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r5T4lRK+leoCoo3oii+w8vxpQhZnz3Q5IXeIQWH63rRTFpjzbEV0AOG8TO0zFi8Fdbbx6K+j7azazABV5FUpmttcdkxtBuxsrcAzElmrDxXzULj1Nuh8zeoldpZfNgVlWyOPe7TG8bDIK9gaw2ACMWFvAu68CmYdnTtnSZs1Pzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MkW/06fJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YQTBCwvl; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MkW/06fJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YQTBCwvl"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 892C4114012F;
	Fri, 27 Sep 2024 18:48:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Fri, 27 Sep 2024 18:48:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1727477293; x=1727563693; bh=dNU5eGnsby
	/gNeqYnWsDpe9y++MM5pnyUiKXsUsZg9U=; b=MkW/06fJJPeGKQNy+FJKUxCkLD
	l3tU6YbUsMd9PL7hTBj4PR81oyybnnljC5WHLn5GFVZnn9XRztz3JBvrlDVFKA0E
	Sd35/ZEB2a5wNXnT7bKVJPE7FzYTgNa+PWAY440hGByJCyNfKlmYrKsrN93F8Kq7
	38wowE95z0rfoLfMWT2E5zTZL8e/G63er6wU0UhTAgqJmsWmL2Nhw1qoCSsaFgFM
	f8FQ6IMSCGSiPb879yjA6D6GSoMRu7eGti34g4V4EuwAihp3rPHx1ceeW0CICOii
	AqWYkr3RwOFOKJWfxIRystc/Y9I0D9+MG1/dl6bP9yQHvZxhI+fcqmeCzjfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727477293; x=1727563693; bh=dNU5eGnsby/gNeqYnWsDpe9y++MM
	5pnyUiKXsUsZg9U=; b=YQTBCwvl+4DijGh6OqNBeYybnv/a7S9sJfR5XJYA6Rmw
	wsKwaJmlrb1CpeUDQpK6fN0NgODPV/QeoBMm4e6+ufosIlgJR55aaup3ErUyjRNQ
	XJk4xtMYwvRhmLLv1UVPgBv/dy6Bj2m9JFlfz4GamD+1uJRakfSMf39PonKrDWGb
	zegQw60b1Ayi0CpxByvQ+70u9Qc20JNH+1lJPw1Ig7ZlUHOU1E9siU4EMcX48Ck/
	XknWGs6EhB4D1W/2/4+aJ1OBaXqYSgN4YMw71Jn+gc3BYJ3AQAwc48qPyt0GqT/c
	nSL4MiX81boyzNhwujbH21jMaLFu5A8tW/Lc6ndHVQ==
X-ME-Sender: <xms:LTb3ZkdfEALuTFomb3SghmCzTMISENuOXBZF9ORtJayn8sIJ6Edf4A>
    <xme:LTb3ZmN3_EViZcstte_5Sr43fCZOEDHwDrD85jEMAo5enMn8a0Wb8pG_h2lNR3guj
    tXuPjqGj4Nkvt8-fg>
X-ME-Received: <xmr:LTb3ZlgfZoDJqrHeChNOfJ8wB0hsgDxhi920NqrPqJAYWuSsuHV2OcNCSNtA7Feq-daHgjpGIk9XlkA22wJ1SgjBrc7Hx627TROQRcU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddutddgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepveeludejledtkeejueffudekheetlefgiedu
    heefhffggffhteefieeguedvvdfhnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpgh
    hithdqlhhfshdrmhgunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepke
    dpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhgu
    vghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehjohhhnhgtrghikeeisehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtoh
    hmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgt
    phhtthhopehmhhgrghhgvghrsegrlhhumhdrmhhithdrvgguuhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:LTb3Zp_Up-V_riUIe3VpE9ZOYSuxvXxDuRXzHfk0Go9bLtL0hyTmkA>
    <xmx:LTb3ZgsmVLIy9wUswwQONc2qyXTfaly3sBebKVsLoh1BJkrgA7queA>
    <xmx:LTb3ZgGxDKVoOOGfSPHPvzpHraWpYry412eDuOzKzu1GVEFXu9b_Pw>
    <xmx:LTb3ZvPU9ypkXjT50xiFW4oJmyNeXCIUHwqZP4SlNEZ-zHYRUG_1Ng>
    <xmx:LTb3ZuCNu9GDzyuPmxlZJ5ayAlm1atisXsrAEJwvH88gZh0OzHVqTFOy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Sep 2024 18:48:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  John Cai <johncai86@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  Taylor Blau <me@ttaylorr.com>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 0/4] Introduce a "promisor-remote" capability
In-Reply-To: <CAP8UFD34YJ23WSjaP3m8Ao6iZja_NJWfQ0BNEsaNU_F_X3qA_Q@mail.gmail.com>
	(Christian Couder's message of "Fri, 27 Sep 2024 11:15:01 +0200")
References: <20240731134014.2299361-1-christian.couder@gmail.com>
	<20240910163000.1985723-1-christian.couder@gmail.com>
	<xmqqikuijni0.fsf@gitster.g>
	<CAP8UFD34YJ23WSjaP3m8Ao6iZja_NJWfQ0BNEsaNU_F_X3qA_Q@mail.gmail.com>
Date: Fri, 27 Sep 2024 15:48:11 -0700
Message-ID: <xmqq34lkg1ck.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> By the way there was an unconference breakout session on day 2 of the
> Git Merge called "Git LFS Can we do better?" where this was discussed
> with a number of people. Scott Chacon took some notes:
>
> https://github.com/git/git-merge/blob/main/breakouts/git-lfs.md

Thanks for a link.

> It was in parallel with the Contributor Summit, so few contributors
> participated in this session (maybe only Michael Haggerty, John Cai
> and me). But the impression of GitLab people there, including me, was
> that folks in general would be happy to have an alternative to Git LFS
> based on this.

I am not sure what "based on this" is really about, though.

This series adds a feature to redirect requests to one server to
another, but does it really have much to solve the problem LFS wants
to solve?  I would imagine that you would want to be able to manage
larger objects separately to avoid affecting the performance and
convenience when handling smaller objects, and to serve these larger
objects from a dedicated server.  You certainly can filter the
larger blobs away with blob size filter, but when you really need
these larger blobs, it is unclear how the new capability helps, as
you cannot really tell what the criteria the serving side that gave
you the "promisor-remote" capability wants you to use to sift your
requests between the original server and the new promisor.  Wouldn't
your requests _all_ be redirected to a single place, the promisor
remote you learned via the capability?

Coming up with a better alternative to LFS is certainly good, and it
is worthwhile addtion to the system.  I just do not see how the
topic of this series helps further that goal.

Thanks.
