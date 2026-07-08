Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EFD42DA2D
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 16:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783527290; cv=none; b=eQCfErfBulbgDmyCX4SZchBMnhHQz57npd7NVHb6qV4a1rOvFFO/OpLJCSX1s9vNu44aAV/gRIYRel7opA4yhzMBPet/pDU3MvkrclVUxaWOHX2E5Nip96uCugPvrvuEbmY2zicjVTwsneCBS/77iB1lLt+JeS7yvj6s4A87L34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783527290; c=relaxed/simple;
	bh=YGThhQaoJKRK5z5Nxl9mufvVWj9SeajkviLIaxaCQsQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iT5xXUdT6JcXThncn3k8RuMnf7aDLZDMZ0+CJlkDHDUWkQwaBuatkAPSei85obfRz2lbYhpMblWRCLdY01frG4l8TnjonFlLYZP4dXSmjl2XacWxG4yAHfEiEaAxh/mYj+zqhzmT6L9JRfNagKPXr43aRtQqycOAT6GLjL6+vSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=xLHlbVCF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EmjHpHbA; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="xLHlbVCF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EmjHpHbA"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C4A99140005C;
	Wed,  8 Jul 2026 12:14:47 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 08 Jul 2026 12:14:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783527287; x=1783613687; bh=nT/EcWEeQy
	KdxGg23oOdrL2n0z3PVAFrkAeqLOcpl+c=; b=xLHlbVCFkyr2czuutxfCy+ZRYW
	7wueSXl3cIMf+ZXnQQjXCF5p5OTLWie+IvXAzsBeb7wljAN7v7lIdmdAQFJBaIFu
	ar9APy2ibwS4Cz9lBln6J9e60mqxH39/0BovoUtlEZO1yOp5aK7l4kiVfABq7GN+
	cx8aVZlHKcJtga7nAArAkHxSito2bGewqHvt3mU9/6n8XdkavYBYEOFV5kYLlNbf
	ZGviEtZVv+2cew5fHwI31Tmw98yiOsxZLuv3uFf/obURB3yCU9yyc3OXav3LwmjP
	dTGEkSMmTrMZ4Jr8+JA1hxBqSGP6vdoiwqpyRregLkEjueC4aOtnjZvwS4cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783527287; x=1783613687; bh=nT/EcWEeQyKdxGg23oOdrL2n0z3PVAFrkAe
	qLOcpl+c=; b=EmjHpHbAF2UX/7ijx4VQdBSLMJYfcl47k2wYriLqiIFzVYtAD5C
	u0kpJ00/G8c0yd068+HYo56qZNpxdluQfVxSXD53ypUO5uXCEDteEZJ4VHvolB+5
	mIsgaO9vLSShpaptN2hfGoOzBPNhJF6bgu6Nw/8S6z4DpyogwQP1xUEc7sBnRQaj
	7pC3xvTjfZ4cRuHEIApzd+BCBXc66HZ/hi+SUIPODJrCJfYQwDrFtTGB38g8q3j0
	685Gesi8gdRjiXic8oRu+TnIjLWIwvXEC8aE4LPa7Xx93ebFYutxdpHNx4nplboC
	nRTrAmrpG0tXM01pBySKnbPu9ZvytpHSf8g==
X-ME-Sender: <xms:d3dOarBXRsDKxVpYeb57gpNnjoHia7IjZ0JdwrMs7fT9uJSaWDXx9w>
    <xme:d3dOao9tzTjy71SoBreEs4QoVwNpxY9HefcHEtQ-73GLV2EfMsApy5x_tGA_2QsfB
    -bNvualx9XvzL6dpFn-GgrFLHva5vauS13gmPExGgKFS7Ia8Icj4Q>
X-ME-Received: <xmr:d3dOaj8oOPa4RWXMoPSZQERk8wF6J68QeLoXHP-d-uSjJ2DNT4Jdur1KHxApUNBzNEJF_NXOeQl6fEwPi0tHeJ8na5i2mZXc4L7U0pM>
X-ME-Proxy-Cause: dmFkZTFELfT6eOWp/idKVrpUXkCwOiFrkNtBXIGlWcnIF8slavPrUVyhVm/W1vdURcKaLo
    Q6rcv6pOK6iGgBLJ1PxEYR7Z1GVrSgMa5m+ZuJj0IVt/blr9K5WIbZPtJO1TufCCWFgvFr
    RXyxOLKJPElWiPrGNld6uaR32RKiU94acBNR2maAr0/g2NdMv6XU7a/HIFIWTXocE0sV9g
    6Fe6CGN8ZHcNBrzjakC4WkYIiBrLS/qj/LYJGhPReZlgh67oPz++U6P8LTE//EjBxKJfSY
    fNLAXPr3PKm02sDCLQjXrMGQVA5p9ewvI6Fgbp73lTdHmX/5X1lQhmtQtz5rEP0JmNnZGx
    J5PXrrbo68qEfDlyXNOS0BLRbSMePu2Nsx9W+v5gSW/6T3JlyGtkapud2fiXGoh/4m5oZq
    R8JEqjHNqzujSuAI3qRneYXNvt0jFTzZZRjhrVUy6TLqNuWRUL1mUNdAsYdQBD0BFpCKSc
    H4X95egdiThelpT1sQTjV/BuajLAyTPG165HoBujmsqH8jdihh1/WO9tGxlFhTlnxDaYsZ
    z3WOVuWMcKFP/iAiOU7ljZC5keO67/SeZeDEu3pxKXbJvxpgme5boYWKJVr12G037Q3VMB
    VthpbJpiQECqwZo2rcuUNEc48bSluU+p1uqef5WyyzfE+kmPpSO3oJLpdIkg
X-ME-Proxy: <xmx:d3dOandA8O6xW0JHYoB_-xDNVvsOwwaaBVjScZwJZ4xdoMjvs_EHJQ>
    <xmx:d3dOakHYS6Blbn5P-Q7-ZBFwgdNBpmjp1GK_UWcHOf9wLdwx4-JvoQ>
    <xmx:d3dOatf6Eik-qG8-jaWf19at8V1Dgs8I1xY626kKltVKw7hkH0ZHaA>
    <xmx:d3dOamEBeah8DIahHGo8LBsfKTfuzHdh5sn7J9K1dB1zJa-xbA9qNA>
    <xmx:d3dOalfI73QLnKuyicru3yYlQrRvIYA9K5yvBPm82IIMEuyX5MorCjWZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jul 2026 12:14:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Kristofer Karlsson <krka@spotify.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2026, #03)
In-Reply-To: <CAL71e4MrQ25WJHp-08bTS2=y-gd36zs9CVYmYGeRv-6iCpdfdQ@mail.gmail.com>
	(Kristofer Karlsson's message of "Wed, 8 Jul 2026 13:45:54 +0200")
References: <xmqqeche67lr.fsf@gitster.g>
	<CAL71e4MrQ25WJHp-08bTS2=y-gd36zs9CVYmYGeRv-6iCpdfdQ@mail.gmail.com>
Date: Wed, 08 Jul 2026 09:14:45 -0700
Message-ID: <xmqq33xtwj9m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kristofer Karlsson <krka@spotify.com> writes:

> I tried building v6 of kk/merge-base-exhaustion on top of
> kk/commit-reach-find-all-fix but since that one is based
> on kk/paint-down-to-common-optim it does not include
> the changes from kk/commit-reach-optim which I also depend
> on.
>
> I thus think the status of kk/merge-base-exhaustion should
> instead be:
> "On hold, waiting for kk/commit-reach-find-all-fix to land first."
>
> Alternatively you could rebase kk/commit-reach-find-all-fix
> on master (triggers a small conflict though) and that would
> also unblock a reroll (but I don't want to generate more work for you).


When topic A depends on topic B and topic C, rather than rebasing A
on 'next' (if B and C are in 'next'), I would often do

    $ git checkout -b A master
    $ git merge --no-ff B
    $ git merge --no-ff C

these days to prepare the "base" to apply patches that belong to A.

Many contributors mimic this and state in their cover letter that
the patches in the series are to be applied on top of master at
commit X with branches Y and Z merged, or something to that effect.

Thanks.
