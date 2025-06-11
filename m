Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CCD347C7
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 13:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749647867; cv=none; b=V0TucCqaEmxzeZLtb7RwEs59LCf50338GxXW5Ifea9vGbCRwkUU8/HaaELdwRMezlb/EAUuwi6eh7iQFvXAbPE+RBmjksL8f7n4BdTvdTGnQeskRotGHF+a3rj+aHzB3eVQEYq/K7fpY9y8HvMoBhqdY4R75FF1sFDbiX4ZPGu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749647867; c=relaxed/simple;
	bh=/3FKPgtdBAShGLSCkV0bwG7OSEfU4xRaWPha4st0jeA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eBCYuqz4yaCC6dts3bNdwh245eS3wBmO23+Ez4swzyXn8BKcC4bmTZRIP4yMb/q6DqrSgfYEIAgY42dd4RhOK7DFsOvSwEKbCwUCg4p3tOZAUqbmtCsRVipnqkFnBBTCJbDvjafAsjEtX1Pz9HyByboqKZ0uZ9k489kTNBWWFUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gu+P7gw4; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gu+P7gw4"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4a585dc5f4aso90413091cf.2
        for <git@vger.kernel.org>; Wed, 11 Jun 2025 06:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749647865; x=1750252665; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fQbKVPCbYdpJ4YcjoZiGfsad/UHf3eIP7ejzwTqMgAY=;
        b=Gu+P7gw42oxvvYWLo1WaTgjfnZ9lhSZGvMGB5WGm/CWQCNwHOvkn34clXJh5kk5U6/
         qkvMjhnCjvDyxXysqCeFzzSPMXCZIbDVRQS513HHe/F5RsLB/Xk7wokK4wgGi7wTfMz5
         g1H6SHIUzd/Or8Wd1MGHUkxus0I4Rxj6DlLexIVgd1UMqgz1U+qoQWAUuFtHHpVWhBtU
         v8f9RQbJjS7fw8EnKlWiIJ4X0tZxwU83UHsufj+oFcgXZniniVUNUWpLzJHduqfgeP/f
         EsTP49CUlSM3PjwZV0gfn19jXif8FeWYNXCiPovotTs1y5ceOWrwmz1AUHH84s3MU/Py
         bncg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749647865; x=1750252665;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fQbKVPCbYdpJ4YcjoZiGfsad/UHf3eIP7ejzwTqMgAY=;
        b=aC2QQj6HDF4lWe3sXdBQF9Mi73nNiJb8OcTwF+e866maaRPsQ1RaJoOUwuSZYLT5+Y
         q959v/CO93xxC/J2u4Snq2kzZQUR14m71W6WIxiVd/bT3+z512l+xcsB+kgMdAhuS87K
         VZ8fr3W2QUNJlS73fOKxT35YwUBPkjk1Fx/wwOZ+HgwDeW0WzbmM4ed8WmPsVnAk5K0N
         UIiD6MPPINEj/0PYLlhAJwlcDPvCYZWTrzk43+AZcTkI1aKJbnbEEtARKGXjcvc/smWc
         398hJyTc/cK6FOKmSOK4ZebclFl0zljpSTVNTIsfa7QHzDEThAjZLNDN+K92XuGH1IDJ
         dBBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFAwbLMy3475sMyHX3CO8TmcFrHloBNi2QZA069ktm7RKAOsLHq2lB3HdSIzOvJdpB1Ls=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqRA7Y+vL2VItnFf+OnCi2M8r9A7WpowrR2GXGHuWWClZtePpX
	52z5/iTChiU9vfzUPVe2oYIAi4JgF9nVHfoyfiTX55rSkNOL8CCwOOGH7vCTcgrKuq8BczXOWNN
	TKO/ADm8yS9M16TZ+So4zXm7ns2cz0HvVmz7GN+4=
X-Gm-Gg: ASbGncvHo77eTR5wVHl5fm2iqBRzLqT7cEddkg0Cwo8BjOdUvuOHoJXtZ7COY6H/GR+
	ZVX0wAyzuf+Rmn1b+g/udT/9tv3Z27gb3jjEd6V9grZ13PzCjb5k9WH8HF2z7v3Pxx9NOJbHxn4
	P7GAbTf+Cu748RJKWEK/+8+UE4jebZCz7+H+SXvvbjVw==
X-Google-Smtp-Source: AGHT+IGIQ/jpc6Ka38VlM+PshryYbLHff1qMOu1nR7YXH84yr3WvPiHIyw7ceAK+Rg9WrVSG392GBMJLbSJ6Qtg1DIc=
X-Received: by 2002:ac8:6f06:0:b0:494:a235:fcbb with SMTP id
 d75a77b69052e-4a713c2e7c1mr54718981cf.29.1749647865183; Wed, 11 Jun 2025
 06:17:45 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 11 Jun 2025 08:17:44 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 11 Jun 2025 08:17:44 -0500
X-Gm-Features: AX0GCFs5BulSD77dt68eZG9001A7H5E3bsK6lAmbSOfLJu0T-Bwebs13W-dEIEw
Message-ID: <CAOLa=ZQrJ06Se1+kZjCa2Mkhv7Q5gh8ZgtLh0usqZqTBPcVxSg@mail.gmail.com>
Subject: Re: [GSoC RFC PATCH 0/5] repo-info: add new command for retrieving
 repository info
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org
Cc: ps@pks.im
Content-Type: multipart/mixed; boundary="0000000000007cc33506374ba3f5"

--0000000000007cc33506374ba3f5
Content-Type: text/plain; charset="UTF-8"

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

[snip]

> ## Feedback
>
> I would like to ask for your feedback on this proprosal, specially:
>
> - on deciding if the JSON and linewise plaintext formats are the really the best,
>   or if I should consider others (e.g. gitconfig syntax, NUL-terminated, etc)
>
> - on deciding how the fields will be specified. This "<category>.<format>" was
>   a first idea based on the JSON structure
>
> - about the JSON schema
>
> - about information that may be nice to include in the output of this command,
>   even if they are not currently retrieved by `rev-parse`
>

One thing I'd also like to see is some thought/documentation of what
kind of information should go into this command and what shouldn't. For
e.g. should number of references in a repo be part of this command, or
the `git refs` command. More broadly, which subsystem information should
be exposed via `git repo-info` and how do we draw that line.

Mostly to not create a new `git rev-parse` alternative.

> Thanks!
>

I've also gone ahead and reviewed the patches individually and left some
comments.

- Karthik

--0000000000007cc33506374ba3f5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: ee6baad7beac35fe_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1oSmdmWVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNjV2Qy80NXZ5R01DS3J6aHh6NWhMdlpKeUFGcDQySgp4Zjd0SGpidEF4
a254UGpEdk9PMSttMC9mQXpTckNMN29BTi9vMGJ6cm0xUFVoS1VZbnJJK3dDSnJORzdaRXdzClpj
aWhTUWkyTzRyUW1LcDg0aXU1K0RSYXBackhhRkZGaDNMVUNlaUltVFpUNitwVisxdE1xdEttWU1O
b0ZBRUIKNStPTnVaRnlIRDE2TU5UcG5yOUxPWEp2NWVCVEFOa1NhK1NFWlFZb0l5RlgyOXF0Um5U
cUY1MFFGWS9YTjhEMwpYRVpxTE5GUzJvbXJQZTljN2hHY0o3cDhQU3dGQ0RRN295TlkwVWpYVXRP
d3hhaTM1aGxRdlJkWWxFOHFFMklmCmtVN3NVNFc3RmY5NVhsU3ZOK0tVVklGU3ArSjJvdFovbEsy
cmtKMndxRStsUHRKbjBJT0R6VUtyYy9JUXNqQkUKQ3YxQlEzYkxtcWN0Rmo5akVGRkdmd3NhRkdC
U3ArQS93WWkyYjhSci9wSDZjV1pndlFYdHh6RTJGY2NUU2l6UQp0VXhzM2FBb3prWkhiT2QrZk05
SnZiNS9vT05uTEFJWkZiTFlBdFJaWkVoU2YyOGZ6NUNjY1RjWW9Nc2w2MDVhCkRHT2J0UUJGRWx3
bEgvU0R0OGVlNXNXWkRHNDNxWWJxdXp6cTBJcz0KPTFkeHAKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000007cc33506374ba3f5--
