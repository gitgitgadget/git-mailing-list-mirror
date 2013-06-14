From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/2] pull: clarify the large && { ... } form
Date: Fri, 14 Jun 2013 14:26:18 +0530
Message-ID: <1371200178-9927-3-git-send-email-artagnon@gmail.com>
References: <1371200178-9927-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 14 10:54:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnPmL-0001Hq-It
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 10:54:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751542Ab3FNIyc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 04:54:32 -0400
Received: from mail-pb0-f47.google.com ([209.85.160.47]:60180 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750930Ab3FNIya (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 04:54:30 -0400
Received: by mail-pb0-f47.google.com with SMTP id rr13so370887pbb.6
        for <git@vger.kernel.org>; Fri, 14 Jun 2013 01:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=i/HA7zbhrsq7spkxr6c+ai4hTTZlbxU91i+By5Bz7Lw=;
        b=cu8OpJWaDrycpFniJlVjYfNLekY1P7vpRvT4+6gc23XBbGe/UqMc4V+qFls08ao1vE
         3do2vfIfVF8SJ9XO6mxksMHIZflZ3rhfN1DO6ujdxNg0qgKpj/qOd14BhiZ8J2hFruSA
         9PRcKks5fatbtDsNhQ3/uEJLEorbpUUXymeX+jT6Xv4Y6o7G9JPOj0r48fDmdh7ziUvt
         rl5Ubo3UfRYVC8//cTcQvFKsl9ZYJX7oxUz5qS+h1caDFfZmVMC9fZUZn9/aPuyYey/A
         +T+uTFgvSV7hHz3cpjGJdkwZ+dSuzBzdMjZcQ0T5Ya7RZaHAxiov/o9qXpgrdMehiSHL
         6csA==
X-Received: by 10.66.82.69 with SMTP id g5mr1521767pay.179.1371200070065;
        Fri, 14 Jun 2013 01:54:30 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id fr1sm1506848pbb.26.2013.06.14.01.54.27
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 14 Jun 2013 01:54:28 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.379.gb74074e.dirty
In-Reply-To: <1371200178-9927-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227797>

Remove the large && { ... } form, as the block can be confused with a
function block.  Use a simple if-condition instead.  No functional
changes.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 git-pull.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index fb01763..babf009 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -195,7 +195,7 @@ error_on_no_merge_candidates () {
 	exit 1
 }
 
-test true = "$rebase" && {
+if test true = "$rebase"; then
 	if ! git rev-parse -q --verify HEAD >/dev/null
 	then
 		# On an unborn branch
@@ -220,7 +220,8 @@ test true = "$rebase" && {
 			break
 		fi
 	done
-}
+fi
+
 orig_head=$(git rev-parse -q --verify HEAD)
 git fetch $verbosity $progress $dry_run $recurse_submodules --update-head-ok "$@" || exit 1
 test -z "$dry_run" || exit 0
-- 
1.8.3.1.379.gb74074e.dirty
