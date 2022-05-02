Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32DDC433FE
	for <git@archiver.kernel.org>; Mon,  2 May 2022 22:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235160AbiEBWLP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 May 2022 18:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387831AbiEBWKp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 May 2022 18:10:45 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5AC71169
        for <git@vger.kernel.org>; Mon,  2 May 2022 15:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651529234; x=1683065234;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=R6bOplnAVDOye1NH+4w0nnDvZJolBzHiGfk2NjgweJ8=;
  b=NKF+80qIWmjmkQT5avM7nQbrPmYuR5MOxjVvTcIfh9caSugcfyAZRKrX
   9n+4d/U111aG+n27RnNdKWSGR2ya5seq7B2KEAF60XvBqaVFOqEXK2hhv
   8McD1rOWBnObmRREhpHE4Jh65qFZ1U4POGDso9jIWbBZRabzefrrt5m9x
   o6GVRz2tpnVqPDlqv/sb2ZuQIE846SVvCL/jzRDa1AjfOS8aWSJBNRkBd
   bQHEpQtFHsYHQyv4SopMzjyaAduNWGXmpGrQ/6udYf2GMqo/sho7j1dZI
   AmbbGNlHd2yVMhpfK96b5WE2NN5JChXapubd4cFDrzk0aAIqaFBBs92M1
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="267216425"
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="267216425"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 15:07:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="583923154"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 02 May 2022 15:07:14 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 2 May 2022 15:07:13 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 2 May 2022 15:07:13 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 2 May 2022 15:07:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jtPmJp7/hr+6mPcnIjrkN+u01fGp4G3cnYKzv90DpgAK8UsQ+G/WsrVz0HyMU+HyLMteXxspdcAFaD3alCBDuZMcS2WaS2U35zQr/6TXLCnFXINHfp8K1jNTaSfa65n3XyxO1uOIKOCp1UTHh5klNSoc74GSBsPkLJtFF9ERq+9cSfCAFUumLSk9zP97muBCyhiW4b1nWdB/jtea/lLd3E/oj50nuC4kccfhmLPfhtTF+4pXQ+DH/tF1Asld1L5f/6MIuGNPcIq5mmV3qf/rwheJx6RSl87uZEu7c31t6HxYlQsHd3ulmeE1hpX0gPTOYH//NhH1NSC/ESyPazYJ/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9J5+n3gHEkYiKZrSF7WD/VzXb+2nffDoRGPvNmyJClk=;
 b=jxs3+QqTd/N1296a5BCpfmkaxae5DllokWcnGiGXmblm61aCMnm3tgORS+Mtp0W3491DJ5a8jGqWAvTl6SuIsUnL48dOUAVCrRBtlJcwwFHOwOFxhM0e5iN9RjHcq83iY4TpyS//QdtDro3EXFb6GtMcN9RjGmWbi1T/IsJedBVjli/1Dn2pEmpo/P125kQ4FBzgh2z+87GEtNek/XTghneskGEAL7nwe1w6l//Tq4SmxpLzG8JPxLiJipOrx5pjbLm68MjlK6yH14wIEuUoenWqg1fDrw5BLAhYIoWhjY+XJyXQOBqZVM56i3GoyMB5TpWlkHL/5OpTS1lVjyDzbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6089.namprd11.prod.outlook.com (2603:10b6:930:2f::20)
 by SJ0PR11MB5071.namprd11.prod.outlook.com (2603:10b6:a03:2d7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.28; Mon, 2 May
 2022 22:07:11 +0000
Received: from CY5PR11MB6089.namprd11.prod.outlook.com
 ([fe80::c1e3:eba2:6b63:9c88]) by CY5PR11MB6089.namprd11.prod.outlook.com
 ([fe80::c1e3:eba2:6b63:9c88%4]) with mapi id 15.20.5206.024; Mon, 2 May 2022
 22:07:11 +0000
From:   "Mirochnik, Oleg V" <oleg.v.mirochnik@intel.com>
To:     =?iso-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: git reset --hard can leave modified files
Thread-Topic: git reset --hard can leave modified files
Thread-Index: Adhb4MMAQOnQgyaTQG+zXJEHEdwbngAbPBsAAIFT3fAAAeFxAAAE9L4Q
Date:   Mon, 2 May 2022 22:07:11 +0000
Message-ID: <CY5PR11MB608955D3020A85983471A260C6C19@CY5PR11MB6089.namprd11.prod.outlook.com>
References: <CY5PR11MB6089858FD6FCC971D6F216DDC6FC9@CY5PR11MB6089.namprd11.prod.outlook.com>
 <20220430044940.6botq23lxmpqxbel@tb-raspi4>
 <CY5PR11MB608914F7E815A8EF95441BB1C6C19@CY5PR11MB6089.namprd11.prod.outlook.com>
 <20220502192634.bzjfvoda2wjjxs3i@tb-raspi4>
In-Reply-To: <20220502192634.bzjfvoda2wjjxs3i@tb-raspi4>
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
x-ms-office365-filtering-correlation-id: e4a2328f-d883-4904-50b7-08da2c881b6b
x-ms-traffictypediagnostic: SJ0PR11MB5071:EE_
x-microsoft-antispam-prvs: <SJ0PR11MB5071E8332B6720AF0C2A15BEC6C19@SJ0PR11MB5071.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pf8gGoJayEogExeJuJsPlpeEZBpAb9uImtqKuw5WsiGnHhQOARyNwb8AwxkBjJGIgqRgylJNqI+bfd/X+EllwDRi6gW0I1uW2Jf+4TFBoz/GfAulkjE8uVtJ38sBwDq6bCqJgQpltwzfVsc7REFEkvdWH5wu2YcjJnCK8VLllvUNBUQrBGsZVBDjR2kU7rEItZiI3OSdK7q0Rnj0xq5X1mxCENLIbpEf4gunS+Wuhg9sXpkDaX6A+72S88HrbNDjZWen7XuSr+DqjapNdwvOvBKrUr35EFb/XRNdHXq0hpmk+E/1jWfgSXJPmb3kI3b3Ey00HUEdP8D2gdnzBpFgUbEe3xqD4HWHqNwP86Y0h5TWU9/PKpPNBRgLbxvwO0a3Hgy6ZP1JZl1dU+j8/ysqqtLBf52GfmCn09zT3xGuFcGDFxZe2Gknk92MzKo++R3+K9pTGU3x0jZK1Ye7xpXW5L8mOPhSPQm8HLEDK06eU8PPYNN5HcqnzyTNlu64JW/LcwtwtFeWzvL49Rsr+r1kIJmKJBLC3kLiZ2Pewujyp+HSYJEBUSUa8aMxSGGoiJseBQUoXSYF5zTod5rMA09zE3p8e1Vu9gxI3/gYhz8hCYzfwy5uBHIIOhgccWcH9Ix3mg3Nm7QEf48RbJy0L6vcPOcMzwn9gfeDLzkIGSRPfuwRhbQdwwcsHl+jfENUiDne1+bZAIy1grXbKa0AXTzZRdnlvNccRXAECo8eTnXtg3avF3hAy5P1xDWKcky80Kxmw9FdFFUZ7tTNvnHWaO4Ju1fCevv5707C6lXc1sSNW1A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(64756008)(8676002)(66476007)(66556008)(186003)(86362001)(66446008)(66946007)(83380400001)(76116006)(66574015)(4326008)(122000001)(55016003)(5660300002)(82960400001)(2906002)(8936002)(38100700002)(52536014)(38070700005)(33656002)(53546011)(6506007)(7696005)(26005)(316002)(966005)(508600001)(9686003)(6916009)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?q6pi+lYuNWB3XYJiJZhrRRl2yw2XmhPGF8Z9YUyXYRjeHWaZWdrUDxYLWx?=
 =?iso-8859-1?Q?0HboIehKbvhSoWEd2lP/XOCs1la0S0QUObrtT688nQyMMsN0SweHghoFYu?=
 =?iso-8859-1?Q?fiPa8yUH/h/b2BvA5RVYn6NLhAYZjTqhw0TRQ6TFkCQOnDLxQUgMvSDH5b?=
 =?iso-8859-1?Q?uqPBO+60IgqaKetFcDIKneRVTWBSX7Qya2JAMGq1OchXwHVREFxSsvy//4?=
 =?iso-8859-1?Q?yBb2bqI3ew+07Lm9jJ821Hh1VuMV9tAdxyIFuCIjrEnIkogt4dCmvuBzv2?=
 =?iso-8859-1?Q?GpabnUtfHWrQ+2lxPf+WJ7i9128fV2LYnAjTDerrYPyei+n+UroKLpDjDY?=
 =?iso-8859-1?Q?otrl70qnkhrveYXDc+JsKYalzE1hiP/sVv6QcRqyhTc4WX9IhKs/c/nLut?=
 =?iso-8859-1?Q?X54jL71TFuePyEPEhogajO34N2aoA/UtunrztAbIg/YJB+WNV1A8VH3yak?=
 =?iso-8859-1?Q?995En59+p6A7NxgJSTKhBkBohWAAFfuqvFJfwzZV+WLC56J+oH5E37Jl/8?=
 =?iso-8859-1?Q?9ms2j6GU+FNwRRYimvJjk6J4xBdX5AhAy3pHJeyqtPCSHejqceovxKZMv2?=
 =?iso-8859-1?Q?C3OFNGzu06ebHqQVa/AL2B0EuYgO/9Ivj1YhW1J5E6cZHbKxMsMbdrYKNi?=
 =?iso-8859-1?Q?2iGO4NqNLsHY2u3+eMArxJcSn3fU6ZP/zaPgCfM/TSbl+3oyAaACl5EhW+?=
 =?iso-8859-1?Q?nDeJE6YsCyPBeFk7smQgtKbdl6LygrXEO4zFPVbTNKL8/qBH7kY9xPXmEI?=
 =?iso-8859-1?Q?b1xwTPO7p4EazZiCnz8zyQD8UoeSy3JBkAeroS+6nlOOyq3jIEOxDj0vd4?=
 =?iso-8859-1?Q?j+xseB5n2mqn2AF67QNJNbjPssPhTKYFyn8RllyNnCZ01ve13eXF9JUs5h?=
 =?iso-8859-1?Q?V4d4O/xca+/oeGNbWEsL/GOlts+kqFyPeKYug4JA0jemf7oJYS4I5dZlKD?=
 =?iso-8859-1?Q?aVarOzGTFuDFz0TMt5rON1o2lxjXV7Nm+6s1aoquqtBaxHVmf+5qlU/fUT?=
 =?iso-8859-1?Q?yotiuqPSN/5z8N+mzuRR5sT/3281ZtCLUUUS7OUc/UhHe5Mid1Zs+i71Mh?=
 =?iso-8859-1?Q?NWgzQJoG/E/nP+H37wTwAwN6b0f8Kj5W9KpJ99gGlHbC6P/P5KVoHi9UuP?=
 =?iso-8859-1?Q?cjNNF40e+KHFzNiGK0HXE+X/bOrCJDn+8CyMVlyM1BTl8LlPTROOr6BzUs?=
 =?iso-8859-1?Q?qVJvur7a1jm3QkcOhBXQnaGXRyPgjLJiwY6jbxVD7sHH+n1DM78g4tbV1A?=
 =?iso-8859-1?Q?nmXk5LNPAXqQDGlc1X6fo9HwsgANsPDQuYt47nssI3P87y/UorMdKLzGSC?=
 =?iso-8859-1?Q?e+u1hK6LO+uDx8uaGK5vwxrQl6llbK++M2VGV0xvnK246h6SXhlgGmm6MC?=
 =?iso-8859-1?Q?SLfbnbm2FNPGG/Xx5J4SA9IhvxOL6gXfDg5c/xPBhyPe16EO7bDPzFPyFT?=
 =?iso-8859-1?Q?sFGaMR/mXvOzRr1inp7ZPAvq1/5PnlPha0dM9gnHV2TP2V76AlpPRLBD/W?=
 =?iso-8859-1?Q?LE2heFTFNb9jWKf9qK0BhGVOJUk3LSEUalSVdsNSqATAV3SljhLtajzqOc?=
 =?iso-8859-1?Q?5Oo0dXC0rZrj9F9mZYvvxRRQKdMXo9nMiweNb/oQLGHJHyOsPETko6oonR?=
 =?iso-8859-1?Q?FApLeWnxoMsEGlXPtw7Xpim5WxTUlWhbCL2gc4IFmaoUuROMxxf3KPx+Is?=
 =?iso-8859-1?Q?6o/jFUQjdk4msssoxTvvUVv/E9rDyDlNOYwkMlUrBvdyL4C6D20nVRGHYR?=
 =?iso-8859-1?Q?Z2LBt46HO668LFZlpkgabK/qD8UArNzBb2OEPdRatl+CrZRZcBWvgdT0/L?=
 =?iso-8859-1?Q?emYNNa7H9gsAlh1fsLhfUQBOK3BaN70=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4a2328f-d883-4904-50b7-08da2c881b6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2022 22:07:11.3227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MNmmrMNBtLw/rXbAHa7zlAeEGsqv4hJniYCcPCeNEjincxJPPOPv4HwYEBHOM49ES+rMlBcmi5763pVkKn/cz8xwtpfGCgKizP+3wqogMXg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5071
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -----Original Message-----
> From: Torsten B=F6gershausen <tboegi@web.de>
> Sent: Monday, May 2, 2022 12:27 PM
> To: Mirochnik, Oleg V <oleg.v.mirochnik@intel.com>
> Cc: git@vger.kernel.org
> Subject: Re: git reset --hard can leave modified files
>=20
> On Mon, May 02, 2022 at 06:37:26PM +0000, Mirochnik, Oleg V wrote:
> > > -----Original Message-----
> > > From: Torsten B=F6gershausen <tboegi@web.de>
> > > Sent: Friday, April 29, 2022 9:50 PM
> > > To: Mirochnik, Oleg V <oleg.v.mirochnik@intel.com>
> > > Cc: git@vger.kernel.org
> > > Subject: Re: git reset --hard can leave modified files
> > >
> > > On Fri, Apr 29, 2022 at 03:50:59PM +0000, Mirochnik, Oleg V wrote:
> > > > Thank you for filling out a Git bug report!
> > > > Please answer the following questions to help us understand your is=
sue.
> > > >
> > > > What did you do before the bug happened? (Steps to reproduce your
> > > > issue) git clone https://github.com/intel/llvm cd llvm git
> > > > checkout git-bug-reproducer git merge
> > > > 38df0bd4fccd1067f3abe078d42e94c740748628
> > > > -m Merge1 --no-ff git merge
> > > > b6b8d34554a4d85ec064463b54a27e073c42beeb
> > > > -m Merge2 --no-ff git reset --hard HEAD~ git status --porcelain
> > > >
> > > > What did you expect to happen? (Expected behavior) An empty output
> > > > from the last command
> > > >
> > > > What happened instead? (Actual behavior)  M
> > > > clang-tools-extra/test/clang-apply-replacements/Inputs/crlf/crlf.c
> > > > pp
> > > >  M
> > > > clang-tools-extra/test/clang-apply-replacements/Inputs/crlf/crlf.c
> > > > pp.e
> > > > xpected
> > > >
> > > > What's different between what you expected and what actually happen=
ed?
> > > > Obvious
> > > >
> > > > Anything else you want to add:
> > > > The issue is flaky. First found for v2.29.2 Multiple executions of
> > > > the "git reset --hard HEAD" can help.
> > > > I ran a simple script to get some numbers: 100 attempts to get and
> > > > fix the issue
> > > with up to 100 runs of the "git reset --hard HEAD"
> > > > Got max number of runs - 45. Most of the cases (63) required 5
> > > > runs. 5 cases
> > > did not get the issue at all.
> > > > V2.36.0 built from sources got similar results:
> > > >
> > > > The script:
> > > > (set -e; for a in {0..99}; do echo ++++++++++++++++ a=3D$a; git
> > > > reset --hard origin/git-bug-reproducer; git merge
> > > > b2d4d67d5e34c345cb6a3cf725b2e26a15a9dfe5 -m Merge1 --no-ff; git
> > > > merge b6b8d34554a4d85ec064463b54a27e073c42beeb -m Merge2 --no-
> ff;
> > > > git reset --hard HEAD~; for b in {1..99}; do git status
> > > > --porcelain | grep . || break; git reset --hard HEAD; done; echo
> > > > ++++++++ b=3D$b; git status --porcelain | grep . || continue; echo
> > > > FAILED $a; break; done) > ../logg 2>&1
> > > >
> > > > Please review the rest of the bug report below.
> > > > You can delete any lines you don't wish to share.
> > > >
> > > >
> > > > [System Info]
> > > > git version:
> > > > git version 2.36.0
> > > > cpu: x86_64
> > > > no commit associated with this build
> > > > sizeof-long: 8
> > > > sizeof-size_t: 8
> > > > shell-path: /bin/sh
> > > > uname: Linux 4.18.0-193.el8.x86_64 #1 SMP Fri Mar 27 14:35:58 UTC
> > > > 2020
> > > > x86_64 compiler info: gnuc: 4.4 libc info: glibc: 2.28 $SHELL
> > > > (typically, interactive shell): /bin/bash
> > > >
> > > >
> > > > [Enabled Hooks]
> > > > not run from a git repository - no hooks to show
> > >
> > > One quesion, out of interest:
> > > do you have core.autocrlf=3Dtrue ?
> >
> > Nope.
> >
> > > What does
> > > git config core.autocrlf
> > > give you ?
> >
> > Nothing:
> > $ git config core.autocrlf
> > $
> >
> > > The llvm repo itself has a lot of files commited with CRLF in the rep=
o.
> > >
> > > You can see this by running
> > > git ls-files --eol | grep "^i/crlf"
> > >
> > > So my recommendation would be to set up a proper .gitatributes file
> > > in the root of the repo, run
> > >
> > > git add --renormalize .
> > > git add .gitattributes
> > > git commit -m "Normalize the line endings"
> >
> > AFAIK all of them CRLF files are intentional.
> > LLVM community decides on the stuff, we have to follow the decisions.
> >
>=20
> I somewhat suspect seriously that the problem is related to this thread:
> https://reviews.llvm.org/D124563
>=20
> I didn't dig into all the details (yet).
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  git show c9a16e8c3d99173c7525e576d78eed571 Drop '* text=3Dauto' from
> .gitattributes and normalize
>=20
>  Git wants to check in 'text' files with LF endings, so this changes them
>      in the repository but not in the checkout, where they keep CRLF endi=
ngs.
>=20
>     Differential Revision: https://reviews.llvm.org/D124563
> --------------------
> I don't know, if this was a good change or not.
> If folks wants CRLF in their working tree, there are 3 ways to do so:
> - Set core.autoclrf to true
> - Set core.eol to CRLF
> (This works on Windows and Unix)
>=20
> Or, if everybody should have CRLF in the working tree, we could (and shou=
ld) still
> have LF in the repo.
>=20
> Just set
>=20
> *myfiles.cpp text=3Dauto eol=3Dcrlf
>=20
> In other words
> (I may be wrong due a lack of time to dig deeper into the llvm repo) the =
problem
> seems to come from upstream.
>=20
> And we could find out, what upstream really wants and needs, and may be a=
ble
> to help here.
>=20
> Is this maybe something you can do, contact upstream ?
No, I could not as I'm not a llvm contributor.
Here is another related discussion, hopefully could be useful -- https://re=
views.llvm.org/D48494

Actually, I don't quite understand what your suggestions are.

Are you telling it's not a git bug but an invalid setup in the llvm-project=
 repo?
If so, then I'd suggest you (or git community) provide a clear description =
(or link to a related document) what needs to be done to make it valid and =
I'd ask one of our contributors to propose a correspondent fix into the ups=
tream.
Or you agree it's a bug.
Then I'd ask to propose your recommendations as a temporary (or permanent) =
workaround.

Could you please clarify?
=0D=
