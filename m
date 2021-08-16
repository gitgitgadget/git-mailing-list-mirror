Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45354C4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 22:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2340860F41
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 22:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbhHPW1X (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 18:27:23 -0400
Received: from mx0b-00209e01.pphosted.com ([148.163.152.55]:8382 "EHLO
        mx0b-00209e01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232269AbhHPW1W (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 16 Aug 2021 18:27:22 -0400
Received: from pps.filterd (m0115756.ppops.net [127.0.0.1])
        by mx0b-00209e01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17GMGO2Y021136;
        Mon, 16 Aug 2021 18:26:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ncr.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pod1119;
 bh=FJHI0Oncuzn2+Un9dO25MCkKWjdPKyV3+bowegH0D+k=;
 b=z5gho7KZ503RhbFWk2IuStGa4qrAlJyEb3jI31wWg7NTraqkh8dAwR8aML70phGmeghu
 9j6M8TbhuqPXUCcrnNHn2fPHglSTizedsy+FvTizV+yPHGiE3blIS8/vByGxgI2Rs7cf
 6fZ7HZlzYIFmTfancQ/qcv6QCdTu58E4NcHKmlAwAAIaBE2bZ3218EK+5N29on90IZca
 iOyGysEgq2lURV5sEntvnyxpXL3SJTrSHjLlx3GYED3JAZwlMZTBisp66VXV1b1IYnUw
 vvFZgYNctCe4OIG9JIQyX7Z8bXxgsrdNtbpmZF5VKMS9NnjULtyZqzFJMLysdjQHMKeb Nw== 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2040.outbound.protection.outlook.com [104.47.51.40])
        by mx0b-00209e01.pphosted.com with ESMTP id 3ae8rj8875-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Aug 2021 18:26:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=erQEewy5YRHsTHq4O/WhGFnGgoujghwCL4BuLVrIqfh6zg0JJpAk9lnp1Yapds3nyw0w5RIXdYggblLGekbPKz4hcPg0gk1c43+cZGRd2KcVl18b0tdcOU9oBBxwHHNoM/HzmYSQPM0ta3/4U/L/LhD0+xK8nDrOpV4YFzLp657iRcT5qPdomi3fwhoqOtqenAbeAR1P53H+/po0cSM0fU+SR5nYqzPc0TFceXc4B9kFAAZK2zVyVC/yxbL2r+SsHQXPTWrhP0R///2Bam3gQEiXXvA73Tud+Z3aufiOUnDkWbGoxzOaZMfDJKRQXnLXALj/YulfE+I3Zvf/bqpMjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJHI0Oncuzn2+Un9dO25MCkKWjdPKyV3+bowegH0D+k=;
 b=h1IMkznE6ee/1JUUomRC+/bjLehkDZmbtkUpOwi3QIRIsxyjns8rZinEmhRB/sBvz9dbtZ68uBK0dGG/V/fSAM8c7yFIFVkzR/qBT+CXCEVpAwTG/tMJDITx+ZCjX2nOYubCVrPl+JJ9bZZ+mWFtLruRphVnGShSN4W7ytnUiPvqj7Xy9UVP+JpJzFUVZrIT2JAucl6l6+QkIw0vS1RTqWANt1UFvE5sn6IbQBRq4lsVmChr9aSZPQ7DLfi+MazKOR/eBMl1pW6TstGTG8F8Ucp5+2OMb3Ob89IXsWERvOvzzwh3Zuq8xED64QX4RH24LLtze8adaq27NzF7YqJuxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ncr.com; dmarc=pass action=none header.from=ncr.com; dkim=pass
 header.d=ncr.com; arc=none
Received: from BN6PR15MB1426.namprd15.prod.outlook.com (2603:10b6:404:c4::18)
 by BN7PR15MB2308.namprd15.prod.outlook.com (2603:10b6:406:8d::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.19; Mon, 16 Aug
 2021 22:26:36 +0000
Received: from BN6PR15MB1426.namprd15.prod.outlook.com
 ([fe80::21ab:b879:3cff:87c3]) by BN6PR15MB1426.namprd15.prod.outlook.com
 ([fe80::21ab:b879:3cff:87c3%6]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 22:26:36 +0000
From:   "Russell, Scott" <Scott.Russell2@ncr.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
CC:     Jeff King <peff@peff.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: git clone corrupts file.
Thread-Topic: git clone corrupts file.
Thread-Index: AQHXkui+FYBcWaT2QVKI1LhsxFP/Cat2rE3AgAAHg4CAAAEh4A==
Date:   Mon, 16 Aug 2021 22:26:36 +0000
Message-ID: <BN6PR15MB1426BCE62EFCDFE2F095C404CBFD9@BN6PR15MB1426.namprd15.prod.outlook.com>
References: <BN6PR15MB1426E50F03A0530CA9140F98CBFA9@BN6PR15MB1426.namprd15.prod.outlook.com>
 <BN6PR15MB14261C40E614CC11416388B4CBFA9@BN6PR15MB1426.namprd15.prod.outlook.com>
 <BN6PR15MB14264C9A96F4B5F6B01FA7FACBFA9@BN6PR15MB1426.namprd15.prod.outlook.com>
 <YRbya0UO2+PvOjL5@camp.crustytoothpaste.net>
 <BN6PR15MB1426E99386269CCBDA888D51CBFD9@BN6PR15MB1426.namprd15.prod.outlook.com>
 <YRqYD+SszvhhySwl@coredump.intra.peff.net>
 <YRqzmC5ubd0TEWL/@coredump.intra.peff.net>
 <YRrdq5VAp3o35+Fb@camp.crustytoothpaste.net>
 <BN6PR15MB1426DAA212EC5A9E89E19176CBFD9@BN6PR15MB1426.namprd15.prod.outlook.com>
 <YRrkgQDRVT+O+4Ih@camp.crustytoothpaste.net>
In-Reply-To: <YRrkgQDRVT+O+4Ih@camp.crustytoothpaste.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_Enabled=true;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_SetDate=2021-08-16T22:25:07Z;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_Method=Privileged;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_Name=dc233488-06c6-4c2b-96ac-e256c4376f84;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_SiteId=ae4df1f7-611e-444f-897e-f964e1205171;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_ActionId=7f8b1aed-c603-49f1-a524-865525e67f03;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_ContentBits=0
dlp-product: dlpe-windows
dlp-version: 11.3.0.17
dlp-reaction: no-action
authentication-results: crustytoothpaste.net; dkim=none (message not signed)
 header.d=none;crustytoothpaste.net; dmarc=none action=none
 header.from=ncr.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3657f09-7508-4f1e-dba5-08d96104e8cc
x-ms-traffictypediagnostic: BN7PR15MB2308:
x-microsoft-antispam-prvs: <BN7PR15MB2308CD18CE2895B14E06A12FCBFD9@BN7PR15MB2308.namprd15.prod.outlook.com>
x-from-ncr-tenant: Processed
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MF5oB0eOFMExrqDmn/zXjadxiktHlS0c87AYpSZUKWZNR9WoO/o9d0M8+utfPoi960WtmT+Xxp78vKzbD+QJgluSJUC1Irc6Thvh7u9xfJauHJtk/g8KwpfJLCES0AQ0p6hADA8e5SV5DWV7l2uJhg+Jaj3C/HBtJdsyUfJQQ49AkqSyy/HHt646Sw+fyL6ZEw6OJbeLKu6paVUREkVMwoiig1ozBqo+9fmNn578lI0O+TKMvDDPYMzl8oeaYF/H7WadMswisv7wvJP6EdbJ6qaRK9QoqIuEq7ZiftE9J0macWpHeE/Dt6vGXkz8nTRnXXCSYs02ZjU0eRo/k+2MrtHAaiBLbhOAT8RikAp365BPwdqG7AkRwV6MqJZXCJ4T2eByRIVMu5PVPNJ2dOsqvr0sATjDjQ3AVa8E/et+dhcl9r8fpZYuqbSVsNv8I1KBecVD3cp4a5pZo+bbILvkH/tqtaJ0XmWoA4fuRHEc059FlEA2NAVSjihdzMk7EvTkXZWCGWlLurPhef7fJd0YN7M56y2Qn96f/ZwNf96nl3x6ZSP5E474nUXODi1X2GNA1wb0RiGMGXtWgITNwwRKwV6AprI1tyKP6CwRi8V/eiNtg5oftRCeJwROwAIo9uMoICjW0W/ie0yTnNUaOWXGvc/MI6WnJmxdxA+7Gmur54t1oBwbC9xyjGxAZw4STwap20zOfJENzVpxpMwSFaGuBA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR15MB1426.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(8936002)(86362001)(8676002)(52536014)(71200400001)(83380400001)(33656002)(6916009)(2906002)(64756008)(4326008)(66946007)(66476007)(66556008)(53546011)(6506007)(508600001)(38100700002)(38070700005)(55016002)(26005)(3480700007)(186003)(54906003)(316002)(9686003)(66446008)(7696005)(122000001)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZTF4emVlcVlva3BBbkpXaU5vTU52NjM0UTZPWU9IR3NmM3ZVOEtBWWNZSFVt?=
 =?utf-8?B?M0RzR1Z4WUhpRmJ0bWQ0U2JlOTdSdlNqQXNpOTNsVXcreTFVRG8rZTk0WlpI?=
 =?utf-8?B?UllPUUFFNGM2ZzA3ZjZkNmpjblovOWhpVmVXZ0VGU3E1UTVJYXRkK28xVklX?=
 =?utf-8?B?MzR3b1gyc0Ryd281MUlTQjNzYzZ6aG5MTkNIaHBKWmFhOVRRZkVLMHp6RG1L?=
 =?utf-8?B?SDZFZFhOZUdGaFlMOEd0RXE3QmgwREZjWFpYWCt3UUJDUzlwWUhkQjNST2Ex?=
 =?utf-8?B?RU5Tam1xK05FcEhISXZhQU1abCtZVHlvQzNNcE9TSVBWbWw0c3NSNy9IcVVE?=
 =?utf-8?B?RE4vWGt2eGFhS0VVdjlZZzRlbjFienBLZjNEWkxUcnZYYUZXSk54Y1k0b1dw?=
 =?utf-8?B?WTltVHYyZ05ObitNdk9ocURoOEJsaXVLNlNxSXkxUHg2cmJHN1Rjalcxa2hm?=
 =?utf-8?B?TzNRVnR1NFFjRkpMUURwOSttMlE3SERPWkRWUnQvMU9OK3BGZDZyT1BKK1JC?=
 =?utf-8?B?Um1QaU1NZnNaaXZBZ1NWQzg2UVpvbENDL1ZKdDVQQXJiWk1kYmgxaTh2SWFm?=
 =?utf-8?B?WmZ0TE5WMjd5cjVUcXdVK3VsT2lLRkh0U2RiZXVuSWV6SmlWalhJRjJUeFVz?=
 =?utf-8?B?RUplbVR6b0xLUkE1ZURkSGg4VGtIMmE1R3gzYklONFNvTFJ3a3hJUTMxWjFh?=
 =?utf-8?B?NmVsUWFwOURWL3dUcVp0d1RXczR2c1EyNy9RaU5vVEd2NHdmMGZJbTk0K2Qv?=
 =?utf-8?B?c2svTklsQ3RVRlhUQXphWU1BMTlUV1JqRjcrMFpzRXhUb0E4MEdBTXlycDNH?=
 =?utf-8?B?djJjVTEwR2taTExtM3djT0NBeG9qckhSMnY0MEFwb091Nko4Q2N1YUV5Q01z?=
 =?utf-8?B?d051czNHZmYzalpsSG9GS01hMjFyQWE4eGMrc3hNZERyU3FhRWdhWTlOMkNM?=
 =?utf-8?B?MU1rd2xNSHZjazU0THk4a1Y4ZGlHQUg3NHJkUVZ1cGo4VitJUnBZZFJmTkRt?=
 =?utf-8?B?bkdqTmwzSTlMd1BDVVVwTHZ4VGhaZXRwTWk0MU9scm14bWVuaHp4cFR3dTdR?=
 =?utf-8?B?UE8wR2FnMDJZbFEvcXR1emd5NGR6Zk9kdm9MTTF0MzhqTVhEYjJmbk1QQUsr?=
 =?utf-8?B?YWMyaFVtb2V4ZGluR3ZZQzk0SkoxUlJhU2FOZDljV25vNUlkWkFBTkRrRFIr?=
 =?utf-8?B?dW01bHdpdVdQKzJBYy8weGh5c2twaXZsWlRpK3VRTmlOTVNEL042SnpjTkpt?=
 =?utf-8?B?ZWRXcEtUNmc1UWtZanMvbTBHdkpJaDh4MkdMZlVhS1BLWHk1NmFVR0R1STVY?=
 =?utf-8?B?NEpGeDg3R0w5UDBWZ2loQmtNeTgxc0pxYWsvMzJjV0JZeHZONjEzU2NnVXhh?=
 =?utf-8?B?UWQzaVprdGVWdkVSdjBLbExTTUR0UjliL3kxbmt3RnNoLzFhV0hmeTRxQ09Y?=
 =?utf-8?B?S0lBSVlaanBtNHBybjBVbW85Sko5Ky9WRFNiNU1sc2xzcjZVVXhoQ0VPS213?=
 =?utf-8?B?WHNpTDRxdW9OZlVTeHBrR0ZJQ0dFYlFmRi9ZSi8vNDZjZzExOWFmdzhCK212?=
 =?utf-8?B?ODZscXdnYVcxRlkwQVFBMkhDQ2FITERMQmFoVDBjSkQ5dTY0UUVicXZ3NWVX?=
 =?utf-8?B?MTZJN3NmUlgwS016NG5jUEZUb3hPTzRGT2t5citLdzJYT3YxTXA5aXRsSk56?=
 =?utf-8?B?OVR3aTA1Z3FPemlmVXYyR0dHUHVrUDdMN0swTDdRcWlBbko2WjQrQXdPVW5B?=
 =?utf-8?Q?XsTbK0ekjKUmC8Shetnuc7tHrw2AkZaQMt7S4Ec?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ncr.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR15MB1426.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3657f09-7508-4f1e-dba5-08d96104e8cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2021 22:26:36.0580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ae4df1f7-611e-444f-897e-f964e1205171
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c1WD27U2+/Zf5511zjQmg6of+cr5ttkvL9ssWHTTtCS7YL8TpyxKKY+CDl1nZYtsXx33v5/XTOTCZP4vZUH/1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR15MB2308
X-Proofpoint-ORIG-GUID: NlJmFL2REaxcf0AmZQN3SrehOucm4FzK
X-Proofpoint-GUID: NlJmFL2REaxcf0AmZQN3SrehOucm4FzK
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-16_08:2021-08-16,2021-08-16 signatures=0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

T2ssIHRoYW5rcyBmb3IgYWxsIHRoZSBoZWxwLiAgDQpJIHRoaW5rIHdpdGggdGhlIHBhdGggaW4g
LmdpdGF0dHJpYnV0ZXMgSXQgd2lsbCBiZSBmaW5lLiAgDQoNCmRpci9zdWIvcGF0aC8qLmluaSB0
ZXh0IGVvbD1jcmxmIHdvcmtpbmctdHJlZS1lbmNvZGluZz1VVEYtMTZMRS1CT00NCg0KSSB3aWxs
IGdpdmUgdGhvc2UgYSB0cnkgYW5kIHNlZSBob3cgaXQgd29ya3Mgb3V0LiAgIEFuZCBlc3BlY2lh
bGx5IHRoYW5rcyBmb3IgdGhlIGhlbHAgYWR2aWNlIG9uIGFkZCAtcmVub3JtYWxpemUuICAgSSB3
b3VsZCBuZXZlciBoYXZlIGRvbmUgdGhhdC4gIA0KDQoNClRoYW5rcywgDQoNClNjb3R0IFJ1c3Nl
bGwNClN0YWZmIFNXIEVuZ2luZWVywqANCk5DUiBDb3Jwb3JhdGlvbsKgDQpQaG9uZTogKzE3NzA2
MjM3NTEyDQpTY290dC5SdXNzZWxsMkBuY3IuY29tICB8ICBuY3IuY29tDQogICAgICAgDQoNCi0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBicmlhbiBtLiBjYXJsc29uIDxzYW5kYWxz
QGNydXN0eXRvb3RocGFzdGUubmV0PiANClNlbnQ6IE1vbmRheSwgQXVndXN0IDE2LCAyMDIxIDY6
MjAgUE0NClRvOiBSdXNzZWxsLCBTY290dCA8U2NvdHQuUnVzc2VsbDJAbmNyLmNvbT4NCkNjOiBK
ZWZmIEtpbmcgPHBlZmZAcGVmZi5uZXQ+OyBnaXRAdmdlci5rZXJuZWwub3JnDQpTdWJqZWN0OiBS
ZTogZ2l0IGNsb25lIGNvcnJ1cHRzIGZpbGUuDQoNCipFeHRlcm5hbCBNZXNzYWdlKiAtIFVzZSBj
YXV0aW9uIGJlZm9yZSBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQoNCk9uIDIwMjEtMDgt
MTYgYXQgMjI6MDQ6MjAsIFJ1c3NlbGwsIFNjb3R0IHdyb3RlOg0KPiBUaGFua3MgQnJpYW4sDQo+
IA0KPiBJIGFwcHJlY2lhdGUgdGhlIGd1aWRhbmNlLiAgIEFsbCBvdXIgLmggZmlsZXMgY2FuIGNh
bGwgYmUgY29udmVydGVkIHRvIEFOU0kuICAgSSBkb24ndCBrbm93IHdoeSB3ZSBzZWVtZWQgdG8g
aGF2ZSBqdXN0IG9uZSBzYXZlZCBhcyBVbmljb2RlLg0KPiBCdXQgaXQgd2FzIGEgd2FrZXVwLCBh
bmQgbGVkIHRvIGRpc2NvdmVyeSBvZiBvdGhlciBmaWxlcyBub3QgY29ycmVjdC4NCj4gDQo+IFVw
b24gcmVhZGluZyB0aGUgaGVscCBvbiAuZ2l0YXR0cmlidXRlcywgSSB3YXMgcmVtaW5kZWQgdGhh
dCBXaW5kb3dzIFZpc3VhbCBTdHVkaW8gY2FuIHNhdmUgc29tZSAucmMgZmlsZXMgYXMgVW5pY29k
ZS4NCj4gSSB0aGluayB0aGF0IG1vc3QgYWxsIGFyZSBBTlNJIGJ1dCB0aGF0IGxlYXZlcyB0aGUg
cG9zc2libGUgcmVzdWx0IHRoYXQgYW55IG9uZSBzYXZlZCBhcyBVbmljb2RlIGNvdWxkIHVuZXhw
ZWN0ZWRseSBmYWlsIGNvbXBpbGluZyBkdWUgdG8gdGhlIGNvbnZlcnNpb24uDQoNCkkgZG8gd2Fu
dCB0byBzcGVjaWZ5IGEgZGlzdGluY3Rpb24gaGVyZS4gIFlvdSdyZSByZWZlcnJpbmcgdG8gIlVu
aWNvZGUiDQphbmQgIkFOU0kiLCB3aGljaCB0cmFkaXRpb25hbGx5IG1lYW4sIG9uIFdpbmRvd3Ms
IGxpdHRsZS1lbmRpYW4gVVRGLTE2IHdpdGggQk9NIGFuZCBXaW5kb3dzLTEyNTIuICBZb3UgZG8g
bm90IGdlbmVyYWxseSB3YW50IFdpbmRvd3MtMTI1Miwgb3IgdGhlIGVuY29kaW5nIG9uIHdoaWNo
IGl0J3MgYmFzZWQsIElTTy04ODU5LTEuICBUaG9zZSBhcmUgb2Jzb2xldGUgYW5kIGhhdmUgYmVl
biBmb3Igd2VsbCBvdmVyIGEgZGVjYWRlLiAgSXQncyB1bmZvcnR1bmF0ZSB0aGF0IG1hbnkgV2lu
ZG93cyBwcm9ncmFtcyBjb250aW51ZSB0byB1c2UgdGhlc2UgdGVybXMsIGJlY2F1c2UgbmVpdGhl
ciAiVW5pY29kZSIgbm9yICJBTlNJIiBkZXNjcmliZSBhbiBhY3R1YWwgY2hhcmFjdGVyIHNldCBh
Y2NvcmRpbmcgdG8gSUFOQS4NCg0KV2hhdCBpcyBnb2luZyB0byB3b3JrIGJlc3QgaGVyZSBpcyBV
VEYtOCB3aXRob3V0IGEgQk9NLiAgTW9zdCBXaW5kb3dzIHByb2dyYW1zIGNhbiBoYW5kbGUgdGhh
dCB0aGVzZSBkYXlzLCBidXQgc29tZSBzdGlsbCBkb24ndC4gIElmIHlvdSB0cnkgdG8gc2F2ZSB0
aGluZ3MgYXMgIkFOU0kiIHdpdGhvdXQgYSB3b3JraW5nLXRyZWUtZW5jb2RpbmcgYW5kIHRoZXkg
YXJlbid0IGNvbXBsZXRlbHkgQVNDSUkgZmlsZXMsIHRoZW4geW91IHdpbGwgZW5kIHVwIHdpdGgg
c29tZSB3ZWlyZCBkaWZmIG91dHB1dCBhdCB0aGUgdmVyeSBsZWFzdC4NCg0KSWYgdGhlIGZpbGVz
IGFyZSBjb21wbGV0ZWx5IEFTQ0lJLCB0aGVuIG5vIHdvcmtpbmctdHJlZS1lbmNvZGluZyBpcyBu
ZWNlc3NhcnksIGJlY2F1c2UgQVNDSUkgaXMgYSBzdWJzZXQgb2YgVVRGLTguDQoNCj4gV2UgaGF2
ZSBhIG1peCBvZiAqLmluaSBmaWxlcyB3aGljaCBhcmUgYSBtaXggb2YgbW9zdGx5IEFOU0kgYW5k
IG1vcmUgdGhhbiBhIGZldyBvdGhlcnMgYXJlIFVuaWNvZGUuDQo+IEkgZG9uJ3Qga25vdyBob3cg
dG8gaGFuZGxlIGEgbWl4dHVyZS4NCj4gDQo+IFBlcmhhcHMgSSB3aWxsIGhhdmUgdG8gc3BlY2lm
eQ0KPiANCj4gKi5pbmkgLXRleHQuDQo+IA0KPiBVbmxlc3MsIGRvZXMgLmdpdGF0dHJpYnV0ZXMg
YWxsb3cgcGF0aHMgdG8gYmUgc3BlY2lmaWVkPyAgSW4gZWZmZWN0IA0KPiB1c2UgdGhlDQo+IA0K
PiBQYXRoL3BhdGgvcGF0aC8qICB0ZXh0IGxmPWNybGYgd29ya2luZy10cmVlLWVuY29kaW5nPVVU
Ri0xNkxFLUJPTQ0KDQpZZXMsIHRoaXMgc3ludGF4IGlzIGFsbG93ZWQuICBTZWUgdGhlIGdpdGF0
dHJpYnV0ZXMoNSkgbWFudWFsIHBhZ2UgZm9yIHdoYXQncyBhbGxvd2VkLiAgWW91IGNhbiBldmVu
IGRvIHRoaXM6DQoNCmRpci9zdWIvcGF0aC8qLmluaSB0ZXh0IGVvbD1jcmxmIHdvcmtpbmctdHJl
ZS1lbmNvZGluZz1VVEYtMTZMRS1CT00NCg0KT25lIHRoaW5nIEkgZm9yZ290IHRvIG1lbnRpb24g
aXMgdGhhdCBhZnRlciBtb2RpZnlpbmcgeW91ciAuZ2l0YXR0cmlidXRlcyBmaWxlLCB5b3UnbGwg
d2FudCB0byBydW4gImdpdCBhZGQgLS1yZW5vcm1hbGl6ZSAuIiBhbmQgdGhlbiBjb21taXQgYm90
aCB0aGUgLmdpdGF0dHJpYnV0ZXMgZmlsZSBhbmQgYW55IGNoYW5nZXMuICBPdGhlcndpc2UsIHlv
dSBtYXkgZW5kIHVwIHdpdGggZmlsZXMgdGhhdCBkb24ndCBlbmQgdXAgY29udmVydGVkIHRoZSB3
YXkgdGhhdCB5b3Ugd2FudC4NCi0tDQpicmlhbiBtLiBjYXJsc29uIChoZS9oaW0gb3IgdGhleS90
aGVtKQ0KVG9yb250bywgT250YXJpbywgQ0ENCg==
