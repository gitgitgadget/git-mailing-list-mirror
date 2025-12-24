Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C271990C7
	for <git@vger.kernel.org>; Wed, 24 Dec 2025 01:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766540670; cv=none; b=u94jrzAEFNkycyrBa5QrhZllFt3Kc5kRBO5soCxn759Hzsq9Pf2sHNBF4NzLnVnH1gqzEeQg6MUnyyNuh55X9Hlodw5soUzepFvk+7s723n/Nfbpo8KOlxwE6UnwdQKJtO1a8xzBEm1JdVshCjxqruiei6NzVFu9mXyFsf17DeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766540670; c=relaxed/simple;
	bh=k/4VSnMWz/kBs0FZ1X4ThUwP5zebsoA7Br1v7zmUsok=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s58M/oO9saV1yOR5wlQySKjx0/wWkiWlNiY8hPH2Fnl68oMBEIGUFBrIItg4Rtdmw98tyOQ6r3VzldMH5fdmwtPkL70q56fUFDqXHDNOBAHrIPu9/gpoL4FWyLqn1V99pFXXHxsjPYybgasaJfL2lZqtFYZSKBdi4d/bDbwpBTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cxkQ3nSs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KvjztdVW; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cxkQ3nSs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KvjztdVW"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 381DA7A0075;
	Tue, 23 Dec 2025 20:44:27 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 23 Dec 2025 20:44:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1766540667; x=1766627067; bh=jOjE8eJcCs
	V0+9m7mEfkbE+XyVm5RoR61s5AFWeF1R0=; b=cxkQ3nSsyMfkmLN3Msy8T3ueU4
	E2Sz2web+6EkgvF5DZpohOPfj+O2ni0QbsDSfMlyZadNo0DQAE2nvhwGdwaVNXEe
	NMh4k2EfKClmoGFxtRxMx2iXFUyfyTHpuDiBxrTCTdCkzb73h1vLcaEnfy0CDne7
	yZQM2XEcRPbUKxXz0QRdYhEIoVXdwnmhOmpHv58CKhLriwx7Vo3aoQpOL1FopOSH
	Y25EPX80rwG9Pq5DmvC+NOC+H5uLv1WJY0fSxHs0FFUSQuLe6uFjUTj6LPORN+p6
	cX+81ZSkVhP44SU54xoj+wRYhBQdPTCCIDwwkkYYqSzzgt8RF9tGOn/nPlmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766540667; x=1766627067; bh=jOjE8eJcCsV0+9m7mEfkbE+XyVm5RoR61s5
	AFWeF1R0=; b=KvjztdVWavzSBYq7STVLSc+NTJrtn5Mwf23lfC90dU/rz5/oRml
	O239Ykfta7uuM9XKbl0UbYZHPPU0I7/BH0i+KZP2rIZhV/ITsdrYfYpXU+64limx
	PzmqqBE/CFXueP3GRpYhH8wwltphPYKM4qrMyqw5dkSWuL6EbypaQF88oFKPhCTP
	pMBQxefXOQq1V7uvybM+QDcDgvfOwS+kxeqlk+fsl1upH/55aYiDiDNz1qYvOH2c
	JnC17g/MgQyNW2ewQioQ9DlMZL28ylsLj2HCAq1QiEdR+WM1TAWOqhykuqIlVPi4
	zmj+9zMUl/ewPgifkzvhBP1gZtWkdSETk9g==
X-ME-Sender: <xms:ekVLacgK555iWsd0k_FPF0z4K1BFixRWKmScUMDSkjUcCw2rclKkxA>
    <xme:ekVLab4tnLdWVhCYqY3PnKmuUBW5w8c8mJL_YpawoXadZYyxKWXQmFW_U_z7uohKh
    Tl_6dFchCQq5zf-GIxvwePDYHd-T-yFItpZXE7lSuqdfo_zgUIBHg>
X-ME-Received: <xmr:ekVLacbA0hBWfajo9OeksWbM20bfbieYCTx4c_rBI0AKXzY1hPjT4XrjlJGCpT4Tg0eMwMVLM-Ly7TaDX_T3mdXGKrIw0tacHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeiudegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileff
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopeihtghhihhnrdhmrggtvhhimhesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgrrhgrlh
    gunhhorhgughhrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:e0VLaY4iF3MlIttW-qtms53J486gN-Em4aK0caLqIKmnJKYw92zTuA>
    <xmx:e0VLaXAH4_1jEepdrQOSrQayeQUTQMxTbySqb538AhhmIUWgW-JK2g>
    <xmx:e0VLaWcklRGDrAP_kUDsNiLGEyB7_AQqo39zd6LJJ4QwZMbyhsjP1A>
    <xmx:e0VLaeJRYrKAG7rUAoLBAHmZOcNvRObLxnCl7mQK-2MmfLUpHU2lfg>
    <xmx:e0VLaUICNy4lACLHhKQ1MTYPMLwcX-pKSlARZslCUWkJVLvig6Ab9nwV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Dec 2025 20:44:26 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Yee Cheng Chin <ychin.macvim@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH] status: show default branch comparison when tracking
 non-default branch
In-Reply-To: <CAHTeOx8nrjJVD0U0=BDTUJZNZX0Xs_b4YGbj=WSavWEPEg-9Eg@mail.gmail.com>
	(Yee Cheng Chin's message of "Tue, 23 Dec 2025 16:49:42 -0800")
References: <pull.2138.git.git.1766451217075.gitgitgadget@gmail.com>
	<CAHTeOx_kSX7RhVvjjffSK849MMQbjNreqrq=ezHazw0GjMO2Ww@mail.gmail.com>
	<xmqqy0msogso.fsf@gitster.g>
	<CAHTeOx8nrjJVD0U0=BDTUJZNZX0Xs_b4YGbj=WSavWEPEg-9Eg@mail.gmail.com>
Date: Wed, 24 Dec 2025 10:44:25 +0900
Message-ID: <xmqqqzskodqe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yee Cheng Chin <ychin.macvim@gmail.com> writes:

> I may be speaking for the author here, but I think the reason why the
> upstream discovery (or alternatively an additional configuration in
> the repo) feature was suggested is that not everyone uses the
> mechanism you described (which I think is the "pushRemote" config).

The mention of pushRemote by Harald is a red-herring.  My point is
that branch.<name>.remote tells what remote we interact with (and
pushRemote is used as a fallback), so there is no need to, and it is
actively wrong to, assume "upstream" or "origin".  Even if you push
back to the same repository as you pull from, you may push to a
different branch there, in which case you do not need pushRemote,
but you'd need to learn what configured remote you are using anyway.
