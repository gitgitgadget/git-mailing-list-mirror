Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E49DC433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 00:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36D0260F45
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 00:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345247AbhIHAzB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 20:55:01 -0400
Received: from mga14.intel.com ([192.55.52.115]:4648 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343915AbhIHAy7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 20:54:59 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10100"; a="220036842"
X-IronPort-AV: E=Sophos;i="5.85,276,1624345200"; 
   d="scan'208";a="220036842"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2021 17:53:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,276,1624345200"; 
   d="scan'208";a="605524250"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga001.fm.intel.com with ESMTP; 07 Sep 2021 17:53:51 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 7 Sep 2021 17:53:50 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Tue, 7 Sep 2021 17:53:50 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Tue, 7 Sep 2021 17:53:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FMj167TbcN8jWqp/aDWmbCpBspmvHKQNNtaN4qOM5MYgkN49B6aftmccsLH4Iwn8y3wmoOtkK/fRu3LgSCxoo5GnMJaLheewPHRxAr9mSeQuqPl9TEBhcXht6J76IH8fKDA99+V85EiL14UPay3V8RILu7Ode89EPwAcupGLCT+iYi6bQvQg6mJ17/SoJLgueUVmIch3qfhEiUkjmOyxABJFPmazHgro4JmHsnsLmW3GiTNhC/qbgDjV6c2c9/4vSsUnKJTTkWLwvuF3/+GDZwThE1s9Ygbjf8gHuS7O0V36SypBZR9cMiOFFresIHk2SQdFIT8auCA3xukFH6SJGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=gbT2H0jLn2wb/jrK3KZl1amnVON1rqhLrwuOzfAiCUA=;
 b=HCmmqWwRlhSalMbcVqkNI60d/TTrDE/6tdCgkl8BknzKCP/2Z0ktBsq7UV1TYGlzOKhEQdVLaM6dPdTvy0QsvAgVgAP69CcrTb1DM5NcsQizELdneDijH/IPn1kmvfm2ordEaZYCZzW9NP8Ilca5t+77WoAe3kTYpPrQS1sxbEtRK2cqnjc4zOc8eQ7Hyov9Enr3sLTGMCyeVMjRN1Tbrs5SIz88ooWwE3RvERmoXm5u9UGVlUxRMT+bMy4MzU8myqrAZ3XDlvVQ6F6Quqly8BKTPXbi2KA+A+ryt533Nf9nxUA2tcuHjrZv8eVWxFYiFBagYgzuRYZBQSWin5Uz9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbT2H0jLn2wb/jrK3KZl1amnVON1rqhLrwuOzfAiCUA=;
 b=KjW0vScQaGdaJt73hyAgH+0ROtaRJMJBnsUlOVSogUUCzvdmtkafDjUuhRYmOGBzp3IBB099TKV1c38xWQbvBaWna89T7T40vBjVw32ld/SmnHhws6HkIZXacE14MaoP84ANk/wWpMJ4zhNW8RC2QtCZrhOWxza3f+/0mqeA/lo=
Received: from SJ0PR11MB4942.namprd11.prod.outlook.com (2603:10b6:a03:2ac::19)
 by BY5PR11MB4307.namprd11.prod.outlook.com (2603:10b6:a03:1bd::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17; Wed, 8 Sep
 2021 00:53:42 +0000
Received: from SJ0PR11MB4942.namprd11.prod.outlook.com
 ([fe80::508a:1ef0:4715:8a8e]) by SJ0PR11MB4942.namprd11.prod.outlook.com
 ([fe80::508a:1ef0:4715:8a8e%7]) with mapi id 15.20.4500.014; Wed, 8 Sep 2021
 00:53:42 +0000
From:   "Mirochnik, Oleg V" <oleg.v.mirochnik@intel.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Git apply can convert LF file into CRLF when .gitattributes file is a
 part of a patch
Thread-Topic: Git apply can convert LF file into CRLF when .gitattributes file
 is a part of a patch
Thread-Index: AdekSjABRblmB+G2Qxe3yucEo6VX7A==
Date:   Wed, 8 Sep 2021 00:53:42 +0000
Message-ID: <SJ0PR11MB49429B90AA71A06BD4A3BD15C6D49@SJ0PR11MB4942.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7530a570-db5a-4beb-31e9-08d972631aea
x-ms-traffictypediagnostic: BY5PR11MB4307:
x-microsoft-antispam-prvs: <BY5PR11MB4307FB97C427556854341451C6D49@BY5PR11MB4307.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:655;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GOfTi7uC0MfopqhCCUsCyzMWMDZTqvDhiliHcf54b/3VaBDoeR1knpEScBDjvXEgcDds+zFnq5eXCZRIAC/oIs5BSJIWx6NW3pFMQlSjVUduteypP9ERm8vsKDxknd2dUW1ubB7gQhE8qIdAoXm92oI0kGKciGIUqRV9lS+1hVMwBCvNletsX6oAlRIvcIpIkJnVfz6ZsmDXAgxUiJGituh+YxQUqBGX2ZHqlLnHulQIWYNoC+V2fvqULMW6fBe61cTpy8rOrO81B6Ny3dGYlPdDeuwZzobeHWLlEpYCLO5C1pTQPP6bZstpavQ2hh/o8p+BPH1DztzbOmkCXHetsNeM7w/TJS1jX8Evt/LEza8KfgKuqZG3w8jSFVKleStUtENjLzyt1OKjHBLYmKKFhwoXwWwxAZu8oNtgR4UGbRvt/HhYOS2c/5zBjk9OYpAoXuwnv3FVnS7hS2b1J/ACL1WfRVpWXYvi/81h2DrA+ff1mIO3xGoVutQq9vpdaF8Pk2nx+kIEiByqcmpmT2zAltmR6H+AV8oS4H2Ey0THW7yMB0G5u45dxv1uKzty3oyk0yae+NBzXcbVjFXhaxd09xm3ehLojbgRbHq+BT2Wqdl5WLbOEyGG0QkORkfACfZkzTJf4sYwGucURRksul412Hq1EWdWFMTd3oYU2lsT/542O7WNpsTit5AMwtSMRzGbjNZ2YLAGuWj3Wj7+mSxwsdox01eEaIc40UoUx3WK3yLHmMhyfNfO08lYxS87ZE369P23m6IS6zoOTrPsvxZnC0+HPs8O+rRXKKeWYGDkc4yqoGN87/WPQlK+9PIgk+Sp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4942.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(7696005)(5660300002)(8676002)(52536014)(122000001)(83380400001)(186003)(9686003)(38100700002)(8936002)(33656002)(55016002)(86362001)(316002)(66946007)(6916009)(26005)(64756008)(66556008)(66446008)(6506007)(66476007)(71200400001)(76116006)(478600001)(2906002)(38070700005)(966005)(142923001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZuCWAATB17tMBmjW/Zvza1bpwQ2kFDZlCEUfPMc37Zv4eEY9s7aNmVSB8uaG?=
 =?us-ascii?Q?OzZvCcm1dD0A8mNFtemk6Ij29fW9arf+7O5hHzg4WUpdaxzp2SC4FxIVt7fA?=
 =?us-ascii?Q?Rv7Fr4+T9gCR0y4Ot+LhSjc8XzaldNZmCqFGs9cDk1D1+a0iDa96p2VUZGUz?=
 =?us-ascii?Q?z4M+Mye1FJFMzfi6PHGFyLpPIA5HibjRPPt7VLUk5hG1sZa6jsq1vnqeuznL?=
 =?us-ascii?Q?LvQ6nNcl+3qbOd803dWxwYYLybwtE/yUQdvSHgSTETbdYTYhD/is+J6UF66S?=
 =?us-ascii?Q?cAztC0UpWPXxo6reZV+89e6nQhtLh8dv/8rCjY0BREFlNAk21jftqGYXNH/n?=
 =?us-ascii?Q?XrBMtGChpILY6bQfWSOf2IclIQQAaLVeoR7kxdZ5e9fsj28+h8FaZAd1/LRL?=
 =?us-ascii?Q?3WmWbd86C3pj7vxQQUqj4OAXJZePiklih8ZUGIZs9jhf4UCQBb75EmYVh5R1?=
 =?us-ascii?Q?anwa6GxlXdzuC5WNv3h0/O1PI1HKQ62MomANBa/1FTffsrxZ7TWO1U+a+eVc?=
 =?us-ascii?Q?43vrXZBiRfoJYC5sgPggS3KUfN1devAHp6rezUJ3wcQR4CT+T7xI6u/4qC2z?=
 =?us-ascii?Q?qTGgALriA4cAMxOOiSjo5i24hnnJZnjiphuvH711xiUrEEKhlbui4wC63YF7?=
 =?us-ascii?Q?KUNU1Pv3cBR231cOCsSPup7SdMvDQn9k7cmv+pET1NGLSMAHRINff0cb2a1q?=
 =?us-ascii?Q?oHs+zFif8ZJKNE5hOml6YbSXyIEKd38GEYuj/lWp4MJjT3YCtu2SSBwNFIig?=
 =?us-ascii?Q?81wLKT5g6n4oaR7t7Y2RhHMl/g3vUtNvJX3nDRMDw0A18aUqstJl/I5WaXoF?=
 =?us-ascii?Q?MHhQN86aIaDNfp0h8OmSR6QeGan0W7Pkb5hWpuhfDc59fWjAS4FgJGx7DWel?=
 =?us-ascii?Q?Gs/r7hTtnL5SAJZ5E66uMUNZQFwXXvdFDBzvuLUEeJAIvEoeMW8PmXtZVk4Q?=
 =?us-ascii?Q?80j/77vNEiPSh+YCERENTdsTiqEJ08NHcLgv0f7Ewh27TQ+lf+ZIM4fFX5gK?=
 =?us-ascii?Q?eMz7T1p1zXSNDqN4i17Xr+1fj2EMLM1PrHnX6zbnbR5eN1Wt/KItyLx89KzD?=
 =?us-ascii?Q?XzLcVN8tbOFkMylzOIfTBY7aUDDPQ6P7AkgfvDCI2BayiZe/ZXZnEdtLifkP?=
 =?us-ascii?Q?aSB8W6EYwca5sUntjpt8Ec6LkAMgvrkECgff/ox7ppocBHgmPKv9ESSOSEPf?=
 =?us-ascii?Q?tvqzIHYa4jwewANwcBBmysmghfgNoApgBYTxC8rU8S4wO3wuZTRjdz4YYVRs?=
 =?us-ascii?Q?KHiy+8BWc//bnJJBjfrP2Cc9ozkogyo1XI2inPT1sKwqd8toT9dQxaurV+ND?=
 =?us-ascii?Q?AvXtLcnHgrPur+K+djQ2d8C/?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4942.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7530a570-db5a-4beb-31e9-08d972631aea
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2021 00:53:42.7076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a6HpFPfjOKmtnMef+rxzpW0Id0NPukbBmXDEPo76Gv8np3Wp1zaGX9JLXY2nSHCwSEzp45GQQccjT6Xy7UPAfNlqn1g4dOQuzxg976evdfU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4307
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Originally the issue was reported in https://github.com/git-for-windows/git=
/issues/3409
But I was asked to report it in the mail list as the issue is not a Windows=
 related.

As you can see below "git apply --binary" converts files into CRLF mode if =
.gitattributes file modification is included into a patch file.
IMO behavior should be consistent - "git apply --binary" should not convert=
 files into CRLF mode because of unrelated change in .gitattributes file.

Steps:
$ cat doit
git --version --build-options
git config --global core.autocrlf true

rm -rf tst
mkdir tst
cd tst
mkdir repo.git
cd repo.git
git init --bare
cd ..
git clone repo.git 1
cd 1
mkdir cr lf
echo '* -text' > lf/.gitattributes
for d in *; do for b in {1..5}; do echo foo >> $d/foo; done; done
git add *
git commit -m init
git push
cd ../

git clone repo.git/ 2
cd 2
for a in `find * -type f`; do echo `od -c $a | grep -q '\\r' && echo CR || =
echo LF` $a; done
for a in `find * -type f`; do echo '# dummy' >> $a; done
git commit -a -m dummy
echo ""
echo +++ After commit and before diff
for a in `find * -type f`; do echo `od -c $a | grep -q '\\r' && echo CR || =
echo LF` $a; done
git diff --binary HEAD~ -- cr lf     > ../patch.with
git diff --binary HEAD~ -- cr lf/foo > ../patch.without
git diff --binary HEAD~ --    lf     > ../patch.lf-only
cd ..

echo ""
echo +++ Patches
for a in patch*; do echo `od -c $a | grep -q '\\r' && echo CR || echo LF` $=
a; done

git clone repo.git 3
cd 3

echo ""
echo +++ patch w/o .gitattributes
git reset --hard
echo +++ After reset and before patch
for a in `find * -type f`; do echo `od -c $a | grep -q '\\r' && echo CR || =
echo LF` $a; done
git apply --binary ../patch.without
echo +++ After patch
for a in `find * -type f`; do echo `od -c $a | grep -q '\\r' && echo CR || =
echo LF` $a; done

echo ""
echo +++ patch with .gitattributes
git reset --hard
echo +++ After reset and before patch
for a in `find * -type f`; do echo `od -c $a | grep -q '\\r' && echo CR || =
echo LF` $a; done
git apply --binary ../patch.with
echo +++ After patch
for a in `find * -type f`; do echo `od -c $a | grep -q '\\r' && echo CR || =
echo LF` $a; done


echo ""
echo +++ patch no CR
git reset --hard
echo +++ After reset and before patch
for a in `find * -type f`; do echo `od -c $a | grep -q '\\r' && echo CR || =
echo LF` $a; done
git apply --binary ../patch.lf-only
echo +++ After patch
for a in `find * -type f`; do echo `od -c $a | grep -q '\\r' && echo CR || =
echo LF` $a; done

git config --global core.autocrlf false

$ sh doit
git version 2.29.2
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
Initialized empty Git repository in /tmp/issue3409/tst/repo.git/
Cloning into '1'...
warning: You appear to have cloned an empty repository.
done.
warning: LF will be replaced by CRLF in cr/foo.
The file will have its original line endings in your working directory
[master (root-commit) fc793f1] init
 3 files changed, 11 insertions(+)
 create mode 100644 cr/foo
 create mode 100644 lf/.gitattributes
 create mode 100644 lf/foo
Enumerating objects: 6, done.
Counting objects: 100% (6/6), done.
Delta compression using up to 24 threads
Compressing objects: 100% (3/3), done.
Writing objects: 100% (6/6), 378 bytes | 378.00 KiB/s, done.
Total 6 (delta 0), reused 0 (delta 0), pack-reused 0
To /tmp/issue3409/tst/repo.git
 * [new branch]      master -> master
Cloning into '2'...
done.
CR cr/foo
LF lf/foo
LF lf/.gitattributes
warning: LF will be replaced by CRLF in cr/foo.
The file will have its original line endings in your working directory
[master 718534d] dummy
 3 files changed, 3 insertions(+)

+++ After commit and before diff
CR cr/foo
LF lf/foo
LF lf/.gitattributes

+++ Patches
CR patch.lf-only
CR patch.with
CR patch.without
Cloning into '3'...
done.

+++ patch w/o .gitattributes
HEAD is now at fc793f1 init
+++ After reset and before patch
CR cr/foo
LF lf/foo
LF lf/.gitattributes
+++ After patch
CR cr/foo
LF lf/foo
LF lf/.gitattributes

+++ patch with .gitattributes
HEAD is now at fc793f1 init
+++ After reset and before patch
CR cr/foo
LF lf/foo
LF lf/.gitattributes
+++ After patch
CR cr/foo
CR lf/foo
CR lf/.gitattributes

+++ patch no CR
HEAD is now at fc793f1 init
+++ After reset and before patch
CR cr/foo
LF lf/foo
LF lf/.gitattributes
+++ After patch
CR cr/foo
LF lf/foo
LF lf/.gitattributes
