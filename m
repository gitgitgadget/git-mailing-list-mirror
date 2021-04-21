Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8188C433ED
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 11:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F7DB613E0
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 11:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236722AbhDUL5r (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 07:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233957AbhDUL5p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 07:57:45 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA0FC06174A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 04:57:11 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id mh2so41546378ejb.8
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 04:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=ajliHNuGKqKtTuChpdnsVzpdSWEjKQuzOh2s8SvuZvE=;
        b=AUDYDIphrKDiaTfLz5lszG9RVArdVZzW6FUTZeuArLbs3wCRZRoBxbJ/Ik4AGMi5JC
         4gdBkpeo73sVX/VJ9+6GaffSUi8XhApjs4pSmQLfZenbkXkFTqhmMGAOCFccwMjQN+a7
         o7YXoIssZfUhlTdln4TNKEptNqxQ/Hl7Dzmn62GyvZEUGSGJqQclYmnfldPAlrmOjXll
         E9SL/2rEzzCIAPO0Xofa97FzPZul+UUjVVUi/hC8ZkCdOpQFULaPFn9kruhpDHtH4SWL
         IpVaVluRYajoY1clYFvaUndEcNBowpJ+XJY6DeRcntRyz7RebJzF2r69mmiFarHXGDR6
         o2rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=ajliHNuGKqKtTuChpdnsVzpdSWEjKQuzOh2s8SvuZvE=;
        b=D/60IFRVGH8txF5Zqj5JuqSCFVntttGXBSZ75BtblV841QYopDwaKjbvXzt0OqQDI4
         ByK/XCknWsL2vGAPYTd7Fy9lZMO+QktSP/fd+3fDLMds6NriVh12ovFIS77EfEdX1r41
         o02SVgf47lHDdGqn2ShIWzIPobEjCf8mDr4TII1DI9M0jnzNQaoa7AuyrqGk77pCRwAo
         TKgahHXJgXuQBSnfQr06PRIn82EehodXivwHBycU1N4Z50TGy8ViDAXzuGrMia/MXKwg
         4iwaEiOz4vzW5h4lPEFG1/yWOalgkVsrh25BL2OCc3ePsHx5l+IT6p+GETN01vPTakNn
         AdCg==
X-Gm-Message-State: AOAM53093BmonEpb4562CK75gVHtcqZI4xmRVDwYlPeTQTw+xmw1CTkE
        JIgbmYIJtwwiR5YPA62WxKI=
X-Google-Smtp-Source: ABdhPJyIV8u0w4UNiioD2NCht+0/GntmNiDD3tuwJ0gBaR7wDuAuUGrCvOSUXwX1YOcVsbaMsZNbiQ==
X-Received: by 2002:a17:906:8812:: with SMTP id zh18mr32480309ejb.342.1619006230273;
        Wed, 21 Apr 2021 04:57:10 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id r18sm2155534ejd.106.2021.04.21.04.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 04:57:09 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: reflog existence & reftable
References: <CAFQ2z_Ps3YxycA+NJ9VKt_PEXb+m83JdNB7ujzWw1fTPKyZ=fg@mail.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <CAFQ2z_Ps3YxycA+NJ9VKt_PEXb+m83JdNB7ujzWw1fTPKyZ=fg@mail.gmail.com>
Date:   Wed, 21 Apr 2021 13:57:09 +0200
Message-ID: <87im4f3l62.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Apr 21 2021, Han-Wen Nienhuys wrote:

> Hi there,
>
> (splitting off from a code review of my test cleanups.)

Just changing the "Subject" won't break In-Reply-To and prune CC, FWIW
the missing In-Reply-To is (probably):
https://lore.kernel.org/git/87pmyo3zvw.fsf@evledraar.gmail.com/

> Currently, reflogs are stored in .git/log/*. Git adds entries to the
> reflog only if the reflog already exists (See the log_ref_setup()
> function).
>
> The current iteration of the reftable design has a unified key space
> of {refname,index-number} for reflog entries. This causes there to be
> no distinction between
>
>   1) reflog is empty (.git/logs/blah is a 0-byte file)
>   2) reflog does not exist (.git/logs/blah does not exist)
>
> This trips up some current tests that make assumptions on reflog existence.
>
> I don't know why one can tweak reflog to be written or not, but the
> current functionality will cause a change in operation with reftable.
> I see two ways forward:
>
> 1) Have different functionality in case of reftable: you cannot query
> for the existence of reflogs, and writing reflogs doesn't depend on
> the existence of a reflog.
>
> 2) Add a reflog existence feature to reftable. We could introduce a
> magical reflog entry, which indicates that the reflog exists (but
> might be empty). This adds some complexity to the C code, but lets us
> maintain backward compatibility.
>
> What do you think?

I think we should fix the tests first, per [1] :)

Because there's a third case revealed by the test case, which would be
teased out by not entirely skipping the test with REFFILES, but
incrementally splitting it up:

Which is that the current reftable implementation is failing a test
(well, probably a lot more, but the one under discussion) that:

 A. Sets core.logAllRefUpdates=false
 B. Checks out an orphan branch
 C. Checks that it has no existing reflog
 D. Makes a commit there
 E. Checks that it has no reflog

Only the "E" case is covered by your summary above.

But no matter how reftable's behavior is under
core.logAllRefUpdates=false it should surely not be returning true in
the "C" case, because there's no log entry to serve up, and indeed the
branch being asked for has no commits.

So for that case somewhere in the guts of the reftable integration we're
losing the distinction between asking for a log that can't exist
v.s. one that's empty, maybe the reftable code is returning "yes I have
logging on" or "yes I have some entries somewhere" in that case?

And in "E", related to "C" isn't in unambiguous to not write it if
there's no existing entry for the branch in question and
core.logAllRefUpdates=false is in effect?

For the rest of this is the behavior under reftable indistinguishable
from having core.logAllRefUpdates=always set?

In any case, I don't think the emergent behavior of the files backend is
worth emulating, but maybe if some feel that way it might be better to
transition the setting in general to core.logAllRefUpdates being a
global on/off boolean, and having a branch.<name>.logRefUpdates, but I
suspect that there's not going to be any/many users of this selective
logging feature.

1. https://lore.kernel.org/git/87lf9b3mth.fsf@evledraar.gmail.com/
