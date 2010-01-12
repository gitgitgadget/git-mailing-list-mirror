From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 07/18] parse-options.c: mark file-local function static
Date: Mon, 11 Jan 2010 23:52:50 -0800
Message-ID: <1263282781-25596-8-git-send-email-gitster@pobox.com>
References: <1263282781-25596-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 12 08:55:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUbaX-00056x-Eq
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 08:54:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753428Ab0ALHx2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2010 02:53:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753413Ab0ALHxY
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 02:53:24 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41058 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751277Ab0ALHxX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2010 02:53:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DA6F48E890
	for <git@vger.kernel.org>; Tue, 12 Jan 2010 02:53:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=6cda
	u6OTgSJkzoeCZNn3j6QUjEs=; b=uKN4DxLcM8SSRsA5ynB1youSzsdcIjkzw8GN
	MoGXZwGlhrrpfZt5p5JRoCwvZXZRFUK0zHdTYvKIDTgGLs1I0e2sWMsKqs5B1Wox
	O78iaF3oaISguiMkeKmlOuGOvLK0gLgFCdrO5dSNfYzlChS0tR1FF6U2T5zzfOPp
	k48Yl0E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=nO1Hqa
	XT5evAK+ZpIQ8pdiK9D0GuPVi3b1+w1YgOYIMze1gJTwyrAqnGD10q2n249YuDM3
	5kBSuGxftqkIyvRRTh49EpkX1Vqyalt2N+7b8e1KM0g51GKUiN200rQu9NeMQyEd
	1st/VVxveHvBehMN9/tI2nRSp6DJ7tVYnDzM0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D67DA8E88F
	for <git@vger.kernel.org>; Tue, 12 Jan 2010 02:53:22 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6BCEF8E88E for
 <git@vger.kernel.org>; Tue, 12 Jan 2010 02:53:22 -0500 (EST)
X-Mailer: git-send-email 1.6.6.280.ge295b7.dirty
In-Reply-To: <1263282781-25596-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 8EA6ADB6-FF4F-11DE-8A02-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136701>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 parse-options.c |    7 +++++--
 parse-options.h |    3 ---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index f559411..7bbed5f 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -3,6 +3,9 @@
 #include "cache.h"
 #include "commit.h"
 
+static int parse_options_usage(const char * const *usagestr,
+			       const struct option *opts);
+
 #define OPT_SHORT 1
 #define OPT_UNSET 2
 
@@ -560,8 +563,8 @@ void usage_msg_opt(const char *msg,
 	usage_with_options(usagestr, options);
 }
 
-int parse_options_usage(const char * const *usagestr,
-			const struct option *opts)
+static int parse_options_usage(const char * const *usagestr,
+			       const struct option *opts)
 {
 	return usage_with_options_internal(usagestr, opts, 0);
 }
diff --git a/parse-options.h b/parse-options.h
index f295a2c..72fa360 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -171,9 +171,6 @@ struct parse_opt_ctx_t {
 	const char *prefix;
 };
 
-extern int parse_options_usage(const char * const *usagestr,
-			       const struct option *opts);
-
 extern void parse_options_start(struct parse_opt_ctx_t *ctx,
 				int argc, const char **argv, const char *prefix,
 				int flags);
-- 
1.6.6.280.ge295b7.dirty
