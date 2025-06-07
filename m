Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D471362
	for <git@vger.kernel.org>; Sat,  7 Jun 2025 15:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749310332; cv=none; b=f8zcuQEVVP94232NZwVWQ3ThA6EQs5ae6EwvdTujMhSKcHu3blpMwgOmGAqeve63qaWrC0aOtb6g6EXb2cye4JK9V/fM0baHwKhIjI/1llh1cyCuiETYnR3n37g75YcHfEPV9uRrKek6OS6E+30/ft76vvmnQMyXjHmetAeIvTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749310332; c=relaxed/simple;
	bh=Sa19cbIB7P3RypFRORYU+NwPajrEeIb9O2IjE3Xb5VQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TfuhuCmyWoMhCLw8vjsKYaaMgP5VnNdAyGTnM1g2WhvhjiB/+mvCQmOEa7u9UBMZNeRb70ImkqAbTh8uaFmdq4h5f1l05TvDFfeTKlpqjg2T0D1FZqpaIaPnDSicIx0GBmQuLvA1QqPXW5zfzUUMozryL7EdzojbMBoWULFpYMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=uSpmfYpX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jo2N9R24; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="uSpmfYpX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jo2N9R24"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D1FA8254011D;
	Sat,  7 Jun 2025 11:32:08 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Sat, 07 Jun 2025 11:32:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749310328; x=1749396728; bh=PN0v5GMWpW
	CkK4oPT+KiNQLhApFn/Mg3g1UC/6qG4Dw=; b=uSpmfYpXj3kOa+x/fgIv1a5AF0
	2Hmo/SLyjFb3AD8R97/V3qaotIYLmATgp1sa8OFRvuYykSei3L12HjQ1poBnQTfS
	tKPXeP/LJx6UnRbSC6u2wU8pIWXC5YkN5Pi6ayG97x1W5ubgIAxwZ2llnEnAJR0n
	C/r5/NcQfeX9qPChNmYSkwRz16QWs6LV7sDXHubFixwRxuSpGNSiFOsubitwjtpF
	LioILSWsesEtUGovD5cua01e/Ut696z48W9gU5hrwUOV+cveyQATngnGoHuyvOCn
	h3D91Wyi4nnMjVzgubbkAAijNgm3gdkzuDzLB88xnGsZxKqYmL49crgKZjvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749310328; x=1749396728; bh=PN0v5GMWpWCkK4oPT+KiNQLhApFn/Mg3g1U
	C/6qG4Dw=; b=Jo2N9R24IF6Fz5cCi6YybR866yKtNck5RPTLoqnd0BSlRCe8s8t
	DOe+na6XO3GRce4vnQhPa0sjlWr7VAoc2dsD+OxTooPhGcyPrs82FpCXydviqyTv
	2GN5ThMu6/lYBvmCMzebmom2dvvnhwUMxBB2j2z0qdJXkGKccOsoTO/EPaNKFVVr
	Qhal8J0J67JnsnVhiVDqOneTATQSL+/msQM0bFyiZ7teSVfnWLwSPgHlLjM36Ajb
	dJxROQ5VaOLZbnmTLjRCiRMB9EauE24JLiAhyVCKIte5Go0CYDhv4ybIVnNJVIRp
	+8+Lv/S2l/gXLHDnMOiNnfS6pOtU7c0BYNQ==
X-ME-Sender: <xms:eFtEaALx293txr4c35eCiW8bn0Wjmog0f8Q9MqOSTGpcGCtDV8eqYQ>
    <xme:eFtEaAKG-0LZRIMIiCKFQEyHpR6Iv1yUpFUOyWqwlxcVDkzo-qxYUAD572GAyrZ80
    4t2n_Fc5DHonPWuTQ>
X-ME-Received: <xmr:eFtEaAsztrxry9C3cjT9ymoavCQtCm66tavb-HhVk8tUZthfIYKfKD5gWcgfzTpZnGzcWfXExLXDC2Nkq909K82f5bc0s2FV56q3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdeijeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghgrrhhgrgguihhthi
    grtdeksehlihhvvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomh
    dprhgtphhtthhopeiiihihrghoseguihhsrhhoohhtrdhorhhgpdhrtghpthhtohepshgr
    nhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepph
    gvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghi
    lhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:eFtEaNYJd-j-2MrltV7JbTRhDncwpqMJJT3tqwSHpTlRkdfJOHKAPA>
    <xmx:eFtEaHY4Ec9iwp7h49jQRdnPqpQKlAcmsImVZhX5zugK5gd-yhuBDQ>
    <xmx:eFtEaJCqvYTgZtRJJcK6ciGVcNslsleZb5Qp2L0KG9N6oHER1rFg4Q>
    <xmx:eFtEaNaQXHsn4t5gF4WF52ZssZSrhxsAqeVY0B0Pb9r5AHGVANoC_g>
    <xmx:eFtEaNn-SDLeZOTUSR295CFlY6lcd7E5zKvC5RuNhJ6-EWbo1sJAdEVE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Jun 2025 11:32:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,  Zi Yao
 <ziyao@disroot.org>,  "brian m . carlson" <sandals@crustytoothpaste.net>,
  Jeff King <peff@peff.net>,  Ben Knoble <ben.knoble@gmail.com>,  Phillip
 Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v14 05/10] imap-send: gracefully fail if CRAM-MD5
 authentication is requested without OpenSSL
In-Reply-To: <PN3PR01MB959732DB7232FFE1ED7D38F3B86EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	(Aditya Garg's message of "Fri, 6 Jun 2025 20:06:27 +0000")
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597BB453E9980CC50AA6703B86EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB959732DB7232FFE1ED7D38F3B86EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Sat, 07 Jun 2025 08:32:06 -0700
Message-ID: <xmqqy0u3zhxl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

> Unlike PLAIN, XOAUTH2 and OAUTHBEARER, CRAM-MD5 authentication is not
> supported by libcurl and requires OpenSSL. If the user tries to use
> CRAM-MD5 authentication without OpenSSL, the previous behaviour was to
> attempt to authenticate and fail with a die(error). Handle this in a
> better way by first checking if OpenSSL is available and then attempting
> to authenticate. If OpenSSL is not available, print an error message and
> exit gracefully.
>
> Signed-off-by: Aditya Garg <gargaditya08@live.com>
> ---
>  imap-send.c | 61 ++++++++++++++++++-----------------------------------
>  1 file changed, 20 insertions(+), 41 deletions(-)

This is a good thing to do, but I would have expected that it would
come a lot earlier in the series, perhaps immediately after 01/10
fixes the copy-and-paste bug.  If this is moved earlier in the
series, it would need to introduce the try_auth_method() helper at
the same time.  Since there is no new authentication methods
introduced at that stage in the series yet, it would be quite
straight-forward to read and understand the patch, and on top of
such a solidified ground, the series can add OAuth2.0 and PLAIN
support on top.

Thanks.
