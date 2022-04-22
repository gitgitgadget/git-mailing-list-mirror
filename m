Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF16FC433F5
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 13:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447967AbiDVNaT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 09:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234679AbiDVNaQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 09:30:16 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A0555231
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 06:27:23 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id t11so16348175eju.13
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 06:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1MrKEyclU4ypk9snXt9qmJbPeveiH7u8UBCEVn+VFqg=;
        b=X3+QhzslgmvCC8WGrbEW1yQRFoIMGw0m/vnBTdKwSOh0CZypnVGeFgKdIdTiQ27JUO
         3EWw4fl9AYZCt07Hd9nF2edJ1C/BKG/WZQwm9mPQc03J7mBin2oYhVBRwBvoC+IO4EdC
         CgkzvOqfdgtthr123Q5pipeWmhKJoLTz1k4Tk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1MrKEyclU4ypk9snXt9qmJbPeveiH7u8UBCEVn+VFqg=;
        b=qPi64CVnRlhcbuAPyl+wvPw62tUO4ZjYMY0DhTDp4OI7T/TIlAgJq92hXq722KY/zn
         CN38h+cIEdujikxndtexwHlvn9H6iSMrZSJxrl86HGGD4SxdoQRGGG/dxV6MRmXjqEF7
         OH8fRLIaudfNaj0Q25ftQZhsQSHxjOtgsaNPgM7qvU1wzWvGItQxotIdU16dDP2q3X64
         hiTjeYoxpPjZcf0i/1UGxRkFap/3lgU4phaTxXcyJCdFhkHYiMosusCtAnfDKvxFpgO5
         5dG5Xzm4s7iep12i445ZQ9OgAFlN6t4uGYvCB132AgBfzoxhCAyEZQ5p81cmxiBgCNOJ
         M+xQ==
X-Gm-Message-State: AOAM533yD8YLVNOci2muqb5I4KqumIL02MD9MJ1L7S2glXON7aZsJVy9
        NSzDZDSjyfUx0ABlTC6kM5ddkDDHFvL+jHrIXB4EDQ==
X-Google-Smtp-Source: ABdhPJwCHAxJ8eWtQPj/Nq38zyGUStNQLJUPZNdmqKxKuhnTcuf41LVd5Ija6Xfuab9QzPEcb+HTeU+BYZtQoNvV4c4=
X-Received: by 2002:a17:906:4d1a:b0:6e8:8860:8a72 with SMTP id
 r26-20020a1709064d1a00b006e888608a72mr4342516eju.540.1650634041753; Fri, 22
 Apr 2022 06:27:21 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1161.v3.git.1646032466.gitgitgadget@gmail.com>
 <pull.1161.v4.git.1647843442911.gitgitgadget@gmail.com> <Yl2qwO0SMPOhb5h9@google.com>
 <CAPMMpogY5vZU8gyRSYh+BM4goPPtJw0cCiM-31sy-s_uGRv8uA@mail.gmail.com>
 <xmqqczhbr6pv.fsf@gitster.g> <CAPMMpohQei9vBBm=7hC=N5LPwzMCED=fZcXyePnrkLCHfCJTZw@mail.gmail.com>
 <xmqqlevzkxrf.fsf@gitster.g> <CAPMMpoiCD+fG=bs2j4Rin5Pvip9Mre9iqLcOb2LYnDQK9cuRxw@mail.gmail.com>
 <xmqqzgkddf8m.fsf@gitster.g> <CAPMMpoj+g-XFKXoAXzW4d6WZRSBO_uE6MRsw2jWUPAjqWFQt2A@mail.gmail.com>
In-Reply-To: <CAPMMpoj+g-XFKXoAXzW4d6WZRSBO_uE6MRsw2jWUPAjqWFQt2A@mail.gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Fri, 22 Apr 2022 15:27:10 +0200
Message-ID: <CAPMMpojyO82ooz8hMAnd_nuGOc68Th_bRXF=2t+DuTJjR8xWgw@mail.gmail.com>
Subject: Re: [PATCH v4] merge: new autosetupmerge option 'simple' for matching branches
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Josh Steadmon <steadmon@google.com>,
        Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 22, 2022 at 11:24 AM Tao Klerks <tao@klerks.biz> wrote:
>
> On Fri, Apr 22, 2022 at 4:27 AM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Tao Klerks <tao@klerks.biz> writes:
> >
> > >
> > > Unfortunately, I'm not sure what "something better than simple" for
> > > push.default actually is, in the current system.
> >
> > "none", probably.  Much better than "current" that can create new
> > branches on the other side, which you would want to do with an
> > explicit end-user instruction (i.e. not with "git push", but with
> > "git push origin topic").
> >
>
> Hmm, I don't understand you here. You either mean "simple is the best
> option you could choose for push.default, when
> branch.autosetupmerge=simple, none of the other options are better",
> or there's a small typo and you're saying "push.default=nothing would
> be better". I'll assume the latter, but I'm not sure because I don't
> see how it can be a good-faith statement.
>

My apologies for the tone here, I clearly sent before re-reading
properly. I cannot presume to state what you did mean; I meant to say
something like "I assume you mean either X or Y",  or "my plausible
interpretations are X or Y", or something similarly reflective of my
own limitations.
