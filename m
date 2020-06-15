Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2863BC433E0
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 05:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE5B8206E2
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 05:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LX/K5HAe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbgFOFUM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 01:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbgFOFUM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 01:20:12 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A9CC061A0E
        for <git@vger.kernel.org>; Sun, 14 Jun 2020 22:20:12 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id i8so2232667lfo.4
        for <git@vger.kernel.org>; Sun, 14 Jun 2020 22:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WoeT5K6GW92w3fp4qu3FnHhjON+On+75CPt5tE8KO4I=;
        b=LX/K5HAeVsI1vL2sWa+4XgiTRIvPUP98GQkDkpRrqov2X4Dcr3V2BJbGx2I8eTczLs
         hgt3cAockE79VMdEzoWPo0pCm4hPKji4DZi/A3aZKepBAJi5UNH0j727l7jOc+KCdgln
         /GIs0HOgRqwfGFsGUhG4UyuiPxM6XzcQ6D5+nhomYr7XMqWQqLHZy7IBmvp8lSTDxx5X
         1l1uPv1DMaHeHNGN2grQ6n/jJd3zAwq+r3ljGt4VE/WCclZOdTAeg0EGFoGGxOYlVIav
         etLtK5rUC0QDmtPwhg5zDZ+ALgUaET7u5RdfVW+toE67kXMsCXnKS0LcJPEgEkIH836z
         vFOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WoeT5K6GW92w3fp4qu3FnHhjON+On+75CPt5tE8KO4I=;
        b=DLFSclbIh4pMYdWpbTbMQnfqEY039IWFXtwAparK74t5ctOR+1Slc5Vf5k2VNiLZpn
         lzc+naInx4XtJZY/0IMQRwm/Ba0PR4BWlra1nn9XHCSwrE+WKZ+hQTTeeQvLE4cK15YV
         NKqLhGdu+cO2XbzyXe445yRtqUl1QCsi0sqYq5uUwAuDLyuhNZaDp1AH2y7+vFJA1MJj
         /cRrxULvaTx61OUCYTQQusnXampRfz5OXRSBpNJgPqfGveAwEZ+kyP85KBaDsx/HQoFy
         i89/8Wb+49e0a4e12st/JLZreEwT3UYuGyub/SYihuIufrGySK4hnx+fOr7R492wbIOV
         XaWw==
X-Gm-Message-State: AOAM530jHp5uCNmPiOUnCGh+tgQbdQvdu9oGPMBZcAGSxSZMfaBrfPzt
        R0fTHZbQTJMG5BTPY0xOfRFDrgrqo+ZJ+N2zUoDfhSvzZh55iA==
X-Google-Smtp-Source: ABdhPJzGhgsjGd+GTOwqglYxLnHnQtSVBLK0ralUYSTJliQOemOf+3+KmPCIlA8xfwlIgFc1RI8YhfzMmQ2bi2Fl0Y4=
X-Received: by 2002:a19:c216:: with SMTP id l22mr601581lfc.98.1592198410025;
 Sun, 14 Jun 2020 22:20:10 -0700 (PDT)
MIME-Version: 1.0
References: <9d3d3888-55e5-61f0-1541-9854a70fb233@iee.email>
 <d020d05f-5e36-2959-3eae-d7e21bf51178@gmail.com> <CAGA3LAfqzBsn91YTYaCT5y9XLeNLY_0B_7b1f3fdc6X4JOU81A@mail.gmail.com>
 <CAH5451n7e39ZCM4iJ4Ry=g7QkVYwFL-a=9CTVOifp+rcvb5i_g@mail.gmail.com> <20200615044533.GA24311@sigkill.com>
In-Reply-To: <20200615044533.GA24311@sigkill.com>
From:   Andrew Ardill <andrew.ardill@gmail.com>
Date:   Mon, 15 Jun 2020 15:19:38 +1000
Message-ID: <CAH5451nUVB33RkSM2nzJ_yiKF_zSnWGj1FzHwMetg_yVUH05Cw@mail.gmail.com>
Subject: Re: Rename offensive terminology (master)
To:     "J. Paul Reed" <preed@sigkill.com>
Cc:     Don Goodman-Wilson <don@goodman-wilson.com>,
        =?UTF-8?Q?S=C3=A9rgio_Augusto_Vianna?= <sergio.a.vianna@gmail.com>,
        philipoakley@iee.email,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>,
        =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
        newren@gmail.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Simon Pieters <simon@bocoup.com>, stolee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi J. Paul, who would have thought! :)

On Mon, 15 Jun 2020 at 14:45, J. Paul Reed <preed@sigkill.com> wrote:
> Heya Andrew... turns out I read this list too, so... thanks for referencin'
> all my work!

No problem, I appreciated the effort you went to.

> > Even if git borrowed 'master' from BitKeeper AND BitKeeper used it in
> > a "Master and Slave" fashion, that doesn't mean that the person
> > introducing it to git was using it in a "Master and Slave" fashion,
>
> https://marc.info/?l=git&m=111968031816936&w=2

This is an example we discussed on twitter, so I'll paraphrase/extend
on what I said there.

This is definitely a "Master and Slave" usage by Linus, but is not an
example of using "Master and Slave" terminology with respect to git
branches.
It is talking about mirroring kernel.org from a master to the mirror (slave).

It's evidence that Linus used "Master and Slave", but not (to my mind)
evidence that the master branch in git was named master because of the
"Master and Slave" meaning of master. It may have been, but this
example doesn't seem like evidence for that.

> https://marc.info/?l=git&m=111634468526506&w=2

I hadn't seen this one before, but this doesn't seem directly related
to this issue either.

Linus says that "the public stuff [note - he is referring to
master.kernel.org:/pub/scm/linux/kernel/git/torvalds/linux-2.6.git] is
the _slave_. It has no meaning. The only important one is the one that
the _developer_ works on."

He is saying that the public master is a slave to (as in a mirror that
follows) his local repository. This is definitely "Master and Slave"
usage (though an unusual one, as something called master is acting
like a slave) but again it is not referring to how branches are named.

In that email, most of his usage is talking about "central
repositories" or "main repositories", and "local repositories" which
are referred to as workspaces; the only reference to slave is the
behaviour of his public repository, in that it follows his local.

> Oops.
>
> > It's just as likely that the 'master' usage was common in the industry
>
> Do you have any specific references to, specifically, common usage in the
> industry, at that time?

Nothing apart from those in my previous email - all of the BitKeeper
references, and the book which does explicitly use the "Master and
Slave" terminology -
https://www.google.com/books/edition/Open_Sources_2_0/q9GnNrq3e5EC?hl=en&gbpv=1&pg=PA29

I wasn't focused on what general usage of master may have been, so
didn't search out other examples, but the reason I think it's a
reasonable alternative are all the usages from BitKeeper (some, such
as the airgap example are very old, relatively) and the fact that so
many developers today seem to think the usage is the "Master Copy"
meaning (and assuming some level of continuity in language over the
last 15 years).

In any case, this is not a strongly held belief of mine, my starting
point was that most people (myself included) seem to assume the master
default branch in git is the "Master Copy", and I haven't yet seen
much evidence to suggest otherwise. Happy to see other evidence, and
I'll go looking for some myself (in my obviously copious free time
haha!)

> > My conclusion?
> >
> > Of all the usages of master in BitKeeper, the overwhelming majority of
> > them are of the "Master Copy" variant, consistent with how I and many
> > other people I have seen comment understand gits usage of the term
> > master.
>
> See above.
>
> > To reiterate my point at the top - I believe this information is
> > irrelevant when deciding what git should do now, and my preference
> > would be to have no default at all.
>
> Cool. Sounds like we mostly agree...

Cool indeed :)

Regards,

Andrew Ardill
