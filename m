Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 545E5200B9
	for <e@80x24.org>; Thu,  3 May 2018 16:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751336AbeECQgV (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 12:36:21 -0400
Received: from mail-ot0-f173.google.com ([74.125.82.173]:45433 "EHLO
        mail-ot0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751261AbeECQgU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 12:36:20 -0400
Received: by mail-ot0-f173.google.com with SMTP id 15-v6so6513865otn.12
        for <git@vger.kernel.org>; Thu, 03 May 2018 09:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YIT1wRc7E5Tzt/zEAvF6Uw/J7e5PcTzfZc+TdfpaWTo=;
        b=UA7GJtaHtlZ99HL9vIq7RHuBqQbIKquVrHr9Z2p2eWlLAEJ10DU6FVNesw2ju6f+Tp
         zhoB4hdKBB3dIecdHbFGf9SFIZ7f99y7oq4IDvHom1yruLiCdCIcONvfELlZS6/gD3Os
         1blzZ1kC8PAeJ3KJXUbvicQgQFXCTdLeopoCciCWEuz/ZRdUyy+LRXwx/5yCPBplTsVH
         eD4xzONhs6XpwQLt/ifbCzcaM1+sscbac1QUJcageQx375iEhynXYux7mhpNFkxQmC43
         oN/ChSuGlyXvUby+wo+vkDmwwuzkYwexq0Nrl0hqHYPJDpsp3sWYCdmICVPtDPvKFa40
         pjuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YIT1wRc7E5Tzt/zEAvF6Uw/J7e5PcTzfZc+TdfpaWTo=;
        b=ff1Z+5UQT/I3I+sj1WflWBtv86JYIQRzlUTO/kf2tZ1AgLe3JLCDhDiIK3dWUhkJRw
         LW/rs/ERmKjByLO0XEIbKLHqESsoc632CiFbToHmeqFP5P4UT5vMMatqyMqD/4eA8+WK
         Ydui/Ftt5ehsJPS0BuySJGQPKd35YJTd6NE1K0cmE2r+d7Z+9H15wf2pbNtALDw9evLm
         uGzxm7uMlUUt/Alr7KScmUPlfWKspx8uQEfC/kC2xsi/eolyhCHgKDLUQbhDyBZgD0OH
         RcMziDR6FMqya1sP0SFENcF9Wsete9ouiJNWA+QQ8HIo44z++VOvvFqAGUGibQYdzItX
         01tA==
X-Gm-Message-State: ALQs6tBTkHBwIVa22qr6NxpoCoIqfOhGbj6YBhulnlYzQmm6ERhmetB5
        QmfzYYYFMDFjb2ho4uuLZjguKKedqQXf38BENWM=
X-Google-Smtp-Source: AB8JxZpQgNOwBhbGXtaUgej9EMOUgIqnUrCn53TyQC5LZpXwT8WF/YwwG4sgqoDcpjhEjqlXKQZTjL57jXHLl7hK6NM=
X-Received: by 2002:a9d:e8f:: with SMTP id 15-v6mr7324163otj.14.1525365379450;
 Thu, 03 May 2018 09:36:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Thu, 3 May 2018 09:35:48 -0700 (PDT)
In-Reply-To: <20180430153122.243976-1-jamill@microsoft.com>
References: <20180417163400.3875-1-jamill@microsoft.com> <20180430153122.243976-1-jamill@microsoft.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 3 May 2018 18:35:48 +0200
Message-ID: <CACsJy8C3yZ6bSZGw1d5DjwcPgHMDE7iGGUOn9SvyLmshzs9DvQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Allocate cache entries from memory pool
To:     Jameson Miller <jamill@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        "sbeller@google.com" <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 30, 2018 at 5:31 PM, Jameson Miller <jamill@microsoft.com> wrote:
> This patch series improves the performance of loading indexes by
> reducing the number of malloc() calls. Loading the index from disk is
> partly dominated by the time in malloc(), which is called for each
> index entry. This patch series reduces the number of times malloc() is
> called as part of loading the index, and instead allocates a block of
> memory upfront that is large enough to hold all of the cache entries,
> and chunks this memory itself. This change builds on [1].

I have only looked at the mem-pool related patches to see if
mem-pool.c is good enough to replace alloc.c. To me, it's a "yes"
after we optimize mem_pool_alloc() a bit (not that performance really
matters in alloc.c case, but that may be because it's already
blazingly fast that we never noticed about it).

I probably should look at read-cache.c changes too. Maybe later.
Although after the change to use xmalloc() per entry a few years(?)
ago, it should be straight forward to use a different memory
allocator.
-- 
Duy
