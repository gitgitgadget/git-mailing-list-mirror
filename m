Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A9AC433E0
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 13:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2D1D65060
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 13:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234553AbhCPNGK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 09:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234502AbhCPNF6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 09:05:58 -0400
Received: from mail-out.m-online.net (mail-out.m-online.net [IPv6:2001:a60:0:28:0:1:25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD127C06174A
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 06:05:57 -0700 (PDT)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4F0D765lkSz1ryX4
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 14:05:54 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4F0D765ccPz1qqlD
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 14:05:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id BOY--uPnbioS for <git@vger.kernel.org>;
        Tue, 16 Mar 2021 14:05:52 +0100 (CET)
X-Auth-Info: bHOb0Eg60jGDWK/QrAOQaidU9v0rPKBu7Pey8yAZMm5wC7LJ1KrMDg+ffHqucrzj
Received: from igel.home (ppp-46-244-163-222.dynamic.mnet-online.de [46.244.163.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 14:05:52 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id 5BE782C37EE; Tue, 16 Mar 2021 14:05:51 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     git@vger.kernel.org
Subject: git bisect fails to handle annotated tags
X-Yow:  Did I do an INCORRECT THING??
Date:   Tue, 16 Mar 2021 14:05:51 +0100
Message-ID: <878s6nz1sg.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

$ git --version
git version 2.31.0
$ git bisect start
$ git bisect good v2.30.0
$ git bisect bad v2.31.0
3e90d4b58f3819cfd58ac61cb8668e83d3ea0563 was both good and bad
$ git bisect log
git bisect start
# good: [71ca53e8125e36efbda17293c50027d31681a41f] Git 2.30
git bisect good 2d9685d47a7e516281aa093bf0cddc8aafa72448
# bad: [a5828ae6b52137b913b978e16cd2334482eb4c1f] Git 2.31
git bisect bad 3e90d4b58f3819cfd58ac61cb8668e83d3ea0563
$ git bisect start
Already on 'master'
Your branch is up to date with 'origin/master'.
$ git bisect good v2.30.0^{}
$ git bisect bad v2.31.0^{}
Bisecting: 453 revisions left to test after this (roughly 9 steps)
[41abfe15d95ede4c2a047180a6062eac23d8f7d6] maintenance: add pack-refs task
$ git bisect log
git bisect start
# good: [71ca53e8125e36efbda17293c50027d31681a41f] Git 2.30
git bisect good 71ca53e8125e36efbda17293c50027d31681a41f
# bad: [a5828ae6b52137b913b978e16cd2334482eb4c1f] Git 2.31
git bisect bad a5828ae6b52137b913b978e16cd2334482eb4c1f

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
