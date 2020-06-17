Return-Path: <SRS0=YePV=76=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F8FC433DF
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 20:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F301212CC
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 20:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ojOIZO9i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgFQUtz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Jun 2020 16:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgFQUtz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jun 2020 16:49:55 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADCBC06174E
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 13:49:54 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id x25so3161010edr.8
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 13:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to;
        bh=xR3v8wuLVfwRYG/YwBGpL3pZirEb7vNOsH+pqNnNpno=;
        b=ojOIZO9iX+ptu5Dy+KdHV6D3fniXp6bJPP4/ho861yPw/zF2v8R/3dqFIbHzkbVcWt
         xdvEcTEEBu8NC9cGN3CHTYAjYTLJrYhKytPqwePA5ZfbXpTmXNxzRg5NCqcDEz9H5L+v
         QazoYHnQtyX6IOj/eINSy+142ipFP799iVOn1juo7u4PE6yp+Z9fO2MzBVxc4okVgYxs
         NEB1qI0POagAslRm3A6zIhyGmTzOlLYHk5gEfPrHqMgSvB5nQMuoF8mRDXyyFJ1ixLwS
         y7KxuBW1cbHOGoYPrARCqoigFUmchSnV1Q/sSxsFXQsjcTKZGWgDBEpsvYtivTPkXkwL
         NE9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to;
        bh=xR3v8wuLVfwRYG/YwBGpL3pZirEb7vNOsH+pqNnNpno=;
        b=kpRJZ0dlermxZ5QbDk5aZ7rwJ0vOIv7l/vtdx83xxCesdlyYJV17egg53ya8BqObF4
         OJEpsIbbhemeQA5EyhtqmcEd4/fW2nnUnfuLpQaYabQ76OFE+uIs87KrNgHNRbV0gRhD
         2KmNNslFUqxuXJpLl21uaekF5fSxuCasyPHEFunv5pYrBduPm414jL2GB/x9/5lZ1TrV
         4FjU3hMY2aafJmjTVnhpCnXQ0Q8+SfqlolPqDhu5E1iRDgq89/razTD/cOQEeUiVIaw6
         OR+eOKrYSRa/dyE7sQi28kgCaLbW9/KCOR3Jmr4j0vn7Y1baDoW1i6U2PAMl1j0Pj2Ky
         0GoA==
X-Gm-Message-State: AOAM530wgT5cx+Cs/jM4iqNYlOjPVwZY2rXXnhb6Hb9GDPE4MjKsee4i
        BoZ2tRvPV1XmiAfjlzgdeOE=
X-Google-Smtp-Source: ABdhPJzKPQrUbJivTGbXG+MThfT+E3R4Ag1WuKFNu0gEV8LrXdqyDd/dU2BhWVSZ1NQpmZCy4ykS4g==
X-Received: by 2002:a50:d75e:: with SMTP id i30mr964372edj.305.1592426993018;
        Wed, 17 Jun 2020 13:49:53 -0700 (PDT)
Received: from localhost.localdomain (ptr-uhky5bq0ghslncy72e.18120a2.ip6.access.telenet.be. [2a02:1810:1c39:a800:a975:5a77:183c:f046])
        by smtp.gmail.com with ESMTPSA id kt10sm705606ejb.54.2020.06.17.13.49.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Jun 2020 13:49:52 -0700 (PDT)
From:   ZeeVriend <zeevriend@gmail.com>
To:     lego_12239@rambler.ru
Cc:     git@vger.kernel.org, Zee Vriend <zeevriend@gmail.com>
Subject: Re: Rename offensive terminology (master)
Date:   Wed, 17 Jun 2020 22:48:42 +0200
Message-Id: <20200617204842.23344-1-zeevriend@gmail.com>
X-Mailer: git-send-email 2.11.1.windows.1
In-Reply-To: <20200617074940.GB18445@legohost>
References: <20200617074940.GB18445@legohost>
In-Reply-To: <20200617074940.GB18445@legohost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Zee Vriend <zeevriend@gmail.com>

Dear Oleg,

Thanks for your feedback. I have no knowledge from cyrillic so it is nice to hear from you! As a fact, in French "zero" also has
bad meanings. But, positive meaning exist also. Building up from nothing as example I give you.
Now if my suggestions are not ok we can try something else. I thought alternatives can be "source" and "root". Both are used A LOT
by programmers everywhere so possible they all agree! Let me tell you "source" has EXACT same meaning in French, I like it a lot.
We all write 'source code' is not?
Maybe you have other words to describe this. We can all share the best words and select the best agreement. A true inclusive collaboration
from all!
Let me wish you a good day and happy moments next!
