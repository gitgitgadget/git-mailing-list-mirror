Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E285A390CA5
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 11:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773661559; cv=none; b=Ab/gc4TwuBbUmb3jiQWMN1of0L3ovLno9rRCc4EIgOuKhFOq6jEp1+EHzh51mICrOCwRt7eVfmbATYjPkxJN/igTktGDC/1zVQnUpinO2Sy7u+a3bFHt4EbK0eFKKjBxxtaE0WSlqvCfVaapri2RIOjhTgS/Iv6R1uAgRCxw76c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773661559; c=relaxed/simple;
	bh=E68mj8scqMn3w6X3tFxVhAYSHAjFRq1cMfRKhKmrlxg=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=kYtiNj+gOdRVgmejWliNTlJhL0dIGslriZXveGH9hOTZHZW3/gZd6S15YnXF72nFRyEKFBlNSJHSaKxWE38zQLhJPDqaTpm5ffsXbigPBW1ya5DkxTnnE8f1nkKe6R++wfhhJNcDSNifJjoBCny4sbDdgSqJJql6W2qy1AezhlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=WXmUBQNp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZNSXfpPw; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="WXmUBQNp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZNSXfpPw"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 250A77A0289;
	Mon, 16 Mar 2026 07:45:57 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Mon, 16 Mar 2026 07:45:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773661556;
	 x=1773747956; bh=t+XiKo95NIkCTeKqx0oTiG3TcGTGLf8aGUu+5PeWdhA=; b=
	WXmUBQNpXj0Q84gnUW+jXoQbHPWwAgccu4w3sbGrnuXNvCRJQY7T/OvYe7l29Z2o
	++fQc08zFoIlxNDkI+IzyDOj1kfdlhRqoyxhzcVF/5jvV9iKZp2pBWKpXIVCWB+A
	LpUWCDtAdfLKJOrCYFYeEn/U6UR4vNID4pUYq75A4dsZPWK/ps5JHnJZkIIZOOGp
	gGqXbdgWIWuQDdgl3W7LWRcq2AqjkcgoCwL3R8bdMPByUp/UPIM5GYYU6wJUwj65
	sSnGnuhwzOG+gyuZsZaIUjOnkZNo55WogMzYWFaL5j4CRBaxSKKovQa555NcEqbV
	35i9i6rDX4HFjVy5ry05cA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773661556; x=1773747956; bh=t
	+XiKo95NIkCTeKqx0oTiG3TcGTGLf8aGUu+5PeWdhA=; b=ZNSXfpPwj+nJZQCbV
	xLUsn6Cnj+9zPQsLWR852j77o+rONczuSvKSk1QQkUfXOHriQ11KeIminus9c3Ct
	QFcLkzDR9NZ4RAuJFL/DlALtUGcwo9eejlbnwDlqUBiI9bRDSz9Q2Cm/wfvDlMey
	61aqnn9M9ok+xbNIOTTLGZ4+Tb5VssEXrSiYnkAITP2hxIZ0fzuKKygGPXR63tis
	SjHTvk/UX2JCCANJkYM61aMJSOEKjO0zXWhH/hv66I1iFvMP/WG/fPjt2YnxGZ8D
	+rtJNelRZj2vTTpLG3qG95TKWS+K4oS8kR3hkZYcu8ge3dckhH513AxIAgxHv6lp
	dlrkQ==
X-ME-Sender: <xms:dO23afb4T0cVGGs-_wmkKeqDuNhGo4ss1PRY6L-zBQntHAs_zyAxU2Y>
    <xme:dO23aZPYEOnFsieReQWEIdYfcyb1cr-uFfNMb_Hask27srrlCOhbg0UchF841ffsX
    xYmrpSQweS5sdmVVSuCSw8VEdrfFa--baRFk3LTW2CO3GgToL3S2Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleekvdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtgfffteetudel
    hfefkeehtefggeefjeevieekfeefieekkefhveeiledtkefgueenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepjhhohhhnsegtrhgvrghtihhvvghpohhsthdr
    tghordhukhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:dO23abuckoScYNSOcNRsi8SZcLNYoN4VjYbhVqtNIc0yDrGdBsAFJg>
    <xmx:dO23aQypOG8XdHbjOqi996WZzFjKS2qKT53MQa8LD4SYteXVQfuyCA>
    <xmx:dO23ad50pV1ZMq4iePbKWkrJ63lPg3RS7PuxGNkUPp65A0RJTeOAbg>
    <xmx:dO23aSUu7Hj168Fe-TbszZJMOuh628Gkdmncb6XUOPKo4lOXNMuU5Q>
    <xmx:dO23aZQE7WrcC5R0ApPLEfFggK7NnMjkb8aTtw3QgYEzeRXoXsdlA7ES>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B2E981EA006B; Mon, 16 Mar 2026 07:45:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AEY4yhY0zDWk
Date: Mon, 16 Mar 2026 12:45:36 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "John Emmas" <john@creativepost.co.uk>, git@vger.kernel.org
Message-Id: <ff0e899a-3d8b-4f46-8585-55881546423b@app.fastmail.com>
In-Reply-To: <457209f3-e998-4223-bdf3-57245bc51926@creativepost.co.uk>
References: <457209f3-e998-4223-bdf3-57245bc51926@creativepost.co.uk>
Subject: Re: git --format anyone ?
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026, at 11:12, John Emmas wrote:
> I'm hoping this is the right mailing list (I'm using a product called
> Git for Windows and its logo looks the same on your website!)
>
> I'm working on a project which requires me to run "git --format" (with
> various parameters of course). I'm currently running version 2.51.2
> which looks fairly recent and if I simply type "git" it displays a list
> of available options - but it doesn't deem to offer an option called
> 'format' :-(
>
> I gather that the latest version is 2.53.0 so would it be worthwhile f=
or
> me to upgrade? i.e. would that then offer me git --format? Thanks,

The `git` command itself does not have a `--format` option. Some
subcommands do like git-log(1).

    git log --format=3D<something>

> I'm working on a project which requires me to run "git --format" (with
> various parameters of course).

`git log --format=3D<something>` is for formatting log output. But since=
 a
project =E2=80=9Crequires it=E2=80=9D could this be formatting in the se=
nse of formatting
source code?

You can for example use the third-party git-clang-format(1) on this
project. But it is third-party. It is not part of the git(1) suite of
commands.
