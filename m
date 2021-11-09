Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 547E1C433F5
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 17:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31C6161038
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 17:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240402AbhKIR0F (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 12:26:05 -0500
Received: from smtppost.atos.net ([193.56.114.177]:17134 "EHLO
        smarthost4.atos.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S238350AbhKIR0E (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 12:26:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=atos.net; i=@atos.net; q=dns/txt; s=mail;
  t=1636478598; x=1668014598;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NTJI6mJn92RJTs55b7XN/3oGOzKGd5xZVQgnD0HDr1o=;
  b=ABASVhoFt0McQKnTKYKVBeafV5ZU6p1jGGDw+aXta5DGAfw50Gt8LrWD
   Q9lglhjfBqPSECDjVOyETpLyLqQ3Xk9xBA8cSkA3ENfFzCQvaWwoCH3zp
   LAJRmfjhTRMtIub1qTkeZW3qn8u5rRpCDKYlcPuRLzpjOVUDkMQsHDi02
   0=;
X-IronPort-AV: E=Sophos;i="5.87,220,1631570400"; 
   d="scan'208";a="290321656"
X-MGA-submission: =?us-ascii?q?MDFBZpmDMCD1W4e2Qcsh09C92Rlq7pF2I+XjAP?=
 =?us-ascii?q?YCLCpDWWLKCXWiMnI2L+pq4kbIUhnWOfzptjt4nntZDcEH2St7h4R1kb?=
 =?us-ascii?q?Wx+Y77LTRHO70Vt6cJ7tytm+5JL2H7il3JObh6OHSjjQiY5rIsgZ2/MZ?=
 =?us-ascii?q?2U?=
Received: from mail.sis.atos.net (HELO GITEXCPRDMB24.ww931.my-it-solutions.net) ([10.89.29.134])
  by smarthost4.atos.net with ESMTP/TLS/AES256-GCM-SHA384; 09 Nov 2021 18:23:14 +0100
Received: from GITEXCPRDMB21.ww931.my-it-solutions.net (10.89.29.131) by
 GITEXCPRDMB24.ww931.my-it-solutions.net (10.89.29.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Tue, 9 Nov 2021 18:23:14 +0100
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (172.16.214.169)
 by GITEXCPRDMB21.ww931.my-it-solutions.net (10.89.29.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15 via Frontend Transport; Tue, 9 Nov 2021 18:23:14 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cA76rT2QF+3LetcN0v85EIakGet9s7/5VJHythFlNrxFC1r24CdGaezzH8ubK5NI7+gyT2tXoT2m1UM3+za37rzlJJyHf1enmh+DG3su79+DqCWbCpkrxFCo9j4gMyGLO3miYlEpZQPQgOT0VRo5Mm165h6bbEXwJEOEgogmpHRClzEC7MGtK6FeRQLPlITW/VvwOHKUCi8IzAJkNdb+cDOm48DCQT0KaOc4ITsYvwUfUNGHKC+8vcHeXNFlJJTCv4aEXgC2sYThKEXEbNHGnTpZbG0+w7eaFEtruauLHyJGTFCmyORFBZo4eL8rGP+VINUE/+ixSQns+p5OA0hotQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NTJI6mJn92RJTs55b7XN/3oGOzKGd5xZVQgnD0HDr1o=;
 b=Yf1DteqJv3GRjszIP2rCd8SNTqmwtOFcdNKbwE8muV8vcBYlU2loefK2eiQv0cWgLbXRzGBw43B/z4rNEtyI3UdqHFUr5IecP8CrOkltgmRiKOn8N3hS0M18a99qZ4rfy86GgzpbDJH/3DJNJtGX0cpk99BhygQl3d/KC0gxqIvsO2a5YPjLGNHBAPYSh+pTU9dsmK1j5gS4Dcw+Khx+m8s3evc4uQnbUuzXoO+4wEevW1GSSjNTs1WTBFS7oZKVl/Efm1ekxxWAZArNkYNi+dcwVvKD7X/wy9ozf2wTSs1SJ0ySXR6z3tBms/5Din0Mfw3sRfaXdyO2ZhOkxY9RlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atos.net; dmarc=pass action=none header.from=atos.net;
 dkim=pass header.d=atos.net; arc=none
Received: from AS8PR02MB7302.eurprd02.prod.outlook.com (2603:10a6:20b:3f8::19)
 by AM7PR02MB6049.eurprd02.prod.outlook.com (2603:10a6:20b:1ac::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15; Tue, 9 Nov
 2021 17:23:12 +0000
Received: from AS8PR02MB7302.eurprd02.prod.outlook.com
 ([fe80::71a4:9afa:1133:bc63]) by AS8PR02MB7302.eurprd02.prod.outlook.com
 ([fe80::71a4:9afa:1133:bc63%3]) with mapi id 15.20.4649.019; Tue, 9 Nov 2021
 17:23:12 +0000
From:   "Kerry, Richard" <richard.kerry@atos.net>
To:     Junio C Hamano <gitster@pobox.com>
CC:     Adam Dinwoodie <adam@dinwoodie.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Fabian Stelzer <fs@gigacodes.de>
Subject: RE: [PATCH v2] t/lib-git.sh: fix ACL-related permissions failure
Thread-Topic: [PATCH v2] t/lib-git.sh: fix ACL-related permissions failure
Thread-Index: AQHX0nvORR0vjem5O02kOU0OiGV1bav1bGlCgAQGCmCAAJJwMIAA61Gw
Date:   Tue, 9 Nov 2021 17:23:12 +0000
Message-ID: <AS8PR02MB73028E498D0AB831FE8028E89C929@AS8PR02MB7302.eurprd02.prod.outlook.com>
References: <20211104192533.2520-1-adam@dinwoodie.org>
        <20211105193106.3195-1-adam@dinwoodie.org>
        <xmqqk0hmwc0c.fsf@gitster.g>
        <AS8PR02MB730266C2B87493F2AF712D989C919@AS8PR02MB7302.eurprd02.prod.outlook.com>
 <xmqqbl2uv4ri.fsf@gitster.g>
In-Reply-To: <xmqqbl2uv4ri.fsf@gitster.g>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Enabled=true;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_SetDate=2021-11-09T17:23:09Z;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Method=Standard;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Name=All Employees_2;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_SiteId=33440fc6-b7c7-412c-bb73-0e70b0198d5a;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_ActionId=fc599076-8756-40a2-ba4e-75f490629578;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_ContentBits=0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atos.net;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e63e89c0-4cb0-4286-4f7b-08d9a3a59b76
x-ms-traffictypediagnostic: AM7PR02MB6049:
x-microsoft-antispam-prvs: <AM7PR02MB604916BA40D9CB62A14FDF519C929@AM7PR02MB6049.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k7wvfBwUAqVadEuvTcUKK61dBCWlYpXTb3DhVoimT/W8YUobvBeO3r1vxr1q1D09KIPXJLCrYbCcw3VZ3Wtd50RBNzllX7QDTjEW+I41ka1jbTyiLU2eOhzTpli9q1WHCe5Mm0o5Z9TNH1vAvPrk0IAyQizsXKcezR6A3QKRvUgjphH1Nyc0Jh8g65JqYt6NNBDyaTgKtb7Fo95wQozjujRGnXnU9x3nL/IzGTjhhwDmtRcCslqM1MG1ydZ4FNCILsCEoAJDSJeCff71wCDoHyYqn3D2rjlJdbvxelf70GpWoE5zXHl45Z97iJjD2xAUuQc96ZC0oSQ9jyuKhA9ESdWz5TPplt+qDZST2o2SV2dyUJKtlVgICNueOo9cPWm/ylGB4Js8R1YFrtvQFkntdZdYqXOAoE0gH6x7cTb/qjxvXiLo9/ujdjtvD/Pw/YUgp37qh9BuU881AFEI7teT8d3YiiViwzRRPJvSs6/TE5Td1UXd/FL9XJouxanQtYsAdH4qrMm0xpOsrHJJQzCAL+xRJojbI1h/i5HH95JZfUG6mTV4j/QRIx8PZ2U6Ywh+P4lqQzltbXNMt2WcwVapFWp3A/NElOCQUrBGjLBP1IN4c+0B3wYpJ/NcluMoWGlbWjWZj/a/16pSDqGxUJA/E+T9rb/atZOrb1nAdBCIkk5MikRIWbwerAVmv3H7He7P
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB7302.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(64756008)(9686003)(83380400001)(66556008)(76116006)(66946007)(55016002)(66476007)(38100700002)(33656002)(66446008)(186003)(6506007)(52536014)(26005)(6916009)(82960400001)(38070700005)(55236004)(86362001)(54906003)(4326008)(316002)(8936002)(122000001)(7696005)(2906002)(71200400001)(8676002)(508600001)(53546011)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?35bKMjBEhJDZfMO+7PCi1SgEC6tOuYm/KgoDo0LY5gaAm9U2gK9BQNvoMReR?=
 =?us-ascii?Q?n+uxzDIQcxRGauORwsrK0RrjmKpZj4yWoAJD53ky9YtdIKeDVZWfrUVf7hA2?=
 =?us-ascii?Q?Z+0tbYNjLKul1M8dUodZoMTFenlGgxdbbmthnoqFhP9vq4F8Cy8/TsoNlsVM?=
 =?us-ascii?Q?5KCwKm0cdzsWWy0r0Eippd5dTHQvS0NESajnhYTZVL1wWKNfiyK3CtkFXByC?=
 =?us-ascii?Q?9E7AV0Q5nO2Ps3kLhQ6+DnpowLhpH3G4mjxDw40oIJkRLz7X89SEEilyfg3W?=
 =?us-ascii?Q?H4BVxEXR2Ybe8sNZfBqoZlwc4M8gcSFZ9ikeCKPmml8AL756B2Rv0rHadNSX?=
 =?us-ascii?Q?CPIw2KQdZCollaPZpjF8lulvj1FNheWDyrkRzhfZXL+qKwgedPJ9LcNIGp0K?=
 =?us-ascii?Q?R0E5dr+CPhP+Z9cSNL/GCzIwr23WITrUBmldFUXk5P2pXAQUaQbPXZogTqZv?=
 =?us-ascii?Q?21Vu0vnY2FVziFyLGt6W+GsZtC4G3HSUf+JXLnaU2zJgDZzkxKHh+et6jJFq?=
 =?us-ascii?Q?NfGphiww+RUnD17z/nGtZ4p7c3NLif1XGkct377D/MV3/fEr34HzWpD5Ucod?=
 =?us-ascii?Q?rTY8o3ptxn3zTfBNk/TlZBmRaP0wKbAyqYnjNtoLAsna8s1RY7T4tFfLuVEJ?=
 =?us-ascii?Q?NHV758xhZu5F7mhXtgeZYZiIiQlL+YdRbFaWD1ugzSmmhSFjJMhj71fiXZ0P?=
 =?us-ascii?Q?lmi/MLRKL5BPG7k7sl+saTCjVC+jHhfgAcM2cKl8vdnxeh+YhKx/XJGF2+kb?=
 =?us-ascii?Q?4DDg9PNZ+6pr7oBBHEDdgLgmZBBQpjmCzx8PARlWtAE6HI2ll1JCBxgGHZrC?=
 =?us-ascii?Q?yzz48kAe60C2q+OAQSK6kKZqrY25CKFamxIvnxotnzB5vYv1JJfDju96mMbX?=
 =?us-ascii?Q?Ajv6oPcTKh9ypxzCP8FpculG3l23ITQm4YdfYN3b07P/f+ZbesnG+nUKbRto?=
 =?us-ascii?Q?WPHNsrQCpXbNwe2402sErXXyldG0rBKL6ysKRd9mFjeS+iYubKbH0vkZNqRp?=
 =?us-ascii?Q?tsBxAYKD6Lm6UM2Df3crVjdGtbBLJI885+Zwt8YtMSUDNncgEvP+aEJOpZXr?=
 =?us-ascii?Q?nCm3HkuXdDgcjHM23gHBg9oPv+dTLiLq0g+ZObwJVhPYUlZRCweaihizC79j?=
 =?us-ascii?Q?uZYVaRwJAScjngSkTXas4XevF2+NsX3QXgClarYMoiExTdSZGlJdUJsKDwoO?=
 =?us-ascii?Q?PmO2UL4NXzim5dpKp3bKpa0pdPwopYsa/m6MDXn/7zlFz9Tmg61o8nPjeOB+?=
 =?us-ascii?Q?fbNemcAbmRaPZgTmP6n1weYLWtV4oFli8CKc0gifId4UHwckPcMIxH2H2Zwj?=
 =?us-ascii?Q?fGbgOTUie9f6/zmupZEXim10GZkNHX69yrUDHxYhmXgdYAw/uS3lMIh5p0BJ?=
 =?us-ascii?Q?NKGvwNmnRGaIdY/nMWgYe/YhKCyYf/E8L++bqXfbF7gQ1HN4k53Mpe4R9xCE?=
 =?us-ascii?Q?UaXP7jdCL0vllND/9hTPw4HAmoeNzIRHdHfI6UU5jOHA9zId+gsQJqsmqKLe?=
 =?us-ascii?Q?Uyn4bfHJzhY52ZEfa/3pNbfTpan7reAeAu41yCPAbZ1q3FbLL8uDd8gJlwtd?=
 =?us-ascii?Q?sZLFiRHylZGjc1DPwEA23erJoI0Ad8Ae7C7y2pwedbYoLKr37VpSsqDoYgZi?=
 =?us-ascii?Q?/A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7302.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e63e89c0-4cb0-4286-4f7b-08d9a3a59b76
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2021 17:23:12.1425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 33440fc6-b7c7-412c-bb73-0e70b0198d5a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FUAErbBObtfxCPBSCprnW4yx5zfDezBCBAvifdpIHuN31WU5DCxnqnem1ZU/CpmJqqzMjjRO5Qj3IYZ4yW8+Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR02MB6049
X-OriginatorOrg: atos.net
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> -----Original Message-----
> From: Junio C Hamano <gitster@pobox.com>
> Sent: 08 November 2021 19:15
> To: Kerry, Richard <richard.kerry@atos.net>
> Cc: Adam Dinwoodie <adam@dinwoodie.org>; git@vger.kernel.org; Fabian
> Stelzer <fs@gigacodes.de>
> Subject: Re: [PATCH v2] t/lib-git.sh: fix ACL-related permissions failure
>=20
> Caution! External email. Do not open attachments or click links, unless t=
his
> email comes from a known sender and you know the content is safe.
>=20
> "Kerry, Richard" <richard.kerry@atos.net> writes:
>=20
> >>
> >> > To avoid this happening, before creating the keys, clear any
> >> > default ACL
> >>
> >> "happening" -> "from happening"
> >>
> >
> > No, original is correct.
> >
> > To avoid this happening.
> > To keep this from happening.
> > To prevent this happening.
> > To prevent this from happening.
> >
> > Would I think all be correct.
> > "to avoid from" is not right.
>=20
> But I meant to say "to avoid this from happening", not "to avoid from", w=
hich
> I agree is not right.

"to avoid this from happening" is wrong.
"to avoid this happening" is right.
Or my other examples, with more or less the same meaning.

I phrased it as "to avoid from" as an example of the verb in its basic form=
.  You were entirely clear what you meant - I was merely trying to give exa=
mples of what I think is wrong.

As a native English speaker I grew up without being taught formal grammar, =
so I can say something is wrong without being able to explain why in a form=
al way.....

I'd guess from his name that Adam is also a native English speaker.

Regards,
Richard.



