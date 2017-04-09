Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD68820966
	for <e@80x24.org>; Sun,  9 Apr 2017 11:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752288AbdDILAO (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Apr 2017 07:00:14 -0400
Received: from mail.ableton.net ([62.96.12.117]:44261 "EHLO mail.ableton.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752072AbdDILAN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Apr 2017 07:00:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ableton.com; s=mail;
        h=Content-Type:MIME-Version:Message-ID:Date:From:Subject:In-Reply-To:CC:To; bh=nm/ZMZtf5Bc8AUfOPEQP0M0Fd2mxu3ywmVCuQ01+PyQ=;
        b=IZhHP7crBuI0EHt+XnMmFZJCe2WgG8AD8FygelYeW2099b3UBlHVRyPZNEh8pFef5GSOdhjuGm1c5sAY1PRqmgNFy1EpUOWFF0Z0Ax0cDoO/ji+F73/Z1D7+3043pfja+mdQR8s2/f6auaSedgpREEvBndg0vjVirL0XVFaMVEA=;
Received: from moon.office.ableton.com ([10.1.15.25])
        by mail.ableton.net with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.82)
        (envelope-from <haller@ableton.com>)
        id 1cxAZn-0002dn-DI; Sun, 09 Apr 2017 11:00:11 +0000
Received: from [192.168.42.152] (178.0.62.147) by mail.office.ableton.com
 (10.1.15.25) with Microsoft SMTP Server (TLS) id 14.3.319.2; Sun, 9 Apr 2017
 13:00:10 +0200
To:     Jacob Keller <jacob.keller@gmail.com>
CC:     Jeff King <peff@peff.net>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=3F_Bjarmason?= <avarab@gmail.com>,
        Matt McCutchen <matt@mattmccutchen.net>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
In-Reply-To: <CA+P7+xqS1Fh0aDV=QYbVMdRa=M4e-mBtjvknR=U_RShDoccNjQ@mail.gmail.com>
Subject: Re: Tools that do an automatic fetch defeat "git push --force-with-lease"
From:   Stefan Haller <haller@ableton.com>
Date:   Sun, 9 Apr 2017 13:00:10 +0200
Message-ID: <1n47so5.9e6qvf1bbqww4M%haller@ableton.com>
Organization: Ableton
User-Agent: MacSOUP/2.8.6b1 (Mac OS 10.12.4)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [178.0.62.147]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> wrote:

> Agreed. You "take" a lease whenever you push to the remote or when you
> pull from the remote and when you pull into the branch. It should
> store something that tracks both the branch and remote branch together
> so that you can generalize it to multiple remotes.

I don't see why it has to support multiple remotes (but then I don't
have much experience with workflows involving multiple remotes, so I may
well be missing something). A local branch can only have one remote
tracking branch on one remote, and in my view --force-with-lease without
arguments works with that remote tracking branch only. Is this view too
simple?

> It doesn't necessarily track perfectly with a branch that contains
> extra work such as when doing pull --rebase, but maybe you have an
> idea about that?

Maybe I wasn't clear enough about that in my proposal, but I propose to
always store the commit hash of the remote tracking branch as a new
lease after push and pull, not the local branch. This way it works
nicely with pull --rebase and a branch that has extra local commits.


-- 
Stefan Haller
Ableton
http://www.ableton.com/
