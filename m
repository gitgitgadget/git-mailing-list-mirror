From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] help: include <common-cmds.h> only in one file
Date: Sat, 19 Jan 2013 00:00:31 -0800
Message-ID: <7vpq11ob4w.fsf_-_@alter.siamese.dyndns.org>
References: <1358256924-31578-1-git-send-email-pclouds@gmail.com>
 <7v8v7qsagd.fsf@alter.siamese.dyndns.org>
 <7vmww6qmck.fsf@alter.siamese.dyndns.org>
 <201301182323.55378.avila.jn@gmail.com> <50FA316E.8060807@web.de>
 <7vwqv9obie.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	=?utf-8?Q?Jean-?= =?utf-8?Q?No=C3=ABl?= AVILA 
	<avila.jn@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4g?= =?utf-8?B?VGjDoWkgTmfhu41j?= Duy 
	<pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 19 09:00:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwTMI-0002qT-NM
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jan 2013 09:00:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498Ab3ASIAg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2013 03:00:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41603 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751442Ab3ASIAg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2013 03:00:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 350189241;
	Sat, 19 Jan 2013 03:00:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WEyfXqX0X88Ko8FNJQ2GBNkw+m8=; b=wBD3QB
	+vPSRZAopE13RPWAvdBhHk5dXFIzzzL1Uu27GLHp0lXggopMaxUMdvRA8Yy1v1mH
	8hN87kBjPwc+zBouAiD6HtFjIuIuDS4HKKdtkx7ZnaRF5ttAz2IH+Rm0AkPso9Sv
	E9bpKradghhs8G2LP09Gcb1GgCzM5eb3Nsq+A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=siq5WJVz+5H4uo7bQNzeRuaCHCV0IyQy
	2o7kHwWkel/xD7SrT0O5PWSzg0xwahUUkmPGTb9KJbcrzamsjwvWZtj+goimcp47
	ujBjfVt9L3oR7khZCGxl48+rthgOqsnIipMJJDuTsEQ4DEi8t525zJu3IP8AwJgZ
	WajzpiXt4Co=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2691F923F;
	Sat, 19 Jan 2013 03:00:35 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4E258922A; Sat, 19 Jan 2013
 03:00:33 -0500 (EST)
In-Reply-To: <7vwqv9obie.fsf_-_@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 18 Jan 2013 23:52:25 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4D793EF6-620E-11E2-BCC7-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213963>

This header not only declares but also defines the contents of the
array that holds the list of command names and help text.  Do not
include it in multiple places to waste text space.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is a real "cleanup" patch.

 builtin/help.c | 18 ------------------
 help.c         | 17 +++++++++++++++++
 2 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/builtin/help.c b/builtin/help.c
index bd86253..6067a61 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -6,7 +6,6 @@
 #include "cache.h"
 #include "builtin.h"
 #include "exec_cmd.h"
-#include "common-cmds.h"
 #include "parse-options.h"
 #include "run-command.h"
 #include "column.h"
@@ -287,23 +286,6 @@ static int git_help_config(const char *var, const char *value, void *cb)
 
 static struct cmdnames main_cmds, other_cmds;
 
-void list_common_cmds_help(void)
-{
-	int i, longest = 0;
-
-	for (i = 0; i < ARRAY_SIZE(common_cmds); i++) {
-		if (longest < strlen(common_cmds[i].name))
-			longest = strlen(common_cmds[i].name);
-	}
-
-	puts(_("The most commonly used git commands are:"));
-	for (i = 0; i < ARRAY_SIZE(common_cmds); i++) {
-		printf("   %s   ", common_cmds[i].name);
-		mput_char(' ', longest - strlen(common_cmds[i].name));
-		puts(_(common_cmds[i].help));
-	}
-}
-
 static int is_git_command(const char *s)
 {
 	return is_in_cmdlist(&main_cmds, s) ||
diff --git a/help.c b/help.c
index 2a42ec6..1dfa0b0 100644
--- a/help.c
+++ b/help.c
@@ -223,6 +223,23 @@ void list_commands(unsigned int colopts,
 	}
 }
 
+void list_common_cmds_help(void)
+{
+	int i, longest = 0;
+
+	for (i = 0; i < ARRAY_SIZE(common_cmds); i++) {
+		if (longest < strlen(common_cmds[i].name))
+			longest = strlen(common_cmds[i].name);
+	}
+
+	puts(_("The most commonly used git commands are:"));
+	for (i = 0; i < ARRAY_SIZE(common_cmds); i++) {
+		printf("   %s   ", common_cmds[i].name);
+		mput_char(' ', longest - strlen(common_cmds[i].name));
+		puts(_(common_cmds[i].help));
+	}
+}
+
 int is_in_cmdlist(struct cmdnames *c, const char *s)
 {
 	int i;
-- 
1.8.1.1.454.g48d39c0
