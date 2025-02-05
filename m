Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96C21FC0ED
	for <git@vger.kernel.org>; Wed,  5 Feb 2025 17:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738777349; cv=none; b=Bf4qASInvLxUelbTfEtmCWS0k2x9WMNHQNmejISINeONj6Nu2IaOpaD30wWfzraHL9BqQG8eM9IeSnu1cOKnG0M4Gy1CQbRVobl3rBx3CRFtMf0/vu9kp0pLSC3YfCQtPkkSUL7oxFNRgTPr7pUPfVnsI6TOC6xzAcPn30TU4/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738777349; c=relaxed/simple;
	bh=24Sge3ryZ5tGVOuXF4Z9cK5ciFeMOhr8sINMGfjIIiw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pRMjmT+AwFDTQBWipRTzocBqqH9ga9h2XmrxJNIpjEEWZ7wNiv5x6lzvVZDbyXSQ8PLWt6to7tczduuL9Qp7PH23jHT5PbWX/PF8Qjbk282GT1E1pzsxgi77VgS1j6CZFzOYTiUaOO6o1d7AqQ6VrdVNR/Xy4624A1jC9wmj64I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=c0ZfQP5+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ckvpXfAS; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="c0ZfQP5+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ckvpXfAS"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 70CB1254011C;
	Wed,  5 Feb 2025 12:42:26 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 05 Feb 2025 12:42:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738777346; x=1738863746; bh=jJkRXSRfZB
	Cp/z9D8vIaJe9aRUELNi7cqMGwQrCE3gk=; b=c0ZfQP5+rFZ5IYrQyNqGrIQB6R
	AuCYCGLZju9Z4M6EUmZqaj33S194ICEgX4I5vD1JO1tuyK7GrxoQY7RIEiJgO54a
	4CScGv7/8Y7EfSUIgNzx/wRYJGdPtZjyAHGhdrBtwTDrQkMo8kQnDnusdOuhMLld
	45tCnNZ1cRooEXw6MCOJ1klffx5KxBeM0qMUPMUq+BpOX5IMhyFGl/Cvf/fNqWqZ
	pvoVnTJUU/+Hh2x720xencU4PSUTY8fxn0DuNAQc7mJSiRsSEVYOEDF9KCqCeF4p
	/D7u+IV5VpbNriy2VCge9wDYXRQOQ2j18MmpqGZuRQ6L3rfGcqg2ZbZL04KQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738777346; x=1738863746; bh=jJkRXSRfZBCp/z9D8vIaJe9aRUELNi7cqMG
	wQrCE3gk=; b=ckvpXfASTQiSYu4A4Lv6Bsmx89SKeeA0mBhF+k4+PnPYd12mwtx
	IIrUWTQAp95ex5SVyLYQrAvPJitk6p3xwqQrsMJR3ZLBbXAYX23TkZsQeFtdsjS/
	EcbdX4ApC8B3XODu5sSDuVpXeM66xJbF05boo5f1OZIgCvwkHwE/bfSw0c/gF9zz
	T0LBuh4jw8WPfLXzqMBOOiTljSZi4xkubXyyG2oQJQauNhobXgRkbfVVu7Hk0XhV
	AQSC7nHTGToxNdXjxkeQMKTYtm90NvwAb/bm2ZYdVWt1CdRVKLMzON7VpCW4+21H
	kRcIIF00jqaMJonwWx17Y/5esErQVbuXyww==
X-ME-Sender: <xms:AaOjZ-6xWiKJNRE7yhIJOAfjIsdAyW4nXY82ffFsP2VHdeyjNVKg2Q>
    <xme:AaOjZ36y18_yt91n1tfdZVfkIHHPvYmgkwGBKRRQu6lVW5HcZifcnQwF-fnIvmxtJ
    d3aoMrMAZWA3FBkiA>
X-ME-Received: <xmr:AaOjZ9eLvBCRFg6dHY7LlSEJ3N-Nx_LrmTHrUJkcYJuSpsg-5DmS8YmGRJCzkWeKc0tdtD3tHGusCFkoAhPcCNiFIhhSRbaLkv9w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgedtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvghnrdhknhhosg
    hlvgdoghhithhhuhgssehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgihhvghnrhhivgdvgeesghhmrg
    hilhdrtghomhdprhgtphhtthhopegrvhgrrhgrsgesghhmrghilhdrtghomhdprhgtphht
    thhopehfvghlihhpvgdrtghonhhtrhgvrhgrshesghhmrghilhdrtghomhdprhgtphhtth
    hopehpshesphhkshdrihhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:AaOjZ7IgAiemvib79CbqZIZWmcTmUl51zPsI0FoLzrWxtbztXBXQ-Q>
    <xmx:AaOjZyKco0Gg3ZlwB7439tuM2NLDUSH8qH813zUbAY-lcHD9CZTYIw>
    <xmx:AaOjZ8yiLt0yvXp-FnHhEtl5njKTGuqXJIZoB_ZmmqvC9KfK62t8kA>
    <xmx:AaOjZ2IqzIGhRRFDRJ4dMlUueWB1fgHeLyGyGSnxCK2pBLfV2hIPlA>
    <xmx:AqOjZx8YEu6x8gNv33BK0AyXZ6EsWb_yG24ToSP-XVUNyXpO4M5ZmCEe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Feb 2025 12:42:25 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: git@vger.kernel.org,  Alex Henrie <alexhenrie24@gmail.com>,
  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,  Felipe
 Contreras
 <felipe.contreras@gmail.com>,  Patrick Steinhardt <ps@pks.im>,  Elijah
 Newren <newren@gmail.com>
Subject: Re: [PATCH] pull: allow branch.<name>.rebase to override pull.ff=only
In-Reply-To: <CALnO6CA_vF4huxMx6jSS4SVjS4+EO9K16Msco-vMUDzSoYRDOg@mail.gmail.com>
	(D. Ben Knoble's message of "Wed, 5 Feb 2025 11:36:10 -0500")
References: <20250205030642.95252-1-ben.knoble+github@gmail.com>
	<xmqqbjvgr11y.fsf@gitster.g>
	<CALnO6CA_vF4huxMx6jSS4SVjS4+EO9K16Msco-vMUDzSoYRDOg@mail.gmail.com>
Date: Wed, 05 Feb 2025 09:42:24 -0800
Message-ID: <xmqq34gsp9tr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble+github@gmail.com> writes:

>> So, I dunno.
>
> Agreed that if pull.ff=only is supposed to override all other options
> (except those on the command-line), this might be wrong. And `git pull
> --rebase` works in the scenario I described.

Yeah, I view --ff-only as a safety measure for the user to say "my
workflow is to make sure I do not have anything locally cooking on
my branch when integrating with the other side, and stop me if I
somehow made a mistake".  If rebase or other options override, the
folks in the rebasing camp, unlike in the merging camp, cannot
benefit from such safety measure, which worries me.
