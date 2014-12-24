From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH] commit-tree: simplify parsing of option -S using skip_prefix()
Date: Wed, 24 Dec 2014 01:18:11 +0100
Message-ID: <549A0643.8090202@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 24 01:18:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3Zep-0004hh-Ov
	for gcvg-git-2@plane.gmane.org; Wed, 24 Dec 2014 01:18:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756643AbaLXAS1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2014 19:18:27 -0500
Received: from mout.web.de ([212.227.15.14]:54074 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751297AbaLXAS0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2014 19:18:26 -0500
Received: from [192.168.178.27] ([79.253.147.237]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0M0yvn-1XkoHT49aJ-00v9oH; Wed, 24 Dec 2014 01:18:21
 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
X-Provags-ID: V03:K0:hTaurtunOU/dMXyzVEByx5O4iT8eJxOSkyS4Ozdm/lFtwqvuF1v
 cJt9Stf5Z2TImT7cZBZ5r5SZvpdbQ31C+zLEFiDuUVI7nrYUnbx/w3x7elZ379eN8uWmAMN
 lwQQ8YrTRWS5CX9zmE3RgmCW6NTF+Ga+tPT+CWj4PbG61ppzb0xlO9kt7Kgs1wDvHEwZDfF
 e5GEZrPWFcBp3S6O396zQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261781>

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/commit-tree.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index 8a66c74..25aa2cd 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -66,10 +66,8 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 
-		if (!memcmp(arg, "-S", 2)) {
-			sign_commit = arg + 2;
+		if (skip_prefix(arg, "-S", &sign_commit))
 			continue;
-		}
 
 		if (!strcmp(arg, "--no-gpg-sign")) {
 			sign_commit = NULL;
-- 
2.2.1
