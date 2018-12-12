Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34D3020A1E
	for <e@80x24.org>; Wed, 12 Dec 2018 21:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbeLLVuj (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Dec 2018 16:50:39 -0500
Received: from mail-eopbgr800088.outbound.protection.outlook.com ([40.107.80.88]:63832
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726263AbeLLVuj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Dec 2018 16:50:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dA2DmfZ/GXtoR1mHzE+O9y2R/B/+9RSTSTQ3KYVlfu0=;
 b=kGCqVqQmR29WE5Aqamy6DhL7U1OUo1qnXnZzkfsExS8cO4CwS3dKBC39+jMyXuF5FwBqplte4elzmg9trIbd50smEpFsi8XZr51ImN0wWqm2p2P7V9uW3WNvpfkYx61BpBuHEeC8+YcCpKbhTTei/oovEEpuTQ9hru2BygZqcts=
Received: from SN1PR12MB2384.namprd12.prod.outlook.com (52.132.194.153) by
 SN1PR12MB0397.namprd12.prod.outlook.com (10.162.104.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Wed, 12 Dec 2018 21:50:36 +0000
Received: from SN1PR12MB2384.namprd12.prod.outlook.com
 ([fe80::f9a6:2b87:1862:d693]) by SN1PR12MB2384.namprd12.prod.outlook.com
 ([fe80::f9a6:2b87:1862:d693%2]) with mapi id 15.20.1425.016; Wed, 12 Dec 2018
 21:50:36 +0000
From:   "Iucha, Florin" <Florin.Iucha@amd.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Subject: RE: High locking contention during repack?
Thread-Topic: High locking contention during repack?
Thread-Index: AQHUkcZ+f0+V0Wt6CUuFEjrDC9wzQqV69toAgABaC1CAABTh8IAABuDAgAAK5yCAAC208A==
Date:   Wed, 12 Dec 2018 21:50:36 +0000
Message-ID: <SN1PR12MB2384DADBA94F3F9435E5E9D895A70@SN1PR12MB2384.namprd12.prod.outlook.com>
References: <SN1PR12MB23840AFE62E41D908A40D1B095A70@SN1PR12MB2384.namprd12.prod.outlook.com>
 <20181212112409.GB30673@sigill.intra.peff.net>
 <SN1PR12MB23849A5B991FB7D9213FB64595A70@SN1PR12MB2384.namprd12.prod.outlook.com>
 <SN1PR12MB2384362EE5BA4980322931B795A70@SN1PR12MB2384.namprd12.prod.outlook.com>
 <SN1PR12MB2384587486B6D10F2784CEB795A70@SN1PR12MB2384.namprd12.prod.outlook.com>
 <SN1PR12MB23844F35A879EA185AD6B00B95A70@SN1PR12MB2384.namprd12.prod.outlook.com>
In-Reply-To: <SN1PR12MB23844F35A879EA185AD6B00B95A70@SN1PR12MB2384.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Florin.Iucha@amd.com; 
x-originating-ip: [165.204.24.251]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR12MB0397;20:kCTO8a9D0JdeVsgilMmbNPSLQQSw2nxYTAYbalJQi1wTIq15rm7p8HbN1CY2uqmE5oVnLrODqWNAjPtQSbEMjClsP0sHSnnzbE1Zgm4Erpr5w3wcVDE3ykAmAg1leDTDwqUg0qN7AJ0Hn4aJ3Brgx4QIzmclp2WeSfnYmMLdcJP17hoI+/8aGiomwHnrb+MDc/JaKZHUQ6oNG6uGhRYtyq9XixtA0n9H6Kzky/LH28OnM+6vMORxfQbK9jhs3Xig
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 0ea63a90-2a15-4ba3-0f05-08d6607bd94b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB0397;
x-ms-traffictypediagnostic: SN1PR12MB0397:
x-microsoft-antispam-prvs: <SN1PR12MB03979FF86C83FB9EB030E7A595A70@SN1PR12MB0397.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230020)(999002)(6040522)(2401047)(5005006)(8121501046)(3231475)(944501520)(52105112)(3002001)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:SN1PR12MB0397;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0397;
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(376002)(346002)(366004)(189003)(199004)(39060400002)(9686003)(53936002)(256004)(86362001)(229853002)(105586002)(93886005)(54906003)(71190400001)(71200400001)(76176011)(6506007)(6916009)(5640700003)(99286004)(316002)(8936002)(305945005)(4326008)(186003)(3846002)(6246003)(6436002)(55016002)(7696005)(102836004)(6116002)(26005)(2906002)(2501003)(74316002)(478600001)(2940100002)(25786009)(72206003)(5660300001)(66066001)(2351001)(33656002)(97736004)(7736002)(14454004)(106356001)(8676002)(1730700003)(81166006)(81156014)(11346002)(486006)(476003)(93156006)(446003)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0397;H:SN1PR12MB2384.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Gqy6o3WXrNJ8eonNozyHUzxaKknXSTF6tFRzaR5SdMdF3uDlMGwnu3b+Io89mtL4x4YKxuohJaTJ8pfy/yraklBFBDm9P0zFQ9aF5e7nYcOCoItOEQD/sEejzNmP8CjVuf7q38XoYd1y1U4nPH1DHHWTmNmZslMAV1Ial9TJwvHUzpV9Zhv9sJ/Ijp5CI53q+S47WboDfHGUn/g8vI6FkZw6x0VJHJuILalDzwEamLb6ZzjX2JWH7Ryb2ccuOMxb/0NdMsanrqWRbZ+4o0th020OR4fJqHxReZJQJGy5+Ip1JzYVrDrZYzoMihs5ABUp
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ea63a90-2a15-4ba3-0f05-08d6607bd94b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 21:50:36.1072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0397
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiBJcyB0aGVyZSBhbiBlYXN5IHdheSB0byBmaWd1cmUgb3V0IHdoYXQgb2JqZWN0IHdlJ3JlIHBy
b2Nlc3NpbmcgaW4gY3JlYXRlX2RlbHRhPyBJIGhhdmUgZmlsdGVyZWQgb3V0IHNvbWUgbGFyZ2Ug
ZGF0YSBmaWxlcyBpbiAuZ2l0YXR0cmlidXRlcyBhbHJlYWR5Lg0KDQpGb3IgdGhlIHJlY29yZDoN
CiogYWRkIGJyZWFrcG9pbnQgb24gY3JlYXRlX2RlbHRhIGF0IGRpZmYtZGVsdGEuYzozMjENCiog
c3RvcCB0aGUgZXhlY3V0aW9uDQoqIHN3aXRjaCB0byB0aGUgd29ya2VyIHRocmVhZA0KKiBzZWxl
Y3QgZnJhbWUgMzogdGhyZWFkZWRfZmluZF9kZWx0YXMgYXQgYnVpbHRpbi9wYWNrLW9iamVjdHMu
YzoyNDA4DQoqIHAveCBtZS0+bGlzdC5pZHgub2lkLmhhc2gNCg0KZmxvcmluDQo=
