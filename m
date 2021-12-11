Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3151DC433F5
	for <git@archiver.kernel.org>; Sat, 11 Dec 2021 17:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbhLKRRh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Dec 2021 12:17:37 -0500
Received: from mx0a-00128103.pphosted.com ([205.220.160.181]:13178 "EHLO
        mx0a-00128103.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230326AbhLKRRf (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 11 Dec 2021 12:17:35 -0500
Received: from pps.filterd (m0207974.ppops.net [127.0.0.1])
        by mx0b-00128103.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BBCI1P7004284;
        Sat, 11 Dec 2021 09:17:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=firstam.com; h=from : to : cc :
 date : message-id : references : in-reply-to : content-transfer-encoding :
 mime-version : subject : content-type; s=facorp;
 bh=fonXrUrN3lgMnBFnd4u7mPW5mJGKMOdVVlWWPDUN0xs=;
 b=ptrSXow6LKqkgpSk8u/ApQuQe9THSnnreAIwxgV8RXcRAwqFPlYZtsjztUDcA8dwo2N1
 H89WYxbmILffgoHjwU22mKpH9kfo9yfFFS7MzivqEmoEF/ZNcx0aRMKVyKcJp6i28Owj
 1e6s5LoMOMgmEVSDIvfJtccxIZ5zSjcqiTad4xjwDkOdnj64rkgNTCRmEp2/bWgyv5Vf
 gG0AXb79Y/xiyTzpomBu12+EGQ7z+PHoO/tr/whMpSD4iJLVPO1mUUkJpLR09J/a0c0N
 OOKitrp8yE9Rb6in3t41UoPsbQ8L3R95K5i7yZZOEsvTBXvPpjsT3IPvqZTzR1xa+Pff Qg== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by mx0b-00128103.pphosted.com with ESMTP id 3cvuvd8tfa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 11 Dec 2021 09:17:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KJqCVzFlmT2REZOOUt4iqvTdOrwT5LOCcx6Q8Yy20Pm2JRLylYQyflsrVu6R7QNhVr7/5dNB4952OOXVxylZuhBb+lHt8YVKFitG9JfxQi/OAZzBIKApPCQKgi+yIniMXSvxTk3Zeg9eLU+6ZqCWXmWZwHu+Zzo3BgOsWuIrTbLM5jzEKDItpTMDwas9+H+uDKc13b34poVjPZOCZK7RGO0rRpew4tNY7iJi9zCPUJXZWMo6GDbB5Epk2CPRzEiQ2SgwurVbyP4Bl4lnBUueQ34SRS+BVQeGrMGd3swW5QyDDVCVsjHprqH71m52YRzZ6mEA5Y2qUXzw+6hBuSFtpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dvpsv/EvlVXtYDAMwpF3aYzgtbeE4MinByhhD87HY90=;
 b=n2LF0l2Cz4+B/EKxWnE8B5nTexv7s0ovdhhdJyOmG4yh4p2pVHtCaLtABvteN/ln3TkQxQJ5dz1OH93AoRf7vPrU4h3vutUpygwWn4ADxvXeTOIbZ3AeA2e5xaTctzkC4FeSQowCFy1xqsAEH13zqP7LwdfE/p1FCEgIeC3esVcBWER2f+NQEc8qfYRVp7gYZvQH3Pa+Z1gm0QdwNny2JjNrreUHTsjvE77QZF7JML8bB+QzxhJVfvBN9oyo1oqhXHsksEPvSkpCBCbvy9wlDUkOQf+wSO+9CaDQFXbGe0eNsYEu+0m3FR4toLHEYo0fFNGhUIAx1O7CCC/dTdVV7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=firstam.com; dmarc=pass action=none header.from=firstam.com;
 dkim=pass header.d=firstam.com; arc=none
Received: from BN7PR08MB4993.namprd08.prod.outlook.com (2603:10b6:408:27::22)
 by BN7PR08MB6049.namprd08.prod.outlook.com (2603:10b6:408:9::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Sat, 11 Dec
 2021 17:17:26 +0000
Received: from BN7PR08MB4993.namprd08.prod.outlook.com
 ([fe80::18a7:4224:8325:6300]) by BN7PR08MB4993.namprd08.prod.outlook.com
 ([fe80::18a7:4224:8325:6300%7]) with mapi id 15.20.4778.017; Sat, 11 Dec 2021
 17:17:25 +0000
From:   Robert Weyrauch <rweyrauch@firstam.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Thread-Topic: [External] Re: Question: Git and ActiveTcl
Thread-Index: Adft90W0O3L81lRGRK+gEUx2pgCRPAAoJ/iAAAbBhpA=
Date:   Sat, 11 Dec 2021 17:17:25 +0000
Message-ID: <BN7PR08MB4993A29A91FEBFB6F34A0BA7B7729@BN7PR08MB4993.namprd08.prod.outlook.com>
References: <BN7PR08MB4993D6DAF501472017175C65B7719@BN7PR08MB4993.namprd08.prod.outlook.com>
 <nycvar.QRO.7.76.6.2112111502210.90@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2112111502210.90@tvgsbejvaqbjf.bet>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9acd1fc5-a95c-49ce-b8be-08d9bcca1a3f
x-ms-traffictypediagnostic: BN7PR08MB6049:EE_
x-microsoft-antispam-prvs: <BN7PR08MB604905990DD14F7533A722A8B7729@BN7PR08MB6049.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UfCX16gZmXZfBdnq/sZTNz8FipYF6JbW0lkP/WuzxrC3sAZooTiI/sFKcvHiD4vF+ZSkc9Oim6GzSpjV9fNvNvBwVUCJRQqHtb2jpJA62WmRpShUsUj9f6sHJKbStz6b47+zrsffTuvWArCYEheqhFoazYkwGIQk+P0YTN/zsgQufUDfBjkqgi0i7fFFhrVE7SjIAWHu4Uh396qneCL9wxCWAG94TIZ20Spzw7INf5nsRym7X77s90eOJhz9RaSgTeUq+x1QU0howmr+hCap5yELd+X1+3ryeZawWg+jsvI/s7eHiZLHNuA2w2lGl+YvInn2xks/EleKHE5hbpgtZNEjyMRRy8EExpSiTCBL4Yh6CFhOAX9Tr1H1aQRqDMkrh2v9c/PnVLkGO56C8TrSOzoWv9aNiF4XhxwIsHrOMX0MmS6VblOScM1cjf5P9u2qFv5BoWx84MmlX29qZvt4hykhplxVvNp8hALVA53oLHHTsS1xMqoLwwpsgKLFFInolvsV/3wQuJ/MlhFRmvoLg5AyloEaG0qz5irin1j7vn2NR9HwqXnGez9sSKbsGt7AaKcVOlL/bhCZ0R7kRdm6cJP2GKhzhq2cnLN2/4bm40A2bazGbb2hKJYZCFCVEkDU365LuPN2Mo3HHGE7y2wMcWmiIQqvArlIwU5X/7OlYmjIGuT+Gew4cdO/UglYAx5otwbwSVt6PLBvLsXWhDCjqw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR08MB4993.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(83380400001)(6916009)(508600001)(122000001)(66946007)(66446008)(9686003)(4744005)(64756008)(7696005)(76116006)(33656002)(66556008)(66476007)(26005)(2906002)(8936002)(5660300002)(52536014)(38070700005)(38100700002)(186003)(86362001)(316002)(4326008)(8676002)(53546011)(55016003)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NE5xREJZdFpLV3M1K0ROZWc0T0owTENTQm5FdGZOZ3lOc1EzUXM4VE1aRDVG?=
 =?utf-8?B?cjd6NEpSeFFvL1daV0VjNjhuSjZSa0M3OVcyRVNsMENob3B6YjE5SkNNSEFF?=
 =?utf-8?B?cG84cjJudWFrKzVIelh1UWpBalJlYi9tMmdEblN1RXl1dGhsZzRVWFBkeTA3?=
 =?utf-8?B?aitwZ2cvcXBtOW5nSlJWNjUycmpLSGU4cG5uYjh0Mi80bGcrdUdPenlabGpk?=
 =?utf-8?B?STlWcDVmcjZUaGhBL242TW5nS2tabVFQMkdCbm8wZUJyRjB2NDJQQVpCT0V2?=
 =?utf-8?B?SzhCUzlDMmlTVG8zQ0hUYjZlOVM1SDBjTnUxN1U5TDFrRHlac2RDL01uSXo2?=
 =?utf-8?B?T3Z6blltYW03d3ptL0J2NGtNTFlLSkxsNldzR000T0hTOEpuNEk2bUY4U1ds?=
 =?utf-8?B?WmllU2VMcTYrYkxQQ2k3SXZLRnd6dlozcmZkL2EzZW5aVXM1TXZ0Q2hJZHph?=
 =?utf-8?B?QUloRk1ONDhHbGlsNDVvUmdEcDFnaUFFM1hrNWUrQUFFYUVjK1I4RFpKbVRS?=
 =?utf-8?B?NURXMS9XRG11R0RFR0R3OGpoeXcvTlAvRDhCREowcEZGN1o2Q2NFMnVwS28z?=
 =?utf-8?B?NUt0bnl6K0VaYjZRME9SSllmcnBlVE9oaGk1SXI1VERlOWNxV0JOQWRlRW1V?=
 =?utf-8?B?c3FIRXI2RVNLZTkvaVkxL05PTDE4a3krdGtRc3NzUUlqOXk0aUIzalovVVNK?=
 =?utf-8?B?VVBSZlJxY0I4U3l5YzJVY3p2Rkg4YXUxNFV2NU1rT2JuNFdLNU9nL0V6d3Fy?=
 =?utf-8?B?bVF3SzdCZUFYQkw2MlN4anNUaVVIMEpaV2pWUUxPOWlESVR4eTV5Z0VINytk?=
 =?utf-8?B?OS9BQlNwQzVmSGZKWmpHM2Y5STFvWWMwYVFIS2M3Rkp5WWRsZGlVcVErUVh5?=
 =?utf-8?B?U215ZytGOEFidllEZzJxdnRNSkYzRERPMTZhajBib0pJQ0NFWXdobGMzbGpK?=
 =?utf-8?B?SnBGeCttM3FSZTZkR2Y4U0tiS2hpT1BLM2RLT2pFM3piajR1ckZHeE10Ynhk?=
 =?utf-8?B?cDhlalJrdExQUnhlR0Q3a2NLWW96bXVDZWlkUjhtV3IyZVdIb0dETnJCQVJR?=
 =?utf-8?B?SEM1TzdvRnRiaHJNSGtqcXgzNzdQWWdXQzRZenZRUFNnZVZ2dVBQWE52V3Ja?=
 =?utf-8?B?RGQ0K2duOVRDeE1ocHZ2NkY0aHpTVjdzaGVZYkp0TG5vNEhGdkxNeXU2Mkcr?=
 =?utf-8?B?bDV0UHZlaStQMGJQczZhV0VjVWhjcnhMbWdXeHc0ZEhDbXJ5THgxMU5rWXVz?=
 =?utf-8?B?SCtMMkhwaVJzeFdzMVM1T0xKTHhRanJHdVV4SVJSY3NGMDEzRnFTKzlBZ3V2?=
 =?utf-8?B?eXBJYXF1QkJaSndEcTlreUI2ejFKR0NCR3UzTm41c2NJRXFHRThtTGlIN3dP?=
 =?utf-8?B?cE5jQkhTcEN3N3piekJLVnRmOXZLaUhNTE13V1RtOHpDQ1IrZitPS2RRNytE?=
 =?utf-8?B?Q1YwZkQxNmIwb3F5RkpkQ3pWOWNxZ3FyMmM3M05rQUsvNHF3VUZnN21DVThP?=
 =?utf-8?B?OThCaEpkbTFqQWZVcVZyTVlLZXZNOVFRY0dCc3dRQVB4Vmkrb2VuV3QyVFJF?=
 =?utf-8?B?YzlYS1FJNzA3RDZEcUJIeXI0dGtpckJNMy9EYnRHdnVOK1FuSERRNG13Zm9t?=
 =?utf-8?B?eTJsSHE4YWtwdkdXZnhpQVNvR3FCWlVCaWxjeTE1eUVibEZHRVJ2ZnBqeHB0?=
 =?utf-8?B?RUFGVDlnSCtRNHgzb2dNdVowai9hOXp3cGQvcjhvZ1FhRHJ5Mkd0V3YzT2Fv?=
 =?utf-8?B?YXNXaDhacW5ZemN2cVpzWC9ud243Z01hZGx2WHQxaTBzNFo5ckZnVDVicHR4?=
 =?utf-8?B?bElwanFTQjNKU1BSVjRXMUlrZ1ltbHk2a1ROUFZzd2k5MW5zMEJhbnRhd2Jy?=
 =?utf-8?B?bFBQdnk3UGg3VUtFZFZISm1pMFAvQzR6cDRCdnQ3MTVjS1JiRVF6dE13MHdZ?=
 =?utf-8?B?dmdxU0RPSjNTV2NaMEJoSkg0N0llK21IaUhnZ0xDaFdSSjVZY0hzcFNEQUdQ?=
 =?utf-8?B?dTZGenFCU1ZmWHRjVWg2N2FpOU1hVXdORzhhcnR2QzA3T0RVTThqQ0lTQ2o5?=
 =?utf-8?B?d1d5UEZubjF2VVNYQW0zcGdHYVR2N0ZmV3hlam9xWnM4V0tCMHpVVElJYW4w?=
 =?utf-8?B?c0JGWk13SVdkR1l6SkxiNGFXVTI5bm4yQzcrOUdyLzJzZ0YwS1ZjSVRUU2Vm?=
 =?utf-8?Q?zWkL/5MPnlUpjU/HiO/cyFw=3D?=
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: firstam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR08MB4993.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9acd1fc5-a95c-49ce-b8be-08d9bcca1a3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2021 17:17:25.8045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4cc65fd6-9c76-4871-a542-eb12a5a7800c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NjhZKaDPJAGbgHinr2UylYPIrIbg6ISCbrl7f8Q6XDYHStKxAq44QWkT8IPdGfTnxqZa7q8TBTV8SPZ42/p0hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB6049
X-Proofpoint-ORIG-GUID: dgcChmuXk0GPBUFHwsbo-U56pAfZlF_v
X-Proofpoint-GUID: dgcChmuXk0GPBUFHwsbo-U56pAfZlF_v
Subject:    Question: Git and ActiveTcl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-11_07,2021-12-10_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 adultscore=0 impostorscore=0 malwarescore=0 spamscore=0
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112110097
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

UGVyZmVjdC4uLiAgWWVzIGFuZCB0aGFuayB5b3Ugc28gbXVjaCBmb3IgeW91ciBoZWxwIQ0KDQpS
b2INCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEpvaGFubmVzIFNjaGluZGVs
aW4gPEpvaGFubmVzLlNjaGluZGVsaW5AZ214LmRlPiANClNlbnQ6IFNhdHVyZGF5LCBEZWNlbWJl
ciAxMSwgMjAyMSA3OjA0IEFNDQpUbzogUm9iZXJ0IFdleXJhdWNoIDxyd2V5cmF1Y2hAZmlyc3Rh
bS5jb20+DQpDYzogZ2l0QHZnZXIua2VybmVsLm9yZw0KU3ViamVjdDogW0V4dGVybmFsXSBSZTog
UXVlc3Rpb246IEdpdCBhbmQgQWN0aXZlVGNsDQoNCkhpIFJvYmVydCwNCg0KT24gRnJpLCAxMCBE
ZWMgMjAyMSwgUm9iZXJ0IFdleXJhdWNoIHdyb3RlOg0KDQo+IEluIEp1bmUgMjAyMSBBY3RpdmVT
dGF0ZSwgYSBwcm92aWRlciBvZiBjdXJhdGVkIFRjbC9UaywgUGVybCBhbmQgDQo+IFB5dGhvbiBk
aXN0cmlidXRpb25zLCBjaGFuZ2VkIHRoZWlyIGxpY2Vuc2luZyBmb3IgdGhlaXIgY29tbXVuaXR5
IA0KPiBlZGl0aW9ucyB0byByZXF1aXJlIHBheW1lbnQuIEkgd291bGQgbGlrZSB0byBlbnN1cmUg
SSBhbSBjb21wbHlpbmcgDQo+IHdpdGggdGhlc2UgY2hhbmdlcy4NCj4NCj4gSSBhbSByZWFjaGlu
ZyBvdXQgdG8gc2VlIGlmIHRoZSBUY2wgbGlicmFyaWVzIHVzZWQgYnkgR2l0IGFyZSB0aG9zZSAN
Cj4gcHJvdmlkZWQgYnkgQWN0aXZlU3RhdGUgKEFjdGl2ZVRjbCksIG9yIGlmIHlvdSB1c2UgdGhl
IHZhbmlsbGEgdGNsL3RrLg0KDQpTaW5jZSB5b3UgdGFsayBhYm91dCBBY3RpdmVTdGF0ZSwgSSBh
c3N1bWUgeW91IGFyZSB1c2luZyBHaXQgb24gV2luZG93cz8NCklmIHNvLCB5b3UgbWlnaHQgYmUg
dGFsa2luZyBhYm91dCBHaXQgZm9yIFdpbmRvd3MnIHZlcnNpb25zIG9mIFRjbC9Uaz8NCg0KSWYg
dGhhdCBpcyB0aGUgY2FzZSwgdGhlIGxpYnJhcmllcyBpbiBxdWVzdGlvbiBhcmUgYnVpbHQgYnkg
dGhlIE1TWVMyIHByb2plY3QsIGFuZCBub3QgYnkgQWN0aXZlU3RhdGUuDQoNCkNpYW8sDQpKb2hh
bm5lcw0KCioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKgpUaGlzIG1lc3NhZ2UgbWF5
IGNvbnRhaW4gY29uZmlkZW50aWFsIG9yIHByb3ByaWV0YXJ5IGluZm9ybWF0aW9uIGludGVuZGVk
IG9ubHkgZm9yIHRoZSB1c2Ugb2YgdGhlIGFkZHJlc3NlZShzKSBuYW1lZCBhYm92ZSBvciBtYXkg
Y29udGFpbiBpbmZvcm1hdGlvbiB0aGF0IGlzIGxlZ2FsbHkgcHJpdmlsZWdlZC4gCklmIHlvdSBh
cmUgbm90IHRoZSBpbnRlbmRlZCBhZGRyZXNzZWUsIG9yIHRoZSBwZXJzb24gcmVzcG9uc2libGUg
Zm9yIGRlbGl2ZXJpbmcgaXQgdG8gdGhlIGludGVuZGVkIGFkZHJlc3NlZSwgeW91IGFyZSBoZXJl
Ynkgbm90aWZpZWQgdGhhdCByZWFkaW5nLCBkaXNzZW1pbmF0aW5nLCBkaXN0cmlidXRpbmcgb3Ig
Y29weWluZyB0aGlzIG1lc3NhZ2UgaXMgc3RyaWN0bHkgcHJvaGliaXRlZC4gCklmIHlvdSBoYXZl
IHJlY2VpdmVkIHRoaXMgbWVzc2FnZSBieSBtaXN0YWtlLCBwbGVhc2UgaW1tZWRpYXRlbHkgbm90
aWZ5IHVzIGJ5IHJlcGx5aW5nIHRvIHRoZSBtZXNzYWdlIGFuZCBkZWxldGUgdGhlIG9yaWdpbmFs
IG1lc3NhZ2UgYW5kIGFueSBjb3BpZXMgaW1tZWRpYXRlbHkgdGhlcmVhZnRlci4KCklmIHlvdSBy
ZWNlaXZlZCB0aGlzIGVtYWlsIGFzIGEgY29tbWVyY2lhbCBtZXNzYWdlIGFuZCB3b3VsZCBsaWtl
IHRvIG9wdCBvdXQgb2YgZnV0dXJlIGNvbW1lcmNpYWwgbWVzc2FnZXMsIHBsZWFzZSBsZXQgdXMg
a25vdyBhbmQgd2Ugd2lsbCByZW1vdmUgeW91IGZyb20gb3VyIGRpc3RyaWJ1dGlvbiBsaXN0LgoK
VGhhbmsgeW91LgoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioKRkFGTEQK
