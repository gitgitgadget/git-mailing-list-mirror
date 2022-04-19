Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C54C433F5
	for <git@archiver.kernel.org>; Tue, 19 Apr 2022 05:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348627AbiDSFho (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Apr 2022 01:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348616AbiDSFhm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Apr 2022 01:37:42 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2095.outbound.protection.outlook.com [40.107.236.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0025590
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 22:34:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lJC9TVune/cuckV1os3+af6MWFeIr2kvwPoHN0dssSVXxZIxBfAvsYW0fv+pYQFxWvcFHxFHBgBl03lGKG3gG4g4R9iBLW2WCPAYPRJWXzHOIuO/fPRjVMfdCdOm4nRa6gltg7DCV6jU/n33z/auxEzlxUA9E14jZ2HEwwGro60ZDrZuOQYDcoy0fz4zZj3K2SzkNZeMRyoqkwzWA6PaCHSwzFaQoxewrbB+AhE7w3dpimspIb3LKpndT1vBn3nJwJZs9m2YxbvMln2slf8csg8b6wvVtgasBwfUPA3vAC317eFmu0J9yyyN4qrDS0V288ymJMn0R9pxjZTtG+aEbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V3CUNuCrkyUoyhUmqMfDsx5xzzr/T5+4HaiKCXZgong=;
 b=jgzcI8rOR1SlQWFVRNxzj4gXhKpAGUBt9uTdYh8qs3YgjpdPe1t8w3MXmJxBQIwgatQLg5VH4es7H7ZmnWwxsXsENQfU8wTYP5Y7TL6M3I1iaWnlmhznU9vY4zRS3bi1SqWS575tw4GcQuf9m9SSCcH2pCCiNFX70Tha+nD0NOT3gir/IfMk6YqRNpcDFpX+2FyvXs+z5PR9u3O8eF280sbPqXVlDclL+jJ5lA1FsY+iTFxUXLwyqGDbhswWxBbG4aLsFXVSX9czFCPaAs7rIgF6RvlTptErZBzAL7FtbcKpXDo/ETFYwMXhl28QFbTHaBrPUi3OgXfWd91N/dLbdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ucmerced.edu; dmarc=pass action=none header.from=ucmerced.edu;
 dkim=pass header.d=ucmerced.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucmerced.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3CUNuCrkyUoyhUmqMfDsx5xzzr/T5+4HaiKCXZgong=;
 b=UjeUa7Sze860Qx7FOWdiT6+S4HMmBSCeqtzAZMHknZujR0g8vI4xS4p6OxtEUwNKU3LrfoAK84S+Nl/PyVNohU+u0DdaCBnV5XqgJBF+dRCPIAs8ace/7iAggWWD7IH1+Z+glKIFkkJycEb0oupi0Gc9TFF6Pfzx5b1N5/XI1Lw=
Received: from BYAPR06MB4517.namprd06.prod.outlook.com (2603:10b6:a03:49::15)
 by SA1PR06MB7826.namprd06.prod.outlook.com (2603:10b6:806:1b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 05:34:55 +0000
Received: from BYAPR06MB4517.namprd06.prod.outlook.com
 ([fe80::48bb:88c4:a53c:af06]) by BYAPR06MB4517.namprd06.prod.outlook.com
 ([fe80::48bb:88c4:a53c:af06%6]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 05:34:55 +0000
From:   Jack McGuinness <jmcguinness2@ucmerced.edu>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Jack McGuinness via GitGitGadget <gitgitgadget@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 0/3] [GSoC][Patch] area: t4202-log.sh, modernizing test
 script
Thread-Topic: [PATCH 0/3] [GSoC][Patch] area: t4202-log.sh, modernizing test
 script
Thread-Index: AQHYU40s2lTpqAUJV0+1vvQAXAJX7qz2tNoAgAABli4=
Date:   Tue, 19 Apr 2022 05:34:55 +0000
Message-ID: <BYAPR06MB4517BCBBA837AA3004B2137DE6F29@BYAPR06MB4517.namprd06.prod.outlook.com>
References: <pull.1220.git.1650331876.gitgitgadget@gmail.com>
 <5b90dfbf-b299-1388-f9b6-c610ce12bab7@gmail.com>
In-Reply-To: <5b90dfbf-b299-1388-f9b6-c610ce12bab7@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 1ce3ec47-7ada-3511-0983-b994338e992d
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ucmerced.edu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d6436172-298d-4c88-d053-08da21c655dd
x-ms-traffictypediagnostic: SA1PR06MB7826:EE_
x-microsoft-antispam-prvs: <SA1PR06MB78267CA9C61AE117B663E4F5E6F29@SA1PR06MB7826.namprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 79Kzepfj14x3RjIBCbC1aCVbnXrycbN6wJuwyD6+69+5t91VwXiLUkA6rpUD5EBKxY/rFtTlt3Jo6uUc4P3z9jhaNevh2p1yjiawPRgfvbyY5qgPL0GGOS6KCvmITiedAElPI97jAkq8yJAppfmuoyPeTWabYfooJJizqSAcsoESOx0F0x3tVvUXZeIbVaxts4NBZuInzugMMW6/UNXNJ0SNKC5SfFxXGvM+nJ81N09NGsgzNcQd12xuzf3JF4XFH47ZmEzzHntBld5iEc/826eTH53CLL3jEgP8gjywgO4pSrCCYiq7YBOpe6OiJtOSlUJcShgQfZHqo9cA+riF4Oo4sFphjl3GsMstTXm1Fro0xD94O+XZc3Zn6tkRRkAiALCbV1fCeWpP9c959d+TAH31I9kXSqtw+dzGCNNk45T9evz2cDpOhPpTC6vE42K7ah8BsxLVkM/A9+sS/LjFUXdEcMQ3w+uqMBwhRS+bM5hrkjtPNPkrG5POLhQAjhhWZc1L5jF+4Uh2fCBJAmHZYP3fqz6ppRx/QJW8iccAWwcoql2cPiX4qVtgbq9N3ySkfEPVcyuIWbUY4Fw1uZiSX1ix17DtT3NEgE7dwFF3qX+jZpB9fyO+PfHMmJZyNgZv7EioudOrL3XZI2Od7BF4mz4j7f2J1oFNj1DqahmoGZL864xyMSTBcLHWc6uAA6NrL29Ims3HYmJ6CtrNV6z4OA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB4517.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(38070700005)(53546011)(64756008)(122000001)(5660300002)(2906002)(83380400001)(9686003)(6506007)(86362001)(7696005)(55016003)(186003)(26005)(786003)(66476007)(66556008)(316002)(66946007)(38100700002)(33656002)(66446008)(76116006)(75432002)(8676002)(110136005)(71200400001)(8936002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OFGsI8Y7McP5F4mIiEGSfowYERhlHSDz1+VqYwraR9v0ttEM8Igg5ftwmlOf?=
 =?us-ascii?Q?XSE9IkjgQDZW5e17CjcccQzQ7Q8JZmu5++yIc75lYJPVCOiQizANd0bfTY4/?=
 =?us-ascii?Q?cKp5l/Nde8hhFP6VEcYDM3BU+JcxsHwnsEx5vaIWyBr4HDeGpC6Ml10fWz51?=
 =?us-ascii?Q?gApF0jFxztVZXTAFQSwGBxWcCUdhk/tB/7oLfu6g6/Jj0VtYjoRugVRHBxdc?=
 =?us-ascii?Q?oYI53G1jRItaYoXlezBbLseELWiKIil6DvQy4e2aCDb4kSzsHiXjmmUGM5Yk?=
 =?us-ascii?Q?Z5M7LsJcD8Ka7BaCnO8lL0ROd5pGEjJ+VNVX4rBaqB+Z/VCKFPLY2zRQ4KDF?=
 =?us-ascii?Q?NFgBVvbKEBv3Msk413DXCH+TR9cFaLkwwloQfKs+8IaTUHLw4Yl+Jk9iPhYz?=
 =?us-ascii?Q?TSf8Pyzbcbql2d69vShbrC72avGzNw9qCXP7Xw2IqQDKDCP8S6nQ2iVORmEo?=
 =?us-ascii?Q?y8b89fit8dcJS/7fOWvCB1Vf/BYaw3ghEB2YfiUVREiuOMz7kTC6Y3RZewoW?=
 =?us-ascii?Q?bHkGfuM84q86WF6eQ29blfe+H8QX0MParTxB4LmLjl+8LLMBj9GrnWrA+yj5?=
 =?us-ascii?Q?+wjhih4zgH/lSPsX9iYpaGB9QmodyDg4km38caNEH9unj3emQ0o5X/3XHBME?=
 =?us-ascii?Q?XjYdQ2GpDQ1JsZKVj2hCPLH+C/GJK+jK4zPBymOIepfbbun56/b9dvCbpi2l?=
 =?us-ascii?Q?ZZLbIYz0a1BWfNGT1G6ukis1ZIA56H/mYbbcA500zbLijhePwrv02FoKmDYv?=
 =?us-ascii?Q?bmvB4b0XUMduOPNoBq2cDOBmo+kaIfsX3ZOYfcs0UX4CK4KSWYbAXCmg0OlG?=
 =?us-ascii?Q?TKu0E2V8U/bvw7A9fMfPcjFVr62Exbn6aGIm4KDkLNHlP3TM3VCsIvUNnJP8?=
 =?us-ascii?Q?ZFyLakl2tqYYa3sNvsl9TyEXudwv5AEw7AlM/p+3v6v0Q8Rxc1ygQhzfkWgL?=
 =?us-ascii?Q?DUcYY9fZCu+cU4tvd436AS2mF4rTYS5wmhIivxZgKIL/LX07eOfqCQwRMlaI?=
 =?us-ascii?Q?XZRcC3+HT35HnCc6WTXOleqAO16DhipwM5E4cXHVDIyf36DXhhjWXacE9WSo?=
 =?us-ascii?Q?NuOq46qqspZnLCqvUL7pxF8HNREkA4A+BsfMtNRd5FwNSmFybQIZa5emQtyi?=
 =?us-ascii?Q?oWselJjNHwwvorYHORmsR0/tE9OIiNr0G08pJYQ1h02YlA1TfapyxrRzsEeu?=
 =?us-ascii?Q?o7qdhuJkOa62l0yJ2Li/WHzkZj/xP5zAGI4bhKvxlWVA1t0ESU0cu8QeqMHS?=
 =?us-ascii?Q?46+ujIuEDz9HaGoMk6JyJXDRZOkvHE6vSIuIv/jfj5nNt050soND1iCXJDk7?=
 =?us-ascii?Q?agkYKaM+aJDUU/9XgTYAjCdFkrt5chnikdeRfyIp2Su/55KbvBrUShQoDtkQ?=
 =?us-ascii?Q?nHCXuc8EWg8jcQIopGyz7p7Wg9c2H1pw6w9oHGkneraqTY/OZKNqLgx0QrJK?=
 =?us-ascii?Q?5j8IqBuRU20u07T9sbMrn5ykAO0bObb5lCgbJlFJzkzuO6dodCeiQIKwTl6Q?=
 =?us-ascii?Q?f8AfzT5zypvbsKHDgaOeWpegy0/FAu2UqgQAFm2unC08GcO+NEWFqxOjKaum?=
 =?us-ascii?Q?KjbtgrnOCqcNK+NB9qd6gO6i0u2Xr+wJFHlpYjyHRRpL0FuyWc5qzMIg+hcl?=
 =?us-ascii?Q?Qwxq7Lf/R/XE3WsO/pZvd97JQPK9QA9MAiKHzz6iB/zJNy8cdmagtsZlEMG8?=
 =?us-ascii?Q?VpyvtGgVESFydfg4xYz4nZRRFGo98n4Dq4M9cYMWGBD2vemNv2Xy9Kf3kl5L?=
 =?us-ascii?Q?B0seZUXW/Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ucmerced.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR06MB4517.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6436172-298d-4c88-d053-08da21c655dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 05:34:55.2781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f4dfe9a3-ca78-4998-b7a7-e6d0692eace6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8CHEFZsZIMhAGBAr/C0WuhN6a1N02MvC2umtpZbRLQ/hKf20Wv0ha3hd+a3R8OaJ5ZDxde92KtZVq9x60RQvQQS2W2m/FEjQQri/uLwlPx4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR06MB7826
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, thank you for the advice. I wanted it to be that way myself, however I =
was using gitgitgadget to email it, and my PR was composed of three differe=
nt commits, which caused it to automatically be formatted that way. I tried=
 finding a way to remove it, but I had no luck, If you know how I would lov=
e to know!

Thanks for your time,
-Jack McGuinness <jmcguinness2@ucmerced.edu>

________________________________________
From: Bagas Sanjaya <bagasdotme@gmail.com>
Sent: Monday, April 18, 2022 10:26 PM
To: Jack McGuinness via GitGitGadget; git@vger.kernel.org
Cc: Jack McGuinness
Subject: Re: [PATCH 0/3] [GSoC][Patch] area: t4202-log.sh, modernizing test=
 script

On 4/19/22 08:31, Jack McGuinness via GitGitGadget wrote:
> Jack McGuinness (3):
>   [GSoC][Patch] area: t4202-log.sh, modernizing test script
>   [GSoC][Patch] area: t4202-log.sh, modernizing test script p2
>   [GSoC][Patch] area: t4202-log.sh, modernizing test script p3
>
>  t/t4202-log.sh | 156 +++++++++++++++++++++++++------------------------
>  1 file changed, 80 insertions(+), 76 deletions(-)
>

I think the subject prefix of this patch series can be just
[GSOC] [PATCH] instead.

--
An old man doll... just what I always wanted! - Clara
