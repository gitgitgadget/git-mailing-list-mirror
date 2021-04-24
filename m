Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F26C433ED
	for <git@archiver.kernel.org>; Sat, 24 Apr 2021 03:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CEDE60FE3
	for <git@archiver.kernel.org>; Sat, 24 Apr 2021 03:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbhDXCxD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 22:53:03 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:15262 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232155AbhDXCxB (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 23 Apr 2021 22:53:01 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13O2lpqU002994
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 19:52:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : content-type : content-id : content-transfer-encoding
 : mime-version; s=facebook;
 bh=mE7EZC+E1CAnWMLqjW5xHpr1D4AlxFd93Ju7nLk5k/s=;
 b=TnznzuIvfTlUZrnXlXYuP4Ilkhiqq0IRm+wvYKLnZCb4h7nPMbYUuUvycQ/5m0/zOFWJ
 ckq66ASbZvU1/P06rXbD+FDZZuefXwE4aw32csk/+TR8TaMa0RT4P6awZTQ6enuC2yj8
 vzu9JA3qTNtW449TVIEAzJg4UsljnpfssMw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3845w5hb5h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 19:52:23 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 23 Apr 2021 19:52:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XNiqQZbEsuD6Ssk+P+XvW5q9IRvanbF8zi+WQXNKLKgdXHpQR9OQlXdovnmEfZmf7G/CBsZgqT9rEJKnG4DUXa8ONVdnKsMNTgtjEply7rOIzG2TyAoR7HhDHMhsZFTzkj6n39W8CI56Wdg05tRYOHVnQfPHMoLqJlnllod4ZsnYL9prx9L5OLFr/CTobJRlr5NOzhAvpLNtgDhnE85RNJ4ufVgUgNvlpOhe5aPGnw0NESQ9NIUnQ4j/lmwBtSOzq57n6xCOwSJYGaj941nwlmgCZ7j2njJxW4rnrjPT/qElyyw1RIjYmREYz5kO7O7/Ton0mcZMRLGZGph3zqIHHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mE7EZC+E1CAnWMLqjW5xHpr1D4AlxFd93Ju7nLk5k/s=;
 b=Jhdy6mWzsZmvrktTJJ8q5KwTK2yF9vQz5+9yMS9v9f7c4Yh3TM31v4AFbKTZvA5pcVlX3v39SR2vs/Zi8zmPkTuZVNoAQGORCGQxBwQckVfAv1vNdn5f656NWC9mMWwiQ7cevdLlNak3c0XDwgi/eggWkU2DwRf1prio3hNk+KZ+xNIMB+x9V5ZErgHdzSZp8Rf3SxA84eYF+aS13U0zZd9N5i9vLyM/0DKsiPd/heYp3CaK0t36XNJU0sy0vGQWFvDg4UFPr3UpLLE2ATT/ak292ZrGONZ1jxqzvkfhOKz1XzxK+E7pcEyfW3Ov8XTPvGdXzXyRjEHGUb0Py65yhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3697.namprd15.prod.outlook.com (2603:10b6:a03:1b3::32)
 by SJ0PR15MB4439.namprd15.prod.outlook.com (2603:10b6:a03:374::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Sat, 24 Apr
 2021 02:52:21 +0000
Received: from BY5PR15MB3697.namprd15.prod.outlook.com
 ([fe80::60ca:e5a2:a17b:70e7]) by BY5PR15MB3697.namprd15.prod.outlook.com
 ([fe80::60ca:e5a2:a17b:70e7%5]) with mapi id 15.20.4065.025; Sat, 24 Apr 2021
 02:52:21 +0000
From:   Shoaib Meenai <smeenai@fb.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [BUG] ** glob pattern in git diff doesn't match root directory
Thread-Topic: [BUG] ** glob pattern in git diff doesn't match root directory
Thread-Index: AQHXOLTY90qVDB3WrkWA7U/v+Lwk5A==
Date:   Sat, 24 Apr 2021 02:52:21 +0000
Message-ID: <79834D18-EAF4-4748-9B96-38AAA0760499@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:897]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ffef2a26-8f3f-4273-f6e9-08d906cbfb48
x-ms-traffictypediagnostic: SJ0PR15MB4439:
x-microsoft-antispam-prvs: <SJ0PR15MB443977EBE871819FEBC414CAC9449@SJ0PR15MB4439.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rENJrrHSuh9YsISS1fabty6BlDgewUpLVN4gyfTt6DsvZ/zPUqTCxpXG8CQTD2C7nOgoLQ3U6UbkQQ4GIxDuOk6sb/WVkUWjxUPZmRfmO0h1uKHccvrJTm5eOm3U7h1qy9yQ9KZ7iUa9TyJVuPLFE1gWY9R6eVvdxO3HuDXvRo9dA1Qh0nqJN4w3/UlPg9ia77242ojQKNpP8e2fyqqS+COSiwmnjD2BaSoo/3M9BH0G5d9rJXwpWkUJcAcVovofb3oY8CmKKN6hstYymSaQJW6wHP8J6rtVaE9G2tEDKMJvX6lPVyrtnEcmgw150qluUoIto/XgYkovMIo1A0o1VUaArrjAoEBegWJioEM5rdIhMt09QTiLB4PnNaUloiaSz1mVGCBfeT9251DlPazcFHnZmW1S+5o+WVZdlvuvi1BdHKLrkB3zhYK6rfxvIeGM/KkOcb9L0Uo6gxHGTFjnVrPFVV/rOR5uhvYGahOmnhgjDd6LszsvNGKFoZQdHLr3nFjRPQZJHCihD0MJJdNrtMOvGLs8/DWy0k7dnI8ySVfbwJ/YZ9Cw8DocATjnzmQ3aZEPIxIy+zIUGv+chGE8C73VREnlnjWHiLTI/HxprIMb6TaEPM7XbF4kSDA6WvVNB+N1r984icJN58L3XZVenYzAvPJp6HDdwfDV/EoO86w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3697.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(38100700002)(122000001)(2616005)(186003)(2906002)(36756003)(8676002)(8936002)(316002)(6916009)(6512007)(66946007)(91956017)(478600001)(86362001)(6486002)(5660300002)(71200400001)(76116006)(64756008)(66556008)(33656002)(6506007)(66476007)(66446008)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?QXRJTnFtSlFvL04rZkdWc0pIOEMybHVEOFZXZ2NDbHFCNmgzL3VJbDFrSUdH?=
 =?utf-8?B?Vm85dUZJSGxMNWEvYnd3YWdZRUNSSUlHTUFGdXNMNTU3Um4rTDJVSFdVTlEw?=
 =?utf-8?B?d281dGVkNmVSbksxdXpxME92ZDhRVmZWQkpkdDR0bUcrc2xDWE1zVyt0NThX?=
 =?utf-8?B?OEZRd3NUQkRHNXd3K0lVb1VyQlkrWE5TdDNpYVVESUxRbmMzNjdpUEJpNFRh?=
 =?utf-8?B?OXBuZFROYTlHRjlzc1FTTzZ1b1VRVHFvcHdRZEg0OVhhMCtPSVVoNmlvQito?=
 =?utf-8?B?OGh4RlhNN1VwU0E0V2g5MkVKNnNhN1Q2SlFXb2UvaWFrQnZna0RndE5VaUZJ?=
 =?utf-8?B?VnhEZURNU2YxNnV5NENtOGVrK0c2K1ZMQlpxemtSZk0vcTA4Ry9KbkM0SHZZ?=
 =?utf-8?B?NlE3NlZoUFIrWmRuMm1NNFRHYnUxU0xTRU10N3laUlE4QzRiQzNLZFhwUHVB?=
 =?utf-8?B?WHg4aitpNnFLbjVDc1h6ZkVMclZlL0kwZVVlRDI1ZlE4NEh1Y1YxMEgwOEF0?=
 =?utf-8?B?aTlGdklrSUtVYnFibzg1SHl4RGtHYjlTWWkrQnpNc1VtcjFXeHA4QU1FT2tG?=
 =?utf-8?B?R1YvbXFJSnoxNzNpK1hkdXZIaE5Oa3dxVVhPOGxpSllBekJxby95NzdmMzg0?=
 =?utf-8?B?T2tiaS9oT1lHTU9xcGdrWnR4WE9jOC94N1dEbjNkV3kzWXNuMEk5ZytwR24x?=
 =?utf-8?B?NXBTTzZyUFlTTGlGeElCd25LMUFjWktIb3RBQitWOWZTNENETGtjNThLMmhy?=
 =?utf-8?B?aDF3eUdmOFA0aW9jd29waW1ldm9JeE5DVDFLMWhvTjhlTFFJTVFXcVd4WU5y?=
 =?utf-8?B?UGxxeDluZUNqWUN1NlFObWdNaE1pL0ZTazlYcXBQcEIxVjNYdXhzMWNML3dh?=
 =?utf-8?B?VDJoTHlQZ0dpdndGRFpWcGpvUzZ6WjRGTElFeFZiaHZGMWRHbHNhZkJnRjAv?=
 =?utf-8?B?SjZva3FmcGFpaTFZbXRLN2JBMVZRcFc3NW03eHR0QnYrWWZTVzIzSU1TOW5J?=
 =?utf-8?B?UnF1SmpsZndkYTUrWG40M09mVzVEUW4rSFdRbnBSN09HQkJmMFBGVUVTYm1N?=
 =?utf-8?B?VUtlUk0yL1FyalRlZk1ia084ZUVReVBDUCtQZjRiTGdJb0IydGNtc09OTnEr?=
 =?utf-8?B?S2dKOUlzZE1GWGsxQ0d3NHNjOEsyNlYrTHNHOW4vSGEwbWNBTU44RkFDMFBF?=
 =?utf-8?B?SnZ1N1ZNYzBTazlPcklWVk1XbHhnaGZHNTRibVQyM1JqRkNkT3plNzNVQW1j?=
 =?utf-8?B?aXB0MU9JRENNYmsvc01LU2M3d2RTZ0FYT0t2ZDFmb2tjVm1WbS9tNjMzTmhE?=
 =?utf-8?B?d2w0TjdPVDcwQUdHWXo3ZUJ0UlBlMktPQm84TWxQWHBiWFhMc0pQVHBDVjJD?=
 =?utf-8?B?QXNhcFdjeTJsa052YjdMRTVVRnl0ZlZnR28xbzlqcVN2Zk4zSDV6cHBDWHRr?=
 =?utf-8?B?YmFHb1RPUTFvNkNSYkpoWWxqNGw3RzVDQSt6VndURUZDTTh4YWlBa3VwRFBl?=
 =?utf-8?B?dHJ6TXN4aEgxS29WWk95UTJsZVdPSUd5allVQVNBczhUOVNKTGVaUjlKdXRw?=
 =?utf-8?B?VDg3NHpIeHVBdEtPMFFDdmFWbG53OXlQUkRnaUtpRkg3NHZlTFJ2TlE5cW5q?=
 =?utf-8?B?dGRCZURZc1ZmN21kdklYYkdYVXpLZkhVL1R6d1ZYdzY1bFFWZEFuc2NmWjVK?=
 =?utf-8?B?YzlTRE5pM01mdVRENm1hZmRZUVBMTEh0WVV4NDJRM2dCblI3ZWp6M0c1THVL?=
 =?utf-8?B?Qld0OVV4b0dtVHhBRDFVcXhscDdkcWJHWDh6OUpXQVJQVjR5eWFnOTdjOFVC?=
 =?utf-8?Q?JspJ99bJz822bGOM4fw5RqVQ07mir7heYXV9A=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D72BD92DC42ADA41A822F8094447BEC0@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3697.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffef2a26-8f3f-4273-f6e9-08d906cbfb48
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2021 02:52:21.2137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5IjJIC+y8zvWhlL2igp3zg5cUPSBuoK/3Phx9MUV2VUn3ChQ7RIWvrEete3b35WK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4439
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: YZzBz1JRE8ivW05w5S24WpXlgxcLJ1_9
X-Proofpoint-GUID: YZzBz1JRE8ivW05w5S24WpXlgxcLJ1_9
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-23_14:2021-04-23,2021-04-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 adultscore=0
 phishscore=0 impostorscore=0 clxscore=1011 priorityscore=1501
 suspectscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2104240017
X-FB-Internal: deliver
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGkgYWxsLA0KDQpXaGVuIEkgdXNlIGEgYCoqL2AgZ2xvYiBwYXR0ZXJuIHdpdGggYGdpdCBkaWZm
YCwgaXQgZG9lc24ndCBzZWVtIHRvDQptYXRjaCBpbiB0aGUgcm9vdCBkaXJlY3RvcnkuIFRoZSBk
b2N1bWVudGF0aW9uIGZvciBnaXRnbm9yZSBzYXlzIHRoYXQgYQ0KbGVhZGluZyBgKiovYCBzaG91
bGQgbWF0Y2ggaW4gYWxsIGRpcmVjdG9yaWVzLCBhbmQgSSB3b3VsZCBleHBlY3QgaXQgdG8NCmJl
aGF2ZSB0aGUgc2FtZSB3YXkgZm9yIGBnaXQgZGlmZmAuIEZvciBleGFtcGxlOg0KDQokIGdpdCAt
LXZlcnNpb24NCmdpdCB2ZXJzaW9uIDIuMzEuMS41MjcuZzQ3ZTZmMTY5MDEgIyBidWlsdCBmcm9t
IHRoZSBgbmV4dGAgYnJhbmNoDQokIG1rZGlyIC90bXAvZ2xvYnRlc3QgJiYgY2QgL3RtcC9nbG9i
dGVzdA0KJCBnaXQgaW5pdA0KJCBlY2hvIGZvbyA+IGZvbw0KJCBta2RpciBzdWINCiQgZWNobyBz
dWJmb28gPiBzdWIvZm9vDQokIGdpdCBhZGQgLg0KJCBnaXQgY29tbWl0IC1tICdJbml0aWFsIGNv
bW1pdCcNCiQgZWNobyBiYXIgPiBmb28NCiQgZWNobyBzdWJiYXIgPiBzdWIvZm9vDQokIGdpdCAt
LW5vLXBhZ2VyIGRpZmYgJyoqL2ZvbycNCmRpZmYgLS1naXQgYS9zdWIvZm9vIGIvc3ViL2Zvbw0K
aW5kZXggZWY3ODg5Zi4uMmIyYWI2YyAxMDA2NDQNCi0tLSBhL3N1Yi9mb28NCisrKyBiL3N1Yi9m
b28NCkBAIC0xICsxIEBADQotc3ViZm9vDQorc3ViYmFyDQoNCk9ubHkgdGhlIGRpZmYgdG8gYHN1
Yi9mb29gIGlzIHByaW50ZWQsIHdoZXJlYXMgSSdkIGV4cGVjdCB0aGUgY2hhbmdlIHRvDQp0aGUg
dG9wLWxldmVsIGBmb29gIHRvIGJlIHByaW50ZWQgYXMgd2VsbC4gYGdpdCBkaWZmICcqKmZvbydg
IGRvZXMgYmVoYXZlDQphcyBJIHdvdWxkIGV4cGVjdC4gVGhpcyBhbHNvIGhhcHBlbnMgd2l0aCBh
IGAqKmAgaW4gdGhlIG1pZGRsZSBvZiBhDQpwYXR0ZXJuOyBlLmcuLCBgc3ViLyoqL2JhcmAgd2ls
bCBtYXRjaCBgc3ViL2Rpci9iYXJgIGJ1dCBub3QgYHN1Yi9iYXJgLg0KDQpBbSBJIG1pc3VuZGVy
c3RhbmRpbmcgaG93IGAqKmAgc2hvdWxkIHdvcmssIG9yIGlzIHRoaXMgYSBidWc/DQoNClRoYW5r
cywNClNob2FpYg0KDQo=
