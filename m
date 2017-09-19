Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C5462047F
	for <e@80x24.org>; Tue, 19 Sep 2017 19:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751471AbdIST2z (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 15:28:55 -0400
Received: from mail-dm3nam03on0134.outbound.protection.outlook.com ([104.47.41.134]:8672
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751473AbdIST2o (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2017 15:28:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=0oIVF1dkNDRtvDKjYkXQhgCKfIJpmuw4sG0LlxIdaeA=;
 b=bNiK93W6Dva3JlPwJa4Q9Prc3GXHcKznl44KNNyqhAc0AE8DCxS3deAVi4HON1+jntEO3QQGSW8yKgOALP8Pt70BILvwpGP2WrU/rFNBLKkgNfrkyI+H/MXpOhR4TopSlB0QMfy4qXTwFFTC0M4SFo52cFK7GAMJMvv6bReqIaQ=
Received: from localhost.localdomain (65.222.173.206) by
 CY4PR21MB0471.namprd21.prod.outlook.com (10.172.121.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.98.1; Tue, 19 Sep 2017 19:28:39 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     benpeart@microsoft.com
Cc:     David.Turner@twosigma.com, avarab@gmail.com,
        christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        johannes.schindelin@gmx.de, pclouds@gmail.com, peff@peff.net
Subject: [PATCH v7 10/12] fsmonitor: add test cases for fsmonitor extension
Date:   Tue, 19 Sep 2017 15:27:42 -0400
Message-Id: <20170919192744.19224-11-benpeart@microsoft.com>
X-Mailer: git-send-email 2.14.1.windows.1
In-Reply-To: <20170919192744.19224-1-benpeart@microsoft.com>
References: <20170915192043.4516-1-benpeart@microsoft.com>
 <20170919192744.19224-1-benpeart@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [65.222.173.206]
X-ClientProxiedBy: DM5PR03CA0030.namprd03.prod.outlook.com (10.174.189.147) To
 CY4PR21MB0471.namprd21.prod.outlook.com (10.172.121.149)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05e45ebf-2b0b-4e7b-42ad-08d4ff94a22d
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(300000503095)(300135400095)(48565401081)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:CY4PR21MB0471;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0471;3:Cmf9n9NrppNcNt3tdlw07oXeLUOzi80WH0xnR+yuIwrTXQw5o6Bi2MfVwyzzlHy8ZnB9oRPceHgL3MMw8N4+WAKmDWR2xlOey0o7xndZ4VKu63YoxHMsMnkFBeV7pOkhfn9kSnxNfnCj8f5+2XTPOg0m2pk28320JMPqC2q/9AxpS9rwg+QDE0actm/ards1TWxWdXcVNBL4eR+jZ+ZdytMTQ5tn2En7X2IFTAxN2TlFyjc+dP2JJKj2pe7u3Z3K;25:muJWP5kkdv327dxiQUfUN4SJ35GtudDxIegzYiY2xKH70pwovofg3ukBuHsb5KPJlOOT1li5dkl4uT9IIb0q7JslnNmKx/E+xorurhmthUSZLspTURaTTBC9jXCAxBOmHP6k7mgW8/Lw/Mx193HbCpkThAYKWLKmzB+Acr9kZGL3dyaM4WACUQ3AMXqoRn5wUD7vePSp11mJl1DnURms/SDBJuzcQx56gr2PthYDEL2eqoJbHKQwoUNk784V3Guf+oNv3BGErVX3TI5LuJ/dwBqzUPigY+ImAM3NsxokwUQNdxW3w3q/GN77esmPGgagUC6X7x88crd9/IqoIRcWdw==;31:I3pWR2Htn5Wr4gyRckNJvPEEABrmV68js3J22HvbusOBk3nqcoCeAuCB4H3+4JUReOC/31beVMu5CRkE8KbT64qHoUnmY+JCSa4lHnxhwcxhlGE4cZvVkvjyqQ36BSjl+pBAWGH4ASeb6w3FKlftx7aolWTXlz3+mVxamBMkhdyXVJ1WDPK5UPi9l+xNy+wgfwWeSfjX8vAo9CA3vrBO6XmfiJwlwcdYB1qak5QzPw4=
X-MS-TrafficTypeDiagnostic: CY4PR21MB0471:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0471;20:L0VxoVPYfVcgwsORIl9lMUq5eEjR7BFtnVlq49Bu6JXEkLnIZE+x2Ap9MJ1H0gUlKPf/jM1d4yHl+v8+1hQ+wLa+dRqkSESE6hV48t91RKS+0n4Ky23vnAdn+GdVylkiWJhDtwuoIwDDSlrQg19tlXVOOw4sMT8ewuDp4Ih7XZxjL6s5/V6m26ZJ+6EgaDUJ4ufhVbK/cnl0CCLDzdOhmFeOwh6JxIPoF8FKLq1zNMuvudVwtMijCqNLbjKgFLBzfH1LLBRIz8abLYPUZqZ7YcpIK4EJZOmLbSmN7XnvxCPPm7GBgVfifkexxKtc7vgdLJRPKN8x3dbTQ3A45knXS7RWCKzwdAO7jdS+V60usG+dNV4GPhIgtA++ciwlJrlikMHP8rMMwyaIJqqssoCF89TNTW1ghg/uzV2YF1kJZcetfA+zlstBCjCqeNehHKQATQslk/w3Y4w7fKrrSb5XjL/wO92ePMUaCRV1JLxxwbFzebqIu3+H7IdmOHqfaS7l;4:iUn+zqzwWILCxJMf08sowcSG6d21TyOrc/o7lV9EKgS2o2zksYto5y3Vbz809c5If/++dEntyPlrjGRyWoGwtl8urpIi/z9lrpMzg2s6N6UIS2f4k9+a9Y00Omij6pIcuB11RCNSQfGMcVqhj/iZkU9+MDmU20sZI+83e/swxy+V6drweBl85mtemp2nbPuCP55gL/5UnvWC2GUuzZ85u/TkDVKiiP+nbyefrZ2jbGvg+klyA8Qyh1IxD9gIJoAXptYLe1kbN3jUIM7AMC/yQOzuGxpCt64w41R8116oSCfbOigwufZOdTlfWVzdbsGGYvI6G1bpT+kMLK/nuefigA==
X-Exchange-Antispam-Report-Test: UriScan:(20558992708506)(89211679590171);
X-Microsoft-Antispam-PRVS: <CY4PR21MB0471629CC2549B8F7489BBDCF4600@CY4PR21MB0471.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(5005006)(8121501046)(93006095)(93001095)(100000703101)(100105400095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041248)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123560025)(20161123564025)(20161123555025)(20161123558100)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR21MB0471;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR21MB0471;
X-Forefront-PRVS: 04359FAD81
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(6009001)(346002)(376002)(39860400002)(47760400005)(189002)(199003)(25786009)(1076002)(2906002)(50226002)(478600001)(6486002)(6666003)(5660300001)(33646002)(48376002)(50466002)(36756003)(8676002)(16526017)(10290500003)(316002)(16586007)(37006003)(189998001)(97736004)(3846002)(22452003)(86612001)(81166006)(6116002)(305945005)(6512007)(4326008)(34206002)(101416001)(39060400002)(106356001)(105586002)(8656003)(76176999)(50986999)(68736007)(53936002)(2351001)(7736002)(10090500001)(5003940100001)(81156014)(8666007)(72206003)(2361001)(1511001)(8936002)(47776003)(6306002)(66066001)(2950100002)(6506006)(2421001)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0471;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR21MB0471;23:jha/7zvJUlzgZe5xu5p8+a3sVdUBzKdZV9erNsfuC?=
 =?us-ascii?Q?aTIzkVe75UWrkeWhS64lBEXOrBuJEJ5ECWKNgUGIwdKrdhGECLtIoYlUAgtm?=
 =?us-ascii?Q?MyybH1XD5F7VZWf3C1Ea1pmClr18+GwXFnjpELEYSiwRMLOQDGoHbWRUCaKH?=
 =?us-ascii?Q?2fgkC0IdiVGgduQVsVUUZiHE/KmUlpFMYSjob50sNh2lt/+GAIqZ0W2w3pAG?=
 =?us-ascii?Q?tqYnR4VQ/j53UTC9Io4jij3Aj8YQVhxd48VB+OGp7U/NVsLJtKnuJILFyuiF?=
 =?us-ascii?Q?j5sFkrMmWF+g38/0n+soIDnc1T1ZHtoYJHf2IduZcE0fut7Wwr4JOnvKmKQn?=
 =?us-ascii?Q?lVTvUIlux9RK1YgTUwK1ZcE5XyCdIEmzegv2vvovM5vd/zuhIrv2pg5lvFkJ?=
 =?us-ascii?Q?aVbKs2zCscnu4MBCeTB+MwGoxV84Qj73fk2X9ypoL4iyReeu0RPcybDB7KXa?=
 =?us-ascii?Q?Vik9eJca20iH+HU31QNBE7ToHMvA4PklKxEJunrfXVPn+gEpwueqV8S3ILT/?=
 =?us-ascii?Q?Zjh4Dz3t6mEM2W+Z3NbzzOrdrE8Ef14/HyOw9dUB0S7C40J6Tg2gzDipotkg?=
 =?us-ascii?Q?QfDH7J52xNoGizW3rPzAhNq0EKl36IFUPb/xBuOFr/3p99sypKhK3S1NTo1Q?=
 =?us-ascii?Q?QYySnVVhdgZ9770UJ0AjXzyLpkIyjoT9X43teae+0Kc7wKFWNB/iYbYmjVBm?=
 =?us-ascii?Q?r3m7L3BMkvA0791TjqtsleWPMPuFjuUguBqcNqLUXpmC5VvVrELoD/arhqY1?=
 =?us-ascii?Q?+Bph+elw9XoOAuF0qHhOk1gV6NYPS4betbgQzMcLx1YwWHFSlC5bM2zsmwHu?=
 =?us-ascii?Q?LqHDRKfbTJO1WFrIZ+duKhupbVAiHo0O+KykG3jwyXvLvhCefJGxC21rGfqE?=
 =?us-ascii?Q?OjXp7HJKURgmGn5EVqF1bYuwifJZZ220pwT42nhWFZge78YOdpXjWeDnIcW7?=
 =?us-ascii?Q?LYp62mHHl2JPDWIo/ckHS9wUdEtebr0JrUyZtb+RCsUAgG2TBZ+BXdliKzp+?=
 =?us-ascii?Q?zmEoBZ/LavClegcp8hP5t0oFNeeJ+n+5/X580i/Z1R0V5r3FtG2cAweVvCBa?=
 =?us-ascii?Q?AVvlc2lTMi/XxqTHYgrcTdlF38M0/RlevYn70lylZt1Ku6igEyJPIfJwR9Cw?=
 =?us-ascii?Q?cFVqUFGhpgmGTVeZ9HIw1xnEUTnuIApdtYosCyw+qKzlk802ekzXaLJGlFAm?=
 =?us-ascii?Q?GfBfBSeljNYarqcpJ7vHaMXNmNUotmdF18garTmBmaG1CilYcU3p8cPQ7zRH?=
 =?us-ascii?Q?oqEJ62OTNMp8fIa5uYyyPEIILjGWn0LjvZUTonuIy9TeWWZT2mbMGCIC5Qhp?=
 =?us-ascii?Q?qmXUPgjSlaztqqExCIv0SOV0WkyZg4ECmOtC7iPXhEn2DTG3m923NhlVwfYy?=
 =?us-ascii?Q?VI3u3TI63RQZZFXcFx5sl3/UYt1zMjYaqhnFTvtf5aB7w6DtzO6UHJbfRo7f?=
 =?us-ascii?Q?FF9IypgwvmFpvEgZUQflVML1biW2ExrQ4TixQLXPs0v7Vkx/j9j?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0471;6:cQlLEJ/gbBNrF1gy26wfxlcGKvJIOjrihOlvWfb1V6xIOMhbu6qckmB2gZtsa3fqEQXTrlojO8Yak7zVMiAUtVNAK1SK5pFN+mJp54cbaUOUj0wecfgj/OA+TlRE2jBd36rkDW8ikwyvTM0GIXgIGQ/t7tsfmI5ZDsQURSu/094cLlTOeBnee2NLZ5zO0otD3XALj1t0QOOasGyCMSCWFOQc7D9DdN29LQwZfVX6Jk7ZaCJyDyGWhq6ICfj7SykhiJFSA6NuEWXY4O6Yfm4Q1cUYKfJplvi5BN+uF3owgi1C3GIytl4ESK/0rFEfJW9Mmx43t1SJS3QkJtdWG9IRYA==;5:MwrUWJ+PYA/x4V4dvNKPXjkgImy0q9mG10ZZMOVXZt2m+RgO5A+2iT7I/VfxTUhENVlxfgquP5SCZM/EGkEu3WuB6yqmtyH1nChzpSGmkVKNcFGM9rDef7fQE4GGMRy/1tFcFFiHqY6924a2w2LvVg==;24:GyEn+vGkpCZGEB/ZWJZi/oKvgiTkAE5aNyNs9iqRRV2ywT6TwyPQMSBd/9YVyUfg1VPFXcjyhuX1+7zH+E4mbtxN+quMvLnJn63jlY0hdo8=;7:OYwcsiVMC84UR0FwwIn8NfQ6MzV8WUwljrefRYz0jiTHeW/88DaxWHp+FPqqk7kV7YwWHMXqHVP5uAfw8/09oyEMRWP17Ca4fuNHGbqxp9oNjEYaEf0ILJW4wu0aYrEoTjbkWLenD6Rxk9gmcb5ufUlmFd5lcUhI6owL26Y3YzH4DLmDI3Y6u8pT6CwdaTYyGDUU9IAW5GhSyugTRtct/jCLtz0XLcznZed6fTslOGE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2017 19:28:39.6106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0471
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test the ability to add/remove the fsmonitor index extension via
update-index.

Test that dirty files returned from the integration script are properly
represented in the index extension and verify that ls-files correctly
reports their state.

Test that ensure status results are correct when using the new fsmonitor
extension.  Test untracked, modified, and new files by ensuring the
results are identical to when not using the extension.

Test that if the fsmonitor extension doesn't tell git about a change, it
doesn't discover it on its own.  This ensures git is honoring the
extension and that we get the performance benefits desired.

Three test integration scripts are provided:

fsmonitor-all - marks all files as dirty
fsmonitor-none - marks no files as dirty
fsmonitor-watchman - integrates with Watchman with debug logging

To run tests in the test suite while utilizing fsmonitor:

First copy t/t7519/fsmonitor-all to a location in your path and then set
GIT_FORCE_PRELOAD_TEST=true and GIT_FSMONITOR_TEST=fsmonitor-all and run
your tests.

Note: currently when using the test script fsmonitor-watchman on
Windows, many tests fail due to a reported but not yet fixed bug in
Watchman where it holds on to handles for directories and files which
prevents the test directory from being cleaned up properly.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 t/t7519-status-fsmonitor.sh | 304 ++++++++++++++++++++++++++++++++++++++++++++
 t/t7519/fsmonitor-all       |  24 ++++
 t/t7519/fsmonitor-none      |  22 ++++
 t/t7519/fsmonitor-watchman  | 140 ++++++++++++++++++++
 4 files changed, 490 insertions(+)
 create mode 100755 t/t7519-status-fsmonitor.sh
 create mode 100755 t/t7519/fsmonitor-all
 create mode 100755 t/t7519/fsmonitor-none
 create mode 100755 t/t7519/fsmonitor-watchman

diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
new file mode 100755
index 0000000000..c6df85af5e
--- /dev/null
+++ b/t/t7519-status-fsmonitor.sh
@@ -0,0 +1,304 @@
+#!/bin/sh
+
+test_description='git status with file system watcher'
+
+. ./test-lib.sh
+
+#
+# To run the entire git test suite using fsmonitor:
+#
+# copy t/t7519/fsmonitor-all to a location in your path and then set
+# GIT_FSMONITOR_TEST=fsmonitor-all and run your tests.
+#
+
+# Note, after "git reset --hard HEAD" no extensions exist other than 'TREE'
+# "git update-index --fsmonitor" can be used to get the extension written
+# before testing the results.
+
+clean_repo () {
+	git reset --hard HEAD &&
+	git clean -fd
+}
+
+dirty_repo () {
+	: >untracked &&
+	: >dir1/untracked &&
+	: >dir2/untracked &&
+	echo 1 >modified &&
+	echo 2 >dir1/modified &&
+	echo 3 >dir2/modified &&
+	echo 4 >new &&
+	echo 5 >dir1/new &&
+	echo 6 >dir2/new
+}
+
+write_integration_script () {
+	write_script .git/hooks/fsmonitor-test<<-\EOF
+	if test "$#" -ne 2
+	then
+		echo "$0: exactly 2 arguments expected"
+		exit 2
+	fi
+	if test "$1" != 1
+	then
+		echo "Unsupported core.fsmonitor hook version." >&2
+		exit 1
+	fi
+	printf "untracked\0"
+	printf "dir1/untracked\0"
+	printf "dir2/untracked\0"
+	printf "modified\0"
+	printf "dir1/modified\0"
+	printf "dir2/modified\0"
+	printf "new\0"
+	printf "dir1/new\0"
+	printf "dir2/new\0"
+	EOF
+}
+
+test_lazy_prereq UNTRACKED_CACHE '
+	{ git update-index --test-untracked-cache; ret=$?; } &&
+	test $ret -ne 1
+'
+
+test_expect_success 'setup' '
+	mkdir -p .git/hooks &&
+	: >tracked &&
+	: >modified &&
+	mkdir dir1 &&
+	: >dir1/tracked &&
+	: >dir1/modified &&
+	mkdir dir2 &&
+	: >dir2/tracked &&
+	: >dir2/modified &&
+	git -c core.fsmonitor= add . &&
+	git -c core.fsmonitor= commit -m initial &&
+	git config core.fsmonitor .git/hooks/fsmonitor-test &&
+	cat >.gitignore <<-\EOF
+	.gitignore
+	expect*
+	actual*
+	marker*
+	EOF
+'
+
+# test that the fsmonitor extension is off by default
+test_expect_success 'fsmonitor extension is off by default' '
+	test-dump-fsmonitor >actual &&
+	grep "^no fsmonitor" actual
+'
+
+# test that "update-index --fsmonitor" adds the fsmonitor extension
+test_expect_success 'update-index --fsmonitor" adds the fsmonitor extension' '
+	git update-index --fsmonitor &&
+	test-dump-fsmonitor >actual &&
+	grep "^fsmonitor last update" actual
+'
+
+# test that "update-index --no-fsmonitor" removes the fsmonitor extension
+test_expect_success 'update-index --no-fsmonitor" removes the fsmonitor extension' '
+	git update-index --no-fsmonitor &&
+	test-dump-fsmonitor >actual &&
+	grep "^no fsmonitor" actual
+'
+
+cat >expect <<EOF &&
+h dir1/modified
+H dir1/tracked
+h dir2/modified
+H dir2/tracked
+h modified
+H tracked
+EOF
+
+# test that "update-index --fsmonitor-valid" sets the fsmonitor valid bit
+test_expect_success 'update-index --fsmonitor-valid" sets the fsmonitor valid bit' '
+	git update-index --fsmonitor &&
+	git update-index --fsmonitor-valid dir1/modified &&
+	git update-index --fsmonitor-valid dir2/modified &&
+	git update-index --fsmonitor-valid modified &&
+	git ls-files -f >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<EOF &&
+H dir1/modified
+H dir1/tracked
+H dir2/modified
+H dir2/tracked
+H modified
+H tracked
+EOF
+
+# test that "update-index --no-fsmonitor-valid" clears the fsmonitor valid bit
+test_expect_success 'update-index --no-fsmonitor-valid" clears the fsmonitor valid bit' '
+	git update-index --no-fsmonitor-valid dir1/modified &&
+	git update-index --no-fsmonitor-valid dir2/modified &&
+	git update-index --no-fsmonitor-valid modified &&
+	git ls-files -f >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<EOF &&
+H dir1/modified
+H dir1/tracked
+H dir2/modified
+H dir2/tracked
+H modified
+H tracked
+EOF
+
+# test that all files returned by the script get flagged as invalid
+test_expect_success 'all files returned by integration script get flagged as invalid' '
+	write_integration_script &&
+	dirty_repo &&
+	git update-index --fsmonitor &&
+	git ls-files -f >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<EOF &&
+H dir1/modified
+h dir1/new
+H dir1/tracked
+H dir2/modified
+h dir2/new
+H dir2/tracked
+H modified
+h new
+H tracked
+EOF
+
+# test that newly added files are marked valid
+test_expect_success 'newly added files are marked valid' '
+	git add new &&
+	git add dir1/new &&
+	git add dir2/new &&
+	git ls-files -f >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<EOF &&
+H dir1/modified
+h dir1/new
+h dir1/tracked
+H dir2/modified
+h dir2/new
+h dir2/tracked
+H modified
+h new
+h tracked
+EOF
+
+# test that all unmodified files get marked valid
+test_expect_success 'all unmodified files get marked valid' '
+	# modified files result in update-index returning 1
+	test_must_fail git update-index --refresh --force-write-index &&
+	git ls-files -f >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<EOF &&
+H dir1/modified
+h dir1/tracked
+h dir2/modified
+h dir2/tracked
+h modified
+h tracked
+EOF
+
+# test that *only* files returned by the integration script get flagged as invalid
+test_expect_success '*only* files returned by the integration script get flagged as invalid' '
+	write_script .git/hooks/fsmonitor-test<<-\EOF &&
+	printf "dir1/modified\0"
+	EOF
+	clean_repo &&
+	git update-index --refresh --force-write-index &&
+	echo 1 >modified &&
+	echo 2 >dir1/modified &&
+	echo 3 >dir2/modified &&
+	test_must_fail git update-index --refresh --force-write-index &&
+	git ls-files -f >actual &&
+	test_cmp expect actual
+'
+
+# Ensure commands that call refresh_index() to move the index back in time
+# properly invalidate the fsmonitor cache
+test_expect_success 'refresh_index() invalidates fsmonitor cache' '
+	write_script .git/hooks/fsmonitor-test<<-\EOF &&
+	EOF
+	clean_repo &&
+	dirty_repo &&
+	git add . &&
+	git commit -m "to reset" &&
+	git reset HEAD~1 &&
+	git status >actual &&
+	git -c core.fsmonitor= status >expect &&
+	test_i18ncmp expect actual
+'
+
+# test fsmonitor with and without preloadIndex
+preload_values="false true"
+for preload_val in $preload_values
+do
+	test_expect_success "setup preloadIndex to $preload_val" '
+		git config core.preloadIndex $preload_val &&
+		if test $preload_val = true
+		then
+			GIT_FORCE_PRELOAD_TEST=$preload_val; export GIT_FORCE_PRELOAD_TEST
+		else
+			unset GIT_FORCE_PRELOAD_TEST
+		fi
+	'
+
+	# test fsmonitor with and without the untracked cache (if available)
+	uc_values="false"
+	test_have_prereq UNTRACKED_CACHE && uc_values="false true"
+	for uc_val in $uc_values
+	do
+		test_expect_success "setup untracked cache to $uc_val" '
+			git config core.untrackedcache $uc_val
+		'
+
+		# Status is well tested elsewhere so we'll just ensure that the results are
+		# the same when using core.fsmonitor.
+		test_expect_success 'compare status with and without fsmonitor' '
+			write_integration_script &&
+			clean_repo &&
+			dirty_repo &&
+			git add new &&
+			git add dir1/new &&
+			git add dir2/new &&
+			git status >actual &&
+			git -c core.fsmonitor= status >expect &&
+			test_i18ncmp expect actual
+		'
+
+		# Make sure it's actually skipping the check for modified and untracked
+		# (if enabled) files unless it is told about them.
+		test_expect_success "status doesn't detect unreported modifications" '
+			write_script .git/hooks/fsmonitor-test<<-\EOF &&
+			:>marker
+			EOF
+			clean_repo &&
+			git status &&
+			test_path_is_file marker &&
+			dirty_repo &&
+			rm -f marker &&
+			git status >actual &&
+			test_path_is_file marker &&
+			test_i18ngrep ! "Changes not staged for commit:" actual &&
+			if test $uc_val = true
+			then
+				test_i18ngrep ! "Untracked files:" actual
+			fi &&
+			if test $uc_val = false
+			then
+				test_i18ngrep "Untracked files:" actual
+			fi &&
+			rm -f marker
+		'
+	done
+done
+
+test_done
diff --git a/t/t7519/fsmonitor-all b/t/t7519/fsmonitor-all
new file mode 100755
index 0000000000..691bc94dc2
--- /dev/null
+++ b/t/t7519/fsmonitor-all
@@ -0,0 +1,24 @@
+#!/bin/sh
+#
+# An test hook script to integrate with git to test fsmonitor.
+#
+# The hook is passed a version (currently 1) and a time in nanoseconds
+# formatted as a string and outputs to stdout all files that have been
+# modified since the given time. Paths must be relative to the root of
+# the working tree and separated by a single NUL.
+#
+#echo "$0 $*" >&2
+
+if test "$#" -ne 2
+then
+	echo "$0: exactly 2 arguments expected" >&2
+	exit 2
+fi
+
+if test "$1" != 1
+then
+	echo "Unsupported core.fsmonitor hook version." >&2
+	exit 1
+fi
+
+echo "/"
diff --git a/t/t7519/fsmonitor-none b/t/t7519/fsmonitor-none
new file mode 100755
index 0000000000..ed9cf5a6a9
--- /dev/null
+++ b/t/t7519/fsmonitor-none
@@ -0,0 +1,22 @@
+#!/bin/sh
+#
+# An test hook script to integrate with git to test fsmonitor.
+#
+# The hook is passed a version (currently 1) and a time in nanoseconds
+# formatted as a string and outputs to stdout all files that have been
+# modified since the given time. Paths must be relative to the root of
+# the working tree and separated by a single NUL.
+#
+#echo "$0 $*" >&2
+
+if test "$#" -ne 2
+then
+	echo "$0: exactly 2 arguments expected" >&2
+	exit 2
+fi
+
+if test "$1" != 1
+then
+	echo "Unsupported core.fsmonitor hook version." >&2
+	exit 1
+fi
diff --git a/t/t7519/fsmonitor-watchman b/t/t7519/fsmonitor-watchman
new file mode 100755
index 0000000000..7ceb32dc18
--- /dev/null
+++ b/t/t7519/fsmonitor-watchman
@@ -0,0 +1,140 @@
+#!/usr/bin/perl
+
+use strict;
+use warnings;
+use IPC::Open2;
+
+# An example hook script to integrate Watchman
+# (https://facebook.github.io/watchman/) with git to speed up detecting
+# new and modified files.
+#
+# The hook is passed a version (currently 1) and a time in nanoseconds
+# formatted as a string and outputs to stdout all files that have been
+# modified since the given time. Paths must be relative to the root of
+# the working tree and separated by a single NUL.
+#
+# To enable this hook, rename this file to "query-watchman" and set
+# 'git config core.fsmonitor .git/hooks/query-watchman'
+#
+my ($version, $time) = @ARGV;
+#print STDERR "$0 $version $time\n";
+
+# Check the hook interface version
+
+if ($version == 1) {
+	# convert nanoseconds to seconds
+	$time = int $time / 1000000000;
+} else {
+	die "Unsupported query-fsmonitor hook version '$version'.\n" .
+	    "Falling back to scanning...\n";
+}
+
+# Convert unix style paths to escaped Windows style paths when running
+# in Windows command prompt
+
+my $system = `uname -s`;
+$system =~ s/[\r\n]+//g;
+my $git_work_tree;
+
+if ($system =~ m/^MSYS_NT/) {
+	$git_work_tree = `cygpath -aw "\$PWD"`;
+	$git_work_tree =~ s/[\r\n]+//g;
+	$git_work_tree =~ s,\\,/,g;
+} else {
+	$git_work_tree = $ENV{'PWD'};
+}
+
+my $retry = 1;
+
+launch_watchman();
+
+sub launch_watchman {
+
+	# Set input record separator
+	local $/ = 0666;
+
+	my $pid = open2(\*CHLD_OUT, \*CHLD_IN, 'watchman -j')
+	    or die "open2() failed: $!\n" .
+	    "Falling back to scanning...\n";
+
+	# In the query expression below we're asking for names of files that
+	# changed since $time but were not transient (ie created after
+	# $time but no longer exist).
+	#
+	# To accomplish this, we're using the "since" generator to use the
+	# recency index to select candidate nodes and "fields" to limit the
+	# output to file names only. Then we're using the "expression" term to
+	# further constrain the results.
+	#
+	# The category of transient files that we want to ignore will have a
+	# creation clock (cclock) newer than $time_t value and will also not
+	# currently exist.
+
+	my $query = <<"	END";
+		["query", "$git_work_tree", {
+			"since": $time,
+			"fields": ["name"],
+			"expression": ["not", ["allof", ["since", $time, "cclock"], ["not", "exists"]]]
+		}]
+	END
+	
+	open (my $fh, ">", ".git/watchman-query.json");
+	print $fh $query;
+	close $fh;
+
+	print CHLD_IN $query;
+	my $response = <CHLD_OUT>;
+
+	open ($fh, ">", ".git/watchman-response.json");
+	print $fh $response;
+	close $fh;
+
+	die "Watchman: command returned no output.\n" .
+	    "Falling back to scanning...\n" if $response eq "";
+	die "Watchman: command returned invalid output: $response\n" .
+	    "Falling back to scanning...\n" unless $response =~ /^\{/;
+
+	my $json_pkg;
+	eval {
+		require JSON::XS;
+		$json_pkg = "JSON::XS";
+		1;
+	} or do {
+		require JSON::PP;
+		$json_pkg = "JSON::PP";
+	};
+
+	my $o = $json_pkg->new->utf8->decode($response);
+
+	if ($retry > 0 and $o->{error} and $o->{error} =~ m/unable to resolve root .* directory (.*) is not watched/) {
+		print STDERR "Adding '$git_work_tree' to watchman's watch list.\n";
+		$retry--;
+		qx/watchman watch "$git_work_tree"/;
+		die "Failed to make watchman watch '$git_work_tree'.\n" .
+		    "Falling back to scanning...\n" if $? != 0;
+
+		# Watchman will always return all files on the first query so
+		# return the fast "everything is dirty" flag to git and do the
+		# Watchman query just to get it over with now so we won't pay
+		# the cost in git to look up each individual file.
+
+		open ($fh, ">", ".git/watchman-output.out");
+		print "/\0";
+		close $fh;
+
+		print "/\0";
+		eval { launch_watchman() };
+		exit 0;
+	}
+
+	die "Watchman: $o->{error}.\n" .
+	    "Falling back to scanning...\n" if $o->{error};
+
+	open ($fh, ">", ".git/watchman-output.out");
+	print $fh @{$o->{files}};
+	close $fh;
+
+	binmode STDOUT, ":utf8";
+	local $, = "\0";
+	print @{$o->{files}};
+}
-- 
2.14.1.windows.1

