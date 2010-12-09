From: "Alan Raison" <alan@theraisons.me.uk>
Subject: [PATCH] Corrected return values in prep_for_email;
Date: Thu, 9 Dec 2010 13:24:16 -0000
Message-ID: <004201cb97a4$6127cc60$23776520$@me.uk>
References: <002501cb962c$5fa3aa40$1eeafec0$@me.uk> <7v1v5tqswl.fsf@alter.siamese.dyndns.org> <4CFE8E97.4020508@digium.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Kevin P. Fleming'" <kpfleming@digium.com>,
	"'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 09 14:24:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQgU2-0004XJ-5D
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 14:24:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756819Ab0LINYZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 08:24:25 -0500
Received: from gateway.bjss.co.uk ([77.86.30.29]:36993 "EHLO
	gateway.bjss.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755978Ab0LINYY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 08:24:24 -0500
Received: from exchange.bjss.co.uk ([172.22.32.28]) by gateway.bjss.co.uk with Microsoft SMTPSVC(6.0.3790.4675);
	 Thu, 9 Dec 2010 13:24:17 +0000
Received: from kitkat ([172.22.33.188]) by exchange.bjss.co.uk with Microsoft SMTPSVC(6.0.3790.4675);
	 Thu, 9 Dec 2010 13:24:17 +0000
In-Reply-To: <4CFE8E97.4020508@digium.com>
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AcuWRylNHE+witzbTUKvAHNYKsYlyABXN5Cw
Content-Language: en-gb
X-OriginalArrivalTime: 09 Dec 2010 13:24:17.0017 (UTC) FILETIME=[6120EE90:01CB97A4]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163280>

>From ebe98d1c682f268b39a7eaf3ef529accbf0ac61c Mon Sep 17 00:00:00 2001
From: Alan Raison <alan@theraisons.me.uk>
Date: Mon, 6 Dec 2010 15:49:21 +0000
Subject: [PATCH] Corrected return values in prep_for_email;

Function was returning 0 for failure and 1 for success which was breaking
the logic in the main loop.

Corrected to return 0 for success, 1 for failure.  Function now also returns
in all cases, rather than exiting.
---
 contrib/hooks/post-receive-email |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/hooks/post-receive-email
b/contrib/hooks/post-receive-email
index 85724bf..f99ea95 100755
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -144,13 +144,13 @@ prep_for_email()
 			short_refname=${refname##refs/remotes/}
 			echo >&2 "*** Push-update of tracking branch,
$refname"
 			echo >&2 "***  - no email generated."
-			exit 0
+			return 1
 			;;
 		*)
 			# Anything else (is there anything else?)
 			echo >&2 "*** Unknown type of update to $refname
($rev_type)"
 			echo >&2 "***  - no email generated"
-			return 0
+			return 1
 			;;
 	esac
 
@@ -166,10 +166,10 @@ prep_for_email()
 		esac
 		echo >&2 "*** $config_name is not set so no email will be
sent"
 		echo >&2 "*** for $refname update $oldrev->$newrev"
-		return 0
+		return 1
 	fi
 
-	return 1
+	return 0
 }
 
 #
-- 
1.7.3.1.msysgit.0
