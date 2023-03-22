Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF115C6FD1F
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 15:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbjCVPK1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 11:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjCVPKZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 11:10:25 -0400
Received: from mailfronta3.caissedesdepots.fr (mailfronta3.caissedesdepots.fr [212.157.112.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F64591DB
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 08:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=caissedesdepots.fr; s=mx1; t=1679497824;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FNfCwA23oiWgF4mPjLpjBZRFv8jDYoezGXcSld3l8OA=;
  b=aHkZgY+gm7gYE0fR8aj3OlpxYNv2+m06RTE/1sqZaiWxhwOj9DsWjHVT
   OqYG+clKqtPpcRcR8tivR6qf/Wp3M2suQK6rOYN7NreEibh6vIP3MUfGu
   i3b+NT8lOy5D+sUBEbMpEwNMqtU07MVUNSU7Y++LYiCqRlTNjce7cR6/u
   I=;
Received: from dlmailfedproda2.inet.local (HELO mailfrontfeda2.serv.cdc.fr) ([158.156.1.195])
  by mailfronta3b.caissedesdepots.fr with ESMTP; 22 Mar 2023 16:10:22 +0100
X-IronPort-AV: E=Sophos;i="5.98,282,1673910000"; 
   d="scan'208";a="16387940"
X-MGA-submission: =?us-ascii?q?MDE0j9H2tQryyo1xYt4lq7dfYXKDuL8Ft7Ex30?=
 =?us-ascii?q?RjypR0lPMOSYRsfP5YuC9aRevwl6jkUS2fUu98DNlwaRfXxdGNcWEwbl?=
 =?us-ascii?q?cC3LCm8mdXvqZIl0W/qCI8sciO+R8wLBJ+YzZ8wtI+G05bqbHqwMRaFj?=
 =?us-ascii?q?YG?=
Received: from is9prif00113.ap.cdc.fr ([10.12.149.220])
  by mailfrontfeda2.serv.cdc.fr with ESMTP; 22 Mar 2023 16:10:22 +0100
Received: from IS9PRIF00117.ap.cdc.fr (10.12.149.182) by
 IS9PRIF00113.ap.cdc.fr (10.12.149.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 22 Mar 2023 16:10:22 +0100
Received: from IS9PRIF00140.serv.cdc.fr (10.11.134.75) by
 IS9PRIF00117.ap.cdc.fr (10.12.149.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 22 Mar 2023 16:10:22 +0100
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (158.156.156.209)
 by hybridesmtp.caissedesdepots.fr (158.156.156.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 22 Mar 2023 16:10:19 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SvEjvviPpumptPHyHW87YcaGeFUw5PMAtftHzhNWTQR9JmUaW4tKJ+DZ02AnqFfR2c2KnTDnBpUuulQXCiBU0ZFJFHN0BURFZTbSD45rJVapc+Wk5adxM82JYLpPDbnfSEwwHf7S/jkHSXhSxy6DWjDeutMWXahDKXw1OEOiG/bERydYy5GAYe+0ceUo/kE+zqragd0zILLsR5BZNjVEVDRbpG3JEoTMxlsts02inxDPtMPwVq+0LYF+p/Kt4D29dpfK+yEMuA1deMFod3hUO2wvDg7xlqcopQbf3N5Vz0nXKKERtXLfQcjJ8escJFJBCBASc39I0Xf9UDsv0yObEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FNfCwA23oiWgF4mPjLpjBZRFv8jDYoezGXcSld3l8OA=;
 b=CzkP9OSIeyycJlHqaIKUMExlvyZaYDjp5fPRMbMZQ9DOO4QkWZumABHTgI9JIyQ97J7RRIUqeR1FNELZ4F0/4IzwYKEBuC57VLj67koC4nAaStemjhEI36O711/YG2tnbWEGnC8Fb/CQJK7K7iHw+HaSUHjbHhUY9UnMHr9ujduMoRKSaLJaQTvIe1bNxFvmCrL205hJW0NY2qkBDIJclJt7RubEdqvE/KS+O0y9cOqy6Z2HOo0fQUkPRMDyJ54ci/ULqIZ8a7W3nFrhfxKuCFmUkYgKJdUT/B9oj7ajgutXpzcAX07pvpGioRb3PIyxU5uERFYfVNIKoNtGy8cq6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=caissedesdepots.fr; dmarc=pass action=none
 header.from=caissedesdepots.fr; dkim=pass header.d=caissedesdepots.fr;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=caissedesdepots.onmicrosoft.com;
 s=selector2-caissedesdepots-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNfCwA23oiWgF4mPjLpjBZRFv8jDYoezGXcSld3l8OA=;
 b=WmiwNm4hdwZw6mcfpuAX5IdbhEp5YwACCv1o195SlLlvq8wtHE4kIEA59xwScRj3c+DFet3Q57lew6ZpjE7Vbue6cVykTiXrQS0W983/ZfgWr4wb4dfKWjNvVi097Qck2R1tX9wIU3lgLNlJd21VYWutQajWfT+eChPLzoV2lUQ=
Received: from PR2P264MB0799.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101:5::13) by
 PAZP264MB3287.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:113::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.37; Wed, 22 Mar 2023 15:10:20 +0000
Received: from PR2P264MB0799.FRAP264.PROD.OUTLOOK.COM
 ([fe80::9483:e6d4:9856:e66b]) by PR2P264MB0799.FRAP264.PROD.OUTLOOK.COM
 ([fe80::9483:e6d4:9856:e66b%7]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 15:10:20 +0000
From:   "Coirier, Emmanuel" <Emmanuel.Coirier@caissedesdepots.fr>
To:     ZheNing Hu <adlternative@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Minor bug regarding git-reportbug
Thread-Topic: Minor bug regarding git-reportbug
Thread-Index: AdlcwZ7iuBXUWVorTtS96wvFbIv8+gABH8QAAAKDpzA=
Date:   Wed, 22 Mar 2023 15:10:20 +0000
Message-ID: <PR2P264MB0799DAC31905C93ED2E4D2A2F4869@PR2P264MB0799.FRAP264.PROD.OUTLOOK.COM>
References: <PR2P264MB0799BA146D27303A72B3EF69F4869@PR2P264MB0799.FRAP264.PROD.OUTLOOK.COM>
 <CAOLTT8RfhvDSP-Tq1bFZ39H4YyvLJ5Yv0pCn15=2r4_Ay9ZgxQ@mail.gmail.com>
In-Reply-To: <CAOLTT8RfhvDSP-Tq1bFZ39H4YyvLJ5Yv0pCn15=2r4_Ay9ZgxQ@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_94e1e3e5-28aa-42d2-a9d5-f117a2286530_Enabled=true;
 MSIP_Label_94e1e3e5-28aa-42d2-a9d5-f117a2286530_SetDate=2023-03-22T15:10:19Z;
 MSIP_Label_94e1e3e5-28aa-42d2-a9d5-f117a2286530_Method=Standard;
 MSIP_Label_94e1e3e5-28aa-42d2-a9d5-f117a2286530_Name=C2-Interne avec
 marquage;
 MSIP_Label_94e1e3e5-28aa-42d2-a9d5-f117a2286530_SiteId=6eab6365-8194-49c6-a4d0-e2d1a0fbeb74;
 MSIP_Label_94e1e3e5-28aa-42d2-a9d5-f117a2286530_ActionId=b7895a96-c72b-4f1e-bba7-aa059f4fdd86;
 MSIP_Label_94e1e3e5-28aa-42d2-a9d5-f117a2286530_ContentBits=2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=caissedesdepots.fr;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PR2P264MB0799:EE_|PAZP264MB3287:EE_
x-ms-office365-filtering-correlation-id: d2bf4e98-bd85-4774-1af7-08db2ae78db9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nGWhMRvjXrVojJhaA4d4oVu4k46mUY6GL6J0NFJ8rK3apWzqojQqxbNSljShdvUR5kaEYBg1i5ExF/h/QWcbVBJMdSdH2ZhRAHIzhkSgLSDhy7xMTVASDujNUHpTUz/dXLFKuEQny0+pSoR/ON5+jXnFkzgtAT+rXgb2X+MtMu1dRTTJPiPXoez6F+kng/i6g8u5XWcL1Q5VeEa8/4term+wfv40IfmjatmzL/DfUaSC36dnin6tej/abdXmVVNKQSN0PCN7b63I2DNmynYQ2cHgwi4vflf7/JwQwtg2AEaNoraq6TMP1Trj5C2xt5M+ZElDjw9zT73r3juADIpad9U2H9Qopbxz2cpjkYITngR/pW7LwuKSOxJ+r6baYEAjGnF3zul9bG3i8NqamLHAEigtfWV5de3zo7CfrPy7bV0aOBgsps0guBONu88NIUvbkbhM4LdGusj2TSSMW+uVCqB+fzeYkmWbQURAHrfEO6UuviFUddtbPY2uOn1ugoPpimH4mtIC/l+cNAZRr+6RdxnYELRStvuut5O0A/9DqbaViw8JjmXRrFAV6lPn9uyux/nj94D8N6hFdTIPaupQey595wQ/ClP2kF/xBG4/PQLZ5IAz3Qqw4i0+UEZh8YjbJCWRo0FIUvZN2bAHfK2xwuSgGptbpuOFuzfZ7pwBM2WQAo4nQP65y5SNrxbPA4k22kIUB8LG5hZWgm5+Nz2SZw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR2P264MB0799.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(376002)(136003)(39860400002)(346002)(451199018)(52536014)(8936002)(5660300002)(41300700001)(55016003)(82960400001)(33656002)(38070700005)(86362001)(38100700002)(122000001)(2906002)(186003)(4326008)(83380400001)(478600001)(66574015)(7696005)(9686003)(6506007)(71200400001)(26005)(316002)(8676002)(76116006)(66446008)(6916009)(64756008)(66476007)(66946007)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXE4cDluWUtJZi80Ump1aTFBTy80Ynk0SlhhQ1JoUEgxSlVKcHYzU3h0Q0Vt?=
 =?utf-8?B?NWMwTlVyRVprS2FBYTV3bkpyNVNDdUV5cnZ4MlRXMmZKRitjNjdadUN3U2g4?=
 =?utf-8?B?bnFPb2lFSDdFaXhidjhjRmJScXhiT20xc1BtOVEyZjhoZUtrYjRPSzc2QXUv?=
 =?utf-8?B?OFFsUC94Sy9HV0RxSCtRdFBsbldteDNKQThKdlNrOUhOL3VmWVdtOEtFbkE4?=
 =?utf-8?B?bWt5am1OZmZQTmdQclRYMlplanZjNDJOMDFCZjFzU0Z4RGptTURoU05OV0RT?=
 =?utf-8?B?Wll1cGIrQllwV25icFlQSzZ3bll2cXhPc055YkV1SUJmdDh6aWxXakVQbmp4?=
 =?utf-8?B?d1d6MFhxUVhQRjJaL2k0SE5QMURCanM1RnFWYTIxK09RS1BES0dpVTQ4enR1?=
 =?utf-8?B?WmdFUkhzQ2l1VDVaVEJ0Y3Q2d0IxOEovWmRMenhrNG5mY2Z6WmwrTTd4c3RV?=
 =?utf-8?B?MWhzeU50UGZrbjA1MGFSMGQyT0crWDFteldvcW91K0ZLS2pzdHhjaXBVdm9U?=
 =?utf-8?B?ZXZSdmRZM2RhVEJVSktYNzRPdkxlSTJURExIQ0tWVms2NmtvVzY2MWY5cEhD?=
 =?utf-8?B?SFZ2dXdGWGsraGR2MDlxVHo2b2JMenFRU2g4d3BKcGVnRG9zYnlMaU9KT1cy?=
 =?utf-8?B?OWJBM0tEanF3UVJGOWhYRGZyd2gxVnF1cTJDVlVyYWREcmMzTzV0amlLWUVz?=
 =?utf-8?B?d3VwaDhRNWNGV3M4VFJqYW5WYVJxbFVCY1hLRFEvVWl6QjZlVGJPSFVJTG1u?=
 =?utf-8?B?dHpydXdlVGRINXYrS0llTkxxM2N5QlNpRERsQWV0Ry9GUXo0YTVvRHg4S2o0?=
 =?utf-8?B?QUJvcVpoSkNYa05jV0Vnc3hDNGlOd0tBVlZjTmx1TlQ1Q2dvUFZjYjRyY0VD?=
 =?utf-8?B?ZzhxU0lmeG5UaWZUdGUwTmRhM0JrTlVMY2h6WGRaQ2U2Zm9uVElIRHlHWGRZ?=
 =?utf-8?B?bXIrUE01clY2RlFqdTdMYUMyN0tRVCtzQW9VMWp3TloweG9TUG9FNzd4NWdN?=
 =?utf-8?B?c2d6YW9mQWV6bm83bll2MGdXRkdTV085RUlxWFk5ZzZMNzhzSlQ4anhXK1cv?=
 =?utf-8?B?ZXRURk5BMDVYQnJMZVJsaTBzck9qK2FhQjI0SXlCaHk5ZE85bzlSWnhheTZH?=
 =?utf-8?B?RmZDU1ptVzlOMkJpd0xzWEN2cUJuUG4vcmZXK3hiVXVXWmNyL2dDK2lRdXJz?=
 =?utf-8?B?L29TMmdlUC9wOU1lTE5iaGhOV2F2RDAxNFo4czM0RGxFL3RJZXo4RkZub0FU?=
 =?utf-8?B?RVByUXlwRDZEaFNUTllEdjRWNzRsRmZIMGpyY2VWR3JpN2ttbWFBVzBORDNi?=
 =?utf-8?B?Wk5MTHpWbkZFY3JlU3RsT2hwQUJwdG5zUU5DWWhjWVozeDNYV0d1aEdLVjVT?=
 =?utf-8?B?RzZVd0lMRWQ1V1lHVmhaakkvcE9vN0x0V1R4LzJUUGs4b29UbmtSMUY2Vlly?=
 =?utf-8?B?TFN3ZmxUcGxBVDFYQW1KV1BXWnAvOGhRYmdOejhVZTZwNEJoc2NMQ1Q3Qm1U?=
 =?utf-8?B?c2ZkaWg5NkVOd2lsUnBBakg5Z1FUTDd0S0x6Z0dMN0hpdzc1ZXVHS1k4bzBp?=
 =?utf-8?B?MzZvb2lJR1ZKMlBKWURpTW11V294cFViTUVmWk9PNHB3MTV2ckxOeUswcmQ2?=
 =?utf-8?B?Sk1CdDg5QTQ2Z2YvRi9FS0hyOFRXbFc1S2FCQ0Y5WmtrazA2SFVERm1aRC9q?=
 =?utf-8?B?SkJncWVwRStPeFdWdlREL3FhWTFZSXFKN3BSTmd5enBzenZ0Z2d2ek55Njc4?=
 =?utf-8?B?NWtoZStQRVd0N29BNDVRa1UwUFdjNHNUaXRLb3dsU3NaOHh5RFhhNC9QWjhy?=
 =?utf-8?B?M2FBazN5M3J4VjdRb0U2SkxZTkZ4VVhsZzVaSHQ3V2hYMFVBUzgyblNxem9x?=
 =?utf-8?B?YmtuMFloNkJZMmlKK3ZNM0wrUllXY2U3M0xhOTdUMGt3ZVVRUk5kd0ZOdE5I?=
 =?utf-8?B?M3FuV1UzRVVUbDlTVVQ3RXJCcU1qRkVBSEcyZm0wOERpdy9xM3lDVE5sc2Ra?=
 =?utf-8?B?Z3g3SkhKeHlDL081VG9GbytXREM2NGZtYSs1ZG01WDJMd3o5R005OGFHQkdF?=
 =?utf-8?B?WUhlYUFLaTJUVnZlcDFJOVBpMTdPZVh4dDhhMElURXF4dmlVZ2phS0Z5QzZU?=
 =?utf-8?B?TUY4ZTRsTHpLMFhkTGFUeGVQQlRkZTR3TXFlSXpJTWUwQkU3cytvVnJlTFJ6?=
 =?utf-8?Q?G4xjWNp0uys5d4T/r36Qr1A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR2P264MB0799.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d2bf4e98-bd85-4774-1af7-08db2ae78db9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2023 15:10:20.6118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6eab6365-8194-49c6-a4d0-e2d1a0fbeb74
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pINB2rUcyTpDutl4Qsqtdo9yU2OUUJyBGUdsuD7kYgmepnZhj/VEZjuxjda2zaLAP2z2QkDuNIk7K9VedLizhna/hQHY8pMjiDxVr8tNTOLjQkOlkN4vJVHebS2ta6Xn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB3287
X-OriginatorOrg: caissedesdepots.fr
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

RGVhciBIdSwNCg0KDQo+ID4gZ2l0IGJ1Z3JlcG9ydCBvcGVucyBhIHRlbXBsYXRlIGluIHZpbSwg
d2hpY2ggSSBkb24ndCB1c2Ugb24gYSBkYWlseSBiYXNpcy4NCj4gPg0KPg0KPiBBaCwgeW91J3Jl
IHJpZ2h0LiBJIHdhcyBhYmxlIHRvIHJlcHJvZHVjZSB0aGlzIHNtYWxsIGJ1Zy4gSXQncyBjYXVz
ZWQgYnkgZ2l0DQo+IGJ1Z3JlcG9ydCBub3QgcmVhZGluZyB0aGUgY29uZmlnLiBJJ2xsIHN1Ym1p
dCBhIHBhdGNoIHRvIGZpeCBpdCBsYXRlci4NCg0KVGhhbmtzIGEgbG90ICENCg0KQmVzdCByZWdh
cmRzLA0KDQotLQ0KRW1tYW51ZWwgQ29pcmllcg0KDQpJbnRlcm5lDQpDZSBtZXNzYWdlIGV0IHRv
dXRlcyBsZXMgcGnDqGNlcyBqb2ludGVzIChjaS1hcHLDqHMgbGUgwqttZXNzYWdlwrspIHNvbnQg
Y29uZmlkZW50aWVscyBldCDDqXRhYmxpcyDDoCBs4oCZaW50ZW50aW9uIGV4Y2x1c2l2ZSBkZSBz
ZXMgZGVzdGluYXRhaXJlcy4gVG91dGUgdXRpbGlzYXRpb24gZGUgY2UgbWVzc2FnZSBub24gY29u
Zm9ybWUgw6Agc2EgZGVzdGluYXRpb24sIHRvdXRlIGRpZmZ1c2lvbiBvdSB0b3V0ZSBwdWJsaWNh
dGlvbiwgdG90YWxlIG91IHBhcnRpZWxsZSwgZXN0IGludGVyZGl0ZSwgc2F1ZiBhdXRvcmlzYXRp
b24gZXhwcmVzc2UuIFNpIHZvdXMgcmVjZXZleiBjZSBtZXNzYWdlIHBhciBlcnJldXIsIG1lcmNp
IGRlIGxlIGTDqXRydWlyZSBzYW5zIGVuIGNvbnNlcnZlciBkZSBjb3BpZSBldCBk4oCZZW4gYXZl
cnRpciBpbW3DqWRpYXRlbWVudCBs4oCZZXhww6lkaXRldXIuIEludGVybmV0IG5lIHBlcm1ldHRh
bnQgcGFzIGRlIGdhcmFudGlyIGzigJlpbnTDqWdyaXTDqSBkZSBjZSBtZXNzYWdlLCBsYSBDYWlz
c2UgZGVzIETDqXDDtHRzIGV0IENvbnNpZ25hdGlvbnMgZMOpY2xpbmUgdG91dGUgcmVzcG9uc2Fi
aWxpdMOpIGF1IHRpdHJlIGRlIGNlIG1lc3NhZ2Ugc+KAmWlsIGEgw6l0w6kgbW9kaWZpw6ksIGFs
dMOpcsOpLCBkw6lmb3Jtw6kgb3UgZmFsc2lmacOpLiBQYXIgYWlsbGV1cnMgZXQgbWFsZ3LDqSB0
b3V0ZXMgbGVzIHByw6ljYXV0aW9ucyBwcmlzZXMgcG91ciDDqXZpdGVyIGxhIHByw6lzZW5jZSBk
ZSB2aXJ1cyBkYW5zIG5vcyBlbnZvaXMsIG5vdXMgdm91cyByZWNvbW1hbmRvbnMgZGUgcHJlbmRy
ZSwgZGUgdm90cmUgY8O0dMOpLCBsZXMgbWVzdXJlcyBwZXJtZXR0YW50IGQnYXNzdXJlciBsYSBu
b24taW50cm9kdWN0aW9uIGRlIHZpcnVzIGRhbnMgdm90cmUgc3lzdMOobWUgaW5mb3JtYXRpcXVl
LiBUaGlzIGVtYWlsIG1lc3NhZ2UgYW5kIGFueSBhdHRhY2htZW50cyAo4oCcdGhlIGVtYWls4oCd
KSBhcmUgY29uZmlkZW50aWFsIGFuZCBpbnRlbmRlZCBvbmx5IGZvciB0aGUgcmVjaXBpZW50KHMp
IGluZGljYXRlZC4gSWYgeW91IGFyZSBub3QgYW4gaW50ZW5kZWQgcmVjaXBpZW50LCBwbGVhc2Ug
YmUgYWR2aXNlZCB0aGF0IGFueSB1c2UsIGRpc3NlbWluYXRpb24sIGZvcndhcmRpbmcgb3IgY29w
eWluZyBvZiB0aGlzIGVtYWlsIHdoYXRzb2V2ZXIgaXMgcHJvaGliaXRlZCB3aXRob3V0IHByaW9y
IHdyaXR0ZW4gY29uc2VudCBvZiBDYWlzc2UgZGVzIERlcG90cyBldCBDb25zaWduYXRpb25zLiBJ
ZiB5b3UgaGF2ZSByZWNlaXZlZCB0aGlzIGVtYWlsIGluIGVycm9yLCBwbGVhc2UgZGVsZXRlIGl0
IHdpdGhvdXQgc2F2aW5nIGEgY29weSBhbmQgbm90aWZ5IHRoZSBzZW5kZXIgaW1tZWRpYXRlbHku
IEludGVybmV0IGVtYWlscyBhcmUgbm90IG5lY2Vzc2FyaWx5IHNlY3VyZSwgYW5kIENhaXNzZSBk
ZXMgRGVwb3RzIGV0IENvbnNpZ25hdGlvbnMgZGVjbGluZXMgcmVzcG9uc2liaWxpdHkgZm9yIGFu
eSBjaGFuZ2VzIHRoYXQgbWF5IGhhdmUgYmVlbiBtYWRlIHRvIHRoaXMgZW1haWwgYWZ0ZXIgaXQg
d2FzIHNlbnQuIFdoaWxlIHdlIHRha2UgYWxsIHJlYXNvbmFibGUgcHJlY2F1dGlvbnMgdG8gZW5z
dXJlIHRoYXQgdmlydXNlcyBhcmUgbm90IHRyYW5zbWl0dGVkIHZpYSBlbWFpbHMsIHdlIHJlY29t
bWVuZCB0aGF0IHlvdSB0YWtlIHlvdXIgb3duIG1lYXN1cmVzIHRvIHByZXZlbnQgdmlydXNlcyBm
cm9tIGVudGVyaW5nIHlvdXIgY29tcHV0ZXIgc3lzdGVtLg0K
