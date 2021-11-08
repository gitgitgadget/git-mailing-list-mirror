Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA2BC433EF
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 16:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60CEB6120A
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 16:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240150AbhKHQu0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Nov 2021 11:50:26 -0500
Received: from smtppost.atos.net ([193.56.114.176]:4225 "EHLO
        smarthost3.atos.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235325AbhKHQuZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Nov 2021 11:50:25 -0500
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Nov 2021 11:50:25 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=atos.net; i=@atos.net; q=dns/txt; s=mail;
  t=1636390061; x=1667926061;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jwRNYZWywvQlhD/G+6oZJvf0fLlocfZqV2gcxSezjCM=;
  b=SmUh8RSZQglNDSJF/936vEY8LkgDIw4ELCN5tRY0t0+UJE1tUCZYsIkF
   qsgnhlQc5TRSf912IcGubVX04Yy2xKPlpTkOcAM/khyqI/To4hfaBqUA2
   vpIwWZE1GqU7asZwmnSXG4ZjGSBAUeOLdJJGx9isuG4L8TPN2F5sQGhBD
   4=;
X-IronPort-AV: E=Sophos;i="5.87,218,1631570400"; 
   d="scan'208";a="280457820"
X-MGA-submission: =?us-ascii?q?MDHz0zYDd4v9WoUJ1a7RbKKd3YJyvJMeH0dMnM?=
 =?us-ascii?q?x2lgxKS3cQ0Ul91onsr3H3asdkiRgJoEY377TYsLIkvz3SDtrFo+3gYB?=
 =?us-ascii?q?ToB+cUG+UWaElA+r/DDjzfJR9C4IjkBki0giWY9clKtWJ1i6YxCQcE9+?=
 =?us-ascii?q?9R?=
Received: from mail.sis.atos.net (HELO GITEXCPRDMB11.ww931.my-it-solutions.net) ([10.89.28.141])
  by smarthost3.atos.net with ESMTP/TLS/AES256-GCM-SHA384; 08 Nov 2021 17:40:30 +0100
Received: from GITEXCPRDMB14.ww931.my-it-solutions.net (10.89.28.144) by
 GITEXCPRDMB11.ww931.my-it-solutions.net (10.89.28.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Mon, 8 Nov 2021 17:40:30 +0100
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (172.16.214.170)
 by GITEXCPRDMB14.ww931.my-it-solutions.net (10.89.28.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15 via Frontend Transport; Mon, 8 Nov 2021 17:40:30 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Futf6HkeaHGmC7y/sjvgG7tRhByxq6FJ7e4oiTdFGomLagcaUkA8Mm7yKeeEmMSTBedLdb3JRlLgCc2tX0YKu0LJwGGy2nENzP3qny15JmEbHUXDIZjMR9cTvleabG3xqm7UxddWhA11uzPQK6wv9nzzqLvlOaXR9QVP1Lw5871OdiBYAZOc1swTFxIa4STRbPkWNZKaX6Eic4zZDvbgQEq11Yg0Pvar2IWguh1kPYo81OMm8SkJJsTtKqzfV1zUmZ2ZCBDj2GOKYHQKuTbWu4lLiuhAp/MoI9Zx7fhGFCL2IgkPynRr4SL/g5AOKk2U9/r7N7ar2AeatiIgKNAi7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jwRNYZWywvQlhD/G+6oZJvf0fLlocfZqV2gcxSezjCM=;
 b=LdeDXpgPyU69iTP93JqToVSHh3L5KoPizJzQaIEe8FxqzwHNmKIdQBzg4Wh24Pd0eFcjV9J9cahvBlfoVSNrKHcUmVI14aMKwF4ld+AuEwFt2qtRRIbIZqsZYacPR7CwecgU/tusYzY2aLL1+vECaU5y6XQNhlKqd/pPd1jHrWZpDnuUxewSwOXhGrX0oroIzj2DU/LJCW04qpbkmTH0zwwBIgKG9GxZoWT9lDaTwgsnTJqiN9HSHJRXXpZLBC9YPIzOgvs6wdnDTaN+kEW3HFbVEpAdzXWAbmvcyXy4d5nhxZMpFknxJyty4zWNl5YJvfkDt7CGaw73hEWT+ePGrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atos.net; dmarc=pass action=none header.from=atos.net;
 dkim=pass header.d=atos.net; arc=none
Received: from AS8PR02MB7302.eurprd02.prod.outlook.com (2603:10a6:20b:3f8::19)
 by AM7PR02MB6052.eurprd02.prod.outlook.com (2603:10a6:20b:1a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Mon, 8 Nov
 2021 16:40:30 +0000
Received: from AS8PR02MB7302.eurprd02.prod.outlook.com
 ([fe80::71a4:9afa:1133:bc63]) by AS8PR02MB7302.eurprd02.prod.outlook.com
 ([fe80::71a4:9afa:1133:bc63%3]) with mapi id 15.20.4649.019; Mon, 8 Nov 2021
 16:40:29 +0000
From:   "Kerry, Richard" <richard.kerry@atos.net>
To:     Junio C Hamano <gitster@pobox.com>,
        Adam Dinwoodie <adam@dinwoodie.org>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Fabian Stelzer <fs@gigacodes.de>
Subject: RE: [PATCH v2] t/lib-git.sh: fix ACL-related permissions failure
Thread-Topic: [PATCH v2] t/lib-git.sh: fix ACL-related permissions failure
Thread-Index: AQHX0nvORR0vjem5O02kOU0OiGV1bav1bGlCgAQGCmA=
Date:   Mon, 8 Nov 2021 16:40:29 +0000
Message-ID: <AS8PR02MB730266C2B87493F2AF712D989C919@AS8PR02MB7302.eurprd02.prod.outlook.com>
References: <20211104192533.2520-1-adam@dinwoodie.org>
        <20211105193106.3195-1-adam@dinwoodie.org>
 <xmqqk0hmwc0c.fsf@gitster.g>
In-Reply-To: <xmqqk0hmwc0c.fsf@gitster.g>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Enabled=true;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_SetDate=2021-11-08T16:40:27Z;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Method=Standard;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Name=All Employees_2;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_SiteId=33440fc6-b7c7-412c-bb73-0e70b0198d5a;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_ActionId=cab8ee52-9289-4bf7-9698-0af5cd3c90e7;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_ContentBits=0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atos.net;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0533f043-b3ee-4e9f-5a5e-08d9a2d679cc
x-ms-traffictypediagnostic: AM7PR02MB6052:
x-microsoft-antispam-prvs: <AM7PR02MB60528C182CB3CE31FB1DFBDA9C919@AM7PR02MB6052.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dl5ZLShfgvUqfERcoTrjULou3fgCZyvB5GcxxI2DVyUqvpVbkmAipDbvTSoU/rPN+ETd63RmfTINyrP4CKZbteu4H4/6Xlzr93LpGXb+O1gh9wpVJ8WhCdmXglOlMAoy8FkaauDOMOsI1eexnr+L5FGFkXJIVzGSzS03VsTeBQmnlhxJLS//W4M6CERugiSfCs4V8HBIx66SzxPYZkpbtAjknQPy34cfBwKlSCTmhvyi3AS8FYCxQiJvJhhtw8reHd7oW0KrQ9N/NEgzLmhDjgMUhESXcQjtHKe9huaSB0UgEtdcMM08CWxpia88vf4hIgrSnvA+E8wf/j59oPuoI+PpRfGtg2sNVjeZ/rnIAhFwOJN/wsJfpJr6j/RYu4kycU3lpilY2R/6kFBh7KJOO65FRYhRu5/o7FCywqGpSiXtpI//5c+Em1UTt+ymeuZj31qSDbI6rQFV/3nd8U6usGE/L5M3GOlUEz1HuQEowqD54hNaVDyfcokRb6dSBxCMRnXlCwj64tE4EouNLEMijW+//Pou2RyefqTpoNKYpIEfRDiGJHJxLF/wfWu2DqspJ+u7PO7xNe2CJcqO4BrM6J+OY4BXlbpO3XQ9smx6IJ123Q9wDa3Iep6Sf2xDvv9l6/qjF6Lrrki8fQ/HZxNM4eJWmyZgonP/MuFk1mxYXZ4qxjUNz4jNCqjg9l1AzGeVUSZustUATuJhYJcZvxHWKQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB7302.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(2906002)(71200400001)(5660300002)(52536014)(38100700002)(316002)(26005)(55236004)(186003)(4326008)(7696005)(8936002)(8676002)(86362001)(82960400001)(122000001)(33656002)(64756008)(66476007)(55016002)(4744005)(66446008)(66556008)(110136005)(38070700005)(76116006)(54906003)(9686003)(66946007)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dbhdASiSXo7EccmppiLOTNZO1/l+u0CiOa/aCLlJDDJ3JBLAyTEXbvdJ6ABT?=
 =?us-ascii?Q?NMotTCtc+bF2Z/TEe6H0s/XZGls5gtAz88QTCpIDIo29M3Fsw6Ja9AH1OGZm?=
 =?us-ascii?Q?l7yoMxXUZ2wlfFxeuDL+QsHnWIVQBUCxLese/wOnrcHwl87S8Eh3gk/HF0mn?=
 =?us-ascii?Q?mk0PEy6hFNN7a5Odx44lUMG0SksHLt6sjvDdEP4ewmPwTuPOr2boIK+F23dd?=
 =?us-ascii?Q?GyBFD6G4Yobq1KGuw2a4oneMFTAAlVy4CXNPtyJdPqBPvUwuXXpzLPKwTFUi?=
 =?us-ascii?Q?mVpR2mSbFPNIMrBzBVlX7TLjnue4sx0BZBR2OE50qXP57zuZ3PghQrsp+Aad?=
 =?us-ascii?Q?Fdx/O01gwC01AogdnNXhqSHCqRkf1JPVb0rKXjGJr8b18pvrMf1vUr3czNaU?=
 =?us-ascii?Q?7D+D1e1xuSssR6sigXrdqQn3uSlSQdFTGHY7Kl3+EW8dJQr/VEyORO6NcpLF?=
 =?us-ascii?Q?jwOCjDSs4D+sf6QTGm9vviNibbTUDtjSDrz0wWzDRPGyY+L6fRlhWfhagyT9?=
 =?us-ascii?Q?4YEWIQ/9nqZrGLTW0nigxE+yW1AHz+zRmj5a6sHttqEeoa5mf5lcMr/Fkpcn?=
 =?us-ascii?Q?umL3+I4ZpRVIcBBkzuQLv5o+qokmumw/mIOHxpSe9n2e2UhtRaPBEftzgZkC?=
 =?us-ascii?Q?LEGtBbecO4XBkYLmH3qMIZV2s26CM0xwy8N+gG8NkucikKn83R5xl/X9Yv9A?=
 =?us-ascii?Q?eDj75S7t5M01hEwbNxjG/HIw0KpFLpXUJ3yfzHjRwGk8JjvqJksX8A9/YCdl?=
 =?us-ascii?Q?ZMzruAuLtR/XA8vicMNilkPGXb/Y4eq2c8tGnGuWJG8JrdG5UB5yuY/5ognP?=
 =?us-ascii?Q?SVrdlrVosLxhdHvZ9dNLd+e+reGr+7VY0qg/OPwvoJSqdvVn+f3/bKu9x8jD?=
 =?us-ascii?Q?g8NIryE/YoG2r3hWFT5lQ9YbcXT/LctaRHRydUjivf8IspBGK+4s3gp9MyVT?=
 =?us-ascii?Q?Hls0Q9vbHhEc5FthHq05vJNxy71jg1HRG9YJbKJ6RDUBXGn1Sk/Mzyjjliw1?=
 =?us-ascii?Q?KYZlWfXzff0P3PKip7pNaVS1EmA/alCEpyHhwEz3HfGEiSQY4Aa/X3kYIvH1?=
 =?us-ascii?Q?HMDom/9yVaA6AfAJ069DUCrrN9qMv7oIWJvpfX3FovaIU6ClWEFNKE0/KwAj?=
 =?us-ascii?Q?ArBZOigf2HipeBFsUffiUFcublHZ1WPPAnutHVw4egPSdkhYp2IXU1EP/aSh?=
 =?us-ascii?Q?kEHRli0U+t3c0cjCXIJYlvJ3eI0xZvN2tdEzJ90KZVIisjQr4qcoERq8W5Y7?=
 =?us-ascii?Q?c07kwUooziGbSDoNAMTloqsg9hRoFiahLFwuE39DMFcJZiBOiw5D1B1HizS6?=
 =?us-ascii?Q?i9BPR6299pf8JzUlDDPNUy9bAC1JJSQ8kV6lM6aTRCksP6zeH9B9gkqdAjV4?=
 =?us-ascii?Q?uQIqHLAY4kB/wvzKrVXl/JzSGqWE0VPiUJsbvhri85Ql8MXsbbO/ONPcsfBK?=
 =?us-ascii?Q?YbSayDsZTseqvlQN7KuMIFb194JqKsuGZj8GryT9scKPWC0tcc8yvBdYB0ID?=
 =?us-ascii?Q?AW+8SjIa/XTk2sNmjqFoRdh22wRWsGo9+Mz1hTJOh+0x6j4rdjp2r/gj8f9p?=
 =?us-ascii?Q?XM56KMxrIHRNDrniy7EhoX+zIaxBf2i3BZnHfOHyfEG4UPNC9pPSx7oifj62?=
 =?us-ascii?Q?KQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7302.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0533f043-b3ee-4e9f-5a5e-08d9a2d679cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2021 16:40:29.8527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 33440fc6-b7c7-412c-bb73-0e70b0198d5a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oRH2H2yWODkaUfVvxGfFSqJ5lZ6NggL/EWKdsGQZnaWcvjSM+JUXHJ0BtFt3iDMH1qyVAgVWhjTsgsxdG6awOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR02MB6052
X-OriginatorOrg: atos.net
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>=20
> > To avoid this happening, before creating the keys, clear any default
> > ACL
>=20
> "happening" -> "from happening"
>=20

No, original is correct.

To avoid this happening.
To keep this from happening.
To prevent this happening.=20
To prevent this from happening.=20

Would I think all be correct.
"to avoid from" is not right.

Regards,
Richard,

