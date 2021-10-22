Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0842DC433EF
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 16:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE61E610A4
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 16:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbhJVQVa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 12:21:30 -0400
Received: from srv1.79p.de ([213.239.234.118]:45692 "EHLO srv1.79p.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232258AbhJVQVa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 12:21:30 -0400
X-Greylist: delayed 348 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Oct 2021 12:21:29 EDT
X-Virus-Scanned: Debian amavisd-new at srv1.79p.de
Received: from [IPv6:2003:ea:270e:d800:50f8:6c55:53f7:f07b] (p200300ea270ed80050f86c5553f7f07b.dip0.t-ipconnect.de [IPv6:2003:ea:270e:d800:50f8:6c55:53f7:f07b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sven@cs-ware.de)
        by srv1.79p.de (Postfix) with ESMTPSA id 53002600695;
        Fri, 22 Oct 2021 18:13:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs-ware.de;
        s=mail2021; t=1634919200;
        bh=2vU9tXwx0sCA7sI2YJW+o5GGQmzR2u4QpjXbOXN0s7g=;
        h=To:From:Subject:Date:From;
        b=cHGS+GY7NJdg9uJVGnqZ4JvcDr2JGsNWsmKz7CE9FruxJRbwKlabuNO8dm9y+KGw/
         1HDYAvXZJ1E4Y06UQTzo8VxVsl9xzoP13t0d+Tn0na8D7fUMDEOdcMObDq9JZwcLJB
         FOG74fowXxtTvIKK8mCj0y7Pc4LId990xrpuBW2S9TePrFH3AhecdGH2Wsci4IaKuz
         j4JZIQHmpCz9uQKkpHVeS/C38qYrWPaE8M4U6edN0+zPlUpa8hMtExzBB839RuHs9r
         LwoGYnxr13p94oTK0rA+AFLtEnrDZGq5ilZ1QuVycrC4hMmuOsv3a+9yJqgYM0hP9I
         5cuP4BytKahtA==
To:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
From:   Sven Strickroth <email@cs-ware.de>
Subject: tortoiseplink ssh variant still needed?
Message-ID: <dad761bf-3121-8934-fad6-78610bc21121@cs-ware.de>
Date:   Fri, 22 Oct 2021 18:13:20 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Git differentiates between different variants of SSH tools.

One variant is the tortoiseplink variant. When this is configured Git 
passes passes a special "--batch" parameter and passes the port using 
"-P" (capitalized P) t the SSH tool.

IIRC tortoiseplink was initially created by TortoiseCVS which is 
nowadays not maintained any more 
(<http://www.tortoisecvs.org/download.shtml>).
In TortoiseSVN and TortoiseGit tortoiseplink was modified six years ago 
(around 2015-03-07) to ignore the "--batch" parameter and also accept 
"-p" additionally to "-P"  (cf. 
<https://osdn.net/projects/tortoisesvn/scm/svn/commits/26348>).

Therefore, my first question: Does Git still want to support very old 
versions of tortoiseplink or should I provide a patch which drops 
support for it?

Second question:
TortoiseGit comes with an even more improved version of TortoisePLink 
(named TortoiseGitPLink, but also ships the same binary as 
tortoiseplink) that also accepts "-o SetEnv=..." parameters in order to 
support the Git protocol version 2. At the moment TortoiseGit 
automatically sets the environment variable "GIT_SSH_VARIANT=ssh". This 
works, but is not perfect if other parameter of OpenSSH are used. Would 
it make sense to add a new ssh variant tortoisegitplink? If yes, how to 
handle new versions that might also support even more OpenSSH command 
line parameters?

-- 
Best regards,
  Sven Strickroth
  PGP key id F5A9D4C4 @ any key-server
