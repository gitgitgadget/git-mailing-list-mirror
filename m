Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D41520248
	for <e@80x24.org>; Tue,  2 Apr 2019 11:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730580AbfDBLcn (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Apr 2019 07:32:43 -0400
Received: from mail-eopbgr150049.outbound.protection.outlook.com ([40.107.15.49]:20900
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729821AbfDBLcn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Apr 2019 07:32:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WhuKr99qn2sTH7vVRO1Znf5WKrqgpdqXLAXGi6Y7YcI=;
 b=a7g2avymT2PcDvlbd46YGIRckFDkIIl3Cg1wgYnpxVBPD7Bxmh9upbbv7QkY9P3CWvH3Zz0wweK6E/q1fggp3oaNLrwTi7U7CZhM38IyUu1wThpA/Vedlrb3PwuGT4A3FlDnS5y7Ryl6+FmLRqZg/bSevY8Owj62hnCCquHmPcY=
Received: from HE1PR0702MB3788.eurprd07.prod.outlook.com (52.133.7.18) by
 HE1PR0702MB3739.eurprd07.prod.outlook.com (52.133.6.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.8; Tue, 2 Apr 2019 11:32:00 +0000
Received: from HE1PR0702MB3788.eurprd07.prod.outlook.com
 ([fe80::5c2d:ab3e:7dee:f309]) by HE1PR0702MB3788.eurprd07.prod.outlook.com
 ([fe80::5c2d:ab3e:7dee:f309%3]) with mapi id 15.20.1771.011; Tue, 2 Apr 2019
 11:32:00 +0000
From:   =?iso-8859-1?Q?Bj=F6rn_Pettersson_A?= 
        <bjorn.a.pettersson@ericsson.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Bad performance when using git log --parents (used by gitk)
Thread-Topic: Bad performance when using git log --parents (used by gitk)
Thread-Index: AdTpNlxw1Ad95YlaQMWenIqIhrVZfw==
Date:   Tue, 2 Apr 2019 11:31:59 +0000
Message-ID: <HE1PR0702MB3788FCDAB764252D9CBB42E5B0560@HE1PR0702MB3788.eurprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=bjorn.a.pettersson@ericsson.com; 
x-originating-ip: [192.176.1.84]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 13d22acc-9ef5-407a-9c9d-08d6b75ed22f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:HE1PR0702MB3739;
x-ms-traffictypediagnostic: HE1PR0702MB3739:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <HE1PR0702MB3739E590F874666A0D8309AAB0560@HE1PR0702MB3739.eurprd07.prod.outlook.com>
x-forefront-prvs: 0995196AA2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(346002)(376002)(136003)(396003)(199004)(189003)(53936002)(486006)(26005)(476003)(186003)(5660300002)(316002)(52536014)(66066001)(97736004)(6306002)(2351001)(6506007)(2501003)(55016002)(5640700003)(305945005)(7696005)(6916009)(9686003)(102836004)(8936002)(966005)(33656002)(71190400001)(478600001)(3846002)(106356001)(105586002)(74316002)(81166006)(8676002)(1730700003)(86362001)(66574012)(7736002)(68736007)(71200400001)(81156014)(6436002)(256004)(99286004)(14454004)(25786009)(2906002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0702MB3739;H:HE1PR0702MB3788.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: ericsson.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iqNp3JT15cZexmoPCXCnjkbUZCWLrtdDFblkZ9ICwURGht3zWPoO5vcNLc4U9VuMhVXYcgHQDXwHTMJKLpmRkGmamcRUntdrPhdeZTiPKy0YpBTGLJ5qgx3ks4oWXtboD5OqfE8NWfm4e2Qna7pACSXDAUPCw/gOXLSVCFiLPT/xEU9nj6jgRDtyufkVbONvvI5F9SggjSS5XcUQbQrgG5WuD/o/j887Xja87hUPR7qOQ7rp+rGZIT+CLUsnvHtRaH6NCA1YYSerJ6pA/YTFZ2GUlslo0KlvOhk5blRjIu8P60Y+MZhK7qMsM8M6yG0Su8O9tOn4JUi1eI/zrnE4kHmA8bbCI8Q7OYBA5Fre4ZEYlvq7xlBmwrKvwRxK1Fe64G24dRalBPflYaxdGJ3SlLXHglg8patfVLz5pqDvpDY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13d22acc-9ef5-407a-9c9d-08d6b75ed22f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2019 11:31:59.9437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0702MB3739
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

The LLVM project is moving from SVN to git, creating a single repo on githu=
b for several LLVM sub-projects.
In the past we have had one git repo mirror for each sub-project (mirroring=
 the SVN projects).

Unfortunately, I've seen some performance problems with git (or rather gitk=
) when starting to use the new llvm-project git repo.

It seems like gitk is using "git log --no-color -z --pretty=3Draw --show-no=
tes --parents --boundary HEAD -- <file>" when loading the history. So it se=
ems to be the performance of "git log --parents . -- <file>" that is causin=
g the performance problem afaict.


Example:

Run "git log --parents" for an old file (bswap.ll), and a brand new file (d=
ummy).

First we try it using the new "llvm-project" repository.

---------------------------------------------------------------------------=
-----
bash-4.1$ git clone https://github.com/llvm/llvm-project.git && cd llvm-pro=
ject
Cloning into 'llvm-project'...
remote: Enumerating objects: 130, done.
remote: Counting objects: 100% (130/130), done.
remote: Compressing objects: 100% (98/98), done.
remote: Total 3361980 (delta 39), reused 58 (delta 26), pack-reused 3361850
Receiving objects: 100% (3361980/3361980), 605.50 MiB | 15.63 MiB/s, done.
Resolving deltas: 100% (2755544/2755544), done.
Checking out files: 100% (82618/82618), done.

bash-4.1$ /usr/bin/time git log --parents -- llvm/test/CodeGen/Generic/bswa=
p.ll >> /dev/null
190.63user 0.43system 3:11.01elapsed 100%CPU (0avgtext+0avgdata 702756maxre=
sident)k
232inputs+0outputs (2major+177913minor)pagefaults 0swaps

bash-4.1$ touch dummy
bash-4.1$ git add dummy
bash-4.1$ git commit -m "test"
[master ce43ac2e487] test
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 dummy
bash-4.1$ /usr/bin/time git log --parents -- dummy >> /dev/null
205.54user 0.37system 3:25.83elapsed 100%CPU (0avgtext+0avgdata 644576maxre=
sident)k
0inputs+0outputs (0major+163134minor)pagefaults 0swaps
---------------------------------------------------------------------------=
-----


Now do the same for the old "llvm" repository.

---------------------------------------------------------------------------=
-----
bash-4.1$ git clone https://github.com/llvm-mirror/llvm.git llvm && cd llvm
Cloning into 'llvm'...
remote: Enumerating objects: 84, done.
remote: Counting objects: 100% (84/84), done.
remote: Compressing objects: 100% (61/61), done.
remote: Total 1673859 (delta 25), reused 35 (delta 23), pack-reused 1673775
Receiving objects: 100% (1673859/1673859), 373.08 MiB | 12.72 MiB/s, done.
Resolving deltas: 100% (1369306/1369306), done.
Checking out files: 100% (36477/36477), done.
bash-4.1$ /usr/bin/time git log --parents -- test/CodeGen/Generic/bswap.ll =
>> /dev/null
4.89user 0.27system 0:05.19elapsed 99%CPU (0avgtext+0avgdata 468072maxresid=
ent)k
0inputs+0outputs (0major+120244minor)pagefaults 0swaps

bash-4.1$ touch dummy
bash-4.1$ git add dummy
bash-4.1$ git commit -m "test"
[master 1db81b43a30] test
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 dummy
bash-4.1$ /usr/bin/time git log --parents -- dummy >> /dev/null
4.05user 0.24system 0:04.32elapsed 99%CPU (0avgtext+0avgdata 437920maxresid=
ent)k
0inputs+0outputs (0major+112503minor)pagefaults 0swaps
---------------------------------------------------------------------------=
-----


So for bswap.ll it takes about 190/5 =3D 38 times longer time to run "git l=
og --parents",
and for the new dummy file it takes 205/4 =3D 51 times longer time, when us=
ing the new repo.

The size of the llvm-project repo is a little bit larger (since we have mer=
ged
several project, so the number of commits increases from ~180000 to ~310000=
, but I doubt
that such an increase should affect the time for git log --parents by a fac=
tor of 50.


From what I understand --parents can take some time, but I see huge degrada=
tion when using our new repo compared to the old.
Not sure if just the repo is too large (or poorly packed?), or if this is a=
 git problem.

Any help understanding this is welcome.

I used git version 2.20.0 in the tests above.


PS. I also think that the problem can be seen for files with longer history=
, for example CODE_OWNERS.txt (llvm/CODE_OWNERS.txt in llvm-project). But t=
hen the git log command starts printing commits much sooner. So with gitk I=
 actually get to see some history just after a few seconds also when using =
llvm-project (even though it takes some time to load the full history). For=
 the files with a very short history (like the dummy file example) the prin=
tout won't happen until at the end (after 200 seconds) so git log (and gitk=
) just appears to be stuck. Is git log caching the result somehow, not prin=
ting anything until it has more than one commit to print?

Regards,
Bj=F6rn Pettersson A   =20

Ericsson
Datalinjen 4 (Hus K)
58330, Link=F6ping
Sweden
