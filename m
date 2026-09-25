Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA7041D208
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 06:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790318521; cv=none; b=FruwVURR9So1QraKe2r7vRrB6gr1cBixNFPA9VVICjUvvxDzTFqaoVhohj3q6RMDf9fVd91eGQUSe1TEBmgBufGu8w7fa4pF5TrmZpBmw4bERHxIRhXrhNzd+4WXB2GYi+N6cDUgMjuKGAyEKxFcX1JLLvZ5Qr8N74DJmvZJUO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790318521; c=relaxed/simple;
	bh=26Q75XTGg8SIz3NI7tCzL9vAnZafchL0NDzLZ4kOZD4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OWyvm9gZg7MvYQl/4g3hQUvqec/c+LR5ONfCBQB9PAJUgb6A+pUKX+m+vj+WTx5xKHZ1WOip8S+udJOV6hpbjfbbjUdfDDp3gS88pDm9Mx1kw1tRJSgUzql0JP3A7umve9spbHXpXV3103Iu184mZND/MiuiPJwfw6XihIgk6Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=prNVtPKJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EplNZD20; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="prNVtPKJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EplNZD20"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 758DFEC0089;
	Fri, 25 Sep 2026 02:41:58 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Fri, 25 Sep 2026 02:41:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790318518; x=1790404918; bh=tr5kbXhWNW
	AMJoHYu6X38VCqvkm7PO0Sm+akQ/zqEH4=; b=prNVtPKJeuKe/WZ051lOOh4kRi
	2Df+1YdbO7El2tWmMA03SbCytgW/iTIg+yD7afctil0M/zMWxZsYEggTEDQt0flc
	A+kw8K9RxdU83grIDYf6kyKDg4X8ESOobS+OrBzd3H+ODO3P7xelCMdebdwmzqN6
	Z3sg8KqBGC/CBHs/Ultn/hL98TQDLrlb+kD8NGgVJqPGdYXTk3CcrHyW+B6QZ5j7
	VpsTa8CifoBfWGJnuxKnEQvJ1/no/suCPSERhkwifzNd3RolaThCvlGr6LDJx6Yg
	FxSZyNUP56GSZS//xS+Mcxd8jglGFhjU+5Tp5/OblYkvVQhCbp8lCnrfKZRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790318518; x=1790404918; bh=tr5kbXhWNWAMJoHYu6X38VCqvkm7PO0Sm+a
	kQ/zqEH4=; b=EplNZD20P9g5Z9eLLOrbQpdZjXoGyQvvY1QMWcqbhebZL7IuoRw
	tys4iAI5BUJmt0amk9PdCUkJQec1aDIp6CJ24pKKFt2T+H0B0GDr9e/W0kCbvLIK
	zKupvn5RjedzeV9XJJZvf04DZqgo2F+kSK4uQdmdCwxfoX+K7rebt/bcwGic6ep+
	fg61uuzYH/w+e1l5woTF1Dw2vNaU+1lHQjwWpvAZO0U718fCkMxYyJX92Z/4dB2F
	z5l7GnVpd9sWY7GRZyTDsmnYwI43iw9xKFW1tal2UeFXmn2qzllD2ybxljGhHfEJ
	brIVI5lRd0I0iRS2YDKjOv4FOdqP1rqHxAw==
X-ME-Sender: <xms:the2akYrqCDB1Q_CJr7QK4wBQbw6a2bX_1tRjktFZij95vcVlYk1XQ>
    <xme:the2amQ3MLIDuSSmQpFVt8DXBokYbaxDiqLTqQog-wSSvWfiBoPgMua82DSgT22r4
    c_OmlpiCwIvYOGSo2NZ5wcTuwm7YVHv5JbcNCvj7_bhT_IVimDuviw>
X-ME-Received: <xmr:the2anQAjpu7XzZWw2v0_ssyXgQ3spA84mRnjNiTgWhbkFY9k4XJgxF5dD6aICgQ99FZmEykLJSCuqdt0JT9AJ2CemfivaSunANo>
X-ME-Proxy-Cause: dmFkZTFYJUFOWRdkbws5J8f1/+3xziU1MD8vm0FtkS435caiyby/XsktAKfd4dtcMWjMuH
    jX/Nkmtp1ZqnWa2lFOmYozuaao21r+Mc6O00oAZYmGg+/6AK/xD+f9ARTmDcf576EI03gR
    iKQshLuJhmJCv5LtLQGYgapGv0yTvl9G0Z3LbK0C023IJym5TQLFHNrpNhxdD/qSk01rqH
    9Vyys3YjAcAbSESjtANtRGvWcfCsXmaiwTfqDPSnyLJN23m9FcqVKTPrvVloxSUQIuwT7f
    XpI6bWdLZLaxg6sXqiFWdq/I9l0qTWRJbvC6e0R/b4OIRm7a5cNJa1MW9toBCfyfXUp1jG
    CLiOPag8T44zNT+tbpysqeIgvftVbSMam/ODyTsGbVB4W43uNT+Dgjtf7GJN3Ws+PwYB6T
    pwFGNY4DuKp+FvAF+cgMRUew4ERnbXqhwu/g/th63LdnqVRwjU4rKNsaqzb5hRcDMrKE+A
    I31KHcoXPikRuKzB7hPfOgo57zysD2zlXui9tlcaD8MnJ+c7oljZqtMb04VpTsSDmQZnTC
    rltAz3xU4A7cYwnSq7Cw5VzfWbSagt+lLKuRc8Xf8O96AS02t8//tjlrV5YYphAkUrFqqf
    XubYtcg3n9jCqALsougy7a011g4vt4dH3vaCPg7uZvVogtkidDIuwQF7y7/Q
X-ME-Proxy: <xmx:the2aqSTb1iDhfco3b0L2fjwWfFuFIvlTjWyaihKNieojN3FwtcLAw>
    <xmx:the2as7xbG5TPtBoc-QT5GHthf8AWskpEfI_7YQMlDIdFG6Sdr7ZYA>
    <xmx:the2am1ihneEA_cEtvjVybeY4BojOvoxGB_LGdCJGy6_sO0clZpG6A>
    <xmx:the2anAeWzmaOMYAG45vLVRncbPKzo-aJyRO4cs6YYZ6-5jMErzn9g>
    <xmx:the2aiwz5n5u4um52-fmgHteHIaXfaMhR-IQfDvLHb7j-ClAP2dqm0md>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Sep 2026 02:41:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Tamir Duberstein <tamird@gmail.com>,  Patrick Steinhardt <ps@pks.im>,
  git@vger.kernel.org
Subject: Re: [PATCH 1/2] t4205: compare huge output without diff
In-Reply-To: <20260925001332.GA1408107@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 24 Sep 2026 20:13:32 -0400")
References: <20260923-ci-large-test-resources-v1-0-c28416d59475@gmail.com>
	<20260923-ci-large-test-resources-v1-1-c28416d59475@gmail.com>
	<arS_l1hPIr7I2Gn-@pks.im>
	<CAJ-ks9kJWc0e7aEX4vAL-RoJ5kVvfjDABqV86_hZf2Fn-085GA@mail.gmail.com>
	<20260925001332.GA1408107@coredump.intra.peff.net>
Date: Thu, 24 Sep 2026 23:41:56 -0700
Message-ID: <xmqq7bk9ygqz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

>   # first check quickly if there is any difference
>   cmp "$@" && return 0
>   # if not, then we can spend time to produce a useful output
>   diff "$@"
>
> But I never pursued it because I figured most of the things we compare
> are not big enough to matter (and really the comparison itself is
> dwarfed by the process startup time).

Yup, that matches my intuition.

> So I am happy just marking this particular case as cmp_bin, too.

Me too.

Thanks.
