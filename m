Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EFD364036
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 18:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772215500; cv=none; b=oYHLe9E+2fF1Wk+n130dEyNwv5kHM+eaG+gc7qjhX03jOBVSGk8/CvIVbFHVwmGWJMluFvlonguAL2+ZvGsokrEkxpSJ+r2PtlCW3qOwIlDQ8hV/SEAFz3AB3xerELicEhAOvH1OlIZIsqwq3max6ZZitfZpFS3jKHDbyCiSLLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772215500; c=relaxed/simple;
	bh=IdOFq0luQYiCExtPteksS+vyZFSZG8IDA/LZV4epm4s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hbU4nWPDB+qkSUT/aKj8XtrJtKGYl5rT3VOD591I4qFBKRZHRdnf6IB1Fah2J3JLHc6A0/l7aK5QasXTvcPwOA0xZt0XMtm0XfGOGuaXcu5lcP7NgwNQl3S6AlV1EiIwONprTudWzD5AypKCCnsrn4e/g029W7Q2DWBNSy3I4qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dAH7fQjk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gl6ihucq; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dAH7fQjk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gl6ihucq"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E09E67A013F;
	Fri, 27 Feb 2026 13:04:58 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 27 Feb 2026 13:04:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772215498; x=1772301898; bh=4ApabPhiI7
	vdKI7HcgFV90BSwA6sP0XMtt/wv0Qi9zA=; b=dAH7fQjkZ6Su8RPGuGrxxegfZ3
	I3dxVeLTcehm1eCl+Utb0HCY5d8IerVG1gWLN4xFz1pN2EvHLEA0d1prBaS06ykj
	XKhk+zUfjS7EodhCciGiNCiMTx236rT1/2VN/mulWyGQXGW570ZRxpplzLqP3u5t
	tOnxxYsYq8tVmB3LYBqaFeKawZ97e4Nnm6FFPCL5k6odbANuFR89P79Xa9RaYDk2
	AOoMhPViKB1QvBLWPA9Utyk0oqTMU4mjIsHH+N8bYXayjKTsP6eHgtRuWesKD9Oh
	ftzmhqgs6m16Thm7bOmYxMI/Chge2ySDi2g2n1hz8i5KMb/OWEGWWl7QpOEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772215498; x=1772301898; bh=4ApabPhiI7vdKI7HcgFV90BSwA6sP0XMtt/
	wv0Qi9zA=; b=gl6ihucqzucpNUl6FNKAtD4QW67JJwQI34Vuo95QDxnVvrTEkhx
	cEbA6/8NN5fgvH6PQc8oSIH1AuWU36VAKWycxJ2MjClcRKN5Kxm99QcPctOopLsT
	NimQDB2r38n+dFJCMsldcCETeS516NzIhdfaH+ILfKV5U0563H15TkPH8PKtblrF
	UVmXycJ4IdtfJjYWsgz2ZOzQ9G9dDCc5MvwSfz/nxENgjMTzsDxZ0gPaV0JsR/FH
	UhSM8DK03v5XNN/At//jBj0QmcudtODm7R5S6ZquIi5AmocaFb9FfIOfJsn2LrIj
	0QOKZXrwnNCr64HzsxZhUWhTuVp5LnMjjnQ==
X-ME-Sender: <xms:ytyhaWirP2BEU8vmwWGD5NyFl711ZDYb4OBy1H5eI-2aKJ_G3An4Cw>
    <xme:ytyhaedizRSXYB05vksoM5QToMtxThlbozRbEFW5Dc1p3_jpZq3nFTvY_SX3KGhlO
    EYfCyIPITRIgGB_6ID4ta8AIDtawoe1t_JwyDwmkPsym5whfWmyulw>
X-ME-Received: <xmr:ytyhabeuwBUYcfbXpjcc78NQKdSlmyaEI3ae9SghgstCwZBsjVv10FBNk0wPtdzrhnilAs6UhHMoux89_XoQwilES3-fVRbK9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeelieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlohhrvghn
    iihordhpvghgohhrrghrihdvtddtvdesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:ytyhaY9RgQsfVLgUNW8QBamYRDrDB7JIJcyVTdeD3PBvwQ8zHt6GFA>
    <xmx:ytyhaXmvi7GZ46uQ_FH2xF8kZ-iUGHwjZ468J9NIJwgRL2gl8hzieA>
    <xmx:ytyhaa_tPdTiPVW1odz8t5WZckjcMG6_Pxb0tvjz9MxXQ4NUGDpjHA>
    <xmx:ytyhaVl3EE9o3tPJuXP2QbnEmLj1JKwYOQ0lFNiIYSKoT_Df_XN1mQ>
    <xmx:ytyhaecTNkfvoOfN5ynGtm-dEW6GxKsMzJzTsZK1nIDGBSfVkIvxn5h->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Feb 2026 13:04:58 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [GSoC PATCH v2 0/2] diff: handle UTF-8 chars in prefix when
 calculating diffstat width
In-Reply-To: <cover.1772136203.git.lorenzo.pegorari2002@gmail.com>
	(LorenzoPegorari's message of "Fri, 27 Feb 2026 17:01:07 +0100")
References: <cover.1771894207.git.lorenzo.pegorari2002@gmail.com>
	<cover.1772136203.git.lorenzo.pegorari2002@gmail.com>
Date: Fri, 27 Feb 2026 10:04:57 -0800
Message-ID: <xmqq5x7irrjq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

LorenzoPegorari <lorenzo.pegorari2002@gmail.com> writes:

> This patch aims to fix a bug where the calculation of the diffstat width
> incorrectly uses the strlen() of line_prefix instead of its actual
> display width.
>
> This patch addresses the NEEDSWORK item added by ce8529b2 (diff: leave
> NEEDWORK notes in show_stats() function, 2022-10-21).
>
> V2 DIFF:
> * Changed references from "ANSI char" to "UTF-8 char"

Is that correct?  I thought these references are mostly about the
ANSI color escape sequences that are used to paint strings in color
e.g.,

    printf "This is shown in \033[31mRED\033[0m color\012"

uses "\033[31m" (use RED as the foreground color) and "\033[0m"
(reset all styles and colors).  The problem the NEEDSWORK comment
talks about is that the code uses strlen() but these two sequences
in the above example are 0-width as far as the terminal display
width computation is concerned.  And that is why we want to use
utf8_strnwidth() with SKIP_ANSI bit on.

>  diff.c                 | 12 ++++--------
>  t/b                    |  0
>  t/t4052-stat-output.sh | 30 ++++++++++++++++++++++++++++++
>  3 files changed, 34 insertions(+), 8 deletions(-)
>  create mode 100644 t/b

I doubt you meant to add a new file there ;-)
