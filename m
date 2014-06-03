From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/9] fetch doc: remove notes on outdated "mixed layout"
Date: Tue,  3 Jun 2014 15:16:27 -0700
Message-ID: <1401833792-2486-5-git-send-email-gitster@pobox.com>
References: <1401833792-2486-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 04 00:17:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wrx11-0005GI-9y
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 00:17:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965474AbaFCWQ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 18:16:59 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60377 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965472AbaFCWQ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 18:16:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3E1021DD73;
	Tue,  3 Jun 2014 18:16:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=JCkk
	m+hY12HsLa0TQjrwTK/Kjuo=; b=baXBh1G86N4tB6WSn1QSmH+DvXLNSbTr92VJ
	8X6QFHwicXsflDS4s1ekSXs+gfYxiPYiowH0ifMNV/bqLWmYk94rJ653Gfn0zodC
	OhMCakS9xrBGhQm8zortGXt0QYMUCQVji2CAJz0+MzfK6ZmrcAvzG0jzYJvz66A5
	7LdxqaA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=x9cJGF
	4sTIqaEHZtn0S2Qnrq2BoFHPM+dhiDiP95896LNZJDgfhRQXcv6gDpgxbXtw+Fyv
	OVX/8kCUr9jsPWzWCavwt8Zu2uWRgnt2mzxKdhfLYUqmBOZ1o0Fd8/zeL8RA9Fw/
	XxEUtk4PDc1RhTfV+IB3/pLjJ34SOutH+DxmE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 351511DD72;
	Tue,  3 Jun 2014 18:16:57 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9D1B91DD69;
	Tue,  3 Jun 2014 18:16:53 -0400 (EDT)
X-Mailer: git-send-email 2.0.0-518-g8437b4f
In-Reply-To: <1401833792-2486-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: C47925D2-EB6C-11E3-82C5-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250699>

In old days before Git 1.5, it was customery for "git fetch" to use
the same local branch namespace to keep track of the remote-tracking
branches, and it was necessary to tell users not to check them out
and commit on them.  Since everybody uses the separate remote layout
these days, there is no need to warn against the practice to check
out the right-hand side of <refspec> and build on it---the RHS is
typically not even a local branch.

Incidentally, this also kills one mention of "Pull:" line of
$GIT_DIR/remotes/* configuration, which is a lot less familiar to
new people than the more modern remote.*.fetch configuration
variable.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/pull-fetch-param.txt | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/Documentation/pull-fetch-param.txt b/Documentation/pull-fetch-param.txt
index 41474c5..40f8687 100644
--- a/Documentation/pull-fetch-param.txt
+++ b/Documentation/pull-fetch-param.txt
@@ -36,19 +36,6 @@ in a repository with this behavior; the pulling user simply
 must know this is the expected usage pattern for a branch.
 +
 [NOTE]
-You never do your own development on branches that appear
-on the right hand side of a <refspec> colon on `Pull:` lines;
-they are to be updated by 'git fetch'.  If you intend to do
-development derived from a remote branch `B`, have a `Pull:`
-line to track it (i.e. `Pull: B:remote-B`), and have a separate
-branch `my-B` to do your development on top of it.  The latter
-is created by `git branch my-B remote-B` (or its equivalent `git
-checkout -b my-B remote-B`).  Run `git fetch` to keep track of
-the progress of the remote side, and when you see something new
-on the remote branch, merge it into your development branch with
-`git pull . remote-B`, while you are on `my-B` branch.
-+
-[NOTE]
 There is a difference between listing multiple <refspec>
 directly on 'git pull' command line and having multiple
 `Pull:` <refspec> lines for a <repository> and running
-- 
2.0.0-511-g1433423
