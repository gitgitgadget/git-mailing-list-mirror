From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH] tg-push: prevent multiple occurences of branches
Date: Tue, 26 May 2009 23:37:00 +0200
Message-ID: <1243373820-13442-1-git-send-email-bert.wesarg@googlemail.com>
Cc: Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org,
	martin f krafft <madduck@debian.org>,
	Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
	Marc Weber <marco-oweber@gmx.de>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue May 26 23:37:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M94Kl-0004eb-KF
	for gcvg-git-2@gmane.org; Tue, 26 May 2009 23:37:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753921AbZEZVhF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2009 17:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754553AbZEZVhE
	(ORCPT <rfc822;git-outgoing>); Tue, 26 May 2009 17:37:04 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:51072 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753584AbZEZVhD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2009 17:37:03 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1044348fga.17
        for <git@vger.kernel.org>; Tue, 26 May 2009 14:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=zRZ++wjtzYuyYc8TWOtZ6PT6cZ9XXfxjKuwZOsJ9OzY=;
        b=WxGwdngPPvGjZM5YOIwtdEYl0myZACmhxSpf6usVY2xCmtQtFtAugsT83N16ZPL906
         hXnQy3LJBrjEH8o6IbW2ZP5Zh1fAtfeR79lQKAapMOdEMwfBrDauGHmc7dA2CVK9nlK4
         CmI5ZRjofzrr4mvfnH8fQ1Z34Y9BjAZvtOrL8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=vLS9imAE8OdiBgSMvzvPKEuKudg0lB19ier/4/HAljFm6MUlxAcr6mJ28rvOZUVLLj
         tc+a9r4KChw3ABqWuOFkwgTyONtUX0HO2Z93VIY9RWVZOPBcTxyXV5YKNi0XI4ksZQ7u
         Ywj1bo5Mgt/gqdjmsbIXOvFUqJEBLijZUAnso=
Received: by 10.86.81.15 with SMTP id e15mr6842633fgb.35.1243373822850;
        Tue, 26 May 2009 14:37:02 -0700 (PDT)
Received: from localhost (drsd-4db3d3cf.pool.einsundeins.de [77.179.211.207])
        by mx.google.com with ESMTPS id 4sm14144956fgg.18.2009.05.26.14.37.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 26 May 2009 14:37:02 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.463.g124d4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120011>

So, I finally tried tg-push and got a lot of warnings and errors:

warning, no base found top-bases/master
warning, no base found top-bases/master
warning, no base found top-bases/master
warning, no base found top-bases/master
warning, no base found top-bases/master
warning, no base found top-bases/master
warning, no base found top-bases/master
warning, no base found top-bases/master
warning, no base found top-bases/master
warning, no base found top-bases/master
warning, no base found top-bases/master


error: Ref refs/heads/master is at b725fc951a37854fc65945ac5bcab3bc61ccbd94 but expected 0000000000000000000000000000000000000000
error: failed to lock refs/heads/master
error: Ref refs/heads/master is at b725fc951a37854fc65945ac5bcab3bc61ccbd94 but expected 0000000000000000000000000000000000000000
error: failed to lock refs/heads/master
error: Ref refs/heads/master is at b725fc951a37854fc65945ac5bcab3bc61ccbd94 but expected 0000000000000000000000000000000000000000
error: failed to lock refs/heads/master
error: Ref refs/heads/master is at b725fc951a37854fc65945ac5bcab3bc61ccbd94 but expected 0000000000000000000000000000000000000000
error: failed to lock refs/heads/master
error: Ref refs/heads/master is at b725fc951a37854fc65945ac5bcab3bc61ccbd94 but expected 0000000000000000000000000000000000000000
error: failed to lock refs/heads/master
error: Ref refs/heads/master is at b725fc951a37854fc65945ac5bcab3bc61ccbd94 but expected 0000000000000000000000000000000000000000
error: failed to lock refs/heads/master
error: Ref refs/heads/master is at b725fc951a37854fc65945ac5bcab3bc61ccbd94 but expected 0000000000000000000000000000000000000000
error: failed to lock refs/heads/master
error: Ref refs/heads/master is at b725fc951a37854fc65945ac5bcab3bc61ccbd94 but expected 0000000000000000000000000000000000000000
error: failed to lock refs/heads/master
error: Ref refs/heads/master is at b725fc951a37854fc65945ac5bcab3bc61ccbd94 but expected 0000000000000000000000000000000000000000
error: failed to lock refs/heads/master
error: Ref refs/heads/master is at b725fc951a37854fc65945ac5bcab3bc61ccbd94 but expected 0000000000000000000000000000000000000000
error: failed to lock refs/heads/master
error: Ref refs/heads/bw/log is at a16df35cc7009b36f6f71717ae3d9a3dc29987da but expected 0000000000000000000000000000000000000000
error: failed to lock refs/heads/bw/log
error: Ref refs/top-bases/bw/log is at b725fc951a37854fc65945ac5bcab3bc61ccbd94 but expected 0000000000000000000000000000000000000000
error: failed to lock refs/top-bases/bw/log

 ! [remote rejected] master -> master (failed to lock)
 ! [remote rejected] master -> master (failed to lock)
 ! [remote rejected] master -> master (failed to lock)
 ! [remote rejected] master -> master (failed to lock)
 ! [remote rejected] master -> master (failed to lock)
 ! [remote rejected] master -> master (failed to lock)
 ! [remote rejected] master -> master (failed to lock)
 ! [remote rejected] master -> master (failed to lock)
 ! [remote rejected] master -> master (failed to lock)
 ! [remote rejected] master -> master (failed to lock)
 ! [remote rejected] bw/log -> bw/log (failed to lock)
 ! [remote rejected] refs/top-bases/bw/log -> refs/top-bases/bw/log (failed to lock)

Also the result was ok this output is defintive not ok.

To prevent multiple occurences of the same branchname we maintain these in a
file.

In push_branch ref_exists was called, which is redundant because _dep_is_tgish
tells us exactly this.

Regards,
Bert

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---
 tg-push.sh |   48 +++++++++++++++++++++++++++++-------------------
 1 files changed, 29 insertions(+), 19 deletions(-)

diff --git a/tg-push.sh b/tg-push.sh
index 8d09a02..c813927 100644
--- a/tg-push.sh
+++ b/tg-push.sh
@@ -45,31 +45,41 @@ for name in $branches; do
 	ref_exists "$name" || die "detached HEAD? Can't push $name"
 done
 
+_listfile="$(mktemp -t tg-push-listfile.XXXXXX)"
+trap "rm -f \"$_listfile\"" 0
+
+# prevent multiple occurrences of the same branch
+add_to_list()
+{
+	fgrep -qx "$1" "$_listfile" ||
+		echo "$1" >> "$_listfile"
+}
+
 push_branch()
 {
 	# if so desired omit non tgish deps
 	$tgish_deps_only && [ -z "$_dep_is_tgish" ] && return 0
 
-	echo "$_dep"
-	local base="top-bases/$_dep"
-	if ref_exists "$base"; then
-		echo "top-bases/$_dep"
-	else
-		echo "warning, no base found $base" 1>&2
-	fi
+	add_to_list "$_dep"
+	[ -z "$_dep_is_tgish" ] ||
+		add_to_list "top-bases/$_dep"
 }
 
 for name in $branches; do
-	list="$(
-		# deps
-		if $recurse_deps; then
-			no_remotes=1 recurse_deps push_branch "$name"
-		fi
-		# current branch
-		_dep="$name"
-		_dep_is_tgish=1
-		push_branch "$name"
-	)"
-	echo "pushing:"; echo $list
-	git push $dry_run "$remote" $list
+	# current branch
+	# re-use push_branch, which expects some pre-defined variables
+	_dep="$name"
+	_dep_is_tgish=1
+	ref_exists "top-bases/$_dep" ||
+		_dep_is_tgish=
+	push_branch "$name"
+
+	# deps
+	$recurse_deps &&
+		no_remotes=1 recurse_deps push_branch "$name"
+
+	cat "$_listfile" |
+		sed '1{ s/^/Pushing: /; n; }; s/^/         /;'
+
+	cat "$_listfile" | xargs git push $dry_run "$remote"
 done
-- 
tg: (b725fc9..) bw/push-fixes (depends on: master)
