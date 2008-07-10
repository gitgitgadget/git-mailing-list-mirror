From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Teach merge.log to "git-merge" again
Date: Thu, 10 Jul 2008 00:50:59 -0700
Message-ID: <7v7ibuqisc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Thu Jul 10 09:52:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGqwv-0001mJ-Ck
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 09:52:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752088AbYGJHvU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 03:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751953AbYGJHvU
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 03:51:20 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43391 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751906AbYGJHvT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 03:51:19 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 8766024F06;
	Thu, 10 Jul 2008 03:51:17 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A497B24F04; Thu, 10 Jul 2008 03:51:11 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FA57DB82-4E54-11DD-A572-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87956>

The command forgot the configuration variable when rewritten in C.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-merge.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/builtin-merge.c b/builtin-merge.c
index 821edcd..bc3f921 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -519,8 +519,10 @@ int git_merge_config(const char *k, const char *v, void *cb)
 	else if (!strcmp(k, "pull.twohead"))
 		return git_config_string(&pull_twohead, k, v);
 	else if (!strcmp(k, "pull.octopus"))
 		return git_config_string(&pull_octopus, k, v);
+	else if (!strcmp(k, "merge.log") || !strcmp(k, "merge.summary"))
+		option_log = git_config_bool(k, v);
 	return git_diff_ui_config(k, v, cb);
 }
 
 static int read_tree_trivial(unsigned char *common, unsigned char *head,
