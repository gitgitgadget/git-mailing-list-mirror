From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH v2 1/3] run-command: name the cleanup function
 child_process_clear()
Date: Sat, 31 Oct 2015 10:19:15 +0100
Message-ID: <56348793.5040909@web.de>
References: <56348709.9080207@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Stefan Beller <sbeller@google.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 31 10:19:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsSJy-0005VM-Pp
	for gcvg-git-2@plane.gmane.org; Sat, 31 Oct 2015 10:19:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752827AbbJaJTa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Oct 2015 05:19:30 -0400
Received: from mout.web.de ([212.227.17.12]:63846 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752645AbbJaJT3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Oct 2015 05:19:29 -0400
Received: from [192.168.178.36] ([79.253.163.201]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0Laky4-1aKxW40oae-00kMTn; Sat, 31 Oct 2015 10:19:20
 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <56348709.9080207@web.de>
X-Provags-ID: V03:K0:bBBPaNmADU6sFkRjoFSPyejK/+e27iFG8uB44+aTwlubhfGPX5L
 6v08SpzYrLkiTIyh7fRHEGSxM3pUzJ0fNAK4EIr59R4V9H1O+jd3ADxe9LOq6q2iJyPRwwF
 GIBucDNUb0MVIwbIiXSlbFIBJgCZaoj251FYyCpHQdPnhB7I7UsR6o8GA45s1KKKJL5EACq
 3yCy0Qt1Z1TErMbuFZL6w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9GIonI7gOJU=:6bHrpCHej7U9jbDhBoyWhC
 DqFHjLlQK42cBJYHj1s8c4gp82yD5niUfJ8u2xI0C/E2Z6vQBrzhxmbQ1og1ug298tSU1vNKf
 65VcxtOYFpcyqijm7kTRnRYFaCc0Xhs6IQFqjQ0K/Q7/JmHGdW8aA4Vd7+7h51zb5tzJpAtMo
 C6MHHsvbgKLWc80yOijom37AHPNIFJGkFy8AbdDGq8/G6qHLwBeZdUw/Mrk/98BNPttEmQoiX
 yqqBhmJsvfugpxZZIZ6UBvmZlSw5r/HoUD+KheWkRsEKjT2b4n00H+48RZk7DoAvfiVOzt5fL
 HkI2TLMCfDPSQ7JH4cvbP4805AsU8cpl7VJ74oBy9cgrWUnVzq17p+H1aOlDie0CG2AeV0O5g
 n3OSOfLrLfNecBI4LgVk0uAsX86ptNe2AadMy0ruoqBgfGVc+5qodhwVwCEYV/CLmuWl6rUFb
 rzxyYSmd1Y2mCPidNVvX43A+/IrZ1KUpq1V2VzBpCy5WotyB05J5kyjrr30sqoJHwJXAaiQ1+
 H8dH/41sPmb5DrkkVEUQ+3kz/ckeuxHdN95ljjPK6C7zQQ5EhiW0Ny76WJUmzaGAhp9tYXvAy
 Oa7lWg7kFnki9lEif3qHV8KWsIBrvq+NH/ywRVl1cW5d5p9qiVhNcFj/C9EUgmHOixVj+j+X4
 +6M+hhyisByPm7kejpWnwAVaAtgPS5WgQYDxeoH7UgDmcpOF6+uXXp/N7iwgGBsp1xjsEhsbz
 CpMPJCUd8Gr7yVGkUJRmtdyd3UJoULgvE63mrZaQ5QRfsRB7vuHBHnk4prHZOyhQTpJG20h+ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280572>

Rename child_process_deinit() to child_process_clear() in order to stay
consistent with similar cleanup functions like argv_array_clear(),
string_list_clear() etc.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 run-command.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/run-command.c b/run-command.c
index 82cc238..b10ec75 100644
--- a/run-command.c
+++ b/run-command.c
@@ -13,7 +13,7 @@ void child_process_init(struct child_process *child)
 	argv_array_init(&child->env_array);
 }
 
-static void child_process_deinit(struct child_process *child)
+static void child_process_clear(struct child_process *child)
 {
 	argv_array_clear(&child->args);
 	argv_array_clear(&child->env_array);
@@ -335,7 +335,7 @@ int start_command(struct child_process *cmd)
 fail_pipe:
 			error("cannot create %s pipe for %s: %s",
 				str, cmd->argv[0], strerror(failed_errno));
-			child_process_deinit(cmd);
+			child_process_clear(cmd);
 			errno = failed_errno;
 			return -1;
 		}
@@ -520,7 +520,7 @@ fail_pipe:
 			close_pair(fderr);
 		else if (cmd->err)
 			close(cmd->err);
-		child_process_deinit(cmd);
+		child_process_clear(cmd);
 		errno = failed_errno;
 		return -1;
 	}
@@ -546,7 +546,7 @@ fail_pipe:
 int finish_command(struct child_process *cmd)
 {
 	int ret = wait_or_whine(cmd->pid, cmd->argv[0], 0);
-	child_process_deinit(cmd);
+	child_process_clear(cmd);
 	return ret;
 }
 
@@ -990,7 +990,7 @@ static void pp_cleanup(struct parallel_processes *pp)
 
 	for (i = 0; i < pp->max_processes; i++) {
 		strbuf_release(&pp->children[i].err);
-		child_process_deinit(&pp->children[i].process);
+		child_process_clear(&pp->children[i].process);
 	}
 
 	free(pp->children);
@@ -1157,7 +1157,7 @@ static int pp_collect_finished(struct parallel_processes *pp)
 		pp->nr_processes--;
 		pp->children[i].in_use = 0;
 		pp->pfd[i].fd = -1;
-		child_process_deinit(&pp->children[i].process);
+		child_process_clear(&pp->children[i].process);
 		child_process_init(&pp->children[i].process);
 
 		if (i != pp->output_owner) {
-- 
2.6.2
