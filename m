Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA406C07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 19:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C27AD6192B
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 19:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbhGFTdZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 15:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbhGFTdY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 15:33:24 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD092C061574
        for <git@vger.kernel.org>; Tue,  6 Jul 2021 12:30:44 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id bu12so36059737ejb.0
        for <git@vger.kernel.org>; Tue, 06 Jul 2021 12:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=2TEYTdyk3okZnF3xXblM+cI3dVZf/742LyNky7msnO8=;
        b=NlnVCMD7XAwmiN7MJlLFo8WiSan5BCCSAINvimrNxvA9bypHvw8bjOf3z7ZIHT5zIW
         HiOSYEXGGrdidNCiXQpykf/OYJHLA6iwzvlHfVs9xY6Wr1ZukOfLHNL/TmsVsEP0q213
         h+PV1ExDN+K+QoFjYreWd5M2+wW+F9WKSvJYOlPCvzD+hPew9Eq2ndWmpmXId/CqeVco
         5Z0f4U0pOoR4qSp+yLaQB9+zeaoaPx6OLHFXxaHZG29sCxzrhqgH2sCUEmI1fS5nHtdO
         BN5f44zoRJzKISq/Nx/jwPnDjf23vHKyNDwIiHtfzA2lyOELvfSbulV+hQye4YNjRxRP
         rriw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=2TEYTdyk3okZnF3xXblM+cI3dVZf/742LyNky7msnO8=;
        b=HueobQmsdbKIHQi4CT3nMFFYFyfdUddyrBPiTx9mKY649Q++XGaj+Nw8pT3YwhDXMF
         DA1alfwX5egfD5iCU4Us3F3QHzGT47pw9oVGFafwo2MPbTnytgbonLACJ3HVj43+jdeX
         o25iQN2Hf4EWbKD7zpNqzu4RgeJyyjhS4df1xTz/ESOBEpF6QC9uisXoyDch6lGhxd99
         6VZUyOJq3BxWrD8wyCS3LkSOGDpo6PM8E2OFWeWu2OaAgn3Bn5EKbTqur2Rfo/1yuv9D
         6S6HdgtMMiemYe4YRjxTAYlLy+xhxijhwP2rTkJMB83UwedvUqllKcQ0Mj793Zd9Vem5
         nzlg==
X-Gm-Message-State: AOAM530ogiqq+jeu2U5O942uWNI66fC3N1ejNNdqc7lz5IfaGlTRnxH0
        2IozRQs+sr8/4J/mxj0lz6g=
X-Google-Smtp-Source: ABdhPJxyF2lVRrf6pFS76OS3yCQseHZBNFsuoWx7AYX+cPHHA4uk9WeJtDuZtOukSq8aeQn+eQ7KKg==
X-Received: by 2002:a17:906:b0e:: with SMTP id u14mr15541098ejg.185.1625599843051;
        Tue, 06 Jul 2021 12:30:43 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id h14sm6164754ejl.118.2021.07.06.12.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 12:30:42 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: What's cooking in git.git (Jun 2021, #07; Wed, 30)
Date:   Tue, 06 Jul 2021 21:29:38 +0200
References: <xmqq4kdft122.fsf@gitster.g>
 <CABPp-BGF4K4mAXf6X1rTpTmPCfQgwdhv_VUVg2icGk5Dw7Q1yw@mail.gmail.com>
 <d04c71fe-acfb-abe0-b00f-cfa01651dd57@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <d04c71fe-acfb-abe0-b00f-cfa01651dd57@gmail.com>
Message-ID: <87k0m35jfi.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 06 2021, Phillip Wood wrote:

> On 03/07/2021 06:04, Elijah Newren wrote:
>> On Wed, Jun 30, 2021 at 3:58 PM Junio C Hamano <gitster@pobox.com> wrote:
>>> * pw/diff-color-moved-fix (2021-06-15) 10 commits
>>>   - diff --color-moved: intern strings
>>>   - diff --color-moved-ws=allow-indentation-change: improve hash lookups
>>>   - diff --color-moved: stop clearing potential moved blocks
>>>   - diff --color-moved: shrink potential moved blocks as we go
>>>   - diff --color-moved: unify moved block growth functions
>>>   - diff --color-moved: call comparison function directly
>>>   - diff --color-moved-ws=allow-indentation-change: simplify and optimize
>>>   - diff: simplify allow-indentation-change delta calculation
>>>   - diff --color-moved: avoid false short line matches and bad zebra coloring
>>>   - diff --color-moved=zebra: fix alternate coloring
>>>
>>>   Long-overdue correctness and performance update to "diff
>>>   --color-moved" feature.
>>>
>>>   Waiting for reviews.
>> I read through the first half the patches or so and didn't spot
>> anything wrong, though I'm very unfamiliar with this code area and
>> don't yet understand much of what's going on; it was more of a spot
>> check.  I'll try to get back to it again, but my review probably won't
>> be that deep.
>
> Thanks for taking a look, do let me know if I can do anything to make
> reviewing this series easier

FWIW I put it on my own mental list of "waiting for re-roll" per [1].

(Not that you need to take my suggestion there, just that you seemed to
agree, so I thought I'd take a look when that happened in a v2).

1. https://lore.kernel.org/git/094f5e5f-d447-8867-a9a7-be5c8827bba6@gmail.com/
