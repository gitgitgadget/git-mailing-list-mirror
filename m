Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C429C4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 14:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E224760FDA
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 14:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbhFUO4p (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 10:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbhFUO4o (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 10:56:44 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D386C061574
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 07:54:29 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id nb6so29179080ejc.10
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 07:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=6lrcCs3QFmqtbPc2ueZHE78XjCLNA3EU0h9DiNVICfc=;
        b=rk+uiGjTT0lDwtEZjd8Whaq/DypsqgTYaD56fWzAP08Au4l65BXxXyy+fdfcieTWjM
         fSQdHkwhXCujBjnx48a9G7IOBkL9SmtF76JD6X0erH8UMAwyUMpiytAsoueN4Cktcr53
         ZWlF6p1CsD2oUd9uk7tL/by8F2mrtBSVwa1L+npVFSwY/nRhbz97tF+Axmjc7ncLNl31
         QQ8luLauvmco2AqIEy27itA7pvT3AFKdi21Xh9B9vd0HMVZVLAoMc8q5ZTBgM6fhVA8c
         Pio0E3XaydsTV+ZxI+freoqW/BgNf2o+RqN6ERGE7FWFPgmH6O7xxErNlAt59p28F6vF
         3adg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=6lrcCs3QFmqtbPc2ueZHE78XjCLNA3EU0h9DiNVICfc=;
        b=D3uZ7lugLEIqpBsaqYcNqY15QVW5ig1oeTvDwP3uG6whWvg65XP8pX0a9YxYKpBzCk
         rQ+ZqtcSV/pM5Yb6+enEbc07hnbmD7j+PTIb+2Xd4XShgUrMAaLFFHkIFR4pjWHEkCT8
         ttDZg7c46NEzkNxY8IXIA4DT0hlF2dxImcPLWny0EMO0btjYN76I/t34KWWpjmKv+KLJ
         qclN6whRRm55FFWh8ORbmRqF4zDnMwvWPHjuHPHbRpwzz3ohqMRpws9lo/4nkNfpg+di
         7kWwqtH6Tp4s3JwxAr/eiay0vZVrgIYmquZcXzcnejHUZWAS3wArDXMcxTD9BuTHl1y1
         57bA==
X-Gm-Message-State: AOAM533h+VRXOF+cWtrpTwWSlnfjXsoELsh8e4iK6+ZVzvZJb1GnsYsA
        aJD9oGhP/3YILlThcDYD0w5p6glMyf5CoQ==
X-Google-Smtp-Source: ABdhPJxdx2TKqm0pLmgR7d1fDKOG0bJLYAWfk+QnDOm44VGny/BtgzNjfWog0nE8PkIoxQZffWmcXQ==
X-Received: by 2002:a17:906:3b13:: with SMTP id g19mr23557226ejf.360.1624287267894;
        Mon, 21 Jun 2021 07:54:27 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id da28sm5943413edb.0.2021.06.21.07.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 07:54:27 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Josh Steadmon <steadmon@google.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] trace2: log progress time and throughput
Date:   Mon, 21 Jun 2021 16:51:53 +0200
References: <20200512214420.36329-1-emilyshaffer@google.com>
 <871r8w3sxu.fsf@evledraar.gmail.com>
 <CABPp-BFDfCqpDGZ1D=U6V5--KkcuCJON5-CcX-PVLcvH4pc5cg@mail.gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.12
In-reply-to: <CABPp-BFDfCqpDGZ1D=U6V5--KkcuCJON5-CcX-PVLcvH4pc5cg@mail.gmail.com>
Message-ID: <87pmwf2rq5.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 21 2021, Elijah Newren wrote:

> On Sun, Jun 20, 2021 at 6:32 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>> On Tue, May 12 2020, Emily Shaffer wrote:
>>
>> [Replying to a change long-since merged into git.git's "master"]
>>
>> > Rather than teaching only one operation, like 'git fetch', how to write
>> > down throughput to traces, we can learn about a wide range of user
>> > operations that may seem slow by adding tooling to the progress library
>> > itself. Operations which display progress are likely to be slow-running
>> > and the kind of thing we want to monitor for performance anyways. By
>> > showing object counts and data transfer size, we should be able to
>> > make some derived measurements to ensure operations are scaling the way
>> > we expect.
>>
>> Did you end up using this data for anything?
>
> I know you were asking Emily, but independently, I found it useful
> while doing merge-ort and diffcore-rename optimizations.  I thought it
> was a clever idea for quickly adding more measurement regions easily,
> and wished I had thought of it myself earlier.

Indeed, the data's useful. I'm just wondering about the key name.

I saw after I sent this that this was brought up when the patch was
discussed, and the name was just left in there:

https://lore.kernel.org/git/8f159f13-ed61-61ea-8e9a-c1ffbc5fddb3@gmail.com/

