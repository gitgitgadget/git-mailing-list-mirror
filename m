Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFEB61F404
	for <e@80x24.org>; Mon,  9 Apr 2018 16:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753328AbeDIQlv (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 12:41:51 -0400
Received: from mail-co1nam03on0134.outbound.protection.outlook.com ([104.47.40.134]:21376
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751774AbeDIQlu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 12:41:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=qksJMjgtZp96pEM54CYsP+Tf6vasJEJIY9w9XN+fRck=;
 b=lyhXu0eZuKzoc0aw0T01SEVCfpWVsZWzVSXaAxd0BZPWOS0e8AfFyDgEvhVjPBjwxiz8A8K9yF9VnuzNXjIrQHWGpV6NHRlZbzUSsqQ8FUtjm2nYoLDyDzrWb9fKlHJz3hyD+IKH6uCOCw3PV9WgpsKjq5Fz/Y2O/MNuJLFfWQA=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1074.namprd21.prod.outlook.com (52.132.24.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.696.0; Mon, 9 Apr 2018 16:41:48 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1%2]) with mapi id 15.20.0696.003; Mon, 9 Apr 2018
 16:41:48 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "peff@peff.net" <peff@peff.net>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "sbeller@google.com" <sbeller@google.com>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>,
        "bmwill@google.com" <bmwill@google.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 00/10] Compute and consume generation numbers
Thread-Topic: [PATCH v2 00/10] Compute and consume generation numbers
Thread-Index: AQHT0CGn/+i7H/tvaEu/RrmpDmZQsg==
Date:   Mon, 9 Apr 2018 16:41:48 +0000
Message-ID: <20180409164131.37312-1-dstolee@microsoft.com>
References: <20180403165143.80661-1-dstolee@microsoft.com>
In-Reply-To: <20180403165143.80661-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CY4PR13CA0029.namprd13.prod.outlook.com
 (2603:10b6:903:99::15) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1074;7:fQGmzDekOrxRcBmzm4DtaeJks9AaqHLSnubgxNu0aH+SSCFnReGt0tIqd+imcHbxE7lgJmSK03DVJPt0jeKp/az9B80jV8FHu3IjQnXiwnLpYoDBtEKkaFXHebswjMMqovhwn5OcLdILjN0rgFm7+5f6s8iMG49yeEVqaxviw4u1gyptVjNSQumpyumcnU/o8UV6dixKR+jKdxBimekJtrGSTpZqtbghsYFyMhB1i1rnq3R+GJ4GifSHGIu34MpK;20:luL9acJgCT8E4FnxAFWuYth4ebp6ldDKhilRI3ATAma7JcW6aRUuqPWcqVnlsLT8/XbGNLeByoHcegq8ByvARG5HV3dY6M/fs5347PPcPVb6RpBikU4Jh4I0B1dm8Shv+CxthCCg9KTtN6PxOWbjPv/DuyXPfv5yNs0i4XK9jqk=
X-MS-Office365-Filtering-Correlation-Id: 8bec24d5-55c8-4e74-b3ee-08d59e38c930
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:BL0PR2101MB1074;
x-ms-traffictypediagnostic: BL0PR2101MB1074:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB1074F6B53F13A6CDBE12E8B8A1BF0@BL0PR2101MB1074.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:BL0PR2101MB1074;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1074;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(346002)(39380400002)(39860400002)(189003)(199004)(51914003)(102836004)(186003)(2616005)(476003)(105586002)(6916009)(36756003)(3660700001)(7736002)(11346002)(3280700002)(5660300001)(46003)(6436002)(2351001)(478600001)(25786009)(5640700003)(1730700003)(6512007)(106356001)(8936002)(4326008)(8676002)(6486002)(99286004)(10090500001)(305945005)(81166006)(68736007)(81156014)(39060400002)(107886003)(10290500003)(76176011)(54906003)(386003)(6506007)(5250100002)(59450400001)(446003)(53936002)(2501003)(2900100001)(1076002)(316002)(52116002)(86362001)(86612001)(14454004)(2906002)(22452003)(6116002)(486006)(97736004)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1074;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: /SJ9szj7xTZMrh2cxm4mXhQuCUAx8nXdxaY3ke+jnEx6I8GQj2OkxMYaTTk8wExxCo+DW249WsGud1CzkayAHHVeL2Bfh55WKU9qsL3PEWYaqicGT5Ffsxc9cVBftGvuAluYyrc6Tj2Sg5JhUk8+ZoulPUbPsinvKXLw88IPTO6StSaVYVH2jMyZNq0wxdQZI/Wem7j1OQn90YHfbQiVqFxt0QdslV/RlT2jXW1M8TsCTKi+RY/4+7RnbjBzXeQBW4c2Smm3OXOMGKENI/q/oX1kuluKDpA9wIZv3AjEj7MkFYeFrk3aqJI+yZVScRnB2jvJWLnwnFUOHgKuB/Df3SRNqZo2+N5w7NOc17miqaKkLjsMR9hhDHPB9LFHPtjVMedQTxT0XMZEji2SH5Oah/MZhBr8kHScrY1qCyMYJaU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bec24d5-55c8-4e74-b3ee-08d59e38c930
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 16:41:48.0467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1074
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the lively discussion of this patch series in v1!

I've incorporated the feedback from the previous round, added patches
[7/6] and [8/6], expanded the discussion of generation numbers in the
design document, and added another speedup for 'git branch --contains'.

One major difference: I renamed the macros from _UNDEF to _INFINITY and
_NONE to _ZERO. This communicates their value more clearly, since the
previous names were unclear about which was larger than the "real"
generation numbers.

Patch 2 includes a change to builtin/merge.c and a new test in
t5318-commit-graph.sh that exposes a problem I found when testing the
previous patch series on my box. The "BUG: bad generation skip" message
from "commit.c: use generation to halt paint walk" would halt a fast-
forward merge since the HEAD commit was loaded before the core.commitGraph
config setting was loaded. It is crucial that all commits that exist
in the commit-graph file are loaded from that file or else we will
lose our expected inequalities of generation numbers.

Thanks,
-Stolee

-- >8 --

This is the one of several "small" patches that follow the serialized
Git commit graph patch (ds/commit-graph).

As described in Documentation/technical/commit-graph.txt, the generation
number of a commit is one more than the maximum generation number among
its parents (trivially, a commit with no parents has generation number
one). This section is expanded to describe the interaction with special
generation numbers GENERATION_NUMBER_INFINITY (commits not in the commit-gr=
aph
file) and *_ZERO (commits in a commit-graph file written before generation
numbers were implemented).

This series makes the computation of generation numbers part of the
commit-graph write process.

Finally, generation numbers are used to order commits in the priority
queue in paint_down_to_common(). This allows a constant-time check in
queue_has_nonstale() instead of the previous linear-time check.

Further, use generation numbers for '--contains' queries in 'git tag'
and 'git branch', providing a significant speedup (at least 95% for
some cases).

A more substantial refactoring of revision.c is required before making
'git log --graph' use generation numbers effectively.

This patch series depends on v7 of ds/commit-graph.

Derrick Stolee (10):
  object.c: parse commit in graph first
  merge: check config before loading commits
  commit: add generation number to struct commmit
  commit-graph: compute generation numbers
  commit: use generations in paint_down_to_common()
  commit.c: use generation to halt paint walk
  commit-graph.txt: update future work
  ref-filter: use generation number for --contains
  commit: use generation numbers for in_merge_bases()
  commit: add short-circuit to paint_down_to_common()

 Documentation/technical/commit-graph.txt | 50 +++++++++++++--
 alloc.c                                  |  1 +
 builtin/merge.c                          |  5 +-
 commit-graph.c                           | 48 +++++++++++++++
 commit.c                                 | 78 ++++++++++++++++++++----
 commit.h                                 |  5 ++
 object.c                                 |  4 +-
 ref-filter.c                             | 24 ++++++--
 t/t5318-commit-graph.sh                  |  9 +++
 9 files changed, 197 insertions(+), 27 deletions(-)

--=20
2.17.0

