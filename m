From: Nicola Paolucci <npaolucci@atlassian.com>
Subject: [PATCH 2/3] contrib/subtree: new list command to list subtrees
Date: Thu, 10 Mar 2016 10:44:11 +0100
Message-ID: <1457603052-53963-3-git-send-email-npaolucci@atlassian.com>
References: <1457603052-53963-1-git-send-email-npaolucci@atlassian.com>
Cc: Dave <davidw@realtimegenomics.com>,
	"David A . Greene" <greened@obbligato.org>,
	Mathias Nyman <mathias.nyman@iki.fi>,
	Nicola Paolucci <npaolucci@atlassian.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 10 10:45:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adx9l-0001oY-In
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 10:45:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754685AbcCJJpL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2016 04:45:11 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:35180 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754634AbcCJJpD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2016 04:45:03 -0500
Received: by mail-wm0-f42.google.com with SMTP id l68so21684767wml.0
        for <git@vger.kernel.org>; Thu, 10 Mar 2016 01:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u1U74JnOG3r1Y7W+ImP0ttHymc/2DRk2L7sNxWkJhgE=;
        b=c3nWQmaQKE36B9HKPENfxXPiLcFSW11cfuPVj8SVYFpCe0VX+3HEEetdto/U10ORvr
         8pQkQgQ1Eg9zzwVuMfw5ESVm2vwjzy7cRsMfBTpvpsSWKUQthYtFVgB5EOTrwdTNm9P3
         sakBcjBof5l7XiNlqTeTk5tMuROGprXaO48sL7ak6kI6L+8nT+AqQueNh906HZeYnDOU
         YYn1W35jnegAbemCeKiocDJQjow9Z+6IhYIY3X2ckzy+j9ZrgH+Bt8T3g26RMp3v9bPd
         hfW5GdH0jtBB2AntUTYkPTHxOhv608PQ671ACFTKqJN4emOSUPzdFyZQVey3s+qadKpI
         WMDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u1U74JnOG3r1Y7W+ImP0ttHymc/2DRk2L7sNxWkJhgE=;
        b=F8oQ45Sr9g4UCjARgqJ2HfNoIXMAKAE45eyivCz5kmkamqFdD7gubZGUYQ7DrsNsNJ
         XuUafGlChkRn9QdCnDQYmcyft8jlxgL/QgGOSQRS68XjygCSIQiB5QtjY9KP+gdRrKBI
         CslQMUGz3pz4QPdttp59dzWM+QuV7zXZd29A7213DVuvCUT2Bw5xz91bV1QZMzmOVCJK
         OFM+9zJIbQDzUY6iY+2FuWLgsYeDdCcKpmos195lehZTE8/KQqtkb8WaD46i1GBnvYEX
         VnVMHZgmenhoNSiT2tW4Mxti7g/D0CQnc6jx1jDACRniF6UfS1vevAjKlNNPG7pbMEJN
         1IIQ==
X-Gm-Message-State: AD7BkJKGtLQFnjZfahaLvSyPOEHg5BJafEBOW+01DIX/Tn3hFJbFg6tw3mUFjEZAyqJirB2Q
X-Received: by 10.28.30.208 with SMTP id e199mr2665771wme.74.1457603102069;
        Thu, 10 Mar 2016 01:45:02 -0800 (PST)
Received: from reborn.ams.atlassian.com ([46.243.25.78])
        by smtp.gmail.com with ESMTPSA id q139sm2684747wmd.2.2016.03.10.01.45.01
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 10 Mar 2016 01:45:01 -0800 (PST)
X-Mailer: git-send-email 2.7.1
In-Reply-To: <1457603052-53963-1-git-send-email-npaolucci@atlassian.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288608>

Example output:

$ git subtree list
.vim/bundle/fireplace https://github.com/tpope/vim-fireplace.git b999b0

Signed-off-by: Nicola Paolucci <npaolucci@atlassian.com>
---
 contrib/subtree/git-subtree.sh     | 54 ++++++++++++++++++++++++++++++++++----
 contrib/subtree/t/t7900-subtree.sh | 18 +++++++++++++
 2 files changed, 67 insertions(+), 5 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 278699b..82f3fce 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -14,6 +14,7 @@ git subtree merge --prefix=<prefix> <commit>
 git subtree pull  --prefix=<prefix> <repository> <ref>
 git subtree push  --prefix=<prefix> <repository> <ref>
 git subtree split --prefix=<prefix> <commit...>
+git subtree list
 --
 h,help        show the help
 q             quiet
@@ -109,19 +110,22 @@ done
 command="$1"
 shift
 case "$command" in
-	add|merge|pull) default= ;;
+	add|merge|pull|list) default= ;;
 	split|push) default="--default HEAD" ;;
 	*) die "Unknown command '$command'" ;;
 esac
 
-if [ -z "$prefix" ]; then
-	die "You must provide the --prefix option."
+if [ "$command" != "list" ]; then
+	if [ -z "$prefix" ]; then
+		die "You must provide the --prefix option."
+	fi
 fi
 
 case "$command" in
-	add) [ -e "$prefix" ] && 
+	add) [ -e "$prefix" ] &&
 		die "prefix '$prefix' already exists." ;;
-	*)   [ -e "$prefix" ] || 
+	list) ;;
+	*)   [ -e "$prefix" ] ||
 		die "'$prefix' does not exist; use 'git subtree add'" ;;
 esac
 
@@ -230,6 +234,41 @@ try_remove_previous()
 	fi
 }
 
+find_subtree_repos()
+{
+	debug "Looking for subtree repos..."
+	sq=
+	main=
+	sub=
+	git log --grep="^git-subtree-dir:" \
+		--pretty=format:'START %H%n%s%n%n%b%nEND%n' HEAD |
+	while read a b c; do
+		debug "$a $b $c"
+		debug "{{$sq/$main/$sub}}"
+		case "$a" in
+			START) sq="$b" ;;
+			git-subtree-dir:) dir="$b $c" ;;
+			git-subtree-mainline:) main="$b" ;;
+			git-subtree-split:) sub="$b" ;;
+			git-subtree-repo:) repo="$b $c" ;;
+			END)
+				if [ -n "$sub" ]; then
+					if [ -n "$main" ]; then
+						# a rejoin commit?
+						# Pretend its sub was a squash.
+						sq="$sub"
+					fi
+					debug "Subtree found: $dir $repo $sub"
+					echo "$dir" "$repo" "$sub"
+				fi
+				sq=
+				main=
+				sub=
+				;;
+		esac
+	done
+}
+
 find_latest_squash()
 {
 	debug "Looking for latest squash ($dir)..."
@@ -536,6 +575,11 @@ get_repository_url()
 	echo $repo_url
 }
 
+cmd_list()
+{
+	find_subtree_repos "$@"
+}
+
 cmd_add()
 {
 	if [ -e "$dir" ]; then
diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index ed40e73..ce97446 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -196,6 +196,24 @@ test_expect_success 'add --squash stores git-subtree-repo value' '
 '
 
 #
+# Tests for 'git subtree list'
+#
+
+next_test
+test_expect_success 'list outputs list of subtrees' '
+	subtree_test_create_repo "$subtree_test_count" &&
+	subtree_test_create_repo "$subtree_test_count/sub proj" &&
+	test_create_commit "$subtree_test_count" main1 &&
+	test_create_commit "$subtree_test_count/sub proj" sub1 &&
+	(
+		cd "$subtree_test_count" &&
+		git fetch ./"sub proj" master &&
+		git subtree add --prefix="sub dir" "./sub proj" HEAD --squash &&
+		check_equal "$(git subtree list | cut -c -19)" "sub dir ./sub proj "
+	)
+'
+
+#
 # Tests for 'git subtree merge'
 #
 
-- 
2.7.1
