Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66C401FEAA
	for <e@80x24.org>; Fri, 17 Jun 2016 21:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755627AbcFQVyk (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 17:54:40 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:38372 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752644AbcFQVyj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 17:54:39 -0400
Received: (qmail 1367 invoked from network); 17 Jun 2016 21:54:37 -0000
Received: (qmail 30493 invoked from network); 17 Jun 2016 21:54:37 -0000
Received: from unknown (HELO linux-omuo.lan) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 17 Jun 2016 21:54:37 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:	Vasco Almeida <vascomalmeida@sapo.pt>
To:	git@vger.kernel.org
Cc:	Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 35/38] i18n: submodule: join strings marked for translation
Date:	Fri, 17 Jun 2016 21:54:12 +0000
Message-Id: <1466200455-16951-6-git-send-email-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <1466194887-18236-1-git-send-email-vascomalmeida@sapo.pt>
References: <1466194887-18236-1-git-send-email-vascomalmeida@sapo.pt>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Join strings marked for translation since that would facilitate and
improve translations result.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 git-submodule.sh | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 5b9674a..f72b237 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -239,14 +239,15 @@ Use -f if you really want to add it." >&2
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
@@ -437,8 +438,9 @@ cmd_deinit()
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
2.6.6

