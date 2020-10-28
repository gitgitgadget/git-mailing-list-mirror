Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6EFAC55179
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 00:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8988B2080D
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 00:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzqA1jhY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388531AbgJ2AXX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 20:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388527AbgJ1Who (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 18:37:44 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56F0C0613D1
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 15:37:43 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id f7so1271752oib.4
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 15:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1XYlFL8ejqyTPPprGNxTRooDpX2JgMW72pLAzcqcqrs=;
        b=bzqA1jhYpbmTZ00WkYh+D3ANjSe+F4sadyqFpR62B/Y+4NpOi/NN2gpGnuSEMqF+Vc
         9ZrzpVF/aNscPlO6LO6oDyWkCsjKmz3dYjCb80PZjde8N2bpbArelDnc43RwZOah1u/U
         jfTBWE/HT8d+SncREMEeY8f/SR6yoZOU+k0tQQQUX7HHmxvUFR9/w5+ilYYUWRcBDxJD
         SIzXF8DCzesNn84McvZXeBLcxHDDlowoUjWjttaY8AZkp8/ziQQW0H0GUNIsbkW+z8kB
         Q7k44mOqNu1RWx2meM3zXpj4RWM6qcHXDK/hqoO4ZLurWUuVoO/UhXolgOFb0bs0o2FO
         9z/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1XYlFL8ejqyTPPprGNxTRooDpX2JgMW72pLAzcqcqrs=;
        b=LIzBjvsGvelgoA0BU6GT1ayNr+Kliql4Hqi9IcUZT3t3gt6U4SCv2t7MRWbNBBuwwK
         +E/0FpSn2KeuMNaBdRqk0e8vS1bOP+ZBXtIMWZH/6Jc4GLQQ0uBf5Mg6VX7NgkZFHZaw
         iPBZp266RVm1AaMz15l5nNfEXzQ1YgBMwhhVmeKFLIfirWqaNvs5bXs7s7rc112QBv/z
         mv1rQHfXCv/++Qu+MC8Xll9QDu8w657C9qvi6q8vN1DH6qxR//RidvmjFpuI8XrAABOf
         ny7sMMqgTKoYpCSDn7jtC//WxgBeGS8+Uy94wUkfraVE9uJeDiif+xN83LJpZHr4tNQr
         IYbg==
X-Gm-Message-State: AOAM532zH49lM5f59J4V43pA2BJeptWQvtqqfV++gw0CQsF2uLE8z8q6
        KszdtK/tFU78SYHLb26oDsUJ07oyLdtZ5VXaLM97Hask8CM=
X-Google-Smtp-Source: ABdhPJybyy91HTWvTfQI2Y3TM+qW7KBigcRNMBhE8X/G27QyiZ97a2lD0Xy6ikLa86ZQaysE5pGILRO0xfl3obd/9Iw=
X-Received: by 2002:aca:55c3:: with SMTP id j186mr5288425oib.98.1603890894839;
 Wed, 28 Oct 2020 06:14:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAPSFM5e9tXx_LuwNK+e1wOjaHb6kiTCEt3WeL851KAbTPNsEow@mail.gmail.com>
 <6a2005e7-6b8b-2bf4-91fa-55feadd65897@gmail.com> <CAPSFM5fbZN0uv9SgB-d4SR53ZFw8cOkgFmUK-Gns+c=yAmcP1w@mail.gmail.com>
 <966470c3-8883-faf1-629f-89fc8d18b339@gmail.com>
In-Reply-To: <966470c3-8883-faf1-629f-89fc8d18b339@gmail.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Wed, 28 Oct 2020 18:44:43 +0530
Message-ID: <CAPSFM5evXnsOT3Oj=PXzeDYUR8esCd1rEZXpihSdbT7NPuYm1w@mail.gmail.com>
Subject: Re: [Outreachy]: Help for Outreachy Application
To:     phillip.wood@dunelm.org.uk
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 27 Oct 2020 at 23:18, Phillip Wood <phillip.wood123@gmail.com> wrote:
Hi Phillip
>
> Hi Charvi
>
> On 27/10/2020 14:24, Charvi Mendiratta wrote:
> > On Mon, 26 Oct 2020 at 16:06, Phillip Wood <phillip.wood123@gmail.com> wrote:
> >> On 25/10/2020 07:43, Charvi Mendiratta wrote:
> >>> I have read the Outreachy projects and am interested in the project
> >>> "Improve droping and rewording commits in Git interactive rebase". I
> >>> spent some time understanding the project and have gone through its
> >>> detailed explanation in the issue[2].
> >>
> >> Thanks for your interest in the project
> >>
> > I apologize for late replies, as I thought to spend some more time in
> > understanding the project.
>
> That's fine, no need to apologize - taking time to understand the
> project is good
>
>  >[...]
> >>> I also looked into archives of the mailing list and found the
> >>> patches[3] submitted by Philip for --reword option in git commit and
> >>> need some more pointers about its status and how to start with its
> >>> code ?
> >>> Also, in the issue[2] as commented by Phillip regarding the patches[4]
> >>> that implements reword. I would like to know if I can start with that
> >>> mentioned work, if available.
> >>
> >> Whoever takes on this project is very welcome to use my patches as a
> >> starting point. The code in the patches is sound as far as I know and
> >> the I believe the test coverage is reasonable (though that would need to
> >> be checked). They are lacking any documentation and there has been a
> >> change to the way empty commits are handled by rebase since they were
> >> written so "rebase -i: always keep empty amend! commits" will need
> >> looking at and could probably be dropped.
> >
> > Okay, I will note these points .
> >
> >> We will also need to decide on the best UI for the --reword idea. My
> >> patches were developed a couple of years ago before I was aware of
> >> dscho's idea and so implement a slightly different UI to the one
> >> outlined in the github issue (they call 'reword!' 'amend!' instead). I'm
> >> not that keen on adding another option to `git commit` to create yet
> >> another flavor of fixup commit, we'll need to agree a way forward on that[1]
> >>
> >
> > I agree that we need to look into options for creating reword! commit
> > and drop! commit and its integration with interactive rebase .
> >
> > Also, considering this I think there can be two possibilities :
> >
> > As mentioned by Junio [1] that we can extend the existing '--fixed <commit>'/
> > '--squash <commit>', to implement reword! commit as mentioned in the issue[2]
> > by Dscho .
>
> My concern with the idea of using `--fixup=<commit> --edit` to create a
> reword! commit is that it is changing existing behavior. I (very)
> occasionally add some temporary notes to a fixup commit if I know I'm
> not going to be rebasing for a while, that would still be possible under
> the new scheme but would require manually editing the subject line.
>

I am still unable to get the case as you mentioned . Otherwise, I thought
earlier about this idea as that for creating reword! commit if we want to
change both the content and message then `--fixup=<commit> --edit` can
be used and will be presented same as `git commit --amend` . Secondly, if
we want to change only message then `--fixup=<commit> --edit --allow-empty`
can be used and will present same as `git commit --amend --only` for the
mentioned commit . Please correct me if I am wrong or missing something .

> > or as you have mentioned to change the semantics of
> > 'git commit --fixup/squash".
>
> I think that would require a config variable to opt in which is not ideal.
>
> Since that discussion I've wondered if changing commit to allow
> `--fixup=reword:<commit>` to create an empty reword! commit that changes
> the message of <commit> when it is rebased and `--fixup=amend:<commit>`
> to create a reword! commit that changes the content and message of
> <commit> when it is rebased. The advantage is that they are backwards
> compatible and mirror --amend and --reword as suggested in the other
> thread. We could allow `reword/amend:<commit>` to be abbreviated as
> `r/a:<commit>`
>

Okay, I note this as one of the possibility and I agree completely with this.

> We also need to decide how to apply a reword! commit when rebasing. My
> patch series adds a new command 'amend' but I wonder if we should think
> about using `fixup -C` to reuse the message without editing and `fixup
> -c` to reuse the message and have the user edit it as we do for `merge`
>

Yes I also think, like we are not using extra commit command, then we
can also avoid to use new command in rebase also and can go with `fixup -C`.
But, I am still doubtful that how it will work upon rebase
--autosquash . I am still
looking for some pointers for how merge command works(its use) in rebase -i.

> One other point - as the reword! mechanism changes the contents and
> message of the commit I wonder if we could improve the name - maybe
> amend! or revise! I'm not sure.
>

As I understood, that reword! mechanism includes two cases, first if we want
to change the content and commit message both and second if only need to
change the commit message (as mentioned in issue to --allow-empty). As the
word "reword" implies the second case only . So, considering this I also agree
to improve its name to the one as you suggested or may be other.

> > And, if we consider the above then for drop! commit, I wonder if we
> > can implement
> > it in the same way as mentioned in issue [2] by adding the --drop
> > option to 'git revert'.
> >
> > Secondly, as you have mentioned here [3], there could be a `rewrite` command
> > as a wrap of `rebase -i` . But regarding this, I want to once confirm
> > if this can be a
> > solution of this project or is it need to be done later on.
>
> The 'rewrite' idea is definitely not part of this project, it's an idea
> for better history editing in the future.
>

Okay,Thanks for confirming this  .

Thanks and Regards,
Charvi

> Best Wishes
>
> Phillip
>
> > Please correct me if I am wrong.
> >
> > Thanks and Regards,
> > Charvi
> >
> > [1] https://lore.kernel.org/git/xmqqft77glhn.fsf@gitster.c.googlers.com/
> > [2] https://github.com/gitgitgadget/git/issues/259
> > [3] https://lore.kernel.org/git/95cc6fb2-d1bc-11de-febe-c2b5c78a6850@gmail.com/
> >
> >> Best Wishes
> >>
> >> Phillip
> >>
> >> [1]
> >> https://lore.kernel.org/git/95cc6fb2-d1bc-11de-febe-c2b5c78a6850@gmail.com
> >>
> >>>
> >>> Thanks and Regards,
> >>> Charvi
> >>>
> >>> [1] https://public-inbox.org/git/20201021124823.2217-1-charvi077@gmail.com/
> >>> [2] https://github.com/gitgitgadget/git/issues/259
> >>> [3]
> >>> https://public-inbox.org/git/pull.736.git.1600695050.gitgitgadget@gmail.com/
> >>> [4] https://github.com/phillipwood/git/commits/wip/rebase-amend
> >>>
> >>
