Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FAC34252D
	for <git@vger.kernel.org>; Wed, 12 Nov 2025 16:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762966335; cv=none; b=Fbag0eX21ERaqtQI6dY0BeGU36XXMwugTa69NdkrcAMQ8uer4134erJBdzkpl5c14hZB2CJ8mNxCo8iIVJl9vROXr/+FYz7PcGxytJQ9eHnbtz5oEuNrokylZlapeG5ZoWxI+yK8l+AxBny54lCaaYUTvi2BOVZnIwFJz6mfFek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762966335; c=relaxed/simple;
	bh=pzjKjXiwFsqTFZweTR3EfeFeEhqhRxIybuDZ1yBUyWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fq3Ue3tCE1TaAGVwvYFP2lQ432OUot5KOXnPPN27FsHMWYatl+HNmybSoKj/dPH2wiJj7Qbocl0r6pGBUSVdm8+eulwxntKaUm5jH3FFUev5HBqnaQ4+3ybynMfMe5deERZqULWYrDtWMSEl7URiJKMKxpJFLvRFk58/gSXe5fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MYPM8DuF; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYPM8DuF"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-297e264528aso9806115ad.2
        for <git@vger.kernel.org>; Wed, 12 Nov 2025 08:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762966332; x=1763571132; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QYfuOLeaQi7NlgchXqXG0aPm/fV+H0Aj8ZA95UbKtvM=;
        b=MYPM8DuFQhxoJWjUb8FtttrGP0/es1wSpYsRvW3y5GQ5KtcgPPNw5hqOLW24Nd25mt
         GH02MeFECKp3NLVaPx/Qv5xurG4NJ/E8JZZkPr7WE8GX/Kf2X6Vy0GvqpGJP/GBhCMc8
         aaGeHOUvB9W3KmxP5dxlcQBuxi/7YcKOKS7+VQAoM0C9isj2vN2cVxT11LzsdpxtNu0B
         evT73yZQQchNI6nYSzQchDCX0A7qWRpjJmCS00W07xqAP8t20jrgF9tImzAGVpXQ77VZ
         HejftFcix59w5et8OMNrgsLzc43UG39czSpWA8flqkVbwfiuxrqgx+nTobQyuhI63VEy
         nWDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762966332; x=1763571132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QYfuOLeaQi7NlgchXqXG0aPm/fV+H0Aj8ZA95UbKtvM=;
        b=ZzR4i1mJX8oecpmmbE2TeN13rhfwxEicMYyCqdipNYxbEmkROGJvAH49kteblg634A
         aCFXlwYzbZmhb/4deMwW6utFGuD4u7KxbbQ30VJh14jvZbBUp2NjJUSqFl4lV9LN7GKV
         JyieElzFzMmsitQ1wTYKolsxbfyMPDadX8nAilj2uc8PgD1gT/lzFmK/48RfkXA/TZwV
         akYVDdt9ykE+Enw1U7eV7Twrl2zjbBITcm9bJHguiLNi8FlrP6eYVpMwvF9wnC2i+jEc
         ufogL0L+1uTXnZVs72r+xtzYplQYAZqKAkpjAjweg+3pO6jxAhPuHeMk+CNSPGH//N3E
         jpzg==
X-Forwarded-Encrypted: i=1; AJvYcCVCjUVRzEq3Lwx8AJcEUgual1Eig1ZbRtoT2cdldxUn/fU9wABOHYQo+LTQYKN1ky3c920=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzui3r4MPmfuHDHwNKTDeUVHyhDcSc9J/PcuGTwM2gwc53g8Ys4
	jDmTFeZAr6Jc9jtF++Ev78+IXTYmY4V/RAVBy21oC9pJ9m7IFEdsuAE3w8ldgyfVO+Ua8QLL2Q+
	S8Z/b2gPaQKNs0JqRFYIQAW1evbVNtNE=
X-Gm-Gg: ASbGncv7WiuUQ/oD3fHlihjBg0KTzA3Ny3kYw6wO7CFeIRJdaP3LNQI8ZqFf9Rc3Pzd
	GCjZ10bM+UrPc1dPOJFRN7lSC2SIstpxYNKE2fx5AP/vXLkc4XCvhtD9iSsa5UhN4MMC1iLTDKK
	lBm3pr4ItajFS07Yzt9x266ViPE4YJNxuhglh8MESIc96IZWeUbPKca38IS/DS22m02egSHj3Lq
	BEAQBt2x6SS+pwniuWMAfmBMX11FlxACIYH6gBSevwdfLjHtQz0zJBFwYYXRWe8C3GxxXiq/fLJ
	qhVq3vD6fkeR
X-Google-Smtp-Source: AGHT+IE8WRDY2niM8eevWh3B5ogQKBqxUxzgpBshzdf/ixe9+6gDyWXLjJZf5/834hvWvmNy6YrvLYk7pq5tBjc4GaA=
X-Received: by 2002:a17:902:ec89:b0:297:d764:9874 with SMTP id
 d9443c01a7336-2984ed46fe0mr47112845ad.21.1762966332277; Wed, 12 Nov 2025
 08:52:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1997.git.1762683774166.gitgitgadget@gmail.com>
 <6be20c41-15a0-4732-bd12-4927a59a9f59@gmail.com> <aRIoleD6nP-kA4Xn@fruit.crustytoothpaste.net>
 <20251110201136.GB127132@coredump.intra.peff.net> <CAOLTT8RweGOmxNK=vKDv8w-8AJM7QUfLBw4WOKeY1EpSVeB6iQ@mail.gmail.com>
 <20251111191508.GA1907007@coredump.intra.peff.net> <xmqqh5v0wcif.fsf@gitster.g>
 <20251111213339.GA4053071@coredump.intra.peff.net> <xmqqwm3wut8i.fsf@gitster.g>
 <20251111222335.GA4054883@coredump.intra.peff.net>
In-Reply-To: <20251111222335.GA4054883@coredump.intra.peff.net>
From: ZheNing Hu <adlternative@gmail.com>
Date: Thu, 13 Nov 2025 00:51:58 +0800
X-Gm-Features: AWmQ_bmOm9dnuVP7n5DLcFvprSwgAfhx7Bf8jEsTUqy-uZiJwkZZajhTpMSPxsI
Message-ID: <CAOLTT8RyH7nJzzeva6Kjn+mvCjGF3mCSLTLcUH-yeEH0+3LL0Q@mail.gmail.com>
Subject: Re: [PATCH] commit: add --committer option
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	phillip.wood@dunelm.org.uk, 
	ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jeff King <peff@peff.net> =E4=BA=8E2025=E5=B9=B411=E6=9C=8812=E6=97=A5=E5=
=91=A8=E4=B8=89 06:23=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Nov 11, 2025 at 01:58:21PM -0800, Junio C Hamano wrote:
>
> > Jeff King <peff@peff.net> writes:
> >
> > > I just mean being able to do:
> > >
> > >   git commit --amend --author=3D'Foo Bar <foo@example.com>' --committ=
er-is-author
> > >
> > > instead of:
> > >
> > >   git commit --amend --author=3D'Foo Bar <foo@example.com>' --committ=
er=3D'Foo Bar <foo@example.com>'
> >
> > Ah, I see.  Like
> >
> >     git -c user.name=3D'Foo Bar' -c user.email=3Dfoo@example.com commit=
 --amend
> >
> > Makes me wonder if we want user.ident that covers them both ;-)
>
> Hmm, I hadn't thought to use "-c" config for this. That makes me
> question the utility of --committer a little bit. ;) I guess it is
> slightly more convenient than "-c" in that it will trigger the
> find_author_by_nickname() magic.
>

The advantages of --committer over -c user.name -c user.email:

1. It's symmetric with --author
2. A single option is sufficient
3. As you mentioned, it can search for the committer in commit
history (although that wasn't my original intention)

> -Peff
