Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8DA82098B
	for <e@80x24.org>; Wed, 19 Oct 2016 15:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S942826AbcJSPrY (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Oct 2016 11:47:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:59467 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S942756AbcJSPrV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2016 11:47:21 -0400
Received: (qmail 5151 invoked by uid 109); 19 Oct 2016 08:51:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 19 Oct 2016 08:51:16 +0000
Received: (qmail 11170 invoked by uid 111); 19 Oct 2016 08:51:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 19 Oct 2016 04:51:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Oct 2016 04:51:15 -0400
Date:   Wed, 19 Oct 2016 04:51:15 -0400
From:   Jeff King <peff@peff.net>
To:     santiago@nyu.edu
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        walters@verbum.org, Lukas Puehringer <luk.puehringer@gmail.com>
Subject: Re: [PATCH v4 1/7] gpg-interface, tag: add GPG_VERIFY_QUIET flag
Message-ID: <20161019085115.thvsf5muhyvmvgj2@sigill.intra.peff.net>
References: <20161007210721.20437-1-santiago@nyu.edu>
 <20161007210721.20437-2-santiago@nyu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161007210721.20437-2-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 07, 2016 at 05:07:15PM -0400, santiago@nyu.edu wrote:

> From: Lukas Puehringer <luk.puehringer@gmail.com>
> 
> Functions that print git object information may require that the
> gpg-interface functions be silent. Add GPG_VERIFY_QUIET flag and prevent
> print_signature_buffer from being called if flag is set.

The layering here is a little funny. The gpg-interface code allocates a
new flag, but none of its functions do anything with it.  Instead, it's
acted on only by the run_gpg_verify() command local to tag.c.

I guess this "flags" variable comes to us from other callsites via
gpg_verify_tag. That's still in tag.c, but it's arguably part of the gpg
interface.

So I think it's OK.

-Peff
