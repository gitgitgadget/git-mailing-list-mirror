Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658D928371
	for <git@vger.kernel.org>; Sun,  3 Aug 2025 16:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754239424; cv=none; b=fGdmFiJstkDqH+2M/d24YwDMDOVoiLSz0/mZT9XQH9Bfb3BsOpwvZna+MrIfmaVc7nvBPhTaclpoQkdx+/ZjmRwTaN624iRZyixbhjwMhBMcl5Ra5BW7WWXPZ6V1XWlaEJ6WT6gp9Maydu68gXouPrdqF3mXmnIkfQx2jtI6GK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754239424; c=relaxed/simple;
	bh=uRK7cMrOAfnoBLUdcJPvsrQ13rYXlcpiPL6zK6Yw5yA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ruyXo3zGbsrsN6P7bluQjPfRYAB24W1tX9/o+8oZQRGYCPPPRek/56j6a4TAeGVidxjzApBYyn8Wne4hZM9hwPcKvlQtVyJLLawJDyhzvpogFPFXRFbJwG/tr+/nDCJk5u5bjTTSF2FrZQ5pdU1drTujmmN9/aMQFcXJcMzcur4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b5aMIQmk; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5aMIQmk"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ae6f8d3bcd4so766157066b.1
        for <git@vger.kernel.org>; Sun, 03 Aug 2025 09:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754239420; x=1754844220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ccOSds2WsGSwz4VIzvlxwy482qlmh+I5EvCTHWn9zWw=;
        b=b5aMIQmkLgu+Rn/4S4CBZRLSsBKHRwRik0qM4LGL5x1doNxEMeeQXgQQlYQPtlgFeN
         +Ukv9yH65sWTm2MM4NmzAeL7a2ZplKECFbLrPQU+3n7N+glB7aBRscU4znSZ9wHB/gsl
         wgX0JnHZuEwv3Y0MiB4fJR4fYpzvsIloeG4SOfGdzeNLryEA7T8KF1naXSgamIh4DQG/
         7JswcBdFMUyclitgwqvpLnNndw18ouKX1+Y5zb6MzSAednVnu6FZibtWPINXJeLm4jjZ
         HaslCqvNlMl8tflPDjeBMNu4FSRjKEVR8lnSDrY7qgGzpy19t7tdmOhLiPoouo5+0sX+
         HYOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754239420; x=1754844220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ccOSds2WsGSwz4VIzvlxwy482qlmh+I5EvCTHWn9zWw=;
        b=M9fbO22ZsCLkyrYJK4K5E+a24dEVqGFyaJCaLM/HeZH5DMRPDc3he4bw/YCv6dLRMs
         f2Ci3ofUUlRMncRcAettAve7fqTXFb/tORxhmELrv6kZdJVNEKlQ2P00DpEEmCDnw8yq
         fUkpenFQXP6GtDg7cGpflYJUDkzqGRwUgm1wTh3mge7e/p1Wg/Dw6baGo/AtdgCVXpur
         DZ5vo4HU4jzRhAJz3uVROLFiEMsxKHAMkBg5pbPMvwEZSoWMO2gA1L7zQ2s/C7vrE72C
         k7GHmP6u1d1cCcLbOs0O8HuG2zKDHTz8hjuzIaCdV38bUw7xIiW8NRJK8C558QPexuwt
         x8Qg==
X-Gm-Message-State: AOJu0YwYPOihi1Qo3bgECtz7QtkUEQ51Q7KrW6bV5tTaljRr8R/oUGTF
	wZHTmACXZWfyJuW8Nr1rBwzLiUSWum5PqWCy/szXS94btAFZre7YPYRbatGBY3DEgzF/MQDH8Zm
	by5SAbNGSFmp9Z9CuaVA+rvzvo+6M72I=
X-Gm-Gg: ASbGnctZ/R56JvoHWRzSn1A3mSuomdSrtcGH9mEhuhM0Jc9rJe4Wrdc+oKIlATpptPu
	SnFGcWPREV+rXjqmQQG8kEG0j+gMXG7yfPRS3NtnmOJa47ivfIByaJ5aeY0U3XsoRIrc0JLQajz
	izyrChW1DEc9Gh4l5uKE1VXfKPQQwZ+7lVeX/+eEZ/z5KQV3omsAaygHKVx9nEUmfEvra+WvJlr
	+2KRbTgv5GLjWETEB6sgdKLStMn2mfjGnDip0if
X-Google-Smtp-Source: AGHT+IERhlgjfjNbhR9Omvsi+XPwBXgcF2NZjz9vatYpMqdTdCGt8E3gwZp7j1iodBVjmCq4F9sH63hrGaBdx3vfu7I=
X-Received: by 2002:a17:907:724a:b0:ad8:9b5d:2c1e with SMTP id
 a640c23a62f3a-af940187813mr634519066b.29.1754239419586; Sun, 03 Aug 2025
 09:43:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250803012613.54086-1-ben.knoble+github@gmail.com>
 <20250803161033.77696-2-ben.knoble+github@gmail.com> <xmqq34a8fjdo.fsf@gitster.g>
In-Reply-To: <xmqq34a8fjdo.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Date: Sun, 3 Aug 2025 12:43:28 -0400
X-Gm-Features: Ac12FXzO2NDcha-xC-0TUjV6kleUb6vJmf4tMoOz7gelzgUHFCHln36IM_hPq4M
Message-ID: <CALnO6CDFekoqMjBDQifO7pj-7geXOUqN5yBbQmsPHBtTjj_kZw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] t1517: fixup for ua/t1517-short-help-tests
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Usman Akinyemi <usmanakinyemi202@gmail.com>, 
	Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 3, 2025 at 12:41=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "D. Ben Knoble" <ben.knoble+github@gmail.com> writes:
>
> > - fix instaweb test prereqs
> >
> > Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
> > ---
> >  t/t1517-outside-repo.sh | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
> > index 8a417af47a..3dc602872a 100755
> > --- a/t/t1517-outside-repo.sh
> > +++ b/t/t1517-outside-repo.sh
> > @@ -123,7 +123,13 @@
> >       *)
> >               expect_outcome=3Dexpect_success ;;
> >       esac
> > -     test_$expect_outcome "'git $cmd -h' outside a repository" '
> > +     case "$cmd" in
> > +     instaweb)
> > +             prereq=3DPERL ;;
> > +     *)
> > +             prereq=3D ;;
> > +     esac
> > +     test_$expect_outcome $prereq "'git $cmd -h' outside a repository"=
 '
> >               test_expect_code 129 nongit git $cmd -h >usage &&
> >               test_grep "[Uu]sage: git $cmd " usage
> >       '
>
> Ideally this would want to be squashed (or moved) into the base
> topic.  Can you two coordinate among yourselves?

Agreed, and happy to=E2=80=94just not sure what that looks like here. Advic=
e welcome :)
