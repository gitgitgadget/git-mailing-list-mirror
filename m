From: Jan Durovec <jan.durovec@gmail.com>
Subject: [PATCH v3 1/2] git-p4: clean-up code style in tests
Date: Tue, 19 Apr 2016 19:49:41 +0000
Message-ID: <01020154301238e9-9d46ac5b-d6e6-4c44-9d2f-7859e0339158-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 21:49:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asbee-0001fW-Tu
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 21:49:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753250AbcDSTto (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 15:49:44 -0400
Received: from a6-243.smtp-out.eu-west-1.amazonses.com ([54.240.6.243]:53736
	"EHLO a6-243.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750859AbcDSTtn (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2016 15:49:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1461095381;
	h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=3mouSS/KoY/ZHOcxtl7/ZoukuDZkxa+T60FMxrbwwMg=;
	b=WdHybeMVoAccqJWR9+ed2YU4DEoFxTsvflG+fNz3DHksw49fWEnHwAgqVshSpPv9
	HCd4f3Xa8Am6twkd83pOMc21heucydjfjc1TjdMLFxthecw9IjjfvToxudigIgnjHIl
	9qREkXGqIRjTwtdCykjZnc/CbED2GUOTkQtAcH/Q=
X-SES-Outgoing: 2016.04.19-54.240.6.243
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291916>

Preliminary clean-up of testing libraries for git-p4.

* spaces added to both sides of () in function definitions in lib-git-p4
* tab indentation added to git-p4 tests when <<- redirection is used

Signed-off-by: Jan Durovec <jan.durovec@gmail.com>
---
 t/lib-git-p4.sh                      | 24 +++++++--------
 t/t9826-git-p4-keep-empty-commits.sh | 60 ++++++++++++++++++------------------
 2 files changed, 42 insertions(+), 42 deletions(-)

diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
index f9ae1d7..0e59fd1 100644
--- a/t/lib-git-p4.sh
+++ b/t/lib-git-p4.sh
@@ -33,7 +33,7 @@ fi
 # Older versions of perforce were available compiled natively for
 # cygwin.  Those do not accept native windows paths, so make sure
 # not to convert for them.
-native_path() {
+native_path () {
 	path="$1" &&
 	if test_have_prereq CYGWIN && ! p4 -V | grep -q CYGWIN
 	then
@@ -49,7 +49,7 @@ native_path() {
 # Attention: This function is not safe again against time offset updates
 # at runtime (e.g. via NTP). The 'clock_gettime(CLOCK_MONOTONIC)'
 # function could fix that but it is not in Python until 3.3.
-time_in_seconds() {
+time_in_seconds () {
 	python -c 'import time; print int(time.time())'
 }
 
@@ -75,7 +75,7 @@ git="$TRASH_DIRECTORY/git"
 pidfile="$TRASH_DIRECTORY/p4d.pid"
 
 # Sometimes "prove" seems to hang on exit because p4d is still running
-cleanup() {
+cleanup () {
 	if test -f "$pidfile"
 	then
 		kill -9 $(cat "$pidfile") 2>/dev/null && exit 255
@@ -89,7 +89,7 @@ trap cleanup EXIT
 TMPDIR="$TRASH_DIRECTORY"
 export TMPDIR
 
-start_p4d() {
+start_p4d () {
 	mkdir -p "$db" "$cli" "$git" &&
 	rm -f "$pidfile" &&
 	(
@@ -151,7 +151,7 @@ start_p4d() {
 	return 0
 }
 
-p4_add_user() {
+p4_add_user () {
 	name=$1 &&
 	p4 user -f -i <<-EOF
 	User: $name
@@ -160,7 +160,7 @@ p4_add_user() {
 	EOF
 }
 
-retry_until_success() {
+retry_until_success () {
 	timeout=$(($(time_in_seconds) + $RETRY_TIMEOUT))
 	until "$@" 2>/dev/null || test $(time_in_seconds) -gt $timeout
 	do
@@ -168,7 +168,7 @@ retry_until_success() {
 	done
 }
 
-retry_until_fail() {
+retry_until_fail () {
 	timeout=$(($(time_in_seconds) + $RETRY_TIMEOUT))
 	until ! "$@" 2>/dev/null || test $(time_in_seconds) -gt $timeout
 	do
@@ -176,7 +176,7 @@ retry_until_fail() {
 	done
 }
 
-kill_p4d() {
+kill_p4d () {
 	pid=$(cat "$pidfile")
 	retry_until_fail kill $pid
 	retry_until_fail kill -9 $pid
@@ -186,13 +186,13 @@ kill_p4d() {
 	retry_until_fail kill -9 $watchdog_pid
 }
 
-cleanup_git() {
+cleanup_git () {
 	retry_until_success rm -r "$git"
 	test_must_fail test -d "$git" &&
 	retry_until_success mkdir "$git"
 }
 
-marshal_dump() {
+marshal_dump () {
 	what=$1 &&
 	line=${2:-1} &&
 	cat >"$TRASH_DIRECTORY/marshal-dump.py" <<-EOF &&
@@ -208,7 +208,7 @@ marshal_dump() {
 #
 # Construct a client with this list of View lines
 #
-client_view() {
+client_view () {
 	(
 		cat <<-EOF &&
 		Client: $P4CLIENT
@@ -222,7 +222,7 @@ client_view() {
 	) | p4 client -i
 }
 
-is_cli_file_writeable() {
+is_cli_file_writeable () {
 	# cygwin version of p4 does not set read-only attr,
 	# will be marked 444 but -w is true
 	file="$1" &&
diff --git a/t/t9826-git-p4-keep-empty-commits.sh b/t/t9826-git-p4-keep-empty-commits.sh
index be12960..fa8b9da 100755
--- a/t/t9826-git-p4-keep-empty-commits.sh
+++ b/t/t9826-git-p4-keep-empty-commits.sh
@@ -47,23 +47,23 @@ test_expect_success 'Clone repo root path with all history' '
 		git init . &&
 		git p4 clone --use-client-spec --destination="$git" //depot@all &&
 		cat >expect <<-\EOF &&
-Remove file 4
-[git-p4: depot-paths = "//depot/": change = 6]
+		Remove file 4
+		[git-p4: depot-paths = "//depot/": change = 6]
 
-Remove file 3
-[git-p4: depot-paths = "//depot/": change = 5]
+		Remove file 3
+		[git-p4: depot-paths = "//depot/": change = 5]
 
-Add file 4
-[git-p4: depot-paths = "//depot/": change = 4]
+		Add file 4
+		[git-p4: depot-paths = "//depot/": change = 4]
 
-Add file 3
-[git-p4: depot-paths = "//depot/": change = 3]
+		Add file 3
+		[git-p4: depot-paths = "//depot/": change = 3]
 
-Add file 2
-[git-p4: depot-paths = "//depot/": change = 2]
+		Add file 2
+		[git-p4: depot-paths = "//depot/": change = 2]
 
-Add file 1
-[git-p4: depot-paths = "//depot/": change = 1]
+		Add file 1
+		[git-p4: depot-paths = "//depot/": change = 1]
 
 		EOF
 		git log --format=%B >actual &&
@@ -80,23 +80,23 @@ test_expect_success 'Clone repo subdir with all history but keep empty commits'
 		git config git-p4.keepEmptyCommits true &&
 		git p4 clone --use-client-spec --destination="$git" //depot@all &&
 		cat >expect <<-\EOF &&
-Remove file 4
-[git-p4: depot-paths = "//depot/": change = 6]
+		Remove file 4
+		[git-p4: depot-paths = "//depot/": change = 6]
 
-Remove file 3
-[git-p4: depot-paths = "//depot/": change = 5]
+		Remove file 3
+		[git-p4: depot-paths = "//depot/": change = 5]
 
-Add file 4
-[git-p4: depot-paths = "//depot/": change = 4]
+		Add file 4
+		[git-p4: depot-paths = "//depot/": change = 4]
 
-Add file 3
-[git-p4: depot-paths = "//depot/": change = 3]
+		Add file 3
+		[git-p4: depot-paths = "//depot/": change = 3]
 
-Add file 2
-[git-p4: depot-paths = "//depot/": change = 2]
+		Add file 2
+		[git-p4: depot-paths = "//depot/": change = 2]
 
-Add file 1
-[git-p4: depot-paths = "//depot/": change = 1]
+		Add file 1
+		[git-p4: depot-paths = "//depot/": change = 1]
 
 		EOF
 		git log --format=%B >actual &&
@@ -112,14 +112,14 @@ test_expect_success 'Clone repo subdir with all history' '
 		git init . &&
 		git p4 clone --use-client-spec --destination="$git" --verbose //depot@all &&
 		cat >expect <<-\EOF &&
-Remove file 3
-[git-p4: depot-paths = "//depot/": change = 5]
+		Remove file 3
+		[git-p4: depot-paths = "//depot/": change = 5]
 
-Add file 3
-[git-p4: depot-paths = "//depot/": change = 3]
+		Add file 3
+		[git-p4: depot-paths = "//depot/": change = 3]
 
-Add file 1
-[git-p4: depot-paths = "//depot/": change = 1]
+		Add file 1
+		[git-p4: depot-paths = "//depot/": change = 1]
 
 		EOF
 		git log --format=%B >actual &&

--
https://github.com/git/git/pull/225
