Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8018013C816
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 20:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754339958; cv=none; b=ndmi/7FdAVSMXKh7yKyxtnlbiE00Jh8c0n9UwpOSzed8LIHe9FKgAZRRINSWV1MqImWlLOPOAaDruw3B5ABnk/l4J9ye3KSMgPk0OKpZu1IjvqeCb73DF7xziW69d10H4ss1fkesQJXwKyy1UT64w/kSWaHKcXEAwBTSQIs0F+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754339958; c=relaxed/simple;
	bh=ECzxQGU7Kh+Qhrunm0S+rFlfqVXoNKo4sX8o9EJeKZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JHuH/ehs5VeBOcpgetLdMKyy2py/iYzrnuUBD9RfkD/uZOK7Uh5OuN3theI9/rugmxel7HCKD2ivSHrPM6o7SNBspvtIgttDZ3BI6rnyyTdrJ6P0NRz/ZagsuGAKl2pcNFJt3RoOoLYGZ8aXiRWkzeue5ScugiEAqRiYQJrLsm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hDLf3krA; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDLf3krA"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3322aba45ebso47659591fa.2
        for <git@vger.kernel.org>; Mon, 04 Aug 2025 13:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754339954; x=1754944754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YB5XBlwllKtWqye0BDq6K6I2q2l7fKIvPnICtfSa8ps=;
        b=hDLf3krABpuljxsBwKeqUk/K5Wlr1dGcUlo3cqnnFzLp2NcbZjfG+Scyd0eFk0Nk8I
         skERQldaZOifVMJrzGG6stTfWo/KXi3M2RiSXJWFHaTPNY4zaSv4RMzzSzuMEacLGYVD
         cRkcvgRSR+twkelS7bJ5QD0sPxJbrLmy77ae433XxMS1TvWy1FPbIUU6dbPThk1/SsMd
         2PyZP+gl1CahKpG3bu6BeA9iMHmBs7BOjF5kPVWw5qyautefiPNVEfYfIHI3Rf3oCzMU
         KPq37b6JVqWgjYJ6Svg+jx1vjUhqdo91h5exlhGhxTY3Y4aYoKaNhmt2ddMyL3FnBF/h
         bBMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754339954; x=1754944754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YB5XBlwllKtWqye0BDq6K6I2q2l7fKIvPnICtfSa8ps=;
        b=i//pbEie5edpk+3WfK4n8TIz5rHghhpML3K+flQMIqXDOBTL0E6/tXzB6WwPWXutvd
         xmhKiJGbgp1fLHODWB5xzogkyF+GPO+WeYay9UKh1oI/N6Sn6EjU2ChKAGv6oD0uX819
         R1uAlZ2c/I1oYyLn7ZN0QWt/sVelyqmmVD5sIhsg7ocpnJQdz+a3e/EnECYdq3uKwEcv
         7kxg10H7RQMhkaxD+NP7ijgh1FmgZPCWUPdL9bnZNZ2iJDu7HyxU4wDBGD5zllhvQK0d
         rMmlz6XWO8jg57jmeTMayYKXyzw2f1zzW1hRUta+P8APN5cOhrXRGoywaImrjBaQWEYN
         w6sw==
X-Forwarded-Encrypted: i=1; AJvYcCXTAmtCy2XA93wcdUFJf/JIaPnDc1HtxBiB/7AS3TNoEkNP4lAXWvSId35PyNQiEUcZl5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFO6CIXhN9yuXqcitd4A3QeG4RPRfgLRb668uqu3ok+bqZvwz9
	+yRfEUX6TVegLZqW2bHi7NfochoGUSUxigkKUwDUzBFZ/eKLckPgRsQg8gXXqX4VGJWiFkpK/Ex
	dZ0qcz+i5pN9HqypjeMRB7U3iEyAptyH50wNW
X-Gm-Gg: ASbGncsiPPEBdZV8pQFfmDrBfZpXEHxNEHUaUn7OyLiiVBGL6oNfLmSp5Ro6mNt9qqo
	0nMo0BYNUYhuL794AQ6WvUlcvXAxnbMpnA3qIhsUxRoWBkDfUmjWXtZrbCaATO3WzdPNeKvCkUu
	GqA9e2je5dZdXMm8qycvWVGoYYxf8Lu9g2W8xk2RitLzpgyY61p5YVaiNM+B64iD8H1rDHL7rqY
	fZJjeNuImOxswByjp/L9nCzD5Qp5AjenMunWF8RDbskKjIOKt4=
X-Google-Smtp-Source: AGHT+IG85HYPJanFJyNhndo9PouzUi+ISVrqfO4qnAE7qYGrzywr8ZW/qi0HmOK4vfmOvAw+v6teS3kJ9l3sApLTke0=
X-Received: by 2002:a05:651c:11c3:b0:32a:739d:fac with SMTP id
 38308e7fff4ca-332568125edmr17413781fa.36.1754339954045; Mon, 04 Aug 2025
 13:39:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGW8g7=21pPAgCixjpayEvmw_ns-hcB4e59NP476TKtCRXHPXQ@mail.gmail.com>
 <ZvM39VNFptcfwMGk@tapette.crustytoothpaste.net> <m0r097mv19.fsf@epic96565.epic.com>
 <ZvXMSKaUWWA-MG9J@tapette.crustytoothpaste.net> <CANgJU+Xs-sQgAOCPL-5skaZGq7eHmhg0MaFGDr8N57=CK67iog@mail.gmail.com>
In-Reply-To: <CANgJU+Xs-sQgAOCPL-5skaZGq7eHmhg0MaFGDr8N57=CK67iog@mail.gmail.com>
From: Ron Ziroby Romero <ziroby@gmail.com>
Date: Mon, 4 Aug 2025 21:39:02 +0100
X-Gm-Features: Ac12FXzal7IKl5VzfFlCu-kq2SWeTco6818b6g9EH1Eck5Yr1ijCRulEQzRzV7w
Message-ID: <CAGW8g7kMVqsi6+JkdjDS-czKJQ=01ULUz36sZrGom+QPVtRF3A@mail.gmail.com>
Subject: Re: Pretty output in JSON format
To: demerphq <demerphq@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, Sean Allred <allred.sean@gmail.com>, 
	git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 27 Sept 2024 at 10:30, demerphq <demerphq@gmail.com> wrote:
>
> On Thu, 26 Sept 2024 at 23:04, brian m. carlson <sandals@crustytoothpaste=
.net> wrote:
>>
>> On 2024-09-25 at 18:45:54, Sean Allred wrote:
>> > "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>> >
>> > > On 2024-09-24 at 21:52:35, Ron Ziroby Romero wrote:
>> > >> What do y'all think?
>> > >
>> > > I think this is ultimately a bad idea.  JSON requires that the outpu=
t be
>> > > UTF-8, but Git processes a large amount of data, including file name=
s,
>> > > ref names, commit messages, author and committer identities, diff
>> > > output, and other file contents, that are not restricted to UTF-8.
>> >
>> > This strikes me with a little bit of 'perfect as the enemy of good'
>> > here. I'm sure there are ways to signal an encoding failure. I would,
>> > however, caution against trying to provide diff output in JSON. That
>> > just seems... odd. Maybe base64 it first? (I don't know -- I just
>> > struggle to see the use-case here.)
>>
>> I understand JSON output would be useful, but it's also not useful to
>> randomly fail to do git for-each-ref (for example) because someone has a
>> non-UTF-8 ref, or to fail to do a git log because of encoding problems
>
>
> I dont really follow your argument, and I find it weird how you are talki=
ng about a specific encoding of unicode instead of Unicode itself.
>
> It is possible to represent every binary string as Unicode encoded as UTF=
-8 (or any of the UTF encodings). It may not be bytewise equivalent with th=
e original, but why should that matter? There are a set of clear rules for =
doing the required transformations, and there is a huge body of tooling to =
do so. As long as you know the target encoding, you should be able to round=
 trip data properly.
>
> IMO CBOR would just complicate what should be a relatively simple problem=
 to solve.

Hi. I've been working with the code and trying to figure out how to do
this. I've also started work on a formal proposal. Two things have
come up that I wanted to discuss:

First, I'm questioning my approach of hacking pretty.c with a series
of 'if json' blocks. Would it be better to make a new file,
json-log.c, and divorce myself from the pretty flow entirely? This
would also go hand in hand with changing from "--pretty=3Djson" to
simply "--json"

Second, I see that someone is adding a --json flag to git status[1]. I
figure that argues for git log to use the --json flag. I don't think
that affects me other than making the case for this JSON output.

## References

[1] Patrick Steinhardt, =E2=80=9CRe: [PATCH] diff: add --json output format=
,=E2=80=9D
message to git@vger.kernel.org, July=E2=80=AF29,=E2=80=AF2025.
https://public-inbox.org/git/pull.1937.git.1753856826464.gitgitgadget@gmail=
.com/

>
> cheers,
> Yves
>
>
>
> --
> perl -Mre=3Ddebug -e "/just|another|perl|hacker/"

Cheers,
Ziroby Ron Romero
