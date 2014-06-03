From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 5/9] fetch doc: on pulling multiple refspecs
Date: Tue,  3 Jun 2014 15:16:28 -0700
Message-ID: <1401833792-2486-6-git-send-email-gitster@pobox.com>
References: <1401833792-2486-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 04 00:17:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wrx15-0005Ki-HF
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 00:17:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965475AbaFCWRF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 18:17:05 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63507 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965472AbaFCWRC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 18:17:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4F5281DD7C;
	Tue,  3 Jun 2014 18:17:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=FdVy
	PCFcoTwK6SjklS31PKNpMQE=; b=QnUju1RMBoo4VpZWwd3Gkb37MSJ8dHYxhWGh
	28VxRUQ/6VF2ghJyZyih6bdywd+gmKQNGEqROo/AkNuw6iITdt2bvoM02fgyQXYn
	VkiGxscxkMfOYpJ/phmL64Ofeg++KTAp84yNk11cZV1d9bcb4qsU9Vz04u1RIv6C
	T+IYiXw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=w2Kb7M
	K3UG6sY4eUl5z+nckFSz4hgHUD7XGFelITYteoqRCNDHm+7a2w1ACB/mreR+Rn8a
	XWfs2/EDQWgaaFlwl9+fwVIbsaz5bYV3H5Dv8CtsyJzwvrGzsy4ByHBvkwJbV2Lf
	tm9KBzZdMHGr5qlnvYNe9bXQT68la9RrOa6kM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 474281DD7A;
	Tue,  3 Jun 2014 18:17:02 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9982C1DD74;
	Tue,  3 Jun 2014 18:16:58 -0400 (EDT)
X-Mailer: git-send-email 2.0.0-518-g8437b4f
In-Reply-To: <1401833792-2486-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: C771DC8E-EB6C-11E3-8654-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250700>

Replace desription of old-style "Pull:" lines in remotes/
configuration with modern remote.*.fetch variables.

As this note applies only to "git pull", enable it only
in git-pull manual page.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/pull-fetch-param.txt | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/pull-fetch-param.txt b/Documentation/pull-fetch-param.txt
index 40f8687..25af2ce 100644
--- a/Documentation/pull-fetch-param.txt
+++ b/Documentation/pull-fetch-param.txt
@@ -34,22 +34,26 @@ will be needed for such branches.  There is no way to
 determine or declare that a branch will be made available
 in a repository with this behavior; the pulling user simply
 must know this is the expected usage pattern for a branch.
+ifdef::git-pull[]
 +
 [NOTE]
 There is a difference between listing multiple <refspec>
 directly on 'git pull' command line and having multiple
-`Pull:` <refspec> lines for a <repository> and running
+`remote.<repository>.fetch` entries in your configuration
+for a <repository> and running
 'git pull' command without any explicit <refspec> parameters.
 <refspec> listed explicitly on the command line are always
 merged into the current branch after fetching.  In other words,
 if you list more than one remote refs, you would be making
-an Octopus.  While 'git pull' run without any explicit <refspec>
-parameter takes default <refspec>s from `Pull:` lines, it
+an Octopus merge. On the other hand, 'git pull' that is run
+without any explicit <refspec> parameter takes default
+<refspec>s from `remote.<repository>.fetch` configuration, it
 merges only the first <refspec> found into the current branch,
-after fetching all the remote refs.  This is because making an
+after fetching all the remote refs specified.  This is because making an
 Octopus from remote refs is rarely done, while keeping track
 of multiple remote heads in one-go by fetching more than one
 is often useful.
+endif::git-pull[]
 +
 Some short-cut notations are also supported.
 +
-- 
2.0.0-511-g1433423
