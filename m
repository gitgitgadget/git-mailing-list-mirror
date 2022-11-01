Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5477CC4332F
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 18:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiKASMQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 14:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiKASMK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 14:12:10 -0400
X-Greylist: delayed 439 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 01 Nov 2022 11:12:08 PDT
Received: from mail.cboltz.de (mail.cboltz.de [88.99.101.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5811D0F9
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 11:12:07 -0700 (PDT)
X-sprachakt.com-SMTP-Auth: no
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.cboltz.de (Postfix) with ESMTP id 4C6A85C0290;
        Tue,  1 Nov 2022 19:04:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at mail.cboltz.de
Received: from mail.cboltz.de ([127.0.0.1])
        by localhost (mail.cboltz.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CtwKHIPNvbso; Tue,  1 Nov 2022 19:04:44 +0100 (CET)
Received: from [192.168.178.40] (i59F7FFE7.versanet.de [89.247.255.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by mail.cboltz.de (Postfix) with ESMTPSA;
        Tue,  1 Nov 2022 19:04:44 +0100 (CET)
Message-ID: <f1a5f758-d81f-5985-9b5d-2f0dbfaac071@opensuse.org>
Date:   Tue, 1 Nov 2022 19:04:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To:     git@vger.kernel.org
From:   Sarah Julia Kriesch <sarah.kriesch@opensuse.org>
Subject: git can not be built for s390x since update to git-2.38.0
Cc:     andreas.stieger@gmx.de
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am one of the zsystems Maintainers (s390x architecture) at openSUSE 
and git can not be built any more since the update from 2.37.3 to 
2.38.0, and with 2.38.1 afterwards. We have tried to debug it.

There is no real test error output, but we can identify, that it is 
happening in the test part with check-chainlint.

[  386s] + ./.make -j2 test
[  386s] /usr/bin/make -C git-gui  gitexecdir='/usr/libexec/git' all
[  387s] /usr/bin/make -C gitk-git  all
[  387s] /usr/bin/make -C templates  SHELL_PATH='/bin/sh' 
PERL_PATH='/usr/bin/perl'
[  387s] make[1]: Entering directory 
'/home/abuild/rpmbuild/BUILD/git-2.38.1/templates'
[  387s] : no custom templates yet
[  387s] make[1]: Leaving directory 
'/home/abuild/rpmbuild/BUILD/git-2.38.1/templates'
[  387s] /usr/bin/make -C t/ all
[  387s] make[1]: Entering directory 
'/home/abuild/rpmbuild/BUILD/git-2.38.1/t'
[  387s] rm -f -r 'test-results'
[  387s] make[1]: Leaving directory 
'/home/abuild/rpmbuild/BUILD/git-2.38.1/t'
[  387s] make[1]: Entering directory 
'/home/abuild/rpmbuild/BUILD/git-2.38.1/t'
[  387s] make[1]: *** [Makefile:83: check-chainlint] Error 1
[  387s] make[1]: Leaving directory 
'/home/abuild/rpmbuild/BUILD/git-2.38.1/t'
[  387s] make[1]: *** Waiting for unfinished jobs....
[  388s] make: *** [Makefile:3075: test] Error 2
[  388s] error: Bad exit status from /var/tmp/rpm-tmp.ztqAAp (%check)
[  388s]

We figured out, that the perl script have been changed there in the last 
month.
I have to give the hint, that all versions of openSUSE for s390x are 
affected by this build failure. Builds are working for the other 
architectures.

How can we fix this issue?

-- 
Sarah Julia Kriesch
openSUSE
