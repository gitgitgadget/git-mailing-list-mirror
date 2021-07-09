Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E704C07E99
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 17:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDEB7613C8
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 17:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbhGIRoS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Jul 2021 13:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhGIRoR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jul 2021 13:44:17 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E91C0613DD
        for <git@vger.kernel.org>; Fri,  9 Jul 2021 10:41:34 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id w127so13103739oig.12
        for <git@vger.kernel.org>; Fri, 09 Jul 2021 10:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=6hiLnpdce3Xf/ZGgrz3+3B/bcKKMjFEkv0nDz0NXOeo=;
        b=hZ+KnUvA+iO4I586WzqdSehkLu6V3MFRKh7y5CAxND0ECx3Uh73zxqpCiC3PE4rRJ3
         SKRIEfVBlewdtFbDmv64XzsvxrZ4a/h6OZTSqVikVO89QVpbOQiv4Z5ph63ky3YgRdMU
         LVLJ7MH74zIM386gPvejyQ8WnJ7kZonZmTcgZ4UDhPBK41EXPMpJF4cTAuUZn4N/BH+L
         QusXc0LRlqKoffwRo5gHRcsB5jurWPFm0MMWuXRWj6G6EUZ9dR7SL55Qn9Q6U7VpFhts
         n2YV3eXxhDNV/M8rn94fsTxRfjD7e6bTcCgou+8dTIOU7hJnGtZrRe9JAuqzojF1yC6m
         61zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=6hiLnpdce3Xf/ZGgrz3+3B/bcKKMjFEkv0nDz0NXOeo=;
        b=JhReNEAN/4UEmgwAM0Ovjg/8FcvSK+dOYjPLPltKhztAEuBJBEvkpsEYawzi2aDtss
         zGD1C1F0IVvttU35sIhGNNoViVUibnCsLym4SOH6pDsxmnVeozgK5vrhG5EzL0urY7FF
         LGV2TbZputp4Br8bDcoxl0syPFrxQuee1RUYPxr8mtlvc+ryYqx4JTYLkuNheWdV6Jlc
         Gg9HcaynA+zFbRk8ynIbyMbTxsp2oWswVsZdL8kO3Ux1gVxM8qxS/DSe/BS+LmztLBTf
         PXnek1Wubd9ZH6t6ema1HK8BCBjs3LJGVbIf+Ht7fxUgI9nk+EZ0Slw8e+ZwCcKMNSKJ
         GkDg==
X-Gm-Message-State: AOAM531N0RV9h70Qz7F15UobM4qdvoH6NkvSTs/rG8tsV1z6P3HwaMvZ
        TAYgDuXABdPm4jw67OahpV4=
X-Google-Smtp-Source: ABdhPJy3XiyGfM+YTyovalNdn+XgA0/WOAIKDSooRY7xzfsjWCJh1pSPe5NGGpuyvkjgc5CmTH6ivg==
X-Received: by 2002:aca:31ca:: with SMTP id x193mr21248693oix.84.1625852493374;
        Fri, 09 Jul 2021 10:41:33 -0700 (PDT)
Received: from localhost (fixed-187-189-163-231.totalplay.net. [187.189.163.231])
        by smtp.gmail.com with ESMTPSA id v4sm295365ooa.2.2021.07.09.10.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 10:41:32 -0700 (PDT)
Date:   Fri, 09 Jul 2021 12:41:31 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Martin <git@mfriebe.de>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Message-ID: <60e88a4b8592f_16bcb2082b@natae.notmuch>
In-Reply-To: <dbfa96f0-558e-ccaf-6e34-6d95c43848b5@mfriebe.de>
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
 <xmqqk0mcy6g2.fsf@gitster.g>
 <b667ca37-b3cb-fce2-a298-63c3b839089d@mfriebe.de>
 <xmqqpmw4uwh2.fsf@gitster.g>
 <7870a0ad-8fa1-9dbd-1978-1f44ec6970c5@mfriebe.de>
 <xmqqy2arrmba.fsf@gitster.g>
 <b80bf908-0c31-2b3a-6d6c-1a3fba5b2334@mfriebe.de>
 <87wnqaclz8.fsf@osv.gnss.ru>
 <60e5f3981de5f_301437208bc@natae.notmuch>
 <87bl7d3l8r.fsf@osv.gnss.ru>
 <60e61bbd7a37d_3030aa2081a@natae.notmuch>
 <877di13hhe.fsf@osv.gnss.ru>
 <c740a4f0-011f-762e-4f49-f85d1b3abc99@mfriebe.de>
 <60e67389a4adc_306ac1208fd@natae.notmuch>
 <4057b3ac-a77c-0d5f-d3f4-ad781754aae4@mfriebe.de>
 <60e736e72da68_30939020850@natae.notmuch>
 <155308af-42ad-b044-fb37-676251a9b7e1@mfriebe.de>
 <60e762243aab1_30a7b02089@natae.notmuch>
 <2b85a7eb-d0be-65e7-ecbb-1750abf53e53@mfriebe.de>
 <60e79c31aaa72_30b8a4208c1@natae.notmuch>
 <65362688-b65b-661c-20c1-94d7dc2118c7@mfriebe.de>
 <60e874e1c6845_215320861@natae.notmuch>
 <dbfa96f0-558e-ccaf-6e34-6d95c43848b5@mfriebe.de>
Subject: Re: PATCH: improve git switch documentation
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin wrote:
> On 09/07/2021 18:10, Felipe Contreras wrote:
> > Martin wrote:
> >> As for "git switch -C"
> >> This should IMHO change to (the 2nd arg, actually depends on the poi=
nt
> >> "1" above)
> >>      git switch (-c|-C) <branch-name> [<base-commit>]
> >>
> >> I suggest to not call it "new-branch-name" because, it might be an
> >> existing name.
> > =

> > I think the name is all wrong. As =C3=86var pointed out --new (-n) is=
 much
> > better. Also it doesn't make much sense to use "create" or "new" for
> > something that already exists.
> =

> The n versus c issue is IMHO separate. Maybe tiny overlaps.
> =

> I see it mostly in the light of -c should be for "copy".
> =

> On "git checkout" it is "-b" for branch. That works, if you perceive =

> "branch" as a verb. "The action of branching creates a new branch".

I generally view git commands as verbs. In this case "checkout" is the
verb, and "branch" is the direct object.

> Actually, "new" or "create" would make sense in "git branch". But in gi=
t =

> switch, they actually raise the question "create what?" / "new what?".

`git switch` doesn't switch anything other branches. I don't think
`git switch-branch` would make the command somehow more understendale.

> > I think you saw a correct issue: `git switch -C` might be used
> > incorrectly, but changing to the documentation would have limited val=
ue
> > (and only for the ones that read it).
> > =

> > I think if the branch already exists, the user has to be explicit to
> > what he wants to do and use `git switch --reset <branch> <commit>`
> =

> Well, that is the question as what the action is perceived.
> I think the example is wrong, rather than the command.
> =

> -c / -C /-n / -N always *c*reate an *n*ew branch. (create and new reall=
y =

> are the same thing here)
> =

> But if the branch name Foo, is already used?
> Well, it will still be a *new* branch being *created*.
> To do that it has to remove the name from the old branch. (effectively =

> removing the old branch).

But it's not removing the name, it's merely changing the head.

I don't particularly mind having -C or -N, I just would not use them
because I like to be explicit. I don't use --new for something that
already exists.

> >> 3)
> >>
> >>      newbbranch  versus new-branch  versus  new_branch
> >>
> >> That is something that just needs to be decided.
> >> "new_branch" is in git checkout.
> > =

> > I'd rather have <branch>, but as I already said, the more ground you =
try
> > to cover the more impossible it will be to actually land the changes.=

> =

> Well ok, if you shorten it to one word that solves it too.
> But for anything that for some reason needs two words, IMHO there shoul=
d =

> be one style. "one word", "-" or "_".
> Currently different styles are mixed.

I don't see the need for that, <new branch> would do the trick, no need
for hyphens or underscores.

> >> Look at
> >>     git checkout --force
> >>> --force
> >>>      When switching branches, proceed even if the index or the work=
ing tree differs from HEAD. This is used to throw away local changes.
> >>
> > =

> > All these issues go away if we have:
> > =

> >    git switch --reset <branch> <commit>
> > =

> > And instead of -C, we have:
> > =

> >    git switch --new --reset <branch> <commit>
> > =

> > This creates a new branch if it doesn't exist, or if it exists resets=

> > it.
> =

> Nope it does not go away.
> =

> All this has done, is that it no longer is a "force" command.
> So the last bit of warning has just gone.
> =

> And it still needs to be documented inside the "git switch" doc, rather=
 =

> than forwarding the user do yet another doc.

Yes, but as I said: the documentation writes itself.

  -n <branch>, --new <branch>

    Creates a new branch.

  --reset <branch>

    Resets the branch to <head>.

> Also making the user read the "git reset" doc does not help, unless we =

> point out that this is a --hard reset, rather than "modifying the index=
".

Nobody is suggesting that. --reset refers to the English word "reset",
not `get reset`.

> So, I still ask:
> - If "--force" to overwrite the work tree can clearly state that change=
 =

> to files will be "thrown away".
> - Then why can "force" re-using an existing branch name not do the same=
?

Because we would be forcing two things now. I'd rather not overload
concepts.

Cheers.

-- =

Felipe Contreras=
