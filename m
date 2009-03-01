From: =?utf-8?q?Tor=20Arne=20Vestb=C3=B8?= <torarnv@gmail.com>
Subject: [PATCH 2/2] git-pull: Allow --stat and --no-stat to be used with --rebase
Date: Sun,  1 Mar 2009 22:28:28 +0100
Message-ID: <1235942908-5419-3-git-send-email-torarnv@gmail.com>
References: <1235942908-5419-1-git-send-email-torarnv@gmail.com>
 <1235942908-5419-2-git-send-email-torarnv@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 01 22:27:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdtBm-0004Gx-5Z
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 22:27:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755661AbZCAVZg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Mar 2009 16:25:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755679AbZCAVZe
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 16:25:34 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:28404 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755596AbZCAVZd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2009 16:25:33 -0500
Received: by fg-out-1718.google.com with SMTP id 16so868649fgg.17
        for <git@vger.kernel.org>; Sun, 01 Mar 2009 13:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=Rzh/JpFkAnY8CKHnDGwPtB26P2uHhI2H19rwNXJWFcg=;
        b=i8ILkvS/08sRTDYw02HmVvHgqxidVxlQnuQXfXlTgXbw6HHIeuek0z60zv4RI90IGY
         flZetNG89dPF9fCUHY3Jv7zPGnx7zgA1JhTvfJzJkh8qPstnP3oKZkPKcsW84fqDqMfo
         6+RibxWOAZLakDFp8/9VsIvSct1UNjDbvJgms=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=vLgCpfEJPJNzAutKFWQ8XsIOoZnB+Wk599D8Xd/oEGaoEY2TIsaMOlGpnK1RvvxR0v
         SmYiJn+ene2PQj/b646mqkoEmE3KFC6PKUEOAr5GBJDU2WcT9ItgVKY9vCerhrESwlgY
         0ORJN5rqLXSHSu8KrrOhQsHGgRd7+fux8CDlg=
Received: by 10.86.80.17 with SMTP id d17mr580199fgb.50.1235942730285;
        Sun, 01 Mar 2009 13:25:30 -0800 (PST)
Received: from monstre.mystifistisk.net (212251244070.customer.cdi.no [212.251.244.70])
        by mx.google.com with ESMTPS id d6sm2809307fga.32.2009.03.01.13.25.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 01 Mar 2009 13:25:29 -0800 (PST)
Received: by monstre.mystifistisk.net (Postfix, from userid 1000)
	id 9048F17800B; Sun,  1 Mar 2009 22:28:27 +0100 (CET)
X-Mailer: git-send-email 1.6.2.rc2.11.g80931
In-Reply-To: <1235942908-5419-2-git-send-email-torarnv@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111875>

=46orwards the --stat, --no-stat, and --summary options on to git-rebas=
e.

Signed-off-by: Tor Arne Vestb=C3=B8 <torarnv@gmail.com>
---
 git-pull.sh |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 25adddf..8a26763 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -16,7 +16,7 @@ cd_to_toplevel
 test -z "$(git ls-files -u)" ||
 	die "You are in the middle of a conflicted merge."
=20
-strategy_args=3D no_stat=3D no_commit=3D squash=3D no_ff=3D log_arg=3D=
 verbosity=3D
+strategy_args=3D diffstat=3D no_commit=3D squash=3D no_ff=3D log_arg=3D=
 verbosity=3D
 curr_branch=3D$(git symbolic-ref -q HEAD)
 curr_branch_short=3D$(echo "$curr_branch" | sed "s|refs/heads/||")
 rebase=3D$(git config --bool branch.$curr_branch_short.rebase)
@@ -28,9 +28,9 @@ do
 	-v|--verbose)
 		verbosity=3D"$verbosity -v" ;;
 	-n|--no-stat|--no-summary)
-		no_stat=3D-n ;;
+		diffstat=3D--no-stat ;;
 	--stat|--summary)
-		no_stat=3D$1 ;;
+		diffstat=3D--stat ;;
 	--log|--no-log)
 		log_arg=3D$1 ;;
 	--no-c|--no-co|--no-com|--no-comm|--no-commi|--no-commit)
@@ -188,7 +188,7 @@ fi
=20
 merge_name=3D$(git fmt-merge-msg $log_arg <"$GIT_DIR/FETCH_HEAD") || e=
xit
 test true =3D "$rebase" &&
-	exec git-rebase $strategy_args --onto $merge_head \
+	exec git-rebase $diffstat $strategy_args --onto $merge_head \
 	${oldremoteref:-$merge_head}
-exec git-merge $no_stat $no_commit $squash $no_ff $log_arg $strategy_a=
rgs \
+exec git-merge $diffstat $no_commit $squash $no_ff $log_arg $strategy_=
args \
 	"$merge_name" HEAD $merge_head $verbosity
--=20
1.6.2.rc2.11.g80931
