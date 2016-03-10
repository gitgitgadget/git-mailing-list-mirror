From: Nicola Paolucci <npaolucci@atlassian.com>
Subject: [PATCH v3 1/3] contrib/subtree: 'add' stores 'git-subtree-repo'
Date: Thu, 10 Mar 2016 10:44:10 +0100
Message-ID: <1457603052-53963-2-git-send-email-npaolucci@atlassian.com>
References: <1457603052-53963-1-git-send-email-npaolucci@atlassian.com>
Cc: Dave <davidw@realtimegenomics.com>,
	"David A . Greene" <greened@obbligato.org>,
	Mathias Nyman <mathias.nyman@iki.fi>,
	Nicola Paolucci <npaolucci@atlassian.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 10 10:45:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adx9k-0001oY-PS
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 10:45:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754682AbcCJJpI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2016 04:45:08 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:34756 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754615AbcCJJpD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2016 04:45:03 -0500
Received: by mail-wm0-f47.google.com with SMTP id p65so20713521wmp.1
        for <git@vger.kernel.org>; Thu, 10 Mar 2016 01:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w4XdYAGCW0bX+sd4G8IVR9zYE291we63WXepUDvjYkc=;
        b=wrQnfxT2Ov7UU7X07kB8NIRct+owGzvULm46f0zad9VblVSGNfNmgKB4ejbGvNO/j6
         BLxYLehggPPTOaQXRMicyFykqhpMA1NZYnp4UfVrxoM6Nt9uyPj+varMDPWBkv2jcl7D
         bn8znxF8XsY4EZErBwvSYVLIG89i7lCpRNV1+4Wce3+io8Z3Mr5ABoJVMMhOezintFEM
         Muz2dHoY5tECmTZW+KfHexDp2LcHQ0rtW8zDXexOsJcDenGhT0ueqDElpLurUdjab6wN
         KInbedohK2ErMSsYIgFyX6QZS6dn9e75OO3bW2xUH8NBR4BPQCHq9BawrbKws6ILdw9M
         5uNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=w4XdYAGCW0bX+sd4G8IVR9zYE291we63WXepUDvjYkc=;
        b=S2nsEOpXXe8PNFgbMfuDdndJCSVQrqQ8gnZg2sPNqSZbmFZlEmkZJTo9/jwX2OzcDo
         YTIo0hDSJeRp1u0Lye9bt7N1Bw/JIMzvNuvB5VzRSkztHANaET+JfkyBcJg7rzTDOsKi
         xwFhWegYOBYtXCGod4g4CIEgiOEM+z18DYEHWXygC/qV1WgEznH4wEsAJl6gQLvXZ5q3
         5CqcU2VJcFrD9Z/h3nCaM0UcQI6aAHyiRNjCP1aHP8Xuv5Pmp64UY5UzJ8xhFuSqBOXR
         Pov4FVsueKuuJF6YoO44sc6KFH3TC55gKy+nEPiTW9zguGx4Zda98Ps/bXt2TkJP99ey
         odKQ==
X-Gm-Message-State: AD7BkJLjyDKkxFRwvubnVvuHuUWYEK52SlxsUi+ehQlnaDT53w6XNjbYT46tXllE9haPS2D6
X-Received: by 10.28.158.149 with SMTP id h143mr2603717wme.61.1457603101269;
        Thu, 10 Mar 2016 01:45:01 -0800 (PST)
Received: from reborn.ams.atlassian.com ([46.243.25.78])
        by smtp.gmail.com with ESMTPSA id q139sm2684747wmd.2.2016.03.10.01.45.00
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 10 Mar 2016 01:45:00 -0800 (PST)
X-Mailer: git-send-email 2.7.1
In-Reply-To: <1457603052-53963-1-git-send-email-npaolucci@atlassian.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288607>

Git-subtree operations 'add' and 'pull', when called with the <repository>
parameter will add this to the commit message:
    git-subtree-repo: <repo_url>

Other operations that don't have the <repository> information, like
'merge' or 'add' without <repository> are unchanged. Users with such a
workflow will be on their own with the --message parameter, if they'd
like to record where the subtree came from.

For example:

$ git subtree add --prefix .vim/bundle/fireplace \
    https://repo/user/vim-fireplace.git master --squash

Will result in a commit like:

    commit ce87dab198fecdff6043d88a26c55d7cd95e8bf9
    Author: Bob Marley <bob@mahrley.com>
    Date:   Tue May 12 13:37:03 2015 +0200

    Squashed '.vim/bundle/fireplace/' content from commit b999b09

    git-subtree-dir: .vim/bundle/fireplace
    git-subtree-split: b999b09cd9d69f359fa5668e81b09dcfde455cca
    git-subtree-repo: https://repo/user/vim-fireplace.git

This allows new ways to interact with injected trees, for example
a new command 'git subtree list' becomes possible:

$ git subtree list
.vim/bundle/fireplace https://repo/user/vim-fireplace.git b999b0

Signed-off-by: Mathias Nyman <mathias.nyman@iki.fi>
Signed-off-by: Nicola Paolucci <npaolucci@atlassian.com>
Thanks-to: Aleksi Aalto <aga@iki.fi>
---
 contrib/subtree/git-subtree.sh     | 73 +++++++++++++++++++++++++-------------
 contrib/subtree/t/t7900-subtree.sh | 19 ++++++++++
 2 files changed, 68 insertions(+), 24 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 7a39b30..278699b 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -335,18 +335,21 @@ add_msg()
 	dir="$1"
 	latest_old="$2"
 	latest_new="$3"
+	repo="$4" # optional
 	if [ -n "$message" ]; then
 		commit_message="$message"
 	else
 		commit_message="Add '$dir/' from commit '$latest_new'"
 	fi
-	cat <<-EOF
-		$commit_message
-		
-		git-subtree-dir: $dir
-		git-subtree-mainline: $latest_old
-		git-subtree-split: $latest_new
-	EOF
+	echo $commit_message
+	echo
+	echo git-subtree-dir: $dir
+	echo git-subtree-mainline: $latest_old
+	echo git-subtree-split: $latest_new
+	if [ -n "$repo" ]; then
+		repo_url=$(get_repository_url "$repo")
+		echo "git-subtree-repo: $repo_url"
+	fi
 }
 
 add_squashed_msg()
@@ -382,8 +385,9 @@ squash_msg()
 	dir="$1"
 	oldsub="$2"
 	newsub="$3"
+	repo="$4" # optional
 	newsub_short=$(git rev-parse --short "$newsub")
-	
+
 	if [ -n "$oldsub" ]; then
 		oldsub_short=$(git rev-parse --short "$oldsub")
 		echo "Squashed '$dir/' changes from $oldsub_short..$newsub_short"
@@ -397,6 +401,10 @@ squash_msg()
 	echo
 	echo "git-subtree-dir: $dir"
 	echo "git-subtree-split: $newsub"
+	if [ -n "$repo" ]; then
+		repo_url=$(get_repository_url "$repo")
+		echo "git-subtree-repo: $repo_url"
+	fi
 }
 
 toptree_for_commit()
@@ -440,12 +448,13 @@ new_squash_commit()
 	old="$1"
 	oldsub="$2"
 	newsub="$3"
+	repo="$4" # optional
 	tree=$(toptree_for_commit $newsub) || exit $?
 	if [ -n "$old" ]; then
-		squash_msg "$dir" "$oldsub" "$newsub" | 
+		squash_msg "$dir" "$oldsub" "$newsub" "$repo" |
 			git commit-tree "$tree" -p "$old" || exit $?
 	else
-		squash_msg "$dir" "" "$newsub" |
+		squash_msg "$dir" "" "$newsub" "$repo" |
 			git commit-tree "$tree" || exit $?
 	fi
 }
@@ -517,6 +526,16 @@ ensure_valid_ref_format()
 	    die "'$1' does not look like a ref"
 }
 
+get_repository_url()
+{
+	repo=$1
+	repo_url=$(git config --get remote.$repo.url)
+	if [ -z "$repo_url" ]; then
+		repo_url=$repo
+	fi
+	echo $repo_url
+}
+
 cmd_add()
 {
 	if [ -e "$dir" ]; then
@@ -548,19 +567,18 @@ cmd_add()
 cmd_add_repository()
 {
 	echo "git fetch" "$@"
-	repository=$1
+	repo=$1
 	refspec=$2
 	git fetch "$@" || exit $?
 	revs=FETCH_HEAD
-	set -- $revs
+	set -- $revs $repo
 	cmd_add_commit "$@"
 }
 
 cmd_add_commit()
 {
-	revs=$(git rev-parse $default --revs-only "$@") || exit $?
-	set -- $revs
-	rev="$1"
+	rev=$(git rev-parse $default --revs-only "$1") || exit $?
+	repo="${@:2}" # optional
 	
 	debug "Adding $dir as '$rev'..."
 	git read-tree --prefix="$dir" $rev || exit $?
@@ -575,12 +593,12 @@ cmd_add_commit()
 	fi
 	
 	if [ -n "$squash" ]; then
-		rev=$(new_squash_commit "" "" "$rev") || exit $?
+		rev=$(new_squash_commit "" "" "$rev" "$repo") || exit $?
 		commit=$(add_squashed_msg "$rev" "$dir" |
 			 git commit-tree $tree $headp -p "$rev") || exit $?
 	else
 		revp=$(peel_committish "$rev") &&
-		commit=$(add_msg "$dir" "$headrev" "$rev" |
+		commit=$(add_msg "$dir" "$headrev" "$rev" "$repo" |
 			 git commit-tree $tree $headp -p "$revp") || exit $?
 	fi
 	git reset "$commit" || exit $?
@@ -609,7 +627,8 @@ cmd_split()
 	else
 		unrevs="$(find_existing_splits "$dir" "$revs")"
 	fi
-	
+
+	rev="$1"
 	# We can't restrict rev-list to only $dir here, because some of our
 	# parents have the $dir contents the root, and those won't match.
 	# (and rev-list --follow doesn't seem to solve this)
@@ -683,15 +702,20 @@ cmd_split()
 
 cmd_merge()
 {
-	revs=$(git rev-parse $default --revs-only "$@") || exit $?
+	revs=$(git rev-parse $default --revs-only "$1") || exit $?
 	ensure_clean
-	
 	set -- $revs
 	if [ $# -ne 1 ]; then
 		die "You must provide exactly one revision.  Got: '$revs'"
 	fi
+	do_merge "$@"
+}
+
+do_merge()
+{
 	rev="$1"
-	
+	repo="$2" # optional
+
 	if [ -n "$squash" ]; then
 		first_split="$(find_latest_squash "$dir")"
 		if [ -z "$first_split" ]; then
@@ -704,7 +728,7 @@ cmd_merge()
 			say "Subtree is already at commit $rev."
 			exit 0
 		fi
-		new=$(new_squash_commit "$old" "$sub" "$rev") || exit $?
+		new=$(new_squash_commit "$old" "$sub" "$rev" "$repo") || exit $?
 		debug "New squash commit: $new"
 		rev="$new"
 	fi
@@ -730,12 +754,13 @@ cmd_pull()
 	if [ $# -ne 2 ]; then
 	    die "You must provide <repository> <ref>"
 	fi
+	repo=$1
 	ensure_clean
 	ensure_valid_ref_format "$2"
 	git fetch "$@" || exit $?
 	revs=FETCH_HEAD
-	set -- $revs
-	cmd_merge "$@"
+	set -- $revs $repo
+	do_merge "$@"
 }
 
 cmd_push()
diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index 3bf96a9..ed40e73 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -86,6 +86,11 @@ last_commit_message()
 	git log --pretty=format:%s -1
 }
 
+squashed_commit_body()
+{
+	git log --pretty=format:%b --numstat HEAD^2
+}
+
 subtree_test_count=0
 next_test() {
 	subtree_test_count=$(($subtree_test_count+1))
@@ -176,6 +181,20 @@ test_expect_success 'add subproj as subtree into sub dir/ with --squash and --pr
 	)
 '
 
+next_test
+test_expect_success 'add --squash stores git-subtree-repo value' '
+	subtree_test_create_repo "$subtree_test_count" &&
+	subtree_test_create_repo "$subtree_test_count/sub proj" &&
+	test_create_commit "$subtree_test_count" main1 &&
+	test_create_commit "$subtree_test_count/sub proj" sub1 &&
+	(
+		cd "$subtree_test_count" &&
+		git fetch ./"sub proj" master &&
+		git subtree add --prefix="sub dir" "./sub proj" HEAD --squash &&
+		check_equal "$(squashed_commit_body | grep git-subtree-repo)" "git-subtree-repo: ./sub proj"
+	)
+'
+
 #
 # Tests for 'git subtree merge'
 #
-- 
2.7.1
