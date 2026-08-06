Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52CE39D3C0
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 13:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786024236; cv=none; b=W9GQ5tKn0mq2RialHb5LmRFE4XwC7ufZtWDJ31f7kSgDCN4YgDAE+bIw+bNkbFOzsWnWILgCbO8RWqYCWQMuNQSy2ZhuB7yea6wdaL66ZwOOuZjf9/XelDaI6DfhAPq/dZDu58kkvJZZ5K95l1ycQETP87CaJVsS9DaTrvtEDmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786024236; c=relaxed/simple;
	bh=3Qc8/OQhAUQHioW7jKYw2Ft2RxXrcblaG2DCvRY0kt8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I+HnRvMGY1xsbZUN1wnk+0nlFDc7UXMnJSSMJSfFFrCaB6Uw20OxCBVnPd7I0LSDtpgMPU7a54XrtSornNwoTXSjvJ0zeKjI9Fm4DHpEnvfHUeevFJ5BfpILDNlSruEoYquV3pyDMzJXcqxTbAbpjFH74m/WOtKI1NVuhLw/Z6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UNEwTPpI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O/Vs48zx; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UNEwTPpI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O/Vs48zx"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DA07E7A0135;
	Thu,  6 Aug 2026 09:50:33 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 06 Aug 2026 09:50:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786024233; x=1786110633; bh=p6tI3pZ90U
	AW19PgCwwsM3BvM5r5uwQ+tU5vhuhOobQ=; b=UNEwTPpIIwdDiM6ydd4HQjSK2j
	gF2CN3KZOYVqjL9hEQOwuoyD5hrXXL0vqxJV7zA/6ZcAU2LxsfFZtyH8AgoVfn0Q
	Iw4T3egmSXFRxSGPxfxj6jkYHZn6MY/HlqIrwPs42t3jqe/PQALxIo+2ubFbxUga
	fUuuoBlNLy3kiCm1kB2OrKLvuSvGDe6uFwzpDrRHCBx7skYd7vlsnNPpi/HlDHTp
	mvSUfZWgOTEFSEMIMOOXSLOBhTmgVVHu9j6ZOmDMu6UPMY9xS4nzsH8NzVlfwF+v
	C5UGRmO9Sl8QnBoEzkjYRhWEXnadOE0X6bJBUYj4of62a2wGdnuzE1VEhsmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786024233; x=1786110633; bh=p6tI3pZ90UAW19PgCwwsM3BvM5r5uwQ+tU5
	vhuhOobQ=; b=O/Vs48zxAA6xH4vaNy3EkiChGAF/rmCZOzazowuA/q3QtzzY6Ku
	QWmxMLguByESDcjTVBNfSMhyjkDjTImF09D/DsWZaj+zxMfgsrmatw9k07Y95gWu
	j9XBQjKv8k/npys82RQj2nmXc2cmB2oSG58XK0pC+/PSgXpUgaim/9jPDHBuLCS/
	9JcBCLvtVri0hG3W+8nHPXTXQKzTtU0+WFL+8xSwUWxnJ0KEsBlwT1Gw5/iPurwV
	OIiZciq/3BMVD+wbdSoQiWlQDaMmkWujhJbsk2QnodPa7tWRgpenLP/bC1qYb3/E
	4/PeNOPd+icjdYKwILrqNhoT4akXwiC1udg==
X-ME-Sender: <xms:KZF0akAD596YFJDR3Q7oM1jH5-N0y9H8QbuWwcGpYuy02CRPF8Kz3A>
    <xme:KZF0atbIdA9f3gC5eqBuzf5LAK1VqIXpUEaJAyojyZn0IS1ASECrkxDZcKM8Ii5dc
    tK9hgcondURnBVT0WGbHsIhX9BiedvM53UE4Qv9iUcPAWRF5UE>
X-ME-Received: <xmr:KZF0av5ZhN3hGzy7vOzhP-0iI47M_JUpCX_Izq7oaEWLLTVecId7xL7x7Rutf03ZPKtYtjVrTWSDahlI5We9yG56IbCTCMq8og>
X-ME-Proxy-Cause: dmFkZTGdEJ6i149iSRzVEf/koDhqqjkyjUaQLh2b5WcjCuI8m/Y5Grpt+74xyhAlyfnNaE
    01RYQZHAQXjHS/3s5T8yRNG5Jdz22d6CO9IXnroXI8R5u9E+hC34JyX/Mss+CmTyBf9Oup
    a8ZUxL8TWQ6+25I93iMvO4et7JTKfNbo7EANr3bRHI4rvKXiuEg/4ntm6qhxTtd4yogASt
    n9jgcZLCUaS0CrW2/Zo/j0eQ/LyW8C2R9hTrVChEHavtGUrFN2Xqh8lIMbMEgd9HIx7IVG
    n+MoTVM1a1CccvRg2aoTvs10doyMmKWCS3qlgtNAzxN+1MLkvwNl0CS94/D4ie+68Arokk
    37nXgALVSdwkNoDMJVKM6Wz/AZcn1DmoeTXskO+HjY7Bj+LEWhHDCL2prWQJTtv57qBJEw
    yAi1WGaPCInrQrk8kXMy9epv0swj9Cksci9QIc3qxgRofdQUTozcHJhCZ2V/tWACRCh0wS
    oeKICrAUXJv4kZ5i94LZjvjSHSudYGa82Rl0/RDCWG+M2KsAQ18lLsjQeaeow1HFY5J+RR
    b9TgQhpuapnpbs4kmQ59ajX0zvZrwE+ptq1P6ZrAe8pKH/cr6CTlzlzY3DdMRjRquSSLCL
    t5u3J+Ln+Tcv6pzieurhWKIcWtRs70hC80w++3UbfauIY4JRu59w5+ksmrCA
X-ME-Proxy: <xmx:KZF0amav_fl8vz_kgTlvAbzzLxSNEs6QatDdCVmyO2rrKebl_md7Wg>
    <xmx:KZF0amgPt7c0KsX1D0FEJaQO7pBnDt5DBaDpWXnIPlBQFOy3bVuApQ>
    <xmx:KZF0av9YpRgLfCaECCtneYxRoP9MmsobpfNZA0BTcDQBXDw77d6Cvg>
    <xmx:KZF0appGqY8WzRUn-iCb70U9zHMwkdi0s1aDKxOTyLBvVNlB0LSl6w>
    <xmx:KZF0akrr_PW7RSjTFO33oc8BLgKyfcKX_7KDRPvMeleH_T5Z2lCkK1-y>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Aug 2026 09:50:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v6 2/2] bisect: add --reset-when-found to leave when done
In-Reply-To: <CAHwyqnXOno2De_eOvH=LizyfWSpyVWpzGBwV4ZGW4bxOEtETOg@mail.gmail.com>
	(Harald Nordgren's message of "Thu, 6 Aug 2026 09:30:57 +0200")
References: <pull.2335.v5.git.git.1785663075.gitgitgadget@gmail.com>
	<pull.2335.v6.git.git.1785705860.gitgitgadget@gmail.com>
	<97a4da55374c6dc52e6e990b3cadfaaa86a57640.1785705860.git.gitgitgadget@gmail.com>
	<xmqqjyq812wr.fsf@gitster.g>
	<CAHwyqnXOno2De_eOvH=LizyfWSpyVWpzGBwV4ZGW4bxOEtETOg@mail.gmail.com>
Date: Thu, 06 Aug 2026 06:50:31 -0700
Message-ID: <xmqqik5nmk7s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harald Nordgren <haraldnordgren@gmail.com> writes:

>> Are there "dead end" states, other than '1st-bad-found', in which we
>> can no longer make any progress?  One thing that comes to mind is
>> "you said this one is good, but that contradicts what you said about
>> its ancestor that you said is bad".  I wonder if we want to do
>> anything special here, just as this part of the code handles the
>> '1st-bad-found' state, for such "dead end" states.
>
> Maybe, but I'm not sure this topic is the right place to dig into this?

No.  But thinking if it supports such new use cases in the future
before committing to the new code structure is soemthing you would
want to make a habit of doing.

I personally think the new "do your thing just as usual, but then
the new code cleans up afterwards" structure better supports
anything new we will throw at in the future.

Thanks.

