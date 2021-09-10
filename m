Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDB3C433EF
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 17:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EBBC611BD
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 17:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbhIJRRq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 13:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbhIJRRm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 13:17:42 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A0DC061574
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 10:16:30 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id k12-20020a056830150c00b0051abe7f680bso3176493otp.1
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 10:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ItPCsLwFi2raSocZCAyJxzByzS+DmxAaw21I4OGjH/A=;
        b=Fs6Nj9clp4VG5xgkof6n7PvJ9NsNIM8oXiZFoIJcy/b2PUt4j83CEy4IxuyAZsqwiF
         poz7Jyf9H8QAHsGCKeaE74ETzJ5Wickon2ulRB7tnDvsrwDvAsNoNmBNnCounqCjL934
         IKLnCsJlFWHx/1b3VOfpxIp7z3V2s7L1YM1ZJ0oyiu30cvUpJGpNKkRwzwLJ53Wwi38h
         ywbI+INSTFcvXiJewRt3U2E4qYIebIve8mVCsXN9SUqViN7CFnbMK/FobMOdGJjO/blN
         oruCnfWnU9/HfUeQrmuyFfQpKGO89STFZ6d/enICs80DwvKEzvPXUfVQ4mhokujCoPRt
         6I9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ItPCsLwFi2raSocZCAyJxzByzS+DmxAaw21I4OGjH/A=;
        b=mzMRyZ+xubfsAYg81e6gHpOcCjz0vVdV1KxbbzKvd0umjzA2mdpcYncy5XqLOFlcPU
         Z12R6CNgiRKTqwCfW5J3NCKnkfOhc50nNE9osPShpBTSqJvVVcM6MSGQ3ynuDBduiUf3
         4WYb07Iz6WmKZxM60dD3zLaVTGUBr1jUTlWL9ycgwv2PO4YIkRSB5YF4LvTmRIbxXsDg
         s75Ue1Y0xGYsbTa7887C/hM6dPmd/LdcV74tsvuxfvaoTtaO/HAVKSRIid9mn44MJsb3
         UY3RSEqr2otTa3IgmRDWMLTAUa3D3x/6xiOaBnAvD798da7n4LUrWbBoqw96YLS3+oGF
         Yx5Q==
X-Gm-Message-State: AOAM532AGFJCKRcZMvveFzmEAApLc2T4WRvJb6lIDRu22oPfRKrmyfeN
        bnPVN8Ob5h5I2QwGGSew9u8gsDUvh0FkS0D+TxS+RUOlO8E=
X-Google-Smtp-Source: ABdhPJzIHKAzuNXF1I9u3zbZpRY0SmNYnlhIdRdAP0jZc9qTbK8y/UIIXFnGfwsJx2eoMuYCg3SYAwdFbHTYainOVws=
X-Received: by 2002:a9d:609e:: with SMTP id m30mr5519799otj.174.1631294189635;
 Fri, 10 Sep 2021 10:16:29 -0700 (PDT)
MIME-Version: 1.0
References: <pull.195.git.1574542242.gitgitgadget@gmail.com>
 <pull.195.v2.git.1630497435.gitgitgadget@gmail.com> <xmqqk0k0ndbq.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2109021616300.55@tvgsbejvaqbjf.bet> <4e998676-4975-8ac2-35a0-34416938b62e@kdbg.org>
 <nycvar.QRO.7.76.6.2109071930080.55@tvgsbejvaqbjf.bet> <CABPp-BFZfa7cchRTycdyMbnwb_f=vHxQYLA5QswuM0ExfxeMAQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.2109101325410.59@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2109101325410.59@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 10 Sep 2021 10:16:17 -0700
Message-ID: <CABPp-BHWVO5VRhr1-Ou60F1wjKzJZ1e_dC01Mmzs+qB9kGayww@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Drop support for git rebase --preserve-merges
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Wong <e@80x24.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 10, 2021 at 5:08 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Elijah,
>
> On Tue, 7 Sep 2021, Elijah Newren wrote:
>
> > On Tue, Sep 7, 2021 at 11:51 AM Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> > >
...
> > > Thank you for clarifying.
> > >
> > > Yes, I remember how that idea came up, and I even tried that strategy for
> > > a couple of merging rebases of Git for Windows' branch thicket. Sadly, it
> > > did not work half as well as I had hoped.
> > >
> > > The best idea I had back then still is in want of being implemented: sort
> > > of a "four-way merge". It is basically the same as a three-way merge, but
> > > allows for the pre-images to differ in the context (and yes, this cannot
> > > be represented using the current conflict markers). Definitely not
> > > trivial.
> >
> > merge-ort opens a new possibility (since it does merges without
> > touching the index or working tree): Take the merge commit, M, that
> > you are trying to transplant.  Hold on to it for a minute.  Do what
> > rebase-merges does now; namely, do a simple merge of the desired new
> > branches that otherwise ignores M to get your new merge commit N.
> > Hang on to N too for a minute.  Now use merge-ort to auto-remerge M
> > (much like AUTO_MERGE or --remerge-diff does) to get a new merge
> > commit that we'll call pre-M.  If M was a clean merge that the user
> > didn't amend, then pre-M will match M.  If M wasn't a clean merge or
> > was amended, then pre-M will otherwise differ from M by not including
> > any manual changes the user made when they originally created M --
> > such as removing conflict markers, fixing semantic conflicts, evil
> > changes, etc.
> >
> > Now we've got three merge commits: pre-M, M, and N.  (Technically,
> > pre-M and N might be toplevel trees rather than full commits, but
> > whatever.)  The difference between pre-M and M represent the manual
> > work the user did in order to create M.  Now, do a three-way
> > (non-recursive) merge of those commits, to get the rebased result, R.
> > This operation has the affect of applying the changes from pre-M to M
> > on top of N.
> >
> > There's obviously some edge cases (e.g. nested conflict markers), but
> > I think they're better than the edge cases presented by the
> > alternatives:
> >   * the first-parent difference idea silently discards intermediate
> > changes from reapplying other patches (especially if other patches are
> > added or dropped), which to me feels _very_ dangerous
> >   * the current rebase-merges idea silently discards manual user
> > changes within the original merge commit (i.e. it hopes that there is
> > no difference between pre-M and M), which can also be lossy
> >   * I don't think this idea drops any data, but it does run the risk
> > of conflicts that are difficult to understand.  But I suspect less so
> > than your five-way merge would entail.
> >
> > If the difficulty of conflicts in this scheme is too high, we could do
> > a few things like providing multiple versions (e.g. if either
> > pre-M:file or N:file had conflicts, or maybe if R:file has nested
> > conflicts, then place both R:file and N:file in the working tree
> > somewhere) or pointing at special commands that help users figure out
> > what went on (e.g. 'git log -1 --remerge-diff M -- file').
>
> While I agree that `merge-ort` makes a lot of things much better, I think
> in this context we need to keep in mind that those nested merge conflicts
> can really hurt.

Yes, and I'm not sure you fully appreciate how much either.  Your
discussion in the other thread of nested conflicts suggests you may
not be aware of a few facts; for regular merges (not talking about
rebase-merges yet):

* Merges can have nested conflicts DESPITE having unique merge bases
and NOT using merge.conflictstyle=diff3
* With unique merge bases (i.e. not a "recursive" merge), a merge will
have at most two layers of conflicts
* non-unique merge-bases and merge.conflictstyle=diff3 make nested
conflicts much more likely
* There is no limit on the number of nestings of conflict markers for a merge

Now, in terms of rebase-merges:

You noted in the other thread the possibility of being unable to
differentiate conflict markers because they had the same length.
However, increasing the length on the second merge by one or two
characters is not sufficient in general, because that might just make
you match the length of one of the nested conflicts from the other
merge.  You need to programmatically determine the sizes of the
conflict markers in the first merge, and then adjust based on it for
your other merge(s).


I know this will sound like I'm scaring you off of my idea even
further, but I actually think despite the above that my ideas for
rebase-merges may have merit.  I just want people to actually
understand the edge and corner cases.  From my reading of the previous
threads on rebasing merges, I'm concerned that there is no discussion
of arbitrarily nested conflict markers and a complete omission of any
considerations for path-based rather than content-based conflicts.

> In my tests (I tried to implement a strategy where a 3-way merge is done
> with M and N^, using the parent commits of M as merge parents
> successively, see
> https://lore.kernel.org/git/nycvar.QRO.7.76.6.1804130002090.65@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz/
> for the nitty gritty), I ran into _nasty_ nested merge conflicts, even
> with trivial examples. And I came to the conviction that treating the
> merge conflict markers as Just Another Line was the main culprit.

I agree that we should not treat merge conflict markers as Just
Another Line.  There are other issues I can mention besides the above
here, but I'm getting kind of long already.

However, I think a big part of the problem you ran into was that the
previous suggestions only work nicely in _really_ simple cases.  In
particular, although I like Phillip's suggested sequence of merges[1]
a lot more than the other suggestions in that thread or from prior
threads, his suggestion is going to be prone to unnecessary nested
conflict markers, as you found in your testcase.

[1] https://lore.kernel.org/git/6c8749ca-ec5d-b4b7-f1a0-50d9ad2949a5@talktalk.net/

> I wish I had the time to try out your proposed strategy with the
> conconcted example I presented in that mail I linked above. Because now I
> am curious what it would do...

For this simple testcase, as best I understood it (you didn't quite
describe it fully so I had to take a guess or two), it provides a
simpler conflict than either of the two you showed you got (from
different merge orderings of Phillip's suggestion).   However, let me
double check that I understood your testcase correctly; please correct
any errors in my understanding.  I believe the commit graph you were
describing was this:

* rebase-of-original-merge
|\
| * rebase-of-local-add-caller-of-core
* | rebase-of-local-rename-to-hi
|/
* upstream
|
|
|
| * original-merge
| |\
| | * local-add-caller-of-core
| |/
|/|
| * local-rename-to-hi
|/
* initial-version


Further, the versions of main.c in each of those are as follows:

==> initial-version:
int core(void) {
    printf("Hello, world!\n");
}


==> local-rename-to-hi:
int hi(void) {
    printf("Hello, world!\n");
}


==> local-add-caller-of-core:
int core(void) {
    printf("Hello, world!\n");
}
/* caller */
void caller(void) {
    core();
}


==> what an automatic merge of the two local-* branches would give:
int hi(void) {
    printf("Hello, world!\n");
}
/* caller */
void caller(void) {
    core();
}


==> original-merge (amended from above by s/core/hi/ in caller()):
int hi(void) {
    printf("Hello, world!\n");
}
/* caller */
void caller(void) {
    hi();
}


==> upstream:
int greeting(void) {
    printf("Hello, world!\n");
}
/* main event loop */
void event_loop(void) {
    /* TODO: place holder for now */
}


==> rebase-of-local-rename-to-hi (kept 'hi' over 'greeting'):
int hi(void) {
    printf("Hello, world!\n");
}
/* main event loop */
void event_loop(void) {
    /* TODO: place holder for now */
}


==> rebase-of-local-add-caller-of-core (kept both new functions,
updated caller):
int greeting(void) {
    printf("Hello, world!\n");
}
/* main event loop */
void event_loop(void) {
    /* TODO: place holder for now */
}
/* caller */
void caller(void) {
    greeting();
}



If I've understood that all correctly, then my idea will give you the
following conflict to resolve:

==> rebase-of-original-merge, before conflict resolution:
int hi(void) {
    printf("Hello, world!\n");
}
/* main event loop */
void event_loop(void) {
    /* TODO: place holder for now */
}
/* caller */
void caller(void) {
<<<<<<< HEAD
    greeting();
||||||| auto-remerge of original-merge
    core();
=======
    hi();
>>>>>>> original-merge
}
