From: Huynh Khoi Nguyen NGUYEN 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
Subject: [PATCHv6 3/4] Let core.attributesfile default to $XDG_CONFIG_HOME/git/attributes
Date: Wed,  6 Jun 2012 15:21:24 +0200
Message-ID: <1338988885-21933-3-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
References: <1338754481-27012-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
 <1338988885-21933-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
Cc: Matthieu.Moy@grenoble-inp.fr,
	NGUYEN Huynh Khoi Nguyen <nguyenhu@ensibm.imag.fr>,
	Huynh Khoi Nguyen NGUYEN 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Lucien Kong <Lucien.Kong@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 06 15:21:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScGBF-0002Wo-4m
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jun 2012 15:21:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753689Ab2FFNVc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jun 2012 09:21:32 -0400
Received: from mx1.imag.fr ([129.88.30.5]:49902 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752995Ab2FFNVb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2012 09:21:31 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q56DClX3001319
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 6 Jun 2012 15:12:47 +0200
Received: from ensibm.imag.fr (ensibm [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q56DLP4J011161;
	Wed, 6 Jun 2012 15:21:25 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id q56DLPlV031196;
	Wed, 6 Jun 2012 15:21:25 +0200
Received: (from nguyenhu@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id q56DLP5D031177;
	Wed, 6 Jun 2012 15:21:25 +0200
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1338988885-21933-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 06 Jun 2012 15:12:47 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q56DClX3001319
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: huynh-khoi-nguyen.nguyen@phelma.grenoble-inp.fr
MailScanner-NULL-Check: 1339593171.36482@YnEyRDzOxr0gzwNNQ7Vi7w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199327>

From: NGUYEN Huynh Khoi Nguyen <nguyenhu@ensibm.imag.fr>

If core.attributesfile is not defined, its default value will be
$XDG_CONFIG_HOME/git/attributes in order to follow XDG
specification. If $XDG_CONFIG_HOME is either not set or emty,
$HOME/.config/git/attributes will be used.

Signed-off-by: Huynh Khoi Nguyen NGUYEN <Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
Signed-off-by: Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>
Signed-off-by: Franck Jonas <Franck.Jonas@ensimag.imag.fr>
Signed-off-by: Lucien Kong <Lucien.Kong@ensimag.imag.fr>
Signed-off-by: Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
---
 Documentation/config.txt        |    4 ++-
 Documentation/gitattributes.txt |    2 +
 attr.c                          |   17 ++++++++-----
 t/t1306-xdg-files.sh            |   47 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 62 insertions(+), 8 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 509bf25..f691d8e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -500,7 +500,9 @@ core.attributesfile::
 	In addition to '.gitattributes' (per-directory) and
 	'.git/info/attributes', git looks into this file for attributes
 	(see linkgit:gitattributes[5]). Path expansions are made the same
-	way as for `core.excludesfile`.
+	way as for `core.excludesfile`. Its default value is
+	$XDG_CONFIG_HOME/git/attributes. If $XDG_CONFIG_HOME is either not
+	set or empty, $HOME/.config/git/attributes will be used.
 
 core.editor::
 	Commands such as `commit` and `tag` that lets you edit
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 80120ea..484c614 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -75,6 +75,8 @@ repositories (i.e., attributes of interest to all users) should go into
 `.gitattributes` files. Attributes that should affect all repositories
 for a single user should be placed in a file specified by the
 `core.attributesfile` configuration option (see linkgit:git-config[1]).
+Its default value is $XDG_CONFIG_HOME/git/attributes. If $XDG_CONFIG_HOME
+is either not set or empty, $HOME/.config/git/attributes will be used.
 Attributes for all users on a system should be placed in the
 `$(prefix)/etc/gitattributes` file.
 
diff --git a/attr.c b/attr.c
index 303751f..aef93d8 100644
--- a/attr.c
+++ b/attr.c
@@ -497,6 +497,7 @@ static int git_attr_system(void)
 static void bootstrap_attr_stack(void)
 {
 	struct attr_stack *elem;
+	char *xdg_attributes_file;
 
 	if (attr_stack)
 		return;
@@ -515,13 +516,15 @@ static void bootstrap_attr_stack(void)
 		}
 	}
 
-	if (git_attributes_file) {
-		elem = read_attr_from_file(git_attributes_file, 1);
-		if (elem) {
-			elem->origin = NULL;
-			elem->prev = attr_stack;
-			attr_stack = elem;
-		}
+	if (!git_attributes_file) {
+		home_config_paths(NULL, &xdg_attributes_file, "attributes");
+		git_attributes_file = xdg_attributes_file;
+	}
+	elem = read_attr_from_file(git_attributes_file, 1);
+	if (elem) {
+		elem->origin = NULL;
+		elem->prev = attr_stack;
+		attr_stack = elem;
 	}
 
 	if (!is_bare_repository() || direction == GIT_ATTR_INDEX) {
diff --git a/t/t1306-xdg-files.sh b/t/t1306-xdg-files.sh
index 873bbcf..eb0f40b 100755
--- a/t/t1306-xdg-files.sh
+++ b/t/t1306-xdg-files.sh
@@ -107,4 +107,51 @@ test_expect_success 'Exclusion in a non-XDG global ignore file' '
 '
 
 
+test_expect_success 'Checking attributes in the XDG attributes file' '
+	test_when_finished "rm -rf git" &&
+	git init git &&
+	(
+		cd git &&
+		echo foo >f &&
+		git check-attr -a f >actual &&
+		test_line_count -eq 0 actual &&
+		echo "f attr_f" >"$HOME"/.config/git/attributes &&
+		echo "f: attr_f: set" >expected &&
+		git check-attr -a f >actual &&
+		test_cmp expected actual
+	)
+'
+
+
+test_expect_success 'Checking attributes in both XDG and local ignore files' '
+	test_when_finished "rm -rf git" &&
+	git init git &&
+	(
+		cd git &&
+		echo foo >f &&
+		echo "f attr_f" >"$HOME"/.config/git/attributes &&
+		echo "f -attr_f" >.gitattributes &&
+		echo "f: attr_f: unset" >expected &&
+		git check-attr -a f >actual &&
+		test_cmp expected actual
+	)
+'
+
+
+test_expect_success 'Checking attributes in a non-XDG global attributes file' '
+	test_when_finished "rm -rf git" &&
+	git init git &&
+	(
+		cd git &&
+		echo foo >f &&
+		echo "f attr_f" >"$HOME"/.config/git/attributes &&
+		echo "f attr_f=test" >"$HOME"/my_gitattributes &&
+		git config core.attributesfile "$HOME"/my_gitattributes &&
+		echo "f: attr_f: test" >expected &&
+		git check-attr -a f >actual &&
+		test_cmp expected actual
+	)
+'
+
+
 test_done
-- 
1.7.8
