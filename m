Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 159261F51C
	for <e@80x24.org>; Fri, 18 May 2018 21:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752103AbeERVjX (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 May 2018 17:39:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:45984 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751545AbeERVjH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 May 2018 17:39:07 -0400
Received: (qmail 28809 invoked by uid 109); 18 May 2018 21:39:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 18 May 2018 21:39:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14553 invoked by uid 111); 18 May 2018 21:39:14 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 18 May 2018 17:39:14 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 May 2018 14:39:04 -0700
Date:   Fri, 18 May 2018 14:39:04 -0700
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] t7005-editor: get rid of the SPACES_IN_FILENAMES prereq
Message-ID: <20180518213903.GC21797@sigill.intra.peff.net>
References: <20180514102812.7924-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180514102812.7924-1-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 14, 2018 at 12:28:12PM +0200, SZEDER Gábor wrote:

> The last two tests 'editor with a space' and 'core.editor with a
> space' in 't7005-editor.sh' need the SPACES_IN_FILENAMES prereq to
> ensure that they are only run on filesystems that allow, well, spaces
> in filesnames.  However, we have been putting a space in the name of
> the trash directory for just over a decade now, so we wouldn't be able
> to run any of our tests on such a filesystem in the first place.
> 
> This prereq is therefore unnecessary, remove it.

I wondered if there might be some platforms that tweak the test
environment in such a way that we skip the space in "trash directory".
But looking at test-lib.sh, I don't think there is any easy way to do so
(e.g., you can't just set $TEST_DIRECTORY_NAME or something). So this
does seem safe, and it's nice to reduce unnecessary complexity.

-Peff
