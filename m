Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6743620248
	for <e@80x24.org>; Fri,  1 Mar 2019 18:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389909AbfCASAM (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Mar 2019 13:00:12 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56259 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389895AbfCASAM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Mar 2019 13:00:12 -0500
Received: by mail-wm1-f66.google.com with SMTP id q187so13389040wme.5
        for <git@vger.kernel.org>; Fri, 01 Mar 2019 10:00:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yfwdsPXdD2I+uY5xxAS1oSf+D+uQ99awHvZqpNyuyAU=;
        b=FTWw34YFzx1xFQLNyALObLQm35Hf7kEx5OkPWsVIImZ8Qp4hPqoqlmctt3m3YuwnZi
         HCFBHEjKIP6AeBjniXkRzIlhmudJiOqvmRxLq+6Gw+eZjkUX6JDUhrJBTKY0mp0Ecu8W
         2SwB2IEtozGMpiumIcKWaqgD+HO5fFeGoT2C+dKFrzWy4A2l7SV0AKgz4+zmT0lb9CVR
         SVvdngtRX1Xlm1OccJYMd/Tg5/v75MObcZTQfDBwBTzfCadhSKgCJSbMM35Kq84TiAtE
         YZVrVs/DJolfmpb+szCXDBGAA0ZZ50m6ZmVCYCVPtHM3wipPwgp/5+7G/98jgmCmtdqz
         b6Pg==
X-Gm-Message-State: AHQUAualNp2D9blML9FI2dmft9DcPPY6DJRdApbzIGtxQK0utZjFvhwg
        Yd/0Wn1/cZW60hRsirLoliZSvxCveUTaMnluOI4=
X-Google-Smtp-Source: APXvYqyYHDDMEXvMixwLv+5qjNEct3a0Qck+FYP2E6TgQDvtXXLHPqYCMwgb68WgO16fvCe9KgLgNW/GBvz0i5eiwtM=
X-Received: by 2002:a7b:ce8e:: with SMTP id q14mr3925193wmj.71.1551463211105;
 Fri, 01 Mar 2019 10:00:11 -0800 (PST)
MIME-Version: 1.0
References: <20190301175024.17337-1-alban.gruin@gmail.com> <20190301175024.17337-2-alban.gruin@gmail.com>
In-Reply-To: <20190301175024.17337-2-alban.gruin@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 1 Mar 2019 13:00:01 -0500
Message-ID: <CAPig+cQ6-O8hV+7mYFszyFyk0u4aJMe021RqN+tiFn3OS7H0Hw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] name-rev: improve name_rev() memory usage
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 1, 2019 at 12:50 PM Alban Gruin <alban.gruin@gmail.com> wrote:
> There a condition that will always be false here when name_rev() calls
> itself for the first parent, but it will become useful when name_rev()
> will stop to name commits that are not mentionned in the stdin buffer.

s/mentionned/mentioned/

> If the current commit should not be named, its parents may have to be,
> but they may not.  In this case, name_rev() will tell to its caller that

s/tell/report/

> the current commit and its first parent has not used the name, and that
> it can be released.  However, if the current commit has been named but
> not its parent, or the reverse, the name will not be released.
>
> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
