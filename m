Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CAE3DDDA3
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 15:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776267101; cv=none; b=T26uOffcXI/LWuVHpqUIuACYgOs7+SJdM5gDRx7szEm5IRN5BXJR2DsZOXtT2Z7n1pQhwKAvegyvowJoDQRNq/2R/lQiUGjJ6K4mKK4c5clcvAai6kHcU2LajXawFN5OC02opdw4ROBTsStX+fVUlWcu6GxZQnnzHfGMohCOWKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776267101; c=relaxed/simple;
	bh=LYtlGZyzTADspnhnvXMR326R/ym/gIt1yVe45Yz0qUA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Bz6yd3NeuhzTtqt0/8oIGPAcfh8KPQHiUfSd9hBk746rZgE51a0RFNXgIgM4rh84llhl0JlQDq4GWOVIEKBxmbDuDrOgRsvRslG9TeOFsT5OhYPDWlinCq2+X6wPo11+ilPT27nUpsojgLSSaacpcXVmO20Rt3uJCOIJZwAMQBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mEKfbF0O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B8bF3D+B; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mEKfbF0O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B8bF3D+B"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 1ACF31D00070;
	Wed, 15 Apr 2026 11:31:39 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 15 Apr 2026 11:31:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776267098; x=1776353498; bh=LYtlGZyzTA
	DspnhnvXMR326R/ym/gIt1yVe45Yz0qUA=; b=mEKfbF0OtsGLkMIG0Kg2x2eivz
	z2WMgY8CibiTY/qnFhFVrM5yWjhJpCUqBoVSTz2piwlQXBg5WpNX7Rg2iJzQfEnL
	W8GENLt3UJwYLfxpcLojfgm+xzvgbwO9tcYwFmaWV9UnBEPi34o2gGxBksERg154
	6ukmS8daoQ17LWKe6Muh85Yk92AkJTLAYtwuCCX0I2IwLlQ31xIQ7bKx04RudG6Z
	8faV7KiSGSjz7oteiwDnpvdVksFM1f1yVEP0cMuoVYeJg47O0SA6bRIG/TGn+B/7
	yVZLvDJY+eMgFAxWyTs0VX9WcDIU53O7F9j/NwjBD26QPV4VgiE9sCX5jsQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776267098; x=1776353498; bh=LYtlGZyzTADspnhnvXMR326R/ym/gIt1yVe
	45Yz0qUA=; b=B8bF3D+BBc8cU/aXGm/4XasuKjzsjUoRqhL92hkXeNwX+xHYxLf
	BQbTzjHDBZYV9dPz96rjYGl3UgQNRrv8CHFflUf2QD8nBiFIa61xz/jOreEY2Xsx
	X2TyUQjXTClKfQAijZgTxXSILzqEJOLDre5AmDV+1OTIKE62Lr1WqFEjVAcJF49p
	H21RRN0pXExL4UGWqlnnzqWjSdFP0i+HfOqylSWVkCkZmEm0ROhFbFQ/antGtWzn
	uIkpN8w4pEHvz1iHYIIpHIDCxyOUbbuhXzkxKZ0PwP0F7VTsDDsWdEqwIDjZSXVo
	EVOiRUi6ipbGs54h5wiLUI//1jPI7PmooDQ==
X-ME-Sender: <xms:Wq_faeAXgF_cls9qssZok0droejCYV9geq_1qSBCSQTq_3yUk4_IJA>
    <xme:Wq_fafgqrGT4we6jwp2WDnvGxDRRo3ComDCLlSaL2ObSKejru7EzFIdwmljp-d-X2
    ggHRmVaudJznuCGmRcs98M6yawjSBB3fyg1d-awoSaFXKRC1VO7lQ>
X-ME-Received: <xmr:Wq_faWkpc6angofc7bZY_jdCMMwfOgM7riF4MxpVADsuYyY4xZiKLZu738w99ljnBvxu1BF57Cz9qRsgV7_g8WZwTpWFlEyjJw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeggeegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepph
    hssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Wq_faboFKWpsD-CCwOh7EA43DoUfBgIU-Tu5_5rCvgj9MfVUHy-L-w>
    <xmx:Wq_fafHBVU9rp5rg-pHrWVUxoNnYvvexpVZn2fRVEscu3rS0SIMjow>
    <xmx:Wq_faXxnhOplzf2bFSV1twnIrBfjsffixJ7jTIIU6lpOWEUjjUfIBw>
    <xmx:Wq_faUqLlEUuqw9__MRfS64Uz8Bpz6Lgxk3sd4DWaSMqN2Eqe7K_0g>
    <xmx:Wq_faVjoQq85qL32diq9ggCe-OJQBc5-WVje6_JQrGgTILaa5rB-6vd2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Apr 2026 11:31:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH 06/12] t: prepare execution of potentially failing
 commands for `set -e`
In-Reply-To: <20260414230810.GA3528448@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 14 Apr 2026 19:08:10 -0400")
References: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
	<20260413-b4-pks-tests-with-set-e-v1-6-5b83763a0e84@pks.im>
	<xmqqeckifq59.fsf@gitster.g> <xmqq340yfivf.fsf@gitster.g>
	<ad3rgbgadjIZRgaz@pks.im>
	<20260414220347.GA3475127@coredump.intra.peff.net>
	<20260414225206.GA3486072@coredump.intra.peff.net>
	<20260414230810.GA3528448@coredump.intra.peff.net>
Date: Wed, 15 Apr 2026 08:31:37 -0700
Message-ID: <xmqqa4v48ckm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> I guess one other option is to avoid turning on "set -e" at all for
> known-buggy shells. We are not relying on it working everywhere, but
> rather hoping that if at least one platform uses it, it will find
> programming errors in the test script.
>
> Personally, I am still skeptical that all of this is worth it versus
> just checking stderr.

Not having to "check" stderr is powerful, when you generally just
run your tests with the output sent to your terminal.

I agree that it is a good workaround to use 'set -e' only where we
know it works.
