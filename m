Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DE223D7ED
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 19:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760385099; cv=none; b=eGcok7XYOo+2qLokMXjcl9+Cl3Y0I26+EbTafy0Iaa+kH6l+y22yFNvpY3UYZkCrSC3C9i5zDJVRmfvIpfzvWII1R319kxtfhk6J+NsXwSYIYHA7ZHdHtWvMurImBtwkm/aky22BF1XWE/Lb6mdDXTw3+2cStUWVPC/OjJt+9Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760385099; c=relaxed/simple;
	bh=vz/yREGy8HbVJ2L2ZCT88hNaoMAbH/TEFOd71tVx71U=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=KlUk/FUEsMPol0YvYaRkqS7rv3FEfv3wO2eopipmc1S5X7chTJ+gC2vSBLRJwEzOXUA7k++zSu6HoPgnhXJG14aJg2xuNZC+gG9Q+jY6G3R3900fE/GbuymJ1t3d44FB3mZrqZHmmHFQFnK2ThA+xBQlL70Sfw21CU28UTh3Cwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=VSlLPRe7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F4AcOLVj; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="VSlLPRe7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F4AcOLVj"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4945314000CE;
	Mon, 13 Oct 2025 15:51:36 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Mon, 13 Oct 2025 15:51:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760385096;
	 x=1760471496; bh=x3E2BNv0RWjmf0jwvAcZBoRGtaUBmiWaGiPQQKHb4EI=; b=
	VSlLPRe7IkWV0I9ofEJu/UsM/VzgfPGcNyrZrYoAsL2LNRxlbP1gPkg7lRgRmOZz
	/BMuZ6Bo2gIK4WjFvXVS21uMZEwDgvDHLIu8XahfMAfNwUCqOv2gGNbis81LBlsA
	uRoaOLCVQ5tIkJQXhLOxCt0GVv88SFGLkWtEJc1jcAQNWWvnY4frwZ2mX0wZcRkc
	yRs5KgxWdAWSByPZdTFFvzeJpGcqyL1Z53tz68McgJXcib5O6GDpZmYDqtG0dsDD
	/rQ5upcZH5KV0vzhXJden17c6IZDM+77JJ+6RLnUwEjsPSJYLfu0i6bFOT05ad2I
	B+AKthfrbcmwmKTh0lbMOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1760385096; x=1760471496; bh=x
	3E2BNv0RWjmf0jwvAcZBoRGtaUBmiWaGiPQQKHb4EI=; b=F4AcOLVjsjR5BPbya
	tpSMOHZS4cun6f3CaQ9N95WFi80RMD69Ognl5TLj+7O9FAt1OhwuldXHp55520Ju
	usKLafWH9W/cqket+UbtZgCAikbVZHCsVkekGYQcxfYrnxl2n9rzgf0X1tPuuDm4
	eowp6gG7jjLaySidcksMpy2YmyvlWor2obTtXvcM8ESzumElTn7nqJEyOSyFBLpr
	TsR2gEpVO8dTbqSQu3kZnQbJQniMXHSZfYNThgVtYgMeaLInBLhnwOWHn+iFvBRe
	FguY3rz4wBl/Uatb8m1kA+63EKJNypRBzOR2XzPnytjnI5LNJ6//xAiVzgL95n2i
	n8rYQ==
X-ME-Sender: <xms:SFjtaPGMpweEdqJRlG79mnbUyJ7v5xvbj_PFu6Bn_y_f5KLFiZdXXbA>
    <xme:SFjtaHJcspKGPiPPVlPutPVgIdEw7Zk14J4TCqHyElQ71bgXCARWl9o3pC1g4njKl
    ETb4udPh_wR76h6kdp52ptoxYwkqr9cI63M9olRfvDZbk1Q8Ha8zwY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudekheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeffieeftefgheek
    geeitedujefgveehvdevieelfeeiiedttedtgfduhfejiefggfenucffohhmrghinhepkh
    gvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehrlhhomhhitghkrgestghonhgtohhrugdrnhgvthdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:SFjtaFwSI3lP_3C0yoBkhnGs3CmnXi9glSbZOCHlZVwXB_uz0e-AcQ>
    <xmx:SFjtaDPCF_OIOd54m4UOHEt87ACxJkv0oVayc-S30qKJ_wnwyiKK0Q>
    <xmx:SFjtaG7_YQQzN7N2w_oyU_8fJ5C5o1fbjEhQL2mnXFpW2SdN_JLnVA>
    <xmx:SFjtaEOBNmT50bIbFkUeipU9wQGbTFi7b0PbFuplDsBLl5v3EhxdMQ>
    <xmx:SFjtaDyDiaXtz7POYrjFoxaV7ADcPDRtwPtJKOJ9aQYCG4b5_xTkGWkv>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id DB3421EA0062; Mon, 13 Oct 2025 15:51:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ASBUPAYCqKF7
Date: Mon, 13 Oct 2025 21:51:15 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Roy Lomicka" <rlomicka@concord.net>,
 "git@vger.kernel.org" <git@vger.kernel.org>
Message-Id: <4f213721-4fd5-4073-8be3-99de1ffa4a8a@app.fastmail.com>
In-Reply-To: 
 <SJ2PR03MB7043AA590AD8D80DB4EC7B73CFEAA@SJ2PR03MB7043.namprd03.prod.outlook.com>
References: 
 <SJ2PR03MB704376284D14F92B54139BFBCFEAA@SJ2PR03MB7043.namprd03.prod.outlook.com>
 <SJ2PR03MB7043AA590AD8D80DB4EC7B73CFEAA@SJ2PR03MB7043.namprd03.prod.outlook.com>
Subject: Re: git whatchanged --i-still-use-this
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025, at 20:55, Roy Lomicka wrote:
> This is one way I deal with the fact that git has no option to respect=
 mtime.

The general recommendation is to replace it with `git log` like so:

=E2=80=A2 Given: `git whatchanged <opts>`
=E2=80=A2 Replace with: `git log <opts> --no-merges --raw`

And I think that should be okay in your case since it seems that commits
without changes will not affect the result. See longer explanation
below.

-----

Longer explanation:

See:

https://lore.kernel.org/git/83241BDE-1E0D-489A-9181-C608E9FCC17B@gmail.c=
om/

   I run an important python script that uses this to set file times to
   the dates of the actual git commits, so as I browse the files I can
   see their last modified date, and not the date that the file was last
   synced.

The recommendation above will give identical output as long as there are
no empty commits in the Git history.  Where an empty commit is:

=E2=80=A2 A single-parent commit (git-whatchanged(1) does not care about=
 merges
  by default, and not in your invocation)
=E2=80=A2 There are no changes compared to the parent (same tree)

See the explanation for why they give different output in this case:

https://lore.kernel.org/git/20250825085428.GA367101@coredump.intra.peff.=
net/

Normally I wouldn=E2=80=99t note all of that since it seems unlikely to =
be
relevant.  (Certainly shouldn=E2=80=99t be relevant for interactive use.)
However here the case seems so *scripted* that not being
output-equivalent might end up mattering.

>
> powershell use-commit-times.ps1
>
> 'git whatchanged' is nominated for removal.
> If you still use this command, please add an extra
> option, '--i-still-use-this', on the command line
> and let us know you still use it by sending an e-mail
> to <mailto:git@vger.kernel.org>.=C2=A0 Thanks.
> fatal: refusing to run without --i-still-use-this
>
> use-commit-times.ps1:
>
>[snip]
