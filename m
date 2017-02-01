Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D38E21F6DC
	for <e@80x24.org>; Wed,  1 Feb 2017 22:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753806AbdBAWf0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Feb 2017 17:35:26 -0500
Received: from cloud.peff.net ([104.130.231.41]:48024 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753224AbdBAWfZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2017 17:35:25 -0500
Received: (qmail 20422 invoked by uid 109); 1 Feb 2017 22:35:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Feb 2017 22:35:25 +0000
Received: (qmail 14360 invoked by uid 111); 1 Feb 2017 22:35:27 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.42.43.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Feb 2017 17:35:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Feb 2017 23:35:21 +0100
Date:   Wed, 1 Feb 2017 23:35:21 +0100
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     cornelius.weig@tngtech.com, git@vger.kernel.org
Subject: Re: [PATCH] doc: add note about ignoring --no-create-reflog
Message-ID: <20170201223520.b4er3av67ev5m3ls@sigill.intra.peff.net>
References: <20170201220727.18070-1-cornelius.weig@tngtech.com>
 <xmqq4m0do86p.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4m0do86p.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 01, 2017 at 02:30:38PM -0800, Junio C Hamano wrote:

> > Notes:
> >     In a previous discussion (<xmqqbmunrwbf.fsf@gitster.mtv.corp.google.com>) it
> >     was found that git-branch and git-tag accept a "--no-create-reflog" argument,
> >     but it has no effect, does not produce a warning, and is undocumented.
> 
> Reading what Peff said in the thread, I do not think we actively
> wanted this behaviour; we agreed that it is merely acceptable.
> 
> So perhaps s/this behaviour is intentional/this is known/ to weaken
> the log message?  That way, when somebody else who really cares
> comes later and finds this commit that adds explicit notes to these
> manual pages via "git blame", s/he would not be dissuaded from
> making things better.  Such an update may make it warn when
> core.logallrefupdates is not set to false (and continue to ignore
> the command line option), or it may make the command line option
> actually override the configured default.

Yeah, I'd consider it more of a "known bug" or "known limitation" than
anything.

Those can go in a separate section, but they're probably more likely to
be read when supplied next to the actual option.

> With such an update to the log message, I think the patch looks
> good.
> [...]
> > @@ -91,6 +91,7 @@ OPTIONS
> >  	based sha1 expressions such as "<branchname>@\{yesterday}".
> >  	Note that in non-bare repositories, reflogs are usually
> >  	enabled by default by the `core.logallrefupdates` config option.
> > +	The negated form `--no-create-reflog` is silently ignored.

This might be nitpicking, but it's _not_ ignored. It still negates an
earlier "--create-reflog". It is only that it does not override the
decision to create a reflog caused by the setting of
core.logallrefupdates.

-Peff
