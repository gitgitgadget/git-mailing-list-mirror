Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC799C433DB
	for <git@archiver.kernel.org>; Sun,  3 Jan 2021 09:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DE3220795
	for <git@archiver.kernel.org>; Sun,  3 Jan 2021 09:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbhACJNK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Jan 2021 04:13:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbhACJNF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jan 2021 04:13:05 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7F0C061573
        for <git@vger.kernel.org>; Sun,  3 Jan 2021 01:12:25 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id v5so16557228qtv.7
        for <git@vger.kernel.org>; Sun, 03 Jan 2021 01:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2jvZHER7XqxOpRABDk7Jl5VRF0OK+uJ3sVpd9tGqKnY=;
        b=LDBa6YnpSKidOkGDJiZrvpQCvKKawTcqUh2TtrNlgkV9HW8Y6ea6XdMmmZJp4stjBn
         X6oDHGb6F0jaVgs1o9karvAsued/eFGTuEM31gCXrU5O6uS87I5efVEihMtdhOoY1ibE
         GKtY7HyZd3sDBpWePWFpj+vuoHQ/elDRS170DRV9i+tLI0U6nTXrr5VzSpRyob353OMB
         GMFyLL5nqTE2n4ymkBnPZNLumcfNLkMz2bYQ2vyK9ufxlLh76PBZF/YOuj0ZMHca9zNu
         8Vo1jD3GDDYWaGeUpJC0HNKK9ebol7WCCf5iEfw+F8ovgdkkHtOIt9IEhG/khe1JdzWm
         4ejQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2jvZHER7XqxOpRABDk7Jl5VRF0OK+uJ3sVpd9tGqKnY=;
        b=to1mCxOTO0932UBkkz5fgEXwctk50j3OnTpyOq5m24TKLJ+8s2E8igBB6UjyteTB79
         Y+rxpWn6I51vBcAKl9vgjWfpaMupJmbW49J9K7tMKOjkLEAo38fd4oG/Xoht4USo1xrI
         p35uAzeQVc+K4RoEziHbsAAem5U3RbPhavrZXlIhmAR/gxM/swHEocRC/EVRifI+Cu5u
         zjBe6+rcmPr62BtLNB5J4DHmA0DnQjzLg05BVSXGL41rhBHHEk+DwCGxGHrqrYxx1Oh4
         eVZ2qciGN6v5LfoLezYB8ctxBZAX6iA78rTLoPmuKVdfWVTX37nPi1DtUhFMLfTqMSoa
         rWoA==
X-Gm-Message-State: AOAM533cv5688Biz7NIPaV7IudT1OH5bibaQU48eeqTHVRUB9s8HcvWh
        ZFjQlpm4LOj3c6xpbm1TwSzv1ZQAE9aWvR0nsOO1X6kf
X-Google-Smtp-Source: ABdhPJxo47m+oBhtcmWt1i8ycNO6e94E0YawyVIlH88sNC8iuZPq2Bdok7+Rzd6LtGceoqxSeSv0c1OpsPijNm8VSBk=
X-Received: by 2002:ac8:5a01:: with SMTP id n1mr65368081qta.227.1609665143501;
 Sun, 03 Jan 2021 01:12:23 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a0c:e3c9:0:0:0:0:0 with HTTP; Sun, 3 Jan 2021 01:12:22 -0800 (PST)
In-Reply-To: <5ff0ed59489bd_a76d2082f@natae.notmuch>
References: <CA+RLzGCtp2T=8DG74geBs67X5vUvhwRP4FMZ6MJv+E+Pj=YbWw@mail.gmail.com>
 <5ff0c58422038_90dc208ea@natae.notmuch> <CA+RLzGArUrxC-Kbng3qGpRZUrZXKZj3zD3Hcut=XrUY-i-eYAw@mail.gmail.com>
 <5ff0ed59489bd_a76d2082f@natae.notmuch>
From:   Yaroslav Nikitenko <metst13@gmail.com>
Date:   Sun, 3 Jan 2021 12:12:22 +0300
Message-ID: <CA+RLzGCfqNdup1cmz3W4iBzbsxe9SD7E+Ju4svNFvhe6ohJqjA@mail.gmail.com>
Subject: Re: git-dir requires work-tree; documentation improvements for
 working directory
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2021-01-03 1:02 GMT+03:00, Felipe Contreras <felipe.contreras@gmail.com>:
> Yaroslav Nikitenko wrote:
>> 2021-01-02 22:12 GMT+03:00, Felipe Contreras
>> <felipe.contreras@gmail.com>:
>> > Yaroslav Nikitenko wrote:
>> >> I use git to manage my dotfiles with this command:
>> >>
>> >>     git --git-dir=/home/yaroslav/.cfg/ --work-tree=/home/yaroslav
>> >
>> > I do precisely the same thing.
>> >
>> >> When reading documentation, I noticed two issues.
>> >>
>> >> 1) The command doesn't work without --work-tree (even from the top
>> >> level directory, which is my home directory).
>> >>
>> >>     [~]$ git --git-dir=/home/yaroslav/.cfg/ status
>> >>     fatal: this operation must be run in a work tree
>> >
>> > That's weird. It works fine here (although I don't see why I would want
>> > that).
>>
>> BTW, how do you do that in your case?
>
> I have an alias:
>
>   alias config='git --git-dir=$HOME/.config/dotfiles/.git/
> --work-tree=$HOME'
>
> So, when I'm in my $HOME, I can do:
>
>   config status

Thanks.

>> > If you remove all your configuration does it still fail?
>>
>> It starts to work when I remove my .cfg/config. I've no idea why it
>> happens. Here is its contents:
>>
>> $ more .cfg/config
>> [core]
>> 	repositoryformatversion = 0
>> 	filemode = true
>> 	bare = true
>
> That's the difference: my core.bare is false.
>
> I do have a checked out work-tree because that's the only way I could
> get some commands to work, for example `git rebase`, even though I don't
> use that work-tree.
>
> I'm not sure if it makes sense to not assume '.' is the work-tree when
> 'core.bare=true', but I think it does make sense, so maybe just turn
> that off.
>
> Cheers.
>
> --
> Felipe Contreras
>

Thanks for the suggestion. I'd rather not change my config at the
moment. It's not difficult to provide work-tree in the alias.

However, I think that this is a bug in the implementation or the
documentation. It's not highlighted anywhere that the repository must
be non-bare for git-dir to work without explicit work-tree (an
opposite is stated in general).

Should I write a letter with [BUG] in its header for that to be noticed?
I'm surprised why there is no issue tracker for git.

Cheers,
Yaroslav Nikitenko
