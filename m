Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305D1CA0FE1
	for <git@archiver.kernel.org>; Fri,  1 Sep 2023 12:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242850AbjIAM2t (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Sep 2023 08:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjIAM2t (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Sep 2023 08:28:49 -0400
Received: from mx0b-00233801.pphosted.com (mx0b-00233801.pphosted.com [148.163.158.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061A9CFE
        for <git@vger.kernel.org>; Fri,  1 Sep 2023 05:28:45 -0700 (PDT)
Received: from pps.filterd (m0098967.ppops.net [127.0.0.1])
        by mx0b-00233801.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3818qUVo014672
        for <git@vger.kernel.org>; Fri, 1 Sep 2023 08:28:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=multiplan.com; h=from : to :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=s1024; bh=wH271lUM7ZHusSKynbpITL3LdPHb3PyWGPygeOVOn7o=;
 b=B4PPez87V4V2WaM0TQ0zhqQOvs/foC7Uv1PSdMYo6hnFx3Y2QT15Ych5gKR8eJcNwpPn
 Ul6gaxP0VFxcfimkm+KC+ljKJWnQ90vSJMRIjsErrMm+HOK/K3erp84oz1yytfMftNIQ
 2oXGElaW/1uc0UdJs4eKt70gsydWGjfXW0CFC1zrE8yD2O0TumV/J4oHPl2kN88yQMsg
 Kmwb1zVUTtwN/r1YpWHka9ETHIucU3w6F3R3KDjc5IKNMy0U42DNqliLIdQ40cldN5ah
 KPLkwvmd7E2GjppQLa31e6/xCaCDQIdlnpT/5Ak7zM6Oj8u+6rmbG9Z2rXMj5EcwT/nH yA== 
Received: from mul10003.zixworks.com (mul10003.zixworks.com [74.203.185.29])
        by mx0b-00233801.pphosted.com (PPS) with ESMTPS id 3stu6fugh4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <git@vger.kernel.org>; Fri, 01 Sep 2023 08:28:45 -0400
Received: from 127.0.0.1 (ZixVPM [127.0.0.1])
        by Outbound.mul10003.zixworks.com (Proprietary) with SMTP id 40FF91B9A75
        for <git@vger.kernel.org>; Fri,  1 Sep 2023 07:29:04 -0500 (CDT)
Received: from cl1-vmcrpmsg03.multiplan.com (unknown [208.78.22.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mul10003.zixworks.com (Proprietary) with ESMTPS id 7AD9F4193324
        for <git@vger.kernel.org>; Fri,  1 Sep 2023 07:29:03 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MtiX44aL0WaA+zFx9njmNpYQQzTtkCd5tqUxs9nXaJVIcTLOhaE99qrfJpU1wp03fAH8ZDyjco8m4grgSnQf3rYUo2PwFOOYdfMbjVu+6jZK0CeJgO19zkChR9D2ucFZbZkxzCm/q50lEfAtNWZAlaFK/tbH8FBXlGlxjt6QouBp4qrHV3YXazQDfNMRLuQyPs/reFFWSjPvLIyLgXUq39ikisKuzjb0uwetID+5h1sX//OLDMeSotx7z2LFgXVcXtf9nNV8+jkki0xNV5hG/O+ski8+sRGOEA1upiL4ghfFQehXGLfP+bUwuVjxb2E6HoXNUPvN/1fRyD+ese+6dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fWQWNwlhj8CyVXoV0/tOx+daum/5PM+UDMVe0jfQnP4=;
 b=bLH3peMq9Ww9IvgYs50BAAQx134yV/0NgBrE7FbN0tiKzrF+ISEf/rub5v34d0CQaz9XkbqRdNiNdbkM+hxNVtunW+2cD/YJtOq2dPfZYcBluP/4Ahit4zPr7ypv4aDMRJLNhUKhUeNYL9jacucFZcwhRjVjaoJaGuOW1TMqgQ0Ey/ZLM/4Q3CPMWQCkzv7ZsXwmcpGGu9GhIYFVz1aVL6gHXJ5byqKTYUsodAvJvRb66CCOpn2zRLyFlvbutCNjPvghiYi3D8Pnf31+e6RdtHpDjBZtMoVUIFCgvk+rQJmCxhgU9rmUad4Feo9TpM4O3AYUProEoaYo9eVNgBZ/1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multiplan.com; dmarc=pass action=none
 header.from=multiplan.com; dkim=pass header.d=multiplan.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=multiplaninc.onmicrosoft.com; s=selector1-multiplaninc-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fWQWNwlhj8CyVXoV0/tOx+daum/5PM+UDMVe0jfQnP4=;
 b=AQklH2Vxkp7xTbuF4zkghtuAN2CrJORCRY5n28YiRp0xfolpZUXqFjlJrEuEeUgvjuKHPXakotVkNWLKhBn7bdCz4G63Y2FVqyCG8W1jpZW00hXe5UPgHOC2hd9PZquCXM4J1frMSBeOI5pZq/R0MLTwumSb1F6hGYifA5tTF3w=
From:   "Chamberlain, Anthony" <anthony.chamberlain@MultiPlan.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: move from gitscm to github with Eclipse
Thread-Topic: move from gitscm to github with Eclipse
Thread-Index: Adncz79JxPhRtPkgRf++Ge3mWBAicA==
Date:   Fri, 1 Sep 2023 12:28:39 +0000
Message-ID: <BL1PR11MB5526B555A6425FB14D1EBDF7F2E4A@BL1PR11MB5526.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYW50aG9ueS5jaGFtYmVybGFpbi5udGRvbWFpblxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjllMzViXG1zZ3NcbXNnLTEzMzQ2ZWFiLTQ4YzMtMTFlZS05MWQxLTAwMjQ5YjYxYjJiN1xhbWUtdGVzdFwxMzM0NmVhZC00OGMzLTExZWUtOTFkMS0wMDI0OWI2MWIyYjdib2R5LnR4dCIgc3o9IjEzMjAiIHQ9IjEzMzM4MDQ0OTE4MzQyOTk5MiIgaD0iczYydnVaWVJsdk9zL29HK1F4QytLeDVwTE9NPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5526:EE_|DS7PR11MB6078:EE_
x-ms-office365-filtering-correlation-id: d6a4997f-1f84-44dc-ae02-08dbaae6f900
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2tEkYkyj006ssut6bLgVT45oWaCosrEKV6E2uoVGz2A5eV5plfEtzra13YvKXJQlB0fMO0fiefeJvnu/JNZTMT7OFkngFcpu4D5fN48lgzgmOAACiKgAkNrWnwimSo0j5NYXUtg60shOWtZ198N8ysZK7RvBzOvuIlP9KVOch4rBy0Bl52u3IgwyOMaCyfeZwqX7djBtSq2y0FaJOZzn/so590FiQD6jSfRPYDdx3EIVVCRlK2JtkbfTEfYh1o0vmQ/ME2roKcW40MaH5bwsoTIFeXq5CLn20YBtBdzNG5sVbUVdVK0yvbrF/TXGLpjSXwMnwUCzT2X/Nvx6sh37sqjNIQ/Y8k6FcC8K/61uHCwcOgxu1AqBkrVIXUWwvA2acVmM2IN1Tp9sWc1RXKOsK10yU+LwoB2nBsB5ZzOEJh2yqvQbEMOj9AlEFGZvRlh/d0bZwizwyeH7ffhvHpW7qywHDKXEwN/kkIgQu62hTRbVfjQfCLdNCvZfRl4C02ZclMaU29e9uK96c8ffHac2lCs3calV5emMBJayfm6UwDibpLyQEygjI29WPYkqm+sxXTvn2baGMPC/sOkYrqQB3zjfnG6YyqmadC2G/fLpI0Ru3fsOnjI94m3qUL1lQqipQJm7DMLfgFy1KgDtEWGvng==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5526.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39850400004)(366004)(376002)(136003)(396003)(1800799009)(186009)(451199024)(6506007)(7696005)(9686003)(71200400001)(83380400001)(122000001)(33656002)(86362001)(38070700005)(38100700002)(26005)(55016003)(52536014)(41300700001)(4744005)(2906002)(76116006)(66446008)(66476007)(66556008)(66946007)(64756008)(8676002)(8936002)(6916009)(316002)(478600001)(5660300002)(85282002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ynAOK6WLb9sBpUOFk5kZsEFp670H9/kDJnzilMtl586YY6uQxBslyo2ZmL0U?=
 =?us-ascii?Q?VhUkNhLaA5cIMnQCqQXv+1FCgjq00DZpDo1LD9VOUOUPUSJYLbFqgu+j1aDo?=
 =?us-ascii?Q?S2EhBmjU8CIEGABJKv1y5RwWuKNS3eFVtNtKy/czeo8sAXy55nujdudVxvRL?=
 =?us-ascii?Q?Kif3EknYVbMWRB5U6JSvnqKXL/fxqVyjrX/fb/y24E8brfNMRI57oIclXLey?=
 =?us-ascii?Q?Zre+FMLM9OCXoeNO5nUjiEzThvyjWSJVAN/AE5e1Hevy80q2GR1Yb7xSsHfV?=
 =?us-ascii?Q?BWj+CfCcbbBDqsNewjwaQvQlUwnRrqtMyxVOzYpnjHCChR/b3Dy2LmmnzR6B?=
 =?us-ascii?Q?JzSOY/ARXcr94iu2NX0V/8TcCVZ1QLsvvu6MnzmhnNVyFf0zPilqKMQLjjpm?=
 =?us-ascii?Q?e2nLtYpZnpJHLCi5eioB8vdzwvkgLZE9Zs1j5H0WvjK1YquC1F6rERZUo0ko?=
 =?us-ascii?Q?lgVDm2mG/VlobGCybXJuanxa8bFYa2GXr57CO+6LidxaFCrsbfBrSOHKofIQ?=
 =?us-ascii?Q?2NMuprjyVFkG5j49+I1Fbyx6f5lJRrvQQq8p1ov40kwAaNuCTF7fwbptgT68?=
 =?us-ascii?Q?MB0HtqG5wUZcX9q23es8pyh3dQIY+xRrNZOa17MxIl8RAiWIMLgmEAnIj3NO?=
 =?us-ascii?Q?Oq7Pv+9kFkK+IkYpym91lRMtZhh6aiKGm13GLuo8LbCTh4fhyR3X1S7pyh7a?=
 =?us-ascii?Q?o34uKpkX5AeedWigAEjMK2boKoBW8VF/+G9fkuCmgAyq8UKmZ3hLjj2edeTU?=
 =?us-ascii?Q?nabRPxsChkn6xtlmFDBK18VPAmn1Fm8tO2BamainxDs55cUcmA8HNdQrIcK/?=
 =?us-ascii?Q?k3/gzqife/skdWwFnTbUnRKyI9bF6gkPDD+GQAvdI2FOPQ0BwHIybgaJt4PV?=
 =?us-ascii?Q?vJXfjb23ivwHQfe6PMBXdm5/U1+3bLDkjYWFQZi60wMRUJtQWvorvEfyF7bP?=
 =?us-ascii?Q?NpuITNpGe9gb2Tub9+Xo9qmfNwSFZ0tE0xClG/dzpXIqjaLX72n/1QbMbY9C?=
 =?us-ascii?Q?Y4+tewSCyVgjIMi8lmov0pHD+/pwIzcPxOLrTE+ugm4XOdCyB0Gtylq/eTXn?=
 =?us-ascii?Q?NKTeUN6QXrTkCSU1sxF5tIVaYmZ9QmMqGtzlJCULzBPcXdqGNvJxYXL6A1mq?=
 =?us-ascii?Q?0zAVxbGGFL7wBmEcCph17Yvj62tuW1eThCeR5VfTq8wUPCcWmB5cwMKiMxCb?=
 =?us-ascii?Q?YtQ61FCO3ff7uw/Lg6M1gNNzieAB+Xpo49XD7s6acFXl88U7C3/BgTmEJ0zq?=
 =?us-ascii?Q?3IOj15rqGjJXdT4pBMOKndE4V280YU8n6Ai7w1/p2zBbzqyBvTywfQq7hXfj?=
 =?us-ascii?Q?+akd8EN1kg9vYuA6JU6h2aQFbFYIKgJyF92jIVURIEzFJRNYve2j1deGbmUP?=
 =?us-ascii?Q?UJtvae2nY+VkA4FQjbL3Pr9NUVEm0apeu+gujEMPpUaIj8HmD2HCJ+0uyR4Y?=
 =?us-ascii?Q?Ddf3QPzR0NDZxJ1QFW6HRMSGbpajVDHojp1OHVbn9x+dcsW6BRCk45Er6uNT?=
 =?us-ascii?Q?sC8CvZJfZCFpxIunqMaaLjILvzphbiPHfCq83vXcvu/zldxIMmbo2NTPQSa0?=
 =?us-ascii?Q?go2q7NBJXON9qVXiSikOF3MDMG/ub3/8elZwjWXcEcjZX+48LjSseg2pkEod?=
 =?us-ascii?Q?0oFegCtp/sH0cgOq83/OuMo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5526.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6a4997f-1f84-44dc-ae02-08dbaae6f900
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2023 12:28:39.9266
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9ac5f514-5b51-45e2-9a69-8bb6c5d51f6d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6rZCM0IGsKg0IDxCYeK94lWkrJ3FMSAuMGzzVZLv/KW3PifR/wULDircv6epdGrnWZYWgQrIf/6yhrFyJ1sQ9NUrRg4PbvSiCjVCAkLlspHv9hq8tnsrEIdrMgyy68An
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6078
X-OriginatorOrg: multiplan.com
X-VPM-MSG-ID: 03aeb9f2-b712-40d6-9809-e622baaa9463
X-VPM-HOST: vmvpm02.mul10003.zixworks.com
X-VPM-GROUP-ID: ba325abc-a2a4-4ea1-861a-b136f5b24601
X-VPM-ENC-REGIME: Plaintext
X-VPM-IS-HYBRID: 0
X-Proofpoint-GUID: I9EroIXQoSgjU3UO0XIQyY1p8_G1mVf7
X-Proofpoint-ORIG-GUID: I9EroIXQoSgjU3UO0XIQyY1p8_G1mVf7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-01_10,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309010116
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

I am currently using gitscm.  I have Eclipse with many git workspaces.  =
Several years ago I made the gitscm token and things work fine.
Now with switching to github this will be done gradually, so some projects =
will be github and some still gitscm.  I made my github token.
Now if in my Eclipse I fill out the login, password, etc., and check =
=22Store in Secure Store=22 will this remove the login and password=20
I am currently using?  Or will it keep two separate values depending on =
the base URL, or what will happen?

PS: I cannot insert the picture or it will think it is spam


NOTICE OF CONFIDENTIALITY: Information included in and/or attached to this =
transmission may be confidential. This transmission is intended for the =
addressee(s) only. Any unauthorized disclosure, reproduction, or =
distribution of and /or any unauthorized action taken in reliance on the =
information in this transmission is prohibited. If you believe that you =
received this transmission in error, please notify the sender by reply =
transmission and destroy the transmission without copying or disclosing =
it. We may also need to contact you for additional information as required =
by HIPAA or state law.

For questions about your privacy choices, please view our privacy policy =
on our website at: https://www.multiplan.us/ccpa/ .=

