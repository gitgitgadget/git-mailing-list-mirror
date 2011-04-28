From: Kacper Kornet <kornet@camk.edu.pl>
Subject: [PATCH] Honor sysconfdir when set as an configure option
Date: Thu, 28 Apr 2011 22:01:13 +0200
Message-ID: <20110428200113.GF4833@camk.edu.pl>
References: <20110428022922.GC4833@camk.edu.pl>
 <7v62py5nbp.fsf@alter.siamese.dyndns.org>
 <20110428192751.GE4833@camk.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 22:01:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFXOw-0004YJ-RO
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 22:01:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933423Ab1D1UBV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 16:01:21 -0400
Received: from moat.camk.edu.pl ([148.81.175.50]:36151 "EHLO moat.camk.edu.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933419Ab1D1UBV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 16:01:21 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by moat.camk.edu.pl (Postfix) with ESMTP id 2F4AD5F0047;
	Thu, 28 Apr 2011 22:01:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at camk.edu.pl
Received: from moat.camk.edu.pl ([127.0.0.1])
	by localhost (liam.camk.edu.pl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id WxEw2SyWR5-H; Thu, 28 Apr 2011 22:01:13 +0200 (CEST)
Received: from gatekeeper.camk.edu.pl (gatekeeper.camk.edu.pl [192.168.1.23])
	by moat.camk.edu.pl (Postfix) with ESMTP id E56B65F0046;
	Thu, 28 Apr 2011 22:01:13 +0200 (CEST)
Received: by gatekeeper.camk.edu.pl (Postfix, from userid 1293)
	id D9862808C3; Thu, 28 Apr 2011 22:01:13 +0200 (CEST)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20110428192751.GE4833@camk.edu.pl>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172399>

./configure can be run with option --sysconfdir=...
and Makefile should respect that choice.

Signed-off-by: Kacper Kornet <draenog@pld-linux.org>
---
 Makefile      |    8 ++++----
 config.mak.in |    2 ++
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index bf912b9..9d6cffa 100644
--- a/Makefile
+++ b/Makefile
@@ -1186,11 +1186,11 @@ endif
 -include config.mak
 
 ifeq ($(prefix),/usr)
-sysconfdir = /etc
-git_etcdir = /etc
+sysconfdir ?= /etc
+git_etcdir ?= /etc
 else
-sysconfdir = $(prefix)/etc
-git_etcdir = etc
+sysconfdir ?= $(prefix)/etc
+git_etcdir ?= etc
 endif
 
 ifdef CHECK_HEADER_DEPENDENCIES
diff --git a/config.mak.in b/config.mak.in
index e378534..ac5912d 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -15,6 +15,8 @@ TCLTK_PATH = @TCLTK_PATH@
 prefix = @prefix@
 exec_prefix = @exec_prefix@
 bindir = @bindir@
+sysconfdir = @sysconfdir@
+git_etcdir = @sysconfdir@
 gitexecdir = @libexecdir@/git-core
 datarootdir = @datarootdir@
 template_dir = @datadir@/git-core/templates
-- 
1.7.5

-- 
  Kacper Kornet
