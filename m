From: Roberto Tyley <roberto.tyley@gmail.com>
Subject: [PATCH 2/2] Add submitGit patch-submission information
Date: Thu, 14 Apr 2016 22:12:29 +0000
Message-ID: <0102015416d52b62-ce575cc4-6dc2-4097-8883-79baac701105-000000@eu-west-1.amazonses.com>
References: <0102015416d52ae9-da060607-a742-4efc-8b40-98301c2bb261-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 00:12:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqpVC-0007x0-Bm
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 00:12:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752084AbcDNWMc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 18:12:32 -0400
Received: from a6-246.smtp-out.eu-west-1.amazonses.com ([54.240.6.246]:41142
	"EHLO a6-246.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752045AbcDNWMc (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2016 18:12:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1460671949;
	h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=Pl7a6Yd11Q8GNCzwevprzcdu/yyWyKRZyUkK880yiKs=;
	b=dy5v+OhAh/vSygIrMuYR5St7O0bF/3zHOEKtqqvywh0qcLJwsjO6a+5Ou/39P+Rr
	jOMdLb2py8TAmso3ovhArZR2KhJqEGcjNvJQs/dvljirrhcySXfCD+9Zc+YDX7qnjYS
	+gCJJ3EB8kZfLXm6Ld2P00rlXhkU+nNvt2yJPXGY=
In-Reply-To: <0102015416d52ae9-da060607-a742-4efc-8b40-98301c2bb261-000000@eu-west-1.amazonses.com>
X-SES-Outgoing: 2016.04.14-54.240.6.246
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291571>

Most of the guidance on how to use submitGit will stay with the tool
itself, so the edits here are mostly to make the choice clear to users.

Because generation of patches is quite different for MUA-users and
submitGit users, I've merged section 3 and 4 together:

section 3 - 'Generate your patch using Git tools out of your commits.'
+
section 4 - 'Sending your patches.'
=
new section 3 - 'Generate and send your patch to the Git mailing list'

I've edited the text of old section 3 to make it more concise (using
'make sure' for emphasis just once before presenting the requirements
list).
---
 Documentation/SubmittingPatches | 44 +++++++++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 15 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 6dca41d..9735236 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -117,29 +117,43 @@ without external resources. Instead of giving a URL to a mailing list
 archive, summarize the relevant points of the discussion.
 
 
-(3) Generate your patch using Git tools out of your commits.
-
-
-Please make sure your patch does not add commented out debugging code,
-or include any extra files which do not relate to what your patch
-is trying to achieve. Make sure to review
-your patch after generating it, to ensure accuracy.  Before
-sending out, please make sure it cleanly applies to the "master"
-branch head.  If you are preparing a work based on "next" branch,
-that is fine, but please mark it as such.
-
-
-(4) Sending your patches.
+(3) Generate and send your patch to the Git mailing list
 
 People on the Git mailing list need to be able to read and
 comment on the changes you are submitting.  It is important for
 a developer to be able to "quote" your changes, using standard
 e-mail tools, so that they may comment on specific portions of
 your code.  For this reason, each patch should be submitted
-"inline" in a separate message.
+"inline" (not as an attachment) in a separate message.
+
+There can be unexpected problems in sending patches:
+
+  . Webmail clients like Gmail generally corrupt whitespace in patches.
+  . messages using HTML-formatting (used by default in many webmail
+    clients) is automatically rejected by the Git mailing list server.
+
+Because of these factors, it's recommended that you use one of these
+specific methods to generate and send your patchs:
+
+  - Generate mail-ready patch files using "git format-patch" and
+    send them using "git send-email" to the Git mailing list.
+    See SubmittingPatchesByMUA for further details.
 
+  - Create a pull request on https://github.com/git/git and
+    use https://submitgit.herokuapp.com/ to send it as a patch series
+    to the mailing list.  Note that the PR is just the place where your
+    patch is born - discussion of the patch should still take place on
+    the Git mailing list.
 
+Please make sure to review your patch before sending it, to ensure that
+it:
 
+  . accurately reflects the change you want to make
+  . does not add commented-out debugging code, or include any extra
+    files which do not relate to what your patch is trying to achieve.
+  . cleanly applies to the "master" branch head.  If you are preparing
+    a work based on "next" branch, that is fine, but please mark it as
+    such.
 
 It is a common convention to prefix your subject line with
 [PATCH].  This lets people easily distinguish patches from other
@@ -186,7 +200,7 @@ patch.
      *2* The mailing list: git@vger.kernel.org
 
 
-(5) Sign your work
+(4) Sign your work
 
 To improve tracking of who did what, we've borrowed the
 "sign-off" procedure from the Linux kernel project on patches

--
https://github.com/git/git/pull/223
