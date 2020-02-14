Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D5EC35242
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 23:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B66A217F4
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 23:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="0IZs/J+T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbgBNXII (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 18:08:08 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:32944 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725955AbgBNXIH (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 14 Feb 2020 18:08:07 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3F4026048E;
        Fri, 14 Feb 2020 23:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1581721686;
        bh=jyc8eerCbUVed8G3QZkNgiSVtkYIfuj6ajM74gafz9M=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=0IZs/J+TEh74PKMVBK77RaE2kxYvkaVHDNr252YZV3WAoEQff+WECmRmqEmzoA/c6
         l2D+V2tve5OIMZXShFkfgUlKgd0MZ3Zgue19Hy8mk+8us5v8SxelI5Smpys+CidAE6
         pQziBDT/ujsXlT9tbqLyjxl4gLf686XEX8DK2H7wBlf0HaS2EHpIrYoIdGKZzFye75
         wqSLye00UFMDbTTedDJf3FjOgpbK5EJ8Y65AocZGV+j+ojjc50o/NxMYH6JRhcUweh
         XawVFo+w0fCAC6eLaUInYwc+mIOQQLTGsCVWqTsfeKcS8bliMlMUsw2LxcdBXSd1UK
         s4h8f9e7s2XFNhbRf0Tf0dPq8a1NXbBODFsarWODa/Jjvmfk8OtPYBPGKnsPQOg6q1
         vLvPoqxtn7FgyLjTJgT7vgdU514MHgRtxD/kRbQD+8Mo0YCpTQyDdMQoFWa5bNY4aJ
         Qcq5WORClHpi9T1/3rktYAJABQihNvriwjb3DqSgby5V7MPcm5c
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH 0/3] Wildcard matching for credentials
Date:   Fri, 14 Feb 2020 22:59:26 +0000
Message-Id: <20200214225929.541306-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series introduces wildcard matching (that is, urlmatch support) for
credential config options, just like for the http options.  This is
helpful in corporate environments where custom credentials should be
used across a wide variety of subdomains.

In addition, there's an additional test for urlmatch behavior with
multiple subdomains and a mailmap update for the email address used in
this series.

brian m. carlson (3):
  mailmap: add an additional email address for brian m. carlson
  t1300: add test for urlmatch with multiple wildcards
  credential: allow wildcard patterns when matching config

 .mailmap                         |  1 +
 Documentation/gitcredentials.txt |  4 +++-
 credential.c                     | 41 +++++++++++++++++---------------
 t/t0300-credentials.sh           | 20 ++++++++++++++++
 t/t1300-config.sh                |  6 +++++
 5 files changed, 52 insertions(+), 20 deletions(-)

