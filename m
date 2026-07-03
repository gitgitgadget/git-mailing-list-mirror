Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A511523BD1D
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 20:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783111686; cv=none; b=ulkx6aNFOfmnl3pJ8/2mfswNPv+161DKBhC02nbmlLJRN9v+pQDbKJS5CpCz3sibWNienziVLISqf+Lik500s1bogwcvitnRAWmcb552NZvkNcyWjXdBC/p7b9Th49/g66rZN6ZjsocI4EXdWP3m3bbHF11wx52f/KPNfMymwOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783111686; c=relaxed/simple;
	bh=BLArjMa9tjrwfdFrIZKWOx3Zz44TqYJBa7gQoeTXTs4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P/gMq/PUgA3pgfd+GaTWWEqk765wowJM8nAgONhHkpAoQ59uTQD0iufr7f5O8psBX+Ly43hB780Yh1i7OmxsvJXVr9W5aVLeHUDNn6wN9jyC/zcu3/mIuQybIpU3LaurKt0EaQhzVf4IMMVjJstOP43Nb1aX7X1R0+6pNr7LMGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ay7UU/zr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bCwZ6zt3; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ay7UU/zr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bCwZ6zt3"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 0739B1D00081;
	Fri,  3 Jul 2026 16:48:05 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 03 Jul 2026 16:48:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783111684; x=1783198084; bh=otMzhCxPI2
	mMSkBk43Xh9kgpHcN0xQeLTZs4i+XrE5M=; b=Ay7UU/zrEtp5sWfag2jW+BkFkd
	0zp8wEQhma8pOsCxFIvF4QYHKvxkoN1h0BGN6zFsEv31k6htvvnRYeRcTZfwtxg+
	oHSsF8LuJ2lY030LjyH5R3i1RCTzbyrqbwtjMsVdCmctDcjhB4BAeSco6U1Ftwpa
	Mr+eMWGjWEXiuzVmCp015cz7gOUd8g9Zc1g+dMXxCmoL3Pq0smWbr9b6qqvZMu2Z
	2/rYCTCIclVmg7Jio9Hu3oMWMepThgv6DLhBeVilpPMy1x6a3oj2Ly7GLFYK+nIs
	A6lB1rE5epn3MzN90kAiiFO8MwtkiwgKH7WphjKRxQUDydlaCvou/RVsWD3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783111684; x=1783198084; bh=otMzhCxPI2mMSkBk43Xh9kgpHcN0xQeLTZs
	4i+XrE5M=; b=bCwZ6zt3HfeWXZ9KJ9Kvvo/B/wsndEfJfL2MDDzQXV8luPk0CNy
	G/axpiuWGcLVKRel9k0wYd9Ox8lA/a7dV89z2oQa3iz6w8O9ARNE5KqLiKigVc93
	RUxxZQevVdHYFmTbxkjyZ8NaNclroa1ifvQyETiJhYeDb80j1b5vHy/b3LuaZkDr
	gKu0aGlJaSkc0Gq9FOjSe/PSZdi5fEJgCFEarwzwF3fS/Z8y2eJIBWhI1CGYU1h6
	khN6xM1ja5rtCC4KL+GdIlCSYkZMRtA2nq3B4nvsNMVpSLV1nNA599BVjMiDaf4f
	RUyddefMKj1To+LMOuIVPIJBcsmnOgvoiDg==
X-ME-Sender: <xms:BCBIasnq91lPrppegEKJvOaVEG_XdYkaZAkmjfwpKk4uGLKtRiSTGw>
    <xme:BCBIait0-OWpTpWKU_ZnWUQ2muh04JGqPt1EoSGGQ1MSYkRgzxN7U-3VbpcEISKHI
    r3BSpLFI9ocByB0MRmJmXBO1tXd6Bb_03-FOGfo8qwsgCMXnuSviQ>
X-ME-Received: <xmr:BCBIai-r3ieSRtpi0JGMsG8958qQ0ef5IDyCfFB6uyQk01UBE_ptRnga4-ubiTZ4CmHmSBabCH_jw_QIviw5d3842oEt1BRv-sZGdBw>
X-ME-Proxy-Cause: dmFkZTGntPfsLMpj2XWAgR9MZ6UNRIl+sbCbdJalgYIFkwoSvPa8qUJTj7D7gm6wBWGJ3n
    OWcdtPo0OJoKa1jeBTI+imhmNKzcN2ihV9ln3NppfYQVrGZEKU91CDyE29y1PU4hkA+s4x
    HPNa751ZeD65voKZOHrjttk+dcSGmX9tJU1hQ1OXPPlXqTBDdBE+By5oysMBKNaidYh52/
    nb/dXgNvVbpkNyywIW1qvQzC+lW8ajKm6hSQ2kC5clIDSl42SJuAVamzUM+F6YMnuen6kq
    aiLWhP2/kQqIBNMqKi+Aq/ByiZDsieuc8GkIQ98h322qRpL7CkyQ9pBoJa7evegDLPETY0
    ZaHxJjK0+cVokL+zjCayyVt12pn4C5Pdt3NHqvEnFQEmIt74CIeDX2qrx+3t20Eq/iSiHW
    VQFsqLvXwz1kfsTuPyp2Pxniq0XRPPhnRbCU6ayhJbtD9JiQhycuwNoML8vqgXx2LPF6Hp
    E83T2cCSM/b9xMGIAjdYg1SYhvR3YJ6Dqmjrtzo8w3uv2Tl1avu44lYPwOP8n1A2kawgmw
    ixcGNSwr7gG/A5ehLtlrEn2XEttR5lfj1qD8rpOAM3vEDqKqWG0fiY8hgvqZBmWDxQLyyD
    Gx3MkJfpYi7pRMyPH6aOwER6zAE69KzLE/75kP9cwuGD5Qn1ENzVi+ijdcuw
X-ME-Proxy: <xmx:BCBIakNHkB4Q3CIL4OckoOv1G3RHefstKv5fm6aBWkpgMD5hDKKE9Q>
    <xmx:BCBIaoFGTqQV_2AXGVbNTOFIG03wemVjJTGz2Yv7jv2Dl01BA9Vl9Q>
    <xmx:BCBIaqRElCmKpPOZfYecURGMuNLzLtHUs2B-dOsoBQ2mm9BA86vZhQ>
    <xmx:BCBIatvZNb826Dm16Cu5HPIxk0oP_MfwQeESn70dlnL6y3-9jk3c1Q>
    <xmx:BCBIajc79B6CT-EK9G9dwvfnoUni5t85VItH7eG5w-lk29iSZFg56I9u>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 16:48:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Marcelo Machado Lage <marcelomlage@usp.br>,  git@vger.kernel.org,
  Vinicius Lira de Freitas <vinilira@usp.br>
Subject: Re: [PATCH] t9811: replace 'test -f' and '! test -f' with
 'test_path_*'
In-Reply-To: <akdwp_a2EuhVoGVW@pks.im> (Patrick Steinhardt's message of "Fri,
	3 Jul 2026 10:19:51 +0200")
References: <20260702140704.65805-1-marcelomlage@usp.br>
	<akdwp_a2EuhVoGVW@pks.im>
Date: Fri, 03 Jul 2026 13:48:03 -0700
Message-ID: <xmqqfr1zhkak.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> -		test -f f1 && test -f f2 && test -f file_with_\$metachar &&
>> +		test_path_is_file f1 && test_path_is_file f2 && test_path_is_file file_with_\$metachar &&
>
> While at it we could split this line into three lines -- it's getting
> overly long, and we typically don't chain multiple commands on one line
> nowadays.

Excellent.

>> -		! test -f main/f10 &&
>> +		test_path_is_missing main/f10 &&
>
> This is a stronger guarantee compared to before, as we only checked
> whether the path is not a file. Now we verify that it doesn't exist at
> all, which would be equivalent to `test -e`. That's a strict improvement
> though, but may be worth pointing out in the commit message so that the
> reviewer is not surprised.

Good.
