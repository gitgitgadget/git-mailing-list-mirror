Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0683C433F5
	for <git@archiver.kernel.org>; Mon, 30 May 2022 22:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237737AbiE3WEc convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 30 May 2022 18:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbiE3WE2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 May 2022 18:04:28 -0400
X-Greylist: delayed 303 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 30 May 2022 15:04:24 PDT
Received: from USMLB1RNPMX04POUT.l3harris.com (usmlb1rnpmx04pout.l3harris.com [192.52.235.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5AA72E25
        for <git@vger.kernel.org>; Mon, 30 May 2022 15:04:24 -0700 (PDT)
IronPort-SDR: ulWb3+/TFWs25V0VXFMPjBIiL7V5ftXrdd0gevyl6Yy5Sc0Z+8mbh5dCIqQ5/uzlZVXDqHZhlU
 UegeYQQyEhXQ==
From:   <Graham.Menhennitt@c4i.com>
X-IronPort-AV: E=Sophos;i="5.91,263,1647302400"; 
   d="scan'208";a="117236163"
Received: from usmlb1rnprt03pout.l3harris.com ([10.64.225.9])
  by USMLB1RNPMX04POUT.l3harris.com with ESMTP; 30 May 2022 21:59:20 +0000
X-filenames: 
X-filesizes: None
X-filetypes: 
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,263,1647302400"; 
   d="scan'208";a="77773093"
Received: from ex01dag01azusva.rootforest.com (HELO mail.l3t.com) ([141.199.128.131])
  by USMLB1RNPRT03POUT.l3harris.com with ESMTP; 30 May 2022 21:59:20 +0000
Received: from WIN-P1000842.rootforest.com (10.95.208.6) by
 EX01DAG01AZUSVA.rootforest.com (141.199.128.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 30 May 2022 21:59:19 +0000
Received: from USG02-BN3-obe.outbound.protection.office365.us (23.103.199.147)
 by smtp.l3t.com (10.95.208.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22 via Frontend
 Transport; Mon, 30 May 2022 21:59:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=ZBz0NVDi5Ah7XVq1yuiPQvLe6Y3upCwhZfRLfwUuhrHmGM6GOYWQ4MCSUlDWj8bnsp7B+rdSJ7T+W2yqrvIem4BX7P0S4PTmvS+kBOK+cB/JxRi5tCR9EU2IYGb0ZdNwfBUCrS3PEpf1ffmR4a7wokZicZarO8QDEZSrSc9Su3gVG+i4GZbNnxDZcF+8TouUmJaCXCmfX1V0hPNlq7Emu6Su7GA2xIrwgArgveUmnPkbDi5cZwMkkcPXcYXrPQm37pCb0JYRqjnBzmUHyxKCVbQQdjQvU3/k1gcIVrncbp063hGRKFJIBAw6F0C1/yAJi+rDlGGcFACdbB5MnwAFFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vAw7fLjD9iHn5S4ApDJw/WcXiBCQEtB9yucC0JMkEMo=;
 b=AArj/O5noQ4wW6fzrn2kixlARC7193LLp/8YIH8VZMt7kmMYCkmFlxosY3eH3De6EKEcnVYXQDroVUcoKEtzJ0CCs7ASz95421KBthKcb70eit3o1skviU2gS2z+pvgUvvhnGtpH2i3dxV7+v8RU/fX5v8RpXm0V/k3gqmwKj7Ckcfm//qjAkQVabs1VBpYIy9afDPb8mBvA4ZNaDs4ewN71gEGwj//NLipi5bKD73BWQO/d2T1VMr/oRkqAcgfHR8Lk9Pm+iuQuV45KwIgmoKOoqXjwcWJw2v1S4iV/BuLa4HAAjJT4BvlHX9sLztf9qQKo+P5e/jJv34mRQ+jzbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=l3harris.com; dmarc=pass action=none header.from=l3harris.com;
 dkim=pass header.d=l3harris.com; arc=none
Received: from BN2P110MB1746.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:16a::11)
 by BN2P110MB0995.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:168::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Mon, 30 May
 2022 21:59:17 +0000
Received: from BN2P110MB1746.NAMP110.PROD.OUTLOOK.COM
 ([fe80::390f:4b:78d8:19d5]) by BN2P110MB1746.NAMP110.PROD.OUTLOOK.COM
 ([fe80::390f:4b:78d8:19d5%4]) with mapi id 15.20.5293.015; Mon, 30 May 2022
 21:59:17 +0000
To:     <richard.kerry@atos.net>, <git@vger.kernel.org>
Subject: RE: request for development/build workflow suggestion/fix
Thread-Topic: request for development/build workflow suggestion/fix
Thread-Index: AdhzxrAHCd1doVchRB28GYAVqQ2qtgAPLRbgABs8ZqA=
Date:   Mon, 30 May 2022 21:59:17 +0000
Message-ID: <BN2P110MB174675FF841676169C7F578DC5DD9@BN2P110MB1746.NAMP110.PROD.OUTLOOK.COM>
References: <BN2P110MB17460C18D525E831A63C4376C5DD9@BN2P110MB1746.NAMP110.PROD.OUTLOOK.COM>
 <AS8PR02MB7302BAA142824332D1BE24939CDD9@AS8PR02MB7302.eurprd02.prod.outlook.com>
In-Reply-To: <AS8PR02MB7302BAA142824332D1BE24939CDD9@AS8PR02MB7302.eurprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Enabled=true;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_SetDate=2022-05-30T09:31:36Z;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Method=Standard;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Name=All Employees_2;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_SiteId=33440fc6-b7c7-412c-bb73-0e70b0198d5a;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_ActionId=c7b750ee-7d65-4da9-b321-bce1a1eba6db;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_ContentBits=0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=L3Harris.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 250f1b6a-3e8d-45b7-1814-08da4287a456
x-ms-traffictypediagnostic: BN2P110MB0995:EE_
x-microsoft-antispam-prvs: <BN2P110MB099531BEE53A32FC57DA4402C5DD9@BN2P110MB0995.NAMP110.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gyWAPBMHU/ZSqz2pvjhnasseZg/liP1zpSq80ibfQzTj9FyrjM/jZFfHg/HaKIl6893VDpB6lBvVKI7HCkGCIDklK4aDoVawav81CmjA38QAVtr0OzGKzAEdui7xjGvu19nNl+Nu6XCctm96jP0HXwnBEPb6N9MeRTnsiAQAvN9CpwAZgNirU6uZZo8hcAxTWkR7KwXUgEJL8ccz7WfTAF37dkwKiM8XLUG+rfceVFOLfX1BR881rMDXtHE/sk+3bfklYqmNFH3AlrQ6/BDbQWfDjBlJHzPE300hWGcYFykxdMjbC2Tb6ddShA739mOpn4gqD6+vc4t11/hgVXJJmGz4XLFzCJt6sZQRPCmKB/1QSomgHTcxtSRPLF9+P0qxFKHnz0oqqMu/CR2dU+5Bqkeo7mdnuzC+/8W4w8QQdfYlGHF/AYmA4PVRNi8KNJEvZiHZRdQqVvts6Gj1qLL0lzRhPj9nbP3O+U76N3pbh4om3dDVvDHPvux0k/bMwGwOL6bSbOvaKan7oMXkVPsPjzeheMlaj2LWwuWbjUbym+3uKfhkjTy2fEFnehRoLLYV8rf7HWPwifY7ObeYo4BlYNuHWmv7VT6Y/gB0YOLh4T1kv6bsbigRzoS/uxU1bwmr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN2P110MB1746.NAMP110.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(52536014)(71200400001)(38100700002)(186003)(86362001)(76116006)(66446008)(8676002)(66476007)(64756008)(66946007)(66556008)(110136005)(82960400001)(83380400001)(122000001)(53546011)(55016003)(26005)(9686003)(38070700005)(6506007)(7696005)(33656002)(498600001)(2906002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 1D2sAADwdFunDvl17UE/CsZnMA/dtT01rM8e4EqMoceLmb2/IRQkHcH52+Un+1ZUwWtXVGF6q6JwngX1kVM2Sq2j+AjQShDl6MKjUzoGjn2CqpQtf4jDjAv+wLKbbM6iP5+phw6a8hEfNvM7lc8CuZ4dTkO35kEkaxEeBVwJ6uQxSnetqMngyfGgFXOAj9O0AZbHa3gXCLHFrIHutP1tlKQFnnC2jfZT5KXjtKwo8QWPy43YtfahASI5ObyN/UvFN3D70Bdjy3e3TA7POEYVKJZo37X3D5Zln3b+hWP2geIHG6MD9Hn6bml3CyoM15370YKyArOPahBN4XJTRHBQ8Gu6Un4Ufs7s+ErBrzmx1+27wrx7zS9O0JdVLrlKWk5TIc1uIkiMotQq/Ovx1rJZfGaq0ufJ9PHoYepEZWpeOEc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN2P110MB1746.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 250f1b6a-3e8d-45b7-1814-08da4287a456
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2022 21:59:17.0845
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ba488c5e-f105-4a2b-a8b1-b57b26a44117
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN2P110MB0995
X-OriginatorOrg: L3Harris.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for replying, Richard.

I'll have a think about your suggestion. It's a fairly radical change from what we currently do, but I'll consider it.

Thanks,
	Graham

-----Original Message-----
From: Kerry, Richard <richard.kerry@atos.net> 
Sent: Monday, 30 May 2022 7:32 PM
To: Graham.Menhennitt@c4i.com; git@vger.kernel.org
Subject: [EXTERNAL] RE: request for development/build workflow suggestion/fix

WARNING: Email originated from an EXTERNAL source. Do NOT click links, open attachments or reply unless you recognize sender and know the content is safe.

> -----Original Message-----
> From: Graham.Menhennitt@c4i.com <Graham.Menhennitt@c4i.com>
> Sent: 30 May 2022 02:45
> To: git@vger.kernel.org
> Subject: request for development/build workflow suggestion/fix
>

> Our (simplified) development workflow for fixing a bug or adding
> functionality:
> - clone the repo and create a private branch off the Integration 
> branch
> - fix the bug or develop the functionality (and test)
> - merge the private branch to Integration
> - create a tag to identify the fix
>
> Our build system:
> - clone the repo's Integration branch
> - edit a 'version' file in the repo that contains the current build 
> number and increment that number
> - build the software
> - commit the edited version file
> - create a tag identifying the build number
> - produce a list of changes since the previous build by diffing 
> between the newly created tag and the previous build tag
>
> The problem:
> - if a developer merges to Integration and creates a tag while the 
> build is in progress, his tag gets included in the diffs even though 
> his changes aren't actually included in the build.

> So, my question: can anybody please suggest an improvement to our 
> development or build workflows to fix/avoid the problem? The obvious 
> change of omitting the pulls before pushing from buildClone doesn't 
> work - git won't allow the push.
>
> Many thanks in advance for any suggestions.
>       Graham
>

Don't merge to the integration branch, commit to the development branch (ie the trunk) At the moment when a build is to be started, branch it generating a new integration branch (maybe also tag its start point).  Build from that.
Thus at that point in time it is frozen.  No-one commits to it.

Integration manager creates the integration branch and is then in control of what may be merged to it.  The rest of the team can commit to the development branch and their work will not hit integration without something being done explicitly to put it there.

Maybe,
Richard.


