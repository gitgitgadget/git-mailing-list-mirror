Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5439C433FE
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 19:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382883AbhLCTcW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 14:32:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382878AbhLCTcV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 14:32:21 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E902C061751
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 11:28:57 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id g14so15260388edb.8
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 11:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VqQPrELnEidD70U5gh6Ktfs9MGAB/IDLXeeCe9epaKU=;
        b=EiHM5Va0+Ldhpu7hbOJRlubZYAiqGOVVYOgPHuLl8O3yq43LuK7DP0FR3UZZql3RM7
         6ItWi4vpI45TF+efLCyTvnlhtsDb4lOpv0F3hLJs/SRjNBGBmjjkHDMS/QK4I+Pz5NFm
         WxEqmNX1TlP/TE/zftQmedWK7PrfU31GZ8ngbAiSFI5ydvvuoOiSPR3EhEyYdwvm9iMd
         8b4Xbzt0QITbG7pysNemg/RlqJiMPSiVqVWF2hWRle0Fjxc3T9sFYz4B4ol/BFEpL2qb
         0R/Uz9vgV1VUT1U8z4LZLrYLrsSYH1H5OzJbTrVVWAKCJrMc2/vJDej5NEtZQEMP9DE8
         q4cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VqQPrELnEidD70U5gh6Ktfs9MGAB/IDLXeeCe9epaKU=;
        b=teu3KN9yNEwsVbQ51kR/ZMATR+S+dpw3FWDFcxDg/XQhh8YJKjAHfAzyfxz8qSV+cF
         +Rnso+EamE/5Nx8Wt4Yo65YofykuNHmL+70Rs1iTBgwPSj2fDpQ7vsGBY5721AKW7Msb
         LMJ9t/ycaTqITQf6joKgEUdea4o7yDNlTHiAwizh3UMV/YzgD/wVP2BdvVGkY2ccOA/G
         ut1Vl4+G4Ng0D/9J5kgfOHbhnsep1t2CzuWOvZkbIUydvc3UCRILtF+xc9xcuDsN8A5m
         F9DdaL23BjgrEGV2HUXng+1rH9rPtIVN1iBa7sPhvclpOljUNXtMcgznmckseHIrKep1
         2ODw==
X-Gm-Message-State: AOAM533qouQDnMA4ULjK6RnQFGhENUNeAEhTkDntL6kXVbQoEqblGrNO
        Lw7tLVA6mu0DTBvZBVP7C2dhPDrkQdKD+Je5n2aREukpD3E=
X-Google-Smtp-Source: ABdhPJx12193gMMADIInzIsAFC/caSK7ua3D1LaHyAnZ0TzVzKF/8FSZgGvOyjuJ5cwxGXd0I8LI1e4I7Q5L8DFvkc0=
X-Received: by 2002:a05:6402:291:: with SMTP id l17mr29207219edv.242.1638559735488;
 Fri, 03 Dec 2021 11:28:55 -0800 (PST)
MIME-Version: 1.0
References: <xmqqzgpm2xrd.fsf@gitster.g> <CABPp-BE4uYBFnb-AgVJhNo6iK4da5hiEFEBhd=7Ea3Ov=4K4zw@mail.gmail.com>
 <d95f092.3f.17d73a85761.Coremail.pwxu@coremail.cn> <CABPp-BG9jHaJYekDnvZT+8QW_fLGM_bmz-oOqzJswaotyVDFBA@mail.gmail.com>
 <211203.861r2tsfej.gmgdl@evledraar.gmail.com>
In-Reply-To: <211203.861r2tsfej.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 3 Dec 2021 11:28:44 -0800
Message-ID: <CABPp-BGE5Ff=adH3nREMDm38DGLEmtRTcPwuJowHw-ckwpbmqQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Nov 2021, #07; Mon, 29)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     =?UTF-8?B?QWxlZW4g5b6Q5rKb5paH?= <pwxu@coremail.cn>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?5b6Q5rKb5paHIChBbGVlbik=?= <aleen42@vip.qq.com>,
        Aleen via GitGitGadget <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 3, 2021 at 10:37 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Wed, Dec 01 2021, Elijah Newren wrote:
>
> > On Tue, Nov 30, 2021 at 5:42 PM Aleen =E5=BE=90=E6=B2=9B=E6=96=87 <pwxu=
@coremail.cn> wrote:
> >>
> >> > Please don't, at least not this version.  There have been newer
> >> > submissions with three commits.
> >> >
> >> > I also still find the word 'die' confusing, since to me it suggests
> >> > aborting the whole am operation, and the documentation does not disp=
el
> >> > that concern.  Even if you don't like 'ask' (for consistency with
> >> > git-rebase), I think 'stop' or 'interrupt' would be much better
> >> > options than 'die'.  If you really want it to be 'die', I think the
> >> > behavior needs to be explained in the documentation, rather than jus=
t
> >> > assumed that users will understand it (because I didn't understand i=
t
> >> > until I read the code).
> >>
> >> Dears Newren,
> >>
> >>     I don't think 'stop' and 'interrupt' words are better to explain m=
ore than 'die'
> >>     because they still indicate that it will stop or interrupt the who=
le am session,
> >>     rather than stop in the middle of it.
> >
> > Since you've been through several rounds of revisions already, if this
> > is the only remaining issue with your series, I wouldn't try to hold
> > it up for this issue; I just thought it could be fixed while you were
> > working on the --allow-empty stuff.
>
> FWIW I think it's worth getting the UX issue right, tweaking it is
> relatively easy, and if we can decide on what the thing is called
> then...

:-)

> > However, while I don't think it's worth holding up your series for
> > just this issue, I would definitely submit a follow-up RFC patch to
> > fix the wording, because I do disagree with your assertion here pretty
> > strongly.  Let's look at the meanings of the terms:
> >
> > die: connotes something pretty final and irreversible -- people tend
> > not to revive after death as far as recorded history goes; most such
> > recorded instances tend to be causes for people to debate the
> > definition of 'dead'.
> >
> > stop: could be final, but is often used in a transitory setting: "stop
> > and go traffic", "stopped to catch my breath",  "the train will stop
> > at this station", "stop! I want to get out", etc.
> >
> > interrupt: seems to nearly always be used as a transitory thing
> >
> > Now, in the computer science context, all three terms come up relative
> > to processes.  You can interrupt a process (the kernel does all the
> > time), but it'll usually continue afterwards.  Or you can give it a
> > SIGINT (interrupt from keyboard signal), which the process can catch
> > and ignore.  You can stop a process (and SIGSTOP cannot be caught),
> > but you can also continue it later.  die essentially means the process
> > is going to be gone for good (at least short of some kind of black
> > magic like a reversible debugger such as rr).
> >
> > So, I think it's much more likely that 'die' will be misunderstood to
> > mean abortion of the entire am-process, than that 'stop' or
> > 'interrupt' would.
>
> Why are we exposing an --empty=3Ddie at all? It's what we do by default,
> so why have it? The user can just not provide the "--empty" option, then
> they'll get the current behavior of die_user_resolve(), which seems to
> have inpired the name for this "die" (it exits with code 128, just like
> die()).

That's an interesting angle to take; I hadn't thought of that.  It's
worth considering.

We do often introduce options equivalent to the default as a way to
either countermand an earlier option (e.g. --do-walk overrides
--no-walk in git log), or because we want to allow new config options
that change the default while allowing the user to explicitly request
something different (e.g. --no-renames was introduced at the same time
as diff.renames), or because we may want to change the default
behavior and want users to be able to explicitly request a certain
type of behavior (e.g. rename detection is the default and
--no-renames overrides).

It's not clear to me whether that type of flexibility is needed or
whether we can just leave it unnamed.  Three points that may affect
that decision: (a) the default (and actually, hardcoded) behavior
before this series for git-am was 'drop', (b)  the default behavior
for git-rebase is 'drop' (though it only affects commits which become
empty, something we can't determine in the context of am) and (c)
there was one point during the series that the author asked about just
removing the 'die' implementation and picking a different default.

The above three points suggest to me that there might reasonably be
config added to control this or that the default could change, and
thus that it might be useful to name the interrupt-the-operation
behavior so that users can explicitly request it.  But that's
somewhere around three levels of chained "might" conditions, so...
:shrug:

> Once we get rid of "die" the rest of the UI can follow the example of
> the existing "git rebase" options:
>
>     --empty=3D{drop,keep,ask}
>
> I.e. the "drop" and "keep" will be the same, no "ask" currently, but it
> can be implemented in the future.

Um, there are minor contextual differences, but what rebase calls
"ask" (interrupt the operation and tell the users what commands they
can use to keep or drop the commit and then resume the operation) _is_
implemented by this series -- it's just being called "die" here.

That's the kind of maddening inconsistency in Git that users complain
about that I really think we should avoid adding to.  If for some
reason 'ask' from rebase seems like a bad choice, then I think we
should pick a new name for this interrupt-the-operation behavior that
makes sense (unlike 'die') for git-am and add it to git-rebase as a
preferred synonym to 'ask'.

> Maybe I'm missing something, I haven't used "am" in this way (or rebase
> with --empty=3D*), but this just seems to me to be needlessly exposing a
> "die" (or "stop" or whatever) because it's how we implement this.
>
> Whereas for the UX we don't need to call it anything except the absence
> of an --empty option, or perhaps --no-empty.

`--no-empty` would semantically be read by users to mean get rid of
empty commits, which would be a synonym of 'drop'.  I think it'd be as
confusing as 'die' (and maybe even more so) for naming the
interrupt-the-operation behavior.
