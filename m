Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A048C433ED
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 08:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4492960249
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 08:52:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243782AbhDMIwh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 04:52:37 -0400
Received: from smtppost.atos.net ([193.56.114.177]:21528 "EHLO
        smarthost4.atos.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229750AbhDMIwg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 04:52:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=atos.net; i=@atos.net; q=dns/txt; s=mail;
  t=1618303937; x=1649839937;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=l/oxsy06Ek+RxO/SXs8cZzB/MgC7vOk5fTuTWh7dDZw=;
  b=ykCHenfHPhQDLzP3XrVTViS5HAp1EsnaEf7tc3suIdP/xZ5LwAh3XeZ6
   LT9MPut3GAT3CGxUz9iKEpHsidyz1rPxevI+unrqxzI9KI6juYCirNpc9
   yrxm62+tWNkppsA16leMmtwpiae29OsRo7BrAOBUL6ry4oqiu437qxmNB
   M=;
X-IronPort-AV: E=Sophos;i="5.82,219,1613430000"; 
   d="scan'208";a="195227383"
X-MGA-submission: =?us-ascii?q?MDEXm05SXzOClSZmgup74OhjGVmK6nBFaqwDVu?=
 =?us-ascii?q?tq+3M3F8KQUnOJFMVdsRGD7LsnPxKdHMEf6zX6PyRjg27WmFRr5Mjc3e?=
 =?us-ascii?q?6crRD6DE5jTBYzkav9WjqJq1rsvddbKkqQpTbsQ1SlTRn57XgSPxIV5x?=
 =?us-ascii?q?3K?=
Received: from mail.sis.atos.net (HELO GITEXCPRDMB22.ww931.my-it-solutions.net) ([10.89.29.132])
  by smarthost4.atos.net with ESMTP/TLS/AES256-GCM-SHA384; 13 Apr 2021 10:52:14 +0200
Received: from GITEXCPRDMB24.ww931.my-it-solutions.net (10.89.29.134) by
 GITEXCPRDMB22.ww931.my-it-solutions.net (10.89.29.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 13 Apr 2021 10:52:07 +0200
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (172.16.214.169)
 by GITEXCPRDMB24.ww931.my-it-solutions.net (10.89.29.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2 via Frontend Transport; Tue, 13 Apr 2021 10:52:06 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MY4rXTfebUqutcywW2N3TKujDVCPP3CbdxMu21652tqKRCLciO2yBbVGX+mzVlnrBt8qi4gbT46ezCcDWE7fWjcoGFQvFmBwkabG2p+o0vMExtYGJ4jS7ZOisUqcx4G6Z8yngFiQm/9fOOqVE0JqtREKVti77FlvTYNJr7KBUuYNZ0/4fmV6CJtBL+KO2UeoFkfJYGq37ZlTi0mkmkrI57VQoudNTdfpHhWpz1D2MQfPgQ2GuDSI4yjXsADkCPWCYCXLtYqzaHpO/ELra7/eyJ1aahZpspCnocPvQHmgOZbsRAVv0kFfqNxuVQ3AEMh5AWlgH/NoPJel1zdegtzzGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/oxsy06Ek+RxO/SXs8cZzB/MgC7vOk5fTuTWh7dDZw=;
 b=Cf0XDkCVPjQ4OhZEEbUTTF9xUFF0XseYMaAZC4JH3PkoE+ZTj+v9rI97x/p3K1V2IaeVNxcA171MtFzfy1x93bPUWY0WDvGhVZSbaNoumyxJqaMxAW7fHGUHKTFbVvRzJAltljLmjj8V8GG2/bscyk8fMYzhN3yN2uX2biV8rYSL5i70OJcY46baU/ufBTkviRvop91XQe1+kKE467Ff+XvpC8eYXViizsdwE2wTszOf6VoQrmmwz/FFogni+82JvpXO2AvI4Od8jDSX9IyGMSfv8RNAMr0JeiJljfCNoV/2kBPCLk2D531ix8xXUIIzZWpa4L45vMlpjAg7K1ORLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atos.net; dmarc=pass action=none header.from=atos.net;
 dkim=pass header.d=atos.net; arc=none
Received: from AM0PR02MB4081.eurprd02.prod.outlook.com (2603:10a6:208:df::14)
 by AM0PR02MB5442.eurprd02.prod.outlook.com (2603:10a6:208:162::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Tue, 13 Apr
 2021 08:52:06 +0000
Received: from AM0PR02MB4081.eurprd02.prod.outlook.com
 ([fe80::c4a6:6307:369f:55af]) by AM0PR02MB4081.eurprd02.prod.outlook.com
 ([fe80::c4a6:6307:369f:55af%6]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 08:52:05 +0000
From:   "Kerry, Richard" <richard.kerry@atos.net>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     Jonathan Nieder <jrnieder@gmail.com>,
        Eli Schwartz <eschwartz@archlinux.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Drew DeVault <sir@cmpwn.com>, Mark Lodato <lodato@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: RE: Regarding the depreciation of ssh+git/git+ssh protocols
Thread-Topic: Regarding the depreciation of ssh+git/git+ssh protocols
Thread-Index: AQHXGbkT0XAkhLaiH0ybB7TQSEzqDKqFVX6AgAAFJoCAAD9+AIAAL5GAgAADBgCAADwoAIAAegoAgABnDQCAAdirgIAgctEAgABkuEuACLYBEA==
Date:   Tue, 13 Apr 2021 08:52:05 +0000
Message-ID: <AM0PR02MB40815FFEC861AD8D3DE7E0189C4F9@AM0PR02MB4081.eurprd02.prod.outlook.com>
References: <20210407134646.2866522-1-lodato@google.com>
 <xmqqv98xzxlb.fsf@gitster.g>
In-Reply-To: <xmqqv98xzxlb.fsf@gitster.g>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Enabled=true;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_SetDate=2021-04-13T08:50:06Z;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Method=Standard;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Name=All Employees_2;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_SiteId=33440fc6-b7c7-412c-bb73-0e70b0198d5a;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_ActionId=76d4d67e-859c-4b26-86da-1d0b253ae792;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_ContentBits=0
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=atos.net;
x-originating-ip: [165.225.197.49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 42c89330-83a7-48a3-e61f-08d8fe596a23
x-ms-traffictypediagnostic: AM0PR02MB5442:
x-microsoft-antispam-prvs: <AM0PR02MB5442ABE253038B01416903A79C4F9@AM0PR02MB5442.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CmtwM7Nk1Wkcvjf6nLkgk9eeO+rhmRGQBVsLrkBBzaus9u6mjcoBkuuglR68e2PFmTXSQRaQUvVEPAxpkPNwkEe3Kq2tMEKGkxAeNaZq0M8EqGUAxnQXsY4QIzER1rLnxTG7RO654yRGrXTAEvkS/aYH+xwqA0R+R8TLjjDUUqvakPjZjp55+xGCfiZcsS0iqLwjmY8vUUmmnN7DGG8gNqBNgCDpEiOTiydMIfLB52skCZuJT7ybb9aIw//KM6SRHOLgve1cJzAYKR5fFrSbyC6NURFuqAqHzZpj0jeYCr7TRhP30vHupKJenKgIe7VFkShYV/D0exL7m7kC5oYwRSoVLSJ0G5JSjizwVdUvOKGtqSq9ctNPYnGPTCOmyg2BntWIMw/1KZvsnHvSiGwoc3fza74fWgGlC6ofGgCxGbXO8RS2qgUof/BNgFBaajtm+uiFDRtJWHR/VJ2uOA4z5N4RNDfd/sUMq7H8VqgIiqdYRx7jTuSSC3Wi7E/AUULj4nbamvPnfKF9xN+3I5sR7Sy3j5TW+5Qj0GyKdHhs2YFLJXHoNK0n8F58WAk4kGxtKYe6I5Jw4LOSS0odNtX0O9Xyvxql3CO8hEnpD8cuc34=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4081.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(396003)(39860400002)(376002)(86362001)(558084003)(66946007)(71200400001)(55236004)(76116006)(186003)(7696005)(64756008)(6506007)(26005)(55016002)(66476007)(9686003)(8936002)(54906003)(6916009)(316002)(2906002)(8676002)(4326008)(478600001)(52536014)(5660300002)(33656002)(66556008)(66446008)(4270600006)(122000001)(19618925003)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Z80c3n2BOJV8MFnsaAF0Z5jh5ca8TlQMpmJvDmWNr2f8hEcX5LzAm9gKgH6o?=
 =?us-ascii?Q?rb6XFbVHJ+DMITc/I0zgVi4QKArPHQiwfSdnKDGSnd0nnmM6TBbJU43YGZWo?=
 =?us-ascii?Q?4ibQwv/UoYY7YTjUt5UuyUylIvLugrFzYLpyg+J/KA9KFQv3Efzd/LzjkUkt?=
 =?us-ascii?Q?sa0QfIRXO84exFZYAKLWaFhdmd/bRlQphRJOz/7acyv2noJUmX95kJPry+GO?=
 =?us-ascii?Q?/VotcZthkBt0Mb/vBMt/bkJ3+c1uvDRHBV+62VnOjtYhLWAns+DGeDQdfU2c?=
 =?us-ascii?Q?SlmOlYqCuBToP8qYNwHSqYM7Tm9dL9bcwB3oc416s1hnGIQpdmUHmGiD2ZWO?=
 =?us-ascii?Q?SlM7ozyxcGinifbV9McmXHrgLDrsiMeutoKHyvytXha+Od/kXeFMJFNQyJ75?=
 =?us-ascii?Q?doJFf2OgTWBXBHnxEodZMKO16U4jgMpdT3rPryDg9KZ1XjaihaXZyz+Pt2VM?=
 =?us-ascii?Q?/dXfYdMRn4WIRS8aWwtrkwRvstBpgjtWPA5MFhgzhq6QKvLSD9KajqFGr39y?=
 =?us-ascii?Q?WYvuUxgwztWALYGemCV+K2UjZ49LYj827/14UkJRBBvRCrvWV8ay/stSaeSh?=
 =?us-ascii?Q?felhjZwnuyMxTFYqim1gpe+YV3OBtwWJbpwYNDTW6ylP7OwNn2y4UaF7AxnX?=
 =?us-ascii?Q?8bgeLwJMG3P6KzGermQ3gbWmGxTIBvEyrPAiBFjdWBlw1GrR9e+7Kl+1a2TS?=
 =?us-ascii?Q?YzArtXXyWxgX4Th4ru4BneIwh5+jzEsJzErNsTg7RM+Vvewuoqx9sNtTf10b?=
 =?us-ascii?Q?2b3eUkUdIgbk1o2edc/nAkf+dq42VWQhb8gxjA8RV6kmJ+6q+fJ8UsaYfN1D?=
 =?us-ascii?Q?SnRqdP2bc0ovJh+qoBX4O5WU2l1I+bJdago5liUVs+ym/u32eI3Zt0CH/G0/?=
 =?us-ascii?Q?uvtkArUhNKnNdaginXgqigneDDpelf4U80ALlf+PmSLe2fC3DSx2cmLPagv0?=
 =?us-ascii?Q?7QC9q2SS7MsxmQ294pI8espe++UKDYCoqs0S8j5mo/ZjagE6W2j7VUyca3e/?=
 =?us-ascii?Q?jTeAvQsHdWdqShnogQGPSmD6kZEFPR7JpVr/fv39HToMwuyJ0gxK4Gsc9tlz?=
 =?us-ascii?Q?iqYM3QwhpiuVZU/LKjNQCBTd0BpDdSjL+mlTLW0Ok8hPjlryK8GgLs3AzuPQ?=
 =?us-ascii?Q?cUbpVuMYAXV3PB8evi+PMERBrP/SamQqITerdOGU+tYRKflVkKIz4yl8Reij?=
 =?us-ascii?Q?eSPqNGuTiUIzEhAhpxOe6K/MOCL7camEyYKUacAUY3vyX1vhYdm+CQ0pzFiN?=
 =?us-ascii?Q?LuxJkMtvkqmWBzJIS69FVoQaX39ZvJjMVAczLhA7QNHb4ETaiHYxvRG3/ZLq?=
 =?us-ascii?Q?52w=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4081.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42c89330-83a7-48a3-e61f-08d8fe596a23
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2021 08:52:05.8417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 33440fc6-b7c7-412c-bb73-0e70b0198d5a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kxedKUL3N7NpuAEFa5JSvks5foZPZCE4vlm0F2Oo+M5tDK3tHD87gx1UMFdhV/bXt5BNkoVN0fo+J+vs4pRz9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB5442
X-OriginatorOrg: atos.net
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


s/depreciation/deprecation/



Regards,
Richard.

