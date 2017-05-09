Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 221A01FDEA
	for <e@80x24.org>; Tue,  9 May 2017 12:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753807AbdEIMzA convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 9 May 2017 08:55:00 -0400
Received: from aok120.rev.netart.pl ([85.128.245.120]:55197 "EHLO
        aok120.rev.netart.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753210AbdEIMy7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 08:54:59 -0400
X-Greylist: delayed 369 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 May 2017 08:54:59 EDT
X-Virus-Scanned: by amavisd-new using ClamAV (21)
Received: from MacMini (14-rev80.giganet.net.pl [91.245.80.14])
        by mgniazd.nazwa.pl (Postfix) with ESMTP id EDE901C90E6
        for <git@vger.kernel.org>; Tue,  9 May 2017 14:48:47 +0200 (CEST)
Date:   Tue, 9 May 2017 14:48:47 +0200
From:   Sebastian Gniazdowski <psprint@zdharma.org>
To:     git@vger.kernel.org
Message-ID: <etPan.5911baaf.74b0dc51.6b4c@MacMini>
Subject: Would this tool be useful - encoding repository data into
 single URL
X-Mailer: Airmail (231)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello
I wonder about usability of following tool. Quick-start:

    giturl https://github.com/zdharma/giturl -r devel -p lib/coding_functions.cpp

    Protocol: https
    Site:     github.com
    Repo:     zdharma/giturl
    Revision: devel
    File:     lib/coding_functions.cpp

    gitu://ŬṽǚǫoŒẗ6ẏȅcЭÑẩőn4ầŘїệαЃȣϟṈӛŀї

It does Huffman encoding and base-1024 encoding to pack given data into single URL. The Unicode characters selected for base-1024 encoding are letters, not symbols, so double-clicking in e.g. web browser selects the whole code, making it easy to grab a repository data.

Decoding:

    giturl -qd ŬṽǚǫoŒẗ6ẏȅcЭÑẩőn4ầŘїệαЃȣϟṈӛŀї
    https://github.com/zdharma/giturl / rev:devel / file:lib/coding_functions.cpp

I can also encode commits relative to given revision, e.g. bits 10011 are commits 1, 4, 5. Easy to add to the g-code. Selecting 10th commit is only 1 character in base-1024.

However I wonder if this has any uses. Could be patches sent this way? Having refs/patches/<name>, encoding <name> in URL, sending it instead of inlining/attaching a diff, selecting e.g. 3 commits via the bit-mask mentioned. That said, it's more about easy-grab of repository data and storage in well-defined, consistent format, not in language "the branch is ..., commit a7a35cb". Does this make sense?

There are 2 implementations, in Zsh (uses Zshell like e.g. Ruby, not interactively) and C++11 (mostly because of std::regex):

https://github.com/zdharma/giturl
https://github.com/zdharma/cgiturl

--
Sebastian Gniazdowski
psprint /at/ zdharma.org
