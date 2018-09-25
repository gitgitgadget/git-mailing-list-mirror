Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4BF81F453
	for <e@80x24.org>; Tue, 25 Sep 2018 20:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbeIZDEN (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 23:04:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:59198 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726173AbeIZDEN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Sep 2018 23:04:13 -0400
Received: (qmail 417 invoked by uid 109); 25 Sep 2018 20:54:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 25 Sep 2018 20:54:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11488 invoked by uid 111); 25 Sep 2018 20:54:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 25 Sep 2018 16:54:30 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Sep 2018 16:54:47 -0400
Date:   Tue, 25 Sep 2018 16:54:47 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] git help: promote 'git help -av'
Message-ID: <20180925205446.GB21956@sigill.intra.peff.net>
References: <20180922174707.16498-1-pclouds@gmail.com>
 <20180924181927.GB25341@sigill.intra.peff.net>
 <xmqq4leesjdc.fsf@gitster-ct.c.googlers.com>
 <CACsJy8D1EMCqvBdxbta4oocMF33jwDf1=opXwZ0aRN7LYu=JXg@mail.gmail.com>
 <20180925174451.GA29454@duynguyen.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180925174451.GA29454@duynguyen.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 25, 2018 at 07:44:51PM +0200, Duy Nguyen wrote:

> > I think adding another section about external commands in "help -av"
> > would address the "clang-format" stuff. With that, it's probably good
> > enough to completely replace "help -a". It may also be good to list
> > aliases there too in a separate section so you have "all you can type"
> > in one (big) list.
> 
> Here's the patch that adds that external commands and aliases
> sections. I feel that external commands section is definitely good to
> have even if we don't replace "help -a". Aliases are more
> subjective...

Just eyeballing the output, it looks pretty reasonable to me. The lack
of explanation for external commands really stands out, but there's not
much we can do.

That part of the output is not very compact, and we _could_ put it in
columns, but that might be confusing since the rest of the output is
one-per-line.

Mentioning aliases seems reasonable to me. The definitions of some of
mine are pretty nasty bits of shell, but I guess that people either
don't have any ugly aliases, or are comfortable enough with them that
they won't be scared away. :)

> -- 8< --
> @@ -53,7 +52,6 @@ static struct option builtin_help_options[] = {
>  			HELP_FORMAT_WEB),
>  	OPT_SET_INT('i', "info", &help_format, N_("show info page"),
>  			HELP_FORMAT_INFO),
> -	OPT__VERBOSE(&verbose, N_("print command description")),
>  	OPT_END(),
>  };

Would we want to continue respecting "-v" as a noop? I admit I did not
even know it existed until this thread, but if people have trained
themselves to run "git help -av", we should probably continue to give
them this output.

-Peff
