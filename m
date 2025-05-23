Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA18B29713F
	for <git@vger.kernel.org>; Fri, 23 May 2025 15:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748015942; cv=none; b=vDxYDIcIWfmYw/zOUztiz+xjuqTrstCeLTx9yY7llPeS4Fv7Gc1+UD4UzTT3J2z2gFyUc41sRHa2LKeMnqI9rWn4amgtQkPVFMWBTctOXAbPRZ8Yq2DfXwiu3mXpWYHR2N0jGu25K9e0YVm5UAwmaG47JYYgneDhE8id4PdjiW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748015942; c=relaxed/simple;
	bh=oOjRJvDsNrEVgQkgDqYj2kCmKELkwJ8bbEbbX/ZptgU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Qf9Q/EPU/A2zRiK9h0SksYfwCDa30P2Z1IXuSgFfJq6sFJEN9DWcfUBhGHiWPJmo+TMlZIaI1Gdta1XzknOQ5/tgfhP8HRNW4a52tYv/yyOdvRientleUwL5o3bY1YzoPiaZLvihCF3KAUv3X0JCybVJC74MjVx/XHolBWIR4O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hTqDy0w6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EYxxmFnC; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hTqDy0w6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EYxxmFnC"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id E87661140159;
	Fri, 23 May 2025 11:58:59 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 23 May 2025 11:59:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1748015939; x=1748102339; bh=mnGO5Mvmrc
	r9XI0ucKwZCSyGC4OZbBuBFX3RsH9cG5w=; b=hTqDy0w6bKPcpGxijmjjCRtEmW
	0qbG4SxEUqBg0ZDCMe/rVhQk0mzkx3g9F9yOujLARnZa2bi8KUg78EvEaJHpVSTe
	AVUf5I89TJoD9vbRQplrcI8px6dUyEkCZ8VL+BeCBgNdkOD+JOzfSMOG/3dODBlv
	jwSPLx7z5IE403vpG9aZVgkH7KlHwrsU8GEqjZP6gUoxn8hMnP6aI1iHm5027YJ8
	XQGbbNB0ICVKIeetQCbOxWU0912hN+XUu4Pol+/qn/b4bODW0iUV1nr95Bagktm+
	kUFIeLJVu8oEOZhZS6dS+gNA1+2foaC1d/8NOdb40G3qwdEQURX65CKNnSNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1748015939; x=1748102339; bh=mnGO5Mvmrcr9XI0ucKwZCSyGC4OZbBuBFX3
	RsH9cG5w=; b=EYxxmFnCqZNVgyDucYrnu8/pnevRkWEmw2zKvRIH/q1253MuXKT
	+Cwqcqa66OTubKY0/im4XN8r5sysMUxjuY9ZqbD3e2P537ZAwSfgASuvzCFjUaAU
	ojkbqe3zJkfaSHnVaNeGL2pM9Dra5zTZjjMYjuE6WaAbci3690eKpn2K/z4hjhfa
	PDsUVNKcBhEXvxyTwhiYPG58LTTyO85xVnR+1Bz722yBhRsSiTDdCZKLv5DyV8jE
	jIBMUn7le2AjTPxGORMmDcS+Y/lIMkWt6CMVkT006Jdp4Giimh+KMEPp51yarweV
	W9M8nTqzCFNUP2+RtsJyPWRsW/jDenEgswg==
X-ME-Sender: <xms:Q5swaH6oNSvl7UxpDtOLzaFn94ySaPn4UMxjjwIeDx6dJ4YBmmwKsQ>
    <xme:Q5swaM4NWHs24C_GTPXMu9s6XyXTQ4SLDPTnNl5Wa-XsF3qmlgdbk0WYc2thz0xMr
    BsjF6GVdxofDQlqpQ>
X-ME-Received: <xmr:Q5swaOdMLfYV2Wb3l1hm2AaPnVZl-WXNiFyWiHvDYd1LjJKfDpQHYhGzll_pNznS5m_DvM9UYVLJgMYpEicTWwQfXBhiGtn-AcIlK-Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdelvdejucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffffk
    fgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceogh
    hithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeeh
    ueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosgho
    gidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepphhssehpkhhsrdhimhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhr
    tghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:Q5swaIK0OAAGSFaLhxPKUj1bdi8MevE58lMUwjWnN5EaVF0jOitGgg>
    <xmx:Q5swaLJrbWq08V17kqCjkOWePy1TcYhF2p6mXToqd_zxBsZ2srr7EQ>
    <xmx:Q5swaBxjV8SZU6lwA97c6BxA2GbVDElD_M1KOP2ENlqVjNPa2-43Zg>
    <xmx:Q5swaHLsrTQfU2Ny9HLnnM8MBkvFE_AYGj_vmxGjbK4IZfyxVl4VjQ>
    <xmx:Q5swaMFXDjFoc7Wyorw4e3junhTm6Wfb-jBHe1_1aAKPyR9ZO5uhZjxj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 May 2025 11:58:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>,  shejialuo <shejialuo@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH v5 0/3] align the behavior when opening "packed-refs"
In-Reply-To: <aDBCdoNPkTq0xzOP@pks.im> (Patrick Steinhardt's message of "Fri,
	23 May 2025 11:40:06 +0200")
References: <aCMnrwkoJ2WyqGZT@ArchLinux> <aCS7O8tNekg_u9Wp@ArchLinux>
	<xmqq7c2aapte.fsf@gitster.g>
	<20250522055006.GA1135327@coredump.intra.peff.net>
	<aDBCdoNPkTq0xzOP@pks.im>
Date: Fri, 23 May 2025 08:58:58 -0700
Message-ID: <xmqqjz67z5bx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, May 22, 2025 at 01:50:06AM -0400, Jeff King wrote:
>> On Wed, May 21, 2025 at 09:31:09AM -0700, Junio C Hamano wrote:
>> 
>> > > Change in v5:
>> > >
>> > > 1. Improve the commit message in the first patch to be more clear:
>> > >     1. Talk about the current behavior, what error we would report if
>> > >        "packed-refs" is empty.
>> > >     2. To align with the runtime behavior, we should skip checking the
>> > >        content of "packed-refs".
>> > >     3. Why do we need to report to the user when the "packed-refs" is
>> > >        empty
>> > > 2. Fix grammar issue in the last patch.
>> > 
>> > The thread has gone quiet on this topic.  Is everybody happy with
>> > this version?
>> 
>> Yep, it looks good to me. Thanks.
>
> Didn't have anything else to add, either. Thanks!

Thanks, all.  Let's merge it down.
