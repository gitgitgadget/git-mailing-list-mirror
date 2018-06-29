Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12FAE1F516
	for <e@80x24.org>; Fri, 29 Jun 2018 21:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932703AbeF2VgB (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Jun 2018 17:36:01 -0400
Received: from mail-yw0-f178.google.com ([209.85.161.178]:39199 "EHLO
        mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932119AbeF2VgA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jun 2018 17:36:00 -0400
Received: by mail-yw0-f178.google.com with SMTP id 81-v6so4194193ywb.6
        for <git@vger.kernel.org>; Fri, 29 Jun 2018 14:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jvGHK7gHh99d4rECMveL0SphtV9ZaTfpNUvr+evbiK0=;
        b=pWarQkMHNLWM6D+6sx7G6hbzF4QotDJD9Fly9+UwAcgFHejB0i5YpwkcgSucRMT1yK
         TG1b/jOrHBBGZZYGzJqPqjVpxyffKM+ueiXRfjkr9bPXJZuYrx2mQAPCpk0Dgmf2vsz0
         sGAq9RFHpJnICN5sG02u2fXVaRrF6Giz+n7MO76if6wNrm8wVfXYgcKIaOmdsxyLOb9f
         73XqS75MN0WrgAZg2FSZH1hZOPYoCyun3l7O9y/0KvSmuiu7WnvmJGoAhvW17c7xNPd0
         Hhb7OOWAGu4fdzoiFHS73BiGGBnQ2dEbB+ThHqLVj4mZ/RvPwprER5QrxT8pffTA2X1D
         x5GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jvGHK7gHh99d4rECMveL0SphtV9ZaTfpNUvr+evbiK0=;
        b=txQ7pDnuVIhVT0OxpLaEWR//fBcrTaQfSyHNLeXgXjwSdQ0Dr6kNnIOmdF3G83csnK
         ErXEtb+il97SI+ookYwWj1bweWhmyglPRTi+dZsptvM60mwnC12AAJaNn9XHDT/dkBHV
         CGPM4be+MLGX5TbrGCfPJCc80sWBgYvkUP+5+BumsDWaVAuiE3yAQVW4rVt/0a4evgLV
         4JbdzBO4o9YH0GrkkWUfUxGybOo7HsRXifnLvVTy1s6qsodQPpEygvbTQ/aE2dGxHHDo
         PebCs0f8mqigkmaiIPUPcs7TVjrpsdNgBBGuOgp/xIuQVwL91bB2uGYQAFZlDXR1Ngi4
         0hOQ==
X-Gm-Message-State: APt69E3F3HilfntMUlYKd+7MAMSfR61Qjz1jHgVOeBkxvZLVLWQjv0Ht
        GZsFMQLn7gWvBcqCsu/B3a8cdzWjM5ZOrIqZVcK5duvR
X-Google-Smtp-Source: ADUXVKK+cjDX410MbilSr2Fpu1GeioJmfQvuzi8heb9Kcrz5ENcDMP8c9KYzUJn6/ggMzFiI2A8XUn0LjV/ISz02j3Q=
X-Received: by 2002:a25:c04:: with SMTP id 4-v6mr8794940ybm.247.1530308159167;
 Fri, 29 Jun 2018 14:35:59 -0700 (PDT)
MIME-Version: 1.0
References: <20180629161223.229661-1-dstolee@microsoft.com> <20180629161223.229661-2-dstolee@microsoft.com>
In-Reply-To: <20180629161223.229661-2-dstolee@microsoft.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 29 Jun 2018 14:35:48 -0700
Message-ID: <CAGZ79kZUYMob2G=RD6UXw3-=PgeP7s=e5XhpzPh9fcZjxh6t7g@mail.gmail.com>
Subject: Re: [RFC PATCH 01/13] commit-reach: move walk methods from commit.c
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Derrick,

> +/* Remember to update object flag allocation in object.h */
> +#define PARENT1         (1u<<16)
> +#define PARENT2         (1u<<17)
> +#define STALE           (1u<<18)
> +#define RESULT          (1u<<19)

Something is up with whitespaces here, apart from that this patch
looks good.
