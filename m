Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627D9C433EF
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 14:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4639A60296
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 14:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbhKBOH3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Nov 2021 10:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbhKBOH2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Nov 2021 10:07:28 -0400
X-Greylist: delayed 352 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 02 Nov 2021 07:04:52 PDT
Received: from sprint-2.amdmi3.ru (sprint-2.amdmi3.ru [IPv6:2a0a:2b41:94:cb5e::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5F0C9C061714
        for <git@vger.kernel.org>; Tue,  2 Nov 2021 07:04:52 -0700 (PDT)
Received: from amdmi3.ru (localhost [IPv6:::1])
        by sprint-2.amdmi3.ru (Postfix) with SMTP id 03CBA187EE0
        for <git@vger.kernel.org>; Tue,  2 Nov 2021 16:58:56 +0300 (MSK)
Received: by amdmi3.ru (nbSMTP-1.00) for uid 1000
        amdmi3@amdmi3.ru; Tue,  2 Nov 2021 16:58:57 +0300 (MSK)
Date:   Tue, 2 Nov 2021 16:58:43 +0300
From:   Dmitry Marakasov <amdmi3@amdmi3.ru>
To:     git@vger.kernel.org
Subject: pull.rebase config option broken in 2.33.1
Message-ID: <YYFEE/2g3SiM04zx@hades.panopticon>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

After update from 2.33.0 to 2.33.1 the pull.rebase = true option
no longer works: `git pull` no longer tries to rebase (however manual
`git pull --rebase` works fine):

% git config pull.rebase
true
% git pull
fatal: Not possible to fast-forward, aborting.
% git pull --rebase
Successfully rebased and updated refs/heads/local-fixes.
% git pull
fatal: Not possible to fast-forward, aborting.
% grep -C1 rebase .git/config
[pull]
	rebase = true
[rebase]
	autostash = true

After downgrade to 2.33.0:

% git pull
Current branch local-fixes is up to date.

-- 
Dmitry Marakasov   .   55B5 0596 FF1E 8D84 5F56  9510 D35A 80DD F9D2 F77D
amdmi3@amdmi3.ru  ..:     https://github.com/AMDmi3  https://amdmi3.ru

