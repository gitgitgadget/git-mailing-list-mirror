Return-Path: <SRS0=1oE7=AU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PDS_TONAME_EQ_TOLOCAL_HDRS_LCASE,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805F5C433DF
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 09:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CCF0206C3
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 09:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="CtObeGAy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbgGIJNa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 05:13:30 -0400
Received: from mout.gmx.net ([212.227.17.22]:59045 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbgGIJN3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jul 2020 05:13:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1594286001;
        bh=iGtlXFoqIIO+Db9GpxDBiup/qfcJaA7694igSROmYhs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=CtObeGAyb3sV2SSenm3ykFmxjQdNQI6wKWCmMnJdMbghUi4lORKo/YU5Lu33MZQoC
         szvM4YXzy0xNPL6pk7nhJXnsDsmj98EycpSegxq82yZJFZynzN4Mj+ehySEy6a/W86
         G89giNY7ExzH+LIUx+diPfCh6B423uEqrxyuT4bI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.26.78] ([89.1.215.3]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mlw7f-1kb4l81V91-00j0gO; Thu, 09
 Jul 2020 11:13:21 +0200
Date:   Thu, 9 Jul 2020 11:13:20 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     martinb <martinb@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Martin Bektchiev via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Martin Bektchiev <martin.bektchiev@progress.com>
Subject: Re: [PATCH] commit: correctly escape @ of stashes
In-Reply-To: <CAEVR=HRrtT-vae8edN=Ltnp=amApMfUrt0j+6guWYMWZyz8Ohw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2007091112310.50@tvgsbejvaqbjf.bet>
References: <pull.815.git.git.1593768655179.gitgitgadget@gmail.com> <xmqqv9j19mgn.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2007070114060.50@tvgsbejvaqbjf.bet> <xmqqo8op20ez.fsf@gitster.c.googlers.com>
 <CAEVR=HRrtT-vae8edN=Ltnp=amApMfUrt0j+6guWYMWZyz8Ohw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Wc7lSgfbWIwDsCmFHRKXDzY2cYvLBeF2EjH6Kkn9441K5XCBm4z
 aA00OtLHqstVJc7Lz5JW6oFAwiDoMP9GeFIwQz4vAyBLt+RVtb9/qp6P5qWu9rNghnEMBWB
 U7vTikJzSz7eGCn9w2+PzuMzr6Ikv+Uc/awnOFmI+zoO7zKNxhoxVGjEAfmiFFGHWilyJkB
 SmIjlaWzW2G8hzXUN2SiA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Si1kiv1qLEc=:xzO6HTBVW+CJUrgN8D4NlJ
 g6UagQYgGFk/61CqCAe8gFvBEniuByp1UKbivqlWbz+TtVGaFQjT+1SfxzQmB3/MLV45C4XTV
 FOOn5gnGAL7/UAouVOOuRH+GA+9gCQGlindXtivvQ6dsG2bhTmfU9eW0cz1V9dpzBhdYiXuEd
 MqD2VAlN/IJZFgY03JQ6WYQCpU9qV1yDAt0SkZ7I+vNI8mJdLY5c8oZdvVOHpuuW7OEnYglno
 4KEDycjv0GLxBu6BJg101UqKXOAUz23VHB+KjTlte7oonb/gckHUTQSVg9PLihUNHGk5+aNLr
 PAESPQtWT2mbEbnlku1iKFQFz/jng5rVFksCsKzdJJ3CS+nz2DV1KAU44j9sD50vWYcjLA8yU
 Gi+ILRyFg9f/6V4aWF7Pl6oMXn7Lfi2ZNHhOHtScvb3XnQWpMw4mH0LYXL0Poq+KqgwCNZz+K
 w63WVwxzazCFgqtzo8xMFYPDmyKzk8gAQZzu1gzzb75O8PiNlnIABG8a9CZDCPUKQU2fm8965
 /H6+KxOjea4bLMe5b60ysEAkhCjtiePmW5ihilNWe8rhtAAK77sEJoTR7IvtRft6hRWbJSHlv
 Z4SONpwqycRxZqwiVLp9LyUA8VnDiiYv+uVDQXq+BHp0OVStyfvmEUoNN7lxP318MC0rudYEP
 3aOVDlhm1dIFsNSJS6+u9EVnWEwrb1cZM+Z+aTaYCp7suel122lFE4UH50F3wTisSf7P7QwBa
 6nLqTh4lTJ6glmVmAGu06J/l+wMXevHLu1sl6yyux8MiImrkK96CFrh10TRPaXCZOJqBmKyWS
 hGP99ILd+JqfQLruj4cOJ667SE/HshIzM9s1DdRerIjBqzI5sRLPxC4uO5sBrgD5iB6UUZ53L
 9qx1DYFmLNKLESMiEG5eyU3iDS8m8cpKfJtPtDgxT16t46QuSh0LWUU0lD857kB4eWp1GPVuW
 iL4f8yduEjVy1+HzZK7KSzO5TmUbTaGratrBQQo/bPBYFEfYlYNTJ+h6iUjU7Y2WcsgYdCn9A
 +0WVmjbl3YNBsuqrMrCUWrnWLySEqp8K6hI8AryAwJr6ohw/L7SNqgItXKVjEqFPPtBo6it3N
 aG8wNw+zDcvyYjchcXxQ4TWzU7rJp/EbBYLKmAzPMMXWCHP9SYuPJr36vokMvib4CqFcsfLK/
 XYn1KQtLoyII2YLc70TBYGfaOoT2Tw8gDvofTnfQfop/nYBjwiUZK6kI0ADdHUtt6zYflYTsI
 ZRY6uLIURVsDzY3+F6JAVd8p/DdmlMwuagubbGg==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Martin,

On Thu, 9 Jul 2020, martinb wrote:

> Ok, then I think it's best if I just close this PR. I didn't know that i=
t
> worked alright in newer versions of BASH. And I haven't found a way to m=
ake
> it work without the escaping of @. It seems that the patch doesn't bring
> any value to the community after all...
>
> Cheers and thanks once more for the review and insights!
>
> Best wishes,
> Martin

I think I figured out why it does not arrive at the Git mailing list. The
mailing list administrators installed a rule where HTML mails are
rejected, and your mail came with a plain text _and_ an HTML part. So it
was rejected.

Ciao,
Johannes

>
> On Wed, Jul 8, 2020, 23:54 Junio C Hamano <gitster@pobox.com> wrote:
>
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >
> > >> In fact, I just tried
> > >>
> > >>     $ git stash show stas<TAB>
> > >>
> > >> in a test repository where there is only one stash entry and got it
> > >> completed to
> > >>
> > >>     $ git stash show stash@{0}
> > >>
> > >> and pressing <Enter> from this state did exactly what I expected to
> > >> see.
> > >>
> > >> > Reproducible on `GNU bash, version 3.2.57(1)-release` and
> > >> > `macOS Catalina 10.15.5`.
> > >>
> > >> What did you reproduce?  The completion gave me "stash@{0}" (withou=
t
> > >> surrounding double quotes) in my above experiment?  If so, that doe=
s
> > >> seem reproducible, but I do not see "suggestions ... are broken" he=
re.
> > >
> > > The problem is visible when you have more than one stash. If
> > > you press TABm autocompletion stops at the `{` and if you then
> > > press TAB once more for a list of all stashes instead of that
> > > the completion changes to `stashstash{` and becomes broken at
> > > this point.
> >
> > That does not reproduce for me.
> >
> >     $ git stash show stas<TAB>
> >
> > completes to
> >
> >     $ git stash show stash@{
> >
> > and any more <TAB> changes the command line, which is what I expect,
> > as it would be stupid to offer stash@{0} and stash@{1} (and others)
> > as possible completion candidates.
> >
> > Also I just tried this (manually)
> >
> >     $ git stash show stash\@{<TAB>
> >
> > and did not get any more extra completion.
> >
> >     $ set | grep ^BASH_VERSION=3D
> >     BASH_VERSION=3D'5.0.16(1)-release'
> >
> > As long as the change does not make things worse for users of newer
> > bash, it is OK to make things better for users of ancient versions
> > of bash.  It might already be considered a worse end-user experience
> > than what we have now to show partly-spelled stash reference as
> > "stash\@{" with backslash, though.
> >
> > Another thing I noticed is that you shouldn't need two separate
> > processes of "sed" to do what you want to do.
> >
> > >> > @@ -2999,12 +2999,14 @@ _git_stash ()
> > >> >                            __git_complete_refs
> > >> >                    else
> > >> >                            __gitcomp_nl "$(__git stash list \
> > >> > -                                          | sed -n -e 's/:.*//p'=
)"
> > >> > +                                          | sed -n -e 's/:.*//p'=
 \
> > >> > +                                          | sed 's/@/\\@/')"
> >
> > The first and the original one -n -e "s/:.*//p" wants to show no
> > lines by default, unless it finds a colon on the line and strip it
> > and everything that follows.  You then further want to tweak that
> > and prefix a backslash before the first '@' you find.  So perhaps
> > something along the lines of...
> >
> >         sed -n -e '/:/{
> >                 s/:.*//
> >                 s/@/\\@/
> >                 p
> >         }'
> >
> > ... which is "show no lines by default, but on a line with a colon,
> > strip the colon and everything that follows, and then prefix the
> > first '@' on the line, if exists, with backslash, and show the result"=
.
> >
> > Having said that, I am very skeptical to any "solution" that has to
> > show "stash\@{" to end-users.  And with the patch, newer versions of
> > bash does seem to show the stupid "all stash entries, numbered",
> > i.e.
> >
> >     $ git stash show stas<TAB>
> >     -->
> >     $ git stash show stash\@{
> >
> >     $ git stash show stash\@{<TAB>
> >     stash\@{0}   stash\@{1}
> >
> > I wonder what unpleasant end-user experience I may have to endure if
> > I had dozens of stash entries.  The list shows only the numbers, so
> > it does not help me decide which number to type at all.
> >
> > A solution to allow older versions of bash to complete
> >
> >     $ git stash show stas<TAB>
> >     -->
> >     $ git stash show stash@{
> >
> >     $ git stash show stash@{<TAB>
> >     -->
> >     $ git stash show stash@{
> >
> > would be very much welcomed, though.
> >
> > Thanks.
> >
> >
> >
>
