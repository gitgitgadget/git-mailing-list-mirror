Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D592202A5
	for <e@80x24.org>; Mon, 25 Sep 2017 22:09:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935122AbdIYWJS (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 18:09:18 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34269 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934913AbdIYWJR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 18:09:17 -0400
Received: by mail-pf0-f196.google.com with SMTP id g65so4168623pfe.1
        for <git@vger.kernel.org>; Mon, 25 Sep 2017 15:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CN3vW2q9w0XA6ZAHh0T9Bt7lEXCSDf1gFQ7F/LYENDs=;
        b=XKeywZknK2qLUPc9o5mFd1Rv3gSs/WHceGTYAkvJxdOkjSHkj700PFyRJDnluC3B4i
         op9lhkIphhD5Cl+CJjPV22Mim50f0vYSoA3iVsn6gLhha7Ard9wblOy4xxvh8ClX4mdO
         nsGU7yqsGFbhonoiQlo4TEUg3WdApZTXA8gUg4ycoak7cKzOOAcBAaWhatw1yxuw9z5V
         BGtzXwTV0hjCDfEYHNrCWrqofsnSec8D3SvlYLdLQQsmO+VevaK62Nb2uxhbWAeeM62H
         xmv3D/I0ca22TsDcnJG6qyp62b5RCsdQONCtEaScJENBxCROGcaiWX+wCoF8RlmXt4l+
         xmug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CN3vW2q9w0XA6ZAHh0T9Bt7lEXCSDf1gFQ7F/LYENDs=;
        b=cGM0hh09pPlt+bHcOY6YfFMqT3cNAIPr+zFgiUjcHl2RYshUg0Yul1z5DA7bcp/le6
         RSOSfFV0Bkd/ORbhm0GmPWUahlKZOeDDB5eIZZGI1zO0x6D6koFJ2BhnOxnrB1Xw2HYU
         GRxn/r2WkHIm4T1yX7cDOOAmIe2A0Q1h3zENvl4zECrPHHWe5kYxk80EqRhWLNL6/HR+
         HeT6vCKOMprK4OizxXNtRHTLTfZLiuyWSOTyelm+QKW9kF6nJOW8yX4Hefg8kqJ6+7wp
         Qyksb8XjTylDg/Kayugtw1zJs7uRgIuOwLBZDQGbGwoIf4q3ye+1z6dFGfO0GThjPgaO
         //kw==
X-Gm-Message-State: AHPjjUjgEeShRhL463Dqx5ZgwYjGr3oKApUUL4IDLhcUwg0zdfHwjIe2
        I3o2KVNTMspK/rha3kzyqQg7Bc8d
X-Google-Smtp-Source: AOwi7QD5C60xnL+v4G55suYUaFcoKtBsnAHIsNoKNhOgR/N23SKIaatHYpIEBzTl+J6mfUYEudiwUw==
X-Received: by 10.98.29.74 with SMTP id d71mr8972217pfd.141.1506377356876;
        Mon, 25 Sep 2017 15:09:16 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:b5cd:5017:828c:d0cb])
        by smtp.gmail.com with ESMTPSA id z24sm13832303pfk.3.2017.09.25.15.09.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 25 Sep 2017 15:09:16 -0700 (PDT)
Date:   Mon, 25 Sep 2017 15:09:14 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/7] read_in_full: reset errno before reading
Message-ID: <20170925220914.GB27425@aiede.mtv.corp.google.com>
References: <20170925202646.agsnpmar3dzocdcr@sigill.intra.peff.net>
 <20170925202916.4tqo4gttrsoy7kai@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170925202916.4tqo4gttrsoy7kai@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

> In an ideal world, callers would always distinguish between
> these cases and give a useful message for each. But as an
> easy way to make our imperfect world better, let's reset
> errno to a known value. The best we can do is "0", which
> will yield something like:
>
>   unable to read: Success
>
> That's not great, but at least it's deterministic and makes
> it clear that we didn't see an error from read().

Yuck.  Can we set errno to something more specific instead?

read(2) also doesn't promise not to clobber errno on success.

How about something like the following?

-- >8 --
Subject: read_in_full: set errno for partial reads

Many callers of read_in_full() complain when we do not read their full
byte-count. But a check like:

  if (read_in_full(fd, buf, len) != len)
	return error_errno("unable to read");

conflates two problem conditions:

  1. A real error from read().
  2. There were fewer than "len" bytes available.

In the first case, showing the user strerror(errno) is useful. In the
second, we may see a random errno that was set by some previous system
call.

In an ideal world, callers would always distinguish between these
cases and give a useful message for each. But as an easy way to make
our imperfect world better, let's set errno in the second case to a
known value. There is no standard "Unexpected end of file" errno
value, so instead use EILSEQ, which yields a message like

  unable to read: Illegal byte sequence

That's not great, but at least it's deterministic and makes it
possible to reverse-engineer what went wrong.

Change-Id: I48138052f71b7c6cf35c2d00a10dc8febaca4f10
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 wrapper.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/wrapper.c b/wrapper.c
index 61aba0b5c1..1842a99b87 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -318,8 +318,10 @@ ssize_t read_in_full(int fd, void *buf, size_t count)
 		ssize_t loaded = xread(fd, p, count);
 		if (loaded < 0)
 			return -1;
-		if (loaded == 0)
+		if (loaded == 0) {
+			errno = EILSEQ;
 			return total;
+		}
 		count -= loaded;
 		p += loaded;
 		total += loaded;
-- 
2.14.1.821.g8fa685d3b7

