Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8406B1F406
	for <e@80x24.org>; Thu, 10 May 2018 17:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966648AbeEJReG (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 13:34:06 -0400
Received: from mail-dm3nam03on0119.outbound.protection.outlook.com ([104.47.41.119]:64153
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966615AbeEJReF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 13:34:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=avIUHhB4p9cBP0hCcUiJYPdOIEJvc6lndipLr5UIS4I=;
 b=Sv5eMInam5GTU3H2JZHxTfoEFUgs4hu0R8KmHj1hQ3sH3ITdjaDgNDEOrsBwDCGvEZfmz39Ku/vC/47EGoNzOaBFRRxLvZ8DrrbRbBci0X8gi0hXM5ANLnsoWQqPLyUSYkfkgInmamj99ToBwhGRuP+oi1wwQJqqsbVGwtipxmo=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0962.namprd21.prod.outlook.com (52.132.20.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.776.1; Thu, 10 May 2018 17:34:02 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::714b:5398:58e0:b4d8]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::714b:5398:58e0:b4d8%3]) with mapi id 15.20.0776.004; Thu, 10 May 2018
 17:34:02 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "peff@peff.net" <peff@peff.net>,
        "sbeller@google.com" <sbeller@google.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 00/12] Integrate commit-graph into fsck, gc, and fetch
Thread-Topic: [PATCH 00/12] Integrate commit-graph into fsck, gc, and fetch
Thread-Index: AQHT6IUVHdyXUGpsNUi8+yA5HZuGdw==
Date:   Thu, 10 May 2018 17:34:02 +0000
Message-ID: <20180510173345.40577-1-dstolee@microsoft.com>
References: <20180417181028.198397-1-dstolee@microsoft.com>
In-Reply-To: <20180417181028.198397-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR14CA0004.namprd14.prod.outlook.com
 (2603:10b6:404:79::14) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0962;7:Iosu83tOcGgYYHdFN4Tkdvlknd8BKYyz4t5ITS0fUeN4lYP55V8CADizsMvnV2rg+e+7dnJOhkkWWLcvHOO10qu4K9FzJNR25erf3ehBOjHyDPpJXTZkvKEtn93NKwdTBYUhF2WoNnJE5aqbRdaCjRusSqTF7xMnmG3K0giyRt8giLS6RPU3wUtlOgEPN8UCxV9GJk6aO+HIzyjx69MDlZS2kdFAJ8f15F8w7x4SBuFmi77mdLyLd4JkrlvTm/A9;20:r3nYZvi2pS05FEQwzR2GhILjQJHXdLbcQpbIrWzYQYHtiUxYYtzzCd3UrFc9TK7loZZIb2oVt+9OFS8REq+z4OhEkatkQVKkKaunAaLwxtnJPeDLOgS5iCa8FDy3MWlQ8y9KNh5s29gPYgSiodG5lmBlPHxMbhkWvvbrkS7daS8=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB0962;
x-ms-traffictypediagnostic: BL0PR2101MB0962:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB0962B28B37138348119B8EAFA1980@BL0PR2101MB0962.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB0962;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0962;
x-forefront-prvs: 066898046A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(376002)(39860400002)(396003)(366004)(199004)(189003)(6916009)(5250100002)(107886003)(4326008)(105586002)(8676002)(36756003)(476003)(2501003)(2616005)(8936002)(14454004)(2906002)(2900100001)(86362001)(10290500003)(6512007)(575784001)(478600001)(53936002)(10090500001)(86612001)(486006)(25786009)(6486002)(5640700003)(46003)(76176011)(1730700003)(386003)(305945005)(5660300001)(316002)(54906003)(39060400002)(81166006)(81156014)(3660700001)(186003)(6506007)(52116002)(7736002)(3280700002)(102836004)(2351001)(97736004)(1076002)(99286004)(6116002)(11346002)(22452003)(106356001)(446003)(68736007)(59450400001)(6436002)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0962;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Y2KCa9NZsyxABdE4A7K8x+mro06kVMtRqLHzUjlwQejGjcJyfkfgLo9fWuKw3PXGKOinA7Xax8TC2nyyQA64BUl0UJ9drvvWOMCdmGTmTxVqQo8LKQxxtzoXJ4Ie9W5i6gQY1ExrsM7/MDJ2iQkIlJnEF3U76aFfoCFhQ6Q974FILuEoMOkdxbQ+i0gUMTQJ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 0ee944dd-738d-4d2c-67d6-08d5b69c37e9
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ee944dd-738d-4d2c-67d6-08d5b69c37e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2018 17:34:02.1296
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0962
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commit-graph feature is not useful to end users until the
commit-graph file is maintained automatically by Git during normal
upkeep operations. One natural place to trigger this write is during
'git gc'.

Before automatically generating a commit-graph, we need to be able to
verify the contents of a commit-graph file. Integrate commit-graph
checks into 'fsck' that check the commit-graph contents against commits
in the object database.

Thanks, Jakub, for the feedback on the RFC. I think there are still some
things to decide at a high-level before we dig too far into the review.
Specifically, the integration points in 'fsck', 'gc', and 'fetch' are
worth considering our alternatives.

For 'fsck', the current integration is minimal: if core.commitGraph is
true, then 'git fsck' calls 'git commit-graph verify --object-dir=3DX'
for the objects directory and every alternate. There are a few options
to consider here:

1. Keep this behavior: we should always check the commit-graph if it
   exists.

2. Add a --[no-]commit-graph argument to 'fsck' that toggles the
   commit-graph verification.

3. Remove all direct integration between 'fsck' and 'commit-graph' and
   instead rely on users checking 'git commit-graph verify' manually
   when they suspect a problem with the commit-graph file. While this
   option is worth considering, it is my least favorite since it requires
   more from users.

For 'gc' and 'fetch', these seemed like natural places to update the
commit-graph file. Relative to the other maintenance that occurs during
these commands, the 'git commit-graph write' command is fast, especially
for incremental updates; only the "new" commits are walked when computing
generation numbers and other metadata for the commit-graph file.

The behavior in this patch series does the following:

1. Near the end of 'git gc', run 'git commit-graph write'. The location
   of this code assumes that a 'git gc --auto' has not terminated early
   due to not meeting the auto threshold.

2. At the end of 'git fetch', run 'git commit-graph write'. This means
   that every reachable commit will be in the commit-graph after a
   a successful fetch, which seems a reasonable frequency. Then, the
   only times we would be missing a reachable commit is after creating
   one locally. There is a problem with the current patch, though: every
   'git fetch' call runs 'git commit-graph write', even if there were no
   ref updates or objects downloaded. Is there a simple way to detect if
   the fetch was non-trivial?

One obvious problem with this approach: if we compute this during 'gc'
AND 'fetch', there will be times where a 'fetch' calls 'gc' and triggers
two commit-graph writes. If I were to abandon one of these patches, it
would be the 'fetch' integration. A 'git gc' really wants to delete all
references to unreachable commits, and without updating the commit-graph
we may still have commit data in the commit-graph file that is not in
the object database. In fact, deleting commits from the object database
but not from the commit-graph will cause 'git commit-graph verify' to
fail!

I welcome discussion on these ideas, as we are venturing out of the
"pure data structure" world and into the "user experience" world. I am
less confident in my skills in this world, but the feature is worthless
if it does not improve the user experience.

Thanks,
-Stolee

Derrick Stolee (12):

Commits 01-07 focus on the 'git commit-graph verify' subcommand. These
are ready for full, rigorous review.

  commit-graph: add 'verify' subcommand
  commit-graph: verify file header information
  commit-graph: parse commit from chosen graph
  commit-graph: verify fanout and lookup table
  commit: force commit to parse from object database
  commit-graph: load a root tree from specific graph
  commit-graph: verify commit contents against odb

Commit 08 integrates 'git commit-graph verify' into fsck. The work here
is the minimum integration possible. (See above discussion of options.)

  fsck: verify commit-graph

Commit 09 introduces a new '--reachable' option only to make the calls
from 'gc' and 'fetch' simpler. Commits 10-11 integrate writing the
commit-graph into 'gc' and 'fetch', respectively. (See above disucssion.)

  commit-graph: add '--reachable' option
  gc: automatically write commit-graph files
  fetch: compute commit-graph by default

Commit 12 simply deletes sections from the "Future Work" section
of the commit-graph design document.

  commit-graph: update design document

 Documentation/config.txt                 |  10 ++
 Documentation/git-commit-graph.txt       |  14 ++-
 Documentation/git-fsck.txt               |   3 +
 Documentation/git-gc.txt                 |   4 +
 Documentation/technical/commit-graph.txt |  22 ----
 builtin/commit-graph.c                   |  79 +++++++++++++-
 builtin/fetch.c                          |  13 +++
 builtin/fsck.c                           |  21 ++++
 builtin/gc.c                             |   8 ++
 commit-graph.c                           | 175 +++++++++++++++++++++++++++=
+++-
 commit-graph.h                           |   2 +
 commit.c                                 |  13 ++-
 commit.h                                 |   1 +
 t/t5318-commit-graph.sh                  |  25 +++++
 14 files changed, 353 insertions(+), 37 deletions(-)


base-commit: 34fdd433396ee0e3ef4de02eb2189f8226eafe4e
--=20
2.16.2.329.gfb62395de6

