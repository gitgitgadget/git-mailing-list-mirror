Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	PLING_QUERY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E08C4321A
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 08:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DF0A23A02
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 08:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbhANIHI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 03:07:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728416AbhANIHG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 03:07:06 -0500
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A572AC061575
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 00:06:19 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id x203so1179831ooa.9
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 00:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hDDYCHivdC0SuOsSheOe5dWD2F0UWULcnFjp95U+ShM=;
        b=NOLEpfYDPEGbUJ9U8Pj5xL3JdJjxXd7it8WC+Aw3ZvxVTDlctP673tXpv5onZnR2Wd
         wq34yk3mQAvLK3vogB+boFE/ZEdjtJHbz5EKj7uU1YJeq2acnVb0eoaPPAn2i+ggNxNO
         g2ide9O1pJXrns3m9dTTCpongRWTj0ROclJ/w5KsfqVhcfE9iadokbaPCtwD+TuRCCGX
         FWI5m9o8haA9yf6yyB+lqnAqbzbboGRNXmQEv8BQ/t/6h/bS4UKfln9Xg7EWFx45fBdU
         4dHW4fDGvsbVSBtI346AFDsC9xA9pMlQsbqYwrFU3mNPuNAL3wVqWPBed3sXZwLyYe4E
         NmEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hDDYCHivdC0SuOsSheOe5dWD2F0UWULcnFjp95U+ShM=;
        b=FMWku0dgRWncKP1dDv2lY+SdJ75rTfzZl5tmumOPDHkpInNGOYC6vIIZ7RPm1iL3RT
         R2hmwAXmgNJYuFvYXORNkeULrPkKMq84IWcUwLTCCDNc3n3jv3KRDcuHiHFScnwVeI6/
         DPytsdukCxTA/vA/eyAY4oPQFx+Y7aPINt4I+c73wm45DRtyq/rwD9FydcobKBRNjWYp
         DEDl95L6jSU28i05Fn6K9h/vROyFQzAIA+IYqX3C7Uce0UxbRtTSZ1Y/Z7pkrl3IUu7y
         yq7cfvjkXS3g5iD3+WibyU+9SW1Z7KPSnJqJ7FUTmpBWTejPUmW7xHhMzuDwqAAGP9rR
         rGgA==
X-Gm-Message-State: AOAM530ZPDEoSBmQvZMe7IYhTrtLAiYEfJKgTQOkEtgk+XIQaW4CiBHF
        AflqhhM65S4isWakQ0nj0BgnPazdYMv59cRkIzw=
X-Google-Smtp-Source: ABdhPJyPyMknJG/XM1uAJVDmLX3ot6nP9ZR6j3V2ILojYAUvSn1KNb/GApBfKf4hoDkzqmZckzKA2glXNQj2dZ6J1QU=
X-Received: by 2002:a4a:4f0f:: with SMTP id c15mr3926285oob.75.1610611578870;
 Thu, 14 Jan 2021 00:06:18 -0800 (PST)
MIME-Version: 1.0
References: <CAPSFM5c2iqBn8_Dih2id7q6RRp0q=vfCSVUHDE5AOXZ8z3Ko9w@mail.gmail.com>
 <CAPSFM5f+cm87N5TO3V+rJvWyrcazybNb_Zu_bJZ+sBH4N4iyow@mail.gmail.com> <X/864HdPtf1km0xZ@nand.local>
In-Reply-To: <X/864HdPtf1km0xZ@nand.local>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Thu, 14 Jan 2021 13:36:07 +0530
Message-ID: <CAPSFM5c=BT2S_32FrfFO7x1EONgaRE0C_TREhaYZVi8F=oj17g@mail.gmail.com>
Subject: Re: How to implement the "amend!" commit ?
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor,

On Wed, 13 Jan 2021 at 23:54, Taylor Blau <me@ttaylorr.com> wrote:
>
> Hi Chavri,
>
> On Wed, Jan 13, 2021 at 06:45:25AM +0530, Charvi Mendiratta wrote:
> > Hi Everyone,
> >
> > Implementing "amend!" commit would be an alternative to the
> > fixup!/squash! commit that addresses the issue as opened here[1]. Also
> > the related patches[2], adds the options to `fixup` command in
> > interactive rebase and supports the "amend!" commit upon
> > `--autosquash`. Next, after discussing with Phillip and Christian,
> > there could be 3 possibilities to implement the "amend!" commit (UI):
>
> To make sure that I'm understanding correctly:
>
>   - Your series in [2] teaches the rebase directive 'fixup' two new
>     options: -C, and -c. Unlike of the option-less 'fixup' command,
>     these new options use the message from the fixup commit instead of
>     the original.
>
>     If I'm understanding correctly, this old-style sequence:
>
>         pick aaaaaaaaaa original
>         fixup bbbbbbbbbb fixup! new
>         exec git commit --amend -C bbbbbbbbbb --no-edit
>
>     should be equivalent to this one:
>
>         pick aaaaaaaaaa original
>         fixup -C bbbbbbbbbb fixup! new
>

Yes, `fixup -C ` works the same as above.

>   - Separate from that, you are asking about how to implement an
>     "amend!" commit which would behave exactly as the 'fixup -C' variant
>     that you are proposing.
>
> We should clarify what you mean by "implement". I take it from the
> remainder of your message that you are really asking about how we should
> _expose_ this new 'fixup -C' command to users.
>

I apologize for the confusion. But yes you got right, by using
"implement" I mean to ask regarding the user interface for "amend!"
commit. So, if we choose to go with adding additional arguments like ,
`git commit --fixup= --amend`, then it will create a new "amend!"
commit and in sequencer it will insert fixup -C, upon `git rebase -i
--autosquash`.

> > Firstly, the `--fixup=<commit>` to have option like,
> > `--fixup=reword/amend:<commit>`
> >
> > So, `git commit --fixup` can have 3 options:
> >
> > a) `--fixup=<commit>`, work as of now, make fixup! commit.
> > b) `--fixup=amend:<commit>`, make "amend!" commit, takes changes and
> > also opens the editor for a new message (Here it adds a new message to
> > amend! commit's message body and upon autosquash it will fixup up the
> > content and reword the original commit message i.e replaces the
> > original commit message with the "amend!" commit's message).
> > c) `--fixup=reword:<commit>`, makes (empty) "amend!" commit, do not
> > take changes and open the editor for a new message(Here, upon
> > autosquash it will just reword the original commit message).
>
> I think that this trio is a good path forward, but...
> `--fixup` behaving as it always has, which is good. Then it makes
> `--fixup=amend:<commit>` insert a 'fixup -C', and `--fixup=reword:<...>`
> insert a 'fixup -c'.
>
> > Secondly,
> > As an alternative to above, we can use `--fixup=<commit> --amend` and
> > `--fixup=<commit> --reword`.
>
> ...I think that this option is even better.
>
> Here '--fixup=<commit>' with '--amend' inserts a 'fixup -C' sequencer
> comamnd, and using the same instead with '--reword' inserts a 'fixup -c'
> sequencer command.
>

I think this would be a bit different. Here both the `--fixup=<commit>
--amend` and `--fixup=<commit> --reword` would create a new "amend!"
commit and at the same time also opens the editor for a new commit
message. And in the sequencer both insert "fixup -C".  So, here for
'--reword', 'fixup -c' is not used in sequencer upon --autosquash, as
we need to open the editor only one time while `git commit
--fixup=<commit> --reword` and works as an alternative to "squash!"
commit that opens the editor both the time.

And, the major difference is that " --fixup=<commit> --amend" would
take both changes and also let the user change the commit message. On
the other hand "--fixup=<commit> --reword" will not take any changes
and only let the user to change the commit message. (So, we don't need
to add additional --allow-empty as we do now).

I also think that the above thing can be a bit confusing and I would
be happy to do more improvements or suggestions to implement
it in a more user friendly way.

> This is clear to me because '--fixup' makes a commit that is interpreted
> separately by the sequencer machinery, so any options that are given
> with it seem to indicate that they will alter how the sequencer
> interprets the resulting commit, which makes sense.
>
> Of course, it's all somewhat confusing because you have to keep track of
> which are options to 'git commit', and which are sequencer commands, but
> I like the direction that you're going in here.
>
> > Next,
> > To use only, `--fixup=<commit> --edit` to make the "amend!" commit.
>
> I don't think that this is as good a direction forward.
>

I agree, thanks.

Thanks and Regards,
Charvi

> > Also as discussed earlier[3] we are avoiding the use of additional
> > options like `git commit --amend=<commit>` inorder to avoid confusion
> > of doing similar things in different ways. So, I wonder which could be
> > the best way to proceed with or if any other way to implement "amend!"
> > commit ?
> >
> > Thanks and Regards,
> > Charvi
> >
> > [1] https://github.com/gitgitgadget/git/issues/259
> > [2] https://lore.kernel.org/git/20210108092345.2178-1-charvi077@gmail.com/
> > [3] https://lore.kernel.org/git/95cc6fb2-d1bc-11de-febe-c2b5c78a6850@gmail.com/
>
> Thanks,
> Taylor
