Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AB119EED0
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 19:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728587700; cv=none; b=bVQMj2BgFs78bSvOF1TlCoqUtj0WXw8oUuh3FMNVN1A7p0TeQuiBDaE2cocfnAlAJ9gOdsry3Lumfycid2L97AA7yP34q5n5KvK6n7JKjRBotBeAkNn8MaLCZB3uMDw0iDkje0yb9FihOC3VP0EhgxxL+zAIAFk0Kto5sXzLSNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728587700; c=relaxed/simple;
	bh=2zGj5sYEV5kL7VLO3fXEAOMBEQxM0x805mKmn5/83bo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OIHqcM2s8jPv5oxpiaVL5ZBXG5qFjPKPzVptwdqnH2nBAoAgn4VvT08lA/BQjs+8Zf9G7SDExtIgjwzuaL9lTfL2AZirw2Tl2eMt3tkDsOSnkcSmDNbVmTM1I9WBvhXry3uKO09RyOEJqLTs15DZpIJE0Vlxf1reoeren+MufjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=sGzYS8+O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NZ13oVe9; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="sGzYS8+O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NZ13oVe9"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3B3CB11401F0;
	Thu, 10 Oct 2024 15:14:57 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 10 Oct 2024 15:14:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728587697; x=1728674097; bh=2zGj5sYEV5
	kL7VLO3fXEAOMBEQxM0x805mKmn5/83bo=; b=sGzYS8+O3wMSjteIvGkfDOqlrS
	rVLxYRq2NpKD4p6Wb88xjEsJOULxncxWpUHyexuokn9WbKudkDU0GLxS+em36TSc
	PyvdMu55B1hHx1nhGqoOBRlJ3iTMLAzbpxc8J4Uo5flrtRoy1m6FhVAATLRx334y
	ilcoOgpvTylkZ0dFl/DU1tF3zkriiHr7t44PyoFQ4CQPor8owYn/g0fUybEGoKaY
	mtgzjP3Xz/9ZsFyLiVAJrQIMkiXqCaVthjKfjXLnf8zNsQjVcAjzx5ZjzlyPQWkl
	FX4ilnNnj9KCVrbY9mjdfGwWRQkWo6y/cmOcSON2nzvmiOcuserBoI5NpmuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728587697; x=1728674097; bh=2zGj5sYEV5kL7VLO3fXEAOMBEQxM
	0x805mKmn5/83bo=; b=NZ13oVe9lHApcepw9AyEdakAgdMhBiMuHJOyjv9Iz89R
	0/xwwG5V97/GJgM7e3qmsRLxZn4YGDTkDzwP9Nk7ztFaGxqQQmscb39UPUCDK20d
	RgXcv0/Q0ysqUxMECCBWA+ynQuOO7Omh7GLJAFfCFuevB0IV9KYiZJuYPQmI87R9
	7JIeziUkECZGjC41+eGD0outKfq5se+DWZe59Y6SA2VApoVKcVi1r/uQO7lYn6Dc
	QUfZ7RlZtySS+71+vdGjnoCAjqlxz9rOVmyD2Bryhs7uZYfodRhaK4YRGedtliHT
	Ucqp5jV1FqAolFc7JumgGRr3Cv9HwmUSG3dBj2Fqsg==
X-ME-Sender: <xms:sCcIZ7RGD4YkXEsV0pr1ybFC8mN_dSPlgRLr9s951ihJ3v_tmF3bTg>
    <xme:sCcIZ8zu7Ft6gAlJKjipvqqotAeahs4kyXZHqqRCF0jayE5w55lHD2vQ5wqj1rUFn
    dyZ0O7ArIX6L55Bxg>
X-ME-Received: <xmr:sCcIZw1N3QXEODVyaQrBYltr-BTxz-LU9D_PCEMIXaj6xgpVSS9eaQMnRGpvvSDTl_47WUML-rN9PY0lCYqd8rNX3ai-rzRpv7GfbPM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefiedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeei
    vddugeffgfffffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptggufihhihhtvgefse
    hpmhdrmhgvpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:sScIZ7DoUuUyPUpNalL64HfEkGJWdQqOorvSRpeUukqysZkbvEjk4w>
    <xmx:sScIZ0j33n_fUij5lSWI1k5Tngq8hck02zhTepgnzH2UER36XPV-TQ>
    <xmx:sScIZ_qVYKt40J73FwHMwVKi1Qp6seEDXYysboenzd3daxQ8Zm6qlg>
    <xmx:sScIZ_gI9D-6I3sS6bQwzhvDcwhh3Pa_IVL-2zuP9I00X7tX1FTW0w>
    <xmx:sScIZ8e-0HiJqZAYahjNm2-UJ4foRtAEG7GCxO6FfUsEJoKiuVYgvDlS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Oct 2024 15:14:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Caleb White <cdwhite3@pm.me>
Cc: shejialuo <shejialuo@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v3 1/3] worktree: refactor infer_backlink() to use *strbuf
In-Reply-To: <e1RptKNShhPZHXDhBkQBaCNCmKBKik4nQzRShqtgVfjcH7vBWpuLYV60PSHaJ0diX-oG3XiKHc7IebhIZM4eSkeYdQQZ_QYK2ixxsK-XwrE=@pm.me>
	(Caleb White's message of "Thu, 10 Oct 2024 16:41:03 +0000")
References: <20241007-wt_relative_paths-v3-0-622cf18c45eb@pm.me>
	<20241007-wt_relative_paths-v3-1-622cf18c45eb@pm.me>
	<Zwf4PT-vaLX35ELL@ArchLinux>
	<e1RptKNShhPZHXDhBkQBaCNCmKBKik4nQzRShqtgVfjcH7vBWpuLYV60PSHaJ0diX-oG3XiKHc7IebhIZM4eSkeYdQQZ_QYK2ixxsK-XwrE=@pm.me>
Date: Thu, 10 Oct 2024 12:14:55 -0700
Message-ID: <xmqqmsjbkbww.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Caleb White <cdwhite3@pm.me> writes:

>> Question here: should we use `strbuf_reset` here? I want to know the
>> reason why you design this. Is the caller's responsibility to clear the
>> "inferred" when calling this function?
>
> Yes we should, sure it is the caller's responsibility but this just helps
> prevent bugs. There's plenty of functions that reset the strbuf that's
> passed to the function before modifying it.

If the API says that it _appends_ what it found in the supplied
strbuf, then it is the caller's responsibility to ensure that the
strbuf being passed is empty, if the caller wants the resulting
strbuf to hold only what the function found.

If the API says it _returns_ what it found in the supplied strbuf,
then the function is responsible to discard what the supplied strbuf
originally has.

As an API design, if it is rarely useful for callers to be able to
append, then the latter is simpler to use, but there are many cases
where the "append" semantics is useful (see strbuf.c to find
examples).

In this particular case, it is rarely useful for the caller to get
the result appended to a string it already has before calling this
function, so unconditionally discarding what the caller had, without
telling the caller that it is responsible for passing an empty buffer,
is the right thing, I wuld think.

Thanks.
