Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F6641F404
	for <e@80x24.org>; Sun, 15 Apr 2018 19:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752604AbeDOTEl (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Apr 2018 15:04:41 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:37573 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752470AbeDOTEk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Apr 2018 15:04:40 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 40PLY21nqdz1rFcN
        for <git@vger.kernel.org>; Sun, 15 Apr 2018 21:04:38 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 40PLY21h70z1qqkc
        for <git@vger.kernel.org>; Sun, 15 Apr 2018 21:04:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id a31nfWOfrGVh for <git@vger.kernel.org>;
        Sun, 15 Apr 2018 21:04:37 +0200 (CEST)
X-Auth-Info: iQpjXMq62FHmxj3EkwMjyDAHJHvckqfZOlTzSr1q8GZvuKsWvxWZMHIAiUlIDySI
Received: from localhost (ppp-188-174-156-232.dynamic.mnet-online.de [188.174.156.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA
        for <git@vger.kernel.org>; Sun, 15 Apr 2018 21:04:37 +0200 (CEST)
Received: by localhost (Postfix, from userid 1000)
        id 4CBCD2C3D5A; Sun, 15 Apr 2018 21:04:36 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     git@vger.kernel.org
Subject: .gitattributes lookup doesn't respect GIT_WORK_TREE
X-Yow:  MMM-MM!!  So THIS is BIO-NEBULATION!
Date:   Sun, 15 Apr 2018 21:04:36 +0200
Message-ID: <877ep8p9yz.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The functions in attr.c do not look at $GIT_WORK_TREE when trying to
find the .gitattributes file.  Thus if you are not inside the work tree,
but have GIT_WORK_TREE set attribute lookup will be wrong.

Password Store <http://www.passwordstore.org/> is using this feature
when the password store is a git repository.  It sets up a diff
attribute that decrypts the contents, but that works only if the command
is issued while inside the repository.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
