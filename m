Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677E118EFF8
	for <git@vger.kernel.org>; Sun, 20 Oct 2024 11:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729422804; cv=none; b=JeMfNDbjq4rtTwSYPEydGmAvwXhH4A4dBUqbEVnjdW4X1FOF0Ql4drR/QCZ5mmtVcJ4p8kG4axuPuqzXjMnwUqJ56v3FLUm/Ru+Do1LBx45OUo8zAppxuI2goohr5Id0hQgrW3m5mRbDggbr6rEeqi7wM22Rlazhwc3U6MlxRyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729422804; c=relaxed/simple;
	bh=jftmWhUEu+CH7ZqgJxxWcn14i2l4k8YVE2i/Wtk14Sg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n2/IQpwuHU1ivsIv6hj3UtSiRsgWnEs471t7pxSU28ieX+nRi5kg5g9cu53c8iqj+pqowLJvmGIq2myvRYjfo9PN83f3CiDeF6Hkz8l3BE3AEqnSPx+AUD4EaoGWZVGEk++rofCsDxRr9cb0lq9DyUbgB3X5qxSgAW38QVomsMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aBDR05Kl; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBDR05Kl"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4a46f36158cso1052924137.2
        for <git@vger.kernel.org>; Sun, 20 Oct 2024 04:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729422801; x=1730027601; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=XKMPQyeCTSBF/OozzVXjYnAS3nqvA1MTAZ+2FXh8y0A=;
        b=aBDR05KlaJOy8UMuLj19Xza19ufaqvo1js2pNN7voZgAhdrkp81FbpUcH95V9XjjGl
         Sjbs4j86RWTRlHsVJdCmDTiP6IBa+yzEuwQqklHDkkfCGlIAunKbbqtVyyk5M5jGBVej
         U431CJ0dCiK452xSgs2lXLoHALoR2yE+TnwSg9A3ZIJyDdjykL5cqg160lNeZaXpIlmj
         zUNuDz2AHPGDbvfMSqzq1qhZiTznBgW2Jzb/YkIqIUj5PUO0d3B1bi24CrRadMfsmAi8
         wsUQHkRv/NY22oZE8U1DxnPJ2fpf8odKGIn4pGVOiWbMHmEFTjMJl0Zto7mS9w91HTgz
         9jWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729422801; x=1730027601;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XKMPQyeCTSBF/OozzVXjYnAS3nqvA1MTAZ+2FXh8y0A=;
        b=byBBtA2fYSwBOIS5YXFtDFBIxViKk2ywX+rZqC6QRI8l4vvHb67TdhX1z1i9xXvSHd
         ol6Uf8jDZIdvC0NtKGGyX96kYP3hiu/6J8EdOzeriNIaQljqgvqByAuY7T9dCQM0dPhC
         3atBPfOF8ChOg6GkgR9oETe1NdO2WWdBw8nd6seVovJn0qwkS5i7MkebafH88ADKFc8I
         fyTy22vwQz/TJcfFwgKMbwyBfH1+iiNwOTjRmE7Bqb8GPkFUhteLkDcEoof0c9kWaQqR
         b/IipM7ThCuyfp5CIh8ZJznFRPS7XOlV0QTMo0Lv/N2UJs7LUkn3IgdUiULblpYHlrrI
         Dctg==
X-Forwarded-Encrypted: i=1; AJvYcCWYu95BedZypR0fpBy30fnB8KpbEPPtEhJfD0FaiRwG3HUXRTOzAV3VJSoaI+dS5gjYpwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLo7g/Uon5PKhD33Fdyrb4iBlD7GACbhPP2lQHXM2Q+ZpMm7W8
	fhnPRydLTTGVH3X7kCzQhfc6h/XFmrslzFnjc9g6D/P5/icd6avFJxRLTV2zwWRDa3kibccFy4K
	DZzBFk4p38ppMP0frQbwonDFV8rA=
X-Google-Smtp-Source: AGHT+IF0ej6yP4lERnohDF0elD+Dj8Ygp+a3vFMvqhQwErEy3Aix6r/p8ReDn/BeI/zF8RDTn+T0TTMn6bJibMo/SeI=
X-Received: by 2002:a05:6102:32cc:b0:4a4:9541:e3a6 with SMTP id
 ada2fe7eead31-4a5d6b8f1bbmr7487113137.21.1729422801245; Sun, 20 Oct 2024
 04:13:21 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 20 Oct 2024 06:13:19 -0500
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <71d1e6364a21767a8d80c96a30282e6557fec426.1729367469.git.code@khaugsbakk.name>
References: <cover.1729017728.git.code@khaugsbakk.name> <cover.1729367469.git.code@khaugsbakk.name>
 <71d1e6364a21767a8d80c96a30282e6557fec426.1729367469.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 20 Oct 2024 06:13:19 -0500
Message-ID: <CAOLa=ZRAGmgfSHjAx6-1q9qV-aJ_Ciw=RZ6kpygqbSO+yAUEeg@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] Documentation/git-update-ref.txt: remove safety paragraphs
To: kristofferhaugsbakk@fastmail.com, git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>, phillip.wood@dunelm.org.uk, gitster@pobox.com, 
	bence@ferdinandy.com, me@ttaylorr.com, sunshine@sunshineco.com
Content-Type: multipart/mixed; boundary="000000000000bc35210624e69f27"

--000000000000bc35210624e69f27
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

kristofferhaugsbakk@fastmail.com writes:

> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> Remove paragraphs which explain that using this command is safer than
> echoing the branch name into `HEAD`.
>
> These paragraphs have been part of the documentation since the
> documentation was created in 129056370ab (Add missing documentation.,
> 2005-10-04), back when the command synopsis was a lot simpler:
>
>     `git-update-ref` <ref> <newvalue> [<oldvalue>]
>
> These paragraphs don=E2=80=99t interrupt the flow of the document on that
> revision since it is at the end.  Now though it is placed after the
> description of `--no-deref` and before `-d` and `--stdin`.  Covering all
> the options is more generally interesting than a safety note about a
> na=C3=AFve `HEAD` management.
>
> Such a safety warning is also much less relevant now, considering that
> everyone who isn=E2=80=99t intentionally poking at the internal implement=
ation
> is using porcelain commands to manage `HEAD`.
>
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
>  Documentation/git-update-ref.txt | 15 ---------------
>  1 file changed, 15 deletions(-)
>
> diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-=
ref.txt
> index fe5967234e9..ec268b1426d 100644
> --- a/Documentation/git-update-ref.txt
> +++ b/Documentation/git-update-ref.txt
> @@ -40,21 +40,6 @@ somewhere else with a regular filename).
>  If --no-deref is given, <ref> itself is overwritten, rather than
>  the result of following the symbolic pointers.
>
> -In general, using
> -
> -	git update-ref HEAD "$head"
> -
> -should be a _lot_ safer than doing
> -
> -	echo "$head" > "$GIT_DIR/HEAD"
> -
> -both from a symlink following standpoint *and* an error checking
> -standpoint.  The "refs/" rule for symlinks means that symlinks
> -that point to "outside" the tree are safe: they'll be followed
> -for reading but not for writing (so we'll never write through a
> -ref symlink to some other tree, if you have copied a whole
> -archive by creating a symlink tree).
> -

In the new reftable backend, HEAD would simply exist as a placeholder.
So either we do as you did and remove this entirely or double down to
say that writing to HEAD directly is not supported. I don't have a
preference here, so this looks good!

--000000000000bc35210624e69f27
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: c586cc11dcea69e8_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jVTVjMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMlNPQy85OW9NQVR2S1NuNmZ3RTloYXpaMmN4WFN4MgpBUDgrNG9Xc055
QW8wbVplUFZHd0ZTa3FsUUFWSEJGNzNLYmE2ZHlvZWRVMUdaV0s4bmlXUklvNmZHU005ZHdLCnJu
YWUvejZRaUZ5TmI3azljY2FDS1AxVFAvTWhCZTJzakRzRm1Gc244VXVjejJ1VHJ6blo3d0g1VnlS
Wko5M3oKclV2bVc0OUx5dVllWnp2alZrSHN4eGpwTXk4RHFrSjVxMnUyV1dBSEtlNU1jY1RnczJO
R0RaaDJGdGNCTGludApKU0s0aytKeE9ranBwanFteHRhZ0c1eHRBamdDWFB5UWg4cCsxSmQwam5q
OEJQQ2poWEFPczFNcGp6YlNYVmZaCnFRd3FNSTFETzNpMWQ3S1NnTTRaYzB0MGFiRGJROHNhSHcr
dUI3NHFtQjg3T0pKTDh4SGRheC9tdy9nS25Ea3gKdE5HYU5ZMk95cUJRNFJMKzFKQmpFN3F1OFF6
eG9BTnRhbFBESXpiNno0QnhrdWwzemgzbThPVFU4Si9YNWJseApXRjZTTlVuVVMzOXRSSmxVM3Ji
MmpjVUQ1TmRuUEZEVFBsa2NKL3JHckNEZ2lteStjWTloRFNHcnh4Tk85Ty9BCjdFTTJGcFJOeHNt
V3BJYlJYWlFiYk5kSjJvanVraUtxeG4xTE53Yz0KPTlIQU0KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000bc35210624e69f27--
