From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH 1/3] t/t5515-fetch-merge-logic.sh: Tests with "." as URL.
Date: Tue, 13 Mar 2007 17:25:53 +0100
Message-ID: <87fy89f6um.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 13 17:26:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HR9pD-000855-4O
	for gcvg-git@gmane.org; Tue, 13 Mar 2007 17:26:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030765AbXCMQZm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 13 Mar 2007 12:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030778AbXCMQZl
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Mar 2007 12:25:41 -0400
Received: from ifae-s0.ifae.es ([192.101.162.68]:37996 "EHLO ifae-s0.ifae.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030765AbXCMQZe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2007 12:25:34 -0400
Received: from bela (caronte.ifae.es [192.101.162.199])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id l2DGPWq15097
	for <git@vger.kernel.org>; Tue, 13 Mar 2007 17:25:32 +0100
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.95 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42130>


Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
---
 t/t5515-fetch-merge-logic.sh                       |   18 ++++++++++--=
------
 t/t5515/fetch.br-unconfig_--tags_.                 |    1 +
 t/t5515/fetch.br-unconfig_.                        |    1 +
 t/t5515/fetch.br-unconfig_._one                    |    1 +
 ...r-unconfig_._one_tag_tag-one_tag_tag-three-file |    1 +
 t/t5515/fetch.br-unconfig_._one_two                |    1 +
 ...-unconfig_._tag_tag-one-tree_tag_tag-three-file |    1 +
 .../fetch.br-unconfig_._tag_tag-one_tag_tag-three  |    1 +
 t/t5515/fetch.master_--tags_.                      |    1 +
 t/t5515/fetch.master_.                             |    1 +
 t/t5515/fetch.master_._one                         |    1 +
 ...tch.master_._one_tag_tag-one_tag_tag-three-file |    1 +
 t/t5515/fetch.master_._one_two                     |    1 +
 ...ch.master_._tag_tag-one-tree_tag_tag-three-file |    1 +
 t/t5515/fetch.master_._tag_tag-one_tag_tag-three   |    1 +
 15 files changed, 24 insertions(+), 8 deletions(-)
 create mode 100644 t/t5515/fetch.br-unconfig_--tags_.
 create mode 100644 t/t5515/fetch.br-unconfig_.
 create mode 100644 t/t5515/fetch.br-unconfig_._one
 create mode 100644 t/t5515/fetch.br-unconfig_._one_tag_tag-one_tag_tag=
-three-file
 create mode 100644 t/t5515/fetch.br-unconfig_._one_two
 create mode 100644 t/t5515/fetch.br-unconfig_._tag_tag-one-tree_tag_ta=
g-three-file
 create mode 100644 t/t5515/fetch.br-unconfig_._tag_tag-one_tag_tag-thr=
ee
 create mode 100644 t/t5515/fetch.master_--tags_.
 create mode 100644 t/t5515/fetch.master_.
 create mode 100644 t/t5515/fetch.master_._one
 create mode 100644 t/t5515/fetch.master_._one_tag_tag-one_tag_tag-thre=
e-file
 create mode 100644 t/t5515/fetch.master_._one_two
 create mode 100644 t/t5515/fetch.master_._tag_tag-one-tree_tag_tag-thr=
ee-file
 create mode 100644 t/t5515/fetch.master_._tag_tag-one_tag_tag-three

diff --git a/t/t5515-fetch-merge-logic.sh b/t/t5515-fetch-merge-logic.s=
h
index 6c9cc67..9759959 100755
--- a/t/t5515-fetch-merge-logic.sh
+++ b/t/t5515-fetch-merge-logic.sh
@@ -113,15 +113,17 @@ done >> tests
 # Merge logic does not depend on branch properties
 # neither in the Pull: or .fetch config
 for branch in master br-unconfig ; do
-    cat <<EOF
-$branch ../.git
-$branch ../.git one
-$branch ../.git one two
-$branch --tags ../.git
-$branch ../.git tag tag-one tag tag-three
-$branch ../.git tag tag-one-tree tag tag-three-file
-$branch ../.git one tag tag-one tag tag-three-file
+    for remote in ../.git . ; do
+	cat <<EOF
+$branch $remote
+$branch $remote one
+$branch $remote one two
+$branch --tags $remote
+$branch $remote tag tag-one tag tag-three
+$branch $remote tag tag-one-tree tag tag-three-file
+$branch $remote one tag tag-one tag tag-three-file
 EOF
+    done
 done >> tests
=20
 while read cmd
diff --git a/t/t5515/fetch.br-unconfig_--tags_. b/t/t5515/fetch.br-unco=
nfig_--tags_.
new file mode 100644
index 0000000..9435770
--- /dev/null
+++ b/t/t5515/fetch.br-unconfig_--tags_.
@@ -0,0 +1 @@
+# br-unconfig --tags .
diff --git a/t/t5515/fetch.br-unconfig_. b/t/t5515/fetch.br-unconfig_.
new file mode 100644
index 0000000..73c937d
--- /dev/null
+++ b/t/t5515/fetch.br-unconfig_.
@@ -0,0 +1 @@
+# br-unconfig .
diff --git a/t/t5515/fetch.br-unconfig_._one b/t/t5515/fetch.br-unconfi=
g_._one
new file mode 100644
index 0000000..2592023
--- /dev/null
+++ b/t/t5515/fetch.br-unconfig_._one
@@ -0,0 +1 @@
+# br-unconfig . one
diff --git a/t/t5515/fetch.br-unconfig_._one_tag_tag-one_tag_tag-three-=
file b/t/t5515/fetch.br-unconfig_._one_tag_tag-one_tag_tag-three-file
new file mode 100644
index 0000000..3ffeb91
--- /dev/null
+++ b/t/t5515/fetch.br-unconfig_._one_tag_tag-one_tag_tag-three-file
@@ -0,0 +1 @@
+# br-unconfig . one tag tag-one tag tag-three-file
diff --git a/t/t5515/fetch.br-unconfig_._one_two b/t/t5515/fetch.br-unc=
onfig_._one_two
new file mode 100644
index 0000000..01e010f
--- /dev/null
+++ b/t/t5515/fetch.br-unconfig_._one_two
@@ -0,0 +1 @@
+# br-unconfig . one two
diff --git a/t/t5515/fetch.br-unconfig_._tag_tag-one-tree_tag_tag-three=
-file b/t/t5515/fetch.br-unconfig_._tag_tag-one-tree_tag_tag-three-file
new file mode 100644
index 0000000..e11b24f
--- /dev/null
+++ b/t/t5515/fetch.br-unconfig_._tag_tag-one-tree_tag_tag-three-file
@@ -0,0 +1 @@
+# br-unconfig . tag tag-one-tree tag tag-three-file
diff --git a/t/t5515/fetch.br-unconfig_._tag_tag-one_tag_tag-three b/t/=
t5515/fetch.br-unconfig_._tag_tag-one_tag_tag-three
new file mode 100644
index 0000000..15f1d89
--- /dev/null
+++ b/t/t5515/fetch.br-unconfig_._tag_tag-one_tag_tag-three
@@ -0,0 +1 @@
+# br-unconfig . tag tag-one tag tag-three
diff --git a/t/t5515/fetch.master_--tags_. b/t/t5515/fetch.master_--tag=
s_.
new file mode 100644
index 0000000..562e00e
--- /dev/null
+++ b/t/t5515/fetch.master_--tags_.
@@ -0,0 +1 @@
+# master --tags .
diff --git a/t/t5515/fetch.master_. b/t/t5515/fetch.master_.
new file mode 100644
index 0000000..ad16cdc
--- /dev/null
+++ b/t/t5515/fetch.master_.
@@ -0,0 +1 @@
+# master .
diff --git a/t/t5515/fetch.master_._one b/t/t5515/fetch.master_._one
new file mode 100644
index 0000000..31f3374
--- /dev/null
+++ b/t/t5515/fetch.master_._one
@@ -0,0 +1 @@
+# master . one
diff --git a/t/t5515/fetch.master_._one_tag_tag-one_tag_tag-three-file =
b/t/t5515/fetch.master_._one_tag_tag-one_tag_tag-three-file
new file mode 100644
index 0000000..1df2089
--- /dev/null
+++ b/t/t5515/fetch.master_._one_tag_tag-one_tag_tag-three-file
@@ -0,0 +1 @@
+# master . one tag tag-one tag tag-three-file
diff --git a/t/t5515/fetch.master_._one_two b/t/t5515/fetch.master_._on=
e_two
new file mode 100644
index 0000000..7713a87
--- /dev/null
+++ b/t/t5515/fetch.master_._one_two
@@ -0,0 +1 @@
+# master . one two
diff --git a/t/t5515/fetch.master_._tag_tag-one-tree_tag_tag-three-file=
 b/t/t5515/fetch.master_._tag_tag-one-tree_tag_tag-three-file
new file mode 100644
index 0000000..564ad9b
--- /dev/null
+++ b/t/t5515/fetch.master_._tag_tag-one-tree_tag_tag-three-file
@@ -0,0 +1 @@
+# master . tag tag-one-tree tag tag-three-file
diff --git a/t/t5515/fetch.master_._tag_tag-one_tag_tag-three b/t/t5515=
/fetch.master_._tag_tag-one_tag_tag-three
new file mode 100644
index 0000000..c127c1c
--- /dev/null
+++ b/t/t5515/fetch.master_._tag_tag-one_tag_tag-three
@@ -0,0 +1 @@
+# master . tag tag-one tag tag-three
--=20
1.5.0.3.1021.g5897
