Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745268BE2
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 05:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714366923; cv=none; b=HQiERHI3hSgg0g8JzHshkhRChLVzQBu/mI8HJjXXGdXx2Om81SwhxJOg52nWulmuBMp6D3NXmxRMAv49NN9fUyajtsLWhWKfkPQR/DWnUUbZNFthpENwYkrlc2yASMccJ9j21xy00vxXbvBrMqwGmSnWPvAiRfw/jcjTWrpwal4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714366923; c=relaxed/simple;
	bh=bl1C08UzkOop6W4TlssQBsXUH4fcUxN7d6OU4pD1Aaw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=VwN1bAZHRMAFOUs+Mkar7i7nc9MRubdkZmDwk5AyKjuiWzxhtch9V9w0HHyYiE41BZZ9JB/j61Njskc8qQ5OTI1vlcf90+Vm0tRbpKTqgp+fKaS1xPgst1qKgyhfBJk9FkzKUDtUcorlM9V5kRCZuWVaa7NKGKffAMPaBc3on94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io; spf=pass smtp.mailfrom=jamesliu.io; dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b=SHcIsdxf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jd8gKgfI; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b="SHcIsdxf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jd8gKgfI"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 877231380268;
	Mon, 29 Apr 2024 01:02:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 29 Apr 2024 01:02:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jamesliu.io; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1714366920;
	 x=1714453320; bh=g0kxnnKEo+aK/KrHE+RPGMhldzww7mGPgO3iiRQDFjk=; b=
	SHcIsdxfeQwc0zfOgooOIYfjlFWOKuS79iTFkmnjS/bOvFWAX/SascU/er4L/NF0
	gekAlndcacVN2lqVHdehmACnSPlZNnxCXspwE4nZrmNyS1ZttpHhOo+Q83+EhRFz
	JVeB7yP1Hutpp1458cGU93Klmmdmir0QSPlMWOv3enu+rihlulVPzBI7HpWlq6g5
	FXipz7OEZDkHZFVsbQBQNYk5DW+WgIPtr2KLkdnTsWTanoBxloJJHMpjxjth8/Wa
	DeY0XYzQEdtLy7VB+IT0ZIC3qQeisHaBaSKb+qTSTdiSiFVZbdLur1au7qayXtsc
	wzF+i/fQtIZjh6ROy+4i9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1714366920; x=
	1714453320; bh=g0kxnnKEo+aK/KrHE+RPGMhldzww7mGPgO3iiRQDFjk=; b=j
	d8gKgfIn2e/Ka63EeLgZEJKJDqnWghxa7bAXLYtpEWSd+bcMCswZPCKYtO3Fpax+
	YWAuOLN+B6AyRbnv+4pULh+xiNZnErqGqzUEBuBgV9VAtqEd+KrVCd8oeDyKa7SK
	wT3BAdA4okpsRU1A9xDj/ZIk5UBt0ipdo+05IIt++9dQFdXF9YR3a3202w1HvK0/
	2IxkW2dWR9yaW5f/V8lNrpskDFIuzEtIeCGh9sTuz522YHJPI2MX23ioZE12Pu8u
	GedHq4tZ3PwZ3hqYZilc3OCr7zQRdKcRs8R/ZHzGfZcEIbWMAW4ex9jBwh5OZ7zX
	z+5RDmistVChz6mfnhhVg==
X-ME-Sender: <xms:yCkvZkwyGtW1AkCP8BVMda6P0KcMwx35h4yqXsbfOCFsMEE5k3BaxA>
    <xme:yCkvZoTOXdPGP6bQAfi7m2J2SzKqC6ebqidT0rCX0j7NrQ7UAhSskF2BUmvSfsp4C
    7rrtZpLimNgMSyqtg>
X-ME-Received: <xmr:yCkvZmXeixcOuKNue9pfpcjjQJn27Ifq63zvxkBq-bX2wI89iQZZ9BmVe2P4PF8ICXcbikBZ4TV8TBk1pmezILCKXItC2DaWtV51zmTx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddtledguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepggfgtgffkfevuffhvffofhgjsehtqhertdertdejnecuhfhrohhmpedflfgr
    mhgvshcunfhiuhdfuceojhgrmhgvshesjhgrmhgvshhlihhurdhioheqnecuggftrfgrth
    htvghrnhepheehudfggeelteeuvdffueffhedtgeeutedtieduhffhffdvkeelteeivddu
    iefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjrghmvghssehjrghmvghslhhiuhdrihho
X-ME-Proxy: <xmx:yCkvZijbW5DCutWoS_RhJHNMVXfJJdNKf7rDz1ZOlt7wpdoaalkk8g>
    <xmx:yCkvZmAEJvOc_462v8Ym0kkEi7Y_JQS4-7yNW5MG2OgTkSX1WsTldg>
    <xmx:yCkvZjK5hHge7jYqlHhrweCDT7Sy5C2jRyY1hSxa5xdJeQ54_PgWXw>
    <xmx:yCkvZtBXmxcymD2RvgL_GJkEQPGUVoSS3HtbKrt3LOheMn7Ob13pmA>
    <xmx:yCkvZpM9SfP7Tbx3OQbRM9WfuOf6UvZ0vSb5K_jl5WLy2kLYuGbPsaPn>
Feedback-ID: i93f149ec:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Apr 2024 01:01:59 -0400 (EDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 Apr 2024 15:01:55 +1000
Message-Id: <D0WCCOLSMM9K.24BIGLR6EEJI8@jamesliu.io>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] advice: add --no-advice global option
From: "James Liu" <james@jamesliu.io>
To: "Dragan Simic" <dsimic@manjaro.org>
X-Mailer: aerc 0.17.0
References: <20240424035857.84583-1-james@jamesliu.io>
 <20240429010925.93205-1-james@jamesliu.io>
 <20240429010925.93205-2-james@jamesliu.io>
 <37512328b1f3db4e8075bdb4beeb8929@manjaro.org>
In-Reply-To: <37512328b1f3db4e8075bdb4beeb8929@manjaro.org>

Thanks for the feedback Dragan!

> After having a more detailed look at the Git documentation,
> I think that adding support for "--advice" at the same time
> would be the right thing to do.  That option would override
> all "advice.<hint>" options that may exist in the configuration
> (and would override the GIT_NO_ADVICE environment variable,
> if we end up supporting it), similarly to how "--paginate"
> overrides all "pager.<cmd>" in the configuration, which would
> be both consistent and rather useful in some situations.

I think this makes sense from a UX consistenty perspective, but I'm not
sure if we should increase the scope of this patch. It's also much
easier to re-enable previously silenced advice hints, so I'm unsure
whether an --advice option makes sense. We can also avoid the decision
of what to do if the user supplies --advice and --no-advice
simultaneously if we only have one option.

> > diff --git a/advice.c b/advice.c
> > index 75111191ad..f6282c3bde 100644
> > --- a/advice.c
> > +++ b/advice.c
> > @@ -2,6 +2,7 @@
> >  #include "advice.h"
> >  #include "config.h"
> >  #include "color.h"
> > +#include "environment.h"
> >  #include "gettext.h"
> >  #include "help.h"
> >  #include "string-list.h"
> > @@ -126,7 +127,12 @@ void advise(const char *advice, ...)
> >=20
> >  int advice_enabled(enum advice_type type)
> >  {
> > -	int enabled =3D advice_setting[type].level !=3D ADVICE_LEVEL_DISABLED=
;
> > +	int enabled;
> > +
> > +	if (getenv(GIT_NO_ADVICE))
> > +		return 0;
>
> Huh, I was under impression that having an environment
> variable to control this behavior was frowned upon by
> Junio? [1]  To me, supporting such a variable would be
> a somewhat acceptable risk, [2] but of course it's the
> maintainer's opinion that matters most.
>
> [1] https://lore.kernel.org/git/xmqqfrva3k9j.fsf@gitster.g/
> [2]=20
> https://lore.kernel.org/git/462de4ec1fb1896fa7f26b3515deca57@manjaro.org/

You're correct. I saw this pattern for a few of the other global CLI
options and followed it. I'm unsure what the best alternative for
passing this configuration down to the `advice_enabled()` function is.
I'd appreciate some guidance here.

Cheers,
James
