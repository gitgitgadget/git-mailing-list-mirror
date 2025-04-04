Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B45BA95E
	for <git@vger.kernel.org>; Fri,  4 Apr 2025 07:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743751083; cv=none; b=R1qp3iB6W8i8FqQZvSPDplYVUzuW0u060gBa7UGhQXXj2h7qpm8Oag6mGQbf4AJiBBcLOpoT5RFvHTvFA7fWWdKN24mlVtWhBbPNRtHneaoROemkL95V9ehwVY9MkTqhgd/9CG5+ib8GT8elnY81tH8qB/JfzO457MfIomyas74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743751083; c=relaxed/simple;
	bh=P4w+FQ9wDgQ9PeonbGbolKfELOOBrVKCgd8PVIumF5c=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R/c8GPAKhsjGjFxnHN6KfDaNmLDuDK8Atkery44NO4FisFa5aoQfJ5/m6IT/Q5F8aVL/A1cyor4XfNxCFISq0dKd66k2lTC8JLnzYlinXFcpzCGbVG1ST+X+0PDozZt1JDudJV6xQyzSiq8x1LWPIRYIpe/OPmjaNrCSx1Jn/Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QLSnzwYB; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QLSnzwYB"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22435603572so16316435ad.1
        for <git@vger.kernel.org>; Fri, 04 Apr 2025 00:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743751082; x=1744355882; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LWJnq0u/+k7zGgdRAgmAZgf/0ilATzlwD3iv08fgXZ4=;
        b=QLSnzwYBy+O0gggbOrTNpUdUpbNnIjHRD1nCR27BtdvoyA90yVcjaW4uaoPXNJW0EM
         f3geGWrThWexRzIqHBd9k/E7WLuZfgmApm7C3sKCIO7p2w4Gz4lm14FFoYqyQTSk/u9a
         VQexfXEJ0scaWujvczHbC1CE8Uv5JjS9dYb9Mt19z0GITwsoTo4l7ap6XL+B14rlk9FL
         F5RqWRGyZv16tRxp/G/OGv7iCxtXNDc0vfCrVpdrq+iogA+tYThpJlFDzswFugxJyr9g
         mqaG8tHanxYLEdYgFb1dxQ9zeR+ihNBDCNqTF3xqSE22umwIccdaNZKbHg5QDwdPNCu1
         +RIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743751082; x=1744355882;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LWJnq0u/+k7zGgdRAgmAZgf/0ilATzlwD3iv08fgXZ4=;
        b=q+7ORw6stUBuzNPjvPz3cXIRC++5P5dgSMdSkBYS2psSIwX8NUdasuVp/me3luynZm
         cwZFCOj0o7aluN30KorcAFve78QQ0G5EePYKs0CvMtgOkEfWVd48INJU/jn1dm06BxkF
         ZnMajPu4SEOivNx7tZWFamS4GPl3r5lrlB/GAkoqzngRaWMUlPdsdFvQMIEOtVYRJDJO
         sorDHbDiW7oeHC+aDJO4PUU31fQGDMX0B87vbvb2XvJD7H+NGammDIAMRuQxOlHkHgG0
         dejtkFMhnWTbbecfMsGp6FHKskxfnzLapVF35Lx3jc1zBoI2M69cXwWTXUZutjE2/G/r
         9+kA==
X-Forwarded-Encrypted: i=1; AJvYcCU9WE/XkrpK8cD4cstOrpTFfucrj9fBHnRPTu0+3+0xrUSSPWxXLFK0kRZKBP+LvsB+Aco=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlYFQpwgWCe0+EPIPIZ3fjVHQoBqRfylwCfcxbqTXbSwY8EUOU
	qC0n4kq0csaoaHx32NKJfn6NiLZrMJekiYIEGxG7ouZT+q4fxVRC
X-Gm-Gg: ASbGnctXf1qKPNKcZ2AmEK+3DoyqlIOrIdjVCmP0vclULlPIvxwb4vufSSNCdz6X077
	CvGU2YOBQiwbeAfBVowm5r0NY083F2FlZotLTH1NkO81yp0IR1JRKGRwvvwAlmvH3Jxl3ssJJpU
	L0QlJ3gy7wGa0ceG9rjhFp9czX09FfDiQ22DFGQ7k2DSO0/ZDX3ALjcERaEdFyhKf2APcDCMrfa
	WzAfUxpHJj8HDoGDgoOtqQLPedNqwDyIlPkFM7hDQwN5UpVwj4q5db5ipW8RcIPm9jfMu0yNgir
	oOxO6eSNUl3wTqhYNQ8RV5bVly+NiKaSxEOBIkQQ
X-Google-Smtp-Source: AGHT+IH1yCvBJIIEz/4JXA4DFJCfBgcPF3xAWWxsroAr+Hw+CnPolqRH5j9DvGNTug49P32Io2q8Mg==
X-Received: by 2002:a17:902:ce07:b0:221:7e36:b13e with SMTP id d9443c01a7336-22a8a864e2amr35483735ad.12.1743751081722;
        Fri, 04 Apr 2025 00:18:01 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22978772ee4sm25555725ad.233.2025.04.04.00.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 00:18:00 -0700 (PDT)
Date: Fri, 4 Apr 2025 15:18:12 +0800
From: shejialuo <shejialuo@gmail.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v6 14/16] refs/iterator: implement seeking for packed-ref
 iterators
Message-ID: <Z--HtPsKissdMvuE@ArchLinux>
References: <20250312-pks-update-ref-optimization-v6-0-f778e0414f55@pks.im>
 <20250312-pks-update-ref-optimization-v6-14-f778e0414f55@pks.im>
 <CABPp-BFBqC_t5QSexRQpYsqXBa11WK+OqGt167E=K=xod=buQw@mail.gmail.com>
 <Z-8JN5ZXrgACgYvN@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-8JN5ZXrgACgYvN@tapette.crustytoothpaste.net>

On Thu, Apr 03, 2025 at 10:18:31PM +0000, brian m. carlson wrote:
> On 2025-04-03 at 19:56:39, Elijah Newren wrote:
> > In this case, the utf-8 characters will have individual bytes whose
> > values are greater than 127, which for a signed character will be
> > represented by a negative number.  I tried tweaking the loop to:
> > 

That's good catch.

> >         while (prefix && *prefix) {
> >             if ((unsigned char)*refname < (unsigned char)*prefix) {
> >                 printf("Comparing %d to %d\n",
> >                        *refname, *prefix);
> >                 printf("Comparing %s to %s\n",
> >                        refname, prefix);
> >                 BUG("packed-refs backend yielded reference preceding
> > its prefix");
> 
> I was mentioning this to Elijah earlier, but I think we might want to
> use more emojis in testing things like refs and other text patterns in
> our testsuite.  Because most of them are in astral planes, that will
> help us exercise our UTF-8 and UTF-16 surrogate handling, which is also
> relevant to a variety of languages, like Chinese, which we obviously
> want to support but which contributors may be less familiar with.  Since
> emoji are more universal, it's easier for anyone to add a test for these
> kinds of cases and we might be able to catch some of these kinds of
> things earlier.
> 

I somehow feel strange that people would like to use emoji(unicode) for
ref name, because if the user doesn't install the corresponding iconic
font, the user cannot see anything meaningful.

Anyway, we may create unicode ref name or commit message to improve test
coverage.

> That's in addition to the fact that many people use emojis in things
> like commit messages because they're fun and we want to make those work.
> 
> Next time I'm sending patches, I'll endeavour to cover a wider variety
> of codepoints in my testing.
> -- 
> brian m. carlson (they/them)
> Toronto, Ontario, CA

Thanks,
Jialuo
