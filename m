Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768EE3D411F
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 18:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674754; cv=none; b=QZYt08eQb9YdOo4zbaLFKyqXAic2FrQY6tT0rgjJiCwVzm4Pupvu5tZ5OgxW6Qz1a6ZJ5+1D7pQqeWGmg2/yN3BS6xVy1kM5rVHkcFiDj3av7bTIA2tmlmQsuxUmsbS5iB6qEbSF/4NORhCys4ORodKjd177Od7UFcxLyUtpcEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674754; c=relaxed/simple;
	bh=SeYp+RGuXQNx3nG3Qxv94eTm38WFXe3b8w+Vghxbnb4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ve8t9ODlLvY/ajgiVT0lFMrfiY3Fhg9a4cET9vxvjLkDYSGSF/pEketJP0oq09ykxSYrl0Huci7FO7o21ntjZu3PMZdPRFzn2Kzo5/62GpU7KZPpxMjVvt1DjYrijKuPkoOOIBcqr5kJAXZ67Q4aQ/zuWaimPjl5+xfaBsJfEEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DvJLMFa3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Pj6/z1CB; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DvJLMFa3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Pj6/z1CB"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id AB771EC040C;
	Wed,  8 Apr 2026 14:59:12 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 08 Apr 2026 14:59:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775674752; x=1775761152; bh=kk/rriiU8i
	Bka1CcJ1LKQBUKykCaYduEu5bCF1eLEVo=; b=DvJLMFa3L+P51WVUnEbOaQ2Dzw
	F3juzYUY0MHH86PifRZWrx/1jh9FlbjyxWBXrIQ6LzLLYFVVS2QNSWNqS2EJMJ2y
	wvS2V7ZS30x2CcOeOWOAJxPXwiEyoMcCOZC4bmcJlgcxc9fTKqigE116oQ+qwQGC
	0DeCxi1hhLbx+6dBNWHLqv72Shscj0FyxWnnWMu9/q12ZTYd2RUXDhNCfHwkaybW
	WP/VJVQoMkPtNT5NY+zpYLve/0segGbiO1OGbKdL5dv5Z2gDk6TuQg62YyEpV6ZW
	grM0yLV4jJXrzUfeqf91zvPK6tkqPwtAGsCiY8N7joypepi2UTAK8WwNV8MA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775674752; x=1775761152; bh=kk/rriiU8iBka1CcJ1LKQBUKykCaYduEu5b
	CF1eLEVo=; b=Pj6/z1CBt9ld4WeoDHKefrEth+Tjkdf/fyuI/I8T0VJgyg51/yp
	8LEL56z57j8FlK33i00YHj9+CkRwGUJaNn8mPlQXtDYoBA7vbd8Y6tX9/XSc+qiO
	At20dRN+ovBQQMdPC2uBR1xEcuSJG4c/VKAtJqMiMLhjYLr+WJFPVQlennN7w1+C
	U/DvSrVoYJf3ZsQH6kQH5m9QVVQeQ+p5N2exdftVdMR26nGeSK+pD6M6v6wVvCaf
	6O5Oyx+DKHdXqUQjjYkjhGS+CdsqcdJ+hEnsGTDPUr+enVXvSVWdum6yrmYwkbYD
	kl6s3eu8aJjV5muL2R9fkyPagQf+gg9CGSg==
X-ME-Sender: <xms:gKXWabLjUsdarOJ51zWhYiVmy3U36Qt9feD5Zt7gz70iqbRe4jbMDg>
    <xme:gKXWaRbjwpnS38gWHC9S7Wsfy7tQV14mn5PTiZxs3NN_5-lxAh-Z0rHBn2Gc5Isk_
    sWgfPQOSrfOayezO9VuhrYo2SSDvWE7Cl5M3wQ2BLoIAeJgjLRo6A>
X-ME-Received: <xmr:gKXWaV9QjOelBpyFB3vUEgonQa3LQPIYhIlCfw6KKdPrP4hc8wocYbuVoWDn-tc4HLab3Gnh1q_0c4SGycvVdtoFpx0VMKp-yw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvgeefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    jhhonhgrthhhrghnthgrnhhmhiesghhoohhglhgvrdgtohhmpdhrtghpthhtoheptghhoh
    hoghhlvghnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhr
    tghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:gKXWaaYAN69MZ3iZDyOxkyVk3Ps4i49vo76BBbXI2n6Lg4E043x2HA>
    <xmx:gKXWaRM_vdkJsrDY9TgZFCooYmHN0UcY5xJ4RBZflmCilr14w4R7Kw>
    <xmx:gKXWaeBMEK7f6GbRFTxzPQEh0-RGaZywEPkpGlE6HixGvrhsaU1Lbg>
    <xmx:gKXWaQJXXFTnBGVwY0YQ4KiERMUJoSgnUxIkoTLc1gcnE6DFdbv2fg>
    <xmx:gKXWaaFi7eAynxJZiaxhwFdO2kYxDGqzqYLPHAbKqQ6K0nWsuIfmdC2w>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Apr 2026 14:59:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  jonathantanmy@google.com,  chooglen@google.com,
  ps@pks.im,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 0/4] fetch: add --must-have and remote.*.mustHave
In-Reply-To: <pull.2085.git.1775658970.gitgitgadget@gmail.com> (Derrick Stolee
	via GitGitGadget's message of "Wed, 08 Apr 2026 14:36:06 +0000")
References: <pull.2085.git.1775658970.gitgitgadget@gmail.com>
Date: Wed, 08 Apr 2026 11:59:10 -0700
Message-ID: <xmqqv7e1xoqp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Based on my understanding, the '--negotiation-tip' option is close but not
> quite what I want. I could have the client only advertise 'release' and
> 'main' and never advertise any user branches. But then we'd download all
> content from each user branch every time it updates. Perhaps this would
> happen even with opportunistic inclusion of more haves, but I'd like to
> explore this area more.
>
> There's also an issue that the '--negotiation-tip' feature doesn't seem to
> have a config key that enables it without CLI arguments. This is something
> that we could consider independently.
> ...
> Big picture questions to think about:
>
>  * Is this a valuable addition to the fetch negotiation?
>  * Is the interaction between --must-have and --negotiation-tip correct?
>  * Is the "must have" name sensical to users? I expect that this only
>    matters to experts, but I'm open to better names that could be more
>    self-documenting.
>  * Should we add a similar config key for --negotiation-tip?

Just like you, I hate the name "must have", but stepping back a bit,
would it work if we add a single boolean option that says "use the
negotiation tips as the primary source of 'have's you'd send, but
unlike the way how the original negotiation-tip feature worked
without this bit enabled, which did not send anything other than the
ones reachable by negotiation tips, do advertise opportunistically
other tips", essentially turning the existing negotiation-tips
feature into your must-have feature?  You could even call the option
"--negotiate-better(=(yes|no))" or something, perhaps?



