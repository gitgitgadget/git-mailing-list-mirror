Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7C41E49F
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 21:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755724836; cv=none; b=fFANLWTI3YnRfSnBwcknb4wws4LdulfKx26aH1mJOEKTdQ0OTPIeuwrA4yRhWA9PPZ+N9Os2Ym2UNZab01juSE/S82Sqf1E+rXfnP/psa8WDSerDfacb2LAzZKhUfFvPYFxvwXGy0jHucCGkqRILZoim0widOpp4C6agNjmcKMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755724836; c=relaxed/simple;
	bh=4xhJKS1n7YIjcRnCVKq4n/YWHk5eTqk3nRvSi8dk3Z0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NeObjt03ZVuQaeh6S+N2y+2oJH8yh0/N7Nudg+21jn0tUqEd5EdQvbGntO/2MvLzEMX+YO9VZ3Q90l7QLdEpAO3l4MnMJmzwESWNutnh1oO8+4Ve9mUccqEsK7q6WiZeFy9tuo8nXlL5j20ICtpGw14A7+PtDWkJ9wxGCH66WLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZxR4Vl2b; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZxR4Vl2b"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-333f8f02afaso2976051fa.1
        for <git@vger.kernel.org>; Wed, 20 Aug 2025 14:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755724832; x=1756329632; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=65BWbcctfonXrjPGTuRI8rdW24enA7uBCSAOCoqLEss=;
        b=ZxR4Vl2bsOJ7P/sbpyMLum4jVMoeg+v1bJ6Tj42aYBpiudBWE9ubt5ALaxJVhrXbBS
         la97Hd0Hd6NLttb7htBTzhkdk7Y05DVH8bzi15wrSYEzx06crv2Qk+d+pwQLoxlgO598
         AKucyaJfHkYfPCMeR4wIaXGCPfIFgo+2s4drxKQOMpSwUakm3TTwjtSXWzn6nx4n0wSt
         Au347BpbNWS8DvNAHRO52bQnWSxteZE5MNhPMSbex01ryt4rIZiREAp+toQ6fkwhXG2b
         wltrnWB7UOQC7DAG3gzxaUTn9sojII8o7Hy+c0rzHnlop8VwpZJFRFoXApOZ1KpCE+ji
         M5jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755724832; x=1756329632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=65BWbcctfonXrjPGTuRI8rdW24enA7uBCSAOCoqLEss=;
        b=lYPRJUsTuw6s5Xd1eXYyoUVpVIlu0oMb+vGmy2iGdoWsFCLnYxogfgXi2ee71vNl9v
         TGZbaNAg0I1cFW1LBt4QcFkSjvk4LO6WlOan5nW6+OyhH3DaBRaKiN5rMzyP1y6Xx9eX
         j92O5+HNOzPIOmut2l4wpBFcOASLiDKh4cJiJjOARXEiTAx/oMWnuZyxkn38nslHHsfT
         Z+MLhL34XxmhqTvXsKMh3GT76ynJizYEl17if4aWZfyK4oHtx9/y2t8YOqyYcGM6fGQb
         LbCFjDw3TZepJe+zzi124asoxBtQyG9msChUQztIt1OjVvfPXRETmIaghM4r+5wVAikt
         x3Pg==
X-Gm-Message-State: AOJu0YzCcNZXVV8ZLdKNCadwqrXVVJl1jGA3LFWJzJ2XrLvJvKbMno5O
	2YfCzWeOgmwgwRhZtfkACoI/DkT/AyTApPU9OL3+uez5fM7T5FUe/mmzqu+NRLNku7fIKjRM6Uu
	cKhpxRjXu9EUjyhLWfYh43TA6P1a5L6s=
X-Gm-Gg: ASbGncvphSvaFbCs/TQjY2RsSPPFWLbe7v+25mCWL+IPplqql2XBjxYcSwbVsdvmh+K
	BOsBQDNFwO13UCAqqvxhy5VYP1PFcVf5EQLdsScNFhbtsCHZpUGzaE/JvSGM6mJ+LW3+pthG/pE
	dMCOQIGTsK2W0wwRfB9OI4/T9EkPuw2beH2xV8g6nYTJThK52KHllkn3wS5XzgmXhDtQd4uFlTy
	gB54RE=
X-Google-Smtp-Source: AGHT+IHcS3z8poRgrQ6DUiXECHSXJ7/22/UpOQDsponeogjDleGFEW7V9gM54SSz2j2pqRGqHkl96OCkhJW/44NWKzo=
X-Received: by 2002:a2e:a584:0:b0:333:f936:d9a with SMTP id
 38308e7fff4ca-33549f755bfmr228281fa.32.1755724832237; Wed, 20 Aug 2025
 14:20:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820195229.45943-1-rappazzo@gmail.com> <xmqq349laeyb.fsf@gitster.g>
 <CANoM8SVTROfaQpRNBfwxU9opjXFPLzxN1W-xXTrA2bhx9KJ0LQ@mail.gmail.com> <xmqqldnd8zpc.fsf@gitster.g>
In-Reply-To: <xmqqldnd8zpc.fsf@gitster.g>
From: Mike Rappazzo <rappazzo@gmail.com>
Date: Wed, 20 Aug 2025 17:20:20 -0400
X-Gm-Features: Ac12FXzTqQQDA48I4Tg9mA3UJSxkNcT2mcOteRdFs-5kC72PHAh-pbgXrGIEn-s
Message-ID: <CANoM8SX7_uQV-ZRAim55UaiHYCKTgKN0AO6zB1O7Ux4deiCNaw@mail.gmail.com>
Subject: Re: [PATCH gitk] gitk: add README.md with contribution guidelines
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, j6t@kdbg.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 5:12=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Mike Rappazzo <rappazzo@gmail.com> writes:
>
> > On Wed, Aug 20, 2025 at 4:57=E2=80=AFPM Junio C Hamano <gitster@pobox.c=
om> wrote:
> >>
> >> Michael Rappazzo <rappazzo@gmail.com> writes:
> >>
> >> > +#### Creating and Sending Patches
> >> > +After committing your changes:
> >> > +```bash
> >> > +git format-patch -1 --subject-prefix=3D"PATCH gitk"
> >> > +git send-email --to=3Dgit@vger.kernel.org --cc=3Dj6t@kdbg.org *.pat=
ch
> >> > +```
> >>
> >> Just being curious, but does the project strongly discourage a
> >> multi-patch topic?
> >
> > I don't believe so.  I think most people know how to submit a github
> > PR, but J6t has mentioned that he prefers the mailing list (as noted
> > in the readme).  So I wrote a simple example to show that patching by
> > email doesn't have to be scary.
>
> As the original assumes that you are on the branch where you are
> taking the patch(es) from, perhaps
>
>     $ git format-patch --subject-prefix=3D'PATCH gitk' @{u}..
>
> would work?  I was mostly reacting to the "-1" on the command line.

`@{u}..` is funny, because that seems to assume that you haven't
pushed your changes to its upstream yet.  I could say `master..` but
that assumes that you named the branch that (as opposed to `main` or
something).  I will try a few different ways and see how they feel.
As I said, I just wanted an example to demystify patching by email.  I
think if I add something above to clarify that this is just an example
and not verbose instructions it could help too.

>
> >> It would be really nice if you add "review them here before you run
> >> send-email" step between these two commands ;-).
> >
> > I can revise.  I will wait for more comments before sending a v2.
>
> Thanks.
