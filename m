From: Benoit Pierre <benoit.pierre@gmail.com>
Subject: [PATCH 1/2] status: allow NULL fmt for status_printf/status_vprintf_ln
Date: Mon, 10 Mar 2014 20:27:26 +0100
Message-ID: <1394479647-22361-2-git-send-email-benoit.pierre@gmail.com>
References: <1394479647-22361-1-git-send-email-benoit.pierre@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 10 20:27:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WN5rb-0003T4-7N
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 20:27:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753479AbaCJT1l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 15:27:41 -0400
Received: from mail-wg0-f48.google.com ([74.125.82.48]:55724 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752673AbaCJT1j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 15:27:39 -0400
Received: by mail-wg0-f48.google.com with SMTP id l18so4912936wgh.19
        for <git@vger.kernel.org>; Mon, 10 Mar 2014 12:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=m286VheZaSkZu+HH5zIoWgeuDZ1249K6M7kzEN8oZI8=;
        b=YsH9jV+ekhztAHptPrQR32ZWPUDYIl4Mt6i8eoT4QQNpRus1Mg4TDRUVl1enSfKAYa
         Dk9/wskAYgGArTsBBXxhF/8ye63ysvy1fQhGDQGyOmBLPN2TGZrxH+C4dG3uHP48xoE+
         ysEgIOiRRfZRa/pMgG190R6EUAdFULeYeGVR83wx4mGZKzbSYnAYfdEl2lUeS8NbpEnL
         JfmmzktM55VDUBPUkxdXPDzspboDkFVZ4zFv741Y1i+m4Tb2KlnJC42EYsyyCxRNiZoN
         OvLLgncpPojvD6q9n5mA6OeKGKFWLfdde4AIvgMdtqbuCZIHxCyWE8suWwPW4iEZOkSS
         8Fyw==
X-Received: by 10.194.219.132 with SMTP id po4mr33642553wjc.7.1394479658784;
        Mon, 10 Mar 2014 12:27:38 -0700 (PDT)
Received: from localhost (109.12.70.86.rev.sfr.net. [86.70.12.109])
        by mx.google.com with ESMTPSA id q15sm54894626wjw.18.2014.03.10.12.27.37
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Mar 2014 12:27:38 -0700 (PDT)
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1394479647-22361-1-git-send-email-benoit.pierre@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243796>

Useful for calling status_printf only to change/reset the color (and
output an additional '\n' with status_vprintf_ln).

Signed-off-by: Benoit Pierre <benoit.pierre@gmail.com>
---
 wt-status.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/wt-status.c b/wt-status.c
index 4e55810..17f63a4 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -49,7 +49,8 @@ static void status_vprintf(struct wt_status *s, int at_bol, const char *color,
 	struct strbuf linebuf = STRBUF_INIT;
 	const char *line, *eol;
 
-	strbuf_vaddf(&sb, fmt, ap);
+	if (NULL != fmt)
+	    strbuf_vaddf(&sb, fmt, ap);
 	if (!sb.len) {
 		if (s->display_comment_prefix) {
 			strbuf_addch(&sb, comment_line_char);
-- 
1.9.0
