Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713D3C433EF
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 23:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D34061B53
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 23:36:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234022AbhKOXht (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 18:37:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347558AbhKOXfs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 18:35:48 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84699C06120A
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 14:30:57 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id z5so18684071edd.3
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 14:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=WXXQTEpf8Xj01N5wLpH1e6cihV0wN6won8mrFs0hIuY=;
        b=PwIwiZUWwSDhxS26MSe8JQEJ6VeonntlWQZ7MhFoiiZr1fhVubKON6dGAQXX1VHPai
         uQj/pqE/ldYhDTvkRzm/7xMwz3AHacUuldFi5pnp2k5rfr6sX1MNjCgq0uhrWssrggzZ
         m9JADvLw3k/MMGCEcCyNlxQve6dgvfEPOMwogCuVr/Hs5AePaJuLwFvmjH7qh9pPVRex
         x7jHC3FsRE5lkSnB4jLS+tRts90mScXGeZWQvDMaZ3I2roLaO331N6DbyWJXXJkb0PJb
         1B4oUUgxPnKUfY6uAAraQijIG4yNsOoVrFF+aDpKtlhQ1trr4BSAb1Sw0GhXfNy2GEEv
         xIfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=WXXQTEpf8Xj01N5wLpH1e6cihV0wN6won8mrFs0hIuY=;
        b=IUx0VU6ZifBcaZ/WkAB4poqHMkVr9szPzUOaW960/9QQripE0qP2SwQZi6GN6Wmtj1
         CCJFVTLjzq459Z0S2+k2npQqFF8wCdsMl7WK7JYqjNLQ8Ey8VY5XmomgeiU5uGA/cKsZ
         LJKWgpr/iEMeewdsci17xiZ6MmbCXL7Z+hjOthmbgWkVkExMWMvrGzbqMyq9vzPlHamU
         VRBXCYXxL91LewGMvb0h966HQQBu/wFWOXoIx8ecNqj2RVAzpfgLvg8pSXb6PfZhOqox
         mrGvT6ypeZ2L/JuMG5G4lrd78F4YF8vOGy7T7jmIKm5CKF428EC+llRq19KahR2WssyW
         5Q3Q==
X-Gm-Message-State: AOAM530w9akztpUQ7NL7SCsClb16mes3Sb2aQDcPJr4HlmA3hc1Yrfst
        7OMWtvv2eotmvH4w3Fukay8=
X-Google-Smtp-Source: ABdhPJz8SR831/zYfZIN7rcOdrbC4a0EME7Uyz3kuD8x71CXwPyd0l4QvlJ1Y5cw32ALjdo3PtdrgA==
X-Received: by 2002:a17:906:6a0a:: with SMTP id qw10mr3020741ejc.547.1637015456037;
        Mon, 15 Nov 2021 14:30:56 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id bo20sm8396283edb.31.2021.11.15.14.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 14:30:55 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mmkV4-001GY4-VA;
        Mon, 15 Nov 2021 23:30:54 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Mike Hommey <mh@glandium.org>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 8/8] hook-list.h: add a generated list of hooks, like
 config-list.h
Date:   Mon, 15 Nov 2021 23:26:36 +0100
References: <cover-0.8-00000000000-20210923T095326Z-avarab@gmail.com>
 <patch-8.8-80aae4d5c13-20210923T095326Z-avarab@gmail.com>
 <20211115220455.xse7mhbwabrheej4@glandium.org>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <20211115220455.xse7mhbwabrheej4@glandium.org>
Message-ID: <211115.86k0h9qcf5.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 16 2021, Mike Hommey wrote:

> On Thu, Sep 23, 2021 at 12:30:03PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> -builtin/help.sp builtin/help.s builtin/help.o: config-list.h GIT-PREFIX
>> +hook.sp hook.s hook.o: hook-list.h
>> +
>> +builtin/help.sp builtin/help.s builtin/help.o: config-list.h hook-list.=
h GIT-PREFIX
>
> hook-list.h is only included from buitin/bugreport.c, so
> builtin/bugreport.o should be the one with the hook-list.h dependency,
> shouldn't it?

Well spotted, yes. This is a mistake. I think from some earlier WIP
version of the series.

In practice we don't really miss dependencies due to these sorts of
mistakes since we use the .depends files, i.e. GCC & Clang figure this
out for us:

    $ grep hook-list .depend/* */.depend/*
    builtin/.depend/bugreport.o.d: compat/compiler.h git-compat-util.h hook=
.h hook-list.h
    builtin/.depend/bugreport.o.d:hook-list.h:

But we do over-depend a bit, if you touch hook-list.h and make
builtin/help.o we'll re-generate it due to this line.

If you or anyone else is more generally interested in the Makefile I'd
really like to get some reviews over at:
https://lore.kernel.org/git/cover-v2-00.18-00000000000-20211112T214150Z-ava=
rab@gmail.com/

I've got some follow-up work that solve these dependencies more
generally, e.g. in this case we should really not need to slavishly
maintain these fallback dependency lists by hand, or have automated ways
of validating their correctness.
