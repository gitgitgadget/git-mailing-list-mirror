Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072DA3112BF
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 16:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758558467; cv=none; b=uE9V0y9MN6qA6b4VVMZNMPkAUIPU9rRXGaiHXQrvxvSlfOfrGjnRJWBparCSXyhjKGFvmtS5WckkCpngyiPIGzRF7ax52yOWgOqakiwuoUTqSUi2gENGJcykaL+3Hak38SDcgs9//158pvgyRLHbjwtkL04/7/1iobkgfP6EGtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758558467; c=relaxed/simple;
	bh=kHfI/htBEXep84s4nNibuB6kQ2fAwtXZ9j596sKtLSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c9/LbnJfFsmygo9mTlrs0ODq4hMpRkdmMqY5kqUWDNgk9+JZHqOddByKPDWlOgKcnQkInFPRMv0sGiUviEI0+L32VmNwaHiZN49PE98whw8y8jZcJSROtIiCFVcEj/iAA+ecy8LPKU8uqk/oIdTKpo6oY0GGhnn+LdDd9UCMvGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h/5/0OD7; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/5/0OD7"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-36453927ffaso28414281fa.2
        for <git@vger.kernel.org>; Mon, 22 Sep 2025 09:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758558464; x=1759163264; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHfI/htBEXep84s4nNibuB6kQ2fAwtXZ9j596sKtLSk=;
        b=h/5/0OD75bIOn0WdrGxZxWPblwu3HEk0GRcswROThWi5LCfr3fDlfsag61NPYwdxY1
         5Dz8t9vrahoKSmJeUBcpeFhEpZd13s0pjfio30LiQv5VeMu6vXToPCmofZ+ihJyxVgv+
         j0+AWuxum7zCZMvjqJ/WJpTIZ76+R/ZOUMgNGTXYrJ9P+4IZEdBP4r3pytV8Kduvf/El
         RmaZF+JiLWhMZAurPCeF8AFUk2CNRbYivwkWgzOiElwmxuwyTvs0EhlVpeDBYlx0ch9f
         Eh3G0mYRd2yqA2ntCD743ZbP+mL35+seL07N8F8m7yXLbk/of9z4pD6XR4+eJCvmomnj
         B/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758558464; x=1759163264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kHfI/htBEXep84s4nNibuB6kQ2fAwtXZ9j596sKtLSk=;
        b=dJx6+U4o/9bke/2OgV4KF6uj+e13LDVEDl7k9Mij9t1AEfrcYCWmtvH+rTyK7qN3fE
         712T9Ad+k2u4EEiC1jQ3hzD1Iy9S73JYFa0aoO2ItWtveHCyyXZJgMd/p/Jzt8Ujbj0j
         OfemCKZzw7KgguIflfhYTgq6LfdZlxx2nNwsbFKINwTbMpHaANXM/3b/1deyJdzmOp7Q
         l2ocV26V3XFRsQoSlDwElBFh+9umYKf2A8tWw3AZCGEzqQwzBS5JZHu1OshZ2QqSBhmQ
         bW3Sz5SIMwIqRIYMq5ybOa4E89vmG9QNNVr/wnHgTlm6Yd02TbHdlHapzu/uwsKUGhAv
         aZgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVc0Wc3ndO4VpzoJcI+ou6lE6LeFh6/dgrXshy9nwX0S+6XSHPOX9CQjbS42o84TFQJvDE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpq8GdNVCqFLMArraw5YQoMq1a5LhJ7CsgOdSaO0KBY9UHfmNn
	HiOcowNuj/SieqGi2MYRNSeczgaBwX58DEGho8rPax5s8GZ+4/Ng+By9iCdFKDQDXN3qEWUWA4D
	rqkaefG8zzuOk/5+m9ZHEKYtmEPi/rJM=
X-Gm-Gg: ASbGncvWl2vh3RIzdvwUsL9fENRSsb9k1Z0kMlf7ucMKZtKvGAtK1NNLSDExvy7Ockk
	+3jH4DaUE3qr9Rub8y7Qt/kTLubbXBfWQkcYAKe3qxuO2ZjDABIqOH6vy8jtSIzgl0vrAeYwEvh
	TTsmLFJGblAYaslD//VHzSoJgMwcDzddu2BxZWT/ZSJmt5PjFGuXg0p37ACVO0yytU1i4y0EHda
	xMau7jR
X-Google-Smtp-Source: AGHT+IHbdojIzMTePfe20QHAf4qhCGOWlx1fIZ4CYXyI5FEV6oH4RVZOmwgsJdudXyCDnIWL6XJFYI4M6iUGZsyfCbU=
X-Received: by 2002:a2e:a547:0:b0:36b:f63:27a1 with SMTP id
 38308e7fff4ca-36b0f633c09mr18646321fa.40.1758558463669; Mon, 22 Sep 2025
 09:27:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
 <pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com> <xmqqcy7pc8ix.fsf@gitster.g>
 <CABPp-BHJUkSERQon6xx=sHrhN7i=6ekv+Hz1+P+2mh0=Xw15Mg@mail.gmail.com>
 <xmqqy0qcae6z.fsf@gitster.g> <aNFIwFD6E6Lngy5M@pks.im> <CAH=ZcbDkDfc6j_gQCt_q9RLP_ozYqr09i1-xe2mvhSQRgf8MGg@mail.gmail.com>
 <aNFz-0rO79l7crZ5@pks.im>
In-Reply-To: <aNFz-0rO79l7crZ5@pks.im>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Mon, 22 Sep 2025 10:27:32 -0600
X-Gm-Features: AS18NWDNiubOkRHuOl2hnXo945zSJ3mYrNjUlPWKbRBKLJsOOGEB9JFU4ecIePY
Message-ID: <CAH=ZcbB_AZ7a=kQ_tHRtm7jPD6h_7AAiQYyaMQrG+ijj8Dyvrw@mail.gmail.com>
Subject: Re: [PATCH v2 00/18] Introduce rust: In xdiff
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>, 
	Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 10:16=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wro=
te:
> On Mon, Sep 22, 2025 at 09:18:14AM -0600, Ezekiel Newren wrote:
> > On Mon, Sep 22, 2025 at 7:01=E2=80=AFAM Patrick Steinhardt <ps@pks.im> =
wrote:
> > > I personally think either (A) or (B) would be good choices. I would
> > > slightly lean towards (B) just so that we have something that we can
> > > already play around with while building the next steps.
> >
> > I'm fine with B if you fix the wording in your Breaking Changes about
> > Rust being introduced in version 2.52. Rust was introduced to Git in
> > 2.49.
> >
> > Elijah points this out in 1 and 2:
> > [1] https://lore.kernel.org/git/CABPp-BFXRbaHk9U3BX+d12bZ+ryGOp+btR0ODM=
w+HtD7xd+MBQ@mail.gmail.com/
> > [2] https://lore.kernel.org/git/CABPp-BEiK49f_UB5UPe3qM9O7vQGGFJ8Nshw1f=
6W_6Lw7HRL6Q@mail.gmail.com/
>
> Will adjust.

Thank you.

> > > By the way: I'm also happy to change attribution of some of the patch=
es
> > > in my patch series to mention Ezekiel as author. I don't care much wh=
o
> > > is listed for the initial patches that introduce Rust, but would reta=
in
> > > my own authorship for the "varint" and "BreakingChanges" commits.
> >
> > My only other concern is with varint. You use usize on the Rust side
> > and then uint64_t on the C side, but I'm ok with fixing that later as
> > it only breaks 'linux32 (i386/ubuntu:focal)' in the github workflows.
>
> Oh, this is actually an oversight, good catch! I refactored "varint.c"
> to use `uint64_t`, but then forgot to adjust the Rust side in the same
> spirit. Will fix.

You also missed updating varint.h.

> I suggested in [1] that I can change authorship of the patches that
> introduce the initial infrastructure into Meson and our Makefile (so I
> guess patches 1 and 3) to instead list you as author and myself as
> Co-authored-by. Is that something you want? Given that you have
> kickstarted the whole effort around introducing Rust again I wouldn't
> mind that at all.

It doesn't make sense to me to list myself as the author of any of
your commits, but I would like my name referenced in your commit
messages.

Thanks.

Ezekiel.
