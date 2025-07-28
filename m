Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571EA1B412A
	for <git@vger.kernel.org>; Mon, 28 Jul 2025 16:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753721678; cv=none; b=XJE4Fa1DvhC2i03x31BaKjDIveIZt7niLG1p5X7N5QRDIDc9Rj9Nhvgd2h7B7lwOqTacB4V3xCnSGPdsVQ6+tHrvImjOWzNcUd/UyZDfkcpV+odg29xIoOJLlUDDFOSkn1xu/B0FAdR3j8Dw4XiNUy3K8sc2/FeVErgO75CVd74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753721678; c=relaxed/simple;
	bh=Ksul4gWSLTjSYOkXMtG0kG76NxZBTk9ft5MGGDj2epw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GhLdtOTumky7wfex+QSf+FLIgQ9yuHCRvMC4G1C8L5fctszl1BI8A4DqmY2C9nmA7Pj3jniRxpEjA5Elj2gwY9MvSDTqnsBr2EEICwUt5NUPStedlJQ9WSetlw/PPtOerh10fB5sNna1EZL9nB892u8iHokXVNZa4uOBhz/HXCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NDksj4GW; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NDksj4GW"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ae35f36da9dso959091466b.0
        for <git@vger.kernel.org>; Mon, 28 Jul 2025 09:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753721675; x=1754326475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHBlUmzr/48UqkiuCF22y6x+WOiEPn5pNLUhbf3hv9U=;
        b=NDksj4GWnxo8c/zB825y9Wb6fcQI1eCHQvcjcYfWk3HfBI1O2fhNpQagKLLlauH41K
         gbxhqhIPfe4mjuzXN2tVkhDYHslGA1cjdiv0qb6ATaDbxIwhe0WfkG5cbitlYKPza+KE
         L/9WSb9NYcMDRPGT0s2bxp4nkfFk89T6Nvl029E2PyPSuvTeE1NvOrIyfSj7eeZudHUC
         ZtX2rHrvYrsiUaNhygdYxnCw1ZKhxsAY5C2K/JMRouktHSD1Z6RgRyztMVxdibjKazH+
         x18kl/cVinVVlagj7PHo/MQoqT4va270J8CjlDAeUUeVg5A3hYabBVfsTIYwSVe1saOe
         wAcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753721675; x=1754326475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lHBlUmzr/48UqkiuCF22y6x+WOiEPn5pNLUhbf3hv9U=;
        b=HO35LlSvcEaiGTwv0EG8K5FoFkT1tsmudFsTZXsEeXv690gIE1dTvBoS6Mlq4i7lHZ
         sbB47aGwdsGMbjgqbZ1cgfIDgxCw37XReBs36hEyHte7LVSKsIWWIfrtwpA9vFeSjIFW
         vTiO26MpLxlU4Bd4+lFxDSNk/6lysGdld1iKWDAczqPVUVc1aDtU/xsNapPF95mf93Tg
         sjcoquCtGNU40TpkmpSxHab47dahWJ8MjW6lgyKP+MUojI6VJJDNXNeoi0UhQiZRZkmG
         FAS2f15gxTiXSZn/kUedBnioE3h/dZBhs0EvQDW3tDiaOh0gS6lGlN9JEzYQ2dUCOQuS
         VWuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnTGkb5WZv/59Q35BZzN7PT1Z7TPJX5dB/ejhNa8Qul96PZZ32qfhnyEr/memn6SGX8jA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz8FrRTalqgsENV/pyp4UkG67BZwd9aNzJ7BEr3pW88yLxLYuH
	Cob0vhgZy6Ch+FQI/ZEAw+l+YyrO8oKQWmaKwzMD2APZ0wmrc/wD9KJvw+Xe7ri3bfHTUVYITjA
	JMnQ2cGXEkn9Apxdw4RUACPlL9TCRdcM=
X-Gm-Gg: ASbGnctbcP+2hwoObvdWYWnLJoEKTZJUgsqX0QPn5IaA33O/kVPppIMwi9EbcjLblvQ
	oee+9UUHZz9POzB340P1ykHq5LjbaCRJfp/XuQj0P/ZTc5muDj5M1gM0Yi5pOW2MhKbVFgtFFvk
	xuRjbXSwkhIKFmZ2faoxCVGSWsevhgu3JN/Mp0YFHTWeUeGpJXatYdTGIZG0Rg6T59rvuDJ9dKk
	FIIIwcA7hAKptfinW0VrnIKPN5esTLwswU25W2WbA1Zpd4T/NxB
X-Google-Smtp-Source: AGHT+IGdCj6GeV/jiL8noFBJ/ZBnRJ1op9hsi/fkPYi7AgkJq4mReeMO5nCQyjCTpw1Pv3t3tZMRBME50U7Vws++LRA=
X-Received: by 2002:a17:907:6d09:b0:ae6:c561:764a with SMTP id
 a640c23a62f3a-af616d05700mr1346478166b.2.1753721674354; Mon, 28 Jul 2025
 09:54:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87y0slp23s.fsf@arch.mail-host-address-is-not-set>
 <xmqqecud145v.fsf@gitster.g> <CALnO6CC+Tn5xFYcHwH-M7kLNt2+gut7Okx7fCuWRdOsQHoDWFw@mail.gmail.com>
 <xmqq5xfcz7d6.fsf@gitster.g>
In-Reply-To: <xmqq5xfcz7d6.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 28 Jul 2025 12:54:23 -0400
X-Gm-Features: Ac12FXwVjnV5yWZVVD3fxmrtTmnfEZ1YJzMyHalbg0vPEvVYfr-MnJ4ixiCholI
Message-ID: <CALnO6CDAAOkWJZUvkaeyWrhvRF5j2MhDcvASTS-Cof+B48qTbw@mail.gmail.com>
Subject: Re: A Question from a Hopeful Future Contributor
To: Junio C Hamano <gitster@pobox.com>
Cc: Eric Frederickson <ericfrederickson68@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 11:02=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> "D. Ben Knoble" <ben.knoble@gmail.com> writes:
>
> >> >> * "git status" on intent-to-add index entries (say "I" in the first
> >> >>   column instead of "A" for short status, add "(needs 'git add')" a=
t the
> >> >>   end of "new file: $path " in long status).
> >> >
> >> > I am interpreting this todo message as meaning that the following be=
havior
> >> > should be implemented:
> >>
> >> I think that was done long time ago.  The entry may have been a wish-i=
tem
> >> in April 2011, but not anymore.
> >
> > At least in 2.48.1 and in git version 2.50.0.rc0.48.g74dbe4346c, this
> > behavior isn't present. So I wouldn't call it "done"=E2=80=94maybe ther=
e was a
> > discussion that it shouldn't be done, though? I didn't search the
> > list.
>
> I didn't either, so this response may not be adding much value, but
> I think the intent of the above entry is so that the output allows
> users to tell between already added entries and about to be added
> entries.  Perhaps in an ancient version of "git status" did not give
> enough information to allow us to tell the status of the index entry
> for the path and the status of the working tree file for the path
> separately, or something?
>
> In any case, we do not need to add anything to achieve that today.

[snip examples

All fair points, and matches with what I see=E2=80=94I was expecting to fin=
d
something more explicit about intent in the output based on the todo
item ("_I" vs "_A"; "(needs 'git add')" or better verbiage), but
you're right that the existing output does indicate the state (if
indirectly).

--=20
D. Ben Knoble
