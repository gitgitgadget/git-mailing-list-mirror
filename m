From: "Simon A. Eugster" <simon.eu@gmail.com>
Subject: [PATCH] Documentation clarification on git-checkout regarding ours/theirs
Date: Fri, 10 Jul 2015 10:27:57 +0200
Message-ID: <1436516877-21064-1-git-send-email-simon.eu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Simon A. Eugster" <simon.eugster@eps.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 10 10:28:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDTfS-00072U-Ch
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jul 2015 10:28:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753460AbbGJI2S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jul 2015 04:28:18 -0400
Received: from mail-wg0-f50.google.com ([74.125.82.50]:33073 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752131AbbGJI2O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2015 04:28:14 -0400
Received: by wgck11 with SMTP id k11so243291317wgc.0
        for <git@vger.kernel.org>; Fri, 10 Jul 2015 01:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=Lyd6wNqz45I78mlkUun12M1vKszo0H6OYdM0BNjgN54=;
        b=nKIaAZwaj/xf9CI9CA3yXCMUjqqQfZ6lpWxNKP68zZU+FNsEPJgJh+Et4BN9rZSsOK
         E13b/jXbjnKarMIiUSmRlq9o1JKC4HHFAi02sf9/tJp7qSXZ1+4U4JoCcg4GtLt1D0qW
         CJ4D0/p6ri+KBMMSHio1y45B6T27wXfF9gW85bTsVgAz4tuHLRXB2hZPq4MkL6Zl+mJu
         1cFP1MMAZ5JOolDu4bPmIpgovOpRjJEsFL85hsxK+aK0+THhrzHPlSPrP9++sP6UWSSu
         YboxFwdYTtLweQHl5rrVb/gqbtAZIIgnE3yGHxZVX9fR9fk8neZdPjyTaK1pORs06uhi
         tC0A==
X-Received: by 10.194.10.165 with SMTP id j5mr40707281wjb.147.1436516893220;
        Fri, 10 Jul 2015 01:28:13 -0700 (PDT)
Received: from sie-matemint.localdomain ([194.9.120.21])
        by smtp.gmail.com with ESMTPSA id c7sm12487109wjb.19.2015.07.10.01.28.12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Jul 2015 01:28:12 -0700 (PDT)
X-Mailer: git-send-email 1.8.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273808>

=46rom: "Simon A. Eugster" <simon.eugster@eps.ch>

Signed-off-by: Simon A. Eugster <simon.eugster@eps.ch>
---
 Documentation/git-checkout.txt | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkou=
t.txt
index d263a56..d69306f 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -115,7 +115,21 @@ entries; instead, unmerged entries are ignored.
 --ours::
 --theirs::
 	When checking out paths from the index, check out stage #2
-	('ours') or #3 ('theirs') for unmerged paths.
+	('ours', HEAD) or #3 ('theirs', MERGE_HEAD) for unmerged paths.
+	See linkgit:git-merge[1] for details about stages #2 and #3.
++
+Note that during `git rebase` and `git pull --rebase`, 'theirs' checks=
 out
+the local version, and 'ours' the remote version or the history that i=
s rebased
+against.
++
+The reason ours/theirs appear to be swapped during a rebase is that we
+define the remote history as the canonical history, on top of which ou=
r
+private commits are applied on, as opposed to normal merging where the
+local history is the canonical one.
+During merging, we assume the role of the canonical history=E2=80=99s =
keeper,
+which, in case of a rebase, is the remote history, and our private com=
mits
+look to the keeper as =E2=80=9Ctheir=E2=80=9D commits which need to be=
 integrated on top
+of =E2=80=9Cour=E2=80=9D work.
=20
 -b <new_branch>::
 	Create a new branch named <new_branch> and start it at
--=20
1.8.5.1
