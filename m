Return-Path: <SRS0=xHKm=7B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCA3C433E0
	for <git@archiver.kernel.org>; Tue, 19 May 2020 16:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 974F3207D8
	for <git@archiver.kernel.org>; Tue, 19 May 2020 16:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbgESQJk convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 19 May 2020 12:09:40 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55916 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729001AbgESQJk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 May 2020 12:09:40 -0400
Received: by mail-wm1-f67.google.com with SMTP id f13so3626170wmc.5
        for <git@vger.kernel.org>; Tue, 19 May 2020 09:09:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Jn7zUXhgq85KbPvrgu12TJxXn0UeHvDGcwfrDAl2tdc=;
        b=oLIMYG7Q/t+rFpY/+tOvKi4BgjcysOR7OAjO9IXsFSOujkeX0W4s+vkaUZxWcC6Diw
         VUdVQA8FfzSMDSxiQjwHLgxV4lrUVNPblAFvrkuiOeUvcPAcV13xmSrIK2CEznaejKEu
         YG1gc2WZ8kXYuA5YT9twyw1V6XZaF7dh4f+w6owlOaqal4BgmxUNCammdLXGDBeTJv1m
         TnQQ8zGrjLhqQOWh7LLAzKPyuqjxiRqJBSLD+kSUr4tYPSmwY9HOs3IHgZ3FYBqHPE5A
         txI0C3Hci8JLZzQG3CfbweTilw4v0rb5Qj5JuBJzghqIif5JTHIeV0WlXk/NHn51kdaL
         XrAA==
X-Gm-Message-State: AOAM5337/KEB/9uQXadB/NDoiXVF+0VGtARZBkUzvww9i50nUX8P74sB
        JM3SCJ+GrDh1vxBqgSp+GOSRjkt+JiS/zi6GRl4=
X-Google-Smtp-Source: ABdhPJwopu6YJ9q07Xk39CEy/bVLvTTlqllzpvccVofDQO0Z1WlFFVePpHxcMFYtb9n1DxFlGXTqamb3UabjIHI4JGo=
X-Received: by 2002:a1c:df46:: with SMTP id w67mr134494wmg.130.1589904578031;
 Tue, 19 May 2020 09:09:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200518100356.29292-1-dtucker@dtucker.net> <20200518141311.GC1980@danh.dev>
 <CALDDTe13_utn7E+QF1AgndX_6nPph=Gr1hesLwfV8e9LwgUPOQ@mail.gmail.com> <20200518153025.GD1980@danh.dev>
In-Reply-To: <20200518153025.GD1980@danh.dev>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 19 May 2020 12:09:27 -0400
Message-ID: <CAPig+cTCbBE4Xj7LGJDqz4pcRsR-ZAF-ekcMnZ_cDuzgmEnxcw@mail.gmail.com>
Subject: Re: [PATCH 1/7] Redirect grep's stderr top null too.
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc:     Darren Tucker <dtucker@dtucker.net>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 18, 2020 at 11:30 AM Đoàn Trần Công Danh
<congdanhqx@gmail.com> wrote:
> On 2020-05-19 00:29:47+1000, Darren Tucker <dtucker@dtucker.net> wrote:
> > $ ./t5703-upload-pack-ref-in-want.sh
> > sed: There are too many commands for the s/\n// function.
>
> I think this was introduced at 878f988350 (t/test-lib: teach
> --chain-lint to detect broken &&-chains in subshells, 2018-07-11)
>
> The chainlint.sed is too complicated for a mortal like me to
> understand, I added Eric to Cc.

That's a rather weird error message; seems like that 'sed' is somewhat broken.

Back when Ævar was trying to get chain-lint to work on some really old
and broken platforms, it was ultimately decided (if I recall
correctly) that it wasn't worth the effort, and that chain-lint should
simply be disabled via GIT_TEST_CHAIN_LINT=0 or --no-chain-lint on
those platforms.

After all, chain-lint exists only to ferret out a specific problem in
_newly-written_ tests (it's testing the tests), not to ferret out
problems in Git functionality (that's what the test suite itself is
for). So it's not a great loss to disable chain-lint on an old or
broken platform on which it is unlikely someone will be developing
_new_ tests. (And, even if someone does write a test on such a
platform, &&-chain breakage will be discovered soon enough once the
patch is posted to the mailing list and someone runs it on a
non-broken platform.)
