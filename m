Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5B6C433EF
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 20:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378224AbiFPUGb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 16:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbiFPUG3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 16:06:29 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-centralusazon11021024.outbound.protection.outlook.com [52.101.62.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371B45A59C
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 13:06:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lCjaPiNH27ncZBVhFvxRBKTTypKPuSDheGXzBni8xA+1k1vBoDH6pXf8XDFzJR82dckn4vFSyfHIpsrs6xoxgg+ov5h46XRLzKM5q3ypRSyQQIP5WMKT4hAGryUv+oZWd3BY4UCjCXlmTfwZvQNFBtmKehX6k8Qw0rTtf9rhi1zHbzOto7JMD3E2KTRFDLe5BL3KCPKlpxsITQ/R/KahccuPVaWhxl/y3QbOd9u8Q8J8Gvh6kBtYbQtOWNRetHrS5cRHkzsQE/Hxpci4RddETbCtDJUsWjx0NUa0XrwDRl+HMHlUkqBtZKYhD68emrPedsyj6pa3bnp/WBSWO/0VXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TCsAp6xmHvX4SIiwyjaT3gPxsuET4Txhjw/yEjypRyw=;
 b=OadXh23kp2hQTE1m01423XqVcbcJajzu8QTCNhyqNFalg4yrAuDvK+PlOxuqYAZQ+bhwPa5G9GqnnV6B2Ys71aQSzNQ9/3YpSZvRgNMBckF0DG943HoBKH5DMD7g9obVxJeVTbHWxBB1aEglrV2a/lmJQIkskF+3BEgfAWXFpiZ5ERkwzEAy9/mCGiaQtgsyw5FCQfHUaHtVA8/u7TL1kIvvpzR6iNa4bVt/yksf6a75LdvA7xTfS8v1MIo4nhOQmQE1QtwZx05n3zuMP8TD3OvQDWQil1cfGN/F81PpEr8rKxFMc+x7UR0bLBJmCjEb6h2n0mNDRT/Qd+U/pSyADw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TCsAp6xmHvX4SIiwyjaT3gPxsuET4Txhjw/yEjypRyw=;
 b=iaE69TJJjC4Xa8W07B6kOasQpXtzlgJEpAui8SJsljr7Vjk9zMv+dsZm/v8SXoQC/yfd3cfZLIJ64zRfv/zluyfmn5yy4j2/6f50n0O0dIkmkmdQiqyNlKU8lVikT/VCugvWGeQ5TZEveEYCY0IBqjXbnB6x5QpVGLo56iomlDI=
Received: from DM5PR21MB1542.namprd21.prod.outlook.com (2603:10b6:4:81::34) by
 SJ1PR21MB3482.namprd21.prod.outlook.com (2603:10b6:a03:452::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.9; Thu, 16 Jun
 2022 19:51:44 +0000
Received: from DM5PR21MB1542.namprd21.prod.outlook.com
 ([fe80::871:4954:a2d0:f555]) by DM5PR21MB1542.namprd21.prod.outlook.com
 ([fe80::871:4954:a2d0:f555%7]) with mapi id 15.20.5373.009; Thu, 16 Jun 2022
 19:51:44 +0000
From:   "Neeraj Singh (WINDOWS-SFS)" <neerajsi@microsoft.com>
To:     Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [PATCH] perf-lib: fix missing test titles in output
Thread-Topic: [PATCH] perf-lib: fix missing test titles in output
Thread-Index: AQHYgYGBOyv9IKstykm78u8JEFYHFa1Scbpg
Date:   Thu, 16 Jun 2022 19:51:44 +0000
Message-ID: <DM5PR21MB154239CE797E7D50D0435213CCAC9@DM5PR21MB1542.namprd21.prod.outlook.com>
References: <YqrXLO5oMYeOr2PB@coredump.intra.peff.net>
 <6671fd2c-ffcb-6278-494f-2d3cfe4c36d1@github.com>
In-Reply-To: <6671fd2c-ffcb-6278-494f-2d3cfe4c36d1@github.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9d182cd1-2fad-444a-9f45-adeccf39b2e6;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-06-16T19:50:45Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 26ea547c-7fc8-421e-bb6b-08da4fd1a40e
x-ms-traffictypediagnostic: SJ1PR21MB3482:EE_
x-microsoft-antispam-prvs: <SJ1PR21MB34829F4E6A19803ACF7F9C24CCAC9@SJ1PR21MB3482.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /6QvY5jgUJtCSF5mrxJMlWySVfqHerD4cNwV90mPLAYQuiGG+am7O4wdOf7mQItrqtlTElI+bz2SRh++SRQBreuZ27zMmFCf0OqhTGoyI/EX/9NCtLFUOGZa4u0nVxJwhbv8uLf99P/WWLhQl13uIk7soZoqNbRH1SHoUf4KQ9HUH3vwYjCWspgZtesftny9Frbbu3X8WKwLIHRcRt+ZwVaOBfGnaNI7yvDUnim64fPoV/3GPrR6QjOKgcUTOTb3SioubesjVEx19fc7YTX7wnh7fcjCOnQmlxBq3mv30aHooWDqou4IPKcjLRU5ST8LJNTemN2abm7Ahfhoc2nyiy7p+rX7VJOkFKjdtplWzArNXHX4ZwPc9fwT4M2TklTf2Zrg/ARU/9xTEWUXQgIggRUnLNZH90jm8zuz8Ml+cKoFGKSvp2VITHUNdBebek6408hIUbPeSJPS9GR/KVwLuuxoy9hUg0Gh9u9gI4q4ulgB3ecXUKyM70LuMjFyJkUeAerHzlx0UnUTeQRHmVdNPZ1RCnMJDywEKiB+0YwQKr956/H0rEC7TdjtVXhNsMUSOkZONwrHayJtvYWUVB7TfbCnymUOSppShsnLtrxJsgm9rKfYVZ1jSgFYKMkr9WpZP+m6Rm8vdtO0GZmTrbjycOaVJ4mi0hNYW48tWnTydxZ0eLrnNe9Qt2vzS0dc3pv/WtljaWCvzmOcRh0npU0Azuv+CoUSv6V13VMjMFAWrikA4kguOUFxZmKQjljX32Xr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR21MB1542.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(451199009)(9686003)(122000001)(33656002)(82960400001)(8676002)(8990500004)(8936002)(66446008)(76116006)(558084003)(66476007)(52536014)(38100700002)(4270600006)(66946007)(2906002)(64756008)(5660300002)(38070700005)(66556008)(82950400001)(186003)(86362001)(10290500003)(7696005)(6506007)(71200400001)(55016003)(498600001)(110136005)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QXpvV3B1bFN1UzZ0R0ZuVkZhbVU2YnY3UlEybjBoOERPSnR5YW9mMkZLN0Ew?=
 =?utf-8?B?elBZSFRnZGpLY1NyWDkyM1lPdW0veFlackdaVjNNdGYvNzk2WGFvT0RZZlI2?=
 =?utf-8?B?NndyOFBacUs5OEtmclZyNzYzMDR6SDdHVVNmSWlub2kvRTBXYnY1SDRYVm1s?=
 =?utf-8?B?RWEzMFhmREl1NG0rcXNOZW1BMlFpYjVSNU9DZkxMR2tYMjVmWjRQSnduM2p1?=
 =?utf-8?B?eW51UzNNM1B6UDFWS1JJb0IyVXRVRHpudEJicXNvYmsrbUpoWXA2eDJESUNR?=
 =?utf-8?B?RVR5VDlkVGJGYm9MS0J0WEN6LzZZaGFXWEhSQ2JLZXlhQnU3M3NhZGR4RWNH?=
 =?utf-8?B?a2pEakk5Y2pBZGdjRjlLM1RGVmNVb2E1b2gyaStsVWJ0YlVOZ2MrQzBwWHZ1?=
 =?utf-8?B?VEFyVnFkNnRRZVB1RUNSbVhhK2g0V2JBYmo4V0xrYVVCeUo5NEgzV0FSRnhj?=
 =?utf-8?B?WElXekw1V1BJMms5SGdQUWhqVHdMOGd0TUdrUjJnZUJpWUJxMkpwNXp2eVVu?=
 =?utf-8?B?dk05SHdvK085OXAwU01kQk55Z3hqZHJ0b09TRndnaVBnTmtoNnhVZDVzTXBR?=
 =?utf-8?B?biswekZwcTFKbGhvYTE1WVIyMlZneFZEQTZ6NXJCUXNxUVZLZWIwUklDTERy?=
 =?utf-8?B?ekRsdUx0ZmJ2SUUrZ1drbnVuWnozK0pnQmJlb0VuZDExVUhvYi9QcUVzazVp?=
 =?utf-8?B?eTZZQi9nQzU5NFB4Q3R4Sm9wdEM4M29NbVM1b1hYYk03cXpnM3g5VHQ0U1lu?=
 =?utf-8?B?bCt6WkF5dEZsUHk1RXJqdE5yS0hSeUlvMFdRRklzbUlrdWZFMVo2SDUvTURV?=
 =?utf-8?B?VnFwZWdDZEcvME5RL0ZPQWd5OUlaL2d3UWRGaE83SGRUM2dVeCt0KzcrV2xL?=
 =?utf-8?B?ZUpuK0xLZTYzdnVoMFEzZ21NSHNLNE9Md0tIVkhyZWRtSUVqaHM2YW5uSlhQ?=
 =?utf-8?B?dSs2VG5RQ0NoclpUK3IzZ1JkUXhTTHF6UWtqbjFUM0tiWkRFZFNBUHk3ZzN4?=
 =?utf-8?B?QUt1TVptcit5aXlCeE5FR1NnRTNIM3JLTFJWTlpMa2IxZkswTHVuZDlhcFJu?=
 =?utf-8?B?TVNvRytNWkpvOGtzdlozWUJhV01GenhCMDRITWt6K28vaHdzaUVFc0xHYXlK?=
 =?utf-8?B?cEUwclF4ZzJBWjFvdy9KR01TeVFhS0pRY3dxdThPdXZaWEY2Z0dSRzl5Z2ti?=
 =?utf-8?B?bWhiQUVtTTVHWnpsemtuaC9JN090ejRDV0ZOZFlIT1YxSi9mOFVVbjI3MlY0?=
 =?utf-8?B?bENVbENYV0hzVDIvT08vQUtYMXZrb000cTdnaERBRWVLWU9YdzVLeTN4cGhW?=
 =?utf-8?B?WnVZcnc0eUVSdEc5b1NIV2lFTmdCS2c4bCtOcStCZlpQS2IzZDd6dW1GK29n?=
 =?utf-8?B?WmplZ1I4WEc0K2hMTVhXSzRJOFVwaXJ5UkhlMVN2elVHOEpOd2lTdTU2cjdp?=
 =?utf-8?B?cnRJSFZJekV0K21nUGZyc2lWRXFCN3RqMUNvOWloL0k1RW9RV1R2bXlmQmNi?=
 =?utf-8?B?YjcyNnNYT0dLUnNEU3JIRTQwUFdhZkpjRWpGcEV4bVQ5NnVFc09PZFg5eThM?=
 =?utf-8?B?OWtFV3RUNHR2MGdoRkhtbDIxb2J1VzJjeDNZU1hCL0FLbStwbk5lbzlwYW4v?=
 =?utf-8?B?WG1uZktTMzNqanhyRDU3Z2hoTnlCQUxiWkt4TU1GYjV6ZFFiMXV5bWpjYjU4?=
 =?utf-8?B?bjJZbi9uZDJxbFFZRTZjWTVTVXdiYVBQSGdzYW5yWWRXNnJXRzBUMkl5a3Vt?=
 =?utf-8?B?dUFTeWZ4dXVQUEpqS3ZyM1o0Z0Y3MVZjbDl4YUQvZkJIOVRYMlNCQkppdHpN?=
 =?utf-8?B?VlA5bkgzNjFBN1YzY0loVzdYR0RCNzVVNW1qSVVKc3JNMmREYUN3MzdFdE1j?=
 =?utf-8?B?bzF1elZJQ0FiUFZRZ0ZGSGpoZ2tKOHBURnhEL1V4bS9DZEJJTC8vc3gxZ2hs?=
 =?utf-8?B?cUZzRVRnQzQvc2FWTTFCbFNIa28raVZmWU4vdFNhL1gyRkthSkxsRGNxWmJH?=
 =?utf-8?B?c3p5UzVyVnFwN3pHR1RVVHFDYkUvZXBUMVNCMFBXQzRTTDdPTFNoRzY3ckt0?=
 =?utf-8?B?U1VCNlZTZ1lLKy9iRVFYbVpja29hZndGYzlHa3UrYk1yS3FoV0k2VnFuenlH?=
 =?utf-8?B?OG1neWJjTXpqTlFrbjg5eTlNTkNkbXVVRE5DMlo5bGtDNG15Njk4bU96b0RN?=
 =?utf-8?B?YUFUazJpZlJGMUdCS3ZrZ0hudG1XRWlnTFB6VWN1SjZMdzhLMk8waHZyUGV3?=
 =?utf-8?B?STQ5aHpwSGhVYTZSOWJCaXNjM0g4QmhZWDRNdHM2a3hySDlLekE5N2NsQXdz?=
 =?utf-8?B?cmpXRmJIN2pneXJjRjBydjVlUG5CSHpBeXJ1TUYwOHlqQncwZ1hiNGdHWnM5?=
 =?utf-8?Q?XZa+JXUtHlgqEHF8n9BCjTjvZOmXyS4oCbOwxVy/yyMCB?=
x-ms-exchange-antispam-messagedata-1: ScBH0O8gykzXmqzW7J3S3mBlqdYCVmXv3SU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR21MB1542.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26ea547c-7fc8-421e-bb6b-08da4fd1a40e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2022 19:51:44.4909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F2IZikZ6b6ppyb5+LU4ZGDMqgIOoo1W/XsvrZM1+OIGKOxm708QoIuYxKhvrFMBv++U1baOaOhxbmIwKA1DHydOCq88R2oi1KoPfh1oDvE4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR21MB3482
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

QXBvbG9naWVzIGZvciB0aGUgYnJlYWthZ2UgYW5kIHRoYW5rcyBmb3IgdGhlIGZpeC4NCkl0IGxv
b2tzIGdvb2QgdG8gbWUhDQoNCi1OZWVyYWoNCg==
