Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87FBCC433DB
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 10:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3071164DF2
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 10:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234375AbhBXKkk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 05:40:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232634AbhBXKkj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 05:40:39 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB31C061574
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 02:39:58 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id r17so2163259ejy.13
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 02:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=qcMijCqoMT77fDyCHYUQV6rbMY0sRas81Jq9gprCbzU=;
        b=TUBSCQCGO5jocyv2IXwLB/t47VMfZ8nw63nOdS6S6PFxtVlNlteWvkYi35lMH75uKm
         JiiuBzWik3AjMfxQMtnCFZlDWrR+hRPXehnrmuuYSYdOmApQomg0BJl24UN4BoPKlt0w
         Wdw22IwdeaNTWlgSMj9NdgZMjYQBZEtgKsxsRkQOSI9PKME6zwXRB417k5oXYnpdFWkb
         RTojtWAuDCSjY31foJ3Ar7tcl2Z0fQp87uob6hTRQTDyGrYg2JBOfZPRNtCeziCuqENz
         eW2kwfbEAxWkxF7eV7P2714ygeO0Dao7n6MR0XsYDlet/+r/OtUhwezY+5pjxYc4q9Uw
         O1ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=qcMijCqoMT77fDyCHYUQV6rbMY0sRas81Jq9gprCbzU=;
        b=JWuTPOwDJj04O7Es96dBwYRSNeqjHqjSItTZUenujzgOeG/8aDxiipF4Z8uzxTBMzK
         b2prfEt0+7Kjb6OL6NnazG2CBrszZKlG6ejGkxP/t0ww6GHgYR36ZzXRv8TysTx6IKjQ
         aNugcywTTglt56erRWkTHP4XFxlllZIBgk+s5Q0sre+ExyQgq1xxPCSEmZi3+/pPR8rQ
         t03dOAoOSgoU6PinGfxlCSo+H2D3KPRYqqgWpQxDlzXY9em2sKu3ilVwg+Z5UX09OHbW
         L4bu0Cn1EeGa181JpMmkn11TImiZjD7/D1Im1KZkqaUeT4d9GyyO9KEQtiS/Ye7K8J+H
         1fng==
X-Gm-Message-State: AOAM532nKgm3bYKrn9XJSQvlLdW+bsxJr1xL+/99MS5P1EeA0oTS96Ch
        rsYByua+O7+oRs7ACRnN1fk=
X-Google-Smtp-Source: ABdhPJxtSolKsUgCHKaQalnlVG1lySymyw2v9uiDDDzy8t5wWRhLwWQOKcXmPZ2eRyM1MyiYfz1OWQ==
X-Received: by 2002:a17:906:5905:: with SMTP id h5mr28906501ejq.531.1614163197412;
        Wed, 24 Feb 2021 02:39:57 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id a26sm1272978edm.15.2021.02.24.02.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 02:39:56 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "Kerry, Richard" <richard.kerry@atos.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Ort-merge: What does "ort" mean?
References: <AM0PR02MB4081D3C17C53DB5CD9021C5E9C9F9@AM0PR02MB4081.eurprd02.prod.outlook.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <AM0PR02MB4081D3C17C53DB5CD9021C5E9C9F9@AM0PR02MB4081.eurprd02.prod.outlook.com>
Date:   Wed, 24 Feb 2021 11:39:55 +0100
Message-ID: <871rd592bo.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 24 2021, Kerry, Richard wrote:

> It's now been quite a few weeks, probably months, since the "ort-merge" work has been going one.  However, I don't think I've ever seen an explanation of what "ort" means.  I know it means "place" in German, but that seems an unlikely usage because git project generally works in English.  I don't know of it as a word in English.  So maybe it's an acronym - ORT.  But what does that mean?
>
> So, can someone please say what "ort" means?

$ head -n 3 merge-ort.c
/*
 * "Ostensibly Recursive's Twin" merge strategy, or "ort" for short.  Meant
 * as a drop-in replacement for the "recursive" merge strategy, allowing one
