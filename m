Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D3DD2036D
	for <e@80x24.org>; Mon, 27 Nov 2017 13:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752314AbdK0Nro (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 08:47:44 -0500
Received: from mail-dm3nam03on0128.outbound.protection.outlook.com ([104.47.41.128]:20160
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752301AbdK0Nrm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 08:47:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=EfSpI76m0Mauy+u8KHsjYYETVZQ35ejC1R+Fly3xMbs=;
 b=UAxn2Hfs8MfDs/WEOifkReDc9ZEenS0bJZZnsSQbkS4lysJ4skRNWMILbR+wzgQ3bxL1jvAORfR7Zgx4mVNQLzhijr4kCfWF/KdiDK9BeLHZMlQSOOuh/LOGpxPeJqusn7hNBi4TSPtSJVc8uEHPMWGgYPiqBxLeUs8GB2kO6/w=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from slxbook4.ads.autodesk.com (62.159.156.210) by
 CY4P136MB0024.NAMP136.PROD.OUTLOOK.COM (129.75.90.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.239.11; Mon, 27 Nov 2017 13:47:39 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, sunshine@sunshineco.com,
        kaartic.sivaraam@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v3] launch_editor(): indicate that Git waits for user input
Date:   Mon, 27 Nov 2017 14:47:16 +0100
Message-Id: <20171127134716.69471-1-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [62.159.156.210]
X-ClientProxiedBy: AM4PR0701CA0023.eurprd07.prod.outlook.com (10.165.102.33)
 To CY4P136MB0024.NAMP136.PROD.OUTLOOK.COM (129.75.90.91)
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 338dc200-4246-431c-9497-08d5359d6d78
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(48565401081)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603258);SRVR:CY4P136MB0024;
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0024;3:LfRFuxkKYAT1a/m3yIGAtGXnmKqS8tBxVtNLUrnXPx7FT6kxTpM4Oztyq6A+n/KZU15klipKEqeXWVkwfP2+czJs9eK64wfPqxnvo/m6VD8LclaaJ1HJ4YjWNCNMcQgNCYwoncvrYv0fhYKsK+EFapvK6heKIFK5/gEfDO8Sz2b37eoOEMARPcfLlXsZ17wICVrOATkAnVQTd4K2lRoGX2jmU+LJM+bD9uIXJReUsInicEtoADTwqu4I8l0MaUTe;25:eNx/E7nFQauLMkgi2wBmYU44+hWS3Qpk9/vzUDG1hfpQDRshGfJIwwv8QJoMeTl7dvA8ft0VffhHzA2CGSjkB35boM1ek3k10J0eyNxzFKYcbpaf1SpuhhtU223tcJYMzJNLMkZvNeZRo10l89VFCO1bK2UKFwNwtU/Jnm/hxZND5hbt8vb9UkAMG3/jtgKMN3toUoeZNRw43bSmINUl1gBheb/pPRBRakoNPN2lTA0vHhckQ1gL29ksg4Hl0kB4XwV+i7Dp3z0Te+YN0xY6ohUzeJoaUFDRtgs1zYW/ngXEyJQHXtV6PudZzxE6HEGOrjKxXrZ9uH1uuIWSI1Wd6Q==;31:Fw034hkpRrc708O1HT8l88jWOcp6cvw4CI7CrVAjDkBK1ryEPEdg0ZUuD+Kv/k1oLUqPAFXuk0q0qXubg3NTjFbXfHAl1i3VxMYbIb77qsOdOv8qOA/1tC79Ihq6efuFJDLYdK31SkAnQwvriiexN0XykAcWA2fFTh386XbpoiPbqUZx27dKapQInJjj55t26mcY/P332muPReeCgV2pUMDdt1lh+0vpO4NwdNEM+gk=
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4P136MB0024:
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0024;20:/+PqhcveFuD1NYHMg9Msm0UoAAxhirv+RB2vcW1R7Xpm+GYOUnoAq0GOTfeUk9AA8YFGuja8awhnIaWw3dm7mKabKL794PD+GzMzY5LHhIDyeSFSRNRvgPAe8NdcWyAGwUcI3mvcr5PwcRV2cGGY16/+4/v/L9yd8ruEwm4fOKpmY5pIl06j7rL0ZF75uUPbQfuuXRJkw1hSfRlRI+6mqQ1kQIF7yGV+Qvb5YqeJ7tsPh8JXmKSdvkIaf52FpICgAIF6RNFKR9v/eFQznmFcPkvg14AlMefVvafIY8WLevjCef8dqQc05HoXpgKN1kAJgVSPs4tXQ75AeMED7Kth14CyO6tzVy0qN5laNssNjbdJFuX37veUo1pmAs+4fEXZcKj1iDM+8mhVbXcuBop9JnaJn13xon5lgP9UunW0TanNVS4yQIRoKhdEMajX2ivGGljn0R/XeLzXlCD6cfgbxDNW0KxUq0pJghDbCNeykyBfkKK01XAxzWee3fHKGtXAXHH1L4G6ZKCFkxiThB/oHkT87EKXnInkO2tnmU7uwFKAkqZXITB2yTl3MMHBdLArNqdS2Ub2psql8HwdAHBF7ycQVaiIJDMDCRJ7lNEeEDs=
X-Microsoft-Antispam-PRVS: <CY4P136MB0024DBC48BB53237CEE3B95BE8250@CY4P136MB0024.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(166708455590820)(35073007944872)(211936372134217)(100324003535756);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231022)(920507027)(6055026)(6041248)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123555025)(20161123560025)(20161123558100)(20161123562025)(6072148)(201708071742011);SRVR:CY4P136MB0024;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:CY4P136MB0024;
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0024;4:j5q/edvHaqJwTq4MDsGbu9K4UToRK8l9s24RulyxqMss+JEWV78KKlMBj7tt3bRYQ/5r4oFl2q+giKUGzrGYkidnXflolYjhsroVQ0e4amNkjjb/SIqzT6WS+wgpvoJPb71diY/YF9atE0UXv27r6ieQqrnr6JsGnlYqAE5YiGB7NeI2ZV1vosyXZLr8nBMfl+/6dT4UtTGgYOpT/gghADaKpyjsX2evj9NtlcLhyaJJBuxu+vngUsmgY5N32C2BYAPJv4JYRCsGDLyW62NUGe7pTlaL3hawWJF17Bydr6i569Wq4387X5pFGftIsLqGnWPFXKfd16y+F7MyQ7neVEB8SX8O79PKQ3frKR+ZW1MCdF6EPSFHTvJuxHY9cyICna9Ks8vRD1eFrrMPKaQig+lzpFoo1SZaKPmzOVwN8Vo=
X-Forefront-PRVS: 0504F29D72
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6009001)(39860400002)(376002)(346002)(366004)(199003)(189002)(5660300001)(50986999)(6486002)(36756003)(6916009)(6666003)(7736002)(16526018)(478600001)(81166006)(81156014)(966005)(101416001)(34040400001)(50466002)(97736004)(305945005)(48376002)(16586007)(25786009)(85782001)(51416003)(7696005)(52116002)(4326008)(8656006)(53936002)(6306002)(9686003)(106356001)(39060400002)(316002)(189998001)(2906002)(2361001)(2351001)(33646002)(3846002)(6116002)(47776003)(86362001)(105586002)(8676002)(50226002)(66066001)(8936002)(68736007)(1076002)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4P136MB0024;H:slxbook4.ads.autodesk.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4P136MB0024;23:70cpSeVCPFkQChZYX+SQd7NtxvbRj6XVfeOfVWtYq?=
 =?us-ascii?Q?SYhuyFemqgvi/6EDn165h9441rTqQLQo5reQXHGEF34bYfqf6k+FKp7j5OIO?=
 =?us-ascii?Q?ktfjXhH3AHSUwGfrg0JRk+sE9syUmKhTU7bLaEnqWcxYN2yLogmAEGHyN8c7?=
 =?us-ascii?Q?Y1LQfOh9982bV+iD0c4jnBr1O69INf8t2Cs5/IG7qEGHGil8xF60AWh0P++r?=
 =?us-ascii?Q?KLeoF2gIA/XhfoznUh0Thup8Ai12npuCW1I04ZlZk1dhVgQvjJtC96j17akG?=
 =?us-ascii?Q?8/mecIx/lIqn0OaW8p6LIv2WJ7zZQaEL0jmFnGLDjpOYrNqMJOrr/wFr1wBz?=
 =?us-ascii?Q?zdqkzHQUkUOOAIY80JrV7NWEsnE8Awtm3uxouGcEEId981qY/yY2ibCpl+Ot?=
 =?us-ascii?Q?PMjrX021JRzkk72ObpT/sF10SdUBcVVRobxtyJgDsOy9NbHDdSl2YXoci30T?=
 =?us-ascii?Q?kThNeR4I6psS1oPZtyXod0dIM+sEVVD4f/0S4Hj4xQtaqVEp6+OBuVIO7cM3?=
 =?us-ascii?Q?vxoauc6dY5yMST/jA2CUDXKSoqjtUa3E1JwSkrT26JN6TFZRsv5akGXbmdSm?=
 =?us-ascii?Q?fd7q752q+MEWx/biFQmqv+bwprnMueMvQzVrK2BBY9S3XPfFU//oPBeBQafm?=
 =?us-ascii?Q?Q6vJDd2FVksVQ5zPai6InCOucmDblEyH60ssFIJ2DKqp30mMc3rQuc42MvMh?=
 =?us-ascii?Q?IAO3t3M6vp8UPkFkh8L+8MD+Y9ZwHxnkZAeqFZ3GByKpo38gRXFLySKsCLu7?=
 =?us-ascii?Q?JfyTieka/KLHQBxSEwxQEZ9G9h8oFkKKsuEF+IewCXTqPsGlwsukpybPjjJR?=
 =?us-ascii?Q?+AO1m1ex0Jmu71VMDvuoMkWQV5hnXXz4fPTCn5FIKRSZcoWRfXONz9aHP8k9?=
 =?us-ascii?Q?CcO9v3HhT0wlkI+RQND3/tCvLl1rgtybnnvuuqi2R2tuZ/WZNoKjkPJtQsAq?=
 =?us-ascii?Q?2OKwWFAWgHtQD9GY1Urr0HONKLuNaEGG7noL0olThYJu1VtEgbWnxrIEDUHS?=
 =?us-ascii?Q?VJgf1kxzAi2wYLKzVdxClckDcHLtxVwbBNqEzspOOrVJ0RfHo8T0kzQJnNTU?=
 =?us-ascii?Q?d5r6JwZnWR41ZMh69Yu81AjJjwC1VQ2MCdiQF+eS4gTflNTnsaCvVjiC9QUf?=
 =?us-ascii?Q?sv2r3MbhnTyIWDvu5MprhaOunShvFxWdNNuc+llUIVyELuwuWwuqBbbpix6t?=
 =?us-ascii?Q?Aw54zjmhMVIaWf+IRH2FqUfXwfdcSus0KQrDpBUHuyJKJKkG9Z/Pzo7B1iKg?=
 =?us-ascii?Q?ZwvMVDGCRHJ6hu/UdhZM2rqvExwBVYW5Q2/TwkS?=
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0024;6:DILVFfwU7OebfaPHoHuy/6j4UOBshlKCvTtWbgjoWqcXYOw44AmoD77wgcSJ1J7RZ5Lm5fh9jOHQCtlMkZjKjzmU7Bpm5kS7+GLJ3LmS0kz77b3RYM8cjNcAhwTc71Hlq8V3P80S5qKsPOKlTjJpxAfXKuaPDyKLfdE4jFS2amzFo5iejariksMx2SwygNlso3SJ+rLaREMnpTUVTFZc9WntNMccfZ9u/DdFVyBameJB3ICGsEpC5uDS3H81RYSOgJCIBADHgt6k+yBS9ispf5gDCvUmfjrJ8A6cmDtQ22rBtyXTyDqKtn3hr9rEPSjluG9LXWGmwjYJ3ti8YvDsoQS6Sr0xrXBZlNOPvj6oTzw=;5:1hwulItC25a/HWe6pL+uYOv8XnEknbbMl4zn/fGtRCuVRwmbT2xlQYiTvfhuxJHcj4CTIU/EcQ7NbwdQst7OWFy0zkfzvo2Vfiq1RYlE5UOI3HR+/FDupFM8IBDIOYL1sj/mz3MR4XQPhD2IrVCFlvYUxiGhZWZ2tXRmImQ19BQ=;24:kI5NIWBxlnWm/yTtxiyJpq+F+6jeMZV2ymmEiM7osno/qYZEzGD54/7cDUZSxvRbarYFTkdizXB1ZxJBaMlZbWvoYI3RGVPQhZo+kpcAy/Q=;7:liPFtRFzFaEjiNxbqETU/8W5uVhzTQdlP1isnFLzRyEMyhGV2UKpf0LOnhJb1NyLdUw+2upxXHNaUzYu4YUYeC0wOVpcJP1UUTEZT8uCKyneK336fJBjrNUVAzbcwmdudD8aFrR/DEH6gDAS0XEIyXWi3Ed3q+NN/rXXxYZ828XLVs4wWH/7J56axGG+9p6nFH93zkJDhbr5Znqz/mlRs7+F7jX59YRKOOIG/k/eMJhazVoubuNPzZ+3ax9V6MI0
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0024;20:OkGbGir/JeoOSWV0KitYMLpa8jTjcmMB9Coho4+J9W+xXiEEbbIzA9WLfxdS8RzqSczjzdP82f8eR8fTZEcen0w5aR3XtPIDtWio9VPnRnd7bi3OmaNi0VkZHL1GiNymLu1e+3tcK45n4Gtx2wj//vCky6vsaKax+YtZ1A9T4Yw=
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2017 13:47:39.0549 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 338dc200-4246-431c-9497-08d5359d6d78
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4P136MB0024
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


Hi,

diff to v2:
    - shortened and localized the "waiting" message
    - detect "emacsclient" and suppress "waiting" message

I did not add a newline after the "waiting" message in case of an error.
Junio indicated [1] that it is not necessary with the shorter "waiting"
message.

Thanks,
Lars


[1] https://public-inbox.org/git/xmqqk1ygnpu7.fsf@gitster.mtv.corp.google.com/

Notes:
    Base Commit: 89ea799ffc (89ea799ffcc5c8a0547d3c9075eb979256ee95b8)
    Diff on Web: https://github.com/larsxschneider/git/commit/0d43814931
    Checkout:    git fetch https://github.com/larsxschneider/git editor-v3 && git checkout 0d43814931

 editor.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/editor.c b/editor.c
index 7519edecdc..4251ae9d7a 100644
--- a/editor.c
+++ b/editor.c
@@ -40,6 +40,35 @@ int launch_editor(const char *path, struct strbuf *buffer, const char *const *en
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
+			else if (term && strstr(term, "emacsclient"))
+				/*
+				 * `emacsclient` (or `emacsclientw` on Windows) already prints
+				 * ("Waiting for Emacs...") if a file is opened for editing.
+				 * Therefore, we don't need to print the editor launch info.
+				 */
+				;
+			else
+				/* otherwise, complete and waste the line */
+				close_notice = _("done.\n");
+		}
+
+		if (close_notice) {
+			fprintf(stderr, _("Launched editor. Waiting for your input... "));
+			fflush(stderr);
+		}

 		p.argv = args;
 		p.env = env;
@@ -53,11 +82,14 @@ int launch_editor(const char *path, struct strbuf *buffer, const char *const *en
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
--
2.15.0

