Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CADBC4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 22:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20B4F60E90
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 22:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbhHPWFN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 18:05:13 -0400
Received: from mx0a-00209e01.pphosted.com ([148.163.148.55]:53536 "EHLO
        mx0a-00209e01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231707AbhHPWFM (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 16 Aug 2021 18:05:12 -0400
Received: from pps.filterd (m0131214.ppops.net [127.0.0.1])
        by mx0b-00209e01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17GM23r8000865;
        Mon, 16 Aug 2021 18:04:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ncr.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pod1119;
 bh=p0hfWUTB7kabV1B2wmYhsihQEzfiTqSz+b4oL4kH9MQ=;
 b=dzUofMmWnTAKvSi4kt3KcZ/q5ghYpBFUrygc46WUzFHpFdCVcKo1ak3Syt+RcjM+bWiL
 f/7j/ElN0av3AkaKEM/UMX280WaUbz1//VGwWPvFYNphDQOgZIa9+UlxqbOBgztrd3XW
 aF0rIF4PPWiPqMzSNwGTzh2xe7XXg5YlZCN3B0tFFsgLU66P6mDX5B9qIl2T+cufufE2
 rk4goOWras74Os+2gRBYqbeCGD9PtlaymuRjq0M52kjnPHXX3qggq35RmmcJnYQ+x+yi
 hxFh6uhl0AgA2+vOW48bXO06RK98FaP1+xjWyuM0B5AqUqJYIJ+qwyjv0jGILxl7OAA3 jg== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by mx0b-00209e01.pphosted.com with ESMTP id 3afrtvtry4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Aug 2021 18:04:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YAW3A87MC8UYHoLy6EuqR3k+zZ/RVZVV5ynHeQxxSGAD/GJ96J5jYZ4POdbu01MuA8dwO26qsRewvfj4gKn6AwVNaks3EkXaI4atMKFv96ZwCC5sovQWygk2gQyCbdWrFJ9rdFFuP960oh34MejdYvrg/ReWLkQKsgOlql/JfXtzQVnfbrrAscL6x4I4195a4mp3Bhtiqr3g31PmSm1y/YCSDqJ7t2qyrjbmelz39bRCZlJuiIq/puiDqWUw0EOEA4I8tETkunJ6H3sLzXJ2x0WA13M6nElvPihV/hAccjEoxTuFmuGjI4RM9K7dApbivSZAufCN9MC/qfAvAhq0/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0hfWUTB7kabV1B2wmYhsihQEzfiTqSz+b4oL4kH9MQ=;
 b=SOiVSpyMQAL7qaiAMPG0h1wApaoY7ztq5AfOde/5NBbb2Tue8gaVaep8DP7SerlddqvE0G2ArDfN67/PhBz5X9BHi3/A2zWzTOkRuqh7r2bo1cu6WJcn/+qGbzGJb0A91mkLExYEmyXwMviL+pyNiRf1ihFhfXR8p4AQ60SEscWORjneuda6SFpKY8A8SuWRIin3VzyfOznoZBDSEUnaWmvjD2o6RWytX6dh00hqux9l2F0hMKG6GlZnB9bkrgx6YXRYs3E3Q8tjQqU1RuUsbVGC+L0utCy/X82SwDOUyT9MoR7O4TSz0H1kezHPcS5spcr+N+Rp+ww51iw+FHBpyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ncr.com; dmarc=pass action=none header.from=ncr.com; dkim=pass
 header.d=ncr.com; arc=none
Received: from BN6PR15MB1426.namprd15.prod.outlook.com (2603:10b6:404:c4::18)
 by BN8PR15MB4241.namprd15.prod.outlook.com (2603:10b6:408:76::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Mon, 16 Aug
 2021 22:04:21 +0000
Received: from BN6PR15MB1426.namprd15.prod.outlook.com
 ([fe80::21ab:b879:3cff:87c3]) by BN6PR15MB1426.namprd15.prod.outlook.com
 ([fe80::21ab:b879:3cff:87c3%6]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 22:04:20 +0000
From:   "Russell, Scott" <Scott.Russell2@ncr.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: git clone corrupts file.
Thread-Topic: git clone corrupts file.
Thread-Index: AQHXkui+FYBcWaT2QVKI1LhsxFP/Cat2rE3A
Date:   Mon, 16 Aug 2021 22:04:20 +0000
Message-ID: <BN6PR15MB1426DAA212EC5A9E89E19176CBFD9@BN6PR15MB1426.namprd15.prod.outlook.com>
References: <BN6PR15MB1426E50F03A0530CA9140F98CBFA9@BN6PR15MB1426.namprd15.prod.outlook.com>
 <BN6PR15MB14261C40E614CC11416388B4CBFA9@BN6PR15MB1426.namprd15.prod.outlook.com>
 <BN6PR15MB14264C9A96F4B5F6B01FA7FACBFA9@BN6PR15MB1426.namprd15.prod.outlook.com>
 <YRbya0UO2+PvOjL5@camp.crustytoothpaste.net>
 <BN6PR15MB1426E99386269CCBDA888D51CBFD9@BN6PR15MB1426.namprd15.prod.outlook.com>
 <YRqYD+SszvhhySwl@coredump.intra.peff.net>
 <YRqzmC5ubd0TEWL/@coredump.intra.peff.net>
 <YRrdq5VAp3o35+Fb@camp.crustytoothpaste.net>
In-Reply-To: <YRrdq5VAp3o35+Fb@camp.crustytoothpaste.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_Enabled=true;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_SetDate=2021-08-16T21:53:05Z;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_Method=Privileged;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_Name=dc233488-06c6-4c2b-96ac-e256c4376f84;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_SiteId=ae4df1f7-611e-444f-897e-f964e1205171;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_ActionId=d249fe89-f6f7-4b6a-9628-c780aa0d57bd;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_ContentBits=0
dlp-product: dlpe-windows
dlp-version: 11.3.0.17
dlp-reaction: no-action
authentication-results: crustytoothpaste.net; dkim=none (message not signed)
 header.d=none;crustytoothpaste.net; dmarc=none action=none
 header.from=ncr.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7b7396fc-f9db-4583-53de-08d96101ccc3
x-ms-traffictypediagnostic: BN8PR15MB4241:
x-microsoft-antispam-prvs: <BN8PR15MB42415D267D06F51337614189CBFD9@BN8PR15MB4241.namprd15.prod.outlook.com>
x-from-ncr-tenant: Processed
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T+9rXxWcLtbkYSseamBLD0rEsWG3lSUXI7iqvWIHjA+4ep0I9a+n4QXEySOATe44uuDVWKOQBgi0laQeFlQVVb9a2jG+r7B0Kynj+8NVaWIDdBu4zgEjJ1Ya5Yg9LOkzzbv5LYaDjaEZ+dp203uGrJQH3UEBCxhh/N7374CmlzCPtcC1VNz969B1CUm7q3ShEeZgA0kVrV9LzIYh9FsvplOgxWWclJtzej9M2qf8trmzTn/BbUx9YYCKphgFh4nZ4AhnASsF0/ImaWSfGH0VipHxabwwk6zVLlOLKlPugAC3HlQK++WEYjTPZ0oqaoVPwxKvdC2mtDGT6AXLyTC8Z+IjZvEVPYxwbkhFPAttgBFx4yZOodiCKICS2dCoSjDJHJQqEbmFOu7lmkvPm1mPT9XvjMSO2r9G38WmUDg2TltYlkg8LFhWanPXehYKxhMpgr6EYq+Jdrlz0QI+5T8k1CI6pDw2rEQ6F5y4/9V8VL57WfJ+qJi4BmFLK+BlnL0BsF/9veN22a0uNCnmOJ7IjhylCimiQzsLF3dblcPGTbTtSRiCOLWlk2okH27gfXK+ynprXr9o0VXAnZ6U/a8DXiRQQLsJnR0ket5oL9PVxvUNI81KmpoarNllWrNwUXttwcdTmpjS8FDq3pHGeQ7t4roniFLXWdGUhWNTyHMxIOJ6KFquDeu7tv7fEvbcsIHCWKQ1NGnCOZQo49B3EVPuY5raIWC1rkk3hlLLJf/u0VHPSosnsQfyk9Wk5+dHZDYEg0aXVYJHDGglZ4DUQLMkAL+lrX0LYQ6vte0fOsos/TI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR15MB1426.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(83380400001)(5660300002)(53546011)(122000001)(6506007)(7696005)(52536014)(316002)(38070700005)(33656002)(2906002)(9686003)(4326008)(71200400001)(3480700007)(186003)(64756008)(66446008)(66556008)(66476007)(26005)(966005)(110136005)(478600001)(38100700002)(86362001)(8676002)(55016002)(66946007)(8936002)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QitPd0hOdXN1UEkwVnBwSjhUcTV6K0xSRFh1bDFndUN5WTJUZnc3Y0NEMTBR?=
 =?utf-8?B?R3k4Y281U2lQKzV1QlBMeEd6THo3Nmpvdm8yYThyeGc5bC9sVE5oM0lHUEhG?=
 =?utf-8?B?ZWwybGZZWFFjMHVlRFhNQ0NZeWFXb05tYW9FanFiaEJYOVF5aVpkR2V2d1g5?=
 =?utf-8?B?bmJ3b01TWVhEa2VjbW1lZVZocU5oN1N2VEJmamJwSDBWRDVrclJuNk8zYlNu?=
 =?utf-8?B?Y1FhWURwL25QckpmY0U4VDR4dDJ3bUs2dENRNXI1NFlURVJabDZEVG5ZQ2ho?=
 =?utf-8?B?bmFuS21QbXkxU0E5OThoRExobXNxSkkzMnJ5b00zME1WTkVsWGdNOW5XczF3?=
 =?utf-8?B?aWFnNysvNnp4ZnNLVVpxK3RzeFNZM2gySnRUNGtaRFlQcEtnREYvVzZ1RG9M?=
 =?utf-8?B?L21ZNG1qK1RKMU9Vb3JicmhLMFI1N2FXMlRIbjVNSXZ5dDJKcFpTY3hvODdU?=
 =?utf-8?B?dzB4L2Q4S1hjenMzZmtzNUl5NGU4ZlFDZkp0M2I3aGQ2MlFkMTk1a1lBb2Rr?=
 =?utf-8?B?elIvSUUrV0dCMndVdjlXQnpRRVBiU0NCTWxDWGMxM2ZrNXNTWXF2MTlaU2cz?=
 =?utf-8?B?SEdpYnJOYURDb3pCa2sxK2dIR2dYNGxLTjhvWUNVTXhCVGUzSTE5eWVBOTU2?=
 =?utf-8?B?QXpjOHlLNkt2TTc3SStKZGxTempwaitNSlNQWEdWejJQcVF0VlpVUm9yeTBi?=
 =?utf-8?B?ZitvWGVYZndRd2hET21pQkZSb092a3Awd1RWaitweE9NL0xUZGtRbjBITlhJ?=
 =?utf-8?B?cUNPenF0cFcyZDRJSVpjVS9TeDFMaDJ1cThHdWtzWVYxZlowajRtQTBCa28x?=
 =?utf-8?B?UG83R2JwL2lkY2x6QlRyd2pLcDd4Vk1qWnRGZkFaNEEzRTVtQ2ZCSlVsMmdx?=
 =?utf-8?B?bHZYNUc5Tk1mKytIeTlGUllETGJOQ2JnaW1nRndEcVZ1eUQ4YkEydVpKenFo?=
 =?utf-8?B?TmUzZFYrZTFCbnpKUWRDVFdEVUxncEFCTFVOYjRCV0ltc2pyQmRhMXNkOXpa?=
 =?utf-8?B?UnJhcmtMemhFalBibmEvdWpiaDMrbFN4bW9JNVErTVRESXhFUDE1TSthbm5y?=
 =?utf-8?B?QmZTMlZlRHY1YVcvYW51bWRxLzRnNjdNREFrUXRyLy9hK29OZkFSVGt0TUxi?=
 =?utf-8?B?SmpXazR5TjV1U2hLUW00elZ6K085RyszS2gyNm44RC9sZ1IxWE4vUTBhYnd1?=
 =?utf-8?B?eTYwZFRNZmxLWFNMbDhTVThENDM5NGRuWFVRT1RwY2x6M1FYSkZHZW9oWnQ5?=
 =?utf-8?B?OG5MMUs2OGo1SmZUU2pob2V0b0dZbTliVVFpbU4waFFicGdCUkJ2ZWM3OTM2?=
 =?utf-8?B?RUZvc3Rrb2VvYlBSWkhseVllN1BMdURwWEZOczk2QkJLTUt0bmQyVExnejhN?=
 =?utf-8?B?K0VsVW12V3hiQjQvN1R3MGlUdVFPTW40dDJiN0VEb1FZcjBjcGwyVHIvakFQ?=
 =?utf-8?B?WlRZM1RQVzArOU1XMGVPMW56eFVMUnc2ZkZEaE1yZFkwd0VMdjd1RHBlU2cz?=
 =?utf-8?B?dFFLRm5YbVkxcEcvTnJUSXdWVTRROTZ1NEo3blJDYlRYWWVWZTdZcGxmWTBn?=
 =?utf-8?B?QmlCcUtnZThjZnpYVHhXOGIwUWxrbStDdlJaclNNZ2gwdUV0dS9iSE1lZ0E2?=
 =?utf-8?B?OS9DZ0gvK2JiL2V4dTgyd2FaYUFrZi8vVXRvUkRJVUtWa1l5cXhYSVQzYlk0?=
 =?utf-8?B?MWtQMG5OZExhRGZ2VytjNy9Pc21yR28vcGVhdTFUSXMvcGV2MWk0R2xmL2ZR?=
 =?utf-8?Q?5f5DLhFjLOAR5n0PPGEWI0giptH25LD99bvceSr?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ncr.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR15MB1426.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b7396fc-f9db-4583-53de-08d96101ccc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2021 22:04:20.5981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ae4df1f7-611e-444f-897e-f964e1205171
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jJEA6A5wvR3u7kJa4N2aX69xOn3PNsM2xuJrM2I3V0b+DlP9opiUgsFXHdkg/uiDTTs6TqMqYnyjHlj44EIa3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB4241
X-Proofpoint-GUID: EpXOvxQBQyIDSFWNTxrGBADqL6N9YkGs
X-Proofpoint-ORIG-GUID: EpXOvxQBQyIDSFWNTxrGBADqL6N9YkGs
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-16_08:2021-08-16,2021-08-16 signatures=0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

VGhhbmtzIEJyaWFuLCAgDQoNCkkgYXBwcmVjaWF0ZSB0aGUgZ3VpZGFuY2UuICAgQWxsIG91ciAu
aCBmaWxlcyBjYW4gY2FsbCBiZSBjb252ZXJ0ZWQgdG8gQU5TSS4gICBJIGRvbid0IGtub3cgd2h5
IHdlIHNlZW1lZCB0byBoYXZlIGp1c3Qgb25lIHNhdmVkIGFzIFVuaWNvZGUuIA0KQnV0IGl0IHdh
cyBhIHdha2V1cCwgYW5kIGxlZCB0byBkaXNjb3Zlcnkgb2Ygb3RoZXIgZmlsZXMgbm90IGNvcnJl
Y3QuICANCg0KVXBvbiByZWFkaW5nIHRoZSBoZWxwIG9uIC5naXRhdHRyaWJ1dGVzLCBJIHdhcyBy
ZW1pbmRlZCB0aGF0IFdpbmRvd3MgVmlzdWFsIFN0dWRpbyBjYW4gc2F2ZSBzb21lIC5yYyBmaWxl
cyBhcyBVbmljb2RlLiAgDQpJIHRoaW5rIHRoYXQgbW9zdCBhbGwgYXJlIEFOU0kgYnV0IHRoYXQg
bGVhdmVzIHRoZSBwb3NzaWJsZSByZXN1bHQgdGhhdCBhbnkgb25lIHNhdmVkIGFzIFVuaWNvZGUg
Y291bGQgdW5leHBlY3RlZGx5IGZhaWwgY29tcGlsaW5nIGR1ZSB0byB0aGUgY29udmVyc2lvbi4g
IA0KDQpXZSBoYXZlIGEgbWl4IG9mICouaW5pIGZpbGVzIHdoaWNoIGFyZSBhIG1peCBvZiBtb3N0
bHkgQU5TSSBhbmQgbW9yZSB0aGFuIGEgZmV3IG90aGVycyBhcmUgVW5pY29kZS4gIA0KSSBkb24n
dCBrbm93IGhvdyB0byBoYW5kbGUgYSBtaXh0dXJlLg0KDQpQZXJoYXBzIEkgd2lsbCBoYXZlIHRv
IHNwZWNpZnkgDQoNCiouaW5pIC10ZXh0LiAgDQoNClVubGVzcywgZG9lcyAuZ2l0YXR0cmlidXRl
cyBhbGxvdyBwYXRocyB0byBiZSBzcGVjaWZpZWQ/ICBJbiBlZmZlY3QgdXNlIHRoZSANCg0KUGF0
aC9wYXRoL3BhdGgvKiAgdGV4dCBsZj1jcmxmIHdvcmtpbmctdHJlZS1lbmNvZGluZz1VVEYtMTZM
RS1CT00NCg0KQW5kIG90aGVyd2lzZSwgDQoqLmluaSB0ZXh0IAktIHRoZXNlIHdvdWxkIGJlIGFu
c2kgaWYgbm90IGluIHBhdGgvcGF0aC9wYXRoICANCg0KVGhhbmtzLCANCg0KU2NvdHQgUnVzc2Vs
bA0KU3RhZmYgU1cgRW5naW5lZXLCoA0KTkNSIENvcnBvcmF0aW9uwqANClBob25lOiArMTc3MDYy
Mzc1MTINClNjb3R0LlJ1c3NlbGwyQG5jci5jb20gIHwgIG5jci5jb20NCiAgICAgICANCg0KLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IGJyaWFuIG0uIGNhcmxzb24gPHNhbmRhbHNA
Y3J1c3R5dG9vdGhwYXN0ZS5uZXQ+IA0KU2VudDogTW9uZGF5LCBBdWd1c3QgMTYsIDIwMjEgNTo1
MSBQTQ0KVG86IEplZmYgS2luZyA8cGVmZkBwZWZmLm5ldD4NCkNjOiBSdXNzZWxsLCBTY290dCA8
U2NvdHQuUnVzc2VsbDJAbmNyLmNvbT47IGdpdEB2Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6IFJl
OiBnaXQgY2xvbmUgY29ycnVwdHMgZmlsZS4NCg0KKkV4dGVybmFsIE1lc3NhZ2UqIC0gVXNlIGNh
dXRpb24gYmVmb3JlIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCg0KT24gMjAyMS0wOC0x
NiBhdCAxODo1MTowNCwgSmVmZiBLaW5nIHdyb3RlOg0KPiBPbiBNb24sIEF1ZyAxNiwgMjAyMSBh
dCAxMjo1MzozNlBNIC0wNDAwLCBKZWZmIEtpbmcgd3JvdGU6DQo+IA0KPiA+IEJ1dCBhbiBhbHRl
cm5hdGl2ZSB3b3JrZmxvdywgaWYgeW91IHJlYWxseSB3YW50IFVURi0xNiBpbiB0aGUgDQo+ID4g
d29ya2luZyB0cmVlLCBpcyB0byBjb252ZXJ0IGJldHdlZW4gVVRGLTggYW5kIFVURi0xNiBhcyB0
aGUgZmlsZXMgZ28gDQo+ID4gaW4gYW5kIG91dCBvIHRoZSB3b3JraW5nIHRyZWUuIFRoZXJlJ3Mg
bm8gYnVpbHQtaW4gc3VwcG9ydCBmb3IgdGhhdCwgDQo+ID4gYnV0IHlvdSBjb3VsZCBkbyBpdCB3
aXRoIGEgY3VzdG9tIGNsZWFuL3NtdWRnZSBmaWx0ZXIuIFRoYXQgd291bGQgDQo+ID4gbGV0IEdp
dCBzdG9yZSBVVEYtOCBpbnRlcm5hbGx5LCBkbyBkaWZmcywgZXRjLg0KPiANCj4gT2gsIGJ5IHRo
ZSB3YXksIEkgdG90YWxseSBmb3Jnb3QgdGhhdCB3ZSBhZGRlZCBhbiBpbnRlcm5hbCB2ZXJzaW9u
IG9mIA0KPiB0aGlzLCB3aGljaCBpcyBlYXNpZXIgdG8gY29uZmlndXJlIGFuZCBtdWNoIG1vcmUg
ZWZmaWNpZW50LiBTZWUgdGhlIA0KPiAid29ya2luZy10cmVlLWVuY29kaW5nIiBhdHRyaWJ1dGUg
aW4gImdpdCBoZWxwIGF0dHJpYnV0ZXMiLg0KPiANCj4gSnVzdCBpbiBjYXNlIHlvdSBkbyB3YW50
IHRvIGdvIHRoYXQgcm91dGUuDQoNClRoZSBzcGVjaWZpYyBpbmZvcm1hdGlvbiB5b3UgbmVlZCBp
cyBsb2NhdGVkIGluIHRoZSBHaXQgRkFRWzBdLCBidXQgcm91Z2hseSwgeW91IHdvdWxkIHByb2Jh
Ymx5IHdhbnQgc29tZXRoaW5nIGxpa2UgdGhpczoNCg0KKi5oIHRleHQgbGY9Y3JsZiB3b3JraW5n
LXRyZWUtZW5jb2Rpbmc9VVRGLTE2TEUtQk9NDQoNClRoYXQgbWVhbnMgdGhhdCB3aGVuIGNoZWNr
ZWQgb3V0LCB0aGUgZmlsZSB3aWxsIGJlIGluIHRoZSBmb3JtYXQgdGhhdCBsZWdhY3kgV2luZG93
cyBwcm9ncmFtcyBwcmVmZXIgKENSTEYgd2l0aCBsaXR0bGUtZW5kaWFuIFVURi0xNiB3aXRoIGEg
Qk9NKSwgYnV0IHdpbGwgYmUgc3RvcmVkIGludGVybmFsbHkgaW4gR2l0IHdpdGggTEYgYW5kIFVU
Ri04LiAgVGhhdCB3aWxsIG1ha2UgdGhpbmdzIGxpa2UgZ2l0IGRpZmYgd29yayBtdWNoIGJldHRl
ciwgYnV0IHN0aWxsIHBlcm1pdCB0aGluZ3MgdG8gYmUgaW4gdGhlIHdvcmtpbmcgdHJlZSBhcyB5
b3Ugd2lzaC4NCg0KSWYgeW91IHJlYWxseSBkb24ndCB3YW50IHRob3NlIHRvIGJlIG1vZGlmaWVk
IGF0IGFsbCwgdGhlbiB5b3UnZCB3YW50IHRvIHdyaXRlIHRoaXM6DQoNCiouaCAtdGV4dA0KDQpI
b3dldmVyLCBHaXQgd2lsbCBjb25zaWRlciB0aGVzZSBmaWxlcyB0byBiZSBiaW5hcnksIHNpbmNl
IHRoZXkgYXJlLCBhbmQgZ2l0IGRpZmYgd29uJ3Qgd29yayBvbiB0aGVtIHdpdGhvdXQgYSB0ZXh0
Y29udiBmaWx0ZXIuDQoNClswXSBodHRwczovL2dpdC1zY20uY29tL2RvY3MvZ2l0ZmFxI3dpbmRv
d3MtdGV4dC1iaW5hcnkNCi0tDQpicmlhbiBtLiBjYXJsc29uIChoZS9oaW0gb3IgdGhleS90aGVt
KQ0KVG9yb250bywgT250YXJpbywgQ0ENCg==
