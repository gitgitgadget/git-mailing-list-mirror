Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141C9C433E1
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 21:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB2F420715
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 21:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgHMVpu convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 13 Aug 2020 17:45:50 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:44500 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgHMVpu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 17:45:50 -0400
Received: by mail-wr1-f42.google.com with SMTP id c15so6567514wrs.11
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 14:45:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=F6U57C9YJLdlKtYJa40437fZSvub16we/bslmOi4l2w=;
        b=L4Qm0az97WmR08XWT0N6PU877Y18QTmrUrcqRVdSsOEgH3fMQkvFaIna1WWDPNp6gK
         iHYIbiDccKdyXGaM/wHNLtCTJIIMp4GesLrQShovH75dm94WHo4KHBO8kQMMfpVd/uno
         ZJ8G3Rl2WlVFUdDsiBmIKMv7iXSAQbU8rz4vYTUi2Q9jRrxHgV6PCC3mH8rQ9Db78F+Q
         jy/Lg6SUBt4bJvgED4JMh4MHUoc9/rrgfyjCEYfMapUu/JBe0PFsnWYNavQFRV7gT/f8
         RpaEVgoX8z/uuOm8ClSc9419aY3wzwG6KWd7q8FIRwefWeQagSv4fQ3g9Kipblese8G9
         8OgQ==
X-Gm-Message-State: AOAM530Ey25JTssPFyq7vwn2L71/rPsQsyKvflqu3ViIBDUqTs0r2R3Q
        +VRwwLhexAyJx3Vy93CvF5t8BPj4+dEJZk/yrgyDX2No
X-Google-Smtp-Source: ABdhPJxa5nE/eM3d0lJ+JKW8AooV43ugg+zLOX9VEPuQfSb9uHWQcv9k+OagNmvz9ahmmXpCyl4yLBnvp4ur+sSvu7I=
X-Received: by 2002:adf:fc45:: with SMTP id e5mr6212847wrs.226.1597355148968;
 Thu, 13 Aug 2020 14:45:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAGNCYk3hGWHuSb4vDzrBE54P5y6Sm+TwfVrCfHD0LnLQWSr9nA@mail.gmail.com>
In-Reply-To: <CAGNCYk3hGWHuSb4vDzrBE54P5y6Sm+TwfVrCfHD0LnLQWSr9nA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 13 Aug 2020 17:45:38 -0400
Message-ID: <CAPig+cQnGUyM2cwNjDm_zys15B9n82QT6-RD7Lgyz1-XSGp8yw@mail.gmail.com>
Subject: Re: [BUG] `make install' partly ignores `NO_INSTALL_HARDLINKS'
To:     Alexander Ost <ost@ieee.org>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 12, 2020 at 4:16 AM Alexander Ost <ost@ieee.org> wrote:
> Despite installing with `make NO_INSTALL_HARDLINKS=1 install', the
> installation process tries to create hard links, and the installation
> fails (a quick workaround is `sed -i git-gui/Makefile -e "s/ln /ln -s
> /g"').
>
> make NO_INSTALL_HARDLINKS=1 install
> ln: failed to create hard link
> ‘/filesystem_without_hardlink_support/libexec/git-core/git-citool’ =>
> ‘/filesystem_without_hardlink_support/libexec/git-core/git-gui’:
> Operation not permitted

Indeed, it appears that the git-gui Makefile does not respect
NO_INSTALL_HARDLINKS. The git-gui project is maintained and developed
outside of the Git project (even though it gets bundled with Git), so
it has its own issue tracker. It would probably be best to re-submit
this bug report there:

https://github.com/prati0100/git-gui/issues

Thanks.
