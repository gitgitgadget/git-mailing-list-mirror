Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14E9D1F404
	for <e@80x24.org>; Tue, 23 Jan 2018 16:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751480AbeAWQcI (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jan 2018 11:32:08 -0500
Received: from cloud.peff.net ([104.130.231.41]:54476 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751256AbeAWQcH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jan 2018 11:32:07 -0500
Received: (qmail 24611 invoked by uid 109); 23 Jan 2018 16:32:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 23 Jan 2018 16:32:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16999 invoked by uid 111); 23 Jan 2018 16:32:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 23 Jan 2018 11:32:44 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Jan 2018 11:32:05 -0500
Date:   Tue, 23 Jan 2018 11:32:05 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/5] travis-ci: use 'set -e' in the 32 bit Linux build job
Message-ID: <20180123163205.GA14626@sigill.intra.peff.net>
References: <CAM0VKjmAjw0a2JzsY1BaAwZcCp8ge+jQaGN6L_nKTLugHeWyvQ@mail.gmail.com>
 <20180122133220.18587-1-szeder.dev@gmail.com>
 <20180122133220.18587-3-szeder.dev@gmail.com>
 <20180123162633.GE13068@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180123162633.GE13068@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 23, 2018 at 11:26:33AM -0500, Jeff King wrote:

> > +HOST_UID=$1
> > +CI_USER=$USER
> > +test -z $HOST_UID || (CI_USER="ci" && useradd -u $HOST_UID $CI_USER)
> 
> If this "useradd" step fails, we wouldn't abort the script, because it's
> part of a conditional. You'd need a manual "|| exit 1" at the end of
> this line. Or to use a real "if" block.
> 
> Reading this line, I'm also slightly confused by setting CI_USER in the
> subshell, and then only using it once. Should it be respecting the outer
> CI_USER setting? If not, should it just hard-code "ci" on the useradd
> command-line?  But that has nothing to do with your patch here.

OK, nevermind on all this. I just read patch 4. :)

-Peff
