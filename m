From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/9] fetch doc: update introductory part for clarity
Date: Tue,  3 Jun 2014 15:16:24 -0700
Message-ID: <1401833792-2486-2-git-send-email-gitster@pobox.com>
References: <1401833792-2486-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 04 00:16:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wrx0j-00055H-W0
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 00:16:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965359AbaFCWQo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 18:16:44 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54186 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965067AbaFCWQm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 18:16:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 270401DD58;
	Tue,  3 Jun 2014 18:16:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=kdkw
	zhTgAYdMQ6DoLjqLNi09ymw=; b=H5yi7hRox5jFwEK/HvLqh5Hf4zqLe8yuJ1Y0
	zP16A/uVUpIsx0LbRVnjDODL7eYeBZg4Fj9ObBGOkCsXozsKIYxKX9o+/dZrd9Kq
	2hYP4YYNAUzElxwD5YVMa8trCtgAjHoZqx4I8g8pTDGZQWEA9v7es3sM1mpVOW9a
	TfA/kvw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=DoS9SL
	jcj+EJei3mLVcpDSEi7SH6+jAcEyTGhi1XQm0fJ5LYTpUDW0ep3moemembZNoRAX
	nT8lCLGjOW9nxnfXjI4me1/ZkJ071QfkwsTSqdzFtbfkiFDuxtcwK+zSxLr6bwJq
	TMp+zPEzYy1vFdmU5ELkK2btNn6CvIKXsrfAo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1DCB51DD57;
	Tue,  3 Jun 2014 18:16:42 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 843E61DD51;
	Tue,  3 Jun 2014 18:16:38 -0400 (EDT)
X-Mailer: git-send-email 2.0.0-518-g8437b4f
In-Reply-To: <1401833792-2486-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: BB78C4D8-EB6C-11E3-95B1-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250696>

 - "Branches" is a more common way to say "heads" in these days.

 - Remote-tracking branches are used a lot more these days and it is
   worth mentioning that it is one of the primary side effects of
   the command to update them.

 - Avoid "X. That means Y."  If Y is easier to understand to
   readers, just say that upfront.

 - Use of explicit refspec to fetch tags does not have much to do
   with turning "auto following" on or off.  It is a way to fetch
   tags that otherwise would not be fetched by auto-following.

Helped-by: Marc Branchaud <marcnarc@xiplink.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-fetch.txt | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index 5809aa4..78fe948 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -17,20 +17,22 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Fetches named heads or tags from one or more other repositories,
-along with the objects necessary to complete them.
+Fetch branches and/or tags (collectively, "refs") from one or more
+other repositories, along with the objects necessary to complete
+their histories.
 
-The ref names and their object names of fetched refs are stored
-in `.git/FETCH_HEAD`.  This information is left for a later merge
-operation done by 'git merge'.
+The names of refs that are fetched, together with the object names
+they point at, are written to `.git/FETCH_HEAD`.  This information
+can be used to learn what was fetched.  In addition, the remote-tracking
+branches are updated (see description on <refspec> below for details).
 
-By default, tags are auto-followed.  This means that when fetching
-from a remote, any tags on the remote that point to objects that exist
-in the local repository are fetched.  The effect is to fetch tags that
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
2.0.0-511-g1433423
