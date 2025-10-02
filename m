Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF3231327C
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 13:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759411899; cv=none; b=RzNecRf+U1nLkpH5DiAS0WM14eHhwHuBdIyg9I9Z0QsccXsGPsVrBl0O9i64QrDEwmN40l2OY1bnsYgv2lvah/cXZMptXSB7dqe9U0+8zdfcbodfVKAfZQKrb6cVyzoFriPBwsRzj3nnOxUxDDaofA2nWMiuDWJTzOJtslCSmq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759411899; c=relaxed/simple;
	bh=h3xbT+7zS97y+Kn4+hibJim7iv0MpqOeqKMIgkTPi0s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lOJ9BKMTOU1j6Og+0n4VLKDFOZcsCO9Iqt/ly3bjKjm7Ucjdtm8gcUyCDym05iVD0tUwUwlWvoA+3gDqku4V9nGSeGUs2B5W+8i+foFkLw8jSHaUeDOPjmD2zdoEeGo1E4y7kaPyaozdNPowg11QSqZcXfGJa9tHeQlSSa61iiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AXkIddew; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fVHhzQCh; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AXkIddew";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fVHhzQCh"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id E75381D00100;
	Thu,  2 Oct 2025 09:31:35 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 02 Oct 2025 09:31:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759411895; x=1759498295; bh=nnuHlKfb0S
	8a5EdwvoF21+Vkw6IcIt11VCy5lKT+hCk=; b=AXkIddewoeqT2ylLPqdSfyTkMm
	xDvUDmXabqjN+tOucgj/faOZ/mSCEyFd2yxsGGpwAWgIsf+vlKCi7c36GBm2nJce
	gP4fJPp1J7ClOilSDtdlQR9iIlYrMGIMGf4PDGIA+rYkhDOgtx91ZxSGLLvmGRkL
	hVGFn8w/EWAnjqdgvgt/qmzSr2mNtbd/+u/NBj6gL3ALXLD4EtQBmKsh5PdITXtk
	ipIvXgiLW3VsW/2h0t3D5pp5XDI6Pm4pZzrOKUWweqajzHypl6Wb7TfL8oG7LIAq
	BYym/ZPEyeBoP0uirrvxIYjkXec9zBS5PmCZVUz+PyFhwZEpdTfrY8PXRrlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759411895; x=1759498295; bh=nnuHlKfb0S8a5EdwvoF21+Vkw6IcIt11VCy
	5lKT+hCk=; b=fVHhzQChcmavN+l+KepF/qzVRxPFaHnQELe/qKIyHFcrAbMmQIe
	k+V3yTPh6H1A0HRTlwUcMT5I3F7yNybiHqa78rHSH2Gcm3eHPqBMkQuL71qHabAb
	hy0mGnM9Zasu8kcQNiOHGaDKWD+joS9DK+KKG+3v72EPQcsrMnFeytk52Hk98hBT
	b/1VhKRUwDLPTtIkrv3IQ18yOw6BM5AR6x6bM07nHrzeJmz6cNxf6UOopsKdSJ8F
	h0jQ3osD5Syd52rOAXyMvRizjBmyxjlorXyPjT3PahkAxLpq66VFVmgYHpp+53tT
	lFdosmbkE2ub64XgExAibU1brVXnaE1y8nw==
X-ME-Sender: <xms:t37eaOFpAsx7cdc_0agqdCiKW7sKouhIWLSkfzoqh4wKRMvQieqCwg>
    <xme:t37eaGMhwNxS7M18roKsRGSOihB7wkX0yuBUuhVS5KOW2NyX1kJUvr7YSv8aGLrIx
    zb1tF0B4dquFrG_W7mJuzftC-L0HFFfiisEwdJ4IDU0vfsD5jBsww>
X-ME-Received: <xmr:t37eaAe8I-Dvr33qh9a7ASvQlOJOkM1uA1QhzalNECuulfVn8S_AJMQjXPw5Tu1YeFWEt9CkC9thxojnF7DOuMCHKDSJHoL2fmVG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekiedugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhgih
    htghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopegviigvkhhivghlnhgvfihrvghnsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:t37eaDuDOnjikoeMVI1xiIiqXAMy_yyMu9W_gE4Zu68GHpcoT3JXPg>
    <xmx:t37eaBmfShw8_kZkeyQvbAekL21CXN0NC2OdHtbVnHlROtpDzIQO_A>
    <xmx:t37eaFyNvnPscgmanquDNh6YdToEDcC7ICr1t8Xa9J_hdV_uA5jI4g>
    <xmx:t37eaDMgLOpTuG4SFGwUodEqS9izi_TCud19hfxiZMT-2y4VZH9u3g>
    <xmx:t37eaC8dTLYegER4F3GWLm9a099Y4zySjsOuCMG6iiMt8JqWG0I3SfXR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Oct 2025 09:31:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 2/3] make: delete XDIFF_LIB, add xdiff to LIB_OBJS
In-Reply-To: <aN4R51_j2ieF-sjy@pks.im> (Patrick Steinhardt's message of "Thu,
	2 Oct 2025 07:47:19 +0200")
References: <pull.2065.git.git.1759341748.gitgitgadget@gmail.com>
	<28e7fd27b632eeb681e7b9af4de2d18cd327be2a.1759341748.git.gitgitgadget@gmail.com>
	<aN4R51_j2ieF-sjy@pks.im>
Date: Thu, 02 Oct 2025 06:31:33 -0700
Message-ID: <xmqq1pnlzayy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Oct 01, 2025 at 06:02:27PM +0000, Ezekiel Newren via GitGitGadget wrote:
>> diff --git a/Makefile b/Makefile
>> index e8fad803be..d89ba03286 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -1397,8 +1396,7 @@ XDIFF_OBJS += xdiff/xmerge.o
>>  XDIFF_OBJS += xdiff/xpatience.o
>>  XDIFF_OBJS += xdiff/xprepare.o
>>  XDIFF_OBJS += xdiff/xutils.o
>> -.PHONY: xdiff-objs
>> -xdiff-objs: $(XDIFF_OBJS)
>
> The removal of the `xdiff-objs` target isn't mentioned or justified in
> the commit message. I personally don't mind that this target goes away,
> as I don't really have a use case for it anyway. But in theory it could
> continue to exist. So I'd either retain it, or explain why it goes away.
>
> In case it goes away, is there still a reason to have the separate
> XDIFF_OBJS variable? Can't we add these objects to `LIB_OBJS` directly?

Doing it this way lets us still keep the "logical" organization to
tell which object is which, even though we may lose physical
distinction by throwing all objects in a single library archive.

Incidentally this would slightly reduce the patch noise and make the
result more merge friendly when other topics are in flight that
touch these (like adding a new file or two to REFTABLE_OBJS), but
with the movement of these lines in [1/3], that benefit is
diminished.

