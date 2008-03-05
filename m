From: Pekka Kaitaniemi <kaitanie@cc.helsinki.fi>
Subject: [PATCH] gitk: Add horizontal scrollbar to the diff view
Date: Thu, 6 Mar 2008 00:51:23 +0200
Message-ID: <20080305225123.GA8485@localdomain>
Reply-To: kaitanie@cc.helsinki.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: paulus@samba.org, newsletter@dirk.my1.cc
X-From: git-owner@vger.kernel.org Wed Mar 05 23:52:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX2Tn-0006OR-D6
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 23:52:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763650AbYCEWvp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 17:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763260AbYCEWvp
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 17:51:45 -0500
Received: from fk-out-0910.google.com ([209.85.128.190]:63721 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762880AbYCEWvo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 17:51:44 -0500
Received: by fk-out-0910.google.com with SMTP id z23so1720717fkz.5
        for <git@vger.kernel.org>; Wed, 05 Mar 2008 14:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:reply-to:mime-version:content-type:content-disposition:user-agent:sender;
        bh=hVT8EIfikdMq9JVTCbAR57sv0zYVErWOVoSLAyTpPhI=;
        b=amgM75+VLWtp7BKKnpLOzzEwoFuajAWwnTKXUOcIyC9rl8Y/WLWCStANyZt1z6UsgSEaqKOQ/07Qd/7wEhc435D1OISbsNHMZ7ZcOiG8L0uWK+OIlVv9AGcLXPCj7M65auCsmSr9bH4hT22DT1hyC7KzZ8vOiEf2+UJok6K/W/A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:reply-to:mime-version:content-type:content-disposition:user-agent:sender;
        b=VG/97E4+5s6V8v+lJ0YxQGWdJlfs2L37770R3ubLS4tObjvHLSt26Q+vHROCU8t8y0/tPsOzCnVviVAzGeds19F+CUhjLsnVHQjXFi8JxE49UZe6P8m6C5BdnoqZ5Tr0sy5CK8CtZyhyDVkMndCwaqw/umwO6MyZhzp6iwWHJp0=
Received: by 10.82.115.8 with SMTP id n8mr2845056buc.28.1204757500827;
        Wed, 05 Mar 2008 14:51:40 -0800 (PST)
Received: from shadow ( [217.30.191.90])
        by mx.google.com with ESMTPS id c24sm2896127ika.10.2008.03.05.14.51.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 05 Mar 2008 14:51:39 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76284>

Adding horizontal scroll bar makes the scrolling feature more
discoverable to the users.

Signed-off-by: Pekka Kaitaniemi <kaitanie@cc.helsinki.fi>
---
Here is a patch that adds horizontal scroll bar to the gitk diff
pane. It makes the scrolling feature a bit more discoverable and
accessible. The only downside is that it uses some screen real estate.

 gitk |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/gitk b/gitk
index f1f21e9..817e0ce 100755
--- a/gitk
+++ b/gitk
@@ -857,14 +857,17 @@ proc makewindow {} {
     set ctext .bleft.ctext
     text $ctext -background $bgcolor -foreground $fgcolor \
 	-state disabled -font textfont \
-	-yscrollcommand scrolltext -wrap none
+	-yscrollcommand scrolltext  -wrap none \
+	-xscrollcommand ".bleft.sbhorizontal set"
     if {$have_tk85} {
 	$ctext conf -tabstyle wordprocessor
     }
     scrollbar .bleft.sb -command "$ctext yview"
+    scrollbar .bleft.sbhorizontal -command "$ctext xview" -orient h
     pack .bleft.top -side top -fill x
     pack .bleft.mid -side top -fill x
     pack .bleft.sb -side right -fill y
+    pack .bleft.sbhorizontal -side bottom -fill x -in .bleft
     pack $ctext -side left -fill both -expand 1
     lappend bglist $ctext
     lappend fglist $ctext
-- 
1.5.4.3

