From: Adam Dinwoodie <adam@dinwoodie.org>
Subject: [PATCH] git-gui: Remove ancient Cygwin compatibility code
Date: Tue, 1 Dec 2015 19:17:43 +0000
Message-ID: <20151201191743.GI14466@dinwoodie.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 01 20:17:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3qQy-0008Cj-3E
	for gcvg-git-2@plane.gmane.org; Tue, 01 Dec 2015 20:17:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756768AbbLATRs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2015 14:17:48 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:34786 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876AbbLATRr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2015 14:17:47 -0500
Received: by wmvv187 with SMTP id v187so222434486wmv.1
        for <git@vger.kernel.org>; Tue, 01 Dec 2015 11:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=yVapSNifcj4fvSEV8Jo6IGPZBEjjq3vHfDYEJySZnxw=;
        b=DVx75cGiyNtQ6nmIx6D1JCTuggGChfpRm8eMS/b+xgRBdx8lL0QdqpphMCwClmwjIB
         Xoox39BPMPwaBWTWCj7Wf4PtJiuVuvRHrL7J0DkhYUh61S0GvSTtD6pUBULfqXXrN8/n
         6vEJCC+OffFaHcOiQDOH4m+Vq1deOtyFZr6m0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-type:content-disposition:user-agent;
        bh=yVapSNifcj4fvSEV8Jo6IGPZBEjjq3vHfDYEJySZnxw=;
        b=XLZVH6KAadjVFesCpATtA1D+F8IuqwCPCfLl+PVEd3gSN+NwE5ijdt5gmheVVVULGP
         K+zvxAEjcLLC1vOdRAFUOdsymZ11jrFVLCcSHKts/Ou7y30QZ5dsYLoA3WCHW33neYKm
         A+7eGANIPy++NrHtMSXVk5IPhMHVlKBeTriCohQPZhmsx6UTDOlIpm6F+Ih7SOkem7sJ
         g0voiUerapoEZ0WysjcxL1ZvlSPo4PTTgp+LpwMNEN68hlwfTgj1Gf7LCs9Po6N+OiXD
         v9v5JJDhbCEBsHrqmc2zlVBAC/PQ1xsqFfXscU/3g8oqKSLD7m+nVxTpbBAn6UhkGp8+
         /p8Q==
X-Gm-Message-State: ALoCoQk0ML2l4Ql0bNrrmOhDEmDnt7QW5G5iSqfXSC9vkjBQoJLsfl1L9SHUAj8S2yHzY4hG50Gw
X-Received: by 10.194.236.6 with SMTP id uq6mr59808439wjc.126.1448997466380;
        Tue, 01 Dec 2015 11:17:46 -0800 (PST)
Received: from dinwoodie.org ([2001:ba8:0:1c0::9:1])
        by smtp.gmail.com with ESMTPSA id gl10sm52803997wjb.30.2015.12.01.11.17.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 01 Dec 2015 11:17:45 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281843>

Remove special path handling for Cygwin in the git-gui Makefile.  This
used to be necessary, but has been being patched out of the official
Cygwin distribution builds since Git v1.7.9, and should really be
patched out of the upstream code rather than being patched every time in
the Cygwin build process.

Signed-off-by: Adam Dinwoodie <adam@dinwoodie.org>
---
I'm the current Cygwin maintainer for Git; this code has been patched
out of the Cygwin Git builds since v1.7.9,* well before I took over.
It's clearly stable and causing no problems, so having it in the
upstream code rather than patching every time seems The Right Thing To
Do.

(* The actual patch used in the Cygwin builds just replaces `ifeq
($(uname_O,Cygwin))` with `ifeq ($(uname_O,noThanks))`, but that's
clearly the appropriate solution for a quick manual patch, not for the
actual upstream code.)

Sending with apologies to Shawn Pearce for the noise; I'd misread the
SubmittingPatches doc and sent to him alone first.

I've based this patch off the git-gui tree rather than the main Git tree
per the SubmittingPatches doc.  Pipe it through `sed
's!Makekfile!git-gui/\0!g'` for a version that applies cleanly to the
main Git source tree.

 Makefile | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/Makefile b/Makefile
index 4f00bdd..e369046 100644
--- a/Makefile
+++ b/Makefile
@@ -136,25 +136,10 @@
 GITGUI_RELATIVE :=
 GITGUI_MACOSXAPP :=
 
-ifeq ($(uname_O),Cygwin)
-	GITGUI_SCRIPT := `cygpath --windows --absolute "$(GITGUI_SCRIPT)"`
-
-	# Is this a Cygwin Tcl/Tk binary?  If so it knows how to do
-	# POSIX path translation just like cygpath does and we must
-	# keep libdir in POSIX format so Cygwin packages of git-gui
-	# work no matter where the user installs them.
-	#
-	ifeq ($(shell echo 'puts [file normalize /]' | '$(TCL_PATH_SQ)'),$(shell cygpath --mixed --absolute /))
-		gg_libdir_sed_in := $(gg_libdir)
-	else
-		gg_libdir_sed_in := $(shell cygpath --windows --absolute "$(gg_libdir)")
-	endif
-else
-	ifeq ($(exedir),$(gg_libdir))
-		GITGUI_RELATIVE := 1
-	endif
-	gg_libdir_sed_in := $(gg_libdir)
-endif
+ifeq ($(exedir),$(gg_libdir))
+	GITGUI_RELATIVE := 1
+endif
+gg_libdir_sed_in := $(gg_libdir)
 ifeq ($(uname_S),Darwin)
 	ifeq ($(shell test -d $(TKFRAMEWORK) && echo y),y)
 		GITGUI_MACOSXAPP := YesPlease
-- 
2.5.3
