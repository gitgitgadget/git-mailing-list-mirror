From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 6/8] gettextize: git-pull "You asked to pull" message
Date: Mon, 13 Sep 2010 19:35:56 +0000
Message-ID: <1284406558-23684-7-git-send-email-avarab@gmail.com>
References: <1284406558-23684-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 13 21:36:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvEpQ-0005HT-5L
	for gcvg-git-2@lo.gmane.org; Mon, 13 Sep 2010 21:36:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755215Ab0IMTgX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Sep 2010 15:36:23 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:52169 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755211Ab0IMTgV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Sep 2010 15:36:21 -0400
Received: by mail-ww0-f44.google.com with SMTP id 20so201266wwd.1
        for <git@vger.kernel.org>; Mon, 13 Sep 2010 12:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=td0eQ2lw+c1RxHNnsXsiBXI946cZXtdjv/HY+ymwvHM=;
        b=u0cJIF/brmFkn7i6zJv6dQ6YqTPaeBvERkqDebNs7kcSFrCrnQhC56ed8xUqGLvRr6
         rOVeQdDHWvTCTwcaQwo6du7q1+JnSnSZOLmJhJZwgIAmxfXXcZkFjJZ8lWuaxiRlPYhy
         2bzdgk/taUqZBP6prF1kId/CT7yBoACeAIa54=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=jazB7pMG8vfq9j0X6oGgD0ra4gxvoZ9gIArrmnq+efhv+BH40UCFalth9h49AgLE7E
         1WlegxEFRg91n/K5MER0KAeYmKknF8W8/qmpY2VDO78cFcfYYzj4cuT+upRwwojUMxzO
         /NVuI49DIa40ygvYYv4Es+3TjBZZoC8a64YnI=
Received: by 10.216.161.71 with SMTP id v49mr4638269wek.94.1284406580356;
        Mon, 13 Sep 2010 12:36:20 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id k7sm4178195wej.2.2010.09.13.12.36.19
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 13 Sep 2010 12:36:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc1.110.g6776a.dirty
In-Reply-To: <1284406558-23684-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156115>

Gettextize the "You asked to pull" error message. This message
interpolated $1 which won't work with eval_gettext for obvious
reasons, so I needed to provide an alias for it.

This also made the message easier to translate, and I added a
TRANSLATORS comment to make it even easier.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-pull.sh |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index bbb2a0a..6ab09b6 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -156,9 +156,12 @@ Generally this means that you provided a wildcard =
refspec which had no
 matches on the remote end."; echo
 		fi
 	elif [ $# -gt 0 ] && [ "$1" !=3D "$remote" ]; then
-		echo "You asked to pull from the remote '$1', but did not specify"
-		echo "a branch. Because this is not the default configured remote"
-		echo "for your current branch, you must specify a branch on the comm=
and line."
+		requested_remote=3D$1
+		# TRANSLATORS: $requested_remote will be a remote name, like
+		# "origin" or "avar"
+		eval_gettext "You asked to pull from the remote '\$requested_remote'=
, but did not specify
+a branch. Because this is not the default configured remote
+for your current branch, you must specify a branch on the command line=
=2E"; echo
 	elif [ -z "$curr_branch" ]; then
 		echo "You are not currently on a branch, so I cannot use any"
 		echo "'branch.<branchname>.merge' in your configuration file."
--=20
1.7.3.rc1.110.g6776a.dirty
