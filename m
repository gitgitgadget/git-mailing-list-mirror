Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6442E1F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 16:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934418AbeGJQZ6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 12:25:58 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37725 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933506AbeGJQZ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 12:25:57 -0400
Received: by mail-wm0-f65.google.com with SMTP id n17-v6so25019613wmh.2
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 09:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Wu2HOJEiJdNQEUUIuwC6ZaHIqeuRdp54D9HV+y9BR9A=;
        b=HtpZczoNjWY4fj4YhVxj3kFAR3VYmP1jNcRVmXw+ielE6+t1gSc9bsCdKkTCffE06G
         7S9JLIxlBZgHKyYMsSR3XLRWRM1Ttvv4L5ibbFXW1c585zZQjm4F+PQoWq3/pRs4KIVV
         qLTAGWrO/3Kb7PzbYywRFN/Hj7NHxBy30Pb6kKenx/Jl8quDYa27cO/bdyf5CMr49oLC
         Anlnal6E4caowVQfybYgaSZQZzzeyuqyvE9z1b78poiiUZIcINhC+O5x4xYv9tm9KUK2
         QpY/ZNc/wH9i01nSpXWTfmabPHBnbc+Ln0xTI0QCP+LnDg+zaT2DRlYGcaf4bSXmgZqj
         a4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Wu2HOJEiJdNQEUUIuwC6ZaHIqeuRdp54D9HV+y9BR9A=;
        b=gYEQZcm2Ri9Qkaq36dUdWJR0rpUc6kjEAsfkEvRsjqVShqMMg7xDnaH6oygI8SiI2m
         W8QXpmNiWUniQUke2apuHR5Sd2/rCEEutGPLB42Esg/lL432kaNaembwa65L8FW6Tnpz
         hqXlWToH6ra1qgus3suPUenEW3xLuA7c7aTABhaalO7a4bvgFJoz3RIWsWibjf+O6oqh
         e9gxoxy5HNT61rYf4kpmHyLspFcbONUux/zDPDF2a1vM8cZI+FVgGVvuvlFkRv0omj0U
         TTChHBdOhJ9yzMWnp8KAmjK3qtBeXN1qdyUzh0p5C50H536Srup/zaAI4M8ekfDRHFQU
         Lf+A==
X-Gm-Message-State: APt69E3MLPARIVxsudh4hf9RjqUkkzOE4L6UGmbKtOitLfWAFiKVAI93
        D9yp2/HA6s2QdToceHRLbPU=
X-Google-Smtp-Source: AAOMgpdguavpImtzScHXUOoTufb7A6LDvIgTl6rVPQUge7sC4OCniGmiQmeKKqRLvVfTQz4V/My7fA==
X-Received: by 2002:a1c:e5cd:: with SMTP id c196-v6mr15180966wmh.101.1531239956243;
        Tue, 10 Jul 2018 09:25:56 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id x16-v6sm29802264wme.12.2018.07.10.09.25.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 09:25:55 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     larsxschneider@gmail.com
Cc:     git@vger.kernel.org, peff@peff.net, Johannes.Schindelin@gmx.de,
        jehan@orb.com, whee@smaertness.net, me@ttaylorr.com
Subject: Re: [PATCH v1 1/2] convert: refactor conversion driver config parsing
References: <20180708183036.29459-1-larsxschneider@gmail.com>
        <20180708183036.29459-2-larsxschneider@gmail.com>
Date:   Tue, 10 Jul 2018 09:25:55 -0700
In-Reply-To: <20180708183036.29459-2-larsxschneider@gmail.com>
        (larsxschneider's message of "Sun, 8 Jul 2018 20:30:35 +0200")
Message-ID: <xmqqa7qz9hws.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

larsxschneider@gmail.com writes:

> From: Lars Schneider <larsxschneider@gmail.com>
>
> Refactor conversion driver config parsing to ease the parsing of new
> configs in a subsequent patch.
>
> No functional change intended.
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---

The change unfortunately makes everything indented one level deeper,
but I can see why "we look for the only thing we are interested in
and return early when given anything else" that allowed us to avoid
the deep indentation would get in the way of the second patch.
