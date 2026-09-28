Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99894E5351
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 15:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790608583; cv=none; b=BIx0/rDCjq8m+kYm+aiNOviJ5MyPSghM8tjjsUM3qoaRGJjfELnSq3h1YM1Jh13etUOQT4Ee3Q1Kg0v9XiKIYrr07CFOGzdKUfNMQ0DYz6fXFYE02ePuYjIy8U8tpOfKTuAGvZEHy0gF8RSFkdKZBNVGgy8SQNYLVNJLd6k1lYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790608583; c=relaxed/simple;
	bh=kA61DRXxlv3cWiGANRUkdGkQ7XBjEoIlH2VWM3tu/JE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hh1ivH5FuUPnumFCiDPgjthA49lTuwAk9Jl5Am2UPGelGsWjxSu7GltnR39E9qZ1eNUlheM9gDLEKDJ1SaXjNZ5SqCcXUX2vpOPwn9HnhJVebscXWC6uQjR4YQwRb/u1/y8K8DJHNSbmhHLb7Y6wTdSZwuF3vfPHN/HA9mEqHX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XVART7KM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sDemmnfW; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XVART7KM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sDemmnfW"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 292A3EC003B;
	Mon, 28 Sep 2026 11:16:20 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Mon, 28 Sep 2026 11:16:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790608580; x=1790694980; bh=jxwySHrmjw
	t7yZZYxU9YM5KTWwQVp76YQDAQUAzIkbc=; b=XVART7KMTIR1+FlstY57prGlNn
	EPe7YZrE5yoNO/QuhN8pZm3Ti2szophqXpzxGpk6Rmkc+aL5CpfXYgN2Izmq93Uv
	KTJzxJhUTAVZzHCmwNhN69RaOEq/gGPtV6AIc916cuT0uirdLjL08HCkCmiVL2C5
	hx36iEY2K2JtHthsQsNq9Uo9RnIXd8s6DoKChRVWkpzgN07koxcLTJHaVMVrkrCB
	k0nUyH+sdiqeYm6YRX7K7fvt4E1EVygBDFZ/SntD3amExUAsptNMyfDurRtuTjut
	QJHRHXaK+rlGf2GNfprOqFh3vTaisNJbyBE0Xv+IVRSLhF5Yp+THpdPFhqSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790608580; x=1790694980; bh=jxwySHrmjwt7yZZYxU9YM5KTWwQVp76YQDA
	QUAzIkbc=; b=sDemmnfW63Zy8Z0LhxzYHfs8y7PgoQqNyWDjB1hlbf58Cz/bnQ8
	eBI3nQR+GDKlzD1SMQFwzYd6Ggv8SmRZqmBkPvPQuhFNRm/V330NR5FtUVjJPzIN
	Xf+JfW7LCHgoapy+V5j4/S0YV92BA3Oq/dEDQaPoGWJXqfIuYavzU+a6WvW9IXV/
	8uC8TP9/3u/1XWLERalXlsi70iuZeZUVlsca1c8K04LRwaakuIFyssXkH5EE95Fg
	PT1paa1ztlQlgIOCClR5xHzb+ADbkNPa6FUcnxRraft2N426ofmH7xCAnEkoRdAu
	e7CCTgKASHhhJ6MAJGOepLcYrl2kKPZ5+2g==
X-ME-Sender: <xms:w4S6ahmEJBS-DP5QjIgaUbCb4-yfkuJrtZw3IFSnT9BFSrTx8RPSew>
    <xme:w4S6akSsGIlf28npZbfHInrvKp8wrRX8BJ7uZbVqLITKuG5E4lNvri-UMCC1fklxx
    2KRHaRiim453UQlTU6FUdkEn2NkFmDQiRTrrHCsqcNkvHETphc3ezk>
X-ME-Received: <xmr:w4S6alB5dIViVmLQz8CHhSB7OlCiacNYvDrl-4O-WZ-Frim0Cb94r-pkPohQifcmAPtcGXCYWF3SGSAcJyqrklKJrKqkKqggbYUR>
X-ME-Proxy-Cause: dmFkZTFFaSJJsRgd3iuj7OJLorY8T727pPp2pgp4fzaeIEHhKD33LjCxFhrXT1zY2ntCx+
    9hjKYmjNXaQ91HBgABFxMcFVuNg2rO/g3Goq76eKAXGlkcfICSoV5fVniMUxJKsarStqT9
    IARJeZ7zJ6v8IfTMaM2pWBnZTiRk2zdukZ//4I7m5yWUc3djnph/2nmp7FXKvWnObIj8SX
    CTAgWF6y3kqQ1ddzxQf8aZQK+FSswqLwuMB8JEWl8MY+Tenw8/OQuLWdbWQf7ldPat5q7z
    9sSMbCZeKIEgDI5k26bqFaEKDxzdo5F/bmMv7XUfJC8Xkd9O6sbdYoA11u8Z2wdnTAztje
    xM8bLkgp9k8qsxShE8ipnZfw4yL00KZ9wq0IcGG0uONzRV3Ce2DtIVAmsI4adL9g8n6cDK
    jK+XvapanM91Yf83pNPlmMBTgwvTJZFt9X7xtgi468qk9/fGo8TiDG78CgGEAehnDk1QaY
    +t7WBIr2TbMWK/LOiaFdjW1tKn2NTEUJydg3D7oYWPMWT9yy2cQDF3xOXUvHJAR+U9pcSv
    YwAtGsmimzjMMTth8T3Zpdnbnm/PY0paDGwj351piv28eYYZSfG0QU5zVig9MOCLDkG505
    DQos7+Sft7n2xvKOvscIOgyNZv6Hg2fKl2iQeUFDirI5NLq90nuVzOXTEEPQ
X-ME-Proxy: <xmx:w4S6arQKIJZpsD29XFGBFOZGC6VWzlYef3A4iRk0B-c1sq37o5f2WA>
    <xmx:w4S6ajrCkxXgTnLbXNTmjHOb961RhTWI2P7e53gxiqDwISPvce204A>
    <xmx:w4S6atxPc1R_UugDz2_8pEHdud4ret-hVPx5lbqK9aVuIWhirEVySQ>
    <xmx:w4S6aoKye2O0Bz9aq0e_1MsIYxaq7xfTfRCgaIfJMk6Aay_axaJ9jg>
    <xmx:xIS6akaME8p6zS6vxxYIEvW5sensNq3Y8Q4Y-NxVjvKcGyzRDMm5ms99>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 11:16:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: git@vger.kernel.org
Subject: Re: Rewriting the Git tutorial to cover less content
In-Reply-To: <7004c3b1-2100-4a90-9815-2a679ceb25b2@app.fastmail.com> (Julia
	Evans's message of "Mon, 28 Sep 2026 08:21:11 -0400")
References: <pull.2416.git.git.1790105342890.gitgitgadget@gmail.com>
	<pull.2416.v2.git.git.1790297546771.gitgitgadget@gmail.com>
	<20260925082723.GB1493716@coredump.intra.peff.net>
	<bd5d9451-ac5a-4274-9a7a-57ae99864fe9@app.fastmail.com>
	<xmqq7bk9wa4y.fsf@gitster.g>
	<4c9f0480-768a-48ba-9753-b4d34188b1a1@app.fastmail.com>
	<xmqqh5jdur4c.fsf@gitster.g>
	<17c46e4e-a4f6-433e-8eea-c1e4eb28fdfd@app.fastmail.com>
	<xmqqv77tt9a4.fsf@gitster.g>
	<7004c3b1-2100-4a90-9815-2a679ceb25b2@app.fastmail.com>
Date: Mon, 28 Sep 2026 08:16:17 -0700
Message-ID: <xmqqh5j9o18e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans" <julia@jvns.ca> writes:

>> Dealing with broken links is easier as we can just remove them.
>> Noticing a link that points at an unmaintained stale document that
>> describes what used to be relevant but no longer in today's
>> environment and replacing it with something more relevant was what I
>> am worried about.
>
> Thanks, this is helpful. Let me try to rephrase to see if I understand,
> let me know if I'm understanding wrong.

In the above, I was talking about the reference links that are stale
at https://git-scm.com/doc/ext which you mentioned.  You said that
it is easy to update broken links there.  I wanted to point out that
there are two kinds of staleness, one that you can validate by
clicking on the link and seeing 404 (your "easy" kind), and the
other that you have to read what you are given by clicking on the
link and evaluate its relevance in today's world (which is much
harder).

So, while I do agree with everything you said in the two paragraphs
below, I do not think these two paragraphs have any rephrased
version of what I wanted to say ?-).

> When possible, it's better to split up changes into smaller pieces so
> that they can be reviewed more easily.
>
> For this change, it would help to split it up into two different patch series:
> "remove tutorial" and "add new tutorial", where the first patch series
> deletes all references to the tutorial. If we do it this way, we can
> both make sure that there isn't any content that we regret deleting,
> and lets us take a look at the documents that reference the tutorial too.

Yes, feeding smaller independent pieces is a format that is easier
to review.  If the end result is that the old tutorial is gone and
replaced by the new tutorial, that would be what we want.  When we
added gittutorial-2, we did not remove gittutorial, probably because
nobody had the guts to say "let's rip out what Linus wrote, it is so
out of date and gives much less relevant information useful in
today's world".

I do not want to repeat that; it is like https://xkcd.com/927/.
