Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_MIXED_ES shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E8EB20A1E
	for <e@80x24.org>; Wed, 12 Dec 2018 16:49:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbeLLQtk (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Dec 2018 11:49:40 -0500
Received: from mail-eopbgr730068.outbound.protection.outlook.com ([40.107.73.68]:21056
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727969AbeLLQtj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Dec 2018 11:49:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cvinbi7AzZGtb21RMw/qcDtaoNijD7ZLS1eX/8yq9sc=;
 b=V9CUtLT/xAusEW8W6vdsCTIKgEC9WP/Q/7NLJolE/4zW0OOe9/3dhUBGCVZhIYr58xlSV2OJGi5UN0cFXzNz8fhHnFhDYPeuhCaHCPJTIiapXa3NoQp99hJRm158cKrfPDo6JJ6iiwuzwJfCJrB2Ecas4ld/YGdv2vw80eDmshg=
Received: from SN1PR12MB2384.namprd12.prod.outlook.com (52.132.194.153) by
 SN1PR12MB2367.namprd12.prod.outlook.com (52.132.194.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Wed, 12 Dec 2018 16:49:37 +0000
Received: from SN1PR12MB2384.namprd12.prod.outlook.com
 ([fe80::f9a6:2b87:1862:d693]) by SN1PR12MB2384.namprd12.prod.outlook.com
 ([fe80::f9a6:2b87:1862:d693%2]) with mapi id 15.20.1425.016; Wed, 12 Dec 2018
 16:49:37 +0000
From:   "Iucha, Florin" <Florin.Iucha@amd.com>
To:     Jeff King <peff@peff.net>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: High locking contention during repack?
Thread-Topic: High locking contention during repack?
Thread-Index: AQHUkcZ+f0+V0Wt6CUuFEjrDC9wzQqV69toAgABaC1A=
Date:   Wed, 12 Dec 2018 16:49:37 +0000
Message-ID: <SN1PR12MB23849A5B991FB7D9213FB64595A70@SN1PR12MB2384.namprd12.prod.outlook.com>
References: <SN1PR12MB23840AFE62E41D908A40D1B095A70@SN1PR12MB2384.namprd12.prod.outlook.com>
 <20181212112409.GB30673@sigill.intra.peff.net>
In-Reply-To: <20181212112409.GB30673@sigill.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.24.251]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR12MB2367;20:PTLQKoZnAo/Diye5AGjhx/QnXa6n8t6YL+LvDX+ybBWDy5jIpfXyelrNmoFtrYx+DL4V7mY47flEU2B8WP4OJhk8lroT1gxnopOWHJBWY57jsQMSsO9yIVrNeGBJI1D62vly9y/de8SEVMu7OOf1abG1hgIr8+KdpC8XdhwWNMkmNJzZzTH4YUISeFBG+pF5V11KCpVbQ1L9MfzY/YmU3LJ+tO63Vj6kcuMQewIVSxqKK2J85Y7Q4VeOLminyi94
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c546c1cb-a1f0-4aab-4846-08d66051cd61
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB2367;
x-ms-traffictypediagnostic: SN1PR12MB2367:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Florin.Iucha@amd.com; 
x-microsoft-antispam-prvs: <SN1PR12MB2367B62BF4A621F1E0FFF8C095A70@SN1PR12MB2367.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230017)(999002)(6040522)(2401047)(5005006)(8121501046)(3231472)(944501520)(52105112)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:SN1PR12MB2367;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB2367;
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(39860400002)(376002)(346002)(189003)(199004)(81166006)(7736002)(9686003)(102836004)(5660300001)(7696005)(72206003)(11346002)(446003)(33656002)(316002)(81156014)(99286004)(68736007)(345774005)(8676002)(105586002)(97736004)(14454004)(6436002)(6916009)(8936002)(6116002)(229853002)(71190400001)(305945005)(55016002)(106356001)(74316002)(2906002)(66066001)(4326008)(3846002)(71200400001)(25786009)(486006)(6506007)(53936002)(6246003)(26005)(476003)(478600001)(76176011)(256004)(86362001)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB2367;H:SN1PR12MB2384.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Px8Nb2PdWXZes9LNcUYOMcNahwnGrUlvv5M6oqrx+B3sz0/Vw8t+xGE98VtrCnTFEDNGT7AC+xWr/qoGD872HiwVCUhl4sVgWF5jpgsG4To2YBCVJ4j/+hszEYpVmNibvqeSEkrEJUJbE9pQZi1cuqsRQ0oj0DdmUhWLj0p3Bobb8+vgWsEnFnBdajUIQvzCbKf5AsnkEkqP8wZXLo8K1UVi+Wh12w57DP3HG5dCcevV/0827/KlxooDKRXbMoXnAR5ux/OOCujNc0X5QRIgXLWJMoCl5D9rc2+nlTDCtBGQ9aCqr3dJpg/nO6ObyQvi
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c546c1cb-a1f0-4aab-4846-08d66051cd61
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 16:49:37.2576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2367
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SmVmZiwNCg0KVGhhbmsgeW91IGZvciB0aGUgYWR2aWNlLCBJIHdpbGwgcmVkdWNlIHRoZSBkZXB0
aC4NCg0KUnVubmluZyAiZ2l0IHBhY2stb2JqZWN0cyAtLWFsbCAtLW5vLXJldXNlLWRlbHRhIC0t
ZGVsdGEtYmFzZS1vZmZzZXQgLS1zdGRvdXQgPC9kZXYvbnVsbCA+L2Rldi9udWxsIiwgaXQgZ290
IHRvIDk5JSBmYWlybHkgcXVpY2tseSwgbm93IGl0IGhhcyA1IHRocmVhZHMgcnVubmluZyAodXNp
bmcgOTkuOSUgQ1BVKSwgYnV0IHRoZSAiZHN0YXQgNSIgc3RpbGwgc2hvd3MgbG90cyBvZiBub3Ro
aW5nLCB3aXRoIHNvbWUgaGVhdnkgc3lzdGVtIGFjdGl2aXR5Og0KDQotLXRvdGFsLWNwdS11c2Fn
ZS0tIC1kc2svdG90YWwtIC1uZXQvdG90YWwtIC0tLXBhZ2luZy0tIC0tLXN5c3RlbS0tDQp1c3Ig
c3lzIGlkbCB3YWkgc3RsfCByZWFkICB3cml0fCByZWN2ICBzZW5kfCAgaW4gICBvdXQgfCBpbnQg
ICBjc3cgDQogIDEgICA4ICA5MSAgIDAgICAwfCAxNjZrICAyMjRrfCAgIDAgICAgIDAgfCAgIDAg
ICAgIDAgfDY4OTIgICA5NzAgDQogIDAgIDEzICA4NyAgIDAgICAwfCAgIDAgICAgIDAgfCAzMzNC
IDE3NThCfCAgIDAgICAgIDAgfDIyODUgIDEzNzQgDQogIDAgIDEzICA4NyAgIDAgICAwfCAgIDAg
ICAgIDAgfCAzMDlCIDExOTBCfCAgIDAgICAgIDAgfDIyMzMgIDEyNjUgDQogIDAgIDEzICA4NyAg
IDAgICAwfCAgIDAgICAgIDAgfCAyODJCIDEwNTNCfCAgIDAgICAgIDAgfDIxNzQgIDEyMzkgDQog
IDAgIDEzICA4NyAgIDAgICAwfCAgIDAgICAgIDAgfCAyNzhCIDEyNTFCfCAgIDAgICAgIDAgfDE5
MzAgIDExNzMgDQogIDAgIDEzICA4NyAgIDAgICAwfCAgIDAgICAgIDAgfCAyNzRCICA5NDJCfCAg
IDAgICAgIDAgfDE5ODcgIDExMzkgDQogIDAgIDEzICA4NyAgIDAgICAwfCAgIDAgICAgIDAgfCAy
NjRCIDExNjhCfCAgIDAgICAgIDAgfDE5MjggIDEyMDUgDQogIDAgIDEzICA4NyAgIDAgICAwfCAg
IDAgICAgIDAgfCAzODhCIDI0MzVCfCAgIDAgICAgIDAgfDIyNDUgIDEyODAgDQogIDAgIDEzICA4
NyAgIDAgICAwfCAgIDAgICAgIDAgfCAyNjhCIDExNDVCfCAgIDAgICAgIDAgfDIyMjUgIDEyMjEg
DQogIDAgIDEzICA4NyAgIDAgICAwfCAgIDAgICAgIDAgfCAxNjRCICA3MzJCfCAgIDAgICAgIDAg
fDI2MDcgIDEzMzMgDQogIDAgIDEzICA4NyAgIDAgICAwfCAgIDAgICAgIDAgfCAxNTZCICA5OTZC
fCAgIDAgICAgIDAgfDIxMDAgIDEyNzAgDQogIDAgIDEzICA4NyAgIDAgICAwfCAgIDAgICAgIDAg
fCAyMDZCIDEwMTlCfCAgIDAgICAgIDAgfDIxOTIgIDEyOTYgDQogIDAgIDEzICA4NyAgIDAgICAw
fCAgIDAgICAgIDAgfCAxOThCICA4MjRCfCAgIDAgICAgIDAgfDIwMTkgIDEyMzYgDQogIDAgIDEz
ICA4NyAgIDAgICAwfCAgIDAgICAgIDAgfCAyNDVCICA0MzVCfCAgIDAgICAgIDAgfDE5NzQgIDEx
OTUgDQogIDAgIDEzICA4NyAgIDAgICAwfCAgIDAgICAgIDAgfCAyNTJCICA4NTVCfCAgIDAgICAg
IDAgfDE4NTIgIDExNjYgDQogIDAgIDEzICA4NyAgIDAgICAwfCAgIDAgICAgIDAgfCAyMzBCICA3
NThCfCAgIDAgICAgIDAgfDIwNjYgIDEyOTkgDQogIDAgIDEzICA4NyAgIDAgICAwfCAgIDAgICAg
IDAgfCAyODRCICA5MjVCfCAgIDAgICAgIDAgfDE4NjAgIDEyMjUgDQogIDAgIDEzICA4NyAgIDAg
ICAwfCAgIDAgICAgIDAgfCAyODlCIDI2ODJCfCAgIDAgICAgIDAgfDE3OTYgIDExOTcgDQogIDAg
IDEzICA4NyAgIDAgICAwfCAgIDAgICAgIDAgfCA5MzlCIDEyNjNCfCAgIDAgICAgIDAgfDE5MTMg
IDEzMDQgDQogIDAgIDEzICA4NyAgIDAgICAwfCAgIDAgICAgIDAgfDEyMTJCIDEzNjZCfCAgIDAg
ICAgIDAgfDE5MTUgIDEzNDMNCg0KSSB3aWxsIHRyeSBydW5uaW5nIHRoZSBjb21tYW5kIHVuZGVy
IHRoZSBkZWJ1Z2dlciBhbmQgc3RvcCBpdCB3aGVuIGl0IGdldHMgdG8gdGhpcyBwb2ludCBhbmQg
cG9rZSBhcm91bmQuDQoNCmZsb3Jpbg0K
