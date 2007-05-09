From: Junio C Hamano <junkio@cox.net>
Subject: Re: failing test t9400 (Re: [PATCH] git-update-ref: add --no-deref option for overwriting/detaching ref)
Date: Wed, 09 May 2007 09:19:01 -0700
Message-ID: <7vr6pqt1fu.fsf@assigned-by-dhcp.cox.net>
References: <20070509103320.GA7257MdfPADPa@greensroom.kotnet.org>
	<7vk5viuim5.fsf@assigned-by-dhcp.cox.net>
	<20070509153831.GW942MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Frank Lichtenheld <frank@lichtenheld.de>
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Wed May 09 18:19:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hlosg-00086U-5z
	for gcvg-git@gmane.org; Wed, 09 May 2007 18:19:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755030AbXEIQTG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 12:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755251AbXEIQTF
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 12:19:05 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:33855 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755030AbXEIQTE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 12:19:04 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070509161900.EAQG2758.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Wed, 9 May 2007 12:19:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id x4K11W00R1kojtg0000000; Wed, 09 May 2007 12:19:02 -0400
In-Reply-To: <20070509153831.GW942MdfPADPa@greensroom.kotnet.org> (Sven
	Verdoolaege's message of "Wed, 09 May 2007 17:38:31 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46738>

Sven Verdoolaege <skimo@kotnet.org> writes:

> On Wed, May 09, 2007 at 08:22:42AM -0700, Junio C Hamano wrote:
>> Can you retry after installing libdbi and libdbd-sqlite-perl?
>
> I'd rather spend my (limited) time on the submodules thing.

Heh, everybody wants to futz with new things ;-)

> Shouldn't these tests be skipped if I don't have all that stuff installed?
> There doesn't even seem to be an option to turn off these tests.

I agree.  We would need something like this, but I have no easy
way to test it myself, short of uninstalling what I need on the
box.  As you do not have them, maybe you can give it a quick
whirl?

Thanks.

---
diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index f17be6b..98d6bb4 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -17,6 +17,11 @@ then
     test_done
     exit
 fi
+perl -e 'use DBI; use DBD::SQLite' 2>&1 || {
+    test_expect_success 'skipping git-cvsserver tests, Perl SQLite interface unavailable' :
+    test_done
+    exit
+}
 
 unset GIT_DIR GIT_CONFIG
 WORKDIR=$(pwd)
