From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/5] fetch doc: update introductory part for clarity
Date: Thu, 29 May 2014 15:42:26 -0700
Message-ID: <1401403350-7122-2-git-send-email-gitster@pobox.com>
References: <1401403350-7122-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 30 00:42:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wq926-0003VL-TO
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 00:42:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753800AbaE2Wmm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2014 18:42:42 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57970 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753789AbaE2Wml (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2014 18:42:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B5BEF1C31B;
	Thu, 29 May 2014 18:42:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=c+1V
	SFr3CMbHQwmd7ViFW2s+6lU=; b=Y57aL3QfVZO2mWf1ybGZwWv7TB1zk97my5Zv
	5Yu891iz3twQqC4e2exMH/3io7+8rc+x8UfwXOvZuPokiq8iIlkSHQjKP7vHrcL4
	3C+MmNkNPW/x0RGP+f6HQQ8EvRsTS+LChAKDPnpVigWrpR8x9AyWnBC1cccrqsoR
	P4Oz8Ik=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=rcPQRf
	TxMbjJ+yHyjtEI9Sg1v+CKIxbICwmMCem8v9sgBnbRjmr78nr9jfgS1maj3gYPvx
	KgvRZHI9J3HGP7cNezbjjP4EJP2+O7ld5CO5vwU80aF5uaGlnv8KYIoyOTUFuz6N
	suc/spQM6lwFmq6lfaPnPtlAWMvSGVrvapfKU=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AD0D81C31A;
	Thu, 29 May 2014 18:42:40 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 57F9F1C319;
	Thu, 29 May 2014 18:42:37 -0400 (EDT)
X-Mailer: git-send-email 2.0.0-479-g59ac8f9
In-Reply-To: <1401403350-7122-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 888933FC-E782-11E3-B7FB-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250412>

 - "Branches" is a more common way to say "heads" in these days.

 - Remote-tracking branches are used a lot more these days and it is
   worth mentioning that it is one of the primary side effects of
   the command to update them.

 - Avoid "X. That means Y."  If Y is easier to understand to
   readers, just say that upfront.

 - Use of explicit refspec to fetch tags does not have much to do
   with turning "auto following" on or off.  It is a way to fetch
   tags that otherwise would not be fetched by auto-following.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-fetch.txt | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index 5809aa4..d5f5b54 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -17,20 +17,23 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Fetches named heads or tags from one or more other repositories,
-along with the objects necessary to complete them.
-
-The ref names and their object names of fetched refs are stored
-in `.git/FETCH_HEAD`.  This information is left for a later merge
-operation done by 'git merge'.
-
-By default, tags are auto-followed.  This means that when fetching
-from a remote, any tags on the remote that point to objects that exist
-in the local repository are fetched.  The effect is to fetch tags that
+Fetch branches and/or tags (collectively, "refs") from one or more
+other repositories, along with the objects necessary to complete the
+histories of them.
+
+The names of refs that are fetched, together with the object names
+they point at, are written to `.git/FETCH_HEAD`.  This information
+is used by a later merge operation done by 'git merge'.  In addition,
+the remote-tracking branches may be updated (see description on
+<refspec> below for details).
+
+By default, any tag that points into the histories being fetched is
+also fetched; the effect is to fetch tags that
 point at branches that you are interested in.  This default behavior
-can be changed by using the --tags or --no-tags options, by
-configuring remote.<name>.tagopt, or by using a refspec that fetches
-tags explicitly.
+can be changed by using the --tags or --no-tags options or by
+configuring remote.<name>.tagopt.  By using a refspec that fetches tags
+explicitly, you can fetch tags that do not point into branches you
+are interested in as well.
 
 'git fetch' can fetch from either a single named repository,
 or from several repositories at once if <group> is given and
-- 
2.0.0-479-g59ac8f9
