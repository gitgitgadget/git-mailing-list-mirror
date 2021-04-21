Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71242C433B4
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 06:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47E616102A
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 06:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236294AbhDUG6C (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 02:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235123AbhDUG6B (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 02:58:01 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53158C06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 23:57:29 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id g20so20670267vst.2
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 23:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CZvT1yPx0OyFTkeCyUv6uwkDl70c807PnAc0ywtuwcM=;
        b=C+phWs+LngM1Nun+F5N9PeGRSNCoSVZLB9RSha0SfNevXKtF9HFL6Ofhxy4XG9DyB1
         /fcDtXvwgUvuRZ9DSv/7tx7EraUKfXkLBYDCI7nkZ5jThvmE5EByFaf9jH4rwNzfLZCp
         ciZV9YoKymaF9qIrLi4jrEtC7OimyhXSMa3Krr/RXbZTV1LLfrdcx79F+k2lq+JSM2Yk
         FLbXakuTDKURsX5rUTfvApwuVf+w4rAGFC7kerm9TmjqwWKll/OTEjaWK7slo8WZAsG1
         QGCORrNAPdP+qRGWnqBw2F88h0lNpCiGFNqu6imZZnZEwjnHxU8a0NIyKUBE72QJvhfm
         E1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CZvT1yPx0OyFTkeCyUv6uwkDl70c807PnAc0ywtuwcM=;
        b=tZNpkFv2Azh/U3L+Zl2FPetRr+/K1ylIDUOISo9UUARuDa60/EL4korih5k8TQTE2P
         G1OQ+B0VG1iEkrK2qEBip4GNu37N2ze7jpsdgSW2EwCJll6bGRGrikJzVXpiCD9haGSU
         X/9Y2HgosFYzUETuFMEPZp+tcmhrmIGnzE1RsFaPb0zLKbHp/AyAWZ/m7pDkH1oEanmi
         izo5EIFGSgjX6QiuYA/jdndyaVn+DbXFk3dwWmDY7huoRCHApRQNygLeAyF6mvnGMYjK
         nXEtlm9y8VfnH2g7LzrZjvF3Nv2BiOOnLlgfp+WwsED0eYOi8b8+dyUd0bidWLc7N6bN
         ZU2g==
X-Gm-Message-State: AOAM532UbMvXNfSC/8+7idwttO9UPXR0XKZOjdlFFCecbiW9kn5/7Hbo
        ATxQ8b1eTcI99vWRk4TGb6hO1VqcK4sK+FQ9LEA=
X-Google-Smtp-Source: ABdhPJz10TIkkKWXLV/i1U6tzjg5jQQrWraS9xG3qrWK1+NOg+Q3IO6sn+Nnbwr3JRwtScTlRTynUk7wR7WKTJ7JeMA=
X-Received: by 2002:a67:e317:: with SMTP id j23mr24117322vsf.17.1618988248504;
 Tue, 20 Apr 2021 23:57:28 -0700 (PDT)
MIME-Version: 1.0
References: <YHofmWcIAidkvJiD@google.com> <CA+P7+xqzsD+pU=-9YUYdGDAqT4uVk=XS4sdxA5WnAXL_7GwM5Q@mail.gmail.com>
 <013401d73552$287f49e0$797ddda0$@nexbridge.com> <CA+P7+xrOuhG5ujQRYS0=o7S9=xD5zm6BGp5mBRt493Lme9xYcw@mail.gmail.com>
 <YH8hxQKarZW6sU+9@google.com>
In-Reply-To: <YH8hxQKarZW6sU+9@google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 20 Apr 2021 23:57:17 -0700
Message-ID: <CA+P7+xprW6tBH8Yo=-qxD0J8ZeeFspOnAp1RShscNcy7v_4btQ@mail.gmail.com>
Subject: Re: RFC/Discussion - Submodule UX Improvements
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        Git mailing list <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Albert Cui <albertcui@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 20, 2021 at 11:47 AM Emily Shaffer <emilyshaffer@google.com> wr=
ote:
>
> On Tue, Apr 20, 2021 at 09:18:05AM -0700, Jacob Keller wrote:
> >
> > On Mon, Apr 19, 2021 at 12:28 PM Randall S. Becker
> > <rsbecker@nexbridge.com> wrote:
> > > On April 19, 2021 3:15 PM, Jacob Keller wrote:
> > > > A sort of dream I had was a flow where I could do something from th=
e parent
> > > > like "git blame <path/to/submodule>/submodule/file" and have it pre=
sent a
> > > > blame of that files contents keyed on the *parent* commit that chan=
ged the
> > > > submodule to have that line, as opposed to being forced to go into =
the
> > > > submodule and figure out what commit introduced it and then go back=
 to the
> > > > parent and find out what commit changed the submodule to include th=
at
> > > > submodule commit.
> > >
> > > Not going to disagree, but are you looking for the blame on the submo=
dule ref file itself or files in the submodule? It's hard to teach git to d=
o a blame on a one-line file.
> > >
> >
> > Well, I would like if "git blame <path/to/submodule>" did.. something
> > other than just fail. Sometimes my brain is working in a "blame where
> > this came from" and I type that out and then get frustrated when it
> > fails. Additionally...
> >
> > > Otherwise, and I think this is what you really are going for, teachin=
g it to do a blame based on "git blame <path/to/submodule>/submodule/file" =
would be very nice and abstracts out the need for the user (or more importa=
ntly to me =3D scripts) to understand that a submodule is involved; however=
, it is opening up a very large door: "should/could we teach git to abstrac=
t submodules out of every command". This would potentially replace a signif=
icant part of the use cases for the "git submodule foreach" sub-command. In=
 your ask, the current paradigm "cd <path/to/submodule>/submodule && git bl=
ame file" or pretty much every other command does work, but it requires the=
 user/script to know you have a submodule in the path. So my question is: i=
s this worth the effort? I don't have a good answer to that question. Half =
of my brain would like this very much/the other half is scared of the impac=
t to the code.
> > >
> > > Just my musings.
> >
> > I'm not asking for "git blame <path/to/submodule>/<file>" to give the
> > the same outout as "cd <path/to/submodule> && git blame <file>"
> >
> > What i'm asking is: given this file, tell me which commit in the
> > parent did the line get introduced. So basically I want to walk over
> > the changes to the submodule pointer and find out when it get
> > introduced into the parent, not when it got introduced into the
> > submodule itself.
> >
> > This is a related question, but it is actually not trivial to go
> > instantly from "it was in xyz submodule commit" to "it was then pulled
> > in by xyz parent commit". It's something that is quite tedious to do
> > manually, especially since the submodule pointer could change
> > arbitrarily so knowing the submodule commit doesn't mean you can
> > simply grep for which commit set the submodule exactly to that commit.
> > Essentially, I want a 'git blame' that ignores all changes which
> > aren't actually the submodule pointer, update.
> >
> > I think that's something that is much harder to do manually, but feels
> > like it should be relatively simple to implement within the blame
> > algorithm. I don't feel like this is something strictly replaceable by
> > "git submodule foreach"
>
> I think I understand what you're saying. Something like the following
> tree:
>
> super   sub
> b------->4
>          3
>          2
> a------->1
>
> producing something like this:
>
> 'git -C sub blame main.c'
>
> 1 AU Thor       2020-01-01
> 2 CO Mitter     2020-01-02              int main() {
> 4 AU Thor       2020-01-04                printf("Hello world!\n");
> 3 Dev E         2020-01-03                return 0;
> 2 CO Mitter     2020-01-02              }
>
> and
> 'git blame sub/main.c'
>
> a Mai N         2020-01-01
> b Senior Dev    2020-01-04              int main() {
> b Senior Dev    2020-01-04                printf("Hello world!\n");
> b Senior Dev    2020-01-04                return 0;
> b Senior Dev    2020-01-04              }
>
> or to put it another way: if we are treating superproject commit as "the
> whole feature", then it could be useful to see "which feature added this
> change" instead of "which atomic commit inside a feature added this
> change".
>

Right. I often want to find out when some change actually made it into
the super project.

> To me, it sounds expensive to compute... wouldn't you  need to say, for
> each blame line, "is this commit an ancestor of the commit associated in
> THIS superproject commit? ...how about the next superproject commit?"
> But I also don't have much experience with the blame implementation so
> maybe I'm thinking naively :) :)

Well I imagine it has to be similar to how we compute the blame for a
regular file? I imagine we start at some commit and walk backwards up
the tree, no?

I imagine the current blame algorithm starts from the current commit
and walks backwards through the commit history, determining which
commit was last to have a given line.

In the submodule case I highlighted, we would be doing the same thing:
Follow the super project history. When you find a submodule file, pull
its contents from the matching submodule commit that the parent
history saw. No need to dig any further into the submodule commit
history, just give me that contents and then I can treat it as if that
contents was what was in the super project for this commit, and use
the normal blame algorithm.

It's much more difficult to do that manually (hence why we invented
blame/annotate in the first place), and trying to go from "git -C
<submodule> blame file" to then figure out which super project commit
introduced the change is also tedious and non-trivial considering you
might now have intermediate or unrelated changes (i.e. it's actually
possible that that particular commit *never* made it into the super
project at all, because it got skipped over, and it might even be
after the file got re-written)

My idea for how blame of submodujles work is to essentially pretend as
if you had subtree merged the contents of the submodule into regular
parent project files with those paths, and then do blame on that using
just the parent project history.... If that makes sense?

>
> And even if it is expensive, considering that Jacob and Randall both had
> different ideas of what their ideal 'git blame' recursive behavior would
> be, maybe it makes sense to use a flag to ask for the more expensive
> behavior, e.g. 'git blame --show-superproject-commit sub/main.c'?
>

Right I imagine that in some ways both are useful, and it depends on
the context of what you're looking for.

The reason I bring up the blame example is because the idea for what I
want is quite tedious to mimic by hand, and requires more than just a
simple git submodule foreach or a cd into the submodule to operate on
it as a standalone repository.

>  - Emily
