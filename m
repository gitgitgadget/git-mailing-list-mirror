Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACF5366DC7
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 06:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768284021; cv=none; b=Qin1oobhDvmshP2zOhkTE6jr9RHp4KcI+XdkSq1eBMXwFh81XcEOkUqZKmNI2luRmG3cfjhDO8XJ1YZc2ftlT0MRuLrSXhmvU7ZWCZZfkeMRYnIv41/Q/KCAb9dZIcHeayZNpt4Z39O5ulTar1C9pQq1Z5bmP9wKrFqU94oGaos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768284021; c=relaxed/simple;
	bh=joSV2Oeia9Sv97h0ZuS4xxyXIl5K7/FgZm7OeXvorJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J3pcu66DqTUbdPpz9x5l7HlRhXyeOOMg8CAMD42ZwMqT1fGyXo5JDETQJgxt3nzr2x+a3QMgK/7Mm/qUdyibx7/a1VV9MSuF+sQUhZj4LerJYmhbMcv8F5a5tgErq6PcSpDhfpZEloUcOFPBBZaIbQ5OjigoxGP/9DNQ/s5U1Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UMRRJtFn; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMRRJtFn"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-657044fea68so3158963eaf.0
        for <git@vger.kernel.org>; Mon, 12 Jan 2026 22:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768284019; x=1768888819; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Az0tEty4bpUNaM5gkpMe2kSDptn+u2zhkECTojnSbOg=;
        b=UMRRJtFn7bM+3DfmCbWVtI/cvwSv+b9u/x/KuvRjcrNBPaw7GiW8K2I2CC+MBrhvTS
         /la9niU6Pkfv2QXtQQ5Su0OhhYWdzqNlOiYgRNsmzme75eXC3XWijszgd2DUmIhLUXdc
         r3ad0s0xKmhIKZ4LQFrOBPhK8co8kC+Tw+tetnbMyDs348+tWp+dJkqmxxLYLevVymWY
         slTPQYJDThVuQVQVGVGxxMUwPjaT4aNiMgTP587hq0h3suH3PQBrIl8v31vquxaFU81o
         EiqVpRG4ltrCjel4hKoCH7DratEyAVD8yAyi3PD/LJ4BqiBkEf+x5k8K4iztE3Rwa/xB
         qdJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768284019; x=1768888819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Az0tEty4bpUNaM5gkpMe2kSDptn+u2zhkECTojnSbOg=;
        b=g9VwfPV3cEkf2WimHtxtZQEVG6KPU0A1HcdUADDj7lnfPkpRCRAn/jTIn/HRHn5t96
         oHOGcj5H9SME8tsrnWyoRMgy0XgkjlVvUQ01gpJt37wf/+HNJbZkR/L4Pb50ipwYDCJW
         rEoKwJyAoxgcoNJhZLdG48VefQ5mx2vEMeQ1DoP1Q+LON3DyJYbFePdLFMlm9U5lBtkQ
         2n12gPjZDZ+tF4VwTo8nC7GRIYMpleJHCNz/5TFWr0WypAAyDAOrb/8zzA3oKlkYtMOm
         PWO6pN9bSeepnOq6zxYJw3wGlAmYnvVtboQaDy+9GOTubBnKeGjuyb9QV1DaQHJ4Hd2V
         4A2w==
X-Gm-Message-State: AOJu0YxmTfkPvTBoZm1i1E7DUaQaK6owBqVkleudoCQk+C1M3IgTAgYv
	Fwh7yesKSXMx0akRlzgXChejBRHzlx2JsGOUuHRTJ8JMkkA2QgJJillZuJvB8WOF/GEZBeQ3FBH
	zh5WIBD0hSfZgNMv9/4GVsP+LzCRfHrQ=
X-Gm-Gg: AY/fxX7iyRF2hsN/d3ABVJczCvW+l/+mg55hp8ikvX2Cf+zGI3jr0SA0yf4qXOZ3H6o
	gHGoWjj+3sRd1J18J8X89KdySPDCi0p25TzJJlCnCZeuGC4RF7GM+dT4dt2FXjolUxZ/ITKIAQF
	MBPWWEWmNTAYucjdObK+8Gi8c1ngALS0eZ7z86AIbbuetdNLeT5t818JdCqpONzqpiK9YYn98pQ
	upgxNF4fC6lDJJ5kgoRuKDMOREmRh1o5aTLLmvFg+jHnm0wi6Jp1DVRSnBEXpNDaSqaOL7kZkjU
	HMa7xH9KPC+XJ+vNO648sikEgETT
X-Google-Smtp-Source: AGHT+IHfrylRFRgBOuulTjAds+TZx1s6A6KScggoy3QaCZf0s52kULlq0vcFliKXpNkekgodLt80avDW7DgGMXzw/9Y=
X-Received: by 2002:a05:6820:f007:b0:65f:6713:fe08 with SMTP id
 006d021491bc7-660f29be456mr883677eaf.20.1768284018702; Mon, 12 Jan 2026
 22:00:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112-b4-pks-history-builtin-v10-0-e3c6aa5b4cec@pks.im> <20260112-b4-pks-history-builtin-v10-1-e3c6aa5b4cec@pks.im>
In-Reply-To: <20260112-b4-pks-history-builtin-v10-1-e3c6aa5b4cec@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 12 Jan 2026 22:00:06 -0800
X-Gm-Features: AZwV_Qi1gK1Qkqq4f2Yq2FJCtvJWZ48yF4gtnoxdgoBsN0ReChYrEVyk0Xi5Fr8
Message-ID: <CABPp-BGOcMRerGpH5HGkUR4-DKPx+VmkWzqRt8qideZoJBrvHg@mail.gmail.com>
Subject: Re: [PATCH v10 1/8] builtin/replay: extract core logic to replay revisions
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
	=?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>, 
	Martin von Zweigbergk <martinvonz@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Karthik Nayak <karthik.188@gmail.com>, 
	Phillip Wood <phillip.wood123@gmail.com>, =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
	Matthias Beyer <mail@beyermatthias.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 6:17=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
[...]
> -       die_for_incompatible_opt2(!!onto_name, "--onto",
> -                                 !!*advance_name, "--advance");
> +       if (!(!!onto_name ^ !!*advance_name))
> +               BUG("expected either onto_name or *advance_name in this f=
unction");
> +

I liked Junio's comments on this section and your response.

> @@ -253,6 +254,137 @@ static struct commit *pick_regular_commit(struct re=
pository *repo,
[...]
> +       if (!result.clean) {
> +               out->merge_conflict =3D true;
> +               ret =3D -1;

Even if you keep the special merge_conflict field for other purposes,
setting ret to -1 here still feels very wrong.  Negative return codes,
and especially -1, is used throughout the merge machinery to signal
unexpected errors like failure to read/write to disk.  Further, it's
inconsistent with how builtin/merge-tree.c works, where both in code
and in documentation merge result code is 0 =3D=3D clean, 1 =3D=3D merge
conflicts.  I'm worried using -1 here could cause some nasty future
maintenance headaches trying to understand the field if left this way,
at least for me.  As mentioned in the last round, the ret value here
should be 1.

> @@ -306,21 +438,11 @@ int cmd_replay(int argc,
[...]
> -       die_for_incompatible_opt2(!!advance_name_opt, "--advance",
> -                                 contained, "--contained");
> +       die_for_incompatible_opt2(!!opts.advance, "--advance",
> +                                 opts.contained, "--contained");

This predates your patch, but I'm wondering if there's anything we
should do to clarify and/or simplify the first check.  The original
form of the check
     +       die_for_incompatible_opt2(!!opts.advance, "--advance",
     +                                 opts.contained, "--contained");
was created because (a) I had code that allowed --onto to be implicit
in some cases, and (b) I was thinking only of --onto and --advance
modes.

However: (a) we got rid of the implicit mode selection from my private
branch, and (b) Siddharth added patches which added a --revert mode.
Those patches caused confusion around the interplay of --contained
with the new mode
(https://lore.kernel.org/git/xmqq3460ocv7.fsf@gitster.g/).  I thought
the synopsis:
           "([--contained] --onto <newbase> | --advance <branch>) "
implied clearly enough that --contained is a sub-mode of --onto, but
apparently that wasn't the case.  Perhaps we can strengthen that
understanding if we change the check here to instead be something like
   if (opts.contained && !opts.onto)
      die("--onto must be specified if --contained is")

Definitely not critical; but might be a nice cleanup.

> +       die_for_incompatible_opt2(!!opts.advance, "--advance",
> +                                 !!opts.onto, "--onto");

Yeah, and Siddharth can convert this to a die_for_incompatible_opt3()
call, adding "--revert" to it when he rerolls his series on top of
yours.

> -       /* Return */
> -       if (ret < 0)
> -               exit(128);
> -       return ret ? 0 : 1;
> +       if (ret) {
> +               if (result.merge_conflict)
> +                       return 1;
> +               return 128;
> +       }
> +
> +       return 0;
>  }

You mentioned that you wanted to keep the merge_conflict field due to
some future patches beyond the currently submitted series.  I wonder
if it'd make more sense to introduce that field once you introduce the
new patches, but i don't feel too strongly about that.  I do feel
strongly that the place where you set ret to -1 is problematic and
should be changed to 1.
