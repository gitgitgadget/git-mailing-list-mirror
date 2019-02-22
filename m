Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9318420248
	for <e@80x24.org>; Fri, 22 Feb 2019 16:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbfBVQFy (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 11:05:54 -0500
Received: from a7-18.smtp-out.eu-west-1.amazonses.com ([54.240.7.18]:44894
        "EHLO a7-18.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727217AbfBVQFr (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 22 Feb 2019 11:05:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1550851545;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=y9fKBjvpbTdm6yLSk1QFTCzSHLPx5dKTrSJo+g+nZZ8=;
        b=fUZoIaEBos7iucMbWgqruoBzTZWHg+48efzUU5NJqzu+WwAwoT+u95WdHqJK13h2
        sCAdecObg5taEIia/00CFKHKZiIMGh+76xHPBxe8cOr4Dk3tDULm3oe0LfUMvBGw7Ai
        FmCink+FlfVhBxGz7Php6Lue1L9vB8soZOBP/4jo=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016915f49a88-27e5f4a8-225c-4d1b-8baf-9027c654169a-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016915f499b8-5813fc52-230b-469e-b939-a1244e83a2b9-000000@eu-west-1.amazonses.com>
References: <0102016915f499b8-5813fc52-230b-469e-b939-a1244e83a2b9-000000@eu-west-1.amazonses.com>
Subject: [PATCH RFC 20/20] cat-file: update docs
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Fri, 22 Feb 2019 16:05:45 +0000
X-SES-Outgoing: 2019.02.22-54.240.7.18
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Update the docs for cat-file command. Some new formatting atoms added
because of reusing ref-filter code.

Actually, %(rest) is supported for all ref-filter commands, but it
has the meaning only for cat-file, that's why I decided to leave it here.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
---
 Documentation/git-cat-file.txt | 38 ++--------------------------------
 1 file changed, 2 insertions(+), 36 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index 8eca671b8278c..b32fcde802ca1 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -195,28 +195,8 @@ the whole line is considered as an object, as if it were fed to
 linkgit:git-rev-parse[1].
 
 You can specify the information shown for each object by using a custom
-`<format>`. The `<format>` is copied literally to stdout for each
-object, with placeholders of the form `%(atom)` expanded, followed by a
-newline. The available atoms are:
-
-`objectname`::
-	The 40-hex object name of the object.
-
-`objecttype`::
-	The type of the object (the same as `cat-file -t` reports).
-
-`objectsize`::
-	The size, in bytes, of the object (the same as `cat-file -s`
-	reports).
-
-`objectsize:disk`::
-	The size, in bytes, that the object takes up on disk. See the
-	note about on-disk sizes in the `CAVEATS` section below.
-
-`deltabase`::
-	If the object is stored as a delta on-disk, this expands to the
-	40-hex sha1 of the delta base object. Otherwise, expands to the
-	null sha1 (40 zeroes). See `CAVEATS` below.
+`<format>`. The format is the same as that of linkgit:git-for-each-ref[1],
+with one additional option:
 
 `rest`::
 	If this atom is used in the output string, input lines are split
@@ -300,20 +280,6 @@ notdir SP <size> LF
 is printed when, during symlink resolution, a file is used as a
 directory name.
 
-CAVEATS
--------
-
-Note that the sizes of objects on disk are reported accurately, but care
-should be taken in drawing conclusions about which refs or objects are
-responsible for disk usage. The size of a packed non-delta object may be
-much larger than the size of objects which delta against it, but the
-choice of which object is the base and which is the delta is arbitrary
-and is subject to change during a repack.
-
-Note also that multiple copies of an object may be present in the object
-database; in this case, it is undefined which copy's size or delta base
-will be reported.
-
 GIT
 ---
 Part of the linkgit:git[1] suite

--
https://github.com/git/git/pull/568
