Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7382C1A9F8F
	for <git@vger.kernel.org>; Thu, 14 Aug 2025 07:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755156677; cv=none; b=gJh0uK8Wm9YN0lOKqOgTUkNv1O4DmqbjmfZteSccHdvLu0q97HDOGwiyAyfnbCDsIC2aUOGv5AvYONiMOd+O3utRFBs41zc/eGNeFfyfBYRcqiTSFniz7dIkkCP7A9umZEBRVDaojLf/ZQq8Mvk68QIqvkd2XFHrtYgyaGlwQ/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755156677; c=relaxed/simple;
	bh=mAV2tcG7Gf2rnv1aQLReZIQx2lkEdPPv89ItXxTrbFc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=eAZqfE8ueRt/7jPmkARSoxy51YqFKNkQKXdFY7lFUzRvetgNUOjiZy7SdCdpXlqtsNJZEI6optiHyX9h4h3i4lxJYsQWK0QMhi8KwZESvDvF1X+bHPN8EyOjKiryf7vT9LehI7RIqetjJefymHkZXaZ8Wf4TkdD5xXwgVaZZXSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=PsexpbRq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iwcN9MNh; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="PsexpbRq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iwcN9MNh"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4B8587A0183;
	Thu, 14 Aug 2025 03:31:12 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Thu, 14 Aug 2025 03:31:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755156672;
	 x=1755243072; bh=tCRj0dPrPObUHcAeUOIeP86qkilzEOqs/j8wQLnwQVc=; b=
	PsexpbRq/A7voGJbiUFT2Gt5erBcw4qUVaFksEyqMcT//OkjrdFayC6xHQM7XBJj
	l3mn2kdI0dPIkmLjDGzTMPt6Ssg1CYgYMn7hbDEb31T5ru5f3QH2bUAzKldHOrhK
	+QyAtqmQFPflr70SH83qDZ9T4kudBYjYA1ldPCiz5d8AQuNF+xwe5Wpip77pjpeF
	fxOLhNp+D+GVGWQRw9lqOS5qtYFb1TfgWM4S5NZ3MfjiC3/hnAMGq7L82N2GlAWL
	e8IVN4hQkCXBJeq5N0Ub21MjHBvuDjdDBUkG2ja4C/By8L1MFY9ydXgBP2KS7OLh
	+DaVNpFneM1RsP2HCRDF4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755156672; x=
	1755243072; bh=tCRj0dPrPObUHcAeUOIeP86qkilzEOqs/j8wQLnwQVc=; b=i
	wcN9MNhIXLJLJTCiM3AtZD59csjnKO4Q8+RUz6FlbjyfKqKM63U5kTHwBtfrThMu
	pX+adFt+jMRtVbFieL/csbfCdWHx3JDDFqnrHF/ZyNWiGpkyfUVgVdJ7ciNI7Oho
	ekbNYUgG7I0ki3ztxAhPpb9p+MvF876bmUAaCbrd3ldhBxEdywtl9G9ytpNEz1+0
	i45LmzISWSWFWjTn+fFbp/XVH6RyTkWYIPG9aAzp+2F14X11E/IMvdzuLzHCKr8+
	+oO8T2Ake9McASyVhHrIs5grh6OMElHM6V+vGCVqAwS5wZOAR3muI6m1UQgoHjcr
	XvCcITtP2IGkNJaW8bRhw==
X-ME-Sender: <xms:v5CdaDKP-ZYpORsYP7s6-GGWa_rnb8OshwQN_jW_8ioWQnN8SHGQpHI>
    <xme:v5CdaHIA9yRnE4WYHS80Y0udxpC24kXb1urpZRcIg6E-YbuUD3b3wopLyYlAIgYdv
    -Jv5MEnueDE_0uXpQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugedtgeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopegurghnihgvlhgvshgrshhsohhlihesghhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:v5CdaGQrG-th37P91dsSKABJa7x78EVSYYU_J6gl3qrtFeus0Y2u7w>
    <xmx:v5CdaCrNHqYSWZtpZN-p5R0qwSXO0D9goPQgUpqW6h-ktMBr08FHBQ>
    <xmx:v5CdaAyYugAkmr0_hX75lV2GlLgsGin8bMYQOfMSgv6k7WSBA-aQTA>
    <xmx:v5CdaPKO8PTMkueZBVGA3rL_ueWOmJjGSukBV610eO0VjLwyDan8Dw>
    <xmx:wJCdaPugjTFceWdoNDHJeOuRn6Au0zy_A9ktz-JtMq1Vgie4XDKHtuwM>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CF8751EA0066; Thu, 14 Aug 2025 03:31:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AMTlAUTgAFnV
Date: Thu, 14 Aug 2025 09:30:51 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: "Daniele Sassoli" <danielesassoli@gmail.com>
Message-Id: <8147cec2-f898-40d7-ac3b-763920eb7947@app.fastmail.com>
In-Reply-To: <pull.2031.git.git.1755078045397.gitgitgadget@gmail.com>
References: <pull.2031.git.git.1755078045397.gitgitgadget@gmail.com>
Subject: Re: [PATCH] Document count-objects pack
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025, at 11:40, Daniele Sassoli via GitGitGadget wrote:
> From: Daniele Sassoli <danielesassoli@gmail.com>
>
> Juno added the printing of "packs" with ae72f685418b.
> When 0bdaa1216 refactored the docs for the -v option, this was missed.

s/Juno/Junio/

But commits are usually just listed as-is without mentioning authors or
other metadata.  Something like this:[1]

    ae72f685418 (count-objects -v: show number of packs as well.,
    2006-12-27) added `packs` to the output of `-v`.  0bdaa12169b
    (git-count-objects.txt: describe each line in -v output, 2013-02-08)
    forgot to include `packs`.

The text above is a bit more terse around the commit references since
the subject line for the second commit says what the intent was.

Alternatively, just referencing the second commit:

    0bdaa12169b (git-count-objects.txt: describe each line in -v output,
    2013-02-08) forgot to include `packs`.

=E2=80=A0 1: using =E2=80=9Ccommit-reference=E2=80=9D from Documentation=
/SubmittingPatches

>
> Signed-off-by: Daniele Sassoli <danielesassoli@gmail.com>
