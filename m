Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D33C433F5
	for <git@archiver.kernel.org>; Mon,  2 May 2022 18:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350598AbiEBSk7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 May 2022 14:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbiEBSk6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 May 2022 14:40:58 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7768F7645
        for <git@vger.kernel.org>; Mon,  2 May 2022 11:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651516648; x=1683052648;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ye86Vj06W/+JDFgV2h9OfdpdYWKSt/WMK2CjQQ4ERzY=;
  b=CQsHSn76hc4ET9ZW4RdVS0twT9+ttDevDFOsmhbnZRTUH72xIzZeC7Uv
   1UoQvsffIPyTqt8r3KDMhOPLKiDbJCm6HG5UzzMCqg43pzOFTSyQ/fkTA
   tEq8j9nt2BglN05P8geznaZzLb0GbRNSdPt6AZQS0TQW/+0QQvnAu1Qj/
   wLc4XgHW1Tp+3MZETWk8A+EjYG9CqFnBMlD+9+pP6blXA2QHdHNp+e2rJ
   E+rEkmMqknZkUOHC1jYrDVDde+ESajXvl8LyNf0XFoYbViql5RJ030xi5
   qR+8OToNxc19XEEdcixU5b+rskLbtIlVy6XIiADCILIEuCzXzA1TaCk5/
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="292481300"
X-IronPort-AV: E=Sophos;i="5.91,192,1647327600"; 
   d="scan'208";a="292481300"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 11:37:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,192,1647327600"; 
   d="scan'208";a="707730558"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga001.fm.intel.com with ESMTP; 02 May 2022 11:37:28 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 2 May 2022 11:37:27 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 2 May 2022 11:37:27 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 2 May 2022 11:37:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P2qKTr6y8Xz4L7u12ezrodciWhoJNZwG5Ucr/xIaWEmWd/BeJwUE6rof62S9GRah7lxRKHTCSWyXFHdqOszbTXvosbKNacvQHR3LntB1oOjPdYx23LacpUpAvXfhk/Ol1+4u92vxopBWEKEmP5YBOh65jMprHVV67S0bJxJwJ+c0NwWeNd2uVa8VBIaxZd7tIEMqVTERRpCPEVoRwC8s9Rvnx+lbI++C6BcQFKPzzIkfY2b/HOZwvOMe6quKlhfWOtB8wueFXzx+v2+Xsl0BPAUMDnRIYaw+iToLLeA4yTlH1+ljmRq85q+IM3W7hm/m+/mPtJmXmAiDq7yObLYBIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mbepc5QKgvg7fBIrRnIBB26dfmN+WTFlxpKpTCNNb10=;
 b=cDxBSK7UVsD4EmO0CgTRkvpkfysti5lyY7djY9rgxWqzHOTPr58CvTtw55W2ME6muLnv5zJMm16IzWJNjlMe8+FDi5Hft3YqY1gG0OmixHvnizimWv4xSIBw1rUj2K0tRdB+xto7m8gwHJBXsgmhA3ypePuxj9PHNhxuqElldCy9wh82w6FWuDNvPVa3SbkJ7Yi+KzGsdFVUoHWFsChxYM6I+PPgVoJZUZMvbX8aDcav+SjjNjlAz6150dkRBcRzPZoi8OGWIXvWO+KKTMVNEEFioF1+4Oz4QjaAStu3UibXiP6CTBe1eqNvXC568rmnwf6IFMFKVXKG2T0tUFTjcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6089.namprd11.prod.outlook.com (2603:10b6:930:2f::20)
 by CY4PR11MB1352.namprd11.prod.outlook.com (2603:10b6:903:2a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Mon, 2 May
 2022 18:37:26 +0000
Received: from CY5PR11MB6089.namprd11.prod.outlook.com
 ([fe80::c1e3:eba2:6b63:9c88]) by CY5PR11MB6089.namprd11.prod.outlook.com
 ([fe80::c1e3:eba2:6b63:9c88%4]) with mapi id 15.20.5206.024; Mon, 2 May 2022
 18:37:26 +0000
From:   "Mirochnik, Oleg V" <oleg.v.mirochnik@intel.com>
To:     =?iso-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: git reset --hard can leave modified files
Thread-Topic: git reset --hard can leave modified files
Thread-Index: Adhb4MMAQOnQgyaTQG+zXJEHEdwbngAbPBsAAIFT3fA=
Date:   Mon, 2 May 2022 18:37:26 +0000
Message-ID: <CY5PR11MB608914F7E815A8EF95441BB1C6C19@CY5PR11MB6089.namprd11.prod.outlook.com>
References: <CY5PR11MB6089858FD6FCC971D6F216DDC6FC9@CY5PR11MB6089.namprd11.prod.outlook.com>
 <20220430044940.6botq23lxmpqxbel@tb-raspi4>
In-Reply-To: <20220430044940.6botq23lxmpqxbel@tb-raspi4>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.401.20
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9cea6ca4-9bca-45a8-2250-08da2c6ace36
x-ms-traffictypediagnostic: CY4PR11MB1352:EE_
x-microsoft-antispam-prvs: <CY4PR11MB1352EA1ACF089E42B66F5AFEC6C19@CY4PR11MB1352.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s0y06ZIEHFpkMNIZ4743J7kmf1pXAe1dr4VfgevbMHjScFTNg9vZkEPn0XUxXvVTehYbxFd7pSc64VlXubOnYe4d8Z/rHRuwtoXG2UcdMloAUxn6AWMuZHr2SGomD9uW19aSW9WyFIf5dmWWIf4TlMRwzJfhsD1a9HLa5OXW905cCufLy94tI6KpNYLqhHfjLBsK16MZLf7QjiqHyFlQHLquwUS5X0+Lf2/BUOo0noFeGXI3v2Mlp43FElxhqrd7+/2145Jc/sXQvew9hMkuI7ZGASEY6/p2xg+Pq2hOPnD/qbviTLMBdhnH3V3eX6X6H0q/3IIB/F3mN96pBTnj/Le97+kOXhzp63ET/V2FtS5jdRFPxKxmdl1+QadKWVs5SIuuX0cRP4uG3xn66brtDFZX580dI1uU4g5Ti8FoV7jEIeRT14GM+1xhMJMzhpBBjR7gjS24jW5Kb4rO4QhqaczanKVp56Xj1EeukOOQLnh8DccQVkVYvNAomdK9Q15g9rkuPfiym19CWqAy6VxZB7F3ZaB8EI8/t8vduuVbxmaMCzxETk/tvdhC5RlW2ubw8ibtCnnobZPeP7ji2eSofoZ4RGozsRrbFIjHLWSCp2XUKzP2j9VrlGGqLomUnmI70AaY3ZVg8IpmFzzKVj38lgbEE2j9azZjPRSBCwWzqfkR0MKbu3XDcO07LOh2VqI17jafjHoKzu4oOWVGi9HYDbVRLvSfKfE7oyA1rMajEKpoyINpEIICB4BtUlubsji4+tKDCIofVuSIaaKQi/H08YusjXYkpMivaHRFpI63Uxw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(33656002)(7696005)(82960400001)(38100700002)(38070700005)(8676002)(4326008)(71200400001)(6506007)(122000001)(316002)(6916009)(66574015)(83380400001)(64756008)(66476007)(66446008)(66946007)(66556008)(76116006)(8936002)(966005)(86362001)(508600001)(5660300002)(52536014)(9686003)(55016003)(26005)(53546011)(186003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2nywNLZSfdNl/dIEqxuBJYv8M72VZLNjYeP0OhxYe4GgKtAg3STyVSxkGr?=
 =?iso-8859-1?Q?41oyvVqPe93zMxeTV3jY0YG3o7VzQ+4XL1zLCiRikeyb+1Qd4IvnkNcBl8?=
 =?iso-8859-1?Q?dPEyC069iuX86FKTnlbtpGVYKy9lVcSa7soKRTn3kuEG+n5fdhgb3rtGPa?=
 =?iso-8859-1?Q?qCma7Y+3hn1/7MIa5sHfmPwLBKfMSTT2UJSP2byzIF222mWGiP6AJCgwXO?=
 =?iso-8859-1?Q?lw93p8mPSZEUk3l1erkINTHxlKkJuynSFVKdZS0WA6Ygo4OG/1def6olPW?=
 =?iso-8859-1?Q?8udMUfq74kHnkXa4tbi6iPqEaaIMWAko6WdZFIeGP8eoAYXEva6n0t4OjF?=
 =?iso-8859-1?Q?BHSy0ekOMTKO7WtrUDCf2qEBFIVRuJrpAB7AzKJkfgLygeV4EdGZxPbRqi?=
 =?iso-8859-1?Q?KXaysxASHUGyFQ68x4mwqJ1h4d4ozx8tlYIRMAsgXIdLjnTVCG3How3cSj?=
 =?iso-8859-1?Q?i9Ax5G0/4XNAmofqSB10l3W5XY7ttaIqL6Fv0FECno8z7vBoj3NUEEfegU?=
 =?iso-8859-1?Q?GoIlC/1KNWwzgRLjvuCcabAD7AFt7abjPDf51bfP6BOHDq22vrtHz08ckD?=
 =?iso-8859-1?Q?rk1L4I+wJ9fyNfRWOqtsxmbS04vziv8xG2b9ULSFdoklz2RHZ8AnEfPow6?=
 =?iso-8859-1?Q?DyUo8Vla+jMWsIVEpz1h5tDSQkB0meBMn8F1QEAOdD8/BtYc11qy584pr1?=
 =?iso-8859-1?Q?FWOHm4ER9TOi2/s7WMGtN7cVPmi6IZgrC+erzM+ZxXayC9HqeQJm/T08HD?=
 =?iso-8859-1?Q?mmHiuAamubJpI5pgkJ/sKIcNKeHlZO0iuHnyMkC6qGyiC8Ag4GIFeN0ls8?=
 =?iso-8859-1?Q?18PoEzO1swKYB0x1tDFKdXm4TmW3MmqK7VmiGnSQ7SUoF19aurpUzpqv+a?=
 =?iso-8859-1?Q?BhVjWZvcnkvogBum+rzkYCpoqv1YbSOSrzrOEFeN+PVh2aOVC3YBvjAV9C?=
 =?iso-8859-1?Q?UhHacmkWbCIdUFjgZChjqWiJcvr+561JJO2XHrHK0gRWjNo+FRO6rqHeyf?=
 =?iso-8859-1?Q?qwG4Q4iqRjoYNVs1q3Ffm2aakDZxUKaYz6ZWDuMxpM4h8EiGNG4V28sPMa?=
 =?iso-8859-1?Q?wbEf+MHxYGpj+VYOGWzeJEFK2Oay7vpoX5V6p+9yTBzxkBlaV73fXJDILL?=
 =?iso-8859-1?Q?p0uc2l2zZnL5t8OQSbTEuR52IscPDCeAh9HUvZ3rTJ0BX6kOUtkGrAtDhj?=
 =?iso-8859-1?Q?K1rzNkkXFv8Jo0cYNTpXaTY2a5zFPh6wuynkKQH7J74TRGGhO5k3h/RrAt?=
 =?iso-8859-1?Q?I8XVrH34u/jZy0YsrZmiUuQHLRFQ2BjrsxbvP2smcOHjwAwJoz7/LsN651?=
 =?iso-8859-1?Q?+rmUSVTxCuXH3eHDudFKnlZiSNeGCNs5ZRvQfmi/aobbduSPuUHT2hrKef?=
 =?iso-8859-1?Q?ziPwloKIe+FAEKZQi+9TtNSCS6b9ywmIpoSZLxiyx/N55o7El4O4pZ58im?=
 =?iso-8859-1?Q?SKJFKfvnA4PNEHgQuRw5NPIzqzWBV1COg11saZrEWLS3ILIW4VQQpWiAIw?=
 =?iso-8859-1?Q?5NJdopyoWG0Y+4iCZefH8vtrEfO57pVcsYM0k6D3VedFwPelaYlZ2CwPCL?=
 =?iso-8859-1?Q?5sYMd5WGT8vrLoXV8G9I34LPYca2CyU5zHUXkbw8bJj2DIKvNx5UXRD58N?=
 =?iso-8859-1?Q?r1hrJC3IEkJjfJkIrGYlnPzFUkp7OFOO27TrN9nRUuOKBzMnAlgoJNACEp?=
 =?iso-8859-1?Q?yi5X8uEi4lgE+zgMsCT+UvPfI3jt5FfD9zMXIPT1xDgOgMad2Uy5YsDSrB?=
 =?iso-8859-1?Q?bYFBNX8G4HKiOvrsNpy+2lQ1//J3kVqc8SGfWr+QC9yHi0zLlfdkYP46/U?=
 =?iso-8859-1?Q?61P8fLBHmZimenTByNuKPmZ00E9CWK8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cea6ca4-9bca-45a8-2250-08da2c6ace36
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2022 18:37:26.3687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: La9zwSgoE9WWV1lRn8zXy8YKka99KueCyccD4hqV+wmvF7ntQJFZZVWNZB4L6I4xdG+PfgXM1kiTyPHKOYRUJaOGxrmwHzllaLC4ZpgeK+w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1352
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -----Original Message-----
> From: Torsten B=F6gershausen <tboegi@web.de>
> Sent: Friday, April 29, 2022 9:50 PM
> To: Mirochnik, Oleg V <oleg.v.mirochnik@intel.com>
> Cc: git@vger.kernel.org
> Subject: Re: git reset --hard can leave modified files
>=20
> On Fri, Apr 29, 2022 at 03:50:59PM +0000, Mirochnik, Oleg V wrote:
> > Thank you for filling out a Git bug report!
> > Please answer the following questions to help us understand your issue.
> >
> > What did you do before the bug happened? (Steps to reproduce your
> > issue) git clone https://github.com/intel/llvm cd llvm git checkout
> > git-bug-reproducer git merge 38df0bd4fccd1067f3abe078d42e94c740748628
> > -m Merge1 --no-ff git merge b6b8d34554a4d85ec064463b54a27e073c42beeb
> > -m Merge2 --no-ff git reset --hard HEAD~ git status --porcelain
> >
> > What did you expect to happen? (Expected behavior) An empty output
> > from the last command
> >
> > What happened instead? (Actual behavior)  M
> > clang-tools-extra/test/clang-apply-replacements/Inputs/crlf/crlf.cpp
> >  M
> > clang-tools-extra/test/clang-apply-replacements/Inputs/crlf/crlf.cpp.e
> > xpected
> >
> > What's different between what you expected and what actually happened?
> > Obvious
> >
> > Anything else you want to add:
> > The issue is flaky. First found for v2.29.2 Multiple executions of the
> > "git reset --hard HEAD" can help.
> > I ran a simple script to get some numbers: 100 attempts to get and fix =
the issue
> with up to 100 runs of the "git reset --hard HEAD"
> > Got max number of runs - 45. Most of the cases (63) required 5 runs. 5 =
cases
> did not get the issue at all.
> > V2.36.0 built from sources got similar results:
> >
> > The script:
> > (set -e; for a in {0..99}; do echo ++++++++++++++++ a=3D$a; git reset
> > --hard origin/git-bug-reproducer; git merge
> > b2d4d67d5e34c345cb6a3cf725b2e26a15a9dfe5 -m Merge1 --no-ff; git merge
> > b6b8d34554a4d85ec064463b54a27e073c42beeb -m Merge2 --no-ff; git reset
> > --hard HEAD~; for b in {1..99}; do git status --porcelain | grep . ||
> > break; git reset --hard HEAD; done; echo ++++++++ b=3D$b; git status
> > --porcelain | grep . || continue; echo FAILED $a; break; done) >
> > ../logg 2>&1
> >
> > Please review the rest of the bug report below.
> > You can delete any lines you don't wish to share.
> >
> >
> > [System Info]
> > git version:
> > git version 2.36.0
> > cpu: x86_64
> > no commit associated with this build
> > sizeof-long: 8
> > sizeof-size_t: 8
> > shell-path: /bin/sh
> > uname: Linux 4.18.0-193.el8.x86_64 #1 SMP Fri Mar 27 14:35:58 UTC 2020
> > x86_64 compiler info: gnuc: 4.4 libc info: glibc: 2.28 $SHELL
> > (typically, interactive shell): /bin/bash
> >
> >
> > [Enabled Hooks]
> > not run from a git repository - no hooks to show
>=20
> One quesion, out of interest:
> do you have core.autocrlf=3Dtrue ?

Nope.

> What does
> git config core.autocrlf
> give you ?

Nothing:
$ git config core.autocrlf
$

> The llvm repo itself has a lot of files commited with CRLF in the repo.
>=20
> You can see this by running
> git ls-files --eol | grep "^i/crlf"
>=20
> So my recommendation would be to set up a proper .gitatributes file in th=
e root
> of the repo, run
>=20
> git add --renormalize .
> git add .gitattributes
> git commit -m "Normalize the line endings"

AFAIK all of them CRLF files are intentional.
LLVM community decides on the stuff, we have to follow the decisions.

=0D=
