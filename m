Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7090710785
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 17:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770917112; cv=none; b=XBA2BifiFnZap9w7Z5mWXU+J/lpXwiBz1xI7LwV11VjPErlJ2E2SMoq9ESi5RmiXJQqnU338/F6u8AdLivh1HKkzWHG8RS8s4uwBvkQPhS0K0gcVbLXh7+tNz3XyAcRDzE5mf6e8ameIhuQGVyx7bP/VncjxU7zzOVFIffMAEfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770917112; c=relaxed/simple;
	bh=gFrhc1dQFwzS3Gp1rn/5xQ1ZWfJkgU5mhhXEp4dy/2E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SFSVTf/XUZNIuIx1xKwR/LVUB+vNNfDeBIynqEOPcNqRX+P1mLKS0VRnGPybY3PnT+kf5NphDVclrJdE7nLujan3NfWNab1CZgQkIow5DpdL9cJVlbRLWf4iI8WJ/13+1w0JMJfEqoQsizaeF92d83Pj1/9/thVHCgLj3HTi5To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pO06RYqT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=crsEyzOI; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pO06RYqT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="crsEyzOI"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3E5767A014A;
	Thu, 12 Feb 2026 12:25:10 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 12 Feb 2026 12:25:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1770917110;
	 x=1771003510; bh=Y8m3FfBEhUitmP/fPVlY0HXziy0GRgTbNxxy6p2xsvU=; b=
	pO06RYqTR7OxpiT0kLFtFIUbxZQQcVyz8SuapwzkryKpK8CMZFHpBH21ilgqA0OL
	kN2b8c54nsszXrWqCn8AjbSsuUm3QmrTujlpFB/wom6xwiE4obS1HdJL65pA9rvy
	DOvP1yh8irVS8SK7zYiodMegsPcKmcU3cNxnvpehIiSkRElwWvTuEcNYmdQL7+JL
	f0hqcaTovKN2/aI0bpMScHODrhpUfKQKNDnGs+S0/TzZpXKe54wewtPeW8w4NZs3
	X122n+pyakz8NwJwIWe5pzLEaix8icwO5kvNDsTON6Gz9NHFdDxT5bPeRAtN6cUU
	G9ijPg9dnveUOjvl5Es+gQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770917110; x=
	1771003510; bh=Y8m3FfBEhUitmP/fPVlY0HXziy0GRgTbNxxy6p2xsvU=; b=c
	rsEyzOIdwzhOxbD54mGS0Mh0LNxNVxXuhH1pQaui7sFP7fuV89WL9EOLors/nEIa
	HqmoFSTtJoDEVi83qZpv0F+u24z86QdQUTEc+zXh3+mv7zxGVarhwwfBIsV12ody
	IKR82ELsKHHhJ15sac6snTudVpl5E24qvw4callDqrrDO6uf4pkQ8fpRDsN0PWio
	WJfXgF01J3nsZhf0902cLoFpErYa38bRLptF9Lw8ju2FKqtJWrlF4ZZXTvn7wD6r
	oHB72Cz9U/20V2G7MWeyWDJrFpepEa/OphuSSKsqGTDPCWggmx7UHW4NWdnVceUi
	A9467R0vOQCJYOVsM1rpg==
X-ME-Sender: <xms:9QyOaRhkxm14OwplHzQyZgwhHJk8_K6AhLSHfS-Qhz3yfflYFp2Y0Q>
    <xme:9QyOaSkVUolnclRyl5_52BNGBer12Md03WFnu6v6zHzshVgMVxNnbrRT8wI89LFEi
    cVD6KQy_7DiTrw81NFLu1HnAAvlnlI6C_uHqU31VeRfd7JsTsCMJQ>
X-ME-Received: <xmr:9QyOaVgRaLo66mMpTu7cxS4BNhzNH7jksxfL2ON4QgkekI49QiESGhwsnTQawQfE2pmK-UqWDSb0vMm-xke0g38G_8t7aECjqg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdehleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopedutddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheprggsrhgrhhgrmhgruggvkhhunhhlvgehtdesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehphhhilhhlihhprdifoh
    hougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshiivgguvghrrdguvghvsehg
    mhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhes
    fhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:9QyOadFzeVtPeU0-EcrZUsyCedI4lLzxUQtfSRJHBsBmSoll7wDPMw>
    <xmx:9QyOafvtjW-h1jJju05JEJoWwbxXsye81Ok2FqdSESyC8eWVT9UG8A>
    <xmx:9QyOaWdNpOmfdxkw8lDGIIn50KW7oU4CHHC-vknEKQK7baZhwQc7BA>
    <xmx:9QyOadnnM1n3F0e1GWijs4wXDVSm5S47t-vMkIqDFTtwqPBtEdglLQ>
    <xmx:9gyOaZKraq8EO85K2_XXwY52USM01PhWwEY5cj-IE2ng0enrrRUWSWg0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Feb 2026 12:25:09 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Samuel Abraham <abrahamadekunle50@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Phillip Wood
 <phillip.wood123@gmail.com>,  SZEDER =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>,
  Christian Couder <christian.couder@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Ben Knoble <ben.knoble@gmail.com>,
  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 2/3] add-patch: Allow interfile navigation when
 selecting hunks
In-Reply-To: <CADYq+fa81Uki0ZVta80VO=-UG-f+Z8GAyzom-FLNXULartwwXA@mail.gmail.com>
	(Samuel Abraham's message of "Thu, 12 Feb 2026 11:32:29 +0100")
References: <cover.1770390576.git.abrahamadekunle50@gmail.com>
	<24692afa3f0a67d3f3eba776cc745287c5d71e94.1770390576.git.abrahamadekunle50@gmail.com>
	<xmqqikc9ekzz.fsf@gitster.g>
	<CADYq+fa81Uki0ZVta80VO=-UG-f+Z8GAyzom-FLNXULartwwXA@mail.gmail.com>
Date: Thu, 12 Feb 2026 09:25:08 -0800
Message-ID: <xmqqtsvlq3gr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Samuel Abraham <abrahamadekunle50@gmail.com> writes:

> On Fri, Feb 6, 2026 at 8:21 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Abraham Samuel Adekunle <abrahamadekunle50@gmail.com> writes:
>>
>> > @@ -1566,11 +1589,14 @@ static int patch_update_file(struct add_p_state *s,
>> >                                               : 1));
>> >               printf(_(s->mode->prompt_mode[prompt_mode_type]),
>> >                      s->buf.buf);
>> > +             if (s->s.no_auto_advance && all_decided)
>> > +                     printf(_("\n%s All hunks decided. What now? "),
>> > +                             s->s.prompt_color);
>>
>> This gives an ordinary prompt for the hunk and then another one
>> after it if we notice everything has been decided.  I am wondering
>> if it wants to be more like
>>
>>         if (!s->auto_advance && all_decided)
>>                 say What now?
>>         else
>>                 ask the usual
>>
>> ?
>
> Hello Junio
> Please just a small curiosity.
>
> If I do it this way, the user will not be able to see the options available
> once they have decided on all hunks and want to rework the file.
> The options for a hunk will not be visible if they navigate with say K or J
> and want to change decisions on a hunk.
> They will always be greeted with What now? without the available options.

Ah, OK.

But then after deciding on all hunks and not telling the prompt to
move to another file, the user will keep seeing this extra line of
prompt?

It somehow smells like a waste of a whole line just to remind the
user that all hunks in the file have now been decided.

There was a separate topic that added "(was: [yn])" to the prompt
when the prompt asks about a hunk that already has been decided on.
As we only need a single bit "all hunks decided", can we do
something similar, I wonder?  At the beginning of the main prompt,
we show which of the N available hunks we are currently at, e.g.,

 (1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?

Perhaps we can add a third number to indicate how many of the
available hunks the user has already decided, or something, that can
be used to avoid this wasted line?  Or is it a good thing that we
are loud in this case using a whole line to remind the user that it
may be time to move on?  I dunno.

In any case, even though I am not 100% sure that this design to
devote an extra line for this single bit of information is the best
one, I now understand the need for conveying it.  Thanks.
