Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8561C78F4A
	for <git@vger.kernel.org>; Thu, 19 Dec 2024 21:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734643167; cv=none; b=mRivnOfsqgdgclSbBgpyH82Vdn+lY6HSl0ZbBUzw7nIKUYLX3F5tbVfngN58yNewrXfa1OOPun0cHl7SCCvOLiPDUujLkNjkXx3u8DLymmiVy7SmkvWBWy58Mii1W3oU1mDQ1rNq3kWlUKJuXTL1X17oQkUSqqDLCtTnplkEyPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734643167; c=relaxed/simple;
	bh=AJRGdW+PfmWk9dMlHkSTA8ItonCPawlYK0mnqiytGRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OyFASkvzidLGJa0/+Nc+qzOj7EuwpSIyYh5bJDSfO5FUcU3i+/s2MWR64psAAkf06CXsTOZ4lWnhKdAXay7LygODXo48h2+oXpdrDC/HxCK/hkSeYV365fd7Qu27E3LsloJ6zaqVwutRtaciSgnwl4jmJP9MMPQ6t64PYHizm5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4lvmsF3J; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4lvmsF3J"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aa692211331so230521766b.1
        for <git@vger.kernel.org>; Thu, 19 Dec 2024 13:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734643164; x=1735247964; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/BV1nifVOz9RxLKbI6qCmMx+T1BpyyQN9zPBR/BSWo=;
        b=4lvmsF3JU4gFoO3lWlGbGtEaIJWn+OKrzuF39CTlJjI6F88q2xzn8qH7Z0Pf2u2I9F
         AXfKFcx3wnuev85Djohsygma/TLWYOWA0EOAK1EGF7UeYcJ4gGvfvFGOEqsJIQjVOe06
         tyMQ0ARuDAIGAp2qFEsPVzFiMxHYzltz1iUHAPFxJjEio52xCNOg0SZPvx6KvKrCGE2f
         Po5sy5aVLH65ULjG3A4ylyRb+kwl1Y49gRVXQMVzOFBdW1sor/LdnxJqnonxkBbddw8A
         OVamcWt+2UFtQO+xkjwb8aXJTevEzjENgUsVcMLF22EHllse3yOujf8zbtomCymLwast
         y6MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734643164; x=1735247964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V/BV1nifVOz9RxLKbI6qCmMx+T1BpyyQN9zPBR/BSWo=;
        b=KE20rFI0dXiYA+AH4lAa6OwxxOzvw9LKkVOqHGREPV5bUiCtFrG9RIFET5pvr+Chwa
         VMJIYgDJ69WDN55Y0hvvFqFUYrfdWwuw21raKnA35qFFeVSIGZt060Ed4d9+fHKRH8C/
         /RtW3bWM+UBq+EezcvMapAoksci4SszbNh7+GWuoBZBNYeDkRIdZWfGIl9I83fK2jSzV
         0C+ZgqP6KeyErgWQp6MTBb8CbNsWtTR60hzK4j0d7YJ9DOFiDTy2MT2R6zFN2Qn4HJQU
         WIdkHoUs6eFfEeJJWpzaJvkQnopSlxazI9VqtIemEJNXav+Bb0qSRNkuhUVJG2Kmzsbc
         zzGQ==
X-Gm-Message-State: AOJu0YwTCG4zv4Gm4+z9LZflHE/us1zkcysFYXqMbr5dDUufGSW1Ugiz
	0QICpPyMfk0dO/flrUJOZYrgKpu47+R6B0r1R4TfuKf6IAo23I8a4r+dbqWHE2a0JTon8f8lJ1G
	5FZU/IRr6Hbl2jsVzv4FsLK2Uv1DO7ILWk+W4
X-Gm-Gg: ASbGncsJNc/NA/SKc6y2ZHnl4lsTtk9pf9puFEuSMQ7c+iamJGK3STI+9xlsGxAi6t4
	zoRrv0LfBlEnKvlqxnihR2fKLLCMWb428UOHJ/XV9MnIDLP2IY8umwj3pHRokezElag==
X-Google-Smtp-Source: AGHT+IFTUUulGGCsB0TUBIGa24FfCqTLrWFpDf5UEHo4kIIXWVqaKPnnn15X4QufoNQTTQyXLMr+Mn1tKgRu2mWJh9Q=
X-Received: by 2002:a17:907:7208:b0:aac:93b:269a with SMTP id
 a640c23a62f3a-aac3469199amr20943166b.20.1734643163643; Thu, 19 Dec 2024
 13:19:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241219-b4-pks-git-version-via-environment-v1-0-9393af058240@pks.im>
 <20241219-b4-pks-git-version-via-environment-v1-2-9393af058240@pks.im>
In-Reply-To: <20241219-b4-pks-git-version-via-environment-v1-2-9393af058240@pks.im>
From: Kyle Lippincott <spectral@google.com>
Date: Thu, 19 Dec 2024 13:19:12 -0800
Message-ID: <CAO_smVhcai9reesTRSrd=hHz2Sa2T7Bs-U1NZ9KcCN5PNv6T5Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] GIT-VERSION-GEN: fix overriding GIT_BUILT_FROM_COMMIT
 and GIT_DATE
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 7:55=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> Same as with the preceding commit, neither GIT_BUILT_FROM_COMMIT nor
> GIT_DATE can be overridden via the environment. Especially the latter is
> of importance given that we set it in our own "Documentation/doc-diff"
> script.
>
> Make the values of both variables overridable.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  GIT-VERSION-GEN | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)

Looks good, thanks for fixing this and for all the work done on the
cleanups for the build system changes.

>
> diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
> index 787c6cfd04f0a43d0c1c8a6690185d26ccf2fc2f..f8367f6d09ff2ada8868e575d=
6ec8f1f9b27534d 100755
> --- a/GIT-VERSION-GEN
> +++ b/GIT-VERSION-GEN
> @@ -53,10 +53,18 @@ then
>  else
>         VN=3D"$DEF_VER"
>  fi
> -
>  GIT_VERSION=3D$(expr "$VN" : v*'\(.*\)')
> -GIT_BUILT_FROM_COMMIT=3D$(git -C "$SOURCE_DIR" rev-parse -q --verify HEA=
D 2>/dev/null)
> -GIT_DATE=3D$(git -C "$SOURCE_DIR" show --quiet --format=3D'%as' 2>/dev/n=
ull)
> +
> +if test -z "$GIT_BUILT_FROM_COMMIT"
> +then
> +    GIT_BUILT_FROM_COMMIT=3D$(git -C "$SOURCE_DIR" rev-parse -q --verify=
 HEAD 2>/dev/null)
> +fi
> +
> +if test -z "$GIT_DATE"
> +then
> +    GIT_DATE=3D$(git -C "$SOURCE_DIR" show --quiet --format=3D'%as' 2>/d=
ev/null)
> +fi
> +
>  if test -z "$GIT_USER_AGENT"
>  then
>         GIT_USER_AGENT=3D"git/$GIT_VERSION"
>
> --
> 2.47.0
>
