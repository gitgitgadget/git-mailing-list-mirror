From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Fix git.c compilation target
Date: Mon, 21 Nov 2005 10:24:17 +0100
Message-ID: <81b0412b0511210124u5cc0d4efv2045123d92872c66@mail.gmail.com>
References: <81b0412b0511210010m66a3f898q6d108a799de023d9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_13008_25905472.1132565057233"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 21 10:24:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ee7uQ-00040o-Nr
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 10:24:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbVKUJYT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 04:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbVKUJYT
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 04:24:19 -0500
Received: from nproxy.gmail.com ([64.233.182.196]:15704 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932213AbVKUJYS (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Nov 2005 04:24:18 -0500
Received: by nproxy.gmail.com with SMTP id x4so75115nfb
        for <git@vger.kernel.org>; Mon, 21 Nov 2005 01:24:17 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=XGW4iC19YEz2KKOth/wNH2WhSLiUPT+MGh5g+boSOEkLEy78mdy/7i3tV6NoIlZ0joZugSt+8jKvsCh7j/Blh3TLkeN7QYPPA9oof0VSp0HTAmXx3F38OjrOqMnTF16CqEGC/O5m9a8Q2joB4q1++oB2m9RJ2RgYamJk5fw8vnw=
Received: by 10.48.239.10 with SMTP id m10mr235702nfh;
        Mon, 21 Nov 2005 01:24:17 -0800 (PST)
Received: by 10.48.248.18 with HTTP; Mon, 21 Nov 2005 01:24:17 -0800 (PST)
To: Andreas Ericsson <exon@op5.se>
In-Reply-To: <81b0412b0511210010m66a3f898q6d108a799de023d9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12432>

------=_Part_13008_25905472.1132565057233
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

There was more to it.
The patch removes a reference to git.sh from Makefile and installs
_all_ programs and scripts.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>

------=_Part_13008_25905472.1132565057233
Content-Type: text/plain; 
	name=0002-forget-git.sh-and-install-all-programs-and-scripts.txt; 
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="0002-forget-git.sh-and-install-all-programs-and-scripts.txt"

Subject: [PATCH] forget git.sh and install all programs and scripts

Signed-off-by: Alex Riesen <ariesen@harmanbecker.com>


---

 Makefile |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

applies-to: 0d9013b9e1804aa68afbc6328d9cf93f36a6bebe
c32490dd373e0fb8b963aa0d2aa31f8a209e09b1
diff --git a/Makefile b/Makefile
index 65b948b..f6f4b87 100644
--- a/Makefile
+++ b/Makefile
@@ -352,7 +352,7 @@ git$(X): git.c Makefile
 	$(CC) -DGIT_EXEC_PATH='"$(bindir)"' -DGIT_VERSION='"$(GIT_VERSION)"' \
 		$(CFLAGS) $< -o $@
 
-$(filter-out git,$(patsubst %.sh,%,$(SCRIPT_SH))) : % : %.sh
+$(patsubst %.sh,%,$(SCRIPT_SH)) : % : %.sh
 	rm -f $@
 	sed -e '1s|#!.*/sh|#!$(call shq,$(SHELL_PATH))|' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
@@ -436,9 +436,9 @@ check:
 
 ### Installation rules
 
-install: $(PROGRAMS) $(SCRIPTS) git
+install: $(PROGRAMS) $(SCRIPTS) git$(X)
 	$(INSTALL) -d -m755 $(call shellquote,$(DESTDIR)$(bindir))
-	$(INSTALL) git $(PROGRAMS) $(SCRIPTS) $(call shellquote,$(DESTDIR)$(bindir))
+	$(INSTALL) $+ $(call shellquote,$(DESTDIR)$(bindir))
 	$(MAKE) -C templates install
 	$(INSTALL) -d -m755 $(call shellquote,$(DESTDIR)$(GIT_PYTHON_DIR))
 	$(INSTALL) $(PYMODULES) $(call shellquote,$(DESTDIR)$(GIT_PYTHON_DIR))
---
0.99.9.GIT

------=_Part_13008_25905472.1132565057233--
