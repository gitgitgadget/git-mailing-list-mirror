Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57AB21F453
	for <e@80x24.org>; Fri, 15 Feb 2019 18:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731335AbfBOSC6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Feb 2019 13:02:58 -0500
Received: from mail-eopbgr710118.outbound.protection.outlook.com ([40.107.71.118]:51264
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729065AbfBOSC5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Feb 2019 13:02:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3aSyZA9Dr5/bijHktZU+gUIXRhZ6xUFdlyWXm0iXow=;
 b=gnC3iRX220iSd4z8d/8N9HOUi5a7vmo1aXMXANNJXMSGQ5DNTbWrlav4Uv/o0RPn5v2ertONe/xVb40ATIewYycxS3MANCD678lnkJOcaAoOQtBTXqz1BNkDDTL8GZcu91B3MIGioUSfFI2zU9xTvUnOO1rp9kuacCeI8k21mJs=
Received: from BL0PR2101MB0914.namprd21.prod.outlook.com (52.132.23.151) by
 BL0PR2101MB1073.namprd21.prod.outlook.com (52.132.24.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.0; Fri, 15 Feb 2019 18:02:54 +0000
Received: from BL0PR2101MB0914.namprd21.prod.outlook.com
 ([fe80::1556:2bd9:8f67:9ea2]) by BL0PR2101MB0914.namprd21.prod.outlook.com
 ([fe80::1556:2bd9:8f67:9ea2%6]) with mapi id 15.20.1665.000; Fri, 15 Feb 2019
 18:02:54 +0000
From:   Ben Peart <Ben.Peart@microsoft.com>
To:     "gitster@pobox.com" <gitster@pobox.com>,
        Ben Peart <peartben@gmail.com>
CC:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Kevin Willford <kewillf@microsoft.com>,
        "sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>
Subject: RE: [PATCH v2] read-cache: add post-indexchanged hook
Thread-Topic: [PATCH v2] read-cache: add post-indexchanged hook
Thread-Index: AQHUxHORQDVcX/3uREWerDeoqQUKiqXfe6OAgABEkbyAAD3DgIABJvGYgAADLRA=
Date:   Fri, 15 Feb 2019 18:02:53 +0000
Message-ID: <BL0PR2101MB0914080996B40B6240322DD2F4600@BL0PR2101MB0914.namprd21.prod.outlook.com>
References: <20190208195115.12156-1-peartben@gmail.com>
        <20190214144241.11240-1-peartben@gmail.com>
        <2f08ee3b-4511-2838-4c70-640d01fe1658@ramsayjones.plus.com>
        <xmqqa7iy860g.fsf@gitster-ct.c.googlers.com>
        <dc851640-ac3b-74a1-a753-7ff2a43a4a5b@gmail.com>
 <xmqq1s496iwe.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq1s496iwe.fsf@gitster-ct.c.googlers.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=benpeart@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-02-15T18:02:52.9160296Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e0ec5f21-d28d-43b7-98c2-985e8f66bb78;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
x-originating-ip: [70.33.148.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 969cd04c-fde7-40a6-1fc8-08d6936fcef2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605085)(4618075)(2017052603328)(7193020);SRVR:BL0PR2101MB1073;
x-ms-traffictypediagnostic: BL0PR2101MB1073:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;BL0PR2101MB1073;23:6QH28e4XMwl7yw8e9YkPeJcPvoz2mIVGCaHQT5k?=
 =?us-ascii?Q?lqr8sM4AQMbFiZb57uqv3mWFIejbUmm+iWHgNM9YDG7e5xSOKBKgxJ2+CKa7?=
 =?us-ascii?Q?35TBfn2s4x2nUkF1gEbPcGR5KS05ztr7jA2Z/gzKX5VDhkrGPz3i+qrZrpUp?=
 =?us-ascii?Q?fz4fuBOgk8FTUuNM7UVoOQXF8+sV6E8dbChEDwk2VnWI1xSVQkbVjmRO64Mg?=
 =?us-ascii?Q?YOkr6T4YhYRWTF4EFNp1OkMpZjfs1F5T/6Y8ACB1t4FIY+v8ZGj8MqQ0rMbL?=
 =?us-ascii?Q?PmbPNHFe28Th2RXSOqW3M2z+UUQE7pxxopBpAVZy+zVgbejOW9pGdwn1ai4L?=
 =?us-ascii?Q?OlZfNOJGQa991OxlCvznTdiNqQZ/6SqKFLXO98iK9j7jbxL8Fd6XncXx6z5k?=
 =?us-ascii?Q?pc65iF3t2wbyCjXX1N8lwth4za+92s24xYNdUDqVlHzKpTscCOOSR8f1axQe?=
 =?us-ascii?Q?TtEuSKF2qgE6uMbZnVDOyiYmrX5Jh0VHeN/3HzX6Dir6an4jLyfxY8JStw7u?=
 =?us-ascii?Q?2e3mMoO8OXGbzXn4oCcHbi1KAadAN5FAjQ8rrAD2Kqdww9t9r0G6R8gDuRcI?=
 =?us-ascii?Q?QuMpButWK63B1FNC6P/7Rl4lA3BIghim9a4urC4ZJzDWeM4Cp0fWFkIgfAtK?=
 =?us-ascii?Q?2MOuuslcKZNEaRIotUeEDHpvop3Jj3FEdoyBQ2bTUB2p2fsh5RzXrGNdnHYh?=
 =?us-ascii?Q?e4q93k0r331FxjUi3Nw4xcU1Tcbm51V/yRWFMAOxRGtnl6aCOYB+y48rWjKn?=
 =?us-ascii?Q?JvYgtmEB/PT0NN6b3xFQOy9sGM9qL7f+yEyd9c2Wacrc3nnuD70z4rkJx5iD?=
 =?us-ascii?Q?O+VXM3VMtL+TArjCzkkXCc2ukUu8DYkZSoFvy1aXznHIjTgQbZpzGlqtcu77?=
 =?us-ascii?Q?Mx4yhNluYhITmnN0qY0bs0LWkA1yRrVpRsc6bsCPCkoxorV54mPDQYIRS4nz?=
 =?us-ascii?Q?gAn0FYSIOoPSp+kfq3Bq1Fy9heKmLDjbCw8OIUQKBAMv8BtbommlMhqbWXq8?=
 =?us-ascii?Q?DHvqXdcytk+OogjRUtUL0wDG6Aq2yAhs50OU4TCz9akp09nRj7PFgs9PjTli?=
 =?us-ascii?Q?+EU9qRyVFHiZSGThoAmMpFCd8PYGnFfr+GQqabEqV2KFkfAiE/pIPQGV4DQ3?=
 =?us-ascii?Q?rIcaTSqP1yMUmRYaagbQk+Qvg86oIyraoW4+4adRbDQBqJE127lbUCvhIgOh?=
 =?us-ascii?Q?5ZEwXf01GNIQtop0Zox8tjuqAVWgvYhNs1Z3PG+e1EHlWB1LBei/wtr527XA?=
 =?us-ascii?Q?I/fxI6qjXqiz0SLa3xhIS7cpPltcj7WCkJwsvyX7ntq8Adao0W4PhP5bWIB/?=
 =?us-ascii?Q?FnOmXSQrqP/2S0dVbTFiwj0seX9gPb8JxB/2nm1kynZ7QNcC8kor5J7PCuwE?=
 =?us-ascii?Q?Sn5Sv+bWw/y+55vu+2BNeol5nT8+YTxmM/MqIBNdtnGvHKe76Rzsqq52HRXO?=
 =?us-ascii?Q?1JRkpECQjU66vseIMPJV2S2Z++XImIYk=3D?=
x-microsoft-antispam-prvs: <BL0PR2101MB10734626BC77A1042AEB0029F4600@BL0PR2101MB1073.namprd21.prod.outlook.com>
x-forefront-prvs: 09497C15EB
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39860400002)(346002)(136003)(396003)(199004)(189003)(13464003)(7696005)(76176011)(6436002)(33656002)(106356001)(66066001)(74316002)(110136005)(7736002)(305945005)(229853002)(486006)(8990500004)(71190400001)(10290500003)(71200400001)(316002)(476003)(55016002)(22452003)(446003)(3846002)(6116002)(4326008)(11346002)(81166006)(81156014)(99286004)(8676002)(10090500001)(72206003)(2501003)(25786009)(86362001)(9686003)(26005)(97736004)(102836004)(14444005)(6346003)(256004)(8936002)(14454004)(6506007)(186003)(53546011)(93886005)(2906002)(68736007)(6246003)(54906003)(478600001)(105586002)(53936002)(86612001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1073;H:BL0PR2101MB0914.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BtcVl/psxcLoXVP95mDRVbFjCgq8zZED0EiLW4TUn3+QN6pPi1SC524ZdAwDqHM0xlHzxw9SXKHWVnBDQFnrjta7FP3fyqlnoNwSqeNpEVrNHjf1uPspugdMqp+bDyZs0qKgbWMDn8ToCkBZtYKjyQarXqYd87O+YpF+K+wEyq21Y1VIC8zbf9xgPBjd24/V9CAFmrLaSp5gzX5NNegLx5GJIwPH9Sf43opMMo1A4DHxprZrfyOVxlrOJK3x9w+/zr95WNGsZ7W8R8sp9Vm1+/ipqPvkHRmnZlX0iejQkxJgjJUdciGIrEiML4wAuP/T8uFluH3X/jcqTbNa7AyCq1w7NDB90t/Gqwoe6KTZjjJPtipi1WrTdmYNZYjmVXUHZrhw4T3GM4aomR2arvY1iS4vR/NUBx54fpFVtQuFZfo=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 969cd04c-fde7-40a6-1fc8-08d6936fcef2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2019 18:02:54.0302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1073
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -----Original Message-----
> From: Junio C Hamano <jch2355@gmail.com> On Behalf Of Junio C Hamano
> Sent: Friday, February 15, 2019 12:50 PM
> To: Ben Peart <peartben@gmail.com>
> Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>; git@vger.kernel.org;
> Ben Peart <Ben.Peart@microsoft.com>; Kevin Willford
> <kewillf@microsoft.com>; sandals@crustytoothpaste.net
> Subject: Re: [PATCH v2] read-cache: add post-indexchanged hook
>=20
> Ben Peart <peartben@gmail.com> writes:
>=20
> > On 2/14/2019 3:33 PM, Junio C Hamano wrote:
> >> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> >>
> >>> On 14/02/2019 14:42, Ben Peart wrote:
> >>>> From: Ben Peart <benpeart@microsoft.com>
> >>>>
> >>>> Add a post-indexchanged hook that is invoked after the index is
> >>>> written in
> >>>
> >>> s/post-indexchanged/post-index-changed/
> >>
> >> Good.  I wasn't paying close attention to the previous round, but is
> >> that the only name-related bikeshedding?  I somehow feel that without
> >> s/changed/change/ the name does not roll well on my tongue and does
> >> not sit well together with existing ones like post-receive (which is
> >> not post-received).  I dunno.
> >>
> >> Will queue.  Thanks.
> >
> > Would you like me to submit another version with the above spelling
> > corrections in the commit message or is it easier to fix it up
> > yourself?
>=20
> I've already done s/indexchanged/index-changed/ before queuing (there
> was only one IIRC in the log message), and also the 'optimize' typofix.
>=20
> I didn't do anything about dropping 'd' at the end, as I haven't heard an=
y
> feedback on that from anybody yet.
>=20

I'm ok with either.  post-index-changed sounded clearer to me but you're ri=
ght, none of the other hooks use the post tense.  I've submitted one with '=
post-index-change' - feel free to keep/user either.

> >>>> do_write_locked_index().
> >>>>
> >>>> This hook is meant primarily for notification, and cannot affect
> >>>> the outcome of git commands that trigger the index write.
> >>>>
> >>>> The hook is passed a flag to indicate whether the working directory
> >>>> was updated or not and a flag indicating if a skip-worktree bit
> >>>> could have changed.  These flags enable the hook to optmize its
> >>>> response to the
> >>>
> >>> s/optmize/optimize/
> >>>
> >>> ATB,
> >>> Ramsay Jones
