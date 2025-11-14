Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA4A132117
	for <git@vger.kernel.org>; Fri, 14 Nov 2025 05:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763098890; cv=none; b=Oydn5PTD8dYHg+Uwre41YxYSqPON0/VD8veFYPjjvDO+jFMTA+wlcDRnNR2jVLTPjkSA2o4dFPZ2ArR1TVRKvw7MpiUpo5nW5hvUcYLy1G5yioi8+29cmuaWPj3uaKoqXpWIbOkVV4fhMtMHBxGoPxOgN4K35669bWJ219xEwAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763098890; c=relaxed/simple;
	bh=MaWYXCbLsHg72FWES9PVLgDgvyhIKQyOo2cBI70Nh9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O7fRqt0vqqu9VNSRL+cZx57yi1DCMY1/Q8d6q/6qcCyFEZNlYpb0phJ4uij/UR5Vtbevavy5jObVSkpm6DR86lLr5QmLvbu0+7Zqx0VHqb/l56SySehBQXWCH+y3E3qQn3b1Iwk/8mIQVKOT9MeMDiSIT836YVZYJzss6quOwHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j+FxmCzU; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+FxmCzU"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-37a2dced861so24835551fa.1
        for <git@vger.kernel.org>; Thu, 13 Nov 2025 21:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763098886; x=1763703686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xpuvbjQmQmnusfaRD8hs32g3H6Dq2vN29h2dt2tvYDk=;
        b=j+FxmCzU+WY/iImCg9BvlrSANZwdMkqOwDtp3mtf1A3uyvTNCzAB6+MGXEkQFhqmWr
         TgD5L69dZxFF6kU0OjHMTMatEvR98iKq3ulR46Q/vSxg27WapKDP/Jftqn9WimI9OVQG
         cuHmpbAdR41dCMCaB3uRjMVr3jiIakNv/sqG8aMyeXyvthLin4B0FDjpIkdG+zNTPgMP
         yal4MH4Yorvns9HdDRRYgSGV5HiAwMaHGU6YRF2SMRsJVWb7S1uKl6sU/4SgpZ1tmzWo
         uz5AWiDKHb8W9O77g5OdXhCiKzijGjgOzFAxbb7QX6sW+AVe1/Zg6nvn0BgM2ahmYvei
         rW6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763098886; x=1763703686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xpuvbjQmQmnusfaRD8hs32g3H6Dq2vN29h2dt2tvYDk=;
        b=ahduSyc1RoiWPd1Ps2ubi/LQ0S5bCXuAsjHfvDF41HGtb6AwoMrht54mFc794/tt4z
         6mq3ctXpS48F2kRxx410QqUb0fBPhvGTnIlZGvhHd0GgymAN0d4FJ2r9rgpr9L2zAcSz
         u0rEXgAN7U7c0bk4Nf61cJT9Ef48l4+BTn1N5jxkuTXkokW8Aeh/rkdho6ndvEpSG2ZY
         8EGHPM0AVpsd0l3jD45eIYXklI4IMkFOh+J9/O5MfAxP/q8wUXWDOZ07BNsTcm405atp
         REwMsNaNYOeBKXKiKMJfDnHk7bht5r9sgkQrfzIlbCqyGgnNimSKeftIJTCsogLqUrh+
         abXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXi05Q9Nt658XXkIzEIHEwgUEyrH67EKV9IjLiFIRtOH5czrgxivTPxL0cxPwVZE+bSHdg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuupkHLTqQC4YkoUYh/5Tb5yb4lDIgLYjdvtvS4TRE6NnKQzG8
	dDX/7fISjRD63L0c/2P8T8V2zc0Tg3i1wrMb/3XJEIkTeBtrSUvU1m7MfHSSseMvQeq+8/HvM/X
	vcN5JUEhNgH9FNAS8Lwr0jfH9HfeiL4o=
X-Gm-Gg: ASbGncuqlZUC8i7RIANKwUG319dVxZLDu1eoaERvGSAgwopweIMV9jEDxzKuTdxOgdr
	3AH4ZS3XoM/8iLwJnd7Yj+ueOn55gnEG9MPNN1nEjc1Qc8MXMHeiBFjs/ANRLPuipC2vgZnPFIy
	nupoxKTexmaL8BsuvLdTxfrlSco5nPfu0j4KRa3q/JYUOsGSgGMPFolyguwvuz9ymZbKhMJWSFe
	IzmnYlq5fblhrmL87zM3TMMcxKcY8i4EYnOuETf8okDCD1HwTe9SaLjA9vzY0/EbsR3RaUl
X-Google-Smtp-Source: AGHT+IFGx56b1LpjmV101Vo/WqwrPfGjdTmKvPzzPAyjebKkrYWXA4bzv0BVshgK876TlYT5SmbkzRFq0dfmgaXuLxg=
X-Received: by 2002:a05:651c:4115:b0:37a:323b:2670 with SMTP id
 38308e7fff4ca-37baaff0379mr4711381fa.24.1763098886146; Thu, 13 Nov 2025
 21:41:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2070.v2.git.git.1761776388.gitgitgadget@gmail.com>
 <pull.2070.v3.git.git.1762890152.gitgitgadget@gmail.com> <3834ea8f9becc9d6e1b407679e8a95dc6c9d56de.1762890152.git.gitgitgadget@gmail.com>
 <xmqqwm3wtat8.fsf@gitster.g>
In-Reply-To: <xmqqwm3wtat8.fsf@gitster.g>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Thu, 13 Nov 2025 22:41:15 -0700
X-Gm-Features: AWmQ_blXeG14xfAS1qazgqHiFvLYLZ1Ve61xFVEp0IaiSvQDDo0XNBXaezv-o8M
Message-ID: <CAH=ZcbCJ4MXnHpspuT+KkeR6LRTQrzh-7v5ep9S8WPRjdteR8g@mail.gmail.com>
Subject: Re: [PATCH v3 06/10] xdiff: split xrecord_t.ha into line_hash and minimal_perfect_hash
To: Junio C Hamano <gitster@pobox.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Patrick Steinhardt <ps@pks.im>, 
	Phillip Wood <phillip.wood123@gmail.com>, Chris Torek <chris.torek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 4:21=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > To make this clearer, the old ha field has been split:
> >   * line_hash: a straightforward hash of a line, independent of any
> >     external context. Its type is uint64_t, as it comes from a fixed
> >     width hash function.
> >   * minimal_perfect_hash: Not a new concept, but now a separate
> >     field. It comes from the classifier's general-purpose hash table,
> >     which assigns each line a unique and minimal hash across the two
> >     files. A size_t is used here because it's meant to be used to
> >     index an array. This also this avoids ` as usize` casts on the Rust
> >     side when using it to index a slice.
>
> How much extra memory pressure does this change cause?  In a single
> instance of xrecord_t, we used to have a single ulong plus a pointer
> and a size_t; now we replaced the single ulong with two 8-byte words,
> so 33% more memory per record, which is not so huge a deal?

This was asked and answered earlier in this patch series [1].

> >  static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf,=
 xrecord_t *rec) {
> > -     long hi;
> > +     size_t hi;
> >       xdlclass_t *rcrec;
> >
> > -     hi =3D (long) XDL_HASHLONG(rec->ha, cf->hbits);
> > +     hi =3D XDL_HASHLONG(rec->line_hash, cf->hbits);
>
> Very nice that we can lose these random-looking casts.

This was Phillip's suggestion [2]. Thanks Phillip.

[1] https://lore.kernel.org/git/CAH=3DZcbD7FeRHtYvN_4=3DqHApB-AwK18=3DKRU2S=
GWNg8ADkrFM-Fw@mail.gmail.com/
[2] https://lore.kernel.org/git/a66fb440-058e-4cd8-8971-9c320c0387e8@gmail.=
com/
