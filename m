Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0370417A309
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 13:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755697808; cv=none; b=JiwNKal0+Av4oH1NUcCqUqpd331whq0TD5Sljn7OPNYPPIwdMlgvLthUmAl2/2i7pU+ZclngA3emm3hjShxoxrY8E/qg0GMNqEzEgk/BFlgn+qgxyjCDOdBUaScvU7fe6lUJ+f9J26hNp7FTnpRyH1ufraw+ik3uE0caCRZ1Fec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755697808; c=relaxed/simple;
	bh=3ymWl1oYgHgQy6LMgwLM61pH+m7XSIAOIdcDx3gVVt4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=X2Hzxaky353+IVUQtJP7qaZspOAWC1qdfJA39zLB4useeMFhluXc4lX4qXay4bCdOozslZR8MwDJ57SQned08ldQ+E2uOkGuHJ4kmypJ7q/RVn0pP4RpHJ6toAnmKmfHBYxrxTtvMIdT/rSawYkpDoXmwI7vkHKpADwrQV2F+7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZ2Dhvrj; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZ2Dhvrj"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-50f88cd722bso1951399137.1
        for <git@vger.kernel.org>; Wed, 20 Aug 2025 06:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755697806; x=1756302606; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uN41PtxqUKUPlMKKQia0YmSDHfvJkcaSl0/4kPps9gY=;
        b=fZ2DhvrjLK7xibDLkIGLCI328xOsfaBUL0BUPQ1Wmrx096W4o0qopGuTZeqH4pCPPq
         CcwQ+BrbLCFojVRYnqzjg/TSzqN0CIAm+t3gLe278K3DQci3dZNDhvScXdKv3EuXAFzq
         P3J2GzEKop+g8jMFJCSE4Rtj5G091xfMXOpPoYEds7oHw9kQDDf6xZDThuxKaT8DzGN9
         cfzZnl+Acrjf21pH6KhPLGO1VKNcLSn0IZWCWUk3BQFmEKbV6f2wVHZzhUySskZkOvC7
         ukHVemXrlGQshB1xgtsetLLBLFsTt2igpXVAOa/dMciPxyHdbG5rmYCskJXkH3DL74Bs
         zIjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755697806; x=1756302606;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uN41PtxqUKUPlMKKQia0YmSDHfvJkcaSl0/4kPps9gY=;
        b=gG03NjK1zaUQu4lNVleQIZYWz3LlfmujKJTR6NUbRe52md7/FzjGsNYKPM8+RWuKoM
         PP2GsrHW+CaYWOhNpK31KoqgwoJHeKGstv0WRegk9JlAIxBH6NpvdZhn1fQob4L5/ggA
         zMkXk0rUOzznAsiKWVStbEZYXyYeiPgmNTzrsMo3M10y2q0R7IH+/J6LutkcgSFUtQLH
         pOXpdu7fdxIsX/5311qXZlWn7FE6mLaz2M1UR02LCeQNCVVC6R6fOwCNGBBh4iBL2a9c
         ERzxsQN6Tm5M2oyCBd4I72wINu47EjZgw6MTnJDiitctbzIxH58bnPD1B8SyUfql56JC
         5szg==
X-Forwarded-Encrypted: i=1; AJvYcCVbq7vpWYGFXv6qe+ENZHUA3FhGIR4Kv+k+z3NBbRWg1psMTImdAjFCro1wT6mt0gbGEwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrMKsyFfbX8Cn4mlmLmrVCOOAFMh4OyhOtKYVAgdJG4utq5MzR
	199vVqZ2dyYAwp9oYnYouX9RyFwonIhGSyQm4zqyURpCcgArO+qjl6Jd5QlBzTgi+UqkDH5rctY
	pF4XVDnXIHxsatKn/9KkRYyTBcppcwATbzw==
X-Gm-Gg: ASbGncstD9t2ldsZDC4QlGKO0RMyV7JX+M5hxmB7+hZ/2g5JnDjljB92hQy1tVdGiju
	1wL+jkJRFb4ht/xUEnKPq+7mVOyrbohGidQ6vQiP8MNSOSOB2kRiglO4ZRjAJOSDgAo4M/P0mSl
	XzdLTV7Tlc24WlWIG2/lj4pzE1JQPkP+uu4Vmw+PoMpju3Xk5gcYBlLPgukcE7zjUiFfMRhz7Y9
	eFVnuhSMou3mfZ5
X-Google-Smtp-Source: AGHT+IFAnsvk1aVHUIpmVVQqYSXJKuG0jxdBjI7aOAvHnTLYjpGY82anuax2m4sB8P1SnyrETHaWnNXsM0tjfmU8JSU=
X-Received: by 2002:a05:6102:2c84:b0:4e6:d784:3f7 with SMTP id
 ada2fe7eead31-51a50c775damr779326137.15.1755697805676; Wed, 20 Aug 2025
 06:50:05 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 20 Aug 2025 06:50:05 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 20 Aug 2025 06:50:05 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250819-b4-pks-packfiles-store-v1-14-1660842e125a@pks.im>
References: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im> <20250819-b4-pks-packfiles-store-v1-14-1660842e125a@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 20 Aug 2025 06:50:05 -0700
X-Gm-Features: Ac12FXyaLX8GPZUY45B1DDKqHKYOcQhfY4m3aJphUBsVBKiRDtf6PPliacmIRAg
Message-ID: <CAOLa=ZR7eXDAsrRifyvxzTt9RwSR1TcQFs4KLaV7n6byxQM0zA@mail.gmail.com>
Subject: Re: [PATCH 14/16] packfile: remove `get_packed_git()`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000000a710a063ccc40e7"

--0000000000000a710a063ccc40e7
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> We have two different functions to retrieve packfiles for a packfile
> store:
>
>   - `get_packed_git()` returns the list of packfiles directly.
>
>   - `get_all_packs()` does more work and also prepares packfiles that
>     are being indexed by a multi-pack-index.
>

Question, under what situation would a packfile not returned by
`get_packed_git()` but be indexed by a multi-pack-index.

> The distinction is not immediately obvious. Furthermore, to make the
> situation even worse, `get_packed_git()` would return the same result as
> `get_all_packs()` once the latter has been called once as they both
> refer to the same list.
>
> As it turns out, the distinction isn't necessary. We only have a couple
> of callers of `get_packed_git()`, and all of those callers are prepared
> to call `get_all_packs()` instead:
>
>   - "builtin/gc.c": We explicitly check how many packfiles aren't
>     contained in the multi-pack-index, so loading extra packfiles that
>     are indexed by it won't change the result.
>
>   - "builtin/grep.c": We only care `get_packed_git()` to prepare eagerly
>     load packfiles. In the preceding commit we have started to expose

Nit: the first sentence reads a bit weird.

>     `packfile_store_prepare()`, which is a more direct way of achieving
>     the same result.
>
>   - "object-name.c": `find_abbrev_len_for_pack()` and `unique_in_pack()`
>     exit early in case the multi-pack index is set, so both callsites of
>     `get_packed_git()` know to handle packs loaded via the MIDX already.
>
> Convert all of these sites to use `get_all_packs()` instead and remove
> `get_packed_git()`.
>

[snip]

--0000000000000a710a063ccc40e7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: d4642cc6ef54d64e_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1pbDBvc1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNkpvQy85NDZCN3NTTW1zZ201VFBWSDBjMUt1aVNhOQpub2lHalZpa2hr
OW5QamxBbjduUzZiRGhpcGhpT2pLRVdPdTVMSFU2NmZoQnNhdXIxbjV4NlNQc2M3UzFva3ZoCmhF
NEhTT3d0WUM1citRWkw3UlhDVi9pSWc4M3ZiRnFETDlsbGR5K1VYQ2lFazhGS0VVelprcUQwWUpE
aGRmMVAKSVoxdU5iRFFWSlpSUDZwYTg1bFp1MUIyZ3RvRGlTS1FlMm4wR2E1dDU4QjV4Rm9PSDMw
NU9kSHpqNlF1aE9NaQp3NDJCbVdUcklQeUR0RGN4anhQSzkvb1lYa05FUDdDZklNa1E5b1dJYnpP
aWl4dEhNdFA5ajlSTEd5UUhxcm05Ci91QzZycVR3VGhKSE11Zk5VRVUvTllJM3JkTnhRbXR0OWIw
d2JFUHlkeVNOVnBNUjFCdTZtbXM3am5Ec3ZLcTcKZlc3L2VEV2tJOWg1UVlLWjdKQjdCaERPTTho
aG1qN0lMOXlUZFRYQ3pNWUNZTWJxTTZiNGgxbkJmS3dTeGpTUQpqVGthTWI1VDcyQnRtdFNjYzcx
b3VOdDNXeVJUWVJma1hNQWc2dS9GTW1nRnlXOGlBV2srbStkbjlxWUZPaGhCCjVuVUdnd3Ixek1Q
MzAwSUw4NWNwTWg4ejNIRHM1VTFjY3huck9pND0KPVIxM0EKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000000a710a063ccc40e7--
