Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD82F26ED46
	for <git@vger.kernel.org>; Mon, 11 May 2026 02:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778468367; cv=none; b=m0WfEsmSbxB7WV8UZsaAwZiWaR+ZR2uaAVjjqtYfP3tBgdQW6TaFNOJEwT9DdbRzsrKNWSPBP2K3Ac4N3PdM2dXdlQVjECcSQ3nb6q4jFI95+2LK4obhD0saSFPoExrbvuHlPWzxvY+aWiA07CItGftopuCBxIzosx696POAhbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778468367; c=relaxed/simple;
	bh=WgjX4paE3NKDBWaoWoVnLkisp7whP95qnyWneiT5azc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A03YjUoHcv9lNxaVSAcw56bSSNHbMG7aF69Xe3NTZCurdbRDSydEd3ZxH78/xAdKibgxjLBWaatmpIDGo+P/jjAk+Y53HTdX3AkKgNGvE0Db+25hbIj1jTh0brebpLNEk7Ug6+322/l+6UfaEL/DSUfBWbDMZg1+uAdqKGC0dOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QMbEgN9R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SOsZN0IT; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QMbEgN9R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SOsZN0IT"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E88667A0098;
	Sun, 10 May 2026 22:59:25 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Sun, 10 May 2026 22:59:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778468365; x=1778554765; bh=9BB/FC9PpJ
	kqd5TTCdFfowT1EG1bvjgOJJsgMT3+6Vw=; b=QMbEgN9RkIffVQi65jaPCClNCb
	NYgqtHeUxD5554sIvUxenSH05Xnk6hHMuQTwEWULM9kQ86h7JJfnlGyIqdNrOpLo
	v6gUKiKmDVm6iJtFswGR+rTmICLgXOk9quxixX69QkowmZgJ/1tPWUhToP0i+jj/
	eO6YDL6VeUqwKa8+ifJqG9p54JZ7vSjDh+nA6cDxHc6WIjKGGO3oMR2DWByeeYKb
	0BkxA8snaRXNCGG0jU+/UrUDLWBgkuV4K19NQ8v2NrRNCtDxcuKj10NcmHU2k/NT
	z3lTZYEV0flO9EIKqUkCNKMhB8oyXpC0L87D56mbfHX/Dqc+Adb0ntzqK2XQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778468365; x=1778554765; bh=9BB/FC9PpJkqd5TTCdFfowT1EG1bvjgOJJs
	gMT3+6Vw=; b=SOsZN0ITqOgtyimlFAnEO6icxS/Q+FAGZS7UBQFiDT8UtDuhdOX
	gKSos22HMVFtdyvkhHkigV92Z79Fch42RnJHJRXc7fMKp3nx0SNUxczvjcj/E+fB
	EuM2NOnSVj6VYQsUyqilqbveShIdCVdC0gzgSNVaLeEZC+sEHoSAJ3s3Xe43ryrz
	IaccHdlIPSRb4FoEZsJ8CwXaFQDAW9Oob8E2F++f2H0YG8W0BLS/JAZhbjmDI3Hk
	50189usQg7C/vg/o3dfMAla0m05VqxvCGn7kfFjIBOjCQg66c/0YbVVPOIV4avS2
	jZKS4a6lGvY2+PGNOXe3EYpBQdHXf/8b9Qg==
X-ME-Sender: <xms:DUYBavj_sAvV-qiufpi0G23_Ngc1b3yNC-9K9ci7qQOQUoNRVVpflg>
    <xme:DUYBavsNZwB2AhGdcnXMG94-7PAU6xODM20WE0tgB0iiCc6nDYF6a9D39gHiw6Z79
    62o-hwJ3BI_4gR33wDTfhlzMA7INwjaglkCHXMthb98R4M8oKPTPw>
X-ME-Received: <xmr:DUYBao7Ql5hPvJKlRVST_kQsqacNTwZXotU4dnOzWBhL3nkEfRWcAvD3AVF1o2YmEBuBE7GR6wby5NwCMGujcxPmkIFzYUW4JQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudejkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohephhgrrhgrlhgunhhorhgughhrvghnsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtghhithhgrggughgvth
    esghhmrghilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggr
    khhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:DUYBajPQ2KhNQXkuyhHhbn0O3uIyl_SZFBTNZj7nvKq-Y6Zp2iYQKw>
    <xmx:DUYBautG2D7sYMiVAvfXnUIzJModyRXT6UgdOSyQfaGRFetXTQb-FQ>
    <xmx:DUYBauZyocuNEoQmWnG2nNyjgH5hWSIgulEwbOcikpbj5gEL7hEhag>
    <xmx:DUYBaowGCS_--PPfCaOhmFmapfGcHiiAbexQ2ypjfyLpvOpqNI5Jlw>
    <xmx:DUYBagtk6E6pTyK7AhE34fucfT3V4jzNDHW_CxSVAP5DZWnuvPH_7mie>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 May 2026 22:59:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: j6t@kdbg.org,  git@vger.kernel.org,  gitgitgadget@gmail.com,
  kristofferhaugsbakk@fastmail.com
Subject: Re: [PATCH] fetch: add fetch.pruneLocalBranches config
In-Reply-To: <20260505220712.93952-1-haraldnordgren@gmail.com> (Harald
	Nordgren's message of "Wed, 6 May 2026 00:07:12 +0200")
References: <1e38fb35-f75d-4067-856e-b5c15f507007@kdbg.org>
	<20260505220712.93952-1-haraldnordgren@gmail.com>
Date: Mon, 11 May 2026 11:59:24 +0900
Message-ID: <xmqqh5oetzw3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harald Nordgren <haraldnordgren@gmail.com> writes:

>> I have some sympathy for the desire to clean up unnecessary local
>> branches, but I don't like the concept that `git fetch` modifies local
>> branches, not even as an opt-in. Deleting local branches should be `git
>> branch`'s task exclusively (at the porcelain level).
>
> Yeah, maybe that's a good point.

I think the latest iteration was sent after the above exchange, yet
it seems to have changes to builtin/fetch.c to cause `git fetch` to
modify local branches still.  Will we have another update that is
hopefully final to excise that part, or are we OK to allow `fetch`
to modify the local state as an opt-in now?

Thanks.
