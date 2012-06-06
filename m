From: Huynh Khoi Nguyen NGUYEN 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
Subject: [PATCHv6 4/4] Write to $XDG_CONFIG_HOME/git/config file
Date: Wed,  6 Jun 2012 15:21:25 +0200
Message-ID: <1338988885-21933-4-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
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
X-From: git-owner@vger.kernel.org Wed Jun 06 15:21:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScGB6-000280-1J
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jun 2012 15:21:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752944Ab2FFNVa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jun 2012 09:21:30 -0400
Received: from mx2.imag.fr ([129.88.30.17]:35299 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752066Ab2FFNVa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2012 09:21:30 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q56DCc93014371
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 6 Jun 2012 15:12:38 +0200
Received: from ensibm.imag.fr (ensibm [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q56DLQCP011163;
	Wed, 6 Jun 2012 15:21:26 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id q56DLPxG031293;
	Wed, 6 Jun 2012 15:21:25 +0200
Received: (from nguyenhu@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id q56DLPUt031274;
	Wed, 6 Jun 2012 15:21:25 +0200
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1338988885-21933-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 06 Jun 2012 15:12:38 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q56DCc93014371
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: huynh-khoi-nguyen.nguyen@phelma.grenoble-inp.fr
MailScanner-NULL-Check: 1339593161.05798@MjIAQYH4ECH6WKVtV5FPwA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199325>

From: NGUYEN Huynh Khoi Nguyen <nguyenhu@ensibm.imag.fr>

Git will be able to write to $XDG_CONFIG_HOME/git/config, a new
configuration file following XDG specification, if:
- this file already exists, and
- $HOME/.gitconfig file doesn't, and
- global option is used.
Otherwise Git writes to $HOME/.gitconfig with global option, as usual.
If you don't create $XDG_CONFIG_HOME/git/config, there is ABSOLUTELY
NO change. Users can use this new file ONLY if they want.
If $XDG_CONFIG_HOME is either not set or empty, $HOME/.config/git/config
will be used.
Advice for users who often come back to an old version of GIT:
you shouldn't create this file.

Signed-off-by: Huynh Khoi Nguyen NGUYEN <Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
Signed-off-by: Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>
Signed-off-by: Franck Jonas <Franck.Jonas@ensimag.imag.fr>
Signed-off-by: Lucien Kong <Lucien.Kong@ensimag.imag.fr>
Signed-off-by: Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
---
 Documentation/git-config.txt |    3 ++-
 builtin/config.c             |    5 +----
 t/t1306-xdg-files.sh         |   30 ++++++++++++++++++++++++++++++
 3 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 7e344a2..a2b4786 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -97,7 +97,8 @@ OPTIONS
 
 --global::
 	For writing options: write to global ~/.gitconfig file rather than
-	the repository .git/config.
+	the repository .git/config, write to $XDG_CONFIG_HOME/git/config file
+	if this file exists and ~/.gitconfig file doesn't.
 +
 For reading options: read only from global ~/.gitconfig and from
 $XDG_CONFIG_HOME/git/config rather than from all available files.
diff --git a/builtin/config.c b/builtin/config.c
index da54fd1..e8e1c0a 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -387,10 +387,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 
 		home_config_paths(&user_config, &xdg_config, "config");
 
-		if (access(user_config, R_OK) && !access(xdg_config, R_OK) &&
-		    (actions == ACTION_LIST ||
-		     actions == ACTION_GET_COLOR ||
-		     actions == ACTION_GET_COLORBOOL))
+		if (access(user_config, R_OK) && !access(xdg_config, R_OK))
 			given_config_file = xdg_config;
 		else if (user_config)
 			given_config_file = user_config;
diff --git a/t/t1306-xdg-files.sh b/t/t1306-xdg-files.sh
index eb0f40b..dbf236a 100755
--- a/t/t1306-xdg-files.sh
+++ b/t/t1306-xdg-files.sh
@@ -154,4 +154,34 @@ test_expect_success 'Checking attributes in a non-XDG global attributes file' '
 '
 
 
+test_expect_success 'write: xdg file exists and ~/.gitconfig doesn'\''t' '
+	mkdir -p .config/git &&
+	>.config/git/config &&
+	rm .gitconfig &&
+	git config --global user.name "write_config" &&
+	echo "[user]" >expected &&
+	echo "	name = write_config" >>expected &&
+	test_cmp expected .config/git/config
+'
+
+
+test_expect_success 'write: xdg file exists and ~/.gitconfig exists' '
+	>.gitconfig &&
+	git config --global user.name "write_gitconfig" &&
+	echo "[user]" >expected &&
+	echo "	name = write_gitconfig" >>expected &&
+	test_cmp expected .gitconfig
+'
+
+
+test_expect_success 'write: ~/.config/git/ exists and config file doesn'\''t' '
+	rm .gitconfig &&
+	rm .config/git/config &&
+	git config --global user.name "write_gitconfig" &&
+	echo "[user]" >expected &&
+	echo "	name = write_gitconfig" >>expected &&
+	test_cmp expected .gitconfig
+'
+
+
 test_done
-- 
1.7.8
