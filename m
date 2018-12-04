Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26E86211B3
	for <e@80x24.org>; Tue,  4 Dec 2018 00:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbeLDABb (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Dec 2018 19:01:31 -0500
Received: from mail-ed1-f48.google.com ([209.85.208.48]:41266 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbeLDABa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Dec 2018 19:01:30 -0500
Received: by mail-ed1-f48.google.com with SMTP id z28so12339026edi.8
        for <git@vger.kernel.org>; Mon, 03 Dec 2018 16:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B/zddOYKh0pTLwH6pYqJ4es6mvKR8MM8Z6J4xNgwcG0=;
        b=kZup5tbBnI0/Tl8JYucAvoz5Sgjfnsf7QcPU22XzEw0grt+/7lio/e59FNKDFo7T3o
         j0AB+3M6qyx7UcDCggZy2SPI+NJViLVxX6JgzSeJLy4Byil6aUH/OSClVuro74C/pXGH
         KTPICK10aEb8EQrGuLRcipzwkG446RkURocgJtHnyskJu0YmfbajabgQyNl428L97WAg
         pePM0vooLmr3RrfYQXswXSy97ObanOe/NdNTNouoQRRuQapj5HIC230MGWQOBWxnPqsC
         AuEcsoQAGLvD2f5Bs9NHrcH1G4B06sT86TcpplsWNab5nq7a6DCLWRENW99QJ/gS4mvU
         W9LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B/zddOYKh0pTLwH6pYqJ4es6mvKR8MM8Z6J4xNgwcG0=;
        b=pPoCUNm7Et+FKdnyeyTIXkIwahPFEmdT568a9cjSLR9RwDaSCZjMdGuHSpOnabJyUm
         0hh8D3zqy8r7h7HCG592YfnObC5Jboqup2okQYS9cjWs6p9eWdM5GybErJ3hwtjeTFOF
         xLCpzGxe4KpA7SZYAdTyk16mcE5bRvggfdc1Nj07QEIoEvQelrSH2SdW8NbHkGy0RIVl
         FWX4r7tQshgqmIIJdGQ+kvk5EjpfgrfN6IRyI7wFkK3eboCVzC3s6+sB1sOQPWnrhnh4
         P0e1KF2o03yxA80bqVlt9JveV1sawylUSRrA49QykJuzL9Mz8CdAkfv9Jr8xxWcEFY4t
         5/ow==
X-Gm-Message-State: AA+aEWY275eMpWU4K6g2C5n665E8WOO2gn2BejhVL2lL0gYlARWuaZAk
        IbpYYOwhHs9liLuk5wVym7c7eSe5JGlDqnu9vfxZDw==
X-Google-Smtp-Source: AFSGD/WRdGra8LVEz3aozkvWq2JSxAsxKTaSB/9zG2w5b+xH96XmqWyn2E3u+MaZ7OhQCX60uQ1lNFKdRpuSI9zIw3o=
X-Received: by 2002:a50:ade7:: with SMTP id b36mr5383616edd.215.1543881687858;
 Mon, 03 Dec 2018 16:01:27 -0800 (PST)
MIME-Version: 1.0
References: <cover.1543879256.git.jonathantanmy@google.com>
In-Reply-To: <cover.1543879256.git.jonathantanmy@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 3 Dec 2018 16:01:16 -0800
Message-ID: <CAGZ79kajSr1jzs0r9bK+Pt6arz5XRq04cWaaPGU=BibDw1PHvA@mail.gmail.com>
Subject: Re: [WIP RFC 0/5] Design for offloading part of packfile response to CDN
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 3, 2018 at 3:37 PM Jonathan Tan <jonathantanmy@google.com> wrote:

>
> There is a potential issue: a server which produces both the URIs and
> the packfile at roughly the same time (like the implementation in this
> patch set) will not have sideband access until it has concluded sending
> the URIs. Among other things, this means that the server cannot send
> keepalive packets until quite late in the response. One solution to this
> might be to add a feature that allows the server to use a sideband
> throughout the whole response - and this has other benefits too like
> allowing servers to inform the client throughout the whole fetch, not
> just at the end.

While side band sounds like the right thing to do, we could also
sending (NULL)-URIs within this feature.
