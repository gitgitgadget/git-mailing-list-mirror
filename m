Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6401223D7E6
	for <git@vger.kernel.org>; Thu, 11 Sep 2025 21:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757625503; cv=none; b=i1t8Mlsn97o9MCQFrbMvLYffMt6mvBLTBssSv5CLKEDqBotH5MC1P6qAH4uLOpQKIBtW/TeLI4JDEjP7Q9Ww2PtceDwzXpPPJ3sbNtwTspsTd0/b3LRNHvUZOE38Y6+bwIzwJI2vFYHOQ9K/+cXhEMvS68PehGtl3VJaRkLjNwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757625503; c=relaxed/simple;
	bh=kN07D55mJ4XaT8HZzb5QwuM1DVUCJDHFoHMmH/j+DrA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XXG0BV6EC/dkrWtFA/Dxbd6pC4RPQMFw8E53HuWt3jY0cqmsJyUB8kHOtCjFKOaYnNBn5wUI/Rmy+ai0/K3VowNb/fbxyaQttFAGf3M10ziL+DqLyQJ4zvDU0vvgJ/8k3b+H5hUq5Nrb2rjk5SeGhfPwigk/15WXhIWxlkGTdv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iZCq7tEu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GCDpunS9; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iZCq7tEu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GCDpunS9"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 751D51D0041D;
	Thu, 11 Sep 2025 17:18:19 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 11 Sep 2025 17:18:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757625499; x=1757711899; bh=PlWpaPs1Vj
	KmDaYIRaLJ7bUTwZD0OpG9i6oxtiLXnOI=; b=iZCq7tEu24ySkujNhd4DzjldUJ
	75KzvOI+OFM5cJopuOt3RtOnhUU1bzwKOvP42fx3+Jf1aEujHIxhIWZKoR69jwPQ
	nUSD9NyJnLwe5ac5Gl5Eh9BNNUgeRZm7Gr7xriMVdwyI6msd7AO2r0LUQUM6gXlW
	to6gtXNQbNgjbfnaDCj3zUTpMAbog3Of0qVhhH6wjbUtxtEJr0+NYE3Cr9glvxdU
	54sOs+ReTOEwx/ZBHvBCzknzP1R/rQIcOSDUeLy1zmqSAnZB1SWoWPWT3c4bgLbK
	u4Lc6jwgzqsePN+CAsmX16v0OpT5TX2GcIbCk2CC/ahhhIdau8yakxRvgkzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757625499; x=1757711899; bh=PlWpaPs1VjKmDaYIRaLJ7bUTwZD0OpG9i6o
	xtiLXnOI=; b=GCDpunS9SFp+/hEDhHd7Xwe5bKHn8Ss5lYj7Y95aMUasgDzpl7U
	xnRdYVS5GIMWadcaiNYYHv3uQw8S4aLUtrgslt9f4Xfbtl5knM3CiyeuzuU22BY/
	AF8B0LKVrrtDTXlOHM+aYoAmeYqzgWGFQlJev4gCiHembmFlvYBQxciYyJcDUX2B
	lxRhfOe5TLK9x8inSVhFtJbC34A94wx+YyUJhWILtUJ0yOyTKKLgE63NPqcPUzL3
	X6cJWHUoJit+Ze3YHnoxmRyN6+zngFtuu0Zmmf45GNtoUlWuUu9GiWnlUiROLJIX
	8Xv3KMI9V3oR8M8zyiTxxOyf5xf1f0jMNng==
X-ME-Sender: <xms:mzzDaCXUqq87Z6jjrhkXp-UQzAartj3WzCD_MOWlmZ8WA_7aHz39_A>
    <xme:mzzDaJKfW1y9jEjv0WnQidV_qgBUKOFFlXVReolhyo_Zl8m6iiCxiczaO9-CU3s3u
    Q9igrapxfNGX4hqeA>
X-ME-Received: <xmr:mzzDaC8rGDRTGqNlWurv8QX_WhRE0JYJ607vfJvGzFiQXPPzRV4963M_wDTMYFWMk5YlIk1PStDT81ZBMIZDTjGx_TlRPaViHpuQXYI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvjedvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeejkeeujeegteevjeetgeeileeujeeijeefueegieetiedtleffvdffheeihedu
    feenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhith
    hgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihhrthhhrdhhihgtkhhfohhrugesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:mzzDaMLSqyOHKs4zv6_d93GDl2WFs3xl8sIdmyulQ5m061vlH2tkbA>
    <xmx:mzzDaHlW8WS7fn0QYujnaTYgQ53Nx01iLPu494xQn56QEgOit1f7mA>
    <xmx:mzzDaAOb6fujQX3OX8YAdNJWa8s7y0PmAWSXRZico08SlI9cuQbflw>
    <xmx:mzzDaN2YrL-Ov6WGQq2ek3OUMcjautfK3d7vezCr3k3n2pum36R2tg>
    <xmx:mzzDaLmJjH-Reae9o6LaC1mMvW2FUzaKmaa0wqlgZzszu4sgnklLWYfv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Sep 2025 17:18:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH] libsecret/Makefile: add install target
In-Reply-To: <pull.1970.git.1757623086030.gitgitgadget@gmail.com> (M. Hickford
	via GitGitGadget's message of "Thu, 11 Sep 2025 20:38:06 +0000")
References: <pull.1970.git.1757623086030.gitgitgadget@gmail.com>
Date: Thu, 11 Sep 2025 14:18:17 -0700
Message-ID: <xmqqsegsofhi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"M Hickford via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: M Hickford <mirth.hickford@gmail.com>
>
> Signed-off-by: M Hickford <mirth.hickford@gmail.com>
> ---
>     libsecret/Makefile: add install target
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1970%2Fhickford%2Flibsecret-makefile-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1970/hickford/libsecret-makefile-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1970
>
>  contrib/credential/libsecret/Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/contrib/credential/libsecret/Makefile b/contrib/credential/libsecret/Makefile
> index 97ce9c92fb..6fe70065ab 100644
> --- a/contrib/credential/libsecret/Makefile
> +++ b/contrib/credential/libsecret/Makefile
> @@ -26,3 +26,7 @@ $(MAIN): $(OBJS)
>  
>  clean:
>  	@$(RM) $(MAIN) $(OBJS)
> +
> +install: $(MAIN)
> +	$(INSTALL) -d -m 755 $(DESTDIR)$(gitexecdir)
> +	$(INSTALL) -m 755 $(MAIN) $(DESTDIR)$(gitexecdir)
>
> base-commit: 4975ec3473b4bc61bc8a3df1ef29d0b7e7959e87

Hmph, the existing make macros used in the Makefile like $(RM),
$(CC), etc. are all defined in the same Makefile, and the only
things this Makefile includes are config.mak and its autogen variant
if they exist, neither of which are the source of INSTALL or
gitexecdir that are used in the main Makefile by being defined
there.

It seems that existing Makefiles in contrib/ like the one in subtree
and contacts, all define their own.  Perhaps you can mimick them by
adding things like

    prefix ?= /usr/local
    gitexecdir ?= $(prefix)/libexec/git-core

    # this should be set to a 'standard' bsd-type install program
    INSTALL  ?= install

that they commonly add for now to make it work?  Without anything
like that, I cannot quite see how it would work with your patch
alone.

And then later we of course should clean things up by splitting the
definitions done in the main Makefile into a common file that can be
included (e.g. path+tool+definitions.mak file), include it from the
main Makefile, and then have contrib/*/Makefile also include it so
that the duplicated definitions like we see in Makefiles in subtree
and contacts (there may be others; they just were the first hits in
my "git ls-files | grep /Makefile").

