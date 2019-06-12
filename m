Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 316F61F462
	for <e@80x24.org>; Wed, 12 Jun 2019 14:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409267AbfFLOVQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jun 2019 10:21:16 -0400
Received: from gproxy2-pub.mail.unifiedlayer.com ([69.89.18.3]:40046 "EHLO
        gproxy2-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2409256AbfFLOVQ (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 12 Jun 2019 10:21:16 -0400
X-Greylist: delayed 1409 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Jun 2019 10:21:15 EDT
Received: from CMGW (unknown [10.9.0.13])
        by gproxy2.mail.unifiedlayer.com (Postfix) with ESMTP id 286F31E0AA1
        for <git@vger.kernel.org>; Wed, 12 Jun 2019 07:57:46 -0600 (MDT)
Received: from box5008.bluehost.com ([50.116.64.19])
        by cmsmtp with ESMTP
        id b3l3hCN4PeyBxb3l4hW7KJ; Wed, 12 Jun 2019 07:57:46 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mad-scientist.us; s=default; h=Content-Transfer-Encoding:Mime-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:Reply-To:From:Subject:
        Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4BBrgGvTQ2v1sUuzpEzTz8gTi+W/qlWPPA2VAUufK/o=; b=2OtTsbzjxIxLD1Ks5vdXY4eJ4P
        lXJ1Hix0GU5kc7JRcW8KPi7su5wwRkMHQyUy7E6qCTPa1IaCrW5SoioSAEmvyuOFLlQ+/IjDPJtdt
        SKrD6Ce0ZlAthhrqjPoUpoofQ;
Received: from [50.226.24.42] (port=42596 helo=pdslaptop)
        by box5008.bluehost.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <paul@mad-scientist.net>)
        id 1hb3l3-0047gp-HG; Wed, 12 Jun 2019 07:57:45 -0600
Message-ID: <9c488ce8c1e1e6d6d4c343b0b40c8a64c8147a7f.camel@mad-scientist.net>
Subject: Re: Reducing git size by building libgit.so
From:   Paul Smith <paul@mad-scientist.net>
Reply-To: paul@mad-scientist.net
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Elmar Pruesse <p@ucdenver.edu>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Date:   Wed, 12 Jun 2019 09:57:43 -0400
In-Reply-To: <20190611234815.GB8616@genre.crustytoothpaste.net>
References: <21f1f334-755e-3283-d0da-ec0ab9231cfc@ucdenver.edu>
         <20190611234815.GB8616@genre.crustytoothpaste.net>
Organization: Please remain calm--I may be mad but I am a professional!
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5008.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mad-scientist.net
X-BWhitelist: no
X-Source-IP: 50.226.24.42
X-Source-L: No
X-Exim-ID: 1hb3l3-0047gp-HG
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (pdslaptop) [50.226.24.42]:42596
X-Source-Auth: paul@mad-scientist.us
X-Email-Count: 1
X-Source-Cap: bWFkc2NpZTE7bWFkc2NpZTE7Ym94NTAwOC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2019-06-11 at 23:48 +0000, brian m. carlson wrote:
> Also, some people install Git into their home directories, and a
> shared library means that they'll have to use LD_LIBRARY_PATH (or
> equivalent) to run Git.

I don't have strong feeling about .so's although obviously less disk
space used is always a good thing, everything else being equal.

However, the above concern isn't actually an issue.  You can install
the .so in a known location relative to the binaries, then link the
binaries with an RPATH setting using $ORIGIN (or the equivalent on
MacOS which does exist but I forget the name).  On Windows, DLLs are
installed in the same directory as the binary, typically.

Allowing relocatable binaries with .so dependencies without requiring
LD_LIBRARY_PATH settings is a solved problem, to the best of my
understanding.


One thing to think about is that runtime loading a .so can take some
time if it has lots of public symbols.  If someone really wanted to do
this, the ideal thing would be to make all symbols hidden except those
needed by the binary front-ends and have those be very small shells
that just had a very limited number of entry points into the .so.

Maybe for git this doesn't matter but for some projects I've worked on
the time to dlopen() a library was a blocking issue that the above
procedure solved nicely.

