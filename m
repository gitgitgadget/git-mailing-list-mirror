From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 5/5] show-ref: stop using PARSE_OPT_NO_INTERNAL_HELP
Date: Tue, 17 Nov 2015 11:26:05 +0100
Message-ID: <564B00BD.7010709@web.de>
References: <564AFF32.1030406@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 17 11:27:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZydT2-00054v-6K
	for gcvg-git-2@plane.gmane.org; Tue, 17 Nov 2015 11:26:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753643AbbKQK0X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2015 05:26:23 -0500
Received: from mout.web.de ([212.227.17.11]:58165 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753638AbbKQK0W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2015 05:26:22 -0500
Received: from [192.168.178.36] ([79.253.153.213]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0LnjFb-1aaTj22HtP-00huHP; Tue, 17 Nov 2015 11:26:11
 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <564AFF32.1030406@web.de>
X-Provags-ID: V03:K0:krCjHdqw7b5VNYgOExbRY0/P90vJHpV463KOYJsF45gBz762NOj
 N+eGuhz5/5BNmJIdcAR7p4aEgLMmLokG3YHg/JVItIHuQ1wx01hsGZUNoMdbA4PQ8gV+37J
 6YtKr8h4S+QdVqqZLjwGC6qKlFJapUDRz5lgMupEnCELh2eu+a1rCqhhmipE6DgluESbAY2
 qYXzRXUYOESCJk69RREgw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Rz4qZf10bUU=:273j5x1oCCA858RNev3Wgp
 Umiv3DOMW0mYsEhLecOIkKDqZfGZ938RG3IUlzI86nC2R6yI7lq7CSsH3M3WSjn/AwlPEXBgx
 c3pthh7pndnAxVLtI+mSuMipciprwozjV3odu8dOywXjPmvYjjruTRJV3vKAYpORhEdIytBfM
 zitowfkQyhD71D6krB2rSwoE1gxt9Q0laDWIWLjPAU1Jg4Ul+lt4//F8ItHy4WPEmFqGM7C1u
 AKNQ5ndfD8I5LQfGMJ5OxbGcbm8Fww5i7CLYqOBs6NSzO7nkePCpLQBrPaPfwyxtece04ru+8
 9QTSn/nFAGmZOAP1S26PP3KDz2BtyxziBlMPl0fJvvwB5o3+sS4qlh70ivQ0Zbb/Qf+THfIrh
 ZdnpV3uA/39Wede6tMcKGWNeX/JNFi4dQsfV323ng3yv3F2q452nSA3P1E63zX4xqTJdUVTBn
 JYEJOvKx5Io2sJC3Bdtw6n5KeXKrPhWhsvr7X/FPrgpPvRHCK6iSp+/MA/D73LI/B8TJU6XCj
 GGm9rgBHenGE3KuIJRrX3Y+AJKv2aRlg7fedFa/dcUQ43XxQ2df0iBFamDAuTaZ5DTo0dD3mu
 NqskOnDnjfolnKMyYivpoNm7Djk0njI7kSFPqcXuOJPIMU5lUxMl23pyb7R/XMf+5ITJSG6zZ
 n5k6kN3Ha923F79DUvQcHOFYFibluW+IBb8IO3A0mr0Pg03IpL8Uk8FQP0fzWByX1CTvZl2Ad
 yyLR135M8LNWkl0MD1oWP9ibiOgV4P+Z7p2Od7io8bAiILEvbQ6/Cs0icsCo0SAx7YFWesL7 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281399>

The flag PARSE_OPT_NO_INTERNAL_HELP is set to allow overriding the
option -h, except when it's the only one given.  This is the default
behavior now, so remove the flag and the hand-rolled --help-all
handling.  The internal --help-all handler now actually shows hidden
options, i.e. -h in this case.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/show-ref.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 264c392..6d4e669 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -161,11 +161,6 @@ static int exclude_existing_callback(const struct option *opt, const char *arg,
 	return 0;
 }
 
-static int help_callback(const struct option *opt, const char *arg, int unset)
-{
-	return -1;
-}
-
 static const struct option show_ref_options[] = {
 	OPT_BOOL(0, "tags", &tags_only, N_("only show tags (can be combined with heads)")),
 	OPT_BOOL(0, "heads", &heads_only, N_("only show heads (can be combined with tags)")),
@@ -186,18 +181,13 @@ static const struct option show_ref_options[] = {
 	{ OPTION_CALLBACK, 0, "exclude-existing", &exclude_existing_arg,
 	  N_("pattern"), N_("show refs from stdin that aren't in local repository"),
 	  PARSE_OPT_OPTARG | PARSE_OPT_NONEG, exclude_existing_callback },
-	{ OPTION_CALLBACK, 0, "help-all", NULL, NULL, N_("show usage"),
-	  PARSE_OPT_HIDDEN | PARSE_OPT_NOARG, help_callback },
 	OPT_END()
 };
 
 int cmd_show_ref(int argc, const char **argv, const char *prefix)
 {
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage_with_options(show_ref_usage, show_ref_options);
-
 	argc = parse_options(argc, argv, prefix, show_ref_options,
-			     show_ref_usage, PARSE_OPT_NO_INTERNAL_HELP);
+			     show_ref_usage, 0);
 
 	if (exclude_arg)
 		return exclude_existing(exclude_existing_arg);
-- 
2.6.3
