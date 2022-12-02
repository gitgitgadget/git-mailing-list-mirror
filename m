Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1410CC4321E
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 14:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbiLBOU1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 09:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233643AbiLBOUX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 09:20:23 -0500
X-Greylist: delayed 504 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 02 Dec 2022 06:20:19 PST
Received: from cventin.lip.ens-lyon.fr (cventin.lip.ens-lyon.fr [140.77.13.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD315DC4C3
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 06:20:19 -0800 (PST)
Received: from vlefevre by cventin.lip.ens-lyon.fr with local (Exim 4.96)
        (envelope-from <vincent@vinc17.net>)
        id 1p16ld-0001cz-2C;
        Fri, 02 Dec 2022 15:11:53 +0100
Date:   Fri, 2 Dec 2022 15:11:53 +0100
From:   Vincent Lefevre <vincent@vinc17.net>
To:     git@vger.kernel.org
Subject: git cherry-pick -x: missing blank line before the "cherry picked
 from commit" line
Message-ID: <20221202141153.GA5599@cventin.lip.ens-lyon.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer-Info: https://www.vinc17.net/mutt/
User-Agent: Mutt/2.2.9+50 (c79959e1) vl-149028 (2022-11-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With git 2.38.1 under Debian, when I use "git cherry-pick -x"
on a commit such that the last line of the log message starts
with "note:" (case insensitively), the blank line before the
"cherry picked from commit" line is missing.

For instance:

    New commit
    
    foo
    
    nOtE:
    (cherry picked from commit 3ba643e2eec4bdc1cd46b478ab36ee0707d241c2)

and

    New commit
    
    Note: foo.
    (cherry picked from commit d0e85cdd32e30f78eeb968f275fc3a98899d791e)

but the following ones are OK:

    New commit
    
    note:
    foo
    
    (cherry picked from commit a0ffae22fd3c94210170a3addcf802804f6ee5f7)

----

    New commit
    
    A Note:
    
    (cherry picked from commit 0a89e0e7f8be3063803b0ad4381cd848ec52dd39)

----

    New commit
    
    Note
    
    (cherry picked from commit f217bd5069c9d66a8ca54c869919ff484a18d20c)

----

I also had reported the bug in the Debian BTS:

  https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1025155

-- 
Vincent Lefèvre <vincent@vinc17.net> - Web: <https://www.vinc17.net/>
100% accessible validated (X)HTML - Blog: <https://www.vinc17.net/blog/>
Work: CR INRIA - computer arithmetic / AriC project (LIP, ENS-Lyon)
