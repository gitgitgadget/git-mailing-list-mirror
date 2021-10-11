Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BAEC433F5
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 12:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB2BC60E9C
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 12:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236577AbhJKM3w (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 08:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234635AbhJKM3w (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 08:29:52 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479C3C061570
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 05:27:52 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id l39so418856vkd.7
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 05:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ynFHajqz9DJ2WV29ddJjYQIZm4LzQxY3DqJDbmRBG+4=;
        b=hMkpp6acTy1JxOVeVqIpgi5tEshM9Q/XKUAsP2dPQ1jqf3cmx1mUaCaIAMAtZ/tZu8
         WMVcjgRFvQV25DjRF9sSCNeTdzVWVe8pWPXqFtuAioY3rghgxTomBLEBACjv/aa2tqwv
         NjVD/tRNBCyCJVpPyog0JMB9hlHwRsdPlWNCLSpVbGaJLG2iExNTlRenrRQUKkDNgfu8
         4QVHaBsEI92MFren7w7WICWK+A1kE3gdbi5QQSVuHCS8pTBn0WXQB6dgSF1e9BEVgm8W
         WRBicLBaIGN+A+EXfvfvWQRolpxprZad3miPsVBnDIBIUDmdoS+ymXdVxFhqm6k+9VCS
         9Ocw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ynFHajqz9DJ2WV29ddJjYQIZm4LzQxY3DqJDbmRBG+4=;
        b=jZSstPYfPNNjhhAES9Lzuyv9RXeE6QkolihLrKIRxaZrunl6wQhomG7k52QW+rw8FE
         FlDlETy2OsdyzY++vQKNxhRWqNQ7TUggHjawWFw9tay7nw9KMt7QfUamKhdhtTx8CDUX
         PE6sLITsctVQ6MHVGAY7wjshMiy71jI6LRFcUCEevrZR3exKZwIGydbx+D1QHTmkh+bh
         7hZK6AI976VecL2pc8lykkww9NwMechiWJqrP1FakekRsZfVueUGdmoNhi7U/fSd7cxn
         zmBJKIyIwPpLJXD/oF2rD5q9HYlfeIajolXYHIBktyZm39Jloeb/yDmZAjcTVD7fcrTA
         xhuw==
X-Gm-Message-State: AOAM532DcnYGxRKBHWqj82GWHnPMURvn5NhBv1+2gI036skLJpHm/dI/
        c+16nUct6hFArAhnpxAsDXYyq+4xpq1g7iGyxXlIW5MPhk4=
X-Google-Smtp-Source: ABdhPJzsjarHarLevnk2L/YNi+q2gdtsVW/tGYrt7qcOgmD8NMVviQ5wuMF2xl7kwkKB+bCr7eCPPCIG6tqWhrC/x8U=
X-Received: by 2002:a1f:a215:: with SMTP id l21mr19291731vke.19.1633955271335;
 Mon, 11 Oct 2021 05:27:51 -0700 (PDT)
MIME-Version: 1.0
References: <61d28b8e9dd906eba821ecc9ee81bd4ac2374494.camel@0xadd.de>
In-Reply-To: <61d28b8e9dd906eba821ecc9ee81bd4ac2374494.camel@0xadd.de>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Mon, 11 Oct 2021 05:27:39 -0700
Message-ID: <CAPUEsphLXcCw=Qj1Rw5ONf2GduQAs62VwkVd3gTt4=PLaGkBcg@mail.gmail.com>
Subject: Re: git log with %(describe) placeholder does not find most recent tag
To:     Benjamin Kircher <bkircher@0xadd.de>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 11, 2021 at 1:10 AM Benjamin Kircher <bkircher@0xadd.de> wrote:
> produces a different result than
>
>     git describe --tags

if the repository you are looking at has non annotated tags (the ones
that have no signature or message and that are created by default with
`git tag`), then that is expected and explained in the documentation
for the '--tags' option you are using.

Carlo
