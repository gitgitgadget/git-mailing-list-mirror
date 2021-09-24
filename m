Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B77C433EF
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 18:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAA5461260
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 18:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346152AbhIXSic (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 14:38:32 -0400
Received: from mx0b-00209e01.pphosted.com ([148.163.152.55]:3374 "EHLO
        mx0b-00209e01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344684AbhIXSib (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 24 Sep 2021 14:38:31 -0400
Received: from pps.filterd (m0184430.ppops.net [127.0.0.1])
        by mx0b-00209e01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18OHBCom012338;
        Fri, 24 Sep 2021 14:36:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ncr.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pod1119;
 bh=yxMcN8rVok6HqmvSMwLrUHsRd72fL9Ye/bG65Mkg+n8=;
 b=kxYr9jMo6A2NliNmu5tO4YuXPH/7d490BYHa/CwisHgRwP3GKNB2AvQ2IobC5vrg5KY1
 ldhdEq6K6pkMZdfALLqv+gamyHmPE4TPPu1A4iPM5p1vhOb5QVodhXd5sF6/k+vSPU4m
 jyeG+6kDg79Zlgvu2Egiwf5iJSplmUTG8mK8LrRTCfb9igIVsGwjoBRHhbGIZ4mXd0Uf
 YfCRhm/oCq820FNV1vYGqEX9HLudAIxcT4Wott2CLvObI8FsklI1+2DPkONxSPgy4vdH
 aEPLRe5V+0MZ5S8fPLw7hKRy4eF1P/GCnB9IpG97Oj1YNpw4gqUWt696X+EsiSmKFD+j vA== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by mx0b-00209e01.pphosted.com with ESMTP id 3b93f2nyqg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Sep 2021 14:36:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C7//0ccS9T6Pb0ja3WQI9harpbvhxy+nClRAKJAogKKWUjGO2z0h7b0+k4tNN0WKZ9YQh10L7DsyLTsQX8eNscEWhwlQEx6/P9XlI2waxmOWP9N91294iXmc38ER0PcXRK58mfyeohbRAkv1ZeZfTfS6BpEFEB9c+aBC1gEjQjCcnIYb8tTIRoBMTvTZ7C9Tr9gbATpCQOZgGpeMnAfqkeRen383DsD8s//sDFjGHePNHgWJQEAgXp0PhGWJ8QO0fVi+f5N9lx+495lwETq2XaQwpQI2Te7P96hwybXq4EBJ/lpsaJcV2Wos8lT3hzNqg1IlHovOdrxL8UphEnMCGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=yxMcN8rVok6HqmvSMwLrUHsRd72fL9Ye/bG65Mkg+n8=;
 b=S5LkEEC/VgZ9T29V9aDvAHAqybVV1YgfhlqHxB35xPFch7jX3xH7Z8hq3xHqOl98PCu7lKjOTdNOZHUtHgPnPfCvir7UjPJb3hgIgbAtrKcjGhXZBGiqUjyjTx6Hyc3ICE0S3Gsq8RvM8zqqiabQonYrjB3ySoo73h6idW22w+oJZUpbr7wN/qO+Ayutnr4I2TRn85Jjnx5ao8ak7mg2yXfNt2XwMW/SN9Mo0jek0XVwnSipglc7zAAdEE8JEtBZM+tHsRnP8+emgvWenvC+FUGAagWjZwXTEOK8PhTtMHFZV2PMLrwwaVIVeZgSOiyOULeYKwvKKDOmivoqa0Eqtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ncr.com; dmarc=pass action=none header.from=ncr.com; dkim=pass
 header.d=ncr.com; arc=none
Received: from BN6PR15MB1426.namprd15.prod.outlook.com (2603:10b6:404:c4::18)
 by BN8PR15MB2529.namprd15.prod.outlook.com (2603:10b6:408:c2::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Fri, 24 Sep
 2021 18:36:51 +0000
Received: from BN6PR15MB1426.namprd15.prod.outlook.com
 ([fe80::fdf3:7fad:62b4:e015]) by BN6PR15MB1426.namprd15.prod.outlook.com
 ([fe80::fdf3:7fad:62b4:e015%12]) with mapi id 15.20.4544.014; Fri, 24 Sep
 2021 18:36:51 +0000
From:   "Russell, Scott" <Scott.Russell2@ncr.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Emily Shaffer' <emilyshaffer@google.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: pull failed - why should I receive this message.
Thread-Topic: pull failed - why should I receive this message.
Thread-Index: AdexUt9vq4ww6wDrT/SkOsyNHqWUqQAFrpQAAAAqpgAAAPPngAAA0Wow
Date:   Fri, 24 Sep 2021 18:36:51 +0000
Message-ID: <BN6PR15MB14262C7036B3C792CCE861D8CBA49@BN6PR15MB1426.namprd15.prod.outlook.com>
References: <BN6PR15MB1426A342CBA9D993C0C49E55CBA49@BN6PR15MB1426.namprd15.prod.outlook.com>
 <CAJoAoZ=DuqHe2brN8Y2Ts0_afEhUNrdasRBb1O8HHomLKRJ4PA@mail.gmail.com>
 <BN6PR15MB14261D1A350398C0C26793E1CBA49@BN6PR15MB1426.namprd15.prod.outlook.com>
 <000401d7b16e$17ea02d0$47be0870$@nexbridge.com>
In-Reply-To: <000401d7b16e$17ea02d0$47be0870$@nexbridge.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_Enabled=true;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_SetDate=2021-09-24T18:29:13Z;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_Method=Privileged;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_Name=dc233488-06c6-4c2b-96ac-e256c4376f84;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_SiteId=ae4df1f7-611e-444f-897e-f964e1205171;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_ActionId=218f5e79-2166-43a3-9927-d2634a407dae;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_ContentBits=0
authentication-results: nexbridge.com; dkim=none (message not signed)
 header.d=none;nexbridge.com; dmarc=none action=none header.from=ncr.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f237ce6-98b9-47af-8de3-08d97f8a4671
x-ms-traffictypediagnostic: BN8PR15MB2529:
x-microsoft-antispam-prvs: <BN8PR15MB2529E79F26778E6A68AE5494CBA49@BN8PR15MB2529.namprd15.prod.outlook.com>
x-from-ncr-tenant: Processed
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s/jsbFa/SNuz5mUrizlTCVK/v1CMp+tLbsXTukcodiRD7PsZfeB0M3dHo5Zb2uZFIM97VenJY/QUGmBzQiy/4Ih0hZskIpmlRExNOj9+UzQIlpU097DWoxGidav5wAGE8tCK1rYpnTD86zULGHaXVT73UAgL04Yj9/KoJnOGSZdwkI/H2bOuZmCaLbp+mvR2J4o3f+cyfkn9YkRKV0FRWwqCPiHUr+d8H168iyUs4TgNHY6qbhasjhqVTPDxI5ESenO/wr9ZJhsodgm2Vb0KwS8/T1eBNf/1l44SaXFmapvQ3QCem54QIPdE55d1idmdDRHbQihiZ4GT/DCqfr5bRtlLGejF7rP8niRZ2Cb8l6zCNuUWcNKeSrXRCOtYVac+DM7TI9Q0wOw+IBLEyUdAYqyJqbWZYJEZ2N2SNeMnUb92ahpB/3Wgb3DKKdOTPK9oz32Rpe0H3xVtr7khK7a6bMjzAbMYRwB/XztALRTcZp4x7BEaqelGLTjDX4uoOT+Me3pQ/wJnhiE0CTmSOcciYm+dzlG/ePYkaokB7wbcJOvY93JyII59OAuYLsYxf0f8dp7KHVO8MJFQbaapGi3m7UaHMOrDwtqNM+J5fh32QGHGSNogInNy6CtrLmPfNZPqD3k4ImrRDoGYbiUJrFbOtLlA/liLxNEVmLAlkWor6a0GUnks3ZWoaOFet+huMU8E2H2x3LpiKTP7vFGTOsMWEZS/EkoVkR601gwA9OiP81M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR15MB1426.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(15650500001)(316002)(8676002)(122000001)(508600001)(64756008)(38100700002)(33656002)(66946007)(66556008)(66476007)(4326008)(66446008)(86362001)(76116006)(110136005)(2906002)(83380400001)(52536014)(8936002)(6506007)(53546011)(5660300002)(38070700005)(71200400001)(26005)(55016002)(7696005)(186003)(9686003)(460985005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bDljV0dnd2haSXVKNitSNEM3NTNreDNWdWliejJPUU1zbWxtVTNFSm9kUzRK?=
 =?utf-8?B?ek1UZGY4OHVDNHR5MVFPLzFId3BORC9aMGx6WnA0NW15elRKTFJBaGtpNXBU?=
 =?utf-8?B?R21YdGxmSHdCL1ZuSkM2aitzeFlxMXRPdXpzL01wLzZlV0pnd09sbWx0VlJS?=
 =?utf-8?B?SW9yN0ovVDJCV0NtSHMwMUpINWI1aE5pZXZWU0V2TGVnNHZJTHE3U3d6eitE?=
 =?utf-8?B?K28vWU1hRkNsYnVvMi9WNk1zamJJaTJmT0M4b29SNC94aWE5MFVUM3NSUTV4?=
 =?utf-8?B?QVhTOTdQRmlEUkZYNXp5SndIdkxYSm1RMlNzZ0pNWStoanpXS0VMbGoyNlVR?=
 =?utf-8?B?K1Q3azdFSnptVFNVdUFUS2VmQmFETzA4bHUwbi9pWXhwdVVKMjZZc2dTOERS?=
 =?utf-8?B?cVBBWEZ0blFmNG9NRExTUW8rb3BMb3BWajRRd1l4bEFuY2dYNzQvV3NHa2Zk?=
 =?utf-8?B?aWtJZjZ2YkROQjJ5ZDhEQWlWQ2ltaGpsTXUyRGJCQW1pTUYvRjBNMXFDQnN1?=
 =?utf-8?B?bytXSWwxU2svK3dSVy9YUkN1U1UwSS9QNFVNZ3VpZGFJQVl6d1dkbk5tdUFP?=
 =?utf-8?B?M21kdFlYeUV0b01jT1FNUVRaNW4vaElrM0IzNURFTm9QTGtYK2VtQVJSb2Zq?=
 =?utf-8?B?cENSSmdsVm45TGlZaHJ3YzMrVENxWHdxZDloNG9namVCbVV6NUdndXNDbmR6?=
 =?utf-8?B?QTJjdDVicVhXUUhPTGYyQW41NkhobzZ0ZGJjUUVOdlVWUWoxYlNRWFBxRUhZ?=
 =?utf-8?B?UHNlaHRLRXY0cnpKTUM0OVpFbE1NVWxKR0Qwdm9sU3VheFpUeDBPR28zc0VU?=
 =?utf-8?B?YXR4Y2xLUVo1Z0hpcnJrSGhsd3FHaHFpbzBNOG5FU2JNekgzT1o0SC84ZUpq?=
 =?utf-8?B?b0VpMUpQS1pad0thTS9UbWlVWXh1ZXJkVkhwRDhoMUcrKzIxTmcrdkNLOWpx?=
 =?utf-8?B?UklvVHA4MW5MUkxvckNOZmw3L3E4WDd3SHpSTWVUMTdWS2VwbVRud0E3bk5v?=
 =?utf-8?B?ODJzMmFEK0lqcWhCb25hYURLZ3lIVzRSOTdnMGVlZWpYeUExdldlTURiQ1JQ?=
 =?utf-8?B?bEc0WEhUMlcra3ljdHNEWkhJSUpMTkFmYVQwZFdaeTZVRmNBZCtKdjM4dnhw?=
 =?utf-8?B?Qlh0TkdsNzZrT3RhcXJhenRkMXRvMGd2UHN1WFYzeUlkMVhVMDRDUERvSHhq?=
 =?utf-8?B?a0hyYU1LRkViRlloTkQ5aHBNbzh0Y1NKcW5DenJIU2NNSlFEOVNvd01ob00y?=
 =?utf-8?B?NS9CT0hmdTNVTzJWQ0h2cCtNL1VnR01lVy9XRWY0cGtpT1hZWjJveHVTOHlU?=
 =?utf-8?B?eEVaZFZlOCt1b0l6QjhZVUVXQTZDMm1ObWszZFBXOXBDQjVwc3lIeU05QzFM?=
 =?utf-8?B?MVRuenhHQUNMdVc2QnBqVXJ1akJ2NTgwUDloYkhiNTNDSUxzbm1xdFhwTWh2?=
 =?utf-8?B?eWUxc3gzSEFtc3RVSjdZaXlLdzZtdDI1QUU0SGtoZXZFT2p1MFJVN09uUzlL?=
 =?utf-8?B?Z214c1pFRXF3eVM4Ymg1UkFleVphTG1VMjRXOFgvbDNoZHRROUR4SlkvS1Ny?=
 =?utf-8?B?Y0lJVlBXMHJwRmtWeFVkbGw2aWtJTVhTQWpRSkFlZDF4dS9jdjVLeDlOTHNL?=
 =?utf-8?B?Z0s2cndEVWlKenF1S1BmYlhnK1N5enM3c0E5bWhYbWRWLytxeWVYbFUzWGxF?=
 =?utf-8?B?d2dNeTdFd1BpNkJ2QTg1QmluNnZUZmk1NlNEcmxEdTArR3B5RnFxKzVQS2FJ?=
 =?utf-8?Q?YH7+AEtBT8+RBLXOXW6sj7BzQEJZZKzQuOaxEV9?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ncr.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR15MB1426.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f237ce6-98b9-47af-8de3-08d97f8a4671
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2021 18:36:51.2237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ae4df1f7-611e-444f-897e-f964e1205171
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /iuGy3cZMSp8bAJWmaeI8qmS99p5/hu7dVkf28rLMztDXHcGQqk6Xcf5ZxwIB65jGV4Y4Xqp733iRJwUEzJ6Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2529
X-Proofpoint-GUID: 5gNX_vv4pncHiZW-XWKhZ9bwRG5FJZl-
X-Proofpoint-ORIG-GUID: 5gNX_vv4pncHiZW-XWKhZ9bwRG5FJZl-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-24_05,2021-09-24_02,2020-04-07_01
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

UmFuZGFsbCwgIA0KDQpUaGFua3MgZm9yIHlvdXIgYW5zd2VyLiAgIEhvd2V2ZXIsIHRoaXMgaXMg
YSBidWlsZCBzeXN0ZW0uICAgDQpHaXQgY2xlYW4gLWR4ZiB3b3VsZCBkZWxldGUgYWxsIHVudHJh
Y2tlZCBmaWxlcyAtIG5vdCBqdXN0IHRoZSBjb25mbGljdGVkIG9uZXMuIA0KDQpXZSBtdXN0IGtl
ZXAgYWxsIHVudHJhY2tlZCBmaWxlcyB0aGF0IHdvdWxkIG5vdCBiZSBjb25mbGljdGVkIGJ5IHRo
ZSBwdWxsLiAgDQpPdGhlcndpc2UsIHRoZSByZXN1bHQgd291bGQgYmUgb3VyIGJ1aWxkIHdvdWxk
IG5lZWQgdG8gZG8gYSBmcmVzaCBidWlsZCBvZiBhbGwgb2JqZWN0cyBhbmQgYnVpbGQgdGFyZ2V0
cyAtIHRob3NlIGFyZSBhbGwgdW50cmFja2VkIGFzIHdlbGwuICANCkluc3RlYWQgb2YgdGhlIGRl
c2lyZWQgY2FzZSBvZiBqdXN0IGJ1aWxkaW5nIHRoZSBjaGFuZ2VkIGZpbGVzIGFuZCB0aGVpciBy
ZXN1bHRhbnQgdGFyZ2V0cy4gDQoNCldlIGp1c3QgbmVlZCB0aGUgcHVsbCB0byBvdmVyd3JpdGUg
YW55IHVudHJhY2tlZCBmaWxlcyB0aGF0IG1heSBleGlzdCBpbiBjb25mbGljdCB3aXRoIG5ld2x5
IHRyYWNrZWQgZmlsZXMuICANCg0KSSBzZWUgZ2l0IGlzIHRyb3VibGVzb21lIGluIHRoaXMgc2l0
dWF0aW9uLiAgIEV2ZXJ5IHRpbWUgYSBkZXZlbG9wZXIgYWRkcyBhbiB1bnRyYWNrZWQgZmlsZSB0
byB0aGUgcmVwbyAtIHJlZ2FyZGxlc3Mgb2YgdHlwZSwgDQpJdCB3aWxsIHJlc3VsdCBpbiBmYWls
dXJlIG9mIHRoZSBwdWxsLiAgIEFuZCBhIGZhaWx1cmUgb2YgdGhlIGJ1aWxkLiAgDQoNCg0KVGhh
bmtzLCANCg0KU2NvdHQgUnVzc2VsbA0KTkNSIENvcnBvcmF0aW9uwqANCiAgICANCg0KLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFJhbmRhbGwgUy4gQmVja2VyIDxyc2JlY2tlckBu
ZXhicmlkZ2UuY29tPiANClNlbnQ6IEZyaWRheSwgU2VwdGVtYmVyIDI0LCAyMDIxIDI6MDEgUE0N
ClRvOiBSdXNzZWxsLCBTY290dCA8U2NvdHQuUnVzc2VsbDJAbmNyLmNvbT47ICdFbWlseSBTaGFm
ZmVyJyA8ZW1pbHlzaGFmZmVyQGdvb2dsZS5jb20+DQpDYzogZ2l0QHZnZXIua2VybmVsLm9yZw0K
U3ViamVjdDogUkU6IHB1bGwgZmFpbGVkIC0gd2h5IHNob3VsZCBJIHJlY2VpdmUgdGhpcyBtZXNz
YWdlLg0KDQpPbiBTZXB0ZW1iZXIgMjQsIDIwMjEgMTozNCBQTSBTY290dCBSdXNzZWxsIHdyb3Rl
Og0KPg0KPlRoYW5rcyBmb3IgeW91ciBhbnN3ZXIuICAgSXMgdGhlcmUgbm90IGFuIG9wdGlvbiBv
biB0aGUgcHVsbCB0byBoYXZlIGdpdCB0byBvdmVyd3JpdGUgdGhlIGV4aXN0aW5nIGZpbGVzPw0K
Pg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogRW1pbHkgU2hhZmZlciA8ZW1p
bHlzaGFmZmVyQGdvb2dsZS5jb20+DQo+U2VudDogRnJpZGF5LCBTZXB0ZW1iZXIgMjQsIDIwMjEg
MToyOSBQTQ0KPlRvOiBSdXNzZWxsLCBTY290dCA8U2NvdHQuUnVzc2VsbDJAbmNyLmNvbT4NCj5D
YzogZ2l0QHZnZXIua2VybmVsLm9yZw0KPlN1YmplY3Q6IFJlOiBwdWxsIGZhaWxlZCAtIHdoeSBz
aG91bGQgSSByZWNlaXZlIHRoaXMgbWVzc2FnZS4NCj4NCj4qRXh0ZXJuYWwgTWVzc2FnZSogLSBV
c2UgY2F1dGlvbiBiZWZvcmUgb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KPg0KPk9uIEZy
aSwgU2VwIDI0LCAyMDIxIGF0IDEwOjA4IEFNIFJ1c3NlbGwsIFNjb3R0IDxTY290dC5SdXNzZWxs
MkBuY3IuY29tPiB3cm90ZToNCj4+DQo+PiBGaWxlcyBub3QgcHJldmlvdXNseSBpbiBnaXQgd2Vy
ZSBhZGRlZCB0byBnaXQuICAgV2h5IHNob3VsZCBJIGhhdmUgdG8gbWFudWFsbHkgZGVsZXRlIHRo
ZW0/DQo+PiBXaHkgY2FuIGdpdCBwdXQgbm90IHJlcGxhY2UgdGhlbT8gIFRoZXkgd2VyZSB1bnRy
YWNrZWQgZmlsZXMgdGhhdCBhcmUgbm93IHRyYWNrZWQgIGFuZCBzbyB0aGUgZ2l0IGNvcHkgaXMg
ZGVzaXJlZC4NCj4+IFdlIGNhbid0IGFsd2F5cyBrbm93IGFoZWFkIG9mIHRpbWUgd2hhdCBmaWxl
cyBtYXkgaGF2ZSBiZWVuIGFkZGVkIGVsc2V3aGVyZS4NCj4NCj5UbyB0dXJuIGl0IGFyb3VuZCBv
biB5b3UsIHlvdSBjYW4ndCBhbHdheXMga25vdyBhaGVhZCBvZiB0aW1lIHdoYXQgDQo+ZmlsZXMg
bWF5IGhhdmUgYmVlbiBhZGRlZCBlbHNld2hlcmUsIHNvIHlvdSBjYW4ndCBiZSBzdXJlIHRoYXQg
eW91ciANCj5uZXdseSBhZGRlZCB1bnRyYWNrZWQgZmlsZSBsb2NhbGx5IHdpbGwgYmUgc2FmZSBm
cm9tIGJlaW5nIG92ZXJ3cml0dGVuIGR1cmluZyBhIHB1bGwuIEhvdyB1cHNldHRpbmcgaWYgeW91
IHNpbmsgMzAgaG91cnMgaW50byBuZXdsaWIuY3BwIGFuZCB0aGVuIHlvdXIgdGVhbW1hdGUgY2hl
Y2tzIGluIHRoZWlyIG93biBuZXdsaWIuY3BwLCBhbmQgeW91cnMgaXMgb3ZlcndyaXR0ZW4gd2l0
aG91dCBhc2tpbmcgd2hlbiB5b3UgcnVuICdnaXQgcHVsbCcuDQo+DQo+WW91IG1pZ2h0IGhhdmUg
c29tZSBsdWNrIHdpdGggdGhlICctLWF1dG9zdGFzaCcgb3B0aW9uLCB3aGljaCB3b3VsZCBhdCAN
Cj5sZWFzdCBwcm9tcHQgeW91IHdoZXRoZXIgdG8gZ2V0IHJpZCBvZiB0aGluZ3Mgd2hlbiB0cnlp
bmcgdG8gbWVyZ2UgdGhlbSANCj5iYWNrIHRvZ2V0aGVyIGR1cmluZyB0aGUgYXV0b21hdGljICdn
aXQgc3Rhc2ggcG9wJyBhdCB0aGUgZW5kLiBPciB5b3UgY291bGQgcnVuICdnaXQgY2xlYW4gLS1m
b3JjZScgdG8gYXV0b21hdGljYWxseSBkZWxldGUgYW55IHVudHJhY2tlZCBmaWxlcyB5b3UgbWln
aHQgaGF2ZSAtIHlvdSBjb3VsZCBldmVuIGFsaWFzIHlvdXJzZWxmIGEgY29tbWFuZCBsaWtlICdn
aXQgZGFuZ2Vyb3VzLXB1bGwnIHdoaWNoIHJ1bnMgJ2dpdCBjbGVhbiAtZiAmJiBnaXQgcHVsbCcu
DQo+DQo+Pg0KPj4NCj4+IFdlIG5lZWQgdGhlIHB1bGwgdG8gd29yayBhdXRvbWF0aWNhbGx5Lg0K
Pj4NCj4+IGVycm9yOiBUaGUgZm9sbG93aW5nIHVudHJhY2tlZCB3b3JraW5nIHRyZWUgZmlsZXMg
d291bGQgYmUgb3ZlcndyaXR0ZW4gYnkgbWVyZ2U6DQo+PiAgICAgICAgIFN0YWdpbmcvQ0FEREFw
cHMvQ0FERFVJSGVscGVyL1NvdXJjZS9SZWxlYXNlL0NBRERVSUhlbHBlci5leGUNCj4+ICAgICAg
ICAgU3RhZ2luZy9DQUREQXBwcy9DQUREVUlIZWxwZXIvU291cmNlL1JlbGVhc2VfVW5pY29kZS9D
QUREVUlIZWxwZXIuZXhlDQo+PiAgICAgICAgIFN0YWdpbmcvQ0FEREFwcHMvSW5zdGFsbERyaXZl
cnNQYWNrYWdlL1JlbGVhc2UvSW5zdGFsbERyaXZlcnNQYWNrYWdlLmV4ZQ0KPj4gICAgICAgICBT
dGFnaW5nL0NvbW1vbi9OQ1JDb21tb25DQ0xpYi9Tb3VyY2UvUmVsZWFzZS9OQ1JDb21tb25DQ0xp
Yk1zZy5kbGwNCj4+ICAgICAgICAgU3RhZ2luZy9EZXZpY2VzL05GQy9FbGF0ZWNfUkZJRFJlYWRl
ci9CaW4vRGlyZWN0b3IuZXhlDQo+PiAgICAgICAgIFN0YWdpbmcvRGV2aWNlcy9ORkMvRWxhdGVj
X1JGSURSZWFkZXIvRmlybXdhcmUvQXBwQmxhc3Rlci5leGUNCj4+ICAgICAgICAgU3RhZ2luZy9E
ZXZpY2VzL05GQy9FbGF0ZWNfUkZJRFJlYWRlci9GaXJtd2FyZS9mbGFzaC5leGUNCj4+ICAgICAg
ICAgU3RhZ2luZy9VdGlsaXRpZXM2NC9TU1BTV0RyaXZlckluc3RhbGxlci9CaW4vRElGeEFQSS5k
bGwNCj4+ICAgICAgICAgU3RhZ2luZy9VdGlsaXRpZXM2NC9TU1BTV0RyaXZlckluc3RhbGxlci9C
aW4vRHJpdmVyRm9yZ2UudjQuNS40LmV4ZQ0KPj4gICAgICAgICBTdGFnaW5nL1V0aWxpdGllczY0
L1NTUFNXRHJpdmVySW5zdGFsbGVyL1NvdXJjZS9SZWxlYXNlL1NTUFNXRHJpdmVySW5zdGFsbGVy
LmV4ZQ0KPj4gICAgICAgICANCj4+IFN0YWdpbmcvVXRpbGl0aWVzNjQvU1NQU1dEcml2ZXJJbnN0
YWxsZXIvU291cmNlL1JlbGVhc2UvU1NQU1dEcml2ZXJJbg0KPj4gc3RhbGxlck1zZy5kbGwNCj4+
DQo+PiBTdGFnaW5nL1V0aWxpdGllczY0L1NTUFNXVGFza01nci9Tb3VyY2UvUmVsZWFzZS9TU1BT
V1Rhc2tNZ3IuZXhlDQo+DQo+T3IgYmV0dGVyIHlldCwgeW91IGNvdWxkIGF2b2lkIGNoZWNraW5n
IGluIGNvbXBpbGVkIGJpbmFyaWVzIGxpa2UgdGhlc2UgDQo+YW5kIGluc3RlYWQgYWRkIHRoZW0g
dG8geW91ciAuZ2l0aWdub3JlLCB1bmxlc3MgeW91IHJlYWxseSBtZWFuIHRvIA0KPnVwZGF0ZSB0
aGVtIGV2ZXJ5IHRpbWUgc29tZW9uZSBtYWtlcyBzb21lIGNoYW5nZS4gV2hlbiBjaGVja2luZyBp
biANCj5iaW5hcmllcywgeW91IHNob3VsZCBiZSBhd2FyZSBvZiB0aGUgYWRkaXRpb25hbCBkaXNr
IG92ZXJoZWFkIG5lZWRlZCB0byBkbyBzbyBhbmQgdGFrZSBhIGxvb2sgYXQgc29tZSBvcHRpb25z
IEdpdCBoYXMgdG8gbWl0aWdhdGUgdGhhdCBvdmVyaGVhZCwgbGlrZSBwYXJ0aWFsIGNsb25lLiBI
b3dldmVyLCBpbiBtYW55IGNhc2VzIHRoZSBlYXNpZXN0IHdheSB0byBtaXRpZ2F0ZSB0aGF0IG92
ZXJoZWFkIGlzIHRvIHNpbXBseSBub3QgY2hlY2sgaW4gYmluYXJpZXMgdW5sZXNzIHlvdSBhYnNv
bHV0ZWx5IG5lZWQgdGhlbSB0byBiZSB2ZXJzaW9uIGNvbnRyb2xsZWQuDQo+DQo+LSBFbWlseQ0K
DQpJZiB5b3UgYXJlIHNjcmlwdGluZyB0aGlzLCB0cnkgdXNpbmcgZ2l0IGNsZWFuIC1keGYgYW5k
IGdpdCByZXNldCAtLWhhcmQgYmVmb3JlIHJ1bm5pbmcgdGhlIHB1bGwuICBUaGF0IHdpbGwgY2xl
YW4gdGhlIG9iamVjdHMgb3V0IG9mIHlvdXIgd29ya2luZyBkaXJlY3RvcnkuDQoNCi1SYW5kYWxs
DQoNCg==
