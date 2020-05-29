Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B41C433DF
	for <git@archiver.kernel.org>; Fri, 29 May 2020 18:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 313062075A
	for <git@archiver.kernel.org>; Fri, 29 May 2020 18:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="VO0LuMgu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgE2SLU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 14:11:20 -0400
Received: from mga07.intel.com ([134.134.136.100]:14470 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726549AbgE2SLT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 14:11:19 -0400
IronPort-SDR: 4kHAdBLEzHYnB4p/FAdHFqlFOjDaqItEWOUt58PsBoZEqG+z5id1h05SnqDN8r5nQUSHuJIufJ
 U+q4a/UmiRfQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2020 11:11:17 -0700
IronPort-SDR: vjK+5EZgbYl//v3bCcN9mMHlbutYZNtdgfAio8VjMdxhSEnHK3fRQ44ukiGwGIKwF/rZOAcSov
 avsjnk0I5wpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,449,1583222400"; 
   d="scan'208";a="311317964"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by FMSMGA003.fm.intel.com with ESMTP; 29 May 2020 11:11:17 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 29 May 2020 11:11:16 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.53) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Fri, 29 May 2020 11:11:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z2WP6NngwcuDSGMFuzCTj5QV36fUY0K6fWdrueLYaHxkvqEEJoHxbM4qy+wBJ7HBSjpZ1cMyhFbKndIqfMeZn/sWuRiwQK5v9TLViOUWkKUCdEmwuiMs4UPES/UifIDpZDxG0LXiIqoXzZ3Sr8296/soC++T1bE1mOtzxHlLXHivwxqgCI1oR/amQMMVUBRpVeUgVcGzp2OXbypa4/vM6m+xjuTvqvd/Pz7QkScmPgKU8J+pTRdq/bTy0yULlw9uLmIp3deP6rkfz7bfWqOFv/pxQWqdc+MlLDr4JXUtpF3YOVDRODYkFlZTrrbM76VEx1El6xRGvcLnsPgP0YWHTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZafYwI7UJygTQKEyuzl/MgXQKNiUiMaQNHKVCq2jc4=;
 b=TRE3KGiZHjcOtVxniLQ5DDW83bBSEukOgQ/KxzFFMgHz6wONvd2ClShwInMQfLpJ7wgczZLcwqQbHxk3b14jzglYROk1KqlZw2tY2oqCn7p+ydej6heAcqeqfPdMyqm8AFsa7a4KY6tvdaH5EjhqdxWatJ9Oi2HGNIYLEel2a8bLGnn5IWPuKELMynJSHhn1fNWiaBAxCzzKl1C8HHQ9MBIAt7RCUuDdGkmE85+xwS3HNueJMGDYT0cl1ryEvnBIInDK7IH61LCwIBEzYelcYdpB6Lfy2l2J1qZiaO3ULnnfuR/i28F/pBGwrmeiGBDm3JwwPCjaTSZ1rz1Q+vfYtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZafYwI7UJygTQKEyuzl/MgXQKNiUiMaQNHKVCq2jc4=;
 b=VO0LuMguLzPfAZeIqaRE2IJmfBn8HHuV1+YBPl/psyiesXwBqkJZSPECtUaMWihu5TS7+iIdCT2IgUZnI9qmUW78ln/gvgnXLeIQgVu2kiuLGDvWZjl2dhYK0AC9rbdG41mNTJfebRNqg9LVZRGuYWqFUMRylqWE/GhxyPpc2Ds=
Received: from BY5PR11MB4260.namprd11.prod.outlook.com (2603:10b6:a03:1ba::30)
 by BY5PR11MB4226.namprd11.prod.outlook.com (2603:10b6:a03:1bf::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Fri, 29 May
 2020 18:11:15 +0000
Received: from BY5PR11MB4260.namprd11.prod.outlook.com
 ([fe80::48d6:af47:b6c8:fe6a]) by BY5PR11MB4260.namprd11.prod.outlook.com
 ([fe80::48d6:af47:b6c8:fe6a%7]) with mapi id 15.20.3045.018; Fri, 29 May 2020
 18:11:15 +0000
From:   "Bensaid, Selma" <selma.bensaid@intel.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Rebase failure with git version 2.17.1
Thread-Topic: Rebase failure with git version 2.17.1
Thread-Index: AdYzdRdKHblX3EjIQG2g6AtEoFsfYA==
Date:   Fri, 29 May 2020 18:11:15 +0000
Message-ID: <BY5PR11MB426002E5EC02396535220F70E18F0@BY5PR11MB4260.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.136.202]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4429108a-6c26-4faf-7357-08d803fbad84
x-ms-traffictypediagnostic: BY5PR11MB4226:
x-microsoft-antispam-prvs: <BY5PR11MB4226EF164F07037F46FCC3ACE18F0@BY5PR11MB4226.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 04180B6720
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uRCXcAdGz9c8ZxAF6xmQrEzMCKJhGfaNCN0sVYmIaaliZMoKBaRn4FYxXSvj9T4NbianRyQ074INP3cGOtjbYu3ASTgPEVp92STT3YAofLMw+ExvUz26y+A6zvLCZIcWCmZqhpLvkYSHUTJBCtbyVpLKUgpbbfP2a8eIfiB12pyKDjTMoJp3XNmR3uHXfdxHcKgH4JxRFSgU91kWwsfora18fDpiMRAMJzI3Qyhra8EIo9G0ZXFGgKjPSqXemFTukbkiO7A3iTIeLLGsacBPIHki9WZuqHnoJl4AdZBX0iwNlzMgrLX7Blh48s+fM7rPHcNSq0KTq0QK7vlRczQakw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4260.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(376002)(396003)(136003)(346002)(366004)(5660300002)(186003)(76116006)(66446008)(66946007)(66556008)(2906002)(64756008)(66476007)(26005)(52536014)(8676002)(4744005)(55016002)(478600001)(6916009)(83380400001)(9686003)(86362001)(7696005)(33656002)(316002)(6506007)(71200400001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: sAKQDEagmZFiU//lM8M5QrPI4mvHHa6CstLL1YVsWVWEo9HbIcQMxiqoLRkamMycOBEF1MG2h7J8ojxnJ+TLQmPESTQ+xGwtCR78Fm5dsRiKF4BLhabyfplPombEaGwRR0tPe2hT5CsbTEiiOnNb6xc0R9Jw6VUP6/UDm8+VQ2Ywx6dz703xZzEVdpZxa0ihgDJGO2QDtw1hnhpTyLrVgAenduupHRz/6ixC+pkXi2doA3+Xfl7ZlR+D7fRKNmN5mB+orvbxygShx0ybrSC3yt7ac/knni2LGZ2XFKSPSijrkMDYny910Ls2mD7DWu4W3rYoyaE8gMtkZxrTLDywFW2ikj6lL2HtgQlywtK/KE1l5h0utJNYQd+oavCl+bKvQlsQMFxsB+Cd9dQsV7lu+jyeGktLl/qGOm3B2XwcKrPszlCVJOe5X4k6Rkw+V32pEBmOma2yLAenqmAe16wGHpHccwcKth2puq6kDAQVz61c83U9MG8QfNUqDwGT0M7+
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4429108a-6c26-4faf-7357-08d803fbad84
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2020 18:11:15.4269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kG9b7t2whn8A0nfARJEE34l8PJ+m7dY8RCr9T+PVJEiQjkx8RcwgvLK+6wRSQcuPTeQ2M3WtaIfInqptIQtXfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4226
X-OriginatorOrg: intel.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
I'm running into a rebase failure with git version 2.17.1 the same rebase i=
s successful with git version 2.7.4.
Do you have any idea if this a regression or I'm I missing something:
This the command I run with the 2 versions:
git rebase --verbose to_remote/to_branch from_remote/from_branch
Both versions print: Changes from b944516f66e253a325bd3c071f8810b7bd3e0416 =
to cceddad5aa3161b8b841be92090d12f3ed2349ec:
However git version 2.17.1 fails the rebase.
Thanks for your help,
Selma.

