Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17C981F404
	for <e@80x24.org>; Sun,  2 Sep 2018 02:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbeIBGcp (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Sep 2018 02:32:45 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40428 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbeIBGcp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Sep 2018 02:32:45 -0400
Received: by mail-qk1-f196.google.com with SMTP id c126-v6so3781566qkd.7
        for <git@vger.kernel.org>; Sat, 01 Sep 2018 19:18:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I1iCv7arqWaNUnR1ToNPs+o0sDzoHLLuIpNvIPb+J7c=;
        b=bpKLcOe6PzJdJ/EM/SObWkQo3fojCB++QoaQtF1oU30FPcgZsTliO8F+FpMDtu5sLr
         OTjVxBSjFA4gYZ0ipZDsVHzYHPX1PX/twCgTokZAWVUQ2FJODR2IC8KUADnxrgUs/5Ny
         qa17BjokOdJajZ5anKdCUg5qekd7Xp+WGABdiMJnBuolJU/kRoYDyjzuGfSy5sBy60tq
         EuB0VXcdx+MXXHDCPVgJz0ZJOXxcLDcrlMGuAU5FjWf/gFV8/rHB0EtrWf0gaP6Sd0gx
         mAnsQcJ3Qh+hhsezaMSncl8Xt2aZARroSssPMIQYeSf1y4Sx9Cm6dGk/sS569ZuQsSsQ
         zfNQ==
X-Gm-Message-State: APzg51A0eMDVeuuWYB2WmVwqiXsMVtDHMPE8b1jGjdyOUt3DyTU4UwUm
        W5BS/JVZgQ7pTEQUUPlxDSnkoKB/F1/Px5dUOgc=
X-Google-Smtp-Source: ANB0VdYW0JdMHEnnwl3HPpCY95f3vJMIXUSIgXtEczes7lHfFJsZcvzQN5fQUgFlfjwYsN2DC4tTPj4ManFdc/R7PE4=
X-Received: by 2002:a37:48e:: with SMTP id 136-v6mr20890681qke.26.1535854724846;
 Sat, 01 Sep 2018 19:18:44 -0700 (PDT)
MIME-Version: 1.0
References: <20180901235256.4260-1-ischis2@cox.net> <20180901235256.4260-3-ischis2@cox.net>
In-Reply-To: <20180901235256.4260-3-ischis2@cox.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 1 Sep 2018 22:18:34 -0400
Message-ID: <CAPig+cTzBTA4hSkM9ZtRVARZEwXMv1o9GnPMrBGimt-g=ExmHw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] Add test for commit --dry-run --short.
To:     "Stephen & Linda Smith" <ischis2@cox.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 1, 2018 at 7:53 PM Stephen P. Smith <ischis2@cox.net> wrote:
> Add test for commit --dry-run --short.

The first line of a commit message typically mentions the area or
module being touched. It's also customary not to capitalize the first
word and to omit the final period. So, for instance:

    t7501: add test of "--dry-run --short" setting 'committable' flag

> Add test for commit with --dry-run --short for a new file of zero
> length.
>
> The test demonstrates that the setting of the commitable flag is
> broken.

s/commitable/committable/

> Signed-off-by: Stephen P. Smith <ischis2@cox.net>
> ---
> diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
> @@ -682,4 +682,12 @@ test_expect_success '--dry-run with conflicts fixed from a merge' '
> +test_expect_failure '--dry-run --short' '
> +       # setup two branches with conflicting information
> +       # in the same file, resolve the conflict

What is this comment all about? It doesn't seem to have any relation
to what the test itself is actually doing. (I see that it was copied
from an earlier test in this script, but that doesn't help me
understand what it is trying to say.)

> +       >test-file &&
> +       git add test-file &&
> +       git commit --dry-run --short
> +'
