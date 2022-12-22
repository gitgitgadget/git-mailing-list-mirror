Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92ADC4332F
	for <git@archiver.kernel.org>; Thu, 22 Dec 2022 09:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235035AbiLVJgU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Dec 2022 04:36:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiLVJgS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2022 04:36:18 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A40DC5
        for <git@vger.kernel.org>; Thu, 22 Dec 2022 01:36:17 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id i15so2163521edf.2
        for <git@vger.kernel.org>; Thu, 22 Dec 2022 01:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gJ7Mk+PhVJTfkXOnNF41jtH5Z/GSUGpw7KBcDHWwf4c=;
        b=oAxgerUVDoiLe76IqC++11Cb0ftrCPsdY9fcDEPhM+M/BpNotQlFty0uoL9w6ph50g
         Ad0mO2krNViS05v5EtLeWlfHUOs9dsJRWPDW00wdw9DHolXrHqC8+zORRaShxsohfVki
         PfekEIZADvsYU5/BWPtJU4o7ehHAt5kqjBIDhbp21iuqRt5CK9KTM6Hk5qmNcZZtwMF1
         pTqHIuXQ/GlCK9nlwwzQUIuDOmiJYiih9E8eHsndeMDReEuH0oGdBAoULThbncyieuKr
         +XiNBUUVIYTfUOC7s8ysBhugBAmATrt1Su8WEv1/GCLEw6C0/pOlejR1GRzE8UJlbAps
         QNXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gJ7Mk+PhVJTfkXOnNF41jtH5Z/GSUGpw7KBcDHWwf4c=;
        b=o2SAG033oQqaXq7nl+kfhdR4+tD8olQaejmSX6ehnqv+dEN29pRbmAeOPepTSKjoCJ
         j+jXeQk/BwBoCROs61IriT3VCt9FYXR39yYpnZL4Cr4d/gHx2bNqIjO9GJw56mPsiKnh
         eko8pft9Z9kSh+kSlg6589j1HHa86n4mxoXylNSORU1gAjTa4eoyP0Yhn+7a6Lsuinhd
         yonPcHFeC844L5glL7JZDwZlGOCTGJOuKIMMIs02EAUuJw4vdXJRcCi4CCSSbgLtc0TS
         NhPBNzTUKodULfTcBNFsOliArISeULOw5fnEoaoOaoJKdMyEplNwbRboKVOOPzePvtnJ
         uUpQ==
X-Gm-Message-State: AFqh2ko9+zKBOYMxgLn0a0mTaRrPbIZ2U9282tufU9wwGUphHctXiOkc
        HiaREoqnAUpF+2vUQMHqs6I=
X-Google-Smtp-Source: AMrXdXu0mnZhOYc0xAjqkYYzy77QY7rcs8b1m1jvkUB4SG2ure7DSkjL4HPwtVZ4r9B+3xLWfys1Ow==
X-Received: by 2002:a05:6402:e83:b0:463:c4f5:ad1f with SMTP id h3-20020a0564020e8300b00463c4f5ad1fmr4648661eda.11.1671701775940;
        Thu, 22 Dec 2022 01:36:15 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id g24-20020a50ec18000000b0046b847d6a1csm181445edr.21.2022.12.22.01.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 01:36:15 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p8Hzr-007aTy-05;
        Thu, 22 Dec 2022 10:36:15 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 0/6] remove USE_THE_INDEX_COMPATIBILITY_MACROS
Date:   Thu, 22 Dec 2022 10:32:21 +0100
References: <cover-0.6-00000000000-20221215T095335Z-avarab@gmail.com>
        <11545cde-9ce2-acf4-7c08-1b49d2dbefa2@dunelm.org.uk>
        <221219.86cz8fzara.gmgdl@evledraar.gmail.com>
        <a6efeaa9-0995-1d1e-a557-e320fbfe5d2b@dunelm.org.uk>
        <xmqqili6zxj1.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <xmqqili6zxj1.fsf@gitster.g>
Message-ID: <221222.863597wzjl.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 20 2022, Junio C Hamano wrote:

> Phillip Wood <phillip.wood123@gmail.com> writes:
>
>>> That's correct, although even if that were the case that wouldn't
>>> be an issue with this migration, as we'd have been using
>>> "the_index" before, just indirectly through a macro.
>>
>> Indeed, I'm just not convinced that it is worth removing the macro in
>> library code without changing to take a struct istate (I don't see the
>> existence of the macro itself as a problem as I think it is just a
>> symptom of the real problem) but I seem to be in the minority on that
>> point.
>
> True.
>
> Many subcommands need to deal only with the_index and no other
> index, so for the implementations of the top-level subcommands that
> work only in a single repository, the macros are not by themselves
> problems.  The deeper parts of the system that we want to reuse by
> libifying of course eventually need to learn to take an arbitrary
> "istate" and NO_THE_INDEX_COMPATIBILITY_MACROS mechanism (and its
> successor USE_THE_INDEX_COMPATIBILITY_MACROS, probably) was a great
> approach for that goal.

I'm not sure what to make of this comment & this series not having been
picked up (perhaps I'm reading too much into that), that you'd like to
keep USE_THE_INDEX_COMPATIBILITY_MACROS?

This side-thread is discussing a theoretical issue.

Phillip was saying (if I understand him correctly) that if we were using
"the_index" in libraries we should fix that, I was agreeing, but saying
that if that were the case this series would still be a good step
forward, we could fix those issues later. It looks like we disagreed on
the "later" part of that.

But in any case, as noted at the start of this thread there are no such
library users, so it's a moot point.
