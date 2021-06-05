Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C535C4743D
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 02:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB2D3613E7
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 02:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbhFECTB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Jun 2021 22:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbhFECTB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jun 2021 22:19:01 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2FD4C061766
        for <git@vger.kernel.org>; Fri,  4 Jun 2021 19:16:57 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id s5-20020a17090a7645b029016d923cccbeso1325475pjl.0
        for <git@vger.kernel.org>; Fri, 04 Jun 2021 19:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fJgwg04hrRj3SBgMBTtbUrEA8JwCp6OEAZXDBRL7UTg=;
        b=sGyIgzrit4O4zGWEgds8FZ4uXN9L3fz3M0BUSFBeDdV5n1CZqRRoHtEi+KApIgLUwV
         +75oOSs5lIIdn+5xqEo9DQa7HvMg1xKvy8kGm7fy7ca98X3VTB0AVYT1gSqDmaAT7Vv8
         TFoXbktHEPCHzgMrRc+seElTDJqFRv/spZLLsmYF8aGOVGtLZ6ACFfl+tVxmcdCtEFXs
         oW8Hs2Nd7qAUefh0cZWdH6fN3fPmqzqQuajDouXAQttfbapbM4Tbu2J+UDdYfR7SE+3N
         Shk4DKWywr9a9QOi6/uhLuRqjcUe+uTQZ9/Lbg9Zzwhlx0E3ToSI9cG7tdYt+59qOOCJ
         diOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fJgwg04hrRj3SBgMBTtbUrEA8JwCp6OEAZXDBRL7UTg=;
        b=G7CVyyB05STezfmbrWZuVqtKwT2aAfnwrRsN7urX6HC7SefJl+yxKAxydfqYK9hqhA
         gqwQq7Mu10yU5TA9+xcuqIKwlzlvlesLiSFv8MlqlERX+ZhzVMmap00h23OZbV1c3yQb
         4zMaBY8eq0r8bt+OvWJlo6TiMCvo1RWB9lDmUzpJFS5BomzJ3eFNGqfmq9Hgw6iHou/4
         hE3QKrShDMWfGl++DDufIEj53INDXcLN0hbCpExxfNZfkDXFM2KvzMXCdOb4muaHPohq
         i8pSHK7UrNlPiF/X6pQGsXe2J2O3bL0Q9INXSUj7kdFzKg94MynffeeshfY8H+QGuTXo
         2euA==
X-Gm-Message-State: AOAM5324z5VKQfPw5eaxN2vgGmhNgYb7mo1Pl8Bo1Fmq8jhRLpRFltqY
        guwMm82TdNesU3miAV0MvNNUueLAjtv7Zjozpb7u
X-Google-Smtp-Source: ABdhPJwxYoqFGFnhOk8uFtAot1Ee0sEPxCbJgrEKD4PIs4mA30on6SDmTnvB2BNUo8uDGORB1AZpQ78/4Kc0oCSMvU8E
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:8b81:b029:108:ec1:e024 with
 SMTP id ay1-20020a1709028b81b02901080ec1e024mr7187997plb.59.1622859417273;
 Fri, 04 Jun 2021 19:16:57 -0700 (PDT)
Date:   Fri,  4 Jun 2021 19:16:55 -0700
In-Reply-To: <CABPp-BGqt2DsrtJZ3_C5AajVyPsN+6a6rhMscSKrgYiCPVDnfA@mail.gmail.com>
Message-Id: <20210605021655.610593-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <CABPp-BGqt2DsrtJZ3_C5AajVyPsN+6a6rhMscSKrgYiCPVDnfA@mail.gmail.com>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: Re: [PATCH 4/4] promisor-remote: teach lazy-fetch in any repo
From:   Jonathan Tan <jonathantanmy@google.com>
To:     newren@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Turns out that this test fails under GIT_TEST_DEFAULT_HASH=sha256; output:
> 
> error: wrong index v2 file size in /home/newren/floss/git/t/trash
> directory.t0410-partial-clone/partial.git/objects/pack/pack-66a15be115d740341216938fb7abb31902e960bd6d464829d85164d1a4a25bec.idx
> error: wrong index v2 file size in /home/newren/floss/git/t/trash
> directory.t0410-partial-clone/partial.git/objects/pack/pack-66a15be115d740341216938fb7abb31902e960bd6d464829d85164d1a4a25bec.idx
> fatal: couldn't find remote ref 74242c6e4a0d89f454d89d3496a1f7cb3f1f39f0
> error: wrong index v2 file size in /home/newren/floss/git/t/trash
> directory.t0410-partial-clone/partial.git/objects/pack/pack-66a15be115d740341216938fb7abb31902e960bd6d464829d85164d1a4a25bec.idx
> error: wrong index v2 file size in /home/newren/floss/git/t/trash
> directory.t0410-partial-clone/partial.git/objects/pack/pack-66a15be115d740341216938fb7abb31902e960bd6d464829d85164d1a4a25bec.idx
> fatal: could not obtain object info

Thanks for noticing this. I'll take a look.
