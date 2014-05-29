From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/5] fetch doc: remove notes on outdated "mixed layout"
Date: Thu, 29 May 2014 15:42:28 -0700
Message-ID: <1401403350-7122-4-git-send-email-gitster@pobox.com>
References: <1401403350-7122-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 30 00:42:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wq92F-0003gm-Qc
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 00:42:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753847AbaE2Wmv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2014 18:42:51 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52341 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753789AbaE2Wmu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2014 18:42:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 743CA1C326;
	Thu, 29 May 2014 18:42:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=qKAh
	5rqHv/DDQ49W4vUOpEVHr+g=; b=l0txbo7SlhQ1sUtim6xhKCXEkaVFgIlVnlBu
	3jdp241RhGpH9McndT3x6BydHGIruGcHv+pbx3B2Wo8FSx0/l8B9rPslcrHQ4/cX
	CV0LTeH94NzLuqDGde4uoZK4vTnW0MzkEvdCCXBw8gmiJzJmo94zEP1Ev/bRA5xa
	oRg7iG8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=PaYwjE
	p6K0B+oHNm3pbK933/J+S9l6PV3+LkklpfEMEMa7326DGiawitXYZS44QRxnuRR9
	bKvKOR6NPgzF5mp3gXfbCI/cv0spdD8fD27ny4yhixJ9Xsgvd7Xa3t/mpnetK0S4
	mhD2ZVDE5NHL7ecT+RACmbOTh1LhoZQd8KALs=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6BB311C325;
	Thu, 29 May 2014 18:42:50 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1522A1C324;
	Thu, 29 May 2014 18:42:46 -0400 (EDT)
X-Mailer: git-send-email 2.0.0-479-g59ac8f9
In-Reply-To: <1401403350-7122-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 8E551B16-E782-11E3-B8F6-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250414>

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
index 2a7e2b7..e266c2d 100644
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
2.0.0-479-g59ac8f9
