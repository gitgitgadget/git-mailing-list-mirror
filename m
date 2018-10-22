Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCA0B1F453
	for <e@80x24.org>; Mon, 22 Oct 2018 22:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbeJWG2K (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 02:28:10 -0400
Received: from mail-by2nam01on0121.outbound.protection.outlook.com ([104.47.34.121]:10764
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726286AbeJWG2K (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 02:28:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qOaG586SYFqzcB2AJeiY0OT7LSKwfhRIoASbvd9drNY=;
 b=WB8Qf/nHvAC/3oatPV+BYgVhvVpWAq5hHj2QK4kRbypO6H91v3Nh+jnpH7jajp5eHZw7HgM2kkCvpcwU+cMEMZOoz5v7nZket6EmQJ1oFinadNwIz3nyNWalzJOMo8YEiNSLxzUaJaKv4eMVomLhru5IId/OwfGLl/zX8R8O5s8=
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com (52.132.146.19) by
 MW2PR2101MB1098.namprd21.prod.outlook.com (52.132.149.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.4; Mon, 22 Oct 2018 22:07:45 +0000
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::6438:244a:94bd:353e]) by MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::6438:244a:94bd:353e%3]) with mapi id 15.20.1294.001; Mon, 22 Oct 2018
 22:07:45 +0000
From:   Ben Peart <Ben.Peart@microsoft.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Peart <peartben@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "peff@peff.net" <peff@peff.net>,
        "sunshine@sunshineco.com" <sunshine@sunshineco.com>
Subject: RE: [PATCH v3 1/3] reset: don't compute unstaged changes after reset
 when --quiet
Thread-Topic: [PATCH v3 1/3] reset: don't compute unstaged changes after reset
 when --quiet
Thread-Index: AQHUagnA+gLbYbdyYkq29jXvxRHQaaUrvBEAgAAXBLA=
Date:   Mon, 22 Oct 2018 22:07:45 +0000
Message-ID: <MW2PR2101MB0970EF1065717A38CF581C64F4F40@MW2PR2101MB0970.namprd21.prod.outlook.com>
References: <20181017164021.15204-1-peartben@gmail.com>
 <20181022131828.21348-1-peartben@gmail.com>
 <20181022131828.21348-2-peartben@gmail.com>
 <nycvar.QRO.7.76.6.1810222244150.4546@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1810222244150.4546@tvgsbejvaqbjf.bet>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=benpeart@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-10-22T22:07:43.8213520Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [70.33.148.227]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1098;6:LLefiROnzZ4gNej9IqVECcRgA3U3IdtEiEz/iwyx+b/HlgDKPDEkzvbJNFKXdntToTSSLHUR1uUbpc1ViKOQhVsNkMTShCLEsRiydcOFIYUpiqCywVXKUog5v5H79coMn5UVtCCP46IBAZ9qN06PvB1qoqSAEMf6KmZq39LEs3j5xe6pEdjkBOQPHYN1vMj5oc3ESPdsWWPQm+b1F3MtNq1XSANSZYThL3bHQClpJz+ikmkxxQ6vga1cb/RQPRB/R6RpXRNbrNkGubY75Jc0lia8WIOdZX//HoxB4WLXnE/LsK83Lj9lS7J2V8MAnzOaQ+SNV4j+sYN59TfXnCgJgx5Ijitm6lDQbYaQdhVSRT4Ij8pAM4/ViTSvZbVyisx7IXP1lsM5XZdNuK7iwGXVX9rh6KrrPJNn431lSX2/Ga1rvMNlc95DD7v2W+1vUvaTIiNh+xzxVMg7142WmK47vw==;5:N85DFkRtgHlE2JgfpUpE5VRG/JuGAjFENXtmXtd4nDNGczpRnx0GtheyFmCZxuFmvkHu3p4wPsBcyku3yto1A2Pi9a1dzQuLI7Wd9Oql8wmWoxHPhx7T7yBcsT0HMUHoimBVHGNFoxTMJu8wN1G6nzxYBNE9Yb4ICCif3uv1n3I=;7:Hq4DGcXWfdrC116UO+RZ+3Uk7bgQolKkIalYFyzWr/mlN3xrCJs+bWTXqRliblzc2qeSIHl2SCPYfS01SsdOh8EU1juOs9V2M679rBmydwmrCKByTjltxR56+hA4M2ryhqLegHTSywZK5ucO1LMK/Q==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: aff95670-3ac6-48af-59b5-08d6386acbd2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:MW2PR2101MB1098;
x-ms-traffictypediagnostic: MW2PR2101MB1098:
x-microsoft-antispam-prvs: <MW2PR2101MB1098ED7B55FE0CCCEC3EDD05F4F40@MW2PR2101MB1098.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(100324003535756)(26323138287068)(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(8220027)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:MW2PR2101MB1098;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1098;
x-forefront-prvs: 08331F819E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(366004)(396003)(376002)(346002)(13464003)(189003)(199004)(39060400002)(4326008)(66066001)(33656002)(478600001)(99286004)(102836004)(76176011)(9686003)(26005)(2900100001)(6436002)(7696005)(55016002)(6346003)(6246003)(25786009)(10290500003)(7736002)(71190400001)(305945005)(71200400001)(53936002)(256004)(53546011)(74316002)(14454004)(10090500001)(72206003)(186003)(8990500004)(106356001)(6506007)(2906002)(54906003)(105586002)(110136005)(93886005)(68736007)(316002)(3846002)(22452003)(6116002)(486006)(97736004)(8676002)(81166006)(11346002)(476003)(8936002)(81156014)(229853002)(86362001)(5250100002)(5660300001)(446003)(86612001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1098;H:MW2PR2101MB0970.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-message-info: ImCzdcZClfswaP6/QjxX6eImwZRxo4Md/UpH0NqErhWEsnTxBkNyZ73fWAo4Urx1jC2rpMyGL1YC3VCllk4uXO7zAmSpql/5Yqtjw57a/XTyzZvvjSteHLrGNtfqmUx9Ka0YQxG2N3p58EFPCg3Z3jEz4KgnCroeE3fB4byxv64XppApql6AoQ41qlF8MC8dTsoplv7qznjNL3tIX1zOaLWUVvSI6P0Qk7X4yd0lIKiLCR3FVmDQZumYt9NwT3DzZ+oFedGgMg12f2k3vgjDScF0smKcOxvoZ+QFws6yVziwMafpH6EbDTRR29T2O5Poo7XekeBuJhjF1mYSRjaB5lmcDnJ4TBN8kXRkzrngIqU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aff95670-3ac6-48af-59b5-08d6386acbd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2018 22:07:45.5712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1098
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -----Original Message-----
> From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Sent: Monday, October 22, 2018 4:45 PM
> To: Ben Peart <peartben@gmail.com>
> Cc: git@vger.kernel.org; gitster@pobox.com; Ben Peart
> <Ben.Peart@microsoft.com>; peff@peff.net; sunshine@sunshineco.com
> Subject: Re: [PATCH v3 1/3] reset: don't compute unstaged changes after
> reset when --quiet
>=20
> Hi Ben,
>=20
> On Mon, 22 Oct 2018, Ben Peart wrote:
>=20
> > From: Ben Peart <benpeart@microsoft.com>
> >
> > When git reset is run with the --quiet flag, don't bother finding any
> > additional unstaged changes as they won't be output anyway.  This speed=
s
> up
> > the git reset command by avoiding having to lstat() every file looking =
for
> > changes that aren't going to be reported anyway.
> >
> > The savings can be significant.  In a repo with 200K files "git reset"
> > drops from 7.16 seconds to 0.32 seconds for a savings of 96%.
>=20
> That's very nice!
>=20
> Those numbers, just out of curiosity, are they on Windows? Or on Linux?
>=20

It's safe to assume all my numbers are on Windows. :-)

> Ciao,
> Dscho


