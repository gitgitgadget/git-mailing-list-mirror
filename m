From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH] cleanup argument passing in submodule status command
Date: Sat, 28 Jul 2012 14:19:56 +0200
Message-ID: <20120728121956.GA36429@book.hvoigt.net>
References: <20120727185925.793121C0FDC@stefro.sfo.corp.google.com> <20120728102209.GA13370@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jens.lehmann@web.de,
	Stefan Zager <szager@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jul 28 14:24:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sv64V-0001gn-3g
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 14:24:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752339Ab2G1MYC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jul 2012 08:24:02 -0400
Received: from smtprelay04.ispgateway.de ([80.67.31.42]:34275 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752299Ab2G1MYB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2012 08:24:01 -0400
Received: from [77.21.76.22] (helo=localhost)
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1Sv5zw-0003rS-RI; Sat, 28 Jul 2012 14:19:56 +0200
Content-Disposition: inline
In-Reply-To: <20120728102209.GA13370@book.hvoigt.net>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202431>

In commit 98dbe63 the variable $orig_args was renamed to $orig_flags.
One location in cmd_status() was missed.

Note: This is a code cleanup and does not fix any bugs. As a side effect
the variables containing the parsed flags to "git submodule status" are
passed down recursively. So everything was already behaving as expected.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 git-submodule.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index dba4d39..3a3f0a4 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -961,7 +961,7 @@ cmd_status()
 				prefix="$displaypath/"
 				clear_local_git_env
 				cd "$sm_path" &&
-				eval cmd_status "$orig_args"
+				eval cmd_status "$orig_flags"
 			) ||
 			die "$(eval_gettext "Failed to recurse into submodule path '\$sm_path'")"
 		fi
-- 
1.7.12.rc0.23.g3c7cae0
