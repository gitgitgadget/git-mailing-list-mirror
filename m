Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B9B173336
	for <git@vger.kernel.org>; Wed,  3 Jul 2024 15:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720021753; cv=none; b=YkvIPSiYllllb1Gu32FnPWgU3as6EWCOIVAx2bxGx5piXZb9YWRLl6yOB7H1LWKDOeyKYBOc3RLXmRuXX4ZvT4qCI/tLK9FSZ6Is0rPtYc9UxPLWdTHKKYCseMr/zJl6x5OYyjg2yGRITnfes45zKkPos0xI2mbk1yanBNRfknI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720021753; c=relaxed/simple;
	bh=pMCMnqMFWz3JYYZJ/h00VIACfySczkQYA4wUI77Kdo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p43Rco9Nd8rvntLeswRAD8OrZaFCDBPCDyEYR/dQ28bsUhfWrl1qpekhkPYlWguJ88WTtd0fYmC1eYJ05lZijZFfPUFoHOUbJ4602Hc+vn68+A+PLDc3nl7lMJlJeNKhhjQObtl1TJ9+FMo536kuQUBpJ7elnBIk4LML0JRpaIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nBQY7UzU; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBQY7UzU"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7ebde93bf79so218367039f.1
        for <git@vger.kernel.org>; Wed, 03 Jul 2024 08:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720021751; x=1720626551; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kXuAypnOspmqsisee0A6iw3G8TsCOMgs8JVs1ja0XuU=;
        b=nBQY7UzU8ubfDTSPr6HoEe72flPILoyVFL9GY26hmTsFhDGdVrl2sy0WAIKGTrkGE2
         F7wuVzghZtDttF/evbnoO2rsvlHJsbZn67CblWJBKK4L9Sc6g3LM62EpgL1v9bmlsNqy
         50hu09kXF9ZpUwclQalOXoiH4CZm1rl724fE2Tn77rrftX4dAnMCPR1qplIsGlTJjNr4
         NMOLW2HlX9oJJ1torzKTRutUNk8560txsO6YpuJXkhTe/W9JokBSEvDD4heYhaQ9VnIy
         TnRvelaCI3JejjhBaLlmvLoTAk1O6wUbYYosGuH0bE9EphfTeUe/CBfxSiGkLYQpe9cy
         h3Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720021751; x=1720626551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kXuAypnOspmqsisee0A6iw3G8TsCOMgs8JVs1ja0XuU=;
        b=QnQOFHnTyeWQDBUcd1C1/T6d9qfEYeC4tatkkDTqM+ZnGPlN/Cnz5N+ZvciyW+A3Ca
         1r8mu+a9SnJgJ7cBpxj5P4i0GI+w7NISPT88/duX8TB7WjPLrntIW5JwoItYWzFl9nJ/
         2ZFtG1Tin4GyMfoCiHMDHvCAwot7g0Mu/HVCEtZbE12KCLAsERvckkiRAY+D6ZRI0mr+
         ERFAuVtFB3ZQZYzGs1J/LzbQTTR5+oUZPgJXAbUuVqscswJF7HbLYbPTaP7S03jhlLFO
         M+P9qFpZYzDlZ+6jza4EmIkcbgXKswkpHoEdz9S78qVEVs7XOG01Yd6JQ+OJUSlj0ClJ
         yB4g==
X-Forwarded-Encrypted: i=1; AJvYcCVPT5mGQFoAXpsCig6RG4iZwckThGvQh0KfNLL8u5rwdlHdXTczbmqye5/0LkOpXZyGMEHSW7JbY8p+bngyDMWP4mhP
X-Gm-Message-State: AOJu0YwclZ4WbZFliL4oSHcuSL3ps6iTQu2Ckp8sHkvnCFysyai6i1OR
	bPPVfH8eTuCTLTAJCdWWL/vRGH4rG6xnOmpu/978GYDjYnboBq539kZiYreDAJh1dDMuY6sh0mB
	G0SDCPzOWFDPVs2O0HJ2XJbdGMps=
X-Google-Smtp-Source: AGHT+IE+HT34anjmlRrQbwQylhV4Al6XI7nMYGuX5blmvmwU3HmhICooC6+cyM1XEZLlmwxaEp3KpmB1esShSndPmHo=
X-Received: by 2002:a05:6602:b:b0:7f3:d863:3cf9 with SMTP id
 ca18e2360f4ac-7f62eea1740mr1286131839f.13.1720021751270; Wed, 03 Jul 2024
 08:49:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1748.git.1718310307.gitgitgadget@gmail.com>
 <pull.1748.v2.git.1718766019.gitgitgadget@gmail.com> <500433edf49a4df448b330e4ed9201cfac83cecf.1718766019.git.gitgitgadget@gmail.com>
 <20240702213326.GA591768@coredump.intra.peff.net>
In-Reply-To: <20240702213326.GA591768@coredump.intra.peff.net>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 3 Jul 2024 08:48:59 -0700
Message-ID: <CABPp-BEkh4K1156FWUdB9wSjSQcdeUF0dcTJ3CS_b8yvz5Vffg@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] merge-ort: convert more error() cases to path_msg()
To: Jeff King <peff@peff.net>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Taylor Blau <me@ttaylorr.com>, Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 2:33=E2=80=AFPM Jeff King <peff@peff.net> wrote:
>
> On Wed, Jun 19, 2024 at 03:00:19AM +0000, Elijah Newren via GitGitGadget =
wrote:
>
> > +static int read_oid_strbuf(struct merge_options *opt,
> > +                        const struct object_id *oid,
> > +                        struct strbuf *dst,
> > +                        const char *path)
> >  {
> >       void *buf;
> >       enum object_type type;
> >       unsigned long size;
> >       buf =3D repo_read_object_file(the_repository, oid, &type, &size);
> > -     if (!buf)
> > -             return error(_("cannot read object %s"), oid_to_hex(oid))=
;
> > +     if (!buf) {
> > +             path_msg(opt, ERROR_OBJECT_READ_FAILED, 0,
> > +                      path, NULL, NULL, NULL,
> > +                      _("error: cannot read object %s"), oid_to_hex(oi=
d));
> > +             return -1;
> > +     }
> >       if (type !=3D OBJ_BLOB) {
> >               free(buf);
> > -             return error(_("object %s is not a blob"), oid_to_hex(oid=
));
> > +             path_msg(opt, ERROR_OBJECT_NOT_A_BLOB, 0,
> > +                      path, NULL, NULL, NULL,
> > +                      _("error: object %s is not a blob"), oid_to_hex(=
oid));
> >       }
> >       strbuf_attach(dst, buf, size, size + 1);
> >       return 0;
>
> This loses the early return in the "type !=3D OBJ_BLOB" code path. So we
> free(buf), but then continue on to the strbuf_attach() call on the
> dangling pointer. Should it "return -1" like the earlier conditional?
>
> -Peff

Oops!  That's embarrassing.  Thanks for catching; I'll send in a patch
on top since this is already in next.
