Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E0A27F198
	for <git@vger.kernel.org>; Tue, 30 Sep 2025 19:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759258819; cv=none; b=P+IEYAGiiEaYNeelRhpc4vrTjusdXFlQJJmiLJF4NqzpU8bptsfANIgHa90lebBRMh221AnRShLcInDbKpJmzJ00w7ZqMv+KmGveFI0Mrya7F3NfWvY/fHFaCX/rIkGDC88mI11muL/IL7siehvJlTbIjyk/Mxbs+lJFyN040Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759258819; c=relaxed/simple;
	bh=5gU3VQablkgjmaLYgUvq3dvEXaFjk+oXETvt8+kSFqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=P3eCnkWgVFwZhNbv2rFOUB9sh8rpnC0Zaa/JHud0pZKxDDGH/DIboMMs8KZFJqjHF0QO5aV+R6Y0Al4qA8+WKGvgQt8sNL479Fs7DSKnneMTa5ltsirQDklC+FgsKMMAbXnvcIk16tvYwAWFa+LsO58k3LkF8+0h27rkw7R5n2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PEkQl1kD; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PEkQl1kD"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b3d2e4f634bso41326966b.3
        for <git@vger.kernel.org>; Tue, 30 Sep 2025 12:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759258816; x=1759863616; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I/bG4dab10BSOtun+9kg3zHOy7QhE2nNJNoGrjk6ipU=;
        b=PEkQl1kD8sY1Gce1BCmhMgnb2PIAX2SC9ErkpRj2kEbvXwmwzEdeovUm1NWyV+8EHA
         1Aj/blwTytN5FUkmmRkxqS1YrHv1IyS4q9RZzBwEoXZJBkEqOUrHMTO8N6tfxnK0UZ0y
         6d1NFB2wPo2McYvFuStQjG8W5eUnZ7z9aQDHmb237C9vdEi+VMLge+zaKwq4CuIbZO6E
         cUao2c5T6ak5K5d9B0q652ejMePXPsu9uWmrg9RgFiymhJGfr1Uet/tER+uQsxbRn+WL
         kuPAGAlB8QRtiTa/wo1fD2eoto9NgH0zCXo7JQnutH6UbjzgFyjuQUkmm3BnsInEjuiD
         UV2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759258816; x=1759863616;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I/bG4dab10BSOtun+9kg3zHOy7QhE2nNJNoGrjk6ipU=;
        b=QhpZ0aYY+YCLYeGzBrdAZUuwYImnlMhC9jMDTneaeCB6yq0+vQRaSJUZI/PPi/DKZ+
         xvbb6QBuV44FiAzIGA50neK09JPFYzrRP89TbQQg2UkkfFXxiG1aI57KiVdrnbT8mhRb
         t8irX5rK//Idsc+/u2ABIjruhQq2mKWhBv2uw4HGg20a22SrxNQ7CZslure/4G+O8nL6
         N+LgDiGCjShmDj0AVybYvpwLem+UAXLZGrgD6GFwY1KEga9XcR4jqhHPXkeXTXKPaWsI
         AtEIuoa9V0pJBKYd4IfhFo/dHJ3TyEtkB9d+/poPCszVxGhJRzjqUH4is2OqtOwiincZ
         eIBg==
X-Forwarded-Encrypted: i=1; AJvYcCXPZwytpcJyaAl/sjbPfhEdr9Kmtp7x69nBplasSChpkrmzKcR0n78aEHtlAdXJkSaPjEU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo+sFM5erBZmYn4PBYf79ymB0ehOGk/1qVmQaE35yN9sP6Ci2I
	8NhSOTEOeTJG/T2VHPJBok4V1GUzplp/VqbnfAl6JuuwLUBzsb4eUjZlBtH1EsGvPx8SA0yJNWY
	90OKNr/cvkqOt6y6TJqCc2e3GRUyonmsBdRCOwxk=
X-Gm-Gg: ASbGncuRv87QsblpZ6ted6bOMWFf3kaxxeXll25g+tsdQ0RLEjzhG/58hV0dZrkLJ2u
	YDWR9tToBPybZsMyw1Wv7h07T22IYYcnEGD3Zub0Lwb6IxnQJO9yr/7+SKY7OmIHLgsp1IxkKtz
	LIG9z/UqA9b1gu9QUYE3VM9/ueXKGS+R5swGwa1bAvC2IT8ndnavP/Jznjsmv+Wlw/Ykx+25OE3
	vlcemnRIgVFTNYpYP91fhjKsmihqPQVOcFlrkm283WggCo3ucZFN6wOSUPzrPg=
X-Google-Smtp-Source: AGHT+IFu8DxHJklGOQ+jxTKQQ0h8K9224ha7hIVe/rIxG4Ron2DqeeZLqwDPfY7Xsk4hlq4wg5otDvrrFcYEzVSaJxM=
X-Received: by 2002:a17:907:7eaa:b0:b3a:6c29:3552 with SMTP id
 a640c23a62f3a-b46ea1277b3mr42343866b.8.1759258815516; Tue, 30 Sep 2025
 12:00:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGJzqsn7BbaVckJ17XhsDHLtmS3OZPBG=oniwe+FRjhEwGc+Eg@mail.gmail.com>
 <aNvxVOUyijGaJfsr@fruit.crustytoothpaste.net>
In-Reply-To: <aNvxVOUyijGaJfsr@fruit.crustytoothpaste.net>
From: M Hickford <mirth.hickford@gmail.com>
Date: Tue, 30 Sep 2025 19:59:00 +0100
X-Gm-Features: AS18NWAUD2hmQJrgvKTCTNvMqeJiu2l8qDWDnTosN1-cDSpTJStDR2nu3RKjePU
Message-ID: <CAGJzqskzfpyobvV1abTr9qUgGWLuhfTE4FdbgKJy4HZgfO-oLw@mail.gmail.com>
Subject: Re: Feature request: partial URL matching for credential config
To: "brian m. carlson" <sandals@crustytoothpaste.net>, M Hickford <mirth.hickford@gmail.com>, 
	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Sept 2025 at 16:03, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2025-09-27 at 18:48:46, M Hickford wrote:
> > Any thoughts on adding support for URL prefix matching?
> >
> > Example syntax could be credential.https://example.com/org1/*.key
> > (explicit wildcard) or credential.https://example.com/org1/.key
> > (implicit wildcard)
>
> I think I may have added support for this (using the urlmatch patterns)
> but didn't document it[0].  I see some tests for it in t0300.  Have you
> tried it?

Thanks Brian for your reply. You're right, it already works as desired:

     $ git -c credential.https://example.com/org.username=bingo config
get --url=https://example.com/org/repo.git credential.username
     bingo

It has to be a path prefix, not just a string prefix, which is nice:

     $ git -c credential.https://example.com/org.username=bingo config
get --url=https://example.com/organ/repo.git credential.username

>
> Regardless, I believe it's a useful feature that we should have.
>
> If, perchance, I did add it and it's still around, would you be willing
> to write some documentation for it?

I shall send a patch with documentation and expanded tests.

>
> [0] I believe Dscho graciously helped fix a few bugs in my changes,
> which I appreciate.
> --
> brian m. carlson (they/them)
> Toronto, Ontario, CA
