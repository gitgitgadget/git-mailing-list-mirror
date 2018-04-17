Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED,UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0997D1F404
	for <e@80x24.org>; Tue, 17 Apr 2018 16:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754277AbeDQQXF (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 12:23:05 -0400
Received: from mail-co1nam03on0127.outbound.protection.outlook.com ([104.47.40.127]:4800
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755345AbeDQQWr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 12:22:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kastle.onmicrosoft.com; s=selector1-checkvideo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=VpSHbUuwfisKr/HRnx7m6N7rPC3ukgYKbBs0isU4YQw=;
 b=y+YAE2OSZnABZ6s7xqfWWue7n0E/QZ86JAGfuxP5jIShioMfkej44A1J5r6IZi+hCw/tfy1CqnGPy2Xj79Zwb2RQpSqD2QZ+8OWVxj2szSyL9tkgNf7EtLN3w+QrjL3hSEW4q7kZmcDiARg05byi3x4UEFjeaEKoachLL0yjIxU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=amazo@checkvideo.com; 
Received: from amazo-desktop.cernium.local (70.163.25.109) by
 BYAPR08MB3845.namprd08.prod.outlook.com (2603:10b6:a02:82::27) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.675.14; Tue, 17
 Apr 2018 16:22:45 +0000
From:   Andrey Mazo <amazo@checkvideo.com>
To:     git@vger.kernel.org
Cc:     Andrey Mazo <amazo@checkvideo.com>, luke@diamand.org,
        gvanburgh@bloomberg.net, larsxschneider@gmail.com,
        miguel.torroja@gmail.com, thanvk@gmail.com
Subject: [PATCH 1/1] git-p4: fix `sync --verbose` traceback due to 'fileSize'
Date:   Tue, 17 Apr 2018 12:22:13 -0400
Message-Id: <2e2b2add4e4fffa4228b8ab9f6cd47fa9bf25207.1523981210.git.amazo@checkvideo.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <cover.1523981210.git.amazo@checkvideo.com>
References: <CAJJpmi-pLb4Qcka5aLKXA8B1VOZFFF+OAQ0fgUq9YviobRpYGg@mail.gmail.com> <cover.1523981210.git.amazo@checkvideo.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [70.163.25.109]
X-ClientProxiedBy: BN4PR12CA0001.namprd12.prod.outlook.com
 (2603:10b6:403:2::11) To BYAPR08MB3845.namprd08.prod.outlook.com
 (2603:10b6:a02:82::27)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB3845;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB3845;3:zwwSsUIqHY/mll32rfKg5O8FmBJoFN5R4FjUXr0JdQ+QZqMgmuwZBt6letwWA3PkwZzfccCyoNtNwO1lU22fWmARPFeUuugl1sI1zR97leLzDnpQTpkxZT24Y0hkFpuwnv2ceyL+RUClRCWJNfdJhezAKx0VDy2ZWOg1lJTDAo8MHk+TN9Rh9A+GiKkT+eoDGp1sy75pLYiArRUuRWNSjXEseWT0X6WMDUvnrt9vKWbsJpqzpipxIRlpki+Kw4aJ;25:ajsAXdLWKhIXzk5EyCQo0CduL9/Fozgch/4cX7QNsDznNXLwGa+fyzzA97c4hDsYXZe03XxpD+yjoZ/y/5VcNNaB7yv4S5XCGxJV2VrJF+4rHdSkdD07QXCjb8w7j/MFyPjCSfq+6L5mtECwbbDoxOE6SXcobG26qEZpvYMAX2VtbXPWAAnrv5J7f8sBM6CybCr5Xn1+ZSEyS5LOMrvEWzeRKKYRwJOERwaJVieAX0KrCIGkLdyUFWOMgI90anNS4Mg0E2M3an3KfWClSfevHdvebHWhPGTHFQyucC7BGRPO//dugz7mGjc82ioKYoF7VkLdh6fHs43tcatK8cavMQ==;31:zOq+NZPGYcyav9kF9ScrsHdENIzjJLtfdwKeWpxpftnxO2GHbfzSJvr7x85bqqAJdu3A/ZBTee+Au7o9p7BixJ87ohKta5A5JQC8ZgdmObb15Ip6XZ7TUA7nihz8J0ZOdLQaNjC2+3cYxu2EUHRwVxaHhLCr/aTbQ4FZlowV7ayH3VNLetQE/bjcp/VieDAdIBsSlSjod10VuqGAeZPYd+1jjl8tF37e1zGtnXRpSDI=
X-MS-TrafficTypeDiagnostic: BYAPR08MB3845:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB3845;20:Mp74+Qtok1WCa78qgO8EMZLzjbgNT7wEHpjQhxlawuRgY2GcfKeJLAK96Aqor0oOL8U7Qpynn8F3QpqgmZLvQOPdinXX4lR2kEK+3kZFlmFF0sAE5ZBxCmz7PxzMKkZfD2SiOF2gOfhnarWjPCCO4ynKN76x3DBUo4fQulPIdT5piNBuXXbwSBSzc0tkcqTapJLq8dQIrbh4y5mprHjzpMwxREtAAc4VKjc4142Ee+iUtXmZPrP9p2djUgY0vi451//Imi3JhLgb9shNYGoDGIkI4O4/qL+M6TXdnV0AniTTcDg1iYuqVGrb95uEiw7ANYvsK9k2q+qK5jkPi/VREE+oYRImKvM+beblSJbYP/WiWCQWVBkM9dgFLZ2nsr+DBwDd4Mvo6fRITP9JF7HEWx7vp/1+n/VOQIf1kY5SRIHiC6cHbV9NrSct6SnlBqlCYMD8ZlngrSHI1NqKbkR4+VJ3SCXxPY4qc24Fp4VJpdTKdw5QNsWNjPn8GyDEYQuv;4:DOYwu4O2a+a+smc+ISxtcZYCT77Zj8PUF3s7SL/Lpi5JHJ/UbMGB2Rx8i8H6/7OsYI+yfnzn1eabHhdHvzCCczAN3IS3HAT8aRvyJdU1HRZvpcGEDoU1u9J2cNYzFDJ9unUgfV7b5V/8WUlYsKaqR98BjUYu13hq2bHA97xp3XcJ+8YLQEHW6M+WkqJexkT0gemROvVYS4IWm8UUqL8XY/qjg/SzDUee12hv9L+auAH/GXDLACBUzu7ac/4sWrh8PxnTE7/JTn43q9c2WphdufcgNKdrgtzgeHbf2xoSsEK4iMdAXWV6KQ4b1FEGBq9i
X-Microsoft-Antispam-PRVS: <BYAPR08MB3845463A47B39EC9413ED786DAB70@BYAPR08MB3845.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(158342451672863);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231232)(944501327)(52105095)(3002001)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BYAPR08MB3845;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB3845;
X-Forefront-PRVS: 0645BEB7AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(366004)(376002)(346002)(396003)(199004)(189003)(3846002)(50466002)(2361001)(48376002)(316002)(446003)(476003)(956004)(486006)(2351001)(11346002)(105586002)(2616005)(47776003)(81156014)(5660300001)(16586007)(7736002)(6116002)(8936002)(97736004)(66066001)(50226002)(25786009)(81166006)(51416003)(26005)(305945005)(478600001)(76176011)(386003)(6506007)(106356001)(2906002)(36756003)(6916009)(52116002)(4326008)(39060400002)(68736007)(16526019)(186003)(53936002)(118296001)(6512007)(8676002)(6666003)(86362001)(6486002)(81973001)(19627235001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB3845;H:amazo-desktop.cernium.local;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: checkvideo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR08MB3845;23:eitEcGRX0wZvhJ0GEmXNXVdUvLY2nHRJNmtYBO4ce?=
 =?us-ascii?Q?WWxWe+t8UZdDuY5ANxSDPHy/DD1VlqbQ+cQjjX8kIQYJhENiSEUIEZwbqgjB?=
 =?us-ascii?Q?q0iDK/ECbRmIJBnBYGSWzIIVo0pFNYXRAPSZbrNvi/odLCHcU5g7w5mGf8zs?=
 =?us-ascii?Q?dtuKU3K582pBxijZGoUDov0ZB9+FHqmCgAW1W5Q/dmadX2rcCV86KmlZ+EvP?=
 =?us-ascii?Q?DiNUghEf2w2ScQtTgM3Vgqjd52aApdG/qIyH85sMk1hovMOVRgDKUcOYGZLq?=
 =?us-ascii?Q?5hH+aiZEBGS4lBtWHqoAfuNCujIJO3djPnGvM+XVsHM+cwOriy1eUxbg7KGA?=
 =?us-ascii?Q?FCr2QGwdvVsala412gwXSNHfmZQPTyvlTFKIpQNgH0C6YNHo+pBfSiKlM5/h?=
 =?us-ascii?Q?6OIEYjd7vIkWNXSbtb1XyuRA7HNWTgmhVQ9Ndwe+3/3qm/KVieFLOAgEJ/KY?=
 =?us-ascii?Q?e+Sg6UUojMgntwE9DI30VNAwkp0U6O6TT5GBR9m0jOLug3iWKS7mqAANcX5z?=
 =?us-ascii?Q?z9lfAw7sQFineMENF40Ypsc88QwuvyqNRCsJJHP+AGBQo2lkjsXQCLzwURMY?=
 =?us-ascii?Q?mtBza6/S1r01OFLOo/6zUxzkFIniZj3vC24lFQO68ZmroMaANfqlQ//hIfKj?=
 =?us-ascii?Q?7YNnhjvo20yoHvK2nIhf3zBqDmoGEzi/I9vA5yZubNbCi0Ntiy6cNpdGxzWU?=
 =?us-ascii?Q?FjwLj16OExQhhc+GlYv0k3uszOxVgfQyDXqn/6wMsw/U4C52jf3Yg4ny3zWe?=
 =?us-ascii?Q?KjgOcCJ/w+MvQz7pk6uQN2dV9rWAt2zhPC0QOY7zi1iEkSUk9fQxXQVpAoqW?=
 =?us-ascii?Q?4zPVtlhJHnI/KPJpa1x0NkWoqAB8Zluqt9Sb7T79OqpCO5JBbCbJMtRkxsCP?=
 =?us-ascii?Q?ZSj9kuYvh/jfb3EwAw2oeUJm1yOVzY/zSVeDsWSaM4/iBAnUrpq9xOc6NKGE?=
 =?us-ascii?Q?nm8nqOUKb4bRNkM343eSFJZFGl17bpATcKJ2rQIRYrb71AdFWt9dmEILCjJu?=
 =?us-ascii?Q?2oNKE0fjOtKBBPd68pDSgyl4KtrT68QtRW3rRf8hOqyMOfRsAh7ENwcy7S1Y?=
 =?us-ascii?Q?u8+xJsumfhprw+2L9fw/YPHKhQ1CIqbZ8/PQnpoMBQa5rFSMHhGtQg1pCJbx?=
 =?us-ascii?Q?zmdlvgmsAWhzG8UDh1zPrcS9I+IGbVHZpZCBhxgFl1cwoTviLUbx2fd/YyOY?=
 =?us-ascii?Q?iZKlOuvcg472b7xg732KJodAfcu9M+gqDhztucRasN+Gn/vrtM+t6KdVnZ2V?=
 =?us-ascii?Q?h5PaFgAaOzVihNQOiy6WvemZCTfW/v/dVuh+IpAr6kDc+ZHN/jpZOvDcNSO7?=
 =?us-ascii?Q?DtQ8bOVZbJqDFgH0zNr/Nw=3D?=
X-Microsoft-Antispam-Message-Info: 5+MQuDDfwkrZ7nGpWy7pwxO3ZGpqEypKWsXDcCrwltcfTX8YlANVVhZGJZuMeu2rfBc4V4WP8ZfxettnT2rnnGzUGTeLZqcLLAoBeC1nWf908xLoIvnNWX67DMilxxs1CQ8UdaGOxqlMPQ0eWdZTG5m7YiQfI78/K4sVVv0J0hCgDwJPbC1z32CCQb3gk11B
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB3845;6:v3MBT3jj15HYZ4Xr6Lk8QGUV/kfjuwncam63thj9JZhXUyXADUp3QNtmUHBA6AfRuWE/dgTNiTO4KY4steZQTxLYj87W5fzUvkZEfOby7y/QJtElgy7zxiP2fWv2Rb3sGB7oEiNkU5niWoO7Iqxkp8LoOMhElFyZfU0DIGYPy4XpDJn5NGdQxbzjC4QASEmrUUPD8DhmgWNz7krGRVdp6yvArpeXPZXI1+cdAnfb9+U+UPaOR7zx+tO6qszxa8G3D1sJ2HI/yd2JRMKUEI/bSEC3uuzPZFGMEVzF3vB59vDk28czMGfbgKV7P4H+xecvZHNOto4xJbpR1fZYBYq0USFJKLHQ5qyepxTc+hC/7xiB+SxBJEF4pqHNydb9Nan3ZGvhnpdNHoQ1qJEan1NBhcvUofvWw5YHtbXB5VPJCrBlNH4GuW4Rsv0gVuZ4T9wbPmrYdPyyNy6ZtfUBP4qUMw==;5:EfHc8eobfcB0+B1LneB4WW0LXleRtBPm0axg9ZRqKv0W/1+X0Y5wf4oTN+Ct9hLZj+qB+xy9i//orh0Tcy3suKxMqPDWJlBJBVJA6DWJP0rVD/aks3GtbKwvopIzuagAlxqz6pD6HzKSnwgxBjtkmBTmeG70P+viwqdxktjuEuY=;24:vOPZF1snUozEC9DphcbZgXTp/jKTpob7wM/0UDrPyC85ovrWAsYOB2mUkLFEt3I4raq3/1LWQ+/r8qqEAUop4WMTZIEZT8YL4I4/DftYE1A=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB3845;7:T2RQU9w612XbrR2OuFdn7hiZ/p+/hU2hxarjARyYI5ixZCUZcOX7PtN84HiJhwlEGN4WQXiw6KWdY67X/IM/gBqR4/2bb+jywBirH1vWgNJDGXdTKmojevUPmAKNCDU8lGx0wziURATwmBq4cQiylDd1ywfAKlNfBkh0DBtwKZC1cRi7w0HlLghWDdIuvCSY16QO4NkOE8WJ9LwRv/1Slgsm1TJVqRsHuGDx1ypyJ3vuh9c/ym3RbTPDhTA/28hn
X-MS-Office365-Filtering-Correlation-Id: 79e840b2-d2de-4967-d30a-08d5a47f7453
X-OriginatorOrg: checkvideo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2018 16:22:45.5370 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79e840b2-d2de-4967-d30a-08d5a47f7453
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7280061d-06ed-4a4e-a2b1-cc9ab5638c09
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB3845
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Perforce server 2007.2 (and maybe others) doesn't return "fileSize"
attribute in its reply to `p4 -G print` command.
This causes the following traceback when running `git p4 sync --verbose`:
"""
    Traceback (most recent call last):
      File "/usr/libexec/git-core/git-p4", line 3839, in <module>
	main()
      File "/usr/libexec/git-core/git-p4", line 3833, in main
	if not cmd.run(args):
      File "/usr/libexec/git-core/git-p4", line 3567, in run
	self.importChanges(changes)
      File "/usr/libexec/git-core/git-p4", line 3233, in importChanges
	self.commit(description, filesForCommit, branch, parent)
      File "/usr/libexec/git-core/git-p4", line 2855, in commit
	self.streamP4Files(files)
      File "/usr/libexec/git-core/git-p4", line 2747, in streamP4Files
	cb=streamP4FilesCbSelf)
      File "/usr/libexec/git-core/git-p4", line 552, in p4CmdList
	cb(entry)
      File "/usr/libexec/git-core/git-p4", line 2741, in streamP4FilesCbSelf
	self.streamP4FilesCb(entry)
      File "/usr/libexec/git-core/git-p4", line 2689, in streamP4FilesCb
	self.streamOneP4File(self.stream_file, self.stream_contents)
      File "/usr/libexec/git-core/git-p4", line 2566, in streamOneP4File
	size = int(self.stream_file['fileSize'])
    KeyError: 'fileSize'
"""

Fix this by omitting the file size information from the verbose print out.
Also, don't use "self.stream_file" directly,
but rather use passed in "file" argument.
(which point to the same "self.stream_file" for all existing callers)

Signed-off-by: Andrey Mazo <amazo@checkvideo.com>
---
 git-p4.py | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 7bb9cadc6..6f05f915a 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2566,8 +2566,12 @@ class P4Sync(Command, P4UserMap):
         relPath = self.stripRepoPath(file['depotFile'], self.branchPrefixes)
         relPath = self.encodeWithUTF8(relPath)
         if verbose:
-            size = int(self.stream_file['fileSize'])
-            sys.stdout.write('\r%s --> %s (%i MB)\n' % (file['depotFile'], relPath, size/1024/1024))
+            size = file.get('fileSize', None)
+            if size is None:
+                sizeStr = ''
+            else:
+                sizeStr = ' (%i MB)' % (int(size)/1024/1024)
+            sys.stdout.write('\r%s --> %s%s\n' % (file['depotFile'], relPath, sizeStr))
             sys.stdout.flush()
 
         (type_base, type_mods) = split_p4_type(file["type"])
-- 
2.16.1

