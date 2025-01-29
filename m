Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B80B191499
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 19:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738180375; cv=none; b=uq2/Yb84yVbJmJnCPgRek5DQAYkTQxD0Y9AeW6Tqz9ljrkVYKbP4P+Qg6XNcnDRzkWAWWuq3FPBVQtcERstHBG+xUn20k2XgR/dfQA9j6frL/Vyben/4RlnkKiRZ2JYPHXelS/dOi0dDUIME2DoCxupwgOkbBJvJywqn9yxiBSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738180375; c=relaxed/simple;
	bh=2KNh+My95vYJyG2znyw6fuxlo4dMKrnzZIb/+xwKKyg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pPeCxK4r/mNsjBvMGxIM7JIw22BRVHBNI6FMUKHVBjnYwUZgtMSyGRNJR5uHzM2y+EuCAaEK1vgW2MsIPkzImfrFt2nvvdflc/FnHqFebX8MM2aXgh5UKY6wZOD4waNmu76Vu0GnYoqKNFX7cqlFeQXyvouARRDAQGZnMuhzz2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=uyGK290e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ePb2eIZw; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="uyGK290e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ePb2eIZw"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2851225401E2;
	Wed, 29 Jan 2025 14:52:51 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 29 Jan 2025 14:52:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738180371; x=1738266771; bh=J9VjY8OJdq
	Zmrzc5y7MTDh+zM57ncZuS4O0Z0Wg6FYY=; b=uyGK290ezrKzlGM8EjZ3OJFoDX
	4D0NBi19Rj4dAC7Lyf8B3NxSxhM6R2kNPHy+WevScl5GwYahIw44NWGLIp2V1yhQ
	QHNabb3WQUfXuuq+niJjExdZ+B6cz8PDd0rT/LLcBH1xp28yKIB4pe45gf647V9g
	IIic5ANmKPsJaBp68KSRU91r0CMgevkHRiPNXgJISZok8v0mUtF7nsZ0yKBD2V3p
	ftb2VW0I2egpT9rqjBWebe2quOCc//MZaqeYKJ1l+Ud1iFFtaCcBSU/14ZxSORLb
	LRkO1QtQT8IQu1SWJkyTzUSRuxURcVcZYpcY1mc8Q3JYam2iSopf3XMw+MJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738180371; x=1738266771; bh=J9VjY8OJdqZmrzc5y7MTDh+zM57ncZuS4O0
	Z0Wg6FYY=; b=ePb2eIZwhpj8v0m6noF1oTHXzlzFuW0aNuqRbdEg/XJ3f+wMOUe
	Sf20J6BCM58Fepo4YVi2ycG7TJPdM6lY6g3rhbuL4oGm6CiF9zWXmTxEHs845jcY
	jFu39HLX8/1W251EA3dBrNUEMVBLt0c3y9Vz1w1HYPijZiMDBVfVuzvEiJDDZGFe
	Ov1entP2CbLOtrW2yUq8vim1/o4we777J37Q8Keb53unlPlLW+MM9xrKgc2gO914
	5inFZrbv/FhrRs4db8JYvCkcdZ/1zbNjhiUDjFKPR13310qhm1Y3ybj5eqD6cdSr
	0O9UECwr1Z2FxRcjGHQV/AukuS9m8ckdz8w==
X-ME-Sender: <xms:EoeaZ2UASPxlwTPzdCLnbyroS8pQ6H8ZqlvdNHFWEtwfKDuktJTE0Q>
    <xme:EoeaZykFFVb8ZVbm7snMElBLI00vh_fkEwF02pgyYqeJlyD5JaM0IWUdni_NVJJTD
    WIy4HeD0DciPAkl6A>
X-ME-Received: <xmr:EoeaZ6ZgwtDoV9zIL3Ahms1Xk174P0i358iJd-ZhOBNpy2caoHjgPbPzyEH2CJh1ZLqVYLy38ch7QnONJWzJoPgz_cocaQEGBNhp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeejgeegfeekteffgfehudeugefgffevfeev
    vddtudevhfeiheekgfegteffkedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hpshesphhkshdrihhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggt
    ohdrtghomhdprhgtphhtthhopehsohgvkhhklhgvsehfrhgvvghnvghtrdguvgdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:EoeaZ9W2g9cjz2cXqSiG-lQR2Nnx41PjyrSZfcVQzpVFIIBlA4mEnw>
    <xmx:EoeaZwn795cbfz2InOKwkUr46TnPSSK0103rWE10JeVezOAFFktzsQ>
    <xmx:EoeaZyeVUjtaZcVUE_2oT7H63i8BKHB8YL-lRbuf-MmmI6FeCRlflQ>
    <xmx:EoeaZyEdvDjA23uP6MPpSB9BkFx93EXJ1Ct9kcbM4gywNHWBJSr2Gw>
    <xmx:EoeaZ-ZIeldTWCR5WQVc3qG51iar4k8vJN5GEXT7gaAcqIfxVk3il5dv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jan 2025 14:52:49 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  sunshine@sunshineco.com,
  =?utf-8?Q?S=C3=B6ren?= Krecker
 <soekkle@freenet.de>
Subject: Re: [PATCH v3 1/4] add-patch: Fix type conversion warnings from msvc
In-Reply-To: <6a251603-25bc-415d-ab8c-ae698bd7977a@gmail.com> (Phillip Wood's
	message of "Wed, 29 Jan 2025 16:51:42 +0000")
References: <20250126125638.3089-1-soekkle@freenet.de>
	<20250126125638.3089-2-soekkle@freenet.de>
	<6a251603-25bc-415d-ab8c-ae698bd7977a@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Wed, 29 Jan 2025 11:52:49 -0800
Message-ID: <xmqqsep1iei6.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> I'm afraid I'm still not convinced this is a good idea for the reasons
> I explained previously [1] together with an alternative approach to
> silencing these warnings. What makes "unsigned long" an incorrect
> choice when that's what "git diff" and "git apply" use?
>
> [1]
> https://lore.kernel.org/git/e396131c-1bd3-46d0-bae6-cd97ca9710d8@gmail.com

Ah, this patch still does that?  I was hoping that it got corrected
already after it was pointed out in the previous iterations.  I
agree with you that size_t is a dubious type to use for the line
numbers there.

diff.c defines "struct emit_callback" with lno_in_{pre,post}image
members that are of type "int", which is somewhat dubious, too, but
at least we don't run on 16-bit machines, and being limited to 2
billion lines is probably OK.  I am OK to upgrade that to long (if
we use negative values for some oob signal) or ulong, but that is
clearly outside of this topic.



>> Add macro str_to_size_t for converting a string to size_t.
>> Test if convertion fails with over or underflow.
>
> That is welcome, but the implementation needs tweaking. If you look at
> other uses of strtoul() in our code you'll see that (somewhat
> unusually) one needs to set errno to zero before calling strtoul() as
> one cannot tell from the return value whether there was an error or
> not. As errno may have been set by a previous function call it needs
> to be cleared before calling strtoul() so we can be sure the error
> came from strtoul().

Nice advice.

> Best Wishes
>
> Phillip

Thanks.


By the way, who is
<CAPig+cQ49Hdc_8=mRhhJDTny_Kqo6Wg6Nr98rsBN_YXmBrQ6kA@mail.gmail.com>
and why is such an apparently bogus e-mail address Cc'ed?


