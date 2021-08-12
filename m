Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2EFC4338F
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 08:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3EF160EB9
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 08:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235124AbhHLIGS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Aug 2021 04:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235084AbhHLIGR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Aug 2021 04:06:17 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDCA9C061765
        for <git@vger.kernel.org>; Thu, 12 Aug 2021 01:05:52 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id m24-20020a17090a7f98b0290178b1a81700so9453642pjl.4
        for <git@vger.kernel.org>; Thu, 12 Aug 2021 01:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7f3YPpmbCYt9Wo3ixGHIP4WTX6UNhc8rOclyzPgIukg=;
        b=Verno5L8m3xNOTWIN6IyOiuUz+yiFaDf3e+yB6x8cmIBNkqSx1lnATlXUSk4+zlZgx
         Y0CtvxcSNcRy8N8zPtKBuE8EW8IUSPtcNeBKw/n6i5ZYHUBuQlstFNOhjIy95kJp+9+3
         O8u+kQDHhkEU16+mDAjGODqyyGA3EgxIZgALRAAg+ISlUXWpjOb+gmAMaXS/iXyGYIoK
         MqcD2xY6b5CO/55YjC69Jjt5QjA7LEQYJkHlf5UADrasANW4d6l67mToJ4GTsA0uzpuC
         JAAvZbwIiNN7h+hnMCDtltONbacJD7e0cidAdNmw58QaR5+pDMH4E6miqDT+HguMZONB
         Qg3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7f3YPpmbCYt9Wo3ixGHIP4WTX6UNhc8rOclyzPgIukg=;
        b=JmbSXn862XK3kOXqrNs4Ht+IS3593u9e92cINPk9eUjFJBzahD15g/K/YWGjaAStzq
         84XQYdQmQnOupCSjOvAyITvzhZRTJ3VeOiCZoCxH3CVicr54wu5yb38e85xAkyI0mPbr
         W1xlg8ijd4GjaaFM3AG7c1LzbFMvF3Sr53+d6gOAppzujeK2OS3dZSJP5gwBa/G0bxFs
         EUXy4aAvGz/qwKPObvDJ0SfBzhLd+2H8T/vLdjj8MVOEtFebHM4l+hdBUl4/biDxOSnL
         R17hMR+e6B14G4oTWLgzAAcakf6A3nuP85HLJXR8pVcP+ORAyFOFRD19nlKfoMZ6J1Sz
         xHnQ==
X-Gm-Message-State: AOAM533coCM72k2GSD2eGBAVkTeLxzJIGfZn1oOR/Zr3AVMnENxEFI0z
        VCK2PuW42e5PgQytS9sQ3mc=
X-Google-Smtp-Source: ABdhPJyoP2B3cx+lnkyvYX1NDsTORDVUOJyNYo47AQ3CPCXHVek/pwWujYNKgNgl/qJaYFBy+N7riw==
X-Received: by 2002:a65:6110:: with SMTP id z16mr2805593pgu.152.1628755552425;
        Thu, 12 Aug 2021 01:05:52 -0700 (PDT)
Received: from localhost.localdomain ([47.246.98.159])
        by smtp.gmail.com with ESMTPSA id a8sm2554933pgd.50.2021.08.12.01.05.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Aug 2021 01:05:52 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     peff@peff.net
Cc:     dyroneteng@gmail.com, git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v1 1/1] list-objects.c: traverse_trees_and_blobs: rename and tree-wide
Date:   Thu, 12 Aug 2021 16:05:42 +0800
Message-Id: <20210812080542.5469-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.32.0.dirty
In-Reply-To: <YRQg+IJ3cxb3Vk+c@coredump.intra.peff.net>
References: <YRQg+IJ3cxb3Vk+c@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>>FWIW, I was about reply and suggest the exact same name. :)
>>
>>As something internal to list-objects.c, I don't think it matters all
>>that much either way. The name "traverse_commit_list()" is IMHO more
>>likely to confuse. It is public within the project, and of course
>>traverses any type of object. So "traverse_objects()" or something may
>>be more accurate.

On the basis of understanding the relationship between git objects,
`traverse_commit_list` is understandable, for me.

>>OTOH I do not find it all that confusing, and it may not be worth the
>>disruption to the code base.

Agree.

It’s interesting to read your reply, because of learning a lot of
abbreviations.

Thank you.
