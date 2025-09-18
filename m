Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E232926AE4
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 06:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758175390; cv=none; b=OHOEI37FOmdJZx5YFFyo9gICFxufA0m6H7QnbGkVQwIfFbOgEXDaS/f0iyZiiGCJO57Qu5tJJHQE0xwz13JvRevP2w60GYYehmn5N2JLtIv+q/5WJlBWXn11lPSTp9Ba8C6lpwlEkATO3yKgjk3kKP7a81vqZEIiRlGLCJ41Hwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758175390; c=relaxed/simple;
	bh=Xb3XSRAHCbw0B0s23BqEjDTZWS6pR6uIGiL5Z+U7XCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ieKqlCr1LrAJXz1eXY0ZP9rxnWEsnUQMvHjK11ButRC9ECxkZhsa8Stof2M4IIbnzoiBlrS5fjrRD4twhWDQ/rT6m4Pm7KjwLfWbW4J4wSXXyUqgshS8xFtTo2UqORxQGwp9a7UBO59mHBVcU+7yrShU32FnL6Lc49DNEJcfBAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fIYBPFyr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XrT4ODkd; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fIYBPFyr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XrT4ODkd"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id EDA31EC0351;
	Thu, 18 Sep 2025 02:03:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 18 Sep 2025 02:03:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758175387; x=1758261787; bh=+HVEVYR8CR
	iLgopBJoOr+9k0zLFoBlU5gePPcF9giiY=; b=fIYBPFyrG0NkkuKIszxcdTDtW/
	4ppyGFm+rtaBbllrEFHDcbtv50GoSJdBoQq+E3XPie64yHDTI6pvqUlgs6wjjdiJ
	f3FRmQ8NcK2nWDwguyv5dmjGaf/6+syS0b0vSzqDqUUZTaztt4WQHlxugBdYNtjV
	qHx1mYAJsUVl1C6ZEfR0LEwO5KoeqdKOZ1iabU9Dj98gi/rEGLNvOODMHC9Z0I7n
	OP10CBI9edaIjg8dpnSeizaSvZhXu9XHegvTHf2miXk9WXt/IlZsgWDFY+NilscT
	rWZqtOod/Ll0RU0S9OiCJlDLTcsTmhlEMsqJXWyY2sQobzJUjL5LkQZ5WX/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758175387; x=1758261787; bh=+HVEVYR8CRiLgopBJoOr+9k0zLFoBlU5geP
	PcF9giiY=; b=XrT4ODkdXdyzdOGc9N14daibEQu9enyKS1Tj+tN2Cdx7BpguwcS
	ecSqU9zpOWSZSzp+Q+Y3SuRlM9Q2EdORrE/cmWS7F/tBHRFY3XgWP38XvRd8YmWT
	+R0VtvsMj7ueFJYQIEPtecALcpPFjmL5uePWkCmKz/x7LePHwaFHBOoPXqQHSpwu
	ag2vKVKRf0v6o/eYwOkCkxxZEIORqLphboTRdbQIAydMlN2iKLMimnjkAvDgfRDx
	EdU+nWJF0h8I3VfEqRv86yM/GEMI8gZOvjLOalvS/OCHPjUSJeyst0BVufYmLlY2
	kAENdRni6Rrrl4nt8N6eMaQbeLnINOkRqew==
X-ME-Sender: <xms:m6DLaKcE-2fvlfC0SaYIpXXYrrKi7vsvKmRlHmjW2xKPl4nAeHzhVw>
    <xme:m6DLaOwS7VXQuW9mWaOEjLlN-VCH6M-sR_jwBGD4bG0t7Jh1O6jaKlM8rriwDbzYg
    8PhTVuq1NPgQ9fCEw>
X-ME-Received: <xmr:m6DLaIEkoYfSbS_1_ajsy134hNhmnd1QtMv7cqJAtmC0J6yC8esbwz9wjLm874EgxDSeyY-yAO24UQM07Rf2baS21jx5V5wk1tlH5KS1HA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegheehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprh
    gtphhtthhopehsiigvuggvrhdruggvvhesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:m6DLaKymlbhgypTwdLUTBBAcRgtlbYxG8kNm7FoIhLMJc4xqYjoEWg>
    <xmx:m6DLaBvNnCgMhEynRHkKe22YH2MPCMYQypDj1ibiO7CwtIe0v6PseA>
    <xmx:m6DLaP2p2DFY316RkwF2MR-RBJMejQ7VMO9nCiLexu-B_6fO0lyZDw>
    <xmx:m6DLaE-VYhilcFrMU7plCV70OtHif9m5JWoysKtWYWFyQCCCgAkQuw>
    <xmx:m6DLaIud-QntFDcSVVG72o-JvIWi-emGHYU_GeDzNukX3uqo02CrAv2W>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Sep 2025 02:03:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ff27742d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 18 Sep 2025 06:03:05 +0000 (UTC)
Date: Thu, 18 Sep 2025 08:03:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2 5/5] builtin/config: do not spawn pager when printing
 color codes
Message-ID: <aMuglu_TtQPht1xP@pks.im>
References: <20250915-pks-config-color-v2-0-e4290bd8d13c@pks.im>
 <20250915-pks-config-color-v2-5-e4290bd8d13c@pks.im>
 <xmqqikhjhbgo.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqikhjhbgo.fsf@gitster.g>

On Mon, Sep 15, 2025 at 10:28:23AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > With `git config get --type=color` the user asks us to parse a specific
> > configuration key and turn the value into an ANSI color escape sequence.
> > The printed string can then for example be used as part of shell scripts
> > to reuse the same colors as Git.
> >
> > Right now though we set up the auto-pager, which means that the string
> > may instead be written to the pager command. This is of course quite
> > nonsensical; there shouldn't be any use case where the color code should
> > end up in the pager instead of in the TTY.
> >
> > Fix this by disabling the pager in case the user is asking us to print
> > color sequences.
> 
> I am of two minds.  Part of me obviously agrees that it is more
> straight forward with this change.  But it may 
> 
> An interactive user experimenting while writing their own script
> might say something like
> 
>  $ git config --type=color --default="reverse red" n.n
> 
> If the command emitted directly to the terminal, then everything
> they type from then on will be bloody red, but the pager protects
> them from such an accident.  Instead, they are forced to say
> 
>  $ C=$(git config get --type=color --default="reverse red" n.n)
>  $ R=$(git config get --type=color --default="reset" n.n)
>  $ echo "So$C Bloody ${R}Red"
> 
> but these are likely what they would be writing in their script
> anyway, so...

True. That being said, I'm mostly trying to emulate the old behaviour
that we had in `git config --get-color`. We have the following condition
there:

	/*
	 * The following actions may produce more than one line of output and
	 * should therefore be paged.
	 */
	if (actions & (ACTION_LIST | ACTION_GET_ALL | ACTION_GET_REGEXP | ACTION_GET_URLMATCH))
		setup_auto_pager("config", 1);

`ACTION_GET_COLOR` is not part of this condition, so we wouldn't set up
the auto pager there, either. So I think it's sensible to match that
behaviour so that the new command really is a drop-in replacement for
the old one.

I should probably clarify the commit message.

Patrick
