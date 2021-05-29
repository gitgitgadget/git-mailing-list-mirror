Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65670C4708E
	for <git@archiver.kernel.org>; Sat, 29 May 2021 15:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4236E611CA
	for <git@archiver.kernel.org>; Sat, 29 May 2021 15:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbhE2P0E (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 May 2021 11:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbhE2P0D (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 May 2021 11:26:03 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C624C061574
        for <git@vger.kernel.org>; Sat, 29 May 2021 08:24:26 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id t22-20020a4ad0b60000b029020fe239e804so1678558oor.4
        for <git@vger.kernel.org>; Sat, 29 May 2021 08:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=zs7tA2ES5+/L3IEgF2INOvNv9NWP9ZSDDxPNo61Q6t8=;
        b=iTWDdo6VjqG9XjvBWv6RLAOlTzXmh1Uo6YduUR3sjiOXBnywKvgmmDAZrLnmhkP0A2
         2vs0UI1tUksQDdDnK338u0DyOes44EYgzWR3hSQeW6xlucHMYeuW7DSEOOwUi4t4i56w
         jE+GqPha+Rfp5U4wafydiwsL4C1jrNCXK8zDDAnEJbYLOBe5rYCPXqUYZTc9oqb7mJ/B
         +9JjNqeWZMQsuPljxuB2g//5z4OA9N3zNLjbf4MidNF54z3g19xjOCNf1v1tHBRISJbV
         0y4PtaoTxpr/MUIW50AUrryaS746j2QjlkbjDklLF4qavwwo2syXScdb4UCgcpAFMHyb
         x1eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=zs7tA2ES5+/L3IEgF2INOvNv9NWP9ZSDDxPNo61Q6t8=;
        b=F1nJpbZtBqdEiE55WQbpA+sWP1LHktZz4etE34VJJ6rjKKrKqhEDYExgxqZpfMsjAX
         qR/wcb6sxFMNP543zLkJa/tFiwtExxm5fOp+R5zR+oWs16Zya+xh+N6y/51ReO5Gu2By
         fpIOrstiFSWXivudC5RWGcX2De5ChoGHhPMpse6lVJmi7P1gaSagv94f+TmeE27AsG3K
         LW/otyTolUEdpPuU5KJuv5KsgLEtKNM1nCZydV67thQGug7XNHZUJhwKX08+TsTBnziB
         g/sqMQ9XsuqTcXxPaSuFyrpewB1OO0xyFUyAxPLB9mWK8VYhHoD+D9owzF6AFMuSm6wL
         vSrQ==
X-Gm-Message-State: AOAM532oEI49/h61qP2wFeZIwVwNHiRFqary3XX3JVMW34+02PEx9gZo
        XBlf+wZdexY+S86o6VCnvmI=
X-Google-Smtp-Source: ABdhPJwSszCgHwu1TiIQvp10+e+z/fznG7qBS59ozjGPLaigtb/L/E8YDyKcKPmdHtqpTCWGkGbZvw==
X-Received: by 2002:a4a:4581:: with SMTP id y123mr10847319ooa.33.1622301865444;
        Sat, 29 May 2021 08:24:25 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id r24sm1830982otk.50.2021.05.29.08.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 08:24:24 -0700 (PDT)
Date:   Sat, 29 May 2021 10:24:23 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, ZheNing Hu <adlternative@gmail.com>
Message-ID: <60b25ca7a01c2_265088208af@natae.notmuch>
In-Reply-To: <13c63e79-27fd-58d5-9a4c-6b58c40ef4b8@gmail.com>
References: <pull.963.git.1622126603.gitgitgadget@gmail.com>
 <b3848f24f2d3f91fc96f20b5a08cbfbe721acbd6.1622126603.git.gitgitgadget@gmail.com>
 <60afca827a28f_265302085b@natae.notmuch>
 <13c63e79-27fd-58d5-9a4c-6b58c40ef4b8@gmail.com>
Subject: Re: [PATCH 1/2] [GSOC] ref-filter: add %(raw) atom
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood wrote:
> On 27/05/2021 17:36, Felipe Contreras wrote:
> > ZheNing Hu via GitGitGadget wrote:
> > [...]
> >> +static int memcasecmp(const void *vs1, const void *vs2, size_t n)
> > 
> > Why void *? We can delcare as char *.
> 
> If you look at how this function is used you'll see
> 	int (*cmp_fn)(const void *, const void *, size_t);
> 	cmp_fn = s->sort_flags & REF_SORTING_ICASE
> 			? memcasecmp : memcmp;

Yeah, but why?

We know we are comparing two char *. Presumably the reason is that
memcmp and memcasecmp use void *, but that could be remedied with:

	cmp_fn = (int (*)(const char *, const char *, size_t))memcmp;

That way the same cmp_fn could be used for the two cases.

Either way I don't care particularly much. It also could be possible to
use void * and do the casting in tolower().
 
> > (and I personally prefer lower to upper)
> 
> We should be using tolower() as that is what POSIX specifies for 
> strcasecmp() [1] which we are trying to emulate and there are cases[2] where
> 	(tolower(c1) == tolower(c2)) != (toupper(c1) == toupper(c2))

That's true.

-- 
Felipe Contreras
