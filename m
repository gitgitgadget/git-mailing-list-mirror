From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH v3 10/12] tg-prev/tg-next: commands to explore dependencies
Date: Wed, 20 Oct 2010 22:17:55 +0200
Message-ID: <8bd4da13a1c992ece87b4c742d75dad3b6776acf.1287605587.git.bert.wesarg@googlemail.com>
References: <52df5d1de969f474d93c4dce320edc657bb866dc.1287605587.git.bert.wesarg@googlemail.com>
 <38d2d7e3ba54cea256bc111f50bcb8d35e7d520d.1287605587.git.bert.wesarg@googlemail.com>
 <b00fdc4e3060b7cf9f1ed25caff16799df09e414.1287605587.git.bert.wesarg@googlemail.com>
 <d9fc8653e6e4c7eb7197a0fb92cd3b8c6e058187.1287605587.git.bert.wesarg@googlemail.com>
 <d1c407c33f446a6e5c7329ba521871732a136fa6.1287605587.git.bert.wesarg@googlemail.com>
 <e3ce8e49edc363c62c6135ffe94dd1e5990cce6a.1287605587.git.bert.wesarg@googlemail.com>
 <2af535ba26e4879ef1e420900effb95f71a9e531.1287605587.git.bert.wesarg@googlemail.com>
 <3d4e3b72d48a5227fc7a22c0e55581114a75f1b0.1287605587.git.bert.wesarg@googlemail.com>
 <1bf3b3656a23c2de123c749524fcd6df09d9bf87.1287605587.git.bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, pasky@suse.cz,
	martin f krafft <madduck@madduck.net>,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Wed Oct 20 22:19:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8f7p-0005GB-Kt
	for gcvg-git-2@lo.gmane.org; Wed, 20 Oct 2010 22:19:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755619Ab0JTUSd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Oct 2010 16:18:33 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40177 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755604Ab0JTUSa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Oct 2010 16:18:30 -0400
Received: by mail-fx0-f46.google.com with SMTP id 4so3063004fxm.19
        for <git@vger.kernel.org>; Wed, 20 Oct 2010 13:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=cIMwdEIeYupZpzsgu5/m1J13cBl6fKMKIw63a9BHcrg=;
        b=N5nb9P6amsDi3uCQOvRreuJolML311S1+n7rOAiHGQHtA3uMG5mk70kwWvESmyZct0
         fhuFu7qa4fUFVSdSwXFvdJQ+86jfXswiKDbexpuDjuARryGCNbrRuDcVxUO2DENXh5Xb
         CmOLR5lfsynKLu6VoZ0s8K69fP4aTmNK2ZnQ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=gnhWEbvZRiunK7qxIZ7XqPYzfz8IaNIv/5fML/Dt1STvc6VxZNoGTM8BAlbhVJV+/q
         u/tTlDhaezh5Ixfei0/04wecDpmndO1lf7sDEvACc6mwewc/Kuyj3s8rEJFzejes9ERZ
         H+affdFPXE+ATeTqCWmfcjsJvf7nWFdInGaXA=
Received: by 10.103.121.16 with SMTP id y16mr6161544mum.95.1287605910021;
        Wed, 20 Oct 2010 13:18:30 -0700 (PDT)
Received: from localhost (drsd-4db3cc42.pool.mediaWays.net [77.179.204.66])
        by mx.google.com with ESMTPS id p2sm404591fak.46.2010.10.20.13.18.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 Oct 2010 13:18:29 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1.1069.g89486
In-Reply-To: <1bf3b3656a23c2de123c749524fcd6df09d9bf87.1287605587.git.bert.wesarg@googlemail.com>
In-Reply-To: <52df5d1de969f474d93c4dce320edc657bb866dc.1287605587.git.bert.wesarg@googlemail.com>
References: <52df5d1de969f474d93c4dce320edc657bb866dc.1287605587.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159434>

Two new commands to explore the dependencies of TopGit branches:

  a) tg prev [-i | -w] [NAME]
     outputs the dependencies of NAME

  b) tg next [-i | -w] [NAME]
     outputs branches which depends on NAME

Obviously, quilt next was the inspiration.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 .gitignore                 |    4 +++
 README                     |   18 ++++++++++++++++-
 contrib/tg-completion.bash |   34 +++++++++++++++++++++++++++++++++
 tg-next.sh                 |   45 ++++++++++++++++++++++++++++++++++++++++++++
 tg-prev.sh                 |   38 +++++++++++++++++++++++++++++++++++++
 5 files changed, 138 insertions(+), 1 deletions(-)
 create mode 100644 tg-next.sh
 create mode 100644 tg-prev.sh

diff --git a/.gitignore b/.gitignore
index 2a4d165..6cfab6e 100644
--- a/.gitignore
+++ b/.gitignore
@@ -30,10 +30,14 @@
 /tg-info.txt
 /tg-mail
 /tg-mail.txt
+/tg-next
+/tg-next.txt
 /tg-log
 /tg-log.txt
 /tg-patch
 /tg-patch.txt
+/tg-prev
+/tg-prev.txt
 /tg-push
 /tg-push.txt
 /tg-remote
diff --git a/README b/README
index c5a8ae0..7760218 100644
--- a/README
+++ b/README
@@ -541,8 +541,24 @@ tg files
 	  -i		list files based on index instead of branch
 	  -w		list files based on working tree instead of branch
 
-TODO: tg rename
+tg prev
+~~~~~~~
+	Outputs the direct dependencies for the current or named patch.
 
+	Options:
+	  -i		show dependencies based on index instead of branch
+	  -w		show dependencies based on working tree instead of branch
+
+tg next
+~~~~~~~
+	Outputs all patches which directly depend on the current or
+	named patch.
+
+	Options:
+	  -i		show dependencies based on index instead of branch
+	  -w		show dependencies based on working tree instead of branch
+
+TODO: tg rename
 
 IMPLEMENTATION
 --------------
diff --git a/contrib/tg-completion.bash b/contrib/tg-completion.bash
index ddc7655..e34b66f 100755
--- a/contrib/tg-completion.bash
+++ b/contrib/tg-completion.bash
@@ -453,6 +453,38 @@ _tg_update ()
 	esac
 }
 
+_tg_next ()
+{
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+
+	case "$cur" in
+	-*)
+		__tgcomp "
+			-i
+			-w
+		"
+		;;
+	*)
+		__tgcomp "$(__tg_heads)"
+	esac
+}
+
+_tg_prev ()
+{
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+
+	case "$cur" in
+	-*)
+		__tgcomp "
+			-i
+			-w
+		"
+		;;
+	*)
+		__tgcomp "$(__tg_topics)"
+	esac
+}
+
 ### }}}
 ### {{{ tg completion
 
@@ -500,7 +532,9 @@ _tg ()
 	info)        _tg_info ;;
 	log)         _tg_log ;;
 	mail)        _tg_mail ;;
+	next)        _tg_next ;;
 	patch)       _tg_patch ;;
+	prev)        _tg_prev ;;
 	push)        _tg_push ;;
 	remote)      _tg_remote ;;
 	summary)     _tg_summary ;;
diff --git a/tg-next.sh b/tg-next.sh
new file mode 100644
index 0000000..93dd5b5
--- /dev/null
+++ b/tg-next.sh
@@ -0,0 +1,45 @@
+#!/bin/sh
+# TopGit - A different patch queue manager
+# (c) Petr Baudis <pasky@suse.cz>  2008
+# (c) Bert Wesarg <Bert.Wesarg@googlemail.com>  2009
+# GPLv2
+
+name=
+head_from=
+
+
+## Parse options
+
+while [ -n "$1" ]; do
+	arg="$1"; shift
+	case "$arg" in
+	-i|-w)
+		[ -z "$head_from" ] || die "-i and -w are mutually exclusive"
+		head_from="$arg";;
+	-*)
+		echo "Usage: tg next [-i | -w] [NAME]" >&2
+		exit 1;;
+	*)
+		[ -z "$name" ] || die "name already specified ($name)"
+		name="$arg";;
+	esac
+done
+
+head="$(git rev-parse --abbrev-ref=loose HEAD)"
+[ -n "$name" ] ||
+	name="$head"
+
+git for-each-ref --format='%(refname)' refs/top-bases |
+	while read ref; do
+		parent="${ref#refs/top-bases/}"
+
+		from=$head_from
+		# select .topdeps source for HEAD branch
+		[ "x$parent" = "x$head" ] ||
+			from=
+
+		cat_file "$parent:.topdeps" $from | fgrep -qx "$name" ||
+			continue
+
+		echo "$parent"
+	done
diff --git a/tg-prev.sh b/tg-prev.sh
new file mode 100644
index 0000000..1f1e0c1
--- /dev/null
+++ b/tg-prev.sh
@@ -0,0 +1,38 @@
+#!/bin/sh
+# TopGit - A different patch queue manager
+# (c) Petr Baudis <pasky@suse.cz>  2008
+# (c) Bert Wesarg <Bert.Wesarg@googlemail.com>  2009
+# GPLv2
+
+name=
+head_from=
+
+
+## Parse options
+
+while [ -n "$1" ]; do
+	arg="$1"; shift
+	case "$arg" in
+	-i|-w)
+		[ -z "$head_from" ] || die "-i and -w are mutually exclusive"
+		head_from="$arg";;
+	-*)
+		echo "Usage: tg next [-i | -w] [NAME]" >&2
+		exit 1;;
+	*)
+		[ -z "$name" ] || die "name already specified ($name)"
+		name="$arg";;
+	esac
+done
+
+head="$(git rev-parse --abbrev-ref=loose HEAD)"
+[ -n "$name" ] ||
+	name="$head"
+base_rev="$(git rev-parse --short --verify "refs/top-bases/$name" 2>/dev/null)" ||
+	die "not a TopGit-controlled branch"
+
+# select .topdeps source for HEAD branch
+[ "x$name" = "x$head" ] ||
+	head_from=
+
+cat_file "$name:.topdeps" $head_from
-- 
1.7.3.1.1069.g89486
