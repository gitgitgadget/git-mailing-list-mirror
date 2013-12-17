From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 3/3] cmd_repack(): remove redundant local variable "nr_packs"
Date: Tue, 17 Dec 2013 14:43:58 +0100
Message-ID: <1387287838-25779-4-git-send-email-mhagger@alum.mit.edu>
References: <1387287838-25779-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 17 14:44:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vsuwx-0003iJ-Mu
	for gcvg-git-2@plane.gmane.org; Tue, 17 Dec 2013 14:44:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753641Ab3LQNof (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Dec 2013 08:44:35 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:48844 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753207Ab3LQNo3 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Dec 2013 08:44:29 -0500
X-AuditID: 12074413-b7fc76d000002aba-43-52b0553dfa13
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id A0.6D.10938.D3550B25; Tue, 17 Dec 2013 08:44:29 -0500 (EST)
Received: from michael.fritz.box (p57A24733.dip0.t-ipconnect.de [87.162.71.51])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id rBHDiIKv024888
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 17 Dec 2013 08:44:28 -0500
X-Mailer: git-send-email 1.8.5.1
In-Reply-To: <1387287838-25779-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRmVeSWpSXmKPExsUixO6iqGsbuiHIYOUmVouuK91MFg29V5gt
	bq+Yz+zA7PH3/Qcmj4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M7YcNej4DF3RfP9u4wNjBs4
	uxg5OSQETCQmNp5igbDFJC7cW8/WxcjFISRwmVFiXudtKOc4k8SbAxPZQarYBHQlFvU0M4HY
	IgJqEhPbDoF1Mws4SGz+3MgIYgsL+Ers+vQWLM4ioCrRde06axcjBwevgIvEzQV2EMsUJPZd
	Ogk2hlPAVeLHnY9gthBQSeOneawTGHkXMDKsYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI118vN
	LNFLTSndxAgJFOEdjLtOyh1iFOBgVOLh3TBjfZAQa2JZcWXuIUZJDiYlUd6zLhuChPiS8lMq
	MxKLM+KLSnNSiw8xSnAwK4nwPggEyvGmJFZWpRblw6SkOViUxHnVlqj7CQmkJ5akZqemFqQW
	wWRlODiUJHinhgA1ChalpqdWpGXmlCCkmTg4QQQXyAYeoA1nQAp5iwsSc4sz0yGKTjEqSonz
	bgBJCIAkMkrz4AbAYvoVozjQP8K8M0CqeIDpAK77FdBgJqDBz9esAxlckoiQkmpgdHT/t/FX
	0EeuPdkc3SvTUxY0HfzUduR8wCy2Z9EikjMzu1K/ex794fTC+/GLmB3rCiqkfaS0Zi1x1Xuq
	cs++xFuvLfDGw66de/vtpDfsPCJy+IRPZKEd0/+9605dD5m1+lvE5td7E6+dPyPy4a2Y6KqU
	+mIb/4flvxO/cpw5d/BpeaJ/SZb9HyWW4oxEQy3mouJEACUKYnvEAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239384>

Its value is the same as the number of entries in the "names"
string_list, so just use "names.nr" in its place.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
This is just a trivial simplification.  Take it or leave it.

 builtin/repack.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index a0ff5c7..91e2363 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -123,7 +123,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	struct string_list rollback = STRING_LIST_INIT_NODUP;
 	struct string_list existing_packs = STRING_LIST_INIT_DUP;
 	struct strbuf line = STRBUF_INIT;
-	int nr_packs, ext, ret, failed;
+	int ext, ret, failed;
 	FILE *out;
 
 	/* variables to be filled by option parsing */
@@ -233,13 +233,11 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	if (ret)
 		return ret;
 
-	nr_packs = 0;
 	out = xfdopen(cmd.out, "r");
 	while (strbuf_getline(&line, out, '\n') != EOF) {
 		if (line.len != 40)
 			die("repack: Expecting 40 character sha1 lines only from pack-objects.");
 		string_list_append(&names, line.buf);
-		nr_packs++;
 	}
 	fclose(out);
 	ret = finish_command(&cmd);
@@ -247,7 +245,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		return ret;
 	argv_array_clear(&cmd_args);
 
-	if (!nr_packs && !quiet)
+	if (!names.nr && !quiet)
 		printf("Nothing new to pack.\n");
 
 	/*
-- 
1.8.5.1
