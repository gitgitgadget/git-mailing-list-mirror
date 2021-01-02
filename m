Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF426C433E0
	for <git@archiver.kernel.org>; Sat,  2 Jan 2021 19:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92B22207AA
	for <git@archiver.kernel.org>; Sat,  2 Jan 2021 19:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbhABToy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Jan 2021 14:44:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbhABToy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jan 2021 14:44:54 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A9EC0613C1
        for <git@vger.kernel.org>; Sat,  2 Jan 2021 11:44:13 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id v5so15920839qtv.7
        for <git@vger.kernel.org>; Sat, 02 Jan 2021 11:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gTN4VZX7WnXf91DDt5TOfmLtIRkQsX2dbFk3QHTFedU=;
        b=Qk6NI1Q9os5TJG7bgS/7upH8zLtk2kj3UeJWeNH7lNP/bSWU6rhL0L5UE2dTQMRtFA
         N86mmH85qB4UibzgzeJZkxHMQ27HI9Ar2seP2tuUTccFg8fNkffqx+Zv/gScnl6VQlaM
         FRaS3RAUMkgOG3qdZjcZoeqTi9xe60oMW8I+j284mf22g00zI4xwG3rk3J/vwWCNi1AX
         VdiM+weaf7V4cRoaBO8J2m3ufG8iWv573EDzJiuAB+S/TVhhyD3uZ8lyxsn/FB+rysTj
         W2cy5zWPZrTH6hI6meJ9++vwUjKdAMX2o6ePRZI8tych7vT2o8Nh+obuNdfqxj03eT8F
         qKcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gTN4VZX7WnXf91DDt5TOfmLtIRkQsX2dbFk3QHTFedU=;
        b=G2K0xvZ+tbURruEB0rwfhh1ONGSdTdNQ6qLp9tm/Yq3c53AkVugBwzV6JMACb5Z3pn
         OHfKpmmXu9cp4HGwRDsc3UEPXDwCaGnvb0uP85O+f56LPEoPINt4RTJfI42oKDcFD5wD
         uyn1DsbcMevfQjIJxjIlpALYu1DMiPGUURDyE+TvsKiwEGXHHluwCRSRJ0DgFCw5rSCx
         JAlJjrgdBuhIy2l1OrVhhXHwLw4ciZHJISyx8mLAD8Cwik5U19Uu7QYp1rsmmr2c9rKb
         j22/RSYppJQtyLW2UMIVAgM/7Mj9gZHk1Fg0Wm9zWbkyOrXKkffiwbyAkSIA9NCie+M3
         BQWQ==
X-Gm-Message-State: AOAM533at6TkZEhRvJePOBseQsCdC6qOr+nq6tUJj3QtilS64Huo1Hry
        ScO6GtJPWRurxGt1oul228p4N6dg3LIRkK0JR8Q=
X-Google-Smtp-Source: ABdhPJzzP5nB2Wxpg9fzFAcz1AQLuekw9DqJ6fjbAkkC/EODrGwck88QKI5oOTU2YO80ZVZUJMeHgPEY9AEQm2OoVXI=
X-Received: by 2002:aed:31c5:: with SMTP id 63mr65720928qth.84.1609616653153;
 Sat, 02 Jan 2021 11:44:13 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a0c:e3c9:0:0:0:0:0 with HTTP; Sat, 2 Jan 2021 11:44:12 -0800 (PST)
In-Reply-To: <5ff0c58422038_90dc208ea@natae.notmuch>
References: <CA+RLzGCtp2T=8DG74geBs67X5vUvhwRP4FMZ6MJv+E+Pj=YbWw@mail.gmail.com>
 <5ff0c58422038_90dc208ea@natae.notmuch>
From:   Yaroslav Nikitenko <metst13@gmail.com>
Date:   Sat, 2 Jan 2021 22:44:12 +0300
Message-ID: <CA+RLzGArUrxC-Kbng3qGpRZUrZXKZj3zD3Hcut=XrUY-i-eYAw@mail.gmail.com>
Subject: Re: git-dir requires work-tree; documentation improvements for
 working directory
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2021-01-02 22:12 GMT+03:00, Felipe Contreras <felipe.contreras@gmail.com>:
> Yaroslav Nikitenko wrote:
>> I use git to manage my dotfiles with this command:
>>
>>     git --git-dir=/home/yaroslav/.cfg/ --work-tree=/home/yaroslav
>
> I do precisely the same thing.
>
>> When reading documentation, I noticed two issues.
>>
>> 1) The command doesn't work without --work-tree (even from the top
>> level directory, which is my home directory).
>>
>>     [~]$ git --git-dir=/home/yaroslav/.cfg/ status
>>     fatal: this operation must be run in a work tree
>
> That's weird. It works fine here (although I don't see why I would want
> that).

BTW, how do you do that in your case?

> If you remove all your configuration does it still fail?

It starts to work when I remove my .cfg/config. I've no idea why it
happens. Here is its contents:

$ more .cfg/config
[core]
	repositoryformatversion = 0
	filemode = true
	bare = true
[remote "origin"]
	url = me@myserver:my_working_path
[branch "master"]
	remote = origin
	merge = refs/heads/master


>> 2) In the man documentation for git > git-dir it's written
>> "It can be an absolute path or relative path to current working
>> directory."
>> I think this can be confused with work-tree. I suggest removing the
>> word 'working' (and probably add an article 'the' before the
>> 'current', but I'm not a native speaker).
>
> Yes, the article is missing, as for the rest I have no opinion.
>
>> I don't subscribe to the mailing list but hope that I'll receive the
>> replies.
>
> Don't worry. The git mailing list doesn't munge the Reply-To header, so
> any decent MUA will keep you in Cc.

I noted that, thanks.

> Cheers.
>
> --
> Felipe Contreras
>
