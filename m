Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC27C2B9F4
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 14:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A3F161953
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 14:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbhFYOdZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Jun 2021 10:33:25 -0400
Received: from smtppost.atos.net ([193.56.114.176]:10219 "EHLO
        smarthost3.atos.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229573AbhFYOdY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jun 2021 10:33:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=atos.net; i=@atos.net; q=dns/txt; s=mail;
  t=1624631463; x=1656167463;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VmlcqSqqsAXDqfwhiLDxdKzQe2RvyafLnumm56vaRk0=;
  b=qOybeOHHlHRkaBv7Gih1+sjB6E9x9OVkp7iZgpRAhV5hiIKZvSP/bIAB
   vc/yNwSaElYH13bqzjSTD+yw8WlAyx6F6knOuxvXlTyA9r8bnGGnEErC5
   M7dRI8u0Bvp4n7tmetVOlLUJA/Iq0RMnKvD8UnPFM/aqkBrHiSCtXINYS
   U=;
X-IronPort-AV: E=Sophos;i="5.83,299,1616454000"; 
   d="scan'208";a="219179734"
X-MGA-submission: =?us-ascii?q?MDGQ2GD9YXtAcyIIf3fZZu8feP/X0jW3QdxEcp?=
 =?us-ascii?q?rC+2U0+7jt/EEZQueHl+W8t4aFXW0p4wO417LNDQHov/HRaqFAABXQ1j?=
 =?us-ascii?q?0repZSv8XBJzfyK8ZXXkzrFzNFFaF+a6uZFILBG2Q66uXFjrMAMRgYuC?=
 =?us-ascii?q?YX?=
Received: from mail.sis.atos.net (HELO GITEXCPRDMB13.ww931.my-it-solutions.net) ([10.89.28.143])
  by smarthost3.atos.net with ESMTP/TLS/AES256-GCM-SHA384; 25 Jun 2021 16:30:56 +0200
Received: from GITEXCPRDMB11.ww931.my-it-solutions.net (10.89.28.141) by
 GITEXCPRDMB13.ww931.my-it-solutions.net (10.89.28.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 25 Jun 2021 16:30:54 +0200
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (172.16.214.168)
 by GITEXCPRDMB11.ww931.my-it-solutions.net (10.89.28.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14 via Frontend Transport; Fri, 25 Jun 2021 16:30:54 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQv0PpQC1Dc1ZILX9tyaLlVFigaJlc25d7muuvdgAhR9soGri43Z8TsM/44eTseS72ARuQVoH0w8KNpLcg7NBAOmwZQNAB0pOUwt5jHTx5tLXH9/GS92oIVW1jrjyR2CjjRwwraFIoi/WWtF1Xm1LFnwdW6m6UD/4acGTRCJjelmypyxkhBKbjxb1rW4gIWlWUwlmijeiJSpSssFM/iPXeZmapZXBpeW+FEMxztX2J2zdTpw/5heC+1zvPmG9Wbr1fFy1i/NDK/ka5qrDaEkeLKOhEJCPRSIeVXHBbiCLMPvQtvoEn9PFEr7fpG9yAPTrr9iKZtIM4jwOdY6CKl2wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmlcqSqqsAXDqfwhiLDxdKzQe2RvyafLnumm56vaRk0=;
 b=ngcL+mhlf6dAtsjWA8TB9v1BQUWHYbvoPSzkEiMjuP73N5+kpnG0S2E6IWg7+67IEe7wFqultayZcuXuRgYmBQLvcITU9+r570fUelL6vBVhwt5pn9Nk6h9vptOzVq9AjUcKkbU1f4JmVzXlSIYZW9Po9O23/IPVYzQyVZCckVWig0wPaly4Qf8PYf6w5dW6z257XLCgogYFzCU0JydbJM3S1YjJ5scCW4/jrbWbE1AoVH8+JjFuIbD9ndK0savuq8jm5sW29B03euLn0uKhCCes4esFq0Q4h3OJRTgMiCiAMg/UxDt3VumeAmzPEX9gNijmHGoeoAiJ/PfIJ36/sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atos.net; dmarc=pass action=none header.from=atos.net;
 dkim=pass header.d=atos.net; arc=none
Received: from AS8PR02MB7302.eurprd02.prod.outlook.com (2603:10a6:20b:3f8::19)
 by AM5PR0202MB2514.eurprd02.prod.outlook.com (2603:10a6:203:6d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Fri, 25 Jun
 2021 14:30:53 +0000
Received: from AS8PR02MB7302.eurprd02.prod.outlook.com
 ([fe80::ed80:b8f7:efc7:e147]) by AS8PR02MB7302.eurprd02.prod.outlook.com
 ([fe80::ed80:b8f7:efc7:e147%5]) with mapi id 15.20.4264.023; Fri, 25 Jun 2021
 14:30:53 +0000
From:   "Kerry, Richard" <richard.kerry@atos.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>,
        "stolee@gmail.com" <stolee@gmail.com>,
        "jrnieder@gmail.com" <jrnieder@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: RE: [PATCH 1/4] Documentation: use singular they when appropriate
Thread-Topic: [PATCH 1/4] Documentation: use singular they when appropriate
Thread-Index: AQHXW75YcIiaTHB6CUqdN7DKAcvQUasKYV8AgAAIYQCAAUfasIAARScAgBjiMAA=
Date:   Fri, 25 Jun 2021 14:30:53 +0000
Message-ID: <AS8PR02MB730242836E3DA3E3F3B1D9DC9C069@AS8PR02MB7302.eurprd02.prod.outlook.com>
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
 <afc51c5e6edec7935a6d0d0a05d396e11311ca6c.1623085069.git.gitgitgadget@gmail.com>
 <YL+p+MlgJ754YoqB@google.com> <60bfb1003c46b_1ac15c20894@natae.notmuch>
 <AS8PR02MB730269FA1BF5C3B0CE20DD8B9C369@AS8PR02MB7302.eurprd02.prod.outlook.com>
 <60c0fe08659fc_10887208d8@natae.notmuch>
In-Reply-To: <60c0fe08659fc_10887208d8@natae.notmuch>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Enabled=true;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_SetDate=2021-06-25T13:44:27Z;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Method=Standard;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Name=All Employees_2;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_SiteId=33440fc6-b7c7-412c-bb73-0e70b0198d5a;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_ActionId=7c955f44-339c-453f-ac7c-2bed22a1c2fd;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_ContentBits=0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=atos.net;
x-originating-ip: [165.225.199.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e15a452a-ca1b-457d-120a-08d937e5d695
x-ms-traffictypediagnostic: AM5PR0202MB2514:
x-microsoft-antispam-prvs: <AM5PR0202MB2514AA468C136038484B353B9C069@AM5PR0202MB2514.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xz7g29gwmWIUtr23aNXRYZ9wF3unFKmGpoCLrG2u5CQByPPE5nfkA5XftAUyBPCEdpw5FTKMpSAyJGvyWV46RRnxyBLqsiymz2/TqyjBVRGNzTrxud/mWXDCwI9l32r2+gzIr7D6UqvZUQTAScj7wnFA8lF9uvAnVdUQR8iV2k2WzKRNbnsL1+lZOidnTsgkL1UweJcq01oYOEI6fqFQfNGdOOo4jZzzDK0ik7D/BTEKGpubCzVFhbqTCtoYCUb7GKgXpG9WsGUFrSKsaFD+LtRsuFA8gC7ZNlm632+A9WR0jFneadXZJmgHUcqkKzMFRDOns1jo42dzBjNGoxXl58Pm7sPOSQMmNge/ucgOsSfvsREWc5n+VzDzvj1VGm277neIxPdafgFQC1jS1TAVw8jL/4zORAdCggYiPZbsaFV7/B0V/LbwxhlhisF3HMRNsypD7Nib/bLSGMkVHu2hOUhYxnkXVF1BudKSBk+okSfhcDMWrAkwf725K5jvRavnywDxPegu5WphR9GPqM6pB6lR6fX78VFN4Y5tRGyav9YrXpkGJ+KMLID7pJQhmQmgD48YLkuLWQIbfms/YODw/eSGzAIvK/3zvASMPAKDL44=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB7302.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(346002)(396003)(376002)(26005)(53546011)(186003)(55016002)(9686003)(6506007)(71200400001)(55236004)(7416002)(122000001)(316002)(76116006)(66476007)(110136005)(54906003)(38100700002)(66556008)(66946007)(66446008)(5660300002)(64756008)(45080400002)(8936002)(8676002)(478600001)(52536014)(33656002)(2906002)(7696005)(4326008)(4744005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1oCsQSXuwXEurJeTrVhBUiVn8cGVFTZrTeXKJqoD3STD7SkV/GxgbSu++MH5?=
 =?us-ascii?Q?AeOgnEN4jSBXXSwDE5FSoVGPUdpQf7umJ+pIy+IvtBex4ek/D5EqcqxBvWZH?=
 =?us-ascii?Q?+BJlQEIyEFc8N7P8qipzNqw5cBwQwomxvTZhXye72U6RcFwm5xjhO8xaeSq6?=
 =?us-ascii?Q?Mw5ffgpzKsz4WH7ypH88en61kOn52TUporChqnTes+Z/hP12NYBDW11s/7nX?=
 =?us-ascii?Q?ky5B3br1QLyfzlL0BlBdqOKWRR9A96jfT9HliGL9wBkI9thh2INd9mVRXnDL?=
 =?us-ascii?Q?rfJo8rPNnIA18Br4LjWd2eq36bOoFaPTlQ/wwjsv6IxfGt86zFSUwnQ9yMHw?=
 =?us-ascii?Q?X1K6kRJK08Yl+K4OKjpZ7QY2EV4NnazhaFojQmPDcNwHSFlUZNxrqsyNLvE/?=
 =?us-ascii?Q?D/6wyK7MLoNj+o54G782e14cLif1x92FLPdvh0EFxZL3WnGik0WC4XtPV827?=
 =?us-ascii?Q?VYSVReRju/UqdKcxjF/xto/JbKgAZ9skgvVnZNikdrObf8tnUgQ4CTa0Rjmi?=
 =?us-ascii?Q?NMTOc5kbdNZWUPazhu2kuXLsp46iMAxZlBx+7dmpFLEjaMoeAs73wssmrCEw?=
 =?us-ascii?Q?o2MLksMNmAYPowV9i9CIuT7pX8xjD3RKWYAZBuR02MFCFJEP12czt8tY68MB?=
 =?us-ascii?Q?PqsromVcAEOEvpkZkAHLpm0d03GEHwfLGlA+2xo8+tpAXmKlHuhHTlE9HhZf?=
 =?us-ascii?Q?hRO2PR/Qy29UqgE/WBcDS4/QOdpuILKNiQs45fTLahKw3C2qllwChZkbIy6a?=
 =?us-ascii?Q?INtYTmJSX2r2xzxWO0r/KuMixa+BM4lCGOX1OMEi9CH3qvIAIHpHVhR+EJ0V?=
 =?us-ascii?Q?UsV7HRedVgeiJLKBorpwMCNaI0vsLbxAtwdWzAFnxVoUhE63Wy67GGYUt3hY?=
 =?us-ascii?Q?LvwDlVJdBEbnlSMpYYlpx22zQRQdImaPqjxkokMkDyT+IIJaBZxFcnZrTPl/?=
 =?us-ascii?Q?fMRQWzM8QOsLTSA/7UTgQNk//rDSsfigmPrhA8Mw2J6yV+3dpw8fCXuPj1xL?=
 =?us-ascii?Q?JwVwEcViiFRdkUpl7g3SOZH8tgN6p9yfjgm6jkw2idr2Rm6ioyKaKarqGUFr?=
 =?us-ascii?Q?eXPyiWwEzCmyDqfFbwD9EkNv0RTXGVuo9E41p44juVXNISApD0dom/cBy0BT?=
 =?us-ascii?Q?OQi1VUOfWtov1vCXRHu0yuU7tH0AjkDtbpcaYNhB6Q4tjj2F4xY5wJln+EUr?=
 =?us-ascii?Q?cQ0cWuNaFUay50mt4HSdsetIOhBpMtyitPe0IX/HgPVDRSiYsYKg6unoUjao?=
 =?us-ascii?Q?jsrYcqiec5D84O9xqfSF7p07dJYTAWC8h9lnXlfE9+wwbjFdR9cQjHN4fri6?=
 =?us-ascii?Q?G77L4TbU4TQF/XVvnIwYQ0/t?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7302.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e15a452a-ca1b-457d-120a-08d937e5d695
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2021 14:30:53.5802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 33440fc6-b7c7-412c-bb73-0e70b0198d5a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oyMU3sauP4OU59ErjHnRvJMJzsq33SUFnbDA6dASAqpDaGIOWc/GQf7FajLKg6+N1Vs0YvA6j1k4XvH5cM5LiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0202MB2514
X-OriginatorOrg: atos.net
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> From: Felipe Contreras <felipe.contreras@gmail.com>
> Sent: 09 June 2021 18:45
> Subject: RE: [PATCH 1/4] Documentation: use singular they when appropriat=
e
>=20
> > [RK]  Or rephrase to sidestep the issue=20
>=20
> Would it be possible for you to use quoted line prefix [1] as is common o=
n
> this mailing list? We only have the beginnings of a mailing list etiquett=
e [2],
> but this is something that reads very different from everyone else.
=20
Sorry.  Yes.  Will do.
When I first looked for reply options In Outlook I couldn't find "indent wi=
th prefix".
I've just looked again and found it.
Though it is still giving me "[RK}" on new lines, so I need another look to=
 get that turned off.

Regards,
Richard.


