Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,PLING_QUERY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D9FC433E0
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 18:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 377CD233EA
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 18:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbhAMSZS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 13:25:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728195AbhAMSZR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 13:25:17 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D7DC061575
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 10:24:37 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id c14so1789484qtn.0
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 10:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2aP1sWaD6QNATEov/dQmQcnDXa0wbR+rRGXv4MeAFAw=;
        b=CPIi8K4hOJxGSw2PGUuRV7EOW8ksRAxx01mvdFc83KfQEduoqptyDPwKlS3br4GtWN
         vVOqTi/kyhs23st9Zks7QqwHXlpQJgpsOrT7WXaD0BeVl3Rdmi0SGF6NxzAq8z4WvY5y
         bhZQv8S+0PLpbyX3b009yKfu2Hr0wsrpZ96wk7sjcl3eEG4WvQYoqPGHc6XJXNFwgOyB
         B03BPJo95rdSOYTPBiq5I2yzOgNBA9CjpaRXyn+sT9cM2OHEh/7Uzy4yYBCG7lq7Rou8
         sm2kPhrTAR9PuqK5NKaogB7ku0isloVsM0mXXYPFjCJtssTXpljcSfwp/s09G6Y49k4f
         K29A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2aP1sWaD6QNATEov/dQmQcnDXa0wbR+rRGXv4MeAFAw=;
        b=r07eAekduy/qWE9EahmXvlawim5ejOWo072ldQws/8V2NHMjk/ePpYKAV385p1SEfk
         odhw1pGQMw4+cP5w1qx0hjMtVgSf7u2fko8RQv7FHBvLprkoLyM3BAhWavmQJbjayeWF
         PzlU2uaBbhqo8xX7p0XxtRC/MyIqU+lIHc1IWB2hGZnr+xX6rY+MID7cbke4vSDM3V7s
         fwyFA4MeTPshXpFuKnvj6295f2G7i0TYbGZfo4aMZ/9dawjPMlLizfIPlATu+5hFVGpB
         DjgXAsOFMfA3TT84UpotWcx5Mjm0hwngktLZ2i94GlieuGoddD1bHaby8HG4Srg88hbG
         Vf8Q==
X-Gm-Message-State: AOAM532jC0JQm9StwSB0UEP4rvlkKHvwvJtRt+0Dcuw2pyBcjUz9AtbS
        BDAlIiNp37KkFokACnWGe4ZDcw==
X-Google-Smtp-Source: ABdhPJxzw6s68MkME5XYIPng8BrtOr4gmCS0mxz9CYDN6p6x5V5qBVhAaezDaTsXOjE/BZ5MBOkFHg==
X-Received: by 2002:ac8:3598:: with SMTP id k24mr3575936qtb.72.1610562276392;
        Wed, 13 Jan 2021 10:24:36 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:b172:2e4c:efe4:db53])
        by smtp.gmail.com with ESMTPSA id l1sm1429377qtb.42.2021.01.13.10.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 10:24:35 -0800 (PST)
Date:   Wed, 13 Jan 2021 13:24:32 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: How to implement the "amend!" commit ?
Message-ID: <X/864HdPtf1km0xZ@nand.local>
References: <CAPSFM5c2iqBn8_Dih2id7q6RRp0q=vfCSVUHDE5AOXZ8z3Ko9w@mail.gmail.com>
 <CAPSFM5f+cm87N5TO3V+rJvWyrcazybNb_Zu_bJZ+sBH4N4iyow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPSFM5f+cm87N5TO3V+rJvWyrcazybNb_Zu_bJZ+sBH4N4iyow@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Chavri,

On Wed, Jan 13, 2021 at 06:45:25AM +0530, Charvi Mendiratta wrote:
> Hi Everyone,
>
> Implementing "amend!" commit would be an alternative to the
> fixup!/squash! commit that addresses the issue as opened here[1]. Also
> the related patches[2], adds the options to `fixup` command in
> interactive rebase and supports the "amend!" commit upon
> `--autosquash`. Next, after discussing with Phillip and Christian,
> there could be 3 possibilities to implement the "amend!" commit (UI):

To make sure that I'm understanding correctly:

  - Your series in [2] teaches the rebase directive 'fixup' two new
    options: -C, and -c. Unlike of the option-less 'fixup' command,
    these new options use the message from the fixup commit instead of
    the original.

    If I'm understanding correctly, this old-style sequence:

        pick aaaaaaaaaa original
        fixup bbbbbbbbbb fixup! new
        exec git commit --amend -C bbbbbbbbbb --no-edit

    should be equivalent to this one:

        pick aaaaaaaaaa original
        fixup -C bbbbbbbbbb fixup! new

  - Separate from that, you are asking about how to implement an
    "amend!" commit which would behave exactly as the 'fixup -C' variant
    that you are proposing.

We should clarify what you mean by "implement". I take it from the
remainder of your message that you are really asking about how we should
_expose_ this new 'fixup -C' command to users.

> Firstly, the `--fixup=<commit>` to have option like,
> `--fixup=reword/amend:<commit>`
>
> So, `git commit --fixup` can have 3 options:
>
> a) `--fixup=<commit>`, work as of now, make fixup! commit.
> b) `--fixup=amend:<commit>`, make "amend!" commit, takes changes and
> also opens the editor for a new message (Here it adds a new message to
> amend! commit's message body and upon autosquash it will fixup up the
> content and reword the original commit message i.e replaces the
> original commit message with the "amend!" commit's message).
> c) `--fixup=reword:<commit>`, makes (empty) "amend!" commit, do not
> take changes and open the editor for a new message(Here, upon
> autosquash it will just reword the original commit message).

I think that this trio is a good path forward, but...
`--fixup` behaving as it always has, which is good. Then it makes
`--fixup=amend:<commit>` insert a 'fixup -C', and `--fixup=reword:<...>`
insert a 'fixup -c'.

> Secondly,
> As an alternative to above, we can use `--fixup=<commit> --amend` and
> `--fixup=<commit> --reword`.

...I think that this option is even better.

Here '--fixup=<commit>' with '--amend' inserts a 'fixup -C' sequencer
comamnd, and using the same instead with '--reword' inserts a 'fixup -c'
sequencer command.

This is clear to me because '--fixup' makes a commit that is interpreted
separately by the sequencer machinery, so any options that are given
with it seem to indicate that they will alter how the sequencer
interprets the resulting commit, which makes sense.

Of course, it's all somewhat confusing because you have to keep track of
which are options to 'git commit', and which are sequencer commands, but
I like the direction that you're going in here.

> Next,
> To use only, `--fixup=<commit> --edit` to make the "amend!" commit.

I don't think that this is as good a direction forward.

> Also as discussed earlier[3] we are avoiding the use of additional
> options like `git commit --amend=<commit>` inorder to avoid confusion
> of doing similar things in different ways. So, I wonder which could be
> the best way to proceed with or if any other way to implement "amend!"
> commit ?
>
> Thanks and Regards,
> Charvi
>
> [1] https://github.com/gitgitgadget/git/issues/259
> [2] https://lore.kernel.org/git/20210108092345.2178-1-charvi077@gmail.com/
> [3] https://lore.kernel.org/git/95cc6fb2-d1bc-11de-febe-c2b5c78a6850@gmail.com/

Thanks,
Taylor
