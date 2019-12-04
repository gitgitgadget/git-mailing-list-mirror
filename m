Return-Path: <SRS0=IU/p=Z2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BTC_ID,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE5DC2D0C0
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 22:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDD7920661
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 22:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNmxSfrI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbfLDW35 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Dec 2019 17:29:57 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37016 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728421AbfLDW3v (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Dec 2019 17:29:51 -0500
Received: by mail-wr1-f68.google.com with SMTP id w15so1132945wru.4
        for <git@vger.kernel.org>; Wed, 04 Dec 2019 14:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LG7UrrQD+Cb9wX5rcQaDY8ql7td6YtytjUpvKfIFZj4=;
        b=kNmxSfrIzMqLzv6hfmRsGa+SMb5Ng91pSQysQ6yggVgk0o4mFPUvkDQHjJiGNz9Lwv
         qqJtzMJ/4CrvrJ86FKplAyVxkc7JVNqfvJFurA0WnCvQcsBLK3hsqn3341dFhkf9k/ug
         GW/OcN4NcEgwnryZ7LeLWtTRonnPjwlLu+eRmxbNVnJsd0pxqPEWZEaGWQbkhjm8dmMr
         DqwbRT0wr11IWzvbJ2uqT8bXiWeTlo2jWaDumSfDriDrhxqojofKK1pmXk2kwABoZCi2
         3Wjw2Av+WzfaUqVM7iIlMjNqbEtorVSc8H2tPFC1MvpQ89sCna7DISuM35j2cSFhoGXJ
         4VZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LG7UrrQD+Cb9wX5rcQaDY8ql7td6YtytjUpvKfIFZj4=;
        b=DjiK5bFh7ZgjzUx0CmYnDw5z375dDavLVBKb/QPYjj8gUl+JfKaqdDems4mXOqlNkQ
         WZIbdRweh0MdREN9l0eLMVT+cnKoxnOfHouqevhCgamXNDycj7NRjlhJwzD9+sejjx/U
         jXfe1+YiX6nOuKYLSm2fDiqdophdUq2EP074Ga1FhNNWkZZ93H74+ktl0PETsydSZw0x
         ivpokkNkQKpbspx0m4KqQr6wfPFh2FwiD1uqGUi8ZB4Ez7jgMf8WYGqZTj7TRvDolopR
         Yt/z0yP2aIU2plCcQD+1+EMdelVOrt32CBFVRmBHnjPAPWOf6izTHscfZiV3nDZk7d0d
         XOLA==
X-Gm-Message-State: APjAAAXN8dyakfYZiCnEE/sNA5FaYuxWrAdYFbPmCWp3NYDwM+Jx1f3Y
        aTFEZiVlHzT5oyadyoKqnMNz6Ttr
X-Google-Smtp-Source: APXvYqzTDbA0PUtNT7NX6v+SqbfAN8V8V48n/4VkIVPplbBEabkEelqj8mfJXW7mXyZbhqwJ6FORTQ==
X-Received: by 2002:a5d:49c7:: with SMTP id t7mr6415637wrs.369.1575498588365;
        Wed, 04 Dec 2019 14:29:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h2sm9881290wrv.66.2019.12.04.14.29.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Dec 2019 14:29:47 -0800 (PST)
Message-Id: <883ef45ca5476c6ff412bf4f95b0e7b50c58338b.1575498578.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.463.v4.git.1575498577.gitgitgadget@gmail.com>
References: <pull.463.v3.git.1575313336.gitgitgadget@gmail.com>
        <pull.463.v4.git.1575498577.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 04 Dec 2019 22:29:37 +0000
Subject: [PATCH v4 11/11] git-p4: Added --encoding parameter to p4 clone
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ben Keene <seraphire@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Keene <seraphire@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Keene <seraphire@gmail.com>

The test t9822 did not have any tests that had encoded a directory name in ISO8859-1.

Additionally, to make it easier for the user to clone new repositories with a non-UTF-8 encoded path in P4, add a new parameter to p4clone "--encoding" that sets the

Add new tests that use ISO8859-1 encoded text in both the directory and file names.  git-p4.pathEncoding.

Update the View class in the git-p4 code to properly cast text as_string() except for depot path and filenames.

Update the documentation to include the new command line parameter for p4clone

Signed-off-by: Ben Keene <seraphire@gmail.com>
(cherry picked from commit e26f6309d60c6c1615320d4a9071935e23efe6fb)
---
 Documentation/git-p4.txt        |   5 ++
 git-p4.py                       |  61 +++++++++++++------
 t/t9822-git-p4-path-encoding.sh | 101 ++++++++++++++++++++++++++++++++
 3 files changed, 149 insertions(+), 18 deletions(-)

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index 3494a1db3e..f54af3c917 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -305,6 +305,11 @@ options described above.
 --bare::
 	Perform a bare clone.  See linkgit:git-clone[1].
 
+--encoding <encoding>::
+    Optionally sets the git-p4.pathEncoding configuration value in 
+	the newly created Git repository before files are synchronized 
+	from P4. See git-p4.pathEncoding for more information.
+
 Submit options
 ~~~~~~~~~~~~~~
 These options can be used to modify 'git p4 submit' behavior.
diff --git a/git-p4.py b/git-p4.py
index 05db2ec657..1f2e43430a 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1228,7 +1228,7 @@ def getClientSpec():
     """Look at the p4 client spec, create a View() object that contains
        all the mappings, and return it."""
 
-    specList = p4CmdList("client -o")
+    specList = p4CmdList("client -o", encode_data=False)
     if len(specList) != 1:
         die('Output from "client -o" is %d lines, expecting 1' %
             len(specList))
@@ -1237,7 +1237,7 @@ def getClientSpec():
     entry = specList[0]
 
     # the //client/ name
-    client_name = entry["Client"]
+    client_name = as_string(entry["Client"])
 
     # just the keys that start with "View"
     view_keys = [ k for k in list(entry.keys()) if k.startswith("View") ]
@@ -2637,19 +2637,25 @@ def run(self, args):
         return True
 
 class View(object):
-    """Represent a p4 view ("p4 help views"), and map files in a
-       repo according to the view."""
+    """ Represent a p4 view ("p4 help views"), and map files in a
+        repo according to the view.
+    """
 
     def __init__(self, client_name):
         self.mappings = []
-        self.client_prefix = "//%s/" % client_name
+        # the client prefix is saved in bytes as it is used for comparison
+        # against server data.
+        self.client_prefix = as_bytes("//%s/" % client_name)
         # cache results of "p4 where" to lookup client file locations
         self.client_spec_path_cache = {}
 
     def append(self, view_line):
-        """Parse a view line, splitting it into depot and client
-           sides.  Append to self.mappings, preserving order.  This
-           is only needed for tag creation."""
+        """ Parse a view line, splitting it into depot and client
+            sides.  Append to self.mappings, preserving order.  This
+            is only needed for tag creation.
+
+            view_line should be in bytes (depot path encoding)
+        """
 
         # Split the view line into exactly two words.  P4 enforces
         # structure on these lines that simplifies this quite a bit.
@@ -2662,28 +2668,28 @@ def append(self, view_line):
         # The line is already white-space stripped.
         # The two words are separated by a single space.
         #
-        if view_line[0] == '"':
+        if view_line[0] == b'"':
             # First word is double quoted.  Find its end.
-            close_quote_index = view_line.find('"', 1)
+            close_quote_index = view_line.find(b'"', 1)
             if close_quote_index <= 0:
-                die("No first-word closing quote found: %s" % view_line)
+                die("No first-word closing quote found: %s" % path_as_string(view_line))
             depot_side = view_line[1:close_quote_index]
             # skip closing quote and space
             rhs_index = close_quote_index + 1 + 1
         else:
-            space_index = view_line.find(" ")
+            space_index = view_line.find(b" ")
             if space_index <= 0:
-                die("No word-splitting space found: %s" % view_line)
+                die("No word-splitting space found: %s" % path_as_string(view_line))
             depot_side = view_line[0:space_index]
             rhs_index = space_index + 1
 
         # prefix + means overlay on previous mapping
-        if depot_side.startswith("+"):
+        if depot_side.startswith(b"+"):
             depot_side = depot_side[1:]
 
         # prefix - means exclude this path, leave out of mappings
         exclude = False
-        if depot_side.startswith("-"):
+        if depot_side.startswith(b"-"):
             exclude = True
             depot_side = depot_side[1:]
 
@@ -2694,7 +2700,7 @@ def convert_client_path(self, clientFile):
         # chop off //client/ part to make it relative
         if not clientFile.startswith(self.client_prefix):
             die("No prefix '%s' on clientFile '%s'" %
-                (self.client_prefix, clientFile))
+                (as_string(self.client_prefix)), path_as_string(clientFile))
         return clientFile[len(self.client_prefix):]
 
     def update_client_spec_path_cache(self, files):
@@ -2706,9 +2712,9 @@ def update_client_spec_path_cache(self, files):
         if len(fileArgs) == 0:
             return  # All files in cache
 
-        where_result = p4CmdList(["-x", "-", "where"], stdin=fileArgs)
+        where_result = p4CmdList(["-x", "-", "where"], stdin=fileArgs, encode_data=False)
         for res in where_result:
-            if "code" in res and res["code"] == "error":
+            if "code" in res and res["code"] == b"error":
                 # assume error is "... file(s) not in client view"
                 continue
             if "clientFile" not in res:
@@ -4125,10 +4131,14 @@ def __init__(self):
                                  help="where to leave result of the clone"),
             optparse.make_option("--bare", dest="cloneBare",
                                  action="store_true", default=False),
+            optparse.make_option("--encoding", dest="setPathEncoding",
+                                 action="store", default=None,
+                                 help="Sets the path encoding for this depot")
         ]
         self.cloneDestination = None
         self.needsGit = False
         self.cloneBare = False
+        self.setPathEncoding = None
 
     def defaultDestination(self, args):
         """ Returns the last path component as the default git 
@@ -4152,6 +4162,14 @@ def run(self, args):
 
         depotPaths = args
 
+        # If we have an encoding provided, ignore what may already exist
+        # in the registry. This will ensure we show the displayed values
+        # using the correct encoding.
+        if self.setPathEncoding:
+            gitConfigSet("git-p4.pathEncoding", self.setPathEncoding)
+
+        # If more than 1 path element is supplied, the last element
+        # is the clone destination.
         if not self.cloneDestination and len(depotPaths) > 1:
             self.cloneDestination = depotPaths[-1]
             depotPaths = depotPaths[:-1]
@@ -4179,6 +4197,13 @@ def run(self, args):
         if retcode:
             raise CalledProcessError(retcode, init_cmd)
 
+        # Set the encoding if it was provided command line
+        if self.setPathEncoding:
+            init_cmd= ["git", "config", "git-p4.pathEncoding", self.setPathEncoding]
+            retcode = subprocess.call(init_cmd)
+            if retcode:
+                raise CalledProcessError(retcode, init_cmd)
+
         if not P4Sync.run(self, depotPaths):
             return False
 
diff --git a/t/t9822-git-p4-path-encoding.sh b/t/t9822-git-p4-path-encoding.sh
index 572d395498..cf8a15b2e4 100755
--- a/t/t9822-git-p4-path-encoding.sh
+++ b/t/t9822-git-p4-path-encoding.sh
@@ -4,9 +4,20 @@ test_description='Clone repositories with non ASCII paths'
 
 . ./lib-git-p4.sh
 
+# lowercase filename
+# UTF8    - HEX:   a-\xc3\xa4_o-\xc3\xb6_u-\xc3\xbc
+#         - octal: a-\303\244_o-\303\266_u-\303\274
+# ISO8859 - HEX:   a-\xe4_o-\xf6_u-\xfc
 UTF8_ESCAPED="a-\303\244_o-\303\266_u-\303\274.txt"
 ISO8859_ESCAPED="a-\344_o-\366_u-\374.txt"
 
+# lowercase directory
+# UTF8    - HEX:   dir_a-\xc3\xa4_o-\xc3\xb6_u-\xc3\xbc
+# ISO8859 - HEX:   dir_a-\xe4_o-\xf6_u-\xfc
+DIR_UTF8_ESCAPED="dir_a-\303\244_o-\303\266_u-\303\274"
+DIR_ISO8859_ESCAPED="dir_a-\344_o-\366_u-\374"
+
+
 ISO8859="$(printf "$ISO8859_ESCAPED")" &&
 echo content123 >"$ISO8859" &&
 rm "$ISO8859" || {
@@ -58,6 +69,22 @@ test_expect_success 'Clone repo containing iso8859-1 encoded paths with git-p4.p
 	)
 '
 
+test_expect_success 'Clone repo containing iso8859-1 encoded paths with using --encoding parameter' '
+	test_when_finished cleanup_git &&
+	(
+		git p4 clone --encoding iso8859 --destination="$git" //depot &&
+		cd "$git" &&
+		UTF8="$(printf "$UTF8_ESCAPED")" &&
+		echo "$UTF8" >expect &&
+		git -c core.quotepath=false ls-files >actual &&
+		test_cmp expect actual &&
+
+		echo content123 >expect &&
+		cat "$UTF8" >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'Delete iso8859-1 encoded paths and clone' '
 	(
 		cd "$cli" &&
@@ -74,4 +101,78 @@ test_expect_success 'Delete iso8859-1 encoded paths and clone' '
 	)
 '
 
+# These tests will create a directory with ISO8859-1 characters in both the 
+# directory and the path.  Since it is possible to clone a path instead of using
+# the whole client-spec.  Check both versions:  client-spec and with a direct
+# path using --encoding
+test_expect_success 'Create a repo containing iso8859-1 encoded directory and filename' '
+	(
+		DIR_ISO8859="$(printf "$DIR_ISO8859_ESCAPED")" &&
+		ISO8859="$(printf "$ISO8859_ESCAPED")" &&
+		cd "$cli" &&
+		mkdir "$DIR_ISO8859" && 
+		cd "$DIR_ISO8859" &&
+		echo content123 >"$ISO8859" &&
+		p4 add "$ISO8859" &&
+		p4 submit -d "test commit (encoded directory)"
+	)
+'
+
+test_expect_success 'Clone repo containing iso8859-1 encoded depot path and files with git-p4.pathEncoding' '
+	test_when_finished cleanup_git &&
+	(
+		DIR_ISO8859="$(printf "$DIR_ISO8859_ESCAPED")" &&
+		DIR_UTF8="$(printf "$DIR_UTF8_ESCAPED")" &&
+		cd "$git" &&
+		git init . &&
+		git config git-p4.pathEncoding iso8859-1 &&
+		git p4 clone --use-client-spec --destination="$git" "//depot/$DIR_ISO8859" &&
+		cd "$DIR_UTF8" &&
+		UTF8="$(printf "$UTF8_ESCAPED")" &&
+		echo "$UTF8" >expect &&
+		git -c core.quotepath=false ls-files >actual &&
+		test_cmp expect actual &&
+
+		echo content123 >expect &&
+		cat "$UTF8" >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'Clone repo containing iso8859-1 encoded depot path and files with git-p4.pathEncoding, without --use-client-spec' '
+	test_when_finished cleanup_git &&
+	(
+		DIR_ISO8859="$(printf "$DIR_ISO8859_ESCAPED")" &&
+		cd "$git" &&
+		git init . &&
+		git config git-p4.pathEncoding iso8859-1 &&
+		git p4 clone --destination="$git" "//depot/$DIR_ISO8859" &&
+		UTF8="$(printf "$UTF8_ESCAPED")" &&
+		echo "$UTF8" >expect &&
+		git -c core.quotepath=false ls-files >actual &&
+		test_cmp expect actual &&
+
+		echo content123 >expect &&
+		cat "$UTF8" >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'Clone repo containing iso8859-1 encoded depot path and files with using --encoding parameter' '
+	test_when_finished cleanup_git &&
+	(
+		DIR_ISO8859="$(printf "$DIR_ISO8859_ESCAPED")" &&
+		git p4 clone --encoding iso8859 --destination="$git" "//depot/$DIR_ISO8859" &&
+		cd "$git" &&
+		UTF8="$(printf "$UTF8_ESCAPED")" &&
+		echo "$UTF8" >expect &&
+		git -c core.quotepath=false ls-files >actual &&
+		test_cmp expect actual &&
+
+		echo content123 >expect &&
+		cat "$UTF8" >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
gitgitgadget
