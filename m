Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB55C61DA4
	for <git@archiver.kernel.org>; Thu, 16 Feb 2023 12:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjBPMlP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Feb 2023 07:41:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjBPMlO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2023 07:41:14 -0500
X-Greylist: delayed 317 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 16 Feb 2023 04:41:13 PST
Received: from mail.nic.cz (mail.nic.cz [IPv6:2001:1488:800:400::400])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8F710F3
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 04:41:13 -0800 (PST)
Received: from [IPV6:2001:1488:fffe:6:983c:4aff:fe77:287c] (unknown [IPv6:2001:1488:fffe:6:983c:4aff:fe77:287c])
        by mail.nic.cz (Postfix) with ESMTPSA id 687941C137C;
        Thu, 16 Feb 2023 13:35:54 +0100 (CET)
Authentication-Results: mail.nic.cz;
        auth=pass smtp.auth=michal.vasilek@nic.cz smtp.mailfrom=michal.vasilek@nic.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1676550954; bh=cbFpDOSRgooVq9+GnUDOWpO6xiY43CtX0TEbEVRxxeE=;
        h=Date:To:Cc:From:Subject:From:Reply-To:Subject:To:Cc;
        b=SbmCSIrOT20mRtbNdar90L1i5Qo5tPh14qlqWdbhzGdad3SbGlJZM3BALMY9jbDky
         MPAquKQPcg/TBFRJKHVBSsEJeFSL6+u9Bri2mph9zYI0CndMs8jI5qJydvDod6PXYX
         NUb0F897a2f7byEOi3ZsO3sM5O/h1Zmz8DrxydaY=
Message-ID: <80eb3972-4960-5727-ce86-acc3a4425fd4@nic.cz>
Date:   Thu, 16 Feb 2023 13:35:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To:     git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
From:   Michal Vasilek <michal.vasilek@nic.cz>
Subject: [Bug] make gitweb with GITWEB_JS set fails to build
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.7 at mail
X-Virus-Status: Clean
X-Rspamd-Server: mail
X-Rspamd-Queue-Id: 687941C137C
X-Spamd-Bar: /
X-Spamd-Result: default: False [-0.10 / 20.00];
        MIME_GOOD(-0.10)[text/plain];
        ARC_NA(0.00)[];
        FROM_EQ_ENVFROM(0.00)[];
        MIME_TRACE(0.00)[0:+];
        FREEMAIL_ENVRCPT(0.00)[gmail.com];
        WHITELISTED_IP(0.00)[2001:1488:fffe:6:983c:4aff:fe77:287c];
        FROM_HAS_DN(0.00)[];
        ASN(0.00)[asn:25192, ipnet:2001:1488::/32, country:CZ]
X-Rspamd-Pre-Result: action=no action;
        module=multimap;
        Matched map: WHITELISTED_IP
X-Rspamd-Action: no action
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What did you do before the bug happened? (Steps to reproduce your issue)

I ran make gitweb with the GITWEB_JS variable set on git 2.39.2, 
specifically:

     make gitweb GITWEB_JS=/www/gitweb.js


What did you expect to happen? (Expected behavior)

I expected the build to pass and that the GITWEB_JS (or GITWEB_CSS) variable
will only be used for changing the path for gitweb.js in gitweb.cgi like it
used to before 2.38.0 (before 564ebde3d323fc3b22534dcbb32723807771b955)

What happened instead? (Actual behavior)

The build failed with:

         GEN gitweb/gitweb.cgi
     make: *** No rule to make target 'gitweb//www/gitweb.js', needed by 
'gitweb'.  Stop.

What's different between what you expected and what actually happened?

Anything else you want to add:

This is caused by 564ebde3d323fc3b22534dcbb32723807771b955, but I am not 
sure
what exactly is the issue there, so I am only reporting this and leaving the
fix to someone else.


[System Info]
git version:
git version 2.39.2
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
compiler info: gnuc: 12.2
libc info: glibc: 2.36
$SHELL (typically, interactive shell): /bin/bash

