Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D54C433F5
	for <git@archiver.kernel.org>; Mon,  7 Feb 2022 21:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236693AbiBGVIv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 16:08:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236701AbiBGVIu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Feb 2022 16:08:50 -0500
Received: from mx0e-00379502.gpphosted.com (mx0e-00379502.gpphosted.com [67.231.147.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DC5C043182
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 13:08:49 -0800 (PST)
Received: from pps.filterd (m0218361.ppops.net [127.0.0.1])
        by mx0f-00379502.gpphosted.com (8.16.1.2/8.16.1.2) with SMTP id 217L6mV1005091;
        Mon, 7 Feb 2022 13:08:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=llnl.gov; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=02022021-podllnl;
 bh=RPj5btIdCXfl7MJUIc7W2qqZSXZ7eutOfIt2thBq8BE=;
 b=OgCbt+fkIB4OZoc8oEctP+omaqmzxyZ9h1UG7K3OzalA/xrXwyzHcX5r/Q5eDVFODdKU
 OG5cayMVnh6DhnGsHWmHDkri37H5SDHU0okffvRRn5btI0Q96dTpMuB72Ow/SiOSdkH+
 F6IAugzBP2kcLaeGIwQt3XbFk/kj1Xf7i7WFRBmhzaWSa0QF0avy813G/60YUXchSu/u
 4Yalzfx9SB6bPEj9QeIsP8hhF88JAZVLLpCag+H1oZvM/3aG89pfeVNgaJqRZN0f9Fdm
 UrshznA/hZd5/lIJnGleqVOwK8Esyl7FCC1jExAkWkpUG6zs6NP3U1ib3ETziHlU8+UG 7A== 
Received: from gcc02-dm3-obe.outbound.protection.outlook.com (mail-dm3gcc02lp2106.outbound.protection.outlook.com [104.47.65.106])
        by mx0f-00379502.gpphosted.com with ESMTP id 3e2nhv30x6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Feb 2022 13:08:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CBbjeOrhXRG4/hTC/uUjyfZn3OqIyONm3VTWdDbpGMpMcsamy0xsxU+LWwJkKYlZaNdJFQdYaEw+DjiJhP1GIEUlgQqZ6u2PbXB9yitYVLs5iCVoQpQKa0+j1PLz81NbFKdKUr4Kiq4RTYEvNI1fBTcRDG+Jn8U5zHwjIr3GGqOv7X8j9tOi+l1qe9UmzbCpV/hp4mzponfCWJqjdzP56Gy74Oa4yEAY0MtUmhn8uUYjMGA1izSE4aJngyC24VGzgjVhueVFdut0y6vnWcpWo8TEVMoQ8kQuIKTKTIkUikpIwx/Va5j5iw+wB3xzyIU9QxcAWaAJOD9UhHBiUtCqJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RPj5btIdCXfl7MJUIc7W2qqZSXZ7eutOfIt2thBq8BE=;
 b=BtmueDJ4uYznXHciUi8uyywTeSbRtRsb8mZporGihDlTbHKQBCvNHNX+1Ecs54LGo+W4On6Nhxfg+GPIPpJqtHzuWoCGW8zM5bJy7lTmcA5KJhy/J7aTPsGPovfy3EAsh3OGhBNIpkyGFjMPsUKBSgz1kro4tiTYrJgIchSZGy8tofh1G/kj+MU3E6I22L7nKkQ3nEOaYW/uL3K8z6DZ4nJ1zWgeEbaGwn2dwlmBbjhj2m+DlI+i8EscAFs4tAkWBvc6Tq3NoteOyOxuEIOrwwiUlilzE3ilCt5QlWlqoQc1X2TpYm3UP7ghqX22GlRqTY7A4zz0D5BQLyjB7IHtEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=doellnl.onmicrosoft.com; s=selector1-doellnl-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RPj5btIdCXfl7MJUIc7W2qqZSXZ7eutOfIt2thBq8BE=;
 b=FSYPkVf44WN569VbOcPJBBzRdnSzTB0LyyKjRSwUy6b9LaAWwSgul8DaCZ8DKInslIryAceE0FKyMC6gf0KvobotuU1e4qGaCAFr9jYoRtbFrf8b5qGV1RBlxKupFoSSAzLVLsdxLMNX/E9H0usRl9hWKdV4BfcElqu3KDHGBF4=
Received: from BY5PR09MB5972.namprd09.prod.outlook.com (2603:10b6:a03:242::12)
 by BY5PR09MB5219.namprd09.prod.outlook.com (2603:10b6:a03:243::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Mon, 7 Feb
 2022 21:08:30 +0000
Received: from BY5PR09MB5972.namprd09.prod.outlook.com
 ([fe80::1152:ffb:b909:9231]) by BY5PR09MB5972.namprd09.prod.outlook.com
 ([fe80::1152:ffb:b909:9231%2]) with mapi id 15.20.4951.019; Mon, 7 Feb 2022
 21:08:30 +0000
From:   "Gamblin, Todd" <gamblin2@llnl.gov>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
CC:     Philip Oakley <philipoakley@iee.email>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Commit SHA1 == SHA1 checksum?
Thread-Topic: Commit SHA1 == SHA1 checksum?
Thread-Index: AQHYGi5p7M1/4kXYKkqhLSADSBwD+KyFqvkAgAClySOAAJl4gIAACmf7gAAZTQCAALOSgIAAU6YAgACEMoA=
Date:   Mon, 7 Feb 2022 21:08:30 +0000
Message-ID: <A9EEF286-72D8-4B7B-8242-042F9D432FBB@llnl.gov>
References: <ED97E252-CABA-41BB-B18C-819A5EF305E3@llnl.gov>
 <121ce485-bea8-3168-aa35-d11eb13022da@iee.email> <xmqq1r0gjo6h.fsf@gitster.g>
 <eca83634-ee91-89bd-567e-6b0807b5ff79@iee.email> <xmqqee4fix0l.fsf@gitster.g>
 <13f21a57-1519-5ace-30e8-def598fad38b@iee.email>
 <734DE4FA-E4B1-43CB-89EE-3C200FA21F4F@llnl.gov>
 <20220207131520.cqkdtmceddqquwlg@meerkat.local>
In-Reply-To: <20220207131520.cqkdtmceddqquwlg@meerkat.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc484ebc-7ad6-434a-dd1f-08d9ea7dfe2d
x-ms-traffictypediagnostic: BY5PR09MB5219:EE_
x-microsoft-antispam-prvs: <BY5PR09MB5219177A32722F61257AA34EF82C9@BY5PR09MB5219.namprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1Ih4mEbw8B4nMFRPfIJf3iHUQhw23z6GQWGn2YHHWnTMbH4aNJuzYQIBjg3LCcrAp6YWjk7qQBVcLhM1IzHpBWy809xrpYJo7Hw3nW5juh/WeV0MT4PvfAwr8q1CnDSi2w4ruzBVmfBug/b9PvgLZ/WQjswpH7XYQO8/Da2ToI2WW2sKLIwEH1gVQ91tLewGnLZeyCemwlqQ5hlmPB/iU0soz9DbYEtqQDvA5Ice/8O5RHavR+xCPTFKU65JMq/IeoHeJvvvID4gnpJMLnHR7UAEMhxfyKFvzZi+/ic2VbnQubRy0QB2IW74wQt7LzUrZ7SEWVvmMjPctYMGxFi5hGnpcAgPDBwHrkRKkcvKpKBcIgbfOj222nwKHeExfTrzy4jXfi/KwbLZ4CCEKlerA1DZCkKIdxBxFB6gNMcRU5trNXS22gYXd1S373n0k8KxwYJnAt2IvOfvVMsTfOVjCGsijmDXiwP88qEZdb7j2Cu/s4q0cTX2KRBCJ6z8WmkKg6LhrppX96egzVT8Dqq6ythf+ZbhFzUQ7IjJJLX5TmDjXmFAmh3uW8MRvCF13VaJOSn+S7lbhuNS7iREZeD6su+QTN2jGoJAFGxvmiVXyivnjNj0g/g8t5mT1ORnliACp2GTxg57eK90WsutEXV/Y+IVDK0ShSpWv6DzNFKCykoGM5dNTPHM5s4quPI7wsaCD1TBoSXQYBuA8fC4kPCC+kBE+e2zztI2VthK0Zkel1lWII6Edr7D81+IkBpb/BNd4qxgw5GemnnCm76FoqnU4xKx1XFGlGV3frX4ARNza+kO6cZKf5FifUk7J/SqpSpX9+4TsKifbLzak9WeKDMYAlG+v3azub2Z4NQ+EpRZfO0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR09MB5972.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(66446008)(66476007)(66556008)(8676002)(64756008)(76116006)(4326008)(2906002)(33656002)(86362001)(83380400001)(8936002)(38070700005)(54906003)(6486002)(966005)(508600001)(5660300002)(122000001)(82960400001)(186003)(6916009)(26005)(2616005)(6506007)(36756003)(53546011)(38100700002)(316002)(71200400001)(6512007)(45980500001)(357404004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0VDQmZ1cG9YSDhScHd1dVp1RUsvTEZPb09kcVNPR2tNYndpUWlhS0xGZi9E?=
 =?utf-8?B?VDJueEU2ZW85a2dBcEpIK0xacWIwd1hlcHJVNm9IQlI0am1Ia3M5OXhlY3Zp?=
 =?utf-8?B?Q0dCd211NlFVYkFSOGN5bnMxWE5NRnpRRllrZTBMdnhwSW5Lb0JZSkxvUmJH?=
 =?utf-8?B?bWVtNTVEWmNYNUNab29EYWtMVjNuemtQQ0d0WEF5MjZ2dXFacUFMTVNtK0l2?=
 =?utf-8?B?RG1ZZ092cTNXblpzcFhvNmRkdjdwaWE2Z21TMFh2TkRFWXJNK2ZBMWViSGV5?=
 =?utf-8?B?Qkk0S3NqTDRTNGJIUmVROVRtM2VzaVRKUm9FNkprWXFJTGYzUlRCVHlzUUU5?=
 =?utf-8?B?OEg4Vy9ZZms1elVsMlEwNElIVHJOQmRQb0FlcUlGeWtXWjBSTlZGL09FYTlq?=
 =?utf-8?B?VVY2VitMdWRTc0grMitWYkI2N0ZVNFRJVFBqeWhPR3dab2JrelNCbXR6d1dl?=
 =?utf-8?B?N05aWWk3RnVqVnJ1ZDNNUkJPdWZITXduSU92OUlETjEyTTh3Mmcrbnpxa1U4?=
 =?utf-8?B?SGpPRms1ZE5QaWNNbEdTbXRZUVhMR2hLd0kxRFc5SFpsTHUrd0xCcmNGTmJG?=
 =?utf-8?B?eHh3dk5mUFlQMERVV3dVQUZYSVEyanhQYWw1TjdVbHg5RXZJTUZtcnJDUHAx?=
 =?utf-8?B?dmJQVlp2OUJhdFE1RmFBWEJBajV4Y1pKKzBDazVuZWZsUW9ianQzQjR3eUpl?=
 =?utf-8?B?a0lCajBWY1FnNjkxK0pFMlVUYlN6bWJvbHVsSXBZRGptR3lJTFR2dnNJZnRH?=
 =?utf-8?B?aDVEbERnWDZ6dWpMZ05ldFkrTmpramY3eWVIZHdXalZTMGtzbjdKNXhGMVZ0?=
 =?utf-8?B?bjZ0UXBkQjdOTTJ3NXJqeUJrUktEQjN5akE3LzlacjN2eEQ3YnVVZXVzSWNj?=
 =?utf-8?B?dDRPbmc5ek5CMDhEeHN4Ni9ib2J0VmoxNHNnMEp1L1JBM3BOWVRKSVcyMCtN?=
 =?utf-8?B?RkJQTkpoWVp4WHVnMW1QN2t5NjhVTHRzOHlOWXJaRXlSQkFreSttV3Ezd1Rr?=
 =?utf-8?B?NXpWdk5ndS83Q1ZiV2F0cnphZHlnbzJ2RFAyWmRzelVtNVB1d3JsOFcxZ05o?=
 =?utf-8?B?dTluQ0lPUXQ4Y3h5d3VwMUZEZWVtVDV4M2RCTzBvZ2xzOWdZUkFwWlplQzhx?=
 =?utf-8?B?TEJwckNibEZUWjNlWGJqUUxZYzRvMTluS0J0d1hOWDdSSkxlVllHNU9EcWxm?=
 =?utf-8?B?bnJjY2dJaG1mY2gyK1dMR0cxaXlEbFJtSDFmQVJVVGNDTDdiUzlBSzlkNDVX?=
 =?utf-8?B?NEl0dE1LNVRFQklRV1JNd2RuYlU0ZXYveFJLMHFMTE5wTGRyZ3FpNVl4VVBl?=
 =?utf-8?B?Rlc5VVhTRmVRS3RKSmkzUjRJd05JZkY0d2xucG85czBmQnovZ2Z3UGU0ejkv?=
 =?utf-8?B?a0VqTmk0MHRCYW9VWXNsOHkrUGgyVWpGdmpqQUgyaGxPclEzaThYRVdyc2pt?=
 =?utf-8?B?ZWlwNHkzZHZJRWwvbWhLWlZVS1hRNE1tRVo3eXhINXNJVktzd053QlVYZGRC?=
 =?utf-8?B?cEJUcXRHaHZ5cjJKNUdtVmtva2JmNTU2Qlpsc2dnKzZUYlhTU0UzSWViWmRu?=
 =?utf-8?B?bUgwN1RHdWpOcTdZUHB6bCtFM0tXRStPNGZHK1lGc2V3WUJjZTQzQUZ6S01u?=
 =?utf-8?B?dmZVUXh5NFJkdGJFQnFIYWhjQ3lhTjdFMkZlaHROYnNNTHFPOXhQUHNVM0VU?=
 =?utf-8?B?RmEzS1hMb2tYNkp6ZEtYNFNrR3lxNFp3R2lYMEZPOWZFUFZwaEZ2Vjg0Q2Qw?=
 =?utf-8?Q?muaG7l3GgMvuQvLa/Wj5PyHOYfpCUV6YLBo1M/X?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <42AA031B681D154BB785F4AF152217E3@namprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: llnl.gov
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR09MB5972.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc484ebc-7ad6-434a-dd1f-08d9ea7dfe2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2022 21:08:30.5241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a722dec9-ae4e-4ae3-9d75-fd66e2680a63
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR09MB5219
X-Proofpoint-GUID: EMA3qmydEO8ExtGfWBpUIM7CDcBhbwB6
X-Proofpoint-ORIG-GUID: EMA3qmydEO8ExtGfWBpUIM7CDcBhbwB6
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.816
 definitions=2022-02-07_06:2022-02-07,2022-02-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 mlxlogscore=999 mlxscore=0 spamscore=0 phishscore=0 clxscore=1011
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202070121
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiBPbiBNb24sIEZlYiAwNywgMjAyMiBhdCAwODoxNTo1OEFNICswMDAwLCBHYW1ibGluLCBUb2Rk
IHdyb3RlOg0KPj4gSW4gb3VyIGNhc2UsIHRoZSBpbml0aWFsIHRydXN0IGRvZXNu4oCZdCBjb21l
IGZyb20gYSBQR1Agc2lnbmF0dXJlIOKAlCBpdCBjb21lcw0KPj4gKGF0IGxlYXN0IGZvciBub3cp
IGZyb20gaGF2aW5nIGNsb25lZCB0aGUgcGFja2FnZSByZXBvc2l0b3J5IGZyb20gR2l0SHViLg0K
PiANCj4gTm90IHJlYWxseSB0aGUgY2FzZSwgaWYgeW91J3JlIHJlbHlpbmcgb24gYSBwYXJ0aWN1
bGFyIGNvbW1pdCBoYXNoLCBhcyB5b3UNCj4gc3RhdGUuIE9uY2UgeW91IHNwZWNpZnkgYSB0YXJn
ZXQgaGFzaCwgeW91IGRvbid0IHJlYWxseSBoYXZlIHRvIGNhcmUgd2hlcmUgdGhlDQo+IHJlcG9z
aXRvcnkgY2FtZSBmcm9tIC0tIHRoZSBoYXNoIGlzIGVpdGhlciBnb2luZyB0byBiZSB0aGVyZSBh
bmQgYmUgdmFsaWQsIG9yDQo+IGl0J3Mgbm90IGdvaW5nIHRvIGJlIHRoZXJlLg0KDQpOb3QgdG8g
YmVsYWJvciB0aGUgcG9pbnQsIGFzIEkgdGhpbmsgd2UgYWdyZWUsIGJ1dCB0aGVyZSBhcmUgdHdv
IGNsb25lcyBnb2luZyBvbiBpbiBteSBleGFtcGxlOg0KDQoxLiBTcGFjayB0aGUgcGFja2FnZSBt
YW5hZ2VyIGlzIGhvc3RlZCBvbiBHaXRIdWIuICBZb3UgY2xvbmUgdGhlIHJlcG9zaXRvcnkgYW5k
IHJ1biBiaW4vc3BhY2sgb3V0IG9mIHRoZSByZXBvc2l0b3J5IHRvIHVzZSBpdC4gIFVzZXJzIHdp
bGwgY2xvbmUgZWl0aGVyIGBkZXZlbG9wYCAodGhlIGRlZmF1bHQgYnJhbmNoKSBvciBzb21lIHJl
bGVhc2UgYnJhbmNoIOKAlCBidXQgdGhleSB3b27igJl0IGhhdmUgYSBjb21taXQgaGFzaCBmb3Ig
dGhhdC4gIFRoaXMgaXMganVzdCBob3cgdGhleSBnZXQgdGhlIHBhY2thZ2UgbWFuYWdlciBhbmQg
aXRzIGJ1aWx0LWluIHBhY2thZ2UgcmVwbyBpbiB0aGUgZmlyc3QgcGxhY2UuDQoNCjIuIEluIHRo
ZSBzcGFjayByZXBvIGlzIGEgcmVwb3NpdG9yeSBmdWxsIG9mIHBhY2thZ2UgZGVzY3JpcHRpb25z
LiAgVGhvc2UgcG9pbnQgdG8gc291cmNlcyBmb3IgdGhpbmdzIHNwYWNrIGNhbiBidWlsZCwgYW5k
IHRoZXkgbWF5IGRvIGl0IGJ5IGNvbW1pdCBoYXNoIG9yIGJ5IHRhcmJhbGwgVVJMIGFuZCBzaGEy
NTYuICBJZiBzcGFjayBzZWVzIGEgc291cmNlIGxpc3RlZCBieSBjb21taXQgaGFzaCwgc3BhY2sg
Y2xvbmVzIGl0IChhdCB0aGF0IGhhc2gpIGJlZm9yZSBidWlsZGluZy4NCg0KSW4gKDEpLCBzaW5j
ZSB5b3UgZG8gbm90IGhhdmUgYSBoYXNoLCB5b3XigJlyZSB0cnVzdGluZyB0aGF0IEdpdEh1YiBn
YXZlIHlvdSB0aGUgcmlnaHQgcmVwbyBhbmQgdGhhdCB0aGUgcHJvamVjdCBtYWludGFpbmVkIGl0
cyBicmFuY2hlcyB3ZWxsLiAgVGhpcyBpcyB3aHkgSSBjYWxsZWQgaXQg4oCcaW5pdGlhbCB0cnVz
dOKAnS4gIEluICgyKSwgdGhhdCB0cnVzdCBlbmFibGVzIHlvdSB0byBoYXZlIGNvbmZpZGVuY2Ug
aW4gdGhlIGhhc2hlcyBpbiB0aGUgcGFja2FnZS5weSBmaWxlcy4NCg0KSSB0aGluayB3ZSBib3Ro
IGFncmVlIHRoYXQgaWYgeW91IGhhdmUgYSBzaGExIGhhc2ggZnJvbSBhIHRydXN0ZWQgc291cmNl
LCB5b3UgY2FuIGJlIGFzc3VyZWQgdGhhdCBpdOKAmXMgYWNjdXJhdGUsIHJlZ2FyZGxlc3Mgb2Yg
d2hlcmUgdGhlIHJlcG8gY2FtZSBmcm9tLg0KDQotVG9kZA0KDQoNCg0KDQoNCg0KDQo+IE9uIEZl
YiA3LCAyMDIyLCBhdCA1OjE1IEFNLCBLb25zdGFudGluIFJ5YWJpdHNldiA8a29uc3RhbnRpbkBs
aW51eGZvdW5kYXRpb24ub3JnPiB3cm90ZToNCj4gDQo+IE9uIE1vbiwgRmViIDA3LCAyMDIyIGF0
IDA4OjE1OjU4QU0gKzAwMDAsIEdhbWJsaW4sIFRvZGQgd3JvdGU6DQo+PiBJbiBvdXIgY2FzZSwg
dGhlIGluaXRpYWwgdHJ1c3QgZG9lc27igJl0IGNvbWUgZnJvbSBhIFBHUCBzaWduYXR1cmUg4oCU
IGl0IGNvbWVzDQo+PiAoYXQgbGVhc3QgZm9yIG5vdykgZnJvbSBoYXZpbmcgY2xvbmVkIHRoZSBw
YWNrYWdlIHJlcG9zaXRvcnkgZnJvbSBHaXRIdWIuDQo+IA0KPiBOb3QgcmVhbGx5IHRoZSBjYXNl
LCBpZiB5b3UncmUgcmVseWluZyBvbiBhIHBhcnRpY3VsYXIgY29tbWl0IGhhc2gsIGFzIHlvdQ0K
PiBzdGF0ZS4gT25jZSB5b3Ugc3BlY2lmeSBhIHRhcmdldCBoYXNoLCB5b3UgZG9uJ3QgcmVhbGx5
IGhhdmUgdG8gY2FyZSB3aGVyZSB0aGUNCj4gcmVwb3NpdG9yeSBjYW1lIGZyb20gLS0gdGhlIGhh
c2ggaXMgZWl0aGVyIGdvaW5nIHRvIGJlIHRoZXJlIGFuZCBiZSB2YWxpZCwgb3INCj4gaXQncyBu
b3QgZ29pbmcgdG8gYmUgdGhlcmUuDQo+IA0KPiBJdCBvbmx5IG1hdHRlcnMgd2hlcmUgdGhlIHBl
cnNvbiB3aG8gcGlja2VkIHRoYXQgaGFzaCBjbG9uZWQgdGhlIHJlcG9zaXRvcnkNCj4gZnJvbSBh
bmQgd2hhdCBzdGVwcyB0aGV5IG1hZGUgdG8gdmVyaWZ5IHRoYXQgaXQgaXMgYSBsZWdpdGltYXRl
IGNvbW1pdC4gSWYgIkkNCj4gY2xvbmVkIHRoaXMgcmVwb3NpdG9yeSBmcm9tIGdpdGh1YiIgaXMg
c3VmZmljaWVudCBmb3IgeW91ciBuZWVkcywgdGhlbiB0aGF0J3MNCj4gZmluZS4gVGhlIGFsdGVy
bmF0aXZlIGlzIHRvIHVzZSBQR1AgdmVyaWZpY2F0aW9uLCBidXQgaW4gZWl0aGVyIGNhc2Ugb25j
ZSB5b3UNCj4gcGljayBhIGhhc2ggdG8gdXNlLCB5b3UgY2FuIHJlbHkgb24gZ2l0IHRvIGRvIGFs
bCB0aGUgcmVzdC4NCj4gDQo+PiBUaGF0IHNhaWQsIEkgZ3Vlc3MgSSBkbyBzdGlsbCBoYXZlIG9u
ZSBtb3JlIHF1ZXN0aW9uIOKAlCBob3cgc29vbiB3aWxsIGdpdA0KPj4gbm90aWNlIHRoYXQgYSBn
aXZlbiByZXBvIGlzIGNvcnJ1cHRlZC90YW1wZXJlZCB3aXRoIChpbnNvZmFyIGFzIHNoYTEgY2Fu
IGRvDQo+PiB0aGF0KT8gIE9uIGNoZWNrb3V0Pw0KPiANCj4gWWVzLiBJJ3ZlIGFza2VkIHRoaXMg
cXVlc3Rpb24gYmVmb3JlIGFzIHdlbGw6DQo+IGh0dHBzOi8vdXJsZGVmZW5zZS51cy92My9fX2h0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2dpdC8yMDE5MDgyOTE0MTAxMC5HRDE3OTdAc2lnaWxsLmlu
dHJhLnBlZmYubmV0L19fOyEhRzJrcE03dU0tVHpJRmNodSFnQXBLbWg0UkFROHp1ZURsSERuUnpI
Qm1LcG4wM0NTSDlXdmpnQWs2QzR0QmE1WkpNd1I4R0J1cm81bHN0aDB2TWckIA0KPiANCj4gVGhl
IHJlbGV2YW50IGJpdDoNCj4gDQo+ICAgIFRoZW4geWVzLCB0aGVyZSBpcyBubyBuZWVkIHRvIGZz
Y2suIFdoZW4gdGhlIG9iamVjdHMgd2VyZSByZWNlaXZlZCBvbg0KPiAgICB0aGUgc2VydmVyIHNp
ZGUgKGJ5IHB1c2gpIGFuZCB0aGVuIGFnYWluIHdoZW4geW91IGdvdCB0aGVtIGZyb20gdGhlDQo+
ICAgIHNlcnZlciAoYnkgY2xvbmUpLCB0aGVpciBzaGExcyB3ZXJlIHJlY29tcHV0ZWQgZnJvbSBz
Y3JhdGNoLCBub3QNCj4gICAgdHJ1c3RpbmcgdGhlIHNlbmRlciBhdCBhbGwgaW4gZWl0aGVyIGNh
c2UuDQo+IA0KPiAtSw0KDQo=
