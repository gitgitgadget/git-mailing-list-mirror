Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B5E331A75
	for <git@vger.kernel.org>; Fri,  7 Nov 2025 16:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762533024; cv=none; b=b2a0bFCsJ7ojPAygAFqiANHbupmD/mGL/mbmMgwNqzN0f8rH68KjmtS/dudegQUhLzYrI32xc4jw/pmA12je7VV7tXS77flb13qtdkjpIRkGgqdxnVeHqAH+wL7JbARZwjcRI5FSA5PFH8ghdhIIcnM5B6yv4WVbuBmVnBk/bJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762533024; c=relaxed/simple;
	bh=ntpVJV4HR/XnYWpgqzULCVzN4FHmeXKgcSNYZ1+9ePA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sNpfQBUDhXyk4/WgN/cDgmtp4dyeYCGcMM5r34cD7bMxPap6ce1dUXC6qAeLfnkGrnNoTt+932trxcp2xVdE5OQ68/1giBFC1nu1VaapQsgsUajKAQYJjL5U1kTct+USuCovCJfm5CeCGwKYJPtF14cQevnYqAHQh+O4gUs4c94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ewJdoqVs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C0d7KoKp; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ewJdoqVs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C0d7KoKp"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 5EFBB1D00141;
	Fri,  7 Nov 2025 11:30:21 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 07 Nov 2025 11:30:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762533021; x=1762619421; bh=B8EHJyx7Xt
	wMMe3WUhiqxW0X8MN12Al+RN5zKKXOotw=; b=ewJdoqVsPZOmkV2XmxZ+6N28jS
	DV0Lkq+qYrlWh+33aiiqe3aAPJNBoGY92Lk126ZjQ7XeTlAmn/eavRmK0HSHIO6Y
	UaG0m0DqM8ARIJ+vAAop2qw1tBfYgls+7d7G0cehit7ir3ZDaJa0PJaJ8EqhdxgN
	gxMht5TnPwGKFBKjUJOKuQ8/OjbAyqjZvmzEjQSJa30x9MbHLUuejls10nNQd+6c
	ckpNFGaWU5qp0phI8zVFiYam4igQcy2RK+aD64F3olX9QsjEibX1ANaMAni9T7ep
	i/CoNFdoVmqiEkm0VWFY25Q2bbycCd7q1MO344DH7tl7sRrB7mp64luA3Smg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762533021; x=1762619421; bh=B8EHJyx7XtwMMe3WUhiqxW0X8MN12Al+RN5
	zKKXOotw=; b=C0d7KoKp7mBHICaIuQXSTCIzCVJypycfp2e1YZqEVkM3FxohysA
	wjrsWexGELdttT4Mpvh6Ge/jBC/K3+AI5u1IQUg2xYIya4oYGs5a2uRUoTnONiBm
	HBobekLXU1Se98oondquxubg88pp1MggbBYH5p+zQfuNM8DQMLKzFEXeB9YsDtgR
	0YrxwA+diM1W4ENCiem0+zMqnXeXUHmYxg9yMZ3MZYyEdmcHTdSOBtBfHGIxubbp
	uFtxfCK8+CBeTa1LwQ+vs5HYeoc2/SoU7F+KUSWahNRJDnfS9lDSQXP7XGEUH2Ft
	47q0qPNM8fS/eFvgCVVv3/gWXpUqSvahTow==
X-ME-Sender: <xms:nB4OaYXvZqPlJaillaFAPsKh868YfMwIjFqJ4C-nlxRVh4CO-K8mhA>
    <xme:nB4OaaaHwQsWgh-Wmdb7PFMmkVgZNQo0dl8U2KKl031Vskl51UKriZybPHcYR3zRx
    HGjnxPuKE6-WrhFF8OJAXmZfo1Wn5V_KxAS0lyyxdQ38Jy6R_OTkAw>
X-ME-Received: <xmr:nB4OaW0bj4-mf_sRgP_YxQyvEQ8oClYE6S9aWidA6aALdxR78CQ8byjiBzmmUE10-7cU1GgnRZxW1kydRrdR_YXuWlSJUmS5sHHO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduledtudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhhohhmrghsrdhuhhhlvgesmhgrihhlsghogidrth
    huqdgurhgvshguvghnrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgi
    druggvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:nB4OaUjppM9MF61ZqRZs9Y1yOyA5J4zFQ-YGPc5yLRgzqrDccT0zWw>
    <xmx:nB4OaSYXGZlBOn87oXqErnN9qomCCGPJVN-c8122z4VPkz-UssdLNg>
    <xmx:nB4OacTlryDLXJOqbZYN4eIrgh3j6W94LDJxZANRmWpDI-h-PTVZjw>
    <xmx:nB4OaVR_FV_k1pkLhLrAD0zvvxGT1d68h86FvG3Cx0TRZ3madaG0-Q>
    <xmx:nR4Oaf3NmR2DVn2AvY0GX84ivSYvaf3O7dBfouv0-M9VaeAqb-1sXlnS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Nov 2025 11:30:20 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Thomas Uhle <thomas.uhle@mailbox.tu-dresden.de>
Cc: <git@vger.kernel.org>,  Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] wincred: align Makefile with other Makefiles in contrib
In-Reply-To: <19573251-81e1-e07d-0f21-1f90ea5153a3@mailbox.tu-dresden.de>
	(Thomas Uhle's message of "Fri, 7 Nov 2025 12:45:33 +0100")
References: <3869ec21-e20d-cf9b-5913-6389c372a5f0@mailbox.tu-dresden.de>
	<927c2094-3654-edec-072e-1f6ca7d91f96@gmx.de>
	<xmqqv7jnhzmh.fsf@gitster.g>
	<19573251-81e1-e07d-0f21-1f90ea5153a3@mailbox.tu-dresden.de>
Date: Fri, 07 Nov 2025 08:30:18 -0800
Message-ID: <xmqqwm41g605.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Uhle <thomas.uhle@mailbox.tu-dresden.de> writes:

> Thank you!  Does this patch qualify for the final version 2.52.0 or is it 
> already too late?  And if it is the latter, wouldn't it make sense to have 
> it in an updated version 2.52.1?

Highly unlikely, I would suspect.

In general, after -rc1 gets tagged, nothing will become candidate
for the final release without a valid excuse.  One common reason is
that it is a bugfix for a regression that was introduced during the
cycle.  This clearly isn't one---the aspect of the wincred Makefile
your patch fixes haven't changed since ccfb5bda (wincred: add
install target, 2012-10-24).  People lived with that awkwardness for
13 years.  They can live with it a few more months just fine.

Those who _have_ been building wincred and installing it for their
own (or for their colleages) would have an established procedure to
work around the unusual arrangement the Makefile has (which you have
fixed), and changing it this close to the final release would only
add extra work on them, without helping anybody else.  A good time
to merge such a change is early in a fresh cycle, so that they have
longer preparation period to adjust their build infrastructure.

There are reasons we may want to have changes newly floated after
-rc1 got tagged; for example, I merged 8d716966 (ci: update
{download,upload}-artifact Action versions, 2025-11-06) after
tagging -rc1.  There were another CI fix merged immediately before
-rc1.

The benefit any late changes that get merged has to outweigh the
risks by a large margin, and CI changes like these have very small
blast radius even if it goes wrong (nobody other than our developers
would be affected, and they know what to do) while the damage
unfixed CI job can cause is larger (CI can deliberately stop to make
us realize that the service we rely on is being deprecated).

There also is a message typofix merged post -rc1, to correct new
messages that appeared during this cycle.  The output from the
programs before the release candidate were properly localizable, but
left unfixed, our translators need to translate typoed messages, and
then when the typofix hits 'master' later, they have to adjust their
translations by updating what original gets translated again.

Is there comparable justification why wincred/Makefile change has to
be in the upcoming release?  I do not think of any.
