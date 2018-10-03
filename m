Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5CD21F453
	for <e@80x24.org>; Wed,  3 Oct 2018 15:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbeJCWlF (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 18:41:05 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33433 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbeJCWlF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 18:41:05 -0400
Received: by mail-ed1-f67.google.com with SMTP id g26-v6so5843383edp.0
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 08:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=M2zBGSnfIgOfnhGpWoCg14Mi5CqwTfHikFw6l9k/j5A=;
        b=oc6jlT+CcDKTPwC48J5i9EPjujq+sjGv+zlM1n3BB9dwZfHBdtgud9wfO3kmfH3bHA
         ipnJ5wQOkj61ZYi6yhI+Li83CoPQqrPQyBiSsNzCxVn4dQJZRyny31rSU21SRCa6F/IZ
         JaJxI/EoXeuz8p0YBQN8VSqFwFFC84k5zzhA2r/hc3I4iRNrOEIcCw3JF+Uvt68H3o0y
         xfwPDmWzbA0pVjVIbASgzHeOhe4uVr76Hrb7+R/KpJZMqX0H+ZRgawGxpNItJY7OavBD
         yfYlQhEcMZqksQQt2ghTTIhebAQ+y2xorovYblLuQWlWuFEQcqO1EfYTj0K168LPSnXO
         Ry7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=M2zBGSnfIgOfnhGpWoCg14Mi5CqwTfHikFw6l9k/j5A=;
        b=VbfqnGMHQyKcslJn6H650GyTUqzHq+gQm2l18xAhb5WLocMT9frvTkjhFxu6vubReG
         ENMJImbWaJDe2enBia8j5Kn1IkFQVmvbyG4z1I0AvltGhMwsXzcG4vU4eJt1hJ7fq1tp
         paameICqi9SwqGldh1ihPlNzCkCzQR8LyS2iLgkopaveqrfAdwPBWFlLGl4OkO63nFNi
         90HEFJwwnLM1Nhkxx/9pH9Ov0FrE/u3CdivsTXCwBfGaHfPEsvz2TT/iGo6tkS9J4BQU
         c2r1drzz65SAXFGMoN10eaI3yiWDyZtzN3oGS8wEL++CDORMmxo5V35z1yqKlZkNj9EI
         bZCA==
X-Gm-Message-State: ABuFfohR/lPmPzCw/7yFuFroOc7UX0kySzeb91ig/2Ab/5+D+U7usnA2
        ziTEGZ6Tuy5lMKoKrmiNwQVix2M19VL4fGKuWpo=
X-Google-Smtp-Source: ACcGV60NVpZ9Aw1DhWHDEQAHKukMk8xPVVQmL0XnyUS59miJenP3oP0Av6e9nQC9ZNRC7IFbNdrhDj17ta5wl243Bss=
X-Received: by 2002:a17:906:a884:: with SMTP id ha4-v6mr2532119ejb.143.1538581926071;
 Wed, 03 Oct 2018 08:52:06 -0700 (PDT)
MIME-Version: 1.0
References: <20181002191642.21504-1-jacob.e.keller@intel.com>
 <20181002195519.GB2014@sigill.intra.peff.net> <20181003101658.GM23446@localhost>
In-Reply-To: <20181003101658.GM23446@localhost>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 3 Oct 2018 08:51:54 -0700
Message-ID: <CA+P7+xoos=7WAn+L1W=_OrY6+_WvrptjhrGFPvhArq=WG0gi5A@mail.gmail.com>
Subject: Re: [PATCH] coccicheck: process every source file at once
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Jeff King <peff@peff.net>, Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 3, 2018 at 3:17 AM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wro=
te:
>
> On Tue, Oct 02, 2018 at 03:55:19PM -0400, Jeff King wrote:
> > On Tue, Oct 02, 2018 at 12:16:42PM -0700, Jacob Keller wrote:
> >
> > > make coccicheck is used in order to apply coccinelle semantic patches=
,
> > > and see if any of the transformations found within contrib/coccinelle=
/
> > > can be applied to the current code base.
> > >
> > > Pass every file to a single invocation of spatch, instead of running
> > > spatch once per source file.
> > >
> > > This reduces the time required to run make coccicheck by a significan=
t
> > > amount of time:
> > >
> > > Prior timing of make coccicheck
> > >   real    6m14.090s
> > >   user    25m2.606s
> > >   sys     1m22.919s
> > >
> > > New timing of make coccicheck
> > >   real    1m36.580s
> > >   user    7m55.933s
> > >   sys     0m18.219s
> >
> > Yay! This is a nice result.
> >
> > It's also one of the things that Julia suggested in an earlier thread.
> > One thing I wasn't quite sure about after digging into the various
> > versions (1.0.4 on Debian stable/unstable, 1.0.6 in experimental, and
> > pre-1.0.7 at the bleeding edge) was whether the old versions would be
> > similarly helped (or work at all).
> >
> > I just replicated your results with 1.0.4.deb-3+b2 from Debian stable.
> > It's possible there are older versions floating around, but for
> > something developer-only like this, I think "in Debian stable" is a
> > reasonable enough cutoff.
>
> Linux build jobs on Travis CI run Ubuntu Trusty 14.04 LTS, and
> therefore our static analysis build job still runs 1.0.0~rc19.deb-3.
>
> This patch appears to work fine with that version, too, though note
> that I also changed the build job to don't run two parallel jobs; for
> the reason see below.
>
> > > This is nearly a 4x decrease in the time required to run make
> > > coccicheck. This is due to the overhead of restarting spatch for ever=
y
> > > file. By processing all files at once, we can amortize this startup c=
ost
> > > across the total number of files, rather than paying it once per file=
.
> >
> > One minor side effect is that we lose the opportunity to parallelize
> > quite as much. However, I think the reduction in total CPU makes it wel=
l
> > worth that (and we still have 8 cocci files and growing, which should
> > keep at least 8 cores busy).
>
> One major side effect, however, is the drastically increased memory
> usage resulting from processing all files at once.  With your patch on
> top of current master:
>
>   $ for cocci in contrib/coccinelle/*.cocci ; do command time -f 'max RSS=
: %MkB' make ${cocci}.patch ; done
>        SPATCH contrib/coccinelle/array.cocci
>   max RSS: 1537068kB
>        SPATCH contrib/coccinelle/commit.cocci
>   max RSS: 1510920kB
>        SPATCH contrib/coccinelle/free.cocci
>   max RSS: 1393712kB
>        SPATCH contrib/coccinelle/object_id.cocci
>        SPATCH result: contrib/coccinelle/object_id.cocci.patch
>   max RSS: 1831700kB
>        SPATCH contrib/coccinelle/qsort.cocci
>   max RSS: 1384960kB
>        SPATCH contrib/coccinelle/strbuf.cocci
>   max RSS: 1395800kB
>        SPATCH contrib/coccinelle/swap.cocci
>   max RSS: 1393620kB
>        SPATCH contrib/coccinelle/xstrdup_or_null.cocci
>   max RSS: 1371716kB
>
> Without your patch the max RSS lingers around 87048kB - 101980kB,
> meaning ~15x - 18x increase
>

Quite a significant increase.


> This might cause quite the surprise to developers who are used to run
> 'make -jN coccicheck'; my tiny laptop came to a grinding halt with
> -j4.
>
> I think this side effect should be mentioned in the commit message.
>

Yes I agree. I hadn't considered the memory problem.

Thanks,
Jake
