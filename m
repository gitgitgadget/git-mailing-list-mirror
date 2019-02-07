Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 985E51F453
	for <e@80x24.org>; Thu,  7 Feb 2019 21:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfBGV7h (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 16:59:37 -0500
Received: from ikke.info ([178.21.113.177]:32800 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726873AbfBGV7h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 16:59:37 -0500
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id E06D34400C1; Thu,  7 Feb 2019 22:59:35 +0100 (CET)
Date:   Thu, 7 Feb 2019 22:59:35 +0100
From:   Kevin Daudt <me@ikke.info>
To:     git@vger.kernel.org
Cc:     larsxschneider@gmail.com
Subject: t0028-working-tree-encoding.sh failing on musl based systems (Alpine
 Linux)
Message-ID: <20190207215935.GA31515@alpha>
Reply-To: git@lists.ikke.info
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm trying to get the git test suite passing on Alpine Linux, which is
based on musl libc.

All tests in t0028-working-tree-encoding.sh are currently failing,
because musl iconv does not support statefull output of UTF-16/32 (eg,
it does not output a BOM), while git is expecting that to be present:

> hint: The file 'test.utf16' is missing a byte order mark (BOM). Please
> use UTF-16BE or UTF-16LE (depending on the byte order) as
> working-tree-encoding.
> fatal: BOM is required in 'test.utf16' if encoded as utf-16

Because adding the file to get fails, all the other tests fail as well
as they expect the file to be present in the repository.

Any idea how to get around this?

Kevin
