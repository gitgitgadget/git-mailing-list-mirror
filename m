From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH v2 3/4] run-command: call run_command_v_opt_cd_env() instead
 of duplicating it
Date: Tue, 19 Aug 2014 21:11:00 +0200
Message-ID: <53F3A144.4030307@web.de>
References: <53EFE15B.7030805@web.de> <53F05DE2.5080806@kdbg.org>	<20140817084832.GL23808@peff.net> <xmqq61hpybs9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 19 21:11:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJoot-0005Mn-IX
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 21:11:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753606AbaHSTLp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 15:11:45 -0400
Received: from mout.web.de ([212.227.15.3]:55902 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753510AbaHSTLo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 15:11:44 -0400
Received: from [192.168.178.27] ([79.250.174.3]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0Ma2hT-1X4mEx3tpn-00LjJp; Tue, 19 Aug 2014 21:11:29
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <xmqq61hpybs9.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:yokwcNxGgaVG7eH6shDvZokD/gnteVUqyBNnOgTQjiVB9e9H4XK
 OuS1uS//Air5rmAeTkC3bJIBCefxSqxu8PFfkdXelgvl6fi1w0NlVa+xDi041tTOX+gfXP4
 JOW48nnYNU+T07W3lnSX1pAO5M47/2i0vNYxDG8RdPZ8jjS9etyStelFepxC0HTO+0B1g+C
 pRtQvNobZBZvAvJxjIZ+Q==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255510>

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 run-command.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/run-command.c b/run-command.c
index 47ab21b..9196ee0 100644
--- a/run-command.c
+++ b/run-command.c
@@ -577,9 +577,7 @@ static void prepare_run_command_v_opt(struct child_process *cmd,
 
 int run_command_v_opt(const char **argv, int opt)
 {
-	struct child_process cmd;
-	prepare_run_command_v_opt(&cmd, argv, opt);
-	return run_command(&cmd);
+	return run_command_v_opt_cd_env(argv, opt, NULL, NULL);
 }
 
 int run_command_v_opt_cd_env(const char **argv, int opt, const char *dir, const char *const *env)
-- 
2.1.0
