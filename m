Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 592A920281
	for <e@80x24.org>; Fri, 15 Sep 2017 19:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751738AbdIOTWL (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 15:22:11 -0400
Received: from mail-dm3nam03on0117.outbound.protection.outlook.com ([104.47.41.117]:20724
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751832AbdIOTVZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 15:21:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Rviv+eOeZ4qqoSl2MHUYA9Lfy+L2gtmn4X1NSxc3CjQ=;
 b=gTEFgBGG0/StkHoJU75gZMEWouVdLjz2Lvpx3Kt+aUblcrllDv7XgegYEHqvPj+b4pl+ihUeu71Juhf52VJ1pFlRcx+G8NwpITNja2zYzWEU7t30CnKmp0naYsDHj0ShMuP1k+azpuegNXOZSVma9F9XIg7xgizCUfRAEW1TMes=
Received: from localhost.localdomain (65.222.173.206) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.77.7; Fri, 15 Sep 2017 19:21:20 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     benpeart@microsoft.com
Cc:     David.Turner@twosigma.com, avarab@gmail.com,
        christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        johannes.schindelin@gmx.de, pclouds@gmail.com, peff@peff.net
Subject: [PATCH v6 03/12] update-index: add a new --force-write-index option
Date:   Fri, 15 Sep 2017 15:20:34 -0400
Message-Id: <20170915192043.4516-4-benpeart@microsoft.com>
X-Mailer: git-send-email 2.14.1.windows.1
In-Reply-To: <20170915192043.4516-1-benpeart@microsoft.com>
References: <20170610134026.104552-1-benpeart@microsoft.com>
 <20170915192043.4516-1-benpeart@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [65.222.173.206]
X-ClientProxiedBy: BN6PR2201CA0010.namprd22.prod.outlook.com (10.174.119.23)
 To CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147)
X-MS-Office365-Filtering-Correlation-Id: 3011b327-9552-4d91-7c6e-08d4fc6ef30f
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(48565401081)(300000503095)(300135400095)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:CY4PR21MB0469;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0469;3:1kwht69gnJkU2Geev7qC8MVpjXceHbI6NdorjmdHKWO1oBpvDXZDBUALsRGD/WRIrYr6savcp2kwpfy/1wd6PwQbQ6Dz8fnjMy9N5gkz7GsSD8r3BJSIXuDwFotr2i3vmvND/xmYE7ELcWB5v9ZrkPhIcCW5oO4zSXJ/zWMxvite656DUP0Eo+H90alLdIbOffaM5xUQysAVfDzFlzEgs/Mfd37xLTA5RIbjPKPF3uKmRXx3TVqWW8+vFPYfQ4/h;25:+fLq6ACSiVIkLP7GXLXXqa2FDuO4W3xX226Xkdy7Fv8EiUkCbVJA/ISe6Psu3NILI7KOPkxglOjcBsU7Q4Qa1R6Xh1ATbMZm1eBWMRKV0yZ152FeXLOYS6D6cEsJRu92q2K0ze0/e5ish3RmrBM21Ae/ksNnetpFfj7w7ky1LRFvqmYlTw9lPFixBv+ndx9xHn/ZRnh6mE3jQCzbD7egE44mIlZLyvn5acujpLoAwT2QZkqsDSJY8ydUQgdiEjFExf9Jpx6I3qvrDEQozA3AtrFTndH9cYdL4LV3XUIaDe9gOU3c8WSRIc3/cD0IVRSdC6tfVgIQjY4OW1JC4LK/7g==;31:qn3Z+aDZWiXW5zIdrVhHb4Qz29pFrZJupBcWQSmQEAxPceCxxWfy9C7/2KHSTvV2fBtoy2EkYu5o9yunSDW6ZsEPOH8u6Rao6jZCDe3WBfadmpHgceYpktOXhK/4Wrb/Wh9PAYL6OMt8IkydBGmdCmYp5etGXDX2h60I0A6zV8d3LHLZ0UToWomjJTPceUWF4MSc1H2cIGqU4aa+A5injWDOf9RM5Oa4C97sINtSfC8=
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR21MB0469:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0469;20:3UdRrfN1doUA+g4yRfSPvJJDMtCJoivGSDA/eMx0jUVI+UVeQ5+O72GeGU/DHllbXqqx7Uh0PI1o5KOpqYGJdh3T3ELTP4iH2+b+5Oz/RDjGaET0XekTVIv/CBHfCIUqtiyWARCRoxTHSx5qbcnzanDBiom8IEpmfW4eRVmbjMXBIOoUCdlcVhwoowYYsC9u1XNqU5G/eKOM7/xg75QZHJX9VSPf7OF9gw3l4qTc+DNAuhAiSb9mqfjGSC88apYZ5wrI78pq42qOt1+gPGzZuKhp2J3Bpz4jUBbB9aQyLFc6b2qDR0Hb+C97Bmkj0fWsdHsXTkGa8Sn3G+ZCECMwdg3XkK1gPKd7UxpB4pssytpQc9NLVjcTbza19qdqohjC8j8nDgi1NVIbsxPeHrA9r/ZzkpIWjVrJtTP9klo9Oq3l5p+UHSleya1qq0lQFOd44/0RREVqHCBAJ5r/6YbjvowXXTdZRsAKkcRTyZgwugZT91SKeozKGa5oQ53yBrVA;4:ensx/2XWglQ/hL9PbvixDOMUJSNOulxB+a7mzWx4Q6wJ29ncqzoCgc5V4fuLdKKdSBhBrMq4fzNfIv5yuv2Xl6+ImfmUeoJeE0SosrXa79YjCnBWZVBxuTk+lTxIOMGOX5uN1bEEHMWyvUe38tg39zJzSnyfSfteBeA5R+SnDWhuPlga2qsd6Vrr34b4CKS2uGpPpjETSmqYezOYw2NETXZ2THwwQe2xymrO4ImzJQn8d2jGLbeaMNqhDTOVhX8LACQnWzTNRj+P44zhrDsMgoRwhECemh35G9MbIojBXMc=
X-Exchange-Antispam-Report-Test: UriScan:(89211679590171);
X-Microsoft-Antispam-PRVS: <CY4PR21MB0469B10568BAC19BC493090AF46C0@CY4PR21MB0469.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(8121501046)(5005006)(100000703101)(100105400095)(10201501046)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041248)(20161123562025)(20161123560025)(20161123555025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123558100)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR21MB0469;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR21MB0469;
X-Forefront-PRVS: 0431F981D8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(6009001)(346002)(376002)(39860400002)(47760400005)(199003)(189002)(101416001)(15650500001)(4326008)(39060400002)(110136004)(34206002)(8656003)(25786009)(97736004)(2906002)(2351001)(50986999)(76176999)(22452003)(48376002)(50466002)(2421001)(33646002)(68736007)(230783001)(36756003)(105586002)(50226002)(2361001)(478600001)(106356001)(16526017)(1511001)(316002)(16586007)(47776003)(10090500001)(5660300001)(6666003)(6506006)(2950100002)(72206003)(5003940100001)(66066001)(6486002)(6512007)(81156014)(81166006)(6116002)(7736002)(305945005)(8936002)(8676002)(3846002)(53936002)(10290500003)(1076002)(86612001)(189998001)(8666007)(37006003)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR21MB0469;23:F72ZMnGCR98ne+WHJll75wZSZ43dG48Gx5B/9Tul0?=
 =?us-ascii?Q?sM4xPc5x9hoAnQvX209p1LA8UJumqq0qc5tPKh73KZa8fRiAwtcD7v5n1sIK?=
 =?us-ascii?Q?MBd1T4pIQruYGE4xtrQmlJZvzP1qr7mNjGH0vOqr1G52LcpGKdgwDjWjzHUi?=
 =?us-ascii?Q?KEM5hw7QXCw4JCTfQgZWeFvdU4PHln9K3kknI2PZMEXB3ix3unehh0BhPLpm?=
 =?us-ascii?Q?2smFUaFvy1cXQkhDXg0fBmnSEqZDeA5znzE8K7LPnD98UNCEYHAqdndlk1Tf?=
 =?us-ascii?Q?vvl6UVcZUEmarK7x4F7DzOMO6eKKL2cQ+tWzPchSQRvfEHiNu96a2GgoDEbr?=
 =?us-ascii?Q?Pp8KsOeY1ZFcU0EdCiemgXa0d1fxRg/1xqlmQnrjdxvpAMtV1+ggB9vXGdN5?=
 =?us-ascii?Q?ccT+QVB90v0w3z1idNPw3bgdZhrTh6gbpHJm/CvyEw2tLn5kytYm2SkrYhJn?=
 =?us-ascii?Q?LO7ctzF37lB0aqFNvxFqnm6OhgzGcgiuv30KZgqO93bw9R04pzeBN1mMPUXK?=
 =?us-ascii?Q?5i88SBXksqJcuAMMQHsw95XrJ4ylZm7wHpeCn2YW6Miovw8EYFUYP/tYdSGN?=
 =?us-ascii?Q?SBGyJElmA5y8e8jKTs2dSa+gMDpDObEddfmRHObccbEP5ufGnDJWMCRKiI8T?=
 =?us-ascii?Q?SRumooYU1FIs6klBgxfD1wdfOMVRJw06X6bLp6Hb/dTsR6yJc+5fWFBUmBqJ?=
 =?us-ascii?Q?gLAubZ3JgYl0jRCxmR9gXA090J8hHBhitwQZJT40o9KLeOyS8iVO1PlOjWog?=
 =?us-ascii?Q?Ds/ZQfCPMPg+75Aw3YTbCo3eYiDVaA3yOto7b/lyhtpOTvVoFDxUFwemlYBE?=
 =?us-ascii?Q?hZkSQ3y9urjcPafwMrrwkuRGhinyuD2v8e/7+SE28/+ktaA7bKK0Wdztf69r?=
 =?us-ascii?Q?M2/JVXSFo/1MpAz41i9MI5MoKZgVYY79N7JUB7vILdtHlCiqAoRwr1Jevaq5?=
 =?us-ascii?Q?7ftzdYIVlXuUbUPW2h9QSCPZLJQFH9j4rceYf0MpXd1OlUtT6rAwDGEUEvkL?=
 =?us-ascii?Q?RbIURfpn5C+9u8NhxBqdPNyyTgpKLT3yWxx0l83IBe0BoypO6TG+2iPC0yVX?=
 =?us-ascii?Q?L5zGOEmsPmwU0nvG2GjkScSyuWnzQBhwGPLuaR52SnecP85DpJqaZ/uPc65r?=
 =?us-ascii?Q?0VWsgbKmQVJszioH0J+IMUlEa8k1RdQtbRoLm9a6+giECrVjx1d0Pq2IH367?=
 =?us-ascii?Q?IUjISDtCzQKY4CU7Z9D5nOvOmGnVXNDIezv0jblg+f62280kykAOAcgPiirk?=
 =?us-ascii?Q?X63ySq0wxwbXEfS3k1GjgY1gV0Y6WuRJoPh7muV8qcd8xjYZfKEmDgvDeovU?=
 =?us-ascii?Q?3h/lYMjXfNdygLh4jKz6tDvqAkfu17ZxgUm40CPXYz57nAWA82ZNvAl+LA4w?=
 =?us-ascii?Q?XUVlhpidIgOYBzwGIGyHgpDtjjOvXMDSaMrEcuE+5vXseKBmhKaP+BTa8Sj1?=
 =?us-ascii?Q?Te8tH9P6mMWX+ivOacTyXVArBKum7yQ+XHlzKOp8cRTupFQ1fHe8QG5U9PCG?=
 =?us-ascii?Q?fIrBRSb1ZT3kYtBcTHXM3EXj3jFvFuDdAo=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0469;6:R4PVy7C4dNt6irE7p11ZbH3DsfkCtaSfsarPXbKkL2WZ6IY6tgaFESrqrtH61x2jCGOyqwQikFfRBgrOZcmvLyCYHbKcURqNYigU30LOgYj460XGHTQvIuQiWhqVrf0w+qfHob291ylNFiUDacxfasKlwvVovilJ/jzshDXrzUmgM+jBefMRcPPy3jwx0K9bKXFoLUVP7FAWk/XI/ao9ueMLGXkpvn9EBSbpwhq4Iqr/WpepJYQsueP/XEitRqQKb6z6fAFIhllZ8NlmEzhnUTcyViRk0nDReq2Lle263mXZiVa/WYOEars8sfaaJI+UTefZH+XggeIE6hRZyW3ZSQ==;5:jBlRj4sgRDt06vl34QuKw1r0bVQXm5QqKLoiq8hgmNb8uv/L6p8DRA39bEaNqLkN4amyP9VqJAH79XjYWQMStdI8U4VZybaMrmq+rKDQDU5DeTPGBAyTcqpoEj5wzVf1v4ljWqpyeArfyoIJ1ShNeQ==;24:/nUjcR+GoS1/WbJskXWD9fMajbxnYydu3n2chaJp6WFCXkD3oud+rMwUnjT4uJh2ZE6ZGSwduvHBcQiIkpE/tWaoQNwrUOhVOxJpEqi4Mgc=;7:pe1tjfpzZlsT6WfYBLxSLgUIwfIyZBFcKhLCAbPi/4nAj8mlPvrVJziMfa5EWjzgLlBmTpM8XgAnkh4rgf4WO/BCBM1LNwFQWUcxOryJ7cPagSi7oDH0VZVC2lq6xo84061zJumfxD0wqG/hwJ/1B0JEuidTydJNFgp2WGPpjc0w6qtUh9FD6BiZ+QpazvuJgDopI2Af+r/+jM+0v/mAJVR2jOtLkmjL3ZjFxjtOhbU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2017 19:21:20.0406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At times, it makes sense to avoid the cost of writing out the index
when the only changes can easily be recomputed on demand. This causes
problems when trying to write test cases to verify that state as they
can't guarantee the state has been persisted to disk.

Add a new option (--force-write-index) to update-index that will
ensure the index is written out even if the cache_changed flag is not
set.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 builtin/update-index.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index d562f2ec69..e1ca0759d5 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -915,6 +915,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 	struct refresh_params refresh_args = {0, &has_errors};
 	int lock_error = 0;
 	int split_index = -1;
+	int force_write = 0;
 	struct lock_file *lock_file;
 	struct parse_opt_ctx_t ctx;
 	strbuf_getline_fn getline_fn;
@@ -1006,6 +1007,8 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 			    N_("test if the filesystem supports untracked cache"), UC_TEST),
 		OPT_SET_INT(0, "force-untracked-cache", &untracked_cache,
 			    N_("enable untracked cache without testing the filesystem"), UC_FORCE),
+		OPT_SET_INT(0, "force-write-index", &force_write,
+			N_("write out the index even if is not flagged as changed"), 1),
 		OPT_END()
 	};
 
@@ -1147,7 +1150,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		die("BUG: bad untracked_cache value: %d", untracked_cache);
 	}
 
-	if (active_cache_changed) {
+	if (active_cache_changed || force_write) {
 		if (newfd < 0) {
 			if (refresh_args.flags & REFRESH_QUIET)
 				exit(128);
-- 
2.14.1.548.ge54b1befee.dirty

