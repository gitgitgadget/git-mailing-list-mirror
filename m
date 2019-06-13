Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2A1A1F462
	for <e@80x24.org>; Thu, 13 Jun 2019 16:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392856AbfFMQzg (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 12:55:36 -0400
Received: from resqmta-ch2-07v.sys.comcast.net ([69.252.207.39]:52122 "EHLO
        resqmta-ch2-07v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729992AbfFMB46 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 12 Jun 2019 21:56:58 -0400
Received: from resomta-ch2-02v.sys.comcast.net ([69.252.207.98])
        by resqmta-ch2-07v.sys.comcast.net with ESMTP
        id bDLqhTufPaoW0bEz3h6NHm; Thu, 13 Jun 2019 01:56:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=20190202a; t=1560391017;
        bh=RQt+spEcPo4GSjIIP7qbPIsoO5SVmWr04wtnno5Yz9c=;
        h=Received:Received:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=MJI9TvJyQYIZcSIuMXXIfQ0Uce7AxIx+aYZyi1ihsD28ZbPcZ190En6vFerThkH9G
         /IUyNtwjCchAQX66Wql5EIzorOe4LhvxC/T5v/tsRGJF+xb6AShtidnh5oJNyQE4m8
         NwoayLZFIcVZTdXJLXm3OLmjG1Yd4cYffd6xT5MuXeWiBUMWqs6lS/osLgWKD/YgeW
         PC/xF1cLLwX2kXABuPRWQyJ8zyjDRAwArXL0CYV9XLYGJMWErdHf3f7Bi8bKSG+ngH
         c3GKfHqz1DywDfiI5qLL5IX+Lnh7TM6agVyJQDAoHKvXscIvPxXzfuKjiiIQwBk9T9
         0+TXBfS3Q6hcw==
Received: from comcast.net ([IPv6:2620:15c:2ce:200:8063:176b:924:d4ca])
        by resomta-ch2-02v.sys.comcast.net with ESMTPSA
        id bEyOhUmTyX4ngbEyWhXxhl; Thu, 13 Jun 2019 01:56:54 +0000
X-Xfinity-VMeta: sc=0;st=legit
Date:   Wed, 12 Jun 2019 18:56:16 -0700
From:   Matthew DeVore <matvore@comcast.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matthew DeVore <matvore@google.com>, git@vger.kernel.org,
        avarab@gmail.com, git@matthieu-moy.fr, olyatelezhnaya@gmail.com,
        samuel.maftoul@gmail.com, Johannes.Schindelin@gmx.de,
        karthik.188@gmail.com, pclouds@gmail.com, sunshine@sunshineco.com,
        emilyshaffer@google.com, jrnieder@gmail.com
Subject: Re: [PATCH v2 1/1] ref-filter: sort detached HEAD lines firstly
Message-ID: <20190613015616.GG58112@comcast.net>
References: <faaa9a3d6ba66d77cc2a8eab438d1bfc8f762fa1.1559857032.git.matvore@google.com>
 <cover.1560277373.git.matvore@google.com>
 <cf0246a5cce6cbd9b4a1fd1eefa0f5cbc2cfcaf0.1560277373.git.matvore@google.com>
 <xmqq7e9rlw72.fsf@gitster-ct.c.googlers.com>
 <xmqqo932ik7y.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo932ik7y.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 12, 2019 at 02:09:53PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> Stepping back a bit, why are we even allowing the surrounding ()
> pair to be futzed by the translators?
> 
> IOW, shouldn't our code more like this from the beginning, with or
> without Chinese translation?
> 
> With a bit more work, we may even be able to lose "make sure this
> matches the one in wt-status.c" comment as losing the leading '('
> would take us one step closer to have an identical string here as we
> have in wt-status.c

I think my previous e-mail didn't make it to the public list, maybe since it
contained non-ASCII text. The gist of that mail was that we have full-width
parens in various zh_CN strings so it seems hacky to make just this one be
half-width for the sake of code simplicity.

Giving this a bit more thought now, perhaps the fact that we want to be in-sync
with the string in wt-status.c, combined with the fact that we already have "*"
as half-width metacharacter in the "git branch" output, is a good enough excuse
to drop "()" out of the translatable string, as your patch does.
