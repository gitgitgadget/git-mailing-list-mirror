Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20B0C04FF3
	for <git@archiver.kernel.org>; Mon, 24 May 2021 20:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC14B6140E
	for <git@archiver.kernel.org>; Mon, 24 May 2021 20:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbhEXU3f (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 16:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233346AbhEXU3e (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 16:29:34 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8E2C061574
        for <git@vger.kernel.org>; Mon, 24 May 2021 13:28:06 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id v13-20020a17090abb8db029015f9f7d7290so576353pjr.0
        for <git@vger.kernel.org>; Mon, 24 May 2021 13:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eq35W3di8zK1mo+dglnDfD8zjTeX8ItxyuacwcpSJPo=;
        b=uqh2kQo8KJGRnW8pyxL+5lK0XdccTYOUqaqduDfTeu9Yb7nh7hmiQzA+A4+CwH0w0t
         62Uj/ZlS8BLO3PFMacCnBX43Mk7d8rsz+nZEIN9/LxEUeuvr0pDn8U3Tw9IFYIP+wa8T
         N7g4YRYI/DLbXkP+53tUNlSRjEw9Mh3LrhFgKSqTctnh9yGcJZZFInyL2lkJ6+uHoLll
         oXJcf6irMQOO9hnut3eKRahHTILPjGy7iO9QdFJ7cuPzzWYM0KqjjmjShk2XzU7NMSUa
         HNMfFJN16CDclqLNRJmYTKxHLL26DrCnDLkIDARNtL/XNKRsnKQoSUJvfTllk/CucwyU
         M8fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eq35W3di8zK1mo+dglnDfD8zjTeX8ItxyuacwcpSJPo=;
        b=dUHBwciRom5Sylf2KkDta3+n/yTFgRn0Qlj/ZDkkqdH92LOyc2B2PA7kKoeefB5MjO
         Hf8DvQkp0QUL+79VCLx6p7a2J+YN3xCk+VfHV2c7vo3BsBuJXNESt0MQWMvkcU0rcdwE
         zdMekG3IXX01pJzO2Snf8XA7S2v4aViTctZnBaytpFbXZuUrEvBoZjbkU5j4cxz+DfGx
         dpWeB70U8SGEdoM/8QZRLG9E/OGAtsSR12rLdsyLXEu1LEROzlwG24tCXtrKt0jaPaZA
         w5jcaDBoEujscXnXHa1hrPeiV9CFU+iPmjsLseVqEyHHozbCWfRbt7AvJsPwukVbk2tj
         3CIA==
X-Gm-Message-State: AOAM531Sd9Ejg2YxU+KcbhX9URmRWqe2i+97B+joUzdb56VlZ4dUBeoB
        I/YgjQYG4oQUJh/lhakkuxXhhWillCw=
X-Google-Smtp-Source: ABdhPJzmxc3wrWXjRZVuSpOdeN/ahgZ/FQc4fofc/cj+E5q2Mqq9ryjmCbl1Af44NcaRGFlAvi98WQ==
X-Received: by 2002:a17:90a:cc05:: with SMTP id b5mr26994917pju.6.1621888085492;
        Mon, 24 May 2021 13:28:05 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:ae43:6046:39d1:c30a])
        by smtp.gmail.com with ESMTPSA id c1sm7865977pfo.181.2021.05.24.13.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 13:28:05 -0700 (PDT)
Date:   Mon, 24 May 2021 13:28:03 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, stolee@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] t1092: use GIT_PROGRESS_DELAY for consistent results
Message-ID: <YKwMU13DOtTIgaeP@google.com>
References: <pull.960.git.1621886108515.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.960.git.1621886108515.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Derrick Stolee wrote:

> The t1092-sparse-checkout-compatibility.sh tests compare the stdout and
> stderr for several Git commands across both full checkouts, sparse
> checkouts with a full index, and sparse checkouts with a sparse index.
> Since these are direct comparisons, sometimes a progress indicator can
> flush at unpredictable points, especially on slower machines. This
> causes the tests to be flaky.

Hm, I think this test strategy is going to be fundamentally flaky
regardless: Git doesn't intend to guarantee any kind of stability in
the exact stderr output it writes.

Could the tests be made to check more semantically meaningful
information such as "git ls-files -s" output instead?

Thanks,
Jonathan
