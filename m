From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] rebase -i -p: document shortcomings
Date: Mon, 31 May 2010 20:43:35 -0500
Message-ID: <20100601014335.GA21970@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Thomas Rast <trast@student.ethz.ch>,
	Florian Weimer <fw@deneb.enyo.de>,
	Greg Price <price@ksplice.com>,
	=?iso-8859-1?Q?J=F6rg?= Sommer <joerg@alea.gnuu.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 01 03:44:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJGWd-0003sE-TB
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 03:44:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752173Ab0FABno convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 May 2010 21:43:44 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:42752 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752110Ab0FABno (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 May 2010 21:43:44 -0400
Received: by gye5 with SMTP id 5so729196gye.19
        for <git@vger.kernel.org>; Mon, 31 May 2010 18:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition
         :content-transfer-encoding:user-agent;
        bh=xDUwzM6DKOW1zkgN01jWdkhN25rCSTs1FrfEAy4LxL8=;
        b=IcB9scvlLattJ/ySPfI1Zgv11oGNDUcWoqDSRVVlffxHwyqTauAt/Zd1ZR/FdiVpB0
         e7vh7jUHJK8cGcGHcpaXh+yTIUHjsNULqZ+/X712pnNMiFjn/1GDylbiVdz9ei1vY6Ry
         myTRtAAkQunM4y08ww5YWb49GxPMYPsVx4yvk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=Ksnhhb1TnwnvX8UdJ5AoKCoj+zrKqnwARzQ+xAeaxuCOuArybAGP8QjXVDvol5j40t
         St6CxCUch/4Uz/NJIF3ywyHU/YvtpZgeWKEl9a6aGv9bIBm/cA4ciYfMPMRN5UwbnQaT
         48UOasZ8hNkbsa75EhRLpSCVFmfXALVzr0REI=
Received: by 10.231.150.18 with SMTP id w18mr6796838ibv.43.1275356622849;
        Mon, 31 May 2010 18:43:42 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id d9sm28915486ibl.16.2010.05.31.18.43.41
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 31 May 2010 18:43:41 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148059>

The rebase --preserve-merges facility presents a list of commits
in its instruction sheet and uses a separate table to keep
track of their parents.  Unfortunately, in practice this means
that with -p after most attempts to rearrange patches, some
commits have the "wrong" parent and the resulting history is
rarely what the caller expected.

Yes, it would be nice to fix that.  But first, add a warning to the
manual to help the uninitiated understand what is going on.

Reported-by: Ji=C5=99=C3=AD Pale=C4=8Dek <jpalecek@web.de>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Pointers towards a real fix:

 . http://thread.gmane.org/gmane.comp.version-control.git/79424/focus=3D=
79504
 . http://thread.gmane.org/gmane.comp.version-control.git/77965/focus=3D=
80835
 . http://thread.gmane.org/gmane.comp.version-control.git/131921/focus=3D=
132679
 . http://repo.or.cz/w/git/price.git
 . http://repo.or.cz/w/git/dscho.git/shortlog/refs/heads/rebase-i-p

Thanks to all who have worked on this before.

Thoughts?

 Documentation/git-rebase.txt  |   26 ++++++++++++++++++++++++++
 t/t3404-rebase-interactive.sh |    6 ++++++
 2 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.tx=
t
index 5863dec..330e9ea 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -306,6 +306,11 @@ link:howto/revert-a-faulty-merge.txt[revert-a-faul=
ty-merge How-To] for details).
 -p::
 --preserve-merges::
 	Instead of ignoring merges, try to recreate them.
++
+This uses the `--interactive` machinery internally, but combining it
+with the `--interactive` option explicitly is generally not a good
+idea (see BUGS below).
+
=20
 --root::
 	Rebase all commits reachable from <branch>, instead of
@@ -607,6 +612,27 @@ The ripple effect of a "hard case" recovery is esp=
ecially bad:
 case" recovery too!
=20
=20
+BUGS
+----
+The instruction sheet presented by `--preserve-merges --interactive`
+does not represent the topology of the revision graph.  Attempts to
+reorder it tend to produce counterintuitive results.
+
+For example, an attempt to rearrange
+------------
+1 --- 2 --- 3 --- 4 --- 5
+------------
+to
+------------
+1 --- 2 --- 4 --- 3 --- 5
+------------
+by moving the "pick 4" line will result in the following history:
+------------
+        3
+       /
+1 --- 2 --- 4 --- 5
+------------
+
 Authors
 ------
 Written by Junio C Hamano <gitster@pobox.com> and
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive=
=2Esh
index f20ea38..6668907 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -181,6 +181,12 @@ test_expect_success '-p handles "no changes" grace=
fully' '
 	test $HEAD =3D $(git rev-parse HEAD)
 '
=20
+test_expect_failure 'exchange two commits with -p' '
+	FAKE_LINES=3D"2 1" git rebase -i -p HEAD~2 &&
+	test H =3D $(git cat-file commit HEAD^ | sed -ne \$p) &&
+	test G =3D $(git cat-file commit HEAD | sed -ne \$p)
+'
+
 test_expect_success 'preserve merges with -p' '
 	git checkout -b to-be-preserved master^ &&
 	: > unrelated-file &&
--=20
1.7.1
