From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH 3/4] tg-prev/tg-next: --all option
Date: Tue,  5 Oct 2010 00:28:19 +0200
Message-ID: <1286231300-29268-3-git-send-email-bert.wesarg@googlemail.com>
References: <1286231300-29268-1-git-send-email-bert.wesarg@googlemail.com>
 <1286231300-29268-2-git-send-email-bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, pasky@suse.cz,
	martin f krafft <madduck@madduck.net>,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Tue Oct 05 00:28:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2tWP-0000QR-A5
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 00:28:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756117Ab0JDW2c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 18:28:32 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58423 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755921Ab0JDW2b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 18:28:31 -0400
Received: by mail-bw0-f46.google.com with SMTP id 11so4091341bwz.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 15:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=xTh1aE69TvaV41tH6KqczSUU2xL3FZC1BgDGbM9vnQs=;
        b=s1a0yanqTh/UJ38xOwCRgYwpOuSQwpnBJPi6XXAuGfKei7VVrxLUGpsmnEFXRTMd/H
         GeNCtMNEFPN3jBnZHrBkeyNABsP6fkQIYO1BZZV3duwM4yfw6T5jVI5SOnEjqWWmlYNX
         zM/59TH6CKBZToykjrtq2dPROoG89Wqa+YMMw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ZJVWMKyAnj+z1EWfxHhxP74FwpaxCoFlWMR1N+h/pJgroHlh60OXkSHdvozNYEkvgm
         8654B7sd2J/Ltm/6t1pZk9bU7ASnDcz/St86xwdITFQOT6Fvi7tA44xteRPcXUp7n4Wr
         AqnWXGSb7WkJLLEIYfefqfVWrj912rhruVLTE=
Received: by 10.204.81.39 with SMTP id v39mr7627234bkk.149.1286231310276;
        Mon, 04 Oct 2010 15:28:30 -0700 (PDT)
Received: from localhost (p5B0F7A6E.dip.t-dialin.net [91.15.122.110])
        by mx.google.com with ESMTPS id x13sm4250177bki.12.2010.10.04.15.28.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 04 Oct 2010 15:28:29 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.1067.g5aeb7
In-Reply-To: <1286231300-29268-2-git-send-email-bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158132>

This adds an --all option to tg-prev and tg-next, to show all offenders.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>


---

Note the dependency on bw/tred is only historical, it depends only bw/fan-in-out.

 README                     |    2 ++
 contrib/tg-completion.bash |    2 ++
 tg-next.sh                 |   11 ++++++++++-
 tg-prev.sh                 |   11 ++++++++++-
 4 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/README b/README
index 49f7b10..b1dc45a 100644 README
--- a/README
+++ b/README
@@ -573,6 +573,7 @@ tg prev
 	Options:
 	  -i		show dependencies based on index instead of branch
 	  -w		show dependencies based on working tree instead of branch
+	 --all		show not only the direct but all dependencies
 
 tg next
 ~~~~~~~
@@ -582,6 +583,7 @@ tg next
 	Options:
 	  -i		show dependencies based on index instead of branch
 	  -w		show dependencies based on working tree instead of branch
+	 --all		show not only the direct but all dependencies
 
 TODO: tg rename
 
diff --git a/contrib/tg-completion.bash b/contrib/tg-completion.bash
index d319828..d18f564 100755 contrib/tg-completion.bash
--- a/contrib/tg-completion.bash
+++ b/contrib/tg-completion.bash
@@ -475,6 +475,7 @@ _tg_next ()
 	case "$cur" in
 	-*)
 		__tgcomp "
+			--all
 			-i
 			-w
 		"
@@ -491,6 +492,7 @@ _tg_prev ()
 	case "$cur" in
 	-*)
 		__tgcomp "
+			--all
 			-i
 			-w
 		"
diff --git a/tg-next.sh b/tg-next.sh
index 9b352b3..abb9a53 100644 tg-next.sh
--- a/tg-next.sh
+++ b/tg-next.sh
@@ -5,6 +5,7 @@
 # GPLv2
 
 name=
+all=false
 head_deps=
 
 
@@ -17,8 +18,10 @@ while [ -n "$1" ]; do
 		head_deps='(i)';;
 	-w)
 		head_deps='(w)';;
+	--all)
+		all=true;;
 	-*)
-		echo "Usage: tg next [-i | -w] [NAME]" >&2
+		echo "Usage: tg next [--all] [-i | -w] [NAME]" >&2
 		exit 1;;
 	*)
 		[ -z "$name" ] || die "name already specified ($name)"
@@ -29,6 +32,12 @@ done
 head="$(git symbolic-ref HEAD | sed 's#^refs/\(heads\|top-bases\)/##')"
 [ -n "$name" ] || name=$head
 
+if $all; then
+	# ignore first line, which is $name
+	list_fan_in "$name" $head_deps | tail --lines=+2
+	exit $?
+fi
+
 git for-each-ref --format='%(refname)' refs/top-bases |
 	while read ref; do
 		parent="${ref#refs/top-bases/}"
diff --git a/tg-prev.sh b/tg-prev.sh
index efef410..63f71bd 100644 tg-prev.sh
--- a/tg-prev.sh
+++ b/tg-prev.sh
@@ -5,6 +5,7 @@
 # GPLv2
 
 name=
+all=false
 head_deps=
 
 
@@ -17,8 +18,10 @@ while [ -n "$1" ]; do
 		head_deps='(i)';;
 	-w)
 		head_deps='(w)';;
+	--all)
+		all=true;;
 	-*)
-		echo "Usage: tg next [-i | -w] [NAME]" >&2
+		echo "Usage: tg next [--all] [-i | -w] [NAME]" >&2
 		exit 1;;
 	*)
 		[ -z "$name" ] || die "name already specified ($name)"
@@ -31,6 +34,12 @@ head="$(git symbolic-ref HEAD | sed 's#^refs/\(heads\|top-bases\)/##')"
 base_rev="$(git rev-parse --short --verify "refs/top-bases/$name" 2>/dev/null)" ||
 	die "not a TopGit-controlled branch"
 
+if $all; then
+	# ignore first line, which is $name
+	list_fan_out "$name" $head_deps | tail --lines=+2
+	exit $?
+fi
+
 deps_src=$name
 # select .topdeps source for HEAD branch
 [ "x$name" = "x$head" -a -n "$head_deps" ] &&
-- 
tg: (bf1dfaa..) bw/next-prev (depends on: bw/tred bw/next-prev-base)
