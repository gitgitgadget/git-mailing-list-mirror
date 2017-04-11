Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 112A620970
	for <e@80x24.org>; Tue, 11 Apr 2017 22:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752214AbdDKWaH (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 18:30:07 -0400
Received: from mail-by2nam03on0133.outbound.protection.outlook.com ([104.47.42.133]:5184
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751620AbdDKWaG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 18:30:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ZNfbThssivUWrEEzj7A5jFi2lD9RXMi5Vg0zb1bnBmQ=;
 b=IESNcZZNoa6TEtHbQ+mWox+ERCXsL8o8KoWwlhXXW0YlQdMbQfB6w/ouyaxj7q6OZ+trmYRrbdWOhcfOfeeYduIaCrnZzoK2WinuAoF8Txltycqwcj+WGOJOtqoa27sqa2/LYORIGX7tQwGO8V4tM8c1/2MbU9+jRTqQgAMYpok=
Received: from SN2PR03MB2333.namprd03.prod.outlook.com (10.166.210.136) by
 SN2PR03MB2336.namprd03.prod.outlook.com (10.166.210.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1034.10; Tue, 11 Apr 2017 22:30:04 +0000
Received: from SN2PR03MB2333.namprd03.prod.outlook.com ([10.166.210.136]) by
 SN2PR03MB2333.namprd03.prod.outlook.com ([10.166.210.136]) with mapi id
 15.01.1034.011; Tue, 11 Apr 2017 22:30:04 +0000
From:   Kevin Willford <kewillf@microsoft.com>
To:     Duy Nguyen <pclouds@gmail.com>,
        Kevin Willford <kcwillford@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "peff@peff.net" <peff@peff.net>
Subject: RE: [PATCH 3/3] reset.c: update files when using sparse to avoid data
 loss.
Thread-Topic: [PATCH 3/3] reset.c: update files when using sparse to avoid
 data loss.
Thread-Index: AQHSr9SG2d/PxqpiCkGFIsgEf/85JqG+aZyAgAJC7XA=
Date:   Tue, 11 Apr 2017 22:30:04 +0000
Message-ID: <SN2PR03MB2333BCFD2E1A6A400706F94CB7000@SN2PR03MB2333.namprd03.prod.outlook.com>
References: <20170407192357.948-1-kewillf@microsoft.com>
 <20170407192357.948-4-kewillf@microsoft.com> <20170410102429.GB19325@ash>
In-Reply-To: <20170410102429.GB19325@ash>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [184.155.115.67]
x-microsoft-exchange-diagnostics: 1;SN2PR03MB2336;7:OF+FsCM3+3UNgPil6cPrzKMzgnsFju9cKrNEJhd1N8Z4PmDiOBt+d6D4X3bqXXadT0ktF8Qf9riou5MIN0q/dj7lgff9OI5HGhGavPKtqJAL2HpkU718is07EbeCxO9pu6rp8kdCLurpwVRi+FQhUNQqA+qSkH4EoxGWfD2wfBeY51nGfqPrdMNwrcjb68bUuWVwS/TrNnMxto/wKKQ22aEeGFtbWRKuBf3mdrqKi/xToJOVPasSv3W183L73foR7k5sESnRqtC7Ysr8QgSY5YVpPTxIq+rKUBwYVCk5+GCZxCeQYf7LvJSagJ7q10dBnTwNKbaULfJZCww0dJdSB/9kIXm9ncJHiGCz7G/+RD4=
x-ms-office365-filtering-correlation-id: 7dbe36cd-8bf2-4534-c042-08d4812a4d14
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254075)(48565401081)(201703131423075)(201703031133081);SRVR:SN2PR03MB2336;
x-microsoft-antispam-prvs: <SN2PR03MB2336D316B12E6749AFB93C44B7000@SN2PR03MB2336.namprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(100324003535756);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040450)(601004)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041248)(20161123560025)(20161123555025)(201703131423075)(201702281528075)(201703061421075)(20161123562025)(20161123564025)(6072148);SRVR:SN2PR03MB2336;BCL:0;PCL:0;RULEID:;SRVR:SN2PR03MB2336;
x-forefront-prvs: 0274272F87
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6009001)(39860400002)(39410400002)(39840400002)(39400400002)(39850400002)(39450400003)(13464003)(24454002)(377454003)(54094003)(305945005)(53546009)(10290500002)(7736002)(5005710100001)(8990500004)(189998001)(10090500001)(74316002)(6116002)(102836003)(3846002)(2950100002)(8676002)(7696004)(4326008)(25786009)(8936002)(81166006)(5660300001)(66066001)(33656002)(76176999)(54356999)(50986999)(122556002)(6506006)(38730400002)(2906002)(39060400002)(6436002)(86362001)(229853002)(6246003)(15650500001)(53936002)(55016002)(77096006)(99286003)(9686003)(8656002)(54906002)(86612001)(2900100001)(3280700002)(3660700001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN2PR03MB2336;H:SN2PR03MB2333.namprd03.prod.outlook.com;FPR:;SPF:None;MLV:ovrnspm;PTR:InfoNoRecords;LANG:en;
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2017 22:30:04.6896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR03MB2336
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -----Original Message-----
> From: Duy Nguyen [mailto:pclouds@gmail.com]
> Sent: Monday, April 10, 2017 4:24 AM
> To: Kevin Willford <kcwillford@gmail.com>
> Cc: git@vger.kernel.org; gitster@pobox.com; peff@peff.net; Kevin Willford
> <kewillf@microsoft.com>
> Subject: Re: [PATCH 3/3] reset.c: update files when using sparse to avoid
> data loss.
>=20
> On Fri, Apr 07, 2017 at 12:23:57PM -0700, Kevin Willford wrote:
> > When using the sparse checkout feature the git reset command will add
>=20
> "git reset" has three different modes. It would be good if you mention wh=
at
> mode is affected here. The tests are for --mixed only. I wonder if we nee=
d to
> do anything for --hard and --soft?
>=20
> --soft touches branch SHA-1 index only, not worktree, so probably not.
>=20
> --hard should be handled by unpack_trees(), I think.
>=20
> But it would be good to cover these in the commit message as well to stop
> readers from wondering.

Sounds good.

>=20
> > entries to the index that will have the skip-worktree bit off but will
> > leave the working directory empty.  File data is lost because the
> > index version of the files has been changed but there is nothing that
> > is in the working directory.  This will cause the next status call to
> > show either deleted for files modified or deleting or nothing for files
> added.
> > The added files should be shown as untracked and modified files should
> > be shown as modified.
>=20
> Hmm.. reading --mixed documentation again ("Resets the index but not
> working tree"), I think the current behavior is expected regardless of sk=
ip-
> worktree bits.
>=20
> Perhaps the problem is the loss of skip-worktree bits on entries added by
> update_index_from_diff()? If the bits are at the right place, then it sho=
uld
> not matter if the same version exists on worktree or not and "status" or
> "commit" should work as expected, I think.
>=20
> --
> Duy

The loss of the skip-worktree bits is part of the problem if you are talkin=
g
about modified files.  The other issue that I was having is when running a =
reset
and there were files added in the commit that is being reset, there will no=
t
be an entry in the index and not a file on disk so the data for that file i=
s
completely lost at that point.  "status" also doesn't include anything abou=
t
this loss of data.  On modified files status will at least have the file as=
 deleted
since there is still an index entry but again the previous version of the f=
ile
and it's data is lost.

To me this is totally unexpected behavior, for example if I am on a commit
where there are only files that where added and run a reset HEAD~1 and
then a status, it will show a clean working directory. Regardless of=20
skip-worktree bits the user needs to have the data in the working directory
after the reset or data is lost which is always bad.

Kevin

