From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH/RFC 3/3] t/t5515: fixes for the separate fetch and merge logic
Date: Fri, 16 Feb 2007 09:10:41 +0100
Message-ID: <87r6sqo73y.fsf@gmail.com>
References: <874ppmplw7.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 16 09:11:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHyBG-0002mr-GF
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 09:10:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423422AbXBPIKz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 16 Feb 2007 03:10:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423424AbXBPIKz
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Feb 2007 03:10:55 -0500
Received: from ifae-s0.ifae.es ([192.101.162.68]:47918 "EHLO ifae-s0.ifae.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423422AbXBPIKz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Feb 2007 03:10:55 -0500
Received: from bela (caronte.ifae.es [192.101.162.199])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id l1G8AmB03959
	for <git@vger.kernel.org>; Fri, 16 Feb 2007 09:10:51 +0100
In-Reply-To: <874ppmplw7.fsf@gmail.com> (Santi =?utf-8?Q?B=C3=A9jar's?=
 message of "Fri, 16 Feb
	2007 09:06:00 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.93 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39903>


1) branch.*.merge no longer must exactly match the remote part
   of the branch fetched. Both are expanded in full (as refs/heads/...)
   and matched afterwards.
2) When the remote is specified with $GIT_DIR/branches/... and there is
   a branch.*.merge, the remote branch name must match to get them merg=
ed.
   Before the branch in $GIT_DIR/branches/... was always merged.
   In the documentation the $GIT_DIR/branches/ is documented as a
   short-hand for a corresponding file in $GIT_DIR/remotes/, so I think
   this makes the new behaviour consistent.


Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
---
 t/t5515/fetch.br-branches-default-merge            |    2 +-
 ...etch.br-branches-default-merge_branches-default |    2 +-
 t/t5515/fetch.br-branches-default-octopus          |    2 +-
 ...ch.br-branches-default-octopus_branches-default |    2 +-
 t/t5515/fetch.br-branches-one-merge                |    2 +-
 t/t5515/fetch.br-branches-one-merge_branches-one   |    2 +-
 t/t5515/fetch.br-config-glob-octopus               |    2 +-
 t/t5515/fetch.br-config-glob-octopus_config-glob   |    2 +-
 t/t5515/fetch.br-remote-glob-octopus               |    2 +-
 t/t5515/fetch.br-remote-glob-octopus_remote-glob   |    2 +-
 10 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/t/t5515/fetch.br-branches-default-merge b/t/t5515/fetch.br=
-branches-default-merge
index ca85356..28b85e1 100644
--- a/t/t5515/fetch.br-branches-default-merge
+++ b/t/t5515/fetch.br-branches-default-merge
@@ -1,2 +1,2 @@
 # br-branches-default-merge
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f=09
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge
diff --git a/t/t5515/fetch.br-branches-default-merge_branches-default b=
/t/t5515/fetch.br-branches-default-merge_branches-default
index cb5acac..1d86ad1 100644
--- a/t/t5515/fetch.br-branches-default-merge_branches-default
+++ b/t/t5515/fetch.br-branches-default-merge_branches-default
@@ -1,2 +1,2 @@
 # br-branches-default-merge branches-default
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f=09
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge
diff --git a/t/t5515/fetch.br-branches-default-octopus b/t/t5515/fetch.=
br-branches-default-octopus
index 002b82e..22bed59 100644
--- a/t/t5515/fetch.br-branches-default-octopus
+++ b/t/t5515/fetch.br-branches-default-octopus
@@ -1,2 +1,2 @@
 # br-branches-default-octopus
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f=09
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge
diff --git a/t/t5515/fetch.br-branches-default-octopus_branches-default=
 b/t/t5515/fetch.br-branches-default-octopus_branches-default
index 7443cf7..c584f16 100644
--- a/t/t5515/fetch.br-branches-default-octopus_branches-default
+++ b/t/t5515/fetch.br-branches-default-octopus_branches-default
@@ -1,2 +1,2 @@
 # br-branches-default-octopus branches-default
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f=09
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge
diff --git a/t/t5515/fetch.br-branches-one-merge b/t/t5515/fetch.br-bra=
nches-one-merge
index e594bec..c7f5013 100644
--- a/t/t5515/fetch.br-branches-one-merge
+++ b/t/t5515/fetch.br-branches-one-merge
@@ -1,2 +1,2 @@
 # br-branches-one-merge
-8e32a6d901327a23ef831511badce7bf3bf46689=09
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge
diff --git a/t/t5515/fetch.br-branches-one-merge_branches-one b/t/t5515=
/fetch.br-branches-one-merge_branches-one
index 168031c..1473f5c 100644
--- a/t/t5515/fetch.br-branches-one-merge_branches-one
+++ b/t/t5515/fetch.br-branches-one-merge_branches-one
@@ -1,2 +1,2 @@
 # br-branches-one-merge branches-one
-8e32a6d901327a23ef831511badce7bf3bf46689=09
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge
diff --git a/t/t5515/fetch.br-config-glob-octopus b/t/t5515/fetch.br-co=
nfig-glob-octopus
index da95823..0f324e0 100644
--- a/t/t5515/fetch.br-config-glob-octopus
+++ b/t/t5515/fetch.br-config-glob-octopus
@@ -2,4 +2,4 @@
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge
 8e32a6d901327a23ef831511badce7bf3bf46689=09
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8=09
diff --git a/t/t5515/fetch.br-config-glob-octopus_config-glob b/t/t5515=
/fetch.br-config-glob-octopus_config-glob
index 0e7c769..8151e4c 100644
--- a/t/t5515/fetch.br-config-glob-octopus_config-glob
+++ b/t/t5515/fetch.br-config-glob-octopus_config-glob
@@ -2,4 +2,4 @@
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge
 8e32a6d901327a23ef831511badce7bf3bf46689=09
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8=09
diff --git a/t/t5515/fetch.br-remote-glob-octopus b/t/t5515/fetch.br-re=
mote-glob-octopus
index 92ef25c..4a14384 100644
--- a/t/t5515/fetch.br-remote-glob-octopus
+++ b/t/t5515/fetch.br-remote-glob-octopus
@@ -2,4 +2,4 @@
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge
 8e32a6d901327a23ef831511badce7bf3bf46689=09
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8=09
diff --git a/t/t5515/fetch.br-remote-glob-octopus_remote-glob b/t/t5515=
/fetch.br-remote-glob-octopus_remote-glob
index 6ad3726..7f6f928 100644
--- a/t/t5515/fetch.br-remote-glob-octopus_remote-glob
+++ b/t/t5515/fetch.br-remote-glob-octopus_remote-glob
@@ -2,4 +2,4 @@
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge
 8e32a6d901327a23ef831511badce7bf3bf46689=09
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8=09
--=20
1.5.0.35.gaaba
