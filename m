Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59DDC433EF
	for <git@archiver.kernel.org>; Mon, 30 May 2022 09:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234777AbiE3Jct (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 May 2022 05:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233729AbiE3Jcr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 May 2022 05:32:47 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 30 May 2022 02:32:45 PDT
Received: from smarthost2.atos.net (smtppost.atos.net [193.56.114.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A50F25C5A
        for <git@vger.kernel.org>; Mon, 30 May 2022 02:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=atos.net; i=@atos.net; q=dns/txt; s=mail2022;
  t=1653903166; x=1685439166;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=vXssRfEUxDSa4jVaxDGezV0+nPFeRN9Dmc+RZX7p00o=;
  b=jDZBPANrPchAfljhlBuFcGxAg6IYD+X8NdQ5ngZ72JFUgeQDdmsMe4/G
   M9PoxpiBranAOENJYtZgsHO6cveuWV2CrYCpLgPrRontnp5He8m9nBVcr
   t/O5jt9yAtvd+9Py+L6re9VwUhQ0UWE/eDWBrDMosg48kWapvZZyJof9x
   aT/YLgM6dOnga8c/O4N37GhuMB+1Mn6ZLRebHINVH2Mo+ScdZCMfJN//B
   JgSuJ9p6zsIQoSua4LmyOvZmxTTyUuIw41bsJUt8IKlkmHmy/mmpnVfrZ
   mz+ZhLVJJEhC3OIsOTfqFPL0ySfpnQL8ytY3dXvZCsJR3md+BLE7mfiFM
   g==;
X-IronPort-AV: E=Sophos;i="5.91,262,1647298800"; 
   d="scan'208";a="357026037"
X-MGA-submission: =?us-ascii?q?MDFWo2Kl18wGXuhYSrSd5vfrEoU6COzqxR4wvX?=
 =?us-ascii?q?eB2FUkWQaQ9WlKpgiYeXxhL7ayvnpbR7w2rV828cCNVzWvRoWcnjEbTq?=
 =?us-ascii?q?L6dD5rRbT/Vt3RfLC1qZdXn7amC02ugaGG1UxH7D66G3QQFYUahU7SH2?=
 =?us-ascii?q?hF?=
Received: from mail.sis.atos.net (HELO GITEXCPRDMB21.ww931.my-it-solutions.net) ([10.89.29.131])
  by smarthost2.atos.net with ESMTP/TLS/AES256-GCM-SHA384; 30 May 2022 11:31:40 +0200
Received: from GITEXCPRDMB24.ww931.my-it-solutions.net (10.89.29.134) by
 GITEXCPRDMB21.ww931.my-it-solutions.net (10.89.29.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 30 May 2022 11:31:39 +0200
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (172.16.214.170)
 by GITEXCPRDMB24.ww931.my-it-solutions.net (10.89.29.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24 via Frontend Transport; Mon, 30 May 2022 11:31:39 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WEnOuRKmdlf8HrrVHOYBJM2hy9WLrS/qOiZ2gvT8Dg+KsDMl/EryIGDpN0fuA+yHIS5e9KYIuYL1USjDJXxR6Rh3bYwXS34YWXrMpjedeHZke4p06s2wcPobEJmVXQh8vkfMzlFYCjEIESEHSCI89iGaPi36Cx3YtxAvEiu22exfSYbQvYn19tXA9f8B/JWkty97rrP/dh2l8A+bIwbR9lyqmkDmcAquxG933fzilpnOzSYDD3Y1AZySBTJmo3oV1Pt6lKlQM6fXU1okQm8fDwAp9Gh5vQUet6ZxtTLdvSsC5m97gMMj8LgbH89dnG0nXVaPIhRNeIXB59lQ+++6pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vXssRfEUxDSa4jVaxDGezV0+nPFeRN9Dmc+RZX7p00o=;
 b=JoIcVI29Abephncn+3f7LCDIw5o24YnnLKfTxQSNHKX+eFfWnuPBmuwx9ojc7mR6ved8viODwsq/of103wTEbJawG8EVg4g7ct1GDRSn4TE1zHUiQbK6PYiOq4ipWvRsEabyLp8WXl2B08MpYGex3TVpyDQOXl7M6PMTSS0NOyf/0jMpiomQ0pcHXVuyod38dyUhFsENyt0iVYIUKVxC42cqb03dGcA7U8FZ9Zqu/6Q7BeUHCSkyoddNGg9CODgbg1vIMhWuf3lfN03a1a4bi7QRIDoAKHR/2PYomIUdnHbFzejcVq7NXQlrPlXozPJdnKZhxVCHis65Czs7TqkApg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atos.net; dmarc=pass action=none header.from=atos.net;
 dkim=pass header.d=atos.net; arc=none
Received: from AS8PR02MB7302.eurprd02.prod.outlook.com (2603:10a6:20b:3f8::19)
 by DB7PR02MB4043.eurprd02.prod.outlook.com (2603:10a6:10:43::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.16; Mon, 30 May
 2022 09:31:38 +0000
Received: from AS8PR02MB7302.eurprd02.prod.outlook.com
 ([fe80::75d2:ba70:2c4c:4aff]) by AS8PR02MB7302.eurprd02.prod.outlook.com
 ([fe80::75d2:ba70:2c4c:4aff%7]) with mapi id 15.20.5293.019; Mon, 30 May 2022
 09:31:38 +0000
From:   "Kerry, Richard" <richard.kerry@atos.net>
To:     "Graham.Menhennitt@c4i.com" <Graham.Menhennitt@c4i.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: request for development/build workflow suggestion/fix
Thread-Topic: request for development/build workflow suggestion/fix
Thread-Index: AdhzxrAHCd1doVchRB28GYAVqQ2qtgAPLRbg
Date:   Mon, 30 May 2022 09:31:37 +0000
Message-ID: <AS8PR02MB7302BAA142824332D1BE24939CDD9@AS8PR02MB7302.eurprd02.prod.outlook.com>
References: <BN2P110MB17460C18D525E831A63C4376C5DD9@BN2P110MB1746.NAMP110.PROD.OUTLOOK.COM>
In-Reply-To: <BN2P110MB17460C18D525E831A63C4376C5DD9@BN2P110MB1746.NAMP110.PROD.OUTLOOK.COM>
Accept-Language: en-GB, en-US
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
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 37502e6b-1fe2-4d39-334e-08da421f322a
x-ms-traffictypediagnostic: DB7PR02MB4043:EE_
x-microsoft-antispam-prvs: <DB7PR02MB4043AC5C2AF96DC9EA0296BD9CDD9@DB7PR02MB4043.eurprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q3IqeBdNOYNk7Q8zxUTk7O9nnueYk1El/E29IWvxHz2atiQDNVlblxWDqvA2EJEOHuiu12/B17uQUYqNLXDdR5iYzfeq6NW5/dtyvq3RdOUr11b02atGXf36esiCces6AAXgeMNgYigqYN6+lyPgMxH/NA1ECv2IKIhDGlDGS8wt6R9MWErPlsWDpsg5wrByZtT+ZX3IWAFMRS3Vs5GigeLXcNf/XVUVUw5fP6Dznk8z1pf0HkSCswHCXeP1KWl1T1aKazCaHFLIJxKm5VnrOVITq30C4qmfWXJtKQ+2NZXHi3a/CQ5A/GtFyGSQK+2T581rd9q8FeVHYak9W0RzLFLNNhpGdOhIG7tH4JlX/CBHko9bYz0hfKPrcP6SOK8aQBUqEPmFisbh6VKLlRUzMGvsqPCNxkbAsjnvTzPTA8uZCkUX0P8j2eIEkf0rK4I3RIdtomdnmD/R6tn0I4bLgNN5Ekm8jEG5JqtSDVoR1yPTBaVZAui8e8yUguWq3F/pFNZsiXsVbHSOIQPhWbjy+ywcjBJo5HHp0xS7JrCk1qV5x48oa5BEEzBjcADdSFAN1/Z/zstQS97Ac0618hPsH0VJZc79A/XkiCuJJbo8Z9lPWfmZci6M9KDLxDKeBM+7pv51wJq+iv/QRFnyPHKE4hwSldjZO5bm+kWOMrpN0zB6onnkJtUboNIJNogmr6q1HjtN3BR2SrHK8/pWefLObQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB7302.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(38100700002)(71200400001)(316002)(33656002)(110136005)(55016003)(38070700005)(186003)(2906002)(82960400001)(76116006)(66946007)(8676002)(66556008)(66476007)(66446008)(64756008)(86362001)(5660300002)(8936002)(122000001)(52536014)(83380400001)(6506007)(26005)(53546011)(9686003)(55236004)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LggcxQPt5gEM7i7b8SJiZ0cQ4ys0lAVFhxXC7GEkKEHGsRwDrUltWP/WHht5?=
 =?us-ascii?Q?Ar90hZga+ac+dqtMeU80PBUfBVQjv05cQKUxo12QGscI5kmYUBiZMmdQJTXD?=
 =?us-ascii?Q?1N7gCipq0PTFRydup0sQv0mnhTnkKPOOYBYwpe/vfYVhAk72659o2ec4jOAB?=
 =?us-ascii?Q?em9vCFe8XtQbSev4CWBAW7xiemlPGEFsE3a53yEwST6IZHzD+nM8bQnnX35f?=
 =?us-ascii?Q?1BIAT1tme0KWnLFYLLmYyX2PdVOgqFlApcfEWaq543xVnz5lq6YDyAq0WGVO?=
 =?us-ascii?Q?yRiF8aEuA7Zb9fYU9SOaFcUwDyXdR/hIZnjPMfu/iJRtQeI9eOL9rhueXXwT?=
 =?us-ascii?Q?4ji2OUi8tPTMzem6ecc/iWURrBUvHMM6AUUO28sRaz6I9gSxu1oqIsBsHDLX?=
 =?us-ascii?Q?d32YW22d6cPDzK7ike7yes+2FS4Tqy9WjJoWCoLxiIdmN4jmc/9OZpfzGQZz?=
 =?us-ascii?Q?0Efx1/KMAs+LWnPP0Iiv/mktG5CjvuiG3CNXLUurT37FphoU4ErRtsKV2FCJ?=
 =?us-ascii?Q?7QnKhem8gNfbbU80eGZdw5zrQSFHPxp8h4r0kfejqdQD6B25Y6K1HZFl1Dds?=
 =?us-ascii?Q?tmXr2xIcoDU/7bOBosSDDsP5Ow7y8YxlUDW75axAMX+SByOJ9jiwivuPsXVv?=
 =?us-ascii?Q?20G0MyU+uUHF+fY7ZKmUtWBZuNFZwYIT4/vvN/l35MRgenlAicscDJseQlWV?=
 =?us-ascii?Q?7POVx9jxVTyGg3ImFciYFsVM7XBw3/Xkc66SNcdWRDrdDmipfLjqmTkb03Nt?=
 =?us-ascii?Q?5HL5MksmvSp8sFrYjAwADbQHC18xzeRwXjmL/CU++CQanaJygMFZpTMcmC3z?=
 =?us-ascii?Q?UvRVds0rPmGodEdn+BLKARdpoM8i9ni4y+z1GTOftHgqYEWJ9t68LrRRVyV7?=
 =?us-ascii?Q?+TDrWZsghCcxDWt43F1192aUmJinOfqXOegc8RztDYc62vCr7dJqdqOm1aB8?=
 =?us-ascii?Q?UEEp53PsjUBBbZjsR34li9FBJAvL/qdwn5hRsOKkCt1yMNzWU3NWyYrt1Ksr?=
 =?us-ascii?Q?pWXVovIfGSKNFKlkMK0U6cQVSUjp6OMhEOeBfcPMSycH1Z6CT1LHurXkZR1i?=
 =?us-ascii?Q?dExSZERj/eONZU1lXtk0tIW8QyWZJ+7fwBHdy5KOO/IAtPJzz6NcnXg6IQVL?=
 =?us-ascii?Q?CAOsGq/7rbCdp+BT0lC345kEvVg39+1qhyFnpsJ6uuyBEHA60SfkfdhmmvvK?=
 =?us-ascii?Q?sUhHWCKHKi0f6Oh+fEESdGa65G5Fjvs1/XZEuk7BKy79clQQpdclnsOYw8jl?=
 =?us-ascii?Q?xQcbpRL/W5xjK+UTSeU8C+csvgHOlZaek3sB9s+ScqX+ZZ5f0COD/cLJD4Wo?=
 =?us-ascii?Q?8qBtsjzL9+HqwF4jZuvgJnudVkZ8hOx8CLZsK5MzrEpoZyzmQICnQfrLl0QY?=
 =?us-ascii?Q?s2u5KwjPEHnrgOrnUOAvCqZAr7eaDFEnpSbMupmIWpZyJPLpPldJasREkmHZ?=
 =?us-ascii?Q?KSl0HKZ/G0xtAhfu/trKLZ7eh6THZv0xtTMrsKYkjZANLTmMv4azc5Lh9p4f?=
 =?us-ascii?Q?vBsJ+uSQn9hcEckX4xiNthz+3Vhd9sjZTu/pV4GzeDdbSfBftJj7L4HH+Soe?=
 =?us-ascii?Q?Qh4hq7eTL2LGws0IdwopbuvtV6iWcThMBuMua4QpbxKp+Ed7DRMG3Hr1figO?=
 =?us-ascii?Q?weKlc7lFRjNI9ds5IUb+pL7oUJ0Hd8Oloj5ewIQxVpjcnvIiBK9CIuV61Z2q?=
 =?us-ascii?Q?KxL8yt7wazSYsLrQJM7dYAH6iLV9KDAWMXFRIL/GJwZskhA84/Es9V1qMMZ0?=
 =?us-ascii?Q?blgkfhqT3A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7302.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37502e6b-1fe2-4d39-334e-08da421f322a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2022 09:31:37.9236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 33440fc6-b7c7-412c-bb73-0e70b0198d5a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sv9VU3HNQjYNrKwhZPNlPJB8yps2cQfuwFiwzo+GnMaYb6O6tMK4tNnOeM+/HR9x4WdwsWJ8S7/pFKMZpmYBqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB4043
X-OriginatorOrg: atos.net
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -----Original Message-----
> From: Graham.Menhennitt@c4i.com <Graham.Menhennitt@c4i.com>
> Sent: 30 May 2022 02:45
> To: git@vger.kernel.org
> Subject: request for development/build workflow suggestion/fix
>=20

> Our (simplified) development workflow for fixing a bug or adding
> functionality:
> - clone the repo and create a private branch off the Integration branch
> - fix the bug or develop the functionality (and test)
> - merge the private branch to Integration
> - create a tag to identify the fix
>=20
> Our build system:
> - clone the repo's Integration branch
> - edit a 'version' file in the repo that contains the current build numbe=
r and
> increment that number
> - build the software
> - commit the edited version file
> - create a tag identifying the build number
> - produce a list of changes since the previous build by diffing between t=
he
> newly created tag and the previous build tag
>=20
> The problem:
> - if a developer merges to Integration and creates a tag while the build =
is in
> progress, his tag gets included in the diffs even though his changes aren=
't
> actually included in the build.
=20
> So, my question: can anybody please suggest an improvement to our
> development or build workflows to fix/avoid the problem? The obvious
> change of omitting the pulls before pushing from buildClone doesn't work =
-
> git won't allow the push.
>=20
> Many thanks in advance for any suggestions.
> 	Graham
>=20

Don't merge to the integration branch, commit to the development branch (ie=
 the trunk)
At the moment when a build is to be started, branch it generating a new int=
egration branch (maybe also tag its start point).  Build from that.
Thus at that point in time it is frozen.  No-one commits to it.

Integration manager creates the integration branch and is then in control o=
f what may be merged to it.  The rest of the team can commit to the develop=
ment branch and their work will not hit integration without something being=
 done explicitly to put it there.

Maybe,
Richard.


