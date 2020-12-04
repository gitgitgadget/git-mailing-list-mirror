Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F4D3C4361A
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 15:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0806922B42
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 15:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730570AbgLDPYd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 10:24:33 -0500
Received: from mail-eopbgr70105.outbound.protection.outlook.com ([40.107.7.105]:50591
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726116AbgLDPYc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 10:24:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ClxIQFGSdaGrNRNvO958mKyNSiGYLQqmPOpMzLx+KG1rV5hsuXGbOv/by5Uis6c1Wcqppu7B61oc6gDwIq9Vdm1hfQcMyvcT2zu4nlY4jArVnc522UY/10ypUyKyI9cUl2unfB7NdQyeeKGbhVuFwM35wbAHo6HJM/Gia3JUF+HTQP1mUoBiEFPITQz/FhH5HuA54Z2vov25egefeHU/FcL+SixlEgIAwazHvRyIEEQEdTWlM0b7JbzhuQ/dGeKZcpcL0JRpxdDtuq5f9+2b5mOdVfbGYxwhHC4oLVIMT7FTD872Kxgf16uqvZb36OqECo4n2Ld9soMlrWOSrmcs4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KIPi7zb2MQ9++8vIJsdlFzuXB/GwotSwq9PcJGnPQaw=;
 b=bmDtd3xPgekANBR0w2EKB1fQs3KQ4MWRwv7c0XfYVKiwTW6jtJpKQCX+MOIPb8i5JIa4IHtOfoEOjOBl2PfLCUFqU3HkrNxoGQssqgtMbYyjVfp2xcDiUqyyVjSr9pzaHxF1g5e/VS2/dA2PNXNP6x6vi8LvFVxXKNVUfxDjnbvSkVKuT2UU6ksxWBAGmPyeKq38IRLOBdY8k1ZxfwONxfoNO2xmddvhdH6VxfPawlSU/LVESUFCCrVTxcqHHd33oNgIg4AWgIAaB9aKwwlo4+l9X794J9icliVPLSQsnq24M4toxY88hyf0t9Jj07cs9wqx+R8SeMaGR4u7tvlCUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 131.228.6.101) smtp.rcpttodomain=gmail.com smtp.mailfrom=nokia.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KIPi7zb2MQ9++8vIJsdlFzuXB/GwotSwq9PcJGnPQaw=;
 b=G94rekUcip/gxeoqiEhClgzRSSoT5Vd6GELSh2VsbJgLMcJBcD1xk7yhe+ZzVoLFldUkle5CBNWMO6qWBCSeYt6upPn9APJUmZNuvQrKPe/bm6zHkKf5wMvRXrMbXoAnvMBrtlN8U4ooV5bumrVGm0iPh9AgYkt4JV9Xfr4Am6c=
Received: from AM6PR05CA0016.eurprd05.prod.outlook.com (2603:10a6:20b:2e::29)
 by DB7PR07MB5771.eurprd07.prod.outlook.com (2603:10a6:10:85::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.15; Fri, 4 Dec
 2020 15:23:40 +0000
Received: from VE1EUR03FT051.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:2e:cafe::92) by AM6PR05CA0016.outlook.office365.com
 (2603:10a6:20b:2e::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend
 Transport; Fri, 4 Dec 2020 15:23:40 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 131.228.6.101) smtp.mailfrom=nokia.com; gmail.com; dkim=none (message not
 signed) header.d=none;gmail.com; dmarc=fail action=none
 header.from=nokia.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 nokia.com discourages use of 131.228.6.101 as permitted sender)
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 VE1EUR03FT051.mail.protection.outlook.com (10.152.19.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.17 via Frontend Transport; Fri, 4 Dec 2020 15:23:40 +0000
Received: from ulegcpbofur.emea.nsn-net.net (ulegcpbofur.emea.nsn-net.net [10.151.74.147])
        by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 0B4FNbZj025084;
        Fri, 4 Dec 2020 15:23:37 GMT
From:   Peter Kaestle <peter.kaestle@nokia.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        git@vger.kernel.org
Cc:     Peter Kaestle <peter.kaestle@nokia.com>,
        Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] submodules: fix of regression on fetching of non-init subsub-repo
Date:   Fri,  4 Dec 2020 16:23:32 +0100
Message-Id: <1607095412-40109-1-git-send-email-peter.kaestle@nokia.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <0b6a34a0-428e-5fc4-307d-1217b112659c@nokia.com>
References: <0b6a34a0-428e-5fc4-307d-1217b112659c@nokia.com>
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: db014115-4e00-42fe-6ea0-08d898689461
X-MS-TrafficTypeDiagnostic: DB7PR07MB5771:
X-Microsoft-Antispam-PRVS: <DB7PR07MB57711438CF9201F75C73FA82EEF10@DB7PR07MB5771.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:324;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ymg/wt7tuyO4sXKBqI+K8W1Lo/N6lQwLuwRfuzvUYmp8C/xspTkcF8u58xDZKF+skH7zdaytEzw+S6ivkdMWu7jq4a4ceT8UJ9kY7FbW+vKKCMHdK9AoLNjqF6Bv4DgZ763nB0gz7DILvou+Tl4XzBDoaRAtJ4k7tPPR/EXrSJ8IsFXiQrYPE357/tWN0LyWrkbzz6mUXuiA4jrdquvVTr7D0vS+BdijuoG5HdCAcJLX1xxTRRW2AQ8FpMLRAc9pqlCqq2cLBcRT8VckKGbdcbXK8HFJT3Edim/kW1xmoHRc/Fx5eRh6BBL8HnV+GoiQ1wVguJPz+pmG6NY648DP8PcQHKU3idcRmpHF80uexnNLMW1xk6OWPcKIrWXT+m5GL5C/Jxe2gz0Z6u3oKHI0lQ==
X-Forefront-Antispam-Report: CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(376002)(396003)(46966005)(70206006)(8936002)(82740400003)(2906002)(8676002)(82310400003)(6666004)(356005)(83380400001)(70586007)(5660300002)(316002)(478600001)(2616005)(336012)(110136005)(81166007)(54906003)(186003)(26005)(86362001)(4326008)(47076004)(36756003)(4001150100001)(44832011);DIR:OUT;SFP:1102;
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2020 15:23:40.5389
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db014115-4e00-42fe-6ea0-08d898689461
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT051.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR07MB5771
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A regression has been introduced by a62387b (submodule.c: fetch in
submodules git directory instead of in worktree, 2018-11-28).

The scenario in which it triggers is when one has a remote repository
with a subrepository inside a subrepository like this:
superproject/middle_repo/inner_repo

Person A and B have both a clone of it, while Person B is not working
with the inner_repo and thus does not have it initialized in his working
copy.

Now person A introduces a change to the inner_repo and propagates it
through the middle_repo and the superproject.

Once person A pushed the changes and person B wants to fetch them using
"git fetch" on superproject level, B's git call will return with error
saying:

Could not access submodule 'inner_repo'
Errors during submodule fetch:
         middle_repo

Expectation is that in this case the inner submodule will be recognized
as uninitialized subrepository and skipped by the git fetch command.

This used to work correctly before 'a62387b (submodule.c: fetch in
submodules git directory instead of in worktree, 2018-11-28)'.

Starting with a62387b the code wants to evaluate "is_empty_dir()" inside
.git/modules for a directory only existing in the worktree, delivering
then of course wrong return value.

This patch ensures is_empty_dir() is getting the correct path of the
uninitialized submodule by concatenation of the actual worktree and the
name of the uninitialized submodule.

Furthermore a regression test case is added, which tests for recursive
fetches on a superproject with uninitialized sub repositories.  This
issue was leading to an infinite loop when doing a revert of a62387b.

Signed-off-by: Peter Kaestle <peter.kaestle@nokia.com>
CC: Junio C Hamano <gitster@pobox.com>
CC: Philippe Blain <levraiphilippeblain@gmail.com>
CC: Ralf Thielow <ralf.thielow@gmail.com>
---
 submodule.c                 |  7 ++-
 t/t5526-fetch-submodules.sh | 94 +++++++++++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+), 1 deletion(-)

diff --git a/submodule.c b/submodule.c
index b3bb59f066..b561445329 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1477,6 +1477,7 @@ static int get_next_submodule(struct child_process *cp,
 			strbuf_release(&submodule_prefix);
 			return 1;
 		} else {
+			struct strbuf empty_submodule_path = STRBUF_INIT;
 
 			fetch_task_release(task);
 			free(task);
@@ -1485,13 +1486,17 @@ static int get_next_submodule(struct child_process *cp,
 			 * An empty directory is normal,
 			 * the submodule is not initialized
 			 */
+			strbuf_addf(&empty_submodule_path, "%s/%s/",
+							spf->r->worktree,
+							ce->name);
 			if (S_ISGITLINK(ce->ce_mode) &&
-			    !is_empty_dir(ce->name)) {
+			    !is_empty_dir(empty_submodule_path.buf)) {
 				spf->result = 1;
 				strbuf_addf(err,
 					    _("Could not access submodule '%s'\n"),
 					    ce->name);
 			}
+			strbuf_release(&empty_submodule_path);
 		}
 	}
 
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index dd8e423d25..04eb587862 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -719,4 +719,98 @@ test_expect_success 'fetch new submodule commit intermittently referenced by sup
 	)
 '
 
+add_commit_push () {
+	dir="$1"
+	msg="$2"
+	shift 2
+	git -C "$dir" add "$@" &&
+	git -C "$dir" commit -a -m "$msg" &&
+	git -C "$dir" push
+}
+
+compare_refs_in_dir () {
+	fail= &&
+	if test "x$1" = 'x!'
+	then
+		fail='!' &&
+		shift
+	fi &&
+	git -C "$1" rev-parse --verify "$2" >expect &&
+	git -C "$3" rev-parse --verify "$4" >actual &&
+	eval $fail test_cmp expect actual
+}
+
+
+test_expect_success 'setup nested submodule fetch test' '
+	# does not depend on any previous test setups
+
+	for repo in outer middle inner
+	do
+		(
+			git init --bare $repo &&
+			git clone $repo ${repo}_content &&
+			echo "$repo" >"${repo}_content/file" &&
+			add_commit_push ${repo}_content "initial" file
+		) || return 1
+	done &&
+
+	git clone outer A &&
+	git -C A submodule add "$pwd/middle" &&
+	git -C A/middle/ submodule add "$pwd/inner" &&
+	add_commit_push A/middle/ "adding inner sub" .gitmodules inner &&
+	add_commit_push A/ "adding middle sub" .gitmodules middle &&
+
+	git clone outer B &&
+	git -C B/ submodule update --init middle &&
+
+	compare_refs_in_dir A HEAD B HEAD &&
+	compare_refs_in_dir A/middle HEAD B/middle HEAD &&
+	test -f B/file &&
+	test -f B/middle/file &&
+	! test -f B/middle/inner/file &&
+
+	echo "change on inner repo of A" >"A/middle/inner/file" &&
+	add_commit_push A/middle/inner "change on inner" file &&
+	add_commit_push A/middle "change on inner" inner &&
+	add_commit_push A "change on inner" middle
+'
+
+test_expect_success 'fetching a superproject containing an uninitialized sub/sub project' '
+	# depends on previous test for setup
+
+	git -C B/ fetch &&
+	compare_refs_in_dir A origin/master B origin/master
+'
+
+
+test_expect_success 'setup recursive fetch with uninit submodule' '
+	# does not depend on any previous test setups
+
+	git init main &&
+	git init sub &&
+
+	touch sub/file &&
+	git -C sub add file &&
+	git -C sub commit -m "add file" &&
+	git -C sub rev-parse HEAD >expect &&
+
+	git -C main submodule add ../sub &&
+	git -C main submodule init &&
+	git -C main submodule update --checkout &&
+	git -C main submodule status |
+		sed -e "s/^ //" -e "s/ sub .*$//" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'recursive fetch with uninit submodule' '
+	# depends on previous test for setup
+
+	git -C main submodule deinit -f sub &&
+	! git -C main fetch --recurse-submodules |&
+		grep -v -m1 "Fetching submodule sub$" &&
+	git -C main submodule status |
+		sed -e "s/^-//" -e "s/ sub$//" >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.29.2

