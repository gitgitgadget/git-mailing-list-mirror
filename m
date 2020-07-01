Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5C6C433E1
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 16:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB8FB20780
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 16:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKhgVnye"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732189AbgGAQAx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 12:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728534AbgGAQAx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 12:00:53 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02619C08C5C1
        for <git@vger.kernel.org>; Wed,  1 Jul 2020 09:00:53 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id o11so24584411wrv.9
        for <git@vger.kernel.org>; Wed, 01 Jul 2020 09:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7IoNr4yvZMHW9w6dnCR3VsdeUq6V4k4ZhZm8WSoSdSo=;
        b=kKhgVnyeECIm+eI5G5y61uQREDbDtJdooGQlTTlF6xKUYIw/Kob9YEGFYRmYQjcs/p
         0NPvQwOvFclqE7ERjtMED1rCOsCxO/rFHebvBED5u82DotB+PUtv//Zv2SU+eMi2PL82
         MTSvIB3cYJgqcoOrQkugtVo4wH+d1UfDP6xxNkQ9xODVsD1IDrgKTS8J/TsCdMPr2V7K
         oa5x8m7gVAmeoVBZLiNRxYPm0B3XZ2+yzGszY5uTWQKwfHUJnGDX+oLGFcsLvF6xUux6
         xu7KdNfTz6uRvGlaqbqKIqdGAW9kQoWg/Ov+xiBrPjM6vMR3w3S9eqn07enfIQE6bpbp
         OLRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7IoNr4yvZMHW9w6dnCR3VsdeUq6V4k4ZhZm8WSoSdSo=;
        b=g6mFEQC9BYr1CgKUrYBzXgpdYLVdGKBSJ0vkvhKBjzQBFp9y7AsDylM3B3gSJnEN5y
         iSUcw6MO9xCT+jsGD7S1C0sf3cbxAlMX/4VJZ5LcEeIWZo6p/sb6xt/sbt0jhZ53rpBJ
         fyS9bL9IbUMzXbtQZmTci8Y8jpRvwYnHf5nEc3qWRtbV2bFPWs4bsEW4Ju9+WWoP7Ia/
         XHXvw6+VeSktPzH6DpjGHVXJjxJ7ZIv4UgycreR50/Is5BbitM6r576DdPkRcil/Cg5g
         XNvssZAOSyr5b3AJB1OPQBLgIpVenUaO3rzGypQctmkb3AyuIgIw5RaPUVjOf1JLzgdl
         +M0Q==
X-Gm-Message-State: AOAM532Z9G9MK+SPlmk/tJkuI7VdqSnpHX3GfKZlNpzoMfchDH771gKv
        JC5pMa1f9NvIePWIUlDprc3QrGMdHPw=
X-Google-Smtp-Source: ABdhPJzfNi9FpGa/eEChetkn+8t6RH1KgPpDjqzBPf1kyGvIyYdLm5nubWn32/sVz6A2tRyZ8g8OIQ==
X-Received: by 2002:a5d:5306:: with SMTP id e6mr29583937wrv.39.1593619251647;
        Wed, 01 Jul 2020 09:00:51 -0700 (PDT)
Received: from [192.168.1.116] (2-229-250-51.ip199.fastwebnet.it. [2.229.250.51])
        by smtp.gmail.com with ESMTPSA id c70sm7610127wme.32.2020.07.01.09.00.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jul 2020 09:00:50 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: Built Git 2.27.0 from sources on macOS Catalina fails on "make
 profile"
From:   Fabio Frumento <frumento.fabio@gmail.com>
In-Reply-To: <20200701153726.GC6726@coredump.intra.peff.net>
Date:   Wed, 1 Jul 2020 18:00:49 +0200
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E9210645-66F4-4B76-BB26-C8282AE23B3D@gmail.com>
References: <618374D7-60E1-4942-B29F-4F2EA261996F@gmail.com>
 <20200701153726.GC6726@coredump.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Thanks for the reply.

I get several messages like this

LLVM Profile Warning: Unable to track new values: Running out of static =
counters.  Consider using option -mllvm -vp-counters-per-site=3D<n> to =
allocate more value profile counters at compile time.

I=E2=80=99ve checked the scripts in the t folder, they use #!/bin/sh =
while  I=E2=80=99m using zsh could  it be of some relevance? Which shell =
are they supposed to be run?

-Fabio

> Il giorno 1 lug 2020, alle ore 17:37, Jeff King <peff@peff.net> ha =
scritto:
>=20
> On Wed, Jul 01, 2020 at 03:17:05PM +0200, Fabio Frumento wrote:
>=20
>> now I'm struggling during the ```make profile``` step
>> [...]
>> I'm a little surprised as presumed, since 2.27.0 is an official
>> release, all the tests should pass without any issue.
>=20
> They generally do (not just for releases but for every commit that =
hits
> master). However, we've sometimes seen weird test failures from "make
> profile" (which in my experience isn't all that well maintained).
>=20
> That said, "make profile" passes for me on v2.27.0, on Linux.  It's
> possible that a test is racy (the profiler often slows things down,
> exacerbating races), but I can't seem to get t0410 to fail with our
> usual stress-test to find races.
>=20
> If you don't care about profile-optimized builds, then I'd suggest
> skipping "make profile".
>=20
> If you want to look further into the test failure, probably it would
> help to re-run the test with more verbose settings. E.g.:
>=20
>  [wait for this to fail, which would leave the problematic version of
>   git in the build directory]
>  $ make profile
>  $ cd t
>  $ ./t0410-partial-clone.sh -v -i -x
>=20
> then we could see what's failing.
>=20
>> How to file a bug to the Git developers?
>=20
> I think you just did.
>=20
> -Peff

