Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7250A3ABD8E
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 18:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791831327; cv=none; b=ZhxFwzINZvK1TX3YGThYcolR9n9PNPlJ75WIm6hmVK+sm9ayS6GyxP/XOJ/F7B7eAykUjZa8EfwQGgGNCwvQI2My2+zdbpLowKzDsbYqnsrvDiPFIe/EWnp8ZtbMPMQ5h9jsYRkto55u55i/1prpXGZsbq57JABC0gJptd5aVqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791831327; c=relaxed/simple;
	bh=xM+4YZUTW9wxXwJWd6ifFhp9BGBsWRRb9YwtRDn1sbk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KgIO2qrCMJD/bYbXbkcMPbwRT7PhTH1qDEy5h1Vs0PYjkYxlMZsooXqqRQXLsvdHKamRBk9KbVjaT1WnphJCm2G+uVIMamtHf4Ten8UxgZpEt6cE/7CZIrYCZ+wgrmUmdR7GsVKhk1bCtd1/lF31WP/kQyOWiJ8kcSjzagCYY4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VkuKOxng; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=w2RULqBi; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VkuKOxng";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="w2RULqBi"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 944B5EC0845
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 14:55:25 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Mon, 12 Oct 2026 14:55:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791831325; x=1791917725; bh=xM+4YZUTW9
	wxXwJWd6ifFhp9BGBsWRRb9YwtRDn1sbk=; b=VkuKOxngVlA0TjM6jwJPi+tOsn
	KK5SHyi69zZ1jYaav8Kahpr0Eq9KmqijMSfZmP5uVPPaMZnk1PW3ZO0u0Dp3ihjw
	C02iRDaa14N3hmNQOBiqLvlWpUyQ2EaTB5pjL5Gyb8cTW/9XY5SFCiCZ4AdAmL8W
	EqZLpKMrg1n7hcAyKyvweG0VKgzZGh1GM2jo8DtWmcEICyEgEV1lwJdhCIABq69z
	MOgDsEdjIvY+98Fb4U0lg3ahQST0s7BJxZTyye6frNGEx++6549oXe+k/nV5RzgN
	oEtdyjDjt0EN+fBIH4fnRrLKYhVjGDtD/FgM4eyeoUt34nrXOlyiE/w3pUdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791831325; x=1791917725; bh=xM+4YZUTW9wxXwJWd6ifFhp9BGBsWRRb9Yw
	tRDn1sbk=; b=w2RULqBi+yvwRnddEbxixuWxTbl9KPm9fKgOsiNn+dN9d7SLPTg
	9pH/tuPkccOij44ZyAIr1gmySo6FiLgMszbSdo+Tu8qAaeqkuxBjhPLZA++AXY87
	bE83q5Q28k40IwGH181Kmv2yMZyHCiwhatbD6QXgNpuLvNvsafjPTnC9rYkdykSu
	/GBbgSGTDXG53LdUX0rQRPOyRrDiTYbvg/sJvhRETIYYH5dEOfCvZH+oZvOS3c4F
	u/em0UYy6pbgzeDhohfaiFvUe+/nu+3FY3rqfWwgkvogBK+mA4Etr2a1lR6v2w42
	FwBWjuckypdAMjebzWqdro28r5tMFXVw/Aw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791831325; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:nL2bGQg7ZKJBAaSzE3FdEUCMuemZVeluyK8vcSVFJskUYm8
	PMsxCIDFhv5j0KU8IZbIKQkP2mbscx5i01ID5oaROAee2hFNqyJ7lcSFSXb2XsRZ
	0BSxJnKR4diOGtZrhGZwGBh1g4SymoxXoC5V6em7EDVGEEtkAQED483PHDbuGqjO
	Ic2J3wS17P0ZtgJzQzv5pnuYCkQ05dzpkUL6SIkFmv51e4N5+u2DdHZFMnFQoywc
	/6LHWySv/bOLj89ebxD9N5MUOveR0oZxoAAJK40ua1pkcm5s9lOyOr9ejc2XZgAl
	RU5OtVxgyKsUTPx1Tg0jp09Awbk3RW2tATjy93A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:jeYkx42wHtniPegfbpNHyU36lBR2l7O0FO1FI+AdBhU=:xM+4YZUTW9wxXwJWd6ifFhp9BGBsWRRb9YwtRDn1sbk=;
X-ME-Sender: <xms:HS3NakKr3FiQMf0AKNiPC2Rj92xG38nnC9FLJZCLbxoYvs886ZqXVQ>
    <xme:HS3NarAd10-3zdE-jpt8gtilr7uuEBPLTFnxWAeX7mFByH2Xa8yhJZ1WNmQYrxFUl
    QtrNSFcug15b-SogGUh3AWIMxqvUW_EhVMDzMF7IwVe_J5XEGYBibg>
X-ME-Received: <xmr:HS3NatBWluRVSi2dZqSSQZ4Ni6-1eyHCVuea0WaPqZZW8l2iUAfGJ8xDtUkJqybzXS1_6utBlkbhrX6ZUehM4CBWwMQGGn6xS4iE>
X-ME-Proxy-Cause: dmFkZTGhgzHc06Km3xRbWA3KAa2Hm152y3Y9zwRbGuwq1lIiPpSrIdh9b3iGmnKWrRY5kf
    84P+at2T0VPfv7WbAhmzPlnISZMaHufbu5r8vafhagQb4hOnLhddbfSzWTMEKmMz1QDkLG
    RNrNQnIeI1jTYaZnBNuhYtIpaivfIAoDk620O7zaib4/PuRiJN2Xw8cRgVd1ws/j8NIoUk
    5DU7SrFc1jr7exF1av+s6KQcEOvHkjrtTbVZYtKvjblZazhqsiJCLaaFi/Twup49XpML+P
    53+7fhSRtqEF5+ijFP04mtW1eJbwgUN8x3KCTgGk+Zgq+rFHlTO9DYoPfq739P/NR8zaW6
    MHHLQk/ckXZor8XH8n3ggr9Cqgmc9Ts69E73Quo+CsSdAE9wo/YZ2X5R3t/Bw0kaCNAtF8
    hZP+MWykZNnYPAbDhKLJe4uPyxuyxO2JsKMkA7+z+h0ZWqSUYMHzv07GUkwVMU5B3OMooq
    jQUH5x5XjogJpdlZ7ejx/Hw8jA7l51cqe0ztDo3MWS5b1ZJrBrAf+RrNxrjCaeNzIJ4wee
    AhE871EePYtxnfyGadDL6QN3lMPgGOGTdfalifYJu+EXE4dixF3iX+TMpflq3SGRcBCX1q
    7DTLlE8qU+bv6BNXtf6Zx4ndXvKwoivokaIm16Li9cAoWm7y8ZBqh7bSXmdQ
X-ME-Proxy: <xmx:HS3NatAAY1OoWJ_ji0dG2OJJ_djvQPnSv1IPbM6O0TqFbRLXZOMpyA>
    <xmx:HS3Naor1t8hyX-9PK-kOznmkhaT4v5hXRM4gkf-WfHD8Dcx659Nkyg>
    <xmx:HS3NannhIch1G-U_4ZRprjW2vHR77FFkkf7i4rYec80rl0Y8ZOfoXg>
    <xmx:HS3Naoz-xMZpll5MbWcc07yWeN-fPGFrT-7xQDKdBtFt_xLKru9J_w>
    <xmx:HS3NarNogDuBvjk-8bHBLxvn4VMGKXdFaNkiDx7LQ7GGtIspLN-HKvBv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Oct 2026 14:55:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristofer Karlsson <krka@spotify.com>,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 0/4] connected: add incremental connectivity check
In-Reply-To: <pull.2211.v3.git.1791806877.gitgitgadget@gmail.com> (Kristofer
	Karlsson via GitGitGadget's message of "Mon, 12 Oct 2026 12:07:53
	+0000")
References: <pull.2211.git.1789379276.gitgitgadget@gmail.com>
	<pull.2211.v3.git.1791806877.gitgitgadget@gmail.com>
Date: Mon, 12 Oct 2026 11:55:23 -0700
Message-ID: <xmqqzewi695w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> I'll just mention a short summary here, to avoid repeating what's already in
> the commit message. The incremental mode is faster than the full mode when
> there are few commits to verify and when the active object tree is large. In
> the happy case, the work tracks the changed paths and their comparison trees
> rather than the full reachable object closure, which substantially reduces
> the dependence on total repository size.

This is exciting.

> There are also regression cases in the synthetic fixtures. With long
> incoming histories, the extra parent-tree scans accumulate; in the synthetic
> fixture incremental is about 1.5x slower at 10000 commits. Per-commit
> ...
> A safety net for this regression could be to dynamically disable the
> incremental mode if the number of incoming commits is too large, but this is
> left out of the initial version to avoid overly speculative code.

Hmm, ... OK.

> Deepening fetches currently fall back to the full check because the full
> check omits --not --all for deepening -- there is no existing-reference
> boundary at which the walk can stop. An incremental approach is possible
> here too -- using the old shallow roots as the trusted boundary and walking
> the deepened ancestry forward -- but that is a separate change and left for
> future work. Deepening is also less common than regular fetch and
> receive-pack, where the speedup matters most.

OK.
