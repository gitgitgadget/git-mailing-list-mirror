From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: [PATCH] core.filemode may need manual action
Date: Thu, 16 Oct 2014 21:29:49 +0200
Message-ID: <54401CAD.4090606@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 16 21:30:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeqkN-0001O4-F3
	for gcvg-git-2@plane.gmane.org; Thu, 16 Oct 2014 21:30:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752398AbaJPT37 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Oct 2014 15:29:59 -0400
Received: from mout.web.de ([212.227.15.3]:60580 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751472AbaJPT36 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2014 15:29:58 -0400
Received: from macce.local ([78.72.74.102]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0M0w07-1Y0lmW1KAR-00v7mW; Thu, 16 Oct 2014 21:29:55
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.1.2
X-Provags-ID: V03:K0:lYo322v+JLeHcggivLfFrxmvmxUoBRXSFcMUco7wC2rAY/DFNI7
 pr4RfSPk9WgSjVMTBIZTkQnOAjoPf6ZJ6wjvxY9mwdBox01IO0McsH2aHElNve36FpQ0cxq
 vW5FcM4PMmj4E5hL1i2lvWHEzvay5Ecisj+gICmvlmA5i+mV9ENpQPg9iT/a1aEuL/PJ3IL
 gghXG3tAZerTiIpBmfRXw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

core.filemode is set automatically when a repo is created.
But when a repo is exported via CIFS or cygwin is mixed with Git for Wi=
ndows
core.filemode may better be set manually to false.
Update and improve the documentation.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---

Does this reflect the discussion via email ?
Or is more tweaking needed ?


 Documentation/config.txt | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 4333636..b4fea43 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -204,8 +204,23 @@ advice.*::
 --
=20
 core.fileMode::
-	If false, the executable bit differences between the index and
-	the working tree are ignored; useful on broken filesystems like FAT.
+	Tells Git if the executable bit of files in the working tree
+	is to be honored.
+
+	Some filesystems lose the executable bit when a file that is
+	marked as executable is checked out, or checks out an
+	non-executable file with executable bit on.  "git init" and
+	"git clone" probe the filesystem to see if it records
+	executable bit correctly when they create a new repository
+	and this variable is automatically set as necessary.
+
+	A repository, however, may be on a filesystem that records
+	the filemode correctly, and this variable is set to 'true'
+	when created, but later may be made accessible from another
+	environment that loses the filemode (e.g. exporting ext4 via
+	CIFS mount, visiting a Cygwin managed repository with
+	MsysGit).  In such a case, it may be necessary to set this
+	variable to 'false'.
 	See linkgit:git-update-index[1].
 +
 The default is true, except linkgit:git-clone[1] or linkgit:git-init[1=
]
--=20
2.0.0.GIT
