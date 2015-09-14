From: Alan Clucas <alan.clucas@teamwpc.co.uk>
Subject: [PATCH] Pass amend to pre-commit hook
Date: Mon, 14 Sep 2015 13:14:20 +0100
Message-ID: <55F6BA1C.7080507@teamwpc.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 14 14:30:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbStV-0001ie-LQ
	for gcvg-git-2@plane.gmane.org; Mon, 14 Sep 2015 14:30:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752158AbbINM35 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2015 08:29:57 -0400
Received: from mail-am1on0109.outbound.protection.outlook.com ([157.56.112.109]:58727
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751300AbbINM34 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2015 08:29:56 -0400
X-Greylist: delayed 928 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Sep 2015 08:29:55 EDT
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=alan.clucas@teamwpc.co.uk; 
Received: from omar-linux.teamwpc.local (87.83.8.229) by
 HE1PR05MB1385.eurprd05.prod.outlook.com (10.162.250.27) with Microsoft SMTP
 Server (TLS) id 15.1.268.17; Mon, 14 Sep 2015 12:14:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
X-Originating-IP: [87.83.8.229]
X-ClientProxiedBy: DB3PR05CA0023.eurprd05.prod.outlook.com (25.160.41.151) To
 HE1PR05MB1385.eurprd05.prod.outlook.com (25.162.250.27)
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB1385;2:U1CnNyE/3rPBFQfr9Fv/sZZEws7aUW8UDK6o9bhOb714wjANonVYsqO+/VHk2qtg8zC/KnrseBHtVgCraFNG+95U2r0fRgPzzdv4XnT1MKs2B+qrYBlNXNj2lRRqJsiAUjFiG7TBNjikIexmwZfkb07wWqEzWYAIKQYmeWvF+04=;3:J/KpHgc0jfWu9mcrdFepwpBy+8iwnT2GC4jrZwKyAUVFlGxOIswrzU1QKR10pTmVvXKsgvQqt4r2PXcycP9P8/AorrE2/mHTlYrHBcWwoXJPVIWBYiDX3dVYmmj9r5oYKm45IZoupIMws79yn1MbgQ==;25:1wVeW8/fJvyKBuOgSMsIde/NyH4vSH/9OxIEmXHtjHISrKdVR6oPeksMw59UWrGILc0IdLF0X8Vz1/HXlUu11YIp8ne6wqsZaXP4h7HaqyX2Ra7dr6zPE0U2WN4AGbLozmDo2gscyGWeCjPweFtwDZep1cutL80OGE6bKZvF7WsgkTh8F01TSSXBkxsgy51ERW6Mcv37n2VreYuR04UxZSrrckgSrCwglzTMFmfvZRPv7vDuMhpLyjVaSP5IHN8CZDxEngv01bhJ5giVxTADNA==
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:HE1PR05MB1385;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB1385;20:shuSxv0MZYRb/92HsyTa+sTMHB+jqvaAC0EymsbkAeKj/ka7gAwI/ETnV659Kw7c2q6j7E2ynYgZHhFwl7fPvhUXzlIryMeory2RmJWDIJWxK+hqDqHoRBmztBBpw3VhT0ZNN/VnjSmSNKrmAktwkdD9OlcQdE4euT/WrCI4v8g/oU2xfkTwjQYZJtGVSOrMqrlPvl9GWvKtsJFu4Vx27lQ1f7tdUaCJRGoAzhJze06jATSUMuB1s7uh3adovOr+Mho/dXdVSDTEXI3KC2sd7ldjZm5OORjOZMK+6pL2rkKFB5WFou1nlTt9U6apIrljZYciLBo1id/RK+5MhPdyRXuvYXDpbTL56R02BpTgVY8=;4:oS1msydzbOc6MulBdi4KLEmmordGy6KlbAKX3BKYX8dDwtS/BTPj8m4B1CVhpkt5DU3Y0e3H4OouGYr0Vo7GIlxiFiq6E3VsoZWb0V8ZEfR3Rx6ZEso0ZDjme0EJq27aaY9Bn6FE/8CdjgjbyhbD5D4DqpOgKs3JiuKE5Ha6s9XiqJgE2Tx3k8lKnaxMupHYNl64n/bqhdJHmaZsOk/2ipiFLvDyN7zVWAFyfncbfG3yOUDtENLN7LmhVbdIkrx1BVWXqJX5Sz+1gsVSaprpxeknjzjUvdEG8Kb9kMIN21AfC2OLCe3GX0WlPEmVrjog
X-Microsoft-Antispam-PRVS: <HE1PR05MB1385C4A4E83058F5E9236E8EB65D0@HE1PR05MB1385.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(5005006)(8121501046)(3002001);SRVR:HE1PR05MB1385;BCL:0;PCL:0;RULEID:;SRVR:HE1PR05MB1385;
X-Forefront-PRVS: 0699FCD394
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6009001)(199003)(164054003)(189002)(83506001)(5004730100002)(5007970100001)(64126003)(87976001)(50986999)(15975445007)(68736005)(42186005)(229853001)(2351001)(77096005)(50466002)(5001830100001)(97736004)(4001350100001)(81156007)(86362001)(105586002)(575784001)(4001540100001)(106356001)(33656002)(77156002)(450100001)(40100003)(19580395003)(23676002)(62966003)(107886002)(189998001)(110136002)(122386002)(80316001)(65956001)(36756003)(5001960100002)(5001920100001)(101416001)(19580405001)(92566002)(5001860100001)(74482002)(47776003)(65816999)(46102003)(54356999)(64706001)(59896002)(87266999)(66066001)(65806001);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR05MB1385;H:omar-linux.teamwpc.local;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: teamwpc.co.uk does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA1TUIxMzg1OzIzOlh5TG1SbnYzTWpXRUNsakRNTnE3cUd2RlJZ?=
 =?utf-8?B?WElHSEh2Mm05c3dncDVSMktTOHFhQmxhMmJWUzBISEoyb2RDUnF5ZUE2NUpp?=
 =?utf-8?B?ekdiSitQWlR0S2J5dXVZY1V1SEFzdE5JNys5T3JCbk45a052SkgyRzA0NHZ2?=
 =?utf-8?B?U0lERWQvamZwRGZNM2drQmVNV2QwVDFkTnZ1THZkQVZPTExCZndDeU9nd1FP?=
 =?utf-8?B?clN5OEVncGdEYndtWThNMjVQS2pRdWNIY0NEU1hUVGRCeGFuRW5xb2FhRjll?=
 =?utf-8?B?emxpdDV4Qm91MDNOWU9SbVBEZm51Qzh1alJwdHFwWm5aaTBBK1FFVFhaakpr?=
 =?utf-8?B?WWpjbWNUWWFpUkh5cmZoS3U1UWRDSVNQZHJtc0dqNEVNeEVqRXhNYkljZERH?=
 =?utf-8?B?ZlJVK2ZXL1hvVjg5aFlycEtPNXU5REFYTytjazVsZkJDZnY2Y1htellTR1lP?=
 =?utf-8?B?U0VzcTYweElQMDU3b0cyY2JBMW14SVIraU5sNkF6WDZ3WHUrMG5iMkNOQUxq?=
 =?utf-8?B?SHZUWnB3amdoaHNpaHQ1dVY0dDA4VUhJVWxYWkZROUVKaDZqQWZjdndCUXh4?=
 =?utf-8?B?aGxnMjVuaWF5R3QrWlNnWmtPdDBJeWdrQ3pWU3EweVpwd1Q0bENzUi84dGxw?=
 =?utf-8?B?TDE1SnNPV0VkTEFHbjI5OTR2bXBkVHFJemxPNlRxaG 
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB1385;5:5RRBMBe6w1/GK++JwOMhJMdWcLZUUbRZgSSIf9FA4pg2B0xJZSPYH8YnntcixwHrgXUMEdA/+M9bCCu0y78vSJHgprIFjr/F21wBz+V8wn+F3q1Xnqj7UlFDFtgBcbTcoTEHIjpk53MY/MpN2SYu/w==;24:kPD3+2hQfFeR2xphit1O7DhZ8zBVMN5fWr0bVArarNCccsczkrOeDsfHrxlnr37k4CfrzvYr3yfn8i4bGyFjzHGwTQm9CdnaQ9dDIV8OxRo=;20:O2GzIiSRjTLRRFOMWRFxBY1zrFWOAbduofy/L2ey7pijdzoCSPG67pY4VbjgK77pBYDJz9BoKMvRk0Nsn4sFcg==
SpamDiagnosticOutput: 1:23
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: teamwpc.co.uk
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2015 12:14:23.6499 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR05MB1385
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277818>

Pass a single parameter 'amend' to the pre-commit hook when performing a
commit amend.

This allows 'incremental improvement' pre-commit hooks to prevent new
code from violating a rule, but also allow the pre-commit hook to pass an
amended commit where the amend has reverted back to the original
code (which may not pass that same rule).

Example:
I have a new whitespace rule. Old code violates this rule and will not
be fixed up for blame reasons.
My pre-commit hook detects _new_ lines which violate the rule and
rejects them, however, my original commit passes.
I amend the code to revert back to the original code (which violates the
rule). Without this change I cannot detect this is an amend and reject the
change (unless --no-verify).
With this I can detect this is an amend and verify the patch as a whole
is not in violation of the rule.

Signed-off-by: Alan Clucas <alan.clucas@teamwpc.co.uk>
---
Hello,
This is my first submission to git, so hopefully I've managed to get the 
formatting right. This patch should be explained above, and would also
help out the folks at overcommit who have this (pretty horrid) solution to
the same issue:
https://github.com/brigade/overcommit/issues/146
https://github.com/brigade/overcommit/pull/167
Thanks,
Alan Clucas

 Documentation/githooks.txt | 10 ++++++----
 builtin/commit.c           |  2 +-
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 7ba0ac9..49d7adb 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -73,10 +73,12 @@ pre-commit
 ~~~~~~~~~~
 
 This hook is invoked by 'git commit', and can be bypassed
-with `--no-verify` option.  It takes no parameter, and is
-invoked before obtaining the proposed commit log message and
-making a commit.  Exiting with non-zero status from this script
-causes the 'git commit' to abort.
+with `--no-verify` option.  It takes zero or one parameters.
+If a parameter is given it will be 'amend' indicating this is
+a commit amend (if an `--amend` option was given). It is invoked
+before obtaining the proposed commit log message and making a
+commit.  Exiting with non-zero status from this script causes the
+'git commit' to abort.
 
 The default 'pre-commit' hook, when enabled, catches introduction
 of lines with trailing whitespaces and aborts the commit when
diff --git a/builtin/commit.c b/builtin/commit.c
index 63772d0..936a614 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -671,7 +671,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	/* This checks and barfs if author is badly specified */
 	determine_author_info(author_ident);
 
-	if (!no_verify && run_commit_hook(use_editor, index_file, "pre-commit", NULL))
+	if (!no_verify && run_commit_hook(use_editor, index_file, "pre-commit", amend?"amend":NULL, NULL))
 		return 0;
 
 	if (squash_message) {
-- 
2.4.1.168.g1ea28e1
