Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E28C82018B
	for <e@80x24.org>; Wed, 22 Jun 2016 20:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbcFVUUW (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 16:20:22 -0400
Received: from mout.gmx.net ([212.227.17.22]:57566 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750787AbcFVUUV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 16:20:21 -0400
Received: from virtualbox ([37.24.143.194]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MEo4s-1b8cZv2SzK-00Fxap; Wed, 22 Jun 2016 22:20:17
 +0200
Date:	Wed, 22 Jun 2016 22:20:16 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 1/2] Make the skip_blank_lines() function public
In-Reply-To: <cover.1466626795.git.johannes.schindelin@gmx.de>
Message-ID: <293bdb45f4a7c8b635ec246763346710ff4e3111.1466626795.git.johannes.schindelin@gmx.de>
References: <cover.1466587806.git.johannes.schindelin@gmx.de> <cover.1466626795.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:1sYFxtu6HQTlvlC7CIiIJr3yEPE9Y2wfhYR1RwNkMMRTbPLQLjb
 e81/+1WsEuJwALvNVBSOATeJiltv58PRu2Qqe8Y6Oe9w/YYRbe68yxszkwz3G9Rdr39xcLj
 3Cg6NGjkjL/E+Qv/SvIpChS0peyhFVTzUdXQebi1jnW1SQoowBSQiazpRoKMh0lj5PrQ84O
 0oqZgo/Epen6inl8lsRGA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:Z9FENrrVLjo=:tVLBDUvH+a9PTd9iWkhtVO
 DVL7EYEMRgwlLeARFKXezQQN4a2Zu15ln35XbBWaAkt41fkeuBFqLrKpnwOhW2KHhIgIkUzhv
 FpnoI9008LSzacqq6LhSnmszi+QcJTABxNUFZgb8/k7tS7Tvtkr1LtJ9Z3q4yaxSuBQUA2XWD
 WBHx58888DEC+piIZXTQHwrg2JSj7GYg9JEyqDtq7UgBRaA3G316mr5PDanJfA65wi/0sGN7y
 Q45CqapDtkmHbi2TsHuIw4XPjrMC7N2BQ1J5ezr9FZBPfHchtmCcOM9iVGX3RVRa9wz6vkzL6
 YICjq29GkqFhU5CbdpGkLeCQ1/ZyAOIYGy3cN8mDhip+NqR8ZdoS7i69PJB3ZU7kFCXnfO6Uq
 3sD69V3iWpoBxDw1GtPGEYcJ4eNo4f7AVNrsw+DAA2gDvkWlfob5bSpFSlI8GVidHFQqGdXmC
 U6kXPc89ZTCK+rNeJt6gD+LrLUnYBFkCYlrzED96vqvay3281Zk6+7KC/3hYPzoNmoPY2K8qd
 mZSK9mW7lfiK5k/WTGusPwIbDSBLv/BNJPWwcPj7KLsVv3UMUbumT2JRUWFnqGgSVyD/o099t
 buVUsmoiEmJ7twDRVSrhPaP16U95yWgIJIbhkKud25Udqb2Q1C3gvIENzG1PFlK6MC9N/N8pp
 6KI6UG++yEqSR4/3lQ/WZBenIAlkJoRsb3DD9lEAR2/DC9lzYFHg22fCmOH56fAy3ohIMt7Gq
 kiPiAH7IdeVGPK+UHs0NDjv2XvIIztr2ZEp/zOcdCJWe18UzPdZ3lTRrigkNlExn8/IBuQSQX
 E3Z44Zd
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This function will be used also in the find_commit_subject() function.

While at it, rename the function to reflect that it skips not only
empty lines, but any lines consisting of only whitespace, too.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 commit.h |  1 +
 pretty.c | 16 ++++++++--------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/commit.h b/commit.h
index b06db4d..5b78f83 100644
--- a/commit.h
+++ b/commit.h
@@ -177,6 +177,7 @@ extern const char *format_subject(struct strbuf *sb, const char *msg,
 				  const char *line_separator);
 extern void userformat_find_requirements(const char *fmt, struct userformat_want *w);
 extern int commit_format_is_empty(enum cmit_fmt);
+extern const char *skip_blank_lines(const char *msg);
 extern void format_commit_message(const struct commit *commit,
 				  const char *format, struct strbuf *sb,
 				  const struct pretty_print_context *context);
diff --git a/pretty.c b/pretty.c
index c3ec430..3b6bff7 100644
--- a/pretty.c
+++ b/pretty.c
@@ -507,7 +507,7 @@ void pp_user_info(struct pretty_print_context *pp,
 	}
 }
 
-static int is_empty_line(const char *line, int *len_p)
+static int is_blank_line(const char *line, int *len_p)
 {
 	int len = *len_p;
 	while (len && isspace(line[len - 1]))
@@ -516,14 +516,14 @@ static int is_empty_line(const char *line, int *len_p)
 	return !len;
 }
 
-static const char *skip_empty_lines(const char *msg)
+const char *skip_blank_lines(const char *msg)
 {
 	for (;;) {
 		int linelen = get_one_line(msg);
 		int ll = linelen;
 		if (!linelen)
 			break;
-		if (!is_empty_line(msg, &ll))
+		if (!is_blank_line(msg, &ll))
 			break;
 		msg += linelen;
 	}
@@ -875,7 +875,7 @@ const char *format_subject(struct strbuf *sb, const char *msg,
 		int linelen = get_one_line(line);
 
 		msg += linelen;
-		if (!linelen || is_empty_line(line, &linelen))
+		if (!linelen || is_blank_line(line, &linelen))
 			break;
 
 		if (!sb)
@@ -894,11 +894,11 @@ static void parse_commit_message(struct format_commit_context *c)
 	const char *msg = c->message + c->message_off;
 	const char *start = c->message;
 
-	msg = skip_empty_lines(msg);
+	msg = skip_blank_lines(msg);
 	c->subject_off = msg - start;
 
 	msg = format_subject(NULL, msg, NULL);
-	msg = skip_empty_lines(msg);
+	msg = skip_blank_lines(msg);
 	c->body_off = msg - start;
 
 	c->commit_message_parsed = 1;
@@ -1711,7 +1711,7 @@ void pp_remainder(struct pretty_print_context *pp,
 		if (!linelen)
 			break;
 
-		if (is_empty_line(line, &linelen)) {
+		if (is_blank_line(line, &linelen)) {
 			if (first)
 				continue;
 			if (pp->fmt == CMIT_FMT_SHORT)
@@ -1782,7 +1782,7 @@ void pretty_print_commit(struct pretty_print_context *pp,
 	}
 
 	/* Skip excess blank lines at the beginning of body, if any... */
-	msg = skip_empty_lines(msg);
+	msg = skip_blank_lines(msg);
 
 	/* These formats treat the title line specially. */
 	if (pp->fmt == CMIT_FMT_ONELINE || pp->fmt == CMIT_FMT_EMAIL)
-- 
2.9.0.118.g0e1a633


