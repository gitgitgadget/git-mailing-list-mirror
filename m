Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D97817B505
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 06:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768284068; cv=none; b=G8xBBTXj6aLW682TCbPZftCPSMMGJCqg23BsDT4uAl1QQJgTkb59AB5GblwDDVfyYd6kg++qkedZTqR7hkAEWKQXz4eYT4w9fs3e0YSI9obNkZoeqo9oZOz39dpwYT7Nm+g5EoAVtk61vUrcUZRNNlPFiTiIO+dmzS+MKFfFVBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768284068; c=relaxed/simple;
	bh=DW7M+41l8I+FrqYSSLrwruY0T64dtEU/4pkHK9d2h3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FcLoWVhBcxn00qXAVewWohZHykUPfie8Jmvzlsom2E2VyJvoX0G+OYG0hwHwCzw3RJZW5EXCuYrluQwYmVkebv+U7KCLByhrsdKgFc0AWh6fM2xa12YJNB3GJyMaPZr9D5GTJxEdcOuvcFe8PlHGhmRqAcnM0C+CcGmWn9/jC9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zyd+sCnH; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zyd+sCnH"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-3e12fd71984so5111654fac.2
        for <git@vger.kernel.org>; Mon, 12 Jan 2026 22:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768284066; x=1768888866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fql2gesPNs1RaNyma5kQP/cHo1RJwIuEGiMveIQjfVc=;
        b=Zyd+sCnH0DHWM7ZjK8x9BcGOGShflYmWvDExFKUIn8ld15/zhjleCqeUb898TMMUY0
         PDZxakGkPXpMyNjPv1Aby+Z/6fgU4caUwTgBhU+wuPBoiVJdVCnERnWoqYOmbjog+wdn
         pq5ALvHLZPb76u1QQP+GL6cItznh+Zdzhku1x1W13fpdw1nRxILcI0fUWYukMGCYjH+B
         Vr+mX7zuB3nyW/Tj+wQEytUFAMgkIlaKpFzY4FvOfyIJh3DAmiFM/uFhLN10k1RdlwUh
         cNNuRsInI3YWtvwYLncDrZRiCWe/7jNoMMY7R3OGwJ+V3YcXR/9w+ePs0u6iq424Vra6
         jvyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768284066; x=1768888866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fql2gesPNs1RaNyma5kQP/cHo1RJwIuEGiMveIQjfVc=;
        b=iDPOaW0jzJLq4duOs6rUKK7XHbYDhJYUjYVv+gueyqyzuMIVcFRc/X8uDvFhAm2QHr
         THB12KWVcu6DF/UhRUiv4HQ1Ql1aHjshUWpd659HzRGeh1qDwY2qqFiV9bto7wvwjtE+
         lRaVuzUuasr/tLA0KNCw+WGNavcqT4xnCOu7J+o2bNBM70Vdoz4oHr+xRP9Py3+6Sqmv
         w2fwEA3j8B9xhv+Qw9BH7ay5pWudeMu1jyzkCQrk25LahTcTaxOsdUXm/HnArivQhsAy
         3d6PdmhnO1Ah1XUTTyqpNzKoUeNp8P1YiRW/P3KSVblkOoz+QwL2QnBfPzr8BI96KJfj
         gySQ==
X-Gm-Message-State: AOJu0YwUmjvrXhnKXPLfUCf40lhTgAINhi0tm1i/q4sCp7Rwet+HMRI+
	d+PEmoJCN+jzztxQhM45dZsvl9zssKNB4mBnS4p8V2tfJsBkSlYEYBuMyrzAQZ1ub/UV0qljlDa
	iJIKAQm0c6G/UNkDbZ93d53nDfVxwtEg=
X-Gm-Gg: AY/fxX5odqFQUXY8MYnNz/Z8BIclir0K6F2rEL1oOWBuQvfPrfVofZLhT1r3bBke8Jx
	xPA9H108s4M0aMEzx+barg1u696BzAM6cZ7sLOdxbGEAywi/RhiHMQvaDe97tiASdN+p3hpGc92
	WlIOeuaLXwYxEtr25jOYXGISL4+ATYPPY+otGBxYiNP3lkURAfHaPhup/dngcZ7H2kAAOueJdwa
	8pDNUNKxarxCT1FkDEhEaUsbM/0Rl+xH0rla0yBMbg/58KSwJIjPSc+QH3DBCQDohwv9rPT+eTu
	xk8nhGQSCq9mrxVzN+Wker1wfOGL
X-Google-Smtp-Source: AGHT+IFx3hHIvmODfACYO7HjWjFCt0pEjC0f13Brkk4wZNYTjA+27uAEDClKMNlwJGV3cUiJqgopmBV+3l1waVfA1bY=
X-Received: by 2002:a4a:d15a:0:b0:65b:3797:6536 with SMTP id
 006d021491bc7-65f54ed455cmr7147244eaf.3.1768284065961; Mon, 12 Jan 2026
 22:01:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112-b4-pks-history-builtin-v10-0-e3c6aa5b4cec@pks.im> <20260112-b4-pks-history-builtin-v10-5-e3c6aa5b4cec@pks.im>
In-Reply-To: <20260112-b4-pks-history-builtin-v10-5-e3c6aa5b4cec@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 12 Jan 2026 22:00:53 -0800
X-Gm-Features: AZwV_QivQUuhGTZXLGYFpI3tL7KOLWWt8OCzLdwf0Iyk7i4ROS__4VdcagiKAvU
Message-ID: <CABPp-BFvi0xmpP1jcU0qc7c-KhYXgzpCVbXyto3FMSFSSwrKoA@mail.gmail.com>
Subject: Re: [PATCH v10 5/8] replay: support updating detached HEAD
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
> +       refs_read_ref_full(get_main_ref_store(repo), "HEAD",
> +                          RESOLVE_REF_NO_RECURSE, NULL, &head_flags);
> +       *detached_head =3D !(head_flags & REF_ISSYMREF);

Ah, I like this simpler way to determine if we have a detached HEAD.
Out of curiosity, though, is there a need to specify
RESOLVE_REF_NO_RECURSE?  I waffled on that for a bit and just left it
out.

> @@ -312,18 +319,30 @@ int replay_revisions(struct rev_info *revs,
[...]
> +               for (decoration =3D get_name_decoration(&commit->object);
> +                    decoration;
> +                    decoration =3D decoration->next)
> +               {
> +                       if (decoration->type !=3D DECORATION_REF_LOCAL &&
> +                           decoration->type !=3D DECORATION_REF_HEAD)
> +                               continue;
> +
> +                       /*
> +                        * We only need to update HEAD separately in case=
 it's
> +                        * detached. If it's not we'd already update the =
branch
> +                        * it is pointing to.
> +                        */
> +                       if (decoration->type =3D=3D DECORATION_REF_HEAD &=
& !detached_head)
> +                               continue;
> +
> +                       if (!opts->contained &&
> +                           !strset_contains(update_refs, decoration->nam=
e))
> +                               continue;

I like this refactoring to make the conditions clearer; very nice.

> diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
> index 307101eeb9..c862aa39f3 100755
> --- a/t/t3650-replay-basics.sh
> +++ b/t/t3650-replay-basics.sh
> @@ -249,6 +249,15 @@ test_expect_success 'using replay on bare repo to re=
base multiple divergent bran
>         done
>  '
>
> +test_expect_success 'using replay to update detached HEAD' '
> +       current_head=3D$(git branch --show-current) &&
> +       test_when_finished git switch "$current_head" &&
> +       git switch --detach &&
> +       test_commit something &&
> +       git replay --ref-action=3Dprint --onto HEAD~2 --ref-action=3Dprin=
t HEAD~..HEAD >updates &&
> +       test_grep "update HEAD " updates
> +'
> +
>  test_expect_success 'merge.directoryRenames=3Dfalse' '
>         # create a test case that stress-tests the rename caching
>         git switch -c rename-onto &&
>
> --
> 2.52.0.590.g1f87b77810.dirty

Good extra test too.
