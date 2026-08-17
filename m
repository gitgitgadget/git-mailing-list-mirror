Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38B2222597
	for <git@vger.kernel.org>; Mon, 17 Aug 2026 15:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786980984; cv=none; b=pC/EUx4Xzp/u08Z38wkiTFcOq1YPhxuQJd+F5XsExoumEo2i0XVctfPpgzUuTTEZ+pqyConsf3je2+2nJ2GBneVbbYImkwu6n04OJ33JT30XQtb3JNdNIXmVCZ7P4wQT8XIhnHdWwTv/KDfQftYN0NkEkasodpxed6FIxE4Hstw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786980984; c=relaxed/simple;
	bh=kh1n5s7XXKhdUw1ds+AehL5G2d41tCm8MMx6xWUHTWE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mjt3Hz031HVyNFmG9FEpJ58LBVDt3livtSfv7h7zKIYqgKNtjLW3coQ5e1ZqlCZWoTzrfed3stkVEKOK094+rlc6TgkgxvPKX0Fcvq4HZiODzbyJlyvw6cA3/kjSD6nkyJp6jIukFFkhvCcMqm2INoXKLbb874a7AfF4XkE5TnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=xohpEr59; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BP+6kmnI; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="xohpEr59";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BP+6kmnI"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id CEE07EC023E;
	Mon, 17 Aug 2026 11:36:21 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Mon, 17 Aug 2026 11:36:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786980981; x=1787067381; bh=9+EE5Bm93a
	PwmxkXWBJnYY1r58bBvURNeBSv6yraFZU=; b=xohpEr59CVY6DwvwTdGIBPJr6l
	zobHK9mxn4Gy4pRJmNpFeRImZjUgCfT2L/j9eNdFY9XMr+XdnQ9y/QukmxcZkhQ7
	yEito4MIxuMJjdDyRr+yqkkihnKwIXrrn035R5xR4gJC/JqSbhH7+Gv6+jZaeOc3
	75yvELg5M5YgTtXOUtt2rlL2HEyxwSUPFiDgpoLAkLRmvqduZMaf+Agxuw3h/JZb
	9X/dENI/a1NSySuoAdsvjtVxY0tNNk8ALIRgw+6e3ZpDpFOQ7X0+Iw/ITcHimJ9s
	3Up2PJPiQxUc1Md2XKY4oSH1CRbs2vEig/ibqdsMSqBsGhaLW5bAnvHSNESA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786980981; x=1787067381; bh=9+EE5Bm93aPwmxkXWBJnYY1r58bBvURNeBS
	v6yraFZU=; b=BP+6kmnImOtQzixY7OS5fXzd3jkxEEcmGwakWohFVQk4XSoh5At
	37RjZ38NwQVhU+u/zHTADtmbluiu/+WUV1UUZbjDCtEANTBZvGiiTi7uLDdcQXh7
	3UzEWgT9qZ6OX4WvIKDMzDikdH6C4P3nj4NhdX31IHQWTESgEJudmadFVWSBfqsj
	04fnr05HctCrmim8pvzLphO9NKpCQWOiIwwQBMqnib3JDx8yGFhNQasVYrf2xcp+
	T7FujGnU2rpDqjPSgH2tVGFMqc7diw3DBbcISdU4TJPwO+Sg3NTn/WbxI9t7OZD6
	gn0dUQjbf5BOKSLRA2GJ1Li03aIvhmaU+oQ==
X-ME-Sender: <xms:dSqDanO40tJvV5eI5TMfLvdeqwcdAbC785UJa1WyE1v5REUOz2VDUA>
    <xme:dSqDaki7Jww_bczHxX5nFZepT8wlHYNctm_8hsRjv1qUJ0vngMnRdBnKwzE-FaVKu
    ij1xpI1Zt5_SXMpyLLjBGeNF1yaOp7djTY5fkMu5G5-P-e2xVJVGVU>
X-ME-Received: <xmr:dSqDap5Cq3zNNgos4t8tuyS7YZZ2-hIalC7HmSL4kggd68KNaGOVA2cpZr4hZWOlTX3tbwiZLEfq_PbSdKv_BfB8L1fAW-aJrw>
X-ME-Proxy-Cause: dmFkZTE87+F+ATxWi3YDe2fC2bndvP6ClNhXLs0fsNkM1acqcyU16eQxuQNuQyS/KGMVHX
    zt8KU8AAZXmO96+yBpn+Eg0yO6SeHOm7E8aHNwM7zUweTWcantSUhH1UOOM6EIpapsIuct
    Pm1tIqtErzWW2qoqDpyDy0cdO/iL0o+UWx2FC0X+SLOhaXmhLd2vbYvaUktCX+0OxyjOMb
    zNFi03ndewBf2TZCrxXjHz03dICzvEAQTWQVzY44UX5yIIZAqSBkLT1/cfSo0KAeWjRMUl
    vJnpZZoYsvZqO9MxVBOw/bw+ZJ6+LdfoB6uX2XOLbA8WerVApt5T0h1TK5v1puJuEYF7iK
    7z5EVKreMvkgmPoYKvitr2/zZqAYGsG8KSM9a0hwLLYc5SEtptGasn0VCxukIxYA1Euf7j
    gGAND28l/7dB0ZaWbMf+hFqt3GDSaMCZLUmceWwtZ5Bn1ZNXX6/OH5f+RbWF/DGapAEmtQ
    PtzR3JMPSjEKnF7xi3W5zNYan000CiQTGVNQIAnYgAk8OylvPBfFesmZYO59IGN/5QokHS
    jC3vn+5SgOohb+KHSdLwvftoNFFP815dGnIiThnm22OED/KJC0AV9FDlBH8DIcCpE8EYNY
    z0P6W50JGcSM+ygaSJ2nMoWh8EkCy07QkDiXNM2X0zFLtmwMuH52hm8pwKxA
X-ME-Proxy: <xmx:dSqDar0G-m1oLznANMPzd0BhnQ556Ci8XeohxqBihs-0WIrV959D-Q>
    <xmx:dSqDakvcPhN1HSzv4Ks1pjxcQ3xnWj2_VfH6Fzcz49YJu2GdesgiMA>
    <xmx:dSqDah7kdNwkbRmcSdnZ07E8fPaXAMP5BWq1-8K9yyWOgI5ePZU7Jg>
    <xmx:dSqDagcRZ_s9E7PnBeGX3-j78Igklno6O7tIXk0RgaGjiZSytg9TDw>
    <xmx:dSqDamFAZoNlhAwxlnvK4eKk0-PR-11ZSrGwVE6y3C0uF2pZ3uUtOYi2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Aug 2026 11:36:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  Matt Hunter <m@lfurio.us>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Harald Nordgren
 <haraldnordgren@gmail.com>
Subject: Re: [PATCH v13 7/8] history: create squashed commits without editing
In-Reply-To: <f34669ad-9157-4f13-a3c1-c0abbc660497@gmail.com> (Phillip Wood's
	message of "Mon, 17 Aug 2026 09:26:43 +0100")
References: <pull.2337.git.git.1781465141.gitgitgadget@gmail.com>
	<pull.2337.v13.git.git.1786088371.gitgitgadget@gmail.com>
	<8b3551d0d4ecb360775ea29507ee262c7bf9cd42.1786088371.git.gitgitgadget@gmail.com>
	<xmqq4igyszeb.fsf@gitster.g>
	<f34669ad-9157-4f13-a3c1-c0abbc660497@gmail.com>
Date: Mon, 17 Aug 2026 08:36:19 -0700
Message-ID: <xmqq7blo7o98.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> I've just had a quick look at that other thread, it would be more 
> convincing to me if there was some explanation of the security issues 
> that accepting uppercase object ids causes. While I appreciate brian may 
> not be able to talk about specific vulnerabilities in particular 
> products, it would help to outline the security issues in general terms.

In any case, I do not see any new use of istarts_with() in the patch
to deliberately allow upppercase hexadecimal.  It is not like there
is an existing machinery that has generated uppercase hexadecimal
for a long time and we need to support their output, or anything
like that.
