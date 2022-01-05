Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115FBC433EF
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 17:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242285AbiAERaJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 12:30:09 -0500
Received: from mx0b-00198c03.pphosted.com ([148.163.141.38]:60708 "EHLO
        mx0b-00198c03.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242288AbiAER37 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 5 Jan 2022 12:29:59 -0500
X-Greylist: delayed 466 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Jan 2022 12:29:58 EST
Received: from pps.filterd (m0241609.ppops.net [127.0.0.1])
        by mx0b-00198c03.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 205EwmhY009176
        for <git@vger.kernel.org>; Wed, 5 Jan 2022 17:22:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=interpublic.com; h=from : to : cc :
 subject : date : message-id : content-id : content-transfer-encoding :
 mime-version : content-type; s=ipgdkim02012019armz7ef6cwb5;
 bh=biccCUsgQGXzAI32sczS3ycMXZh5zm06P/+3GgMBvwM=;
 b=aZqiotOFO3ts5w/23N7/WqjPKAG6ZlWR4i2mqV2ZAIVYQ8pcwL5tzqw6zQY4k7X+xZ4i
 2j48D0kyj0ezGACSWM/4xjI0pXthbtGg7TZEMJgS5dayg7UEZQsGPFYBXF63DDYbiJ+J
 QUhcA0aI/zhlu+pn1N5J71sE9MV83H0IaUgSffBU7mOTDE2BM2Bku1v0UTHBUWqqbJbc
 5df1A0mZ9higeLH7uwO10dQPE9NFE85rrsj1yh9GGFJ0eeGk1cymsr3bi7IkDXCjQplk
 OMhVGWYl3xSeWsZLyGJyidTXY1k6lg01j3PAxxN3NTvUIM32qUAHhDD+HIRtPUw7H/3F MA== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by mx0b-00198c03.pphosted.com with ESMTP id 3dddjj1phu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <git@vger.kernel.org>; Wed, 05 Jan 2022 17:22:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oSBeGcpa3pCoEc1dQcBp7Kj8e9Txf0czyysRnhLlMmJ97YI9ubZ1tykskdnYDItfqX0k4tjRtmHULQ/ryGaNqUoX9CGNoYZH9znwPgjRp7ksdInW8bFRTUeyhwA5Q5K+8swRqvoNOZuN4G+aiJZDGKXywmWOmda0tDPqaT8zsyTEu4Vby9yggH3kTwXeTQHGKkF7yLEWDby3CmwU8YcSlM+/sbM+k8J0ZPBozXW6KEtV37UtQ1YezVOeawh6aIwwSh0ZLkq97Q0GmzB1squm6VvDYCEp9Bx4XtcjbOAhqflv6Ht+g/EWYr+kVyiS06ZKM7o2ejjgjcU0F7VaK5QZiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Xt+RpAmWjJCfIqq6Q8plAlBpd1s4qNJdu5ly324r2w=;
 b=ikH0fDHWYhzVRehoV0eL+QRQZfjbS6Fl6Sex6Nh+Ng72fFpfpqv6azU6t+0b+JwMe8Lztp2p1/BTy0TxWiU5B5JT8Ys/0CI7j4JG4G7F8gzatNJZqsgJtobH/mpYec2Y/9zrUOm5eoarriGI4jOx08340wIUTb4Qbal++C4EbKvL9eQ7KDbEwDekBRBAsqaX0n3CxovjO6t78hy0/MCv9AYwgDNyqxy4zbdI34PY9XqawdQ8/0AHH/JNmI9emZL/F+SYgVfo4ozCuLawlJakYDlNVIs+78UP+P1tNHSyO6Q4HlBu2N2lVAU3331kHrvexwOd3BS8xT729nJzTByaIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=interpublic.com; dmarc=pass action=none
 header.from=interpublic.com; dkim=pass header.d=interpublic.com; arc=none
Received: from MN2PR06MB6320.namprd06.prod.outlook.com (2603:10b6:208:e0::26)
 by MN2PR06MB6221.namprd06.prod.outlook.com (2603:10b6:208:dc::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Wed, 5 Jan
 2022 17:22:07 +0000
Received: from MN2PR06MB6320.namprd06.prod.outlook.com
 ([fe80::ac3d:36ee:8977:78ac]) by MN2PR06MB6320.namprd06.prod.outlook.com
 ([fe80::ac3d:36ee:8977:78ac%7]) with mapi id 15.20.4867.009; Wed, 5 Jan 2022
 17:22:07 +0000
From:   "Nanekrangsan, Sucheela (NYC-GIS)" 
        <sucheela.nanekrangsan@interpublic.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "Frank, Carson (OMA-GIS)" <carson.frank@interpublic.com>
Subject: Git bug report git remote get-url
Thread-Topic: Git bug report git remote get-url
Thread-Index: AQHYAljD6H+tKUERQ0aHSUPS8PjWrQ==
Date:   Wed, 5 Jan 2022 17:22:06 +0000
Message-ID: <00FDB880-5FF6-4C67-9144-5599B2872830@interpublic.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.10.1b.201012
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b931b60b-d5b3-41c4-70e5-08d9d06fe642
x-ms-traffictypediagnostic: MN2PR06MB6221:EE_
x-microsoft-antispam-prvs: <MN2PR06MB62210FCD796F257F036BDD45F74B9@MN2PR06MB6221.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cliVRafbGcwiVW3YLauXyoihdQsgTqCy3ni3OipnEVvnb55NVcGcGfYL8TAMt57t43t/hpf5mntE9it68GiaiaigE93l3DG5WTbOseownwaQ/hGWuwsSm7rRcaWiRPUjlVXhK+HbhB/5rU8h/dWtiNj7bdsIJrnhR9MhutLN+PhOC7ZO+h5oyLAEAGNKMZdFNKyWWGk+UAdX2tCljocqWbGvjC3cp1i7iULbBk6F+muUvbr/sh/f+K00JjvUzxOwkG8k07JTT1fUPUetdZxXKWXKp7wEYRJWvXBuTp8vUsdPcBDmTeh8Al/rifONUzzIQcL4NkanTMd2pRXxLDxxTDTP8+F0U71ojySeZ1cIjiyWD62Env+z7mXsQfSNyDQLHEspb2Ch9NnnPnZFtmOqYRKRKWD3h85y8p3m6yo4Mc8r3dLrXrM6cmsvZiyCr6UpRVnSR0088qMj/p8LrryHIpUae4sDqkGU2CDRa6BLRisNl+S4lNeX3RRaKQtSFgu3T6b3pRFdXZgjbZZ4vZjbzmdWEqMTxvsuOy6mxbnSTql5hZCXvpe3n8/pjhYnL8lQrwKRNVuzOPG1hw5IpT2p+Th7kXVA/Hb10QE/m8mi3l2itCE/6/lAKqjI0CkR16DNy98wNbPi9DH2eJnVXnyHQdXgDBXNAv30l98xlc/rbErFgOQxA54aLYOJMh1LhJ7RJjKUKQE6UVL+yC31Rqjyz7oPTChUgLL7BU1GnEDRtrLRMmG/UhwqFTICkvuXApyMnLpqiafAAcUDPDUkkkuwkw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR06MB6320.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(6512007)(186003)(6486002)(8936002)(2906002)(91956017)(316002)(66556008)(8676002)(86362001)(107886003)(5660300002)(71200400001)(2616005)(38070700005)(76116006)(508600001)(66476007)(36756003)(64756008)(38100700002)(4326008)(6506007)(122000001)(33656002)(66946007)(83380400001)(66446008)(26005)(21314003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K1kwSTEvcGw5Qkd0RmZ4dDdHNkhDaWMxREwrWWgvZ21RbmdFaGQvUDk5ZWxO?=
 =?utf-8?B?MytrMnowNmowYTg4OEZDaVVvUC85cUpESUtDMlBlR1F4ajFNd2tnUExRc0U4?=
 =?utf-8?B?YkdDNjIwc3UwS3ZGM0J3eTZCeWVsWnpmUHhmL3ZacHNOdExZd3ZNNGI0dGxN?=
 =?utf-8?B?ZVBROXZza2xIWkNiZzNGdlZHbjBodnhKaC9uTHloR09aVEQ3MnpsaSs3a2pk?=
 =?utf-8?B?Z254TWFBT05lRmtCOXlxSXBOYTdUTE5vT0x6cVkwQld1aWU5UGJJZUZDS21r?=
 =?utf-8?B?dTA1OEhBTm44Z3JJTm9wWEQ4QisvQkQ5cFJNeGsxRWF3SzhxcGFsNUgwUEN2?=
 =?utf-8?B?RURiRk0rVGU1OUJtZGsvYjlsUGdwRzMyalNFVm5EQTVyQ09CcTkvOXJVOVZ0?=
 =?utf-8?B?eDZCMVIwSFA1ZUVuUXREOXUxNUY4LzJ4WER3T0w1dnUvTzRXQWF1WTNueThj?=
 =?utf-8?B?UmNQay9LMlZDUXFxUEROL1JPL2pnNkpGVWgrSFNjc2h5UVo5dlV5VkZYNWww?=
 =?utf-8?B?aVRVbm5zUGpYRG9sK1YrR2NPNzRMK0xSR1pHZUljMndUUlFoTVRNVjZ6clAy?=
 =?utf-8?B?R1NHU2FPS3VDc3ZwamZjWkhrL1dyNHdkeDVEajFmUTJlT3ZBY2kydjd6N3g0?=
 =?utf-8?B?cWZvK2xlVS9VbGRITTMwWGZjdVZjNEM2RGJ2RUN5MmQ4TklwODFGL3k1b1BS?=
 =?utf-8?B?T0lSTWw1OEY4OEZydCt3NCt3ZHNqVCtsUElRc243dlNHZDd6RTlKNjhPTnF2?=
 =?utf-8?B?eDlGd2hPSGNwemFjSU90ZmRLeG9zaHhiakRTVXFTeDdWbUREUmJVbWRiU0hD?=
 =?utf-8?B?aDg0alBJdFYwanZmUGxTRW9UREpSdmV4UUhJTzNmV1J0ZVlyRW10WmpLNXho?=
 =?utf-8?B?Q1VENDdxVWI0QUxCcnMwc0pNb09GaTBXMTBnWGRXTVhubjljODhIRFFUZW8x?=
 =?utf-8?B?TTlNSU1UU1dNRm1JUTY0Y2svOU52UllOaDJlMmdyWFVpVlNyejRVVFRwWUJn?=
 =?utf-8?B?RVl3bC82VVV5Y3g2L2M1KzJqZ0hCb0J2VGdwOVNWdFg0NVFvc2dqbmtPSDBl?=
 =?utf-8?B?YUgraGh6QlFvSm9XWlFZOTdMMS85cEo1a2trUmxsMlR6eHN0R2lKU1d3RDBs?=
 =?utf-8?B?dWplcTBFS1p5RXdyb3BSWWtxbWpwanVzV3NqQnJTWnJVTjJBYk9vSlpNMCsv?=
 =?utf-8?B?Um81Rnh4YVE5b3Y0QTRqY1VJVTRML1RNQ0FSRGtkVVdrSnVBUjJZNXgvNTVy?=
 =?utf-8?B?VDlMV2VZcUhtTGtIanZPS2d2cTlMODZOSDdPa2ZETkFXOStzNWtFd1lZSVJW?=
 =?utf-8?B?bDNkK1pSdnZrVHNGa1h3dlRrOW9ETVpIeEEyejFWWEZ0aDNQdzU5T0tBZWg0?=
 =?utf-8?B?d3k5cHV5clVINFBHNUViSmNxTFI0T2ExeUJVZDluczdiRUJ5MzlkWHF4d2Fp?=
 =?utf-8?B?Z1VqYWdQTWdpY2tTUjRrZUxOUEhkeVgxRXhJcFY2VUdzcE9POS9WQUNNbEJn?=
 =?utf-8?B?d0hBYlFDRjM4WFYxWFRLZWsxd2lVaWxIZ1NYSjJ4ZVYwcElZeGNDTFVoZ2NW?=
 =?utf-8?B?R3dHUXg1YjRsaGFmcklHZzYrdFplTjNWb3U1SHlWaEhxS0ZPcXRXWUE3aDIw?=
 =?utf-8?B?eWh1c2cvUjY2d1pyK1FkM2tmZWY2YXBFR3k4alpqOTRYckdtSzMwbWJCMlNq?=
 =?utf-8?B?dmhvSjZFM0ZCSDZkb0hRbFYzRzZCcnJkSkN6SUhpMGl3MFFwT0pMMCtEejBX?=
 =?utf-8?B?ZmEyTHZvSmtqbkgzeHVSUlRiQk5CanFHbSttZHo3aXJuQllQMzN4TUx1R2Zx?=
 =?utf-8?B?eHo0TG8xL0tWbXNOZVNLNWw3L1NiY2JLQUFBM1p6dEtyck1IV0hMK3lqZHZW?=
 =?utf-8?B?bnlxM3c5SHpxbEEwNGlFc1FhRTNHcGRTdkVIcXVaV3hydWRGZHR5NUt6ZEY1?=
 =?utf-8?B?bTJRV3BPUlZCRys5dGV0TTJzeTZzSFZ6S0tCWS9HeXNMV1RNbGFqUlBoR1pX?=
 =?utf-8?B?M2lXWlg1MFdXTFdCNTdWVmRqa3g3enV0ZTBEcnFJemt6Z1RQQmRiZ2tQNEtz?=
 =?utf-8?B?WXNaS3BIL0VORjMwQStySzBzL1J6QnVYNWdDRmYxd2RkNEFDQzMxQ2lVeW8x?=
 =?utf-8?B?NlpUQTRQNjI2ZU5HVzZZK21hTmNRRnVJS2IydGdyQ2pkMmU0T1Z1d2J6SVVZ?=
 =?utf-8?B?ZUcyTjNqNDBJejlLK0h3dVEyWHM1MkJ5RTlvcFpnM3NkQ2RwdkRhbU5XSTBw?=
 =?utf-8?B?ZnFpYlJRV1VaNWpPTkRNUWhJY3lTY1kvYXdoazBoczIxK0VIc2pwU1NqclRO?=
 =?utf-8?B?T01wWUlPQlJIdzVPYzNSaWVBY2hsVUwwYWV3TnF0cmhLbHNldk82dz09?=
Content-ID: <6E005C19091FE543AD8E16BFE264DFA1@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: interpublic.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR06MB6320.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b931b60b-d5b3-41c4-70e5-08d9d06fe642
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2022 17:22:07.1497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d026e4c1-5892-497a-b9da-ee493c9f0364
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v5aNVAjGH8SatRLgfVRX7Xkg1RWR1EBHRS/iYHXzNs3coGN/tsPZLNZxwfJpKvPnWOPv3O8L9u2w+lzBntgTmQ73xmMt0IJkaNH4vpRxDhaALfmNx5/HK2JXTgF7H1ew
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR06MB6221
X-Proofpoint-ORIG-GUID: I076a_0dSVO2CXJOPRYufHY3qZF5eg9K
X-Proofpoint-GUID: I076a_0dSVO2CXJOPRYufHY3qZF5eg9K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-05_05,2022-01-04_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 suspectscore=0 clxscore=1011 lowpriorityscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxlogscore=757 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2112160000 definitions=main-2201050115
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

VGhhbmsgeW91IGZvciBmaWxsaW5nIG91dCBhIEdpdCBidWcgcmVwb3J0IQ0KUGxlYXNlIGFuc3dl
ciB0aGUgZm9sbG93aW5nIHF1ZXN0aW9ucyB0byBoZWxwIHVzIHVuZGVyc3RhbmQgeW91ciBpc3N1
ZS4NCg0KV2hhdCBkaWQgeW91IGRvIGJlZm9yZSB0aGUgYnVnIGhhcHBlbmVkPyAoU3RlcHMgdG8g
cmVwcm9kdWNlIHlvdXIgaXNzdWUpDQoxLiBJIHB1dCBbcmVtb3RlXSBlbnRyaWVzIGluIC9ldGMv
Z2l0Y29uZmlnDQoyLiBgZ2l0IGNvbmZpZyAtLWdldCByZW1vdGUueHh4LnVybGAgcmV0dXJucyB0
aGUgY29ycmVjdCBVUkwuIEkgY2FuIGBnaXQgcHVsbGAgZnJvbSB0aGlzIHJlbW90ZS4NCjMuIGBn
aXQgcmVtb3RlIGdldC11cmwgeHh4YCByZXR1cm5zICJlcnJvcjogTm8gc3VjaCByZW1vdGUgJ3h4
eCciDQo0LiBBZnRlciBgZ2l0IHJlbW90ZSBhZGQgeHh4YCwgSSBjYW4gZ2V0IHRoZSBVUkwgZnJv
bSBgZ2l0IHJlbW90ZSBnZXQtdXJsYC4NCldoYXQgZGlkIHlvdSBleHBlY3QgdG8gaGFwcGVuPyAo
RXhwZWN0ZWQgYmVoYXZpb3IpDQpJIGV4cGVjdGVkIGBnaXQtcmVtb3RlIGdldC11cmxgIHRvIGdp
dmUgbWUgdGhlIFVSTCBJIGFkZGVkIGluIC9ldGMvZ2l0Y29uZmlnLsKgDQoNCldoYXQgaGFwcGVu
ZWQgaW5zdGVhZD8gKEFjdHVhbCBiZWhhdmlvcikNCmBnaXQgcmVtb3RlIGdldC11cmxgIGRpZCBu
b3QgcmVjb2duaXplIHRoZSByZXBvcnQgSSBhZGRlZCBpbiAvZXRjL2dpdGNvbmZpZy4NCg0KV2hh
dCdzIGRpZmZlcmVudCBiZXR3ZWVuIHdoYXQgeW91IGV4cGVjdGVkIGFuZCB3aGF0IGFjdHVhbGx5
IGhhcHBlbmVkPw0KSSBleHBlY3RlZCB0aGUgVVJMIGZyb20gL2V0Yy9naXRjb25maWcgZnJvbSBg
Z2l0IHJlbW90ZSBnZXQtdXJsYCBidXQgZ290IGVycm9yLg0KDQpBbnl0aGluZyBlbHNlIHlvdSB3
YW50IHRvIGFkZDoNClRoZXNlIGdpdmUgbWUgdGhlIGNvcnJlY3QgcmVzdWx0cw0KYGdpdCBjb25m
aWcgLS1nZXQgcmVtb3RlLnh4eC51cmxgDQpgZ2l0IGxzLXJlbW90ZSAtLWdldC11cmwgeHh4YA0K
DQpQbGVhc2UgcmV2aWV3IHRoZSByZXN0IG9mIHRoZSBidWcgcmVwb3J0IGJlbG93Lg0KWW91IGNh
biBkZWxldGUgYW55IGxpbmVzIHlvdSBkb24ndCB3aXNoIHRvIHNoYXJlLg0KDQoNCltTeXN0ZW0g
SW5mb10NCmdpdCB2ZXJzaW9uOg0KZ2l0IHZlcnNpb24gMi4zNC4xDQpjcHU6IHg4Nl82NA0Kbm8g
Y29tbWl0IGFzc29jaWF0ZWQgd2l0aCB0aGlzIGJ1aWxkDQpzaXplb2YtbG9uZzogOA0Kc2l6ZW9m
LXNpemVfdDogOA0Kc2hlbGwtcGF0aDogL2Jpbi9zaA0KdW5hbWU6IExpbnV4IDMuMTAuMC0xMTYw
LjQ5LjEuZWw3Lng4Nl82NCAjMSBTTVAgVHVlIE5vdiAzMCAxNTo1MTozMiBVVEMgMjAyMSB4ODZf
NjQNCmNvbXBpbGVyIGluZm86IGdudWM6IDQuOA0KbGliYyBpbmZvOiBnbGliYzogMi4xNw0KJFNI
RUxMICh0eXBpY2FsbHksIGludGVyYWN0aXZlIHNoZWxsKTogL2Jpbi9iYXNoDQoNCg0KClRoaXMg
bWVzc2FnZSBjb250YWlucyBpbmZvcm1hdGlvbiB3aGljaCBtYXkgYmUgY29uZmlkZW50aWFsIGFu
ZCBwcml2aWxlZ2VkLiBVbmxlc3MgeW91IGFyZSB0aGUgaW50ZW5kZWQgcmVjaXBpZW50IChvciBh
dXRob3JpemVkIHRvIHJlY2VpdmUgdGhpcyBtZXNzYWdlIGZvciB0aGUgaW50ZW5kZWQgcmVjaXBp
ZW50KSwgeW91IG1heSBub3QgdXNlLCBjb3B5LCBkaXNzZW1pbmF0ZSBvciBkaXNjbG9zZSB0byBh
bnlvbmUgdGhlIG1lc3NhZ2Ugb3IgYW55IGluZm9ybWF0aW9uIGNvbnRhaW5lZCBpbiB0aGUgbWVz
c2FnZS4gIElmIHlvdSBoYXZlIHJlY2VpdmVkIHRoZSBtZXNzYWdlIGluIGVycm9yLCBwbGVhc2Ug
YWR2aXNlIHRoZSBzZW5kZXIgYnkgcmVwbHkgZS1tYWlsLCBhbmQgZGVsZXRlIHRoZSBtZXNzYWdl
LiAgVGhhbmsgeW91IHZlcnkgbXVjaC4K
