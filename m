Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC0BE1F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 21:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388780AbeGKVgd (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 17:36:33 -0400
Received: from mail-sn1nam02on0139.outbound.protection.outlook.com ([104.47.36.139]:8416
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733028AbeGKVgd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 17:36:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGk0Giet40ixv/cb/G7nEFV/iBIq39iW3XoeNVUgCOQ=;
 b=GWg/mxwGR3mzRpa1ixEmXo3KjpsZqTOlx2nzupWF9H7tw0O+3FeN4ugBm8OPO+J1USYOGM/D1sMkPJxOWXeKyX2WQQ+XoUx/mU0YScqYuM937IFBbZUsPxwlbL3fxVdtCC4zNNGTC+YaOtNz+GyWjZEtplaik98YShO7IxmH9k0=
Received: from BL0PR2101MB1012.namprd21.prod.outlook.com (52.132.24.11) by
 BL0PR2101MB0962.namprd21.prod.outlook.com (52.132.20.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.4; Wed, 11 Jul 2018 21:30:13 +0000
Received: from BL0PR2101MB1012.namprd21.prod.outlook.com
 ([fe80::d865:2b6c:e0c8:7724]) by BL0PR2101MB1012.namprd21.prod.outlook.com
 ([fe80::d865:2b6c:e0c8:7724%3]) with mapi id 15.20.0952.017; Wed, 11 Jul 2018
 21:30:13 +0000
From:   Ben Peart <Ben.Peart@microsoft.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Subject: RE: [PATCH v1] handle lower case drive letters on Windows
Thread-Topic: [PATCH v1] handle lower case drive letters on Windows
Thread-Index: AQHUGUA9WUpXPhD60kqwA1StNOsHQqSKT0oAgAAROHCAABOXxoAAEsaA
Date:   Wed, 11 Jul 2018 21:30:13 +0000
Message-ID: <BL0PR2101MB101209F234BC164073DC650FF45A0@BL0PR2101MB1012.namprd21.prod.outlook.com>
References: <20180711175420.16940-1-benpeart@microsoft.com>
        <CAGZ79ka=HfzKprETBJ=+sdQsUZPXgHsgoqNWkbHprUGgLMggUA@mail.gmail.com>
        <BL0PR2101MB1012D2CC0BEA20AB35CBE967F45A0@BL0PR2101MB1012.namprd21.prod.outlook.com>
 <xmqq36wp3549.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq36wp3549.fsf@gitster-ct.c.googlers.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=benpeart@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-07-11T21:30:12.1142062Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [70.33.148.227]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0962;7:m28sYroNlF6LhgEnbukUo4rACwx3zuQfvrlIckBt0YxKfly9TTL8TRI0zItgZOFjcTpPyAT39gGd5xGkqId4azEhgI1R3jdawKfIXjDoh8R27bkHpZHe0IGQq8n96K3A3Sc5sn/4i1uqo8CuZsYU8MvOlvAPJyT7mnNXAqrOSJsoFUPtTBKL+dZy8jzsVI3jcMfCNvJRMJA1a/VXQTcgxpeExi9eQhnMfT/daojfuo477AM86QkzMltdTOTpZGo3
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 4d0f0e3a-a31b-43bb-6b74-08d5e7757ce2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7193020);SRVR:BL0PR2101MB0962;
x-ms-traffictypediagnostic: BL0PR2101MB0962:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB096278CB11E51A8D50C92995F45A0@BL0PR2101MB0962.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(85827821059158)(211936372134217)(153496737603132)(100324003535756);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB0962;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0962;
x-forefront-prvs: 0730093765
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(346002)(376002)(396003)(136003)(13464003)(199004)(189003)(72206003)(10090500001)(66066001)(6436002)(14454004)(86362001)(55016002)(81166006)(478600001)(68736007)(93886005)(10290500003)(6246003)(53936002)(5250100002)(7696005)(76176011)(7736002)(2900100001)(54906003)(86612001)(8676002)(256004)(229853002)(81156014)(74316002)(316002)(11346002)(2906002)(8936002)(9686003)(476003)(5660300001)(186003)(105586002)(25786009)(8990500004)(26005)(22452003)(3846002)(97736004)(6916009)(6116002)(305945005)(53546011)(446003)(486006)(6506007)(102836004)(99286004)(33656002)(4326008)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0962;H:BL0PR2101MB1012.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 75g26srhUBeiMUVUa68tic34ZtQKayH+p3GWk+8uFjW42W0EmI8GT0BScridmY5NauOcOzgZh3PoF9B0EYvboZtWnX5dKmcpFQXOeMv1T2gVgTkFRhbOs2qRD4pdcq6x4tlzdRvvcPyht8k0DNtTvQdJ8OYpBxXp69XMOiqTfYcFZc829xhi/RaBfiCS9UAL92oCs5pTEEUaMoGg9zWEY6EfvVO5fvHLrutppPn3xTs2thCAM1kk+MU5SEeLSspZsitTwJ7+neN8AtQRZD9YWWa2oy0RfQqymo0d19WETY0yftuEP8Xv/lD5DRN7trEAoWGj5Z7yONz7z97NBD7f9WSy3IDsiJj/+EEIil5fmlE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d0f0e3a-a31b-43bb-6b74-08d5e7757ce2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2018 21:30:13.4727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0962
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -----Original Message-----
> From: Junio C Hamano <jch2355@gmail.com> On Behalf Of Junio C Hamano
> Sent: Wednesday, July 11, 2018 4:11 PM
> To: Ben Peart <Ben.Peart@microsoft.com>
> Cc: Stefan Beller <sbeller@google.com>; git <git@vger.kernel.org>
> Subject: Re: [PATCH v1] handle lower case drive letters on Windows
>=20
> Ben Peart <Ben.Peart@microsoft.com> writes:
>=20
> >> -----Original Message-----
> >> From: Stefan Beller <sbeller@google.com>
> >> Sent: Wednesday, July 11, 2018 1:59 PM
> >> To: Ben Peart <Ben.Peart@microsoft.com>
> >> Cc: git <git@vger.kernel.org>; Junio C Hamano <gitster@pobox.com>
> >> Subject: Re: [PATCH v1] handle lower case drive letters on Windows
> >>
> >> On Wed, Jul 11, 2018 at 10:54 AM Ben Peart <Ben.Peart@microsoft.com>
> >> wrote:
> >> >
> >> > Teach test-drop-caches to handle lower case drive letters on Windows=
.
> >>
> >> As someone not quite familiar with Windows (and using Git there),
> >> is this addressing a user visible issue, or a developer visible issue?
> >> (It looks to me as the latter as it touches test code). In which way
> >> does it improve the life of a developer?
> >>
> >
> > It is a developer visible issue.  On Windows, file names (including dri=
ve
> > letters) are case insensitive.  This patch improves the life of a Windo=
ws
> > developer by making drive letters case insensitive for the test-drop-ca=
ches
> > test application as well.  Without this patch "test-drop-caches e" will=
 fail
> > with an error "Invalid drive letter 'e'" instead of succeeding as expec=
ted.
>=20
> I think one point of the original question was if it is common for a
> developer to say "test-drop-caches e" from the command line, or the
> helper is run solely by being written in some numbered test script
> directly under t/.  In the latter case, it would be reasonable to
> expect and insist the scripts to use the more canonical form, even
> if the platform is case insensitive (assuming E: is more canonical
> than e:, that is) no?
>=20
> In any case, a larger point is that it would help other people who
> read the patch and "git log" output, if the answer you gave Stefan
> in the message I am responding to, and another one that you may give
> me in a response to this message, were in the proposed log message
> in the patch.
>=20
> Thanks.

I apologize.  My memory had faded as to the scenario that caused the issue
and my earlier response was incorrect.

Some months ago I ran into a situation where GetCurrentDirectory returned a
lower case drive letter which caused test-drop-caches to fail.  While most
tools _do_ upper case the drive letter before calling SetCurrentDirectory,
it isn't anything that is enforced so you _can_ get a lower case drive lett=
er
from GetCurrentDirectory and we should handle it properly.

At the time, I simply patched my local copy to properly handle that case an=
d
the patch has been sitting in my "todo" backlog for a while now.
I'll submit a V2 with a better commit message.
