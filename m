Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D78C001DC
	for <git@archiver.kernel.org>; Wed, 26 Jul 2023 19:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjGZTHa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jul 2023 15:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjGZTH3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2023 15:07:29 -0400
X-Greylist: delayed 313 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 26 Jul 2023 12:07:26 PDT
Received: from dd36226.kasserver.com (dd36226.kasserver.com [85.13.153.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA9B198D
        for <git@vger.kernel.org>; Wed, 26 Jul 2023 12:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=haller-berlin.de;
        s=kas202302241129; t=1690398130;
        bh=TWfn8bGH8v15wRMm/7s3ZCsUIWqMrpd8dzGm7Gm6Ltg=;
        h=Date:To:From:Subject:Cc:From;
        b=FU0cfAK4FR9rNWH6ymodZrUtMeRinB0HPhJRTL2CgLiDO/NaYmwU/s4b7CNLF5ABT
         MpQYV/Cw5WGsRwnrap7dWFKR8xATTHvwI0VDNeFVc4lETk8ShM3wnFP9VHFSw1PSz8
         UNl9/11UMl2Z2h2p69qdIU3o1zGDSGAXEdRKJjBm46RJjietJkCrTgSGDThC30w5Gj
         TjSNeU5S+uzIczLCmuOEVN3RB5S8CqqKRprA90yNxupyATWRXXsSgnR/VOxJKKTe1S
         2HMB22VDQRtxiQgjLnDkPLpL7wCn+VJNZzT+R2X8d0PmYM12cBhYe6vZdjcRT4XZhB
         ruMpnVfSv39Ag==
Received: from [192.168.1.103] (m90-132-120-221.cust.tele2.se [90.132.120.221])
        by dd36226.kasserver.com (Postfix) with ESMTPSA id 19E5E3C0033;
        Wed, 26 Jul 2023 21:02:10 +0200 (CEST)
Message-ID: <f51c73ed-eb03-83ca-fb31-d3e2645c9a63@haller-berlin.de>
Date:   Wed, 26 Jul 2023 21:02:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Content-Language: de-DE, en-US
To:     git@vger.kernel.org, Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
From:   Stefan Haller <lists@haller-berlin.de>
Subject: --force-if-includes only works if local and remote brach names are
 the same
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: +
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The --force-if-includes option of git push only seems to work if my
local ref matches the name of the remote ref that I'm pushing to. It
would be nice if I could also use it if that's not the case.

For example:

  git checkout -b main-myremote myremote/main
  git push -u myremote main-myremote:main
  # Hack hack hack, rebase rebase
  git push --force-if-includes --force-with-lease

This fails, as it does the check_if_includes_upstream check against the
local main, which is unrelated.

(Cc'ing a few people who were involved in the review of the patch series
that introduced the --force-if-includes option.)

-Stefan
