From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH v3 36/39] i18n: submodule: join strings marked for translation
Date: Wed,  1 Jun 2016 18:13:00 +0000
Message-ID: <1464804783-10195-7-git-send-email-vascomalmeida@sapo.pt>
References: <1464799289-7639-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 01 20:14:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8Aek-0006c3-8i
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 20:14:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754961AbcFASNt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 14:13:49 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:59118 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754645AbcFASNs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 14:13:48 -0400
Received: (qmail 31749 invoked from network); 1 Jun 2016 18:13:41 -0000
Received: (qmail 20890 invoked from network); 1 Jun 2016 18:13:40 -0000
Received: from unknown (HELO localhost.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 1 Jun 2016 18:13:35 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1464799289-7639-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296143>

Join strings marked for translation since that would facilitate and
improve translations result.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 git-submodule.sh | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 5a4dec0..91fca56 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -275,14 +275,15 @@ Use -f if you really want to add it." >&2
 		then
 			if test -z "$force"
 			then
-				echo >&2 "$(eval_gettext "A git directory for '\$sm_name' is found locally with remote(s):")"
+				eval_gettextln >&2 "A git directory for '\$sm_name' is found locally with remote(s):"
 				GIT_DIR=".git/modules/$sm_name" GIT_WORK_TREE=. git remote -v | grep '(fetch)' | sed -e s,^,"  ", -e s,' (fetch)',, >&2
-				echo >&2 "$(eval_gettext "If you want to reuse this local git directory instead of cloning again from")"
-				echo >&2 "  $realrepo"
-				echo >&2 "$(eval_gettext "use the '--force' option. If the local git directory is not the correct repo")"
-				die "$(eval_gettext "or you are unsure what this means choose another name with the '--name' option.")"
+				die "$(eval_gettextln "\
+If you want to reuse this local git directory instead of cloning again from
+  \$realrepo
+use the '--force' option. If the local git directory is not the correct repo
+or you are unsure what this means choose another name with the '--name' option.")"
 			else
-				echo "$(eval_gettext "Reactivating local git directory for submodule '\$sm_name'.")"
+				eval_gettextln "Reactivating local git directory for submodule '\$sm_name'."
 			fi
 		fi
 		git submodule--helper clone ${GIT_QUIET:+--quiet} --prefix "$wt_prefix" --path "$sm_path" --name "$sm_name" --url "$realrepo" ${reference:+"$reference"} ${depth:+"$depth"} || exit
@@ -467,8 +468,9 @@ cmd_deinit()
 			# Protect submodules containing a .git directory
 			if test -d "$sm_path/.git"
 			then
-				echo >&2 "$(eval_gettext "Submodule work tree '\$displaypath' contains a .git directory")"
-				die "$(eval_gettext "(use 'rm -rf' if you really want to remove it including all of its history)")"
+				die "$(eval_gettext "\
+Submodule work tree '\$displaypath' contains a .git directory
+(use 'rm -rf' if you really want to remove it including all of its history)")"
 			fi
 
 			if test -z "$force"
-- 
2.7.3
