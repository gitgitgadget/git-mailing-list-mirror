Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F60BC433FE
	for <git@archiver.kernel.org>; Thu, 25 Nov 2021 03:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345715AbhKYDRk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Nov 2021 22:17:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346617AbhKYDPj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Nov 2021 22:15:39 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF48C06173E
        for <git@vger.kernel.org>; Wed, 24 Nov 2021 18:54:55 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id r25so19091862edq.7
        for <git@vger.kernel.org>; Wed, 24 Nov 2021 18:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ig8Hlo1Wf6MWkFHrlbR7BC5eDtA3CcoUVInV1L+zvfg=;
        b=RMIDuZIloQS7nEendae+YqDEeaMJofhYyTHnKl5o36+g8UQIvR6BEjwYQ8scxrcJqK
         W/dD4dTj5BUSSWWf+58dwT7Xg4b7PORcVsbrkVRRW8PLFYIUgMr21KWPsAa0GQuDsTrB
         dG9GxyGWTqzpaN2CFyqShwLIfc3mMwv6fJZj3pGefdMsNPUVMNIYGb3BPzDwGTNLtz8v
         J/DDEKZk1reQyUn9rQmrkT5tymQGegAOOGvbFxvEYhV/0q8ajE9N6d8TwxIYgnIsHGSC
         B6diErI3igLt+llE8FpwdEzFLfe5QOWAj0LPF4W9QnPneagY+zFl8/pqUVzmlp+p4Xm2
         1HiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ig8Hlo1Wf6MWkFHrlbR7BC5eDtA3CcoUVInV1L+zvfg=;
        b=EyySija2iNBoh/RGvkmtbX1JQSPc5ZO9RnCxW070Zz8UDnuJqEeNsz7kxu1wWQMrkv
         siDEwHFhp+8mH4bvJhYcHC/RCYMBHZKRsR+gld9HGBdDOthd0lLqwgSCYzgBzzQueY57
         C4qExUsYG6jRoaXYM/6VQb6oE7SM08h1O7mYPvrFXem9IWBqS9it/5J7hpW+We7HaquW
         0KGjj6O9bH0vAGLR5CV2jRnv5fkc5MUHaM1crADdYYyd869s8lqUhpMpKq+my4LMzUsV
         MW/awy7jNOH0DUM5S+qugeCCkwY8qvvtKmj1PXtevmycmOhqi7A2c6ZkEA98vcaaM87v
         KLOA==
X-Gm-Message-State: AOAM531n5Os5hXKkosvLykkoCEQ91CQUo0MXSP0rTvCxeJOlG/bRCqEE
        GQvWQ5z0gjNakiPDxl3e9KRvb4/fbUu97KMX367PQz7B
X-Google-Smtp-Source: ABdhPJxaNslPxQX+YINhY2NhJ79G2z0BWolzpDQwotuHbzLI2eH8C0PNDSJlIgvloyPTs/raHvFlbhZLJ4adw93GdoM=
X-Received: by 2002:a17:907:1c9d:: with SMTP id nb29mr27893540ejc.74.1637808894578;
 Wed, 24 Nov 2021 18:54:54 -0800 (PST)
MIME-Version: 1.0
References: <a5528cbb14ddbbf26cde873e3f3e95744d59b950.1637455620.git.gitgitgadget@gmail.com>
 <20211123003958.3978-1-chooglen@google.com> <CABPp-BE0Bcimwr1wwcnnh+6apx7r114Oqnu=QDgKEn6VAHAtFg@mail.gmail.com>
 <kl6lmtluka55.fsf@chooglen-macbookpro.roam.corp.google.com>
 <CABPp-BGr9PDTE0q5zev4Ffx19g+hG083zdNShoSdH47VqzT8mw@mail.gmail.com>
 <211124.86ee76e4fl.gmgdl@evledraar.gmail.com> <CABPp-BGZPheDqWD1pXbePOYe2BcT1-TqX-zGVqnNLGtFuXab1g@mail.gmail.com>
 <211124.86wnkxdbza.gmgdl@evledraar.gmail.com> <211124.86sfvld4cl.gmgdl@evledraar.gmail.com>
In-Reply-To: <211124.86sfvld4cl.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 24 Nov 2021 18:54:43 -0800
Message-ID: <CABPp-BH_NfkzX5XkhPPpX1_bsR9kWGsBBdcUwikDWsA8jc6KJA@mail.gmail.com>
Subject: Re: [PATCH 8/8] dir: avoid removing the current working directory
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Glen Choo <chooglen@google.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 24, 2021 at 6:18 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> I fleshened this out a bit in this WIP change:
> https://github.com/avar/git/tree/avar/setup-handle-gone-directory +
> commit:
> https://github.com/avar/git/commit/97968518909eef88edba44973b7885d154b7a2=
73

Sweet!

> As noted there there's some caveats, but so far nothing I spotted that
> can't be overcome. It's particularly painful to test it because of an
> implementation detail of our test suite, the bin-wrappers are
> shellscripts, and the very first thing they do is reset $PWD (none of
> which happens if you run the real "git" binary).
>
> That's b.t.w. the "shell-init" error you noted in
> https://lore.kernel.org/git/CABPp-BEp3OL7F2J_LzqtC-x-8pBUPO8ZR1fTx_6XbqZe=
OH1kRw@mail.gmail.com/,
> it's from the bin-wrapper.

To be a bit more precise, the error/warning is from bash rather than
the bin-wrappers specifically; for example, you can also trigger the
same shell-init message with a simple `bash -c 'echo hello'` when your
cwd has been deleted.

> I really wish we didn't have the bin-wrappers...

I'm curious: is this issue the only reason, or am I reading between
the lines correctly that you have additional reasons for that?
