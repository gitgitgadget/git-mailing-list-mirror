Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1B818E74B
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 11:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724153386; cv=none; b=dlE8GHKvdrzxSGgsb7w8laAaFgMmc5X9k32QPzSFzJzDt2z63KTQOGYGgNUqKuY/AEDv5gS7oR3tE2MTYdQeEUOwj01chTQ2IEcG/n87hLI79ge7JPgxOLCKCO22L42lVkGxHRZTJZe2pFHK28X7PYLUiRItqjEKXrrxuQJE03o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724153386; c=relaxed/simple;
	bh=/gzssEUM1lwrQvPLnEELwit5ctS9n7fvoIBZFqnLmuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kC8+YKm1CppOWUfknrdk2LNT0BwMJyvwaZ3Mk0wDOPCrN9kNcUTR9J26DeDB9gtqrOLySDix5HoTUh877AHtX4gqB3Q0N3pGodBJIJSINdW9idyI9mjIIX/MHnM0r+iBHrAU5yd2GScR5uNUXJy8m5Qv1jaSghbTn86/Vcoqz3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CMCmnBjt; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CMCmnBjt"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3718acbc87fso2850797f8f.3
        for <git@vger.kernel.org>; Tue, 20 Aug 2024 04:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724153383; x=1724758183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4w8FsdUhuGxK4bloV09UsZOnG/sUPks5lJ6KGz/5cG4=;
        b=CMCmnBjtT2frx8DFRTEKvx4gegPZyyC+TnvYEPmiW1gLjzneH1qldj3iViPRR2dp2w
         Y14kla7JA7a6ytUtX0X4UpCo5CAObdd7KbjhR89XiLQRbxkNwTmsczfYgoJcVAxkUt6A
         qqLSBxMkpoxfdRl/MG1AXjM13yOz9z91A7DScV32tDn+pWLKcYj7rE4n/hx/hHWWshm5
         ojuPbmfqW8XeW77R7/+C2wkM3RBOms8G94uQP0dkn0BGtVvgzaYrciQmJHezmkDXhSKa
         L1u2S1MnJ8MOrkH6ZExa5pAuWaCyELc1J6ZerCtV89RPWKvyowWNQ0+bMdJGbWREClrh
         Adlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724153383; x=1724758183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4w8FsdUhuGxK4bloV09UsZOnG/sUPks5lJ6KGz/5cG4=;
        b=dXQ6AdfKxi2PcLhLBCChD90O36BjHy3cM9qOV8GsEn1LRq2w697w/CLBcaBbhkAFxB
         miT3v1v/ETKtgV20ag7Dji9rVskj74wMIYOWCy6pVapwabqKgICFXT8dffqGcH5B9EJg
         RmQ35wj4AXcvcI+NOiI9KBNTw5MZXlslKGgw8J5YSjPpD4DmW36MP/m0jRCfkCnqe7Pz
         AbulTL9vOhtiKa3ab19+871yqM3KtM3WFap8GxMkltbm1IaZvdr3Svt18lakrDI6kT4S
         I8+ZD/cjaCw1urJntx8qxmlJF55XE0z5XLKtnqWdHubzywDCrOhUWHELE+AKElD4cVC+
         3wdQ==
X-Gm-Message-State: AOJu0YzDVK0o2NSeWJa6oR5iee8VnkIO+I/2cAbZMwCTJ0vua8vlW2FC
	0VFBB3Pzlxi6Nr0rb4cfoPpsKhZMdDTwkgYzp5ztueWfXMMqGyzlRVcp78CuL7kOvGf7t7Rgcat
	D0xbQRr4fRm2pA1+iepQCb309x1E=
X-Google-Smtp-Source: AGHT+IFeVXCkAsOfvv1fHSd6EjjttpQMeDM+BhcvGKa4+E36kUvbrIJ9eKaHcwVchvpUefh+6WLhGH+uR7xk/lk3JHY=
X-Received: by 2002:a5d:5913:0:b0:371:8e39:6f88 with SMTP id
 ffacd0b85a97d-3719443cd05mr8103741f8f.17.1724153381933; Tue, 20 Aug 2024
 04:29:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731134014.2299361-1-christian.couder@gmail.com>
 <20240731134014.2299361-2-christian.couder@gmail.com> <xmqqzfpx5vk5.fsf@gitster.g>
In-Reply-To: <xmqqzfpx5vk5.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 20 Aug 2024 13:29:29 +0200
Message-ID: <CAP8UFD0u+pziZunGqqpKJQj333kBD4oA5dm97hffGX3v72TCHw@mail.gmail.com>
Subject: Re: [PATCH 1/4] version: refactor strbuf_sanitize()
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, John Cai <johncai86@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 7:18=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > diff --git a/strbuf.c b/strbuf.c
> > index 3d2189a7f6..cccfdec0e3 100644
> > --- a/strbuf.c
> > +++ b/strbuf.c
> > @@ -1082,3 +1082,12 @@ void strbuf_strip_file_from_path(struct strbuf *=
sb)
> >       char *path_sep =3D find_last_dir_sep(sb->buf);
> >       strbuf_setlen(sb, path_sep ? path_sep - sb->buf + 1 : 0);
> >  }
> > +
> > +void strbuf_sanitize(struct strbuf *sb)
> > +{
> > +     strbuf_trim(sb);
> > +     for (size_t i =3D 0; i < sb->len; i++) {
> > +             if (sb->buf[i] <=3D 32 || sb->buf[i] >=3D 127)
> > +                     sb->buf[i] =3D '.';
> > +     }
> > +}
>
> This looked a bit _too_ specific for the use of the transport layer
> (which raises the question if it should even live in strbuf.[ch]).
> It also made me wonder if different callers likely want to have
> different variants (e.g., do not trim, only trim at the tail, squash
> a run of unprintables into a single '.', use '?'  instead of '.',
> etc., etc.).
>
> It turns out that there is only *one* existing caller that gets
> replaced with this "common" version, which made it a Meh to me.
>
> Let's hope that there will be many new callers to make this step
> worthwhile.

A very similar step was also part of my previous patch series to add
an OS version to the protocol. See:

https://lore.kernel.org/git/20240619125708.3719150-2-christian.couder@gmail=
.com/

My opinion is that the code is doing something often needed when
dealing with the protocol, so it is worth it to refactor that code
soon, and then adapt it later when needed with options (to not trim,
only trim at the tail, use '?'  instead of '.', etc).

I am not sure if it should live in strbuf.[ch], but on the other hand
if we indeed adapt it over time with a number of options for different
use cases, it might end up in strbuf.[ch], so it is a reasonable bet
to put it there right away. I must also say that I don't know which
other place(s) would be a good home for it.
