Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D3591F404
	for <e@80x24.org>; Thu,  5 Apr 2018 22:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752414AbeDEWso (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Apr 2018 18:48:44 -0400
Received: from mout.gmx.net ([212.227.17.21]:51631 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751722AbeDEWsn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Apr 2018 18:48:43 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MCwbX-1fChsL3GCJ-009feZ; Fri, 06
 Apr 2018 00:48:38 +0200
Date:   Fri, 6 Apr 2018 00:48:38 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/4] color: introduce support for colorizing stderr
In-Reply-To: <cover.1522968472.git.johannes.schindelin@gmx.de>
Message-ID: <8cae2e4c924bab3696f2cf72c4dc4ec49b893c0b.1522968472.git.johannes.schindelin@gmx.de>
References: <cover.1518783709.git.johannes.schindelin@gmx.de> <cover.1522968472.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:M5/70FQCL4OItfhaj4iyEUrUfs/fCOc3cGheUP3Zp1G6rkyd9Ff
 QSDb2saDcTOPXyIobgZOwtVdSTwtTjDiSfRgWCqFPWs620ybBEP0Y6CxkYxqwMQ6Q0kKnAH
 522Ysj8KlOXwWfU6UXNCRZAKgogXwygZhxJxTTzeWnDxiub+mhfEB60MNkmBD6r2Ynp+kWi
 Y6oeg53Oompnz7mh87GOQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZFZjnUrkqRg=:lqUiD5GFZA8mz5W8UrCYf+
 /tG1uUffV255LObTTOJIKlZRNXzjhc6NxSB8yGxfam1DehIRo9+m2gVbHiKpOcQHht+vK8KfS
 1S8oPlNgbavCIGz3FQSEPee0RDCshqxrVTT2sjwn0q8Y3nC+28/bS9oq5ynw7VCpltG8OqS4H
 3PIFcd0JTOjYAN7XH1gYtU7qxfG4TYXW3D1IHTps+dFhpOV7HNNj/qRwVhO5bGTpumwYDpCXL
 ShL7mqwuZq9LKP4aTeVHfbK6duWrmelsH6uIh+B/ggZN8L4hqD0tnCW4HFDraevfVPknAcVt5
 /EUyOOt6DrtRV8p1TgRNlufU1i1eUmEA8VzM3719wfVVUvQ6atCzGL7PGom2jwUeoxEA0I0+h
 ea84am9JfqXCWWUGRZVP8oOqlVORIM2eOvLihoA5dVDVx6BOgw2Swb8vry67kRsMK8oBMqrX+
 xeZNFGcmGbUVegTvmqljY2Ggts/ZtVuDdtXJiuZqDJeprHaR1yStNPYD/57LxgZPbxq7boWuv
 k/+jLFZkAVKA0zhLLrEwB+ZUaVjdmALiNVFMzjPeeAkdSeTB8knXzzU++DKhN3IbEq+622XWa
 /3LlPJnCjOGoNlFksJQBMHWY7EPM7DjFURJxgsbkjyafSY8mDMS6LxwKxiGOtYMXWLIZxqDAC
 VAPvHHP2iRl6wSmMwxeQ7nr5+iQBe0c3h+Ak+4hXU8RNXipG8eUGgbNXtL0GvyHji7aODWSMR
 nrg1K0DZ5uQtC0cTSn98IfzRmJ7t+i1y98kbpGvcDgYuJc/TqBTFR+MY4gPxQNBPWD7grNS8f
 3kfPSUaG3bhC/icQDaVZD258RB2Y/NQuDtWbUk9L7j+VTwsAlSI6eDsiCcrWA2JWHFQBfXi
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So far, we only ever asked whether stdout wants to be colorful. In the
upcoming patches, we will want to make push errors more prominent, which
are printed to stderr, though.

So let's refactor the want_color() function into a want_color_fd()
function (which expects to be called with fd == 1 or fd == 2 for stdout
and stderr, respectively), and then define the macro `want_color()` to
use the want_color_fd() function.

And then also add a macro `want_color_stderr()`, for convenience and
for documentation.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 color.c | 20 +++++++++++---------
 color.h |  4 +++-
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/color.c b/color.c
index f277e72e4ce..c6c6c4f580f 100644
--- a/color.c
+++ b/color.c
@@ -319,18 +319,20 @@ int git_config_colorbool(const char *var, const char *value)
 	return GIT_COLOR_AUTO;
 }
 
-static int check_auto_color(void)
+static int check_auto_color(int fd)
 {
-	if (color_stdout_is_tty < 0)
-		color_stdout_is_tty = isatty(1);
-	if (color_stdout_is_tty || (pager_in_use() && pager_use_color)) {
+	static int color_stderr_is_tty = -1;
+	int *is_tty_p = fd == 1 ? &color_stdout_is_tty : &color_stderr_is_tty;
+	if (*is_tty_p < 0)
+		*is_tty_p = isatty(fd);
+	if (*is_tty_p || (fd == 1 && pager_in_use() && pager_use_color)) {
 		if (!is_terminal_dumb())
 			return 1;
 	}
 	return 0;
 }
 
-int want_color(int var)
+int want_color_fd(int fd, int var)
 {
 	/*
 	 * NEEDSWORK: This function is sometimes used from multiple threads, and
@@ -339,15 +341,15 @@ int want_color(int var)
 	 * is listed in .tsan-suppressions for the time being.
 	 */
 
-	static int want_auto = -1;
+	static int want_auto[3] = { -1, -1, -1 };
 
 	if (var < 0)
 		var = git_use_color_default;
 
 	if (var == GIT_COLOR_AUTO) {
-		if (want_auto < 0)
-			want_auto = check_auto_color();
-		return want_auto;
+		if (want_auto[fd] < 0)
+			want_auto[fd] = check_auto_color(fd);
+		return want_auto[fd];
 	}
 	return var;
 }
diff --git a/color.h b/color.h
index cd0bcedd084..5b744e1bc68 100644
--- a/color.h
+++ b/color.h
@@ -88,7 +88,9 @@ int git_config_colorbool(const char *var, const char *value);
  * Return a boolean whether to use color, where the argument 'var' is
  * one of GIT_COLOR_UNKNOWN, GIT_COLOR_NEVER, GIT_COLOR_ALWAYS, GIT_COLOR_AUTO.
  */
-int want_color(int var);
+int want_color_fd(int fd, int var);
+#define want_color(colorbool) want_color_fd(1, (colorbool))
+#define want_color_stderr(colorbool) want_color_fd(2, (colorbool))
 
 /*
  * Translate a Git color from 'value' into a string that the terminal can
-- 
2.17.0.windows.1.4.g7e4058d72e3


