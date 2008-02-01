From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: [PATCH] Make blame accept absolute paths
Date: Fri, 1 Feb 2008 05:07:04 +0100
Message-ID: <200802010507.05421.robin.rosenberg.lists@dewire.com>
References: <47975FE6.4050709@viscovery.net> <7v7ihtqfm8.fsf@gitster.siamese.dyndns.org> <7vve5dox0o.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Shawn Bohrer <shawn.bohrer@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 01 05:07:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKnBd-0000x3-OP
	for gcvg-git-2@gmane.org; Fri, 01 Feb 2008 05:07:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763107AbYBAEGy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2008 23:06:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757072AbYBAEGy
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jan 2008 23:06:54 -0500
Received: from [83.140.172.130] ([83.140.172.130]:8091 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1763107AbYBAEGw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2008 23:06:52 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 446D080266C;
	Fri,  1 Feb 2008 05:06:50 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3It1pSBgIAu5; Fri,  1 Feb 2008 05:06:49 +0100 (CET)
Received: from [10.9.0.4] (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 96B5C802641;
	Fri,  1 Feb 2008 05:06:49 +0100 (CET)
User-Agent: KMail/1.9.6 (enterprise 0.20071123.740460)
In-Reply-To: <7vve5dox0o.fsf_-_@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72146>


Blame did not always use prefix_path.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 builtin-blame.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

This is a followup to "setup: sanitize absolute and funny paths in get_pathspec()"
Thanks Junio for fixing this wish of mine.

diff --git a/builtin-blame.c b/builtin-blame.c
index c7e6887..f88c32a 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -1894,9 +1894,7 @@ static unsigned parse_score(const char *arg)
 
 static const char *add_prefix(const char *prefix, const char *path)
 {
-	if (!prefix || !prefix[0])
-		return path;
-	return prefix_path(prefix, strlen(prefix), path);
+	return prefix_path(prefix, prefix ? strlen(prefix) : 0, path);
 }
 
 /*
-- 
1.5.4.rc4.25.g81cc
