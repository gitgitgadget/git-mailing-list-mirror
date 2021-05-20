Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DCFC433B4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 08:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAF856109F
	for <git@archiver.kernel.org>; Thu, 20 May 2021 08:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbhETIfT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 04:35:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:60092 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229536AbhETIfS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 04:35:18 -0400
Received: (qmail 26467 invoked by uid 109); 20 May 2021 08:33:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 20 May 2021 08:33:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29107 invoked by uid 111); 20 May 2021 08:33:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 20 May 2021 04:33:59 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 20 May 2021 04:33:56 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] doc: explain the use of color.pager
Message-ID: <YKYe9PZbTO1CyBOp@coredump.intra.peff.net>
References: <YKTXlTjwOUi4W+R8@coredump.intra.peff.net>
 <YKVsw3uqb66ifzvd@google.com>
 <xmqq5yzdvrlg.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5yzdvrlg.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 20, 2021 at 03:36:59PM +0900, Junio C Hamano wrote:

> > More importantly, I think I'd find a
> > reference to the commit or a quotation from the affected user more
> > helpful than a reference to the mailing list archive, since that would
> > make this a bit more self-contained.
> 
> The original commit and its log message we ended up with did not
> explain the motivation behind well enough.
> 
> The motivation from the original thread:
> 
>       When I use a pager that escapes the escape character or highlights the
>       content itself the output of git diff without the pager should have
>       colors but not with the pager.  For example using git diff with a
>       pathspec is quite short most of the time.  For git diff I have to
>       enable paging manually and run git diff | $PAGER usually but git log
>       uses the pager automatically and should not use colors with it.
> 
> can be quoted as a whole, but "the point is to deal with ..." is a
> succinct summary that is good enough for the purpose of this commit,
> I would think.

Thanks, I was just preparing a near-identical response.

I do think it's an important principle in general to summarize the
content of things we link to. It's just that the summary in this case
was so short that it was easy to look past. :)

> > If I understood correctly, how about some text like the following?
> >
> > 	A boolean to specify whether `auto` color modes should colorize
> > 	output going to a pager, in addition to their behavior of
> > 	colorizing output going to a terminal. Defaults to true; [etc]
> 
> The variable has no control over what happens to output that
> directly goes to a terminal, so while the additional phrase might
> not be technically wrong per-se, I do not see why this is more clear
> than the original.

Unsurprisingly, that's my opinion, too. While writing it, I actually did
try some longer explanations to explain from the ground up, but I
worried it was distracting from the main point of this variable. E.g.,
something like:

  When color mode options (e.g., `color.ui`) are set to `auto`, Git by
  default will enable color when the output is going to a terminal or to
  a pager (since the pager itself is outputting to a terminal). This is
  a problem if your pager doesn't faithfully relay the color codes to
  the terminal. You can set this boolean to `false` to disable color
  when output is going to a terminal.

> So, in short, I think it would be sufficient to amend the proposed
> log message with s/deal with/to deal with/ and nothing else.

I'm happy with that.

-Peff
