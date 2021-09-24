Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610FBC433F5
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 17:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AFB76105A
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 17:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343662AbhIXRgX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 13:36:23 -0400
Received: from mx0b-00209e01.pphosted.com ([148.163.152.55]:25538 "EHLO
        mx0b-00209e01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241904AbhIXRgG (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 24 Sep 2021 13:36:06 -0400
Received: from pps.filterd (m0094032.ppops.net [127.0.0.1])
        by mx0b-00209e01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18O9kb7l005889;
        Fri, 24 Sep 2021 13:34:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ncr.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pod1119;
 bh=e4w3rGLO2lV05NKArpiBn8NIgkk1tgCR5Ha4xfvbNZk=;
 b=VE87sw5Xaj2w9EzaPQFzOOlDLzUzqbZgMvPFzMSYTbQjRpTCCTQ5C+iq6Q/uTqxlTdWb
 ClHCkPIyht4D8e+f5/8EzxbAZx+zyedwDGOo8Vm/wtpI67JR4dqpTtyKF4tLSWsoMFgg
 83MLnHSMX6Pt+MyJPBUjEA0eO8Z1DsQbjrmnFXS7FsyWoX6atkavshNlEJl65vZj/eRl
 myqU6aqmFFDn2x+br7TzpYFd7h35X5sq1DMacUhYEV0fTHTZDRrm2VoKu/C2ziMFFVOb
 KIuLzWhMaEEGNmT67Us/zjEGzIanfWvQ7sShsk12JqQ39q4c7jFGQY4gqhNDFZt2Upz2 6w== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by mx0b-00209e01.pphosted.com with ESMTP id 3b93f2nb9n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Sep 2021 13:34:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RtPRikhTahYOtNKKmURpjD4cIczEc5XJah2ihicuca1bjgY4iPQVf7mt4mbn5q9++H7if1kdpro0YsERXzHCn/235Lo4UEQO5recq0EpZY93AP918Aprp/1VmWaTN/9+VOOsl6me8xMIrNjJ1+P5bV6jdDIodfRRa5OL27mWUIENKDWIkrPaoW3RwWpJZ4sztcevjECPLEHGAhygB/V+bVSAGN5nDb7C4zFdLkHcBg8srTvrC2KAiqr+CiSuYAcz6X2JO/NDsspH28p65CsSREp5pG7fpmGvyEZLe+vbR/epMRtNlhHgbasjMHVjDlSNbWNNgtQswtlYgOAbsgdSUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=e4w3rGLO2lV05NKArpiBn8NIgkk1tgCR5Ha4xfvbNZk=;
 b=T8nRJJF+sW1dGNUTWWUV9dMiPk9qcGuGxB0D7weKq2fBW7Omy+kWX37W31e1WNYa6a+xT5u8QAOWXNf9nH9vg0Ml8MKWlhpqiYajEcj/wWFKFblQzBl5+2kzhEkd5Ag8gBG7r9bv/+MEW2vhPXq+3UL/XDkn/+S/xSFQdju2U++0YQ5py84Y/wnx3NyEQ3qRe0NFy/h9k+KMXPpAZ344/WYXBiYApbLulz6u/w4xhuNQ/UFLit5az9XyZ99vhhCWMbpNtcfjDjGFqI19eFPQtESpDSJNuHBzicPS63FVjekSO+S8Wta1FCDlIUPfAZ7lO9MhNgUauMAYyvpORNsEsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ncr.com; dmarc=pass action=none header.from=ncr.com; dkim=pass
 header.d=ncr.com; arc=none
Received: from BN6PR15MB1426.namprd15.prod.outlook.com (2603:10b6:404:c4::18)
 by BN6PR15MB1106.namprd15.prod.outlook.com (2603:10b6:404:e6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Fri, 24 Sep
 2021 17:34:27 +0000
Received: from BN6PR15MB1426.namprd15.prod.outlook.com
 ([fe80::fdf3:7fad:62b4:e015]) by BN6PR15MB1426.namprd15.prod.outlook.com
 ([fe80::fdf3:7fad:62b4:e015%12]) with mapi id 15.20.4544.014; Fri, 24 Sep
 2021 17:34:27 +0000
From:   "Russell, Scott" <Scott.Russell2@ncr.com>
To:     Emily Shaffer <emilyshaffer@google.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: pull failed - why should I receive this message.
Thread-Topic: pull failed - why should I receive this message.
Thread-Index: AdexUt9vq4ww6wDrT/SkOsyNHqWUqQAFrpQAAAAqpgA=
Date:   Fri, 24 Sep 2021 17:34:27 +0000
Message-ID: <BN6PR15MB14261D1A350398C0C26793E1CBA49@BN6PR15MB1426.namprd15.prod.outlook.com>
References: <BN6PR15MB1426A342CBA9D993C0C49E55CBA49@BN6PR15MB1426.namprd15.prod.outlook.com>
 <CAJoAoZ=DuqHe2brN8Y2Ts0_afEhUNrdasRBb1O8HHomLKRJ4PA@mail.gmail.com>
In-Reply-To: <CAJoAoZ=DuqHe2brN8Y2Ts0_afEhUNrdasRBb1O8HHomLKRJ4PA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_Enabled=true;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_SetDate=2021-09-24T17:33:30Z;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_Method=Privileged;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_Name=dc233488-06c6-4c2b-96ac-e256c4376f84;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_SiteId=ae4df1f7-611e-444f-897e-f964e1205171;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_ActionId=21a6591c-1460-47dd-a266-e3ff2116e5f4;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_ContentBits=0
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=ncr.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 62b95795-3047-4e17-a7ec-08d97f818ee3
x-ms-traffictypediagnostic: BN6PR15MB1106:
x-microsoft-antispam-prvs: <BN6PR15MB1106E3BEE1FB2966795F6D53CBA49@BN6PR15MB1106.namprd15.prod.outlook.com>
x-from-ncr-tenant: Processed
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JclW2T78R13HMXkOlCOYTEYRxySDZrapF2cZbupB2BX3vqZT2vMPz4C+5usBJ1V0Upz7FKqCTDy3prZrbmlfAgZrAMfQ/k9I5QiA1loAS89xybDt7zDFa0sHLr+d5uCl6xYio26LGNsgbypLTNWzTev7uIo/fdYLEylOQtB/UHx+FW3g3CpXZjDuW8hRppv8g56WcnWTFt6oYE17Fo7LJNtp3Qf0Ed+ksh350bxXEv/t5hFepaaGgYzEHcoW/bJms+D0iKezLPzzbr7bMwQrUOtWSOMsPxrTSgMdCYcEZTixIKlC1q+VDyzsHCN7DBA6rGIOTZ8yjepG/od58+bvCkyaxsY0FWHNTXyWvGVLbzZ4qgElsB+NRLkdloVdezqj0pzuBegs74uSBfeD96Vaps46WRKh5lMPs1jw9i+L0rK8yvoueV5TJoMBgVbw+rSGvWnHQfXxTJZv4+T/QD9ro3YAM84sa9ncr5NdL7WSGZJlAnQ2JUWEASu8SdArByIIBCEtZywmKeg3Pq5aB7NuLzWUdhpwuF4xFdqmaB+bJcOm2gUNg80lROpQKkeL8YCPtby9RDYo+I1p3K1k/EYiBNgIh5wcikQzryfmxUExK9ZNzkGwSBlJ/Dvd80+/M+UZY0bfOHwwjtPqhs5U9uetD0eaL6eWGWFhJEu5fDQvnUxh/wGv/L1fnnV/WxJV0ZsEjhI/OcNSzt/x6ejDGdG6z7LZ5pkHxUiHhljVM86XG/ziDngzc4ggkCyvkjP4fLRG+Yo6MMCoDI3u+EbZ5W0qTA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR15MB1426.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(76116006)(9686003)(6506007)(52536014)(2906002)(508600001)(55016002)(5660300002)(26005)(4326008)(8676002)(8936002)(186003)(53546011)(83380400001)(66946007)(64756008)(316002)(33656002)(66446008)(38070700005)(71200400001)(66556008)(6916009)(38100700002)(122000001)(66476007)(86362001)(15650500001)(7696005)(460985005)(2480315003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0UrRWp1SzFpTkN1OHFKVk92TndrUElraWNyNzMxc1l1bzJ5YjdHTUxva1RE?=
 =?utf-8?B?WWlEeFcwQWlLSWRqUDJvQldMYUFLUnhRTjUxVHhOdE5HNzRObnRXYlE1ODV6?=
 =?utf-8?B?TnpGeTN0MkJTbnNNaTRxa1RzQzI0MFNjOVoxSUpxVlNjTURWMzFmdmdENWVG?=
 =?utf-8?B?eDZ6NUh4d3pVUzluOEpIOEpjMnlvSlJHWVcwRnNkVWMzVDh5UzBmMXFGS093?=
 =?utf-8?B?QXFGYXV0OEs1bTBDaGFENzZldXRjMWVzRzlxMzMrR0h6SFg1cGtmSXc0eTQ4?=
 =?utf-8?B?amtSMUFoQ1IyTGRySS9IYlJTUGFDUU4xNzJENDhkRnVVc3hBQ1FndTM2VTAv?=
 =?utf-8?B?VCtHYlRVYTc4QjVYT0lNV2JRSWJNNmVlUWpDS0NpSmVZN3JXTVVvZFpkSTJD?=
 =?utf-8?B?OElzZ04zMy9NNVBxWU1UYU02ZDBLdlEzWjFPVG9vSDREZFZnOFVSYU83Yklj?=
 =?utf-8?B?OTN6aG9aNEszZ044VTdaV1dJamdmVjlqSjA3dVZ0SWorMUlsbXJ1UlQ2UC90?=
 =?utf-8?B?alZMQjlnUGFVcWJ3bXRpK3JoeWFDV25XRFpkZVgvWTk0K1N6TnNIMW9QU21T?=
 =?utf-8?B?ZU84bmtIYTBDaHY5ckViTHZWQVB5Y3h2L1k0Q242TDJpYkRoOHNzUHZNaS9i?=
 =?utf-8?B?QzhvNmVxalduQklQa1hmaDNsdjVQOW42c0lDZHNodzkyeElZdEhIZmJNQjlW?=
 =?utf-8?B?VUsyZ3Nlc2w4akthK2o3MFVsZEZ6WXV0eEZ6bFJVUVVGdFpQRXNQc1JmdjVT?=
 =?utf-8?B?R00zMXhnd213UVJpVm9VbkZDOCtrRjc5eWlpWUhIbUdBb283dWFYN0VkTVN0?=
 =?utf-8?B?V3FjZmllajE2TUkrQnNmWDdYbFJ6RkJZdXYrckpndjBqd0hIYXRaQnBjdlhY?=
 =?utf-8?B?NEIyNUFJNnF6SjdBa2xEZmJlQko4dHpkUE11UDhDMEpZOHN5ZW4wWVZMbFFm?=
 =?utf-8?B?bTNJYjNYUFV0QXJLRy83TDh2bmFZZWN3VE9PNnY0UVpTaTZrWGRXNEVjSjJx?=
 =?utf-8?B?S1NtNDhUUS9keTZvZHBrL0RzMDhVZ1BRRzNCV1pNdE9qVFhsYVBqV3VJUFRv?=
 =?utf-8?B?NVBYSzdxbEVYYXAxK3MvYU40Rk5rOEJlblYrbHkxem8ydEFxRXNGL1RYOVVx?=
 =?utf-8?B?dzIwUG9jQW5lSlVEdHVkUjR2OStIbnI5L0QybFd0OXljbmg4ZEprNS9xaUp1?=
 =?utf-8?B?dXlRU0hYNkV0Q0VnZEI3czhWYVArWUJRVWFyd1pCU0crWENiNWo2eENJeU03?=
 =?utf-8?B?L0Zya1gvRXY4UFZYRGZRTlFtb3JjWHRUb09zNGlTSTVzekt2c0NyZ1VwbnBC?=
 =?utf-8?B?a3RjTFh5OVNhYjhlMFhQMlQzZExHZjJja2luUW82bXhZRmpLV1RWb01VbThZ?=
 =?utf-8?B?TVZsNEpwOEtHMUtWcVQ1c21yNjlqZWR6bmFaMjBHajd4ZlBpeHZoeTljOWFQ?=
 =?utf-8?B?UldWaHFBUEhtNGJtZHZzZnlUTGVKWXM4aXFjSEJXYmJlcTZ6Rjl6eXFsLzJ2?=
 =?utf-8?B?R3ZadXk3bDJrc080VkhteWtZOHRwMUp1dEhJcHdDd3hJV2x0ck1tS3BaZUo1?=
 =?utf-8?B?OVp2QXRGM0cxYmRFRkxNTCtPZjVva3o3Z3ZEMEwrUmJXY0ZvZk96RFNxbmdK?=
 =?utf-8?B?VnlkSDkzYUJaU3Q4N3dVMjNLanB4OVRsMDcyODl0aFUzQXVXWnF2NHZzbjJa?=
 =?utf-8?B?NlJNSUl4Z255ZzY3aDZ3aVZROVM5SHJpVkNiL21QVHBBcDVmVGZvSWNmMzds?=
 =?utf-8?Q?oTJVMMFqmaUC0IIunzUZoMaMKxObzTuK9M3YG5g?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ncr.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR15MB1426.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62b95795-3047-4e17-a7ec-08d97f818ee3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2021 17:34:27.3109
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ae4df1f7-611e-444f-897e-f964e1205171
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: osWzM7rPSd4pz+zy2HualPzpuzk2Pn+dUp9OvAJnC/mqAFY0sOfjNvy6xwlCzMUzMsGuB3FXn0ry4EbuWqJlbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1106
X-Proofpoint-GUID: _rp6GUESSgq1Po9yL0jhRMeT_w-EloX0
X-Proofpoint-ORIG-GUID: _rp6GUESSgq1Po9yL0jhRMeT_w-EloX0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-24_05,2021-09-24_02,2020-04-07_01
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

VGhhbmtzIGZvciB5b3VyIGFuc3dlci4gICBJcyB0aGVyZSBub3QgYW4gb3B0aW9uIG9uIHRoZSBw
dWxsIHRvIGhhdmUgZ2l0IHRvIG92ZXJ3cml0ZSB0aGUgZXhpc3RpbmcgZmlsZXM/IA0KDQoNClRo
YW5rcywgDQoNClNjb3R0IFJ1c3NlbGwNClN0YWZmIFNXIEVuZ2luZWVywqANCk5DUiBDb3Jwb3Jh
dGlvbsKgDQpQaG9uZTogKzE3NzA2MjM3NTEyDQpTY290dC5SdXNzZWxsMkBuY3IuY29tICB8ICBu
Y3IuY29tDQogICAgICAgDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBFbWls
eSBTaGFmZmVyIDxlbWlseXNoYWZmZXJAZ29vZ2xlLmNvbT4gDQpTZW50OiBGcmlkYXksIFNlcHRl
bWJlciAyNCwgMjAyMSAxOjI5IFBNDQpUbzogUnVzc2VsbCwgU2NvdHQgPFNjb3R0LlJ1c3NlbGwy
QG5jci5jb20+DQpDYzogZ2l0QHZnZXIua2VybmVsLm9yZw0KU3ViamVjdDogUmU6IHB1bGwgZmFp
bGVkIC0gd2h5IHNob3VsZCBJIHJlY2VpdmUgdGhpcyBtZXNzYWdlLg0KDQoqRXh0ZXJuYWwgTWVz
c2FnZSogLSBVc2UgY2F1dGlvbiBiZWZvcmUgb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0K
DQpPbiBGcmksIFNlcCAyNCwgMjAyMSBhdCAxMDowOCBBTSBSdXNzZWxsLCBTY290dCA8U2NvdHQu
UnVzc2VsbDJAbmNyLmNvbT4gd3JvdGU6DQo+DQo+IEZpbGVzIG5vdCBwcmV2aW91c2x5IGluIGdp
dCB3ZXJlIGFkZGVkIHRvIGdpdC4gICBXaHkgc2hvdWxkIEkgaGF2ZSB0byBtYW51YWxseSBkZWxl
dGUgdGhlbT8NCj4gV2h5IGNhbiBnaXQgcHV0IG5vdCByZXBsYWNlIHRoZW0/ICBUaGV5IHdlcmUg
dW50cmFja2VkIGZpbGVzIHRoYXQgYXJlIG5vdyB0cmFja2VkICBhbmQgc28gdGhlIGdpdCBjb3B5
IGlzIGRlc2lyZWQuDQo+IFdlIGNhbid0IGFsd2F5cyBrbm93IGFoZWFkIG9mIHRpbWUgd2hhdCBm
aWxlcyBtYXkgaGF2ZSBiZWVuIGFkZGVkIGVsc2V3aGVyZS4NCg0KVG8gdHVybiBpdCBhcm91bmQg
b24geW91LCB5b3UgY2FuJ3QgYWx3YXlzIGtub3cgYWhlYWQgb2YgdGltZSB3aGF0IGZpbGVzIG1h
eSBoYXZlIGJlZW4gYWRkZWQgZWxzZXdoZXJlLCBzbyB5b3UgY2FuJ3QgYmUgc3VyZSB0aGF0IHlv
dXIgbmV3bHkgYWRkZWQgdW50cmFja2VkIGZpbGUgbG9jYWxseSB3aWxsIGJlIHNhZmUgZnJvbSBi
ZWluZyBvdmVyd3JpdHRlbiBkdXJpbmcgYSBwdWxsLiBIb3cgdXBzZXR0aW5nIGlmIHlvdSBzaW5r
IDMwIGhvdXJzIGludG8gbmV3bGliLmNwcCBhbmQgdGhlbiB5b3VyIHRlYW1tYXRlIGNoZWNrcyBp
biB0aGVpciBvd24gbmV3bGliLmNwcCwgYW5kIHlvdXJzIGlzIG92ZXJ3cml0dGVuIHdpdGhvdXQg
YXNraW5nIHdoZW4geW91IHJ1biAnZ2l0IHB1bGwnLg0KDQpZb3UgbWlnaHQgaGF2ZSBzb21lIGx1
Y2sgd2l0aCB0aGUgJy0tYXV0b3N0YXNoJyBvcHRpb24sIHdoaWNoIHdvdWxkIGF0IGxlYXN0IHBy
b21wdCB5b3Ugd2hldGhlciB0byBnZXQgcmlkIG9mIHRoaW5ncyB3aGVuIHRyeWluZyB0byBtZXJn
ZSB0aGVtIGJhY2sgdG9nZXRoZXIgZHVyaW5nIHRoZSBhdXRvbWF0aWMgJ2dpdCBzdGFzaCBwb3An
IGF0IHRoZSBlbmQuIE9yIHlvdSBjb3VsZCBydW4gJ2dpdCBjbGVhbiAtLWZvcmNlJyB0byBhdXRv
bWF0aWNhbGx5IGRlbGV0ZSBhbnkgdW50cmFja2VkIGZpbGVzIHlvdSBtaWdodCBoYXZlIC0geW91
IGNvdWxkIGV2ZW4gYWxpYXMgeW91cnNlbGYgYSBjb21tYW5kIGxpa2UgJ2dpdCBkYW5nZXJvdXMt
cHVsbCcgd2hpY2ggcnVucyAnZ2l0IGNsZWFuIC1mICYmIGdpdCBwdWxsJy4NCg0KPg0KPg0KPiBX
ZSBuZWVkIHRoZSBwdWxsIHRvIHdvcmsgYXV0b21hdGljYWxseS4NCj4NCj4gZXJyb3I6IFRoZSBm
b2xsb3dpbmcgdW50cmFja2VkIHdvcmtpbmcgdHJlZSBmaWxlcyB3b3VsZCBiZSBvdmVyd3JpdHRl
biBieSBtZXJnZToNCj4gICAgICAgICBTdGFnaW5nL0NBRERBcHBzL0NBRERVSUhlbHBlci9Tb3Vy
Y2UvUmVsZWFzZS9DQUREVUlIZWxwZXIuZXhlDQo+ICAgICAgICAgU3RhZ2luZy9DQUREQXBwcy9D
QUREVUlIZWxwZXIvU291cmNlL1JlbGVhc2VfVW5pY29kZS9DQUREVUlIZWxwZXIuZXhlDQo+ICAg
ICAgICAgU3RhZ2luZy9DQUREQXBwcy9JbnN0YWxsRHJpdmVyc1BhY2thZ2UvUmVsZWFzZS9JbnN0
YWxsRHJpdmVyc1BhY2thZ2UuZXhlDQo+ICAgICAgICAgU3RhZ2luZy9Db21tb24vTkNSQ29tbW9u
Q0NMaWIvU291cmNlL1JlbGVhc2UvTkNSQ29tbW9uQ0NMaWJNc2cuZGxsDQo+ICAgICAgICAgU3Rh
Z2luZy9EZXZpY2VzL05GQy9FbGF0ZWNfUkZJRFJlYWRlci9CaW4vRGlyZWN0b3IuZXhlDQo+ICAg
ICAgICAgU3RhZ2luZy9EZXZpY2VzL05GQy9FbGF0ZWNfUkZJRFJlYWRlci9GaXJtd2FyZS9BcHBC
bGFzdGVyLmV4ZQ0KPiAgICAgICAgIFN0YWdpbmcvRGV2aWNlcy9ORkMvRWxhdGVjX1JGSURSZWFk
ZXIvRmlybXdhcmUvZmxhc2guZXhlDQo+ICAgICAgICAgU3RhZ2luZy9VdGlsaXRpZXM2NC9TU1BT
V0RyaXZlckluc3RhbGxlci9CaW4vRElGeEFQSS5kbGwNCj4gICAgICAgICBTdGFnaW5nL1V0aWxp
dGllczY0L1NTUFNXRHJpdmVySW5zdGFsbGVyL0Jpbi9Ecml2ZXJGb3JnZS52NC41LjQuZXhlDQo+
ICAgICAgICAgU3RhZ2luZy9VdGlsaXRpZXM2NC9TU1BTV0RyaXZlckluc3RhbGxlci9Tb3VyY2Uv
UmVsZWFzZS9TU1BTV0RyaXZlckluc3RhbGxlci5leGUNCj4gICAgICAgICBTdGFnaW5nL1V0aWxp
dGllczY0L1NTUFNXRHJpdmVySW5zdGFsbGVyL1NvdXJjZS9SZWxlYXNlL1NTUFNXRHJpdmVySW5z
dGFsbGVyTXNnLmRsbA0KPiAgICAgICAgIA0KPiBTdGFnaW5nL1V0aWxpdGllczY0L1NTUFNXVGFz
a01nci9Tb3VyY2UvUmVsZWFzZS9TU1BTV1Rhc2tNZ3IuZXhlDQoNCk9yIGJldHRlciB5ZXQsIHlv
dSBjb3VsZCBhdm9pZCBjaGVja2luZyBpbiBjb21waWxlZCBiaW5hcmllcyBsaWtlIHRoZXNlIGFu
ZCBpbnN0ZWFkIGFkZCB0aGVtIHRvIHlvdXIgLmdpdGlnbm9yZSwgdW5sZXNzIHlvdSByZWFsbHkg
bWVhbiB0byB1cGRhdGUgdGhlbSBldmVyeSB0aW1lIHNvbWVvbmUgbWFrZXMgc29tZSBjaGFuZ2Uu
IFdoZW4gY2hlY2tpbmcgaW4gYmluYXJpZXMsIHlvdSBzaG91bGQgYmUgYXdhcmUgb2YgdGhlIGFk
ZGl0aW9uYWwgZGlzayBvdmVyaGVhZCBuZWVkZWQgdG8gZG8gc28gYW5kIHRha2UgYSBsb29rIGF0
IHNvbWUgb3B0aW9ucyBHaXQgaGFzIHRvIG1pdGlnYXRlIHRoYXQgb3ZlcmhlYWQsIGxpa2UgcGFy
dGlhbCBjbG9uZS4gSG93ZXZlciwgaW4gbWFueSBjYXNlcyB0aGUgZWFzaWVzdCB3YXkgdG8gbWl0
aWdhdGUgdGhhdCBvdmVyaGVhZCBpcyB0byBzaW1wbHkgbm90IGNoZWNrIGluIGJpbmFyaWVzIHVu
bGVzcyB5b3UgYWJzb2x1dGVseSBuZWVkIHRoZW0gdG8gYmUgdmVyc2lvbiBjb250cm9sbGVkLg0K
DQotIEVtaWx5DQo=
