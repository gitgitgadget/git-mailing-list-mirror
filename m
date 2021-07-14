Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1900CC07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 12:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAD0C610CB
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 12:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbhGNMFa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 08:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbhGNMFa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 08:05:30 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0998C06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 05:02:37 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id dp20so1059042ejc.7
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 05:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=wxlp/Pn+7Z7Dd6ROwBVJl4F3y7raa9jsm1VC9dR18m8=;
        b=YPSMbDJrtGCiDtbYnqVm3pIHa8bJGWaOCT/yvScHLl9heV1kJqdAtxCv1R276XckiT
         ipkTBQGMqHLyorM9K1OyiK8heTeKpJ61Rf3HEobSIIE/bvjL/ZN0o1+ZKNc0jrw0wGDl
         Um62bWpRDbDwnNWhJMf0ah8CWXnR5HcLD6qawlP15eAUm3Pa4SEMVJyY1zkh3+BUKGNf
         xJOqwTD1YxXi8YNNdv7dgOzs0byxFLPM5d47KCRUmfZ4qegjBELjWE0DAxELHYaVXfEo
         DXeBIbUzGCjAcB2zm0uKeEdXPd7FsqkypdSW+UYnoWZ0Ip4MG0H6f2jl1vlVgAVq1Zk8
         oWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=wxlp/Pn+7Z7Dd6ROwBVJl4F3y7raa9jsm1VC9dR18m8=;
        b=p1IWt3tP4nNzkynuoToZhxmyZHmgrMp9c8V68Ao+hDekQjeOJurdQvxBN/8MrzYV21
         P22S9JR1dh09ss4OK/UFI8FT6ZGA6VpNO+MJJyb+rCex0HxYUIdt692GZGwcjEJBeBA8
         OYTDJ9jYnP9AcdM8CzPBOYDTpxpej5ehrAzNuj+Trvql5hLEntGifwA0OzY4Uya02Rgf
         09wE5W97ZnDRUS/GAxUZq1jdRpyPtEPNz+O2xs8QlmU7ATnKVDg1HY8z4p1QSeQiL35R
         ewsWThEridol+DOJQ2eAyGhH+4OemFY4OjASSmuQNY0j2/DcwOReRG/oS6gtnS1Gi+/F
         OUzQ==
X-Gm-Message-State: AOAM532phno2iL/DF/Fz1RkltsyN3dT85Cncrv8O3dKwLZCc/QjZkTpE
        +St2DHMw2HahOqhRWGCeSFoKsew/oIuxlfEU
X-Google-Smtp-Source: ABdhPJw5VQCce2p0sd+B3N509pCxrKLIbtp9j5JqWd2p52DcsPZT7Ibd9Qd1h21LvdWitqorIMKCog==
X-Received: by 2002:a17:906:c34e:: with SMTP id ci14mr12286279ejb.199.1626264156067;
        Wed, 14 Jul 2021 05:02:36 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id z10sm703284ejg.3.2021.07.14.05.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 05:02:35 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2021, #03; Tue, 13)
Date:   Wed, 14 Jul 2021 13:54:57 +0200
References: <xmqqmtqpzosf.fsf@gitster.g>
 <CAFQ2z_P=9Suh0kO6E44hUOyNFOAKcmcUg_x6AQFP9jhHrBA6RQ@mail.gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <CAFQ2z_P=9Suh0kO6E44hUOyNFOAKcmcUg_x6AQFP9jhHrBA6RQ@mail.gmail.com>
Message-ID: <87fswh14ta.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jul 14 2021, Han-Wen Nienhuys wrote:

> On Wed, Jul 14, 2021 at 3:07 AM Junio C Hamano <gitster@pobox.com> wrote:
>> [Stalled]
>>
>> * hn/reftable (2021-05-20) 27 commits
>
> I have some updates for the series pending, but I'm waiting for the
> preliminaries (test fixes, the errno stuff) to hit master.
>
> How do other folks deal with dependencies between topics?

Not very well, but maybe this works for you.

If I had say a "ab/reftable" locally and it depended on
"ab/refs-errno-fixes" I'd rebase ab/refs-errno-fixes on top of
ab/reftable, and set the upstream info ("git branch --set-upstream-to")
to my pushed version of ab/reftable.

Thus "git log @{u}.." in "ab/reftable" gives me changes as of the
"ab/refs-errno-fixes" "base" topic, and git-format-patch/send-email will
send patches as of that topic.

Of course when you send this to the list you need to make that
dependency relationship clear, as in my just-submitted re-roll of
your/my refs.c errno changes:
https://lore.kernel.org/git/87im1d156t.fsf@evledraar.gmail.com/

I have no idea if/how this would work with gitgitgadget, which I think
you exclusively use.

