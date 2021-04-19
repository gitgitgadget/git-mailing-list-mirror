Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6FEC433ED
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 23:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 133156113C
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 23:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbhDSXFK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 19:05:10 -0400
Received: from mav.lukeshu.com ([104.207.138.63]:57000 "EHLO mav.lukeshu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230295AbhDSXFI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 19:05:08 -0400
X-Greylist: delayed 589 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Apr 2021 19:05:08 EDT
Received: from lukeshu-dw-thinkpad (unknown [8.42.69.49])
        by mav.lukeshu.com (Postfix) with ESMTPSA id 1E69980590;
        Mon, 19 Apr 2021 18:54:46 -0400 (EDT)
From:   Luke Shumaker <lukeshu@lukeshu.com>
To:     git@vger.kernel.org
Cc:     Luke Shumaker <lukeshu@datawire.io>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 0/3] fast-export, fast-import: implement signed-commits
Date:   Mon, 19 Apr 2021 16:54:38 -0600
Message-Id: <20210419225441.3139048-1-lukeshu@lukeshu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Luke Shumaker <lukeshu@datawire.io>

fast-export has an existing --signed-tags= flag that controls how to
handle tag signatures.  However, there is no equivalent for commit
signatures; it just silently strips the signature out of the commit
(analogously to --signed-tags=strip).

So implement a --signed-commits= flag in fast-export, and implement
the receiving side of it in fast-import.

Luke Shumaker (3):
  git-fast-import.txt: add missing LF in the BNF
  fast-export: rename --signed-tags='warn' to 'warn-verbatim'
  fast-export, fast-import: implement signed-commits

 Documentation/git-fast-export.txt | 18 +++++--
 Documentation/git-fast-import.txt |  9 +++-
 builtin/fast-export.c             | 88 +++++++++++++++++++++++++------
 builtin/fast-import.c             | 15 ++++++
 t/t9350-fast-export.sh            | 82 ++++++++++++++++++++++++++++
 5 files changed, 191 insertions(+), 21 deletions(-)

-- 
2.31.1

Happy hacking,
~ Luke Shumaker
