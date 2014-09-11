From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH] pre-push.sample: Write error message to stderr
Date: Thu, 11 Sep 2014 13:35:30 -0700
Message-ID: <48e0d9c541a5aad9644a0d1ec67b67de454cde5b.1410467299.git.wking@tremily.us>
Cc: Thorsten Glaser <t.glaser@tarent.de>,
	Wieland Hoffmann <themineo@gmail.com>,
	Aaron Schrab <aaron@schrab.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 11 22:42:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSBBw-0000gK-E1
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 22:42:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757320AbaIKUmD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2014 16:42:03 -0400
Received: from resqmta-po-06v.sys.comcast.net ([96.114.154.165]:58786 "EHLO
	resqmta-po-06v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754362AbaIKUmB (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Sep 2014 16:42:01 -0400
X-Greylist: delayed 365 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Sep 2014 16:42:01 EDT
Received: from omta13.emeryville.ca.mail.comcast.net ([76.96.30.52])
	by resqmta-po-06v.sys.comcast.net with comcast
	id pw3U1o00617UAYk01wba1c; Thu, 11 Sep 2014 20:35:34 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta13.emeryville.ca.mail.comcast.net with comcast
	id pwbY1o00U152l3L8ZwbZGX; Thu, 11 Sep 2014 20:35:33 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id 684C41392F8A; Thu, 11 Sep 2014 13:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1410467732; bh=OvNUOahL5DaZUd5ylQVsxTEuE9+sY9jOrYnHfaluxy0=;
	h=From:To:Cc:Subject:Date;
	b=aKWV2cydb/k5v3CR+xX0jmO/lyAH0AbLSUEDyAE/an4+nmCLdrZs0/b+gOCURLdcZ
	 9CMsxa8RBus408/PNSmjdyfflsB2Ek+bLZ3mcHjXzWrNjMk0EXUj3wzBDY8RAkyP9m
	 pB6wNap+uZxJhlFLb2E+09InNXPDG5EVC+xDmsq8=
X-Mailer: git-send-email 1.8.5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1410467734;
	bh=d8tb1UoY8dfaK/8conwRC+TgcNBOXBUtOzW9D2aMY5Y=;
	h=Received:Received:Received:From:To:Subject:Date:Message-Id;
	b=aTApo9nOldbYRnB0iNxBFtnqOGwzGRCbmXr32MpECSG1VBLykfYtVnJyp1Ya6+Cb1
	 SBPK59BXEs0z8XFqtRGjWV9midgEUmw57Wu2pM+W2DighXdqDYd3NII9PNBjdiUB9n
	 XvtVicuBEXzdjZr0hlo2N4Lx2XC3+VTu/W2S4dYA+Jy1d/lUALDxjcIf6blqNJTUSz
	 ztv6idhOgO4pnGmKPus0z61mWd1kfdh/3FGz/Xefr6x6Bw4GwM/Gy14+B1qm19j9Dz
	 dRM883UX27LMQP545FUK1I+1piESdkDygRA5KI9d9gE+HElYdHbX/lWUPzaxDZEar/
	 KRz7IVfHvTNew==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256875>

githooks(5) suggests:

  Information about why the push is rejected may be sent to the user
  by writing to standard error.

So follow that advice in the sample.

Signed-off-by: W. Trevor King <wking@tremily.us>
---
 templates/hooks--pre-push.sample | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/templates/hooks--pre-push.sample b/templates/hooks--pre-push.sample
index 1f3bceb..7cb911c 100755
--- a/templates/hooks--pre-push.sample
+++ b/templates/hooks--pre-push.sample
@@ -45,7 +45,7 @@ do
 		commit=`git rev-list -n 1 --grep '^WIP' "$range"`
 		if [ -n "$commit" ]
 		then
-			echo "Found WIP commit in $local_ref, not pushing"
+			echo "Found WIP commit in $local_ref, not pushing" >&2
 			exit 1
 		fi
 	fi
-- 
2.1.0.60.g85f0837
