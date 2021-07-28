Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26610C4338F
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 20:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0375560234
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 20:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbhG1U6V (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 16:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbhG1U6U (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 16:58:20 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD95CC061757
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 13:58:17 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id h8so5078256ede.4
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 13:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xiw4Pm5VYJCJ/Cljp3yGA4FyGSkCSvh/gU3/oJupi5o=;
        b=qOTIT8p/Af800Sn7rxYZ1xU3NMlZURRv02FWjd2L7LuZY/VoTI8V8HX6rh1wdfBMA8
         +dnB+VVt8rQeudwg47VhSw9QmUyFT4afft4Cwh619BC4yzsiN51K4s/KzSBwoWxnjHxC
         rzQ522yxUPHcOaoz4UmQmr+knloJRVs6cvN+mtigNGVOJXjJB/29VROMEt7IWTkw5EGW
         nMokPPOZ/3rCg4hpLSlClDe9famIL7SIaVGcTYFZYLmMIu20Z7m+UoiJnH5GG5lfhh4d
         dvaQlCThs3g05F1gwbr+l47b8xW6xEwjGAJOXBbfD/ztI4/NIYJ9VpD5t5y3B46r8Qtq
         rp2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xiw4Pm5VYJCJ/Cljp3yGA4FyGSkCSvh/gU3/oJupi5o=;
        b=t6zvClzBkoxpKIroNZHzY9TsGZ1CzLikM3mG0yj7Eq1iaV9IITo5YlUXL1f/yK/uP/
         P9eTks+6OEtWXgYFWUJeobTcp5ngjoViY+Rru66FLoy1Ld0990FRDs5ixls4KUK6QMb2
         cDpyfxV6Yuwd72d0keYSxwwHqUCgH02iS9uOz2+GFEVfMui0u1EvRVqZ74JVHquYu5rL
         J6jtBO2hp/pHDb9sbaVpavnpumMB3C7Odl7xOhFPxExa6e0VVIQhGthI4PEq5WM/e7fg
         0rnCaE+Qz2x9SiYDioPH2bdp2Iyn3b5zsoefBeJ89zJOq3Q/CVYow2zPyEoyQUiwao8V
         gZOg==
X-Gm-Message-State: AOAM533nYg1OPY7KchZj11M6csz3wzoGIYOBUlaBZRAYWdSpaGyjHNYI
        w+i6ahrEjGQvItN8WFbx7b+Rc7NKnn4IY7/nBkQ=
X-Google-Smtp-Source: ABdhPJw0csqLq0ZjTKHhKS8gMcqLUJuCgnCNonrH72ChNZWRk+Xt2lw1CRKBhMlJBlKR9VoPQXhuxdNxCpXvLl2IqcY=
X-Received: by 2002:a50:ff0a:: with SMTP id a10mr1996053edu.273.1627505896324;
 Wed, 28 Jul 2021 13:58:16 -0700 (PDT)
MIME-Version: 1.0
References: <0df90d98-3b79-3751-8712-69e1d44a32fd@gmail.com>
In-Reply-To: <0df90d98-3b79-3751-8712-69e1d44a32fd@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 28 Jul 2021 22:58:05 +0200
Message-ID: <CAP8UFD1pfFwSFMUJ-pR02xNm7kzYwqabPKc1L-jb_rELuZAVqA@mail.gmail.com>
Subject: Re: [BUG] 'git bisect start' fails to detect bad revisions without '--'
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philippe,

On Wed, Jun 30, 2021 at 8:47 PM Philippe Blain
<levraiphilippeblain@gmail.com> wrote:
>
> Hello all,
>
> I've found a small bug in the argument parsing of 'git bisect 'start',
> i.e builtin/bisect--helper.c::bisect_start.

Sorry for the late reply to this, and thanks for the report!

> If one mistypes bad (or good) revisions but does not write the double-dash,
> the code does not check that the revisions exist and it goes on and checks out HEAD.
>  From what I understand the mistyped revisions are (in some cases) interpreted as paths
> (they are written to '.git/BISECT_NAMES), even if they do not match any paths...
>
> For example, these invocations all check out HEAD and do not give any error in git.git:
>
>         git bisect start BAD GOOD
>         git bisect start v2.31.0 GOOD
>         git bisect start v2.31.0 GOOD ANOTHER
>
> But these correctly error:
>
>         git bisect start BAD GOOD --
>         git bisect start v2.31.0 GOOD --
>         git bisect start v2.31.0 GOOD ANOTHER --
>         git bisect start v2.31.0 v2.30.0 GOOD BAD
>
> This one does not error and correctly checks out the mid point between 2.31 and 2.30,
> but does not check that BAD exists (in this case it's not written to BISECT_NAMES):
>
>         git bisect start v2.31.0 v2.30.0 BAD
>
> This is on the latest master, 670b81a890 (The second batch, 2021-06-14). I tried older versions
> before the start of the conversion of 'git bisect' from shell to C and they seem to behave the same.

Yeah, I agree that it looks like the behavior could be improved. It
could be tricky though, as, even if something does not match any paths
in the current commit nor in the BAD and GOOD commits, it could
perhaps match a path that is in one of the in-between commits.

Best,
Christian.
