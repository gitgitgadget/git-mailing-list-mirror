Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DC21A6810
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 01:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772501178; cv=none; b=anaHAon3dIRZmd4UAwWZ3b8umBr0LYE237czceJ8bVn+lwrVgBaBQ/Qn32Bk27GbzUG7Jphgml0+sw8s4P4khqw8DYo56bzP0043LodhuLrx9v3esFrvUTaKOWaUohG07KvO5UnKA4XNpXxMpW4RTKrraGdrQD66Ii18cxuw+NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772501178; c=relaxed/simple;
	bh=uGCxP1wymiRT/ThCvRXAsuTU2UlCdfDFIzIIIjAL+Qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T4y7itytGk2E+17lMnl3NaPfb1o3r3FgcfVY1yit3Q+5C7U6PIiqWX/qwFtNTA3v/L3HvxlGfq0bEC3ncG9KDX29F87VWFhM7jcSqmMrTR2Zesv8j8AvkIpOtjqVdpgHubrcPR4QbTtHyYoJ3SC+AMEbvMfgh2lteeibZ3whaOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a7U55KBw; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7U55KBw"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48375f1defeso38131775e9.0
        for <git@vger.kernel.org>; Mon, 02 Mar 2026 17:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772501175; x=1773105975; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zTs8nLrArx3FysH1kyP0z9ctw6WrSVeiU5xZXhf/BnA=;
        b=a7U55KBwtp98jYkolrBCrDBQSyLTJ6r+KJ6UtfWeJdIQVTEqRvXnv85kW7RcIsCpU1
         jquKTA3DLedvi8aUyVXj3n13Hh9U96K69hdyCUz5lOGOXCr3CPWrSVtzZtIQAOnz5W3T
         RuO803UT7MUD5NXL8bxex8ftRomZJoWZisMzIuC6cVso8xAFLBNfiBUfJopGQjJ/BFsp
         6lbdYDds4QbChHfdJkLZzA7pmiw6zkKVv07lvA4mmYmPTLVZFu/8qaxR1Zx5YgyXkF2E
         2hF+DBUECX2a5pGhqfBfqcdcSnhOlhYiVyUFp2bLBzJUpRrvdZceNWLTn7kQlpF+9SQR
         AcLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772501175; x=1773105975;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zTs8nLrArx3FysH1kyP0z9ctw6WrSVeiU5xZXhf/BnA=;
        b=N7Ly68VskTeLmXp1s6cAy1KKoXS4P0fZjsSiWGZA0NnmHhohfr1oNqwxQyo1fiVbFq
         LSdnQYnCNO2iKa3ZLAbeMxuPmdBSLn+wuUgJbcL60/ChKHLk02c/8bMezDDhWOSHqIEJ
         Td8ZpBXzkN1PxHspGBMW2/KuDTAKzoQqiOo3CX6lHqNV37ZSi3MxTVxyg3zytAgJQV9Z
         qzMAgOCBQUbrAFbVfJiOYIDUZ7zQo3EI2/OoS/DeonG/eg7ArlosH7P7S5VVko+Y5NJ4
         um6Jsf3VUc6v/dtOt58KOz2P/75727v+DwLNUoX3lk9qdsaYYdFauZg5WIrT8o+RrEEi
         Se1Q==
X-Gm-Message-State: AOJu0Yy2+oTYd9b1JsnlG5iFodNNX40eIYM/9KfjGD24szGT9wMpbw9w
	NLRNZhfny+90D0B+Q5Z2ZVlhRmnE46eTpL4rMEWAwWOW/j1TlO2U1HIdyBaVew==
X-Gm-Gg: ATEYQzz5C5obmXivEs+pnGZB+t/4kua1WysID/lI3Lg0LAPp8w8t9QuevdwkLhGORBZ
	2upw3pVQXfAzYpOUMWXMulLLRQ33A2E8PcP5Co/FVlHqUHh+hPzV4yAxqVJcgYGBw1uX/ysGQSW
	oPkeQaZ+I0pAi/8lVnuUgKAOBwQcewRC3cYogx27A7aP/1bvZg1OptjBVY7owvV0WuktNs+tLS/
	HFloOTTNvn4Qgc+Vy5sd0dMpgAqUKdtVrDSZG/oXt1s9cnYG6UCdpMTuykO92D9/b1qpiY7tylX
	XlUGTk1GqKRC8eAX569zt+9htyxGIdLEuDjk6aBLRfPIzsb8hJVgikhhVnS0gSPqrYm0H9Wqi8Z
	YlF3epHyJCS5WOkXNHb25Th3tKnjRNZyZux8FDprBdbbOV7FPO+8JgCIU2FO9zznZFbs763V9ft
	K+BM8jQLmvokWjkkSO5gB4JXoCu8eYjYBwqWE=
X-Received: by 2002:a05:600c:1f95:b0:477:6374:6347 with SMTP id 5b1f17b1804b1-483c9c0bb23mr238209815e9.22.1772501175308;
        Mon, 02 Mar 2026 17:26:15 -0800 (PST)
Received: from lorenzo-VM ([84.33.161.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851335e1f9sm3999705e9.7.2026.03.02.17.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 17:26:14 -0800 (PST)
Date: Tue, 3 Mar 2026 02:26:13 +0100
From: Lorenzo Pegorari <lorenzo.pegorari2002@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [GSoC PATCH 3/3] doc: gitprotocol-pack: normalize inline code
 formatting
Message-ID: <aaY4tQzdEGE0hfvB@lorenzo-VM>
References: <cover.1772467050.git.lorenzo.pegorari2002@gmail.com>
 <e0e4ea3d22d11d8d6b6e721228f1420cb8dfa612.1772467050.git.lorenzo.pegorari2002@gmail.com>
 <xmqqms0px2de.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqms0px2de.fsf@gitster.g>

On Mon, Mar 02, 2026 at 03:01:17PM -0800, Junio C Hamano wrote:
> LorenzoPegorari <lorenzo.pegorari2002@gmail.com> writes:
> 
> > Uniform inline code usage for command and process names.
> >
> > Signed-off-by: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
> > ---
> >  Documentation/gitprotocol-pack.adoc | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/Documentation/gitprotocol-pack.adoc b/Documentation/gitprotocol-pack.adoc
> > index f4c9e024b0..63d3971037 100644
> > --- a/Documentation/gitprotocol-pack.adoc
> > +++ b/Documentation/gitprotocol-pack.adoc
> > @@ -117,7 +117,7 @@ process on the server side over the Git protocol is this:
> >  SSH Transport
> >  -------------
> >  
> > -Initiating the upload-pack or receive-pack processes over SSH is
> > +Initiating the 'upload-pack' or 'receive-pack' processes over SSH is
> 
> These are not `backquoted` for <tt>teletype text</tt> typesetting,
> like the other hunks in this patch do?
> 
> All other things in these three patches I found them reasonable,
> except for this hunk.
> 
> Thanks.

Thank you so much for catching all my mistakes Junio.

I misread the existing formatting: I mistook the apostrophes for
backticks, and so I incorrectly assumed that the document used inline
code for command and process names. In reality, the rest of the document
uses italics for these elements.

I'm sending a v2 where I correctly uniform command and process names to
use the italic style ASAP.

