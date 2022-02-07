Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE3DC433EF
	for <git@archiver.kernel.org>; Mon,  7 Feb 2022 22:29:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244517AbiBGW3x (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 17:29:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235284AbiBGW3x (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Feb 2022 17:29:53 -0500
Received: from mx0e-00379502.gpphosted.com (mx0e-00379502.gpphosted.com [67.231.147.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453A3C061355
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 14:29:52 -0800 (PST)
Received: from pps.filterd (m0218361.ppops.net [127.0.0.1])
        by mx0f-00379502.gpphosted.com (8.16.1.2/8.16.1.2) with SMTP id 217MQPtx030433;
        Mon, 7 Feb 2022 14:29:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=llnl.gov; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=02022021-podllnl;
 bh=SfcRRIvOC+O3xUZwWfq5k0f0Or2i9GLDwjhBaiJYpYo=;
 b=ZWD9cVrpjnuX9tpNTP8txvfcbWWJkMNcA5thiurtH8qd5bPiB+Uu/eQ9+5azQLc1OoWX
 7VmqVDgFXBZ4m+FHnpalePO0THWy46eVHyD1j/DWpr6wILeWL4HHHFstVp2THwl+XE57
 VS6PhKRUxpnwgEGaaLR58lK2crFkqVos07x0nVPKRluRy9ZypG5Iv96TDlka9I/w4YFf
 ndpfuYw78asLP+cbNstMc3GWJ3G3YVTKYssDMwyTBvesNJJSpJJjEBMpSnXZWJVgK+Th
 EZhEUUFXvI2NplC4xOg8Rd4/0Wh+Ri17juLi4/zdMq8GpGMVUV5BoPOFeogkitjHNnQJ dg== 
Received: from gcc02-bl0-obe.outbound.protection.outlook.com (mail-bl2gcc02lp2104.outbound.protection.outlook.com [104.47.64.104])
        by mx0f-00379502.gpphosted.com with ESMTP id 3e3b7f07vv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Feb 2022 14:29:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UCCxLAD7RARa5kUyiBTAFC1g7AmOWh6pMvLPXGCc0rpaH6g90Z65gDdtsgKEfUrB0H+O5IiQfqmy0q5Uvs6DraTqQDYIXUqau7qEsPtu+Az5FRbZSF3sE8qzT36aS7VLerecuBeEoFVS0mVRLgjkKYGuRttNQODWpsalcjscuUw0jg1iKK5XrKIZbjAkUooDJENc5ef7JoaWMbFbhH33TEDkt2hZDQ69umOPW+L0J8IIBCLzZX87R7iNsvYMGjcxKtt0WvJIUckzaJCE2A1o+y69vSppWXD4UUpf+tUAaUYDuoiP7hSUty53ADPIoK1nGo3VRi6J5UiEdwwcwMJvkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SfcRRIvOC+O3xUZwWfq5k0f0Or2i9GLDwjhBaiJYpYo=;
 b=OWAXTECqZO67FRCQDnziCAtYlvGEAiJ7k1SbnEh4HtGC++LPJpltCNcqIy3wD2Y8T7/1Nhv1xj1tvKnr+A8mHlb2S5DCt3oKt2iTKUWjFmNcT306pryNlT0iX/EDzulHI90zqOcA/h4sFzEVCwVA7vy6WHpIZWhplDv6/joXbd8VL2XXnMvt+EzFE/bAhpUUUDhTw+gZoHse4x8qPxhO+5YCKLu7X2q4jUATEs1Ey5yTuk8xhFXkC725sEsjN0vxt/NE+aC1Lmjceb4WTVPK53QT6NBErn8UpGr5Xvc+3l21uFIKM1pBrZkDX8mxmjCNXKLKEyOgDErBNbgfUuHYCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=doellnl.onmicrosoft.com; s=selector1-doellnl-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SfcRRIvOC+O3xUZwWfq5k0f0Or2i9GLDwjhBaiJYpYo=;
 b=NBx9aM5smOt5hwdCcOOqdKg+/MSnEQLF6SY2fc9SaJc1U47Z5Qnn5+KH8dTOt+AXW2rc6h1iJT6WFov/oaAVmB5jcr5DZVQm6mqChs6/fTlqtMTNaQvpIL04oIHAh3nRtMCXTwp8VUyyI7f/Rk4yLAxbn/4MrI3q9Ym6W5h9a2o=
Received: from BY5PR09MB5972.namprd09.prod.outlook.com (2603:10b6:a03:242::12)
 by BY5PR09MB5825.namprd09.prod.outlook.com (2603:10b6:a03:242::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Mon, 7 Feb
 2022 22:29:37 +0000
Received: from BY5PR09MB5972.namprd09.prod.outlook.com
 ([fe80::1152:ffb:b909:9231]) by BY5PR09MB5972.namprd09.prod.outlook.com
 ([fe80::1152:ffb:b909:9231%2]) with mapi id 15.20.4951.019; Mon, 7 Feb 2022
 22:29:37 +0000
From:   "Gamblin, Todd" <gamblin2@llnl.gov>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
CC:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.email>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Commit SHA1 == SHA1 checksum?
Thread-Topic: Commit SHA1 == SHA1 checksum?
Thread-Index: AQHYGi5p7M1/4kXYKkqhLSADSBwD+KyFqvkAgAClySOAAJl4gIAACmf7gAElYQCAAHxxnYAACkGAgAAPT4A=
Date:   Mon, 7 Feb 2022 22:29:37 +0000
Message-ID: <8A241137-C8D6-40A6-ABB8-5624B9E617A9@llnl.gov>
References: <ED97E252-CABA-41BB-B18C-819A5EF305E3@llnl.gov>
 <121ce485-bea8-3168-aa35-d11eb13022da@iee.email> <xmqq1r0gjo6h.fsf@gitster.g>
 <eca83634-ee91-89bd-567e-6b0807b5ff79@iee.email> <xmqqee4fix0l.fsf@gitster.g>
 <20220207133244.kpyczjsxriepjtdt@meerkat.local> <xmqqczjyiecs.fsf@gitster.g>
 <20220207213449.ljqjhdx4f45a3lx5@meerkat.local>
In-Reply-To: <20220207213449.ljqjhdx4f45a3lx5@meerkat.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e8bbf70f-4836-4cc4-b8f7-08d9ea895344
x-ms-traffictypediagnostic: BY5PR09MB5825:EE_
x-microsoft-antispam-prvs: <BY5PR09MB5825AA9EE6F09A1CE3F2A1DCF82C9@BY5PR09MB5825.namprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VzdkutR/vbbOFXZcMtMCOT4EBoNlRey89AkeVAI5dm/VM9+WITWnZsZSkGPKYODJtET/f1tK/ANamKtdOpMqyF9Qi4I6+6El/ywLHD/O4zfvp79lEdNaXpg4DtQQZOdqXBo3iX4pOJT926IFbBj4PkjCYrzA2cVug3ScFbO3CbNcny5T2lNY2Uisd0uJRJq6IG4k8kxkLFXkLSoU0rtZMuNPZRRl/KCgFmdQn+SBP1VEoRmJN0QzFkpjoxyaZTZ2xRr8SBQOQoeH6B0wFdZX4uCWf4/tgL0jaBf9mDb0O4NgspEUPqbq5C77qE1yenxLu/DzJuBz4wzsNceiqp6tMTH5glV0390gGXRo4/wJFJlO9pUiPSo7AvoWydUKVW1aUh3HZhvTnPsfNvMjX7+cBLyHR9vxZWMe1rM/S/QPqUe9xaHrtibReNPvEynl/CwXUxWVgAIRf1TLkM+6QDojQeXqeFNhqr/Op0prGHsfgwjrw5gP1Rk7ozw1q5Edx+HZrNARLhotxM+L87/voF3Dd0yxBWcPCIJsLamLVOQcMgcytPV1vNlfX8VexOVhqZQTRkvUsKdAu1+xjac2HluV33C6+yj835Zg5jaHgFR0jpBi/twpdP5+flWeq+e317Djk3REqffPbAZrkauNRGf6qIMUCYJjUy3IUcfhrihANqXvtDTib4+32v9wv5AiGyK1X32RZ5Y68PPWAPcYD49Ge9Pn5LU9OIkbK7NiLEbGDfs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR09MB5972.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(508600001)(53546011)(6506007)(86362001)(6512007)(122000001)(82960400001)(2906002)(5660300002)(38100700002)(4326008)(8676002)(66446008)(6916009)(66946007)(54906003)(66476007)(8936002)(64756008)(66556008)(33656002)(6486002)(83380400001)(38070700005)(71200400001)(186003)(316002)(76116006)(26005)(2616005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWtFUHNXYVMrY0FVWnhZZFZtL2Q2a3UvVkNUL3NpV29VTUY3bktES2dxV1BC?=
 =?utf-8?B?VCtiMXlhRURUdzcxc0RwWWV3ckdNUkthR0hNbUVzYXk1b1dVTWpFVGRlM01F?=
 =?utf-8?B?YjlSRTlHRDkwd2I0N05KaGI4NmRhMWY4WHpsc3l5UHhMdVJxS2xJYk9OcVg3?=
 =?utf-8?B?QWduaDhlUHdTdENZbncwME56Vis3aVhpL3FGTk5sM280c1gvV3ZyTjBxY2lq?=
 =?utf-8?B?UWNLMGpSUFpvd2ZPZnhZMml4anpLUXFHTGVjeXE1eXRtdFFEbU4zSUIxOFVB?=
 =?utf-8?B?QVNyOUlkWEtCckNud3RRZEl6dWFuclc1TG16ay9tbW1NZCtNTzBsRFM4eXpD?=
 =?utf-8?B?OUpyNlRiVXZhTm10VmNxdzYvZkpsMGc4d0h1OVpVTGRwdDd2KzhlQlpJaXJO?=
 =?utf-8?B?U1BzZ1owK2VtZEpiYnlCRHV6cFJzMjBQNHJITWZVQ2pyV3hIY0JrWlVKZ2JT?=
 =?utf-8?B?WGtVTk11VTJoUTUraUw4eU9sVXEyWS9BMzB1Qk1QZlFUWnlHZmQ1cGNjUlIw?=
 =?utf-8?B?UGdrSUZ1VGYvOUMrOFozcUppQkhLZnUzeUlQZnJ4dmdMSmUwbmlHN0pxa0pv?=
 =?utf-8?B?N3FUTWlnb21QRXlXYUFERG90dlhLRmZBREw5bkFoMDBGUEFxT3lWdWN0cnVV?=
 =?utf-8?B?OE9xOFB1enJxaTdQbk1TNlZQMDUvRSt1Um9nWHphS1gzOEhJZlZHZCtpUWY1?=
 =?utf-8?B?dlZCSUFHZkxHZ1ZWVTJBVm82STY5c3FxS2ZGNjJXMkZGOThHSWhsUlF1bDZt?=
 =?utf-8?B?ZVg3eTBZUldXREdnaUNjRi95QnI2eThDVnRmWmx3UUVsejN6MEViUVVNVFlC?=
 =?utf-8?B?V1ZPR2lndXhkTVpiL1BrcUNmbTRjNCtPbW9RZ3BuOFBQczlMM0FjaEwyVU9x?=
 =?utf-8?B?MHN3cWpndm1NY1lFdW1uUlgrUTdCYVdkb08yT0UrZEs2RjA3NUpEWHBNaDRT?=
 =?utf-8?B?RmZrdm85aVFwVFViUEgrdysySlhNREVGSEd5RlgzaVZKQ3B4YWhIYW1BNXJt?=
 =?utf-8?B?VmJENHlBbWJQaU4wbUk4QkErNjRySzk1Q2tEL0EwM3dLRW9jQUFDR1FpYjgx?=
 =?utf-8?B?S1lSaHpxM1g2dmxTYTBjV1NITGxObjZPajZtU00zVFNNdk9SMmZINm9FVElF?=
 =?utf-8?B?TDdrZ01kOHA4Qk5QdDdXcmcwL2dqTmlwb2lVQjhhQTBkQkQxcDFSRGlJNFdW?=
 =?utf-8?B?NlFMMG5wbHkwcXBoM1h5cVF3aVFPajJQYUpCSkU1QTBqUG16VW9GVW84QVpN?=
 =?utf-8?B?bktpT2s4c3lsQjV1NU1jeUx3eUlOWjM1RHRvenloRFh6RHRIR2VMOGVzbm1Q?=
 =?utf-8?B?S3lZYWxTKzJEdEhabmlPazhML08raG85QUlqUkphZXVmNUMveHZWRG9kYmEw?=
 =?utf-8?B?WTZIT2N2VXB2QmpQZVdHUHA4QzkzVFBQMTZNSmJpTldhNTN5Q3grWm9YUVJp?=
 =?utf-8?B?WGd2OVlUSXlrZm9UakFLcWs2OGFpbzZOQzQxajVwZ2UyN1RFYjJUQ1Z0dTha?=
 =?utf-8?B?VkZjUEpsRVNDWmZtbE04cHZXeFBiSEkzR1JlL3RLbnVLYkRwa244aUh2VDdh?=
 =?utf-8?B?N2dreVNBZTQvTGZ3dUpMOVpHN1hxNzZyQnBxcjZ4QWY2dTYyQUw1c1lWU0VU?=
 =?utf-8?B?eWJNUUk2UnZUQWJyUFRKV2xyK25YampDRm9yV0l4L0VaaXNaYWd0T0JDdDJR?=
 =?utf-8?B?Q0tJQ0Z5bDIrbjl3VlpIU05Ua0dBMVVLdnVFa3RHc0hkRDIrU2tDNVI2TDVr?=
 =?utf-8?Q?6HDmBKY+OGBpKe8dYf/eeIu1OBeoHXtHp4sbSJo?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C3CBD60DA207644C8CFDDEC31B4B0889@namprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: llnl.gov
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR09MB5972.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8bbf70f-4836-4cc4-b8f7-08d9ea895344
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2022 22:29:37.6817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a722dec9-ae4e-4ae3-9d75-fd66e2680a63
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR09MB5825
X-Proofpoint-GUID: yTYH7iWo2O5pAjwJ8w_FgK6QghSz6ZzW
X-Proofpoint-ORIG-GUID: yTYH7iWo2O5pAjwJ8w_FgK6QghSz6ZzW
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.816
 definitions=2022-02-07_07:2022-02-07,2022-02-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=999 phishscore=0 mlxscore=0
 clxscore=1015 adultscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202070125
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiAyLiBwYWNrYWdlcnMgd291bGQgYmUgYWJsZSB0byBwZXJmb3JtIGNyeXB0b2dyYXBoaWMgdmVy
aWZpY2F0aW9uIHdpdGhvdXQNCj4gICBuZWVkaW5nIHRvIHRyYWNrIGFueSBleHRyYSBzb3VyY2Vz
IGxpa2UgY29ycmVzcG9uZGluZyAuc2lnIGZpbGVzOyB0aGV5DQo+ICAgd291bGQganVzdCBuZWVk
IHRvIGFkZCBhIGJ1aWxkLXRpbWUgZGVwZW5kZW5jeSBvbiBnaXQgKHBsdXMgd2hhdGV2ZXIgaXQN
Cj4gICBjYWxscyBmb3IgY3J5cHRvZ3JhcGhpYyB2ZXJpZmljYXRpb24sIHN1Y2ggYXMgZ251cGcg
b3Igb3BlbnNzaCkNCg0KVGhpcyBpcyBhIGNvb2wgaWRlYSwgYnV0IHRhci9nemlwL2V0Yy4gYXJl
IHZ1bG5lcmFibGUgdG8gaW5wdXQgYXR0YWNrcyAob3IgYXQgbGVhc3QgdGhlcmUgaGF2ZSBiZWVu
IENWRXMgaW4gdGhlIHBhc3QpLCBzbyB0aGlzIGRvZXMgbm90IGVsaW1pbmF0ZSB0aGUgbmVlZCB0
byB2ZXJpZnkgYSBkb3dubG9hZGVkIC50YXIgb3IgLnRhci5neiBmaWxlIGluZGVwZW5kZW50bHku
ICBZb3UgY2FuIHZlcmlmeSB0aGUgY29udGVudHMgb2YgdGhlIHRhciwgYnV0IHRvIGRvIHRoYXQg
eW91IGhhdmUgdG8gZXhwYW5kIGl0LCBhbmQgdG8gZG8gdGhhdCB5b3XigJlyZSBzdGlsbCBwYXNz
aW5nIHVudHJ1c3RlZCBpbnB1dCB0byB0YXIuDQoNCkl0IHdvdWxkIGJlIHJlYWxseSBpbnRlcmVz
dGluZyBpZiBpdCB3ZXJlIHBvc3NpYmxlIHRvIGNyZWF0ZSBhbiBpbmNyZW1lbnRhbGx5IHZlcmlm
aWFibGUgZmlsZSBmb3JtYXQgZm9yIHRoaXMg4oCUIGNvbW1pdCBtZXNzYWdlcyBoYXZlIHNpemVz
IGVtYmVkZGVkIHNvIGl0IHNlZW1zIHBvc3NpYmxlIHRvIHN0cmluZyBhIGJ1bmNoIG9mIGNvbW1p
dHMvdHJlZXMvYmxvYnMgdG9nZXRoZXIgaW4gYSBmaWxlIGFuZCB0byBtYWtlIHRoYXQgd29yay4g
IEnigJltIGp1c3Qgbm90IHN1cmUgaWYgdGhlIGZvcm1hdCBjb3VsZCBiZSBjb21wcmVzc2VkIGFu
ZCBhbHNvIHRydXN0ZWQuICAgSSBkb27igJl0IGtub3cgZW5vdWdoIGRldGFpbHMgb2YgZ2l04oCZ
cyBvd24gc3RvcmFnZSB0byBzYXkgd2hldGhlciwgZS5nLiwgcGFjayBmaWxlcyBjb3VsZCBoZWxw
Lg0KDQotVG9kZA0KDQoNCg0KPiBPbiBGZWIgNywgMjAyMiwgYXQgMTozNCBQTSwgS29uc3RhbnRp
biBSeWFiaXRzZXYgPGtvbnN0YW50aW5AbGludXhmb3VuZGF0aW9uLm9yZz4gd3JvdGU6DQo+IA0K
PiBPbiBNb24sIEZlYiAwNywgMjAyMiBhdCAxMjo1Nzo1NVBNIC0wODAwLCBKdW5pbyBDIEhhbWFu
byB3cm90ZToNCj4+IFlvdSBhcmUgc29sdmluZyBhIGRpZmZlcmVudCBwcm9ibGVtOiAiSSBoYXZl
IHRoaXMgdGFyIGFyY2hpdmU7IHdoYXQNCj4+IGdpdCB0cmVlIG9iamVjdCB3b3VsZCBJIGdldCBp
ZiBJIGV4dHJhY3QgdGhpcyBhcmNoaXZlIHRvIGFuIGVtcHR5DQo+PiBkaXJlY3RvcnkgYW5kIHNh
aWQgJ2dpdCBhZGQgLiAmJiBnaXQgd3JpdGUtdHJlZSc/Ii4NCj4+IA0KPj4gSSBhZ3JlZSB0aGF0
IG9uZSBpcyBjb21wdXRhYmxlLg0KPiANCj4gU28sIEkgd2FzIGJyYWluc3Rvcm1pbmcgYWJvdXQg
dGhpcyB0b2RheSwgYW5kIEknbSBjdXJpb3VzIGlmIHlvdSB0aGluayB0aGlzDQo+IHdvdWxkIGJl
IGEgdXNlZnVsIGZlYXR1cmUgdG8gaGF2ZSwgbWF5YmUgZXZlbiBuYXRpdmVseT8NCj4gDQo+IEUu
Zy4gaGVyZSdzIGEgc2NlbmFyaW86DQo+IA0KPiAiZ2l0IGFyY2hpdmUgLVMgPHNpZ25lZC1vYmpl
Y3Q+IiBjcmVhdGVzIGFuIGFkZGl0aW9uYWwgZmlsZSB0aGF0IGlzIGFkZGVkIHRvDQo+IHRoZSBn
ZW5lcmF0ZWQgdGFyL3ppcCBhcmNoaXZlIC0tIGZvciBleGFtcGxlLCBhICR7cHJlZml4fS5HSVRf
QVJDSElWRV9TSUcuIFRoYXQNCj4gZmlsZSBjb250YWlucyB0aGUgcmF3IGNvbnRlbnRzIG9mIHRo
ZSBzaWduZWQgdGFnIGFuZC9vciB0aGUgc2lnbmVkIGNvbW1pdC4NCj4gDQo+ICJnaXQgdmVyaWZ5
LWFyY2hpdmUiIHdvdWxkIGxvb2sgZm9yIGEgdG9wbGV2ZWwgLkdJVF9BUkNISVZFX1NJRyBmaWxl
LiBJZiBpdCdzDQo+IHByZXNlbnQsIGl0IHdvdWxkIHZlcmlmeSB0aGUgc2lnbmF0dXJlIG9uIHRo
ZXNlICJkZXRhY2hlZCIgc2lnbmVkIG9iamVjdHMgdG8NCj4gZ2V0IGEgdHJ1c3RlZCB0cmVlIGhh
c2guIFRoZW4gaXQgd291bGQgY29tcHV0ZSB0aGUgdHJlZSBoYXNoIG9mIHRoZSB0YXINCj4gYXJj
aGl2ZSAobWludXMgdGhlIC5HSVRfQVJDSElWRV9TSUcgZmlsZSkgdG8gc2VlIGlmIGl0IG1hdGNo
ZXMuDQo+IA0KPiBJbiBteSBtaW5kLCB0aGF0IHdvdWxkIHByb3ZpZGUgdGhlIGZvbGxvd2luZyBi
ZW5lZml0cyBvdmVyIHRoZSBjdXJyZW50DQo+IHByYWN0aWNlIG9mIGRldGFjaGVkIC5zaWcgZmls
ZXM6DQo+IA0KPiAxLiBlbnZpcm9ubWVudHMgbGlrZSBnaXRodWIvZ2l0Lmtlcm5lbC5vcmcgd291
bGQgYmUgYWJsZSB0byBjcmVhdGUgdmVyaWZpYWJsZQ0KPiAgIHNuYXBzaG90IGFyY2hpdmVzIHVz
aW5nIGFuIGV4aXN0aW5nIHNldCBvZiBzaWduZWQgb2JqZWN0cw0KPiAyLiBwYWNrYWdlcnMgd291
bGQgYmUgYWJsZSB0byBwZXJmb3JtIGNyeXB0b2dyYXBoaWMgdmVyaWZpY2F0aW9uIHdpdGhvdXQN
Cj4gICBuZWVkaW5nIHRvIHRyYWNrIGFueSBleHRyYSBzb3VyY2VzIGxpa2UgY29ycmVzcG9uZGlu
ZyAuc2lnIGZpbGVzOyB0aGV5DQo+ICAgd291bGQganVzdCBuZWVkIHRvIGFkZCBhIGJ1aWxkLXRp
bWUgZGVwZW5kZW5jeSBvbiBnaXQgKHBsdXMgd2hhdGV2ZXIgaXQNCj4gICBjYWxscyBmb3IgY3J5
cHRvZ3JhcGhpYyB2ZXJpZmljYXRpb24sIHN1Y2ggYXMgZ251cGcgb3Igb3BlbnNzaCkNCj4gMy4g
dGhpcyB3b3VsZCBhdXRvbWF0aWNhbGx5IHN1cHBvcnQgYWxsIGdpdC1uYXRpdmUgc2lnbmF0dXJl
IG1lY2hhbmlzbXMgbGlrZQ0KPiAgIG9wZW5zc2ggYW5kIHdoYXRldmVyIGVsc2UgZ2V0cyBhZGRl
ZCBpbiB0aGUgZnV0dXJlDQo+IA0KPiBEb2VzIHRoaXMgaWRlYSBoYXZlIGFueSBtZXJpdCwgb3Ig
aXMgaXQgdG9vIGZyYWdpbGUvY3JhenkgdG8gYm90aGVyPw0KPiANCj4+IE9mIGNvdXJzZSwgZXZl
biB0aGF0IHJldmVyc2UgcHJvYmxlbSB3aWxsIGJyZWFrIG9uY2Ugd2UgY29uc2lkZXIgdGhlDQo+
PiByZWxlYXNlIHRhcmJhbGwgZ2VuZXJhdGlvbiBwcm9jZWR1cmUgd2hlcmUgd2UgX2FkZF8gc29t
ZSBnZW5lcmF0ZWQNCj4+IGZpbGVzIHRoYXQgYXJlIG5vdCBpbiB0aGUgR2l0IHRyZWUsIGZvciBi
dWlsZGVyJ3MgY29udmVuaWVuY2UuDQo+IA0KPiBZZXMsIGJ1dCBpdCdzIGluY3JlYXNpbmdseSBy
YXJlIGFuZCBtYW55IGJ1aWxkIGluc3RydWN0aW9ucyBub3cgc3BlY2lmaWNhbGx5DQo+IGFsbG93
IGZvciB0aGluZ3MgbGlrZSAiZmlyc3QsIHJ1biBhdXRvY29uZiBpZiB5b3UgZG9uJ3QgYWxyZWFk
eSBoYXZlIGENCj4gY29uZmlndXJlIGZpbGUiLCBldGMuDQo+IA0KPiAtSw0KDQo=
