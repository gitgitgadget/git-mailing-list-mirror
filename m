Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 392C11F732
	for <e@80x24.org>; Sun,  4 Aug 2019 07:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbfHDHn3 (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Aug 2019 03:43:29 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39012 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfHDHn3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Aug 2019 03:43:29 -0400
Received: by mail-io1-f66.google.com with SMTP id f4so161249241ioh.6
        for <git@vger.kernel.org>; Sun, 04 Aug 2019 00:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=m1L44YB6V78kLfBDieBdYHW3V3kLFAgGm5uIlWcXXqc=;
        b=e33gYbG26vY8Og0IxWe73JurQJjcSleWC1GsEmhBrArcFSovSKe8/Jk7jGNmrCAzsG
         99LfCpun+PJgddh201wI5sUH9IEAI+3nfud/ZAK2GHcpMdWCgBDrQOTjJ4u3/xZB5Pzi
         Ji+1DdLfM5OwZxM8EqGrddUD9ZnAHvoI7xk2aI8ZCvj8I+D716bBXqwt2ogOmdI6ifC/
         HgpKrfgRlHO1avpKZWwFRO+U7VAHgtB+ZqmDbw0gLYTbQUkglQc0klMOoro3VKFwqgiR
         JDD070Cx/i9tKTq3+nY/r2V0EDamgg97aeaYtj4T+j+zXJa4zsd0ipW37Y2pgv/OLa6O
         bDrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=m1L44YB6V78kLfBDieBdYHW3V3kLFAgGm5uIlWcXXqc=;
        b=V1lGvUydtzi7qMYLNxhlKK2XEabV0Y6IMMZnl2oPz13in8RkYEXvZSFbiiH3eoxNoP
         c4zTP4XIJZITlSjaieJxq58HlJoM5Njs64Wkq5gCtYuLAdeCbE6ag423XEWMqOskzIJ+
         sVCZ4Xw/QIGkXTA9uPrxanzZIIavyeXvz7yTCZgaSIgX0zgp5VXjRCPulDAAcxK1lVUi
         v2Dlg7B//3g6XpSLv7EDZcbRFgdFxKfrqaghBj5EitusVyY0h8GFRlgc9ZonD3JoRjI/
         1uVsAk6nPoSfmUqR4TisSrq7+QYTTEJrtSYwmTkqE1BySNaoNxg/Sb2nQ3h/m7lQf9mN
         NxGw==
X-Gm-Message-State: APjAAAUEmmX7V5TgZFjiqrcVf/5KRIfxUls3Hcjsc/DYDWY5459GVcT0
        X4DJACQzL7uhGrhOv6q/kTrSk1khiidrYETnMT8xoVSGIOs=
X-Google-Smtp-Source: APXvYqyeNTSP+F0VsgUUo6dP+PGECvZFz2YNShZRc9ZsIuaVOKQsrFMcS6pAp4WO4IPld5YkTjWJoIe8ZxX8YSeucoM=
X-Received: by 2002:a5e:cb43:: with SMTP id h3mr6432373iok.252.1564904608362;
 Sun, 04 Aug 2019 00:43:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190729105955.44390-1-carenas@gmail.com> <20190804031409.32764-1-carenas@gmail.com>
In-Reply-To: <20190804031409.32764-1-carenas@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Sun, 4 Aug 2019 00:43:17 -0700
Message-ID: <CAPUEspjOtzFxDLrQzLLU7+Q6Z6V8P0=qNrH2NrOzL7Q884krrQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3] grep: treat PCRE2 jit compilation memory error as
 non fatal
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, gitster@pobox.com,
        l.s.r@web.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PROs:
* it works (only for PCRE2) and tested in OpenBSD, NetBSD, macOS, Linux (De=
bian)
* it applies everywhere (even pu) without conflicts
* it doesn't introduce any regressions in tests (tested in Debian with
SElinux in enforcing mode)
* it is simple

CONs:
* HardenedBSD still segfaults (bugfix proposed[1] to sljit/pcre)
* warning is noisy (at least once per thread) and might be even
ineffective as it goes to stderr while stdout with most the output
goes to a pager
* too conservative (pcre2grep shows all errors from pcre2_jit_compile
should be ignored)
* no tests

Known Issues:
* code is ugly (it even triggers a warning if you have the right compiler)
* code is suspiciously similar to one[2] that was rejected, but
hopefully commit message is better
* code is incomplete (PCRE1 has too many conflicting changes in flight
to attempt a similar fix)
* there are obvious blind spots in the tests that need fixing, and a
lot more testing in other platforms/architectures
* git still will sometimes die because the non fast path has UTF-8 issues

I still think the pcre.jit flag knob might be useful to workaround
some of the issues detailed in CONs but probably with a different
definition:
unset -> fallback (try JIT but use interpreter if that didn't work)
false -> don't even try to use JIT
true -> print warning and maybe even die (if we really think that is useful=
)

some performance numbers below for the perl tests

with JIT enabled (in non enforcing SELinux)

Test                                            this tree
---------------------------------------------------------------
7820.3: perl grep 'how.to'                      0.56(0.29+0.60)
7820.7: perl grep '^how to'                     0.49(0.29+0.54)
7820.11: perl grep '[how] to'                   0.54(0.39+0.51)
7820.15: perl grep '(e.t[^ ]*|v.ry) rare'       0.60(0.45+0.58)
7820.19: perl grep 'm(=C3=BA|u)lt.b(=C3=A6|y)te'          0.58(0.30+0.61)

with "fallback to interpreter" (in enforcing SELinux)

Test                                            this tree
---------------------------------------------------------------
7820.3: perl grep 'how.to'                      0.64(0.59+0.56)
7820.7: perl grep '^how to'                     1.83(2.91+0.56)
7820.11: perl grep '[how] to'                   2.07(3.33+0.61)
7820.15: perl grep '(e.t[^ ]*|v.ry) rare'       2.89(4.91+0.66)
7820.19: perl grep 'm(=C3=BA|u)lt.b(=C3=A6|y)te'          0.78(0.86+0.55)

[1] https://github.com/zherczeg/sljit/pull/2
[2] https://public-inbox.org/git/20181209230024.43444-3-carenas@gmail.com/
