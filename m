Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E91121F516
	for <e@80x24.org>; Tue, 26 Jun 2018 21:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752213AbeFZVu6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 17:50:58 -0400
Received: from smtprelay02.ispgateway.de ([80.67.18.14]:6698 "EHLO
        smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751885AbeFZVu6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 17:50:58 -0400
Received: from [91.113.179.170] (helo=[192.168.92.26])
        by smtprelay02.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <marc.strapetz@syntevo.com>)
        id 1fXvrQ-000081-W5; Tue, 26 Jun 2018 23:50:53 +0200
From:   Marc Strapetz <marc.strapetz@syntevo.com>
Subject: [PATCH v3] Documentation: declare "core.ignorecase" as internal
 variable
To:     git@vger.kernel.org
References: <7f6b2a42-334d-9443-7b89-625069931ca7@syntevo.com>
Cc:     sunshine@sunshineco.com, gitster@pobox.com, bturner@atlassian.com
Message-ID: <c899089d-c195-26b5-66ce-de0273a7152b@syntevo.com>
Date:   Tue, 26 Jun 2018 23:50:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <7f6b2a42-334d-9443-7b89-625069931ca7@syntevo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Df-Sender: bWFyYy5zdHJhcGV0ekBzeW50ZXZvLmNvbQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The current description of "core.ignoreCase" reads like an option which
is intended to be changed by the user while it's actually expected to
be set by Git on initialization only. Subsequently, Git relies on the
proper configuration of this variable, as noted by Bryan Turner [1]:

     Git on a case-insensitive filesystem (APFS, HFS+, FAT32, exFAT,
     vFAT, NTFS, etc.) is not designed to be run with anything other
     than core.ignoreCase=true.

[1] https://marc.info/?l=git&m=152998665813997&w=2
     mid:CAGyf7-GeE8jRGPkME9rHKPtHEQ6P1+ebpMMWAtMh01uO3bfy8w@mail.gmail.com

Signed-off-by: Marc Strapetz <marc.strapetz@syntevo.com>
---
  Documentation/config.txt | 9 ++++++---
  1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1cc18a828..c70cfe956 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -390,16 +390,19 @@ core.hideDotFiles::
  	default mode is 'dotGitOnly'.

  core.ignoreCase::
-	If true, this option enables various workarounds to enable
+	Internal variable which enables various workarounds to enable
  	Git to work better on filesystems that are not case sensitive,
-	like FAT. For example, if a directory listing finds
-	"makefile" when Git expects "Makefile", Git will assume
+	like APFS, HFS+, FAT, NTFS, etc. For example, if a directory listing
+	finds "makefile" when Git expects "Makefile", Git will assume
  	it is really the same file, and continue to remember it as
  	"Makefile".
  +
  The default is false, except linkgit:git-clone[1] or linkgit:git-init[1]
  will probe and set core.ignoreCase true if appropriate when the repository
  is created.
++
+Git relies on the proper configuration of this variable for your operating
+and file system. Modifying this value may result in unexpected behavior.

  core.precomposeUnicode::
  	This option is only used by Mac OS implementation of Git.
-- 
2.17.0.rc0.3.gb1b5a51b2

