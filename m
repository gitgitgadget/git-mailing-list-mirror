Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93115231842
	for <git@vger.kernel.org>; Wed, 20 May 2026 17:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297152; cv=none; b=j2yUrFmS3pSXA4ocXhm0BR3Ii2vmLEkVrkf60Gls1OLKBdPjSjXfxtX4HXZGabAOMHpz8Xy7pmazgtGf4Rh/msbgUp2qn5XqKNYJvgtoQmw9m7Q/6k0bM+3RX1fiTOZn1xqyiOfuEiBpz7KXN8lwKyzHjEGvuP9lOh6Yn8/H0Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297152; c=relaxed/simple;
	bh=uYSzHxVEF5JMjBH9FyQLbOau1fiCT3MxXKtrQ6q/PBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cfC1PP/IB1f3vrr0wIPOj0HO/hJ/i7MfbB78OSNjcZ/9eufSjJq1FkuDaAQy6w158kgSAdpCBA+vEcd/F0spR/W+IVPvZ4yJfaP26uQLbrDnCyRfVnmIKoaZR1Ouna3Ux25wgtfjt3qkr0yWGc15unQM/44gPJZXNx0z3h8iku4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=U7OwAgFM; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="U7OwAgFM"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-651c366f7efso5406781d50.1
        for <git@vger.kernel.org>; Wed, 20 May 2026 10:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1779297150; x=1779901950; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=av8n46hSq1Ks9ovkvhWqa3z35vfpLWJsR5A7CRjcRQM=;
        b=U7OwAgFMTzFARKj6V5uGESotPRthrtZa/gAOi5IG9SHz6bV1B2kYWqYzKPwvG8na9v
         msEDVdV0hbM27fCKsoY1tVZ5G0vaxGuTe0aBvlc8Kw2GYAlUPeDkMIfsaKynQtuEKYFI
         mnxeQ4xrGkruzM5bZxy41TV5r+m5R/AkpfaRkIwAgHBTUn+LKbTlEf9fNrn5j4BwlRmE
         ZL0ieoYwgqsIHqV1zTzeLCEYB27hENmSJUFdLsOqyU4ECXLzXQ89u039sn7yH89T3vdh
         no8zy10q9r7+nlzt4gcCQvMddjbY99UlaRmttyH73u+DrIPlWrSduqtaOav7M5a1zoKs
         pvHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779297150; x=1779901950;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=av8n46hSq1Ks9ovkvhWqa3z35vfpLWJsR5A7CRjcRQM=;
        b=V+ilf1avgCV/uCcMykNDIw6vyVHJljASbJuMkDtD/nQZ+jCae1Dfz61wFLZ0o1GoDf
         THvnxPiu/BtpSZyPOCvGfrm9gVpYslfQEtdKPW8BljOuDRL7n4UYp/IjXNOyHwzHBere
         oqw5jXokaX7MVP2pAj9s761dZmXkBsLce8zhObpFPNvW7e1nTsliltKXT27/LysOWcF+
         NeW9NJXzMaYbFEmrPQqLDjLNUYpeGXZNTdTieJZKQslCG6elxBE/gv4zDR5ezqeLR1lc
         V75FtCUURKZQV0mtSi0fImjv7zCx5/rU1iOYcD6UHgOExai6pHVY0KsHlnlvaSsyJAr1
         17aQ==
X-Gm-Message-State: AOJu0YzCAo1EpfeKKgCE8/UDubrW5IarQMQMl4hHvgW9KTdaYJb7JDpm
	0mQUDVIdzzsy8I466KsacMZRxWpQdG9Hco0H8IyNe2arFxEKjV76oEg1xjx80E7pIL4=
X-Gm-Gg: Acq92OF4ch3XL1eQy/GNwf+MCpOD0oJzF3RU7jop6WYcYLNfjufgJfCu8sV7NzHxsdL
	quhgffb2/Y0ZPighfwX+GGNIcNLtPwKmnJ7M/dfVL3UnIoY+WqZO8SkIInDm9iBXDimMpQ+Dxcj
	//6YJnZUVa/VHUMnqi+V2Lwnp++DVE8zY+6unmvzmt2ldmN50t/rhSniHFO3JTrgLUuBA9+oz2Z
	C72CUZ+wjx3IOWqnjnn23KFAzaSHrtKDeKxSeC11NG6xo1F+V3nXWFVe0CqsX1THt9dq179saCA
	2QdEhNEFmmlbR8TP/WQ1+ylgDIEGTFoCzboAZZd3hJ0osUZbaBO/oP0THgk4O9dPYCxiH9WSiQu
	FYKRevoaZ1bV8bdzNf+Xv6TG75S+IDAKHZnOQs1bwFrUrrPyFCRvoPo2ycEsGjWpoRubBdwLOOM
	JM52DnbzznV7lRLYK5EtonicUSlLEekPjGkOwPOgCsQLtgDXBm+bTqv5crahQCFNNHThOiJnIA/
	PH41ibQop+4naMkyQ0AUY2QAL1Nscguni4OFc93ZjEhQNZlLH4sPNA86MvkWiZPEkZNGz2GrP/5
	YG9tnV0mM1ZjY+8Q
X-Received: by 2002:a05:690e:4293:10b0:653:f72:f482 with SMTP id 956f58d0204a3-65e2275e8fbmr19491023d50.22.1779297150465;
        Wed, 20 May 2026 10:12:30 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e0d89b130sm9619448d50.5.2026.05.20.10.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 10:12:30 -0700 (PDT)
Date: Wed, 20 May 2026 13:12:26 -0400
From: Taylor Blau <me@ttaylorr.com>
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 4/8] pack-bitmap: consolidate `find_object_pos()` success
 path
Message-ID: <ag3reiso1XFh/Jvs@nand.local>
References: <cover.1779207127.git.me@ttaylorr.com>
 <c9a560660949c53575a9b1e81160d25212a1f484.1779207127.git.me@ttaylorr.com>
 <ag3IXa3lKLmQC1tD@szeder.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ag3IXa3lKLmQC1tD@szeder.dev>

On Wed, May 20, 2026 at 04:42:37PM +0200, SZEDER Gábor wrote:
> On Tue, May 19, 2026 at 12:12:44PM -0400, Taylor Blau wrote:
> > Both sides of `find_object_pos()` report success in the same way by
> > setting the optional `found` out-parameter and return the resolved
> > bitmap position.
> >
> > Prepare for adding more bookkeeping around object-position lookups by
> > storing the result in a local `pos` variable and sharing the success
>
> This 'pos' variable will only be declared in the next commit,
> resulting in an error building this commit:
>
>   pack-bitmap-write.c: In function ‘find_object_pos’:
>   pack-bitmap-write.c:227:17: error: ‘pos’ undeclared (first use in this function)
>     227 |                 pos = oe_in_pack_pos(writer->to_pack, entry) + base_objects;
>         |                 ^~~
>   pack-bitmap-write.c:227:17: note: each undeclared identifier is reported only once for each function it appears in
>   make: *** [Makefile:2917: pack-bitmap-write.o] Error 1

Thanks for spotting. I had split the patch that immediately follows this
one into two to make the latter easier to read, but have no idea how
this snuck through.

It's fixed by declaring `pos` in this commit:

--- 8< ---
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 6483fdc7daf..42ed22feacc 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -217,6 +217,7 @@ static uint32_t find_object_pos(struct bitmap_writer *writer,
 				const struct object_id *oid, int *found)
 {
 	struct object_entry *entry;
+	uint32_t pos;

 	entry = packlist_find(writer->to_pack, oid);
 	if (entry) {
--- >8 ---

, but I'll send a re-roll after the rest of the series has been
reviewed.

Thanks,
Taylor
