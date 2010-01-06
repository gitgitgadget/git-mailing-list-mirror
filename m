From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH git-gui 5/5] git-gui/Makefile: consolidate .FORCE-* targets
Date: Wed, 6 Jan 2010 02:16:38 -0600
Message-ID: <20100106081638.GF7298@progeny.tock>
References: <20091128112546.GA10059@progeny.tock>
 <20091128113709.GD10059@progeny.tock>
 <20100106080216.GA7298@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jan 06 09:16:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSR4U-0005KD-Mo
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 09:16:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754009Ab0AFIQj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2010 03:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753188Ab0AFIQi
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 03:16:38 -0500
Received: from mail-yx0-f188.google.com ([209.85.210.188]:50387 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752500Ab0AFIQi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2010 03:16:38 -0500
Received: by yxe26 with SMTP id 26so16461752yxe.4
        for <git@vger.kernel.org>; Wed, 06 Jan 2010 00:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=v90/IXh2ZDqGfwnOjNRuvSp2d7WSW7SZ156SzMxWF3w=;
        b=FGIG2AipHvyvMoYS4WYGRXngAy7jxXK1iMIfZlqmDkDXoHOBHB8NrxY8vSSp/UHsDV
         3g5w8i8DNuNgHCxvXIThd+z4u/D8ad+p+CHTt+j2qA8n0Ncd0i1DR0AHYzJezMMHbCUb
         fVxtONo5r7iRRZAe4zIQP28Nr7lo2GZ14m3J4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=TlgeAA7w2o1/nYxErdfnatRa42heHvDxGqFBtFQOJyPgRT3g3g8kgw38vX/dou5MgR
         c+y/mwxR8Vl8nz4jDdEmwTJ/vpOrVxWh7NlNPW81+IHuHbfqueVN8Bj8KYSfWZc72vIJ
         DzarQXmrit381zkbh/WW5w2yiEjBleJUOGo5I=
Received: by 10.100.245.5 with SMTP id s5mr39972506anh.86.1262765796361;
        Wed, 06 Jan 2010 00:16:36 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm19255095iwn.3.2010.01.06.00.16.35
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 06 Jan 2010 00:16:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100106080216.GA7298@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136249>

Providing multiple targets to force a rebuild is unnecessary
complication.

Avoid using a name that could conflict with future special
targets in GNU make (a leading period followed by uppercase
letters).

Cc: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
This is my first git-gui patch, so it is likely I have missed some
conventions.  If that is the case, please let me know.

Thanks,
Jonathn

 Makefile |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index b3580e9..197b55e 100644
--- a/Makefile
+++ b/Makefile
@@ -7,7 +7,7 @@ all::
 # TCL_PATH must be vaild for this to work.
 #
 
-GIT-VERSION-FILE: .FORCE-GIT-VERSION-FILE
+GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
 -include GIT-VERSION-FILE
 
@@ -270,7 +270,7 @@ TRACK_VARS = \
 	GITGUI_MACOSXAPP=$(GITGUI_MACOSXAPP) \
 #end TRACK_VARS
 
-GIT-GUI-VARS: .FORCE-GIT-GUI-VARS
+GIT-GUI-VARS: FORCE
 	@VARS='$(TRACK_VARS)'; \
 	if test x"$$VARS" != x"`cat $@ 2>/dev/null`" ; then \
 		echo 1>&2 "    * new locations or Tcl/Tk interpreter"; \
@@ -340,5 +340,4 @@ ifdef GITGUI_WINDOWS_WRAPPER
 endif
 
 .PHONY: all install uninstall dist-version clean
-.PHONY: .FORCE-GIT-VERSION-FILE
-.PHONY: .FORCE-GIT-GUI-VARS
+.PHONY: FORCE
-- 
1.6.6.rc2
