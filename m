Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F4D5C433F5
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 20:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57ED661038
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 20:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346011AbhIXUPC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 16:15:02 -0400
Received: from mx0b-00209e01.pphosted.com ([148.163.152.55]:57194 "EHLO
        mx0b-00209e01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344820AbhIXUPB (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 24 Sep 2021 16:15:01 -0400
Received: from pps.filterd (m0094031.ppops.net [127.0.0.1])
        by mx0b-00209e01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18OIFmfF011611;
        Fri, 24 Sep 2021 16:13:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ncr.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pod1119;
 bh=HYMKlHN+bYVZcggQjyYSDFVOLpIY5vLO3iXl8OP7u4M=;
 b=zZWYQRqUngdueaNTZuvOWrU/e1D+TuNtMInOzxqIU/yiu5XEB9sAjiJMVOxgHvudv5KZ
 Pi6AZOacdvR78aq0SEp+9DxOcEk1oGGuX3PSStC5/u3z7GyUhUxH+Bimcvfev3mEQ+lo
 yDtCwYSlZR/IAxbXfI42u6HPGSjewn+fxwcl/o2Gfpd5+Kxsjm4jfuGucaauL7pOVlk5
 hqAVQbS/aIGXplxlCUsO83u9OPXzHeoGay2vWV8JKJ9CnHWwFq1//DVh5awK0pOQ3Kqz
 9AJANiUBogJP5MgMPZQjR0HR4d02tV7+p2i6Gk/wxTE3Y68wFtuySYRV08u948OUCAmZ +Q== 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2047.outbound.protection.outlook.com [104.47.51.47])
        by mx0b-00209e01.pphosted.com with ESMTP id 3b93f2xeaf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Sep 2021 16:13:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Old92jBj7oUFU2gRsio60ZmfX1N4/PnpVXgKzcbOVlAbp/9SwGqjYD7gMTVbe5VClSHPnbcd+e7GkvPKF0aEZuy1AOv9wQ5lC6XvVwvGG70++clQGzdkON36BtQiqv3P+tx3K+tY1/ZoWxp590PdexwIbNcylKLRV7hyymHUzd3wGz7lULGYFhUaYfJS36+m5wms/KDItAZdapxJ/8gmj4ugzK5UaTdgrxvFd1P4xi923T8V9wu1blq/kh3W2cStYjDOqq1vg1OcB/3j8fQFc1WJk9J66LeIVe+EM/2PjunPI8tpOToh5j7z8EQkMSxpCECirykK7YEW6pVmrcx3SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=HYMKlHN+bYVZcggQjyYSDFVOLpIY5vLO3iXl8OP7u4M=;
 b=LhWnKBZWuCQFVqV/jX/EEGeWq3MOF81DG/koTqFniXX8hpt4fw19f3QljXdciPxQLX4nxAIabMt1rafOlK/gCiWpRzNLGm4K5LXNZMruASOd/xy+hKhgwCVzh7eY6X7aRE744GXeKm1BNaImmaeFP4JlslVlysV6bAGiGymtahbUbIEM3MJSKKQEzQtLTYGgj5NifONkqbgzP7dHvuvAtpQKwH9hf5go+cQ2/aUqS0D/YhqbYHj0y/5wDLRkqJWtLS8cmc/BN3G6YMH60yuu2aiTckxFuDLrmP01sN28HLlI19HK22mCVr3eVncd+h9DypHfcGjBb2jvDERP5+k+NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ncr.com; dmarc=pass action=none header.from=ncr.com; dkim=pass
 header.d=ncr.com; arc=none
Received: from BN6PR15MB1426.namprd15.prod.outlook.com (2603:10b6:404:c4::18)
 by BN8PR15MB2993.namprd15.prod.outlook.com (2603:10b6:408:83::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Fri, 24 Sep
 2021 20:13:15 +0000
Received: from BN6PR15MB1426.namprd15.prod.outlook.com
 ([fe80::fdf3:7fad:62b4:e015]) by BN6PR15MB1426.namprd15.prod.outlook.com
 ([fe80::fdf3:7fad:62b4:e015%12]) with mapi id 15.20.4544.014; Fri, 24 Sep
 2021 20:13:15 +0000
From:   "Russell, Scott" <Scott.Russell2@ncr.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
CC:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Emily Shaffer' <emilyshaffer@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: pull failed - why should I receive this message.
Thread-Topic: pull failed - why should I receive this message.
Thread-Index: AdexUt9vq4ww6wDrT/SkOsyNHqWUqQAFrpQAAAAqpgAAAPPngAAA0WowAAN6l4AAADvH4A==
Date:   Fri, 24 Sep 2021 20:13:15 +0000
Message-ID: <BN6PR15MB1426EBF10C9E8634EF317DDBCBA49@BN6PR15MB1426.namprd15.prod.outlook.com>
References: <BN6PR15MB1426A342CBA9D993C0C49E55CBA49@BN6PR15MB1426.namprd15.prod.outlook.com>
 <CAJoAoZ=DuqHe2brN8Y2Ts0_afEhUNrdasRBb1O8HHomLKRJ4PA@mail.gmail.com>
 <BN6PR15MB14261D1A350398C0C26793E1CBA49@BN6PR15MB1426.namprd15.prod.outlook.com>
 <000401d7b16e$17ea02d0$47be0870$@nexbridge.com>
 <BN6PR15MB14262C7036B3C792CCE861D8CBA49@BN6PR15MB1426.namprd15.prod.outlook.com>
 <YU4vG0TI+BkK6xiW@camp.crustytoothpaste.net>
In-Reply-To: <YU4vG0TI+BkK6xiW@camp.crustytoothpaste.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_Enabled=true;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_SetDate=2021-09-24T20:10:20Z;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_Method=Standard;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_Name=dc233488-06c6-4c2b-96ac-e256c4376f84;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_SiteId=ae4df1f7-611e-444f-897e-f964e1205171;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_ActionId=cc56e2b7-49de-4d46-899a-5b1334b82e58;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_ContentBits=0
authentication-results: crustytoothpaste.net; dkim=none (message not signed)
 header.d=none;crustytoothpaste.net; dmarc=none action=none
 header.from=ncr.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 84bc63b6-4a46-4847-1c46-08d97f97bdf3
x-ms-traffictypediagnostic: BN8PR15MB2993:
x-microsoft-antispam-prvs: <BN8PR15MB2993E4420B8C091E3B8A327FCBA49@BN8PR15MB2993.namprd15.prod.outlook.com>
x-from-ncr-tenant: Processed
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XyGeGEFJ2LaySPeoIJPHa/+LtXTuGuI/OT0AED8EO/1bkKHmoRa/T7yPitPidatF1d2IfvELk/3lqL2T1IBWOv0jbJ9iMcj+nvGqty5QcxhVBcFsnfaDsYQAW9ZZ1E3aFyePhVyQhRBCEjaH1F3sM3oZSvrOQ9sJCBr6D/ZASBqHdTN1THt80+setIDG3AM13Kzv+6cU82w+bBjfEyv/wp8DZttJmSuxxkjXTmtvi5ltwfRHZQt8NvbHNKEUYN/x38Ev+vR8NzG1qlpHGt9cuOEl10HEKxEsZ81HUVClhRdoAlVqX9TRRR9oETGuifZCNrhMP0y58bkG3wNIKo8Zu7jIuqB0APJtA0zNrNoNazROHKZsuUdEFjhpcNHwZruENmg0H//Pq9KWMX+a2iUaJow9RPPer9YTKcuN7uhtYWrnN2q1Tf7spHYwERmRRNGk5lo56NZp3SSwvmNrUX5s+nx8Dhpwlh8D0JCDQFW3XKlAgr4kJjfY1mafvgN62RONzLdl/3xRqXX8Ds9DWtzrAzp5KsiTqzUrWJbOEa/S/YvKhCkRo2/u8v1cUxmFpM8Or8NIF9GYs57fPptIGrhtlygfbYdqK2R31uVyYjO1D1fuLBwPahbkZpfn5IPjqKliMLdOELWNJWYpOn3aVg7hlS3t0s3dh8w/55USpuu3ks3lNCmgjzevnfAF0wRq15bAQknfgKaxff85Ae1cK0dZwg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR15MB1426.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(64756008)(4326008)(9686003)(38100700002)(66446008)(7696005)(122000001)(66476007)(52536014)(54906003)(55016002)(2906002)(5660300002)(76116006)(66556008)(186003)(38070700005)(86362001)(8936002)(508600001)(83380400001)(71200400001)(8676002)(33656002)(26005)(6506007)(53546011)(15650500001)(316002)(6916009)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U1BIWE03NEI3UlZFRkhUU2VwY241RWQ0SVBYSmVwbGZDdXB6eHRMcHNoUVdu?=
 =?utf-8?B?b25DMkMvT0liekpmYkhNc1NJczFyVWhRaUhqeEtreWlrc3RaY0oranlrQ3p5?=
 =?utf-8?B?SzgyU0Z3cEIzT2dQN3BsN005WmhUYmNkMEJlbmcrdDVNQnR3TitGYkRyV2Z4?=
 =?utf-8?B?SXlOQ3FJTFMyZ1VUZmFEQnVSYXZ5NmJnQThhUWNNREI1ZU56U1NWa0VUUTcy?=
 =?utf-8?B?UDdqWTE4U3hPMHRSTWlNR0lCclRkYVBWOWJTcnpDNXE2Nnh4YXEreWlyWFhQ?=
 =?utf-8?B?MXdMLzE2TXBzWWR2Y1c5YURWeU5HeGtic2sveEFTSm5lclBWT1V2bmphNkdh?=
 =?utf-8?B?L1ZaWVFZVUtRMnNBbjhLWkxYMWEwTzNsUVg3SUtKdU1tSGZCSktvdzFrK2hy?=
 =?utf-8?B?eU1HQWdJVXFEVEh6bWxNaW5DV3RVSW1KamdyVmpFSWF6VVdNeFZ6Ri85MlFK?=
 =?utf-8?B?cW1TZERjRExCT1pkNEVEL1Y4WjVkS2lqbmZjMmllNW5NRzlBNFkzWWdhbzBH?=
 =?utf-8?B?ZkRzQWZ3L2tia2VaWXBtTUdKRzFjWmlTdjhtbUU2aVFJUThnN2lYckJYMzB5?=
 =?utf-8?B?OS90VEp2S1ZWdVdlYy9oUHl0Snd5WDFPYzBRdWk2RHpJTFhuNWhLRFQrYlM2?=
 =?utf-8?B?SXRkTDMzNUZ4LytUcjhxMklXcU54VnF5R1I0dmFVVGRVSjFvbHJqMWR0WmJq?=
 =?utf-8?B?S1dFdkJmNE5PaDR0UDVEaUwzd3Y1Ny9rL1htdmtxeFpDazZaUkxML0FGWUJV?=
 =?utf-8?B?bW1ZWk44SE93M2JCZE1YWmsxZENqRlVQSG9Db3B2bDRBSUtvSjVDT2h0M0Fk?=
 =?utf-8?B?cVBKVXBIZ0s3azhjYnFubzhEZjBEM09VN0t1S0doYWRmc0wvTmNCRGNXQ3A0?=
 =?utf-8?B?V1NDNU80UFEwYkdzenJRMXVmbjJCNHcrUm9RS0dybjlUNlFTNHFXZlVvWmV5?=
 =?utf-8?B?Z0U4Y0VJckhvWjhNM0RaUzIwdm1PbnFtaEY4c3BvSHYvaGhpeCtFYVpDMTFm?=
 =?utf-8?B?VFc0cmg2Z3ZDVGZMQWwxZkkvNDVJUndIKzBvOE9CcEIwRnlQclJCWFZIT3Fx?=
 =?utf-8?B?a2dFTXpORG54Q2lHSU9lMTVlNi8zdVFZUnM4LzFOamZHWmVVWG81UWNJOG1o?=
 =?utf-8?B?eWloOTFLSDFpUFNhT3lzai8wUW5VeG5aNGQ0NDQwWTZ1R0F6QTcxK2ZmajV0?=
 =?utf-8?B?TVk0cVZuRHY5MEUyVDFtRGQ5QnNOTXNYQ0pPSFJJN21tZUZ5Q1RJZkNOYnIz?=
 =?utf-8?B?dFJrQWhQN0dreS9FdlROV090MkpnN0FnWk9OWSs5czZKcWd2Mll4UlZLb21u?=
 =?utf-8?B?bmNtY2VSaUxZMmsycWtmL2c0ZWNWSkVvb1BaTEwrcnNwWnV5cnhaRjJBZ1cy?=
 =?utf-8?B?M05LSWg5bGxubjFNczFlTVlzUkZIRVFnMFlHRVBIOUVMbHNiTkZoUlgvK1BL?=
 =?utf-8?B?SkFHU1hYazNBdmkxR3pyZlYxQ29IUHI2b21KM0xUTUFzK2t2eVhtWXFsd2U4?=
 =?utf-8?B?Z3JmT25JTTg1bWdQOVpla0YrMWRqWGppdVE0dW9uc2hGMVhuS0dVTnNUUFhF?=
 =?utf-8?B?R0VrVENGc2FGWFVJZ25tZnNMK0l5TVpEcXpVNktCd1BIbTZuemFERUlKNDFS?=
 =?utf-8?B?d0xwM3dqamU2ZXN5d1JZa21Td2M4UENnUUNSV1c5SXd0L1RwcTZ6MGhXNXFW?=
 =?utf-8?B?elZKNlg2MEJnL0E5eE50STdFQ0F0aUlqS3ZuMmY0YVlxeGE3ZzRZZmlWY1R6?=
 =?utf-8?Q?khO49he15/A2OO+huaAjaPrI6JCPp9X+9EeZDwF?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ncr.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR15MB1426.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84bc63b6-4a46-4847-1c46-08d97f97bdf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2021 20:13:15.1512
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ae4df1f7-611e-444f-897e-f964e1205171
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bVeD1UR8NQrIAENZPlRY3pSEC8Nt96BK5R0AR6bGkRGoRyVJfzhevsswU4F7r+CkTMRco4cSFdioTJpaaDJF0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2993
X-Proofpoint-ORIG-GUID: p0kUAE_Bo0bWnFvKtCZY_LK2PeWgGvjY
X-Proofpoint-GUID: p0kUAE_Bo0bWnFvKtCZY_LK2PeWgGvjY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-24_05,2021-09-24_02,2020-04-07_01
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

QnJpYW4sICANCg0KWW91IGFyZSBjb3JyZWN0LiAgVGhpcyBpcyBhIGJ1aWxkIHN5c3RlbS4gIEFu
ZCB5b3VyIHJlc3BvbnNlcyBhcmUgdGhlIG1vc3QgdXNlZnVsIHNvIGZhci4gIA0KDQoiZ2l0IGZl
dGNoIG9yaWdpbiIgLSBva2F5IA0KDQpGb3IgdGhpcyBvbmUsIGlzIHRoZXJlIGEgd2F5IHRvIHNw
ZWNpZnkganVzdCB0aGUgaGVhZD8gICBJIGp1c3Qgd2FudCB0aGUgbGF0ZXN0IC0gYW5kIGRvbid0
IHdhbnQgdG8gdHJ5IHRvIGZpZ3VyZSBvdXQgd2hhdCAnUmV2aXNpb24nIG1heSBiZS4gDQoNCiJn
aXQgY2hlY2tvdXQgLWYgUkVWSVNJT04iDQoNCg0KDQpUaGFua3MsIA0KDQpTY290dCBSdXNzZWxs
DQpOQ1IgQ29ycG9yYXRpb27CoA0KICAgICAgIA0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KRnJvbTogYnJpYW4gbS4gY2FybHNvbiA8c2FuZGFsc0BjcnVzdHl0b290aHBhc3RlLm5ldD4g
DQpTZW50OiBGcmlkYXksIFNlcHRlbWJlciAyNCwgMjAyMSA0OjA0IFBNDQpUbzogUnVzc2VsbCwg
U2NvdHQgPFNjb3R0LlJ1c3NlbGwyQG5jci5jb20+DQpDYzogUmFuZGFsbCBTLiBCZWNrZXIgPHJz
YmVja2VyQG5leGJyaWRnZS5jb20+OyAnRW1pbHkgU2hhZmZlcicgPGVtaWx5c2hhZmZlckBnb29n
bGUuY29tPjsgZ2l0QHZnZXIua2VybmVsLm9yZw0KU3ViamVjdDogUmU6IHB1bGwgZmFpbGVkIC0g
d2h5IHNob3VsZCBJIHJlY2VpdmUgdGhpcyBtZXNzYWdlLg0KDQoqRXh0ZXJuYWwgTWVzc2FnZSog
LSBVc2UgY2F1dGlvbiBiZWZvcmUgb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KDQpPbiAy
MDIxLTA5LTI0IGF0IDE4OjM2OjUxLCBSdXNzZWxsLCBTY290dCB3cm90ZToNCj4gUmFuZGFsbCwN
Cj4gDQo+IFRoYW5rcyBmb3IgeW91ciBhbnN3ZXIuICAgSG93ZXZlciwgdGhpcyBpcyBhIGJ1aWxk
IHN5c3RlbS4NCj4gR2l0IGNsZWFuIC1keGYgd291bGQgZGVsZXRlIGFsbCB1bnRyYWNrZWQgZmls
ZXMgLSBub3QganVzdCB0aGUgY29uZmxpY3RlZCBvbmVzLg0KPiANCj4gV2UgbXVzdCBrZWVwIGFs
bCB1bnRyYWNrZWQgZmlsZXMgdGhhdCB3b3VsZCBub3QgYmUgY29uZmxpY3RlZCBieSB0aGUgcHVs
bC4NCj4gT3RoZXJ3aXNlLCB0aGUgcmVzdWx0IHdvdWxkIGJlIG91ciBidWlsZCB3b3VsZCBuZWVk
IHRvIGRvIGEgZnJlc2ggYnVpbGQgb2YgYWxsIG9iamVjdHMgYW5kIGJ1aWxkIHRhcmdldHMgLSB0
aG9zZSBhcmUgYWxsIHVudHJhY2tlZCBhcyB3ZWxsLg0KPiBJbnN0ZWFkIG9mIHRoZSBkZXNpcmVk
IGNhc2Ugb2YganVzdCBidWlsZGluZyB0aGUgY2hhbmdlZCBmaWxlcyBhbmQgdGhlaXIgcmVzdWx0
YW50IHRhcmdldHMuDQoNCk5vdGUgdGhhdCBhICJnaXQgY2xlYW4gLWR4ZiIgd2lsbCBjbGVhbiBl
dmVuIGlnbm9yZWQgZmlsZXMuICBJZiB5b3UganVzdCBuZWVkIHRvIGNsZWFuIHVudHJhY2tlZCBm
aWxlcywgeW91IGNhbiBkbyAiZ2l0IGNsZWFuIC1kZiIgKHdpdGhvdXQgdGhlDQoteCkgYW5kIHRo
ZW4geW91ciBpZ25vcmVkIGZpbGVzIHdpbGwgbm90IGJlIGRlbGV0ZWQuDQoNCj4gV2UganVzdCBu
ZWVkIHRoZSBwdWxsIHRvIG92ZXJ3cml0ZSBhbnkgdW50cmFja2VkIGZpbGVzIHRoYXQgbWF5IGV4
aXN0IGluIGNvbmZsaWN0IHdpdGggbmV3bHkgdHJhY2tlZCBmaWxlcy4NCj4gDQo+IEkgc2VlIGdp
dCBpcyB0cm91Ymxlc29tZSBpbiB0aGlzIHNpdHVhdGlvbi4gICBFdmVyeSB0aW1lIGEgZGV2ZWxv
cGVyIGFkZHMgYW4gdW50cmFja2VkIGZpbGUgdG8gdGhlIHJlcG8gLSByZWdhcmRsZXNzIG9mIHR5
cGUsDQo+IEl0IHdpbGwgcmVzdWx0IGluIGZhaWx1cmUgb2YgdGhlIHB1bGwuICAgQW5kIGEgZmFp
bHVyZSBvZiB0aGUgYnVpbGQuDQoNCkkgZG8gc3Ryb25nbHkgYWdyZWUgd2l0aCBFbWlseSB0aGF0
IGJ1aWxkIGFydGlmYWN0cyBzaG91bGQgbm90IGJlIHRyYWNrZWQgaW4gdGhlIHJlcG9zaXRvcnkg
YW5kIHRoYXQgdGhlIGJlc3Qgd2F5IHRvIHNvbHZlIGl0IGlzIHRvIGFkZHJlc3MgdGhhdCBwcm9i
bGVtLg0KDQpIb3dldmVyLCBpZiB5b3VyIGdvYWwgaXMgdG8ganVzdCB1cGRhdGUgdGhlIHdvcmtp
bmcgdHJlZSB0byBhIHNwZWNpZmljIHJldmlzaW9uLCByYXRoZXIgdGhhbiB0byBwb3RlbnRpYWxs
eSBtZXJnZSB0aGF0IGNvbW1pdCBpbnRvIHRoZSB3b3JraW5nIGRpcmVjdG9yeSwgeW91IGNhbiB1
c2UgImdpdCBmZXRjaCBvcmlnaW4iIHRvIGZldGNoIHRoZSByZW1vdGUsIGFuZCB0aGVuIHVzZSAi
Z2l0IGNoZWNrb3V0IC1mIFJFVklTSU9OIiB0byBjaGVjayBvdXQgdGhlIGJyYW5jaCBhbmQgZGVz
dHJveSBsb2NhbCBjaGFuZ2VzLiAgSSBzdXNwZWN0IGluIHlvdXIgY2FzZSwgc2luY2UgdGhpcyBp
cyBhIGJ1aWxkIHNlcnZlciwgdGhhdCBjaGVja2luZyBvdXQgYSBzcGVjaWZpYyByZXZpc2lvbiBp
cyB0aGUgaW50ZW5kZWQgYmVoYXZpb3IuDQotLQ0KYnJpYW4gbS4gY2FybHNvbiAoaGUvaGltIG9y
IHRoZXkvdGhlbSkNClRvcm9udG8sIE9udGFyaW8sIENBDQo=
