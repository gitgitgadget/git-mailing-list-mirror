Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650A3C433FE
	for <git@archiver.kernel.org>; Mon,  7 Feb 2022 08:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiBGI1w (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 03:27:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244250AbiBGIQO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Feb 2022 03:16:14 -0500
Received: from mx0e-00379502.gpphosted.com (mx0e-00379502.gpphosted.com [67.231.147.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD19C043181
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 00:16:13 -0800 (PST)
Received: from pps.filterd (m0218361.ppops.net [127.0.0.1])
        by mx0f-00379502.gpphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2178E1xX014828;
        Mon, 7 Feb 2022 00:16:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=llnl.gov; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=02022021-podllnl;
 bh=Yjl0ip8bML2fNCnMTCWHpaLDoTbzl2s7IdOumegB13Q=;
 b=Tl359eWMRmT8r3N75I0UuaoY4/qpws4skXyx+CMnNurL6oY6SFgHoL2rkb0EKU642fWl
 zqbFhpoXlxV1q6pG5LRUw7ioD4c7a0zEj4q9fpN+QUO0GRHu78v/y8EMJeQF29M3SiYP
 WNThmOjn8Pe+21Ijsz7FQTl+7s0RvdTWwWag/1r82fGfC8bA2nMWLrn3duN2j5N4gFGy
 n0TLZejWa3F1W3ylTyum8JT08PIbj+B8MzQO6g97WPeBe4FozvLWbwjwr7XWUcuqV8Rt
 yxTJ8nonc5XpdutzLEcyKl/LCoV4g7qj5UMxsjuck2u60zVvnWxn03VV6WQpoqY7eM2C Iw== 
Received: from gcc02-bl0-obe.outbound.protection.outlook.com (mail-bl2gcc02lp2107.outbound.protection.outlook.com [104.47.64.107])
        by mx0f-00379502.gpphosted.com with ESMTP id 3e2nhv0ubh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Feb 2022 00:16:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iiAg48F0SRbD44IY1Q4gusfYcy/DRJuiOtYgh9u0qEboSvMDP/dxI/a/eiyX1oo4On9yN3fZqRs9AHLvataA3lBNpTBB5linPWG8ZoqTTnKgMdclNYqTr/x+W9I+y/2yx1rDU7OfPYjQxSTHQEmc8uFazBzzXGWLG2+wjGUaBMpENhjVFNgrjQ6E0KVkMq+0jhkUGtqKPS51oA17DBmqPiupt6d7Bjav5AW0QmSo+9cXYUU5Ak3CROO8DvXrZqh0MDFnhCsSbVm4FmtmJ43X0Tn2NGtRbUt83iAWfyymjM8fTuX6pFU2E4hGRvGoHl9GlhsEY4YXoYEDxKRzmRGyWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yjl0ip8bML2fNCnMTCWHpaLDoTbzl2s7IdOumegB13Q=;
 b=oGg3h9eadkWoFfj/w468CwDWpBjodAeuFS8wPA4ee0H/l0Nw4lOPVPXr+qlCBZ0VGGgvBq+cKdPACu0WEsBkzMFwT6M5mTP4xX8vrYrxPHAnCw905pXGKLyTWQWrnqrVrszRHwUJNPCczb4SPBw2hlaSyWSjDIPCbk20Gr7tUPJCvIN/tZQnHsyNBbxjyTbRr6R0+5LazPLT7rzH5yY9uo8BkLBg7Xfr1GqcX3wWuDBF+n37OCAkKACrfIoSTpupi0CcCWwp61TDjg1wEnW1KmmJBnMwYVmsfpg1dlmOdWzxfR0uBbBiGU0R78xtUzq5GWgTw/i2ehh1xSUd5DG4gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=doellnl.onmicrosoft.com; s=selector1-doellnl-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yjl0ip8bML2fNCnMTCWHpaLDoTbzl2s7IdOumegB13Q=;
 b=KTZNqXP6hockG7z+wtkdCXFtANgXGPMikplBzU3eQDEnYu2lxCrChDF5adiId7yKnnLJKIN3a8cAIRA71k/bSkCvbU0Y+EyWknu5fa1N5M6R6hHZNa/wsbOUFKohKGuPHNnvbz+WgWXE7Xxl+/lCubJerxcLJWBeWjWm5/V4HNc=
Received: from BY5PR09MB5972.namprd09.prod.outlook.com (2603:10b6:a03:242::12)
 by BY5PR09MB4706.namprd09.prod.outlook.com (2603:10b6:a03:24b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Mon, 7 Feb
 2022 08:15:58 +0000
Received: from BY5PR09MB5972.namprd09.prod.outlook.com
 ([fe80::1152:ffb:b909:9231]) by BY5PR09MB5972.namprd09.prod.outlook.com
 ([fe80::1152:ffb:b909:9231%2]) with mapi id 15.20.4951.019; Mon, 7 Feb 2022
 08:15:58 +0000
From:   "Gamblin, Todd" <gamblin2@llnl.gov>
To:     Philip Oakley <philipoakley@iee.email>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Commit SHA1 == SHA1 checksum?
Thread-Topic: Commit SHA1 == SHA1 checksum?
Thread-Index: AQHYGi5p7M1/4kXYKkqhLSADSBwD+KyFqvkAgAClySOAAJl4gIAACmf7gAAZTQCAALOSgA==
Date:   Mon, 7 Feb 2022 08:15:58 +0000
Message-ID: <734DE4FA-E4B1-43CB-89EE-3C200FA21F4F@llnl.gov>
References: <ED97E252-CABA-41BB-B18C-819A5EF305E3@llnl.gov>
 <121ce485-bea8-3168-aa35-d11eb13022da@iee.email> <xmqq1r0gjo6h.fsf@gitster.g>
 <eca83634-ee91-89bd-567e-6b0807b5ff79@iee.email> <xmqqee4fix0l.fsf@gitster.g>
 <13f21a57-1519-5ace-30e8-def598fad38b@iee.email>
In-Reply-To: <13f21a57-1519-5ace-30e8-def598fad38b@iee.email>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 57b043ff-bf1d-4e63-519d-08d9ea12121a
x-ms-traffictypediagnostic: BY5PR09MB4706:EE_
x-microsoft-antispam-prvs: <BY5PR09MB47061D94B2842210EE619D6DF82C9@BY5PR09MB4706.namprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ju0BlzYb3oCXgMCKhmxKQJJsND2MnLwUIHu4BZkcB65QXQoqpQWg3beBrSk9EdW/4sS1Z21ytMbgIrnO6ZS59THhvc8xRnKOLoDZ7cqzt3goAsaEUIu+3OIxoIYB/CK0YOU2bSC/A5FucZrsHH5dRqK9QDd2/YwPtgXRoYM2d42N9Tvm4M9ccIg/6+M5L1yL+uWqN9shULgio63swvBI4U//Am6IbxFLjVv+9RG5mmOvjlcyADAGSM7YkNwGx+SQfBqbGIx40GgI2AnVITBEGQFlFm8m4QvAQXl3VL0lZ8gQIB0zr1H1Y/Vg05wNRdu5bdOAH5ZDTlf2A7o7bEQi0eezWXshQkzAvNIR5AxNkOF69nvwRUqmmtvNAbhCOhFrJj+SyACIxBR/ndP30NmPT5DrwdTFQysZQfdr6o8nFRcva8AxfG6cx6+REVBXTkkWfBZvcPtMoz0r1AY1BaKlzvcXlqUaSO1CKNs558LBi8R2tK+wRf2OJ1y7ESDDF18hBLC5zfDbknaJvvTE4yRJ+qtNjMShbci7KByX7Tqy86EexUFEp4oWRJUNxCmAunJR3BTa62tQCHYX/nwOFdfP855GXThmbYpP1FmR/V6zkco+NM1L0BWEGTXsR7yD+oyTdj3Khz3rTsaM0fVcXSpizKiYNiN4KyHI5t2W51CdJQcUcFB2bfpF4z1NQJb76pnv+79Bl23ZoFYgt4hyigDiIFUV0x5YCtpx6Kd+vbhDC7k1/lw9x/ek5oH/X/rnJT94T6a8RIdJ8ZK9ElEAD9xD1WQsXZ9G8pCnyRziq5ROXy/pCowRJk43DZaKrQXISaue
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR09MB5972.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(82960400001)(38100700002)(83380400001)(8676002)(8936002)(33656002)(76116006)(2906002)(66556008)(66946007)(64756008)(66446008)(66476007)(4326008)(36756003)(5660300002)(110136005)(6486002)(86362001)(966005)(53546011)(6506007)(38070700005)(2616005)(71200400001)(26005)(186003)(6512007)(122000001)(316002)(508600001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QmRLREN6SGZtS1lsTWUwWk9XZVBsZjJKczBXem5NR2QxR2U2OHVMRzVYQ3JZ?=
 =?utf-8?B?RFNTcjZaWmc3dGVPYjJiNVpEaHZMSzkwZ0x1ODdtTmZBM3VVdUdZZ3VJV3l2?=
 =?utf-8?B?UXlaa21zeWwvRkYwQ0cyRXFsN0lHc2xzWWJ4NjBxek1BVlkwUk1Demw5M05q?=
 =?utf-8?B?cmJPeS9NcnpXZUdseklFR0pDR2NndmZLaDYwQTM2SzJIaUJ6TXJaZzk0OEtK?=
 =?utf-8?B?bXliNFYxYkI3MXFRVjdEQncrUUJpVHhRbWQ0SWxMNFhqSTYySGJrbURMaXVV?=
 =?utf-8?B?azg3MkJHayt5a0M0cWZwRytYNk1FRXpNQUJoQmNrV2hNdDgvR1hMV3VOYkMx?=
 =?utf-8?B?a1JZdXppWFJUWE5XLzN3ei9YdWdoRlR5ajNxdUk4b0lZSmNxbFpGTmJ3OFJp?=
 =?utf-8?B?MVZKWnpGZTg3eUxFcG9qaWt4TnpjQis1K3lKK29TeG1jWWpycm8yQ0xLUGRD?=
 =?utf-8?B?RG56d1BOSWxBZ1AyVlJSNlQvUlBBbnBjVU9BUENURlZzeG9MWUY2SnhXTllB?=
 =?utf-8?B?LzJIT3hSZ1VLMUFCTkdUMjNaa244aWYvSWMrV3ErUWF1aEVvQklDR0plYkRG?=
 =?utf-8?B?VzByeWdQQzNjbFMvUXhXbUJPNXJNdE9SbWpyLy9MY2ZlSFphNnZ6NDdOWjF3?=
 =?utf-8?B?d2dTRU5qSEs4TCtQU2hxRndHWUtDSVhaME1jVHJDOHIxR0lCWFJKSjNGRS9a?=
 =?utf-8?B?dC9pMGJDWUN2VS9DaFFGTTVDeEliUEZ1RXJic3JhVks5eFE1MTB1YnMrSklu?=
 =?utf-8?B?K2JNT0dsMXY5bjA3bmUzR3RES0hwV3lyc0tER3NjRkp1S3kxOVdhYnVoZXlW?=
 =?utf-8?B?a3VmTGJ3bTBVSWxOeTZKSStpTjkwWkM1eTVlL1FVaXRhaFIwSjhXUjVraGlS?=
 =?utf-8?B?QWZiZndMdU03WVplNmV4UHlTSXVrV3MranptUWRZUjJ6VUFaT2RuUXkzR2lQ?=
 =?utf-8?B?elBDdnF6KzFBOVQwREhyQUVuVkZZQllTbTQ2N1p3eEErdmczVm9zTzl5b0Z6?=
 =?utf-8?B?MTEyZWVvVjdKbWUzM3VKQjVIVG5RNUUzektmV01GQ3VZMTRyb2xVaUt3M1B6?=
 =?utf-8?B?cU0rczcyVzVEN1c3UXdRSlFoM0lMVkhsSnI2aCtpNHpzc1hCTXFPcGg4dnp5?=
 =?utf-8?B?YjExNXhBUnBMVDRlMVhPZk1EcFpBM05SbTM5VFRqcTc0T2lQaU9zUkh2UnZB?=
 =?utf-8?B?cXhsN2d6S3o3eEphejBKTERCMi9YdXQrMHhJcGVTbWtEbzV4Sit4cU5CUjlI?=
 =?utf-8?B?RnkzZ1QvZ1dhWTJWQ1RjUXgxZStPWFRRTU1qNXdKaUN5REI5WXVSODk3OGNy?=
 =?utf-8?B?MStVMmFuejAySGtpb0d2QmU1dmx3Mm8raHdVQlQwNmxHWFMveTY3c0I0cFRY?=
 =?utf-8?B?aVE3WTN4NGFXNzhYekViUmhDZ0NUWm1mZnRMS2h0TlQ2a1VYeHJhN2tPSEhp?=
 =?utf-8?B?RzBBV3F1TGpNOEpyUkd6b1JCd0l6dm5zekVSdlhkYVJFS3Z6N2xkR2lCdGhU?=
 =?utf-8?B?WjZOaGg3MlhuS2JHdWVRZlNrMXpUTjZDSG5xckIwVUxTNS92b0Uva0YybldQ?=
 =?utf-8?B?Wk9GWTZYcnpGRUhROGFoQ2N0elVBbVhONU5zd25ZN0o3dXhOTVNWaExVY21s?=
 =?utf-8?B?cm1vY05CdkhTVU1CUjNVZTA5dkJ2dXdTMjI0VXN5Y0VyOWtaUVR6cWkwY25H?=
 =?utf-8?B?TFA4NDV2MjJsN0RjZzdHUjU3a2JZOEFJY3lnMDdYYVFrWGRQWmc0bmRRK0p6?=
 =?utf-8?B?Y0xPT2NmYmdROXRpQ0xHWFNOTEt1Z3pVS3Fzb2QxUnI3NG8zbVZNdUFVNm84?=
 =?utf-8?B?VlYvK1h3MzJrNFJ2OHdFdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2292C29D8CEBBD479137F7E1E4D31957@namprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: llnl.gov
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR09MB5972.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57b043ff-bf1d-4e63-519d-08d9ea12121a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2022 08:15:58.3035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a722dec9-ae4e-4ae3-9d75-fd66e2680a63
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR09MB4706
X-Proofpoint-GUID: oc-mRUEUYMvpgpHBdodtGaUKtWQcJCAD
X-Proofpoint-ORIG-GUID: oc-mRUEUYMvpgpHBdodtGaUKtWQcJCAD
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.816
 definitions=2022-02-07_03:2022-02-03,2022-02-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 mlxlogscore=999 mlxscore=0 spamscore=0 phishscore=0 clxscore=1015
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202070054
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

VGhhbmtzIGV2ZXJ5b25lIGZvciB0aGUgcmVzcG9uc2VzLiAgSSB0aGluayBKdW5pb+KAmXMgY29t
bWVudCBzdW1tZWQgdXAgd2hhdCBJIHdhcyBhc2tpbmcgbmljZWx5Og0KDQo+IEFzIG11Y2ggb3Ig
YXMgbGl0dGxlIHRydXN0IHlvdSBoYXZlDQo+IGluIFNIQS0xIGluIHZhbGlkYXRpbmcgdGFyYmFs
bC50YXIgd2l0aCBpdHMga25vd24gU0hBLTEgY2hlY2tzdW0sDQo+IHlvdSBjYW4gdHJ1c3QgdG8g
dGhlIHNhbWUgZGVncmVlIHRoYXQgdGhlIGNvbW1pdCB0aGF0IGlzIHBvaW50ZWQgYnkNCj4gYSB0
YWcgaXMgd2hhdCB0aGUgcGVyc29uIHdobyBzaWduZWQgKHdpdGggR1BHKSB0aGUgdGFnIHdhbnRl
ZCB0aGUNCj4gdGFnIHRvIHBvaW50IGF0LCBhbmQgaW4gdHVybiB0aGUgdHJlZXMgYW5kIGJsb2Jz
IGluIHRoYXQgY29tbWl0IGFyZQ0KPiB3aGF0IHRoZSBzaWduZXIgd2FudGVkIHRvIGhhdmUgaW4g
dGhhdCB0YWdnZWQgY29tbWl0LCBhZCBpbmZpbml0dW0sDQo+IGluIHRoZSBzcGFjZSBkaW1lbnNp
b24uICBBdCB0aGUgc2FtZSB0aW1lLCBhIGNvbW1pdCBvYmplY3QgcmVjb3Jkcw0KPiB0aGUgaGFz
aCBvZiB0aGUgY29tbWl0IG9iamVjdHMgdGhhdCBhcmUgaXRzIHBhcmVudHMsIHRoZSB3aG9sZQ0K
PiBoaXN0b3J5IG9mIHRoZSBwcm9qZWN0IGdvaW5nIGJhY2sgdG8gaW5jZXB0aW9uIGNhbiBiZSB0
cnVzdGVkIHRvIHRoZQ0KPiBzYW1lIGRlZ3JlZSBpbiB0aGUgdGltZSBkaW1lbnNpb24uDQoNCklu
IG91ciBjYXNlLCB0aGUgaW5pdGlhbCB0cnVzdCBkb2VzbuKAmXQgY29tZSBmcm9tIGEgUEdQIHNp
Z25hdHVyZSDigJQgaXQgY29tZXMgKGF0IGxlYXN0IGZvciBub3cpIGZyb20gaGF2aW5nIGNsb25l
ZCB0aGUgcGFja2FnZSByZXBvc2l0b3J5IGZyb20gR2l0SHViLiBTbyB5b3UgdHJ1c3QgR2l0SHVi
IGJ5IGNsb25pbmcgb3ZlciBodHRwcywgYW5kIHlvdSB0cnVzdCB0aGUgU3BhY2sgbWFpbnRhaW5l
cnMgdG8gb25seSBtZXJnZSBzYWZlIHRoaW5ncyBpbnRvIGBkZXZlbG9wYCBvciBzb21lIHJlbGVh
c2UgYnJhbmNoLiAgQSBwYWNrYWdlIGRlc2NyaXB0aW9uIGluIHRoZSByZXBvIG1pZ2h0IGhhdmUg
c29tZSB2ZXJzaW9ucyBzcGVjaWZpZWQgYnkgY29tbWl0LCBsaWtlIHRoaXM6DQoNCglodHRwczov
L3Jhdy5naXRodWJ1c2VyY29udGVudC5jb20vc3BhY2svc3BhY2svNWZmNzJjYS92YXIvc3BhY2sv
cmVwb3MvYnVpbHRpbi9wYWNrYWdlcy9hY3RzL3BhY2thZ2UucHkNCg0KV2UgdXNlIHRoZSBzcGVj
aWZpZWQgY29tbWl0cyB0byBidWlsZCBwYWNrYWdlcyBmcm9tIHNvdXJjZSwgb3IgdG8gY3JlYXRl
IChob3BlZnVsbHkpIHJlcHJvZHVjaWJsZSBiaW5hcnkgcGFja2FnZXMuIEFueXdheSwgbGlrZSB0
aGUgUEdQIGNhc2UsIHlvdeKAmXJlIGdpdmVuIGEgY29tbWl0IGhhc2ggZnJvbSBzb21lIHRydXN0
ZWQgc291cmNlLiAgVGhlIHF1ZXN0aW9uIHdhcyByZWFsbHkgd2hldGhlciB5b3UgY2FuIHJlbHkg
b24gdGhlIGhhc2ggbGlrZSBhIHNoYTEgY2hlY2tzdW0g4oCUIGFuZCBpdCBzZWVtcyBsaWtlIHlv
dSBjYW4uDQoNClRoYXQgc2FpZCwgSSBndWVzcyBJIGRvIHN0aWxsIGhhdmUgb25lIG1vcmUgcXVl
c3Rpb24g4oCUIGhvdyBzb29uIHdpbGwgZ2l0IG5vdGljZSB0aGF0IGEgZ2l2ZW4gcmVwbyBpcyBj
b3JydXB0ZWQvdGFtcGVyZWQgd2l0aCAoaW5zb2ZhciBhcyBzaGExIGNhbiBkbyB0aGF0KT8gIE9u
IGNoZWNrb3V0Pw0KDQpSRTogSm9oYW5uZXM6DQo+IChIb3cgY291bGQgeW91IGV2ZW4gY29udGVt
cGxhdGUgdGhhdCBpdCBkb2VzIG5vdD8gSXQgaXMgdGhlIG1vc3Qgb2J2aW91cyB3YXkgdG8gcHJv
dGVjdCB0aGUgY2xvbmVyLikNCg0KSSBoYXZlIGFsd2F5cyBhc3N1bWVkIHRoaXMgd2FzIHRoZSBj
YXNlIGJ1dCBuZXZlciBjb3VsZCBmaW5kIGFueXRoaW5nIGluIHRoZSBkb2NzIHNheWluZyBleHBs
aWNpdGx5IHdoYXQgSnVuaW8gc2FpZCBhYm92ZS4gIEl0IGlzIGhhcmQgZm9yIG1lIHRvIGltYWdp
bmUgZ2l0ICpub3QqIHdvcmtpbmcgdGhpcyB3YXksIGJ1dCBJ4oCZdmUgYmVlbiBhc2tlZCB0aGlz
IHF1ZXN0aW9uIGJ5IGVub3VnaCBvZiBvdXIgcGFja2FnZSBtYWludGFpbmVycyB0aGF0IEkgdGhv
dWdodCBJ4oCZZCBicmluZyBpdCB1cCBoZXJlLg0KDQpSRTogUGhpbDoNCg0KPiBIb3BlZnVsbHkg
VG9kZCB3aWxsIGJlIGFibGUgdG8gY2xhcmlmeSBpZiB0aGF0ICdhcmNoaXZlIHZzIHRhZycgY3Jv
c3MNCj4gY2hlY2sgd2FzIHBhcnQgb2YgdGhlIHF1ZXN0aW9uLCBvciB3aGV0aGVyIGl0IHdhcyBw
cmltYXJpbHkgZm9jdXNzZWQgb24NCj4gdGhlIGludGVybmFsbHkgR2l0IGNoZWNrcyBkdXJpbmcg
Zm9yIGNvcnJlY3RuZXNzIGR1cmluZyBjbG9uZSBhbmQgZnNjay4NCg0KSXQgd2FzbuKAmXQgcGFy
dCBvZiB0aGUgb3JpZ2luYWwgcXVlc3Rpb24g4oCUIEkgd2FzIHJlYWxseSBqdXN0IGFza2luZyB3
aGV0aGVyIGdpdCBndWFyYW50ZWVzIHRoYXQgYSBmcmVzaCBgZ2l0IGNsb25lYCBvZiBzb21lIGNv
bW1pdCBhY3R1YWxseSBoYXMgdGhlIHN0YXRlZCBjb21taXQgaGFzaC4gIEkgcmVhbGl6ZSB0aGVy
ZeKAmXMgbm8gcmVsYXRpb24gYmV0d2VlbiB0aGUgc2hhMSBvZiBhIGNvbW1pdCBhbmQgdGhlIHNo
YTEgb3IgYW55IG90aGVyIGhhc2ggb2YgaXRzIHRhcmJhbGwgKGl04oCZZCBiZSBhIHByZXR0eSBi
YWQgaGFzaCBmdW5jdGlvbiBpZiB0aGVyZSB3YXMpLg0KDQpUaGF0IHNhaWQsIHdlIGFyZSBzdGls
bCB0cnlpbmcgdG8gd29yayBvdXQgc29tZSBwcmFjdGljYWwgKmFuZCBzZWN1cmUqIHdheSB0byBt
aXJyb3IgZ2l0IGNvbW1pdHMgYXMgYSBzaW1wbGUgZG93bmxvYWQuICBJIHRoaW5rIHdlIG5lZWQg
dG8gZ2VuZXJhdGUgdGhlIHRhcmJhbGxzIG91cnNlbHZlcyBhbmQganVzdCBhZGQgdGhlaXIgc2hh
MjU24oCZcyB0byB0aGUgcGFja2FnZSDigJQgR2l0SHViIGRvZXMgdGhpcywgYW5kIHRoZWlyIGFy
Y2hpdmUgZ2VuZXJhdGlvbiBsb2dpYyBoYXMgY2hhbmdlZCBpbiB0aGUgcGFzdCBhcyBKdW5pbyBk
ZXNjcmliZWQgYmVsb3cuICBJdOKAmXMgbWVzc3kgYi9jIGl0IHJlcXVpcmVzIGFub3RoZXIgY2hl
Y2tzdW0gdGhhdCBtYXkgY2hhbmdlLCBidXQgSSBkb27igJl0IHNlZSBhIHdheSBhcm91bmQgaXQu
ICBXZSBjYW7igJl0IGp1c3QgdGFyIHVwIGEgZ2l0IHJlcG8gLSB0YXIgYW5kIG90aGVyIGNvbXBy
ZXNzaW9uIHRvb2xzIGNhbiBoYXZlIHZ1bG5lcmFiaWxpdGllcyBhbmQgd2Ugd2FudCB0byBjaGVj
a3N1bSBhbnkgaW5wdXQgd2UgcGFzcyB0byB0aGVtLg0KDQpUaGFua3MgYWdhaW4gZm9yIGFsbCB0
aGUgaGVscGZ1bCByZXNwb25zZXMuDQoNCi1Ub2RkDQoNCg0KDQo+IE9uIEZlYiA2LCAyMDIyLCBh
dCAxOjMzIFBNLCBQaGlsaXAgT2FrbGV5IDxwaGlsaXBvYWtsZXlAaWVlLmVtYWlsPiB3cm90ZToN
Cj4gDQo+IE9uIDA2LzAyLzIwMjIgMjA6MDIsIEp1bmlvIEMgSGFtYW5vIHdyb3RlOg0KPj4gUGhp
bGlwIE9ha2xleSA8cGhpbGlwb2FrbGV5QGllZS5lbWFpbD4gd3JpdGVzOg0KPj4gDQo+Pj4gSSB0
aGluayBwYXJ0IG9mIFRvZGQncyBxdWVzdGlvbiB3YXMgaG93IHRoZSB0YWcgYW5kIHVuY29tcHJl
c3NlZCBhcmNoaXZlDQo+Pj4gJ2NoZWNrc3VtcycgKGUuZy4gaGFzaGVzKSByZWxhdGUgdG8gZWFj
aCBvdGhlciBhbmQgd2hlcmUgdGhvc2UNCj4+PiBndWFyYW50ZWVzIGNvbWUgZnJvbS4NCj4+IFRo
ZXJlIGlzIG5vIHN1Y2ggbGlua2FnZSwgYW5kIHRoZXJlIGFyZSBubyBndWFyYW50ZWVzLiAgVGhl
IHRydXN0DQo+PiB5b3UgbWF5IG9yIG1heSBub3QgaGF2ZSBvbiB0aGUgUEdQIGtleSB0aGF0IHNp
Z25zIHRoZSB0YWcgYW5kIHRoZQ0KPj4gY2hlY2tzdW1zIG9mIHRoZSB0YXJiYWxsIGlzIHRoZSBv
bmx5IHNvdXJjZSBvZiBzdWNoIGFzc3VyYW5jZS4NCj4+IA0KPj4gTW9yZSBpbXBvcnRhbnRseSwg
SSBkbyBub3QgdGhpbmsgdGhlcmUgY2FuIGJlIGFueSBzdWNoIGxpbmthZ2UNCj4+IGJldHdlZW4g
dGhlIEdpdCB0cmVlIGFuZCByZWxlYXNlIHRhcmJhbGwgZm9yIGEgZmV3IGZ1bmRhbWVudGFsDQo+
PiByZWFzb25zOg0KPj4gDQo+PiAqIFdlIGFkZCBnZW5lcmF0ZWQgZmlsZXMgdG8gImdpdCBhcmNo
aXZlIiBvdXRwdXQgd2hlbiBjcmVhdGluZyB0aGUNCj4+ICAgcmVsZWFzZSB0YXJiYWxsIGZvciBi
dWlsZGVyJ3MgY29udmVuaWVuY2UsIHNvIGlmIHlvdSBkaWQNCj4+IA0KPj4gICAgICAgcm0gLWZy
IHRlbXAgJiYgZ2l0IGluaXQgdGVtcA0KPj4gICAgICAgdGFyIEN4ZiB0ZW1wIGdpdC0kVkVSU0lP
Ti50YXINCj4+ICAgICAgIGdpdCAtQyB0ZW1wIGFkZCAuICYmIGdpdCAtQyB0ZW1wIHdyaXRlLXRy
ZWUNCj4+IA0KPj4gICB0aGUgdHJlZSBvYmplY3QgbmFtZSB0aGF0IHlvdSBnZXQgb3V0IG9mIHRo
ZSBsYXN0IHN0ZXAgd2lsbCBub3QNCj4+ICAgbWF0Y2ggdGhlIHRyZWUgb2JqZWN0IG9mIHRoZSB2
ZXJzaW9uIGZyb20gbXkgYXJjaGl2ZSAoaW50ZXJlc3RlZA0KPj4gICBwYXJ0aWVzIGNhbiBzdHVk
eSAibWFrZSBkaXN0IiBmb3IgbW9yZSBkZXRhaWxzKS4NCj4+IA0KPj4gKiBFdmVuIGlmIHdlIGRp
ZCBub3QgYWRkIGFueSBmaWxlcyB0byAiZ2l0IGFyY2hpdmUiIG91dHB1dCB3aGVuDQo+PiAgIGNy
ZWF0aW5nIGEgcmVsZWFzZSB0YXJiYWxsLCBhIHRhcmJhbGwgdGhhdCBjb250YWlucyBhbGwgdGhl
DQo+PiAgIGRpcmVjdG9yaWVzIGFuZCBmaWxlcyBmcm9tIGEgZ2l2ZW4gZ2l0IHJldmlzaW9uIGlz
ICpOT1QqIHVuaXF1ZS4NCj4+ICAgV2UgZG8gbm90IGFkZCByYW5kb21uZXNzIHRvIHRoZSAiZ2l0
IGFyY2hpdmUiIG91dHB1dCwganVzdCB0bw0KPj4gICBtYWtlIHRoZW0gdW5zdGFibGUsIGJ1dCB3
ZSBoYXZlIG1hZGUgZml4ZXMgYW5kIGltcHJvdmVtZW50cyB0bw0KPj4gICB0aGUgYXJjaGl2ZSBn
ZW5lcmF0aW9uIGxvZ2ljIGluIHRoZSBwYXN0LCBhbmQgd2UgZG8gcmVzZXJ2ZSB0aGUNCj4+ICAg
cmlnaHRzIHRvIGRvIHNvIGluIHRoZSBmdXR1cmUuICBBbmQgaXQgaXMgbm90IGp1c3QgbGltaXRl
ZCB0bw0KPj4gICAiZ2l0IGFyY2hpdmUiIGJpbmFyeSwgYnV0IGhvdyBpdCBpcyBkcml2ZW4sIGUu
Zy4gInRhci51bWFzayINCj4+ICAgc2V0dGluZ3MgY2FuIGFmZmVjdCB0aGUgbW9kZSBiaXRzLg0K
PiBUaGFua3MgZm9yIHRoZSBjbGFyaWZpY2F0aW9uLg0KPiANCj4gVGh1cyB3aGF0IHRydXN0IHRo
ZWlyIGlzLCBpcyB2aWEgdGhlIHR3byBQR1Agc2lnbmF0dXJlcywgcmF0aGVyIHRoYW4NCj4gZGly
ZWN0bHkgYmV0d2VlbiB0aGUgdGFyYmFsbCBhbmQgdGhlIGdpdCByZXBvLg0KPiAtLQ0KPiBQaGls
aXANCj4gDQoNCg==
