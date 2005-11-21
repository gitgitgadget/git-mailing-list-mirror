From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Fix git.c compilation target
Date: Mon, 21 Nov 2005 09:10:29 +0100
Message-ID: <81b0412b0511210010m66a3f898q6d108a799de023d9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_12543_30691208.1132560629727"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 21 09:11:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ee6lN-0006BB-Bc
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 09:10:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbVKUIKc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 03:10:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbVKUIKc
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 03:10:32 -0500
Received: from nproxy.gmail.com ([64.233.182.196]:36731 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932217AbVKUIKb (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Nov 2005 03:10:31 -0500
Received: by nproxy.gmail.com with SMTP id n28so63681nfc
        for <git@vger.kernel.org>; Mon, 21 Nov 2005 00:10:29 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=iteVWNM5XmNfvTS82ASEJkGN9rGvul0z6bf8LjZy8HSi9FI+RU+XBvd+9QbZqoRZwOQC6Fpug1zhAyUu/7Yt87l5IcIORze3zkwVe4NG3OB7X1Aa+j8yxUZNdS2Nu9FJn1NfFFmh7SZ3nYzrpTNDNYG495ksR+i+WWc07YOIcck=
Received: by 10.48.163.13 with SMTP id l13mr229599nfe;
        Mon, 21 Nov 2005 00:10:29 -0800 (PST)
Received: by 10.48.248.18 with HTTP; Mon, 21 Nov 2005 00:10:29 -0800 (PST)
To: Andreas Ericsson <exon@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12427>

------=_Part_12543_30691208.1132560629727
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

The target for "git" was missing $(X), strangely essential for some
exotic platform.

Signed-off-by: Alex Riesen <ariesen@harmanbecker.com>

------=_Part_12543_30691208.1132560629727
Content-Type: text/plain; name=0001-fix-compilation-of-git-.exe.txt; 
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="0001-fix-compilation-of-git-.exe.txt"

Subject: [PATCH] fix compilation of git(.exe)
(cherry picked from b0911b2af7c52639a2c6ae8f038ba5753f886a28 commit)

Signed-off-by: Alex Riesen <ariesen@harmanbecker.com>


---

 Makefile |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

applies-to: e12ceef6841365e64bb765294235a67e9263d7de
2323c0467c437c337c0ad59e9660ccea920ff866
diff --git a/Makefile b/Makefile
index 092931a..65b948b 100644
--- a/Makefile
+++ b/Makefile
@@ -342,15 +342,15 @@ SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH)
 export prefix TAR INSTALL DESTDIR SHELL_PATH template_dir
 ### Build rules
 
-all: $(PROGRAMS) $(SCRIPTS) git
+all: $(PROGRAMS) $(SCRIPTS) git$(X)
 
 all:
 	$(MAKE) -C templates
 
 # Only use $(CFLAGS). We don't need anything else.
-git: git.c Makefile
+git$(X): git.c Makefile
 	$(CC) -DGIT_EXEC_PATH='"$(bindir)"' -DGIT_VERSION='"$(GIT_VERSION)"' \
-		$(CFLAGS) $@.c -o $@
+		$(CFLAGS) $< -o $@
 
 $(filter-out git,$(patsubst %.sh,%,$(SCRIPT_SH))) : % : %.sh
 	rm -f $@
---
0.99.9.GIT

------=_Part_12543_30691208.1132560629727--
