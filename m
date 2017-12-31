Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8261D1F406
	for <e@80x24.org>; Sun, 31 Dec 2017 19:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751096AbdLaTTA (ORCPT <rfc822;e@80x24.org>);
        Sun, 31 Dec 2017 14:19:00 -0500
Received: from shout01.mail.de ([213.128.151.216]:55125 "EHLO shout01.mail.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751075AbdLaTS6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Dec 2017 14:18:58 -0500
X-Greylist: delayed 370 seconds by postgrey-1.27 at vger.kernel.org; Sun, 31 Dec 2017 14:18:58 EST
Received: from postfix01.mail.de (postfix01.bt.mail.de [10.0.121.125])
        by shout01.mail.de (Postfix) with ESMTP id 2E42740071;
        Sun, 31 Dec 2017 20:12:47 +0100 (CET)
Received: from smtp03.mail.de (smtp03.bt.mail.de [10.0.121.213])
        by postfix01.mail.de (Postfix) with ESMTP id 15C2743D9D;
        Sun, 31 Dec 2017 20:12:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.de;
        s=mailde201610; t=1514747567;
        bh=V/2eMG5kMoHcf9EdSdNJ4FxqYIB2rjbVOXU39F/GtuY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ES0+Z2M/n/yzIf9grFIrs+M96s/GwVIy3ftOiuEH1o4gNFb2Eko7VdzOV5Q5LLTrm
         qYkeXPQBU8tg50ZAVvtUXEb/h9fhXJQ4QiwhgoISICEg3EoZO2Lh6GtHLWsxzZLtPQ
         eR5mUehly2OaOXIQpvNArGJ9CXPA1sdNBEJM2Jgs=
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp03.mail.de (Postfix) with ESMTPSA id 926CD80031;
        Sun, 31 Dec 2017 20:12:46 +0100 (CET)
From:   Stefan Moch <stefanmoch@mail.de>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Simon Doodkin <helpmepro1@gmail.com>, git@vger.kernel.org
Subject: Re: feature-request: git "cp" like there is git mv.
Date:   Sun, 31 Dec 2017 20:11:54 +0100
Message-Id: <20171231191156.28359-1-stefanmoch@mail.de>
In-Reply-To: <20171216013130.GB188893@aiede.mtv.corp.google.com>
References: <20171216013130.GB188893@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 722
X-purgate-ID: 154282::1514747566-00006A20-9CCF5310/0/0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

* Jonathan Nieder <jrnieder@gmail.com> [2017-12-15T17:31:30-0800]:
> This sounds like a reasonable thing to add.  See builtin/mv.c for how
> "git mv" works if you're looking for inspiration.
> 
> cmd_mv in that file looks rather long, so I'd also be happy if someone
> interested refactors to break it into multiple self-contained pieces
> for easier reading (git mostly follows
> https://www.kernel.org/doc/html/latest/process/coding-style.html#functions).

I looked at builtin/mv.c and have a rough idea how to split it
up to support both mv and cp commands.

But first I noticed and removed a redundant check in cmd_mv,
also added a test case to check if mv --dry-run does not move
the file.


Stefan
