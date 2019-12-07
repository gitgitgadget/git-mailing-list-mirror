Return-Path: <SRS0=g+dp=Z5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56F6C2D0C2
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 17:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77ADD24673
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 17:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGdhyFV7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfLGRsC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Dec 2019 12:48:02 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:47080 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbfLGRr7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Dec 2019 12:47:59 -0500
Received: by mail-wr1-f65.google.com with SMTP id z7so11228543wrl.13
        for <git@vger.kernel.org>; Sat, 07 Dec 2019 09:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vzEn/mclDF9DnpF7GdPS8pUStnMHWy4LO0bG9HORHwM=;
        b=EGdhyFV7r758cFgoXisL2T6o5jLMGaaPThkAtSGGZ/niebmJ660XuE/9r/Eh1M4zYu
         de5HBwO7uRE9anf8L212ly6xjUsMfTPlGWvSggKkzejYfA3UmrpDV5PhjiVGSaPJyif7
         e1EsVT/yGf3zTl0/3sY6tF9IHtTvG/cEZJdgHWrz+1Z2ldiT9RGDvd/yo9Y2LENvyL9I
         lqDIH7/Hmc3NydYrlswjuE4nzWCtU32RSS0yCJiKCKqHMgxO3w+GiEsRtvAIb4HEY42s
         D2yF54bSBq5SnjkX1SLAWCA7PLqzfrfaY77J+5cwxV4y9uRVXgd3REhA3R3pMAAxf+PM
         5m0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vzEn/mclDF9DnpF7GdPS8pUStnMHWy4LO0bG9HORHwM=;
        b=jfH7Mck34GqKgnWvZla/RAaCeRT9W4irunIlVMHNEuq2anBAJ2OviMAPVkqH+TWULX
         GOUJSCDaNYAsxMlCByJAIfEMRIEw68WDT44quWqSbdwNvjTwWlqfR9RPog07MNzATU3M
         GDxxqvUlIWZABf/WpQlHKgwerLcHErfvsx8JPPZcEklSocVIMKLvjifZfsntUdy8EyKg
         XrfAcbnKP6J9IhPbEneqqlytHEBS7sNBaiVMsETRYCrT0ccjp3iCNB+SHS4mWpOfVm9d
         4OgPa8xxY2QxKPEdp4tgcU9kjKm7OcnkSzytR/8cNHPaD/FpA+eBCV0lB7i82wojsvM6
         vlMg==
X-Gm-Message-State: APjAAAU0Fw6kPnJbHYtjwupVCxrrBoMW8M6kpIJ4j4Da25xfE82rt/sd
        kEhyvT+4eG3/Kd7Fo14aTw6hGAfR
X-Google-Smtp-Source: APXvYqwtrX7y/4GbxhH34sXXQSKKKUGkQdCaV4fH0E/WTG2P1+wHknmohlgOWTFkI21E0EP15K3efQ==
X-Received: by 2002:adf:f803:: with SMTP id s3mr21475388wrp.7.1575740875427;
        Sat, 07 Dec 2019 09:47:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d186sm7748019wmf.7.2019.12.07.09.47.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Dec 2019 09:47:55 -0800 (PST)
Message-Id: <25ad3e23a337b53ef6ca52019899838cc7ec43f7.1575740863.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.463.v5.git.1575740863.gitgitgadget@gmail.com>
References: <pull.463.v4.git.1575498577.gitgitgadget@gmail.com>
        <pull.463.v5.git.1575740863.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 07 Dec 2019 17:47:42 +0000
Subject: [PATCH v5 14/15] git-p4: added --encoding parameter to p4 clone
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

The test t9822 did not have any tests that had encoded a directory name
in ISO8859-1.

Additionally, to make it easier for the user to clone new repositories
with a non-UTF-8 encoded path in P4, add a new parameter to p4clone
"--encoding" that sets the

Add new tests that use ISO8859-1 encoded text in both the directory and
file names.  git-p4.pathEncoding.

Update the View class in the git-p4 code to properly cast text
as_string() except for depot path and filenames.

Update the documentation to include the new command line parameter for
p4clone

Signed-off-by: Ben Keene <seraphire@gmail.com>
---
 Documentation/git-p4.txt        |   5 ++
 git-p4.py                       |  57 +++++++++++++-----
 t/t9822-git-p4-path-encoding.sh | 101 ++++++++++++++++++++++++++++++++
 3 files changed, 147 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index 3494a1db3e..8fb844fc49 100644
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
index 9cf4e94e28..16f29aae41 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1241,7 +1241,7 @@ def getClientSpec():
     entry = specList[0]
 
     # the //client/ name
-    client_name = entry["Client"]
+    client_name = as_string(entry["Client"])
 
     # just the keys that start with "View"
     view_keys = [ k for k in list(entry.keys()) if k.startswith("View") ]
@@ -2625,19 +2625,25 @@ def run(self, args):
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
@@ -2650,28 +2656,28 @@ def append(self, view_line):
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
 
@@ -2682,7 +2688,7 @@ def convert_client_path(self, clientFile):
         # chop off //client/ part to make it relative
         if not clientFile.startswith(self.client_prefix):
             die("No prefix '%s' on clientFile '%s'" %
-                (self.client_prefix, clientFile))
+                (as_string(self.client_prefix)), path_as_string(clientFile))
         return clientFile[len(self.client_prefix):]
 
     def update_client_spec_path_cache(self, files):
@@ -2696,7 +2702,7 @@ def update_client_spec_path_cache(self, files):
 
         where_result = p4CmdList(["-x", "-", "where"], stdin=fileArgs, encode_cmd_output=False)
         for res in where_result:
-            if "code" in res and res["code"] == "error":
+            if "code" in res and res["code"] == b"error":
                 # assume error is "... file(s) not in client view"
                 continue
             if "clientFile" not in res:
@@ -4113,10 +4119,14 @@ def __init__(self):
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
@@ -4140,6 +4150,14 @@ def run(self, args):
 
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
@@ -4167,6 +4185,13 @@ def run(self, args):
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
index 572d395498..8d3fe6c5d1 100755
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

