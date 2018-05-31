Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58E091F42D
	for <e@80x24.org>; Thu, 31 May 2018 05:25:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753757AbeEaFZl (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 01:25:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:57366 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751037AbeEaFZk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 01:25:40 -0400
Received: (qmail 11814 invoked by uid 109); 31 May 2018 05:25:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 31 May 2018 05:25:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9294 invoked by uid 111); 31 May 2018 05:25:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 31 May 2018 01:25:51 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 May 2018 01:25:38 -0400
Date:   Thu, 31 May 2018 01:25:38 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/4] config doc: move color.ui documentation to one place
Message-ID: <20180531052538.GB17068@sigill.intra.peff.net>
References: <20180530210641.19771-1-avarab@gmail.com>
 <20180530210641.19771-2-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180530210641.19771-2-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 30, 2018 at 09:06:38PM +0000, Ævar Arnfjörð Bjarmason wrote:

> Ever since b982592d66 ("git-status: document colorization config
> options", 2006-09-11) we've slowly been accumulating more and more
> color.* options, where the documentation for each new one has
> seemingly been copy/pasted with minor adjustments from the last.
> 
> This has resulted in documentation where we're describing what sort of
> values color.ui or its overriding variables can take a grand total of
> 9 times.

Yeah, I agree the current state is poor.

> This makes for hard and tedious reading, and is going to be a royal
> pain if we're ever going to add more color.ui values.
> 
> Instead let's briefly describe what each variable is for, and then
> copy/paste a new boilerplate saying that this variable takes the exact
> same values as color.ui, and if it's unset it'll fallback to whatever
> color.ui is set to.

Definitely an improvement. Though I wonder if we should go further and
show the user the relationship in the documentation explicitly. Like:

  color.<system>::
	A boolean to enable/disable color in a particular part of Git,
	overriding `color.ui` (see `color.ui` for possible values). The
	current set of systems is:

	advice::
		Hints shown with the "hint:" prefix, controlled by
		`advice.*` config.

	branch::
		Output from the linkgit:git-branch[1] command.

	...etc...

We could possibly do the same with color.<system>.<slot>. Or maybe even
make a single hierarchical list of systems, and then the color slots
under each. I think if our mental model in adding these options is
to have this kind of hierarchy, then it makes sense to communicate it
explicitly to the user and get them using the same mental model.

-Peff
