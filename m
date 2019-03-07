Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CC7120248
	for <e@80x24.org>; Thu,  7 Mar 2019 19:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfCGTSj (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Mar 2019 14:18:39 -0500
Received: from cloud.peff.net ([104.130.231.41]:42968 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726399AbfCGTSi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Mar 2019 14:18:38 -0500
Received: (qmail 5718 invoked by uid 109); 7 Mar 2019 19:18:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 Mar 2019 19:18:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26762 invoked by uid 111); 7 Mar 2019 19:18:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 07 Mar 2019 14:18:56 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Mar 2019 14:18:36 -0500
Date:   Thu, 7 Mar 2019 14:18:36 -0500
From:   Jeff King <peff@peff.net>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Matthew Kraai <mkraai@its.jnj.com>
Subject: Re: [PATCH v13 18/27] stash: convert create to builtin
Message-ID: <20190307191836.GB29221@sigill.intra.peff.net>
References: <nycvar.QRO.7.76.6.1902191127420.41@tvgsbejvaqbjf.bet>
 <20190225231631.30507-1-t.gummerer@gmail.com>
 <20190225231631.30507-19-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190225231631.30507-19-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 25, 2019 at 11:16:22PM +0000, Thomas Gummerer wrote:

> +static void add_pathspecs(struct argv_array *args,
> +			  struct pathspec ps) {

Here and elsewhere in the series, I notice that we pass the pathspec
struct by value, which is quite unusual for our codebase (and
potentially confusing, if any of the callers were to mutate the pointers
in the struct).

Is there any reason this shouldn't be "const struct pathspec *ps" pretty
much throughout the file?

-Peff
