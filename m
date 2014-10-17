From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: [PATCH V2B] core.filemode may need manual action
Date: Fri, 17 Oct 2014 23:40:23 +0200
Message-ID: <54418CC7.80601@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 17 23:40:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XfFGD-0004pb-Kx
	for gcvg-git-2@plane.gmane.org; Fri, 17 Oct 2014 23:40:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbaJQVk2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Oct 2014 17:40:28 -0400
Received: from mout.web.de ([212.227.15.4]:64967 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751262AbaJQVk0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Oct 2014 17:40:26 -0400
Received: from macce.local ([78.72.74.102]) by smtp.web.de (mrweb002) with
 ESMTPSA (Nemesis) id 0MINI7-1XioIJ1yPP-0048Po; Fri, 17 Oct 2014 23:40:24
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
X-Provags-ID: V03:K0:LkiuAiwx4d/qp9Je6nYGFk1YaxQrpkio6a/8w5RYRyB1irK6c16
 LNpmoaDCFyl0UP95oRzB02COWQo7jyKkTkDrdy0iT2MsyLUv7YcznFmlzCdNvfdWhDelYpN
 y9YGhxFgAYFPjxKk4IvPSNlW/M984M3/ghIG24jXECECxX544Dk4DAEl1M2H6V9vzikTveO
 6Xtv0X5C1iV95Qyx31UPA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

core.filemode is set automatically when a repo is created.
But when a repo is exported via CIFS or cygwin is mixed with Git for Wi=
ndows
or Eclipse core.filemode may better be set manually to false.
Update and improve the documentation

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---

Does this makes more sence ?

 Documentation/config.txt | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 04a1e2f..3127e5d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -204,13 +204,26 @@ advice.*::
 --
=20
 core.fileMode::
-	If false, the executable bit differences between the index and
-	the working tree are ignored; useful on broken filesystems like FAT.
+	Tells Git if the executable bit of files in the working tree
+	is to be honored.
++
+	Some filesystems lose the executable bit when a file that is
+	marked as executable is checked out, or checks out an
+	non-executable file with executable bit on.
+	linkgit:git-clone[1] or linkgit:git-init[1] probe the filesystem
+	to see if it handles the executable bit correctly
+	and this variable is automatically set as necessary.
++
+	A repository, however, may be on a filesystem that handles
+	the filemode correctly, and this variable is set to 'true'
+	when created, but later may be made accessible from another
+	environment that loses the filemode (e.g. exporting ext4 via
+	CIFS mount, visiting a Cygwin created repository with
+	Git for Windows or Eclipse).
+	In such a case it may be necessary to set this variable to 'false'.
 	See linkgit:git-update-index[1].
 +
-The default is true, except linkgit:git-clone[1] or linkgit:git-init[1=
]
-will probe and set core.fileMode false if appropriate when the
-repository is created.
+The default is true (when core.filemode is not specified in the config=
 file).
=20
 core.ignorecase::
 	If true, this option enables various workarounds to enable
--=20
2.1.0.rc2.210.g636bceb
