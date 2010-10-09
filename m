From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH 09/11] tg-prev/tg-next: commands to explore dependencies
Date: Sat,  9 Oct 2010 22:57:00 +0200
Message-ID: <320cfcab44939419b5700daa6c356648becc2004.1286657607.git.bert.wesarg@googlemail.com>
References: <e72a55b5f6ca2b805892fd6e214a4f72bf865124.1286657607.git.bert.wesarg@googlemail.com>
 <456834d2977615d5f5c41ca3947fb45cd82bfd87.1286657607.git.bert.wesarg@googlemail.com>
 <6e000c8cf21fac6cd4cf8608c8dc021b039e6f83.1286657607.git.bert.wesarg@googlemail.com>
 <ec70ec8e15013f663bba7f62885abe6881a1512a.1286657607.git.bert.wesarg@googlemail.com>
 <b765e0da80781182bf6c3af8f28d9496ed49cc1b.1286657607.git.bert.wesarg@googlemail.com>
 <62e3424559a93dc0f7c3ed55aafce738f2b0f6d3.1286657607.git.bert.wesarg@googlemail.com>
 <65565f00635372ad3677c0187c33da4d3ceb4b73.1286657607.git.bert.wesarg@googlemail.com>
 <3f39e999ea8aeca5c7125e8981aeffb8cd92d472.1286657607.git.bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, pasky@suse.cz,
	martin f krafft <madduck@madduck.net>,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Sat Oct 09 22:59:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4gVt-0000QH-OQ
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 22:59:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760627Ab0JIU7Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Oct 2010 16:59:24 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:52677 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760619Ab0JIU7X (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Oct 2010 16:59:23 -0400
Received: by mail-ew0-f46.google.com with SMTP id 20so129207ewy.19
        for <git@vger.kernel.org>; Sat, 09 Oct 2010 13:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=Y4YESiW8hnsc1LVYU1zGXEBxavlBE6XOmwrWReAAfOk=;
        b=Z1Vhxt6HiUGRTM2cdP6zMKbUFXCbVZbg5Vt3Xx4YQfhI90PE5wBeRWqVKy8JZCxD14
         PS77UP6dUQo5pfLAyJXGMMBC9diuzVv3zbpYznqVmQ9g2Vcs0MMEoX1146nq6KeVnRH7
         zbS4Liboc2VXh1nxVpKSzCzqUU1iDt5lV3J9A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Iz3spWwXhx9eHQdiS0tGSfynbAlHv4Kqb1LxCxZ5fgck9lZ+KYp76v94sJS3w2d2Vj
         zjAP3oxOraL91zP2kT5viHNBFehkjvVS0HDyNWm9JVvw0j8JC2oQyxCDrScY479JAfdp
         cwXLOHC8dIMQk6IeKvITJVy6/6gxbENo8SiTQ=
Received: by 10.213.26.14 with SMTP id b14mr925210ebc.15.1286657960770;
        Sat, 09 Oct 2010 13:59:20 -0700 (PDT)
Received: from localhost ([46.115.90.142])
        by mx.google.com with ESMTPS id q54sm3991725eeh.0.2010.10.09.13.59.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 09 Oct 2010 13:59:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.1067.g5aeb7
In-Reply-To: <3f39e999ea8aeca5c7125e8981aeffb8cd92d472.1286657607.git.bert.wesarg@googlemail.com>
In-Reply-To: <e72a55b5f6ca2b805892fd6e214a4f72bf865124.1286657607.git.bert.wesarg@googlemail.com>
References: <e72a55b5f6ca2b805892fd6e214a4f72bf865124.1286657607.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158619>

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
index 2a4d165..6cfab6e 100644 .gitignore
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
index c5a8ae0..7760218 100644 README
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
index ddc7655..e34b66f 100755 contrib/tg-completion.bash
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
index 0000000..93dd5b5 tg-next.sh
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
index 0000000..1f1e0c1 tg-prev.sh
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
1.7.1.1067.g5aeb7
