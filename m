Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A4AC35254
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 14:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D0DF21741
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 14:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbgBEONe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 09:13:34 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43539 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbgBEONe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 09:13:34 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <rhi@pengutronix.de>)
        id 1izLQr-0006h0-25
        for git@vger.kernel.org; Wed, 05 Feb 2020 15:13:33 +0100
Received: from rhi by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <rhi@pengutronix.de>)
        id 1izLQq-0001XX-PJ
        for git@vger.kernel.org; Wed, 05 Feb 2020 15:13:32 +0100
Date:   Wed, 5 Feb 2020 15:13:32 +0100
From:   Roland Hieber <rhi@pengutronix.de>
To:     git@vger.kernel.org
Subject: git-describe --tags warning: 'X' is really 'Y' here
Message-ID: <20200205141332.lov2f2fvinehcd3a@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 15:02:48 up 212 days, 20:12, 103 users,  load average: 1.07, 0.76,
 0.47
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: rhi@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I'm working with the GCC Git repo [0] (which was apparently recently
converted from SVN [1]), and I'm trying to find out the most recent tag.
So on the master branch I do:

    gcc (master) $ git describe --tags --abbrev=0 
    warning: tag 'gcc_9_2_0_release' is really 'releases/gcc-9.2.0' here
    gcc_9_2_0_release

It took me a while to find out what the warning means, because
'gcc_9_2_0_release' is not in $(git tag -l), and it cannot be used as a
ref either:

    gcc (master) $ git show gcc_9_2_0_release
    fatal: ambiguous argument 'gcc_9_2_0_release': unknown revision or path not in the working tree.
    Use '--' to separate paths from revisions, like this:
    'git <command> [<revision>...] -- [<file>...]'

That name is in the tag itself:

    gcc (master) $ git show releases/gcc-9.2.0 | head -n3
    tag gcc_9_2_0_release
    Tagger: Jakub Jelinek <jakub@gcc.gnu.org>
    Date:   2019-08-12 09:38:59

So my question is: is it the intended behaviour of 'git-describe --tags'
that it outputs tag names that cannot be used as a ref? If so, what is a
good other way to find out the most recent tag?

[0]: git://gcc.gnu.org/git/gcc.git,
     https://gcc.gnu.org/git/gitweb.cgi?p=gcc.git
[1]: https://gcc.gnu.org/git/gitweb.cgi?p=gcc.git;a=tag;h=f5b196de86fde51578354ff5f98be6d9c397c8fe

Thanks,
-- 
Roland Hieber, Pengutronix e.K.          | r.hieber@pengutronix.de     |
Steuerwalder Str. 21                     | https://www.pengutronix.de/ |
31137 Hildesheim, Germany                | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686         | Fax:   +49-5121-206917-5555 |
