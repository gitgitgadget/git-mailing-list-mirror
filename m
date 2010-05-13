From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: [PATCH v4 4/4] Rename the "crlf" attribute "text"
Date: Thu, 13 May 2010 23:44:42 +0200
Message-ID: <51a3a3b5bc8736c40e488e01da2c5ac552c00b57.1273786317.git.eyvind.bernhardsen@gmail.com>
References: <cover.1273786317.git.eyvind.bernhardsen@gmail.com>
Cc: msysGit <msysgit@googlegroups.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Finn Arne Gangstad <finnag@pvv.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 13 23:45:07 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCgDK-0005HK-MX
	for gcvg-git-2@lo.gmane.org; Thu, 13 May 2010 23:45:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758867Ab0EMVo6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 May 2010 17:44:58 -0400
Received: from mail-ew0-f216.google.com ([209.85.219.216]:34169 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758821Ab0EMVox (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 May 2010 17:44:53 -0400
Received: by mail-ew0-f216.google.com with SMTP id 8so702713ewy.28
        for <git@vger.kernel.org>; Thu, 13 May 2010 14:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=LQ0EvU/K1dEdiLnW5nc6uXgnBChEUPjN8CVYhLkGHmM=;
        b=Sdzc+u5itheQBJxgDGdXZo9xFILuEt5UpHvriB4E8/Go5G+Wc1YaF+5LQd5+achpGC
         wYJ/xHZNjzRNMFT1W4SZZBxrL6i5CsmqZT+niqy42sjDOL6JYPeLOracjKyojEyA/6/r
         WRt9bDMBNu8kcUNsVaSe1qeXBwVoXkmm59vTA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=uxLt4BOPsJpxmnqvzzDhFTjgw3dDmG1lnUj3NuAMDTYa1DER7fhaTSXDO4vUtNuRhj
         5QLgtaBL1VmPc8jdKUSrAqY17++2pq4uZN7emZH9ql4PAOKlPmF0flKuYsvkNNbZ3NDQ
         dbSCj7NMjM4PaLw0vqwb+9qY339oQWsCGTPK4=
Received: by 10.213.90.139 with SMTP id i11mr1645908ebm.95.1273787092180;
        Thu, 13 May 2010 14:44:52 -0700 (PDT)
Received: from localhost.localdomain (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id 15sm906408ewy.4.2010.05.13.14.44.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 13 May 2010 14:44:51 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.5.gd739a
In-Reply-To: <cover.1273786317.git.eyvind.bernhardsen@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147030>

As discussed on the list, "crlf" is not an optimal name.  Linus
suggested "text", which is much better.

Signed-off-by: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
---
 Documentation/config.txt        |   16 ++++++----
 Documentation/git-cvsserver.txt |   13 +++-----
 Documentation/gitattributes.txt |   59 +++++++++++++++++++++++----------------
 attr.c                          |    2 +-
 convert.c                       |   23 ++++++++++-----
 git-cvsserver.perl              |   13 ++++++--
 t/t0025-crlf-auto.sh            |   21 +++++++++++--
 7 files changed, 91 insertions(+), 56 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 4d3c472..207351b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -204,7 +204,7 @@ core.autocrlf::
 	reading from the work tree but files are written out to the work
 	tree with `LF` at the end of lines.  A file is considered
 	"text" (i.e. be subjected to the autocrlf mechanism) based on
-	the file's `crlf` attribute, or if `crlf` is unspecified,
+	the file's `text` attribute, or if `text` is unspecified,
 	based on the file's contents.  See linkgit:gitattributes[5].
 
 core.safecrlf::
@@ -975,13 +975,15 @@ gitcvs.logfile::
 	various stuff. See linkgit:git-cvsserver[1].
 
 gitcvs.usecrlfattr::
-	If true, the server will look up the `crlf` attribute for
-	files to determine the '-k' modes to use. If `crlf` is set,
-	the '-k' mode will be left blank, so cvs clients will
-	treat it as text. If `crlf` is explicitly unset, the file
+	If true, the server will look up the end-of-line conversion
+	attributes for files to determine the '-k' modes to use. If
+	the attributes force git to treat a file as text,
+	the '-k' mode will be left blank so cvs clients will
+	treat it as text. If they suppress text conversion, the file
 	will be set with '-kb' mode, which suppresses any newline munging
-	the client might otherwise do. If `crlf` is not specified,
-	then 'gitcvs.allbinary' is used. See linkgit:gitattributes[5].
+	the client might otherwise do. If the attributes do not allow
+	the file type to be determined, then 'gitcvs.allbinary' is
+	used. See linkgit:gitattributes[5].
 
 gitcvs.allbinary::
 	This is used if 'gitcvs.usecrlfattr' does not resolve
diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index dbb053e..0864857 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -340,16 +340,13 @@ By default the server leaves the '-k' mode blank for all files,
 which causes the cvs client to treat them as a text files, subject
 to crlf conversion on some platforms.
 
-You can make the server use `crlf` attributes to set the '-k' modes
-for files by setting the `gitcvs.usecrlfattr` config variable.
-In this case, if `crlf` is explicitly unset ('-crlf'), then the
-server will set '-kb' mode for binary files. If `crlf` is set,
-then the '-k' mode will explicitly be left blank.  See
-also linkgit:gitattributes[5] for more information about the `crlf`
-attribute.
+You can make the server use the end-of-line conversion attributes to
+set the '-k' modes for files by setting the `gitcvs.usecrlfattr`
+config variable.  See linkgit:gitattributes[5] for more information
+about end-of-line conversion.
 
 Alternatively, if `gitcvs.usecrlfattr` config is not enabled
-or if the `crlf` attribute is unspecified for a filename, then
+or the attributes do not allow automatic detection for a filename, then
 the server uses the `gitcvs.allbinary` config for the default setting.
 If `gitcvs.allbinary` is set, then file not otherwise
 specified will default to '-kb' mode. Otherwise the '-k' mode
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index c71d883..25753b7 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -92,7 +92,7 @@ such as 'git checkout' and 'git merge' run.  They also affect how
 git stores the contents you prepare in the working tree in the
 repository upon 'git add' and 'git commit'.
 
-`crlf`
+`text`
 ^^^^^^
 
 This attribute enables and controls end-of-line normalization.  When a
@@ -103,28 +103,28 @@ directory, use the `eol` attribute for a single file and the
 
 Set::
 
-	Setting the `crlf` attribute on a path enables end-of-line
+	Setting the `text` attribute on a path enables end-of-line
 	normalization and marks the path as a text file.  End-of-line
 	conversion takes place without guessing the content type.
 
 Unset::
 
-	Unsetting the `crlf` attribute on a path tells git not to
+	Unsetting the `text` attribute on a path tells git not to
 	attempt any end-of-line conversion upon checkin or checkout.
 
 Set to string value "auto"::
 
-	When `crlf` is set to "auto", the path is marked for automatic
+	When `text` is set to "auto", the path is marked for automatic
 	end-of-line normalization.  If git decides that the content is
 	text, its line endings are normalized to LF on checkin.
 
 Unspecified::
 
-	If the `crlf` attribute is unspecified, git uses the `eol`
+	If the `text` attribute is unspecified, git uses the `eol`
 	attribute and the `core.autocrlf` configuration variable to
 	determine if the file should be converted.
 
-Any other value causes git to act as if `crlf` has been left
+Any other value causes git to act as if `text` has been left
 unspecified.
 
 `eol`
@@ -132,20 +132,31 @@ unspecified.
 
 This attribute sets a specific line-ending style to be used in the
 working directory.  It enables end-of-line normalization without any
-content checks, similar to setting the `crlf` attribute.
+content checks, similar to setting the `text` attribute.
 
 Set to string value "crlf"::
 
 	This setting forces git to normalize line endings on checkin
 	and convert them to CRLF when the file is checked out,
-	regardless of `crlf` and `core.autocrlf`.
+	regardless of `text` and `core.autocrlf`.
 
 Set to string value "lf"::
 
 	This setting forces git to normalize line endings to LF on
 	checkin and prevents conversion to CRLF when the file is
-	checked out, regardless of `crlf` and `core.autocrlf`.
-	`crlf=input` is a backwards compatibility alias for `eol=lf`.
+	checked out, regardless of `text` and `core.autocrlf`.
+
+Backwards compatibility with `crlf` attribute
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+For backwards compatibility, the `crlf` attribute is interpreted as
+follows:
+
+------------------------
+crlf		text
+-crlf		-text
+crlf=input	eol=lf
+------------------------
 
 End-of-line conversion
 ^^^^^^^^^^^^^^^^^^^^^^
@@ -160,10 +171,10 @@ the working directory, and prevent .jpg files from being normalized
 regardless of their content.
 
 ------------------------
-*.txt		crlf
+*.txt		text
 *.vcproj	eol=crlf
 *.sh		eol=lf
-*.jpg		-crlf
+*.jpg		-text
 ------------------------
 
 Other source code management systems normalize all text files in their
@@ -188,24 +199,24 @@ files without conversion to CRLF in the working directory.
 
 If you want to interoperate with a source code management system that
 enforces end-of-line normalization, or you simply want all text files
-in your repository to be normalized, you should instead set the `crlf`
+in your repository to be normalized, you should instead set the `text`
 attribute to "auto" for _all_ files.
 
 ------------------------
-*	crlf=auto
+*	text=auto
 ------------------------
 
 This ensures that all files that git considers to be text will have
 normalized (LF) line endings in the repository.
 
-NOTE: When `crlf=auto` normalization is enabled in an existing
+NOTE: When `text=auto` normalization is enabled in an existing
 repository, any text files containing CRLFs should be normalized.  If
 they are not they will be normalized the next time someone tries to
 change them, causing unfortunate misattribution.  From a clean working
 directory:
 
 -------------------------------------------------
-$ echo "* crlf=auto" >>.gitattributes
+$ echo "* text=auto" >>.gitattributes
                     # ...this should be the first line in .gitattributes
 $ rm .git/index     # Remove the index to force git to
 $ git reset         # re-scan the working directory
@@ -216,17 +227,17 @@ $ git commit -m "Introduce end-of-line normalization"
 -------------------------------------------------
 
 If any files that should not be normalized show up in 'git status',
-unset their `crlf` attribute before running 'git add -u'.
+unset their `text` attribute before running 'git add -u'.
 
 ------------------------
-manual.pdf	-crlf
+manual.pdf	-text
 ------------------------
 
 Conversely, text files that git does not detect can have normalization
 enabled manually.
 
 ------------------------
-weirdchars.txt	crlf
+weirdchars.txt	text
 ------------------------
 
 If `core.safecrlf` is set to "true" or "warn", git verifies if
@@ -312,11 +323,11 @@ Interaction between checkin/checkout attributes
 In the check-in codepath, the worktree file is first converted
 with `filter` driver (if specified and corresponding driver
 defined), then the result is processed with `ident` (if
-specified), and then finally with `crlf` (again, if specified
+specified), and then finally with `text` (again, if specified
 and applicable).
 
 In the check-out codepath, the blob content is first converted
-with `crlf`, and then `ident` and fed to `filter`.
+with `text`, and then `ident` and fed to `filter`.
 
 
 Generating diff text
@@ -720,7 +731,7 @@ You do not want any end-of-line conversions applied to, nor textual diffs
 produced for, any binary file you track.  You would need to specify e.g.
 
 ------------
-*.jpg -crlf -diff
+*.jpg -text -diff
 ------------
 
 but that may become cumbersome, when you have many attributes.  Using
@@ -733,7 +744,7 @@ the same time.  The system knows a built-in attribute macro, `binary`:
 
 which is equivalent to the above.  Note that the attribute macros can only
 be "Set" (see the above example that sets "binary" macro as if it were an
-ordinary attribute --- setting it in turn unsets "crlf" and "diff").
+ordinary attribute --- setting it in turn unsets "text" and "diff").
 
 
 DEFINING ATTRIBUTE MACROS
@@ -744,7 +755,7 @@ at the toplevel (i.e. not in any subdirectory).  The built-in attribute
 macro "binary" is equivalent to:
 
 ------------
-[attr]binary -diff -crlf
+[attr]binary -diff -text
 ------------
 
 
diff --git a/attr.c b/attr.c
index f5346ed..bf00469 100644
--- a/attr.c
+++ b/attr.c
@@ -287,7 +287,7 @@ static void free_attr_elem(struct attr_stack *e)
 }
 
 static const char *builtin_attr[] = {
-	"[attr]binary -diff -crlf",
+	"[attr]binary -diff -text",
 	NULL,
 };
 
diff --git a/convert.c b/convert.c
index 98bc029..a309e07 100644
--- a/convert.c
+++ b/convert.c
@@ -440,12 +440,14 @@ static int read_convert_config(const char *var, const char *value, void *cb)
 
 static void setup_convert_check(struct git_attr_check *check)
 {
+	static struct git_attr *attr_text;
 	static struct git_attr *attr_crlf;
 	static struct git_attr *attr_eol;
 	static struct git_attr *attr_ident;
 	static struct git_attr *attr_filter;
 
-	if (!attr_crlf) {
+	if (!attr_text) {
+		attr_text = git_attr("text");
 		attr_crlf = git_attr("crlf");
 		attr_eol = git_attr("eol");
 		attr_ident = git_attr("ident");
@@ -457,6 +459,7 @@ static void setup_convert_check(struct git_attr_check *check)
 	check[1].attr = attr_ident;
 	check[2].attr = attr_filter;
 	check[3].attr = attr_eol;
+	check[4].attr = attr_text;
 }
 
 static int count_ident(const char *cp, unsigned long size)
@@ -652,20 +655,20 @@ static int git_path_check_ident(const char *path, struct git_attr_check *check)
 	return !!ATTR_TRUE(value);
 }
 
-enum action determine_action(enum action crlf_attr, enum eol eol_attr) {
-	if (crlf_attr == CRLF_BINARY)
+enum action determine_action(enum action text_attr, enum eol eol_attr) {
+	if (text_attr == CRLF_BINARY)
 		return CRLF_BINARY;
 	if (eol_attr == EOL_LF)
 		return CRLF_INPUT;
 	if (eol_attr == EOL_CRLF)
 		return CRLF_CRLF;
-	return crlf_attr;
+	return text_attr;
 }
 
 int convert_to_git(const char *path, const char *src, size_t len,
                    struct strbuf *dst, enum safe_crlf checksafe)
 {
-	struct git_attr_check check[4];
+	struct git_attr_check check[5];
 	enum action action = CRLF_GUESS;
 	enum eol eol = EOL_UNSET;
 	int ident = 0, ret = 0;
@@ -674,7 +677,9 @@ int convert_to_git(const char *path, const char *src, size_t len,
 	setup_convert_check(check);
 	if (!git_checkattr(path, ARRAY_SIZE(check), check)) {
 		struct convert_driver *drv;
-		action = git_path_check_crlf(path, check + 0);
+		action = git_path_check_crlf(path, check + 4);
+		if (action == CRLF_GUESS)
+			action = git_path_check_crlf(path, check + 0);
 		ident = git_path_check_ident(path, check + 1);
 		drv = git_path_check_convert(path, check + 2);
 		eol = git_path_check_eol(path, check + 3);
@@ -698,7 +703,7 @@ int convert_to_git(const char *path, const char *src, size_t len,
 
 int convert_to_working_tree(const char *path, const char *src, size_t len, struct strbuf *dst)
 {
-	struct git_attr_check check[4];
+	struct git_attr_check check[5];
 	enum action action = CRLF_GUESS;
 	enum eol eol = EOL_UNSET;
 	int ident = 0, ret = 0;
@@ -707,7 +712,9 @@ int convert_to_working_tree(const char *path, const char *src, size_t len, struc
 	setup_convert_check(check);
 	if (!git_checkattr(path, ARRAY_SIZE(check), check)) {
 		struct convert_driver *drv;
-		action = git_path_check_crlf(path, check + 0);
+		action = git_path_check_crlf(path, check + 4);
+		if (action == CRLF_GUESS)
+			action = git_path_check_crlf(path, check + 0);
 		ident = git_path_check_ident(path, check + 1);
 		drv = git_path_check_convert(path, check + 2);
 		eol = git_path_check_eol(path, check + 3);
diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 13751db..4e55041 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -2369,15 +2369,20 @@ sub kopts_from_path
     if ( defined ( $cfg->{gitcvs}{usecrlfattr} ) and
          $cfg->{gitcvs}{usecrlfattr} =~ /\s*(1|true|yes)\s*$/i )
     {
-        my ($val) = check_attr( "crlf", $path );
-        if ( $val eq "set" )
+        my ($val) = check_attr( "text", $path );
+        if ( $val eq "unspecified" )
         {
-            return "";
+            $val = check_attr( "crlf", $path );
         }
-        elsif ( $val eq "unset" )
+        if ( $val eq "unset" )
         {
             return "-kb"
         }
+        elsif ( check_attr( "eol", $path ) ne "unspecified" ||
+                $val eq "set" || $val eq "input" )
+        {
+            return "";
+        }
         else
         {
             $log->info("Unrecognized check_attr crlf $path : $val");
diff --git a/t/t0025-crlf-auto.sh b/t/t0025-crlf-auto.sh
index 44cb593..8b1a128 100755
--- a/t/t0025-crlf-auto.sh
+++ b/t/t0025-crlf-auto.sh
@@ -44,6 +44,7 @@ test_expect_success 'default settings cause no changes' '
 
 test_expect_success 'crlf=true causes a CRLF file to be normalized' '
 
+	# Backwards compatibility check
 	rm -f .gitattributes tmp one two &&
 	echo "two crlf" > .gitattributes &&
 	git read-tree --reset -u HEAD &&
@@ -54,6 +55,18 @@ test_expect_success 'crlf=true causes a CRLF file to be normalized' '
 	test -n "$twodiff"
 '
 
+test_expect_success 'text=true causes a CRLF file to be normalized' '
+
+	rm -f .gitattributes tmp one two &&
+	echo "two text" > .gitattributes &&
+	git read-tree --reset -u HEAD &&
+
+	# Note, "normalized" means that git will normalize it if added
+	has_cr two &&
+	twodiff=`git diff two` &&
+	test -n "$twodiff"
+'
+
 test_expect_success 'eol=crlf gives a normalized file CRLFs with autocrlf=false' '
 
 	rm -f .gitattributes tmp one two &&
@@ -103,11 +116,11 @@ test_expect_success 'autocrlf=true does not normalize CRLF files' '
 	test -z "$onediff" -a -z "$twodiff"
 '
 
-test_expect_success 'crlf=auto, autocrlf=true _does_ normalize CRLF files' '
+test_expect_success 'text=auto, autocrlf=true _does_ normalize CRLF files' '
 
 	rm -f .gitattributes tmp one two &&
 	git config core.autocrlf true &&
-	echo "* crlf=auto" > .gitattributes &&
+	echo "* text=auto" > .gitattributes &&
 	git read-tree --reset -u HEAD &&
 
 	has_cr one &&
@@ -117,11 +130,11 @@ test_expect_success 'crlf=auto, autocrlf=true _does_ normalize CRLF files' '
 	test -z "$onediff" -a -n "$twodiff"
 '
 
-test_expect_success 'crlf=auto, autocrlf=true does not normalize binary files' '
+test_expect_success 'text=auto, autocrlf=true does not normalize binary files' '
 
 	rm -f .gitattributes tmp one two three &&
 	git config core.autocrlf true &&
-	echo "* crlf=auto" > .gitattributes &&
+	echo "* text=auto" > .gitattributes &&
 	git read-tree --reset -u HEAD &&
 
 	! has_cr three &&
-- 
1.7.1.5.gd739a
