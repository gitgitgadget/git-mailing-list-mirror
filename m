Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347014F96C8
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 14:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790777899; cv=none; b=IfewhSwdjw51qtVst6ioT7U0R4PATC2FFhlSufN3Fz1Zn6zIEP4BdZESzKvIGqTGZZHyKY49ZNfuYXG72QIQuoJVtBCaDXhH4CaiE9pzt9ekvPcTRffv9Eks8jVMLNcCHajPprQHReBZQwAIkaZ0ybqZrqRL15T5bRseALNDWLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790777899; c=relaxed/simple;
	bh=Lxph8+KzAu3aoZZkZkHduH1jza3U0bdK4yz/IlO9low=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=QFpcycFKJSdFC0O7yD4Whb60o814dYe2lAfFbrvQ0614I9xS0PK++y09U+rGkigVAgYtD7iMiEb1w8oL662bwpURn266K5gR9I/D+++xMtug3VU2EEIB5YT3+seM3OqIW10Ame8zHNzdzOiJ0j4sWbtrAmhAi4vxTJ1mpBqzf+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Tbk1xtBG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EtIoTP5c; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Tbk1xtBG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EtIoTP5c"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.stl.internal (Postfix) with ESMTP id 23DC41D006E6;
	Wed, 30 Sep 2026 10:18:06 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Wed, 30 Sep 2026 10:18:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790777885;
	 x=1790864285; bh=fVKX1KMKFc/0KTeQ9CXGoiwWDBu3rdj91aSJhmrHKBk=; b=
	Tbk1xtBGJ0xf5gxlNbVJMh/2B8KLpZIX8BrBz5lyc5fvIBoCL7AzZqwwvBHkag/x
	xpLPcMyEz3sWTYXJdh6ECixVJtfZfIq/M2Q/EA7seRuHCOJP5MoipbYqfZyAly3D
	bh/Vaf1QL3HrSVNgHl3MoL7Bw5twZQUkPdphQffDpOzHbZtCD9l6jZDyigZ5IYJS
	aIN3SGF9n0OXRDWdKCpy4/Ce5k1CZ2fEXRGWVO8h4htViqeQkThZ89BndEZKsTaJ
	WClKmnGP0KbV0ejyt1xIrVdMLBcAc1pilzkhlsxnrRcGST7y1otezfnMMUmXJxAx
	ut/qME2EgaBwz8SkDt/zTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790777885; x=
	1790864285; bh=fVKX1KMKFc/0KTeQ9CXGoiwWDBu3rdj91aSJhmrHKBk=; b=E
	tIoTP5cgjZY5dIFZtGt7rNxp/MZsn16LolGG2FeMpvOWyPb2edrC81SAMgeMpS7V
	yZ5AmILbjg7EGpiNABB9ETRN62wcHbsyreHXSp8R9qr2Y2zhXh8j5aBf9fUNASBi
	15rDgmaQ+Io5C8kqC1l0hJM56a458FhsH9nYaWEFbifwlQWLMeiIpTPZR4obI0QC
	OCMyOHAg5UZ/e0jFi0oo7FaL4nit70KErTpkTK0vMlW5yUGURuqF4/2WeuUdFooU
	zniqrnsXDaOmEq5KrZ9KBZGVMVNOSHY9meHYLT/p+3WpumRcMj1X49kk/ZN0dqNc
	au4ZVQqcl/Xyy9yIgKpYg==
X-ME-Sender: <xms:HBq9ah1TtQUV-d0VqftwnjfPNzBEgByNcq6v65pwykS2Sc1Yaq1SWXQ>
    <xme:HBq9ai5FK_eX4OcoURP9Cog4ekr_lqsgwUS9IL-ypBDZD-OR0yAZS2npCbTVL5jn3
    ZOzzO7AJ7ISk_Kx9gf5kKGJs2sQoUNE3SwgLHKP1BLWZsOqvpZiVA>
X-ME-Proxy-Cause: dmFkZTFO9aoJdGYAFwMiFNHZvjPfJF4XhBnVAqjjszrBGwZebh7Ub0v0D1Q/saFnYmAMod
    AQclZjrEg25LihAOEYrLmgLiQeXt9XPKz0cphzOuhNGB5y28xchQ0SEtjgnJbGiQqcD9OZ
    ha/HNkd1t5xA7Ev2hu/G9ahEx2nJQJt9n7XLnroyjGSLIuZRnaNpDrFToZSYp60cCWmqZg
    PvVkKoJGNvUavqLSOXfBKyHxyqfb6gXZZmFCqo6s2/lvoJPFQhNJWG1rEIxnw3owdBNzAU
    AwZFbj1UJBY+gg0GCqS9Ml4nDVkPeKmIDT6TtorU3oaQ5rQG+y29iGeTRMKeNodsMNSPh1
    8Se/9WkTO+3dwvM/njtrkLLTV6SdEDNcqO4OuNPQ8fytDhQ6Ct2qI5P56jspvxK/H+Mk4k
    sb+423cATbnK8EwvGWPkKGSZ8dI/UveyecLI/X9AnHSDQqLrLL69I88v39pDN4N9ercU/c
    648wd18PHezMmvxtvD4J6q/nOlNA9sjeQzm4dmvtwG/rF4ZuXL0K2Qsr4en0y8xgMuzVqu
    ln8+wp3Y91au2QwkfIT1q4lxZHkzVThRmUO7GJ8IU3TEv/dqdrQZcqIjX4SYPFXzf3yitg
    73gzFvZFPArzZAUbCPuD4YL0kcY6t58qvK3dgp0MXGUP/1vyyUc00db9UQ2A
X-ME-Proxy: <xmx:HRq9aoi7HmKL8dv86ZaPSS9fsG2e8AbVTSJrcqKXMo3TAxBORmrwPw>
    <xmx:HRq9au9RzFxLPl_2ExswlImbHjExKSdfLrezV6dsdQ0i89J1kWvNpA>
    <xmx:HRq9anoatsjgGzO6kcCVjIZW-pcesoRlHqB9T7fPHIREsq02M7OE3A>
    <xmx:HRq9al_NYuOTBYhMtGzO1UP_Rd7rYG6OM85p26aziX86sdJMqwgcaA>
    <xmx:HRq9aiqf6EWXs3IYSvnBONfbCQavCmH_34v81c8coasU7ZOeP8gqhKGF>
Feedback-ID: i83a1424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 4D12B22C008F; Wed, 30 Sep 2026 10:18:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AdBGhQn8Dy97
Date: Wed, 30 Sep 2026 16:17:44 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>
Cc: git@vger.kernel.org
Message-Id: <2e53feae-94fe-4e1b-9665-2a639fe08515@app.fastmail.com>
In-Reply-To: <ar0OicAaDipYx-xU@pks.im>
References: <CV_gitbrchanges7_please.d1c@m5gid.xyz>
 <gitbrchanges7_please.d1d@m5gid.xyz> <ar0OicAaDipYx-xU@pks.im>
Subject: Re: [RFC PATCH 1/4] doc: transform breaking changes doc to a manpage
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026, at 15:28, Patrick Steinhardt wrote:
> On Mon, Sep 28, 2026 at 12:41:25PM +0200,
> kristofferhaugsbakk@fastmail.com wrote:
>> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>>
>> The breaking changes document is not a regular Git documentation page.
>> That means that you cannot navigate to the doc with git(1), i.e. with:
>>
>>     git help BreakingChanges
>>
>> You instead have to download the Git project source. Or go to
>> git-scm.com.[1] Then you get this disclaimer:[2]
>>
>>     This information is specific to the Git project
>>
>>     Please note that this information is only relevant to you if you
>>     plan on contributing to the Git project itself. It is in no shape=
 or
>>     form required reading for regular Git users.
>>
>> But this document is relevant to *all* Git users. Everyone should have
>> as easy access to it as the other doc and guide pages.
>
> Yeah, I agree with that sentiment.

I=E2=80=99m glad that this idea makes sense to more than one person. x)

> [...] The one interesting question about it is of course what we'll do
> with the document once Git 3.0 is out. Will we retain it? Will we
> remove it? Will we empty it and make it focus on Git 4.0?
>
> I guess once it's a manpage we should definitely retain its contents f=
or
> a while longer. The breaking changes will be relevant to users even
> after they've already upgraded to Git 3.0. But if so, we should probab=
ly
> introduce a new section for Git 4.0, at least if we already want to
> start thinking about that.
>
>   NB: even if we start thinking about it I think we should probably not
>   release it anytime soon. I guess having a major release once per
>   decade may be good enough.

I know you are wondering out loud here to the fora. But just personally,
I imagine that this will happen after Git 3.0:

=E2=80=A2 A section at the end about Git 3.0 for historical interest as =
well as
  people on older versions who might be browsing outside of their
  installation (probably git-scm) (and who might be on pre-3.0)
=E2=80=A2 Git 4.0 discussion before that, however hypothetical or distan=
t the
  release date

>
>> To that end, let=E2=80=99s move the text to a manpage. But keep the o=
ld page,
>> just linking to the new one. (We wouldn=E2=80=99t want to break any r=
eaders.)
>>
>> Just do the minimal changes for the new format. Also demote the first
>> section to the second level, i.e. make =E2=80=9CIntroduction=E2=80=9D=
 the same level
>> as =E2=80=9CProcedure=E2=80=99.
>
> I feel like a good first step could've been to convert the
> BreakingChanges.adoc document in-place to use the new format. Like tha=
t,
> it would've become way easier to see what's actually changing. The
> rename could've then been a 1:1 move.

Like this?

1. Convert to the manpage format without changing the filename
2. Rename the file: pure rename without any other modifications
3. Resurrect `BreakingChanges.adoc` with one line that points to the new
   document

Thanks for reviewing.
