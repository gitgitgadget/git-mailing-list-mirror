Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C9A9C388F9
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 04:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6FE220857
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 04:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpScjvYy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgKME2I (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 23:28:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgKME2H (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 23:28:07 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29614C0613D1
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 20:28:07 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id l1so8237607wrb.9
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 20:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=WG8DmJDOZpbHskxaYZUaBpHsj5qxDuD01b8C7Ewu1I4=;
        b=DpScjvYy0y9H39QVI1D54HCrN3ZIk8KyjqSMalXjtBOzdHQ010bkEINr8khFx/rIg4
         cbZNEADe+VguyMs20vntdyzs3JvnbMUnARrGJLHlcTph2Ba6aNMZ9Nfze9kymCTDXqWl
         sBp5ujUDRHgqanELH5FDM7cT7OPGCgiNNbxwWZqIv7xAoM/PLSrt63T3rD/JUZ+nZoyY
         A48M0H9L+BgfD/QUPrCLHMkyxyUZ1N4pXocWLux6xGsEWuSzG9uU2M2G8P7/AicJAv2B
         H8e++/GJ9NrInPxCaMdkrJhZwBwMtnIyBBYQnu3TuA87XEi4+abWkwGoh2+20BH/ekm3
         en2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=WG8DmJDOZpbHskxaYZUaBpHsj5qxDuD01b8C7Ewu1I4=;
        b=EjEjV7ATd7U8Sv5ogEg4A5A64+TvMCPobhitpbR/wcWF1quKOznKra9wh8FAYFX2uT
         eJtcNQsMEY467KR9UAPvS8Zv40MfWV29FhieN91onMZpyrNUkJcI6+vGy9G6JjLOhnj4
         S4GwWlilNyw4e0E8M+88mDFLnmh70Gb9nXwTFKfMGbChCSb6Z696yy+tPqcyjnCYE3d9
         waZlzrVA/Y/dGn8VINyvJPPl9BtHAg2edNuWctE9LRVpTirWFBJT6tRk838/mJfRYyeJ
         O+K4fzTHl3NmzAIjvOaNfSttXhsW6sfGtcc3ikvGimSxv11dQoCWH2cwhoUjlXg1ahBi
         GY3A==
X-Gm-Message-State: AOAM530wcrhFknZOLIAxwvq2TTde/xN0MjWkdI5bURGWgvqaPlldNAsi
        tXjcyrDXhPip1EmoHwi1+beR0ih3MPIZ1K3DrZo=
X-Google-Smtp-Source: ABdhPJxHkFNiZgDmyqbkjR7uyjHIc0h4hBGVdJJyw2+w0ypJh+TlcgrOeHmo7gJnogcarvtmBRtdhi3gdAD7z8J7rnY=
X-Received: by 2002:adf:f041:: with SMTP id t1mr740121wro.139.1605241685408;
 Thu, 12 Nov 2020 20:28:05 -0800 (PST)
MIME-Version: 1.0
References: <CAMP44s3BJ3dGsLJ-6yA-Po459=+m826KD9an4+P3qOY1vkbxZg@mail.gmail.com>
 <20201113010107.GL6252@camp.crustytoothpaste.net>
In-Reply-To: <20201113010107.GL6252@camp.crustytoothpaste.net>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Thu, 12 Nov 2020 22:27:54 -0600
Message-ID: <CAMP44s1U1FevS7NrAYxvgVyzfR5tnD9-+BbPdw5bKnaNHkyD+A@mail.gmail.com>
Subject: Re: The master branch rename, and avoiding another v1.6.0 git-foo fiasco
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Don Goodman-Wilson <don@goodman-wilson.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 12, 2020 at 7:01 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2020-11-13 at 00:04:23, Felipe Contreras wrote:
> > *If* we are going to rename the master branch, it should be with a
> > good reason, after discussing it appropriately, in a major release
> > (i.e. Git 3.0), after a period of deprecation, and a big warning to
> > invite users to provide feedback about the important upcoming change.
> > We can hedge these types of changes with a "core.mode=3Dnext"
> > configuration, as I argued back in 2013. [3]
>
> When the original email that proposed this change came up, I did suggest
> that this would be suitable for a Git 3.0.  I think such a version
> number bump would be valuable, but I know that Git doesn't follow
> semantic versioning and I'm happy for Junio to make the call.  Git has
> made incompatible changes in the past in non-major versions, so there is
> precedent for this, although I agree it has the potential to be
> surprising.  Again, I defer to Junio's judgment here.

I have not been following the Git project for a while, but during the
Git 2.0 development I proposed considerable drastic changes, which
Junio said could not fit into v2.0, but perhaps v3.0, which according
to him: [1]

"Even if we end up having to wait for 3.0, it will happen within two
years max, if not earlier." -- Junio 2014

There are actual good backwards-incompatible changes that a new major
release of Git would benefit from, so if Junio changed his mind about
considering these types of changes, it would be good to know.

I for one haven't noticed a single backwards-incompatible change since v2.0=
.

> I should point out that there is an option to test or set this already,
> with init.defaultBranch.  I have used this feature for testing in the
> past, and I use the feature now to set default branches.  It's also
> possible to use the template functionality to set a default branch name
> for new repositories and I've tested support for this back to at least
> Git 2.0 (but I believe it goes back even farther).  And, of course,
> either of these options can be used for developers to choose the branch
> name which meets the needs of the project best.

There was also the option to test the future changes in v1.6.0, that's
not the point.

The point is that users **must be warned**--and very annoyingly
so--before obsoleting something.

> As for consultation with users, there was a discussion about this on the
> list a few months back and we did get a lot of input from various
> parties.  Some of that feedback was hostile and inappropriate and some
> even violated our code of conduct in my view, as is all too common with
> potentially controversial topics, and I'm not eager to repeat such a
> discussion, since I don't think it's going to result in a productive,
> positive outcome.

I looked for this kind of discussion, but didn't find it. I didn't
imagine it was as far back as June.

It took a while, but I finally read the whole thread, and I understand
your unwillingness to repeat such a discussion, but unfortunately it
will have to happen again, because the people that participated in
that discussion are but a tiny minority that is not representative of
all Git users. If not now, it will happen in the future. This is
exactly what happened in 2008, when the issue was discussed in at
least three big threads.

Moreover, my point was not discussed in that thread. You mentioned it,
but everyone focused on tangents, such as the state of the culture
war, and the etymology of the word "master".

To try to save your sanity I will attempt to be brief (but probably
not as brief as you would like to).

This is what was discussed:

1. Adding a configuration (init.defaultbranch)
2. Should the name of the master branch be changed?
3. Best alternative name for the master branch
4. Culture war
5. The impact to users

I have a lot to say about 4, 3, and 2, and perhaps I will do so in
another thread, but that's not important, what is important is the
thing that was not discussed: the users.

I like to refer to a panel Linus Torvalds participated in regarding
the importance of users [2]. I consider this an explanation of the
first principles of software: the main purpose of software is that
it's useful to users, and that it continues to be useful as it moves
forward. To quote Torvalds:

"Any time a program breaks the user experience, to me that is the
absolute worst failure that a software project can make." -- Linus
Torvalds

This is the first thing the Git project should be worried about, not
the current state of the culture war, and I didn't see anyone
championing the users, and how this change will negatively impact
their experience, which arguably has been pretty stable throughout the
years (at least since 2008).

That being said, I want to touch on only one point you brought
forward, that is indirectly relevant to the users.

You mentioned the importance of intent [3], and how we can never be
certain of the intent of another person, this is true. However, we
must try to guess what the interlocutor might have meant, otherwise
there is no point in communication. This is realized in Wikipedia's
fundamental principle of always assuming good faith [4], Grice's
philosophical razor: prefer what the speaker meant over what the
sentence they spoke literally meant [5][6].

You cannot stand in a comedy special without realizing what the comic
actually means, and it rarely is what he literally says. If I utter
the phrase "kill me now", you know what I mean, or more importantly;
what I don't mean.

A lot of people today want to ignore this fundamental aspect of human
language, and they do so for political reasons. But it doesn't stop it
from being the case. It's not a coincidence that since 2005 nobody had
any problem with the word "master", it's only in 2020 that the issue
"magically" popped up. And it's no coincidence either what kind of
people are pushing for this change.

This is a solution looking for a problem.

There is a concept called "the silent majority" which applies in
software. Most Git users are not going to participate in culture war
debates in the mailing list. It is usually a tiny vociferous minority
that drives these kinds of discussions (and if it has to be said; I
don't mean any negative connotation, simply stating that they are the
opposite of silent). Even the users that are supposedly the target of
these progressive changes (e.g. black users descendant of slaves) will
probably not care at all about such changes, because they are part of
the silent majority that uses common sense and understands that
nothing ill was intended by the word "master". It is usually white
people that "defend" these "oppressed minorities" without their
consent, or need.

Did we hear the testimony of a single black person that was offended
by the word?

The intellectual Gad Saad wrote about a disorder called Munchausen
syndrome by proxy, and how it explains what many modern activists do:
[7]

"Munchausen Syndrome is where a person feigns illness, or medical
conditions, to garner empathy and sympathy. Munchausen Syndrome by
proxy is when you take someone who is under your care (your biological
child, your pet, your elderly parent) and then harm that person or
entity that=E2=80=99s under your care so that you can then garner the empat=
hy
and sympathy by proxy."

Nobody affected by this change actually asked for this change, it is
being done *preemptively* just in case some actual target user might
find it offensive. The only people actually being offended are
offended *by proxy*.

I recommend the book The Parasitic Mind: How Infectious Ideas Are
Killing Common Sense, which explains this and many more problems of
the current culture war.

I have a lot more to say about this, believe me, and perhaps I will do
so in another thread, but for now the summary is this:

We are going to *actually* harm true users that understand the intent
behind the word "master" hoping we might benefit marginally some
imaginary users.

And if we don't warn them about the upcoming change, before the change
is actually implemented (as we did with push.default), they will
complain. Because unlike the users that are descendants of black
slaves who misinterpret what Git developers meant by the word "master"
and get offended as result--they are *real*, and they are a lot.

Cheers.

[1] https://lore.kernel.org/git/xmqqioq12eif.fsf@gitster.dls.corp.google.co=
m/
[2] https://www.youtube.com/watch?v=3DkzKzUBLEzwk
[3] https://lore.kernel.org/git/20200614190842.GC6531@camp.crustytoothpaste=
.net/
[4] https://en.wikipedia.org/wiki/Wikipedia:Assume_good_faith
[5] https://rationalwiki.org/wiki/Logical_razor#Grice.27s_razor
[6] https://plato.stanford.edu/entries/implicature/
[7] https://thoughteconomics.com/gad-saad/

--=20
Felipe Contreras
