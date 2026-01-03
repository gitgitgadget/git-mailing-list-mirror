Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D89239E7F
	for <git@vger.kernel.org>; Sat,  3 Jan 2026 07:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767425743; cv=none; b=hLLQsvoUrtk1GRgYTpT1wn7ecZJogcisJI9DuX6eXFdVs/C1O3tCK9yqvhQdqhueGfQDUE1+p629e967D/jB06ysw8XQJSXOuZiajAPGj0Aew/1GPqQLAVyW/ineujCZ+NJ/MwOlq4/PicfgLc0EpMP4pRrcbC0CGjdrb1Z3ZOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767425743; c=relaxed/simple;
	bh=xsRmFMUb4D3NEMmgJjiomhDqhFkAKK9p4JhQI9dHG60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l4kBFUDiq5/jxEjZLgqWt2eFLVBjftKySLOpKQsWo67avc1KZKH74C3VKPUwom4IOh2RK5TAxAxAWbmdVWKKOV2us8lWozf0lZpEZLTB1oTnVaSBNnM5qbdValqd+g9FqwW7yopw6mswfencyo+R3kFY6X0Dv27bGDmftxZL8Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XeMwLF4H; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XeMwLF4H"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-78fba1a1b1eso6815127b3.1
        for <git@vger.kernel.org>; Fri, 02 Jan 2026 23:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767425741; x=1768030541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CAEs4g2M4MPOVtIZpl2fGWIcIjCkG1r9JevJannNYkA=;
        b=XeMwLF4H721a1F4VM8e+EQyIHj59JNsaJyivvI0RGXQx8PcYtXzMvgKTEcrvW9oDdH
         K+E9RQG66mao7qkKQ7McbwsgPsVdBRnhnBE68g+eWwztD0Xb4lq87ZckY9Db/WnNFIlN
         3wjX+0TjzDugcSkvkV4yyQYmTRwiYVYlbbvjpHCukPpSKzuDCZXQE4c/0PJFaQ9EL8au
         lxbnNMth61fcQUgEVd2V/iDBkbWIPwEYll3QtdYcz9ByAwCzHzMsYEuq/xhFFYtez8O9
         kfyxU5EU3L4Gxaf52xz1bNZQaEYXyEki8iFybvyPxlGz1ru3U9AGVP/9ggkRoTVN7Y6x
         revA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767425741; x=1768030541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CAEs4g2M4MPOVtIZpl2fGWIcIjCkG1r9JevJannNYkA=;
        b=U5wjkaiB+8zrJcUAIIJP9xwJFZkBpwCL//f4Bx8Nl3x/TRASqteLG4UpM/q0XhpMBa
         NNzyO53QCKP2fOrG8nrxsw2oNCub3NYlmJatuhOLXmNnhtc/T/gxyPhCKPKwO6fpPxaC
         tP965jUxX+VAsn3x80G5k7kEzXkEHIBzOyRjZxotdAddRkxoEJbMENPaNKHtvDJNQwpv
         pj7dey7jxBAp3Oyu3Bkq4o/TPjknA1MGpLmIGQDGp14h+m/t5u9nLWFwmeDDDM28yrGu
         toqfD8P58mD1QfD0MlirpLZSZJOv7NHlaIpCWb1UARGIX+Gx4PD2MtqoA5zqa6Apcm1i
         SjVQ==
X-Gm-Message-State: AOJu0Yxs3bEiNjKUHsVvijWf+enC5pNtUFb71AN4KYh/exCXYxkdiCNk
	8xCQYIt97oKbNkUKxaR4RoJOwSlfMaGun8Oqt9mg5CeVvyBGrk5qbWfL1teOH741QtzvU3QqXOP
	9GzjdSnmFjyjGelQCX5CWSTFdGWE75HPYKcP4vPfQzw==
X-Gm-Gg: AY/fxX5gNBMRFWGcsSyHNqPaDV6c1yE4TzBEmcMnNPu7KVFXsxWJYHEafya17X7uooo
	JjkW2hydgGHSC9PrrUrGEa5TYFigz1QfQcFtL08+uNaHas8KDUY7bqjV37PI2exRWZDdcE5/dg1
	WJch3xp/0qcfWtgQ7AT2lZCtp5X/eF19+Nhr/FKGZKTgBWS9iNSCB/prMhBmHHYeYGfn7FRlEjh
	C2wvtwxr7mzpc0sxOdJuRpod25t70ifeVKXV5ovxRHzfjw2UOj8Aq55l8F1mqzQHvDlUjg=
X-Google-Smtp-Source: AGHT+IHAmlITzHTK+ouMsWQhgYOwSHhIKOqTO0LvXSefr+AtWIOUgZwo/Bs2JmcToe8FIo3b8BaTDVUqhKG1XdBoB5g=
X-Received: by 2002:a05:690c:60c7:b0:790:7941:3604 with SMTP id
 00721157ae682-790794149d3mr10378857b3.15.1767425740823; Fri, 02 Jan 2026
 23:35:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Q0zfHYp-_TO2h_5PXPG9KjHwpMKIf2o2u2dsaoAjIsScmA3W6t7IvqIEeLfM7auEFIQyazlNnA3MGAuS4AANF0yfEBJAjkU1bWp-NH9m89U=@protonmail.com>
In-Reply-To: <Q0zfHYp-_TO2h_5PXPG9KjHwpMKIf2o2u2dsaoAjIsScmA3W6t7IvqIEeLfM7auEFIQyazlNnA3MGAuS4AANF0yfEBJAjkU1bWp-NH9m89U=@protonmail.com>
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Date: Sat, 3 Jan 2026 13:05:29 +0530
X-Gm-Features: AQt7F2qRu8OEzXbG2PilJ7aCFK_uLTd_K2jiIgu-b9AV2HvU6IQLott0rTuwCLk
Message-ID: <CALE2CrQTvHeu21yLXtRg=A6ak9AB_vvwPirQNFDjZ2AmhoTzTQ@mail.gmail.com>
Subject: Re: [PATCH] reftable/iter: fix undefined behavior in indexed_table_ref_iter_next
To: Tsahi Elkayam <Tsahi.Elkayam@protonmail.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>, "ps@pks.im" <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tsahi,

Thanks for working on this.

The issue and fix make sense to me. Guarding access to the val2 members
behind a value_type check avoids the undefined behavior noted by the
existing comment, and explicitly handling REFTABLE_REF_VAL1 here matches
the pattern already used in filtering_ref_iterator_next().

I didn=E2=80=99t spot any issues with the control flow or logic in this cha=
nge.

Thanks for addressing this.

Pushkar

On Sat, Jan 3, 2026 at 12:47=E2=80=AFAM Tsahi Elkayam
<Tsahi.Elkayam@protonmail.com> wrote:
>
>
>
>   The indexed_table_ref_iter_next() function accesses ref->value.val2
>   without first checking the ref's value_type. This is undefined behavior
>   when the ref is not of type REFTABLE_REF_VAL2.
>
>   The correct pattern is already used in filtering_ref_iterator_next()
>   which checks value_type before accessing the appropriate union member.
>   Apply the same pattern here:
>
>    - Check for REFTABLE_REF_VAL2 before accessing val2 members
>    - Add missing check for REFTABLE_REF_VAL1 to handle single-value refs
>
>   This was marked with a "/* BUG */" comment indicating the issue was
>   known but not yet fixed.
>
>   Signed-off-by: Tsahi Elkayam <Tsahi.Elkayam@protonmail.com>
>   ---
>    reftable/iter.c | 13 ++++++++-----
>    1 file changed, 8 insertions(+), 5 deletions(-)
>
>   diff --git a/reftable/iter.c b/reftable/iter.c
>   index 2ecc52b336..2eee65bb1e 100644
>   --- a/reftable/iter.c
>   +++ b/reftable/iter.c
>   @@ -171,12 +171,15 @@ static int indexed_table_ref_iter_next(void *p, s=
truct reftable_record *rec)
>                         }
>                         continue;
>                 }
>   -             /* BUG */
>   -             if (!memcmp(it->oid.buf, ref->value.val2.target_value,
>   -                         it->oid.len) ||
>   -                 !memcmp(it->oid.buf, ref->value.val2.value, it->oid.l=
en)) {
>   +             if (ref->value_type =3D=3D REFTABLE_REF_VAL2 &&
>   +                 (!memcmp(it->oid.buf, ref->value.val2.target_value,
>   +                          it->oid.len) ||
>   +                  !memcmp(it->oid.buf, ref->value.val2.value, it->oid.=
len)))
>   +                     return 0;
>   +
>   +             if (ref->value_type =3D=3D REFTABLE_REF_VAL1 &&
>   +                 !memcmp(it->oid.buf, ref->value.val1, it->oid.len))
>                         return 0;
>   -             }
>         }
>    }
>
>   --
>   2.37.1 (Apple Git-137.1)
>
