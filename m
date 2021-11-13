Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E02C433F5
	for <git@archiver.kernel.org>; Sat, 13 Nov 2021 10:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2216461057
	for <git@archiver.kernel.org>; Sat, 13 Nov 2021 10:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234951AbhKMKEM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Nov 2021 05:04:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbhKMKEL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Nov 2021 05:04:11 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CCCC061766
        for <git@vger.kernel.org>; Sat, 13 Nov 2021 02:01:19 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id b15so47715758edd.7
        for <git@vger.kernel.org>; Sat, 13 Nov 2021 02:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Dd6zj6dGzb49+QRQFKxwy1RPAdTzZgsiJEKuXK4H3fA=;
        b=NN0iab0pdMFa07XkY0aH07mWSAIMdF9AC6DofOpXW3AHRt2Y1YkdT+GQaxeE8//k3K
         pBJ9n0cR3DEcH7qr+ABPmjCeaztkhCU11V8vIDbdcuyXKEY+cDf905rtaeN/ge442fxY
         m3E3tfhBoc1+R7TSp+PpLOrCMRQu9HeDu58IBVMh2qTH4uLSm5gSuEgGOw5gm3RfmCms
         6mcowPFHZ8JHhZwWzatnPb60ewQCb4NKaYW2bczbmuX6Xu9rPgfyt46flscBU7FiFsHf
         N1YoED++GQVYJBl4Oy5ZAAjQzrQEZ3bSY/urk2/ybqGhDjwg6UMGM0KXb9zqkpFfuaCn
         G3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Dd6zj6dGzb49+QRQFKxwy1RPAdTzZgsiJEKuXK4H3fA=;
        b=EcEpAz8jsMMuku4SUzBkZkyuaKo5X+9bEZZe5TEQb5p7dmnCgJlnFQB+hzkmSuowp0
         XkgDpX3gmkZPqlhcXJJtwAZACWUsxvsHd0EN++OcnbJlpIPjhFC+fTFn/MIErGLCMxTQ
         5PgaOGQFvLpwwbJLvgmZv/utG16igZXVMhQNSqziGbX/fWWXrveHG+bE7lc7QFEczv+Z
         5nFLiv+f4NLLQkSX1SbTv8q3FqcE6VSLlFlF/KTLQUYRa3okIlugGsdQLsBh+y4FAG2c
         4+4RAj5UDTSfA60N8lnZFwLfD450Y3eTXtKvUgWLAld42RhywF4bOy0Ex1VAxXzgFH1Y
         HFOQ==
X-Gm-Message-State: AOAM532KLVCyrWtWmGouvGYhigI2TvOytHRzHlyYsFulbKny7kpbpBc4
        XS3Mx+Zgtn5swQinKC5sd60=
X-Google-Smtp-Source: ABdhPJy/9FajGtdw0h4TcRBakQpyl96hWfwen+3JrAjCUmXWWoqnQ4Q/fQlZgxnl7+ihtBACfD2Z/w==
X-Received: by 2002:a17:907:2d20:: with SMTP id gs32mr28172561ejc.270.1636797677761;
        Sat, 13 Nov 2021 02:01:17 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id hx14sm3486348ejc.92.2021.11.13.02.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Nov 2021 02:01:17 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mlpqW-000bJY-OR;
        Sat, 13 Nov 2021 11:01:16 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 7/8] grep: simplify config parsing, change grep.<rx
 config> interaction
Date:   Sat, 13 Nov 2021 10:55:04 +0100
References: <cover-0.8-00000000000-20211106T210711Z-avarab@gmail.com>
 <cover-v2-0.8-00000000000-20211110T013632Z-avarab@gmail.com>
 <patch-v2-7.8-140a7416223-20211110T013632Z-avarab@gmail.com>
 <xmqqpmr5qj0f.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <xmqqpmr5qj0f.fsf@gitster.g>
Message-ID: <211113.86lf1stlw3.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 12 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
> [...]

I'll try to reply to all the rest of the feedback, just really quick on
this, because I think it might represent a bit of a gordian knot.

> Another thing I have trouble with is your mention of "keep working".
> Are you proposing to deliberately break what is working as users
> correctly expect?  Why?

Yes, I'd like to change the behavior, because it makes the grep API much
easier to deal with, and beacuse I think it impacts nobody in practice.

The real goal for this series is that I've got pending patches to
speedup diffcore-pickaxe massively by moving it over to PCRE & drop the
kwset.c code. An old perf test I dug up for that is in [1].

To do that I needed to re-use the bits of grep.c machinery that deal
with setting up patterns, dealing with BRE,ERE,PCRE etc. elsewhere.

I *can* do that in a different way, but it's going to be much easier if
we can gradually evolve the already working grep API to become an
internal textual pattern matching API. Eventually I'd like to move all
of regcomp()/regexec() over to such a thing, because we can for any
other ranodm thing we use regexes for get speedups by using PCRE (and
optionally use its interface to understand BRE/ERE syntax).

The alternative is to split that part off from grep.c, which is a bit
more painful, or to have the init bits etc. take some "no config doesn't
go first", "no it goes first" flags just to support this one API user.

So it would be generally useful to know if you're at all open to
that. Reading between the lines in some other comments I fear that it
may be a "no" except if we mark it as deprecated, wait some years, maybe
remove/change it then etc.

1.

    GIT_TEST_LONG=3D GIT_PERF_REPEAT_COUNT=3D10 GIT_PERF_MAKE_OPTS=3D'-j8 U=
SE_LIBPCRE=3D1 CFLAGS=3D-O3 LIBPCREDIR=3D/home/avar/g/pcre2/inst' ./run ori=
gin/next HEAD -- p4209-pickaxe.sh
    Test                                                                   =
   origin/next       HEAD
    -----------------------------------------------------------------------=
-------------------------------------------
    4209.1: git log -S'int main' <limit-rev>..                             =
   0.38(0.36+0.01)   0.37(0.33+0.04) -2.6%
    4209.2: git log -S'=C3=A6' <limit-rev>..                               =
        0.51(0.47+0.04)   0.32(0.27+0.05) -37.3%
    4209.3: git log --pickaxe-regex -S'(int|void|null)' <limit-rev>..      =
   0.72(0.68+0.03)   0.57(0.54+0.03) -20.8%
    4209.4: git log --pickaxe-regex -S'if *\([^ ]+ & ' <limit-rev>..       =
   0.60(0.55+0.02)   0.39(0.34+0.05) -35.0%
    4209.5: git log --pickaxe-regex -S'[=C3=A0=C3=A1=C3=A2=C3=A3=C3=A4=C3=
=A5=C3=A6=C3=B1=C3=B8=C3=B9=C3=BA=C3=BB=C3=BC=C3=BD=C3=BE]' <limit-rev>..  =
     0.43(0.40+0.03)   0.50(0.44+0.06) +16.3%
    4209.6: git log -G'(int|void|null)' <limit-rev>..                      =
   0.64(0.55+0.09)   0.63(0.56+0.05) -1.6%
    4209.7: git log -G'if *\([^ ]+ & ' <limit-rev>..                       =
   0.64(0.59+0.05)   0.63(0.56+0.06) -1.6%
    4209.8: git log -G'[=C3=A0=C3=A1=C3=A2=C3=A3=C3=A4=C3=A5=C3=A6=C3=B1=C3=
=B8=C3=B9=C3=BA=C3=BB=C3=BC=C3=BD=C3=BE]' <limit-rev>..                    =
   0.63(0.54+0.08)   0.62(0.55+0.06) -1.6%
    4209.9: git log -i -S'int main' <limit-rev>..                          =
   0.39(0.35+0.03)   0.38(0.35+0.02) -2.6%
    4209.10: git log -i -S'=C3=A6' <limit-rev>..                           =
        0.39(0.33+0.06)   0.32(0.28+0.04) -17.9%
    4209.11: git log -i --pickaxe-regex -S'(int|void|null)' <limit-rev>..  =
   0.90(0.84+0.05)   0.58(0.53+0.04) -35.6%
    4209.12: git log -i --pickaxe-regex -S'if *\([^ ]+ & ' <limit-rev>..   =
   0.71(0.64+0.06)   0.40(0.37+0.03) -43.7%
    4209.13: git log -i --pickaxe-regex -S'[=C3=A0=C3=A1=C3=A2=C3=A3=C3=A4=
=C3=A5=C3=A6=C3=B1=C3=B8=C3=B9=C3=BA=C3=BB=C3=BC=C3=BD=C3=BE]' <limit-rev>.=
.   0.43(0.40+0.03)   0.50(0.46+0.04) +16.3%
    4209.14: git log -i -G'(int|void|null)' <limit-rev>..                  =
   0.64(0.57+0.06)   0.62(0.56+0.05) -3.1%
    4209.15: git log -i -G'if *\([^ ]+ & ' <limit-rev>..                   =
   0.65(0.59+0.06)   0.63(0.54+0.08) -3.1%
    4209.16: git log -i -G'[=C3=A0=C3=A1=C3=A2=C3=A3=C3=A4=C3=A5=C3=A6=C3=
=B1=C3=B8=C3=B9=C3=BA=C3=BB=C3=BC=C3=BD=C3=BE]' <limit-rev>..              =
     0.63(0.55+0.08)   0.62(0.56+0.05) -1.6%
