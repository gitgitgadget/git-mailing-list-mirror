Return-Path: <SRS0=TjTC=DE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C998C4346E
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 08:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4F0A23977
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 08:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730446AbgI0IDq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Sep 2020 04:03:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:42308 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730438AbgI0IDq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Sep 2020 04:03:46 -0400
Received: (qmail 28568 invoked by uid 109); 27 Sep 2020 08:03:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 27 Sep 2020 08:03:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3781 invoked by uid 111); 27 Sep 2020 08:03:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 27 Sep 2020 04:03:48 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 27 Sep 2020 04:03:45 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 2/8] shortlog: refactor committer/author grouping
Message-ID: <20200927080345.GB1286220@coredump.intra.peff.net>
References: <20200925070120.GA3669667@coredump.intra.peff.net>
 <20200925070211.GB62741@coredump.intra.peff.net>
 <CAPig+cTfYmNAP_65RDa_fZOyuQEH65HuLs-UYSPT0yJ=s6BftA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cTfYmNAP_65RDa_fZOyuQEH65HuLs-UYSPT0yJ=s6BftA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 25, 2020 at 04:05:04PM -0400, Eric Sunshine wrote:

> > +--group=<type>::
> > +       By default, `shortlog` collects and collates author identities;
> > +       using `--group` will collect other fields.
> > +       `<type>` is one of:
> > ++
> > + - `author`, commits are grouped by author (this is the default)
> > + - `committer`, commits are grouped by committer (the same as `-c`)
> 
> I had trouble interpreting "(this is the default)". It made me think
> that <type> is optional:
> 
>     --group[=<type>]
> 
> but that isn't the case at all. Instead, it means that if --group
> isn't specified, then grouping is done by `author` by default.

Right.

> It also
> repeats what the general description of --group already says with
> regard to the default, thus it is redundant to say it again when
> describing the `author` type. Therefore, perhaps drop "(this is the
> default)" altogether?

OK. I was worried somebody wouldn't quite pick up on the default. We
could spell it out as:

  - `author`, commits are grouped by author (this is the default if no
    --group is given)

but that's pretty lengthy. We could also reword the whole thing as:

  --group=<type>::
          Collect and collate values of type `<type>`; if no `--group`
	  option is given, the default is `author`:
   - `author`, commits are grouped by author
   - `committer`, commits are grouped by committer (the same as `-c`)

I'm not sure if that's clearer or not. The first sentence seems a bit
opaque, but I'm not sure how to improve it.

For now (and what plan to send out in v2), I'll take your suggestion to
just drop the phrase.

-Peff
