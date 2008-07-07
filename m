From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (topics)
Date: Sun, 06 Jul 2008 18:36:01 -0700
Message-ID: <7vtzf2a326.fsf@gitster.siamese.dyndns.org>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org>
 <7vr6d8apjx.fsf@gitster.siamese.dyndns.org>
 <7vhcdyfe9u.fsf@gitster.siamese.dyndns.org>
 <7vabjm1a0q.fsf@gitster.siamese.dyndns.org>
 <7vr6crj0jk.fsf@gitster.siamese.dyndns.org>
 <7vmyn4hr8f.fsf@gitster.siamese.dyndns.org>
 <7vmymsjz6x.fsf@gitster.siamese.dyndns.org>
 <7vabijxhk4.fsf@gitster.siamese.dyndns.org>
 <7vwslhg8qe.fsf@gitster.siamese.dyndns.org>
 <7vhccfiksy.fsf@gitster.siamese.dyndns.org>
 <7vod6k6zg4.fsf@gitster.siamese.dyndns.org>
 <7v4p7xwsfp.fsf@gitster.siamese.dyndns.org>
 <7v3anb19n7.fsf@gitster.siamese.dyndns.org>
 <7vwskjazql.fsf@gitster.siamese.dyndns.org>
 <7vk5ggipuw.fsf@gitster.siamese.dyndns.org>
 <7vej6l3lp7.fsf@gitster.siamese.dyndns.org>
 <7vod5kd3im.fsf@gitster.siamese.dyndns.org>
 <7v3amv1e8n.fsf@gitster.siamese.dyndns.org>
 <7vprpwhp7t.fsf@gitster.siamese.dyndns.org>
 <7vlk0ffhw3.fsf@gitster.siamese.dyndns.org>
 <alpine.LSU.1.00.0807061309140.32725@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 07 03:37:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFffK-000532-9K
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 03:37:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752428AbYGGBgT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 21:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752432AbYGGBgT
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 21:36:19 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35936 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752205AbYGGBgS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2008 21:36:18 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E41F323D0E;
	Sun,  6 Jul 2008 21:36:14 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id BE27223D0D; Sun,  6 Jul 2008 21:36:08 -0400 (EDT)
In-Reply-To: <alpine.LSU.1.00.0807061309140.32725@wbgn129.biozentrum.uni-wuerzburg.de>
 (Johannes Schindelin's message of "Sun, 6 Jul 2008 13:10:06 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1681A97E-4BC5-11DD-88BE-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87570>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sun, 6 Jul 2008, Junio C Hamano wrote:
>
>> * js/apply-root (Wed Jul 2 15:28:22 2008 -0700) 2 commits
>>  + apply --root: thinkofix.
>>  + Teach "git apply" to prepend a prefix with "--root=<root>"
>
> If we want to call this "--directory=<root>" instead, we should do it 
> before that commit hits master.

Yeah, perhaps like this?

-- >8 --
git-apply --directory: make --root more similar to GNU diff

Applying a patch in the directory that is different from what the patch
records is done with --directory option in GNU diff.  The --root option we
introduced previously does the same, and we can call it the same way to
give users more familiar feel.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-apply.txt |    8 ++++++--
 builtin-apply.c             |    4 ++--
 t/t4128-apply-root.sh       |    8 ++++----
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index 63fce53..3cd3179 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 	  [--allow-binary-replacement | --binary] [--reject] [-z]
 	  [-pNUM] [-CNUM] [--inaccurate-eof] [--cached]
 	  [--whitespace=<nowarn|warn|fix|error|error-all>]
-	  [--exclude=PATH] [--root=<root>] [--verbose] [<patch>...]
+	  [--exclude=PATH] [--directory=<root>] [--verbose] [<patch>...]
 
 DESCRIPTION
 -----------
@@ -177,9 +177,13 @@ behavior:
 	current patch being applied will be printed. This option will cause
 	additional information to be reported.
 
---root=<root>::
+--directory=<root>::
 	Prepend <root> to all filenames.  If a "-p" argument was passed, too,
 	it is applied before prepending the new root.
++
+For example, a patch that talks about updating `a/git-gui.sh` to `b/git-gui.sh`
+can be applied to the file in the working tree `modules/git-gui/git-gui.sh` by
+running `git apply --directory=modules/git-gui`.
 
 Configuration
 -------------
diff --git a/builtin-apply.c b/builtin-apply.c
index 6c3db60..c242bbd 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -3130,8 +3130,8 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
 			inaccurate_eof = 1;
 			continue;
 		}
-		if (!prefixcmp(arg, "--root=")) {
-			arg += strlen("--root=");
+		if (!prefixcmp(arg, "--directory=")) {
+			arg += strlen("--directory=");
 			root_len = strlen(arg);
 			if (root_len && arg[root_len - 1] != '/') {
 				char *new_root;
diff --git a/t/t4128-apply-root.sh b/t/t4128-apply-root.sh
index b650245..2dd0c75 100755
--- a/t/t4128-apply-root.sh
+++ b/t/t4128-apply-root.sh
@@ -23,18 +23,18 @@ diff a/bla/blub/dir/file b/bla/blub/dir/file
 +Bello
 EOF
 
-test_expect_success 'apply --root -p (1)' '
+test_expect_success 'apply --directory -p (1)' '
 
-	git apply --root=some/sub -p3 --index patch &&
+	git apply --directory=some/sub -p3 --index patch &&
 	test Bello = $(git show :some/sub/dir/file) &&
 	test Bello = $(cat some/sub/dir/file)
 
 '
 
-test_expect_success 'apply --root -p (2) ' '
+test_expect_success 'apply --directory -p (2) ' '
 
 	git reset --hard initial &&
-	git apply --root=some/sub/ -p3 --index patch &&
+	git apply --directory=some/sub/ -p3 --index patch &&
 	test Bello = $(git show :some/sub/dir/file) &&
 	test Bello = $(cat some/sub/dir/file)
 
