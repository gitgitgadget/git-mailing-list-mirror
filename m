Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7034AC77B73
	for <git@archiver.kernel.org>; Tue,  2 May 2023 04:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbjEBESz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 00:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjEBESy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 00:18:54 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7813AA1
        for <git@vger.kernel.org>; Mon,  1 May 2023 21:18:53 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-38e5c33305cso2431075b6e.3
        for <git@vger.kernel.org>; Mon, 01 May 2023 21:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683001132; x=1685593132;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4MPht0ErPQanVrQNE4vEwniQwwFnCwTwoQmXshtTQEI=;
        b=DREVludBlI2AS956InXgKmau7E8XLzC24GkpzPulTgiWXCJAzvb4NdwOdGAmgzujR5
         /NJ6cZMkYhevIH6wJzzrnDnkpNiIgLsY4V7yIK3zDc1EicdXC+T7JcTB+9HieliasXAt
         CUHOQ5RqixF5OAwi3lEgshr5QcW5tokVKZoG0yQZKAYPRolW/RhqbmwxATFG74nX95Wr
         iuKKeyQfs3R9x1vvkq5kWFY1vjhOU6Z6mhzT6Fi8s0HQYdNCq+JBbBlWaD2drjxpA12n
         ylKf62S9IFsec35rlKFepe9OgJNXIWoXeZqhH2NKb7B4W+/6DINcK0BruBbqNsPavOml
         ypCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683001132; x=1685593132;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4MPht0ErPQanVrQNE4vEwniQwwFnCwTwoQmXshtTQEI=;
        b=el7tCueaz0F/tz4deiB8kGC9RqBIyPhX1CDal0jIXzQHESICHrwTrJ7onoPznLvx68
         cJ8rqaZpuDuXGguCJ65entXXL5Vqhs2UZ4YW4qpawAxT6cr6hnvvE9W91qfUO1rBWHzF
         cntkWWboU88v1J0Q7uZClm3zCRxicLspCNckBz7SFs+foDgQfxiZWHhY0hhgSLt7s28J
         hrNn6c2u9tEq7ISQ9F2segws4RzSX78aWzYA7+X/ARwBazCvoPipy7hPl6S/PltPBayP
         bGMk4YcIDDC2RTBRPx9Sc99BeO2h4KTp5lthcbxAuw0OJQgepx0l7t/NdfNnEcdvqgjB
         rLzg==
X-Gm-Message-State: AC+VfDwaRWfYm7EE/X0cnJYjAz5EBon7ibZoQWQ6lV84nYvlzA1UpZQG
        4Z36/xy1xOhSDlgdjqY58Xn/yYUBjtA=
X-Google-Smtp-Source: ACHHUZ6rU005EpBDxFPW+a6TZgGMpbw38+SChOGEbp5W7TjG11MA1VjyHbtUeyfPuedKm3vNi4JuMQ==
X-Received: by 2002:a05:6808:4249:b0:38e:571c:70c5 with SMTP id dp9-20020a056808424900b0038e571c70c5mr7401209oib.30.1683001132183;
        Mon, 01 May 2023 21:18:52 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id n66-20020acaef45000000b0038c0a359e74sm12200835oih.31.2023.05.01.21.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 21:18:51 -0700 (PDT)
Date:   Mon, 01 May 2023 22:18:50 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>
Message-ID: <64508f2ac80a5_1911029468@chronos.notmuch>
In-Reply-To: <20230427175007.902278-1-calvinwan@google.com>
References: <20230427175007.902278-1-calvinwan@google.com>
Subject: Re: [RFC PATCH 0/2] add an external testing library for unit tests
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan wrote:
> In our current testing environment, we spend a significant amount of
> effort crafting end-to-end tests for error conditions that could easily
> be captured by unit tests (or we simply forgo some hard-to-setup and
> rare error conditions). Unit tests additionally provide stability to the
> codebase and can simplify debugging through isolation. Turning parts of
> Git into libraries[1] gives us the ability to run unit tests on the
> libraries and to write unit tests in C. Writing unit tests in pure C,
> rather than with our current shell/test-tool helper setup, simplifies
> test setup, simplifies passing data around (no shell-isms required), and
> reduces testing runtime by not spawning a separate process for every
> test invocation.

I agree unit tests would be very helpful, but they don't need to be written in C.

I sent a RFC patch series [1] attempting to write unit tests, but using Ruby, the
testing framework is less than 100 lines of code, and uses Ruby bindings to use
the C functions.

I think writing everything in C adds a ton of unnecessary complexity for no
gain. In fact some things are simply not possible, like dealing with crashes
without forks.

Modern languages exist for a reason: C isn't the best tool in every situation,
and I believe this is one of them.

Cheers.

[1] https://lore.kernel.org/git/20230502041113.103385-1-felipe.contreras@gmail.com/T/#t

-- 
Felipe Contreras
