From: Daniel Trstenjak <Daniel.Trstenjak@science-computing.de>
Subject: [PATCH] Showing stash state in bash prompt
Date: Wed, 13 May 2009 11:44:48 +0200
Message-ID: <20090513094448.GC2106@bug.science-computing.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="J/dobhs11T7y2rNN"
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed May 13 12:01:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4BHJ-0005UQ-Mr
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 12:01:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757670AbZEMKB0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 06:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757418AbZEMKBZ
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 06:01:25 -0400
Received: from smtp1.belwue.de ([129.143.2.12]:61427 "EHLO smtp1.belwue.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755382AbZEMKBY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 06:01:24 -0400
X-Greylist: delayed 990 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 May 2009 06:01:24 EDT
Received: from mx3.science-computing.de (mx3.science-computing.de [193.197.16.20])
	by smtp1.belwue.de with ESMTP id n4D9iruF008637
	for <git@vger.kernel.org>; Wed, 13 May 2009 11:44:53 +0200 (MEST)
	env-from (prvs=37790d091=D.Trstenjak@science-computing.de)
X-IronPort-AV: E=Sophos;i="4.41,186,1241388000"; 
   d="txt'?scan'208";a="4680123"
Received: from unknown (HELO scmail.science-computing.de) ([192.168.2.1])
  by mx3.science-computing.de with ESMTP; 13 May 2009 11:44:53 +0200
Received: from localhost (localhost [127.0.0.1])
	by scmail.science-computing.de (Postfix) with ESMTP id F1B35AC002;
	Wed, 13 May 2009 11:44:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new
Received: from scmail.science-computing.de ([127.0.0.1])
	by localhost (guinesstest.science-computing.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fvqx9tOQDLqE; Wed, 13 May 2009 11:44:49 +0200 (CEST)
Received: from bug.science-computing.de (bug.science-computing.de [10.10.8.89])
	by scmail.science-computing.de (Postfix) with ESMTP id F21ACAC001;
	Wed, 13 May 2009 11:44:48 +0200 (CEST)
Received: by bug.science-computing.de (Postfix, from userid 1014)
	id C93CD128540; Wed, 13 May 2009 11:44:48 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119020>


--J/dobhs11T7y2rNN
Content-Disposition: inline
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Greetings
Daniel

--=20
                                                                           =
                                                               =20
 Daniel Trstenjak         Tel   : +49 (0)7071-9457-264
 science + computing ag   FAX   : +49 (0)7071-9457-511
 Hagellocher Weg 73       mailto: Daniel.Trstenjak@science-computing.de
 D-72070 T=FCbingen         WWW   : http://www.science-computing.de/       =
                                                              =20
--=20
Vorstand/Board of Management:
Dr. Bernd Finkbeiner, Dr. Roland Niemeier,=20
Dr. Arno Steitz, Dr. Ingrid Zech
Vorsitzender des Aufsichtsrats/
Chairman of the Supervisory Board:
Michel Lepert
Sitz/Registered Office: Tuebingen
Registergericht/Registration Court: Stuttgart
Registernummer/Commercial Register No.: HRB 382196=20


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="showing_stash_state.txt"

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 1683e6d..86e39a5 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -117,6 +117,7 @@ __git_ps1 ()
 
 		local w
 		local i
+		local s
 		local c
 
 		if [ "true" = "$(git rev-parse --is-inside-git-dir 2>/dev/null)" ]; then
@@ -136,15 +137,19 @@ __git_ps1 ()
 					else
 						i="#"
 					fi
+					stash_list=`git stash list`
+					if [ -n "$stash_list" ]; then
+					        s="$"
+				        fi
 				fi
 			fi
 		fi
 
 		if [ -n "$b" ]; then
 			if [ -n "${1-}" ]; then
-				printf "$1" "$c${b##refs/heads/}$w$i$r"
+				printf "$1" "$c${b##refs/heads/}$w$i$s$r"
 			else
-				printf " (%s)" "$c${b##refs/heads/}$w$i$r"
+				printf " (%s)" "$c${b##refs/heads/}$w$i$s$r"
 			fi
 		fi
 	fi

--J/dobhs11T7y2rNN--
