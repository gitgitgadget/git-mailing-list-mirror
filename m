Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEC611F428
	for <e@80x24.org>; Mon, 30 Apr 2018 00:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754537AbeD3AHS (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Apr 2018 20:07:18 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:54251 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754359AbeD3AHS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Apr 2018 20:07:18 -0400
Received: by mail-wm0-f47.google.com with SMTP id a67so2904114wmf.3
        for <git@vger.kernel.org>; Sun, 29 Apr 2018 17:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=AIz2SPc+We/S5ZiKCso69h8dhn/kF8INYyD6oHy2u1g=;
        b=jjhQt42seJjbzP0Ka9UbYNxJspbazYsgvZMAMoR5JKuSXZQlLx6ULG6SMMGwuLaWij
         3xWZ8NBzX9pCI3PC0DFnjHhQkk9biz9UabZ0R40hh7PsOEmH3iyROZaI+vGVmG5I7GL3
         5mChRIWI8Q+lvvxBI8EENEyJ8wfFuqwJrOLKg5J+SND+buV7q8C/5L8beDBeGrbbrvAG
         ruplnkx7hwxN2mIbgV1DQ6JHqYwmDPI3A0H0RnIEPTkyMd1H31GdFn+AJ4JsfHVVoA2R
         ZoCT6MkqikEUGGRihwG64FDr5n5xamwC7xQMmOBJ6VBdPn1Tdpi4TisIl+fvwyC8zKQX
         EgVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=AIz2SPc+We/S5ZiKCso69h8dhn/kF8INYyD6oHy2u1g=;
        b=Vhdg3rmWDKg+F5akt6/cHmWYNkHAtiYFC6R31dp+gOVErzAhLggqtBH+gx3vlg4AsP
         MqG/vvVaDoxFyyxgWNidwsw0CShujmFVroqs4srqu6wMfTvEzAZ6Fg5fInDUiOVc0y06
         o6Y0K2t7V8NZqQno7ZKiTNKwcqACR4XK4c/oPqx/vfOM14a00VK2bf4NVSrhONOsjFux
         gDIunrDa45jUd4BQWvqyJqMUkNA2JL/Oi2TfrIS6sUXaqlr+y1Ng/2w+k7Y+SUQP5B9F
         DFp3ZfFsFqNlKm6nZnBMs79Mg9mzmLg3TaLJRoD9QGt1qwB8WGUL6ZYxBOvhRIOxhu7E
         fEYQ==
X-Gm-Message-State: ALQs6tA9jsNoqoCxy71GDoMj8SsGLrOSJ2dEasNzdgXIDZC6TNPS+/qw
        015fAuKjRCHcLGPc6efW81k=
X-Google-Smtp-Source: AB8JxZp+nWDqtCleQzmZUpa8S425nvIEgBNBS61VUceqr1mV+cXn/b0mNI1gaP77FyoK5E1I6gjmYA==
X-Received: by 10.28.140.207 with SMTP id o198mr6589028wmd.82.1525046836742;
        Sun, 29 Apr 2018 17:07:16 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id a14-v6sm1524781wra.84.2018.04.29.17.07.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Apr 2018 17:07:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v9 0/4] worktree: teach "add" to check out existing branches
References: <20180423193848.5159-1-t.gummerer@gmail.com>
        <20180424215635.9183-1-t.gummerer@gmail.com>
        <CAPig+cRor4UXXZhoAkhOQfe6W+oC84YFmA-KwpLspuEh_A4Zng@mail.gmail.com>
        <20180428160950.GA17619@hank.intra.tgummerer.com>
Date:   Mon, 30 Apr 2018 09:07:15 +0900
In-Reply-To: <20180428160950.GA17619@hank.intra.tgummerer.com> (Thomas
        Gummerer's message of "Sat, 28 Apr 2018 17:09:50 +0100")
Message-ID: <xmqqh8ntzhe4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> On 04/27, Eric Sunshine wrote:
>> On Tue, Apr 24, 2018 at 5:56 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>> > Thanks Eric for the review and the suggestions on the previous round.
>> >
>> > Changes since the previous round:
>> >
>> > - UNLEAK new_branch after it was xstrndup'd
>> > - update the commit message of 2/4 according to Eric's suggestions
>> > - make force_new_branch a boolean flag in
>> >   print_preparing_worktree_line, instead of using it as the branch
>> >   name.  Instead use new_branch as the new branch name everywhere in
>> >   that function.
>> > - get rid of the ckeckout_existing_branch flag
>> 
>> Thanks. I did another full review of all the patches and played around
>> with the new functionality again for good measure. Everything looked
>> good, and I think the patches are now ready to graduate.
>
> Thanks for all your review work on this series!

Thanks, both.
