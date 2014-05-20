From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] t6006-*.sh: Fix truncation tests
Date: Tue, 20 May 2014 14:54:20 +0100
Message-ID: <537B5E8C.3070803@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Alex.Crezoff@gmail.com
X-From: git-owner@vger.kernel.org Tue May 20 15:54:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmkUx-0004wT-M1
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 15:54:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753420AbaETNy0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 09:54:26 -0400
Received: from mdfmta004.mxout.tch.inty.net ([91.221.169.45]:45500 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752115AbaETNyZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 09:54:25 -0400
Received: from mdfmta004.tch.inty.net (unknown [127.0.0.1])
	by mdfmta004.tch.inty.net (Postfix) with ESMTP id CA939AC407F;
	Tue, 20 May 2014 14:54:27 +0100 (BST)
Received: from mdfmta004.tch.inty.net (unknown [127.0.0.1])
	by mdfmta004.tch.inty.net (Postfix) with ESMTP id 5F4DEAC4099;
	Tue, 20 May 2014 14:54:27 +0100 (BST)
Received: from [192.168.254.1] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mdfmta004.tch.inty.net (Postfix) with ESMTP;
	Tue, 20 May 2014 14:54:26 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
X-MDF-HostID: 17
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249681>


Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Alexey,

If you need to re-roll your 'as/pretty-truncate' branch, could
you please squash the relevant parts of this patch into the
corresponding patches of your patch series. (ie this is a patch
against the head of the current pu branch ...).

Without this patch I get:

  $ ./t6006-rev-list-format.sh
  ok 1 - setup
  ok 2 - format percent
  ok 3 - format hash
  ok 4 - format tree
  ok 5 - format parents
  ok 6 - format author
  ok 7 - format committer
  ok 8 - format encoding
  ok 9 - format subject
  ./t6006-rev-list-format.sh: 152: ./t6006-rev-list-format.sh: Syntax error: "(" unexpected
  FATAL: Unexpected exit with code 2
  $ 

(if you have bash as /bin/sh you get different but related errors).
The additional quoting suppresses the 'command redirection' errors, etc...

Thanks.

ATB
Ramsay Jones

 t/t6006-rev-list-format.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index 9bc089b..e1dec3e 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -149,7 +149,7 @@ commit $head1
 $added
 EOF
 
-test_format subject-truncated %<($truncate_count,trunc)%s <<EOF
+test_format subject-truncated %\<\($truncate_count,trunc\)%s <<EOF
 commit $head2
 changed (ge${changed_utf8_part}ndert)..
 commit $head1
@@ -256,7 +256,7 @@ commit $head1
 $added_iso88591
 EOF
 
-test_format complex-subject-trunc %<($truncate_count,trunc)%s <<EOF
+test_format complex-subject-trunc %\<\($truncate_count,trunc\)%s <<EOF
 commit $head3
 Test printing of c..
 commit $head2
@@ -265,7 +265,7 @@ commit $head1
 added (hinzugef${added_utf8_part_iso88591}gt..
 EOF
 
-test_format complex-subject-mtrunc %<($truncate_count,mtrunc)%s <<EOF
+test_format complex-subject-mtrunc %\<\($truncate_count,mtrunc\)%s <<EOF
 commit $head3
 Test prin..ex bodies
 commit $head2
@@ -274,7 +274,7 @@ commit $head1
 added (hi..f${added_utf8_part_iso88591}gt) foo
 EOF
 
-test_format complex-subject-ltrunc %<($truncate_count,ltrunc)%s <<EOF
+test_format complex-subject-ltrunc %\<\($truncate_count,ltrunc\)%s <<EOF
 commit $head3
 .. of complex bodies
 commit $head2
@@ -311,7 +311,7 @@ commit $head1
 $added
 EOF
 
-test_format complex-subject-commitencoding-unset-trunc %<($truncate_count,trunc)%s <<EOF
+test_format complex-subject-commitencoding-unset-trunc %\<\($truncate_count,trunc\)%s <<EOF
 commit $head3
 Test printing of c..
 commit $head2
@@ -320,7 +320,7 @@ commit $head1
 added (hinzugef${added_utf8_part}gt..
 EOF
 
-test_format complex-subject-commitencoding-unset-mtrunc %<($truncate_count,mtrunc)%s <<EOF
+test_format complex-subject-commitencoding-unset-mtrunc %\<\($truncate_count,mtrunc\)%s <<EOF
 commit $head3
 Test prin..ex bodies
 commit $head2
@@ -329,7 +329,7 @@ commit $head1
 added (hi..f${added_utf8_part}gt) foo
 EOF
 
-test_format complex-subject-commitencoding-unset-ltrunc %<($truncate_count,ltrunc)%s <<EOF
+test_format complex-subject-commitencoding-unset-ltrunc %\<\($truncate_count,ltrunc\)%s <<EOF
 commit $head3
 .. of complex bodies
 commit $head2
-- 
1.9.0
