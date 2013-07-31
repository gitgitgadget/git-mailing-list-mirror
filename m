From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCHv2 3/9] log, format-patch: parsing uses OPT__QUIET
Date: Wed, 31 Jul 2013 18:28:31 +0200
Message-ID: <1375288117-1576-4-git-send-email-stefanbeller@googlemail.com>
References: <1375288117-1576-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 31 18:29:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4ZGr-00084w-GV
	for gcvg-git-2@plane.gmane.org; Wed, 31 Jul 2013 18:29:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251Ab3GaQ2y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Jul 2013 12:28:54 -0400
Received: from mail-ea0-f172.google.com ([209.85.215.172]:51745 "EHLO
	mail-ea0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756850Ab3GaQ2a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jul 2013 12:28:30 -0400
Received: by mail-ea0-f172.google.com with SMTP id r16so463858ead.17
        for <git@vger.kernel.org>; Wed, 31 Jul 2013 09:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=dnIAE0BMVJ0eIdmgsNI1CMlCfYXWTaNTbZx6B5+ak0c=;
        b=wXrq7K0GBmlpImOoiKmnDPctBdk7z/pQhroSJ+YNLXNOE5hghaeOwBZoMHu1/p7Zzt
         +V2RFkjYT+6h1/KDIvR9DlU2tXwsGicP311GbBMYDCLJ2ro/zV7ECEShxzNksIceRphm
         AEaWwvi2z3DfvAZi2l4E7hvoGCG1zBoK0HJ7LS2w17PoF8oAro5dQJLL0XDlX7jC3flG
         4LFSKHvsj/egkglIsCGpUKUA1nPGZuxSFOvnhJl4kRTuIfx+M2P3KHA4TFOIhX26URay
         oHSaQ1zvSwyOLX1zn+rKuRu10SD2b0ezKlv3lTx+nyf/xibm/uI+xrsly/eJNdP8gF+g
         vWqA==
X-Received: by 10.15.94.11 with SMTP id ba11mr70304323eeb.101.1375288108951;
        Wed, 31 Jul 2013 09:28:28 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id cg12sm3735796eeb.7.2013.07.31.09.28.27
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 31 Jul 2013 09:28:28 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc0.1.g8f6a3e5
In-Reply-To: <1375288117-1576-1-git-send-email-stefanbeller@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231428>

This patch allows users to use the short form -q on
log and format-patch, which was non possible before.

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 builtin/log.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 1dafbd0..ed4dec4 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -121,7 +121,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 	static struct line_opt_callback_data line_cb = {NULL, NULL, STRING_LIST_INIT_DUP};
 
 	const struct option builtin_log_options[] = {
-		OPT_BOOL(0, "quiet", &quiet, N_("suppress diff output")),
+		OPT__QUIET(&quiet, N_("suppress diff output")),
 		OPT_BOOL(0, "source", &source, N_("show source")),
 		OPT_BOOL(0, "use-mailmap", &mailmap, N_("Use mail map file")),
 		{ OPTION_CALLBACK, 0, "decorate", NULL, NULL, N_("decorate options"),
@@ -1210,8 +1210,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			    PARSE_OPT_OPTARG, thread_callback },
 		OPT_STRING(0, "signature", &signature, N_("signature"),
 			    N_("add a signature")),
-		OPT_BOOLEAN(0, "quiet", &quiet,
-			    N_("don't print the patch filenames")),
+		OPT__QUIET(&quiet, N_("don't print the patch filenames")),
 		OPT_END()
 	};
 
-- 
1.8.4.rc0.1.g8f6a3e5
