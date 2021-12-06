Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81EFDC433F5
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 17:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236874AbhLFR11 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 12:27:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234199AbhLFR10 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 12:27:26 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDE6C061746
        for <git@vger.kernel.org>; Mon,  6 Dec 2021 09:23:58 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id f18-20020a17090aa79200b001ad9cb23022so419111pjq.4
        for <git@vger.kernel.org>; Mon, 06 Dec 2021 09:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Ex7G1Dc4ndxqth3h7XLfmdXzkyG8DOXuEtz7dPDbY9o=;
        b=pLANn+/lZjbbnQyQTupeWmXcO6fCAqaH1b0qTfVwb7DmuwLT7aHi0kjzI0XWoY3ODj
         e/hcK8z68+twZfA04bH1z+4XDAl+ZgcBMu5royAOXcEP7nG1pJWcv9eQvRq7VQyZK1d0
         GhV82j10uB+TzHTXNuxlEu/Lj6/VD+XCer13892vc/VUt1DywGEsymTdU7/bLXKsKRs/
         KI1jwE3q+mhgxfjlPIX7NuBzB1Mnr2YCL7s/nc4RB17hEt1yAqqNub/BMgixyhMrP7US
         JWry/f1vuCZ4l620FkXbozEWvJJos+ocDnb0r2lWzdoBeiaMueA0jDXwcqA1FTmY4sEy
         y+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Ex7G1Dc4ndxqth3h7XLfmdXzkyG8DOXuEtz7dPDbY9o=;
        b=UoMsWiAaOwF/p4fteho75Is+dXVEAkmhkEiH5Y1evVdF+ReiUQL6qI06zGwQGsXAJj
         1Tq+cCzCfa7qeuDciEn/lioY09WOUgtebBddaMqYuXKMg+p4OUERv55SMpVOx07uuqjA
         W7rT8VFIS+yY/cGSGj2KNWdisJxZu5d78LwFyxN5Bo8p6DqXBSxEOO1o/NwPx0Nlm43X
         I7EWAH348F7wQwaDeJW2R2ODe9XJ3ANFu/i3uh+N5YMXpCxvczovN3kYwjZPDcTHI2nt
         Xt0/B83+Ld0/eKe/4iektncGs4UA7gsjcPifywEBSUpa4jEeAlbrvaT7eDwo0L3kfAX3
         Pg1g==
X-Gm-Message-State: AOAM532oF6Iw0RvIZyAn/UcsQWUJl0t3OfiBH4rvNNQs31DXl49VGud9
        jKfWAuE45Fn2kJg0dDZRA45PMlxI/iQ=
X-Google-Smtp-Source: ABdhPJx8AfcKPh3sU8NZ8mEMJsPwQLey+Ia8BQAgNT6iW2mYujG63m995qj9KmylkD8pQyFDfk05ag==
X-Received: by 2002:a17:902:a584:b0:143:c2e3:c4 with SMTP id az4-20020a170902a58400b00143c2e300c4mr44455168plb.69.1638811437531;
        Mon, 06 Dec 2021 09:23:57 -0800 (PST)
Received: from localhost ([2620:15c:289:200:9206:9546:da97:4e9c])
        by smtp.gmail.com with ESMTPSA id lr6sm2908pjb.0.2021.12.06.09.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 09:23:56 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Aleen =?utf-8?B?5b6Q5rKb5paH?= <pwxu@coremail.cn>
Cc:     "Elijah Newren" <newren@gmail.com>,
        "Git Mailing List" <git@vger.kernel.org>,
        =?utf-8?B?5b6Q5rKb5paHIChBbGVlbik=?= <aleen42@vip.qq.com>,
        "Aleen via GitGitGadget" <gitgitgadget@gmail.com>,
        "Johannes Schindelin" <johannes.schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2021, #07; Mon, 29)
References: <xmqqzgpm2xrd.fsf@gitster.g>
        <CABPp-BE4uYBFnb-AgVJhNo6iK4da5hiEFEBhd=7Ea3Ov=4K4zw@mail.gmail.com>
        <d95f092.3f.17d73a85761.Coremail.pwxu@coremail.cn>
        <CABPp-BG9jHaJYekDnvZT+8QW_fLGM_bmz-oOqzJswaotyVDFBA@mail.gmail.com>
        <211203.861r2tsfej.gmgdl@evledraar.gmail.com>
        <CABPp-BGE5Ff=adH3nREMDm38DGLEmtRTcPwuJowHw-ckwpbmqQ@mail.gmail.com>
        <211203.86wnklqx05.gmgdl@evledraar.gmail.com>
        <30b4169a.18.17d8d589b6d.Coremail.pwxu@coremail.cn>
        <xmqqilw2i6w1.fsf@gitster.g>
        <6fa17536.18b.17d8e7c7a09.Coremail.pwxu@coremail.cn>
Date:   Mon, 06 Dec 2021 09:23:55 -0800
In-Reply-To: <6fa17536.18b.17d8e7c7a09.Coremail.pwxu@coremail.cn> ("Aleen
 =?utf-8?B?5b6Q5rKbCeaWhyIncw==?= message of "Mon, 6 Dec 2021 14:44:22 +0800
 (CST)")
Message-ID: <xmqqwnkhhck4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Aleen 徐沛文 <pwxu@coremail.cn> writes:

> The confusing point seems why "git am" stops into the middle and gives
> control back to the user when passing "die". In common cases, "die"
> should stop the whole process, and is it better to distinguish the case
> when passing "die" from the default behaviour? Like what the following
> snippet is implemented:
>
>     case ERR_EMPTY_COMMIT:
>         printf_ln(_("Patch is empty.\n"
>                     "If you want to record it as an empty commit, run \"git am --allow-empty\"."));
> 	die_user_resolve(state);
>     case DIE_EMPTY_COMMIT:
>         am_destroy(state);
>         die(_("Patch is empty."));
>         break;

Sorry, but I am afraid that I still don't get it.  

As we can see, the ERR_EMPTY_COMMIT case already exists and that is
the behaviour we want when we say "create commits from the messages
with patches, stop and give me control back when you see an empty
commit, so that I can decide what to do".  And one of the things you
can do at that point is "am --abort" that causes the am_destroy() to
be called.

That is very much in line with the behaviour the users are used to
see from "git am" when it detects conditions other than "there is no
patch" that needs to stop and give control back to the user,
e.g. when the patch does not apply cleanly or the log message did
not pass msg hook.  am_destroy() is destructive, and limiting such a
destructive operation to "am --abort" would avoid mistakes and
surprises.  I do not know where you got "In common cases, die should
stop the whole" from, but it is not a friendly thing to do to our
users.

Why should the "in addition, stop when there is no patch", which is
what we already handle just fine, needs to become different?  More
importantly, is it worth forcing the users to be aware of the
difference and be extra careful to avoid it?

It is my understanding that the ONLY reason the patch proposes to
add an option other than "skip the step" and "create an empty
commit" is to allow an earlier "--empty=skip" on the command line to
be overridden by a later "--empty=die".  If that option does not
make the command behave identically to "--empty=<anything>" option
on the command line, i.e. ERR_EMPTY_COMMIT case, it does not serve
the intended purpose of overriding the earlier option to revert the
behaviour back to the default.

By the way, I agree with an earlier comment (I think it was from Dscho)
that these names should say "${DO_THIS}_ON_EMPTY_COMMIT"; the above
without "ON" feels somewhat strange.

Thanks.
