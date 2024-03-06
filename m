Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44437499
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 01:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709687301; cv=none; b=KiGe57fj2NVQRiS1n4H+YyECNrZ/ofWEHX/7yvsDiviZ1OpSA4+/Szp+78Oss32/vg2YQi8Cajbj2cjNJ6TMZjwruqOKYbz/oCfmGJeR8KiKMkBHF0HHxTijPngFph/1wqxr3QvixcZd5+CN2n5yIE8dA3xcFhGrzMUElKybpso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709687301; c=relaxed/simple;
	bh=kelXGm8IIt5qlM7xYU5PJx3W0cDjawEyl+qSldpjxzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kkswCzUnDBOrJknTGs13LYNvJ9PBJcuP0zy3+6DVjCtk9vKJxEOzgqM+mlqDq9wcVcZmeJhBPlY9suboe1pAGFVgIdxM+bMEYW07TMjyGgS2RuB5V1Rbyqck9AFjHOppTqd/ZY+5OB6IQEHXtqnY2gwHlEQ5tAvr4TByWndd7jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-68fb3a3f1c5so1978806d6.3
        for <git@vger.kernel.org>; Tue, 05 Mar 2024 17:08:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709687298; x=1710292098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zh3Snqb0eBnggYQ12azvMsWyHqkFiyWf33tGMHhF/0g=;
        b=o3uXCw8jy+eVATOdvyHrXkNfMnXDEvnfNkW3a3l4twZlkB6AamgsrgeQg2A4vZMvgn
         Y8jfcieupPmeO93XXV+U+qlzsVKkkTLYiSDzwNiYLJPd5LLlxYeTUBq6i2b5s1nrclH1
         uFevc7KLphQVdpAeeenJoAG9zQhaRZCZfgRcNgsA26V0KaWbCWH8cQg2vp+Kl3pkvwhN
         afqDL7MS1X6p8bl992r1bdwV6dU1EP5k0csTd6yXFZOH1Fhjsmi71wAkK6iKTT++VNXV
         lVQ/28IS6KugpWuZIjOKxY62btW5r+ueqSjc1k6pGK4cNskARqqCaz5/W8xHdrkLCuyQ
         PZSA==
X-Gm-Message-State: AOJu0YwSov7g1mtp/0hmDH9q4JJWGMDSMx/1NmP2vnHVCPMBDiHTecTl
	ZZN6jYVSAQr/4DuziBhmvuwNYvCnUU/TBO2CzLJi9yKSk9bjJaEVniGqB7sxNRFzBYQlURTycba
	At7aewaxdLOkQVgYBnwirunS2Wj769SET
X-Google-Smtp-Source: AGHT+IHRjl12WaRYqnpzYAsc8H7ZqnobdXJw7UZ6HwNnHf3z2wtr+y5R9jo78VG6A5nNR81Nt99+r/Ciy11Ps4XiRUw=
X-Received: by 2002:a0c:dc11:0:b0:690:8705:7a7f with SMTP id
 s17-20020a0cdc11000000b0069087057a7fmr3836189qvk.9.1709687298624; Tue, 05 Mar
 2024 17:08:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305212533.12947-1-dev+git@drbeat.li> <20240305212533.12947-10-dev+git@drbeat.li>
In-Reply-To: <20240305212533.12947-10-dev+git@drbeat.li>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 5 Mar 2024 20:08:07 -0500
Message-ID: <CAPig+cQ13SANfReDNxVRPmS2TbK+0ZU4mT6g1rw9kWJHzH-j2w@mail.gmail.com>
Subject: Re: [PATCH 09/22] t/t4*: avoid redundant uses of cat
To: Beat Bolli <bb@drbeat.li>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Beat Bolli <dev+git@drbeat.li>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 4:31=E2=80=AFPM Beat Bolli <bb@drbeat.li> wrote:
> diff --git a/t/t4020-diff-external.sh b/t/t4020-diff-external.sh
> @@ -232,7 +232,7 @@ keep_only_cr () {
>  test_expect_success 'external diff with autocrlf =3D true' '
>         test_config core.autocrlf true &&
>         GIT_EXTERNAL_DIFF=3D./fake-diff.sh git diff &&
> -       test $(wc -l < crlfed.txt) =3D $(cat crlfed.txt | keep_only_cr | =
wc -c)
> +       test $(wc -l < crlfed.txt) =3D $(keep_only_cr <crlfed.txt | wc -c=
)
>  '

Could also fix the style problem (drop whitespace after existing `<`
operator) while here, but not at all worth a reroll.

> diff --git a/t/t4150-am.sh b/t/t4150-am.sh
> @@ -786,7 +786,7 @@ test_expect_success 'am takes patches from a Pine mai=
lbox' '
>         git checkout first &&
> -       cat pine patch1 | git am &&
> +       git am pine patch1 &&

As with Junio, the semantic change made here concerned me.
