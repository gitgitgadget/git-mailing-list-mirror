From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v2 1/3] completion: complete "unstuck" `git push --recurse-submodules`
Date: Tue, 22 Jul 2014 19:24:56 +0100
Message-ID: <8303c95dd3e3ee8d77d4b994bb2d33b6a155a17f.1406053442.git.john@keeping.me.uk>
References: <e9576136c09dbf65c5e614f9272d2c2afa96f5b6.1405763157.git.john@keeping.me.uk>
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 22 20:30:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9epO-0008Fj-Cu
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jul 2014 20:30:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756457AbaGVSaN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2014 14:30:13 -0400
Received: from hyena.aluminati.org ([64.22.123.221]:33069 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754757AbaGVSaL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2014 14:30:11 -0400
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id AE06D22F2F;
	Tue, 22 Jul 2014 19:30:10 +0100 (BST)
X-Quarantine-ID: <GATOehXEcMD3>
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.2
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8] autolearn=no
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id GATOehXEcMD3; Tue, 22 Jul 2014 19:29:55 +0100 (BST)
Received: from river.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id A32BD2185E;
	Tue, 22 Jul 2014 19:25:06 +0100 (BST)
X-Mailer: git-send-email 2.0.1.472.g6f92e5f.dirty
In-Reply-To: <e9576136c09dbf65c5e614f9272d2c2afa96f5b6.1405763157.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254028>

Since the argument to `--recurse-submodules` is mandatory, it does not
need to be stuck to the option with `=`.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
Change since v1:
    - Fix typo --recurse{_ => -}submodules
    - Dropped previous patch 1/4 adding ";;" at the end of the "--repo" case

 contrib/completion/git-completion.bash | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 7a6e1d7..bed3665 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1624,6 +1624,10 @@ __git_push_recurse_submodules="check on-demand"
 _git_push ()
 {
 	case "$prev" in
+	--recurse-submodules)
+		__gitcomp "$__git_push_recurse_submodules"
+		return
+		;;
 	--repo)
 		__gitcomp_nl "$(__git_remotes)"
 		return
-- 
2.0.1.472.g6f92e5f.dirty
