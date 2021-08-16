Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D95C4320A
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 18:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5EAC6103A
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 18:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbhHPSxS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 14:53:18 -0400
Received: from mx0b-00209e01.pphosted.com ([148.163.152.55]:61814 "EHLO
        mx0b-00209e01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230143AbhHPSxR (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 16 Aug 2021 14:53:17 -0400
Received: from pps.filterd (m0115756.ppops.net [127.0.0.1])
        by mx0b-00209e01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17GIqIKq030531;
        Mon, 16 Aug 2021 14:52:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ncr.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pod1119;
 bh=jAM2/hogGghIUOynj//e//iC2o0PBqPMohKnzwhFGQY=;
 b=HuZUyseMF2c1vyTLztysFrvVE4j8PrKbIbptFFj1yNeOY9Q+jmsnDVbCHDmASaNfJYoC
 RBi6x33uD0rdyO64LoAoeYIPxmDR4l81s54EQnEWA/wApQWqbcd8X8RLBDVm0ZvGZX3i
 TIo1pvANWybGQPI8VTUUn1caw+KYXK89TuiHIAv/R0igL++X46Bbgg8+ORBqST+STxJg
 4tpT3it8eCdJLdL9C9fHkYDdR1EaTeyKOcfATktQURBcZ0v6D09rRAfXu5CCbLCxEXsH
 XN1ite6aDcihaVAuLH90MW9copNvWQSslNU+psTWTQW7ixQ0O6fgrZomfbAGsTPD5QKv BQ== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2049.outbound.protection.outlook.com [104.47.56.49])
        by mx0b-00209e01.pphosted.com with ESMTP id 3ae8rj6xys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Aug 2021 14:52:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YJ4gbM3DFUpzNKzY6WDplCTKOUksgazozmXKYHBNQvz4eRuYITM4EizHS52PUMp1jUCFlrZy8RKRsNgVonfR4NeqoDrfevgM1NmSLGLBVSPTRYOIgoiqacvEHK0J/vJbq63YHWnO8UX0mN5ilCoKmoLtKUdiLq3l+42NhyODNVu2r5beu7CCdSq3muWYYa+Zb/jDE4TX+7hoWTTDJpWqiP+gmmxpg+2eML/phzCeDW5VsSmVeF5HzWaXqR6kLYnc8qTL5ECLw3T+JygxBfKe86fthE9I9bJviaRafwStXiFRzVu6TUdID3hxL+aamcqYkr2r6brr68Y3jIcRAcMkFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jAM2/hogGghIUOynj//e//iC2o0PBqPMohKnzwhFGQY=;
 b=KqomHLxcrczPJgslq15GTO69UOI0QbWXYe3FYvinM67tqNjHkYJN7KdoGUDN5RfL4E4smLYTLVXMmCbyhomuvKKqoc02cYvuEvSOlaEIQDl4BC3UdYzJCrIX4yFegkqz81jTSUzU9JExH/8BTCBRbcVhTrnebk9y6GmGIDHm5MpGh16pnBNf5b27LJOwPYz/uQ9SZcaH7tbWiaQ+ABl4SiIqN9v9xN5QsKPfMDbi05dxlAM3qx1XtBqv9rI88EEDO+khQ0bsReEJNfW2CxB6JB4pX4Zabjp9A+C8QqxY3w1T/WdlRFwuAnZdmUj3+/NFZ9xzhOAB+XGqvmIxYp0J3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ncr.com; dmarc=pass action=none header.from=ncr.com; dkim=pass
 header.d=ncr.com; arc=none
Received: from BN6PR15MB1426.namprd15.prod.outlook.com (2603:10b6:404:c4::18)
 by BN8PR15MB3457.namprd15.prod.outlook.com (2603:10b6:408:a3::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Mon, 16 Aug
 2021 18:52:31 +0000
Received: from BN6PR15MB1426.namprd15.prod.outlook.com
 ([fe80::21ab:b879:3cff:87c3]) by BN6PR15MB1426.namprd15.prod.outlook.com
 ([fe80::21ab:b879:3cff:87c3%6]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 18:52:30 +0000
From:   "Russell, Scott" <Scott.Russell2@ncr.com>
To:     Jeff King <peff@peff.net>
CC:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: git clone corrupts file.
Thread-Topic: git clone corrupts file.
Thread-Index: AdeQbBTmFYBcWaT2QVKI1LhsxFP/CQAAfQYQAAGNnwAAB6C0gACE7ckwAAYxx4AAAE+G0AADu8+AAAAUxbA=
Date:   Mon, 16 Aug 2021 18:52:30 +0000
Message-ID: <BN6PR15MB14261548DE31763B34CEEDD5CBFD9@BN6PR15MB1426.namprd15.prod.outlook.com>
References: <BN6PR15MB1426E50F03A0530CA9140F98CBFA9@BN6PR15MB1426.namprd15.prod.outlook.com>
 <BN6PR15MB14261C40E614CC11416388B4CBFA9@BN6PR15MB1426.namprd15.prod.outlook.com>
 <BN6PR15MB14264C9A96F4B5F6B01FA7FACBFA9@BN6PR15MB1426.namprd15.prod.outlook.com>
 <YRbya0UO2+PvOjL5@camp.crustytoothpaste.net>
 <BN6PR15MB1426E99386269CCBDA888D51CBFD9@BN6PR15MB1426.namprd15.prod.outlook.com>
 <YRqYD+SszvhhySwl@coredump.intra.peff.net>
 <BN6PR15MB1426D70E338F6B2A988565A9CBFD9@BN6PR15MB1426.namprd15.prod.outlook.com>
 <YRqzM1D6w4bDYjKY@coredump.intra.peff.net>
In-Reply-To: <YRqzM1D6w4bDYjKY@coredump.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_Enabled=true;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_SetDate=2021-08-16T18:51:42Z;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_Method=Standard;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_Name=dc233488-06c6-4c2b-96ac-e256c4376f84;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_SiteId=ae4df1f7-611e-444f-897e-f964e1205171;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_ActionId=d1c871c9-68fd-4929-96e6-4e3b4dbb82d3;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_ContentBits=0
dlp-product: dlpe-windows
dlp-version: 11.3.0.17
dlp-reaction: no-action
authentication-results: peff.net; dkim=none (message not signed)
 header.d=none;peff.net; dmarc=none action=none header.from=ncr.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 822b1ef0-933f-4d92-1d87-08d960e70062
x-ms-traffictypediagnostic: BN8PR15MB3457:
x-microsoft-antispam-prvs: <BN8PR15MB3457DD363ACD98C8C105F51DCBFD9@BN8PR15MB3457.namprd15.prod.outlook.com>
x-from-ncr-tenant: Processed
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sU5RJJKHs+lMl72412IPaMT4k1w0wM4UfoYLcfSyo28AA5D4ResNcXE4HdcYK8u3hJjyLCbXl4FxnO+Moj7ciTQqiK53/6T5PosmS+LpYA/iRsjxpMoJqwyQDdnnZ/D3HSkYEpKGwS/2BS3DeusX8DljC06l21Jw4jyFMHLwm5lZrz5qfuIU5522nRFBkGzRJxV2OKWjRLnXpEr9jtZn4PDsb174DwT4pVZeg8WIeaJB1xU1y18bDQR1xl1SrlrYb5Sd/NkPa0kjveYWmUDxUwkOyElUuyLiEmUGVTMkNOjIoqDa/BU+gDQZ29TxJAxLG2sTZwPy/UcYCSt3fav6ZuMfLUSsV2StIUHyiYI8JuKtWLT3SNqv7UNlHQyit115Yr5CymIBIv3GtNiAl1enWDnCop6GBc8bv+KNVlDjiEK1F8WJ+cS+AxFEs+/tzYuSKmg2MxAdcHmMWZF5fHW4GbabLGIDdvl+9urIb/Ta8KmDC3CpMDRt2z0fOS43YlSCREdeO1NXQxq0IvNvGxkOWs0DYUnorqfvzGSkq5ZBXtdNfOkdD03uCxQn8LG8DMd3jAZNj7xemJRcZs1H9vEhiRNIJ0ljQOzbWU3NvLBbnTjlfEDevdF03AFDfZzB3CqRxF0+LsR5Gcck6LRCv8koR9OZ5CRGrSq643V7qie2MjSNRkfNmWOe4PZu+yhOdkKIlkpsMBnZ97qH5cHgkf32Ww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR15MB1426.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(26005)(66556008)(66476007)(33656002)(9686003)(2906002)(6916009)(186003)(66446008)(3480700007)(64756008)(4326008)(71200400001)(8676002)(66946007)(8936002)(76116006)(54906003)(55016002)(478600001)(38100700002)(86362001)(6506007)(53546011)(5660300002)(83380400001)(122000001)(316002)(38070700005)(7696005)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dzNiNzIxbFh6VG81ZnFGRzRmY0YwUllHZ3BnUW10RkMveE1iQWdzYW9xTFFi?=
 =?utf-8?B?UjhYQzhEN2ZhemZFbEhvMTJnaDY0dUIxNlJlQThaVmxiUEtmR25QTXRLWVNR?=
 =?utf-8?B?bEoycFNtY2xIeGlGVTNJUEk2V01US2QzWHZFZVloQlBkcnYyZThvaTYyQ1J5?=
 =?utf-8?B?TDZnWDNSajNSTlViT0tCOFMxWjlkeDdYNURCL2hXa0dySERtaksvKzhGV1hs?=
 =?utf-8?B?bS9EYVpYNXpSNXIxZU11NlpRbFU5c0M4RitQUnRqczZhMG1USk02dEYzWnpn?=
 =?utf-8?B?b2R6cnJtWUc0VTJLZ1I1Y2tBcFI4YWdWdkw1UmtBTm16b3ZwanZ0TTYyMzdq?=
 =?utf-8?B?SXg0cGxZTlFDdUtjN0ZQN2hlNFVxa21idDJBeWJFejJ3ZUdmOFNVQ3JLYnl0?=
 =?utf-8?B?eVlqTVhoQmYya2RqUFgya2pLa1RsMGQ4WmtnSEREOVpMYWZTQ20xNVJqNk9s?=
 =?utf-8?B?Qi9Pb0M5WVJhUTFWZnFmZE1jNWdteWhNSE9MU1g3MW9aN0I3U0E1TTNBVVdx?=
 =?utf-8?B?ZklUUHMvY0pmWDNueHE1R3JVT29RaWx3WHNnZWxuVHU1REF4djdxMFYwZGRo?=
 =?utf-8?B?UWhuaVB0RnBTQVkwMXJWZERaczR0LzNDVVhHbExybXpmMWlic043NC9iNWNv?=
 =?utf-8?B?QUVVL2tNK0t3dytLR2tWZWVDanhLMWQ4R3JYQkdXM2h0TTNaREIxWU54Q3Rx?=
 =?utf-8?B?cndWcEVtNUtXQmlsc1hvRUZVQ1czNFArblE1ZVVUTk5wQTY2MUpQSHB6OFlK?=
 =?utf-8?B?L0EzeGw1SDhSTzA1OFBVQzhGTVladjJGK0pPbUtDQUxCRG5TNEIzNEdaci9Q?=
 =?utf-8?B?elpJaTdITituTWlEWmVuQTdtSUdPOFdDZERqcjQ4OFpRUmkza2c5MEw5U254?=
 =?utf-8?B?M2h1cWwvU3M3NVFVQm9xdkVKalpJVng3SVlTdjVtRHFKSWlyT2tCakFqeE5p?=
 =?utf-8?B?WWxIZ1NhMk4zdFF5Y1lOMnNwNzNvdVVoT2VCVThjWjhPd1NpYmZ5dDRmZm9D?=
 =?utf-8?B?MEZKQjhucElXZFVVM08yN2JUa0UzaWNnd01oUXBCWVVBWCtnVFdQSHZHYmJh?=
 =?utf-8?B?NkRuOHprdmlEdithdldkZmprVVVFWW9wQmJGVXdhTDd6Mmo3ZG0xdDc3elhj?=
 =?utf-8?B?TlFydnRlc25xelZOVGdyRm1YTllYMUI3UW5DL2RCUVdSOEpWZStDd2lFQW9F?=
 =?utf-8?B?eVdxazNpWUovejRCZnlkU25YWDU4Q2JQdnNYYWdxd3NydWFhUmJMK05jc2cx?=
 =?utf-8?B?OUZRTDI3YVpObnNudlRSZFNpa2J5U3M0Nk9MNGduVVJxZjdlMVc4OVVBWitX?=
 =?utf-8?B?bWVQQUQ2TFhydkwyL1RGTDNqQnJINDV4ZUR1TnVVTTZNbFk0S3g0UUplQ1oz?=
 =?utf-8?B?b3FaUmtoRi9jTmxMNzN1ZjhpMC82YVdFclpNeittT05pbUFacHBTZHBxNHNL?=
 =?utf-8?B?SlZXbDRURVpsZGdxc05NNERCYWorNW1YeStIdzRPOEhFRks4UjRUMnhRZG51?=
 =?utf-8?B?QkM3OVZraGtDcDRKUVY4MEhXbjM1M2FSYmFOUjdFYnZQdzJ6U0U5RHZZaTZ3?=
 =?utf-8?B?OWZUeFY5YXZtM3Y1VXR1VGJBMElXVFJjbm56VVVBUDNIZTI5c3JFSk5UeUEx?=
 =?utf-8?B?YzllSTAzVkNSL3M3VU05TWljQ2xLaUZYQ0ZmQlpRU3gvcGpXNWIyYk1lVkpl?=
 =?utf-8?B?N2cwS0FiS1d4OHZDK1FMdFpzdXJxei8wZHk2QlBhTG5rKzh3dlFDTFVKeGdu?=
 =?utf-8?Q?TkAkh1PvBIYXugB31DEA1h+rRo9MfY2b7VzyqE6?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ncr.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR15MB1426.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 822b1ef0-933f-4d92-1d87-08d960e70062
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2021 18:52:30.9457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ae4df1f7-611e-444f-897e-f964e1205171
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xf8/WyK1NNaCJClRPJuBdhrvn4UFPcGsetezs7eiF9Anrmdr4U/b3ZAmzgBk1fKu+uG7l3lorveDSnpcBv2UpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB3457
X-Proofpoint-ORIG-GUID: N0cLjXX8owmCYkNyglOj6RC76w_sCleQ
X-Proofpoint-GUID: N0cLjXX8owmCYkNyglOj6RC76w_sCleQ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-16_07:2021-08-16,2021-08-16 signatures=0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SmVmZiwgIA0KDQpUaGFua3MgZm9yIHlvdXIgcmVzcG9uc2UuICBJIHdpbGwgdHJ5IHRoZXNlIHN1
Z2dlc3Rpb25zLiAgSSBzdXNwZWN0IEkgY2FuIGNvbWUgdG8gc29tZSBzb2x1dGlvbi4gICANCg0K
DQpUaGFua3MsIA0KDQpTY290dCBSdXNzZWxsDQpTdGFmZiBTVyBFbmdpbmVlcsKgDQpOQ1IgQ29y
cG9yYXRpb27CoA0KUGhvbmU6ICsxNzcwNjIzNzUxMg0KU2NvdHQuUnVzc2VsbDJAbmNyLmNvbSAg
fCAgbmNyLmNvbQ0KICAgICAgIA0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTog
SmVmZiBLaW5nIDxwZWZmQHBlZmYubmV0PiANClNlbnQ6IE1vbmRheSwgQXVndXN0IDE2LCAyMDIx
IDI6NDkgUE0NClRvOiBSdXNzZWxsLCBTY290dCA8U2NvdHQuUnVzc2VsbDJAbmNyLmNvbT4NCkNj
OiBicmlhbiBtLiBjYXJsc29uIDxzYW5kYWxzQGNydXN0eXRvb3RocGFzdGUubmV0PjsgZ2l0QHZn
ZXIua2VybmVsLm9yZw0KU3ViamVjdDogUmU6IGdpdCBjbG9uZSBjb3JydXB0cyBmaWxlLg0KDQoq
RXh0ZXJuYWwgTWVzc2FnZSogLSBVc2UgY2F1dGlvbiBiZWZvcmUgb3BlbmluZyBsaW5rcyBvciBh
dHRhY2htZW50cw0KDQpPbiBNb24sIEF1ZyAxNiwgMjAyMSBhdCAwNTozOToxMlBNICswMDAwLCBS
dXNzZWxsLCBTY290dCB3cm90ZToNCg0KPiBXZSBkb24ndCB3YW50IGFueSBFT0wgaGFuZGxpbmcg
b2YgYW55IGZpbGUuICBUaGF0J3Mgd2h5IHdlIHNwZWNpZnkgYXV0b2NybGYgZmFsc2UuDQoNClJp
Z2h0LCBidXQgaXQncyBub3QgdGhlIHdob2xlIHN0b3J5LiBhdXRvY3JsZiBpcyBhbiBvbGRlciBh
bmQgYnJvYWRlciBtZWNoYW5pc20gZm9yIGRvaW5nIGxpbmUtZW5kaW5nIGNvbnZlcnNpb24uIEZy
b20gaXRzIGRvY3VtZW50YXRpb24gaW4gImdpdCBoZWxwIGNvbmZpZyI6DQoNCiAgY29yZS5hdXRv
Y3JsZg0KICAgIFNldHRpbmcgdGhpcyB2YXJpYWJsZSB0byAidHJ1ZSIgaXMgdGhlIHNhbWUgYXMg
c2V0dGluZyB0aGUgdGV4dA0KICAgIGF0dHJpYnV0ZSB0byAiYXV0byIgb24gYWxsIGZpbGVzIGFu
ZCBjb3JlLmVvbCB0byAiY3JsZiIuWy4uLl0NCg0KWW91IG9idmlvdXNseSBkb24ndCB3YW50IHRo
YXQsIGJ1dCB5b3UgX2Fsc29fIGRvbid0IHdhbnQgdG8gc2V0IHRoZSB0ZXh0IGFuZCBlb2wgYXR0
cmlidXRlcyBvbiBpbmRpdmlkdWFsIHBhdGhzLCBlaXRoZXIuDQoNCj4gV2Ugd291bGQgbGlrZSBn
aXQgdG8gbm90IGFueSBjciBsZiBjb252ZXJzaW9uIG9uIGFueSBmaWxlLiAgIFdoZXRoZXINCj4g
dGhleSBiZSBBTlNJIG9yIFVuaWNvZGUuICAgVGhleSBoYWQgdGhlIHJpZ2h0IGVuZGluZ3Mgd2hl
biB3ZSBjaGVja2VkDQo+IHRoZW0gaW4uDQo+IFdlIGRvbid0IHdhbnQgdGhlbSBhZGp1c3RlZC4N
Cj4gDQo+IERvZXMgcmVtb3ZpbmcgdGhlIGVvbCA9IGNyIGxmIGZpeCB0aGF0Pw0KDQpUaGF0IG1p
Z2h0IGJlIHN1ZmZpY2llbnQuIFlvdSBtYXkgYWxzbyBuZWVkIHRvIGRyb3AgInRleHQiLCBhcyB3
ZWxsLg0KT3RoZXJ3aXNlIGNvcmUuZW9sIHdpbGwga2ljayBpbiBhbmQgZG8gY29udmVyc2lvbnMu
IChTb3JyeSwgSSBkb24ndCB1c2UgV2luZG93cyBhbmQgaXQgaGFzIGJlZW4gYSBsb25nIHRpbWUg
c2luY2UgSSBsb29rZWQgaW50byB0aGVzZSBvcHRpb25zLCBzbyB5b3UgbWF5IGhhdmUgdG8gZG8g
c29tZSBleHBlcmltZW50aW5nKS4NCg0KPiAJWW91IHNhaWQ6ICBVVEYtMTYgLi4uICBjYW4ndCBi
ZSB0cmVhdGVkIGFzICJ0ZXh0IiBieSBHaXQuDQo+IA0KPiBXZSBjYW4ndCBtYWtlIGFueSBjaGFu
Z2VzIHRvIHRoZSBmaWxlcyB0byBzdWl0IGdpdC4gICBXZSBqdXN0IG5lZWQgZ2l0IHRvIHN0b3Jl
IGFuZCByZXRyaWV2ZSBmaWxlcyBhcyBjb21taXR0ZWQuDQoNClJpZ2h0LiBUaGF0J3Mgd2hhdCBp
dCBkb2VzIGJ5IGRlZmF1bHQgKGlmIHlvdSBkb24ndCBzZXQgYW55IC5naXRhdHRyaWJ1dGVzKS4N
Cg0KV2hhdCBJIG1lYW4gYnkgImNhbid0IGJlIHRyZWF0ZWQgYXMgdGV4dCIgaXMgdGhhdCBHaXQg
d2lsbCBub3QgY29ycmVjdGx5IGltcGxlbWVudCB0ZXh0IGZlYXR1cmVzIGxpa2UgQ1JMRiBjb252
ZXJzaW9uLCBub3IgZGlmZnMsIGZvciBzdWNoIGFuIGVuY29kaW5nLiBJdCBpcyBlZmZlY3RpdmVs
eSBhIGJpbmFyeSBmaWxlIGZyb20gR2l0J3MgcGVyc3BlY3RpdmUuDQoNCj4gV2lsbCByZW1vdmlu
ZyB0aGUNCj4gDQo+IAllb2w9Y3IgbGYNCj4gDQo+IGZyb20gdGhlIGxpbmUNCj4gDQo+ICouaW5p
IHRleHQNCj4gDQo+IGZyb20gdGhlIGF0dHJpYnV0ZXMgZmlsZSBzdG9wIHRoZSBpc3N1ZT8NCj4g
DQo+IElmIG5vdCwgZG9lcyAuZ2l0YXR0cmlidXRlcyBhbGxvdyBhIHBhdGg/ICBTdWNoIHRoYXQg
d2UgY291bGQgc2F5DQo+IA0KPiBcY29uZmlnXExhbmd1YWdlIFNwZWNpZmljXCogICB0eXBlICAt
ICAgIElmIHRoZXNlIGFyZSBVbmljb2RlLCB3aGF0IHdvdWxkIHdlIHNheSBoZXJlLiAgIENhbiBp
dCBub3QgYmUgdGV4dD8gIFRoZW4gYmluYXJ5PyAgDQo+ICouaW5pCXRleHQNCg0KSWYgeW91IHNp
bXBseSBkcm9wIHRoZSBhdHRyaWJ1dGVzIGVudGlyZWx5LCBHaXQgd2lsbCB1c2UgaXRzIGF1dG8t
ZGV0ZWN0aW9uIHRvIGRldGVybWluZSB3aGV0aGVyIGEgZmlsZSBpcyBiaW5hcnksIHdoaWNoIGxv
b2tzIGZvciBOVUxzIChhbmQgVVRGLTE2IGZpbGVzIGFyZSBnZW5lcmFsbHkgZnVsbCBvZiB0aGVt
KS4gU28gSSBzdXNwZWN0IHRoYXQgd291bGQgZG8gaXQuIFlvdSBjYW4gYWxzbyBwcm92aWRlIHRo
ZSAiLXRleHQiIGF0dHJpYnV0ZSB0byBvdmVycmlkZSB0aGF0IGFuZCBtYWtlIHN1cmUgbm8gbGlu
ZS1lbmRpbmcgY29udmVyc2lvbiBpcyBkb25lLg0KDQpJZiB5b3Ugd2FudCB0byBvdmVycmlkZSBh
IHNwZWNpZmljIGZpbGUsIHRoZW4geWVzLCB5b3UgY2FuIHByb3ZpZGUgcGF0aHMgKEkgZG9uJ3Qg
cmVjYWxsIG9mZmhhbmQgd2hldGhlciB3ZSBhbGxvdyBiYWNrc2xhc2hlcyBpbiB0aGUgcGF0dGVy
bnM7IHlvdSBtYXkgbmVlZCB0byB1c2UgZm9yd2FyZCBzbGFzaGVzKS4gWW91IGNhbiBhbHNvIHB1
dCB0aGUgcGF0dGVybiAiKiINCmluIHRoZSAiY29uZmlnL0xhbmd1YWdlIFNwZWNpZmljLy5naXRh
dHRyaWJ1dGVzIiB0byBoYXZlIGl0IGFwcGx5IG9ubHkgdG8gdGhhdCBkaXJlY3RvcnkgKGFuZCBv
bmVzIGJlbG93IGl0KS4NCg0KVGhlIHBhdHRlcm5zIGFyZSB0aGUgc2FtZSBhcyB0aG9zZSBpbiAu
Z2l0aWdub3JlIGZpbGVzOyBzZWUgdGhlIHNlY3Rpb24gIlBBVFRFUk4gRk9STUFUIiBpbiAiZ2l0
IGhlbHAgaWdub3JlIi4NCg0KLVBlZmYNCg==
