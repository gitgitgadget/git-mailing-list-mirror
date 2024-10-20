Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EF9746E
	for <git@vger.kernel.org>; Sun, 20 Oct 2024 11:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729422574; cv=none; b=GJ/F41VIZHtV4af2e3fEUrP3/ax84ll/+KfR6WMv/CC1IyqR7GyXfIqqQzz+hg4CGj+Gad8XLzLn+yjQokf+rmL8ONsA9/snzmxEb1gE2DHUnyRsW3HK/3vZlFfqj0WxgIM75FJIFjGTuFI3PQyOHXvuFVkc6Kf/tFs79lcLGrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729422574; c=relaxed/simple;
	bh=JEzhuD+EmLX/UjslsdjqGOB5bK6Ht4NNy/4frJUiLnE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=glVby8lJsYBMazfcaiZ9S6kyZy6+Uf/pv+xHGAUwhHJ9ZbJ3DDxsdOOoiZTUFHD1YoPlgpytp118cvtGF7n1CTCWItMrE9REhY3KjanLkrfpZdZjFoQDe3aiYjUBZ9EETcKluvyEMp45g3r3fm4llTq4IKnpCOxk5SzkoO6QDfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+c9klm1; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+c9klm1"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-4a47240d31aso845329137.3
        for <git@vger.kernel.org>; Sun, 20 Oct 2024 04:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729422571; x=1730027371; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=0wMM0t1Pe/vm5FvdnDJHgmi5gVceVoEQMim1KgxpXZI=;
        b=W+c9klm1NI5pA4Y7+JdJxcpoEHPXun+zIaolZeW/pkz2mcOeaZvSNKcQtF+cvZSc98
         9M1YKAYL8wbjIhH9jRTJ65cr5yfqKJToGmSMlqf3myK0TdxrxBk2Mzjg1RugL3Ff/LwZ
         g+xg+6qmel6Nznp6NIMI03GBggMU4M2Ol27pdbKOWwP3kitnFw7bTRyjiLw8JrcUji2h
         eOipEE4/PG6lX+M/LJdzjDJVWgXEUTiG4qFRUbgUqri8lqWhah349Agh1pfx7N+ELfFu
         /3arol5juzT+Q4Smsj81ly8Dxy5PbcYHAx3wfius/HzPT6CDbSQEOAMLcu1UOZGB2Qxt
         O5Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729422571; x=1730027371;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0wMM0t1Pe/vm5FvdnDJHgmi5gVceVoEQMim1KgxpXZI=;
        b=XwwX6yiThXzWx9ciwf8ams85ETF9R2Voju25DbKYgEPsob0UrQuxqHQUjBoR+Fg6OX
         mLIUTDAhgkCNa/k/gtP8dmSHbdLPr+tW1oHXECx1mJdggai+ClOVp6BTn56xNVwiNFzq
         Rm037HZzPztu/o2HvAIeBM9K0maGvPzeMFuFNHAcUxDb4z/YBnKrjBQS2alzonymR7H8
         k6qEAg6wvvuZwLsfBdmzBguuOZ8VTJt3MWCFJdsVoCWEMVVmb/bPldvYFFv7fFQ8ECOx
         +45CWOJB2RwHzJg2+05RXL6SzR9lf5Cr6f0fNVdaUvMWTpP0YRjVdQJdP/WzhwmAjj7o
         8O+g==
X-Forwarded-Encrypted: i=1; AJvYcCWxsbeOjoMaikGtXXBqX69mVs27c3bhUH9stIqxAg1Fmtziu3SFeaEI4zBd73mZnTQ4seU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpgy6iF8tLpe5gqBONVXMtx4u+pREOCFjsG1ACPN3xDO0os5U8
	/XjEn5JRPryL6eU7bJivzH6+tp4UO8SZBfiNP2xrA2OCrx7rVZwcxtm6UNWZ88AIGlqvRKWJzru
	kEyb9qlT4abfYL6COOg9/RGfz6Xo=
X-Google-Smtp-Source: AGHT+IEGGO4kJgiH9Ka6S2J0TRBasn3vA/yfiJg1EuaXvQcslEpshw6Kc6L2wMzrXjWhDxAUGcYzcgqRsQ03Ev31rMM=
X-Received: by 2002:a05:6102:e0d:b0:493:bcbd:4633 with SMTP id
 ada2fe7eead31-4a5d6a8c469mr6915696137.3.1729422570998; Sun, 20 Oct 2024
 04:09:30 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 20 Oct 2024 11:09:30 +0000
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <91c1cae32098e82033f9b20ead6d1bc8e315da22.1729367469.git.code@khaugsbakk.name>
References: <cover.1729017728.git.code@khaugsbakk.name> <cover.1729367469.git.code@khaugsbakk.name>
 <91c1cae32098e82033f9b20ead6d1bc8e315da22.1729367469.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 20 Oct 2024 11:09:30 +0000
Message-ID: <CAOLa=ZTJqcEOQm8Ns58t6DxEXYn2ws__HDRRAaAhsBkJJFLXmg@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2MiAxLzZdIERvY3VtZW50YXRpb24vZ2l0LXVwZGF0ZS1yZWYudHh0Og==?=
	=?UTF-8?B?IGRyb3Ag4oCcZmxhZ+KAnQ==?=
To: kristofferhaugsbakk@fastmail.com, git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>, phillip.wood@dunelm.org.uk, gitster@pobox.com, 
	bence@ferdinandy.com, me@ttaylorr.com, sunshine@sunshineco.com
Content-Type: multipart/mixed; boundary="00000000000002f3d30624e692a6"

--00000000000002f3d30624e692a6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

kristofferhaugsbakk@fastmail.com writes:

> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> The other paragraphs on options say =E2=80=9CWith <option>,=E2=80=9D.  Le=
t=E2=80=99s be uniform.
>
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
>
> Notes (series):
>     v2:
>     =E2=80=A2 Message: tweak
>     =E2=80=A2 Not done: paragraph wrapping.  I found something else in th=
is
>       paragraph: missing =E2=80=9Cthat=E2=80=9D: =E2=80=9Cafter verifying=
 *that*=E2=80=9D.  I will fix that
>       in an upcoming series since there were four other missing instances=
 of
>       this word and I did not want to add another patch to this series.
>
>  Documentation/git-update-ref.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-=
ref.txt
> index afcf33cf608..fe5967234e9 100644
> --- a/Documentation/git-update-ref.txt
> +++ b/Documentation/git-update-ref.txt
> @@ -55,7 +55,7 @@ for reading but not for writing (so we'll never write t=
hrough a
>  ref symlink to some other tree, if you have copied a whole
>  archive by creating a symlink tree).
>
> -With `-d` flag, it deletes the named <ref> after verifying it
> +With `-d`, it deletes the named <ref> after verifying it
>  still contains <old-oid>.
>

So you mean it would read nicer as s/verifying/verifying that/. Which
makes sense to me, I'd have preferred that this was fixed here and the
others in a follow up patch like you mentioned, but that's okay!

>  With `--stdin`, update-ref reads instructions from standard input and
> --
> 2.46.1.641.g54e7913fcb6

--00000000000002f3d30624e692a6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 52d1b6281ba8bd83_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jVTVPY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN081Qy85ZEMyeTMxeUxvY0NXNEtaKzRNMkhzMUtkOQpoeUVQaDhxeEJq
WmY4Q3RQV3hrbzRLa0lXNDVWS0dzSW40alJvdHlGS3hjbllaem1vN2lhVHhjL2oyOEE2bzVTCitL
NFJaS0ZQWnNuOGcvRit4eE8yOWJMVHJoaHFEMmZjajd3eDJZR2R5M1AySnlBRE9VZDRBWUlFSWNj
cnZGRlcKemE1TjU5QnhDb29IYzVLMzYvL1lnc0ZZaFJaNDJkRE02Tzc4NWpoWTRDc0dMcWJNWEhD
VCtJZy9CWitjZkRRYgpvQU80V0hIN0FteFdRK3Y0ZU5GWENMdjZQOXkyK2hmWDkwcGY1NzZuSHUz
NDU4YnIzOUQ0K3hVekdjUXVsUVl4CmxjZ1BPZTEvUytlb1dDd1Z3RERPV09XMnU1V3JSQkw1dXRC
ME9YVWNpQTNCK0FnQlFLdGdtQ29FbFNvV2dFMm8KMUMzVzV2Y1dMeEVJVlZzWVNRa1RRTVBLbWJJ
WDNBaGNrOVk0OWc3akIzQVJBZk1qeldCNzJFd2w2aHBnWk1hcAp3eElEVFJNS3lVZHhWdUtySTZz
T3RnQ3hEWWJTTlp2cjdUNmhOYUp3L2MwREFxVXp6MGZVQmVwb3hlT1lJNy9BClp6T2JaTG84bkVR
bDBsODVvb1RydEN0Y0NONWVwODVjYldFYzJmQT0KPU8yekwKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000002f3d30624e692a6--
