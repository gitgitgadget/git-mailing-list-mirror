From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH 01/21] i18n: builtin/remote.c: fix mark for translation
Date: Wed, 18 May 2016 15:27:34 +0000
Message-ID: <1463585274-9027-2-git-send-email-vascomalmeida@sapo.pt>
References: <1463585274-9027-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 18 17:29:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b33PY-0000Yi-7U
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 17:29:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbcERP3U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 11:29:20 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:58211 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753427AbcERP3T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 11:29:19 -0400
Received: (qmail 19509 invoked from network); 18 May 2016 15:29:16 -0000
Received: (qmail 11284 invoked from network); 18 May 2016 15:29:15 -0000
Received: from unknown (HELO localhost.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 18 May 2016 15:29:10 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1463585274-9027-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294944>

The second string inside _() was not being extracted for translation by
xgettext, meaning that, although the string was passed to gettext, there
was no translation available.

Mark each individual string instead of marking the result of ternary if.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 builtin/remote.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index d33766b..ae74da6 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -963,9 +963,9 @@ static int show_local_info_item(struct string_list_item *item, void *cb_data)
 
 	printf("    %-*s ", show_info->width, item->string);
 	if (branch_info->rebase) {
-		printf_ln(_(branch_info->rebase == INTERACTIVE_REBASE ?
-			"rebases interactively onto remote %s" :
-			"rebases onto remote %s"), merge->items[0].string);
+		printf_ln(branch_info->rebase == INTERACTIVE_REBASE
+			  ? _("rebases interactively onto remote %s")
+			  : _("rebases onto remote %s"), merge->items[0].string);
 		return 0;
 	} else if (show_info->any_rebase) {
 		printf_ln(_(" merges with remote %s"), merge->items[0].string);
-- 
2.7.3
