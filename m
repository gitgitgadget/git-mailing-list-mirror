Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 453FB20248
	for <e@80x24.org>; Fri, 22 Feb 2019 14:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfBVOKc (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 09:10:32 -0500
Received: from cloud.peff.net ([104.130.231.41]:54264 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725978AbfBVOKc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 09:10:32 -0500
Received: (qmail 1085 invoked by uid 109); 22 Feb 2019 14:10:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 22 Feb 2019 14:10:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28115 invoked by uid 111); 22 Feb 2019 14:10:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 22 Feb 2019 09:10:45 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Feb 2019 09:10:30 -0500
Date:   Fri, 22 Feb 2019 09:10:30 -0500
From:   Jeff King <peff@peff.net>
To:     Krzysztof Sobierajczyk <sobierajczyk.krzysztof@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: bug - git version 2.20.1.windows.1
Message-ID: <20190222141030.GA3272@sigill.intra.peff.net>
References: <CAM3o+_mX6euHa8Trq5cArcYBc9Wm0FH2L56S6Z3ojdhTcc0CWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAM3o+_mX6euHa8Trq5cArcYBc9Wm0FH2L56S6Z3ojdhTcc0CWQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 22, 2019 at 02:26:51PM +0100, Krzysztof Sobierajczyk wrote:

> ksobierajczyk@KME43 MINGW64 /d/Simple repository (master)
> $ git status
> On branch master
> Changes to be committed:
>   (use "git reset HEAD <file>..." to unstage)
> 
>         renamed:    to remove.txt -> new name.txt
>                      <------------  AND FAIL
>         deleted:    to rename.txt

Git doesn't store rename information; it infers it when generating a
diff (and the output from git-status here is a diff between HEAD and the
index).

If "to remove" and "to rename" contain identical data, then they are
equally valid candidates, and Git has to pick one. In this case it
picked the one you didn't expect.

-Peff
