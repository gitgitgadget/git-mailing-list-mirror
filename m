Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_MONEY_PERCENT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5B9C54FCC
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 00:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70CA020706
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 00:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WL4jHr9Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgDVANb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Apr 2020 20:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgDVANb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Apr 2020 20:13:31 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FDBC0610D5
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 17:13:31 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id j26so655620ots.0
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 17:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UEiSq+ob2Zh7S3YI/NM6excDEHkManmqJ3mQ1I5W3tM=;
        b=WL4jHr9ZALmTd9cwz/kBp3NxL9cVwVzRrqKJhdnk92arPYYZcEdWba2WLM6vZ1FHuU
         YtLvBp7h80NqpImcYNP0dhq59uM0CzKr07ViPGP+UUP0qSqnIQ4SWgzJYXlfyvDKdVtQ
         uZwMcfPGDTpWKwxLMkPlYcg0he3/FnXM6v34kdBXI7cA6Rg/GiEqXvpLNESOoeb3pb2n
         ESYgSQiMY/qvE0LeYc908b8EaaRXTK3M5xeegZO5c2Zu7LmlUK7rc+Ypb01CZ5/GUBY9
         J8LqkzQiGPWt339UnNDPSSgq0MRchLckyiq7NL2lsR1H+Ev8Vp0e8QQYuQXFtZB8Rd7G
         Fx/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UEiSq+ob2Zh7S3YI/NM6excDEHkManmqJ3mQ1I5W3tM=;
        b=knfQIcBpafKn14yEkaBTAXkYOJEpc37+puBc/IeQ29yJlIOU9YYeVrDfToUNELmILQ
         ke+JDS8MuJDg1/6BgOQtOb5l07Pszlt6AqryWw4NVQMif+CT8KJQ2pxZbtxbJQ7uu1B4
         IEVxnffiA0fjOedTeeq/iZC5Glc0yqVem0MyauC+2dBfpzpmT2Fpxd2v34xzYAE7ddMh
         1U5bmrjkUNNHDzo5mYvYXHKBB8UadaC0l2bYf/Tbg1LvwCZf8nd36F/5Zx9qvwmCbsGL
         6gjaVIKgzDTlUmBdardUGpuwXYtgs/MURGAERDfvXescF0mdvBVCO3mpBG78+2Jkxs4g
         oZgg==
X-Gm-Message-State: AGi0PuY57XaS4SZ4tdYodJXbNlfJ+c0RcbsT5E2XYErc3wJaSFKqCkuN
        4hDDLPAUNuwkNUrXPWPp0AD/+lRh3YK0Y4/eOKM=
X-Google-Smtp-Source: APiQypKU4Yw49nLXy0MnwEWKGH45lnR+4omKaVRJh4JT0mT6PKLUi+QChPiJ11FsopO9mDiT4Vv0NPzM/PcjUcuC6Tc=
X-Received: by 2002:a05:6830:92:: with SMTP id a18mr16186377oto.317.1587514409877;
 Tue, 21 Apr 2020 17:13:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200421131223.29337-1-shouryashukla.oo@gmail.com>
 <20200421131223.29337-4-shouryashukla.oo@gmail.com> <xmqqy2qomwwl.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqy2qomwwl.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 21 Apr 2020 17:13:18 -0700
Message-ID: <CABPp-BEp-YVKCP7OFHjMgh+jQXgTWh11SHJmvTn847z3Owc1mg@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] gitfaq: shallow cloning a repository
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Shourya Shukla <shouryashukla.oo@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <dstolee@microsoft.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 21, 2020 at 1:00 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Shourya Shukla <shouryashukla.oo@gmail.com> writes:
>
> > Add issue in 'Common issue' section which covers issues with cloning
> > large repositories. Use shallow cloning to clone the repository in
> > a smaller size.
> >
> > Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
> > ---
> >  Documentation/gitfaq.txt | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
> > index 13d37f96af..cea293cf07 100644
> > --- a/Documentation/gitfaq.txt
> > +++ b/Documentation/gitfaq.txt
> > @@ -275,6 +275,20 @@ I want to change the remote of my repository. How do I do that?::
> >  One can list the remotes of a repository using `git remote -v` command.
> >  The default name of a remote is 'origin'.
> >
> > +[[shallow-cloning]]
> > +The repository I am trying to clone is too big. Is there an alternative
> > +way of cloning it in lesser space?::
> > +     One can clone a repository having a truncated history, meaning the
> > +     history will span upto a specified number of commits instead of
> > +     the whole history of the repository. This is called 'Shallow Cloning'.
> > ...
>
> The question is worth keeping but the answer is questionable.
>
> I have a feeling that --depth/shallow is deprecated/frowned upon
> these days and more people recommend partial/blob-less clones
> instead (a few random people added to Cc: to see if they want to say
> something here).

I don't have a problem with us saying we have to support shallow
clones for years or decades more, but I personally strongly dislike
advertising it, for multiple reasons:

* From an internal perspective: The shallow clone implementation feels
like a hack that isn't extensible and doesn't work with other
features, and as far as I can tell that's intrinsic to its design.

* From an end-user perspective: Shallow clones are heavily misused,
oversold, and induce or perpetuate various misunderstandings.  CI
systems seem especially keen on turning on shallow clones whether
requested or not and breaking all sorts of things from simple (like
'git describe') to the more complex (like merge this branch with
master and run tests there too to avoid breaks due to semantic
conflicts) and all sorts of things inbetween (e.g. when trying to
'debug with SSH' the user can't look around in the repo because it's
all missing).  Despite the huge waste of time projects induce by
defaulting this on and sometimes making it hard to turn off, is to
'save space' and they often sell it as a dramatic savings.  B if it's
a standard source code repository then usually you save only about 50%
of the overall download size. (Years ago, I used to like to point out
that a git clone of a repo would only be marginally bigger than a svn
checkout, despite having 'all history', and had a handful of repos
where I had measured the cost to back it up).  The way CI folks talk
about shallow clone makes people assume that 'all history' is
hundreds/thousands of times bigger than the most recent checkout.  The
only case where 'saving size' seems to matter is either the special
simple cases that have really simple builds (though they tend to be
small enough that the size doesn't matter anyway) or for repos that
have accidentally committed huge files in their history that are no
longer present in new versions.  But because shallow clones are touted
so much, people come to perceive the cost of 'all history' as being a
very onerous requirement in git.  And the perception seems to be
sticking in lots of places.  I can sometimes go dig out facts for a
repository in question to show people the differences in sizes and
dispel some of this, but that's a one-by-one case.  I think these
misunderstandings hurt us as a community.

* Diversion of resources: Even though there are current valid usecases
for shallow clones (e.g. Randall sounds like he has some), advertising
this feature is going to make it harder for us to focus efforts on the
better designed solutions we want to implement and extend.  Perhaps a
funny story is in order: At $FORMER_JOB, we made software used by
various groups on supercomputers (or high performance computers, or
however you want to refer to that class of many machines).  One
customer requested support on Itanium machines, and we made the
necessary (though painful) adjustments.  At some point we decide to
list our supported platforms on the DVDs we sent out.  Then at some
point, the Navy decides they're going to buy some nice
supercomputer(s).  They want to use our software, but also want to use
general well-supported industry standard hardware.  They put out a
purchase order for $100 million (I don't remember the real number but
it was large), and overlooked specifying the computer architecture.
Vendors who were just about to retire the very last Itanium chips and
were literally going to just scrap the rest of their inventory notice
this purchase order, bid on the procurement at dirt cheap prices, and
then the Navy is stuck because of "don't waste taxpayer dollars" and
"procurement has to be fair".  They need those machines to work for
several years.  Anyone who provides them software has to support that
architecture for several more years, but the vendors would not sell
any more Itanium machines after that even if you begged, so we were
working with some really old Itanium machines that didn't have enough
power to run the basic regression test in under 24 hours.  The last
sysadmin at $FORMER_JOB with the necessary qualifications to actually
maintain those systems (not just knowledge but red tape box checking
too; this was government after all) was retiring about a year and a
half before the mandatory support period ended for us as well.  We
found out at some point that they checked our requirements before
putting out the purchase order; had our DVDs only advertised support
for x86_64, the whole debacle could have been avoided.

Yes we totally need to support shallow clones (I brought them up as a
concern for fetch.writeCommitGraphs just last week after all), but I
really don't want to advertise them, and if we need to in some way,
then minimize it.

Anyway, that's my $0.02.

Elijah
