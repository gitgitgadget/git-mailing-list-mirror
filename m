Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A795437BE8B
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 18:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770660159; cv=none; b=cGDm5KivAvNIYEHReu7y3EsVFl5mxLs6M9LtX20GkqyZd4l5+1fsKcyN0Sma7GMWjqBjDt94eGi2psb+UrVsICeXom2+EexRNTSBivsR0bVcjjyaCjNYKcTV3SWRGq5TULybfW/I2ZQcAru477FVDr08kG5FzKU+cQCQsYLMHNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770660159; c=relaxed/simple;
	bh=yTGJ2JGizKiIAkn141sG4FNyqTPyqUFEnLVBCtLLvmk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PqFQdAmtBJlIxwcAOnE76zgs+FU1o9/XXDna/edRsZ7NXd3CLolMtMTKWi5oO9q6Vq1N5bXurGZqCSGpvXCzs+BVICcAWa0vsmut/83YBpZImZjg/ZH99WL5RaYIj6BlsB/hW4CYlrM1D58zG/8759cmhb1fTlyVCwRHso5S3Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PuDxJYB7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vdyR26Uu; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PuDxJYB7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vdyR26Uu"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DCBEB14000CE;
	Mon,  9 Feb 2026 13:02:37 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 09 Feb 2026 13:02:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770660157; x=1770746557; bh=FaC5BPUPcT
	VYuqdOIFQU9zILBDQst7fpdVc/brybdxI=; b=PuDxJYB7YQmieWzXfGg1y3RahA
	5iKpJMIvqRGxekXPN38GowjpyiM8ZEK/pw8KKoTfB5HWLewfBLuTMDnH99stY2FE
	cFpcWMWdoWUzCAiaxY2sQHW+qxnEjdS3825b928g+xxDzaxLYKpP8Ow8kH/rwTpR
	tVICtBFXRGpqmIDPTvc0z251Mm0M+SQOms+Nf6XYWCnXLiZhYoE/GGd0tYuL/gBA
	1DWGjG4XK/ZM+8JuzA29AUR8WxLeFF/F0s4FfZvRyTCIh+FXLKJIAbIyCWo/9FQo
	PoCLFzFDQkN+NdP127n7SP18N+KfOHX5856sWriMjXbG3f9wRjPT5ZKTgqMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770660157; x=1770746557; bh=FaC5BPUPcTVYuqdOIFQU9zILBDQst7fpdVc
	/brybdxI=; b=vdyR26Uu/WzQZgP9yFsusXDv16HikJbITd67SEsbqJyVC2+rOPR
	Srz3yvK9j1lYsH3V9BD2hVRmqDlJaco26DqaFWFxOSGJyeAZnhNm6WdURu2wtLWh
	bS3jKXLJbbOGok0Nk/z0hO3T8cOCZ+Rnd+Xs0jmUf96QI5i/zfstC8edRO9rfwLu
	tdr5zZH2wa9yg9fvkRJmBJJVfeCZoqFzqJPD9j/5ee6axLmXM3s+qLoNBv9Jklg3
	vaUnuTYJFQtE0OBau/kzpC86Uexid9OnAk4qB0v57bc5KEFU16p40YTnZKGNiXdm
	MWq3sWMV3rZrwDYxmSjdCQgG21Q6Hv9FvcQ==
X-ME-Sender: <xms:PSGKaSi4RsTpISDUhAJl8sEcM_YvnT5UH73ZK3oWvp5ZuBQLHoBzRQ>
    <xme:PSGKaZ4_naswRDpy7T_xc6m-SnGySDSaVnAuZ-_I9RIDLz6xkTdTZl3nrzNrqzCrA
    mdq9W-wOBTGue1giH7E-ahKEKsy29n5xkEpB8LgWZdbVw89fjbJRQ>
X-ME-Received: <xmr:PSGKaSad1qVelySnM6f_H0xZ5if81WPX7uvc_0yyv7AxyhKXUBhAlyi9SwMhdosCiUi1UPuW_sYWpu_bjTqPQrpUULhGQnhTLg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleejgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdevleejtdduueeljeeugfeitefhteeltdefgeelheelleelhefgfeetkeeu
    ueejnecuffhomhgrihhnpehmshhgihgurdhlihhnkhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrg
    hrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtoh
    epjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:PSGKaW43OsbUMi7zkvaXWSLt-Xq00QYcCy80vlcw9DJ_QvoNyAO7Hw>
    <xmx:PSGKadAqFGcdK1Ast3yUD-SNeLPtt1_sLt_Y1t8d7LBMpJkcIQF4rA>
    <xmx:PSGKaUd0yd0xw34NWTZ0veB2GGNZpFIrg0rCGAaEKfqKgV8yTDPRlQ>
    <xmx:PSGKaUKU64Y5BPUzl8mIAKarH99vMLV6MafXwWSRvXg9_Jf0QSVQjg>
    <xmx:PSGKaYU1YtaeUkzrOe3sUPfV6xaCVG5novhEbIBBZVV4GPl20TjxNr7D>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Feb 2026 13:02:37 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  =?utf-8?Q?Jean-?=
 =?utf-8?Q?No=C3=ABl?= Avila
 <jn.avila@free.fr>
Subject: Re: [PATCH v5 0/4] refs: allow setting the reference directory
In-Reply-To: <20260209-kn-alternate-ref-dir-v5-0-740899834ceb@gmail.com>
	(Karthik Nayak's message of "Mon, 09 Feb 2026 16:58:17 +0100")
References: <20251119-kn-alternate-ref-dir-v1-0-4cf4a94c8bed@gmail.com>
	<20260209-kn-alternate-ref-dir-v5-0-740899834ceb@gmail.com>
Date: Mon, 09 Feb 2026 10:02:36 -0800
Message-ID: <xmqqtsvp4wxv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> Changes in v5:
> - Moved around the commits, to ensure that the code to handle the config
>   in the backend is first. Previously, we added the config first, which
>   meant the commit allowed users to provide a URI but it was simply
>   ignore.
> - Fix typos and grammar and rename variables.
> - Clean up the description and documentation to actually specify
>   protocol over location.

This one looked good.

> - Avoid an extra memory allocation by detaching the strbuf value.

So did this (thanks Stolee for spotting the opportunity).

> - Link to v4: https://patch.msgid.link/20260202-kn-alternate-ref-dir-v4-0-3b30430411e3@gmail.com

Replaced.  Hopefully this is now ready for 'next'?

Thanks.
