Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE6921F597
	for <e@80x24.org>; Fri, 27 Jul 2018 12:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388485AbeG0OVg (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 10:21:36 -0400
Received: from mail-bn3nam01on0130.outbound.protection.outlook.com ([104.47.33.130]:27072
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730971AbeG0OVg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 10:21:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a1P29TDMpUDJ7jeYAo6yuhggs20+jMJxfs6HKZOL9IQ=;
 b=HYd3/fuqO8IRw3dAjGdrSqdQCWqhhAyVBx7UU2JXf7TFXqT2g3hxbbGNzO9yAV3ShRa4u8TyysRuSutEwmC5Ahn7twzwmNEPvJmLdrGBaAgv5fD92/rqQELQOGxmSRmxFvobq4yWYdAx8OBoRw+Pt04XQs0NYwInNZyTT8AXnzI=
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com (52.132.146.19) by
 MW2PR2101MB1131.namprd21.prod.outlook.com (52.132.146.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.2; Fri, 27 Jul 2018 12:59:43 +0000
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::c945:950:24b2:65cd]) by MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::c945:950:24b2:65cd%4]) with mapi id 15.20.1017.000; Fri, 27 Jul 2018
 12:59:43 +0000
From:   Ben Peart <Ben.Peart@microsoft.com>
To:     "peartben@gmail.com" <peartben@gmail.com>
CC:     Ben Peart <Ben.Peart@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Kevin Willford <kewillf@microsoft.com>,
        "newren@gmail.com" <newren@gmail.com>
Subject: [PATCH v2 1/2] t3507: add a testcase showing failure with sparse
 checkout
Thread-Topic: [PATCH v2 1/2] t3507: add a testcase showing failure with sparse
 checkout
Thread-Index: AQHUJamv2HyFBMIOrEWyMJQzH6WvmA==
Date:   Fri, 27 Jul 2018 12:59:42 +0000
Message-ID: <20180727125923.11744-2-benpeart@microsoft.com>
References: <5a8d1098-b4c5-64e1-da98-dac13521e7ba@gmail.com>
 <20180727125923.11744-1-benpeart@microsoft.com>
In-Reply-To: <20180727125923.11744-1-benpeart@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.33.148.227]
x-mailer: git-send-email 2.17.0.gvfs.1.123.g449c066
x-clientproxiedby: DM5PR12CA0015.namprd12.prod.outlook.com (2603:10b6:4:1::25)
 To MW2PR2101MB0970.namprd21.prod.outlook.com (2603:10b6:302:4::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1131;6:aag2EnHyenRR0kUUNbNGw+M3yTJKmMv5olWHKY3WqX3Q9VTlPdV6FOegU1nm2OJqCtioL9nVNj3FsWYB/ysQrFyIN+PsyZwRUBz+98ND1GwfJwO6cBY1JOwI29hBCBqY/zhcuZylJGDb1GFjROBmtNoiCJyg1gPIkPX3g3R99tZtpgSzHBm2BKlKbu/ygpihTBiv4O2d64x6SFMD0H3bBtbbcJrX8osO/0febdcqsiM9HsotBuT7Iuelfc19h3ZMJ0ipnND8IA5uS/0s5LWPrmubC5wHYvNT7XVkSBTZrXj+uTB6jkszrguMn03My+LHDK8Myx7LFJtXobiauClTKpgQnDKEIBP8LSkphNhHRsXw494SZrOL0nY/oSwVUntJ9ljPVu2CtYkIPz/lTg1qEMk451UjCyessQScHsWjY05MHzSI/ZIrtSdVVcMkxJhwf+8qhP00igSGTmgpHdJi9A==;5:VB27eENSKlsEYW95mnJdlK0fDLOnh6hvzZ1HIBWfjFw5zWzL5P+fUvkm5IxKn3Fk3n3MalxvpBNVUe5aiE0+eEvjO1OZmB+Fy85AVdnr5t697VmnaC81mppBKw1DRra80/mqMV3flD6734jmMTfYkkXi8b0ffRiq/P/fWejoQbw=;7:UQQWuqIy9ycruSZbUKstptJxInG4HHSZ57Mt8SqYrhDPSHOKb48OmOriFnXdJYChvKXHaarMH8oG030WvWYGKIBF1t6QSMMGo10hjkdo3p3jffj/GgXS4ajXtpEI0Kh3vv+9eHtCHwXApLG/OEwKY4kMeJtmRduGLB7WjoHlpsWqdMGdvtHyqx50tr62EyBDja/xrhhAgRi/AI7h0swFG2oLqnwkATSL1lGFyfi8jstEHt08BUeaILDLuSvl4anl
x-ms-office365-filtering-correlation-id: 87cfbf43-1a85-4f97-9d13-08d5f3c0d1e7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:MW2PR2101MB1131;
x-ms-traffictypediagnostic: MW2PR2101MB1131:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-prvs: <MW2PR2101MB11315CF353A8DE567C904CABF42A0@MW2PR2101MB1131.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:MW2PR2101MB1131;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1131;
x-forefront-prvs: 07467C4D33
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(366004)(346002)(396003)(136003)(199004)(189003)(99286004)(1361003)(476003)(446003)(25786009)(186003)(5250100002)(14444005)(4326008)(256004)(54906003)(2616005)(486006)(26005)(52116002)(6916009)(11346002)(39060400002)(81166006)(81156014)(86612001)(8676002)(66066001)(53936002)(5640700003)(6512007)(5660300001)(1411001)(386003)(76176011)(102836004)(7736002)(6486002)(305945005)(6506007)(1730700003)(8936002)(97736004)(6116002)(316002)(105586002)(106356001)(14454004)(72206003)(2351001)(10290500003)(68736007)(3846002)(2501003)(22452003)(2906002)(10090500001)(478600001)(36756003)(50226002)(1076002)(2900100001)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1131;H:MW2PR2101MB0970.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: vTp9SE6eg79Lk+445lrDTWzVu0GTznfFFJwzlqFjTr64DBSctA9ARWtfhivnpjCuvvhpR57JCzaLaaJBFeYXeYs9f/mCdVojbYrCXJzUgX7lrLMS9EhjapFIsTUM71NG2fpWkVCH5wIRJ6NosnZ+EW3NuD23+QxKlo0rIX5aKc0z7WpC/whckDX3CCW6ZCpD9W1OFQYFGp6zWjUbCNpVEzckUaNeLJc4w8U8TFZn8pBVmV//gSQxkHMPJW/JEHUVn6mUiV36XPK4e0dYEyD6qyfChK1gylaGJvGQmjCMNXpZj1wYd9uIzp2Ld68HJV0ISv4Edk2pBwjFiVqS7mJJQ5ZGnvBDpS5jgKFhIpiQ7No=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87cfbf43-1a85-4f97-9d13-08d5f3c0d1e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2018 12:59:42.9604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1131
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Peart <peartben@gmail.com>

Recent changes in merge_content() induced a bug when merging files that are
not present in the local working directory due to sparse-checkout. Add a
test case to demonstrate the bug so that we can ensure the fix resolves
it and to prevent future regressions.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t3507-cherry-pick-conflict.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict=
.sh
index 7c5ad08626..45ddd81bfa 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -392,4 +392,17 @@ test_expect_success 'commit --amend -s places the sign=
-off at the right place' '
 	test_cmp expect actual
 '
=20
+test_expect_failure 'cherry-pick preserves sparse-checkout' '
+	pristine_detach initial &&
+	test_config core.sparseCheckout true &&
+	test_when_finished "
+		echo \"/*\" >.git/info/sparse-checkout
+		git read-tree --reset -u HEAD
+		rm .git/info/sparse-checkout" &&
+	echo /unrelated >.git/info/sparse-checkout &&
+	git read-tree --reset -u HEAD &&
+	test_must_fail git cherry-pick -Xours picked>actual &&
+	test_i18ngrep ! "Changes not staged for commit:" actual
+'
+
 test_done
--=20
2.17.0.gvfs.1.123.g449c066

