Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBF8C433F5
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 17:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235879AbiDMRrR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 13:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233587AbiDMRrQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 13:47:16 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F972CE39
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 10:44:54 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id 9so2732732iou.5
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 10:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kXE6DZdmnEXKChJutyG4ABLQUguqeeNxXWf7oWp0YbQ=;
        b=DUln5/G0xWjtgGjpKZmq2EvAoEbCgZe6VdhQBcGAiYvWzsarAngAi/H2KEAyVBLKBz
         7ccSTDzAe4poGz30pxHlNtw1ekrHKz+7CW1OuROBeJblyQYKxhRq3SGk+tAiONX/Vah3
         ASwS7d0tTKL6RHm+gFCLSi9o/XSazyYz/9leysLMdr7xfRGuXtcBu+BZFficLCOFLAD0
         IKh5aLd5Uo5gb42bv1yJQukzo1eALeFTsWjtsI3fAZy4ljtLcmE1ntGS8fxkcddItPSj
         EVqM8DZHYwdxZkKCAt03vTKNgm5IMq6VIluo6m7pP1rGpVnw7aF28EUZ0Rsle/qDxQnH
         ufmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kXE6DZdmnEXKChJutyG4ABLQUguqeeNxXWf7oWp0YbQ=;
        b=eJVktxERiBUHLU/i6haDeA4Wrq4EylfbpfYdJImUD3Aw1iusK+9INck8Ovnkp6bFqz
         51SxkjMV5vl7iv3xdS5P6K6A1CLEWNnDGlWBVIe5qWw57OhEBSBDYwwOLu8R7Soh0paw
         xN5qx2JiWgw7CWOU4Km8a4IKBQIGFSrP1UBR8lpZ7ITUWaR5D0LwDlYwlff9IbN6gYDF
         3FzddGyoUJ385AyEE5Njy3kwPXBXzOSOt4EmkSZ96hm6i9fn3RNfcNU6ngWD05n8VBgB
         EhBgqU6Yv/W7tr/hyenlWHBYi1ffIN5+zk0uRsdrrUqblufQtaZNIU1WZzTFxXExGVDJ
         tWNw==
X-Gm-Message-State: AOAM532yHgyYRn6uwEA8gEv/oVurJJtm2ShbDTysw5Me5i5eOc5DsT6g
        YPiOFynFME01mEWhff/H1/2hRlOP0v5Q4FrxyYuK4EzA/y8nFg==
X-Google-Smtp-Source: ABdhPJz98wR+kb+GphlGmUCpVNkG67Azbd0jolTUZfBstmI+7LuHDwe99uIQkqc3g9DzXEkkGdAQyUKLqCo6ExhEDIY=
X-Received: by 2002:a05:6602:2a45:b0:648:b21c:6f49 with SMTP id
 k5-20020a0566022a4500b00648b21c6f49mr18705599iov.206.1649871893726; Wed, 13
 Apr 2022 10:44:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220413164336.101390-1-eantoranz@gmail.com> <033701d84f5b$ad167ce0$074376a0$@nexbridge.com>
 <CAOc6etY0fyBnT9kMSm+s1LqfCsSV4RRppokuE5igme-M-cvW6g@mail.gmail.com>
In-Reply-To: <CAOc6etY0fyBnT9kMSm+s1LqfCsSV4RRppokuE5igme-M-cvW6g@mail.gmail.com>
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
Date:   Wed, 13 Apr 2022 19:44:42 +0200
Message-ID: <CAOc6eta7-ZieTnTjmCicXoqf-j=d1SmfRT=PS+cAZUxKw+ti=Q@mail.gmail.com>
Subject: Re: [RFC] introducing git replay
To:     rsbecker@nexbridge.com
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 13, 2022 at 7:30 PM Edmundo Carmona Antoranz
<eantoranz@gmail.com> wrote:
>
> On Wed, Apr 13, 2022 at 7:26 PM <rsbecker@nexbridge.com> wrote:
> >
> > >2.35.1
> >
> > I'm sorry if I'm missing something here but how is this different from
> > cherry-pick A..B?
> > --Randall
> >
>
> Good question, but cherry-pick has troubles with merges:
>
> (same example, after amending):
> $ git cherry-pick v2.35.0..v2.36.0-rc1
> error: commit bb4921cf45e11d063e7bbe55f594adf8f0077d5d is a merge but
> no -m option was given.
> fatal: cherry-pick failed

By the way, Randall, it's not just _merges_. Correct me if I'm wrong
but cherry-pick (or rebase) will run merges (in all their glory) to get code
cherry-picked. What I want to do is skip merges/conflicts altogether
by using the information of existing revisions (the ones we want to
cherry-pick) just adjusting their parents to get the new revisions.

Let me know!
