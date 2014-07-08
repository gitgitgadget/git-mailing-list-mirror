From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] line-log: use commit_list_append() instead of duplicating
 its code
Date: Tue, 08 Jul 2014 18:23:37 +0200
Message-ID: <53BC1B09.1020801@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Thomas Rast <tr@thomasrast.ch>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 08 18:23:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4YBH-0003Tl-O3
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jul 2014 18:23:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755116AbaGHQXm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2014 12:23:42 -0400
Received: from mout.web.de ([212.227.17.12]:63957 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754121AbaGHQXl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2014 12:23:41 -0400
Received: from [192.168.178.27] ([79.253.167.50]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0Lylrf-1WZhdN45Sx-0167VP; Tue, 08 Jul 2014 18:23:39
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
X-Provags-ID: V03:K0:M7TwnsmS7oVDyrdduAXNWzK+3XSOqZOfff4az94lEiwzV+a+hbM
 jZ14Ygb9elMvRwvERGqHBMvBWA9NN7fy28xDEmwG64etH/CwKU8I37RhvUbO5AuyUO6gybg
 OkZpocEH/SUEXqqPsYPQD7Q2Ka3hEG1aq6cVI21SsROFQEpTxItulLpMCHSlnNuAhhPhTtg
 BSbkT8HG8LaKwfY4OBWrg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253032>

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 line-log.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/line-log.c b/line-log.c
index 1500101..afcc98d 100644
--- a/line-log.c
+++ b/line-log.c
@@ -1174,9 +1174,7 @@ static int process_ranges_merge_commit(struct rev_info *rev, struct commit *comm
 			 */
 			add_line_range(rev, parents[i], cand[i]);
 			clear_commit_line_range(rev, commit);
-			commit->parents = xmalloc(sizeof(struct commit_list));
-			commit->parents->item = parents[i];
-			commit->parents->next = NULL;
+			commit_list_append(parents[i], &commit->parents);
 			free(parents);
 			free(cand);
 			free_diffqueues(nparents, diffqueues);
-- 
2.0.0
