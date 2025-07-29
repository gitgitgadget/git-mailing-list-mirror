Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028CE242928
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 18:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753814039; cv=none; b=u3bMzlt3jeeDOKcE8RF5QOPAXyGQ5k66GqGg8EDd+QoBYEoeyjqddgNwr3tf9eXJXDRf0LNplmG1VbdcOY7B6VWYnc3j9GFGY0VnUDjc5hk+LdLXe48i1ID+RgBo1rEuHN6S3fhCggHZCr5Ke29wL9cyTJcyVvbsxAXkgyGXaLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753814039; c=relaxed/simple;
	bh=zgK/MvxoZQUsMUe9JWe2UGhrCeDe6RGJlUcCEHkxLw4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=reFYtQXZzJwBMsAXBEeMdMJcunuRHQU+VwBWXMoI6lOP5MDATEcDjiG+2KB97MH6ZoInOIWN++n2Lk+pjtnhNdvyFsJyJWb4SKEmJCs9SUWnwrUAn3YeJ+oJKTOnSPyAaqizIOEaDt1V0YXRIN4YvL+6bm+TmQoBGKYV54xwGL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Clx3Ghym; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G/33cqbx; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Clx3Ghym";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G/33cqbx"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D8A837A00BD;
	Tue, 29 Jul 2025 14:33:55 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Tue, 29 Jul 2025 14:33:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753814035; x=1753900435; bh=8cor5duKpR
	9ERPX/qXrAczYEiYr4z2P9SgmwqiSwo/A=; b=Clx3GhymUYAwhBDttwEwf/OesA
	4kGAor7sAXuqJ5YFrsBbH2/0A3amFZDOA7bXV9TgjNBfnaEimig3dlKB0ozZyvcq
	6OQA+qM749F0a0HQrjDDBRGNzS22rfXiVb4Wi3rXjh5lOuoz7DaYktdttbXSVmwg
	zG4Jk/UM9V1axm+64tmlYCGiUqMXRRQE/53B8PDtMgt3OTOYJDFhRoxNRqGPrrhY
	AKhbfTXkBqfUo2RrLExjLvYCsM634da9ca4i0qWkS35QTyrqF3w3FGJf95ouQ1Oa
	1UMgb0oVWPFC/Hh4TIsfYL5gPo9dZTzYQeXMLxjRsR6dNKA4TLi1OitK70Zw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753814035; x=1753900435; bh=8cor5duKpR9ERPX/qXrAczYEiYr4z2P9Sgm
	wqiSwo/A=; b=G/33cqbxUlTaYhMeJlxoDuuWE+hBq54tOnITBNmh4LUj6ahcPUm
	BJUfMED4UGe5Hr0RiQ9r8Hcd97pIkAW6kldF10cR4AQCOEkMr7f6mq0Kl6eT9bw5
	Ovcj0XP6hAGI/3qlJPqGgJg9Rk2IpxVMORKz1tc/+nIpmbLZdRKonc+nO7bXVTeA
	fr3rIl1aUXFIIF9hx3W41H3gsyIlSkgfgkwuxy1iFbxKb3cVa+BOM74qqxwoDX3x
	NUNXaFnnt8TN1PxpGuYMy7GlSuY7bBgyRyO3yK5hLrga8aLcqJwPlWyedFy1agas
	ws5uVT6Ycnz4Vj1kYFkKnm9bmMfKDPuLRIA==
X-ME-Sender: <xms:ExSJaGadkImGUVAHs2znAKMSAvCgJZtSZZW35r8gknucBvdzCPWY6Q>
    <xme:ExSJaD-27nvPk6QKLMl7FbCBqGNoZzzv7VOCv_e99zDSFaj0SgQ2BvVGiARjWP4e3
    ts_yiIVwVQQh-MVjA>
X-ME-Received: <xmr:ExSJaNhAlLkgnJoWZDeeflq0OZprDrlVv1TmhWessM_HV4rTnBIaLGXGOuywwB-fyZ2sZso41AtXr9HT1f_EGRQuWDSj4OEDmBh05Nw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelheejkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgt
    ohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ExSJaLfhwvpfa5aRRRtNk5K_sVYXukgdJlAoe8U_z7M2bsRr70YTTg>
    <xmx:ExSJaMrSDvEb8bFtojng2GfYH4nCNIxzqug7C6VFS59klmJYoclWfA>
    <xmx:ExSJaIBP1Prkg1rWdYDEOSTkpaBCmp6OAfvu1XQsjLeBf-I9nxyk0A>
    <xmx:ExSJaBbA__D7AbY_iIadachr2Qf5DWRn_Iu3aIVCymGRCwNGzLLBuA>
    <xmx:ExSJaJikDIMTo4OZIWqwxSfKNxgenYesnAzetuyuODjdhgumExOJz4zO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Jul 2025 14:33:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 0/8] midx: stop deduplicating info redundant with their
 sources
In-Reply-To: <20250729-b4-pks-midx-deduplicate-source-info-v1-0-748db2eda3b5@pks.im>
	(Patrick Steinhardt's message of "Tue, 29 Jul 2025 16:12:39 +0200")
References: <20250729-b4-pks-midx-deduplicate-source-info-v1-0-748db2eda3b5@pks.im>
Date: Tue, 29 Jul 2025 11:33:53 -0700
Message-ID: <xmqqwm7qonhq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this patch series is a follow up to the recent patch series that started
> to move the MIDX into its object source. It refactors the MIDX subsystem
> so that we always read and write them via an ODB source. This ultimately
> allows us to store a pointer to  the owning ODB source in the MIDX and
> thus dedup some redundant information.

"Stop deduplicating info" in the series title is probably a typo of
"stop duplicating" (which is the title of the 7th step)?
