Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76416276D38
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 02:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740709935; cv=none; b=s1CMbO3b1zn1vB6lYfuupwW1X2+QoLA+dg8xFqbPDvaz3tL+//ZPRZqD25y5e+RX0+g47M3TGHPnLIy5yxd7veRxf/IP38+OGl85TUgys0a9A8cW8ZR/QdI6P+qiFYDdFzOoIRqH+jRHOcwWwY/bnJv1JWBXFOqsPRcWRdeWBEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740709935; c=relaxed/simple;
	bh=J6iyt+OtmwORGYGZBEAkW5rZ3G1RFi8NYJ2zrf57g5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r1a0970znF7L1YV4Ge9NsDKecAHJmCcxuOUOnw2kLWvoF/IvZHj7C+1Ahwlbq9by26LUf6BV/ronyIxAM8dD3PXhFXCK9LRifhcyWQ8EkHy/lZDjk8oMDc+ZYIVocst6rJC2dNoP/U5344KtzpnVO14hx2QpXGzKs3740pbFCwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kVj33brE; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVj33brE"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3f3f149c334so1150641b6e.1
        for <git@vger.kernel.org>; Thu, 27 Feb 2025 18:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740709932; x=1741314732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vwSlv7pk8isiQmavx+IyKzKEUEJKYJLsDbmH+viQRpc=;
        b=kVj33brEWHef/BXgcPnvVYzUh6aCsn4S8VDbHulmOt0AK/EUFhOTl5hu9IjbpDuSVy
         ixcqWuEetxZGo0TdbBRSxiYMr6VKrtNocIrQwCmznS23d1iq3UnE3eJeTa4MnBmtfNm5
         Cuvep+i/il6Ipv/M4djW+A24y+2zvEsS5pGpdAxzkzLxUzUKGVypvRfSRE+l2W6/FYYH
         tjQhqYEYu03AxRLSBUJgIfIiDz8orytPExULV4gK2QPVTvpIT9btlvYzKt6z9XKKmT44
         vU+R6M6RI7sNlBjq4U7Vihq66NEzFhPNl01UDe7J2IUsZKWJzIMdsfymCm1fm7F9gfC6
         H2Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740709932; x=1741314732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vwSlv7pk8isiQmavx+IyKzKEUEJKYJLsDbmH+viQRpc=;
        b=cW04M8j+AHMVipK6k58UrId8ZSOhlltubFO397fUFVyhgUNVYv5rehIJOkqd2Mydbm
         haIxGrQYTrhCvnN7KMCR+5xAQNIIANRc0SNdk8qPvUMb8r0MzO30qVLR5bBFC5lJhJvq
         FYHeOrb5Dnk/BjIv4iSxeR5zOoPXaBZMOUWls5sRZZ36VKz7DxrdD/VNLjTpHcB/5B5h
         BSvmijZTP8N6e4xznHqMSyuol2mwedeY5WB/vrYR6onGFBxzRr/OHNmHwd5Zitr6HARL
         qqmQoq11L2tUcCG+qXC3yvdQbcsv/j1OqL5TynCow8+cWW8GZOEFpnEsytlSafc6wET0
         LymA==
X-Gm-Message-State: AOJu0YxLbQcXcCnSHAsDJNlSFgjvJaYEVR0amvsDbD0La0gJwj4HySV/
	b0eSbp1KEw7/ph2XEExE8emvkPkpEWJkCWm2nN/OI1yujCf55aZZUzmRsk3iGKk4eTI515Yylwg
	SFYdYuL74+UKQrxrqe+YbF/ffB0hU5+nC5G5D12+e
X-Gm-Gg: ASbGncswYVMiwNH95n8EjEbM55NayrLX/cVEv/Uz/lRvD3AMosxM/mXDVYwe0OBAk8a
	Ftn/GBFs9w1M5f/Zpd5zgABFamjAEZXMtplRtQdA/bPKjs8UGBrZ+yllJ2FDhSBTNxd1YOIVZy8
	bS18Z0IV4=
X-Google-Smtp-Source: AGHT+IEZbxasf2IIygsrnWbIO6LbKXpxNJ1qIaHo5i4wCGvHyUjl95VHz1iFJrTnDUJgv4exyWQcPZOLEhVlJ6ioeAk=
X-Received: by 2002:a05:6808:bce:b0:3f3:fd67:261f with SMTP id
 5614622812f47-3f5585099d0mr1079582b6e.1.1740709932336; Thu, 27 Feb 2025
 18:32:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAD6AYr-ZC32VNfUfMB63H-rQRfTdV=VQfBm67i2mG+6GDCNxkQ@mail.gmail.com>
 <Z8D/aiqN5e/aRSn7@nand.local>
In-Reply-To: <Z8D/aiqN5e/aRSn7@nand.local>
From: SURA <surak8806@gmail.com>
Date: Fri, 28 Feb 2025 10:32:01 +0800
X-Gm-Features: AQ5f1JqedGvEqg5mJp0z32LJ0VNNrNoY_FeKlAnCvpVi26hVqpoYqr-5QCy4O4E
Message-ID: <CAD6AYr84KuBb5N-LVBQo-6Gq2Ms3JKQCk0gyO8i=N8gp3whe_Q@mail.gmail.com>
Subject: Re: The transfer.hideRefs of the upload-pack process does not work properly
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Taylor Blau <me@ttaylorr.com> =E4=BA=8E2025=E5=B9=B42=E6=9C=8828=E6=97=A5=
=E5=91=A8=E4=BA=94 08:12=E5=86=99=E9=81=93=EF=BC=9A
>
> (There's a parallel discussion going on in [1], so it isn't entirely
> clear which thread to respond to. Since it seems a little premature to
> comment on the patch itself, I'll respond here.)

So sorry, I used another email address to submit the patch, it is
indeed a bit early

> On Thu, Feb 27, 2025 at 03:24:07PM +0800, SURA wrote:
> > I found that packed refs are excluded by the transfer.hideRefs front
> > match, while loose refs use full match (when transfer.hideRefs ends
> > with '/', it is prefix match, which is normal)
> >
> > When the server uses git, after setting transfer.hideRefs, the
> > references that the client can see before and after server repo gc are
> > different
>
> It's true that the low-level loose references iterator does not know how
> to handle excluded patterns, and that is by design. In the packed-refs
> case, we can skip over whole sections of the packed-refs file according
> to which patterns are excluded.
>
> But in the loose references case, we haven't implemented anything like
> that to skip over, e.g. enumerating the contents of
> "$GIT_DIR/refs/heads/foo" when "refs/heads/foo/" is excluded. (As an
> aside, this is something that we could do, it just hasn't been
> implemented yet).
>
> So in practice today the only way to exclude loose references according
> to some set of exclusion patterns would be to filter them out as we
> iterate over them. But that is the caller's responsibility, as we see in
> a handful of comments in refs.h which say "any pattern in
> 'exclude_patterns' [is] omitted on a best-effort basis".
>
> So upload-pack / etc. will see all loose references, and it filters out
> the ones which it's supposed to hide via:
>
>     upload_pack() -> for_each_namespaced_ref_1() -> send_ref() ->
>     write_v0_ref() -> mark_our_ref() -> ref_is_hidden()
>
> , where mark_our_ref() tosses out references that the low-level refs
> iterator gave back to it which match one of the excluded patterns.
>
> And there we have ref_is_hidden() doing the following for each hidden
> pattern:
>
>     if (subject &&
>         skip_prefix(subject, match, &p) &&
>         (!*p || *p =3D=3D '/'))
>      return !neg;
>
> So if the reference either matches the pattern exactly, or matches up to
> a '/', then it is hidden and thus not advertised.
>
> I have to imagine I'm missing something, but perhaps it would be useful
> if you could provide a reproduction script that demonstrates what you're
> seeing.
>
> > It seems that 59c35fa accidentally damaged upload-pack when optimizing
> > git for-each-ref
>
> No. 59c35fac54 (refs/packed-backend.c: implement jump lists to avoid
> excluded pattern(s), 2023-07-10) predates any behavior changes in
> upload-pack, which were introduced later on in 18b6b1b5c5
> (upload-pack.c: avoid enumerating hidden refs where possible,
> 2023-07-10).
>
> Thanks,
> Taylor
>
> [1]: https://lore.kernel.org/git/MA0P287MB06412DF70BCDA0D99641129FE4CD2@M=
A0P287MB0641.INDP287.PROD.OUTLOOK.COM/T/#t

I shouldn't have mentioned the '/' suffix, it's confusing

My previous description was not clear enough. The early hiding
according to exclude_patterns in packed_ref_iterator_begin seems to be
designed for git for-each-ref's exclude. It is different from the
ref_hidden matching rule used by upload-pack.

I provide a reproducible step to make it clear

------

# create git repo
$ mkdir sura-repo && cd sura-repo
$ git init

# create one commit
$ echo "hello" > file-001
$ git add . && git commit -m "init repo"

# create some refs
$ git checkout -b sura
$ git checkout -b sura-001
$ git checkout -b sura-002
$ git checkout -b sura-003

# show refs
$ git for-each-ref
d0205e0d0a0a7a6d1a712afb3734ad3e88eeda1c commit refs/heads/master
d0205e0d0a0a7a6d1a712afb3734ad3e88eeda1c commit refs/heads/sura
d0205e0d0a0a7a6d1a712afb3734ad3e88eeda1c commit refs/heads/sura-001
d0205e0d0a0a7a6d1a712afb3734ad3e88eeda1c commit refs/heads/sura-002
d0205e0d0a0a7a6d1a712afb3734ad3e88eeda1c commit refs/heads/sura-003

# upload-pack, normal, hide 'refs/heads/sura'
$ git -c transfer.hiderefs=3Drefs/heads/sura upload-pack .git
0103d0205e0d0a0a7a6d1a712afb3734ad3e88eeda1c HEADmulti_ack thin-pack
side-band side-band-64k ofs-delta shallow deepen-since deepen-not
deepen-relative no-progress include-tag multi_ack_detailed
symref=3DHEAD:refs/heads/sura object-format=3Dsha1 agent=3Dgit/2.46.0
003fd0205e0d0a0a7a6d1a712afb3734ad3e88eeda1c refs/heads/master
0041d0205e0d0a0a7a6d1a712afb3734ad3e88eeda1c refs/heads/sura-001
0041d0205e0d0a0a7a6d1a712afb3734ad3e88eeda1c refs/heads/sura-002
0041d0205e0d0a0a7a6d1a712afb3734ad3e88eeda1c refs/heads/sura-003
0000

# gc make loose refs to packed refs
$ git gc

# then upload-pack
$ git -c transfer.hiderefs=3Drefs/heads/sura upload-pack .git
0103d0205e0d0a0a7a6d1a712afb3734ad3e88eeda1c HEADmulti_ack thin-pack
side-band side-band-64k ofs-delta shallow deepen-since deepen-not
deepen-relative no-progress include-tag multi_ack_detailed
symref=3DHEAD:refs/heads/sura object-format=3Dsha1 agent=3Dgit/2.46.0
003fd0205e0d0a0a7a6d1a712afb3734ad3e88eeda1c refs/heads/master
0000
