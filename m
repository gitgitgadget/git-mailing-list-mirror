Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B97A49D583
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 16:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791303576; cv=none; b=Dfal9mnLAl8i1mr8Twex/PXBQNdfxoO6VPLJHtr1jf6c54GOYh4KuKHsZbvkpBREvjNcloBAzzUEKCaHdm+9LiS5qpKXstry6i1mLvVlLaSpO2TXxAOmFhqj9KZDiM6IqVRAUD4rhtyodsytBdNvUV/qKGOfeLzvUMU9qm/cBh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791303576; c=relaxed/simple;
	bh=YdM84bXLiJu7r35xax9ZoGNoEu2wMwECw4uEujywbcI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Si0dWdcq47PLUhlNOCw8QTZJk9vnhfkX5eO5cyYN/tUuH48o6Y/w3IwxXoQxNhNlWotjMHwc4xj9mL7EpiqJ9fuTvuOvp0TmDOXMC/sslC9FaAi0TH8ju9UqZ9h9f2yerSAA3wQjjeSZl0mQkTSzduXBQVWjRkcDUFVJNcB61OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dYBnZfC8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=y0uABkme; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dYBnZfC8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="y0uABkme"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 817C31400113
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 12:19:34 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 06 Oct 2026 12:19:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791303574; x=1791389974; bh=YdM84bXLiJ
	u7r35xax9ZoGNoEu2wMwECw4uEujywbcI=; b=dYBnZfC8SXHDLv/0unRNK2XEPW
	n42GTG/kD4q5UfgVL8weuuQ6TuiuEcMOyupNZTeCkbBDK8aawQB5OoP6WxnQmf8C
	Wmckfre3iGV5vfX0MyAkP3P0bJGCLFdaBNVQ6KZQdVbnhYQW+J8dZf9xNl8c951D
	pwrxsF4HO+7uAwNJ/kNVgFvgKCk0CfYIvmhbuHSiObfshSaAUp66BhzQr8j/iTgc
	tHkG0NIuLAKoNn8ykGyht2dFOl5j8yVUi2dZnpllaOKrrzAxJLHuJIts8oiihKRA
	BHRJ1zpKRdm7DDbOf+PBLkpqkNyNsw6utMFJoqqo4hF2hnzsOIQP5X8AZuGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791303574; x=1791389974; bh=YdM84bXLiJu7r35xax9ZoGNoEu2wMwECw4u
	EujywbcI=; b=y0uABkmeCuf39++0yoShGK+TnGwVzMOee7P/+usBYMUVHTxh9h5
	obPTWFYyFFlcrOdPTTtmS77tT8fD9x9YgSgpKjLdww5NmRuOdA04uMNv3FxAahea
	iNGrDoAZFRnkjWh9Xl9m2OuwBuwKiC2wLZedn837NQaJuo/6rvCMqB23rKFMDJI6
	bFUYTDNxyU1tFmztqxxxGA3nlYAfMlWtkArVwsGkdTs6VBGvpmdlJbiu2hQgiUZ8
	5jYRvomCYIz2IIKlcm53nzSXLvvKMhc3R9dHD9OCKd2FR1EQ8S4FgZMi2DcgoNWh
	SZxQeO18Mk4X8KncnKeLFnRaceilkpIKL+A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791303574; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:TAsTeJ/s2gvop831w0Oana7hq4Jndgqublwy9Ici9jFKE/l
	VpZ5r8xusaxDWGkUnj1ljtLI5JbvMOi6koF6yD8+mLXWLnWsbyi1y0zy7V10wbG4
	SzlQ7KvHwxu8RBpETYaC/77n14y4nMA3wfJfnuG9gkDayg6j5InDiVqnk7WVVjdK
	uKXiqYTagnUKU2qUaMK4dr/YHRRp7oUpvHyR+bPWoy1qNFF0xe8btHt/Jfo17LzF
	ucPV/ZL1xuAfbvzjRJRxyG0alKkXvb8shXW6zBE9PDiLHgNwAxTsvVEieIEO+5pn
	u1GNfJwgg6TxIxB5Xo2lvMtg6zlN0P89msbFPgg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:UgREXx4g2ED9X0EDxO2La/rul9SuKkQVpE9TpDowlKA=:YdM84bXLiJu7r35xax9ZoGNoEu2wMwECw4uEujywbcI=;
X-ME-Sender: <xms:lh_FauQhqPOcc-xJ5Sr1h46pggPMV_x0L-Vn81V5s6Y7lcv50v2rSw>
    <xme:lh_FaqwGaCbse1sgKHRrk-oZq6jjaGhlp6RCNeFHFwTzuTVvavxkBoJcByWJy_Qef
    X3aMDqJp1c9LXgPUZ-gKCmiSlMRolx-C1Kk-SHhB1YqHOIz2Jy6Kg>
X-ME-Received: <xmr:lh_Fag1tw4yZp8-0zhvZJJOn-Xk-tySszv8TF-PmoKiyXkLFf2EKM4rvsX-FZqrGYeiiY2AaCrHn6qQmAqurzKH3ueifjDOMsr5U>
X-ME-Proxy-Cause: dmFkZTGZg1drkd9aHukDgOoP1WnIJN0RcmlW0BqfnJv1vRzQFgcUCdQjNbXG+feDnfEyXT
    pUudcyOoJLBRefljsvFj5k80fGoYlTgOHFx3RtYZ8zw5SRahupiwJLLErvCbymYn1mzEnO
    kyrsFQVHZeV/P9BlizPpCMq8faWISd5hIk8Jk5RkG3TWAciD3BBveBQZV3sbtb9Hzg2uiA
    k/A5ZoGx17sbQdhcox17Zh9Dm2MrSQkGbKodrpVNwvl5QSyT1RUKKBtRt4z2g/WwaMpbQN
    cGpa4oQB26iC9hwEwwmLpn57t44PM1lPvWDLIK4IFDwFHbXxJvRJMsiEl55vBJ+mvZicdT
    VxfCWgrTTTLCrU5T1WyBHZFzSMDeTBxNq1pCr8QaDUW4C4JUQA2sjTC+OlAUjuYtSL2Fq1
    prB1c3aaZbw11cIigRUplkhJgq6Hs8CX+rpe8AaQydooAEMupOzkvp97+EOg8nuAa3hyeu
    0c0L+frZpfV4bIw9/mc5evDisZcBYLumWeVx0VqVloUFtEw6r3gKykjE8F7C6pDC77usMY
    UIsxHf7R5jTeLn19nUSqJItkPCABbR3mImBJou5cZPKrB/WHx4GdK0Tyg1WoIOfyTzIgLp
    eCZOoiDDtow1dAm79HhjR3ohbsXpvx2vQ2rr95b9c49raST0kawP75VHpnSw
X-ME-Proxy: <xmx:lh_Fao4qSyoyDjzjKGYXplp_CGoEGuCNiom3HlcXxaKlNzWJAisI9w>
    <xmx:lh_FajXoZZZ19ajoiFAhibXUihcp7h_qbDi-1njpt0MDfpsA2T8EJg>
    <xmx:lh_FanDKde1XxvIoJgXyIUrE-EQojxRRR-w5UrSB-FU6F54N1mTiDQ>
    <xmx:lh_Fai7lMjbKY3bUT2kevrpKSwmR9Gmv3FOXPJPsi75GwXKlB3WRlg>
    <xmx:lh_Fan10rPFMX_VwbUpxTJg-7k1n6YnxbXtmGBBw88M0DyjduLnGiJvD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Oct 2026 12:19:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  toon@iotcl.com
Subject: Re: [PATCH v3] packed-refs: use `fwrite()` when passing refs verbatim
In-Reply-To: <20261006-kn-speedup-packed-refs-v3-1-a1c76b1df9e0@gmail.com>
	(Karthik Nayak's message of "Tue, 06 Oct 2026 11:18:40 +0200")
References: <20260930-kn-speedup-packed-refs-v1-1-111cd03d9b0e@gmail.com>
	<20261006-kn-speedup-packed-refs-v3-1-a1c76b1df9e0@gmail.com>
Date: Tue, 06 Oct 2026 09:19:32 -0700
Message-ID: <xmqqtsmyer8r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> With this, any sanitation which was happening as a side effect of
> reformatting is now lost. But that was never the job of this section of
> the code, since the main intention is to simply rewrite the remaining
> refs post deletion of the selective few.

Miniscule nit, but isn't that sanitization, not sanitation?
