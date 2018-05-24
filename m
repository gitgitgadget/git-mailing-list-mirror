Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B385A1F42D
	for <e@80x24.org>; Thu, 24 May 2018 16:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033615AbeEXQ0v (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 12:26:51 -0400
Received: from mail-by2nam01on0132.outbound.protection.outlook.com ([104.47.34.132]:51472
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1031096AbeEXQ0I (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 12:26:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YM01jPM4za0HhRbWtG8uCm+A3YeHyS+xUbkbQ0ME3yg=;
 b=gPxM4YhjmZzAYpFT5nb2NQrWtjL0Z/MIH96+eXqvpudrhsvECs/T02kxOGiZYEpV84LGRVTArJTpsADh7frryqgF5imapxv2tzEHUAsimhnImNrvS0zU8gd7DTbI53sghIRpFx4j6gmvA43enKzQoBOv9tGtmLfsKi04+3TBE24=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1091.namprd21.prod.outlook.com (52.132.24.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.820.2; Thu, 24 May 2018 16:25:59 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::7037:b3ec:4240:9d19]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::7037:b3ec:4240:9d19%5]) with mapi id 15.20.0820.001; Thu, 24 May 2018
 16:25:59 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "peff@peff.net" <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v3 15/20] commit-graph: test for corrupted octopus edge
Thread-Topic: [PATCH v3 15/20] commit-graph: test for corrupted octopus edge
Thread-Index: AQHT83vlEMJoJBh9IkS2RO/3dRxYbQ==
Date:   Thu, 24 May 2018 16:25:59 +0000
Message-ID: <20180524162504.158394-16-dstolee@microsoft.com>
References: <20180511211504.79877-1-dstolee@microsoft.com>
 <20180524162504.158394-1-dstolee@microsoft.com>
In-Reply-To: <20180524162504.158394-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR16CA0004.namprd16.prod.outlook.com
 (2603:10b6:404:f5::14) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1091;7:0EMPNzm+0sorkCSlzYwIFe6WoajEWbuHeX6wkk5H6knTuX5kOW9XWO3cBl1plqwcoM0BOdYSvyCN0Bwq9b7k0wI/CGUl4erJ4cpw9N/amTmeCKU6p7Ya0/ISIS+1/coRTPAdRhtCj4eigxpuI6d3rr+E/Jz/aL6cvnORpX5l01dU2CpabG7XbbqXp07Xl5A0uZr9Yu0zvgPwgLobf4AJL01taQYHgGInWTMihtZHxvO9MVIEqWzNboj/9mj4A0Bp;20:5g7LgdF9JhHq37hLTvTs5810FxZ610uruC6JZ6aGV1rL+Ie1yC39Ouhnt0DOJkK4cJNPWzCLYBrJLzMnEDJ6nQmPzhpvSdqXxsF3U0JfZZFP4bAnwhOSlQ82u20Clgpwmj+oHdg4tr0o1m/6n1jpYa34aC62+woKZuCyDY8+oM0=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1091;
x-ms-traffictypediagnostic: BL0PR2101MB1091:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB1091A1670666EF91C78363C1A16A0@BL0PR2101MB1091.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231254)(2018427008)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB1091;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1091;
x-forefront-prvs: 0682FC00E8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(1496009)(396003)(39380400002)(366004)(346002)(376002)(39860400002)(189003)(199004)(1076002)(53936002)(97736004)(6512007)(86612001)(81166006)(59450400001)(6116002)(25786009)(107886003)(10090500001)(4326008)(3660700001)(2616005)(52116002)(11346002)(186003)(2906002)(446003)(76176011)(305945005)(7736002)(8656006)(54906003)(3280700002)(46003)(86362001)(99286004)(102836004)(1730700003)(81156014)(8936002)(386003)(6506007)(476003)(22452003)(8676002)(486006)(316002)(39060400002)(5250100002)(14454004)(5640700003)(5660300001)(106356001)(2501003)(68736007)(478600001)(10290500003)(2351001)(2900100001)(36756003)(6436002)(6486002)(105586002)(6916009)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1091;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: BdgDiqmvtBh9MV3MRiMFsxWl16bXr5RkS6ur2rx13OsrPzokdvcHauH/2RqZcxutaxCoDtEeF5MypiCqHI2BksCgjCRwHT8kjnxT4xkLBVCIQkmr4a5wGOlMDTtYAbLNVri1U2FDBGsKUQTIxFtxth26wgl7Woe459Nf+8uvJXOk3ChDPKpKBwHeDQH3kQgO
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 2c126a5a-1154-4e92-2950-08d5c1930847
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c126a5a-1154-4e92-2950-08d5c1930847
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2018 16:25:59.3323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1091
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commit-graph file has an extra chunk to store the parent int-ids for
parents beyond the first parent for octopus merges. Our test repo has a
single octopus merge that we can manipulate to demonstrate the 'verify'
subcommand detects incorrect values in that chunk.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t5318-commit-graph.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 58adb8246d..240aef6add 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -248,6 +248,7 @@ test_expect_success 'git commit-graph verify' '
 '
=20
 NUM_COMMITS=3D9
+NUM_OCTOPUS_EDGES=3D2
 HASH_LEN=3D20
 GRAPH_BYTE_VERSION=3D4
 GRAPH_BYTE_HASH=3D5
@@ -274,6 +275,10 @@ GRAPH_BYTE_COMMIT_EXTRA_PARENT=3D`expr $GRAPH_COMMIT_D=
ATA_OFFSET + $HASH_LEN + 4`
 GRAPH_BYTE_COMMIT_WRONG_PARENT=3D`expr $GRAPH_COMMIT_DATA_OFFSET + $HASH_L=
EN + 3`
 GRAPH_BYTE_COMMIT_GENERATION=3D`expr $GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN=
 + 8`
 GRAPH_BYTE_COMMIT_DATE=3D`expr $GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN + 12`
+GRAPH_COMMIT_DATA_WIDTH=3D`expr $HASH_LEN + 16`
+GRAPH_OCTOPUS_DATA_OFFSET=3D`expr $GRAPH_COMMIT_DATA_OFFSET + \
+				$GRAPH_COMMIT_DATA_WIDTH \* $NUM_COMMITS`
+GRAPH_BYTE_OCTOPUS=3D`expr $GRAPH_OCTOPUS_DATA_OFFSET + 4`
=20
 # usage: corrupt_graph_and_verify <position> <data> <string>
 # Manipulates the commit-graph file at the position
@@ -378,4 +383,9 @@ test_expect_success 'detect incorrect commit date' '
 		"commit date"
 '
=20
+test_expect_success 'detect incorrect parent for octopus merge' '
+	corrupt_graph_and_verify $GRAPH_BYTE_OCTOPUS "\01" \
+		"invalid parent"
+'
+
 test_done
--=20
2.16.2.329.gfb62395de6

