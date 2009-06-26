From: newren@gmail.com
Subject: [PATCHv3 4/7] fast-export: Do parent rewriting to avoid dropping relevant commits
Date: Thu, 25 Jun 2009 22:48:30 -0600
Message-ID: <1245991713-12782-5-git-send-email-newren@gmail.com>
References: <1245991713-12782-1-git-send-email-newren@gmail.com>
Cc: Johannes.Schindelin@gmx.de, kusmabite@gmail.com,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 26 06:51:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MK3PG-0003HF-7f
	for gcvg-git-2@gmane.org; Fri, 26 Jun 2009 06:51:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752159AbZFZEux (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2009 00:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751781AbZFZEuu
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 00:50:50 -0400
Received: from mail-pz0-f202.google.com ([209.85.222.202]:44971 "EHLO
	mail-pz0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269AbZFZEur (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2009 00:50:47 -0400
Received: by mail-pz0-f202.google.com with SMTP id 40so3787pzk.33
        for <git@vger.kernel.org>; Thu, 25 Jun 2009 21:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=FG2Z535rskkOisaUkjihcGIiiJHjTet9El12ub3C+5g=;
        b=uv8YF74k/wm+AbTvOuyClBHBiHK2jVKQX09hsouU0mWtGmdR+Zf80T60b0dbIyJvX0
         mmoHZs9sHQxtNg/wm8llzOPcP6P5W0eXe71oo8U1qEMiyciXJXi1GNIx8uMCJhtsaaz8
         KmIKRZcFrHA9q1SzoL+AFmvPEDV5SnAtLrfvM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=L8CwShYEOhiRmz41w3be5eWZBsR2BqV3ujPyNqqlVAz3Mc8MJx7kirfY0Bc5JMCsIM
         N2cly2fHNO85WRYqCkPKleAXDmA9/+BkV5+pBiREAuuFssFZKd0PUdVBOlR2QK9iQUuO
         2p4wiLjYlxzA3sAQLEFgTdd6bPwkLP+aDfbE4=
Received: by 10.142.43.19 with SMTP id q19mr1238084wfq.305.1245991851006;
        Thu, 25 Jun 2009 21:50:51 -0700 (PDT)
Received: from localhost.localdomain (c-68-35-108-93.hsd1.nm.comcast.net [68.35.108.93])
        by mx.google.com with ESMTPS id 27sm160173wff.6.2009.06.25.21.50.49
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 25 Jun 2009 21:50:50 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.3.341.g1a0a
In-Reply-To: <1245991713-12782-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122275>

From: Elijah Newren <newren@gmail.com>

When specifying paths to export, parent rewriting must be turned on for
fast-export to output anything at all.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
No change to this patch since the last series.

 builtin-fast-export.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index 43a7e17..9b8bd37 100644
--- a/builtin-fast-export.c
+++ b/builtin-fast-export.c
@@ -531,6 +531,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 	init_revisions(&revs, prefix);
 	revs.topo_order = 1;
 	revs.show_source = 1;
+	revs.rewrite_parents = 1;
 	argc = setup_revisions(argc, argv, &revs, NULL);
 	argc = parse_options(argc, argv, prefix, options, fast_export_usage, 0);
 	if (argc > 1)
-- 
1.6.3.2.323.geb889
