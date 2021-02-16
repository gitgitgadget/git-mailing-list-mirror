Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5008DC433E9
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 13:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28BE864E02
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 13:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhBPNAr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 08:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbhBPNAq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 08:00:46 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1540C061574
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 05:00:02 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id w1so7232106ejk.6
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 05:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=X1PAf0n/G9uV/HH8XIMgR51FIl9fJBwaYpXrpauhkrQ=;
        b=Vt5wwc8cYxdRYjo0pbl2cWX6r9Q2W2QBEXSkZVwz5VixUh5YZcyVvRFTpku7mmGiGQ
         UzQi4+paa8hXn2KUt3Prhl5WfyJ+HIKylxdrIDZTt++ql6b7QEbYc6RdnXWPrtppOtfj
         N5cuYFo/EbsNsN2GHBRqku24uB0Lo3B935OtxmJcaFPA7ruXxeg31Wh+cV1t3lUAJdqp
         LO8XiJ8WvD51Pn65g4r/XpELDM46AXHUq8ym8dZc69l+vSNT/Qo14DV+6S+GjZTV8KKD
         PNMl8YgHdIq+pngMQJAsbuc18A5j9Jd4vTO0LJe0xSUwt62xzkEPgw/YCxuVBdW+UlcQ
         R7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=X1PAf0n/G9uV/HH8XIMgR51FIl9fJBwaYpXrpauhkrQ=;
        b=Lw9MamNIMpvibTaA2/DsnqU+HOHqsD+QTm8eVoZ8rbj8wD81xUMOSYyNdDKxXzU87T
         tGwPZ9H37LnQb2+vOgVbXgvgX/YkL+MT4nL6ImACEhChtjxhuk9nF8X0d37Qi8NNbLUB
         mjgEzn2Afs3/YzYakyJYGblnFZjppzJ1IQlCpEGAGUmcnMeIPVHZjrJOVGMLp+Oz1uNz
         RzUrkMPJPjwwn2UMpYtuDZgn0kkcVCoatdDwn5aa373BJ32NKSeJ3jLTu5jtDRqoJybn
         myfMKlqOD1lZ6TYTgwHrFfW5gM39VjWc5P5BO6ppq9iwVl+nll21BZ3sd7HCzQz6g6sl
         5AvQ==
X-Gm-Message-State: AOAM530sSBDoHy76RK0aHgx4tzGBzOSyA0roBSH43WEXYG39vJtp6/Rg
        uhSYSol3C1V3dt8RTlji21Q=
X-Google-Smtp-Source: ABdhPJyUekgvdQmYMv84fG9lEP+fhSuLXrSbrk/HHWi3gGL3lNxrnpoZVeDriO8F6mBwM3gb5UnEpQ==
X-Received: by 2002:a17:906:4543:: with SMTP id s3mr20098999ejq.258.1613480401402;
        Tue, 16 Feb 2021 05:00:01 -0800 (PST)
Received: from evledraar (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id hd39sm12536398ejc.116.2021.02.16.05.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 05:00:00 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Eli Schwartz <eschwartz@archlinux.org>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] pretty: add %(describe)
References: <7418f1d8-78c2-61a7-4f03-62360b986a41@archlinux.org>
 <5561d11b-08c3-bcf7-5d37-a7d6c6bfb715@web.de>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <5561d11b-08c3-bcf7-5d37-a7d6c6bfb715@web.de>
Date:   Tue, 16 Feb 2021 14:00:00 +0100
Message-ID: <87pn109nhr.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Feb 14 2021, Ren=C3=A9 Scharfe wrote:

> Add a format placeholder for describe output.  Implement it by actually
> calling git describe, which is simple and guarantees correctness.  It's
> intended to be used with $Format:...$ in files with the attribute
> export-subst and git archive.=20

Does it really guarantee correctness though? In "builtin/describe.c" we
first walk over the refs and use that to format all N items we're asked
about.

Under "git log" this is presumably in a race where refs added/deleted
during the run of "git log" will change the describe output to be
inconsistent with earlier lines.

> It can also be used with git log etc., even though that's going to be
> slow due to the fork for each commit.
