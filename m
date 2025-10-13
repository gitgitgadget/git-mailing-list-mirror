Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9512BEFE6
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 17:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760376554; cv=none; b=M9POzcEyM7/ZYc3v4oJs+WvQh9D92Q/mUoU0+Bt9vi19hhAAMmqs5yTSMwt0JnFYR1xud/bB9nt0Y6g12V39PkPJ/3UiHnLThMIPKua0fxlccTXVwDDd+dTymQPQoJkKrIvIsZnyld2NzYZcKMmcNk46tGD5ZRzWXDPM/TM1oAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760376554; c=relaxed/simple;
	bh=Gz8xPCtKGhDUjM0/M4Rm78eSYwXDA/3S13t0jPJ8DRk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HOxSvAO9DeGKq4yrSZRXBu2uWAlyqQ2h80u26PywLNc8y10NeOY+3PJ6vKLymRyTtLqlv9doyrU3Ir7zHUubqYMygC7rRYztuNN2z3banswYwY/UHMjuZG6orDSlZKc9RZ40SdKI2MgBn84M2eIb9NZpveAVzK//9iFufplRF6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cNt4TCw+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EekDy0Vq; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cNt4TCw+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EekDy0Vq"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E714E140008B;
	Mon, 13 Oct 2025 13:29:11 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 13 Oct 2025 13:29:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1760376551;
	 x=1760462951; bh=7it0zaYEnA8gQLjO9xEKPJp7nlb9LMH7PlxuyBy5B+4=; b=
	cNt4TCw+rgOq4/iPjlI6qbnHZf0ePaCfcs/cGj3lE5IMms2BH4PjnfLZ71T5nD7n
	8qRoZ4vPfgtH2LVk16qECsPoDAM7Gl6WgPMfe1QHdQB6AwiDXrXOwcqluk5+wRvR
	QGoFSNS88n1bQmazksDwgH8s/gql2fALYSE215e1xL0JnQ+lSSrJmJdkMaAt0VUd
	5Gy1PwBB8U1RfrXfXd0zXxuE47U9lciO+xPEaGpieLMBD70K7DyDDtrc2C26AEeG
	z0OfF9zvuTMhMkYOb+a14brIsCjuuJ8o7oviIWdc06u41Nnzc1Hq14fQ/tcpPL3Z
	NxcR3b17wuEYqHH9Dxr1pA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760376551; x=
	1760462951; bh=7it0zaYEnA8gQLjO9xEKPJp7nlb9LMH7PlxuyBy5B+4=; b=E
	ekDy0Vqc/rYDlbvSeioOiLfK8HK18mUeWlDRsiDKk0aJQe/UtrT+ds9TNRqQdbHx
	NDo85oB2QQoDmgYGt7hbcYdGkdU7Nut6mGKfgl7O4uT6Nj9T+43WDTsQDoReKzte
	uYVCrqkIdCt79MAR6OqYQy/KIhYuDJ0eoByCNOYLfEUzveqaz5KfRLwwCoLzHSkd
	nllTXzJ5eeRws6ZFqlHS6f08yRMIxc/X0AFMYEOdoPV+8vtAxEFKGp4rEFd+m5zo
	aes1p5TBGH2Fq+yy2SlWXCSGwo4uNw6MkLE+DZynR6vRhL2OtRv5zoDbJd5whby6
	8eaFfYNZ07FkTvxrrBO9A==
X-ME-Sender: <xms:5zbtaGldVKXcgCZzyeBXVKMqraElrlM6h9TkHI2cJ10K09Y-w9SKhg>
    <xme:5zbtaFQTdg04Z8qtd9yTDL-XbNKGaH5NLYtEvsjBdGZEpmh9arWYpA-RWLfJEkCBx
    Yx2lxrsYlesAY5yWoA-NgxU7N7OLt1GXHs6w7iFsFGlWyjZS-1vmQ>
X-ME-Received: <xmr:5zbtaCC7ka5XI0CD5VVeCbJXlPmZ-sa_vJZrqAqAwbT7X8SAnk673f0hA9bxyN6iZGluZ7yk3eb6sXBNmiFLorT3F9E54d-KJ5v->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudekvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehokhhhuhhomhhonhgrjhgrhihiheegsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:5zbtaETwdWyG6Ccpez9i7uK-gBeHBap74K4s8n1Jp8IGDOSFJFH1xg>
    <xmx:5zbtaIrgJQWi6GbU2COdeWjj7UWsM_2-xJfig_lBc8fbTtoWevXtAA>
    <xmx:5zbtaOwXpu4n0Ldy_xefW_9WD-005i8os3Hrpq7BQ0wVKCpvP1bNQQ>
    <xmx:5zbtaFJBmfkPIC_vQNZwFqDxSuwCfXjKX5Dkn5b8T94QqTLbXRet2g>
    <xmx:5zbtaJSu6bilN9BKfWdmx__fUMM7LLqFvv29phnJz0ur_zH5q-ogdg8N>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Oct 2025 13:29:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] [Outreachy] patch-ids: fix const correctness
In-Reply-To: <CAFpMFfBXhfy7ecBzR-cnGViivQG3AHGrQ00vSTnVY6OdxZPSLg@mail.gmail.com>
	(Okhuomon Ajayi's message of "Mon, 13 Oct 2025 18:22:24 +0100")
References: <20251013165320.201333-1-okhuomonajayi54@gmail.com>
	<xmqq4is23evz.fsf@gitster.g>
	<CAFpMFfBXhfy7ecBzR-cnGViivQG3AHGrQ00vSTnVY6OdxZPSLg@mail.gmail.com>
Date: Mon, 13 Oct 2025 10:29:10 -0700
Message-ID: <xmqqzf9u1zix.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Okhuomon Ajayi <okhuomonajayi54@gmail.com> writes:

> I’ll revert my local change, run a build and tests, and then think
> about safer alternatives (or leave the NEEDSWORK comment in place if
> changing the hashmap API isn’t appropriate).
> Thanks for the clarification.

If you can convince readers that changing the hashmap API is not
appropriate, then I would think that would make a great explanation
for a commit that removes the needswork comment without doing
anything else.  "Thinking about const correctness issues around this
code is no longer needed.  The hashmap API is right to insist that
the extra data pointer must be const because ....  Which makes
casting constness away when assigning it to opt, which is what the
code is, is indeed the only reasonable thing to do, and there is no
more change necessary around here."  Of course, such a commit log
message must fill in the "because ..." part with a convincing
argument ;-).

Thanks.


