Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21614C47089
	for <git@archiver.kernel.org>; Fri, 28 May 2021 03:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5EDF601FE
	for <git@archiver.kernel.org>; Fri, 28 May 2021 03:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236305AbhE1DNJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 23:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236290AbhE1DNJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 23:13:09 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AFEC061574
        for <git@vger.kernel.org>; Thu, 27 May 2021 20:11:34 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id i13so3152006edb.9
        for <git@vger.kernel.org>; Thu, 27 May 2021 20:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=JFvXMv7IxwfglCuCw/qJcWom4eIJlgxxlwbKyQdNJI0=;
        b=AWK0Qc0YqDjq1nzBMGDX4nNjkN8a7hhf2a38/hUTNzt02omAg/Q6LDYWxOwnx3kEcf
         mlctkxEeItlfLiK6cpyfk/W3AKwWUp02kQ4XIoczxBiKHVXagwO65tRpMXb3UGyIeo+L
         lWYAec+5GAukeYiUQJ38jq5DO/1gEgC6yRMYkOWYS5SeW58faqrdW6SM3eGyvZH0N3PI
         AGhmOTgXZrHp14AhZF3ukbhAjLqtplV+T7zjZmdYgcjOjj1TtW4CVIPOHhMGd/qANiau
         apH/uRwA6RhNdw2ZaekKNbZrTVavnCJF2Wa/rbArzwWeWVoYPB8QRB6uwIiJU2pN8Jy4
         fujA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=JFvXMv7IxwfglCuCw/qJcWom4eIJlgxxlwbKyQdNJI0=;
        b=uHqaNyu6zu+BuobND3XqgLIt3D8XuCFHmc9B6b+VN7cUaSfQd1aZZ8tLRkzJpyppEZ
         WX0cdHZVoTeBIIsECVggUfR024jOJRiuiw66k+Iwd4i9qju11cncB68vnfD1iFiTINl4
         XgTSX6atVWejp4l2N8172iE780Vr1gdjhc7zKmxPzSzmnqmdf8hpFWPjZlc6Hsy1X4Yc
         wtC/KZZr3UO9y7rDk1oa85d4R7aQbeByQRrAWc6LtifM2k3xwlxlUUt/oDYDNqNGms2x
         y8VVssGmV1qihQ7MxWPqjZxqHEe0tmIY+RycBKFFah9RdbaunCHQx62ikFFDtrUCrXUP
         M1/g==
X-Gm-Message-State: AOAM532pYJVC8SXhUS9OCJ1PWBEDXVIeQiJDgAxuQy/BErWWafX+UJXx
        u8/IAwAhd1UtnJ7iMbNtDl5vW6Mdn88=
X-Google-Smtp-Source: ABdhPJyWXm0rxxMKyE7vrRgYP28guBabII0kkUGaTSnApRGB1+xZvglLPWGRKhU3kXC2aiQtxL1WFA==
X-Received: by 2002:a05:6402:40d0:: with SMTP id z16mr7677208edb.104.1622171492865;
        Thu, 27 May 2021 20:11:32 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id sb14sm1753174ejb.106.2021.05.27.20.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 20:11:32 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 04/17] cat-file tests: test that --allow-unknown-type
 isn't on by default
Date:   Fri, 28 May 2021 05:10:26 +0200
References: <cover-0.6-00000000000-20210328T025618Z-avarab@gmail.com>
 <cover-00.17-0000000000-20210520T111610Z-avarab@gmail.com>
 <patch-04.17-871b820003-20210520T111610Z-avarab@gmail.com>
 <YLAMdYtd77l2g6SP@google.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <YLAMdYtd77l2g6SP@google.com>
Message-ID: <87cztblfh8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 27 2021, Jonathan Nieder wrote:

> Hi,
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> Fix a blindspot in the tests added in the tests for the
>> --allow-unknown-type feature, added in 39e4ae38804 (cat-file: teach
>> cat-file a '--allow-unknown-type' option, 2015-05-03).
>>
>> Before this change all the tests would succeed if --allow-unknown-type
>> was on by default, let's fix that by asserting that -t and -s die on a
>> "garbage" type without --allow-unknown-type.
>
> nit: "tests added in the tests" seems oddly repetitive.
>
> More importantly, I'm curious about the desired behavior here.  The
> idea behind cat-file --allow-unknown-type is that I can use it to
> inspect an invalid object, for example after it has been reported by
> git fsck.  The commit that introduced it (39e4ae3880, "cat-file: teach
> cat-file a '--allow-unknown-type' option", 2015-05-03) gives the hint
> "query broken/corrupt objects" in the documentation, so I figure
> that's what it's for, and I'm sympathetic.
>
> But: why is that an option instead of something that we always do?
>
> In other words, is there some situation where I would not want the
> more permissive behavior from cat-file against a bad object?

Yes. I suggested as much in
https://lore.kernel.org/git/87r1i4qf4h.fsf@evledraar.gmail.com/

For this series though I'm sticking to testing for the existing behavior
+ fixing the immediate fsck issues. I've got some local patches queued
up for after this topic lands (after I re-roll it, re-submit etc.) that
do that.
