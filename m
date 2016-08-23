Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53C9E1FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 21:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755824AbcHWVKP (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 17:10:15 -0400
Received: from mail-db5eur01on0044.outbound.protection.outlook.com ([104.47.2.44]:52304
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754967AbcHWVJ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 17:09:59 -0400
X-Greylist: delayed 3355 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Aug 2016 17:09:58 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sociomanticlabsgmbh.onmicrosoft.com; s=selector1-sociomantic-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=WN1toeYZmeZqTkqpcETyLgOy7BqrYHnDvirGagkQSDA=;
 b=pVr7WqDOgf1yToDZdr95WnoXYGQPK2J2x5luoO7VfU0RJu+jPjZbaS12nmRQe20YT0JIQNd9RPz66jHCJKXB/1ZlGjjaV6f9C1Bka9w14WDwyj4/35IxsESxNRFkNEpDX0v8Q8h6ah0n9GNVscv6T7XG19+PsfUtfI/S7JTdNC0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leandro.lucarella@sociomantic.com; 
Received: from labs-064.localdomain (87.149.174.153) by
 HE1PR0101MB2137.eurprd01.prod.exchangelabs.com (10.168.29.6) with Microsoft
 SMTP Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P384)
 id 15.1.587.9; Tue, 23 Aug 2016 18:34:48 +0000
Received: from localhost.localdomain ([127.0.0.1] helo=labs-064.localdomain)
        by labs-064.localdomain with esmtp (Exim 4.82)
        (envelope-from <leandro.lucarella@sociomantic.com>)
        id 1bcGX8-0005Bv-46
        for git@vger.kernel.org; Tue, 23 Aug 2016 20:34:46 +0200
Date:   Tue, 23 Aug 2016 20:34:46 +0200
From:   Leandro Lucarella <leandro.lucarella@sociomantic.com>
To:     <git@vger.kernel.org>
Subject: Getting "The following submodule paths contain changes that can not
 be found on any remote" when they are in the remote
Message-ID: <20160823203446.40abfd37@labs-064.localdomain>
Organization: Sociomantic Labs GmbH
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [87.149.174.153]
X-ClientProxiedBy: AM3PR04CA0105.eurprd04.prod.outlook.com (10.163.180.159) To
 HE1PR0101MB2137.eurprd01.prod.exchangelabs.com (10.168.29.6)
X-MS-Office365-Filtering-Correlation-Id: 773acc30-328e-4c59-2b3b-08d3cb8429f6
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0101MB2137;2:OiNNkCkqkiNAKhz9kiN3+gvgQ2oge/sxxVP8bM/FdhmCpxmNonwgbmFh4wVRR18ekaJkeYkvbPBySTDwoesAyG1rYvoz58fFxI1a34yihj55nFJOed9mpfQBlDbb9JiHcaxFlyBeUevKglTJivDgmsox2a+nWurA6LHDsizmCGAut+O6zZM99chWyuM77llz;3:X0nzcwJ0NDstaZD4z3y/e47dkcRWvIlN0UzfnWZ2YSLdVtVuys2z1uBdcLx8e/KkAmjGxyRKzsOio96qPjU/l5/bkZ0pNqsyUPALGoReiR6E+dfW0KVtBJ/YJyasQiHy
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0101MB2137;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0101MB2137;25:PhuUAlBg4afs6pF7l9kUt3nF936CsGWMqUSv0jqpR9BmV04f43NODRCaCOMM6p7zBe94ZACBlnce2iBTjN+d1SvFNV+ee+wtgGKp7jubMINK1SZdHceJDLWIZNochVSCa3RbomQjEyXGhPG5NowMTjYzrqgtERahElVGgPluQt2o6P4XlehosZUmlvbnt4lyadm0Un95ExLalWJM7YoMkdnC0nwZYCyxnicR3V3Fyh5/476Gs/r2nR1QEcXFSFmVnw+pICnzkaQtJLYVDysN+dy+Gz2OES1ZMeNVTtzHgh9CbBVhzpJh6vnFDL7T1rGQAHFnyL66ZWLVfiXfDC+vdRRK1489DN8GFLtLvk6MDaF+W8/qejYvy6Of94c9eJm101m6H3arBNN/JzyQqVGK8qUWv8S1x9InwaiqASTG0YxYAlbVlJvsMPnM07/zsA3/fH6mhr/a/tPRPY6gqKt0FM+PrcJ5E4FfB8NpAr7rn0kqd7xprwOxaNAE1NdzH+i2cOCopL5TxZQAC3mbAh0egufbaqBYBfRYh6I/itbY9iWY9h3eezLnuaC8bqsA9TlzKvMsfMq6eabnEywKFuXEqh5srd+fX6dH1FMSGbWtFGZEPVnZgfIrF+0o/3ltxVRmjXI9HIAp/+s6nGw8KQQrrzbIblAY4D19igSa7XOSmAXT2jpcqBlQdbgs7nzc6nXvfqla3deqNNEXGdSXHF3s+DH2WA6p+JIQiHBM+SBC1sKgQOXZpj6SWIiVVi+6psu0SSs6jfleoE/S8IIEy0wFkeQojFBaf8YSHJCVCPutQhNheYjVje2BMMukNaK3guibEBrytKodD+TcJ0QZBMp55g==
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0101MB2137;31:cwkYZriPU2IZqELak2aiUos9ufaj+bkMEE+a5DeXDnZhUdDWz0iVoX48vVNkoh4PBViHpcAd1L0mU5qW03kWxFh0ZugJ9A7GDC4KHYYS2eg5CCRrg6HMOg7dlYVvWld4CeqDXHTdIhh9EZmSPkFV2wOgJD8jOTSvqPkdg21BvVA4s0NgrIkXBiDZTkDoxfV8+3QUbTk4L7djDpbo9skKBCKPw7Q0o7u7UrTfk7XgKok=;20:T3XT6W9qioQRWbe6+b8kNHMzy4tdlRcqETeQfiVpsbtub/Q3xjh6b8eacxl9Iv/FAq56wsiJ9BG0mZFPZKgmjh8XZEJrvn5q/6CvcnObjViV/ns48D0VJri1g17teGeN0wPNd8gwC86HLxN8dRMB89pbcL6Wl+RoLqcsP5GwbJt3B3YpMZtcyz52vLJ8Sab/MDqJuhwirWFJb+U6b4OZK9zGrzxhNtZc/jwYLjjW+ALq+PW7C9KjQoUTY63844Cw
X-Microsoft-Antispam-PRVS: <HE1PR0101MB2137C63FD910917C09C32DA6ECEB0@HE1PR0101MB2137.eurprd01.prod.exchangelabs.com>
X-Exchange-Antispam-Report-Test: UriScan:(7783539604369)(5213294742642);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040176)(601004)(2401047)(5005006)(8121501046)(3002001)(10201501046)(6043046)(6042046);SRVR:HE1PR0101MB2137;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0101MB2137;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0101MB2137;4:UpgzZf7rlTVUlOmorAhYb9waJK/e/EGsYmZ8fIFGkYj9JNlzdT/t9t2piOeKiax4uPn5/wTWRAG3BEfr3AAr/2DNIZXs65sGcbr2q2WiD3o+chHRG8uihOC1/5QuOfvd3H9WOMuVQrtYATOk2PwHVdBRMw+Pjp4NWyVxNgkwYbyg5KP+JDA2xrENol1x8fmv9WY2IAfJBys3ia3JadR1jBcxcUZH84Z2/On3sBVX5OnxOA8gw/6kMi+N/KdTd/WVdVZmtOCU7CjcRsAfsuBt+hDMVGbptNHDKWMAUa8brA95ePJGHyFDgI4D9ic3qtPdwn5EXKu2pD5ekippKDhB2hyNU7QJuqYkIcPIDRxMSoQEpAQkJj+aR/DIDUDPB1uqasuwjNIEbd1z9tfXYNx17djNNVVtjx4eOhcWLZpymh1ZTN+PjOTVOe7rP3yI62gq98eymrzy9SBxp10fBEVljatBn1rIEtlewjJFb4Lnh8a8u+A7XEBBKGo9O9TrC/7T
X-Forefront-PRVS: 004395A01C
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(7916002)(199003)(189002)(50986999)(46406003)(86362001)(122856001)(15975445007)(97736004)(9686002)(5660300001)(9786002)(77096005)(50226002)(23726003)(107886002)(66066001)(7736002)(2351001)(7126002)(110136002)(7846002)(6116002)(81166006)(229853001)(47776003)(19580395003)(106356001)(305945005)(7696003)(49486002)(450100001)(3846002)(68736007)(81156014)(1076002)(189998001)(586003)(92566002)(50466002)(33646002)(2906002)(8676002)(230700001)(101416001)(105586002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0101MB2137;H:labs-064.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: sociomantic.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0101MB2137;23:Xa6aJAKROUwHDrGqpyN7xFolhQgVM7EHNqpuQGJ?=
 =?us-ascii?Q?UQ7XDCaG0vhLnD6tjwZZkmlCtxEmv5sPcPBGbzd05xodYHY0znLpzw8ix+t1?=
 =?us-ascii?Q?gz3dXuPVu12KDj/DI9bj2dzu0yEN/+3P3DFOezcqgMBYl0JgOymW5xEYLYyq?=
 =?us-ascii?Q?3cTM+dV115PDScBKMIB0x5TEvyc2tp5PZ7UXCphFUJ6+hTHP+Mgwf0kiIQkc?=
 =?us-ascii?Q?r+v3DcqY/XEW8pRd1DGxGUQt6cAnIIGQNVuQmvGA2xZJbFB+b+Hujl3o0HBV?=
 =?us-ascii?Q?T9A22jxNzPgrkNq6/fz31MMR9JOCWS7TFuiB1GgVKIsbuuKniZRiVqNgp7zV?=
 =?us-ascii?Q?AZvnN3Xw5VPvcMROk8/fI3IoJsJaISMxVr2ZH6ZQyh8NuHKK+/xaldOQZpR0?=
 =?us-ascii?Q?/IqzLZJybxlYn+EQzzZiImeEsDtsYUfvCKujC724Po3kLjlZfT5nrQPm+n/M?=
 =?us-ascii?Q?QzIHe+qY9m9QVFrqe+gwefwZuRdTQiae4Ks+YQ/M5CTj0ilge7w5hec/LE2K?=
 =?us-ascii?Q?xDshjVfc7FBFHExsadNyrmMnfNOWQtjMhwPDu/QFnvAo7ak0t7jnJmXwUPst?=
 =?us-ascii?Q?5QDxvIaUWJvk/BacC07bph1Uj/yvLBVJQ2/U5xgBBjEr9t/Z2L508ULcVscs?=
 =?us-ascii?Q?z0LtTq1d9aDgSrbni0aVrnMx31duIL5vt1qaCG/+Iz67dPeT1hmGkoenrSKl?=
 =?us-ascii?Q?rZp9pjpawsBrAL4V+QPLS8j1j+fdnswvu67lILUEjRQF+vbakkW4lGf65oDX?=
 =?us-ascii?Q?V2bShORuKzegsi7Tj5vbarSDKrRDQ9sCHNy1XCtkpNz9+YSpCYT5sImki7/h?=
 =?us-ascii?Q?LviKZaDu0lsP7DOxG5P4TBWICDyikQyxbjmHEgKg0MSo6FDe53RNFhhRfJyn?=
 =?us-ascii?Q?ejeCe+8IGoc7QLqWgcs1miGG0xsI2rBEeIF6cXqgJmbzPpYyvdOFAj9tholz?=
 =?us-ascii?Q?hO7f4sPjyWvvw7qeAl8CgyBJenbPuH8LTJOBv+/Z6hqRyAIQncS8hpo0hMrI?=
 =?us-ascii?Q?lWB0AcvFJ22eSje3BIM3oA/GBfv8BDPzLhJhP+sK4lddjv9pWcwC14G3PYym?=
 =?us-ascii?Q?F01CdLjhpdsmZbwdmHE13Dp0QKjbnOCAVJYX2K8DMoUV0E41ZZygLWUXwKUZ?=
 =?us-ascii?Q?eNVLJmxmIb1R8Kng1sLSv2n/jd8A6cKq4lNJfOcyRTOs8IVCdQBZOnA=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0101MB2137;6:8tC43i2pXR3BfUNbBQpliXDJVBswY7bC5meAl4+q5yjAaBsTWfE49D6M0MtKp9Sw7LvkKLZ4L8VcEkJUfdd7aVxMGjqsbpcKQvCmIzKN9jrh0gIwKeh9mve8ot//jyL6xkkx+liR8uWS4I7UkfqlTQRFcXtUeCu9F7D4iQqtcf/a94P2TSAXrO//JK/TpTakHiQ1okVgDG8ZSjuZFr1SUyDSeq8JSU2r5Z4afRB90cAor+qVRBFt/f/bQ2uyC4v+gqMMQdV2DTmkAZw+7Uh+T67cIGrYqmB7i5/NE5pU2Tj+J36Rv2Iu30G89CIM1R3v;5:dtxYFrPl1xgtjiD8VB/NThsB893ouyP1bVCAwC21v9sBHs0w6pooVdkKCG0iB9HUMjh4dPR49vBvmmIqGnyUi0wwEGmmK9w8SRrzbcJK7qdu8BjUWs8A6mF/YjRFbg0X9RPWw37fxgW8ZmrN6vIBNQ==;24:Gv9aw0dfkMaZ1all1+AYRGQeS+VPSaW+oDXAYg2saufJb9pElm6EMsHF/gq0Iud+PsEIf/dL2YqRc8bXqlqnT3IpRD+Jod9KsSfEfxTxRCY=;7:6wryLK+rXEdSB+Nt6vawX7lJLCdYBTGi6X/vRmYOYdHXgxAwybDDR09eVGzF8vUk73zJnWb7qOY/dF8KvhWfr/5xgyFV0ySdoDRijz6efXOFoGzbhZFzvaD8kGKw+FdMfaMDC46ZorgSOXDEIWnGodqEFgMbsmeHIhOSqTbXVFfX2N+0pqXVMtATNvBm+ZTZvTUk9x3TbXV9zDKibXfGt0j4XisUNMDgz9uMoagsdIpk/uuDDk7SmVe+G/toGv1M
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: sociomantic.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2016 18:34:48.8791 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0101MB2137
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, I'm getting very often, but not always, with many different
projects using submodules, the message:

  The following submodule paths contain changes that can
  not be found on any remote:
    <module>

  Please try

  	git push --recurse-submodules=on-demand

  or cd to the path and use

  	git push

  to push them to a remote.

  fatal: Aborting.

This even happens after doing a:

git submodule deinit <module>
rm -fr <module>
rm -fr .git/modules/<module>
git submodule update --init

So I am getting the reference from the remote, but when pushing a new
change (that doesn't touch the submodules) I keep getting this error.

I tried to get more information about why this is happening but I
couldn't. Googling didn't help either, so I'm resorting to ask here.

I would also like to report a tiny bug, when using push --quiet, I do
get all the message above except for the <module> name, which is quite
confusing.

$ git --version
git version 2.9.3

(running under Ubuntu 14.04)

Please CC me, and thanks a lot in advance!

-- 
Leandro Lucarella
Technical Development Lead
Sociomantic Labs GmbH <http://www.sociomantic.com>
