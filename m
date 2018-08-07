Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6895208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 18:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388943AbeHGUeg (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 16:34:36 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40236 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbeHGUeg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 16:34:36 -0400
Received: by mail-wr1-f67.google.com with SMTP id h15-v6so16655057wrs.7
        for <git@vger.kernel.org>; Tue, 07 Aug 2018 11:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+pKkcUjO9OKayw4W4j4UV04ui5oqhvafMlZwi2nma4E=;
        b=GRZPUxa7RagMiumWT+FBmttgIoExJm9SiKvk0p0gc5qzTesCG3B5ZgOx+jxx40CQQy
         wFYfFknLtkAmz+uI03ty207VlwlhBIAKu76lRG55BX1ypmA5ePbVhsIOy84dIrQuyOAn
         hdQlEHWhqokKgm2NX9lbqene72n5jUd77f6Utnxe4oOaPA6CcbjzHkLBJvRSF9PRTyn0
         iaijGb4UQWT0N5+PA+gNHIcU4x4Vvj6guVj8hYmUqVrxJufG3cwuYxTXwr/WjNk9JWHU
         oo75CUG3Cb/AyczgRNT/QACeLEEaCsRjQPEN+TCHIYLsI2ZulCGqh3B99W1tfX/RHEDx
         JSNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+pKkcUjO9OKayw4W4j4UV04ui5oqhvafMlZwi2nma4E=;
        b=qAwL8GpOP05Ijwn/KCQbXOqhqHa0O3IKgAW+1MU6s5rI4l1/axFNTA6n217hI/oiWV
         nRLnldfSc0YfA3am6ory5T9utODwEl+GHx/aVSxQqu0MKEoavt3eVT4N+Wjyro7FufQK
         CgG3L0yAAdJzowb/BuF1X9H17OCzKIREWShI1LGL2EIYmX2P0z2yaNDcblrB5rAfG/6B
         bxfx5xG99BvzmqR45+2m0eUjQsgUQF1kAJdm/HRnoL0KfrqVmsDWVr2QT2L+7EmKGuNY
         H2nbwZX7Ry3h0BHxA/R3nl/OCeMzv5KLV0VykqZe8jLRTdtYRyVQknpKfAmjqm4Imuiz
         bl/Q==
X-Gm-Message-State: AOUpUlFfgH7vEv7Q+leTMw3pHfKbLI9TqjfZ0UnI1efxeMYh9BPUkTXW
        G9x6thjIuHuJrLQbj33BnVA=
X-Google-Smtp-Source: AAOMgpeBE9afzk7dTwgdZPu1OL90ja541szUefCCfJnV/Wa2lYDzdVDiBA1GrwP9Psb8PSPM5U48KA==
X-Received: by 2002:a5d:6b01:: with SMTP id v1-v6mr12583935wrw.208.1533665939610;
        Tue, 07 Aug 2018 11:18:59 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id j6-v6sm2341770wrs.91.2018.08.07.11.18.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 11:18:58 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCHv3 1/5] t7406: simplify by using diff --name-only instead of diff --raw
References: <20180806152524.27516-1-newren@gmail.com>
        <20180807164905.3859-1-newren@gmail.com>
        <20180807164905.3859-2-newren@gmail.com>
        <xmqqo9eekrv0.fsf@gitster-ct.c.googlers.com>
        <CABPp-BGB5dD6UYUzRq2pDSan-2CV7=8xmZKCa0tv7nzY2Mb-aA@mail.gmail.com>
Date:   Tue, 07 Aug 2018 11:18:57 -0700
In-Reply-To: <CABPp-BGB5dD6UYUzRq2pDSan-2CV7=8xmZKCa0tv7nzY2Mb-aA@mail.gmail.com>
        (Elijah Newren's message of "Tue, 7 Aug 2018 10:40:05 -0700")
Message-ID: <xmqqbmaekpke.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> I think 0/5 should fix the real bug you are deliberately keeping in
>> this patch, from the point of view of organization.
>
> You mean 5/5?  And yeah, it was just a temporary thing for
> organizational purposes.

I meant "a thing that comes before all the other steps".

As far as I can tell, everything else this 5-patch series improves
would still have caught a new bug in the subsystem being tested
(i.e. "submodule update") even without these improvements.  Surely,
if we greak "git diff", "git diff --raw" that sits on the upstream
of a pipe would not have stopped these tests, but we have tests for
"diff" elsewhere and t7406 are not about catching the breakage of
"diff", so from that point of view, fixing them, although it is
necessary and important, is less important.

The "\| grep" thing was a real bug in that if we broke "submodule
update", it would not have helped to catch such a bug, as it wasn't
looking for 'submodule' string in the output.

That is why I felt it would have been a better organization to fix
"\| grep" in "a thing that comes before all the other steps" and
then fix the rest as lower priority clean up.
