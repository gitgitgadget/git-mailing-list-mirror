Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F121C84A0
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 15:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783350016; cv=pass; b=hk8aHTts1134qKNGopV+PRyAQeXC8EsGg1bvjSm8lF0mDfMNuhNnMDUGBUgdgbaoFSDMpMuPyyGlHy9MoDHkpbl6VZ8Js1jprEj4coUN020ZFf4yrqXHYoMDdsj8EeW+N/0v7UqjYEh7ByZK8XUIq+tgVFPfGRs3OX558qQ85rI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783350016; c=relaxed/simple;
	bh=2o8E9ShYK4yG5y2y4GgjZakKA0IcQGSLsXMxRBWrHp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IaHXdPTI+QRKOaF2Dtu2ICnr6WeEcyBGcugqzqWZheeye22INIa5OmG/yTLuVfwR0aZaDZ/HYNCfUIL9WbYHGslozWZJIdsynEa7lOoYMlNfxgkKDBrQ50b2tueNf1j5SdWoKFIF1bGDPvSEDQld4G+Lvl9zNPQwZ7tbxq/QyNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=u9DGkOkj; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="u9DGkOkj"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c124c3c876aso424857166b.1
        for <git@vger.kernel.org>; Mon, 06 Jul 2026 08:00:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783350011; cv=none;
        d=google.com; s=arc-20260327;
        b=m49x74+4LCpj1nuud2xr7cQBHMSJ46ZU0FtNtNQw+4GwZWWU8npvAbmuaMDfl1csRD
         vU0Q8bKqlyY0kgJFeykyOkgs6QNkEPm8B29aDWoZsPV8wwaj/U/xsxKlnWaF687gxAYJ
         Z5Hze4U/xBz1sFMGybEMKMT4gvR7nz6WZ4yXVj5Pn/qGpsf+eP6a4da+gvA/BwRYutW9
         +k1uuS0TSUBFSI0E+ARAvS3reoKZyVan5SUrivJO/aCTCamiYmkL/CsJKTHWrCIm1aib
         LQ9b2zUIQ5e73+NhlBihLbDbc6qd/p8Ham1jv3HupzhDmZ6f7fwZ4jPH+zRP/GgxNoDo
         VzYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tJgYvFdPcWXT/yMkYEfYqkL9EGk/w7nsupcCZwGtNBY=;
        fh=v+6U/WJFxiHuAJZAf+p7IWF4Cu29TqEULcdj9PbsdG0=;
        b=ArSTECtrlpSW3W/UV/S71VTXlFgZFkV/obUgPfZNjWxAbcLv7Bnttcmgw4aGZwpYhP
         MM3m/hgOlOqoockY+6ww3tz8W0msxKT3HPbd1xEGMcB3a5GJmVUIgRI68RgOd7GMsGKI
         KNH2qsYP/CPGZnvTuvonuyMBR+mTY2Uc804dx9wGe/Q4j8XRGpbueW2fMyYXWm7BItCB
         ZCfWurC7m/86qqX6JxAjlz7GysN3V2pYn4YoNf3OfzGWQM4utZG9FhaqXzAL9A/c2qAO
         W+fP4uj6KGRnnwP0YtWrReR8pIzQsrsC7uzVzPnoQ50+cqBW80VaPLOli+gwPH5X59Q+
         qz/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1783350011; x=1783954811; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tJgYvFdPcWXT/yMkYEfYqkL9EGk/w7nsupcCZwGtNBY=;
        b=u9DGkOkjU2qSN1A4hpa82N+mJNwrTtMBxM8pA9VsX/HJr9n/m9+qKVG/rRWdtTQA6A
         RywPay5f/WXas81qx4kVBTSTAxj8+4uRdwuxXo61LjBBulZP8pYgcmNBt4Kdo7Vt3AYJ
         +s65GVKdkXdXXnVD2TB10YLVzJ1XVrVjYb/tF5hvRALjcic0Hh7WyhFclTLO9XGLxAJ+
         LbFWjBTdbHX7fKmlHDPwcl1FVxLBYsk7CzYRnQdBrazSotLkPHGzZwPkD0K7dD1s8exe
         zRGxSKMFCCFR9xHhEDR9345sNiAngSn4PtF3POCovOaeS0QqYVGRCrjJ2dBOtAxMUuCT
         +MeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783350011; x=1783954811;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tJgYvFdPcWXT/yMkYEfYqkL9EGk/w7nsupcCZwGtNBY=;
        b=cDmdLAXAjM7wn/MYMCAa3N4ytwvcaKojr5HcJGJZJAvahH3mlNQGQiJArCla9cwbnH
         sTGy0Oe9+olVz/FGWRSoktN0TDHUc3fgJDBKVMzVSeKhH+Wskt/BZP2s6fj49pVLpLJ2
         eaIrngOmPUAqyN3arV63nSaDDE6tbIvesQjxHMOWY545qjJwDuBBs0U3MEqDebhd+d0y
         E8TEFN6LjuoEA+QgJwgf7BEiRTb7bhaIFrQo99iyXncANKRX/gI+W1XkT1sNlwt/ib2h
         lryJdxZDO4UO/R8L+mZB6m64XjzYXSXnV2xJYAukOYLx4mXV8/RMYf1mfoQE6oksSPMO
         yjOA==
X-Gm-Message-State: AOJu0YxR7rtvHzlf+2L8IUOlFJ0PmgIAikl0lOCGTi8cIpZavP6rXkV4
	8oYPQP97XQtAup1GgtAjYgI3nQ9muMJl/aDO4ZnoXeNvqec5ToXW/Mb/+UAuNw42S1N2nAXUwa6
	Np5vnq+3UJPRVcnJl2VLOS5SOzJ/JQvSRjlkpIfkxAg==
X-Gm-Gg: AfdE7cnQyjZ9eQBeAYMfrbeYmKdEDfQ5wruEHquzpCIu85EdICREOn8QBF+ejkmcjaU
	0ZRMgXnFsUcCkPGPhDH+g9BJ+6QcGbtmesOelAKumGzEjm31Z3vDxJxQPdnYUx83y80pT4DSYTI
	9+hXzupBUuSd8spWQgkSCNbem9MQHqpSQ8Uta2wx1knL8bOcFB3iOkmo05uooakr0FT25HiGyzt
	EBYG9TvjGdAGMExJjjtvrd7rfGoWOOYCaZ2xw/nXPq/nwvwltqYpjCF0SAtA1WEGlf1hgXoBvV1
	0KaSXFUUNKCMd6345fdp6JSrGm4=
X-Received: by 2002:a17:906:2817:b0:c12:b277:c7de with SMTP id
 a640c23a62f3a-c15a68a2599mr40019466b.61.1783350010755; Mon, 06 Jul 2026
 08:00:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702140704.65805-1-marcelomlage@usp.br> <akdwp_a2EuhVoGVW@pks.im>
In-Reply-To: <akdwp_a2EuhVoGVW@pks.im>
From: Marcelo Machado Lage <marcelomlage@usp.br>
Date: Mon, 6 Jul 2026 12:00:00 -0300
X-Gm-Features: AVVi8Cemz8JFBTk2sn23GgT7nVfeQgoRmVk9yVitpByDVmMisSUQtSsPLteGiYo
Message-ID: <CAO=vGZpMe3dxyzFVwR7BWBxaAZ-z9Kw3CqQ0kAe5ZZGSQszkzw@mail.gmail.com>
Subject: Re: [PATCH] t9811: replace 'test -f' and '! test -f' with 'test_path_*'
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Vinicius Lira de Freitas <vinilira@usp.br>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Em sex., 3 de jul. de 2026 =C3=A0s 05:20, Patrick Steinhardt <ps@pks.im> es=
creveu:
>
> On Thu, Jul 02, 2026 at 11:07:04AM -0300, Marcelo Machado Lage wrote:
> > Replace the basic shell commands 'test -f', with more modern test
> > helpers 'test_path_is_file' and 'test_path_is_missing'.
>
> Nit: it might make sense to briefly mention why we do this exercise.
> Like, what does `test_path_is_file` et al give us over `test -f`?

We'll add this in v2.

>
> > diff --git a/t/t9811-git-p4-label-import.sh b/t/t9811-git-p4-label-impo=
rt.sh
> > index 7614dfbd95..93d6b4c479 100755
> > --- a/t/t9811-git-p4-label-import.sh
> > +++ b/t/t9811-git-p4-label-import.sh
> > @@ -62,9 +62,9 @@ test_expect_success 'basic p4 labels' '
> >
> >               cd main &&
> >               git checkout TAG_F1_ONLY &&
> > -             ! test -f f2 &&
> > +             test_path_is_missing f2 &&
> >               git checkout TAG_WITH\$_SHELL_CHAR &&
> > -             test -f f1 && test -f f2 && test -f file_with_\$metachar =
&&
> > +             test_path_is_file f1 && test_path_is_file f2 && test_path=
_is_file file_with_\$metachar &&
>
> While at it we could split this line into three lines -- it's getting
> overly long, and we typically don't chain multiple commands on one line
> nowadays.

We'll do this for v2 as well and make it into a patch series to
separate test interface modernization from formatting changes.

While on this, there are some other places in the file where multiple
commands in a && chain appear in a single line, e.g. in line 244:
> p4 edit f2 && date >f2 && p4 submit -d "change" f2 &&
Should we split these into multiple lines as well, even though they
are under the 80 characters limit?

>
> > @@ -135,9 +135,9 @@ test_expect_success 'export git tags to p4' '
> >               p4 labels ... | grep LIGHTWEIGHT_TAG &&
> >               p4 label -o GIT_TAG_1 | grep "tag created in git:xyzzy" &=
&
> >               p4 sync ...@GIT_TAG_1 &&
> > -             ! test -f main/f10 &&
> > +             test_path_is_missing main/f10 &&
>
> This is a stronger guarantee compared to before, as we only checked
> whether the path is not a file. Now we verify that it doesn't exist at
> all, which would be equivalent to `test -e`. That's a strict improvement
> though, but may be worth pointing out in the commit message so that the
> reviewer is not surprised.

We overlooked this improvement at first, but we'll add a proper note
about it in v2.

>
> > @@ -168,9 +168,9 @@ test_expect_success 'export git tags to p4 with del=
etion' '
> >               cd "$cli" &&
> >               p4 sync ... &&
> >               p4 sync ...@GIT_TAG_ON_DELETED &&
> > -             test -f main/deleted_file &&
> > +             test_path_is_file main/deleted_file &&
> >               p4 sync ...@GIT_TAG_AFTER_DELETION &&
> > -             ! test -f main/deleted_file &&
> > +             test_path_is_missing main/deleted_file &&
>
> Same here.
>
> Other than that the patch looks good to me, thanks!

Thanks for the detailed feedback, Patrick!

Best,
Marcelo

>
> Patrick
