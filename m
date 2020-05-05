Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB0EC47247
	for <git@archiver.kernel.org>; Tue,  5 May 2020 16:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6C23206B9
	for <git@archiver.kernel.org>; Tue,  5 May 2020 16:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQvVOJ6A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730372AbgEEQXP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 12:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730282AbgEEQXO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 May 2020 12:23:14 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93805C061A0F
        for <git@vger.kernel.org>; Tue,  5 May 2020 09:23:14 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id v10so1298751qvr.2
        for <git@vger.kernel.org>; Tue, 05 May 2020 09:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=htkygWCgoQYn61F8FVKQjXEyvcXtOuOfY5lxVnR9BSc=;
        b=UQvVOJ6A5wU9oKh+VmdjWShLkxrO8BA197evvXkzCnYkGJrPxPMQg8HT8CP9uFWWmP
         wQhr3TYRMeO/ua4I1yfONCN3qds+0oQWnIJEuG+EfDHVpt/Rgny0lyOlwrqqFX8bLSLm
         RsVzgt+4vHsZn7K1s/QWwb5CbSCd1d1txGgfqzutyJ2ukoEAFgo+o/fQeK2/sq+7Cx5x
         m7y+LSZF7vBGV2ic+g4+1eO1E6Y+kMcWQuE756pxC4Jktt7jDjCBJnoOmC/+VqRW79d5
         p2DWeO9t6VpGFdaMMrnBhAMrEmZXstjTDH2h0wT7Hs6ZtsVsrenUsN5txyupKdWxSVr4
         czEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=htkygWCgoQYn61F8FVKQjXEyvcXtOuOfY5lxVnR9BSc=;
        b=bToi/tk8wPoVpHl+WKqKFmP4401TkUv2Z8ZBjIbSg3s4FRGNSgqbckOQTcKH3apJg/
         lLwNHbsEE4OvvxovRUrDqLHtituj88RTw2OQ7DULnJAQhsRmDF7BdrA+davvozqkPo1V
         GvLDiWLIlX98ScadRMj4vynKGocF0GH9VKF2auxwuS47AuQ/lhzLmyalrGWUC5tqfh27
         aqysiyfpv9oEkBTEQ4horZ3sbnoINthPUHkgxfJ+8IJF/n0YU/GH9pmqFqKb1hJAj4NS
         bBU8tZ1jM3XKYIVAJF9CHKj6FYhZv0Z1jD1mFN0jx16BGC2BCrtfTscz0n7PVnxFKOH7
         oJQQ==
X-Gm-Message-State: AGi0PuaFqp3jBvVzofnX+h71POMz0U0Nb2dpy10wt8J4iqRqscEYZvZE
        J6hg0ysJqQ2IasNJTsM6N7lmnj74JWT6F2UF1q0=
X-Google-Smtp-Source: APiQypKZvWlGwTINwIS9ia6PzP9wRVfU0MxNqcHmcm8BvsJ36tlVpnD7WfVwn0bcL0dffdzvIL2wwpb1xhD4koXNLs0=
X-Received: by 2002:a0c:a692:: with SMTP id t18mr3571903qva.56.1588695793867;
 Tue, 05 May 2020 09:23:13 -0700 (PDT)
MIME-Version: 1.0
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
 <xmqqv9lod85m.fsf@gitster.c.googlers.com> <CAKiG+9V_nZUXf2a689vZ54rG+xTCFMGcJe_7Av-khaxxuijERg@mail.gmail.com>
 <xmqq8sikblv2.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2004251354390.18039@tvgsbejvaqbjf.bet>
 <20200427200852.GC1728884@coredump.intra.peff.net> <20200427201228.GD1728884@coredump.intra.peff.net>
 <20200428135222.GB31366@danh.dev> <20200428210750.GE4000@coredump.intra.peff.net>
 <CAKiG+9U2Eg5yvT4XjgpMUXu4OV-8JF9Hp_ou_P6twxfqJ1tEYA@mail.gmail.com>
 <nycvar.QRO.7.76.6.2005012130010.18039@tvgsbejvaqbjf.bet> <CAKiG+9UvnLtF7eS9FsPLyRR4ZPNSnakZwyYy3dO7WoAnRpvoMA@mail.gmail.com>
 <xmqq4ksyl4mz.fsf@gitster.c.googlers.com> <CAKiG+9Vvwz_ajhJ1KPVWtq25UaGtJOH57eXTA=cgm5qzoZCfGw@mail.gmail.com>
 <xmqqsgghhr32.fsf@gitster.c.googlers.com> <689741588534833@mail.yandex.ru>
 <nycvar.QRO.7.76.6.2005041630150.56@tvgsbejvaqbjf.bet> <848941588629532@mail.yandex.ru>
 <CAKiG+9Xu+eeET1Y3hFJTSpofxBCWEvwjyaY0cjFbKptzYLACNw@mail.gmail.com> <xmqqwo5qc3ec.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqwo5qc3ec.fsf@gitster.c.googlers.com>
From:   Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Date:   Tue, 5 May 2020 21:53:01 +0530
Message-ID: <CAKiG+9WzQdFa1qM4dKUu8O7k+Q8JGsDMGQg-2GRJr=AJye6wJg@mail.gmail.com>
Subject: Re: [PATCH 0/8] CMake build system for git
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Konstantin Tokarev <annulen@yandex.ru>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Danh Doan <congdanhqx@gmail.com>,
        Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi there,

I have made the following changes as suggested:
1) The CMake script works from contrib/cmake now.
2) The CMake script parses the Makefile for
SCRIPT_SH
SCRIPT_PERL
TEST_BUILTINS_OBJS
LIB_OBJS
BUILTIN_OBJS
XDIFF_OBJS
VCSSVN_OBJS
3) Philip suggested to change the error message if sh/bash was not
found on windows.
4) CMake now tests for ICONV_OMITS_BOM, NO_ST_BLOCKS_IN_STRUCT_STAT.

Regarding the commits, since 1,2,4 are additions to the script, is it
acceptable for those changes to be staged in the next commits?
Regarding the workflow file(main.yml), I modified the vs-build and
test steps, should I drop the commit or should I keep the changes(a
modification is further needed if CMake is going to be used for
vs-build)

Thank You,
Sibi Siddharthan
