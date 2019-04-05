Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_HK_NAME_DR shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBDAB20248
	for <e@80x24.org>; Fri,  5 Apr 2019 20:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbfDEUmg (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 16:42:36 -0400
Received: from vwp8955.webpack.hosteurope.de ([176.28.35.119]:34024 "EHLO
        vwp8955.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725967AbfDEUmf (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 5 Apr 2019 16:42:35 -0400
X-Greylist: delayed 2465 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Apr 2019 16:42:34 EDT
Received: from 200116b8467a7600a4015c77c532f9e1.dip.versatel-1u1.de ([2001:16b8:467a:7600:a401:5c77:c532:f9e1] helo=adam-MS-7A63.fritz.box); authenticated
        by vwp8955.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1hCV1j-0001V8-Lu; Fri, 05 Apr 2019 22:01:27 +0200
From:   "Dr. Adam Nielsen" <admin@in-ici.net>
To:     git@vger.kernel.org
Cc:     Adam Nielsen <admin@in-ici.net>,
        "Adam J . N . Nielsen" <info@drnielsen.de>
Subject: [PATCH/docs] make slash-rules more readable
Date:   Fri,  5 Apr 2019 22:00:45 +0200
Message-Id: <20190405200045.10063-1-admin@in-ici.net>
X-Mailer: git-send-email 2.17.1
X-bounce-key: webpack.hosteurope.de;admin@in-ici.net;1554496954;ea1a8c65;
X-HE-SMSGID: 1hCV1j-0001V8-Lu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Adam Nielsen <admin@in-ici.net>

gitignore.txt: make slash-rules more readable

Remove the addition `it is removed for the purpose of the following description` and 
make clear in which situations a trailing slash is used or not. Increase readability
and make all paragraphs valid, even if they are not read in strict order.
Replace `otherwise` with the the concrete pattern that is considered in the paragraph to avoid
confusion. 
Add simple examples to point out the significant difference between using or not using a trailing slash.

Signed-off-by: Adam J. N. Nielsen <info@drnielsen.de>

---
 Documentation/gitignore.txt | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index 1c94f08ff4..c6720b0ac4 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -89,22 +89,25 @@ PATTERN FORMAT
    Put a backslash ("`\`") in front of the first "`!`" for patterns
    that begin with a literal "`!`", for example, "`\!important!.txt`".
 
- - If the pattern ends with a slash, it is removed for the
-   purpose of the following description, but it would only find
+ - If the pattern ends with a slash "`/`", it would only find
    a match with a directory.  In other words, `foo/` will match a
    directory `foo` and paths underneath it, but will not match a
    regular file or a symbolic link `foo` (this is consistent
    with the way how pathspec works in general in Git).
 
- - If the pattern does not contain a slash '/', Git treats it as
-   a shell glob pattern and checks for a match against the
-   pathname relative to the location of the `.gitignore` file
-   (relative to the toplevel of the work tree if not from a
-   `.gitignore` file).
+ - If the pattern contains no slash "`/`" other then a trailing slash,
+   then the pattern will match in all directories. In other words,
+   `foo/` will match `/bar/foo/` and `foo` will match `/bar/bar/foo`.
 
- - Otherwise, Git treats the pattern as a shell glob: "`*`" matches
-   anything except "`/`", "`?`" matches any one character except "`/`"
-   and "`[]`" matches one character in a selected range. See
+ - If the pattern contains a slash "`/`" other then a trailing slash, then
+   the pattern is always considered from the `.gitignore` file location.
+   In other words, `foo/bar` will match `/foo/bar` but not `/bar/foo/bar`.
+
+ - The character "`*`" matches anything except a non trailing slash "`/`".
+   For example, "foo/*" matches "foo/test.json" and "foo/bar/"
+   but not "foo/bar/test.json".
+   The character "`?`" matches any one character except "`/`".
+   The character "`[]`" matches one character in a selected range. See
    fnmatch(3) and the FNM_PATHNAME flag for a more detailed
    description.
 
-- 
2.17.1

