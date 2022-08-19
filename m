Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DB7C00140
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 01:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239103AbiHSBoX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 21:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbiHSBoW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 21:44:22 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D0BD21EB
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 18:44:19 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id a15so2446778qko.4
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 18:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=b6ZETf3lUpmci98ay49ke4qW9yx5KfMtrfpSCR29r6w=;
        b=lp8PGiK8ympCS9nG1/sAiVtDcFMOyGLGSYikLY0DslgA9h13gM1Y7hjxWgymzpwHfi
         ROpT7XZxl70MnPJYlZCDg5ncRAcWjePednZ0rwCynNWEJDdVtyiG3dkU/THvnB0Uv/pT
         N+upRfV6GcZIs5aw0wXZ1+zhwA9STmuEK3N9ZkxIB3LHyfwTGNjGRJGziFjDh+WxYAPy
         1uQxXyKFLfj98MZ7dPx0IhQIkBNH1k/AZ/AMBWeCMbI0f8dURTmvtgfKFQWcH01jcIQ0
         90jOGKASWA9vzSgseduu1KYzPcmAyUzVePMzdjmzZxn5g3wBIpMdxmOxa4ZEGBD3JBH3
         E2Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=b6ZETf3lUpmci98ay49ke4qW9yx5KfMtrfpSCR29r6w=;
        b=IDLdKzwMNMpUNMlS5nle3eb91eoi9lIL8OHOOhsyzvXh6HwI537A1DH7HUZ9oSKvI6
         EHXIwvO+WoSe2AfzvgC4wLQzQJOYF25+vOdXFcHiv/8rdICFsIJu0mruwYe62z7531Kr
         1aBObbPwqOVDrZ45ye74v3RNDHPv7cfZM4P2NWa4maTwYL94SP4aM/lOTv9LQvw6Czlt
         Ib9RWM2q7+SDIH0XsXmPkpRySss4NWcljlvFIaDX0gPJWTvM2zi2kvs3a9epPVBNl5zM
         KmpaSzkI8w1tmSLM3LoeG0ZmOq1gXh3N0UMf+M2vbmOaY1y0iqK1l9hLSi05GM7OdCau
         l/ZQ==
X-Gm-Message-State: ACgBeo1HNRdi+JTKLqbW5RUQA11S7dyax40qGkMPZtQdWK803CsJSsSb
        Dc3Cvxhhee5gWvD1jmLSjkwYalWnPimNgZUGtlY=
X-Google-Smtp-Source: AA6agR4RoGErMZmXsqT1pvzlGAnNq0eFuHX1ZnVYE/LZBpYXHqCy5OZMJX7PhloSCoSmajlX3KGlsPU2OvewRmWpX+w=
X-Received: by 2002:a05:620a:205d:b0:6bb:2393:b610 with SMTP id
 d29-20020a05620a205d00b006bb2393b610mr4087120qka.413.1660873458506; Thu, 18
 Aug 2022 18:44:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210317204939.17890-1-alban.gruin@gmail.com> <20220809185429.20098-1-alban.gruin@gmail.com>
 <20220809185429.20098-9-alban.gruin@gmail.com> <08ea1eec-58fb-cbfa-d405-0d4159c99515@gmail.com>
 <xmqqilmzkd7p.fsf@gitster.g> <qs23r0n8-9r24-6095-3n9n-9131s69974p1@tzk.qr>
 <xmqqedxgt1zx.fsf@gitster.g> <848p4p89-2219-7874-ss50-2o0rp4r02902@tzk.qr>
 <CABPp-BGSFYWvA5HktLf33=w7JB95iDLDNoE0gdA3oUtb+qYoQQ@mail.gmail.com>
 <xmqq7d36vfur.fsf@gitster.g> <220818.868rnlaa0h.gmgdl@evledraar.gmail.com>
In-Reply-To: <220818.868rnlaa0h.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 18 Aug 2022 18:43:00 -0700
Message-ID: <CABPp-BEvn5ovFF8DzjVW-H9rQ-UdU56uT_dk80w9p7DHokD+rQ@mail.gmail.com>
Subject: Re: [PATCH v8 08/14] merge-resolve: rewrite in C
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 18, 2022 at 7:42 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Wed, Aug 17 2022, Junio C Hamano wrote:
>
> > Elijah Newren <newren@gmail.com> writes:
> >
> >> There's also another concern you tried to address in your other email;
> >> let me quote from that email here:
> >>
> >>> If you want to have an easy example of a custom merge strategy, then =
let's
> >>> have that easy example. `git-merge-resolve.sh` ain't that example.
> >>>
> >>> It would be a different matter if you had commented about
> >>> `git-merge-ours.sh`:
> >>> https://github.com/git/git/blob/v2.17.0/contrib/examples/git-merge-ou=
rs.sh
> >>> That _was_ a simple and easy example.
> >>
> >> ...and it was _utterly useless_ as an example.  It only checked that
> >> the user hadn't modified the index since HEAD.  It doesn't demonstrate
> >> anything about how to merge differing entries, since that merge
> >> strategy specifically ignores changes made on the other side.  Since
> >> merging differing entries is the whole point of writing a strategy, I
> >> see no educational value in that particular script.
> >>
> >> `git-merge-resolve.sh` may be an imperfect example, but it's certainly
> >> far superior to that.
> >> ...
> >> If someone makes a better example (which I agree could be done,
> >> especially if it added lots of comments about what was required and
> >> why), and ensures we keep useful test coverage (maybe using Junio's
> >> c-resolve suggestion in another email), then my concerns about
> >> reimplementing git-merge-resolve.sh in C go away.
> >>
> >> If that happens, then I still think it's a useless exercise to do the
> >> reimplementation -- unless someone can provide evidence of `-s
> >> resolve` being in use -- but it's not a harmful exercise and wouldn't
> >> concern me.
> >>
> >> If the better example and mechanism to retain good test coverage
> >> aren't provided, then I worry that reimplementing is a bunch of work
> >> for an at best theoretical benefit, coupled with a double whammy
> >> practical regression.
> >
> > Ah, you said many things I wanted to say already.  Thanks.
>
> I may have missed something in this thread, but wouldn't an acceptable
> way to please everyone here be to:
>
>  1. Have git's behavior be that of the end of this series...
>  2. Add a GIT_TEST_* mode where we'll optionally invoke these "built-in"
>     merge strategies as commands, i.e. have them fall back to
>     "try_merge_command()".

In the portion of the email you quoted and responded to, most of the
text was talking about how git-merge-resolve.sh serves an important
educational purpose, yet you've only tried to address the testing
issue.  I think both are important.  The easiest way to fix the
educational shortcoming of this series is to reverse the deleting of
git-merge-resolve.sh, and restore the building and distribution of
git-merge-resolve from that script.  Unfortunately, that generates a
collision between both the script and the builtin being used to build
the same file (namely, git-merge-resolve)...which is yet another
reason that the easiest solution available here is to just not rewrite
this script in C at all.

There are certainly other possible solutions to the educational issue,
and might not even be too hard, but we'd need someone to implement one
before I'd agree we found an "acceptable way to please everyone".  :-)

> So something like this on top of this series (assume my SOB etc. if this
> is acceptable). I only tested this locally, but it seems to do the right
> thing for me:
<snip patch>

How did you test?  I'm a bit confused...unless I'm misreading
something, it appears to me that ci/lib.sh sets SKIP_DASHED_BUILT_INS
unconditionally which would probably cause your proposal to break.
