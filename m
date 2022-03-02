Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883BAC433EF
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 19:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234618AbiCBTWW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 14:22:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbiCBTWV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 14:22:21 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E9DCA713
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 11:21:37 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id qt6so5819570ejb.11
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 11:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Sbit2Vc9qXcoK0IRQnohEWFSFev5DA/NGqdEwRzy5co=;
        b=DZoQ+PHf50sDPd1UwjbTtf9ZcT9vIMaksVADPAIlmn8TgVWWfcu2uvot+hAYlFn+uh
         NTDht/V+UbRA8q2LDWADwhpgT5DVlIpPnQW5l93ieXtxDL7BfTjieIdEuLefH9ZteH2B
         8O85yusJho46b2ETcDXRPk8oUfjxZ50sGPgi+hxFAZevYkyefoBb+SXG8QApHPIwuF0q
         gld1x+0IDdxHuzD2M+fAY8wAEBX6+9+HhbQzzGvrAkGwtPsjkWaRwYPceiOc5IPbp5Xd
         92p3vn54jaxvNT3+QxfMIISVwuuITBU4DQS5dYBdGlLUFi58Wq6SZ/3DK0LY/hBNA9R/
         Zd7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Sbit2Vc9qXcoK0IRQnohEWFSFev5DA/NGqdEwRzy5co=;
        b=YPbhIs1/L1MJYNfyZoscJW0kXoxhXMIaT6HtPwS+nYeGx4d+aD5c+SiFust+D4tkMY
         lwW+VgECffIujmKQKUo++OvxZwECywhM3MmWFpLwb+unN5oivgh56P9HtNCIZ7amfN5U
         O2r/B1Mxm5jzq9DO+G5SaonTeJaq+XwrY46tghWKO6jyfbr/shCK8L4ZQDHH8Scr8Biv
         X87VlrwpUQPGGK64wVlvAT3CrAUxNmIT4kA/ca9TBfDvbS6Vlcwly+6+IrwYw6pFqrVA
         +/rwH3swkZrj3Xmxtda5Jzhf5BjmJFxu1Jdu2SnCXpvuPFb7Rmln+WSI0fLHIqsnXjFO
         lr+Q==
X-Gm-Message-State: AOAM530+OUfrbX3tS9HYGyXw6+TXOhQRtKkpIIj6VNd0VRLakfCCiCQS
        JrbkeO1VPjNobHFKLp7/07bZJhsWrpL/TA==
X-Google-Smtp-Source: ABdhPJwIdaJe9KAs6wu0vy8JNY0ShrWcqHjHiN27TknLFc2qhXPEfgSrI6YxbdKBANzqmqs/8kLh2A==
X-Received: by 2002:a17:906:af57:b0:6cf:7f1d:ddd7 with SMTP id ly23-20020a170906af5700b006cf7f1dddd7mr23508337ejb.453.1646248895890;
        Wed, 02 Mar 2022 11:21:35 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id ey10-20020a1709070b8a00b006cee56b87b9sm6651606ejc.141.2022.03.02.11.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 11:21:35 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nPUXW-000JKC-Je;
        Wed, 02 Mar 2022 20:21:34 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [PATCH] parse-options: make parse_options_check() test-only
Date:   Wed, 02 Mar 2022 20:17:13 +0100
References: <xmqqtuck3yv2.fsf@gitster.g>
        <20220228073908.20553-1-chakrabortyabhradeep79@gmail.com>
        <xmqqzgma287n.fsf@gitster.g> <xmqqr17lphav.fsf_-_@gitster.g>
        <220301.86pmn5z5we.gmgdl@evledraar.gmail.com>
        <xmqqo82pnwoc.fsf@gitster.g>
        <220302.86r17k7gry.gmgdl@evledraar.gmail.com>
        <xmqq1qzkmb8q.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqq1qzkmb8q.fsf@gitster.g>
Message-ID: <220302.861qzk6tz5.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 02 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
> [...]
>> So the performance cost is trivial & not worth worrying about.
>
> I already said I am not worried about it, didn't I?  These numbers
> do not matter in this discussion.

Sorry, but I really don't see the point then.

You'd like to keep "git rev-parse --parseopt", but now if you feed bad
input to it you'll get worse error messages from it, and it's not for a
performance benefit then why? Why would we have worse error reporting
without any upside?

Another common case would be locally hacking a command that uses
parse_options(), having it do the wrong thing for some cryptic reason
we'd catch in parse_options_check().

Then eventually remember to turn on this GIT_TEST_* knob (i.e.  if
testing via the command-line/debugger instead of the test suite). I for
one do that a lot when working on the parse_options()-using commands
in-tree, if this land I'll probably remember to add this knob to my
.bashrc, but everyone else will find out the hard way...
