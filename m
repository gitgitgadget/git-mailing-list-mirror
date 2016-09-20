Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8562207EC
	for <e@80x24.org>; Tue, 20 Sep 2016 23:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753670AbcITXGU (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Sep 2016 19:06:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:45803 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752978AbcITXGU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2016 19:06:20 -0400
Received: (qmail 8611 invoked by uid 109); 20 Sep 2016 23:06:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 20 Sep 2016 23:06:19 +0000
Received: (qmail 25839 invoked by uid 111); 20 Sep 2016 23:06:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 20 Sep 2016 19:06:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Sep 2016 19:06:16 -0400
Date:   Tue, 20 Sep 2016 19:06:16 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v3 0/3] handle multiline in-body headers
Message-ID: <20160920230616.n2jwhavi2dzgflno@sigill.intra.peff.net>
References: <cover.1474319086.git.jonathantanmy@google.com>
 <cover.1474391594.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1474391594.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 20, 2016 at 10:17:50AM -0700, Jonathan Tan wrote:

> Changes since v2:
> o Removed utf8 translation before scissors line check in
>   check_inbody_header (I was thinking of support for encodings like
>   UTF-16, but I guess those don't work with the current reencode_string
>   anyway since it uses strlen internally)

Yeah, I'd be surprised if UTF-16 works very well with our code in
general. If we want to address that, though, the sanest thing is
probably to convert it internally to UTF-8 when we remove the transfer
encoding in handle_body().

-Peff
