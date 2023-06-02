Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1384DC7EE29
	for <git@archiver.kernel.org>; Fri,  2 Jun 2023 19:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236374AbjFBTN5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 15:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234942AbjFBTNz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 15:13:55 -0400
Received: from qproxy1-pub.mail.unifiedlayer.com (qproxy1-pub.mail.unifiedlayer.com [173.254.64.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B84133
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 12:13:54 -0700 (PDT)
Received: from outbound-ss-761.bluehost.com (outbound-ss-761.bluehost.com [74.220.211.250])
        by qproxy1.mail.unifiedlayer.com (Postfix) with ESMTP id 9E4EE80298DE
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 19:13:54 +0000 (UTC)
Received: from cmgw12.mail.unifiedlayer.com (unknown [10.0.90.127])
        by progateway8.mail.pro1.eigbox.com (Postfix) with ESMTP id B9F191003E919
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 19:12:53 +0000 (UTC)
Received: from box5922.bluehost.com ([162.241.30.80])
        by cmsmtp with ESMTP
        id 5ACjqomcE0K9w5ACjqo52P; Fri, 02 Jun 2023 19:12:53 +0000
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.4 cv=Xf5McK15 c=1 sm=1 tr=0 ts=647a3f35
 a=u+82WREdhvUKZ7QTvcqjvQ==:117 a=u+82WREdhvUKZ7QTvcqjvQ==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=IkcTkHD0fZMA:10:nop_charset_1
 a=of4jigFt-DYA:10:nop_rcvd_month_year
 a=3EOfIcITIxQA:10:endurance_base64_authed_username_1 a=fT6DP1TIeAv9dCBC-a0A:9
 a=QEXdDO2ut3YA:10:nop_charset_2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mad-scientist.us; s=default; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:Reply-To:From:Subject:Message-ID:
        Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wHTsuH7cZXmnhILEne9lK0Xfo0aDtcn+7a56BoU1DvE=; b=b/PB4iofR9iTHC/MScXx/UEiT1
        HFTE/WBHxkk6YO4gNGHXowwtL2jUVb010R7GIJYKtDjI1QLAPxaNJHf1ORQfzEzNvm+AXV5BgStU3
        yR6fJJvSIVTe2UIfFgSwvYTEF;
Received: from [160.231.0.90] (port=57788 helo=llin-psh13-dsa.dsone.3ds.com)
        by box5922.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <paul@mad-scientist.net>)
        id 1q5ACj-000TjE-D6
        for git@vger.kernel.org;
        Fri, 02 Jun 2023 13:12:53 -0600
Message-ID: <7aa2ab6714bd14671ba9cfff611dea2fa088c99e.camel@mad-scientist.net>
Subject: Re: Anyone know why git ls-remote output might be corrupted?
From:   Paul Smith <paul@mad-scientist.net>
Reply-To: paul@mad-scientist.net
To:     git@vger.kernel.org
Date:   Fri, 02 Jun 2023 15:12:52 -0400
In-Reply-To: <b6f210da2c3cc7746b984b797ad89687cba2d1f8.camel@mad-scientist.net>
References: <b6f210da2c3cc7746b984b797ad89687cba2d1f8.camel@mad-scientist.net>
Organization: Please remain calm--I may be mad but I am a professional!
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.2 (by Flathub.org) 
MIME-Version: 1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5922.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mad-scientist.net
X-BWhitelist: no
X-Source-IP: 160.231.0.90
X-Source-L: No
X-Exim-ID: 1q5ACj-000TjE-D6
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (llin-psh13-dsa.dsone.3ds.com) [160.231.0.90]:57788
X-Source-Auth: paul@mad-scientist.us
X-Email-Count: 1
X-Source-Cap: bWFkc2NpZTE7bWFkc2NpZTE7Ym94NTkyMi5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 2023-06-02 at 14:59 -0400, Paul Smith wrote:
> Also a bunch of the heads are missing.=C2=A0 It's pretty clear that right
> in the middle of printing one of the SHAs we suddenly lost a bunch of
> output, and started printing stuff from later (in the last instance
> 66 out of 131 heads were missing).

I forgot to mention: git ls-remote does not exit with an error code.=20
The exit code is 0 (success).

The reason I get this failure is that as I parse the output I notice
that the SHA is invalid (contains a non-hex character "i") and it
throws this error.
