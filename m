Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD87C6FA8E
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 17:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjBXRug (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 12:50:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjBXRuf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 12:50:35 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DB411151
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 09:50:34 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id g6-20020a056830308600b0068d4b30536aso56626ots.9
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 09:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gJQPbAYVuoDFLenrI//kZE+q4Y/KPpUNrtJc4biLPjs=;
        b=J0rck+RGKB4GARKqp3OX3ccrqR4Vp+08/hey+jNqSu5ZqVZHD0K6IQI7OAwBxVUeP5
         zWwEXn2/02gHqe5a6D3JcyyLpMt2+AsUl4GIdRBmwhv6QWz1eZw4zlAAlqjPwLAtwci9
         bkHyI8SGDO6GM1EKJkcIMfQXsX+AK/qXQ/MfzP0axgM7k56j9j0+ADNVGEa0dKPCON4L
         p5zbrDWO9xvkcT+tFBEhV9avXG2/GoAz2ufebuErkvMGgrhd1anhO2YygxfiIga8NzAH
         uTsHBkmfhllehZh8POfAOXgsVTBHuOy3vlo3JY8N20G3sy5oDffA0VWdcSTyFQPzWFil
         JloA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gJQPbAYVuoDFLenrI//kZE+q4Y/KPpUNrtJc4biLPjs=;
        b=reeXY8kFo06ERecXj8Ix434lxv1zuB76JdZnzBWn43kBU/x2VZy+xCbt48liC2cWXC
         pF5HKcEQns6BWfXH/BQXZ+/quWwOSe7z1ZRuC7Z8V2zqeS3WTkzy6EIbEKD/CMBPohNz
         GjSdA5Xh0vDtwNp1wtJbJUNyO/396P8074weymh2OAY8jQVmwtp1t+ioIhY24b/NSXXb
         7ZOWwOb1qodVpU5O0ULe8RXR80wksnbu+NxQzUO3mTXKUZs+uDoyUo6bGLmvUh4gsoRr
         hNY5niRUfZMXx0levAgzUwg1BC9r7gmK6LuWoYu/awj1wv75LCowrpuDscsqY1TUj8FM
         J2pA==
X-Gm-Message-State: AO0yUKVWi+7Gz3eDIqyW8KUYP3UHaeJOAHEc5MBFTL7pUH6D455ykhEq
        c0RVdSFMUn+Ng5bFEmNnmrBOx9uAv4riAc5X+f8=
X-Google-Smtp-Source: AK7set8haidR7WgAq5dewBBMGLZce/vQCvRLlJLLMj7V6MedLmWwFFm40Q+0ezFtERNhEnnWfa8yfSJPICPtQ10dFfI=
X-Received: by 2002:a05:6830:4088:b0:68b:dd51:8b5 with SMTP id
 x8-20020a056830408800b0068bdd5108b5mr1800265ott.2.1677261034151; Fri, 24 Feb
 2023 09:50:34 -0800 (PST)
MIME-Version: 1.0
References: <20230223053410.644503-1-alexhenrie24@gmail.com>
 <20230223053410.644503-2-alexhenrie24@gmail.com> <b4be9cb3-c24b-4377-bab3-5d53035efdf8@gmx.de>
 <xmqqy1on0yla.fsf@gitster.g>
In-Reply-To: <xmqqy1on0yla.fsf@gitster.g>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Fri, 24 Feb 2023 10:50:23 -0700
Message-ID: <CAMMLpeQKJeZn4rcTJzFR-ixQXKQMT7t-BKvJqXV4o_4VM=tHYg@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] rebase: stop accepting --rebase-merges=""
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, tao@klerks.biz, newren@gmail.com,
        phillip.wood123@gmail.com, sorganov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 24, 2023 at 10:20 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > On Wed, 22 Feb 2023, Alex Henrie wrote:
> >
> >> The unusual syntax --rebase-merges="" (that is, --rebase-merges with an
> >> empty string argument) has been an undocumented synonym of
> >> --rebase-merges=no-rebase-cousins. Stop accepting that syntax to avoid
> >> confusion when a rebase.merges config option is introduced, where
> >> rebase.merges="" will be equivalent to not passing --rebase-merges.
> >
> > Being undocumented and obscure might be a good reason for some to consider
> > this a bug; I do not. You could deprecate it, but there are probably
> > better ideas than to remove it without prior warning.
> >
> > If all you want to do is to support `rebase.merges=`, you can do that
> > without having to change the meaning of `--rebase-merges=`.
>
> Thanks for a doze of sanity.  Let me mark the topic as on hold to
> wait for a resolution.

As Johannes pointed out, it's going to be confusing if
rebase.merges="" does not mean rebase.merges=false. It's also going to
be confusing if rebase.merges="" does not mean --rebase-merges="". The
only sane option I see is to drop --rebase-merges="", or to add a
deprecation warning now and drop it later.

-Alex
