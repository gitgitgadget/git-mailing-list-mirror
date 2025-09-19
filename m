Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3065C96
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 19:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758311030; cv=none; b=as5er492SiVPd1sOS+u6jYTPSsV2JJWgbsSC17Ph6gYWEMNLQPnjpotaa3ehS5dcX/mlRI8PHkpcmBYtAMVJV9y7vNV8PmIMK7RqCRdkl+wTv9OA/TBlY1MQhupE5XaEbXX+ZgHLPiogR40O3PvVcsH8UrJ8p61N5B/ZOyqcwbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758311030; c=relaxed/simple;
	bh=xHoXnFO4T6gqzAgh04lT6tK+ihFVN39IljaI+h8AED8=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=B4lSX/MTW21FzyIr0bxCb+TX+A9dv8HQ8FP6TEdo3KDMHFCmp2DjkGfZqkeGWXJmsCjeySgXPZxhKOEGvTF5tdmJn1qHNc9tlNps+pIXWc6rk0/u10vodKf6xnsUUK4XoABeFZiZ5aYxL52ka9fvTUPwWGsN+2beglsP+dD8hzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Bsc8pEtn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ixCjabJ4; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Bsc8pEtn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ixCjabJ4"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B8E6F1400111;
	Fri, 19 Sep 2025 15:43:46 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Fri, 19 Sep 2025 15:43:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758311026;
	 x=1758397426; bh=njQPkCWEgcvC/GifFxV1QGJusrVNxtMLgglNNhhowA8=; b=
	Bsc8pEtn2Yo6bwfOPfYNehsITGyq8fsgwXZysmWHsHiQP54x1WvyFE898Diva4sp
	bmpGQwURGLNDOdwR/D7ZtLytRjXNSnF1oklDE8ALLk8KlJfEMMrqQ7qCsTKEVQVq
	9pvCVriUaaCpFevX6YTXWSGa0cFCZkLVJetxPrI5R7umVnOm41VHB6fqzCwNDwXq
	W30DlfyneMRGob5PaYG9CRjBYhZuXIrgWYQlK1geEp4048sPDhJjd4leIQOuFmPE
	pVrEbX0gWZT6DmNV8eUPajaDtt9wPKfLbX1jPWvxtomNcp/Yum43osJ+g9NlQOFC
	m+fFbPnZjCgS+VrJy8AN0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1758311026; x=1758397426; bh=n
	jQPkCWEgcvC/GifFxV1QGJusrVNxtMLgglNNhhowA8=; b=ixCjabJ4BOp5Y+AMD
	7LehhRdaNrJU5vuctQPOObnxy1YaN3Wnka2i57D7c0paRbTUBe1+fWgNRy3mgSY4
	MLldciMs0uU7KRJ6nB7lutc7LtgvkGclpxiY7sRIhSwRNyKqqjh479IW3PGidv7R
	z9i8T3BKUc6yRWG7+M1gbGzgOgpQpq4NGIJXK0fHdnXq/LIIPoJodQm7tuJUCSgA
	BYRK0MqiblZD2WKW81kSVm2TPjazY+YObN9JOMqt7cjatPEUZ5129A7nLaMiM1an
	SBVE+DIFT9Oq+7lKPvpPOn6IEzb7YLtq8gXdny5jF1BnM/P85jBTIjugmq6j601H
	YINTg==
X-ME-Sender: <xms:crLNaI0mQ7HNjBey14U7h6dTndIYLSIJYq2yCuZVGLvjBpDCG350Mnk>
    <xme:crLNaDE0LOYy22dlyHLfwHAu-WSFH_vvpaU9ZF7aOTPBsoNjTRnexzgrMhVvUrE-u
    DlZvyfZO5RSPBgvSg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehtddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhsthho
    fhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssggrkh
    hksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdfgffettedulefh
    feekheetgfegfeejveeikeeffeeikeekhfevieeltdekgfeunecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhg
    shgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehjrghmvghssehjrghmvgdrgiihiidprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:crLNaA5Jq4uOsofRB8ZhCpZeFpevjkezXprSzg0-5iReOuRu01QfNw>
    <xmx:crLNaK0sP8LfRjOMt4DIv-YBoLiJAT86mOz-h_zePOC8YcHiS7i36Q>
    <xmx:crLNaBZfHUowfga86E5ZzEOkfcAS7dnd4ezRHGybOA5FJr65HSqNng>
    <xmx:crLNaCDzy4no8W2yggoOV9TBcW9bKYBLNSrnt1zstj-0ZbB0fddydg>
    <xmx:crLNaFNWzC_-YBgOAZp-ZrQxFZllh62gkzcq_TRRZ3ohIGdgbiLHiI0N>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 795DA1EA0068; Fri, 19 Sep 2025 15:43:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A_YGYY6EOHPJ
Date: Fri, 19 Sep 2025 21:43:26 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "James Puleo" <james@jame.xyz>, git@vger.kernel.org
Message-Id: <de3d58bd-5600-4bf3-812b-c329c4940afc@app.fastmail.com>
In-Reply-To: <d94afaec66f8ab8058764cee08e9dd56435dd667.camel@jame.xyz>
References: <d94afaec66f8ab8058764cee08e9dd56435dd667.camel@jame.xyz>
Subject: Re: git whatchanged: fatal: refusing to run without --i-still-use-this
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi=20
On Fri, Sep 19, 2025, at 21:24, James Puleo wrote:
> Hello World,
>
> I have git version 2.51.0. I encountered today entirely on my own this
> fatal: refusing to run without --i-still-use-this
>
> Why I was using this command: There is a bit of code I wrote in a file
> since deleted (from the tree). I knew the path but not whichever ref
> last had the file I was looking for.
>
> Having a file listing consisting of purely the file paths that have
> changed seems like a useful tool, that's all. If this isn't fueled by a
> technical challenge, I don't see a reason to make simple things have a
> difficult path.

This command is getting removed=20
because it's been replaced by git-log.
git-log can do evereything git-whatchanged
can do and has better defaults "for humans".
For example: --stat or --name-only which gives
files-changed output without technical details
like (I guess) filemode.

But you can keep the whatchanged behavior with

    git log --raw --no-merges

--=20
(sent from mobile=E2=80=94check option names
for me ;) )
