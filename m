Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 482DE1F462
	for <e@80x24.org>; Tue,  4 Jun 2019 17:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbfFDRiW (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jun 2019 13:38:22 -0400
Received: from resqmta-po-07v.sys.comcast.net ([96.114.154.166]:36554 "EHLO
        resqmta-po-07v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726179AbfFDRiW (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 4 Jun 2019 13:38:22 -0400
Received: from resomta-po-18v.sys.comcast.net ([96.114.154.242])
        by resqmta-po-07v.sys.comcast.net with ESMTP
        id YAP3hzTBYoy4VYDO9hB6Ve; Tue, 04 Jun 2019 17:38:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=20190202a; t=1559669901;
        bh=ojgj2Yqs8jZmq9JqFc9s5+vcftuOg1qI5L1Jt+8jdHA=;
        h=Received:Received:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=NEMACKe1AoW/JkfBoL++ZT4ABDscAstL7S2mneJ+F9+VNh4WUCakP3cKm622em3t3
         ErTiL8SAbNQgW2ISZc1JyRmHeaQOzCyr8f4ZqKAvfWv0M5DlI3XqY/utPTMsUQYe3O
         h9/lOgyLqDmkTvjK7f+5LoVYq9nH/iW64m52NslyrKc0yWSsH2vJQp/uK19tEx5T9C
         S/mhuStCCARDNwadBUQtNF4AP3Pw50LKWNUllHRSX/H5bIvdg3WDks75hZ2ZpCFz3R
         qfHVhSOHXRIi9bYALGVkO+56ZNhtBt7PocZgiSG6kFENxtmPopmIx46Q/qa4N3WzfG
         SySRMaIdMXBMw==
Received: from comcast.net ([IPv6:2601:647:4b02:2491:f95f:aa00:d2b2:a5dd])
        by resomta-po-18v.sys.comcast.net with ESMTPSA
        id YDO6hoVDctBiqYDO7hiZxT; Tue, 04 Jun 2019 17:38:20 +0000
X-Xfinity-VMeta: sc=0;st=legit
Date:   Tue, 4 Jun 2019 10:38:18 -0700
From:   Matthew DeVore <matvore@comcast.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Matthew DeVore <matvore@google.com>, git@vger.kernel.org,
        jeffhost@microsoft.com, l.s.r@web.de, gitster@pobox.com,
        spearce@spearce.org, jrn@google.com
Subject: Re: [PATCH 2/2] url: do not allow %00 to represent NULL in URLs
Message-ID: <20190604173818.GL4641@comcast.net>
References: <20190603204526.7723-1-matvore@google.com>
 <20190603204526.7723-3-matvore@google.com>
 <20190604010243.GR8616@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604010243.GR8616@genre.crustytoothpaste.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 04, 2019 at 01:02:43AM +0000, brian m. carlson wrote:
> It looks like several of the places we do this are in the credential
> manager code, and I think I can agree that usernames and passwords
> should not contain NUL characters (for Basic auth, RFC 7617 prohibits
> it). It also seems that the credential code decodes the path parameter
> before passing it on, which is unfortunate, but can't be changed for
> backward compatibility reasons.
> 
> And then the other instances are a file: URL in remote-testsvn.c and
> query parameters that have no reason to contain NULs in http-backend.c.

OK. Good to know that there is no justification to support %00 in URLs.

> So I think overall this is fine, although we probably want to change the
> commit summary to say "NUL" instead of "NULL".

Applied for the next roll-up. Thank you for taking a look.
