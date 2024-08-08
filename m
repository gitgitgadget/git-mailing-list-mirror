Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EAF18D625
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 06:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723096841; cv=none; b=SYF+PdqK3ZiLGAEzt9QXwIL6EWusGQorBUi9Eh/dvu7vvy8iMHzmxZkVeQUGXoC7Zc/kTWQvXVG0SQGlK92fBJDOi7cD3otvYvZV7P5ZUtGpgJbfvMZxPZjvnO3oxnUzW/dSo2QIrkFC6Tzwrbiez4nZBEgNrIOGlfz4IfwSjDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723096841; c=relaxed/simple;
	bh=NDkz0yTJ+zW/RNCgsRIG2fE64XkJTB4QegsAUKBh96Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=KUJV44GJE5FfrbcxTc97ixdGWQJzg5Za7/irP5xakDqM6tJUqCGdK+jRvYIzInMUW6toae1zLysmM9MqWMTr7JtGRnwwYCtYcLJk5aiU6jk1qP43jDGnCm6tNzqQ8pKtwugxqdTxrWjID0iHKYNznOQPbQSqwxzccuIP6V4CFaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io; spf=pass smtp.mailfrom=jamesliu.io; dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b=qI9FObHI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bROtcuBF; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b="qI9FObHI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bROtcuBF"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 553421151C99;
	Thu,  8 Aug 2024 02:00:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 08 Aug 2024 02:00:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jamesliu.io; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1723096838;
	 x=1723183238; bh=NDkz0yTJ+zW/RNCgsRIG2fE64XkJTB4QegsAUKBh96Y=; b=
	qI9FObHIp1+7woFvHKVGCr/edXpOWECucJJZJKXUkW/38wC0mMji6YFUCuceFHPl
	v6OmDnBkhd0f9FZ8/ezcnHtvV2PZ1eWddqPlqpiVh0CKkk69RP9pygNqSMHQ5CbI
	kKyHeXL//9xv7XEA0xodXEafqzixRdzJlIMeVhl67JvLZirM0ivl0moyJJmXiVEP
	07GTvOwgq5PskcB1cOAIweFtHC71KGPaCxqzbu1KnqWquJsYjwanQERJvomqRFAb
	hE54AtLd1LA5aE5O3yr3vwAA4imN2ZU6vG/a91/vKBWPnaUhEWXLUz/G+e+qOkVA
	VZ5fpL1Y505zZ2RiqXy7AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723096838; x=
	1723183238; bh=NDkz0yTJ+zW/RNCgsRIG2fE64XkJTB4QegsAUKBh96Y=; b=b
	ROtcuBFMN7bllQzm6Vef4NAzH4IaanLlFgl0SQLwND2hX14RVLSQq/fKCWGGl9uH
	Z0oqelr0LrTB/ZLSoRFzVu9B7a3rVUbinb/t7C/hxKC7uYnj59W8/FcKMoi9kpfg
	QZCGbMnL9Cdf/XwXCLMB13hRRknd2UeJOloBxUwjxufdoUgeMgEKO7M0hT7Ilukd
	TADw0C37RI23umD1lIoa8q8qOxEnI3Hpnc0gBI880UZg4dDtsHajSlOYmmra/SMg
	ReaAce+yQOYDu8uNJIsOj9f9MZizzEDkS4NpwGYkwlsv1EI3kEkDZ5V87PWLfPa2
	kUdHaJESiCTojSYhISrRg==
X-ME-Sender: <xms:Bl-0ZpQdO5ZessIYfnB9MIKhj7e39A2ngjQ8ekyyMcnnk9Uk8bYcBw>
    <xme:Bl-0ZiysJPhcWuovuTtSh0cdWz3hseL6J7gsD2O7CiUSiNNzTdn29ZAomBt4vxbC_
    n0SUlr5L3vMJXfv3w>
X-ME-Received: <xmr:Bl-0Zu0uPXLTEZEz3_8zrCNxhR0IAQcH70IKfvpcVIZ-doT24_sJbZHzHKDQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledugddutdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepggfgtgffkfevuffhvffofhgjsehtqhertdertdej
    necuhfhrohhmpedflfgrmhgvshcunfhiuhdfuceojhgrmhgvshesjhgrmhgvshhlihhurd
    hioheqnecuggftrfgrthhtvghrnhepffeukedtiefgjefhhefhgeelieeguddvveeujeej
    hfegtddviefhjeetudekjeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepjhgrmhgvshesjhgrmhgvshhlihhurdhiohdpnhgspghrtghpthht
    ohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Bl-0ZhBVlan2EVHU74EUoV7Xpyb_wSvGWh3GMvtsM-coNlq1vvei6g>
    <xmx:Bl-0ZihcBeYUk8KcXntjrAJ1U8HS1Kl75-10Rcqj71v2w0x_oWlpDw>
    <xmx:Bl-0ZlrJ2ub2I0x-SwqiCjS72HOPGKzqRojyeuxE_Ymq8RkTeOHqpw>
    <xmx:Bl-0ZtgopPlpADOmoyzDX60JK8FcL6EBAYF6A3aNpkZIpU5dGSt29A>
    <xmx:Bl-0ZlvGgOETGlF9VuoQJQBQGgrewBwVjCAqA2mC34c9njxVFvUnK6rB>
Feedback-ID: i93f149ec:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Aug 2024 02:00:37 -0400 (EDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 08 Aug 2024 16:00:35 +1000
Message-Id: <D3AAUM8AFHO8.1BF5590ZO4RIN@jamesliu.io>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH 00/22] Memory leak fixes (pt.4)
From: "James Liu" <james@jamesliu.io>
To: "Patrick Steinhardt" <ps@pks.im>
X-Mailer: aerc 0.18.0
References: <cover.1722933642.git.ps@pks.im>
 <D39KMJ3FXBZC.7S74VUTPEQHY@jamesliu.io> <ZrRSE0etqno-yFiE@tanuki>
In-Reply-To: <ZrRSE0etqno-yFiE@tanuki>

On Thu Aug 8, 2024 at 3:05 PM AEST, Patrick Steinhardt wrote:
> On Wed, Aug 07, 2024 at 07:27:32PM +1000, James Liu wrote:
> > On Tue Aug 6, 2024 at 6:59 PM AEST, Patrick Steinhardt wrote:
> > > Hi,
> > >
> > > the third set of memory leak fixes was merged to `next`, so this is t=
he
> > > next part of more or less random memory leak fixes all over the place=
.
> > > With this series, we're at ~155 leaking test suites. Naturally, I've
> > > already got v5 in the pipeline, which brings us down to ~120.
> > >
> > > The series is built on top of 406f326d27 (The second batch, 2024-08-0=
1)
> > > with ps/leakfixes-part-3 at f30bfafcd4 (commit-reach: fix trivial mem=
ory
> > > leak when computing reachability, 2024-08-01) merged into it.
> > >
> > > Thanks!
> > >
> > > Patrick
> >=20
> > Thanks Patrick, most of these fixes make sense to me! I appreciate that
> > even the minor changes are accompanied by context.
>
> Thanks for your review!
>
> Patrick

Thanks for responding to my questions! I don't have anything further to
add.

Cheers,
James
