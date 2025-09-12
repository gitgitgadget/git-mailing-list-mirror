Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A1028DC4
	for <git@vger.kernel.org>; Fri, 12 Sep 2025 16:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757694566; cv=none; b=Mq9Ow5UaqdGxqhyKTPflmEiBfB8XyFXrTLJP9YBiAQAHi21mAx0wJygLQJBf4HTK8SJSXDSVjbWyHqAfisAxuDBrkAQtQwlhGfhav91CEwEW8TKav3TE5fV3YCgkoXc8EtA/iOUjKylabfoIELeeXodjvOmkV9XvlmbTZ37Or74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757694566; c=relaxed/simple;
	bh=2jjtRWr+bppu04ebeExoipqC7lP+P+3/lg1OLxAgK8E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=joHoNv/a4aDIL0EAt9xruKpdsb0JEGdo1/hjeXZBgHT4JHwnQcBOJdFbWujzIyi7H1ZUrUplmlfYpxXKel370Mz9B51OyOFpg30VcDQQ0d/rmUZWhOrkb80L4IjBdpch2qPecVrZ7OHKxU/4LX+EmXCUmcS6xM0ss+7T35+qNWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rqgjE4Vy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P4NKt4UA; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rqgjE4Vy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P4NKt4UA"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 1AC501D00255;
	Fri, 12 Sep 2025 12:29:24 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 12 Sep 2025 12:29:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757694563; x=1757780963; bh=dtKUuo9FnJ
	MFypoSGSP1Wvk/R+1yL01L2zp/j5XaGBg=; b=rqgjE4VyBA7o6WyFJPFWLa4d+o
	xhmsuCNSGL/NTpjpkPT5OOrFtIeKO59+PUhjgo7Zfu7T+Ts5mz/xf1GTeOCc7ykr
	yJu4h/XPtPgoomDbSE4jaXcr6tJPdvmaWclHaSNRM26oy09IrlSFaTqvHeTNgRUC
	ilf6pvxzkucvS7avHQfTeyMptL3WMh/UmwcnKznaal0WEreSZR9L0QRXzuUCWwuk
	62DN6kd0iWJEZhV8bfH7/Z9QfjgKXfKHKpM3bBcwmh8XJacD/NmNJFaNltz/LSip
	0w24vjXcSj2BnAXkjvGQWdPkFtU9infNZjAUyu37ZmYu4FTTQ2gYsTFIZ5JQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757694563; x=1757780963; bh=dtKUuo9FnJMFypoSGSP1Wvk/R+1yL01L2zp
	/j5XaGBg=; b=P4NKt4UAE/b5oiMZsbklJWiLYd+BlgC207eS5c1EfY6YdQcYBtE
	xbFWnj1YMuLT61liKMhoYO6gZmbKNJxzBfX9IdSNeJ9sRkLeQn5sEJYHiKVKL0LC
	4vgC/iyjhI89T04w4Ay4BwUiQnCrMS6bfYjXHFQQkjCWwx3rSAQpTaSPhT/aR3ND
	BkvUrX0zWHGblZyVCCOUDYtdBife5gzBcbpeIRM8zHH5huRIDyGeW6C7QDV2H+/f
	g2OBEdbigtpwKIYvizYqmIkVUFxLat3jKuNBW7AEyarZS2LTyNwPDEXmMGJ0iqlx
	bADPmrwmRqJCBZ9SKMrxgTUfa7sxg7W/VAg==
X-ME-Sender: <xms:Y0rEaNGFDUx5HVJkw99JLnSbpq0Q37uL4PWGlhx7lGd_3ToCyo90yw>
    <xme:Y0rEaM7NkZAV7U23WzcCzMPGkmSFccsT7-FpFsfZQQ_LowmoGmo6bsD3_VSawe1N-
    mFoo1BVzcbPX1ozKg>
X-ME-Received: <xmr:Y0rEaLvCA8QPrT4d98IKHHIiT5uiAUmrDefx_L1Go__Th-v2aRsRWTLIokvFe-c_waS-RYzFqt5xNnf2PC1KVFjprm_QQLPuDCTP3TU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvleehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevff
    eufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhssggvtghk
    vghrsehnvgigsghrihgughgvrdgtohhmpdhrtghpthhtohepuhhshhgrrhgvrhhoshgvsh
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Y0rEaF4hMzKB5xPcw7-xPrBncqJg16TDiHyaoZ1Pw1gfxKdqB6LGhA>
    <xmx:Y0rEaOX2_eTg6A5mD9WtH61_dsgSE_NC-Cy_1CRWLsRaM-Js3G7G8A>
    <xmx:Y0rEaP_w-mT60TvKQhCCSBYhdPY4opH1_5U5_1El6kekFd93czfJ5A>
    <xmx:Y0rEaCmdnttDeiSOZAdv3atW6WG_SqPA8Jwh7e2sZAj2a4vBoruZig>
    <xmx:Y0rEaOW8uqGIdgL0n2qEGB7lKbKciNTbXt2M-FV7z34wB-K9Q1l-u4Sk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Sep 2025 12:29:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: <rsbecker@nexbridge.com>
Cc: "'usharerose'" <ushareroses@gmail.com>,  <git@vger.kernel.org>
Subject: Re: [DISCUSS] validation on git config user.email
In-Reply-To: <071101dc23f5$fbf06e30$f3d14a90$@nexbridge.com>
	(rsbecker@nexbridge.com's message of "Fri, 12 Sep 2025 11:00:25
	-0400")
References: <CAJKmQvf-sLxowLJLitvqDmyL1BXXDK+anDE2jaBSEabApMNVoQ@mail.gmail.com>
	<071101dc23f5$fbf06e30$f3d14a90$@nexbridge.com>
Date: Fri, 12 Sep 2025 09:29:22 -0700
Message-ID: <xmqqtt17my71.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

<rsbecker@nexbridge.com> writes:

> Some customers integrate single sign-on (SSO) via the user.email value. In the case
> of one customer I helped, the value is an SSO token used by GitHub for their
> integration. The token value does not conform to any valid email address format.
> Adding an email validation will lock them out of using git.

That is a very good point.  We need to remember that not all users
use the value of the field we define to be "email" to send emails
to, just like some people use "name" field to store something that
is not their name.
