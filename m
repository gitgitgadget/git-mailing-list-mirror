Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D67C5519F
	for <git@archiver.kernel.org>; Mon, 30 Nov 2020 09:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96AB92084C
	for <git@archiver.kernel.org>; Mon, 30 Nov 2020 09:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQIKdb1J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727622AbgK3JUp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Nov 2020 04:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbgK3JUp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Nov 2020 04:20:45 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA966C0613CF
        for <git@vger.kernel.org>; Mon, 30 Nov 2020 01:20:04 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id o1so1121458wrx.7
        for <git@vger.kernel.org>; Mon, 30 Nov 2020 01:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:message-id:references:user-agent:in-reply-to
         :date:mime-version:content-transfer-encoding;
        bh=8iptFlWmwzi5SSR8l5FvxyWbySsF8XM1lYF+X53Yv4s=;
        b=FQIKdb1J6ChJ+ntiUxHV47Ep44hBKjvhLjG0HbNejoym8SNLA1WAWOUSMtmZqgEowb
         YAw306N+xluycBGGGMr2nWEiTXNAMrSNNeeSP2hMst0b/MUyerIqPm7nCZmIrWhlPEVv
         dSNypLPBuh4MWrsVrJuQFn6VzxXAIJaXoeotJgEmVTs81dRiOulDW5hauvjbzqXnnuEk
         MHdKKnVXGJK1Bm5c7sf1LumoFrTIzUY7ydqMFQUvg3CclP5FbT7VOt/WRMD/eP50urhE
         qHcg9zBXTbjiEhzhwPz/JadSuak5qves4HeI3X3lmo0OjC0w5BenmmmR2rj9h8rt8xeD
         pDfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:message-id:references
         :user-agent:in-reply-to:date:mime-version:content-transfer-encoding;
        bh=8iptFlWmwzi5SSR8l5FvxyWbySsF8XM1lYF+X53Yv4s=;
        b=qiZY8M+qZHnjfpNBKwNVKbRLMtpNQ6IYVHEUkCDDC+843lR++pRRlBez3Mai2UBk92
         FhOO3te0SIwkJXM0XLphK3fwX0X7B9+LLvNLqm/N8BchI3WSyp1H7jYaACJ+OeWLatgF
         IaUAYdkpK4yD2KO8kDegMPWAqaEeCHeD7Ch7wsT1BfDcpX/o3jbdkq2UB4RDp9K4Gxyv
         miaIiYp2kRSeB1HGQuFVO2wVdPBhMVmf3CfKVpJYT9K5PT6GTXxNlf5geGyj1DRtR3LS
         6yvBcYYBOaSQKNeRVGjLVnmD0j5fuA7u1i1zBKvs9NYgq81vtFJIUvv4rYHiDNKyHnST
         qRdA==
X-Gm-Message-State: AOAM531dcKvgb9p4fR1PsEKd4B7BqaWIAAZHDeir6ilH0TaSDhqPXGHN
        8xk3JpwPpchAv5R1XNz4p1YXHaZwCr0=
X-Google-Smtp-Source: ABdhPJzayEe8+Evt3YCxlPJUYbj8CdH6EXuauLbHEkchivGyDUByEhd24ZBY8ZvawZwA1x0BY+W1Xg==
X-Received: by 2002:a5d:4585:: with SMTP id p5mr26904582wrq.65.1606728003610;
        Mon, 30 Nov 2020 01:20:03 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id b200sm18488885wmb.10.2020.11.30.01.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 01:20:01 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 0/2] make macOS `git maintenance` test work on Windows
Message-ID: <87blffjkne.fsf@evledraar.gmail.com>
References: <20201130044224.12298-1-sunshine@sunshineco.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 26.3; mu4e 1.4.13
In-reply-to: <20201130044224.12298-1-sunshine@sunshineco.com>
Date:   Mon, 30 Nov 2020 10:20:00 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 30 2020, Eric Sunshine wrote:

> v2 makes the macOS-specific test in t7900 UID-agnostic, as suggested by
> =C3=86var[2], thus the patch which added `test-tool getuid` has been drop=
ped.

LGTM. FWIW I think your v1 is fine too, just meant to comment on the
basis of "you could also do it like that". Having a C program call
getuid() is fine, so is faking it. If you prefer the latter, cool.

As an aside and just because this is fresh in my mind, not really
relevant to this patch as-such:

I did wonder "why not just call perl -e 'print $<' ?"  first. But then
found (by reading the Perl source[1], didn't actually test this) that it
fakes up UID=3D0 for everything on Windows.

I couldn't find any "is root?" in our tree that relies on Perl's $< in a
bad way (the couuple of occurances seem innocuous), we have some "id -u"
checks, but those also seem OK if it returned 0 on Windows (what does it
return?). Seems the worst we'd do there is unintentionally skip some
"skip this as root" tests.

Also as another aside (but your patch is fine as it is), my suggestion
used Perl+Perl RX but you switched it to sed+BRE. Do we want to avoid
"sed -E"? I wondered that for something else the other day, we have
this:

    t/check-non-portable-shell.pl:  /\bsed\s+-[^efn]\s+/ and err 'sed optio=
n not portable (use only -n, -e, -f)';

So maybe it means "nothing but -nef, or maybe "don't use -efn". The ERE
(-E and -r) options aren't mentioned, and a na=C3=AFve log search of of "sed
-E" and "sed -r" in t/ returns nothing.

It's also my impression that just using $("$PERL_PATH" -e ...) is fine,
and at least to my reading the Perl RX is more readable with look-behind
assertions, but I'm biased by familiarity with it.

Our PERL prereq & NO_PERL=3DYesPlease is just for "this may require a
non-ancient Perl" & "don't install Perl for runtime stuff"
respectively. Is that not the case and we'd like to avoid new perl
invocations where possible?

I don't really care either way (or, if your switch in this case was just
a personal preference, also fine), but if we are trying to somewhat
discourage perl use (and maybe eventually get rid of it entirely) that
would be a useful t/README doc update.

I know Johannes (CC'd) has (this is from wetware memory) wanted to
(understandably) not need to bother with Perl as part of GFW, but I
can't remember if that's for a reason covered by NO_PERL=3DYesPlease,
i.e. packaging it up, or whether it's also to not wanting to provide a
perl for the test suite.

1. https://github.com/Perl/perl5/blob/v5.33.4/win32/win32.c#L1079-L1092
