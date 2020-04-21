Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F6AC2BA19
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 04:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9FC02084D
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 04:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgDUEup (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Apr 2020 00:50:45 -0400
Received: from mailgw-01.dd24.net ([193.46.215.41]:57910 "EHLO
        mailgw-01.dd24.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgDUEup (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Apr 2020 00:50:45 -0400
X-Greylist: delayed 306 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Apr 2020 00:50:44 EDT
Received: from mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-01.live.igb.homer.key-systems.net [192.168.1.26])
        by mailgw-01.dd24.net (Postfix) with ESMTP id AC7935FF9F
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 04:45:37 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at
        mailpolicy-01.live.igb.homer.key-systems.net
Received: from smtp.dd24.net ([192.168.1.35])
        by mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-01.live.igb.homer.key-systems.net [192.168.1.25]) (amavisd-new, port 10235)
        with ESMTP id dGw226gCFRiu for <git@vger.kernel.org>;
        Tue, 21 Apr 2020 04:45:35 +0000 (UTC)
Received: from heisenberg.fritz.box (ppp-88-217-42-14.dynamic.mnet-online.de [88.217.42.14])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.dd24.net (Postfix) with ESMTPSA
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 04:45:35 +0000 (UTC)
Message-ID: <acb9a2da98bce7ea3044cbf37c92163497f7e9e2.camel@scientia.net>
Subject: how to (integrity) verify a whole git repo
From:   Christoph Anton Mitterer <calestyo@scientia.net>
To:     git@vger.kernel.org
Date:   Tue, 21 Apr 2020 06:45:35 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi.

It seems I couldn't really find any definitive answer one the
following:

How to cryptographically verify the integrity of a whole git repo (i.e.
all it's commits/blobs/etc. in the history?

Assume e.g. I have the kernel sources and want to do some bisection.
One has also retrieved Linus' and GregKH's key via some trusted path
and assumes that SHA1 is more or less still safe enough ;-)


1) Of course there is git verify-tag and verify-commit which are signed
with the GPPG, but these alone check, AFAIU, only the respective
tag/commit.

How to check everything else? Is it enough to git fsck --full?

Everything earlier in the history of a verified tag/commit should be
cryptographically safe (assuming SHA1 would be still secure enough),
right?


2) But this of course won't show me anything which is in the repo but
not earlier in the history of the tag/commit I've checked, right?!
Is there a way to e.g. have everything dropped which is not verifiable
via some signed commit/tag?


3) I'd assume that normal operations like checkout/bisect/etc. notice
if some SHA1 sum doesn't match. So once I've verified say kernel v.5.6
tag, I could checkout everything in the history of that and be sure it
wasn't modified, right?
But of course this wouldn't include e.g. other stable versions, like
v5.5.13.


Thanks,
Chris.

