Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AD511F453
	for <e@80x24.org>; Tue, 23 Oct 2018 00:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbeJWIot (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 04:44:49 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56052 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbeJWIos (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 04:44:48 -0400
Received: by mail-wm1-f68.google.com with SMTP id x6-v6so675990wmc.5
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 17:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=9nR/c7KPwmJD2V3T/JxvaxZCTZHBx1TbHOMOYuE95oE=;
        b=n4/Jdq1RSiBwRst2uakfLsqa53AOJwQ2PJxbVvMdTNn6A0PR9t6/YJTs7JZFkc0DE/
         TMT3QN7lMHxP1bF7K7XHHCH5Hjj1zOuxBVYXGOARGKffseeM1c7h5R7z72Nr9NKQLC5N
         iTmaf8eh6Oy+Xtxqh3hXmDNuv7QKDH2Zuy3Ye59MewSp1Usjmf2E3QgcMKRdMHBeQ7CA
         EPAV8BdC9FKgUDHF85Ow9CaPDhft/kB7PHG0NuqCsyz16LrKB+0irz5095noRi6G0OVL
         1gdeiyNi0zhHlJ0DwALqlqLzPBl920eqVVNQqk2HYlxaOiPf5V/UNDXI9Yjlhmo0Jz/D
         CGVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=9nR/c7KPwmJD2V3T/JxvaxZCTZHBx1TbHOMOYuE95oE=;
        b=jrxhsYZcLdKZq0cgZ2Be0xU2//eRVyki/bKbONvHBzvAx/L/5PVrpv7veUP2syG6zG
         QpsT4+zo6UJJNm9iBhxqcmo77usyM3wbr5WmID7Kptg4RoexqZmRGSAGbAiM6+B5zSOk
         +cETB7A3fLSM5IhBuFi1ccCoxjxKyl4TocUVnGKRUEpPxRJgOf4U9NI2mNg6OzEdZXUT
         OII4Gp96W92SJbYWl9g/ppMYGcQy1A/ycTNYYIHrW4IaCHJE0yAiUCB3MdQHyQynDgOX
         HD7ue09CR2slg1RYER2qTHMPq5d0tnf/rtJ/kcpRRltv9+MwRS+LpRIn0JL1Fvy4sF6b
         YhDA==
X-Gm-Message-State: ABuFfojcU/sEnNtkuECEDK3s9YuKIjFvvNINLFTA1nRsMXlyPsyN2GK9
        0DOf6gr5xVvvGq1TyBmiLnVN26yLXSI=
X-Google-Smtp-Source: ACcGV60oDB4rVmMKxwMEY3NEYdWk+7lx3o44v2+Eux//oNV/F0Jyo4iAuK8h7y2IBVcaQF4QZarxiA==
X-Received: by 2002:a1c:e0d7:: with SMTP id x206-v6mr17292573wmg.93.1540254237735;
        Mon, 22 Oct 2018 17:23:57 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id o13sm23277610wrx.53.2018.10.22.17.23.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 17:23:56 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     git@vger.kernel.org, benpeart@microsoft.com, peff@peff.net,
        sunshine@sunshineco.com
Subject: Re: [PATCH v3 3/3] reset: warn when refresh_index() takes more than 2 seconds
References: <20181017164021.15204-1-peartben@gmail.com>
        <20181022131828.21348-1-peartben@gmail.com>
        <20181022131828.21348-4-peartben@gmail.com>
Date:   Tue, 23 Oct 2018 09:23:55 +0900
In-Reply-To: <20181022131828.21348-4-peartben@gmail.com> (Ben Peart's message
        of "Mon, 22 Oct 2018 09:18:28 -0400")
Message-ID: <xmqqh8hdtsro.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

> From: Ben Peart <benpeart@microsoft.com>
>
> refresh_index() is done after a reset command as an optimization.  Because
> it can be an expensive call, warn the user if it takes more than 2 seconds
> and tell them how to avoid it using the --quiet command line option or
> reset.quiet config setting.

I am moderately negative on this step.  It will irritate users who
know about and still choose not to use the "--quiet" option, because
they want to gain performance in later real work and/or they want to
know what paths are now dirty.  A working tree that needs long time
to refresh will take long time to instead do "cached stat info says
it may be modified so let's run 'diff' for real---we may discover
that there wasn't any change after all" when a "git diff" is run
after a "reset --quiet" that does not refresh; i.e. there would be
valid reasons to run "reset" without "--quiet".

It feels a bit irresponsible to throw an ad without informing
pros-and-cons and to pretend that we are advising on BCP.  In
general, we do *not* advertise new features randomly like this.

Thanks.  The previous two steps looks quite sensible.

