Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15071A3166
	for <git@vger.kernel.org>; Thu, 21 May 2026 05:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779342912; cv=none; b=D9wkxVzkKZmznZsZcaLXKZ+z1h39M5ByNElfeelEl6yRDeZGjtMeuwxMq8h/bUXxCxr1gXT9Wp2aDIyfRDuiAnUUTQjTKujG5i9RRUzviGVk881YaTxUKExUgyooiptnbyJIMcIgkXcj5UMs9Eqlnw9HMGmkEWaZEjnfJeW8Wto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779342912; c=relaxed/simple;
	bh=S7QTvt0W9tGVHjQ/mWuTM23ilnUo/9cTrvND51hQCXc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ow6Olc6UsOGv9ZOWIQajj8tixhzqygvw/LYOuphurYSS3gCvgYXEJyO+mOYtWMd+6gT6+nXNOH6l3zcV0cpnV0uAq6sXNMDe3tCSKtmMFVdqPsG6xu+qDI/4JYkkXdLic9qaITZCSP1KUqy73kqFmOwyNZTq1yph8gr7BIs21t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CEKm2llN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jp8Sohlu; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CEKm2llN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jp8Sohlu"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6DD0B7A00F3;
	Thu, 21 May 2026 01:55:09 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 21 May 2026 01:55:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779342909; x=1779429309; bh=3+xa9eXTOj
	LqAmTE4g7nQkcv/6KE7UwHPLXhkfDL0Uc=; b=CEKm2llNm5Nf0TQKOjS/g/HL85
	KzXuVPIBz8O5Rj6E3e8j8Mq4mwg1eH0FVtk6EgIDJ34oewG3daZpDXET0lq4ua1Y
	zabvtMHGODi/zCf7Zai35ig5J484+u6sISVoZ5op3Uji//i/jvl90Z778m2f8HS6
	QtFr6mOGLo8XuhOXDTVAiq3sPD2/taTHi62Hg0cbMSdIAFkWJ6nun53XCbu4cFcn
	5i3gPsQLSp95EyK/YKiy2+r1PlwVKt8i2cHnqPRVQSSrHnGyiQXWgeUZjx2n2AQ4
	sIa7/4UUOEpMui0y8N96g50kI2n6ez/H3a4FmWw1Wy/S8E8i56yeB1Tb/cJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779342909; x=1779429309; bh=3+xa9eXTOjLqAmTE4g7nQkcv/6KE7UwHPLX
	hkfDL0Uc=; b=jp8SohluxX/EOH2vVCL0ZEgWkMv6DE64lbsy8bDORyhmjGrYAdH
	b0bYa05SFlcUb4RVJss31FYeosgZAbhr1Qj1LH+1w5AeYzJBxtbfDqx1cKl2JDIU
	yr4RNW97wZPjtaV60UUnzkHY7s9T0V8n+TXjv2o2x1RQzH10UiCaO5MFZn+ZT534
	vEXzqDVBNvkO67Lhda1NmqtpYXvmYr377bmMcn00kRq9ASiKzBfjsHW/s+KU6vn+
	SO5tJz5tiif7lwDOoNb81dpjPG8Z1eMKlgpbwMEKqbb/CU2AZSUtRF9s9VeRFzTm
	EaPp1E9bq8SiekH13RB5MKyelJ7NtWZ051A==
X-ME-Sender: <xms:PJ4OanPqjCBj7Hr-qSH01HNoXWuWdkye8M8ujGqTPNnG4BZvCu_aIg>
    <xme:PJ4Oau7iM-av8nUTsawMVQdsQXRRy-glvdRMXgV3LMOopjI20tL5OcEFtTnWXaqF-
    yVtL7Tbx3tFny3hXDp9ackynNGC7uwZZAbA8cJF7qP6SHnEQfN7SQ>
X-ME-Received: <xmr:PJ4Oah6RSq7hz7NQ9TdvNJ119UgpDqGE1LXavdX2l8go8edToambUr70N-98kZJNkEa_2AAzXy3J1Rrvg51it7rEyEVA1PHMVQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeeijedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpsh
    esphhkshdrihhmpdhrtghpthhtoheprggtthhiohhnmhihshhtihhquhgvsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepmhhikhgrtghhuhesghhmrghilhdrtghomhdprhgtphhtth
    hopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdr
    tghomhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:PJ4OakFMByi9sNCHNCjmby14Ihq0fL48UY7yVdouo9m5-qvm62dsJw>
    <xmx:PJ4OapXbQSRSxbdGG4NCSjCKNX96rJemG1tdJ1eXhKIm0tnAFLVStQ>
    <xmx:PJ4OagWtccHw-dOUJ6QXdc57T9pudc_z3nAMLylFdnwrZECBnI1KhQ>
    <xmx:PJ4OanIJKYjzuedK4gI6O68AEMp-IV3eb8u19Se65Z63cSLdJOr1Bg>
    <xmx:PZ4OarEJ5JkkQlPyDjs_8XuES2ipOBct2zt4E2aRI7qmiRCorCE62Dwa>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 May 2026 01:55:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jean-Christophe Manciot <actionmystique@gmail.com>,  Mikael Magnusson
 <mikachu@gmail.com>,  Jeff King <peff@peff.net>,  Taylor Blau
 <me@ttaylorr.com>,  Derrick Stolee <stolee@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH 0/2] builtin/maintenance: fix locking and respect "gc.auto"
In-Reply-To: <ag6ahXA104_70g3e@pks.im> (Patrick Steinhardt's message of "Thu,
	21 May 2026 07:39:17 +0200")
References: <20260511-pks-maintenance-fix-lock-with-detach-v1-0-ccd7d62c9a40@pks.im>
	<ag6ahXA104_70g3e@pks.im>
Date: Thu, 21 May 2026 14:55:07 +0900
Message-ID: <xmqq33zl2tok.fsf@gitster.g>
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
> On Mon, May 11, 2026 at 02:29:54PM +0200, Patrick Steinhardt wrote:
>> this patch series addresses the issues reported in [1]. The series is
>> built on top of Git 2.54.0.
>
> Junio: I saw that you are starting to prep for Git 2.54.1, and
> a89346e34a (Start preparing for 2.54.1, 2026-05-21) explicitly mentions
> a couple of additional topics that should land in that bugfix release.
> This topic here isn't mentioned though, but I very much think that these
> fixes should be included.

Sure.  As of https://lore.kernel.org/git/ag1MHje6-C6nmcO4@pks.im/ I
think it can be merged to 'next', which will allow me to list it in
there?

Are there other topics that should be fast-tracked?


