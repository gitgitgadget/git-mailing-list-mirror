Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CA171F424
	for <e@80x24.org>; Mon, 23 Apr 2018 16:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755549AbeDWQWq (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 12:22:46 -0400
Received: from tak.tresgeek.net ([68.90.68.206]:35816 "EHLO
        bevomill.tresgeek.net" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1755418AbeDWQWp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 12:22:45 -0400
X-Greylist: delayed 541 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Apr 2018 12:22:45 EDT
Received: from localhost (localhost [127.0.0.1])
        by bevomill.tresgeek.net (Postfix) with ESMTP id 9698F2003005
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 11:13:43 -0500 (CDT)
Received: from bevomill.tresgeek.net ([127.0.0.1])
        by localhost (bevomill.tresgeek.net [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id zpnO8JhNni1H for <git@vger.kernel.org>;
        Mon, 23 Apr 2018 11:13:42 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
        by bevomill.tresgeek.net (Postfix) with ESMTP id 71C1E2003006
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 11:13:42 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 bevomill.tresgeek.net 71C1E2003006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tresgeek.net;
        s=EF7A3342-164F-11E6-87A2-DFDB960215AC; t=1524500022;
        bh=WbmYTpMX/R4RZ3XnJb2b7oHZfQ8TSU/gAqqODN5IKT4=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=tLwmg2+XJ/u+X7KJeL9l7ztT/Eb03sdvv5EFDEyuUr3eshRnDzmXUEYWuzYRKw3Cf
         xXMsADTY0qUkHzTMRC83ZD2W6l3WfKP1J22RiM1BL8RRnlMA8q5+Pa7w5dt80ei46n
         D9t6O65qtYf6pXbBU7tG9LMwP/25eoxLfKBLices=
X-Virus-Scanned: amavisd-new at tresgeek.net
Received: from bevomill.tresgeek.net ([127.0.0.1])
        by localhost (bevomill.tresgeek.net [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id A0v1SJn10DtX for <git@vger.kernel.org>;
        Mon, 23 Apr 2018 11:13:42 -0500 (CDT)
Received: from bevomill.tresgeek.net (bevomill.tresgeek.net [68.90.68.206])
        by bevomill.tresgeek.net (Postfix) with ESMTP id 5296A2003005
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 11:13:42 -0500 (CDT)
Date:   Mon, 23 Apr 2018 11:13:41 -0500 (CDT)
From:   "Jason B. Nance" <jason@tresgeek.net>
To:     git@vger.kernel.org
Message-ID: <2048535297.1044.1524500021908.JavaMail.zimbra@tresgeek.net>
Subject: SEC_E_BUFFER_TOO_SMALL on Windows
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.7.11_GA_1854 (ZimbraWebClient - FF52 (Win)/8.7.11_GA_1854)
Thread-Index: qiC8jF54ZRrvRj62hqJ3gsCExnyjjA==
Thread-Topic: SEC_E_BUFFER_TOO_SMALL on Windows
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

We are seeing intermittent errors with Git 2.16.2.windows.1 on Windows 7 connecting to TFS 2017 (running in a Jenkins slave process):

    ERROR: Error cloning remote repo 'origin' hudson.plugins.git.GitException: Command "C:\tools\Git\bin\git.exe fetch --tags --progress https://internal-tfs-server/tfs/project/_git/repo +refs/heads/*:refs/remotes/origin/*" returned status code 128:
    stdout: 
    stderr: fatal: unable to access 'https://internal-tfs-server/tfs/project/_git/repo/': schannel: next InitializeSecurityContext failed: SEC_E_BUFFER_TOO_SMALL (0x80090321) - The buffers supplied to a function was too small.

I found the following thread from 2015 on a cURL list that seems to be similar:

    https://curl.haxx.se/mail/lib-2015-04/0136.html

However, it looks like a patch was released for that issue:

    https://curl.haxx.se/mail/lib-2015-04/0152.html

Rebooting the Windows client appears to resolve the issue for a time.

Has anyone else experienced this and found a resolution or workaround?

Thank you,

j
