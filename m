From: Huynh Khoi Nguyen NGUYEN 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
Subject: [PATCHv5 3/4] Let core.attributesfile default to $XDG_CONFIG_HOME/git/attributes
Date: Sun,  3 Jun 2012 22:14:40 +0200
Message-ID: <1338754481-27012-3-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
References: <1338585788-9764-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
 <1338754481-27012-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
Cc: Matthieu.Moy@grenoble-inp.fr,
	NGUYEN Huynh Khoi Nguyen <nguyenhu@ensibm.imag.fr>,
	Huynh Khoi Nguyen NGUYEN 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Valentin DUPERRAY <Valentin.DUPERRAY@ensimag.imag.fr>,
	Franck JONAS <Franck.JONAS@ensimag.imag.fr>,
	Thomas NGUY <Thomas.NGUY@ensimag.imag.fr>,
	Lucien KONG <Lucien.KONG@ensimag.imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 03 22:15:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbHCf-0004VG-R7
	for gcvg-git-2@plane.gmane.org; Sun, 03 Jun 2012 22:15:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754681Ab2FCUO7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Jun 2012 16:14:59 -0400
Received: from mx2.imag.fr ([129.88.30.17]:57210 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754612Ab2FCUOu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2012 16:14:50 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q53K64hK021154
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 3 Jun 2012 22:06:04 +0200
Received: from ensibm.imag.fr (ensibm [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q53KEgBN014098;
	Sun, 3 Jun 2012 22:14:42 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id q53KEgjL027487;
	Sun, 3 Jun 2012 22:14:42 +0200
Received: (from nguyenhu@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id q53KEguO027486;
	Sun, 3 Jun 2012 22:14:42 +0200
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1338754481-27012-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 03 Jun 2012 22:06:04 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q53K64hK021154
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: huynh-khoi-nguyen.nguyen@phelma.grenoble-inp.fr
MailScanner-NULL-Check: 1339358769.00935@XAPds32YGaOQzhJLk43NjQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199099>

From: NGUYEN Huynh Khoi Nguyen <nguyenhu@ensibm.imag.fr>

If core.attributesfile is not defined, its default value will be
$XDG_CONFIG_HOME/git/attributes in order to follow XDG
specification. If $XDG_CONFIG_HOME is either not set or emty,
$HOME/.config will be used.

Signed-off-by: Huynh Khoi Nguyen NGUYEN <Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
Signed-off-by: Valentin DUPERRAY <Valentin.DUPERRAY@ensimag.imag.fr>
Signed-off-by: Franck JONAS <Franck.JONAS@ensimag.imag.fr>
Signed-off-by: Thomas NGUY <Thomas.NGUY@ensimag.imag.fr>
Signed-off-by: Lucien KONG <Lucien.KONG@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
---
 Documentation/config.txt        |    4 +++-
 Documentation/gitattributes.txt |    2 ++
 attr.c                          |   17 ++++++++++-------
 t/t1306-xdg-files.sh            |   30 ++++++++++++++++++++++++++++++
 4 files changed, 45 insertions(+), 8 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index bfaef2c..9dc274c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -500,7 +500,9 @@ core.attributesfile::
 	In addition to '.gitattributes' (per-directory) and
 	'.git/info/attributes', git looks into this file for attributes
 	(see linkgit:gitattributes[5]). Path expansions are made the same
-	way as for `core.excludesfile`.
+	way as for `core.excludesfile`. Its default value is
+	$XDG_CONFIG_HOME/git/attributes. If $XDG_CONFIG_HOME is either not
+	set or empty, $HOME/.config will be used.
 
 core.editor::
 	Commands such as `commit` and `tag` that lets you edit
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 80120ea..3339eef 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -75,6 +75,8 @@ repositories (i.e., attributes of interest to all users) should go into
 `.gitattributes` files. Attributes that should affect all repositories
 for a single user should be placed in a file specified by the
 `core.attributesfile` configuration option (see linkgit:git-config[1]).
+Its default value is $XDG_CONFIG_HOME/git/attributes. If $XDG_CONFIG_HOME
+is either not set or empty, $HOME/.config will be used.
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
index 1a1f07e..80621ed 100755
--- a/t/t1306-xdg-files.sh
+++ b/t/t1306-xdg-files.sh
@@ -84,4 +84,34 @@ test_expect_success 'Exclusion in a non-XDG global ignore file' '
 	test_must_fail git add to_be_excluded
 '
 
+test_expect_success 'Checking attributes in the XDG attributes file' '
+	git init git &&
+	cd git &&
+	echo foo >f &&
+	git check-attr -a f >actual &&
+	test_line_count -eq 0 actual &&
+	mkdir -p "$HOME"/.config/git/ &&
+	echo "f attr_f" >"$HOME"/.config/git/attributes &&
+	echo "f: attr_f: set" >expected &&
+	git check-attr -a f >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'Checking attributes in both XDG and local ignore files' '
+	echo "f -attr_f" >.gitattributes &&
+	echo "f: attr_f: unset" >expected &&
+	git check-attr -a f >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'Checking attributes in a non-XDG global attributes file' '
+	rm .gitattributes &&
+	echo "f attr_f=test" >"$HOME"/my_gitattributes &&
+	git config core.attributesfile "$HOME"/my_gitattributes &&
+	test_when_finished "cd \"$HOME\" && rm -rf git && rm -r .config" &&
+	echo "f: attr_f: test" >expected &&
+	git check-attr -a f >actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
1.7.8
