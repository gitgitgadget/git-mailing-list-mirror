Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAB3C433ED
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 17:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C564D60FDC
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 17:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236573AbhDZRcm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 13:32:42 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.68]:27289 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234754AbhDZRcl (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 26 Apr 2021 13:32:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=barclays.com;
        s=barclayscom20180719; t=1619458318; i=@barclays.com;
        bh=l1i/NSUxJywlLsVHGHvmK+azXDQLbeUgZSthlTiY4IU=;
        h=From:To:Subject:Date:Message-ID:Content-Type:
         Content-Transfer-Encoding:MIME-Version;
        b=UXbUS3DBV9pzCp7Th8+qBwdWO6Wq6kD447VdhuA3NrOV9TPVvlEWOCZgZY26rJjmW
         nla1v5Mh0cDd84fWjwsfB4FMoqUWb0hKM6o/YmC8bcgYpq61t0cSstdZRlQOz8jK21
         mvZC+LrVHYCLXA/6PR1bFk4wc8oNOaFguYf1/h+BqxO6bQxRJmeEwDF/dVmPbErODe
         1ugS3+OvJKW8rJHptVpWKkqJLhQ13hQXiNXxAgnBpV14txM04/L+XniYPSdWdIuCPq
         z888shA7B4jADX3HrgcKp7wcjcIymCOxsY09ktYMtqzbeXDpqOmeOWHaRsR20oGhg3
         xL5vX+h1DDo9A==
Received: from [100.112.199.60] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-b.eu-west-1.aws.symcld.net id 3F/E7-64503-E09F6806; Mon, 26 Apr 2021 17:31:58 +0000
X-Env-Sender: Mark.Yagnatinsky@barclays.com
X-Msg-Ref: server-17.tower-283.messagelabs.com!1619458294!154609!22
X-Originating-IP: [157.83.125.118]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.75.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 15653 invoked from network); 26 Apr 2021 17:31:57 -0000
Received: from unknown (HELO IMSMGSLB603P.barclays.com) (157.83.125.118)
  by server-17.tower-283.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 26 Apr 2021 17:31:57 -0000
Received: from IMSMGSLCP03P.barclays.com (Unknown_Domain [22.112.132.22])
        (using TLS with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by IMSMGSLB603P.barclays.com (Symantec Messaging Gateway) with SMTP id D4.C0.50758.D09F6806; Mon, 26 Apr 2021 18:31:57 +0100 (BST)
X-AuditID: 0a318844-bcfeea800002c646-5d-6086f90dd256
Received: from MUKPBCC1MEG0008.collab.barclayscorp.com (Unknown_Domain [10.250.250.254])
        by IMSMGSLCP03P.barclays.com (Symantec Messaging Gateway) with SMTP id 15.5A.43236.D09F6806; Mon, 26 Apr 2021 18:31:57 +0100 (BST)
Received: from MUKPBCC1XSN0036.collab.barclayscorp.com (Not Verified[10.40.84.45]) by MUKPBCC1MEG0008.collab.barclayscorp.com with Barclays Capital Filter ESMTP (using TLS: TLSv1.2, ECDHE-RSA-AES256-SHA384)
        id <B6086f90d0000>; Mon, 26 Apr 2021 18:31:57 +0100
Received: from MUKPBCC1XHY0004.collab.barclayscorp.com (22.48.77.22) by
 MUKPBCC1XSN0036.collab.barclayscorp.com (10.44.69.18) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4; Mon, 26 Apr 2021 18:31:57 +0100
Received: from XUKPBCC4XEDG003.collab.barclayscorp.com (10.234.4.38) by
 MUKPBCC1XHY0004.collab.barclayscorp.com (22.48.77.22) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Mon, 26 Apr 2021 18:31:56 +0100
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (104.47.12.56) by
 edge.barclays.com (10.234.4.22) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 26 Apr 2021 18:31:54 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TdAaCXrULmwNER9PdMiWTT7n1Edh1mdY2fwoGgPLhvxm1UxQvvySKzBUW2dUnuCVaI2cku3UVCiNHRZrKkCbF7XAAnLBwmARZZ3bbgrgld8WdcHutQBEDsQWiQKVNqM6DN3OoEDhrQEhI0dR/7poYp8osiRb+B26iEn+K9cDUGnv/3YAjGT7bcB3vq9Hexn1vH1BPol/eF7ylbCmQFzyyCkrboc1FsEiBgIGJ+9egFnuKTKZa3n2lKPfsb+v5AeiFIytJund+jQfBWzPW66Mcq9bL3YqUb1z+GBe0JSnmvPvXasaYQ/b0z4XQKveo44f9iU+sGUrDnN6FIeChGuDzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/J93lKzsIr5GYv8N+owloMZOTkSYZ9Kk8SJMYAMyU4k=;
 b=WY3AWGjavJZSNzQ2UpVCPqHDwUKcT18yigmOBYN2plhGxlMCKenHUVqjVGLTDu1NDIbMC7X6XO0flGHkY5dnRu59PJO1cc53gMXjXMrHiZifo/bqvo3VQH4FY9D8nxxbML7QYIoGGUbBbztHsOw01pdcAWbtyY+g6WWCd9XJQBNzrBBy9sbyqQ3SNG1/zEpUy8v/H9dIx22a/cSk4FCTQIsifyyweE+d8Z+WGeTI8bjxJLyPObpuT9H/z46vruYgVV3h1gWTcRMi+DgiCAT1yjRaS6kIhtOgFT+ZrmRB9toaEAwjDad9GSLNVdslf3EFMpQEjHUS+j1MxtboiZ+qNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=barclays.com; dmarc=pass action=none header.from=barclays.com;
 dkim=pass header.d=barclays.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=barclays.onmicrosoft.com; s=selector1-barclays-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/J93lKzsIr5GYv8N+owloMZOTkSYZ9Kk8SJMYAMyU4k=;
 b=a6/9ojxt/dMk6WxUwt7WpirIvGKxM9+uFS7XzK5tC/mUhES5Bc6IzKASUQ1OAVnR1JI/nDoxqxSjlmGVOlhjPVMfHB+GLHy8/+l9dTbXDumdn3XObJBp6m41cilCpHRrn2ted0oR0b1qSfhj6OAHfFAAElqnxu18ou9G99mXFC4=
Received: from AM6PR01MB4166.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:25::17) by AM6PR0102MB3141.eurprd01.prod.exchangelabs.com
 (2603:10a6:209:2::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Mon, 26 Apr
 2021 17:31:53 +0000
Received: from AM6PR01MB4166.eurprd01.prod.exchangelabs.com
 ([fe80::d167:5f40:27b1:e153]) by AM6PR01MB4166.eurprd01.prod.exchangelabs.com
 ([fe80::d167:5f40:27b1:e153%7]) with mapi id 15.20.4065.027; Mon, 26 Apr 2021
 17:31:53 +0000
From:   <mark.yagnatinsky@barclays.com>
To:     <git@vger.kernel.org>
Subject: idea to tweak wording of CRLF warning
Thread-Topic: idea to tweak wording of CRLF warning
Thread-Index: Adc6wfQ2HimUVa4FQDejoY5WlEa3eQ==
Date:   Mon, 26 Apr 2021 17:31:53 +0000
Message-ID: <AM6PR01MB4166BC567911A05016DE2918F9429@AM6PR01MB4166.eurprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_c754cbb2-29ed-4ffe-af90-a08465e0dd2c_Enabled=True;
 MSIP_Label_c754cbb2-29ed-4ffe-af90-a08465e0dd2c_SiteId=c4b62f1d-01e0-4107-a0cc-5ac886858b23;
 MSIP_Label_c754cbb2-29ed-4ffe-af90-a08465e0dd2c_Owner=Mark.Yagnatinsky@barclays.com;
 MSIP_Label_c754cbb2-29ed-4ffe-af90-a08465e0dd2c_SetDate=2021-04-26T17:31:51.2643984Z;
 MSIP_Label_c754cbb2-29ed-4ffe-af90-a08465e0dd2c_Name=Unrestricted;
 MSIP_Label_c754cbb2-29ed-4ffe-af90-a08465e0dd2c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_c754cbb2-29ed-4ffe-af90-a08465e0dd2c_Extended_MSFT_Method=Manual;
 barclaysdc=Unrestricted
x-originating-ip: [167.203.54.0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1267ede5-c8ca-4dcb-92ed-08d908d92eb1
x-ms-traffictypediagnostic: AM6PR0102MB3141:
x-microsoft-antispam-prvs: <AM6PR0102MB314163354DD0FE0DF45FC501F9429@AM6PR0102MB3141.eurprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: roUQXpf0i/FN1rztnqXdq6TjzlqkrWBry2v37a37qjdBLqdMWAXSsRYUr95Psxmwwu/vnn6kmeP370IKAIBQniXZBHH1gTLfxyZN/qx/j4/uyVnPI4BeCMrPu3X/3Ju5Vesyh/l4+etHmPUGKfer3JzXDC8hQutefqfocKZv7B3PyS0XxyxqEZzknYbhPxRTAcsOp6iLuYorEiFfzH/iR004huhdluXtascV7WH2Jjdp/clbvkCdBGNsyLAtXVBCrGKq6bCC1A51veIWcltQlgIkgkCGRTlW6sQgshPhGMSumlm9DRw1EmKsq+qLaKOvG9avNPMBc7f9F3ozt0julQbKY3kblukhEmoFRxMUHVXtLeymVSsrtsQo12gXKOTG/7+HFVGoazLZZWF/CQKgTGviGje8HroDNU5wqjm3plExXl3eCZ1cizjGlD8ufP3ECgFQPWw19G2pXO4/csOZmz+kyw5N04w0gNU1LQlQKatiPQBLhuhgoNvfdrP2a6f+VNF3CDsymtdswhCvPJqI75PpLaRYXKgHOJKJQxlKyFz1mafUoiF/L79k4g+FIYgGGWBgikER0/2SMAJI2utgcbu13orB9oprLiKT/bnsTmb6wDXfeHdxCd2sndD93RoV3ehDNlbc1tNLyrNrISEKHk/1+AZVhcnTX6KlmLPDKI1yVbx+P/jhORpt+aynEFuq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR01MB4166.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(39850400004)(396003)(376002)(366004)(83380400001)(66446008)(66556008)(66476007)(9686003)(2906002)(5660300002)(186003)(66946007)(64756008)(55016002)(316002)(8936002)(6916009)(478600001)(86362001)(52536014)(76116006)(71200400001)(26005)(122000001)(10290500003)(6506007)(38100700002)(4744005)(33656002)(7696005)(966005)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?0Ya0GlTsnzuDIePsmc/IcPX/kaoqERNr4Xc3qmLhxftsuLTspripSCCslunT?=
 =?us-ascii?Q?TI/s6JcvNyKXQdiZfZglbPCCpw2I6Hx8KEqnlvI+bKKGPqtu22UhDNCckt7N?=
 =?us-ascii?Q?3kbQGKNmKtnskROmVWICcI1COynjIvjCMPnDO0lN8/1eFhMqjGQJdFT8TkvD?=
 =?us-ascii?Q?IPR7qHdecko7HfBlMSBxBGp0A3jfE2ysbLfv3yKT5ghvyeWsBS2MqntaQJT/?=
 =?us-ascii?Q?Dwwwwo5RGhyXHmVwsj0+vPaant3oEbtOyQqCRl98XYhBY7rBfFQKWts+aiL8?=
 =?us-ascii?Q?0OAxTGo1z4qt42xjGIIvf+7W8aQjsymezNHGMkJlzhcq4R5fEgbC+3fwNORx?=
 =?us-ascii?Q?6thMknE37AFitSqVOGb1TYuz7CrIx4n6xbRVdPCaeBO9d+ErEOQ7HnUSWIUj?=
 =?us-ascii?Q?JDRZ0I+3NasheLBbRrPxD4Btnc2Yvxgw9BbysfTp95Xle4QNKAmMACS5C1yQ?=
 =?us-ascii?Q?faw+f/1fj6tvFOAtu4RvcrAf2tFl42hMQEO6frseVG1Ea0WrkYhWW/kB488F?=
 =?us-ascii?Q?VsQcIiMwSVLxBBlctjag+XxWsaVFJOlRfhUS/w+G3wb+z8704xi5bvuqH2RK?=
 =?us-ascii?Q?rquvGf2r0/qhqcFgRmERcKAZvZygtRkacGmibevbU6NujZBZZTDQ1t6dqhKG?=
 =?us-ascii?Q?tm/jT4UtI8R0l8A5IOnw1CyezutmgTxmuZISJ3lX/AmUzTzShrxUDJFnnlNM?=
 =?us-ascii?Q?D8uA688/iWD/IzclFYTZnoAAQ/pulS40b451zsbMk2xNhRMEkycT3hJHrc9E?=
 =?us-ascii?Q?CF8nOs/hgBg+Q3lbVazlFlEz//dFX7MP8vv+e5Za6dOw6CxwC6FjYova1v+k?=
 =?us-ascii?Q?ueSXIpqplpdAqlLggowQ1bnkVIKIcH6TuKGV3Z0o/Qm+6OnClKgPZ27M+dre?=
 =?us-ascii?Q?ELo0nBVbU9eiiABIdYj2CEhn8/Oo5vqJFVkV56m8xw1geNvXxBycOz20nE66?=
 =?us-ascii?Q?zeFt+k1bOM/6lV7o0SVku1IQ3WVAKQCzHoyDVWO65JrY8tFuBQoXCTPW5cIz?=
 =?us-ascii?Q?Tll6uA4iAbd3nVR+HParVt78XEnsr6nI6+VEMx430RkVNR/3tTr4EBuF2I/w?=
 =?us-ascii?Q?WKm/hWwz8B1npTStUq19HK6MqWGShQeD/S9oIAMfzQLsCUUdhwssQuyD9mkb?=
 =?us-ascii?Q?hfwOlAhhnFoUbJggY8OUxUTtsABIExbJ+SiVVTuQKqrcfGvEjoFSulT3Hrly?=
 =?us-ascii?Q?6hgq1RKcKtMCXEAR7ZyomZZLEbOHjC3GFOfCY+zmVgFOXn639rpPYxpaM/gh?=
 =?us-ascii?Q?gdzPnotMFdWYepExmBEvu/orH3a5pQsj8nQRTNhlNxaMFl+CS+2KBlncnGz1?=
 =?us-ascii?Q?JPI=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR01MB4166.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1267ede5-c8ca-4dcb-92ed-08d908d92eb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2021 17:31:53.2871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c4b62f1d-01e0-4107-a0cc-5ac886858b23
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: faL/xFTb0/nWEpqPqCcp+dNCAdL74c3/nZe7A1Q+ZN/lWvAurO3+YCk3CY+2mKh/ShLy4Fe5VGWr19K6qjYq4EZSQT711uL1QxcaElj4AzA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0102MB3141
X-OriginatorOrg: barclays.com
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42IRK2gR0+X92ZZg8GyjukXXlW4mB0aPz5vk
        AhijRG1KcooVilNLSjLz0m2VfEODQ5T07RJEM6687WQqeCRR0TL7J2sD41PRLkZODgkBE4nj
        r/6zdTFycQgJ7GGS+DBlLjNMonXdFqjEXUaJ3ddmM0E4LUwSna2fWSGcS4wS91euZYFzpq79
        BeUcBnJmzgQbwCiwjFmi68pDVgjnFIvEvnOX2EDWMArsYJSY9jIdJMEisJVZonnuJEaQhJDA
        OiaJbR8sIWa9YZT4vvQCO0iCTUBVYtbO9UwgtoiApMS2x6/AGoQF9CS6L79jh4gbS6x6sZgF
        wtaTmL/qKyuIzQLU++/TZbB6XoFEiUnNnxghrhCT+H5qDdhMZgFxiVtP5jNBAkFAYsme89AA
        EZV4+fgf2Au8Au9YJKb/38QO8c9sRon/cz6yQlQpSExeeZANwpaVuDS/mxHC9pVoezwBKq4j
        MWf1LCi7RKL12Cf2CYwWs5Ash7B1JBbs/sQGYWtLLFv4mnkW2OGCEidnPmFZwMiyipHH0zfY
        1z3Yx8nMwDhgEyMwZXAZdrjsYNzy7YPeIUYmDsZDjBIczEoivGy7WhOEeFMSK6tSi/Lji0pz
        UosPMZoCQ2Qis5Rocj4waeWVxBuamhoYmBlYGJqaGxgqifPK9P+MFxJITyxJzU5NLUgtgulj
        4uCUamBq9WUoi5dT/67yLiKGQ/dHwj7ZOYuN8qcXbfcQs959930f7zchscr4wLlMasbV+z6m
        fvm+1P+LEOOpid8V7/I0rZTeciy/OJ3P0dDftV1E3Iax9MgV3f3FvIdO/y3b4inq2idk+46h
        8Uh/yQUpm4TMSq438i9/6SxP3/JCy09hvtPV48nM0xXMdR4u7TlilpUVsOwl++LUK9/ikhlu
        q9tP4smVuciXbq/19oatVvCmG6umhls+Ya0Urnvcz89yxYEx7Adv6vbF2/da3fba+3b1J8PV
        1e/qj3PuZ2Y4JGq+xPhw4b2u9lsX11l+qt+yUCmDp2ZtAtMqHikrrgjByv+bV57TmvZasrHC
        tTpWQImlOCPRUIu5qDgRADpRbruiAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJIsWRmVeSWpSXmKPExsXC9evXP13en20JBsveKVp0XelmcmD0+LxJ
        LoAxissmJTUnsyy1SN8ugSvjyttOpoJHEhUts3+yNjA+Fe1i5OSQEDCRaF23ha2LkYtDSOAu
        o8Tua7OZIJwWJonO1s+sEM4lRon7K9eywDlT1/6Ccg4DOTNngg1gFFjGLNF15SErhHOKRWLf
        uUtsIGsYBXYwSkx7mQ6SYBHYyizRPHcSI0hCSGAdk8S2D5YQs94wSnxfeoEdJMEmoCoxa+d6
        JhBbREBSYtvjV2ANwgJ6Et2X37FDxI0lVr1YzAJh60nMX/WVFcRmAer99+kyWD2vQKLEpOZP
        jBBXiEl8P7UGbCazgLjErSfzmSCBICCxZM95ZghbVOLl439gL/AKvGORmP5/EzvEP7MZJf7P
        +cgKUaUgMXnlQTYIW1bi0vxuRgjbV6Lt8QSouI7EnNWzoOwSidZjn9ghbHWJlo/zoObISazq
        fcgygdF0FpKjIGwdiQW7P7FB2NoSyxa+Zp4F9pCgxMmZT1gWMLKsYuTx9A32dQ/2cQ4wMA7Y
        xAhMDWIFLWI7GJcceaF3iJGJg/EQowQHs5IIL9uu1gQh3pTEyqrUovz4otKc1OJDjNIcLEri
        vJbbnBOEBNITS1KzU1MLUotgskwcnFINTMWPxFsFJfyDck9Mb2+IdU9jfCacOFt1f/69es00
        X7vYFxPKL55jYP8UoSEXH/00I+xqge5kbd93M+/3dctJHGFoinFZ7OBwfInYXItUmxXiM/dH
        Swuu3BT9fN6+r584mXjnZ185FCPUKJLSvvDBSn83xtctf48t3VL+91L+v49dHP3O/Tq3Xmey
        yJ+2ykmZKvD0tOkhvpUaTKo3tWxl4zSTpiq9vWUYacqzgLXvxeR/zGmBjpGLs51D529R/T//
        04y7bo6XdvJELI69ZK/At3OBw7+I/hX55h9/vP7VxOjJXFPWMJlnptXmXQZKj9OlwzzqZ2/Y
        KsCXeic8oN7kU030FOb8hH9hZTwrFnEosRRnJBpqMRcVJwIA2nYBEXwDAAA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If I'm on Windows and I "git add" a file with LF line endings, I get the =
following misleading warning:

warning: LF will be replaced by CRLF in t.txt

This makes me think something is about to happen "now" but actually the w=
arning is about what will happen "later".
In particular, the file will be committed with LF, but git may convert to=
=20CRLF when it comes time to check out the file.
Thus, I propose to add the words "on checkout" somewhere in the warning m=
essage, to emphasize that the conversion will occur later instead of now.=

E.g., "warning, LF will be replaced by CRLF on next checkout of t.txt" or=
=20something along those lines.

This suggestion was inspired by the amazingly detailed answer to my quest=
ion on Stack overflow, without which I would have been badly confused:
https://stackoverflow.com/questions/67199433/git-line-endings-behavior-do=
es-not-match-documentation


_________________________________________________________________________=
_________________________________________________________________________=
_________________________________________________________________________=
______
=93This message is for information purposes only, it is not a recommendat=
ion, advice, offer or solicitation to buy or sell a product or service no=
r an official confirmation of any transaction. It is directed at persons =
who are professionals and is not intended for retail customer use. Intend=
ed for recipient only. This message is subject to the terms at: www.barcl=
ays.com/emaildisclaimer.

For important disclosures, please see: www.barclays.com/salesandtradingdi=
sclaimer regarding market commentary from Barclays Sales and/or Trading, =
who are active market participants; https://www.investmentbank.barclays.c=
om/disclosures/barclays-global-markets-disclosures.html regarding our sta=
ndard terms for the Investment Bank of Barclays where we trade with you i=
n principal-to-principal wholesale markets transactions; and in respect o=
f Barclays Research, including disclosures relating to specific issuers, =
please see http://publicresearch.barclays.com.=94 =20
_________________________________________________________________________=
_________________________________________________________________________=
_________________________________________________________________________=
______
If you are incorporated or operating in Australia, please see https://www=
.home.barclays/disclosures/importantapacdisclosures.html for important di=
sclosure.
_________________________________________________________________________=
_________________________________________________________________________=
_________________________________________________________________________=
______
How we use personal information  see our privacy notice https://www.inves=
tmentbank.barclays.com/disclosures/personalinformationuse.html=20
_________________________________________________________________________=
_________________________________________________________________________=
_________________________________________________________________________=
______
