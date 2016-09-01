Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C429120193
	for <e@80x24.org>; Thu,  1 Sep 2016 16:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934015AbcIAQP2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 12:15:28 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34650 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933736AbcIAQP1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 12:15:27 -0400
Received: by mail-wm0-f67.google.com with SMTP id v143so2694229wmv.1
        for <git@vger.kernel.org>; Thu, 01 Sep 2016 09:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=58gZMk9yx9w+Z1GFbHXrDGQErcV91Zyi8zURwID6a+4=;
        b=elYQDpjYtTpSg5FvWVXml4emQWualhk0EE3T32D5dkAlTxM1+xlX1VLBG6r1EZki6P
         dhd7zYfU2ly/hKIGItNbwyrETf0jxypC4VbiKr3xX9w2qONwSrRaQNChJ10vcvhWzxvx
         pTt3lPKv4aDk92Ei79qfMpeD2BgoO51QAuRx+bHDVsuEB5vGeoGMEXhnCCV/OIhvrzns
         U5RpQGoYhwGnHrDqF7ycW/HHcgMTrlhOzf5xmGtE7CcVnbjYzYWos/WrtuBVGTUg7pfB
         44pfMAagkCcy+hkSJ7EHsaJBxYZnwwAFj0FIA2XQ7fb+JhDz+6XeO23ZKJUpw8LU5sq/
         V1Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=58gZMk9yx9w+Z1GFbHXrDGQErcV91Zyi8zURwID6a+4=;
        b=AIX1a0v9iv7yxQAVKS5gy4xtrzSoqhqTkc/lQHNd3J3Gtc6VRVHFTVsGj97QP2CfUo
         QPVrB2x9IS+nMGz7+zmorGelr+ojNAJUuEjf0ik+qV+t2KKaSmBu1vgVRv50QJOwUZLL
         rAj8Iv3h9j+Pt9fUzREUrhQKYdw9yfImzdAImfU9Z+eG2yUtFLI+WVoBkvzKrZKpq2ZV
         UhY7D0AGOjQwfIfTMRgKoimV3Br66wbEHWHs83iYYgH+z3i5p8akparX9eBc6TPQE825
         kgo4muZiCxKEPQL9gnhcyzitP/WIGbLVEkRadcBHszodzZWZYQ0IidDQzia11LZRbwzA
         pZ2A==
X-Gm-Message-State: AE9vXwMwT8091K5aKfmS2D7fp6GsGG8sYb6vsvccKGqjxkZ281+wxRCAva0luwpfgSQB/A==
X-Received: by 10.194.120.37 with SMTP id kz5mr16465837wjb.196.1472746525941;
        Thu, 01 Sep 2016 09:15:25 -0700 (PDT)
Received: from hurricane.home.kaarsemaker.net ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id h7sm6053454wjd.17.2016.09.01.09.15.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Sep 2016 09:15:25 -0700 (PDT)
Message-ID: <1472746523.4680.30.camel@kaarsemaker.net>
Subject: Re: [PATCH 27/34] sequencer (rebase -i): differentiate between
 comments and 'noop'
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Date:   Thu, 01 Sep 2016 18:15:23 +0200
In-Reply-To: <alpine.DEB.2.20.1609011720160.129229@virtualbox>
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
          <736bcb8e860c876e32e8f89f68b0b901abedc187.1472633606.git.johannes.schindelin@gmx.de>
         <1472718815.4680.21.camel@kaarsemaker.net>
         <alpine.DEB.2.20.1609011720160.129229@virtualbox>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On do, 2016-09-01 at 17:32 +0200, Johannes Schindelin wrote:
> Hi Dennis,
> 
> On Thu, 1 Sep 2016, Dennis Kaarsemaker wrote:
> 
> > 
> > On wo, 2016-08-31 at 10:56 +0200, Johannes Schindelin wrote:
> > > 
> > > diff --git a/sequencer.c b/sequencer.c
> > > index 51c2f76..4c902e5 100644
> > > --- a/sequencer.c
> > > +++ b/sequencer.c
> > > @@ -763,7 +763,8 @@ enum todo_command {
> > >         TODO_SQUASH,
> > >         TODO_EXEC,
> > >         TODO_NOOP,
> > > -       TODO_DROP
> > > +       TODO_DROP,
> > > +       TODO_COMMENT
> > >  };
> > (picking a random commit that touches this enum)
> > 
> > In a few places you now make comparisons like "< TODO_NOOP", so I
> > think
> > it would be good to have a comment near the definition of this enum
> > that says that ordering matters and why, so people don't attempt to
> > add
> > a new TODO_FOOBAR at the end.
> True.
> 
> It does not seem that we have a precedent for that. The closest is
> what I
> had in an early iteration of the fsck message IDs, and subsequently
> things
> were refactored so that it is not the order, but a flag, that
> determines
> what the command does.
> 
> Not sure how to do this elegantly. Maybe like this?
> 
> 	enum todo_command {
> 		TODO_PICK_COMMANDS = 0,
> 		TODO_PICK = TODO_PICK_COMMANDS,
> 		TODO_SQUASH,
> 
> 		TODO_NON_PICK_COMMANDS,
> 		TODO_EXEC = TODO_NON_PICK_COMMANDS,
> 
> 		TODO_NOOP_COMMANDS,
> 		TODO_NOOP = TODO_NOOP_COMMANDS,
> 		TODO_DROP
> 		TODO_DROP,
> 
> 		TODO_LAST_COMMAND,
> 		TODO_COMMENT = TODO_LAST_COMMAND
> 	};
> 
> But that is so god-awful to read.

Agreed, that sure is awful.

How about something like

/*
 * Note that ordering matters in this enum. Not only must it match the
 * mapping below, it is also divided into several sections that matter.
 * When adding new commands, make sure you add it in the right section.
 */
enum todo_command {
	/* All commands that handle commits */
	TODO_PICK,
	...
	/* All commands that do something else than pick */
	TODO_EXEC,
	...
	/* All commands that do nothing but are counted for reporting progress */
	TODO_NOOP,
	...
	/* Comments, which are not counted
	TODO_COMMENT
}
