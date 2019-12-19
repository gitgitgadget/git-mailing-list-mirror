Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85628C43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 13:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BE3E20684
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 13:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brightrockgames-com.20150623.gappssmtp.com header.i=@brightrockgames-com.20150623.gappssmtp.com header.b="lyBLbeyx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfLSNjz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 08:39:55 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43783 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbfLSNjz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 08:39:55 -0500
Received: by mail-oi1-f193.google.com with SMTP id p125so541682oif.10
        for <git@vger.kernel.org>; Thu, 19 Dec 2019 05:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brightrockgames-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UQgqVfUH6aaioV3pduD6H42mqi4XPACa5SIhWJl98jo=;
        b=lyBLbeyxsrfs1KQAYAnNFp9/7BODg0fgea/rFhul4lN3nXq2sKU/iaardYjsfK1nC0
         VqZvbazP+pYcYr6Hq7TQjTmpVoadV0l/PnkazfUbl12PdN8xP38wMhQYbhrynu3j+DRb
         wOzk4bao5Q+xFn4hkD5/wErm9b1zxHb8M3TLI23YFaXLNU1fH15fwbIJnL8SJlqQxPkD
         erAkVaQg7UXnj0bJVONRQFlu2KiNIyzLY/yJ5fwLqSaucs6B+xKWY3yE9AWekxS2Y3OE
         9MR/mEssJQ7cp8U3109YdIQoYSUZvHh2XQjb+V9dt+3NTlYSt4bOriw6Yg7MrXwxDNf6
         UBGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UQgqVfUH6aaioV3pduD6H42mqi4XPACa5SIhWJl98jo=;
        b=MyjLRFVsdAW4uuh/3tWTQQDk7SRhzGt2FrXrI6cueiM7Q0Op0xfMSVX3SCPgJcHUjF
         JUkel05Dwq/ipgsnpe51OwDGY46RIw5UMJcBf9hSrgfp6o5Tili89LF6+nFiA8UPg4sr
         z+qPAH1aPvo7xT+lXGiXx7A6k67/trEhv4ld8zVhX0pHjQknFQ3L+7B+1VQAYxXJIdpb
         opGZwGGBqUpJNUPlC7yxps8PlHWKru8jlkOw6/X20hZETUQAuDoPQnS21HrI9RJ/x3r5
         aFFW31iCm35nXD1s4EGwLyCFuWgv6OZNn9Rl4gvfT3xBzMUefwN6hH10DzoMMAdOpdxp
         F0rQ==
X-Gm-Message-State: APjAAAWiIQ+irWvaUQcuQ2O0JmX2u+aXTuXtCRYOTDXIipfYPK5Zll+O
        ic0Q1Q5b2pTMup+AJ9c1mLPM2kkN8lCWFZL3JfUtTl1u9/kbsA==
X-Google-Smtp-Source: APXvYqzADtRy2CLwwpcL3gJTcV4rhkr4gmocGfX4NOJx5yYRDWsb4FTP7N4YAuYwWqShpgtHpNSjS72GUZjRtp+on9E=
X-Received: by 2002:aca:c509:: with SMTP id v9mr2003696oif.151.1576762794137;
 Thu, 19 Dec 2019 05:39:54 -0800 (PST)
MIME-Version: 1.0
References: <CAB1T5w2GyfERoaCyFZeKaui_xuXd0r6J+Zvq4pecstBJ9UyRzw@mail.gmail.com>
 <20191218192741.ybi3xpvax7lrrubz@tb-raspi4> <CAB1T5w1Ct7_D7kiUypRuoK+zeiocyPJn0SindXfs6M5wUkVavw@mail.gmail.com>
 <b4338168-50c5-8aa1-32e0-2fe96e82e9bf@iee.email>
In-Reply-To: <b4338168-50c5-8aa1-32e0-2fe96e82e9bf@iee.email>
From:   Scott Richmond <scott@brightrockgames.com>
Date:   Thu, 19 Dec 2019 13:39:40 +0000
Message-ID: <CAB1T5w3ZeLDQcvxuR_j0q3+=V7Bfqh3px01ys_x2f6EYVrnuzA@mail.gmail.com>
Subject: Re: Ability to ignore EOL changes for certain projects
To:     Philip Oakley <philipoakley@iee.email>
Cc:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> If I recall previous discussions, part of the issue is determining what
the alternate abuse cases are, such as lone CRs, or alternate character
sets to the 'pure' utf-8.
In this dev env, I would be surprised if any CR type makes a
difference. But I could be wrong.
If that is indeed one of the reasons why previous discussions broke
down, maybe that could be a configurable option in the feature
improvement.

> Does the environment (on any of the OS's) change the files in the backgro=
und, such that the file time stamps will indicate a modification?
I would imagine the file timestamps do get updated yes. Though I'd
have to do some research to confirm it.

If indeed this isn't a bug (As Torsten suspects), then I suppose what
I am asking for is a feature improvement to perform a further check
after sha1/iod to confirm if the changes are only between CR types?

Regards,

Scott Richmond.
  Director, Producer, Programmer
  Brightrock Games
  T: 07480795661
On Wed, Dec 18, 2019 at 10:35 PM Philip Oakley <philipoakley@iee.email> wro=
te:
>
> On 18/12/2019 21:33, Scott Richmond wrote:
> > Hey Torsten,
> >
> > Thanks for the reply!
> >
> > Correct me if am wrong, but those steps don't tell git to "ignore"
> > line endings. That just causes git to check all text files in and out
> > with a specific EOL type (Either automatically chosen, or not). If an
> > app in the dev env changes a files' EOL to something else, git will
> > notice the change locally.
>
> A broader question is "how does the dev environment handle lone `CR`
> characters? are they also considered as EOLs?"
>
> If I recall previous discussions, part of the issue is determining what
> the alternate abuse cases are, such as lone CRs, or alternate character
> sets to the 'pure' utf-8.
>
> You will still have the difficulty of how `identicality` is determined,
> which currently uses the sha1/oid value. In essence you need a way of
> ensuring that all checkins are always of one defined EOL, but then need
> git to have a broader allowance of changed EOL values (including no lone
> CRs that are not EOL, etc).
>
> Does the environment (on any of the OS's) change the files in the
> background, such that the file time stamps will indicate a modification?
>
> Philip
>
> > Regards,
> >
> > Scott Richmond.
> >   Director, Producer, Programmer
> >   Brightrock Games
> >   T: 07480795661
> >
> > On Wed, Dec 18, 2019 at 7:27 PM Torsten B=C3=B6gershausen <tboegi@web.d=
e> wrote:
> >> On Wed, Dec 18, 2019 at 11:10:27AM +0000, Scott Richmond wrote:
> >>> The Problem Domain
> >>> In certain dev environments (Unity3D projects) there is (AFAIK) an
> >>> unsolvable problem where some files are often modified with line
> >>> endings that aren't the native system or not the committed line
> >>> endings for that file. Secondarily, in this case line endings don't
> >>> matter - Nothing in the dev environment "cares" which kind of line
> >>> ending is used.
> >>>
> >>> The Problem
> >>> Git always cares about EOL. Git has options to transparently modify
> >>> EOLs when files are checked in or out. However it is not possible to
> >>> tell Git to ignore EOLs in other commands:
> >>> Git status shows the file modified.
> >>> Merging/Pulling has to care because it can't merge with a modified
> >>> working tree. Which means the user has to care - They have to either
> >>> stash the EOL changes or wipe them out. Sometimes, if the user has a
> >>> particular app running, it may automatically reload that file and
> >>> recreate the modified EOL changes, causing an endless loop. This
> >>> problem is often made unclear to the user how to solve, especially if
> >>> they aren't domain experts.
> >>>
> >>> To be clear, in this particular dev environment, I can say with
> >>> confidence that this particular issue is a major and common pain poin=
t
> >>> for users. It is made worse as many users in this environment aren't
> >>> programmers by trade and aren't domain experts in version control. I
> >>> also believe this environment is becoming a non-trivial portion of th=
e
> >>> Git userbase and it would be worthwhile looking into resolving.
> >>>
> >>> Solution Request
> >>> It would be fantastic if we could tell Git to stop caring about EOL
> >>> changes on a per-repo basis, with the effective output being that git
> >>> status shouldn't show changes for files with differing EOLs.
> >>>
> >>> I'm experienced with Git, though I am not expert enough to consider
> >>> creating such a change myself - It is unclear to me just how
> >>> complicated a change may be. However maybe I could look into it if it
> >>> was made clear that this improvement is possible and has no serious
> >>> side effects.
> >> Hej Scott,
> >> I think that you problem can be solved.
> >> For each repository, you can tell Git to ignore the line endings,
> >> CRLF vs LF.
> >>
> >> If you start with a fresh repo,
> >> you can do something like:
> >>
> >> echo "* text=3Dauto" >.gitattributes
> >> git add .gitattributes
> >> git commit -m "Add .gitattributes"
> >>
> >> For existing repos, we need to take another step:
> >>
> >> echo "* text=3Dauto" >.gitattributes
> >> git add .gitattributes
> >> git add  --renormlize .
> >> git commit -m "Add .gitattributes"
> >>
> >> More information can be found e.g. here:
> >> https://git-scm.com/docs/git-add
> >>
> >> Once you done that, you can merge branches
> >> into the master branch with help of the renormalize
> >>
> >> git merge -X renormalze branch-name
> >>
> >> See even here:
> >> https://git-scm.com/docs/git-merge
> >>
> >>
> >> This is just a (too) short introduction, I hope that it
> >> helps and that you find the time to dig somewhat deeper into
> >> the documentation.
> >>
> >> Other developers have that problem as well, you are not alone.
> >>
> >> If you have a public repo, I could help with one example.
> >>
> >>
> >>> Regards,
> >>>
> >>> Scott Richmond.
> >>>   Director, Producer, Programmer
> >>>   Brightrock Games
> >>>   T: 07480795661
>
