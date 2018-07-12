Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D068C1F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 20:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732226AbeGLUUh (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 16:20:37 -0400
Received: from mail-cys01nam02on0094.outbound.protection.outlook.com ([104.47.37.94]:48960
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726709AbeGLUUh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 16:20:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zl3c4unGz54IsnFOOp4jbudq8xchi3xqWCOtz0prEvc=;
 b=cxH7r9ZSk8pG/3SnK4W59HoYwAu3599bxCFoMCHF/iefnU75ckGyLA/Fkf234F+6iU4KLETIsUdN4tUQaoSUWA4o5dFT358JqEtiKSr1fANr2BnNLN8g87M56/8UYXraZUw6+DXAiaLFmwfj222QKsdA4dLlQY083PH8266FKdM=
Received: from BL0PR2101MB1012.namprd21.prod.outlook.com (52.132.24.11) by
 BL0PR2101MB1027.namprd21.prod.outlook.com (52.132.20.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.4; Thu, 12 Jul 2018 20:09:28 +0000
Received: from BL0PR2101MB1012.namprd21.prod.outlook.com
 ([fe80::d865:2b6c:e0c8:7724]) by BL0PR2101MB1012.namprd21.prod.outlook.com
 ([fe80::d865:2b6c:e0c8:7724%3]) with mapi id 15.20.0952.017; Thu, 12 Jul 2018
 20:09:29 +0000
From:   Ben Peart <Ben.Peart@microsoft.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "sbeller@google.com" <sbeller@google.com>,
        "johannes.schindelin@gmx.de" <johannes.schindelin@gmx.de>
Subject: RE: [PATCH v3] handle lower case drive letters on Windows
Thread-Topic: [PATCH v3] handle lower case drive letters on Windows
Thread-Index: AQHUGfc8DLm8h3WDaEu2/WTYIc2wTqSL9L23gAACWYCAAAjwZoAABEIw
Date:   Thu, 12 Jul 2018 20:09:28 +0000
Message-ID: <BL0PR2101MB10122C1A2F038B61470A6994F4590@BL0PR2101MB1012.namprd21.prod.outlook.com>
References: <20180711175420.16940-1-benpeart@microsoft.com>
        <20180712154419.18100-1-benpeart@microsoft.com>
        <xmqqr2k8w9n2.fsf@gitster-ct.c.googlers.com>
        <BL0PR2101MB1012EDB64112A8805A2C3D82F4590@BL0PR2101MB1012.namprd21.prod.outlook.com>
 <xmqqmuuww7rq.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqmuuww7rq.fsf@gitster-ct.c.googlers.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=benpeart@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-07-12T20:09:27.3221884Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [70.33.148.227]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1027;7:yF9e57RGueDh81VqmtPeuyFXoLJ3zN5BDkLdJl56+u6zHRCMGdz31sOCfoslM7+PJh8MaUaD8hV/w9Ha0y4Nj7ReFm92uXdlnZQibUkFBh1LYnNLNgZUMz3nbXViZBqI8NqjUfDo9MAxqjNkpPPobgNm3fBWJzQP536+8jWDgv5QAoiUR8qRQl6n9CNPl7vkz0uK7ZY7u66HD4Hj9oVV1TsOhftHhH9+qo2iXkBJXGiRfAN9vcLLBePgfvRJ4/wB
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 3a93faf6-5519-49ce-3370-08d5e8335fc0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7193020);SRVR:BL0PR2101MB1027;
x-ms-traffictypediagnostic: BL0PR2101MB1027:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB1027C6CEED4D8FA00C7CAE8CF4590@BL0PR2101MB1027.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231311)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB1027;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1027;
x-forefront-prvs: 0731AA2DE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(136003)(366004)(376002)(39860400002)(189003)(199004)(26005)(476003)(22452003)(54906003)(33656002)(7736002)(446003)(11346002)(6506007)(97736004)(93886005)(68736007)(99286004)(25786009)(2900100001)(74316002)(72206003)(4326008)(10090500001)(316002)(305945005)(5660300001)(478600001)(6916009)(486006)(105586002)(55016002)(229853002)(5250100002)(81156014)(8676002)(186003)(6436002)(66066001)(3846002)(8990500004)(106356001)(6246003)(8936002)(81166006)(76176011)(2906002)(256004)(102836004)(14454004)(9686003)(86612001)(86362001)(10290500003)(7696005)(6116002)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1027;H:BL0PR2101MB1012.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: HIsqiaEI7zP8uPevIZRw6ydan33ei51Z46rPiqFU2agh9rp7qtpRrIdPZUfKjpfATJOGXsCbHp17WQav5NLYG2wrJPtKgZYh/8REqI/0fRldT8XOIJOcPqP70n+FXRcjWLvABquGZctAiGWwtyoln4P+LOlRfb10NsdBJuGet7/WPx9zRnlHcqQsHeA85MsJFH7ejCfGyub/rbgpbvJIvusxaMbM3EwO4Wl9INI3MR9k17UOirxxme+vNkjp/MxCc77LDrUnx1//zVjV4C/ZTwthMfNqTX0ABEIMDRVUOTSAzdkm+tpEPoEHO5flalaLD91RmQcXfVWlO2VyuvG661/vGUgTTRxI/dP6gVQO/XM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a93faf6-5519-49ce-3370-08d5e8335fc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2018 20:09:28.8950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1027
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > Thanks.  I thought it was strange as well until I realized you only
> > see the error message if there _isn't_ a valid drive letter so seeing
> > the entire path makes sense as it will likely be something like
> "\\server\volume\directory"
>=20
> Yup, that is why I thought Dscho meant to say something like
>=20
> 	"'%s': path without valid drive prefix"
>=20
> in my response ;-)

I'm fine with that - want me to leave it alone, spin a V4 or have you tweak=
 it?
