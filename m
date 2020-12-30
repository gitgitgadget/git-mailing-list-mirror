Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_20,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A61C433DB
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 12:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AAC622227
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 12:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgL3MOQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Dec 2020 07:14:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgL3MOQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Dec 2020 07:14:16 -0500
X-Greylist: delayed 492 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Dec 2020 04:13:36 PST
Received: from vps892.directvps.nl (unknown [IPv6:2a02:2308::216:3eff:fede:83d0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A024C061799
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 04:13:36 -0800 (PST)
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id DC97344012C; Wed, 30 Dec 2020 13:05:21 +0100 (CET)
Date:   Wed, 30 Dec 2020 13:05:21 +0100
From:   Kevin Daudt <me@ikke.info>
To:     git@vger.kernel.org
Cc:     Matheus Tavares <matheus.bernardino@usp.br>
Subject: t4129 failure when sticky bit set
Message-ID: <X+xtAR87vWuNiLoE@alpha>
Mail-Followup-To: Kevin Daudt <me@ikke.info>, git@vger.kernel.org,
        Matheus Tavares <matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The new test (do not use core.sharedRepository for working tree files)
in t4129-apply-sammode.sh does not account for sticky bits set:

  --- d_mode.expected     2020-12-30 11:56:11.869555700 +0000
  +++ d_mode.actual       2020-12-30 11:56:11.872889055 +0000
  @@ -1 +1 @@                                                
  -drwx------                                                
  +drwx--S---                                                

This sticky bit (g+s) is set on my home dir and thus inherrited.
