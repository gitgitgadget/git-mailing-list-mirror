From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] format-patch: give --reroll-count a short synonym -v
Date: Wed,  2 Jan 2013 14:42:05 -0800
Message-ID: <1357166525-12188-2-git-send-email-gitster@pobox.com>
References: <1357166525-12188-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 02 23:42:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqX16-0000Yn-NR
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 23:42:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752784Ab3ABWmO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2013 17:42:14 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59539 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752762Ab3ABWmL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2013 17:42:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EC9D9A33D
	for <git@vger.kernel.org>; Wed,  2 Jan 2013 17:42:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=ASPI
	vJwWddhIZGe34NPNSgS6SNw=; b=PeWBuHFuHFrrxdfeD/rMVPlCJQKuHPbTYedi
	L8jNiA+bNT4vaadjwbuhOsB443bw3QsehJJkW9Dgsdd2MUumVpcCOISLLW3JpRkH
	ckF7b/IqwYYhY0Rglr+VyFMspUBRkkQUkkzNSPrhnzNopRwSYq81YKTp76r8cRxV
	tkja+u8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=Fx3B/t
	YkWurvJqLIPw61rTLOAluznoNp9EIKZhQ/O11SXg8z8A1fBL4BVx9FAtYTwdvmlS
	kapy5EAiu746q6yPGqTnazVAN7AVZ1jDdRoPamCRRBIQueM7/fXyFEISAm1ksq0F
	mqbGRIELMvdXapU/XTx9zUED8WZDBi+r9n75A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DDBE1A33C
	for <git@vger.kernel.org>; Wed,  2 Jan 2013 17:42:09 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 699DCA33B for
 <git@vger.kernel.org>; Wed,  2 Jan 2013 17:42:09 -0500 (EST)
X-Mailer: git-send-email 1.8.1.203.gc241474
In-Reply-To: <1357166525-12188-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: A4633D22-552D-11E2-96D5-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212548>

Accept "-v" as a synonym to "--reroll-count", so that users can say
"git format-patch -v4 master", instead of having to fully spell it
out as "git format-patch --reroll-count=4 master".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * As I do not think of a reason why users would want to tell the
   command to be "verbose", I think it may be OK to squat on the
   short and sweet single letter option, but I do not mind dropping
   it.

 Documentation/git-format-patch.txt | 3 ++-
 builtin/log.c                      | 2 +-
 t/t4014-format-patch.sh            | 8 ++++++++
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 736d8bf..ae3212e 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -18,7 +18,7 @@ SYNOPSIS
 		   [--start-number <n>] [--numbered-files]
 		   [--in-reply-to=Message-Id] [--suffix=.<sfx>]
 		   [--ignore-if-in-upstream]
-		   [--subject-prefix=Subject-Prefix] [--reroll-count <n>]
+		   [--subject-prefix=Subject-Prefix] [(--reroll-count|-v) <n>]
 		   [--to=<email>] [--cc=<email>]
 		   [--cover-letter] [--quiet]
 		   [<common diff options>]
@@ -166,6 +166,7 @@ will want to ensure that threading is disabled for `git send-email`.
 	allows for useful naming of a patch series, and can be
 	combined with the `--numbered` option.
 
+-v <n>::
 --reroll-count=<n>::
 	Mark the series as the <n>-th iteration of the topic. The
 	output filenames have `v<n>` pretended to them, and the
diff --git a/builtin/log.c b/builtin/log.c
index e101498..08e8a9d 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1081,7 +1081,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			    N_("use <sfx> instead of '.patch'")),
 		OPT_INTEGER(0, "start-number", &start_number,
 			    N_("start numbering patches at <n> instead of 1")),
-		OPT_INTEGER(0, "reroll-count", &reroll_count,
+		OPT_INTEGER('v', "reroll-count", &reroll_count,
 			    N_("mark the series as Nth re-roll")),
 		{ OPTION_CALLBACK, 0, "subject-prefix", &rev, N_("prefix"),
 			    N_("Use [<prefix>] instead of [PATCH]"),
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 0ff9958..03b8e51 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -245,6 +245,14 @@ test_expect_success 'reroll count' '
 	! grep -v "^Subject: \[PATCH v4 [0-3]/3\] " subjects
 '
 
+test_expect_success 'reroll count (-v)' '
+	rm -fr patches &&
+	git format-patch -o patches --cover-letter -v 4 master..side >list &&
+	! grep -v "^patches/v4-000[0-3]-" list &&
+	sed -n -e "/^Subject: /p" $(cat list) >subjects &&
+	! grep -v "^Subject: \[PATCH v4 [0-3]/3\] " subjects
+'
+
 check_threading () {
 	expect="$1" &&
 	shift &&
-- 
1.8.0.9.g5e84801
