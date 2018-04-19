Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B34951F404
	for <e@80x24.org>; Thu, 19 Apr 2018 21:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753588AbeDSVqm (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 17:46:42 -0400
Received: from prvmx04.microfocus.com ([130.57.1.219]:18302 "EHLO
        prvmx04.microfocus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753470AbeDSVql (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 17:46:41 -0400
Received: from prvxcaht04.microfocus.com (Not Verified[137.65.248.138]) by prvmx04.microfocus.com with Trustwave SEG (v7,5,8,10121) (using TLS: TLSv1.2, AES256-SHA256)
        id <B5ad90e400000>; Thu, 19 Apr 2018 15:46:40 -0600
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (137.65.224.21)
 by mail.microfocus.com (137.65.248.138) with Microsoft SMTP Server (TLS) id
 14.3.339.0; Thu, 19 Apr 2018 15:46:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=MicroFocusInternational.onmicrosoft.com; s=selector1-microfocus-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=EDQmwMtmOYOxKv/ffPpN72MwbSXc/oShUHg3lho2S7Q=;
 b=G9LRqxDDPT2V3mMBLSr3SS+gxP5E7cadP1tQtw7MAfiLu9AB+S+c3DYahzmauWYCWpq8Wm4nW+r5SE7SDfkffQDieRZdxQs9Dd2zLHDx/ydxmvzb69E23tSf2iPU8DeS4ZsoKBa3spyU3f3AV+N04hy46fVEKE/d/Djdmfaw+d4=
Received: from MW2PR18MB2284.namprd18.prod.outlook.com (52.132.183.149) by
 MW2PR18MB2284.namprd18.prod.outlook.com (52.132.183.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.675.14; Thu, 19 Apr 2018 21:46:38 +0000
Received: from MW2PR18MB2284.namprd18.prod.outlook.com
 ([fe80::1953:6149:ff4d:80b3]) by MW2PR18MB2284.namprd18.prod.outlook.com
 ([fe80::1953:6149:ff4d:80b3%13]) with mapi id 15.20.0675.015; Thu, 19 Apr
 2018 21:46:38 +0000
From:   Isaac Chou <Isaac.Chou@microfocus.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [BUG] Git fast-export with import marks file omits merge commits
Thread-Topic: [BUG] Git fast-export with import marks file omits merge commits
Thread-Index: AdPYJIvNooDcI9D2T/S5TrqX2cAY8A==
Date:   Thu, 19 Apr 2018 21:46:38 +0000
Message-ID: <MW2PR18MB2284E3091991A3DB228CEBBEE5B50@MW2PR18MB2284.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microfocus.com;
x-originating-ip: [74.122.108.54]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR18MB2284;7:nAtTpJY2CLJVVCdooRTn9Quv8DiBm641x6drl2RnMlLduTTcmuzhEL6uYq5qw6O9sc9qDO8DMbNUIiGy27nhzW6PTGf9I+YhxWsNonzkC0m6h45DfhqkJjMD9PlNsXgJl4d6e7eZkfP281pFmQl1jCK/hXk1JlVNxP7jkRczby2Okhq6tyRQargZRpIApcakDpGIt892sbKWw6HZYAAhxZ0SLmiAknzCFSZZRxGQR1F5JS5pPE+MX1sVJxdCudsZ
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MW2PR18MB2284;
x-ms-traffictypediagnostic: MW2PR18MB2284:
x-microsoft-antispam-prvs: <MW2PR18MB2284E0BD9D712BEF0F9DFCB7E5B50@MW2PR18MB2284.namprd18.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231232)(944501386)(52105095)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR18MB2284;BCL:0;PCL:0;RULEID:;SRVR:MW2PR18MB2284;
x-forefront-prvs: 0647963F84
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(346002)(376002)(396003)(39380400002)(13464003)(476003)(86362001)(3846002)(8936002)(305945005)(81166006)(5660300001)(74316002)(6436002)(1730700003)(3660700001)(2906002)(2351001)(2501003)(7696005)(5250100002)(59450400001)(8676002)(72206003)(66066001)(6506007)(6246003)(25786009)(6916009)(26005)(478600001)(186003)(2900100001)(102836004)(53546011)(229853002)(33656002)(9686003)(53936002)(316002)(3280700002)(7736002)(55016002)(6116002)(5640700003)(575784001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR18MB2284;H:MW2PR18MB2284.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;MLV:sfv;
x-microsoft-antispam-message-info: ATJPhn2z3Ex5g1YTygmUr0fj1DDO3Rc9PZFRk6xNvLmgmZBBag48sa8UgKm4xy+w1HcqeT+hlLRjRSSMmJklVBkxZFN6JfO/8jd0asFVIaTGknnN8WcHAbfCHxIUfaeC7kM2OeNk8f7Wd78MATPHUd8eNxN4zRKpemfhQQKaCgj0RCOYBkcE/oXVb24WcCDX
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 7fa5f647-df74-4a27-b5c7-08d5a63f07db
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fa5f647-df74-4a27-b5c7-08d5a63f07db
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2018 21:46:38.5595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR18MB2284
X-OriginatorOrg: microfocus.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I inspected the source code (builtin/fast-export.c) for the fast-export iss=
ue I encountered, and it looks like the merge commit is discarded too early=
 by the call to object_array_pop() after only one of the two UNSHOWN parent=
s is processed in the method handle_tail().  The poped merge commit still h=
as one UNSHOWN parent, therefore it is not processed and is lost in the out=
put.  Can someone advise me on how to submit a code change or bug report in=
 order to get the fix into the code base?

Thanks,

Isaac

-----Original Message-----
From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On Behal=
f Of Isaac Chou
Sent: Monday, April 16, 2018 3:58 PM
To: git@vger.kernel.org
Subject: Git fast-export with import marks file omits merge commits

Hello,

I came across a change of behavior with Git version 2.15 and later where th=
e fast-export command would omit the merge commits.=A0 The same use case wo=
rks correctly with Git version 2.14 and older.=A0 Here is the detail of the=
 use case:

0> git --version
git version 2.16.2.windows.1

1> git init
Initialized empty Git repository in c:/./.git/

2> echo 1111 >> file.txt

3> git add file.txt

4> git commit -m "first commit"
[master (root-commit) 711d4d5] first commit
1 file changed, 1 insertion(+)
create mode 100644 file.txt

5> git checkout -b test
Switched to a new branch 'test'

6> echo 2222 >> file.txt

7> git add file.txt

8> git commit -m "commit on test branch"
[test 76d231c] commit on test branch
1 file changed, 1 insertion(+)

9> git checkout master
Switched to branch 'master'

10> echo 3333 >> file.txt

11> git add file.txt

12> git commit -m "commit on master branch"
[master 61c55fd] commit on master branch
1 file changed, 1 insertion(+)

13> git merge test
Auto-merging file.txt
CONFLICT (content): Merge conflict in file.txt Automatic merge failed; fix =
conflicts and then commit the result.

14> notepad file.txt

15> git add file.txt

16> git commit -m "merged with test branch"
[master 1442e0e] merged with test branch

17> git log
commit 1442e0ee728c831e74550329e39d27d4188b4422 (HEAD -> master)
Merge: 61c55fd 76d231c
Author: isaac <...>
Date:=A0=A0 Mon Apr 16 15:08:39 2018 -0400

=A0=A0=A0 merged with test branch

commit 61c55fdb883fc403e63c91b49bc11bdade62b3e8
Author: isaac <...>
Date:=A0=A0 Mon Apr 16 15:07:41 2018 -0400

=A0=A0=A0 commit on master branch

commit 76d231cdb12eb84f45abdebede06a56f912613d3 (test)
Author: isaac <...>
Date:=A0=A0 Mon Apr 16 15:07:07 2018 -0400

=A0=A0=A0 commit on test branch

commit 711d4d5781df41924421f8629af040e7c91a8d2e
Author: isaac <...>
Date:=A0=A0 Mon Apr 16 15:06:07 2018 -0400

=A0=A0=A0 first commit

18> echo :1 711d4d5781df41924421f8629af040e7c91a8d2e > git-marks

19> cat git-marks
:1 711d4d5781df41924421f8629af040e7c91a8d2e

20> git fast-export --use-done-feature --import-marks=3Dgit-marks refs/head=
s/master --
feature done
blob
mark :2
data 12
1111
2222

commit refs/heads/master
mark :3
author isaac <...> 1523905627 -0400
committer isaac <...> 1523905627 -0400
data 22
commit on test branch
from :1
M 100644 :2 file.txt

blob
mark :4
data 12
1111
3333

commit refs/heads/master
mark :5
author isaac <...> 1523905661 -0400
committer isaac <...> 1523905661 -0400
data 24
commit on master branch
from :1
M 100644 :4 file.txt

done

Thanks,

Isaac

