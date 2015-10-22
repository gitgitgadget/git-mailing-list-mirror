From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Consider object stores in alternates during a dissociating clone
Date: Thu, 22 Oct 2015 10:50:50 -0700
Message-ID: <xmqqd1w6ssg5.fsf@gitster.mtv.corp.google.com>
References: <561F8DE9.4040703@cetitec.com>
	<alpine.DEB.1.00.1510151609280.31610@s15462909.onlinehome-server.info>
	<561FBA48.3050609@cetitec.com> <56274922.80007@cetitec.com>
	<xmqqpp085cth.fsf@gitster.mtv.corp.google.com>
	<5628EBAF.1030205@cetitec.com>
	<xmqq7fmeubkf.fsf@gitster.mtv.corp.google.com>
	<562911AD.50004@cetitec.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j6t@kdbg.org>
To: Alexander Riesen <alexander.riesen@cetitec.com>
X-From: git-owner@vger.kernel.org Thu Oct 22 19:51:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZpK16-0005P4-Cw
	for gcvg-git-2@plane.gmane.org; Thu, 22 Oct 2015 19:51:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964940AbbJVRvD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2015 13:51:03 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62246 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932428AbbJVRvB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2015 13:51:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5207B24DB5;
	Thu, 22 Oct 2015 13:51:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nIN7atqtixC9jFWBfsxa2cygyCA=; b=GydMM4
	KBZpnSmY7qS+Oj2sxYFQZvZT64JLQrW/PTOVi+PC/6k7/lFVQ38givUUQ25fUW0k
	WhyxR0uRhqSeHNSdbkE2yYsLQy11naHX5++1JRCsIf5gArdkuZTZylCZIEXXFZHb
	i/MMr/5MDHYt6pH+myszh1P6lsakAxgdwSAdo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tMAPoA5nghXIDA5tixbyQPKHbj49tqJd
	pkOv/l6R6aGYkZXfH1fUgJEVAMlcqdE6TfKyn7QEp7TIwY+h50a+D1Al3PYgIdGF
	TYLnF3NlJ9/lyeT3CVHPDgrw4GxJU5hWpWbkoP75dkkHsDzDXDFgGuSbDGu/2Ry1
	cFc1o7WB5d8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 472EE24DB4;
	Thu, 22 Oct 2015 13:51:00 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C6F4924DB3;
	Thu, 22 Oct 2015 13:50:59 -0400 (EDT)
In-Reply-To: <562911AD.50004@cetitec.com> (Alexander Riesen's message of "Thu,
	22 Oct 2015 18:41:17 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 74469C5E-78E5-11E5-8C57-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280066>

Alexander Riesen <alexander.riesen@cetitec.com> writes:

>> Content-Type: text/plain; charset=windows-1252; format=flowed

I had to hand-munge it as the above lost all tabs and made the patch
unusable for machines X-<.

Re-reading the documentation, I realized that the use case this new
mode of operation allows is totally outside of the original design
space that was described, so I added a note to teach users how the
option can be used in a new way as well.

So here is what I tentatively queued.

Thanks.

-- >8 --
From: Alex Riesen <raa.lkml@gmail.com>
Date: Thu, 22 Oct 2015 18:41:17 +0200
Subject: [PATCH] clone: allow "--dissociate" without reference

The "--reference" option is not the only way to provide a repository
to borrow objects from.  A repository that borrows from another
repository can be cloned with "clone --local" and the resulting
repository will borrow from the same repository, which the user
may want to "--dissociate" from.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-clone.txt |  9 +++++++--
 builtin/clone.c             | 16 ++++++++--------
 t/t5700-clone-reference.sh  | 11 +++++++++++
 3 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index f1f2a3f..a8c11e3 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -104,8 +104,13 @@ objects from the source repository into a pack in the cloned repository.
 --dissociate::
 	Borrow the objects from reference repositories specified
 	with the `--reference` options only to reduce network
-	transfer and stop borrowing from them after a clone is made
-	by making necessary local copies of borrowed objects.
+	transfer, and stop borrowing from them after a clone is made
+	by making necessary local copies of borrowed objects.  This
+	option can also be used when cloning locally from a
+	repository that already borrows objects from another
+	repository---the new repository will borrow objects from the
+	same repository, and this option can be used to stop the
+	borrowing.
 
 --quiet::
 -q::
diff --git a/builtin/clone.c b/builtin/clone.c
index 9eaecd9..caae43e 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -801,11 +801,15 @@ static void write_refspec_config(const char *src_ref_prefix,
 static void dissociate_from_references(void)
 {
 	static const char* argv[] = { "repack", "-a", "-d", NULL };
+	char *alternates = git_pathdup("objects/info/alternates");
 
-	if (run_command_v_opt(argv, RUN_GIT_CMD|RUN_COMMAND_NO_STDIN))
-		die(_("cannot repack to clean up"));
-	if (unlink(git_path("objects/info/alternates")) && errno != ENOENT)
-		die_errno(_("cannot unlink temporary alternates file"));
+	if (!access(alternates, F_OK)) {
+		if (run_command_v_opt(argv, RUN_GIT_CMD|RUN_COMMAND_NO_STDIN))
+			die(_("cannot repack to clean up"));
+		if (unlink(alternates) && errno != ENOENT)
+			die_errno(_("cannot unlink temporary alternates file"));
+	}
+	free(alternates);
 }
 
 int cmd_clone(int argc, const char **argv, const char *prefix)
@@ -954,10 +958,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 	if (option_reference.nr)
 		setup_reference();
-	else if (option_dissociate) {
-		warning(_("--dissociate given, but there is no --reference"));
-		option_dissociate = 0;
-	}
 
 	fetch_pattern = value.buf;
 	refspec = parse_fetch_refspec(1, &fetch_pattern);
diff --git a/t/t5700-clone-reference.sh b/t/t5700-clone-reference.sh
index 2250ef4..dfa1bf7 100755
--- a/t/t5700-clone-reference.sh
+++ b/t/t5700-clone-reference.sh
@@ -210,4 +210,15 @@ test_expect_success 'clone, dissociate from partial reference and repack' '
 	test_line_count = 1 packs.txt
 '
 
+test_expect_success 'clone, dissociate from alternates' '
+	rm -fr A B C &&
+	test_create_repo A &&
+	commit_in A file1 &&
+	git clone --reference=A A B &&
+	test_line_count = 1 B/.git/objects/info/alternates &&
+	git clone --local --dissociate B C &&
+	! test -f C/.git/objects/info/alternates &&
+	( cd C && git fsck )
+'
+
 test_done
-- 
2.6.2-383-g4ea3cbc
