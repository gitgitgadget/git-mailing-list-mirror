Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBD425E45D
	for <git@vger.kernel.org>; Thu, 20 Feb 2025 18:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740077209; cv=none; b=TGvu+eqsZb786dz45jBUqQjUKu/SwKJQZdCLR4rsYzJYWaa5xy8FY7WvBpUoGJfrjYjuSVVCC0xDxXKAV/DpieAo4hME40H+tzInA6b26/50gwqilE9Xr9TrleNoPrdbbJCwoYWFOe0BuccsGFf031K0kHhviRtyf6go1xCe1nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740077209; c=relaxed/simple;
	bh=6YjS769i3wgiojlzWOCMy/lNqtYIB28DTpTbYN5ujVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u/MwEFmKIu+Wa9epTTwM8zlRXHeZV7m7N4KtXybB/PnpHmbRJGeX7J47AR3HMNwNk1hOdLp2dkH3fHUKVoS1Hklnd7MTyBaYG4snEn5UDZZ9uQvu8sNRr54RrOpXs4302ymwWSe19EmH5AoyYSIMQOySfB/9Rb0DoEoPHkfe+5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JNoZ28Vx; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNoZ28Vx"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e0573a84fcso1801242a12.2
        for <git@vger.kernel.org>; Thu, 20 Feb 2025 10:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740077206; x=1740682006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Boil6zN4kC5GadJm/9LCuGQnJDvtEkdilc8+/92kl/0=;
        b=JNoZ28VxFz+RNkIPL592F6XqO7HxKJmy3mweuSyczpgOaNMfxbWxbmfyMKuNOHuvoX
         dlU8lmFN8zZW19CZdPGS7QhHs3/tx5OW5hWLA4t1qAzH1Qqdkkp0Pa7/xf5zvZPF2bZS
         0fTDCeq3dC6LcMtnbdHQcZzNfdy6lBNbNJECK1ZaPcjzgD4wQ1CAPv1DeSzL+Cp1gEIJ
         mhVouVhYbE2AnDSRcYw0tzZ5lHKrjVr0xaPS2Lj8ZfZEfJwvSQi9FzfLClFVNZnmV9j5
         bvyfwPswPvZODJZIdCrgQDRAU6obvzytP2voEulCPZz2giptv42aO1WGnlfNHmhgfieP
         BBAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740077206; x=1740682006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Boil6zN4kC5GadJm/9LCuGQnJDvtEkdilc8+/92kl/0=;
        b=MyKZ4+u0MRq5e2TXY7ENK7WWG8jn98a+ubJJtdnlXdV6IpWHNhOHgbV+jz/wsOSsPH
         J1BYAUkIQ7KZWZxgjk40yPH+8u0f/WWmziIf4EMJYwnmF3wX+q8pBH8lOVPu+abXSMo/
         DnE8723Es8xna0a4vUgMOnG6K2YX2qz/EnSijjarW6qBy8p7GM+agndArW9SpLZe9Shv
         qLO/tkFJRt54DhzatjxxxjjlIHacqxku+qMj7KpKe7812CfylkJXAfMg+qNFv1w7FWAf
         a8DVDAXO5Be5McZh3+71ItsmlIEDrSYS0Y8t1XkqaLKT2XLpPD4vozfuSq3MrACB339Z
         6Hlg==
X-Gm-Message-State: AOJu0YzSV4YJkQVl5c8ONzpCekTPI3d8QkVS770+SRNZXCeWM98CCL/Z
	xIt19QcIhE/3KMRCvgL5M+bdbBo4t3RuyVrbypG+bTqcJVtkx5qkDaM6qetvQHelcHv7z4SON9X
	g+FHesHjhSeGYAqkQZ+eN7VMYyLQ=
X-Gm-Gg: ASbGncuV2f+QvZNAuzD1TThERy6QQzMQ3OGfW7QKYiHalOVYBCr7AeCnIWfPq4Aq3KE
	u95VY13Bg1uTdu7qLbwgndfJ/bd8zLSNona7M60vJcHuMorDRqG3XQjPBINNrHNXJTe2EP7QvWi
	ykxGiMjcaiZmeWf+oEu7yIRSEmSkuR
X-Google-Smtp-Source: AGHT+IH4JiXUgu3Bn+z6L5DKD14g//g14unUktxPUeyrQjgCIyIKJ1VthTWHnUr1nURfFnld7beVDsV5p3VydypQpOI=
X-Received: by 2002:a05:6402:1d4e:b0:5d9:a54:f8b4 with SMTP id
 4fb4d7f45d1cf-5e036049b12mr20776077a12.11.1740077206044; Thu, 20 Feb 2025
 10:46:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220151207.3248-1-lucasseikioshiro@gmail.com>
In-Reply-To: <20250220151207.3248-1-lucasseikioshiro@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 20 Feb 2025 13:46:35 -0500
X-Gm-Features: AWEUYZm6O-sbPbVhoLchC6QsSgVUOyimoiPcPLMuyAC8lGvLu49B6NvIvfj8-cM
Message-ID: <CALnO6CCiBkz=vrzMban86h7uAPZVXq=eLYtbQkffTg8WFJSCdQ@mail.gmail.com>
Subject: Re: [GSoC][PATCH v2] merge-strategies.adoc: detail submodule merge
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 10:14=E2=80=AFAM Lucas Seiki Oshiro
<lucasseikioshiro@gmail.com> wrote:
>
> Submodule merges are, in general, similar to other merges based on oid
> three-way-merge. When a conflict happens, however, Git has two special
> cases (introduced in 68d03e4a6e44) on handling the conflict before
> yielding it to the user. From the merge-ort and merge-recursive sources:
>
> - "Case #1: a is contained in b or vice versa": both strategies try to
> perform a fast-forward in the submodules if the commit referred by the
> conflicted submodule is descendant of another;
>
> - "Case #2: There are one or more merges that contain a and b in the
> submodule.  If there is only one, then present it as a suggestion to the
> user, but leave it marked unmerged so the user needs to confirm the
> resolution."
>
> Add a small paragraph on merge-strategies.adoc describing this behavior.
>
> Helped-by: Elijah Newren <newren@gmail.com>
> Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
> ---
>
> This v2 changes the documentation text to a clearer explanation (as
> suggested in the v1 review), and changes its location to
> merge-strategies.adoc instead of git-merge.adoc.

This version is clearer to me at least, thanks!

>
> This content is duplicated as this works for both `ort` and `recursive`
> strategies.
>
>  Documentation/merge-strategies.adoc | 15 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/Documentation/merge-strategies.adoc b/Documentation/merge-st=
rategies.adoc
> index 5fc54ec060..a7fca249e2 100644
> --- a/Documentation/merge-strategies.adoc
> +++ b/Documentation/merge-strategies.adoc
> @@ -21,6 +21,13 @@ ort::
>         ("Ostensibly Recursive's Twin") and came from the fact that it
>         was written as a replacement for the previous default
>         algorithm, `recursive`.
> +
> +        In the case where the path is a submodule, if the submodule comm=
it
> +        used on one side of the merge is a descendant of the submodule
> +        commit used on the other side of the merge, Git attempts to
> +        fast-forward to the descendant. Otherwise, Git will treat this c=
ase
> +        as a conflict, suggesting as a resolution a submodule commit tha=
t
> +        is descendant of the conflicting ones, if one exists.
>  +
>  The 'ort' strategy can take the following options:
>
> @@ -95,6 +102,13 @@ recursive::
>         renames.  It does not make use of detected copies.  This was
>         the default strategy for resolving two heads from Git v0.99.9k
>         until v2.33.0.
> +
> +        In the case where the path is a submodule, if the submodule comm=
it
> +        used on one side of the merge is a descendant of the submodule
> +        commit used on the other side of the merge, Git attempts to
> +        fast-forward to the descendant. Otherwise, Git will treat this c=
ase
> +        as a conflict, suggesting as a resolution a submodule commit tha=
t
> +        is descendant of the conflicting ones, if one exists.
>  +

I'm not particularly a fan of duplicated documentation text: is there
a way to reuse one from the other or have one refer/link to the other?



--=20
D. Ben Knoble
