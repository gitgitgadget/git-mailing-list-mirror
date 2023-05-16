Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CC0C77B75
	for <git@archiver.kernel.org>; Tue, 16 May 2023 22:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjEPWTy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 May 2023 18:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjEPWTw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2023 18:19:52 -0400
X-Greylist: delayed 1417 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 16 May 2023 15:19:50 PDT
Received: from mx0a-002e0402.pphosted.com (mx0a-002e0402.pphosted.com [148.163.144.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48AE559FA
        for <git@vger.kernel.org>; Tue, 16 May 2023 15:19:50 -0700 (PDT)
Received: from pps.filterd (m0165940.ppops.net [127.0.0.1])
        by mx0a-002e0402.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GJQSAN028930;
        Tue, 16 May 2023 21:55:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vcentertainment.com; h=from : to :
 cc : subject : date : message-id : references : in-reply-to : content-type
 : content-transfer-encoding : mime-version; s=DKIM20181126;
 bh=LZ6QbK0Snyh+M2kehUmtUqfY6Fn+ncedqffpUfJKnVg=;
 b=OFxNXkbz/eHkhvmYzVwsYIC2OLpObuhJhFWngY/JfHs+hz1cLggoMaSbtUHHItx5lX0q
 NEoBX1YTrbuSLdGsTRNvOsOv2k9mOKx5qgh4VAk98foWmLogPqgstYsd5EFpiLlDz9e6
 ih2hnF0j7K+vNbG/konKH8m3+m4+Sw4qzJedxKaiXFVrhJ+BL5hu9W6y6oCm528aNRHz
 XZy1TGdeh6EpDjwRwkY2toAJS43L5cb/l/egbhm4f2tDWnTI64idTcuLnWeAyk1KNOIg
 RT3ICOJjxvw0V8s7maDo2mn6efArCsXLhhPX5Dbv1UeXEtapwGe+mg0xgRIPwTbcR/VU eQ== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by mx0a-002e0402.pphosted.com (PPS) with ESMTPS id 3qjnfqeg04-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 21:55:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F72hsvBnbDt5EX5Jv6hGSvvhGy1tga3CKkM/aaS+qbK2EPf4SrXS/rqoF5IJA4Yabh8P45LQGfyPvOqTlFpby1G4D4AsP5wUE46nnY3mCkV2Z3pneTM8Yr+RcbuucnLTjFYBAXfAGMig+nWMePU1Jx1aYen6FBgFbGR2x8w9nUC7xa2tns3Gqwf8DM8PX703DhooCUFC7LAJnzgRumGwTGgewJAfL9OgFPTMVGS/Sx3wyHFgEFGE22kYfwxyTdT5eNPOxlylSEIzgOEIO6WziIlsnZ70SWTBbxijLVgFQPJQNA0pJuO6DrrMe6OsAFMPm7HnJwfU8NcYwbU0U39J+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LZ6QbK0Snyh+M2kehUmtUqfY6Fn+ncedqffpUfJKnVg=;
 b=CJE1AV2nttifkFI+7jNCXxf+hnAKWWA3pM3SYuPPPbzieo2RBzfetv0Hgy5VUuf88MgwzoJklZ0pkK18k4OpjzmdHHKJE7GGzzv+nb6VUL2aYf7Ay0w3CLz2veX/j8sv/oxVg1puF38uYODArGMwZVO1WLVwKUR04c7Flb//3wQjFWUIi1pDQGSCCdXKDs69n9//Q3VCU5utjSOusM9dkiakGFxssSwa+E5b9RnpIxdQ9+Kj3z2ruPt2JEvJLPbvuDB1XGj/T6WN5PkBqL93vmmjZO0Niqupp+EADQ6Ks0VZgKYtft2zhrsgQdBSoaD3MI8OzFJ/4r6KjTqEsS4Jbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vcentertainment.com; dmarc=pass action=none
 header.from=vcentertainment.com; dkim=pass header.d=vcentertainment.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vcentertainment.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZ6QbK0Snyh+M2kehUmtUqfY6Fn+ncedqffpUfJKnVg=;
 b=K4VW/HKQ63FuxAigVa3avn85zQuMG2BnzsrwCFB40T60qL6cBUZLyOQ8mkzNw9upaGEy25wTK82IhGhe3Do9CgpRB1gyYKCcnmwaXjae9R3efvNSn8JAgSeg4RuhNURGW3/1nmRx6Zw82zJ9/5B+0bK45CZTXlzTWLJ0miwg1Q5jNGbHd8fhaz0hP9VTE3rhqyKEhAoPVpbuk6y0OIhEPdF43zSkangd4uPY15YHqYILJ/Drn9uDVr8Ql8nboyVzM7kfqz9D5lPvFAqJIYLSPz7fQ8tyDmQW8yg/VKAIDw+X8T93EVJ0OPLZwtbeKZ3zzHehW4HvQOtB3JZ/Lt/OKQ==
Received: from BY5PR14MB3654.namprd14.prod.outlook.com (2603:10b6:a03:1d6::20)
 by SN7PR14MB7023.namprd14.prod.outlook.com (2603:10b6:806:2e2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 21:55:36 +0000
Received: from BY5PR14MB3654.namprd14.prod.outlook.com
 ([fe80::de0e:df1f:c42e:3107]) by BY5PR14MB3654.namprd14.prod.outlook.com
 ([fe80::de0e:df1f:c42e:3107%2]) with mapi id 15.20.6387.033; Tue, 16 May 2023
 21:55:36 +0000
From:   "Tim Walter (Visual Concepts)" <twalter@vcentertainment.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: git hangs with --separate-git-dir
Thread-Topic: git hangs with --separate-git-dir
Thread-Index: AdmIHwP31fja9miBQ1mB5r1EdFLfegAHqcyAAABVG0A=
Date:   Tue, 16 May 2023 21:55:35 +0000
Message-ID: <BY5PR14MB36541924E1E6E5E912AFE0C2A5799@BY5PR14MB3654.namprd14.prod.outlook.com>
References: <BY5PR14MB36544D63ECEAB9954C14407FA5799@BY5PR14MB3654.namprd14.prod.outlook.com>
 <ZGP2AzYJSLpI4kGN@tapette.crustytoothpaste.net>
In-Reply-To: <ZGP2AzYJSLpI4kGN@tapette.crustytoothpaste.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR14MB3654:EE_|SN7PR14MB7023:EE_
x-ms-office365-filtering-correlation-id: 8921f8a2-8f32-43c1-6b20-08db5658478e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W5x4II0zp+z9ZBxw5gQvTxeZdyaMWMPHszMSSEFJrgXerZLWguObjUFVbldQX4tLuPwoWUJbepoTY1CgzgUIRJKPWUtl0xTPyt0pZRgoN5cdsTvCLkD8he+xv509HpWykz6srQSpdGy4G2FYreG3hxUp+BIY4MQ0RfgFx0sgB5HSeuIo+5E4eIchBGt+CXTKL5YRdwRDt2j/njBgjwQCAbx8O9a2jeMO85GvHYXb4eqUr0ENNdAHj34S2s7XQkDF/3U0E9MfQgOmhUVGUqxb3aJM0i0lZkUTcWnm5JJc9+V0W5V3Fqa4TLzdiR+Gz76EwYR0ZRUw8mzXUBDzXne2yb3mYWpPjwEUFPEQUMEsh50OcS5yuU0cYqKVDpjDLdS41RvaCkquct75fo1EBGsmSonJElsaBGS22m9TAVLhkczYzvgE2G1jYNqkNq+NGGFWfE42BuKyQFC718TbCqouRSDhzwlhxogb3vsYzsk0qv1/adjDZUssGL44Hy+7+AluiQa0k0qo4PSul3lBBHbGgsglZPvoc9xEQbaUpTHXU0aTESYPTZ95aKCIEEnBlSsD0KzE/HwreGAzRD4r5ufvj5Ex4gHhRYi4mpvlw/aB9psDACBZFCa3iSRqiYJoZuMxuBykiC5cjM6JC3+NX3M22A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR14MB3654.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(39860400002)(376002)(366004)(136003)(451199021)(2906002)(52536014)(41300700001)(7696005)(478600001)(5660300002)(66946007)(4326008)(6916009)(64756008)(66556008)(66476007)(66446008)(8936002)(76116006)(8676002)(316002)(71200400001)(53546011)(26005)(9686003)(6506007)(186003)(55016003)(66574015)(38070700005)(83380400001)(86362001)(122000001)(33656002)(38100700002)(460985005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWI2RjR4aUM5ZEZhczVrVUNRNkd6MmlkS0gwby82MmlwbDU3ZzYzdjl2ME16?=
 =?utf-8?B?Q09zd2RHVmZld2JOazl6MERScFdNdUVnS2t1SzR6MW9sV09HY0NBVDVxM2Y3?=
 =?utf-8?B?WFFLYTVESDZKbkF3bGQ5MnpBZTZLSWZ5dEdKYm4rd20yb0pCNjQ3NHlSdGd3?=
 =?utf-8?B?cFdTVHFYTE14QXVQZmdVNzcrN1JDVElrbmFhWEoxOWhSTm9Ca1Rvcy9tYlQ2?=
 =?utf-8?B?RDVJY1ZOS0twZFhXYVhiWCs4WEppQndxb0o3bWMrOHd6eXRtaFZxQnUvYnNl?=
 =?utf-8?B?REpnMGxpM1dJTCtLd0p4QWFEOWN0VjZzNDFKRkdWWGJhWXNiN25MTjdkczBq?=
 =?utf-8?B?dDg1WkdpZzdUM1UrNzdtR0dBZTNuWXpUc1B4T1NleVlOdUM0UVZKaEYzTnJJ?=
 =?utf-8?B?ZGhWWVlQUG9aTmFDb1FYUzY1SFFEUVhnWUlnRlh6bHdrZDRvVGgybmVZVmZw?=
 =?utf-8?B?K0kvbDJyV01udTNzZ1J4Y2tPQnBhRlFFQXgyTXlnQ1NvZnNSL2J5dWtCRTIz?=
 =?utf-8?B?UUJWdXR2OXUwa2x4OFhvZHp6ZlNhSEZwcHhCUzVvNE9FRlNUdXJQTWRBbnZT?=
 =?utf-8?B?UWY2R3RWblhLSXk4dXNZNnFsRWlPY0VPcTh4cXZ1UkR5U05QM1k3VTRJYzRM?=
 =?utf-8?B?ZHFwV09haUJWd0NiNytYUkNjRmtzUndNbzFEMkovbGh6QjMvVlQrRE1WeW5W?=
 =?utf-8?B?a25yNFBNV2NHdTlSQXExUDNSRFVhaElxVkFkeDRCRityVFRDTC9pTkZ3UXkx?=
 =?utf-8?B?eUt6NlBoWWRQSmczTitKZGRwQlpNZzZKQUw2b3FKUzRQUUFkTXU0bmNpRm5W?=
 =?utf-8?B?TlYrSUZmc1pjd0hTZFRlTlJxZzZ5YXNGNjg2RWRKT2ZKSU8xZVJmVVpSaVR1?=
 =?utf-8?B?KytRK0liMjQyeU5xNzhrNndpRHJ3c3lXRUhyWHMrNkJLb2ZPZ2dtMkdxMGtv?=
 =?utf-8?B?b1lGazJsTEJpaXJBWURDWU40WFdFN2JxaERxRzVCcE5UaERXRzYvT0tOWGJy?=
 =?utf-8?B?VXZjRk5jUUU3WmpQWkYzalBlV2dmZktnZjlzcW1LZ1QzY0hWUHhoTHlFK0d6?=
 =?utf-8?B?cjIxN3N0SDI1TURtZEpEa1l0NWpScm9TZVJub3ZBTWM5RGZ3eHVBbDExRDZL?=
 =?utf-8?B?RU5rcENjbTE2MWtwcWV3b25aZ3NJc1dQMDdSdVgvWWdISVpNTmw2UjAxanpG?=
 =?utf-8?B?dlpQQU1waDQzdXBBbkkyWlVXd0YwdTZOZ053T0hNdm9xWEwwR1NWbHJWT0V0?=
 =?utf-8?B?cGNPR2pRR1V0cU9rNWZPaEpjdHJHcXlEb0Z6YVBqdllaeWZFV2VJT3VLZ2R2?=
 =?utf-8?B?WTM2MVpHdVFFR1hvTEo5SDZ1cTM5bTBweEdPTERkRVowTFFPRVFJd0xoblNT?=
 =?utf-8?B?Z29TUE5kbkpXTEZPZHQ3T1VRSWc2Qjk2N0VWVWE2SEpEVHZTYmFpY1RXZFlm?=
 =?utf-8?B?NWNOejhpeks4cWtEeXBrVHBIN3pnaEhLSHpvb1dsSGpmNWp3dmZ6MUNkY2pQ?=
 =?utf-8?B?d2R3RGF2YXNEU1QvSW5wdDZJZUtNTW9Tb3FjRXV3QmdxNGRYUnN6eFphMTZq?=
 =?utf-8?B?VFZUeEkxKzB5S0ozOUlwc1FINWtlelZYY1FVQnBkNEEzWisvYzhEazRwdk8w?=
 =?utf-8?B?cnIrVllienljS3lGd2x5N1BIWHFOamRnMCs0Wjl3MlZGOFZlWmMrUmxLc0g4?=
 =?utf-8?B?anFKU1VVT2R4V2RzYXF5OWJsK2hSblVzVzFhSWo5b3g2dVd2dFE4N1dZTUNF?=
 =?utf-8?B?bjlPODlzb2dQbEdUVk8vaCtldGQ3SEI4VDFYbzI3NzlTdUNrOFgzQ3lmY0JF?=
 =?utf-8?B?QXNUSnhPaUZYS0RNRmlWbHFUVGp6bHJDL2N0WHRzQWRVc2R0Z3VINW1mUEdN?=
 =?utf-8?B?SUZnUzdXK3FKa3ZJb0VmR0Y0QUU2bEFTQmIrdWhSUjJ6RGNpWnJpUW4yQ2VL?=
 =?utf-8?B?TzJuMTk1RWJKcmVxdnEra1dFZWZ6R1ZXZUEyMlQrMmo1Q2V6SG1hL1E5MlFP?=
 =?utf-8?B?RlFMb1Fhcmc5akhyYTJ5c29EeEFuZkY3SGtabVlPSGhJdGw0dWRmdC9SWi80?=
 =?utf-8?B?cVJzeURwNXBCZi9MQjB4MVJlenpZZUlVTXYyajNJVmE5SEtQblhBc1hTRUov?=
 =?utf-8?B?U0NVNUZoZlZYcUNSbm9YUDlFdHVvcVNrZVM2b3F0Qm80TWxxRzc2Yis2T1Az?=
 =?utf-8?B?QWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Rs5qDICJtYwBWnkDbB3N8ChrjvawoxuczXum01qbclBm0X3SWxJEVvHbHUyULFPtzOv6sW2uQDuy6YgDym/rqLctIHqt7DNnlTegBZ3Q4hi/JVzNpMbWuj1B/T+t9j90PDIuRiRlXol3B8CmUbg0Vp1PDoBohsNeqJRvazJEF4gTjNwZ0+zFhJssD22QQG+9FEnpDXl02KW52c9rk1F4Ve6BQ9cp4PdulQyooa0sfpeb55US6KHKSoKGEyqnWGZubKkg7ZJlwXdQOmcM3kihakG6WxAJ0IaRpRjmcDY0DiwO9kAj93Y1OgEL0nlkB0zwU2tiqQJej5GFaze8TuXGc+VX///ZOT+a2BpCzB2/D59ZFiW7BqLc5E78MccrjLg71ZzGPvx1rBDTd5bN6Wd8/UzJ4Sl9Om1561T7VgptgDFg+iiCyNPHL53QZJRsix4SmSfzhUU8kWubARhs9iL5dCQ1ZzHtC3Fg1raBts/c47ykHlG/Y74ghxIwZZ8RMJ8jiy9cBXBMmEfSrKmmESAed++SqTOFxLRi8grv5p+eOVi8/8E2U6vfaqr6HF+e6krXpPZZadQdo9cPY10CEgfzJCi6iE1ixt6GkN81479m86DmvTz5KEpfOMhzn64aHQqdFL7g4p4qOJ9+5pESpWP3cqdIN3/6hjSpoE+RkrJAT/zhkAdXHtFXPbKsbI5bCgMNusIecL/4UXlo39cqQv4E0b8LrockUuo4wQVafnU1xgUln54Zjr0sDXLck+FhOtvzu8NwRE9VceJaXWZDtkyeCvVzk2OFAvjdd2Iz0KDhZpHyUfYj2pEoYhFtpzjh8Y9X9PolwBG3twvMdcIrHfH45Q==
X-OriginatorOrg: vcentertainment.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR14MB3654.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8921f8a2-8f32-43c1-6b20-08db5658478e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2023 21:55:36.0145
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d91c4a20-dda6-49ce-ab69-53dee8b047a5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z5j2R6WhHxyI3HgHKgYbHeSHr5CjdcnpwlHGWwtDUQOPunrx4YS3ymvutlu5L05MWjpfMwn5MznWp7o98BH46evSrtZKMXQ4wPxw8EgaITQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR14MB7023
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_12,2023-05-16_01,2023-02-09_01
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

LS0tVEFXIHJlcGxpZXMgYmVsb3ctLS0NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZy
b206IGJyaWFuIG0uIGNhcmxzb24gPHNhbmRhbHNAY3J1c3R5dG9vdGhwYXN0ZS5uZXQ+IA0KU2Vu
dDogVHVlc2RheSwgTWF5IDE2LCAyMDIzIDI6MzEgUE0NClRvOiBUaW0gV2FsdGVyIChWaXN1YWwg
Q29uY2VwdHMpIDx0d2FsdGVyQHZjZW50ZXJ0YWlubWVudC5jb20+DQpDYzogZ2l0QHZnZXIua2Vy
bmVsLm9yZw0KU3ViamVjdDogUmU6IGdpdCBoYW5ncyB3aXRoIC0tc2VwYXJhdGUtZ2l0LWRpcg0K
DQpPbiAyMDIzLTA1LTE2IGF0IDE3OjU0OjQxLCBUaW0gV2FsdGVyIChWaXN1YWwgQ29uY2VwdHMp
IHdyb3RlOg0KPiBXaW5kb3dzIDEwIFBDDQo+IGxhcmdlIHByb2plY3QNCj4gMzAwR0INCj4gNTAw
LDAwMCBmaWxlcw0KPiBtaXggb2YgYmluYXJ5IGFuZCB0ZXh0IGFzc2V0cy4NCj4gDQo+IGNkIC9k
IEQ6XG15cHJvamVjdA0KPiBnaXQgaW5pdCAtLXNlcGFyYXRlLWdpdC1kaXI9RjpcbXlwcm9qZWN0
LmdpdA0KPiBnaXQgYWRkICoNCj4gDQo+IEdpdCBydW5zIGZvciBhIGxpdHRsZSB3aGlsZSB0aGVu
IGhhbmdzIGFuZCBkb2VzIHNvbWUgcmVhbGx5IGJhZCB0aGluZ3MgdG8gdGhlIE9TIGFzIHdlbGwu
DQo+IGl0IHNlZW1zIGltcG9zc2libGUgdG8ga2lsbCBnaXQuZXhlIGV2ZW4gd2l0aCBhZG1pbmlz
dHJhdG9yIHByaXZpbGVkZ2VzLg0KPiBmOiBkcml2ZSBlbmRzIHVwIGxvY2tlZCBhbmQgYW55IG90
aGVyIHByb2Nlc3MsIHN1Y2ggYXMgZXhwbG9yZXIgdGhhdCANCj4gdHJ5IHRvIGxvb2sgYXQgaXQg
YWxzbyBoYW5nIHlvdSBjYW5ub3QgbG9nIG91dCB3aXRob3V0IGhhbmdpbmcgb3IgZXZlbiANCj4g
cmVzdGFydCBUaGlzIHRoZW4gcmVxdWlyZXMgYSBoYXJkIHBvd2VyIGN5Y2xlIHRvIGZpeC4NCj4N
Cj4gMTAwJSByZXByb2R1Y2FibGUuDQo+IA0KPiBydW5uaW5nIGdpdCBpbml0IHdpdGhvdXTCoC0t
c2VwYXJhdGUtZ2l0LWRpciBhbmQgZ2l0IGFkZCAqIHdvcmtzIGZpbmUgDQo+ICh0YWtlcyAzIGhv
dXJzLC4uIGJ1dCB3b3JrcykgdGhlbiBJIGNhbiBtb3ZlIHRoZSAuZ2l0IGRpciB0byBmOiBhbmQg
cmVpbml0IHdpdGjCoC0tc2VwYXJhdGUtZ2l0LWRpciBhbmQgdGhhdCB3b3Jrcy4NCj4gU28gdGhp
cyBzZWVtcyB0byBvbmx5IGJlIGEgcHJvYmxlbSBmb3IgdGhlIGluaXRpYWwgaW5pdC4NCg0KSSBk
b24ndCB1c2UgV2luZG93cyBzbyBJIGNhbid0IHZlcmlmeSB0aGlzLCBidXQgSSB3b3VsZCBub3Qg
ZXhwZWN0IHRoaXMgcHJvYmxlbSB0byBvY2N1ci4gIEV2ZW4gaGFzaGluZyA1MDAsMDAwIGZpbGVz
IGNvbnN1bWluZyAzMDAgR0Igc2hvdWxkIG5vdCBoYW5nIHRoZSBjb21wdXRlciBvciB0YWtlIDMg
aG91cnMuDQoNCldoYXQga2luZCBvZiBkaXNrIGlzIEY6PyAgSXMgaXQgYW4gZXh0ZXJuYWwgZGlz
ayAoVVNCIG9yIHN1Y2gsIGFuZCBpZiBzbywgd2hhdCBzcGVlZCBhbmQga2luZCk/ICBJcyBpdCBh
IG5ldHdvcmsgZHJpdmU/ICBJcyBpdCBhbm90aGVyIGxvY2FsIGRpc2sgaW4gdGhlIGNvbXB1dGVy
IChTU0Qgb3IgSEREKT8NCg0KQXJlIHlvdSB1c2luZyBhbiBhbnRpdmlydXMgb3IgZmlyZXdhbGwg
b3RoZXIgdGhhbiB0aGUgZGVmYXVsdCwgb3IgYW55IHNvcnQgb2Ygb3RoZXIgbW9uaXRvcmluZyBz
b2Z0d2FyZT8gIFdoYXQgSSBzdXNwZWN0IGlzIGhhcHBlbmluZyBoZXJlIGlzIHRoYXQgeW91IGhh
dmUgYW4gYW50aXZpcnVzIGludGVyY2VwdGluZyBHaXQncyBvcGVyYXRpb25zIGFuZCBzY2Fubmlu
ZyB0aGUgZmlsZXMgZm9yIHZpcnVzZXMsIG1ha2luZyBldmVyeXRoaW5nIHJlYWxseSBzbG93LCBh
bmQgdGhlbiBhdCBzb21lIHBvaW50IGEgYnVnIG9jY3VycyBpbiB0aGUgYW50aXZpcnVzICh3aGlj
aCBtYXkgaGF2ZSBhIGtlcm5lbCBkcml2ZXIpIGFuZCB0aGVuIHRoaW5ncyBoYW5nLiAgVGhpcyBp
cyBwcm9iYWJseSBtYWRlIHdvcnNlIGlmIEY6IGlzIGFuIGV4dGVybmFsIGRyaXZlIG9yIG5ldHdv
cmsgZHJpdmUuDQoNCklmIHlvdSBhcmUsIGNhbiB5b3UgdHJ5IHRvIGNvbXBsZXRlbHkgdW5pbnN0
YWxsIHRoYXQgc29mdHdhcmUgYW5kIHJlYm9vdCwgYW5kIHRoZW4gdHJ5IGFnYWluPw0KLS0NCmJy
aWFuIG0uIGNhcmxzb24gKGhlL2hpbSBvciB0aGV5L3RoZW0pDQpUb3JvbnRvLCBPbnRhcmlvLCBD
QQ0KDQotLS1UQVctLS0gaXQncyBTU0QsIGFjdHVhbGx5IE5WbWUsIGFuZCB0aGUgUEMgaXMgMTI4
R0IgcmFtIDY0IGNvcmUgdmVyeSBmYXN0Lg0KLS0tVEFXLS0tIEJvdGggZHJpdmVzIGFyZSBsb2Nh
bCBTU0QgZHJpdmVzLCB0aGUgd29ya2luZyBkaXJlY3Rvcnkgb24gRDogYW5kIHRoZSByZXBvIG9u
IEY6Lg0KLS0tVEFXLS0tIHRoZSAzIGhvdXIgdGhpbmcgaXMgbm90IGEgcHJvYmxlbSBhcyBzdWNo
ICAoaXQncyBhIGxpdHRsZSBmcnVzdHJhdGluZyB0aGF0IGdpdCBpcyBzaW5nbGUgdGhyZWFkZWQs
IGJ1dCByZWdhcmRsZXNzLCB0aGlzIGlzIG5vdCB0aGUgaXNzdWUgSSBhbSBjb25jZXJuZWQgd2l0
aCkNCiAtLS1UQVctLS0gaXQncyBvbmx5IDMgaG91cnMgb25jZSwgb24gdGhlIHZlcnkgZmlyc3Qg
Z2l0IGFkZCB3aGVuIEkgY3JlYXRlIHRoZSByZXBvDQotLS1UQVctLS0gSSBjYW4gbGl2ZSB3aXRo
IHRoYXQsIEkgd2FzIGp1c3QgZ2l2aW5nIGNvbnRleHQuDQotLS1UQVctLS0NCi0tLVRBVy0tLSBU
aGUgcmVhbCBpc3N1ZSBpcyB0aGF0IGl0IGRvZXMgYSAidmVyeSBiYWQgaGFuZyBhbmQgbWVzcyB1
cCBvZiB0aGUgT1MiIGlmIHRoZSByZXBvIGlzIHNlcGFyYXRlIGZyb20gdGhlIHdvcmtpbmcgZGly
ZWN0b3J5Lg0KLS0tVEFXLS0tIEluIG15IGNhc2UgaXQgaGFwcGVucyB0byBiZSBhIHNlcGFyYXRl
IGRyaXZlLCBub3Qgc3VyZSBpZiB0aGF0IGlzIHJlbGV2YW50LCBJIGRpZG4ndCB0cnkgYSBzZXBh
cmF0ZSBmb2xkZXIgb24gdGhlIHNhbWUgZHJpdmUuDQotLS1UQVctLS0NCi0tLVRBVy0tLSBUaGVy
ZSdzIGFudGktdmlydXMgKFNlbnRpbmVsT25lKSBidXQgd2UncmUgdmVyeSBmYW1pbGlhciB3aXRo
IGhvdyB0aGF0IHdvcmtzLCBJIGRvbid0IHRoaW5rIHRoYXQgaXMgdGhlIGlzc3VlLCBhbmQgb24t
ZGVtYW5kIHNjYW5uaW5nIGlzIGRpc2FibGVkIGFueXdheS4NCi0tLVRBVy0tLSBubyBmaXJld2Fs
bCBsb2NhbGx5LCBvdXIgbmV0d29yayBvYnZpb3VzbHkgaGFzIGZpcmV3YWxsIGZvciB0aGUgZW50
aXJlIGNvbXBhbnkgbmV0d29yaywgYnV0IHRoZSB3b3Jrc3RhdGlvbnMgZG9uJ3QgaGF2ZSBpbmRp
dmlkdWFsIGZpcmV3YWxsIGVuYWJsZWQuDQotLS1UQVctLS0gQWdhaW4sIEknbSBub3QgY29tcGxh
aW5pbmcgYWJvdXQgdGhlIHNwZWVkLCAodGhhdCB3YXMganVzdCBmb3IgY29udGV4dCwgYW5kIGNh
biBiZSBkaXNjdXNzZWQgYXMgYSBzZXBhcmF0ZSBpc3N1ZSBpZiBuZWVkZWQpDQotLS1UQVctLS0g
aXQncyB0aGUgaGFuZyBhbmQgYnJlYWsgdGhlIE9TIGluIGEgcmVhbGx5IG5hc3R5IHdheSB0aGF0
IEkgYW0gY29uY2VybmVkIHdpdGguDQotLS1UQVctLS0NCi0tLVRBVy0tLSBJdCdzIG5vdCBwb3Nz
aWJsZSB0byB1bmluc3RhbGwgdGhlIGFudGktdmlydXMgU1csIGNvbXBhbnkgcG9saWN5IGFuZCBJ
IGRvbid0IGhhdmUgcGVybWlzc2lvbnMgZm9yIHRoYXQgbGV2ZWwgb2YgY29uZmlndXJhdGlvbi4N
Ci0tLVRBVy0tLSBPdXIgY3VycmVudCBzb2x1dGlvbiAocGVyZm9yY2UpIG1hbmFnZXMgdGhlIHNh
bWUgc291cmNlIGZpbGVzIGFuZCBkb2VzIG5vdCBoYXZlIGFueSBpbnRlcmFjdGlvbiB3aXRoIHRo
ZSBhbnRpLXZpcnVzDQotLS1UQVctLS1XZSdyZSBjYXJlZnVsIHRvIHRlbGwgdGhlIGFudGktdmly
dXMgdG8gaWdub3JlIGNlcnRhaW4gZm9sZGVycywgYW5kIG5vdCB0byBkbyBvbi1kZW1hbmQgc2Nh
bm5pbmcgb24gdGhvc2UgZHJpdmVzIGFueXdheS4NCi0tLVRBVy0tLSBUaGF0J3Mgb25lIG9mIHRo
ZSByZWFzb25zIHdlIGhhdmUgc2VwYXJhdGUgZHJpdmVzIChjOiBpcyBwcm90ZWN0ZWQgYSBsb3Qg
bW9yZSB0aGFuIGQ6IHdoaWNoIGlzIGp1c3QgdGhlICJ3b3JrIGZvbGRlcnMiIGZvciBleGFtcGxl
Lg0KLS0tVEFXLS0tDQotLS1UQVctLS0gSSBleHBlY3RlZCB0aGF0IG90aGVyIHBlb3BsZSB3b3Vs
ZCBoYXZlIGhhZCB0aGlzIGlzc3VlIGFscmVhZHksIGJ1dCBpdCBzb3VuZHMgbGlrZSB5b3UndmUg
bmV2ZXIgaGVhcmQgb2YgaXQsIHNvIG1heWJlIHNvbWV0aGluZyBvZGQNCi0tLVRBVy0tLSBhYm91
dCBvdXIgcGFydGljdWxhciBjb25maWd1cmF0aW9uPyBCdXQgSSBkb24ndCBrbm93IHdoYXQsIGV4
Y2VwdCB0aGF0Og0KLS0tVEFXLS0tICA6IGl0J3MgYSBsYXJnZSBwcm9qZWN0DQotLS1UQVctLS0g
IDogIGl0IGNvbnRhaW5zIGJpbmFyeSBhcyB3ZWxsIGFzIHRleHQgZmlsZXMNCi0tLVRBVy0tLSAg
OiBJIGFtIHRyeWluZyB0byB1c2UgMiBkaWZmZXJlbnQgbG9jYWwgZHJpdmVzDQotLS1UQVctLS0g
IDogSSBhbSB1c2luZyB3aW5kb3dzLCBzb3JyeSBjYW4ndCBoZWxwIHRoYXQsIHdlIGFyZSBmb3Jj
ZWQgdG8gZGV2ZWxvcCB1c2luZyB3aW5kb3dzIHRvb2xzLg0KDQo=
