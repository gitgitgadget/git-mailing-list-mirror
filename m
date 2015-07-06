From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 10/23] checkout: prepare_linked_checkout: drop now-unused 'new' argument
Date: Mon,  6 Jul 2015 13:30:47 -0400
Message-ID: <1436203860-846-11-git-send-email-sunshine@sunshineco.com>
References: <1436203860-846-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 06 19:33:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCAGO-0008Tb-1y
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 19:33:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753770AbbGFRc4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 13:32:56 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:33943 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753989AbbGFRbj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 13:31:39 -0400
Received: by iebmu5 with SMTP id mu5so117795774ieb.1
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 10:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=umlOvnK0ke6TRnY+ybtNyxE6k0q+waF3vjBy6eSsKV8=;
        b=apANqHqt4jdtGlLg0Zu2ZPmRCztMRwWlFzBelm1Lg5Z3Tk8h2Y7Oxp4jtlyRu9Ksp+
         fkippnFMVJGuphz4nZoKqfOhQk7QMvBk5UJCr9uzkNpyHbzhI3XYvHKTRE2Ms50te9Mc
         g0ahH/uL4lwQ2pFNEh79ZcAnRgDET0SEv0zK3SffLPRNjMUmZJGn9RAG5+gNVNyntqiI
         SeMnS1aCEcVumVRdt8bLZ7Sltfk2sVSsPmwaJvU7BkYNtRtvwZgqAoVA5EAvbCQduhpC
         3TZeojyQj05FwaaIemh/z2nuoOwDDF96TIEOOgYpIwB1Cb1l+Kf+YiE4NCmaYbGhKPsB
         U3RA==
X-Received: by 10.43.56.146 with SMTP id wc18mr36355236icb.24.1436203899027;
        Mon, 06 Jul 2015 10:31:39 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id g18sm12861567iod.5.2015.07.06.10.31.37
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Jul 2015 10:31:38 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.197.g417e668
In-Reply-To: <1436203860-846-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273430>

The only references to 'new' were folded out by the last two patches.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 builtin/checkout.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 162c822..134b6d6 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -854,8 +854,7 @@ static void remove_junk_on_signal(int signo)
 	raise(signo);
 }
 
-static int prepare_linked_checkout(const struct checkout_opts *opts,
-				   struct branch_info *new)
+static int prepare_linked_checkout(const struct checkout_opts *opts)
 {
 	struct strbuf sb_git = STRBUF_INIT, sb_repo = STRBUF_INIT;
 	struct strbuf sb = STRBUF_INIT;
@@ -1304,7 +1303,7 @@ static int checkout_branch(struct checkout_opts *opts,
 	if (opts->new_worktree) {
 		if (!new->commit)
 			die(_("no branch specified"));
-		return prepare_linked_checkout(opts, new);
+		return prepare_linked_checkout(opts);
 	}
 
 	if (!new->commit && opts->new_branch) {
-- 
2.5.0.rc1.197.g417e668
