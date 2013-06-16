From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v4 4/6] submodule: show full path in error message
Date: Sun, 16 Jun 2013 15:18:16 +0100
Message-ID: <eec9274fcda272904c625fe3d8e68b34490671cf.1371391740.git.john@keeping.me.uk>
References: <cover.1371391740.git.john@keeping.me.uk>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Johannes Sixt <j6t@kdbg.org>, John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 16 16:19:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoDnj-0001gG-RB
	for gcvg-git-2@plane.gmane.org; Sun, 16 Jun 2013 16:19:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755241Ab3FPOTY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Jun 2013 10:19:24 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:38050 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755172Ab3FPOTX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Jun 2013 10:19:23 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 5B5106064D5;
	Sun, 16 Jun 2013 15:19:23 +0100 (BST)
X-Quarantine-ID: <EyOlKtXj4yaB>
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -2.899
X-Spam-Level: 
X-Spam-Status: No, score=-2.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EyOlKtXj4yaB; Sun, 16 Jun 2013 15:19:22 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id DB5716064CE;
	Sun, 16 Jun 2013 15:19:22 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id C70CF161E2DC;
	Sun, 16 Jun 2013 15:19:22 +0100 (BST)
X-Quarantine-ID: <NamkszYuZMql>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NamkszYuZMql; Sun, 16 Jun 2013 15:19:22 +0100 (BST)
Received: from river.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 24BB3161E2E9;
	Sun, 16 Jun 2013 15:19:11 +0100 (BST)
X-Mailer: git-send-email 1.8.3.779.g691e267
In-Reply-To: <cover.1371391740.git.john@keeping.me.uk>
In-Reply-To: <cover.1371391740.git.john@keeping.me.uk>
References: <cover.1371391740.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228012>

When --recursive was added to "submodule foreach" in commit 15fc56a (git
submodule foreach: Add --recursive to recurse into nested submodules,
2009-08-19), the error message when the script returns a non-zero status
was not updated to contain $prefix to show the full path.  Fix this.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 git-submodule.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 79bfaac..bdb438b 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -485,7 +485,7 @@ cmd_foreach()
 					cmd_foreach "--recursive" "$@"
 				fi
 			) <&3 3<&- ||
-			die "$(eval_gettext "Stopping at '\$sm_path'; script returned non-zero status.")"
+			die "$(eval_gettext "Stopping at '\$prefix\$sm_path'; script returned non-zero status.")"
 		fi
 	done
 }
-- 
1.8.3.779.g691e267
