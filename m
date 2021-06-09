Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B4CCC48BCD
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 13:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FED9610C7
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 13:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236501AbhFINqM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 09:46:12 -0400
Received: from smtppost.atos.net ([193.56.114.177]:18583 "EHLO
        smarthost2.atos.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229947AbhFINqL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 09:46:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=atos.net; i=@atos.net; q=dns/txt; s=mail;
  t=1623246256; x=1654782256;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ENoN30Jq66c8MGZ2If331GZ5ID1EhZ7lVwsP4SM5tTA=;
  b=Shy240AZ1368aAwAYI08Nc44DLZWxY7j8TXJe6D49xwX5X0k6DQxs60f
   Pb0OExqCj8jYOfEtyjDIceomKTaKu2SBWahiWBK0gM1080tshS1b9H9sw
   r8aKR5xIhKe20M1GioptmVQILodwxBhapnwVdz4krIzYpXY1SWFW4xku+
   Q=;
X-IronPort-AV: E=Sophos;i="5.83,261,1616454000"; 
   d="scan'208";a="216707996"
X-MGA-submission: =?us-ascii?q?MDH5P4rOaX7tn0tJje8wmorHf2XXIyvrLWcvO2?=
 =?us-ascii?q?bt1fw01esgQH+OQyVymsaY9JUnUzahMo8I6aVMZgluDBQJp2V+06SOUP?=
 =?us-ascii?q?Ynz86XG6fDfCjfSEokHKe2pcnJjXu5vs6n3DMj5euqinemO+vztf+YZP?=
 =?us-ascii?q?9i?=
Received: from mail.sis.atos.net (HELO GITEXCPRDMB14.ww931.my-it-solutions.net) ([10.89.28.144])
  by smarthost2.atos.net with ESMTP/TLS/AES256-GCM-SHA384; 09 Jun 2021 15:44:10 +0200
Received: from GITEXCPRDMB14.ww931.my-it-solutions.net (10.89.28.144) by
 GITEXCPRDMB14.ww931.my-it-solutions.net (10.89.28.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 9 Jun 2021 15:44:10 +0200
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (172.16.214.170)
 by GITEXCPRDMB14.ww931.my-it-solutions.net (10.89.28.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14 via Frontend Transport; Wed, 9 Jun 2021 15:44:10 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aaKZLoCCrhRA4A5/Kon7BX369Mgc6Z6ZJw7NdkwS+zVDtWft5ZMEt0HGLx20PfrS+gCX0ixOjvlhvfWQ1VZq8JYFhOPWGY5QoH5Y8/PdbgDFQmhN7lxIJ28ORwSlTnnYyzGprKb0Mf9lIIn8Ixm096J9TfiSqKeq/jBAxdhQi9hLNTZ6kfXssH5LBUQYXRfocvZ+eQgJ7nAfHl1wVnOTdoCX66I+wY7v+pBkXynF3WkYnBxKvCbn/CEkCjNVN26Kt7SF7BmPBwDMgOv+a6FLRV4AToRuIRsqFR7AnP2Xdwuk8YwOCHX1cZje0lO5yds+4hIpyAayj8XPYGy/VZU3dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ENoN30Jq66c8MGZ2If331GZ5ID1EhZ7lVwsP4SM5tTA=;
 b=LmqmHWbsBJoCNnXMtrD6mdcaWU8JxaeAC5KAsVuXW3Mb7tr2coVkpwyp7HKjw+sUQkU4ZbHXZh6tDOcmMn+qbf/eas+dY+2731zsxYMWvQAyKqPi8S90hYDNmbf43XVZu3blUcwGgmKfDh47yiczIu92/I/2B+YTL2hFm7Ew/Nhaa7fv0o/TYPNDNPSyvNiGtLlqYWKNAIHkXi8QJum+zf7dDopSg8MWsRpbHNSwoOAxY93neo0NwY6io6UNCOQuy9DrdERZR8xOegyf3BR8wcjExZn4P06O2U1oUuhHxXhWwGXu3rEo0Ss3dfrd5aKGJv+9CFkUjP6MzIy83FrFyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atos.net; dmarc=pass action=none header.from=atos.net;
 dkim=pass header.d=atos.net; arc=none
Received: from AS8PR02MB7302.eurprd02.prod.outlook.com (2603:10a6:20b:3f8::19)
 by AM7PR02MB6307.eurprd02.prod.outlook.com (2603:10a6:20b:1b2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Wed, 9 Jun
 2021 13:44:09 +0000
Received: from AS8PR02MB7302.eurprd02.prod.outlook.com
 ([fe80::ed80:b8f7:efc7:e147]) by AS8PR02MB7302.eurprd02.prod.outlook.com
 ([fe80::ed80:b8f7:efc7:e147%6]) with mapi id 15.20.4219.021; Wed, 9 Jun 2021
 13:44:09 +0000
From:   "Kerry, Richard" <richard.kerry@atos.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>,
        "stolee@gmail.com" <stolee@gmail.com>,
        "jrnieder@gmail.com" <jrnieder@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: RE: [PATCH 1/4] Documentation: use singular they when appropriate
Thread-Topic: [PATCH 1/4] Documentation: use singular they when appropriate
Thread-Index: AQHXW75YcIiaTHB6CUqdN7DKAcvQUasKYV8AgAAIYQCAAUfasA==
Date:   Wed, 9 Jun 2021 13:44:09 +0000
Message-ID: <AS8PR02MB730269FA1BF5C3B0CE20DD8B9C369@AS8PR02MB7302.eurprd02.prod.outlook.com>
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
 <afc51c5e6edec7935a6d0d0a05d396e11311ca6c.1623085069.git.gitgitgadget@gmail.com>
 <YL+p+MlgJ754YoqB@google.com> <60bfb1003c46b_1ac15c20894@natae.notmuch>
In-Reply-To: <60bfb1003c46b_1ac15c20894@natae.notmuch>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Enabled=true;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_SetDate=2021-06-09T13:44:07Z;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Method=Standard;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Name=All Employees_2;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_SiteId=33440fc6-b7c7-412c-bb73-0e70b0198d5a;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_ActionId=7b4ec2f9-4e4c-4692-b58f-70fc4b2b1825;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_ContentBits=0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=atos.net;
x-originating-ip: [165.225.199.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 515bf27c-be2a-4177-ca45-08d92b4ca889
x-ms-traffictypediagnostic: AM7PR02MB6307:
x-microsoft-antispam-prvs: <AM7PR02MB6307C8D4D0878989190200179C369@AM7PR02MB6307.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FVhKtWGri4dzviyScoTwkH2IL4fnbMX8ajzaGVgwmcRRgOkfakEBRsr/Edkec0IX5hF46H1K2fsU9ngItZPQThhwY7L2MkYe3Vg0ILNkaA7xMTAFaaD4gUlTT5unGAg1xk+SJ2d7kdd5xRtqaAnIc0XhEhOOHMT8zDNZzFAq15S/FQ+JGR7Ifm6uAtnOHNF/qiX5EFekdNw8ScvZiXNhzcrX1Mf2e+4kc0i945TGl3tb8dAv+ItFOkzMc4eMQgegKGpgypXri3JAG2nz6ELXx4XWlCPMNFpqw51B1wGG5MIouwPplcflW01t+wHpJkKYqctEW4SAr5oQNzgkvo+rJug4hvmaYgYLubPOclEz1ckn5at0xUZaerH0VruOgKmLn4/OjN5htrr4CPcc1bcJbWLk86rXw/d17A/EcgGVmH2SBz1istvn0fFWVFHjUfZD9TbouI75vZaz0l1iJ9BeRXQbRAx7txPlklf5NWFWvXLE0f1WSM+J+0cbaqy/RT6cLRHFPNWoZKlwNY7qaJgH187Y04Nn4MXySL9tgSo4ChAOCI6Dpo9P1cycwfCSgkZiI+hFrC9L/Jdgvx/lMA0jiduj/bg/5KAfcyn+I2zh06k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB7302.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(396003)(346002)(136003)(376002)(122000001)(186003)(26005)(478600001)(2906002)(9686003)(76116006)(66946007)(66476007)(66556008)(66446008)(64756008)(55236004)(4326008)(33656002)(8676002)(6506007)(38100700002)(4744005)(7696005)(54906003)(5660300002)(71200400001)(8936002)(110136005)(86362001)(7416002)(52536014)(316002)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGpORHMxQktQQlRZRENoZERuTkc0S3JjVWQ5NWFvL21DYW5EbThWeFhUV2Nu?=
 =?utf-8?B?QlI5bFBpWkluRENLNi9vSlBkNmZKcU1hM00vVnhnQWFrSHl2VkdsakVJWVZq?=
 =?utf-8?B?U0lIRVFoMWtrdmtmendsdjFNcmg3bjdaODdIZlFLcjlMdHE4bUN0WlVtUEF6?=
 =?utf-8?B?Vjgvc0tEdTFJZ3k4VGRjbHo2KzdURlR6L1I5Z0Y5NGZnVTgwdlI0UzE1RmNY?=
 =?utf-8?B?YW9SdWVwcFdkdmZJK2xqYTE3VGlJcE9EMzVHaW41NHR6NGxRL21CUzlMNm1U?=
 =?utf-8?B?USs1eXJ4RGNvbXQyK3QxZ1BPUFFXRVRZa01rZm4waklVY0s1WU5scjFIdGYv?=
 =?utf-8?B?b1RxS25aVmkxb3RFcXhxTDRzYkR6aHZxTnFwNWdLZURyMFBrcGQzV1FObWVp?=
 =?utf-8?B?ZGV4ZUFkV0VrSDR5Z3V3UVB4a1NTRlQvN1E0U3NvenprOFl4RC9OaUplem1W?=
 =?utf-8?B?M04zT0lzK3prdUJTWHkxSUR2LytPKy9vMXlvVFlHcnpQcnlLNUROaC9CdE5E?=
 =?utf-8?B?SVdXUEROU2pSVDkyTHcwdHlnQ3JsekNYQU1QcGkreVdOakdlMkYyejR2NXFl?=
 =?utf-8?B?VTR5NEtYenRYK25rY2taYUZMbDZoRzBuYlVocCsrUFZzaFIxQXFhNzg3OXdE?=
 =?utf-8?B?N1NaQlBubzNpNlBQM3gxK3ZETExPY1NZWmowWFhhWW5SNXZiRjA2QVhENzMx?=
 =?utf-8?B?YTM1Y2llRTF0ZUg1VkR5T3NoU3d6NVk2dU15dERSYUlidnFSNXNjclFCVGZi?=
 =?utf-8?B?TUxiQmt4OEcxcFl2emtMSncvWmZYNXN6OWQ2SlZhVGE2U3ZCQTQ3NFNkaXJU?=
 =?utf-8?B?TGZEOWFhU2R6T2VkQjRVbWkxVzR0VkFxNEsxbGpNeXZsZm1LUjUrZ0YwYnBr?=
 =?utf-8?B?dlVyMlkybWxMbGYxN2pUWUJITE9YL0ZuRjVsRTRyNmhCR3l1bGM4RFNUT1pn?=
 =?utf-8?B?NTQvK1RWVlhUaGl4VVZ6Z0pHbkxiNWRBOHhZT2VJQnViMzJ4ZGswWHVuTFY5?=
 =?utf-8?B?dVFUZE9JbGhmSmwrcEFjMEdXOFdqRnQ4T1A4cC9CTzFPVDAwQ2hRdDdjQjJl?=
 =?utf-8?B?Zk9BemxFOFhmb3FBbFNUVStoWDNGeUJUeDNjcUdwL2ltc3JTRHFhOExWSTJT?=
 =?utf-8?B?OU5NYVVtVW1JdUZhZ1ZoRGlaeWdwRDVKUjdWM0cyRkk4UE9Hc01EcGdlRnZo?=
 =?utf-8?B?MVZTZURpYStFVmJKR3BEeUljeXNKRDQzR1JEaXpqTkxmbEdoandud0FBVkRV?=
 =?utf-8?B?WlNaeWR0ZmpEUUJPTkdyNlV4S3N6K1gwVmRGYmE5MTBvODRoVU94WE8zaml4?=
 =?utf-8?B?NnZWQkNsQkdaZ2VsSGtlY29URDlmL2o1YjZZUVRIbmtpOXZCaVlsc3U2L1pL?=
 =?utf-8?B?dXBrMm9td2pQSHh5NGFlOTkyTE9IckpycjV4c0M2eGpNUnhpVVkvMVdMNWNq?=
 =?utf-8?B?d3NnTXhsVGFwaDJXNG9UUzg5R1d1bGx5ZDEzN0FRN0tTTmloVGlGYU1vdnoz?=
 =?utf-8?B?bW1XbDlqRFRyeWhFR2ZXeWVTaHJ5NWNqWE9NREwvRWQzUVhnWmQyRUkxaXd6?=
 =?utf-8?B?VjZHdlFqeTVSN1QvSElQTG1Qc2ZkRW8zMUxCT3F3M3lqcmEzQUVEWmlUSGRS?=
 =?utf-8?B?dllUR2lBMUZ6NFM1bVdQbjNodncvZzZwZER4OTFWVjdoMGY1ZndpMzlEd0FO?=
 =?utf-8?B?UHNrT00rUVNGS08yWlZhRmdSbGFPZUVxZUdTMUlHWG9sM3pqdWZyNW8xYmtH?=
 =?utf-8?Q?SrHsc9GGG7q/AeWVlHzmbq0qx9qKfrQhJHvmkrs?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7302.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 515bf27c-be2a-4177-ca45-08d92b4ca889
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2021 13:44:09.3940
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 33440fc6-b7c7-412c-bb73-0e70b0198d5a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1g4PlyOpudtRvjEThaXKcSBjIyt5PFVHSXGEv6yKrqN8fa4m6trt6eNRqlPFRCuiqIclZbKo1nMQLjv3SGlSsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR02MB6307
X-OriginatorOrg: atos.net
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DQpXaGF0IGRvIHlvdSBwcmVmZXI/DQoNCiAgQS4gV2UgdGhhbmsgdGhlIHJldmlld2VyIGZvciB0
aGVpciBoZWxwZnVsIGNvbW1lbnRzDQogIEIuIFdlIHRoYW5rIHRoZSByZXZpZXdlciBmb3IgaGVy
IGhlbHBmdWwgY29tbWVudHMNCg0KW1JLXSBJZiB0aGlzIGlzLCBhcyBpdCBhcHBlYXJzIHRvIGJl
LCBhIHJlZmVyZW5jZSB0byBhIHNwZWNpZmljIHJldmlld2VyLCB0aGVuIHVzZSB0aGVpciBwcmVm
ZXJyZWQgcHJvbm91biwgb3IgcG9zc2libHkgYSBjb252ZW50aW9uYWwgc2luZ3VsYXIgb25lIGlm
IHlvdSBrbm93IHRoZWlyIG5hbWUgYW5kIHRoZXkgaGF2ZW4ndCBzcGVjaWZpZWQgYSBwcmVmZXJl
bmNlLiAgDQpbUktdIE9ubHkgaWYgdGhleSBhcmVuJ3Qga25vd24sIGFuZCBlc3BlY2lhbGx5IGlm
IHRoZXkgYXJlIG9uZSBmcm9tIGEgcG9vbCwgdGhlbiAidGhlaXIiLg0KW1JLXSBPciBtYWtlIHRo
ZW0gcGx1cmFsIC0gV2UgdGhhbmsgdGhlIHJldmlld2VycyBmb3IgdGhlaXIgaGVscGZ1bCBjb21t
ZW50cy4NCltSS10gIE9yIHJlcGhyYXNlIHRvIHNpZGVzdGVwIHRoZSBpc3N1ZSAodGhvdWdoIGl0
IGlzbid0IGNsZWFyIHRvIG1lIGhlcmUgd2hhdCB0aGF0IG9wdGlvbiB3b3VsZCBiZSkNCg0KDQpS
ZWdhcmRzLA0KUmljaGFyZC4NCg==
