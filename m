From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] git-remote-testgit: build it to run under $SHELL_PATH
Date: Mon, 29 Apr 2013 10:41:55 -0700
Message-ID: <1367257315-12009-4-git-send-email-gitster@pobox.com>
References: <7vehdtjl2n.fsf@alter.siamese.dyndns.org>
 <1367257315-12009-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 29 19:42:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWs5s-0003p7-T0
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 19:42:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757992Ab3D2RmF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 13:42:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45694 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757892Ab3D2RmD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 13:42:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F69C1ABC2
	for <git@vger.kernel.org>; Mon, 29 Apr 2013 17:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=MgPW
	BC/yUGrFDQJru5BJ8hirCJA=; b=XaGjAWXnz7SnqxxpCBIWivpN9E0FiBLHTzLd
	4jzcAtJi1BfigFJJNwzwK3JQAbjySAgdB+WdM+ipHWQx1SIWyOHVd7VQgt1SqklV
	Ar+iiiZmFUR7kmMIwup7Ovsnni70jbkfybIVCznGptDBmGQeAYNz3E+JoTrK8niT
	/JlWPRk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=c6oJSE
	mvAmzIe/FwkyV44mo+NWoxrvakaX7PiHVEzJ4oPGC4b/aO9FSz6hRZrgzaesh3cJ
	X+QQeaEGYnatqQBpOHCwbO+5Cina3QiCineVXlVQgUQlIwlNdiY70S1WkZTv9A83
	ayLqkSbQv4dNaLu7Qb1aTTDqa3uxzR3IzHq2g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 175C51ABC1
	for <git@vger.kernel.org>; Mon, 29 Apr 2013 17:42:03 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 937351ABBE
	for <git@vger.kernel.org>; Mon, 29 Apr 2013 17:42:02 +0000 (UTC)
X-Mailer: git-send-email 1.8.3-rc0-121-gda9b90f
In-Reply-To: <1367257315-12009-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 19CFE0B6-B0F4-11E2-A9FE-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222825>

Just like all the other shell scripts, replace the shebang line to
make sure it runs under the shell the user specified.

As this no longer depends on bashisms, t5801 does not have to say
bash must be available somewhere on the system.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 .gitignore                                  | 1 +
 Makefile                                    | 1 +
 git-remote-testgit => git-remote-testgit.sh | 0
 t/t5801-remote-helpers.sh                   | 5 -----
 4 files changed, 2 insertions(+), 5 deletions(-)
 rename git-remote-testgit => git-remote-testgit.sh (100%)

diff --git a/.gitignore b/.gitignore
index 6669bf0..10aee94 100644
--- a/.gitignore
+++ b/.gitignore
@@ -125,6 +125,7 @@
 /git-remote-ftps
 /git-remote-fd
 /git-remote-ext
+/git-remote-testgit
 /git-remote-testpy
 /git-remote-testsvn
 /git-repack
diff --git a/Makefile b/Makefile
index 0f931a2..5f424a7 100644
--- a/Makefile
+++ b/Makefile
@@ -460,6 +460,7 @@ SCRIPT_SH += git-mergetool.sh
 SCRIPT_SH += git-pull.sh
 SCRIPT_SH += git-quiltimport.sh
 SCRIPT_SH += git-rebase.sh
+SCRIPT_SH += git-remote-testgit.sh
 SCRIPT_SH += git-repack.sh
 SCRIPT_SH += git-request-pull.sh
 SCRIPT_SH += git-stash.sh
diff --git a/git-remote-testgit b/git-remote-testgit.sh
similarity index 100%
rename from git-remote-testgit
rename to git-remote-testgit.sh
diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index c956abd..0a83db8 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -7,11 +7,6 @@ test_description='Test remote-helper import and export commands'
 
 . ./test-lib.sh
 
-if ! type "${BASH-bash}" >/dev/null 2>&1; then
-	skip_all='skipping remote-testgit tests, bash not available'
-	test_done
-fi
-
 compare_refs() {
 	git --git-dir="$1/.git" rev-parse --verify $2 >expect &&
 	git --git-dir="$3/.git" rev-parse --verify $4 >actual &&
-- 
1.8.3-rc0-121-gda9b90f
