From: Huynh Khoi Nguyen NGUYEN 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
Subject: [PATCHv5 4/4] Write to $XDG_CONFIG_HOME/git/config file
Date: Sun,  3 Jun 2012 22:14:41 +0200
Message-ID: <1338754481-27012-4-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
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
X-From: git-owner@vger.kernel.org Sun Jun 03 22:15:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbHCT-000498-K5
	for gcvg-git-2@plane.gmane.org; Sun, 03 Jun 2012 22:14:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754660Ab2FCUOz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Jun 2012 16:14:55 -0400
Received: from mx2.imag.fr ([129.88.30.17]:57207 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754597Ab2FCUOt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2012 16:14:49 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q53K65sJ021156
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 3 Jun 2012 22:06:05 +0200
Received: from ensibm.imag.fr (ensibm [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q53KEh00014100;
	Sun, 3 Jun 2012 22:14:43 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id q53KEgck027494;
	Sun, 3 Jun 2012 22:14:42 +0200
Received: (from nguyenhu@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id q53KEgKD027493;
	Sun, 3 Jun 2012 22:14:42 +0200
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1338754481-27012-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 03 Jun 2012 22:06:05 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q53K65sJ021156
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: huynh-khoi-nguyen.nguyen@phelma.grenoble-inp.fr
MailScanner-NULL-Check: 1339358769.0136@0APfY3J3tl3KC/bibyTEUw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199098>

From: NGUYEN Huynh Khoi Nguyen <nguyenhu@ensibm.imag.fr>

Git will be able to write to $XDG_CONFIG_HOME/git/config, a new
configuration file following XDG specification, if:
- this file already exists, and
- $HOME/.gitconfig file doesn't, and
- global option is used.
Otherwise Git writes to $HOME/.gitconfig with global option, as usual.
If you don't create $XDG_CONFIG_HOME/git/config, there is ABSOLUTELY
NO change. Users can use this new file ONLY if they want.
If $XDG_CONFIG_HOME is either not set or empty, $HOME/.config will be
used.
Advice for users who often come back to an old version of GIT:
you shouldn't create this file.

Signed-off-by: Huynh Khoi Nguyen NGUYEN <Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
Signed-off-by: Valentin DUPERRAY <Valentin.DUPERRAY@ensimag.imag.fr>
Signed-off-by: Franck JONAS <Franck.JONAS@ensimag.imag.fr>
Signed-off-by: Thomas NGUY <Thomas.NGUY@ensimag.imag.fr>
Signed-off-by: Lucien KONG <Lucien.KONG@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
---
 Documentation/git-config.txt |    3 ++-
 builtin/config.c             |    5 +----
 t/t1306-xdg-files.sh         |   18 ++++++++++++++++++
 3 files changed, 21 insertions(+), 5 deletions(-)

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
index 80621ed..1ff709d 100755
--- a/t/t1306-xdg-files.sh
+++ b/t/t1306-xdg-files.sh
@@ -114,4 +114,22 @@ test_expect_success 'Checking attributes in a non-XDG global attributes file' '
 	test_cmp expected actual
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
+test_expect_success 'write: xdg file exists and ~/.gitconfig exists' '
+	>.gitconfig &&
+	git config --global user.name "write_gitconfig" &&
+	echo "[user]" >expected &&
+	echo "	name = write_gitconfig" >>expected &&
+	test_cmp expected .gitconfig
+'
+
 test_done
-- 
1.7.8
