Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1127F20954
	for <e@80x24.org>; Wed, 22 Nov 2017 14:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751329AbdKVO1X (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 09:27:23 -0500
Received: from mail-qk0-f176.google.com ([209.85.220.176]:36997 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751307AbdKVO1W (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 09:27:22 -0500
Received: by mail-qk0-f176.google.com with SMTP id 136so16943365qkd.4
        for <git@vger.kernel.org>; Wed, 22 Nov 2017 06:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+skd2debS7k6DJEwO1MBZK3nNCC5nx5C13eoxZIi58E=;
        b=l8c1lvK6N/yDZ99cujJ2xXsihItEXoM4Ej+0qjd3m1UnWsb5ifNt7KWPy9oHojypao
         C+z7XwdyRTfQtm20VY4HEnD7A3qjMnSkJK3XnJ/MXPvcYJpNEFX++nBYenOqFY8rZi4z
         wPlLGkLWtI3Yjrrpt/pkTZzWkEeAWMfXVd/oPejH6+8YEQupi1bnfa9Uy43O3Y4VxBEz
         H6FK0he69EhK+Emw5df0wBRQs96Is05RPMA5NhXj7ihSzfATAVUsn33gNiX8vaoqPD/C
         yHNzFQZv0G+SCm2/hVRHSvoKpQsACj2P7BlkupWKaaidLlrWlhiXuMnoXFt29SYt5DuV
         irDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+skd2debS7k6DJEwO1MBZK3nNCC5nx5C13eoxZIi58E=;
        b=aZOYO0bwVAPsgNgzomwENICok2pcmL1AdGSMR4Lr5qJyvkt8+zxeo/jqjH3itfDzsE
         B6JwWgtuqMdDpTL/tCmIyPeKyf9rqLG96peXoa/Tx9CZaZDJ0YATLDr3yxTY0IrUgXBE
         Rj+TH5D7msdkbgPx3Wa58SN9YqaV/3XyqpSYxPWWZhGeUX9biBtT2wV9exc9jBbWZ4YH
         UiNQNis2kHq9QdA1UFiIus8wuyUaixEOHwM1OHbdEgkTFLYyGqL73h/l2LVrz6AjL0yA
         szxYdqvR8hVxgkpOmqGGxTuldoDyfXjwypCdP3GsdjAW/SOByMBUhJ8csZei34k44Lq2
         dgiA==
X-Gm-Message-State: AJaThX68wUgkp5azK2c+H+XNMnRcXguDnPIA452o3cU946qQhiNWm2lL
        d9lJ6pR1f/o1fEzHojPRzbo2jg==
X-Google-Smtp-Source: AGs4zMbCRU8Gqk1C7jLFVR+9QiMGoXKiFuokx0anDKZjTVwnTodmGgUTIoreQTAqQhPa0WwKw1yrBQ==
X-Received: by 10.55.20.105 with SMTP id e102mr33104520qkh.89.1511360840490;
        Wed, 22 Nov 2017 06:27:20 -0800 (PST)
Received: from dnj.pit.corp.google.com ([2620:0:1019:0:5840:7173:18ff:ed41])
        by smtp.gmail.com with ESMTPSA id t28sm3724938qtb.83.2017.11.22.06.27.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Nov 2017 06:27:18 -0800 (PST)
From:   Dan Jacques <dnj@google.com>
To:     avarab@gmail.com
Cc:     Johannes.Schindelin@gmx.de, dnj@google.com, git@vger.kernel.org,
        gitster@pobox.com, pasky@ucw.cz
Subject: Re [PATCH 1/1] exec_cmd: RUNTIME_PREFIX on some POSIX systems
Date:   Wed, 22 Nov 2017 09:27:17 -0500
Message-Id: <20171122142717.15852-1-dnj@google.com>
X-Mailer: git-send-email 2.15.0.chromium12
In-Reply-To: <87efoqwm3x.fsf@evledraar.booking.com>
References: <87efoqwm3x.fsf@evledraar.booking.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 22 Nov 2017, Ævar Arnfjörð Bjarmason wrote:

> > The latter case concerns me here. If the "Config" module is loading local
> > system paths, then the relative pathing between "$Config{installsitelib}"
> > and "$Config{siteprefixexp}" may not be consistent between systems, so an
> > archive built from one system may not have a compatible relative
> > directory structure when resolved with the Config module on another
> > system.
>
> I don't see how this is different from any other option we build git
> with. When we dynamically link to e.g. PCRE under RUNTIME_PREFIX*=Yes
> you can move the installed git from /tmp/git to /tmp/git2, but it'll
> still expect the specific version of the *.so libraries to be in
> /usr/lib or whatever.

PCRE brings up a good point. When I build Git for Chromium, I am actually
statically linking in PCRE and most other runtime dependencies, so this
is the sort of portability that I am targetting. The set of configuration
options for full static linking, however, are too use-case-specific to build
into Git, so this patch set merely seeks to fundamentally enable
relocatability as an option for users to customize as they need.

> Similarly we under the default MakeMaker path add the perl version to
> the directories we have, you can move git from /tmp/git to /tmp/git2 no
> problem, since that won't change the perl version, but if you upgrade
> the global perl itself from 5.20 to 5.24 you'll need to re-build.

As you note below, the Git PERL code below, doesn't include any compiled
binary files. As far as I can tell, it's highly portable, with no real
dependencies outside of PERL 5. To that end, I very much do want to
transplant a Git distribution built on Machine-A w/ PERL 5.20 and dump it
onto Machine-B w/ PERL 5.24 and have things work.

My inclination is to follow your previous advice and export an installation
path to MakeMaker. I found that "INSTALLSITELIB" did what I wanted.

My working version exports a version-neutral installation path,
"$(prefix)/share/perl5", to MakeMaker. I can then hard-code that relative
path into the PERL header and use it for resolution, similar to what my
previous patch is doing. NO_PERL_MAKEMAKER emitted a neutral library path,
"$(prefix)/lib", and that was one of the things that made it an appealing
option in my previous patch, but prescribing the path also works fine.

At the end of the day, we're hard-coding "instlibdir" into the generated
header, so it doesn't *really* matter if we use "$(prefix)/share/perl5/5.2.4"
or "$(prefix)/share/perl5"; however, as a matter of preference, I would like
to avoid naming the build system's PERL version into the deployable bundle
when RUNTIME_PREFIX_PERL is set, so I'd opt for the latter.

> [...]
> If it's not neede dwe can just do "$p/lib".

ATM my working code does (pseudocode and filling in values):

1) $gitexecpath = "libexec/git-core";
2) $perllibpath = "share/perl5"
3) Assert that $FindBin::Bin ends with $gitexecpath (or die).
4) Strip $gitexecpath, result stored as $prefix.
5) Use File->concat($prefix, $perllibpath);

This behaves similarly to how the C code resolves things, and seems adequate
for this purpose.

> Having said the above, I don't understand why we're using MakeMaker at
> all and I think we should just get rid of it.
>
> I think the best way to proceed is probalby to just start getting rid of
> the perl/* make stuff as discussed above.
>
> Is that something you're interested in / have time for, otherwise I
> could see if I could find some time, but I don't have a lot these days.

Once thought on why MakeMaker may have value is that third-party PERL
tooling may want to import Git's PERL libraries. If this is something Git
supports, we probably need something like MakeMaker to know where the system
PERL library installation path is so it can put the Git library in the right
place in standard (non-RUNTIME_PREFIX_PERL) installations.

I agree that it shouldn't block this effort. My general judgement tends to
be that that a patch set should not sway far from a single purpose, else
it becomes hard to review and/or revert if it is problematic. Removing
MakeMaker seems like an independent cleanup task, so I'd inclined to do
that work in a separate patch set.

Having dived this deeply into things, I wouldn't mind working on this if a
block of time presents itself. Is there an issue tracker that the Git
project uses where I could add this as a backburner/cleanup task, so it's
not forgotten? Would it be appropriate to add a "TODO" comment in
"perl/Makefile"?

> [...] I could see if I could find some time, but I don't have a lot these
> days.

Thanks again for taking the time to work this out with me.
-Dan
