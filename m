From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 3/3] commit: show abbreviated sha for commits with empty diffs
Date: Mon, 24 May 2010 17:47:32 +0800
Message-ID: <1274694452-4200-4-git-send-email-rctay89@gmail.com>
References: <1274694452-4200-1-git-send-email-rctay89@gmail.com>
 <1274694452-4200-2-git-send-email-rctay89@gmail.com>
 <1274694452-4200-3-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 24 11:48:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGUGc-0007Tl-Lo
	for gcvg-git-2@lo.gmane.org; Mon, 24 May 2010 11:48:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755424Ab0EXJsF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 May 2010 05:48:05 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:38337 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755359Ab0EXJsD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 May 2010 05:48:03 -0400
Received: by pvg4 with SMTP id 4so716690pvg.19
        for <git@vger.kernel.org>; Mon, 24 May 2010 02:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=KRFgbAy2Zh6ajZ4u+nWEe8wtab3TjQjZuoLuW/glZFM=;
        b=cThaCjx2vdZZMphOz9jHcp/4/dbJBgR3FqONyHCWXlG8n7J1REazLaR0q6NuJgeSbo
         7EQ6hLj51KFVgdnFZ/wNTEBDXfrAaMCSJ1G08lAF9io62VAEqWB1252TrlJuceHygspA
         eJ92FnrdtYxBdKyDdTumy5K0lxQkeywv2w1rg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ZIV5bzGeCGF/S9++h4kHIZ93bzchHI9XjEs4twztNv6F/gweQr1JEr9Qxnzb5N/ws6
         8F2lRkIAXDFvLugujUX/4+7HeYQklyEzngsJ//HL9pcLls1ZIiqUDWsXRBIJ96MZSFPS
         /fTo6t5oqTextJJHGrjIRe2b/oUxbkwdBoeKE=
Received: by 10.115.20.18 with SMTP id x18mr4663161wai.50.1274694475319;
        Mon, 24 May 2010 02:47:55 -0700 (PDT)
Received: from localhost.localdomain (cm218.zeta152.maxonline.com.sg [116.87.152.218])
        by mx.google.com with ESMTPS id n29sm37041273wae.4.2010.05.24.02.47.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 24 May 2010 02:47:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.259.g405af
In-Reply-To: <1274694452-4200-3-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147617>

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 builtin/commit.c  |    1 +
 t/t7502-commit.sh |    4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index a4e4966..ab4a7cf 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1166,6 +1166,7 @@ static void print_summary(const char *prefix, const unsigned char *sha1)
 		struct pretty_print_context ctx = {0};
 		struct strbuf buf = STRBUF_INIT;
 		ctx.date_mode = DATE_NORMAL;
+		ctx.abbrev = DEFAULT_ABBREV;
 		format_commit_message(commit, format.buf + 7, &buf, &ctx);
 		printf("%s\n", buf.buf);
 		strbuf_release(&buf);
diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index 8a4a277..109ae00 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -36,12 +36,12 @@ test_expect_success 'output summary format' '
 	check_summary_oneline "" "a change"
 '
 
-test_expect_failure 'output summary format for commit with an empty diff' '
+test_expect_success 'output summary format for commit with an empty diff' '
 
 	check_summary_oneline "" "empty" "--allow-empty"
 '
 
-test_expect_failure 'output summary format for merges' '
+test_expect_success 'output summary format for merges' '
 
 	git checkout -b recursive-base &&
 	test_commit base file1 &&
-- 
1.7.1.189.g07419
