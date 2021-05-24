Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF7ABC04FF3
	for <git@archiver.kernel.org>; Mon, 24 May 2021 16:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDD25613E6
	for <git@archiver.kernel.org>; Mon, 24 May 2021 16:48:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbhEXQtj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 12:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232442AbhEXQtj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 12:49:39 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5425C061574
        for <git@vger.kernel.org>; Mon, 24 May 2021 09:48:10 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id y76so18357640oia.6
        for <git@vger.kernel.org>; Mon, 24 May 2021 09:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=RcYARtkX10ucPQqrhSIUfEoUk9rV17lPQ+M5VGhFBkE=;
        b=tZ5lHu0CwcTN80HLyNBD7S57hlgI4undT7ydjMkifnOTX6u5AMvlaUTIi6zIseEDAF
         lbFra5K1yEySf4KxVUyFOBvYnknknqLlwpHvCQESeAmDz5GsLrSOygFka0LSCivtKnKm
         11zPRnCM0jWfvKj5bWXPp20QkkoVhDm07bpzpe2tF6JIIgigsh0IbDT4aMP2KyriCwFI
         UzbDbFU0QNT5gM3K5S0HjY6HhSEFiDIMRRMwa0vbwp/iNQCdys1/wjOXUYi2Ex1++MEA
         mdWWjX7dLwDLv6jfXOnwd1szAT9WM1k7eNjnfBnnSXFHPAEuphpnscI2OOFPI3QNu0/n
         hpJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=RcYARtkX10ucPQqrhSIUfEoUk9rV17lPQ+M5VGhFBkE=;
        b=tAycG/WHS3pNBcG5u9rcY1tAz6a2IMvShVWY6mJUMgyxFRA/lDYRUx5gev3wMCJ6gG
         nsErsKVeSIIkuboXshRqzGys0GeuOzF6lRHT3qyDzsUUhMxVjaho3PpuaEpWDR5th2TT
         42hYoNKlOu1hw7cNJ7/df6/7a4NpjCl/s6I63DQquhBqy1iRuZ2pdf+dGDXzcMiEwU8r
         b17BlseL16m9Z0dVKYIwll/4N7wZBGCcKrK+C4OCbI8xj4uYkg6E0xB5eTKJbgmKXcX/
         +cNLKqXvLL4ySo2tmprn0XlcLH3p6+rNp9rOnup6u6FG8VdiUjGwbvhjUm52T0bSJSPl
         M1Ow==
X-Gm-Message-State: AOAM530OTdrCW1BSealVpbQklYlSHcxS8qJVOO1S6staH6srS+NTqr2r
        XCcRdgMEFUhYYeParsHK9Do=
X-Google-Smtp-Source: ABdhPJz7y194NtStU4nfJmNPUehu9CyhySQdYkYftow08vIWo5LmLtu/luOzo4TV4aG/UZ7LP2FAIA==
X-Received: by 2002:a05:6808:14c7:: with SMTP id f7mr19947oiw.63.1621874890177;
        Mon, 24 May 2021 09:48:10 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id c32sm3056411otu.13.2021.05.24.09.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 09:48:09 -0700 (PDT)
Date:   Mon, 24 May 2021 11:48:08 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Message-ID: <60abd8c84afed_1b2092087d@natae.notmuch>
In-Reply-To: <87lf84o23t.fsf@evledraar.gmail.com>
References: <xmqqtumyulv8.fsf@gitster.g>
 <60a8352c936aa_55d9020873@natae.notmuch>
 <87lf84o23t.fsf@evledraar.gmail.com>
Subject: Re: What's cooking in git.git (May 2021, #03; Thu, 20)
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Fri, May 21 2021, Felipe Contreras wrote:
> > Junio C Hamano wrote:
> >> Here are the topics that have been cooking.
> >
> >> --------------------------------------------------
> >> [New Topics]
> >
> > Is this not a topic?
> >
> > 1. doc: asciidoc cleanups
> > https://lore.kernel.org/git/20210514115631.503276-1-felipe.contreras@=
gmail.com/

> These were sent around the same time as v2.32.0-rc0 went out.

That's v2 (of the first patch). v1 [1] was sent on May 12. The only
difference is that one chunk of code moved from patch #4 to patch #3. It
was good then.

> Junio tends to not pick up new things around the release freeze.

And yet a patch from May 20 had no problem landing [2]. And another one
from you [3] also from May 20.

They both landed on "what's cooking" the very same day. In fact, the
former 11 hours later.

> I've only skimmed those topics but they seem like sensible fixes, I
> think it's probably best to let discussion on them settle/continue,
> and re-roll or re-send sometime after v2.32.0.

Sure, they don't belong on 'master', but the first patch series is ready
for 'next' (and was ready since v2), and even if it wasn't, 'seen' is
for proposed changes that don't qualify for 'next'.

I think this qualifies as a proposed change. In fact, a proposed change
that has been reviewed, it's simple, and could not possibly introduce an
issue (famous last words); more than can be said of many patches in
'seen'.

Either way, I'm just asking what's going on.

Cheers.

[1] https://lore.kernel.org/git/20210512222803.508446-1-felipe.contreras@=
gmail.com/
[2] https://lore.kernel.org/git/20210520210546.4129620-1-emilyshaffer@goo=
gle.com/
[3] https://lore.kernel.org/git/cover-00.17-0000000000-20210520T111610Z-a=
varab@gmail.com/

-- =

Felipe Contreras=
