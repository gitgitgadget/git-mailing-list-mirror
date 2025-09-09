Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B1A261581
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 21:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757454267; cv=none; b=n5kNbPzG5K+WIr4h6VAJMd06nOAqB3bYs9ENBGSu2+nmiXvLgowsgrajMjZfxoNStXUKtLRx0eLKveFsNTDzF1gXGONTlHDWfvufmLxE8ELejQU+8J/50ujOHVIx4duICTZdN2KtSwcAsABsHEJTgs77KlKb6SrxGIo9m99OkpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757454267; c=relaxed/simple;
	bh=qSL7ZoZ8k1afFm0Nl3fICRRE2CwUGEeBNjrCm3qRT7s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Iyq80Zenta32vanEsrC5VWfOvbYHCKB+5RDJxDGkNJUMplWemu3R6RDPJ8aXtlRSNSoTRaAoCQ+phs3q2urnTLTUHC/Lkut6CEu+E76PW6QrHd6DvypL2b055C+DXEkumppGdiR0xukVr9suL2WseQ0OSoFA++TuX+haPYBpECA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Cg7NfzHB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zm4gsZOo; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Cg7NfzHB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zm4gsZOo"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id E2BBA1D00012;
	Tue,  9 Sep 2025 17:44:23 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Tue, 09 Sep 2025 17:44:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1757454263;
	 x=1757540663; bh=u7d8d7dl0ZWIxzZ2OhmillHalhzHP4mEyLNoNMgcgw0=; b=
	Cg7NfzHB0Q0GEutxghgT/8nrBMUwvswtHNSZmoCSWeMHBWkpljPZD59ED3KxFa1N
	Awli9WKC1TWQOtwMwjnZUHhbCpxPWwQLVSAdEqtL1teachMWrhSgwUSR+pRk8kYZ
	2HS5PY8KIGCQE3y7CwH42NxFirAzcjHsc4ObVU3kVmEUikE03rPsfutiBxYqjyDz
	X3R9dRkZV2v2z4kcwAgg/92up2a0dTIQYoYXw7cxIY1gZcawgqm425qn2Q3z6d/D
	c/P/OgC9dURbvYf/FNyZSJQoqHkXzVqLvqCd1REjb28oWbWFnmQunVETNyR8oNzS
	GAi442l+eSeQOLsAXFEaTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757454263; x=
	1757540663; bh=u7d8d7dl0ZWIxzZ2OhmillHalhzHP4mEyLNoNMgcgw0=; b=Z
	m4gsZOoEhEcsO+JpyY+d2yuQ7/hEiz35ilBIc85THxkCBLzmvmDocoGD9PVhb7QD
	KWuZTLwhHimJXpOPCo387chiGxv+h5E/1x8lZgAdSBKVeKEMF8y1VRXMUh90QcMt
	iaQ8FqdPF8S/i+t9fzh26qfMSuGwHWCcQQ/IbvJLsgxqIyMneTpgRWqGZWRkWb4J
	DZFNUDxMjrJvSgV+/l+CMbxyR0xdQctipNUZAb3LK9RKW7Ai5QAcRDv5S7bp4XHX
	XtMl+9C38gRuWB34GKBK2r9rsmM+6cb8d+ESs45AEzAd4oSzxt9qWCltGowA/PiQ
	S2AlxAl+HsBAWS6RWSAwg==
X-ME-Sender: <xms:t5_AaFFXXfNzk8ulZb78Ue67vmoWW-OFGwJzAwkd1LCO3a-Jg_E_3g>
    <xme:t5_AaH7PICO_xlRiSy0B1-PUsTEq_CBVsb32VIVJohC1iBjMWfF-K_nblLTxKtSMb
    iL654RIFj6VcCtK1A>
X-ME-Received: <xmr:t5_AaNn6OoqyPxxxBHyDLaw2qnCdMcQhPjlzXbzOgMb-J3b1w6donEdVDjcgf3zdRbOz7-eGUp9pAoL9LKXaiMCNKJxXYOBgoLUOOPE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvudehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfh
    grshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtph
    htthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohep
    phgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:t5_AaMqYPI6DK6rjsYAK2M0h4_zWa0sdARtondC-3BtB_rbSEaSaYg>
    <xmx:t5_AaMvpl1neqhI064IWlBMqm_VyBgPKGyV2FUAkLS1ADEWryVUAow>
    <xmx:t5_AaBFJuaYMT4r4hJHL08_d8ES3gRcMcjw7rB9JoeVglKDR7tKxKg>
    <xmx:t5_AaFZdnhwrIytadSOWpdRr8N0TiaHrCfvyYyLdB2p1__xtF8SS2A>
    <xmx:t5_AaJHL84-P8Nj8lw-jKdYmV609VE2_Ih4HsH2ochzYQvJFWWdzVJZF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 17:44:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,  Eric
 Sunshine <sunshine@sunshineco.com>,  peff@peff.net,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH v4 1/7] git: add `deprecated` category to --list-cmds
In-Reply-To: <66e6a9554b16b2079e5613a415a2d27a601d146b.1757446619.git.code@khaugsbakk.name>
	(kristofferhaugsbakk@fastmail.com's message of "Tue, 9 Sep 2025
	21:45:51 +0200")
References: <cover.1757345711.git.code@khaugsbakk.name>
	<cover.1757446619.git.code@khaugsbakk.name>
	<66e6a9554b16b2079e5613a415a2d27a601d146b.1757446619.git.code@khaugsbakk.name>
Date: Tue, 09 Sep 2025 14:44:21 -0700
Message-ID: <xmqqjz27ti6i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

kristofferhaugsbakk@fastmail.com writes:

>     Incorporate Patrick’s suggestions about the for-loop refactor and
>     formatting the overlong lines.  Now drop the function doc since it
>     doesn’t apply anymore.

So, if "include" is specified, a command that does not match any of
criteria given by those flags is not included, and if "exclude" is
specified, a command that matches any of the criteria given is not
included.  Which probably makes sense.  The only user of "include"
uses the DEPRECATED flag bit without any exclude option, so it is
yet to be seen which one between the previous and the current design
gives an easier-to-use behaviour, but I have no objection to the
updated design presented here.

Nicely done.

Will replace.  I guess we can mark this round as ready for 'next'?

Thanks.
