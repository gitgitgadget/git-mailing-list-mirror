Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DF7C07E96
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 03:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 274E761CA3
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 03:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbhGGDGW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 23:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbhGGDGV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 23:06:21 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C58C061574
        for <git@vger.kernel.org>; Tue,  6 Jul 2021 20:03:42 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id p9so677631pjl.3
        for <git@vger.kernel.org>; Tue, 06 Jul 2021 20:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WDvNwlxM+IcBzsAlHYY5Zsl7njsaN+RL3amkOcQUm6U=;
        b=r4arOLQ6AuHXRcZ4NrX6YhrojmlqTCnD4sgv8dDnYLmrqQ7DS8HOmb2P4Jm0h9TV/I
         8U9pM+gShRMyjfDIujQKq5WO4hRBtGuaUPIb5iWb2YZ32z6eOJ1ka19VA/+XsCmwpA+M
         KI6kJw7Dk1B5oIchlSoMo0AjVHViJkeZTo6xzjzfaaV62HCRLJ/u2PdUdlJRklkhY77p
         BhvJj19KMdoNEsBybvXsCLh76PJyLUjuXtXrD2PuPoYuAvQf3J7GvJBY3E2FtdcV08g8
         JOFW49OS/ve4eHjOhD2DhdCOpHS7Jk5MODH/gmm66rhgZg2yrx0LzGww2FAC90Y4d2Uy
         NztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WDvNwlxM+IcBzsAlHYY5Zsl7njsaN+RL3amkOcQUm6U=;
        b=WAg9SJoaLUOwY7NsHNdQfE478bMYdsJUlpH7tBfHVaIiTUWXtsq+19nAp6rIRYdah8
         I9fyvILu533ROPB2PVSo+Mkxqrt7I30JRozHOj+/G8SIhpEx65M90lC+uI5e6weXrox6
         uZ0CHo6ghnHo9HO2hwKJFQMsfPE2cfBwetwzXePc3yhKMdZfbtTRm2o89kuSqbmXlh78
         /GghugEbIvvX47TAyPOR6kEv5V4IddJTpXAqq6EmAk/aCwDciU9NGtmCqanvj7exaItr
         BdMhZ3t7WRewgaKf6AVD3UanNwxWpwXGp1o268dkf5Ba1f5PnzwJ2OHXZ6c/UfJFM0by
         7rhw==
X-Gm-Message-State: AOAM530jXZ9xWXvtXmRPqeJyrg5AjpK1kI5YiFY1x2qDDHtOgWhahHno
        rlx1CjjTbLkmmE7NaJMHkQ0=
X-Google-Smtp-Source: ABdhPJx5br+I1gyeWBREboq78WfTYY1HE4UIk7jmXGFlF9efY+NvCBBpoK8NkLGvCCa0FCcXsverug==
X-Received: by 2002:a17:90b:194b:: with SMTP id nk11mr23440669pjb.85.1625627021708;
        Tue, 06 Jul 2021 20:03:41 -0700 (PDT)
Received: from localhost ([2402:800:63b8:9039:443b:57cf:40b5:f8d1])
        by smtp.gmail.com with ESMTPSA id s37sm7531368pfg.116.2021.07.06.20.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 20:03:41 -0700 (PDT)
Date:   Wed, 7 Jul 2021 10:03:39 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v5 1/3] test-lib-functions: introduce
 test_stdout_line_count
Message-ID: <YOUZi+Ueg5MIl6DF@danh.dev>
References: <20210615172038.28917-1-congdanhqx@gmail.com>
 <cover.1625362488.git.congdanhqx@gmail.com>
 <ab542ae9aa35decd2bc55561c5ba8f5653fa07a2.1625362489.git.congdanhqx@gmail.com>
 <CAPig+cRNw_RVx3CCXN-Usz0Jmi0iphDv2Vqg1cZFqa+QricuJw@mail.gmail.com>
 <xmqqo8bfjley.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo8bfjley.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-07-06 12:24:05-0700, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
> > A minor think-out-loud: I wonder if there would be value in deriving
> > the name of the output file from the command being run (perhaps by
> > using `tr` to translate oddball characters to underscore or to fold
> > them out). This might or might not help someone debugging a test
> > failure since there would be less chance of "$trashdir/output" being
> > repeatedly clobbered.
> 
> Probably not.
> 
> The iterations of output that are clobbered are all from the passing
> call to test_stdout_count_lines helper we made previously.

Yay, I also think it doesn't add much value. Since we're chaining
command in a single test-case.

I think most people with try to debug with "-i", which exits
immediately.

The only place it would help is debugging test failures with GitHub
Actions, where developers could download artifarts for test failures
from GitHub Actions.

-- 
Danh
