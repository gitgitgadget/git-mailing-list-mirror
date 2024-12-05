Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8FD1D5144
	for <git@vger.kernel.org>; Thu,  5 Dec 2024 09:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733391996; cv=none; b=L5x4wgcND0uf02gRCJBkPlRUY6OUCk9SQ7PcWFs842mT0EXeG25aNGnrXEtyG45BP7fLL8v6VRYIeSTsJo2vOzgeTEdcX0CZTFdnzpfMH00coNKoaW/bd0sllyd6oj9C53tj5tPFw6SLz9RJCSdwrEcYj5nWNWmkTBvh8CtO3c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733391996; c=relaxed/simple;
	bh=kmHQrhs1lQTJXQOIi45eDBFawSbFcRO38P3kcy5fvBs=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qoco0XmZuFVdlhnbjVmzu4L4gXMx7pLmPycgBXyO0jWAtO/p8YzaUaXBWlTaT96Z9jdK5wI/TDoTos1KyQnYz0PyFSxBh+kBeLuJ/JGvbOn3bDGrl7KdxsUP43aMmC/kxCJS+ZsxrSFGyJvtfSgtgjN6wG6FVHVLLTgd/mDUUyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kngOt02/; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kngOt02/"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7251331e756so760396b3a.3
        for <git@vger.kernel.org>; Thu, 05 Dec 2024 01:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733391995; x=1733996795; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=pkqtBlKRy3tKFstPgQbfETGjq5pLZk4V93DwckUCcm8=;
        b=kngOt02/IfbIRm0K+zesPASAkCniUGRKa3jIZWCZsWusNF10X2GlHOAT+sLbkwFMux
         LKOKKcFIYpCoS29NOwyP9Jfa2F62Dp8ga3l6Yfa0PdmAHbvWJhlpPIdUPanGf31baRSt
         3Zfn458mrPdoVODLaWYyhq7YyCzXTAKNgpSmRLYrbXm/dAGSPWRm1f6gGIwt8Fa2vp2x
         m70QgVZllelOTSRog0TgCQmNZmVCjleRstYzggK2JJ8EyiTlbT6pCFhk5UsitBA7Fmvv
         imlN4GNgTJ3c60a/zf9G1CaKsjXVQCYWIwbbVTpzHAWSZuuhH7I6WYobQXmz8lV4+V7s
         HRDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733391995; x=1733996795;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pkqtBlKRy3tKFstPgQbfETGjq5pLZk4V93DwckUCcm8=;
        b=mujYmazw49WRl7akuUDWML3YsvX61uKcHuoCCs9TSJrSUAbMe2WtcfVTDNXN7J4qV4
         xjDdUhx+DnWNwriOZD7UkCIkfJS1VOfiiXB5RhCEy4yBpLaafWhSSOsGsuztdJDXGvHr
         1uA+HdIkOkyzh53glcM8/NOgUuqP6wFjJB2VZt1NBDAPGtFl733bHiZLQaOO4ONdQUSe
         SyEyPg6kVy5qtpucxXIRqLyYfuyMbPXRxyPPd2tViMbEYNl9+McqlWZZbTgkzDIQFCoP
         N82BElHZJjckjv6w+iakucYDA7YTPf94IDt3nvlkijanIo9QPGRos93T8MaYUQYq/Mkp
         long==
X-Forwarded-Encrypted: i=1; AJvYcCXVvXEEsHBYfS7qOrvsqfSMMU7pAsItwEiI+gM+tWfHcIHPc2H6qRqHK1PFQhJxI5DYcLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcDaD7mmp/7qcFJ7yK+Gc8RvUCl/14CzF3xHGGa0NYlSU8NwgP
	uwTEnUHkKHAs6tZ14C258CMkh3u/m1sibYIH1wnHBCrmDukAGBw6X2fAMusTBUP1uV1YTqyv+LY
	Pry1zJflNUcZ8ilYXl74hR40qR+k=
X-Gm-Gg: ASbGncuulawhzUaAYy15+v8cdZ4b/HMm9RKKAkPWIKzIeqoOlubeDsGaO3nPbQ1env7
	JCITdR8LoK2SrCbV/YM45c5twBBy1ug==
X-Google-Smtp-Source: AGHT+IFkINvdLEMB3fpNb6FYuTOO9ADIllBONsEcugbiVOoMPjiLEYZLIQyYlKmQC/ena98+AziVE02RxfsOKJZvRuE=
X-Received: by 2002:a05:6a00:139a:b0:724:ed86:a0af with SMTP id
 d2e1a72fcca58-7257fce12dfmr14634966b3a.26.1733391994615; Thu, 05 Dec 2024
 01:46:34 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Dec 2024 09:46:32 +0000
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqbjxr2m7z.fsf@gitster.g>
References: <pull.1823.git.1730775907.gitgitgadget@gmail.com>
 <pull.1823.v2.git.1733181682.gitgitgadget@gmail.com> <454b070d5bb0f64e11cab993b126ef5d37a3615b.1733181682.git.gitgitgadget@gmail.com>
 <CAOLa=ZRTgJafxDTB_LWGJxGZ_YOP4fO3=s14BHNvPaHEqf4Q_A@mail.gmail.com> <xmqqbjxr2m7z.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 5 Dec 2024 09:46:32 +0000
Message-ID: <CAOLa=ZRDkWymubTQq79+XgttVeK5Ti96wXju_QiDKmy__pTyNA@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] pack-objects: create new name-hash function version
To: Junio C Hamano <gitster@pobox.com>
Cc: Jonathan Tan via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, johannes.schindelin@gmx.de, 
	peff@peff.net, ps@pks.im, me@ttaylorr.com, johncai86@gmail.com, 
	newren@gmail.com, Derrick Stolee <stolee@gmail.com>, 
	Jonathan Tan <jonathantanmy@google.com>
Content-Type: multipart/mixed; boundary="000000000000189dfa062882c620"

--000000000000189dfa062882c620
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> karthik nayak <karthik.188@gmail.com> writes:
>
>> 2. Generally in hashing algorithms the XOR is used to ensure that the
>> output distribution is uniform which reduces collisions. Here, as you
>> noted, we're more finding values for sorting rather than hashing in the
>> traditional sense. So why use an XOR?
>
> I am not Jonathan, but since the mixing-of-bits is done with XOR in
> the original that Linus and I wrote, I think the question applies to
> our version as well.  We prefer not to lose entropy from input
> bytes, so we do not want to use OR or AND, which tend to paint
> everything with 1 or 0 as you mix in bits from more bytes.
>

Thanks for the answering. My reasoning at the start was more of my
thoughts on why XOR could be used here and your explanation makes it
clearer.

> Anyway the question sounds like "generally when you take tests you
> write with a pencil, but right now you are merely taking notes and
> not taking any tests. why are you writing with a pencil?"  There are
> multiple occasions that a pencil is a great fit as writing equipment.

I'd say my questions was more of "I know a pencil is used when taking
tests because of XYZ reasons. On similar lines, why is a pencil used
here?" :)

--000000000000189dfa062882c620
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 8d6182c1c6f42c29_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1kUmRuVVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNHhhQy85UEk2MUx0S2J1ZDhxYlpPZVJaOHBBeitTVgprVFc3OFRKcXI5
QmtjT1NFTGNUdXRPNWhpVHVKcTY3UXBOYU5Eak93Y2QxWGdnK2pKNVp3MHdvSTFJdFNQaWFHCmlv
TzYyNVVrU3FnaGVqYm5NMVNFYUltWjRQRFAxUjhOa2wwWG93QmxhUjBEcnZybnpILzVUdzdrcUJv
R1RndlkKSVpSUWRGYUptL3NWTlp5Q2xqbEd4WFhLZzVmTW1pU05qdUxsZG10bEhqanpTSTNpTFVK
RkVrYUUzT1h0OER5TwoxNDMra0ptems0dkR1WlR3azFyRnhuc3VCam80RjE5WHVOdmFhZVROM1RR
VnB0bnVYbWJ6bW1tdjdFck1GSUgrCitjV29CdlBZdmNnU2drS0FyQlVIMnRxdWR1MXVCM0hiUDQ2
Y1VjTkNVUDdIWW8wYTdhV3NxbXJpN1hkcTJRVUIKM3kwMWlHc01Fb3ZhOHVTQzRPc2ZkSWJGTDdw
cXRyY3d1UVdGbHpTSmw0YXlpeTdxaHBESDIyaGQzblVLOWkyUwpFR0hDQ1BONW1SK1lxdVUwaHhr
allaK1lXSFhZeVlLOUloWERMdTRMdzc5M2RmWk40d1ZyQnQrUElsM2trRkxpCldoM2poWUZNeG81
MVBqeUZwSFZvWjlBZWIzYTF4Z0J0OU5VMlNKOD0KPVFQdDkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000189dfa062882c620--
