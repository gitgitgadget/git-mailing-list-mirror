Return-Path: <SRS0=w3fS=3B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD513C32771
	for <git@archiver.kernel.org>; Sun, 12 Jan 2020 06:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C4F22082E
	for <git@archiver.kernel.org>; Sun, 12 Jan 2020 06:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TbEN+RCj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732307AbgALGoP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jan 2020 01:44:15 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39095 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732302AbgALGoP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Jan 2020 01:44:15 -0500
Received: by mail-wr1-f66.google.com with SMTP id y11so5493883wrt.6
        for <git@vger.kernel.org>; Sat, 11 Jan 2020 22:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yBKeY+etNxLSH9hTk6wwVbc3xhqEcIN4cirYzm1YNPI=;
        b=TbEN+RCjGMwfjT3KQ50hp7HHXRDnRYeHq3z6FAp6CKXNyOSMvcUupDq88ZIW+pSs86
         IkXGLQ0nCGMgZo026SaNZnHW1v/vevUSG8GmnGtRRZRVXaO72ag0Eu+kO7dohq5f59Os
         uLG1w7UXkjSLxvKhTnpKCggiWIW+bDcBVJsuLGUMLQOYEpeukzYiXjaavNQTB5WnKUch
         OJeRGm68ftHAaNRdSAH0vnbnn0n3HSwKzKqievy1CdeBCCFOYD3jf3hWc0KCqgJDU3XE
         jfN90gsiVMZPVuLtrc/M85D4KdR07FbWU6NXfu3QjIofYT/l6sd3sfbYB7F9sOOWmg1G
         iRbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yBKeY+etNxLSH9hTk6wwVbc3xhqEcIN4cirYzm1YNPI=;
        b=p7ZURiAQ2IUTD3RUWhUtjFSfFe+HAbwo7rsCT1g6d/KTF4xb+5WA/Zq64tD0UF+sXx
         dR5cgiUKxI7Vt7NZsuFfuKCzxE8tRfnDNfb9EHH1dkw7X9uG60IBtw+70CZG6zORsnjz
         zZCIB/97gDnkDfW9d51txREUlhkzVkYRvw0eMRVKSdmcUZPHx/IhgbCUpmEB7Z//HSOC
         e+5n1AZQ05xfRf4BdqCItF0myK+A5AJR8T5/sLQE3o/PU7TXUNQqcGLUqIrG/HneZoM8
         PSiU9oFW1Ou3KB6rHYfqbfqWm+4tGcGyV8ZliGKTUv3H+zamHk1IRJS1K6KV1dbuyvfV
         FbRg==
X-Gm-Message-State: APjAAAVnm4HOFYNS9Z03vyxHq5aHCM6ImekaUb4FMai3/xHtR4PXMGqm
        R2ddwyQcJPPDPhiUFgSiWzuA1AwPeuBLejFkE44=
X-Google-Smtp-Source: APXvYqzX6Pt64AlBBeSpzDow7LBuZ5pSAvOaPOi54ay1Yo7zuSG3dsLpM3vn+9LSp62u0SJUcKM06dmh87ibWuuaBDM=
X-Received: by 2002:a5d:66c3:: with SMTP id k3mr11265924wrw.370.1578811453346;
 Sat, 11 Jan 2020 22:44:13 -0800 (PST)
MIME-Version: 1.0
References: <20200111123533.1613844-1-marcandre.lureau@redhat.com>
 <CAPig+cQXkiFOz5HczPEgXuSOH_3KsCwXwVwe0qvQzLDtFgnAXw@mail.gmail.com>
 <CAJ+F1CKW3NACgPdPbmAzYGVwR4iO3r+LCNq+g5st0gcz4X+fzA@mail.gmail.com> <CAPig+cRCMXjjPHc2O8fLmaSm9m-ZO3qR2BoZwG3s5dLHNbiFFQ@mail.gmail.com>
In-Reply-To: <CAPig+cRCMXjjPHc2O8fLmaSm9m-ZO3qR2BoZwG3s5dLHNbiFFQ@mail.gmail.com>
From:   =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date:   Sun, 12 Jan 2020 10:44:01 +0400
Message-ID: <CAJ+F1CJP88PXP0vLtXQd82Z3RmX0uGic2NxBy3iSh0nBnRG0Vg@mail.gmail.com>
Subject: Re: [PATCH] branch: let '--edit-description' default to rebased
 branch during rebase
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric

On Sun, Jan 12, 2020 at 5:27 AM Eric Sunshine <sunshine@sunshineco.com> wro=
te:
>
> On Sat, Jan 11, 2020 at 9:55 AM Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@gmail.com> wrote:
> > On Sat, Jan 11, 2020 at 5:28 PM Eric Sunshine <sunshine@sunshineco.com>=
 wrote:
> > > On Sat, Jan 11, 2020 at 7:36 AM <marcandre.lureau@redhat.com> wrote:
> > > > +                               if (wt_status_check_rebase(NULL, &s=
tate)) {
> > > > +                                       branch_name =3D state.branc=
h;
> > > > +                               }
>
> Taking a deeper look at the code, I'm wondering it would make more
> sense to call wt_status_get_state(), which handles 'rebase' and
> 'bisect'. Is there a reason that you limited this check to only
> 'rebase'?

No reason, I just didn't try it yet. Done, thanks

>
> > > >                 if (edit_branch_description(branch_name))
> > > >                         return 1;
> > > > +
> > > > +               free(branch_name);
> > >
> > > That `return 1` just above this free() is leaking 'branch_name', isn'=
t it?
> >
> > right, let's fix that too
>
> Looking at the code itself (rather than consulting only the patch), I
> see that there are a couple more early returns leaking 'branch_name',
> so they need to be handled, as well.

I think I covered them now, sending v4.

thanks

--=20
Marc-Andr=C3=A9 Lureau
