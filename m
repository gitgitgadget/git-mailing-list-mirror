From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 059/144] t5305-include-tag.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:25:04 -0700
Message-ID: <1395735989-3396-60-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:32:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMmf-0004vU-0f
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:32:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753875AbaCYI1r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:27:47 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:45626 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499AbaCYI1n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:27:43 -0400
Received: by mail-pb0-f49.google.com with SMTP id jt11so133013pbb.8
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=6SG7qz6KapuYgtk1IbRayqmgegIgFsc2HFDNUlr6EGo=;
        b=FiZGoMbgaXareePhiwGySR71ltlZrLGMjHrIyrLE9NsiaKdjzqWTlA8tj7ZkcOR0fC
         VPrlDqQ8ZJbbYByWgwwkf5i+oIU1pLUhsDpr7PTtLEwaBJaSPNlEveOB+8K974Hh9Zmz
         P8wLSFhJ9+ZSXpOH4MWMzbat2j9+sA9TshH7FlL8zZdF4gTYu0vLkW/3SN7H9Gg5nHZz
         I+qaAgCHHg8G3dbDEqeQKRCaHbMSg2Uqd038PRMHJd/3kXNR6Mjg8nafFWie+7rG1mk9
         lJ5f6XNrUjMUTBgO/x1+uQH3zQwDmm9zbmacOKICzUntu5DelJxdqccHLt/kDhwanrdi
         Xu7g==
X-Received: by 10.66.156.4 with SMTP id wa4mr77770128pab.49.1395736063067;
        Tue, 25 Mar 2014 01:27:43 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.27.42
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:27:42 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244971>

The Git CodingGuidelines prefer the $( ... ) construct for command
substitution instead of using the back-quotes, or grave accents (`..`).

The backquoted form is the historical method for command substitution,
and is supported by POSIX. However,all but the simplest uses become
complicated quickly. In particular,embedded command substitutions
and/or the use of double quotes require careful escaping with the backs=
lash
character. Because of this the POSIX shell adopted the $(=E2=80=A6) fea=
ture from
the Korn shell.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 t/t5305-include-tag.sh |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t5305-include-tag.sh b/t/t5305-include-tag.sh
index b061864..74b4a03 100755
--- a/t/t5305-include-tag.sh
+++ b/t/t5305-include-tag.sh
@@ -3,20 +3,20 @@
 test_description=3D'git pack-object --include-tag'
 . ./test-lib.sh
=20
-TRASH=3D`pwd`
+TRASH=3D$(pwd)
=20
 test_expect_success setup '
 	echo c >d &&
 	git update-index --add d &&
-	tree=3D`git write-tree` &&
-	commit=3D`git commit-tree $tree </dev/null` &&
+	tree=3D$(git write-tree) &&
+	commit=3D$(git commit-tree $tree </dev/null) &&
 	echo "object $commit" >sig &&
 	echo "type commit" >>sig &&
 	echo "tag mytag" >>sig &&
 	echo "tagger $(git var GIT_COMMITTER_IDENT)" >>sig &&
 	echo >>sig &&
 	echo "our test tag" >>sig &&
-	tag=3D`git mktag <sig` &&
+	tag=3D$(git mktag <sig) &&
 	rm d sig &&
 	git update-ref refs/tags/mytag $tag && {
 		echo $tree &&
--=20
1.7.10.4
