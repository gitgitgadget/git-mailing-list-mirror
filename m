Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AFA31F9F6
	for <e@80x24.org>; Tue, 13 Nov 2018 22:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbeKNI0D (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 03:26:03 -0500
Received: from mail-pl1-f170.google.com ([209.85.214.170]:33125 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbeKNI0C (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 03:26:02 -0500
Received: by mail-pl1-f170.google.com with SMTP id w22-v6so6732262plk.0
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 14:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HbljWkgxH7aW0a9PkJCBS5IIJAvoO6MKIkWMUvLOVvk=;
        b=YOMq7+nQHlcwhAwEKsg2e5G+afL9Erx2VwrTIVr9qlXlNV0CWlg2pUGJ3YhOZ6CYM1
         T1sHqJF1T4xD1CT9rHZG3eUy4ERd/26F13L07nxL8hKmIlk8JbrXOTl2kNEaRzMy+gXg
         u/ccBaD7d0BcTF2nVxqMzPvXCi13/XMJsUQb0TV7TUYLn4Zj18CuNdiruMQLJ4UTdKky
         cKucDJ9CZhbkeuVmvZq68PjIiq6alMNfmMTTidnVLk/By+GSQwZrgT3clgrgH64VzpSE
         WjIkW0ccZyXv6+mdv8pPxP/KUQ2x4DBJSlN6cW2uClLB3FhDMyHQfyUUPeIfK4v2b3ZG
         W9LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=HbljWkgxH7aW0a9PkJCBS5IIJAvoO6MKIkWMUvLOVvk=;
        b=t7rg5vJIHzxDzB4rAHjve+ZbkiVChreOfAPj3BaXqphOTfKhdeElUNhWxx3MNkpMQm
         ypfcHZC2IYqyUAyBgkH2GU+Pgz19laaeNXV9nSEgKaXTmnxcr4WqAMjQeYXwtSX0Ow9i
         JsokLoX658e9H4PWPus8rQ5hyn0V2qtr8wGZw/myqPoyPug0qmDyrKbmCft0Vtgs4NQC
         Q7byXFWw9glhSLPrkS4BTwTUNMTJIKm/EDwzwUhy53ev3KCVzVWGVaD6kah83zpEAdNJ
         2gOB/T05zkqlujeeTZIH28W3kbwaHA0JN5gOaM3vThKrZk8cE5rsImjMmZa/PB2ZiDmf
         Mheg==
X-Gm-Message-State: AGRZ1gKC43/N+ycsOJYAuZ3ISqD6GPJKBxikxIzbtZt66tiEqRt+rHXY
        2iuXEHJ1N6ynnaRuYqGvcqcvXXW2QQV7oA==
X-Google-Smtp-Source: AJdET5db3atZTaBN40+8k7K5NxaE5mXJSqDze4DQXnfs5Cvp9K3oDrlYWzbhf93x9L4vrQs1RHZkgQ==
X-Received: by 2002:a17:902:9a07:: with SMTP id v7-v6mr6708911plp.14.1542147947704;
        Tue, 13 Nov 2018 14:25:47 -0800 (PST)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id g64-v6sm24068279pfe.37.2018.11.13.14.25.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 14:25:46 -0800 (PST)
Date:   Tue, 13 Nov 2018 14:25:40 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] remote-curl: die on server-side errors
Message-ID: <20181113222540.GE126896@google.com>
Mail-Followup-To: Jeff King <peff@peff.net>, git@vger.kernel.org
References: <9a89e54e79593f6455b52e01d802695362f4ec21.1542062657.git.steadmon@google.com>
 <20181113142624.GA17128@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113142624.GA17128@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018.11.13 09:26, Jeff King wrote:
> On Mon, Nov 12, 2018 at 02:44:56PM -0800, steadmon@google.com wrote:
> 
> > When a smart HTTP server sends an error message via pkt-line,
> > remote-curl will fail to detect the error (which usually results in
> > incorrectly falling back to dumb-HTTP mode).
> > 
> > This patch adds a check in discover_refs() for server-side error
> > messages, as well as a test case for this issue.
> 
> Aside from the reformatting of the conditional that Junio mentioned,
> this seems pretty good to me. But while looking at that, I found a few
> things, some old and some new. :)
> 
> > diff --git a/remote-curl.c b/remote-curl.c
> > index 762a55a75f..bb3a86505e 100644
> > --- a/remote-curl.c
> > +++ b/remote-curl.c
> > @@ -436,7 +436,9 @@ static struct discovery *discover_refs(const char *service, int for_push)
> >  	} else if (maybe_smart &&
> >  		   last->len > 5 && starts_with(last->buf + 4, "version 2")) {
> >  		last->proto_git = 1;
> > -	}
> > +	} else if (maybe_smart && last->len > 5 &&
> > +		   starts_with(last->buf + 4, "ERR "))
> > +		die(_("remote error: %s"), last->buf + 8);
> 
> The magic "4" here and in the existing "version 2" check is because we
> are expecting pkt-lines. The original conditional always calls
> packed_read_line_buf() and will complain if we didn't actually get a
> pkt-line.
> 
> Should we confirm that we got a real packet-line? Or at least that those
> first four are even plausible hex chars?
> 
> I admit that it's pretty unlikely that the server is going to fool us
> here. It would need something like "foo ERRORS ARE FUN!". And even then
> we'd report an error (whereas the correct behavior is falling back to
> dumb http, but we know that won't work anyway because that's not a valid
> ref advertisement). So I doubt this is really a bug per se, but it might
> make it easier to understand what's going on if we actually parsed the
> packet.

Unfortunately we can't just directly parse the data in last->buf,
because other parts of the code are expecting to see the raw pkt-line
data there. I tried adding a duplicate pointer and length variable for
this data and parsing that through packet_read_line_buf(), but even
without using the results this apparently has side-effects that break
all of t5550 (and probably other tests as well). It also fails if I
completely duplicate last->buf into a new char* and call
packet_readline_buf() on that, so there's clearly some interaction in
the pkt-line guts that I'm not properly accounting for.

> Similarly, we seem eager to accept "version 2" even if we are only
> expecting v0. I know you have another series working in that direction,
> but I don't think it touches this "proto_git". I guess accepting
> "version 2" as "we're speaking git protocol" and then barfing later with
> "wait, I didn't mean to speak v2" is probably OK.
> 
> -Peff
