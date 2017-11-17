Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0CE1202AF
	for <e@80x24.org>; Fri, 17 Nov 2017 13:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758026AbdKQNvq (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Nov 2017 08:51:46 -0500
Received: from mail-sn1nam02on0122.outbound.protection.outlook.com ([104.47.36.122]:62538
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1757847AbdKQNvn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Nov 2017 08:51:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ru9pxNM27wjVa3jSgTLi62p1vEjBxF4IE9Oh5IAPkZY=;
 b=IEgzeIJNglNWn9atD2vZHCz7zu4ekhxqbgy5+eQsAN0Ohkz4B2x5fRimzlTuJFEJkEtw4fRQZ/kC8ICQMBwGxsZY/u7KoX90RX5iQO1OzOhGrBU0xVY9zsnsGutX7ZR8yMRsmlpzc3dtzEaze1d4zuSrMGKwioaZYH881Hab7Vs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from slxbook4.ads.autodesk.com (62.159.156.210) by
 CY4P136MB0023.NAMP136.PROD.OUTLOOK.COM (129.75.90.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.197.13; Fri, 17 Nov 2017 13:51:40 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v2] launch_editor(): indicate that Git waits for user input
Date:   Fri, 17 Nov 2017 14:51:09 +0100
Message-Id: <20171117135109.18071-1-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [62.159.156.210]
X-ClientProxiedBy: AM4PR0701CA0018.eurprd07.prod.outlook.com (10.165.102.28)
 To CY4P136MB0023.NAMP136.PROD.OUTLOOK.COM (129.75.90.90)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c07ab5b3-3754-4125-3de6-08d52dc25586
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(48565401081)(2017052603199);SRVR:CY4P136MB0023;
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0023;3:laN3rUHha37SGNyYRTpl+mcQOqIR2w64+0h8AFnweGAciG33E2ulsv8hiC4l6LVaiMNSE8XaCGoqsOsf++wB4RScjYSWEyEC117tjXwPyw/az/BgFk3M04SPeH6bfPoZDweaqOEybD8sIvDIM76k69ZdXWcVb4fjyh28JZ0TUn8M1WyZRhrie5kQ3r+/71tx8P05mitPPFQ1xEDSqsFTF04fGSZ23Cip4L2+KesadGvIHiuVyFFz2itIbewRDZSt;25:jsxAEQu6lrcFrpEZGwNCDescIz4XYGKZJ1hXNBJ622hxjGFr0CLO1MM0Dz0yA1RssfYR+e3i7TE3oQS4eZUq4ArUzM867iS0/CffYsUnI+Xqp+/upCoi0FVpd9C1RC0Jl6WZ9BF2y8dyG6LLhrhuqik9WuEYni7USydfzObKihA8r++6a6omTev2STmIDFzpHD8Grt6Qrl/5z3b7B6NzIAyrvAIuzly8uBjnvkwKfv0yY4zjkV0VkJH8C4czSR0qgEfGSh4EjTrU5wsJ74Hg2nNOLY6rIY8k7O+ayWNbNOwkGX1tjATxeTyv/nl6JBpPTYhIE0Ops8I+mW53lDt14w==;31:8jQmqi+sl6og4E5pyJisfi1+L1Frc9cxPoOEdTCSsWMZVfSH5udN92xZu2ks0BB64eja2cwAs1Wjrjy31HKclH9DlwZxJ5wVUUi4ICJ8T1ItMBm10C1gULTjfgXCUUOoM6/Hk0uLRdprGH4YmwV16zdJgBWVNVniR85GTUPW+0jTYV+l9b8bAVHyorGiGjAewOgVgURgPWHNBPnwNLI5VXtsTWUN9BsAJXNgfnbt76c=
X-MS-TrafficTypeDiagnostic: CY4P136MB0023:
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0023;20:8+ky/8W/HvRz+jhPwXnvkbQmw5I6jkqre+isBBGZNCpgKsDWfcWoXSbN3iZAOcT/3lJvoTDpoGc/8o3ynypEDQNl50pPbBAufT6dldX5GxVgJVP78hmZbuLg0A70EN7JkhWAT1MEx77m+GNNKYcPj67KiBCHuAWdeIX2yN27y0gmQnkjRm3AplQD3HjaQYyohxm3+7Y2f5ZdMt/uEelaTIcAuULFpwtndh9Px8eJvxmDqzPQZwcaSyzmMd1nW6PBYoOx+N5EDgBWXX3cjnf3wLTQJJn+n2rE2g/DT9AdeN5WaqluKjGXpLFuEUiTahIA+Mg/hm95mjWYpOQDL2nHKunscGd8jtneXjiWPBpIQIRiwQ0P8E05TaJ1dK6V9sI7JkxTKbFD1Sn8WYwbeoztLdOj4+Y1aIl1fL7el4vosdY7+P6fvYrvR2aW7WADn1wFvaqcqB+8mWsmPGdeC2lVn4kCmL0661r8PuY29qKU6ZpkIqhzxJFUWqgrdvoU6o3Nu7kcSGRNalx53ZWZ0M3ZXAGKul9SfmjvSVpGKxEedPJoFj+u7NZK35XlGt9Ns62wJ4nVYzIvH6euQbpvltH0FLteCxlqTqLC6m3vj74KBbs=
X-Microsoft-Antispam-PRVS: <CY4P136MB0023374076F20195B2CD801CE82F0@CY4P136MB0023.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(166708455590820)(35073007944872)(211936372134217)(100324003535756);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(5005006)(8121501046)(100000703101)(100105400095)(3231022)(920507027)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041248)(20161123555025)(20161123562025)(20161123558100)(20161123564025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123560025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4P136MB0023;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4P136MB0023;
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0023;4:3LPsGXbaEXDD/on+Y/i7YSf3MVaV5JUUybVEhs7FkFYWQPCj8m6meQxB+516sDf+CktO6lciRCVeuDyPEXv+1jbteIN6D550Waeqn6BGw9G77nTVNW4aaBjqzG6nNBR1yFe4nd0tLFABXFDpiw6ZBFDadVmgh/68y9VzhBgQyyrHg+5hiaK4+wL3FIKqG3/7sb6TAan3SKO0JE3yOd/ma9vHHxjHXAmoRnm/DpmXByWn3LA4lS/lTLLRSOxqeJuZ/FLs45XPgQFme0KUUsHqLT0CZTTD2nQBSZNvzl8NQNiP/ZV7qT603xUOtWHxLMEiw+Kf6RDCR5UAZKScy9t4O7JBVuIQzaTwzYhVgs0KXWjFmZ1Cnhbu/nO+5AHi1A/T1lHCzJME41VgPIZEKxfmtX0Yjgi7GX9oKiiC/N22K6Q=
X-Forefront-PRVS: 049486C505
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6009001)(376002)(346002)(39860400002)(189002)(199003)(68736007)(50466002)(3846002)(6116002)(39060400002)(5660300001)(85782001)(33646002)(966005)(48376002)(1076002)(4326008)(106356001)(105586002)(189998001)(6486002)(6916009)(47776003)(2351001)(2361001)(16526018)(6666003)(8656006)(36756003)(16586007)(316002)(8936002)(9686003)(86362001)(66066001)(305945005)(8676002)(81166006)(81156014)(5003940100001)(50986999)(34040400001)(97736004)(50226002)(53936002)(478600001)(7736002)(25786009)(2906002)(6306002)(101416001)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4P136MB0023;H:slxbook4.ads.autodesk.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4P136MB0023;23:pnYjvRSRW3uhXH72zEYKSZRZ97ciuhFL9gpxFZ5x5?=
 =?us-ascii?Q?QjFUNl+J9SUcMOt2CGE/yUvvuzqFmI1FMO9hwb6ctCa1JqtO+U3r/23/gOZv?=
 =?us-ascii?Q?+5X/kYJBXuP41EHAHBI0F984fEho18ERObsohbgZ/5Egu8WDjV+Ot+wyfDy4?=
 =?us-ascii?Q?B35MkaFehoC40fuDe5s5SY4l5xn9TRgZ/c8cSks3tv5TeTy6aZbvkCRXwIKh?=
 =?us-ascii?Q?2dR+GTdx76w1I1Wha7cpUsgpM3maI30ThrqnDN4wGSee9McJnJJmaYKWJCJw?=
 =?us-ascii?Q?LaLKwOnt+TpJlDqIon1d098P7V/SVSTZb8eSx/dSjTJ04LAE9Q3vqgf5oOaI?=
 =?us-ascii?Q?Hf6q2uGi/jN4wuc7ktosAgQ7nXVZE7Rj9ufNuw/QDfHZsNSTyYefu3Vsan8v?=
 =?us-ascii?Q?JinT/cwNcUILI38u4Hy6L7lzl/ecaWrFraxdLH3Nrb+QY65LN9e/TxCr0ocf?=
 =?us-ascii?Q?08G4MatyrMN2QbkGZw+uh53TpJdT5XplGQBuoM8awylTSr7/Jfbui1NeMPab?=
 =?us-ascii?Q?UhP3+F+WDYFOV31eojJZwoV3KTEhQkk7HMBDGOxEsvQiRYtJyySo4fMwHb7G?=
 =?us-ascii?Q?9XdpASxFd7c3ktRkN1vP8s1CMUGFK08pWBFh+S0uD+G55jR616cubA5iQ7TP?=
 =?us-ascii?Q?SjnA1cF1v836dUI9rn33F8osRFuWiSMcMsrIFPVC5uonW74gejlSix2Gq9dD?=
 =?us-ascii?Q?clxvh3HMXAJJ/l/A1VkWDPI67f9d0XrzWDjeTlheHbx5oZXfw+Ntg745dtZY?=
 =?us-ascii?Q?OiYB/5jcgh5Mk3aNTFBsSvt5YtMeLX6G1eueo04USFZq6h7gWbqIKiGIsIom?=
 =?us-ascii?Q?QWWL0p2WF/s+EPKMg4ogfxYP8pG3bPwB8XNuljUl/BTKNouerm+19GJrJ9q8?=
 =?us-ascii?Q?ZtdMrNh14Diat5b7dO03ShYPCDQGZ69qQFXZ+it149e9EBRY9V8SzIzFV5wB?=
 =?us-ascii?Q?8TALgg0cJlx76Wahx43uT97QXw+b7CH0x4MlRT2ngpIAAkcGGzUh1wb1PjUl?=
 =?us-ascii?Q?7HUoZov8WdFyxakXtlDtCiO4WE6PQLNpQomhFTxQTZsiZL9r70RJoDJLmQ1Z?=
 =?us-ascii?Q?uOIckUXDlmipU8RNfPznxXRdoW6CZUCo+B274iMW0Nx1xcdAg+RgY77ZlkqG?=
 =?us-ascii?Q?QdJ9AFnJGPnSjEpUpSijM03qirkHhvMTtrG0IROaODqfu25C/0L6vbv3150h?=
 =?us-ascii?Q?yyJNkwYN/mwUk7PYAyt4hMgPu86hJyF2en9M+/XaM5hdJ4+eXBCzomRGQ=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0023;6:uNyS9RKHWpJrbeNF9Gon3NGKLt4z+8r9hfIWqDSNg0k/zz93cfknPSf1mrdcCT1QPCKALv1nBcuW74Uy6Irww0kpm+PjNU+I6LACtBrVBXVql5bzYAWdjIPF5EZ9LEQpnA+34ABj6F/xEinzg6D0yNhxYhLIgvaSQzhFqNzx5TGJeUoxdJbj52JfUJj72fgsjiiDvX09FZwIG1/V1TY5qVnfnd7j2c+qQkCYImV+9xDStGIpNeKBtPR/m65Umw1L1hqBjADbZ7kvvJTHbM4lsz5WPwq2p1gZZ5l2FpXaAjDO9PRLwsgaGw4QX0LyrrUUimeufrBVXQCt1WYLWxrlV/mjrNP/VrXgxuNJPXJMDWc=;5:U2aGMqxYnLxXcKCB5Yxij0Mmb9oE53YjPN/SyFv5BwzntX3FgGQSX/iXND87Y9gzjWqlk6kbbAII6RcVYWvHYQTpdah+39I/V1flIipu05ZCcS9rnHD1n/gKE8e7Is75VS0OpaQVtuDLpXBJ8qewbLSZiPMt6drMPE0ditGER9E=;24:AxyGfhMp+N6NTipf7uqjqC0X9FL3qQcdDobWNCQNPgum5Q92wR1x/KiOjRndDLcnzHI8jzi5wKE4XMfsKrsIihLSM0hptIMgMVhOSP2d2tg=;7:7FOKD+z8csK1qivRhTJq680U+jLyKVSbZnLmSZCPwuPIe4bn/7ldUgfoW2e+WdACiE7YwTNSr9jK3pgW02Wn2o7qT7aWswhxHiGAQNI6cA7ZCGgpCJYcjHPyH78nPF7TWJwpe7nIvMCbFwA5hFMnSLzge7ejGZVvGnVGQ7d3SxpK52Ca4XCsItVleHa0RNigtNhfN4fZ6GeGbS+TNBYy5fOO+F80e18ECPZVmVLXM+RLKvjNytRWNhnch707MQhP
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0023;20:34c6XdOwecSBuijbS/wdUkFehizKlyseCFMIwDukzohuAT7iZ6Yv3bogg4cx2nNK/VOnSuXecvrzKSbrIy9kR6THvXSROZnlPqns4Us1wv3HTQftYoySBgH6YUqYHe6Op7aaBlFbAVWxdDEyEw5PlXTQUtYAmN4vyGwjDL5pqKU=
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2017 13:51:40.9715 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c07ab5b3-3754-4125-3de6-08d52dc25586
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4P136MB0023
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

When a graphical GIT_EDITOR is spawned by a Git command that opens
and waits for user input (e.g. "git rebase -i"), then the editor window
might be obscured by other windows. The user may be left staring at the
original Git terminal window without even realizing that s/he needs to
interact with another window before Git can proceed. To this user Git
appears hanging.

Show a message in the original terminal and get rid of it when the
editor returns.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---

Junio posted the original version of this patch [1] as response to my RFC [2].
I took Junio's patch and slightly changed the commit message as well as the
message printed to the user after GIT_EDITOR is invoked [3].

Thanks,
Lars


[1] https://public-inbox.org/git/xmqqr2syvjxb.fsf@gitster.mtv.corp.google.com/
[2] https://public-inbox.org/git/274B4850-2EB7-4BFA-A42C-25A573254969@gmail.com/
[3] https://public-inbox.org/git/DAEC36C7-AE09-4C9B-ACC4-07F2C5F2B97F@gmail.com/

Notes:
    Base Ref: master
    Web-Diff: https://github.com/larsxschneider/git/commit/6fd6d8e682
    Checkout: git fetch https://github.com/larsxschneider/git editor-v2 && git checkout 6fd6d8e682


 editor.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/editor.c b/editor.c
index 7519edecdc..23db92d8c6 100644
--- a/editor.c
+++ b/editor.c
@@ -40,6 +40,32 @@ int launch_editor(const char *path, struct strbuf *buffer, const char *const *en
 		const char *args[] = { editor, real_path(path), NULL };
 		struct child_process p = CHILD_PROCESS_INIT;
 		int ret, sig;
+		static const char *close_notice = NULL;
+
+		if (isatty(2) && !close_notice) {
+			char *term = getenv("TERM");
+
+			if (term && strcmp(term, "dumb"))
+				/*
+				 * go back to the beginning and erase the
+				 * entire line if the terminal is capable
+				 * to do so, to avoid wasting the vertical
+				 * space.
+				 */
+				close_notice = "\r\033[K";
+			else
+				/* otherwise, complete and waste the line */
+				close_notice = "done.\n";
+		}
+
+		if (close_notice) {
+			fprintf(
+				stderr,
+				"Launched your editor ('%s'). Adjust, save, and close the "
+				"file to continue. Waiting for your input... ", editor
+			);
+			fflush(stderr);
+		}

 		p.argv = args;
 		p.env = env;
@@ -53,11 +79,14 @@ int launch_editor(const char *path, struct strbuf *buffer, const char *const *en
 		sig = ret - 128;
 		sigchain_pop(SIGINT);
 		sigchain_pop(SIGQUIT);
+
 		if (sig == SIGINT || sig == SIGQUIT)
 			raise(sig);
 		if (ret)
 			return error("There was a problem with the editor '%s'.",
 					editor);
+		if (close_notice)
+			fputs(close_notice, stderr);
 	}

 	if (!buffer)

base-commit: 89ea799ffcc5c8a0547d3c9075eb979256ee95b8
--
2.15.0

