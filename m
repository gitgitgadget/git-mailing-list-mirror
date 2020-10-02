Return-Path: <SRS0=3i0n=DJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB13C4363D
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 04:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FDF120874
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 04:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qf6jx+my"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725967AbgJBEGD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Oct 2020 00:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbgJBEGD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Oct 2020 00:06:03 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F25C0613D0
        for <git@vger.kernel.org>; Thu,  1 Oct 2020 21:06:03 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id p21so87423pju.0
        for <git@vger.kernel.org>; Thu, 01 Oct 2020 21:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yL3EC41mAY3d4Gui+nZEVPFh3O009xV0d6bsgC6PZXk=;
        b=qf6jx+mygEzhuSJVcc5fbQjJNR3Z7K8p1wH3NAXLdORXQ+JQtptO8vC/70ZCef3zxg
         +eZ2z7ABfVf5ph1Peo0Dep3TE2BonzjJreaIRn47XZBncb4TTlbUcww8Je8Rq2wEPO5p
         ID/FNz6oC6Dew4300cKAghVGA2SjzHKgvrwz++CULwMlG1Gt1fs9l+o+qFz7Zr8kEHws
         YL/AmdEsfMtKJosptJywtI7uelZrpmxaAeiovc96dTOHXu5ph1XK9nQGeGMcGkGa937P
         NVsiNxP2p3sRM7v6hu1Z/76SC2Jn7caKbOzJSjz4POEU5EXyj/cED3MAp093C3nLNJpo
         cVug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yL3EC41mAY3d4Gui+nZEVPFh3O009xV0d6bsgC6PZXk=;
        b=dRekaSHbuRNpxzBI3oX38uyqA8TrJVYpbZ6sPNMvvBJlIUD3ROOa69s8k5yH+ZWwW0
         AclIF1CaP9ia8qTiSwetx17WUgjiuvoCk8pIPVFcYfm/WYlfFMTWG97oe7ry3vYA8sHU
         GSnzhY4OrdMAJOIvH1HqgZYlsQMmlrp+SZ5OOdqgkDC1Iawl/O3ZE39+eHZhtN3in5yH
         ylrhvWmhL1D7dxlhM2rynGo4rQg++NyS0tsaE7xT9z+1nN+A3aVFLFmA0py69gjqnkux
         sd8WwQ4w8/AI1WI0Z2wQ8UbKkmmsDqiuXLON85oQK6QzbxIwa5g486uH+aOAJcRE4lnO
         9itQ==
X-Gm-Message-State: AOAM530Qty0UIA79ZdSg7XvQ2ampE/iqVTzM85wh5qh94YXfL0F4O3lD
        +Dgpi4y7HDvq3fmEimObZWM=
X-Google-Smtp-Source: ABdhPJzHMjUz4aG6z8x+4ocWdrXwTHLX10jGnKNNA4MID4Nzq5/lsDJUdYySOqYK93YRChUHURh36g==
X-Received: by 2002:a17:90b:209:: with SMTP id fy9mr616592pjb.189.1601611562480;
        Thu, 01 Oct 2020 21:06:02 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id d193sm116907pfd.181.2020.10.01.21.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 21:06:01 -0700 (PDT)
Date:   Thu, 1 Oct 2020 21:05:59 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 04/13] reftable: add a barebones unittest framework
Message-ID: <20201002040559.GD3252492@google.com>
References: <pull.847.git.git.1600283416.gitgitgadget@gmail.com>
 <pull.847.v2.git.git.1601568663.gitgitgadget@gmail.com>
 <b94c5f5c6120347fd97bcc2dcc187fc86a802dff.1601568663.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b94c5f5c6120347fd97bcc2dcc187fc86a802dff.1601568663.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Han-Wen Nienhuys wrote:

> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  reftable/test_framework.c | 68 +++++++++++++++++++++++++++++++++++++++
>  reftable/test_framework.h | 59 +++++++++++++++++++++++++++++++++
>  2 files changed, 127 insertions(+)
>  create mode 100644 reftable/test_framework.c
>  create mode 100644 reftable/test_framework.h

Hm, can the commit message say a little about the motivation for this
test framework and what it allows?

For example, does it allow unit tests to write output in TAP format?
How does it compare to existing frameworks like
https://www.eyrie.org/~eagle/software/c-tap-harness/?  How does this
approach compare to what Git's existing unit-style tests with helpers
in t/helper/ driven by scripts in t/ do?

Thanks,
Jonathan
