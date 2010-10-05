From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [RFC PATCH] git.txt: document limitations on non-typical repos (and hints)
Date: Tue,  5 Oct 2010 20:00:53 +0700
Message-ID: <1286283653-22616-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: weigelt@metux.de, spearce@spearce.org, jrnieder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr, raa.lkml@gmail.com,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 05 15:01:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P378p-0005Zp-4n
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 15:01:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752206Ab0JENBF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Oct 2010 09:01:05 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:52422 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751687Ab0JENBE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Oct 2010 09:01:04 -0400
Received: by pzk34 with SMTP id 34so1616451pzk.19
        for <git@vger.kernel.org>; Tue, 05 Oct 2010 06:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=WpyJvk2Tovi//gajwcnLeLoTVdHWRGK6Pok121vo3cY=;
        b=d+ozc1bUFJWZt6ezAiyEvRHjNWmFv1nCBEWT2tbFOVVPNa1+s8D7qpLyDB0h7o0OH9
         LUvUeGI8SqPZOxYKyeWzoqGL5VN6bOk9yO6VT5ydklSiDlL72k+YftYhWfQOgFDpn+70
         RuOc71cy0pEo/Vyxw6PBGduDr3v6QgYfWyvWY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=qH0KB1zGHklymYB+bpR1HL1Zw7Du7ebrwxXMNGLpS5cwHDG+QHOJ0bAoerA/lLTp5K
         iZUNa34sVZMXCkkkTw368qkqrYdKJ6IDmzq835xtCDCRU5OEUGjy5LZ8nIdiBxRmhZN6
         NAHiDafXIJoRqgHDcukEdgRnUWl7g9VSyUVds=
Received: by 10.114.88.17 with SMTP id l17mr13627784wab.145.1286283662954;
        Tue, 05 Oct 2010 06:01:02 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.224.73])
        by mx.google.com with ESMTPS id c10sm11381145wam.1.2010.10.05.06.00.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 05 Oct 2010 06:01:01 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue,  5 Oct 2010 20:00:54 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158195>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 I wanted to make a more detailed description, per command. It would
 serve as guidance for people on special repos, also as TODOs for Git
 developers. But that seems a lot of work on analyzing each commands.

 Instead I made this text to warn users where performance may decrease,
 and to hint them features that might help. Do I miss anything?

 There were discussions in the past on maintaining large files out-of-r=
epo,
 and symlinks to them in-repo. That sounds like a good advice, doesn't =
it?

 Documentation/git.txt |   46 +++++++++++++++++++++++++++++++++++++++++=
+++++
 1 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index dd57bdc..8408923 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -729,6 +729,52 @@ The index is also capable of storing multiple entr=
ies (called "stages")
 for a given pathname.  These stages are used to hold the various
 unmerged version of a file when a merge is in progress.
=20
+Performance concerns
+--------------------
+
+Git is written with performance in mind and it works extremely well
+with its typical repositories (i.e. source code repositories, with
+a moderate number of small text files, possibly with long history).
+Non-typical repositories (huge number of files, or very large
+files...) may experience performance degradation. This section describ=
es
+how Git behaves in such repositories and how to reduce impact.
+
+For repositories with really long history, you may want to work on
+a shallow clone of it (see linkgit:git-clone[1], option '--depth').
+A shallow repository does not contain full history, so it may consume
+less disk space and network bandwidth. On the other hand, you cannot
+fetch from it. And obviously you cannot look further back than what
+it has in history (you can deepen history though).
+
+For repositories with a large number of files, but you only need
+a few of them present in working tree, you can use sparse checkout
+(see linkgit:git-read-tree[1], section 'Sparse checkout'). Sparse
+checkout can be used with either a normal repository, or a shallow
+one.
+
+Git uses lstat(3) to detect changes in working tree. A huge number
+of lstat(3) calls may impact performance, especially on systems with
+slow lstat(3). In some cases you can reduce the number of lstat(3)
+calls by specifying what directories you are interested in, so no
+lstat(3) outside is needed.
+
+For repositories with a large number of files, you need all of them
+present in working tree, but you know in advance only a few of them
+may be modified, please consider using assume-unchanged bit (see
+linkgit:git-update-index[1]). This helps reduce the number of lstat(3)
+calls.
+
+Some Git commands need entire file content in memory to process.
+You may want to avoid using them if possible on large files. Those
+commands include:
+
+* All checkout commands (linkgit:git-checkout[1],
+  linkgit:git-checkout-index[1], linkgit:git-read-tree[1],
+  linkgit:git-clone[1]...)
+* All diff-related commands (linkgit:git-diff[1],
+  linkgit:git-log[1] with diff, linkgit:git-show[1] on commits...)
+* All commands that need file conversion processing
+
 Authors
 -------
 * git's founding father is Linus Torvalds <torvalds@osdl.org>.
--=20
1.7.0.2.445.gcbdb3
