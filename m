Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE46946D56B
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 12:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789042706; cv=none; b=GWnaL3/3nJRxepxhv+k68lsydysSpARB2h8Hul2NJ+ea7+sameLTgC8YzCPFGREbb47lyiLe9TsBvDlilakoMGc+mUTCSB8f7dCglsxKvAXuYML3Pc7eiwOhCqXHHFJeiqQce+XfIu3yVXq+ULVM92ncEPq8LGFxuu70Ibfj1Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789042706; c=relaxed/simple;
	bh=mKc+Wfp1uyW8d0lwPEBq/w3yDDDpaEE+fZGwSWdS34o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XdZoKjmsGEfKPrTXzqd6DZvJ7Amibz5xzqE3E5CGBDbBotKfVpfsybdP5fIZNpHIVidDwlOW1uAb5mpGVm2DMjEvDWEH1RTnTr6luYh6D7JjzhPTQcJQ9zmQ0UWYsgo8lG8+hbMTkDIUScee+4v/rZAPjezKU08+lCIWaI5tPKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Nfx4AggP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kcAc6dRH; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Nfx4AggP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kcAc6dRH"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id B6F66EC0402;
	Thu, 10 Sep 2026 08:18:23 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 10 Sep 2026 08:18:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789042703; x=1789129103; bh=UmtRfzvwFN
	DboHObCWDgFcfog6N2LT7LQIbc8U5hHRo=; b=Nfx4AggPWHAVlYebDTRekd8QlF
	7+ZP/+vw45R4GJTegsWAKw81sRPSt7q1UPE+fBYJdIRi0O++iSSNTffKwRieZsDc
	9pzTqV2RHYg74jmA6Z6Vv5TXEdnCXDx7KhgZjQJz2BMNG5Y6Wu6CI1dKMPGCIU6i
	ZROKg6uXnkUvMIkgvvYftErxoduh7+I+L5lIVSqtjY7ZaqnYOiFFw8uZomV/bu/R
	iWI/bNZC+HDdUXE+C5Mp/YCLUJ03cSG33ztYoEmp+lF+QVPGUMCQ+pEHFE2Q9hep
	JLamlcQIL2TWq8VLmzwr9uxhYybAHp5VwrWAwWz+K9N6xnSSPKJhYqTGZovA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789042703; x=1789129103; bh=UmtRfzvwFNDboHObCWDgFcfog6N2LT7LQIb
	c8U5hHRo=; b=kcAc6dRH6p6qYFDpNel/gufEPl0jkolFwrw+xP7Ue5np8jwogom
	94KWnbcEfz9gAq8BtHdX0YkMn92YPnYiRNy2eE4phPc/CbjfnIv9LI8SuRgws1Ce
	krHh8qi+9ebA/5tzIDzDXhXuiPzGf5wqhgXbT8LGmoWHUNjVSrV4gZa6BZNC77PX
	LXIW0nLFKXpPZWZpEJxo7ukdFzB6YzofKz4UM3v+fGAErP06+A0NpxaBrar0vazi
	kse6IRUQlwUwUFCKS2n9n0ZVr3K9rwOH3INFFhKG4wTYAEoaFhtXdT1k/iY7p+fF
	N6+wpMTOHrKgsQ5IqiQgIA9UyMXdhJ0/7yA==
X-ME-Sender: <xms:D6Cial4IyhDQFbE2WPx3QmIifmpuziM2m1e3en2uFLdvYAzoL7pTwQ>
    <xme:D6CiapzqXv9DiJnsW_MZvR_JYKqaFHveZI9uvTM5KQw91c-CpHicRJcB1GR-nNNPR
    81vIpd9jsybcMQU4JMZnlif5q716pRsq1CHwl1YutiVwPVBkY6i_Q>
X-ME-Received: <xmr:D6CiakyfFDVGC9oVMM9jc8z6P_3t2TSQjtKaLdr2dF8crDg8KL2w0weQ5RISEQquu4wPHv_jwhSFV5AYfyTVFa2xHcO0QeQJr7w9>
X-ME-Proxy-Cause: dmFkZTEoeo2ZW7JpUmkmPSEzb0JuK1F2O00SuIZllRiIeMPRxxJKV1kvn6ieGltD0W3H82
    awwVDco3mFa4PFwUQ6+zcZd21tFmhtvIM2nH/LEhZQ3dlKCwpPEpeSLg3prtpOyL+oz3wm
    PY/l15X3eL+LPq8uHfl6STYjfuQRqQsveUb1KKFvUURXGeBrSQpmJZQNrDvbmTYhV4rLEh
    iumdYUDHvb8VwNnGGxKOpu0/t55rpfx4Rjp2RKRft1T0MjHLXvGlsxIkKrpKphyUVBJ+qq
    TYg9NIVF/6hWfBx4EFtB1U1G4TrJDrMKunc3rHehi1SJNS/L8E52XGXHleAOo4yEtVhvle
    3HCyeDF+uGlhrFBZJOQ1QE8FIDGhWPjZuaTlM7vtSJ3yOwLV7f62TW5H1LiGnAkwWQv0NU
    mB5sdTFo25EyFnWjjD1K2GRXMTk0t0pmEM2sPwEmJjja+muEV91tn4Fg5uVl+8A8dvsWv9
    pBnNdcmvHR1TxFkRRfyKwQSdCsdfmdeb/bbo9Ci+wDCqWXCFl0+oolWG4QgboxfQvxAR9z
    uZSZempS+mldBgvFyVQF8sZ7VaqwYoZVtYq6DtTNgQXInUztPURLOVfwyfocqHsqjOvXB5
    dNeZCAyN5un8ldaJ/uBaKMWM4Zxbdy1Y2VsGOTyJ0uPB8j6dpJPVcl3bQwWg
X-ME-Proxy: <xmx:D6CiapxFl2hzgWsf-5wpIQ8emAPG7uncdpZg5Hz584zYvp1nX36W4Q>
    <xmx:D6CiamaI2BlRQa9UYfBYW1tow9Vh_N4HSM2uDJrtVu_j7c5IetDFZQ>
    <xmx:D6CiaiURwsFVuJTikQP5w4751AAjAp554dcHjkctCJ8aWV3XkC3t-Q>
    <xmx:D6CiasjSXRWcTS1Xwbro3pyir7ppdly_QQcTIv-BnsxBHKJ9jtR7yw>
    <xmx:D6CiaqUcghxeuteaDeDS_gPQPtdKijaRdfd0_pBgQkRbb-uWSdkYUHyh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Sep 2026 08:18:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Vsevolod Myalitsin <ub4nal@mail.ru>,  ben.knoble@gmail.com,
  git@vger.kernel.org
Subject: Re: [PATCH] advice: use global config for default branch name
In-Reply-To: <20260910043356.GB241223@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 10 Sep 2026 00:33:56 -0400")
References: <xmqqik4fyaav.fsf@gitster.g>
	<20260908213840.37833-1-ub4nal@mail.ru> <xmqqik4fwoz5.fsf@gitster.g>
	<20260909155440.GA94069@coredump.intra.peff.net>
	<xmqqv78eqmw8.fsf@gitster.g>
	<20260909195132.GA182066@coredump.intra.peff.net>
	<xmqq8q594tvs.fsf@gitster.g>
	<20260910043356.GB241223@coredump.intra.peff.net>
Date: Thu, 10 Sep 2026 05:18:21 -0700
Message-ID: <xmqq1pb147w2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> But I think the bigger question remains: if we did this, would people
> find the extra lines giving the turn-off instructions ugly/overwhelming?
> I'm not sure.

Well, if they find them unnecessary then they would want to turn it
off and the instruction is already there ;-)

More seriously, if an advice item is found as such, then the item
either must (1) be beneficial enough to be always shown, or (2) be
so rarely shown that the turn-off instruction is unneeded.  It would
inherently be case-by-case basis but I do think we would converge
between unconditional advise() calls or advise_if_enabled() calls.

