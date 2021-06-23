Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC2AC2B9F4
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 01:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A782361002
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 01:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbhFWBLy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 21:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbhFWBLx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 21:11:53 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEED6C061574
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 18:09:35 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id n99-20020a9d206c0000b029045d4f996e62so345783ota.4
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 18:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=USOu7eoUGsfN+ty1LUqb7RVinppwy5JlBU/ae6TBxg8=;
        b=arZY5BDQErTsE2tZNU1FYhdI65YGP+5t8Q/gPsn5fE68rxQdQ+RTyfzPpyG/ctDDXl
         JGRjkiprC5/z8npMgMDlUdTk1KDJ527uN1MTDTOXngsiunsH5bFirMxglV2PZ5BL0uQT
         x0eKVwYgtuxWrV6Bf1sVmm1xfDZPmMJbbZhHhV/rTvyK6Nmqp6Lfgfrdr6Q2BeFZHAMv
         5Vj2vW3sQ+4oBNNJRakXGF5AfrPWykQeJUJHDOrKMeby/ajthgS0ESWyPn4heLDrPobr
         jHktUjr7V0l20uNtAZ3cBzqKX0IJ77ZDYu/mEw+isiWIKEkYZkRgoEB1i+e07krsAt83
         mDUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=USOu7eoUGsfN+ty1LUqb7RVinppwy5JlBU/ae6TBxg8=;
        b=o3/SbX7wVUg6bFiQHMTSab0OP51kUkBn7/esM4vqN/pVDvaQRLz7gMtTRCn//zgmhR
         pD1o70QlXTBWtvobMAeC7YkLoDvyWHuYhVz9xU/d/sc7dRzwB/6WeeCFm0+zqR9GzmoZ
         Wc/AMrBiqKkHTGFH1p/ED8I0LGk/zadPqCD+Ua6SYMdiHNn7YrwL802t4K9oyWscmJ0p
         B6mxinsBjGGNqLY/MSEdpM53LAFFJiNM4C1RK5dPMSiGAAVoiYVsspCo4neYNT3htMkv
         ygJMbNOzasR5IPzYI/gvLdX1Hcj295BNYLldsXaNT5Bpwc/Y47Nj99CAkR4D4nRIdX+h
         uLng==
X-Gm-Message-State: AOAM530hWy4ygs3ULGACFGzVMv51PHLzxOB5QKvSKkuXD6CU/ewZGgDO
        y3GClgFjNFnx8CDr1CtLZ78=
X-Google-Smtp-Source: ABdhPJybelUkzv/AycE+GoBQ5a9P7xY3iJ4AgT3LEfMK3qdTXFsyAj3rbwLr3uCSkQXVK8OSq91VZQ==
X-Received: by 2002:a9d:6298:: with SMTP id x24mr5569831otk.93.1624410575165;
        Tue, 22 Jun 2021 18:09:35 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id s81sm4599994oie.23.2021.06.22.18.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 18:09:34 -0700 (PDT)
Date:   Tue, 22 Jun 2021 20:09:28 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Elijah Newren <newren@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Message-ID: <60d289c84fadf_312208dc@natae.notmuch>
In-Reply-To: <CABPp-BF1noWhiJadHzjJmnGo8hdZj6Fk7XnZ=u6BVVSGfHE7og@mail.gmail.com>
References: <20210621175234.1079004-1-felipe.contreras@gmail.com>
 <20210621175234.1079004-3-felipe.contreras@gmail.com>
 <CAMMLpeR2Y_EGwqGJzghSQ1DzpYQyWr6ENmGCvPRdhhYFkTW4yw@mail.gmail.com>
 <60d0df99d91e1_108e902085e@natae.notmuch>
 <CAMMLpeRnUC+nOek=Kz6bj0_R6EUaDr=7ObKF01V641_ByOmk6A@mail.gmail.com>
 <60d10ebd99d86_113139208cd@natae.notmuch>
 <CAMMLpeRa3atkZxEtV--YD6-JSf0Bp9xRw9kS5wSWerxpsGrvrw@mail.gmail.com>
 <CABPp-BF1noWhiJadHzjJmnGo8hdZj6Fk7XnZ=u6BVVSGfHE7og@mail.gmail.com>
Subject: Re: [PATCH 2/2] pull: improve default warning
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:
> On Mon, Jun 21, 2021 at 8:15 PM Alex Henrie <alexhenrie24@gmail.com> wr=
ote:
> >
> > My only serious objection to this patch is the instruction to merge i=
f
> > you don't know what to do instead of asking the repository maintainer=

> > what to do or reading the Git documentation. I don't have a strong
> > opinion on the rest of the patch.
> =

> You're not alone, Alex; I objected to that part as well.  (See e.g.
> https://lore.kernel.org/git/CABPp-BF4rXBOKsn8bG6y3QUEtNVV9K2Pk5NmwrU581=
8CqhRt_Q@mail.gmail.com/
> and various other emails in that thread, ending with "agree to
> disagree" later).  I still object to it as I did then.

You made your disagreement known in [1], I responded to it with a
devastating argument in [2], and you immediately withtdrew from the
discussion in [3] without engaging my argument at all.

In total you engaged with my arguments zero times.

This is all you replied:

  Yes, we can agree to disagree on this particular point.

To make the record straight, I'm restating the argument you avoided in fu=
ll:

  But that is not the warning, this is the warning:

    Pulling without specifying how to reconcile divergent branches is dis=
couraged;
    you need to specify if you want a merge, a rebase, or a fast-forward.=

    You can squelch this message by running one of the following commands=
:

      git config pull.rebase false  # merge (the default strategy)
      git config pull.rebase true   # rebase
      git config pull.ff only       # fast-forward only

    You can replace "git config" with "git config --global" to set a defa=
ult
    preference for all repositories.
    If unsure, run "git pull --merge".
    Read "git pull --help" for more information.

  This warning says:

  1. There's 3 options: merge, rebase, fast-forward
  2. merge is the default strategy
  3. If unsure, specify --merge (the default strategy)

  So taken altogether it does say what is the default strategy.

  > More
  > importantly, it makes a recommendation...and one that undercuts the
  > point of the message.

  So?

  When boarding a plane the flight attendants do a safety demonstration
  that passengers should pay attention to. If one passenger is not
  paying attention (listening to music on headphones, and reading a
  book) what should the crew do?

  1. Remove the passenger's headphones and force him to pay attention to
  the safety demonstration
  2. Let the passenger ignore the safety demonstration

  Human beings are independent agents responsible for their own actions.
  You as a separate human being--a crew member--can argue that it's not
  in the best interest of the passenger to ignore the safety
  demonstration, and you may be right, but the passenger decisions are
  still the passenger's decisions, even if they are bad.

  Do you think the crew should disregard the passenger's volition and
  force him to pay attention to the safety demonstration?

  > It makes it feel like the message shouldn't
  > exist at all in any circumstances.  I even suspect that adding that
  > sentence may undercut any efforts towards changing the default to
  > ff-only-as-default.  While I'm a big fan of most of what you've done
  > in this series, I will object to its merging for as long as this
  > stays.  (I definitely don't have veto power or anything close to it,
  > just stating what my opinion is.)

  The current warning should not exist at all.

  The complaint from V=C3=ADt Ondruch [1] that reignited this series is a=

  valid one. A *permanent* warning is not good. We should have a
  *temporary* warning with the express purpose of notifying users of an
  upcoming change.

  If we have not yet decided on what should be the default (Junio seems
  to have casted some doubt on the consensus [2]), and we don't have a
  clear path forward to implement such change (we can't even tell users
  to use "pull.ff=3Donly", since eventually it may be
  "pull.mode=3Dff-only"), then we must remove the warning.

  It was a mistake to put a *permanent* warning before deciding to
  change the default.

  So, there's two options:

  1. We decide on a path forward and fix the warning so it *temporarily*
  explains what will happen in the future
  2. We remove the *permanent* warning

  Since we are already here, we might as well take advantage of that
  warning and repurpose it. But in the meantime--while the git project
  decides what to do, and what configurations to suggest the users to
  change--we should at the very least waste as little as the user's time
  as possible, and give him/her a quick opt-out.

  Yes, a quick opt-out defeats the purpose of a warning, but we must
  respect the users' volition. The user may be on a deadline trying to
  push some changes to production before the weekend, and after a system
  update be annoyed with this warning on every pull. The user may not
  have time to look at the warning, decide he wants to read the warning
  in the future, maybe next Monday, and thus not configure anything to
  silence it.

  What's wrong with a user saying "I don't have time for this now,
  please tell me what to do for now, I'll look at the warning later"? If
  anything for those users the configuration is the wrong thing to do,
  because being in a hurry they just choose the first configuration and
  forget about the warning without actually looking at it (because they
  didn't have time), and it will not appear any more. By typing "git
  pull --merge" the user can get rid of the warning *for now*, but the
  next time he does "git pull" the warning will reappear, and at that
  time perhaps the user does have the time to read it, and look at the
  manpage.

  Nobody likes their workflow to be interrupted and be forced to do anyth=
ing.

  I don't think my patches plus that suggestion for a quick opt-out are
  in any way worse than the current situation. If you think they are,
  then we'll just have to agree to disagree.

  I quote the voice of V=C3=ADt Ondruch, which I think represents the typ=
ical
  user: "please select any strategy considered more appropriate and stop
  warning me".

  Cheers.

  [1] https://lore.kernel.org/git/742df4c2-2bc5-8a4b-8de1-cd5e48718398@re=
dhat.com/
  [2] https://lore.kernel.org/git/xmqqh7p1fjml.fsf@gitster.c.googlers.com=
/

> I'm curious whether it'll just be resubmitted again multiple times,
> eventually with a cover letter that repeats something along the lines
> of "these are the non-controversial changes from last-year series
> which...don't have any reason not to be merged."

The fact that **one** person was not 100% on board with a change doesn't
make it controversial.

You made the conscious choice to withdraw from the discussion
immediately, so just like a person who abandons an election cycle and
decides not to vote, you are leving the future of the matter in the
hands of others.

If you want to rejoin the discussion, feel free to respond to my
argument that you dodged last round [3].

Cheers.

[1] https://lore.kernel.org/git/CABPp-BF4rXBOKsn8bG6y3QUEtNVV9K2Pk5NmwBF4=
rXBOKsn8bG6y3QUEtNVV9K2Pk5NmwrU5818CqhRt_QrU5818CqhRt_Q@mail.gmail.com/
[2] https://lore.kernel.org/git/CAMP44s2L24jhCG9ps72--ZiJkXUovR726jCf8JTL=
HAs0jV7Whg@mail.gmail.com/
[3] https://lore.kernel.org/git/CABPp-BGdNt8TBMTE9zvaicF5AtvyTBhpiJXqkuZc=
7mBLGbw0Qw@mail.gmail.com/

-- =

Felipe Contreras=
