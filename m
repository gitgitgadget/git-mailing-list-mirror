Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C77981F954
	for <e@80x24.org>; Mon, 20 Aug 2018 16:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbeHTUIV (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 16:08:21 -0400
Received: from mail-eopbgr710102.outbound.protection.outlook.com ([40.107.71.102]:35723
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726144AbeHTUIV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 16:08:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fTnIV6v2hLhAN8LS5fe++azo2X9C059Qh0i5HWYZOd0=;
 b=Kob5LGi55auQE23BoW78FRblvNYVEXJfnF5yppwsdEgw49lGgZz/N8duqnWPvIkPktaDiNl6EtJsNMBwBr5DAPWfLzk5+I0+DB/B5kEGFvoUQBcZDza2xOQ4pIktHXU2WaLckYkzYixWmy/vRSOUtEliQqeV5imQUBF/4kuQMfQ=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0994.namprd21.prod.outlook.com (52.132.23.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1080.2; Mon, 20 Aug 2018 16:51:51 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c997:1e4b:40d8:1a49]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c997:1e4b:40d8:1a49%2]) with mapi id 15.20.1101.000; Mon, 20 Aug 2018
 16:51:51 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 0/9] multi-pack-index cleanups
Thread-Topic: [PATCH 0/9] multi-pack-index cleanups
Thread-Index: AQHUOKYX6wSs6A/qWUWxFT1UvIklZA==
Date:   Mon, 20 Aug 2018 16:51:51 +0000
Message-ID: <20180820165124.152146-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CY4PR19CA0044.namprd19.prod.outlook.com
 (2603:10b6:903:103::30) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:e008:1:8b51:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0994;6:Pdg4yASoRToCqYOxuGuchx6uGcIU0C9uFre7nCXDUH5aG3YNBBcDgNqnwkr7VxmF5l1CJJKHRZnrV/DTr60iGpoN6x9/BtpqDfQp3ejGEqhn0oMBubiCcuEdO9H8Ze2D7NYAl2hfbvl1TqQEp0LYwvtwJ4KfkGfNrZ33XO3RKfFmb18VGcimWP8ImKftMyiowlFy5tTsanCe8R9jJyCEm6Eep1TSg5mB4EiPlZaTf0SMdUKnKVZ2qrp+tqlYo8t0nxZC3D+eNztaFfxmqUedgWgP5Hgn/qgOWQneiCaTqdXvUuEcoySXijZWP8dWJBGHK96w6C88TIbRQb6LoKX2Ev3HHyqLpPyAdP7E8U3uiZkoa7/oZ+w3YY3FCgtXxH0RKCm4ZSyCNAn3uVf1V/0j9UWmamnGuJdFI2NTKB9FSy0DZezsRlBeeHxE5Nfk3ya7nD82FfeYbXoVQe2wleyNoA==;5:8clJcQaJOX7C1PAq+dA1hYbgc5br8Z8+CVpJnfuhfXPxMSuH1oHK80oZKuORkVEsN+l7enHk9FsbPhoQAPW8r2zbSI4+p+JJy1IK6NflWZn2JYcczqTr5zMvB7kjIP9PqOxETw+kTVx0BD/cHm6AxQ8lbR8ottIO9wTR1vqG3I0=;7:Kp9ZWy97+gLVfPMDhs9r3ZDoqAPWdPvBNKnPdY41nd/6eL4PSr9Hdf+S257VL2Lieo1/LG/vs8sc4e4k3VIKLcL1IFZciOpCwonnn88Jxqaec/1wvSoD02yil2ydp0v7Jp0cAkxc1eb2z7wQj7Kuz/MI/UQYLgVxcn4xuG5/93mvr/CIWF+Mcsq8Orye+R+py0w7z87j2bkZGhOSYqxVXLdsyLaaqt3TKIhENK9Fu3XZjpV7uNjwjKkPiK3NPs0U
x-ms-office365-filtering-correlation-id: 98d37526-0481-4639-189b-08d606bd39db
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:BL0PR2101MB0994;
x-ms-traffictypediagnostic: BL0PR2101MB0994:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB099471B83B2B3D1242CF2A16A1320@BL0PR2101MB0994.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(20558992708506)(166708455590820)(211171220733660);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(20180801012)(6040522)(2401047)(5005006)(8121501046)(3231336)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699016);SRVR:BL0PR2101MB0994;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0994;
x-forefront-prvs: 0770F75EA9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(136003)(376002)(346002)(366004)(189003)(199004)(99286004)(7736002)(10090500001)(6916009)(476003)(1076002)(1730700003)(8676002)(81166006)(81156014)(186003)(6116002)(46003)(2616005)(97736004)(486006)(305945005)(52116002)(5250100002)(316002)(2501003)(386003)(36756003)(6506007)(22452003)(102836004)(5660300001)(6486002)(14444005)(107886003)(6436002)(256004)(4326008)(5640700003)(14454004)(106356001)(8936002)(6306002)(53936002)(2906002)(966005)(68736007)(86612001)(2900100001)(25786009)(86362001)(105586002)(478600001)(2351001)(6512007)(10290500003);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0994;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: iyY2tqe6wWQk2wdFfvfsPsoeJpeYBIPy5MuWx7qeRvytEWhDVWaTnp4yw9sKdpRN4UAawjmeQCLGPI2nGHKu7HnLid+B4cGX3IkUXMMS/V4na8/NRFzG+tEs22FIChqHjBDHP4sOJFI3Z2byxrny7RqkkTqvuEqd1h4Z4oTrtuBapuA8KJcuQCFpuHvKUAC8NBsqper3d3dYqp9pMrZRT8T5BIbUh+B8FqGlKVxzA6W6dZo55fp6t3ccPjqD/z6KjvQ882XOdYXNrJju83BOwMQrCLsUC7xz7RfRvR7hPilJKOm/HpZ3G0Cy8cVtwFA9kwmWWddHZikzdpSIvXmVgA7JJQht2M4qiCP6lSmzICM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98d37526-0481-4639-189b-08d606bd39db
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2018 16:51:51.5804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0994
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is based on ds/multi-pack-index and
jk/for-each-object-iteration.

The multi-pack-index indexes objects across multiple pack-files. To
speed up object lookups and abbreviations, we do not place the pack-
files covered by the multi-pack-index into the packed_git linked list
or the packed_git_mru list. Existing test coverage focused on typical
uses and the main consumers of the multi-pack-index.

To better understand the implications of the multi-pack-index with
other scenarios, I ran the test suite after adding a step to 'git repack'
to write a multi-pack-index, and to default core.multiPackIndex to 'true'.
This commit is available as [1].

The following issues were discovered, and are fixed by this series:

1. The multi-pack-index did not distinguish between local and non-local
   pack-files.

2. A bad packed object was not inspected by object lookups in the multi-
   pack-index, so would loop infinitely trying to load the same object.

3. 'git count-objects --verbose' would not see the objects in the multi-
   pack-index and would report the multi-pack-index as garbage.

4. If the local object directory had a multi-pack-index but an alternate
   did not, then the multi-pack-index would be dropped.

5. If the multi-pack-index covered a pack-file that was paired with a
   reachability bitmap, then that bitmap would not be loaded.

Several issues were resolved simply by making a new 'all_packs' list in
the object store and replacing get_packed_git() calls with get_all_packs()
calls. The all_packs list is a linked list that starts with the pack-files
in multi-pack-indexes and then continues along the packed_git linked list.

Also: I simplified the usage reports in 'git multi-pack-index' to help
users who are entering parameters incorrectly.

[1] https://github.com/derrickstolee/git/commit/098dd1d515b592fb165a276241d=
7d68d1cde0036
    DO-NOT-MERGE: compute multi-pack-index on repack.
    I will send this commit as a separate patch so we can see the change
    I made and the one test I needed to fix (because it moves a pack-file,
    thereby making the multi-pack-index invalid).

[2] https://github.com/derrickstolee/git/pull/9
    A GitHub pull request containing this series.

Derrick Stolee (9):
  multi-pack-index: provide more helpful usage info
  multi-pack-index: store local property
  midx: mark bad packed objects
  midx: stop reporting garbage
  midx: fix bug that skips midx with alternates
  packfile: add all_packs list
  treewide: use get_all_packs
  midx: test a few commands that use get_all_packs
  pack-objects: consider packs in multi-pack-index

 builtin/count-objects.c     |  2 +-
 builtin/fsck.c              |  4 ++--
 builtin/gc.c                |  4 ++--
 builtin/multi-pack-index.c  | 16 +++++++-------
 builtin/pack-objects.c      | 42 +++++++++++++++++++++++++++++------
 builtin/pack-redundant.c    |  4 ++--
 fast-import.c               |  4 ++--
 http-backend.c              |  4 ++--
 midx.c                      | 32 ++++++++++++++++++---------
 midx.h                      |  7 ++++--
 object-store.h              |  6 +++++
 pack-bitmap.c               |  2 +-
 pack-objects.c              |  2 +-
 packfile.c                  | 40 ++++++++++++++++++++++++++++-----
 packfile.h                  |  1 +
 server-info.c               |  4 ++--
 t/helper/test-read-midx.c   |  2 +-
 t/t5319-multi-pack-index.sh | 44 ++++++++++++++++++++++++++++++++++---
 18 files changed, 168 insertions(+), 52 deletions(-)

--=20
2.18.0.118.gd4f65b8d14

