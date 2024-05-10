Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A23B22F19
	for <git@vger.kernel.org>; Fri, 10 May 2024 18:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715365577; cv=none; b=sr8sdKABEaOokD25JpIzjyV/j3QwqxBRHB0xZCIhr+goCxF0qJNA+/IFaRQnGNHqt56kjaxM3qO6TkSZVzl9KvKs1NbmAZLgyeGqrNblVejI2vhMT2YHyACYYKgaFA5eorSVAfBV5eQdRrOEPSW8/vS19Bjf92kQn4HjkUmwn6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715365577; c=relaxed/simple;
	bh=Y6l1zQtULSyCbt0RFjBN3DeUnYvBzOQ945rIGAu/BCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c9PMRfy6s+65BdUfAXiMmg92Lxszbn6d2bm1VyWghpvKxqCoF92r9caxt9LSVi/2hcwBRUMP6vJQrWc+3+qWFb7Rl+uN7aOJXmWUTCzNeDPp5IV7ORhTMG+QhK0ibOpbdxx7fqsA+BfhS+BmZ11mLNeUlG7hbMOomrzmIpYGQFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net; spf=pass smtp.mailfrom=gree.net; dkim=pass (2048-bit key) header.d=gree-net.20230601.gappssmtp.com header.i=@gree-net.20230601.gappssmtp.com header.b=nROn3Czo; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gree.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gree-net.20230601.gappssmtp.com header.i=@gree-net.20230601.gappssmtp.com header.b="nROn3Czo"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-de60d05adafso2309294276.2
        for <git@vger.kernel.org>; Fri, 10 May 2024 11:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gree-net.20230601.gappssmtp.com; s=20230601; t=1715365574; x=1715970374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KB2o/sYgHuJrCCPlKMfllTVDV+Ti83YijZlQtXojR44=;
        b=nROn3CzodA0FtlyfG4Af9Wtd94vxZHCmZp1Y5cwbxAAik0tJRpUFU3uus2SSBySXAb
         B5SwRp7Zz6rGpF7RAkrSRToUu7IhXpcxXqw40aZg9vBMKrAuAEnsexirVzpokLVhEu2j
         peJn1j6Bxb7xYxp8FROn4BEOp3Q9l4t8M6y5Kxut9RFlGty+bwqOBXMefqmh5Qvn8A4a
         aZbrfKKPJeKUs3XOIyx6m/N45Nq1070hTExtDPMvInaQk1FIDrtaeh6cuWY245FOL7eF
         pPmV2CguFzcKWxRXt9Lstvb+6vEvlP1l5TL44E/bmJmtyRVwcwa2gAsOlBz/uDmFE/6M
         DrzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715365574; x=1715970374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KB2o/sYgHuJrCCPlKMfllTVDV+Ti83YijZlQtXojR44=;
        b=a529ei0RF/b2lFG0d4SvS2ENWwDenhqTLQI38j01nn8Nq7N6mr5SgLqNKSJITKJQLQ
         v9Ktl6l+gIIDAoQzDbwzbNde4TEOOsTgSG1i4auPFzP4VGe3bCU2NT6y/UjfZ/qZONSA
         t2wwZhUYnyECdsZkwVrVsmtn2MHZZ9V1cfKP+mZA0tEwnx7f06hugyy7aGqfr38AS3/+
         P0xVmLjLuzkYppoXVpJ7iMOsi4knwU93DQHe/RZ2uRhSYJZS9YWs1uJRTMNn62p9juLZ
         XU9Y/Npj+qJ/FBlC1aKjSpVSKiB9eUpGO8Lj6aNlaFsrlvLlbdqszrbBt6VdKZ7xwHBM
         vVLA==
X-Forwarded-Encrypted: i=1; AJvYcCXc9RyHtWBOJk2OP/72NPDI1Jst7xpQRWCQnM0BGzOK1l/V4WCHaVRVcu+ZKk9wFXjmcZjDlCxRzQuUfkhGajWRb0Ps
X-Gm-Message-State: AOJu0YxElA4iEbbVSkp0qf/huBc8SkVk/KvB3EgMp3NSWI30biXexr5l
	6XJOnrAVwHkAuD+oy56oo9ONf8HfpE4syAgXgzqeC94oWWQD2xESylaM69kff5Vwqj+T0+n6lBs
	yvYo31FuBZF8UpdknmrWqpBjSkaOuGowG4Nx1iZFfcD7CxVZ7yL/SEfx8jVKBfFNJ+dZSbh5qCT
	Cwi6Zy539F9ZoQ37ZzMxiwDDqHWbrv5CALd64k5GOPOTfcZIr32MmI0YbA2MRITfmvRE971fWv5
	izCczqeVUgIcyXdizWzZMr1lP3/5ccM632SZNbtP3CxfYb9f5UM4HwFfqXsVi0Zx1fEmp8yFvR1
	ZrQq337gKuI=
X-Google-Smtp-Source: AGHT+IHIoiKWNm2prHkNZQZDoZUDeErZ0QEhO6L9lxPCg9aKr8ja+jliWLui3uaXzTDS1uDkC/6Pt70zi14ykzSttYo=
X-Received: by 2002:a5b:f4b:0:b0:dd1:55b6:e671 with SMTP id
 3f1490d57ef6-dee4f32d021mr3704051276.21.1715365574050; Fri, 10 May 2024
 11:26:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1729.git.1715328467099.gitgitgadget@gmail.com> <C0C8F71D-2A01-4C31-9EB6-AB31FA17C3AB@boanderson.me>
In-Reply-To: <C0C8F71D-2A01-4C31-9EB6-AB31FA17C3AB@boanderson.me>
From: Koji Nakamaru <koji.nakamaru@gree.net>
Date: Sat, 11 May 2024 03:26:03 +0900
Message-ID: <CAOTNsDzveWCr4wx2vqJF_YfRkF5QyhHpopqfw-CiG2xcNduC2Q@mail.gmail.com>
Subject: Re: [PATCH] osxkeychain: lock for exclusive execution
To: Bo Anderson <mail@boanderson.me>
Cc: Koji Nakamaru via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for detailed insights.

> SecItemUpdate returning errSecDuplicateItem didn=E2=80=99t make sense to =
make sense to me so I had a check to see what scenario this happens and it =
appears to be a scenario where updating in-place fails but replacing it ent=
irely succeeds. However it seems the item might have ultimately still been =
updated: https://github.com/apple-oss-distributions/Security/blob/0600e7bab=
30fbac3adcafcb6c57d3981dc682304/OSX/libsecurity_keychain/lib/SecItem.cpp#L2=
398

> The behaviour is a bit odd and the associated code comment referencing an=
 Apple bug number is perhaps is indicative of that. I guess it perhaps make=
s sense if you are holding references, but that doesn=E2=80=99t apply to us=
.

> I wonder if a fix here could be to treat errSecDuplicateItem as a success=
ful operation for SecItemUpdate. Can you confirm the keychain item is succe=
ssfully updated in that scenario?

I tested osxkeychain with the modification at the end of this note and
got the following log for
"git fetch --all --prune --recurse-submodules". SecItemUpdate()
sometimes returns
errSecDuplicateItem but the keychain item seems okay -- its value is
correct after the command
finished -- perhaps because one of successful operations stores the
correct value. Even if every
store operation fails, perhaps the originally stored value is kept and
no damage occurs.

  XXX: get
  XXXX: protocol=3Dhttps
  XXXX: host=3Dgithub.com
  XXXX: wwwauth[]=3DBasic realm=3D"GitHub"
  XXX: store
  XXXX: protocol=3Dhttps
  XXXX: host=3Dgithub.com
  XXXX: username=3Djenkins
  XXXX: password=3Dghq_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
  XXXX: -25299
  XXXXX: 0
  XXX: get
  XXXX: protocol=3Dhttps
  XXXX: host=3Dgithub.com
  XXXX: wwwauth[]=3DBasic realm=3D"GitHub"
  XXX: store
  XXXX: protocol=3Dhttps
  XXXX: host=3Dgithub.com
  XXXX: username=3Djenkins
  XXXX: password=3Dghq_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
  XXXX: -25299
  XXXXX: 0
  XXX: get
  XXXX: protocol=3Dhttps
  XXXX: host=3Dgithub.com
  XXXX: wwwauth[]=3DBasic realm=3D"GitHub"
  XXX: store
  XXXX: protocol=3Dhttps
  XXXX: host=3Dgithub.com
  XXXX: username=3Djenkins
  XXXX: password=3Dghq_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
  XXXX: -25299
  XXXXX: 0
  XXX: get
  XXXX: protocol=3Dhttps
  XXXX: host=3Dgithub.com
  XXXX: wwwauth[]=3DBasic realm=3D"GitHub"
  XXX: store
  XXXX: protocol=3Dhttps
  XXXX: host=3Dgithub.com
  XXXX: username=3Djenkins
  XXXX: password=3Dghq_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
  XXXX: -25299
  XXXXX: -25299
  failed to store: -25299
  XXX: get
  XXXX: protocol=3Dhttps
  XXXX: host=3Dgithub.com
  XXXX: wwwauth[]=3DBasic realm=3D"GitHub"
  XXX: store
  XXXX: protocol=3Dhttps
  XXXX: host=3Dgithub.com
  XXXX: username=3Djenkins
  XXXX: password=3Dghq_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
  XXXX: -25299
  XXXXX: 0
  XXX: get
  XXXX: protocol=3Dhttps
  XXXX: host=3Dgithub.com
  XXXX: wwwauth[]=3DBasic realm=3D"GitHub"
  XXX: store
  XXXX: protocol=3Dhttps
  XXXX: host=3Dgithub.com
  XXXX: username=3Djenkins
  XXXX: password=3Dghq_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
  XXXX: -25299
  XXXXX: -25299
  failed to store: -25299
  ...

This issue however occurs only when fetch.parallel is configured. If
fetch.parallel is not
configured, we should not ignore any error (including
errSecDuplicateItem). Also, the above unstable
behaviour is essentially caused by running osxkeychain instances in
parallel where some of them
treat "get" and others treat "store". I've also considered treating
errSecDuplicateItem of
SecItemUpdate() as errSecSuccess, but ended up with the current patch
for these reasons.

> A broader Git-wide question that you perhaps don=E2=80=99t know the answe=
r to but someone else here might do is: why are we spamming updates to the =
credential helper? Every parallel fetch instance performing a store operati=
on on the same host seems unexpected to me, particularly if there=E2=80=99s=
 no actual changes.

I agree on this point and would like to know the reason.

Koji Nakamaru

diff --git a/contrib/credential/osxkeychain/git-credential-osxkeychain.c
b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
index 6a40917b1e..0373857731 100644
--- a/contrib/credential/osxkeychain/git-credential-osxkeychain.c
+++ b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
@@ -308,10 +308,12 @@ static OSStatus add_internet_password(void)
       NULL);

  result =3D SecItemAdd(attrs, NULL);
+ fprintf(stderr, "XXXX: %d\n", result);
  if (result =3D=3D errSecDuplicateItem) {
  CFDictionaryRef query;
  query =3D CREATE_SEC_ATTRIBUTES(NULL);
  result =3D SecItemUpdate(query, attrs);
+ fprintf(stderr, "XXXXX: %d\n", result);
  CFRelease(query);
  }

@@ -333,6 +335,7 @@ static void read_credential(void)
  if (!strcmp(buf, "\n"))
  break;
  buf[line_len-1] =3D '\0';
+ fprintf(stderr, "XXXX: %s\n", buf);

  v =3D strchr(buf, '=3D');
  if (!v)
@@ -414,6 +417,7 @@ int main(int argc, const char **argv)
  if (!argv[1])
  die("%s", usage);

+ fprintf(stderr, "XXX: %s\n", argv[1]);
  read_credential();

  if (!strcmp(argv[1], "get"))


2024=E5=B9=B45=E6=9C=8810=E6=97=A5(=E9=87=91) 23:58 Bo Anderson <mail@boand=
erson.me>:
>
> Interesting.
>
> SecItemUpdate returning errSecDuplicateItem didn=E2=80=99t make sense to =
make sense to me so I had a check to see what scenario this happens and it =
appears to be a scenario where updating in-place fails but replacing it ent=
irely succeeds. However it seems the item might have ultimately still been =
updated: https://github.com/apple-oss-distributions/Security/blob/0600e7bab=
30fbac3adcafcb6c57d3981dc682304/OSX/libsecurity_keychain/lib/SecItem.cpp#L2=
398
>
> The behaviour is a bit odd and the associated code comment referencing an=
 Apple bug number is perhaps is indicative of that. I guess it perhaps make=
s sense if you are holding references, but that doesn=E2=80=99t apply to us=
.
>
> I wonder if a fix here could be to treat errSecDuplicateItem as a success=
ful operation for SecItemUpdate. Can you confirm the keychain item is succe=
ssfully updated in that scenario?
>
> A broader Git-wide question that you perhaps don=E2=80=99t know the answe=
r to but someone else here might do is: why are we spamming updates to the =
credential helper? Every parallel fetch instance performing a store operati=
on on the same host seems unexpected to me, particularly if there=E2=80=99s=
 no actual changes.
>
> Bo
>
> On 10 May 2024, at 09:07, Koji Nakamaru via GitGitGadget <gitgitgadget@gm=
ail.com> wrote:
>
> From: Koji Nakamaru <koji.nakamaru@gree.net>
>
> Resolves "failed to store: -25299" when "fetch.parallel 0" is configured
> and there are many submodules.
>
> The error code -25299 (errSecDuplicateItem) may be returned by
> SecItemUpdate() in add_internet_password() if multiple instances of
> git-credential-osxkeychain run in parallel. This patch introduces an
> exclusive lock to serialize execution for avoiding this and other
> potential issues.
>
> Signed-off-by: Koji Nakamaru <koji.nakamaru@gree.net>
> ---
>    osxkeychain: lock for exclusive execution
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1729%2F=
KojiNakamaru%2Ffeature%2Fosxkeychian_exlock-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1729/KojiN=
akamaru/feature/osxkeychian_exlock-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1729
>
> contrib/credential/osxkeychain/git-credential-osxkeychain.c | 3 +++
> 1 file changed, 3 insertions(+)
>
> diff --git a/contrib/credential/osxkeychain/git-credential-osxkeychain.c =
b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
> index 6a40917b1ef..0884db48d0a 100644
> --- a/contrib/credential/osxkeychain/git-credential-osxkeychain.c
> +++ b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
> @@ -414,6 +414,9 @@ int main(int argc, const char **argv)
> if (!argv[1])
> die("%s", usage);
>
> + if (open(argv[0], O_RDONLY | O_EXLOCK) =3D=3D -1)
> + die("failed to lock %s", argv[0]);
> +
> read_credential();
>
> if (!strcmp(argv[1], "get"))
>
> base-commit: 0f3415f1f8478b05e64db11eb8aaa2915e48fef6
> --
> gitgitgadget
>
>
