Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF0FC433F5
	for <git@archiver.kernel.org>; Mon, 31 Jan 2022 09:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239521AbiAaJu3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jan 2022 04:50:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbiAaJu3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jan 2022 04:50:29 -0500
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14616C061714
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 01:50:29 -0800 (PST)
Received: by mail-vk1-xa29.google.com with SMTP id o15so7895427vki.2
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 01:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oa101E1shKW6mjsa7ke9XonHRTKyG5R+4ijsj92iQmI=;
        b=myjCpU4SaWkwSeqFCG6Lo7SKigIro5OP1LNVSRkd5poMbrWm9gqkegxJXz6n0xs5lb
         JNU+EaPRPkGVAZCg5GulZy1cIQcsT/gud6MT2YCouqDbCU/Ruc6kTLWOr9KoDol2O9BP
         cQ8s4JMXaTbYhv6UW0KJwrjyYkv920FxP0PHOUjuD6Ff9VYpknPiDWx9S+RhqDKXxjfa
         2vIxQ+MtPsDFuUyklrdjqq3bYQJH2HITEN2FeTVeIJfwOVecpgDn3RzSUAL3q4rSbgc3
         1S4I6ugxz25HQN6ujbRqH9RzgWtuzOl+E4B6mwbwimR2IwuiNX1KfBTiyymfc2VoxiRh
         ce+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oa101E1shKW6mjsa7ke9XonHRTKyG5R+4ijsj92iQmI=;
        b=YmFYnY+C7eOlsLs7SNJs18ikuiGzeoknIMSBxmcLrASIfLBbwCUhyLOQiQTFsQD5zL
         0OuXoHrvLG31TRtta7YnYHczHWjsLbHNtyrkLDsqJ9PxfdydX4JZjztZUMVU0DNZERH5
         iiCGvCmTB7DSTiN3ZQxrUuqd1UXvzoxbg32ZhxtHr3DqmrYJoiHXxT5f9RYjVTrLd1wY
         IGsNV9+0S0QThxXr6ul5hKQ+2GcyPZBiQLg6OYD2AXbXdchlBTKofHFvDZOBo2fFZwrx
         RLmCDH8nuaBhLd/DLhsUeDFlBGivpWTlsYz/L3SF2GrPVZJ4s/uKEnQUKoX4Jc0NRAOP
         b4fA==
X-Gm-Message-State: AOAM533KqEbkmgjRNSHTbI+k+a/TvJoboWaydqbWEfIgyJN2LHFH2Mif
        X+U5kjBC8r3ckCjTdt47TpytnykRvpkkN8hg8SHRxA==
X-Google-Smtp-Source: ABdhPJw+Hp1eJ9e3Q2lvyCat1gf2p/IW6m37hLLW14+EOktT7GFiH4hI9MKw+wV2JUTpPx2H4+ze4uAtN9CKGzay30E=
X-Received: by 2002:a05:6122:a0b:: with SMTP id 11mr7744227vkn.10.1643622627935;
 Mon, 31 Jan 2022 01:50:27 -0800 (PST)
MIME-Version: 1.0
References: <xmqq35lc53e9.fsf@gitster.g> <YfOd7QRK4zjLwJci@ncase> <xmqqilu3woj2.fsf@gitster.g>
In-Reply-To: <xmqqilu3woj2.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 31 Jan 2022 10:50:16 +0100
Message-ID: <CAFQ2z_M_SXENMU6Y3Evrz9-G_+pqjd-zPQiZjnA_y2hvb+Egkw@mail.gmail.com>
Subject: flags types/names (was: ps/avoid-unnecessary-hook-invocation-with-packed-refs)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 28, 2022 at 10:15 PM Junio C Hamano <gitster@pobox.com> wrote:
> > knowledge there shouldn't be any more issues my series. The only
> > question that remains open is Han-Wen's [2], but as I replied I'm not
> > sure we actually need to adjust documentation of the flags given that w=
e
> > already do explicitly say how we pass through flags in all cases.
>
> I'll let Han-Wen answer this first.

I've recently been working on ref iteration, and it's a pretty
confusing area, because the iterator has flags (should it skip broken
refs, etc.) , and the refs themselves have flags (is the ref broken),
and some code must manipulate both in the same function: the ref
iterator structure has a member `flags`, but it's not the flags passed
to ref_iterator_begin(). In code, this all looks like `flags`, the
compiler does no type checking, and it is often hard to see which bit
field goes where. Here we have another thing called `flags` added in a
context where the meaning of the flags can be ambiguous.

If you want to add another instance, that in itself seems fine,
because there is plenty of precedent across the code for this.

My questions:

* am I the only one who struggles with the different flavor of `flags` ?

* if no, what should be done about this? Maybe

  typedef unsigned int ref_flags;
  #define REF_IS_SYMREF 0x1
  char *refs_resolve_ref_unsafe(const char *refname, ref_flags *flags, ... =
);

or

  typedef enum ref_flags {
     REF_IS_SYMREF =3D 0x1,
  };
  char *refs_resolve_ref_unsafe(const char *refname, enum ref_flags
*flags, ... );

A somewhat related gripe is that some code uses `int flags` and other
code uses `unsigned flags`. It would be great to standardize this.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
