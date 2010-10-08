From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH 08/10] tg-prev/tg-next: commands to explore dependencies
Date: Fri,  8 Oct 2010 09:58:06 +0200
Message-ID: <39cbbf4b56e79fe95d603d2f1aa6112c89150bff.1286524446.git.bert.wesarg@googlemail.com>
References: <160b8b0eb6152da98f4fa633ac25c7a25ff32aa4.1286524446.git.bert.wesarg@googlemail.com>
 <0e1f993f68d36f0c3d848c2aa78f46c7130a24f1.1286524446.git.bert.wesarg@googlemail.com>
 <f8601225b41e5f03b50688c0582466879faaff26.1286524446.git.bert.wesarg@googlemail.com>
 <c013d1489409b5d6e76764aba07eca7107715691.1286524446.git.bert.wesarg@googlemail.com>
 <724f5482452ad11bd3fb8560bacb080fa1cef0a4.1286524446.git.bert.wesarg@googlemail.com>
 <66f0cf2d3c7d2778616fa51bd8d81eb04d0528f6.1286524446.git.bert.wesarg@googlemail.com>
 <009a8ed75bd5dcee636e049b11a1bf3ca8ee6fc7.1286524446.git.bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, pasky@suse.cz,
	martin f krafft <madduck@madduck.net>,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Fri Oct 08 09:58:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P47qr-00020q-8r
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 09:58:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755300Ab0JHH6c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Oct 2010 03:58:32 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:47865 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755221Ab0JHH6b (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Oct 2010 03:58:31 -0400
Received: by mail-bw0-f46.google.com with SMTP id 15so77566bwz.19
        for <git@vger.kernel.org>; Fri, 08 Oct 2010 00:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=ezOZ19rZd8QgFp7EnlGR2/a4KpHVjyHmWBeprFv22G8=;
        b=uOe/RXLkcIkcn+ylu1qcv4qkM21kvVXtv6cuUgc2bqhM9zjkVO3JX4wmGEsLVAO6Du
         u+MY5yYmLZfXp/BaAFRUJBGvSAuGlq0tjESc/eAkTsZ5f5pqfZjJ4HlFa8aZAIzPnyW+
         0jqeDlQGT6NBnsq2pPv4nO+ygwE/5s3Z3KMIg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=pqAL91dB03orMzRugs3i2W8Exb347DSb7vk+se04+DOhAxZpFskTyRfom8aBDuO9P9
         OEUhSHkZszHondyzQT19P/EiNgngTGFhF40G7bRIbKyMd9NKCh+Q+/gGpbde1z7k2Ugk
         3B0y1MeUNDWMpml4xsIABgxRrqq7Qx4CMK5j0=
Received: by 10.204.103.207 with SMTP id l15mr1669627bko.196.1286524710390;
        Fri, 08 Oct 2010 00:58:30 -0700 (PDT)
Received: from localhost (p5B0F732C.dip.t-dialin.net [91.15.115.44])
        by mx.google.com with ESMTPS id d27sm2415178bku.22.2010.10.08.00.58.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 08 Oct 2010 00:58:29 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.1067.g5aeb7
In-Reply-To: <009a8ed75bd5dcee636e049b11a1bf3ca8ee6fc7.1286524446.git.bert.wesarg@googlemail.com>
In-Reply-To: <160b8b0eb6152da98f4fa633ac25c7a25ff32aa4.1286524446.git.bert.wesarg@googlemail.com>
References: <160b8b0eb6152da98f4fa633ac25c7a25ff32aa4.1286524446.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158491>

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
index 552a2f1..3b6d0fd 100644 README
--- a/README
+++ b/README
@@ -540,8 +540,24 @@ tg files
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
index eff85ee..e468474 100755 contrib/tg-completion.bash
--- a/contrib/tg-completion.bash
+++ b/contrib/tg-completion.bash
@@ -445,6 +445,38 @@ _tg_update ()
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
 
@@ -492,7 +524,9 @@ _tg ()
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
