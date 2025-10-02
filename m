Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB091DE4CD
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 13:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759411988; cv=none; b=MStsnnZhs6DC6cmSRfeSUcx0zMpNaEi9vFlpPnUB2YthGXszSSCQ2C3ez/fnByg3OAWgV1uHczIkqRQFLfcMX9hVildxXCx7FBIkAEoTJ8Co86SAUS+q4OLPgIOG6l2JZLeHaMrPjGfjauNci6k1CQU+wKh6Gj5pzeH5Nzve1l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759411988; c=relaxed/simple;
	bh=RFqnkllIAc7p4weC5HjlKXll5x5X/3d0qDbpVogk/sA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nPa10R0im+jzZia6xTabYMTkmOQUwQjU56pZhUFexo6bRN/KTb2aaAHiCGyp+eBc1ph6s0BCrQ8pTCElBFqy9eAnNFbBy+6pAaKweqvMHqCrLsrXtsoZBWQpGnPxgtzQLhOjad+n3EwwVxUKToR8+T+kogPTliuTEbVbQGPCfoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XfGNm6gD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZlcLFiAm; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XfGNm6gD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZlcLFiAm"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 3E37C1D0012B;
	Thu,  2 Oct 2025 09:33:04 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 02 Oct 2025 09:33:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1759411984;
	 x=1759498384; bh=LaL5gGcXOio9Asly8sbPuCy1A8IoOumv2m9P/cEgwck=; b=
	XfGNm6gDrbmXobhDAG5xxh7FbWBnnYOT1FNhn5ABdbwCrnwqkCRXCX0/v012Gp9f
	MhoCNh6yxja8/aNq/vsmXj635w38UkycT3rKf+UULvrhzBa204Pt8V+/0QrNfRh8
	d3PYp1zTJ7d6s1GjsLaFnDIsmdviYOnj/BI5Y/1/15/8fscsen+JN7cFDh8SG3QZ
	Ay4lb1NXHDT0s4MvBMHfmIWOfnQ/1mdYrMc/wovwp4PEwTLfQf8FxYWWFK611wv+
	Hqt+8H5wkKVWE11DliUwj+cPD+8HwgKxPQe1fdLR4FEvjZHxOKfktrMvZKDsoCoz
	/dTBrCEVzBBtjq0s5Drwhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759411984; x=
	1759498384; bh=LaL5gGcXOio9Asly8sbPuCy1A8IoOumv2m9P/cEgwck=; b=Z
	lcLFiAmclNO3/xs6eqeEttIXvo0Ujmcer+MrTXmR+Z5Fnrclov/DqWo0RztrASbZ
	mndBq0wI146Rt4e9dbDr7PSVG82lBlQzTyQ86f9mYFIdl3cNeVSkJavUq1Qxb3+Q
	WFYieX6m8nPxqOgeKHkW2CZ5SwdmPbt9E3jXONYr7+atzYIf4/TA8UhLsbx+obq1
	pSl7X70ng0bUKPnUoK3TJkT4NdYpnR/MVeaO7WYEinbq7DmvJX3fblJ18NtUFD4T
	Zj8kf+I9Xmxs7OsSsW3gDOm+7tFvsyDu8l64y7Kx6i24nWhdqP/nVtkgC3C52eHU
	IwQTzYwVUPZihOYhej9Lg==
X-ME-Sender: <xms:D3_eaBPP4ntNTySrKlGDCH2lVzQMhfC79hFH27HtpoNFGdRlIHmsUQ>
    <xme:D3_eaDA4inMyzhE5v7w7sFuqW3dufRjxKFaXS7eEA3xCmLb0QAnKXTu03mzCUO_oy
    3f3LYGeMykyixM5iuv9oUc28lQgQwtqHf3hJrnl44AQxAeLfTgT5Q>
X-ME-Received: <xmr:D3_eaGfKIWA4FnG5mjAOElTBGZ4yF13vO7KylZ8iaOQ5asof1LISUod_BaXZtcsPNwuvNnOCwljxM9vOCbPUmZEMtgzr7d7Hz5cr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekieduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhhsuhgthhgrnhgvkhesshhushgvrdguvgdprhgtph
    htthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohep
    shhorhhgrghnohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslh
    gvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhgrshhonhduudgthhhotggrsehprhho
    thhonhdrmhgvpdhrtghpthhtohepjhgtuhgsihgtsehjtghusghitgdrphhlpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:D3_eaKPVGKg_egkbisCwEjj_1UL9cf_VPG7oJxNnn6oy166eq9zYxA>
    <xmx:D3_eaOL2BVcn3LJBXqH_BakvOvM7L805XKer5DkNKkTkTn3aK3VxMA>
    <xmx:D3_eaCIoad6f4h4zMXNw7nipNNuNPjIo7s2KjivlavfaC2ga_KqREQ>
    <xmx:D3_eaA7z7ypvdhhViZdFbcPicaFnqkqXncdu6odd2DM8UJYH6sps7Q>
    <xmx:EH_eaNl3_PoDzdig5aXrOsdfPW_BLDaOqisAi52RvbGbVl0IrG0toc33>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Oct 2025 09:33:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>
Cc: Eric Sunshine <sunshine@sunshineco.com>,  Sergey Organov
 <sorganov@gmail.com>,  Ben Knoble <ben.knoble@gmail.com>,  Jason Cho
 <jason11choca@proton.me>,  "Jakub T. Jankiewicz" <jcubic@jcubic.pl>,
  git@vger.kernel.org
Subject: Re: What is the reason behind not hiding git worktrees from git?
In-Reply-To: <aN46GP7-yUfXB_lL@kitsune.suse.cz> ("Michal =?utf-8?Q?Such?=
 =?utf-8?Q?=C3=A1nek=22's?= message
	of "Thu, 2 Oct 2025 10:38:48 +0200")
References: <aNuy1aab954D3rJ1@kitsune.suse.cz>
	<E311F5BA-F88C-4C3D-88B5-F8508B106D41@gmail.com>
	<xmqq3482312r.fsf@gitster.g> <875xcyfk3k.fsf@osv.gnss.ru>
	<xmqqa52a1h6x.fsf@gitster.g>
	<CAPig+cQgZijWi8VV1_QScKPhm9cqhQVvow4N-VH00R4oO1m2xA@mail.gmail.com>
	<xmqqms6az2a0.fsf@gitster.g> <aN46GP7-yUfXB_lL@kitsune.suse.cz>
Date: Thu, 02 Oct 2025 06:33:02 -0700
Message-ID: <xmqqseg1xwc1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Michal Suchánek <msuchanek@suse.de> writes:

> On Wed, Oct 01, 2025 at 03:27:03PM -0700, Junio C Hamano wrote:
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>> 
>> > skip over them when scanning the output. Moreover, I think this is the
>> > first time that we have (on the list, at least) heard a complaint
>> > about the "noise", which may suggest that this is a non-issue for most
>> > people, and that a warning telling people to avoid the practice would
>> > be unwelcome.
>> 
>> Ah, different people guess different reasons out of the same
>> observation.  My interpretation of this is the first time about the
>> complaint on "noise" was because everybody else would not even have
>> additional worktree in-tree.
>
> I suppose a suggestion about not adding worktree in-tree in the add
> command description would be helpful to avoid the problem.
>
> That's the part I would read if I wanted to learn about adding
> worktrees, and it has none of those examples you mention.

Yeah, care to throw a patch or two at the documentation to help our
users and us?

Thanks.
