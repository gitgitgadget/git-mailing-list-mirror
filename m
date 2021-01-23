Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DEAR_SOMETHING,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D059C433E0
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 15:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4368A22AAA
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 15:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbhAWPBH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 10:01:07 -0500
Received: from lb2.peda.net ([130.234.6.153]:53241 "EHLO lb2.peda.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbhAWPBD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 10:01:03 -0500
X-Greylist: delayed 419 seconds by postgrey-1.27 at vger.kernel.org; Sat, 23 Jan 2021 10:01:02 EST
Received: from [84.251.221.37] (dsl-jklbng12-54fbdd-37.dhcp.inet.fi [84.251.221.37])
        by lb2.peda.net (Postfix) with ESMTPSA id AD00DD6045C;
        Sat, 23 Jan 2021 16:53:20 +0200 (EET)
To:     git@vger.kernel.org
From:   Mikko Rantalainen <mikko.rantalainen@peda.net>
Subject: gitk and --no-walk
Message-ID: <00b30f2d-44bb-43b9-c852-45a1d9ed4346@peda.net>
Date:   Sat, 23 Jan 2021 16:53:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Sirs,

I asked a question about how to make gitk behave like git log --no-walk
at https://stackoverflow.com/q/65848193/334451 and found out that gitk
implementation currently simply ignores --no-walk.

According to comment near the actual code in gitk says

> proc parseviewargs {n arglist} {
> ...
> ... "--no-walk" ...
>   # These cause our parsing of git log's output to fail, or else
>   # they're options we want to set ourselves, so ignore them.

However, if I remove the "--no-walk" from that list and e.g. try to run
following command line with Linux kernel repo

gitk --no-walk 7a223e06b b5de3c502 f05badde4 6ec4bae1 1b937e8f 444fe991

everything seems to work just fine and I get the expected output.
Without modifying the gitk source code gitk just renders whole git repo
which takes A LOT of time for something as complex as linux kernel.

Note that I intentionally mixed the order of commit ids in the example
above to test that the history is still rendered correctly.

Is there a reason to keep ignoring the --no-walk flag anymore?

(Tested with git version 2.17.1.)

-- 
Best regards,
Mikko
