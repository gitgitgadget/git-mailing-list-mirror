Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A22C22096B
	for <e@80x24.org>; Fri, 31 Mar 2017 21:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932868AbdCaVX6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 17:23:58 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:36376 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753430AbdCaVX4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 17:23:56 -0400
Received: by mail-io0-f174.google.com with SMTP id l7so47389091ioe.3
        for <git@vger.kernel.org>; Fri, 31 Mar 2017 14:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=qGy+B8YMc3ecDhfO8d02ke+rZzodViP/V3iJi3AD3Yc=;
        b=nRHkpd0qIyVDek8+kpSjwJ5+ucWcvTfNO3z50Ez1bm+iBeq64RbUCpha4HUImLUWzk
         wAA7MfGGSuTqCdYqhuLZp6DfISKfAbt1hF5yILmVOBYYaGTDz6iK326rnhTkEfhVog6f
         i4p5GFI8LgGg3/EomzcSF/T3RebmIWM+8mVj5KjOwZoaFc9nA1NsvW+1iipnKP54AzWu
         uIbx9XHiCAJv/+JVZZWzbeRxudgecI843r2f6S34434yxKUMOiNIkhDhjyLNtxgMLMDD
         0cZzpl46bYmdY8+OEyokJuslbLixmI546B62JapjQGRyymjEjQTm8C0RMd9iwCktAxrP
         UDgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=qGy+B8YMc3ecDhfO8d02ke+rZzodViP/V3iJi3AD3Yc=;
        b=fFkCD2GBPqh1W/jJj9QZpkXtRblDP60FPiKPI++lgLtO8pe5N8VuTZd7iuKygPDfua
         1l2pYSFkd4zs1xABeJk8GowlFj6CkR1UHg39rTWtAqi+4zizuJY2G3rR+BWqV0MyECek
         mERvODTfGpNHohmxTfEr6AoWXSBQHAuEdmcBdSHJvAuQtXQ1LpuFEuiOR/6azLjnKXqX
         b0Z8TRTJ6kMh9tXUnOW/zRlA1XQj9eCrjUoeoZxEOKq/+WksWS1ugkvld3FbPHxmuTU8
         lU76/4m9W36IycWRDUDznvXy5MoX30g5Z+0fr5XGsldAB0NXgAcVUtu0/MR+g+1zfv6A
         udKA==
X-Gm-Message-State: AFeK/H09KyQn6bysBBiOZreiCuAasArTL7F1ztNvC68jvX5rY7RRGgX/EX9x3LzZEVf2UNuDmV6WycLajo/Aog==
X-Received: by 10.107.34.68 with SMTP id i65mr6046976ioi.147.1490995435448;
 Fri, 31 Mar 2017 14:23:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Fri, 31 Mar 2017 14:23:34 -0700 (PDT)
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Fri, 31 Mar 2017 23:23:34 +0200
Message-ID: <CACBZZX6FcHcY7cYs6s_pv=E43cHNmzyUY5wrcuhPWWmUixCL+g@mail.gmail.com>
Subject: Very promising results with libpcre2
To:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Jeffrey Walton <noloader@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The recent libpcre2 got me interested in seeing what the difference in
v1 and v2 was.

So I hacked up a *very basic* patch for libpcre2 that passes all
tests, but obviously isn't ready for inclusion (I searched/replaced
all the v1 usage with v2). I'm not even bothering sending this to the
list since discussing the patch itself isn't the point:

https://github.com/avar/git/commit/414647d88dd9c5

Before that patch, running a test[1] on linux.git where I grep the
whole tree for a fixed string / simple regex with POSIX regexes & PCRE
(all the greps match the same few lines) gives:

      s/iter    rx   prx fixed
rx      2.20    --   -2%  -34%
prx     2.17    2%    --  -32%
fixed   1.46   51%   48%    --

I.e. fixed string is fastest, and both POSIX regcomp() & pcre v1 are
~30% slower than that, with no difference in performance between the
two. Now with my patch above with pcre v2 there's a notable
performance difference:

      s/iter    rx   prx fixed
rx      2.18    --  -16%  -33%
prx     1.84   19%    --  -20%
fixed   1.47   48%   25%    --

We've gone from ~30% slower to ~20% slower for PCRE with v2. But now
let's test that with this patch:

https://github.com/avar/git/commit/4b7e5da3606c0b9b12025437de8005f5fa07ff54

That enables the new JIT support in pcre v2:

      s/iter    rx fixed   prx
rx      2.19    --  -33%  -44%
fixed   1.47   49%    --  -17%
prx     1.22   79%   20%    --

Now it's PCRE that's 20% faster than our currently fastest grep
codepath that searches for a fixed string, and in absolute terms it's
around 50% faster than the current PCRE implementation.

This is on Debian testing with both PCRE libraries installed via
packages, 8.35 & 10.22 for v1 and v2, respectively. Both are the
second-latest[2] point releases for their respective versions.

As far as turning this into a patch goes there's a few open questions:

* PCRE itself supports linking to v1 and v2 in the same program just
fine. Should we provide the possibility to link to both, or just make
the user choose? If these performance numbers hold up preferring v2 is
definitely better.

* The JIT is supposedly a bit slower if you're not doing a lot of
matching, although I doubt this matters in practice, but whether to
use it & a few other options could be controlled by some config/CLI
option. I think it probably makes sense just to always use it if it's
there pending some cases where it makes performance worse in practice

As an aside I started looking into this because I'm interested in
eventually hacking up something that makes every user-facing
regcomp()/regexec() we have now (e.g. log -G) accept PCRE as well.

How do do this in all cases isn't very obvious, we could just have
some global config option, but there's lots of stuff like e.g.
"<rev>^{/<regex>} & "git show :/<regex>" that takes regexes, and e.g.
how to pass a /i flag to some of these isn't obvious at all.

The solution I'm leaning towards is to just make stuff like thath only
work under PCRE, via the native (?<flags>:<pattern>) facility. E.g.
this now works:

    git grep -P '(?xi: h e l l o)'

1. PF=~/g/git/ perl -MBenchmark=cmpthese -wE 'cmpthese(20, { fixed =>
sub { system "$ENV{PF}git grep -F avarasu >/dev/null" }, rx => sub {
system "$ENV{PF}git grep avara?su >/dev/null" }, prx => sub { system
"$ENV{PF}git grep -P avara?su >/dev/null" } })'
2. https://ftp.pcre.org/pub/pcre/
