Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C53C433F5
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 15:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0950760C41
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 15:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236194AbhJZPVM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 11:21:12 -0400
Received: from alln-iport-7.cisco.com ([173.37.142.94]:20505 "EHLO
        alln-iport-7.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235804AbhJZPVJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 11:21:09 -0400
X-Greylist: delayed 425 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Oct 2021 11:21:09 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1864; q=dns/txt; s=iport;
  t=1635261525; x=1636471125;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=mF5vORqAKsX5o3mRaFSxZ9T/pjeM6tuJEjxennE+ZXc=;
  b=dRlOBx8JXBZXe7elMtpdLZmunPLBbvTcmgDt269dI/qn//21kfP+HNbr
   YXxxr4t0mI4Bg841GBuQfKIJF4E2n55KIXUWBeXralrrnsfRw3U3NFCHI
   v7o5hjbUkEXeNMwXzZvJt6e5nDWqE/QMImDKBp9H45zzgxCupAPVaMi1I
   s=;
X-IPAS-Result: =?us-ascii?q?A0DYAwCiGXhhl5xdJa1aHQEBPAEFBQECAQkBFYFZAoFPK?=
 =?us-ascii?q?SiBWDcxhEeDRwOFOaMGgS6BJQNUCwEBAQ0BARIvBAEBhQAZgjgCJTQJDgECB?=
 =?us-ascii?q?AEBAQEDAgMBAQEBBQEBBQEBAQIBBgQUAQEBAQEBAQGBCIVoAQyGRRYREQwBA?=
 =?us-ascii?q?SkJBQERAQYcAiYCBDAVEgQOJ4JPglYDLwGRS482AYE6AoofeoExgQGCCAEBB?=
 =?us-ascii?q?gQEglGCORiCNQmBECoBgwWEF4J3hCkcgUlEgTwMEHmGcIMZN4IMIo8KAYIJL?=
 =?us-ascii?q?ZVDR6kMCoMynngFLYNqkQeSLJYMH4Ignx8BhB0CBAIEBQIOAQEGgWE5gVtwF?=
 =?us-ascii?q?WUBgj4+ExkPjjmBDQEIgkOKXnQ4AgYBCgEBAwmSEl0BAQ?=
IronPort-PHdr: A9a23:Otzbjxz91crjZYvXCzM3ngc9DxPP853qMQMPrJkqkbRDduKk5Zuxd
 EDc5PA4iljPUM2b7v9fkOPZvujmXnBI+peOtn0OMfkuHx8IgMkbhUosVciCD0CoMvHndWo5E
 d5EWVsj+Gu0YgBZHc/kbAjUpXu/pTcZBhT4M19zIeL4Uo7fhsi6zaa84ZrWNg5JnzG6J7h1K
 UbekA==
IronPort-Data: A9a23:iGip7aDO68tAZBVW/zvjw5YqxClBgxIJ4kV8jS/XYbTApDt2hjMBn
 WQaWW3Qb/iNZzD8Lox0YInn9RsH6pCDyN5nOVdlrnsFo1CmBibm6XV1Cm+qYkt+++WaFBoPA
 /3z6bAsFehsJpPmjk/F3oPJ8D8sislkepKmULSdY3grG1c/IMscoUsLd9AR09YAbeeRW2thi
 fuqyyEIEAb4s9LcGjt8B5Or8HuDjtyr0N8rlgBWicRwgbPrvyJ94KTzik2GByCQroF8RoZWT
 gtYpV2z1juxExwFUrtJnltnG6EHaua6AOSAtpZZc4PysDEegQwf6/oQBPoYT0x1pRqCtd8kn
 b2htbToIesoFrfHlOJYWB5CHmQje6ZH47TAZ3O4tKR/zWWfLCCqmKooXRpwZNBGkgp0KTkmG
 fgwMjAKYh+OnMq9wamwTa9ngcFLwMzDY91P6ys+k2+AZRogaYvqX6nhu+dC4GpzmuBNXs2Pf
 9BJYwM6OXwsZDUWagtIV/rShtyAnGH/dDFXpUm9qq8+4myVxwt0uJDiMcb9ZNOHX4NWk1yeq
 2aA+H72aiz2L/SFwjaDt3mrnOKKwGXwWZkZE/uz8fsCbECvKnI7I00kfAecgdSA1mWOW9Z5I
 G461SEEov1nnKC0deXVUxq9qX+CmxcTXdtMDuE3gD1hLIKJvW514UBZE1Z8hMwaWNweHmZ7i
 gDT9z/9LXk+7uLNEy31GqK89GvqYUAowXk+iTjopOfvy+Piq4E6lB7USdAL/EWd0YCtSWiYL
 9xnUEEDa1g7l8UH0eCw+krKxm/qrZnSRQlz7QLSNo5E0u+bTNP5D2BLwQGGhRqlEGp/ZgLd1
 JTjs5PChN3i9bnXyESwrBwlRdlFHcqtPjzGmkJIFJI87Tmr8HPLVdkOu2wndBk3aphdJWeBj
 KrvVeV5uc870JyCMP8fXm5NI5hCIVXITI68DamEMrKinLAoKVPclM2RWaJg9zm9zBdz+U3OE
 Zyaas2rRW0LErhqySHeegvu+eFD+8zK/kuKHcqT503+idK2PSfJIZ9YYQDmRr1os8us/l6Pm
 /4BbJTi9vmqeLCnCsUh2dVLfQ5iwLlSLc2elvG7gcbZclY6QTp6W6GKqV7jEqQ895loei7z1
 inVcidlJJDX3hUr9S3ihqhfVY7S
IronPort-HdrOrdr: A9a23:Jx8pPa1x9vfGvKh7dzZbsAqjBRZyeYIsimQD101hICG9Lfb4qy
 n+ppomPEHP5wr5AEtQ5OxpOMG7MBThHQYc2/heAV7QZnibhILOFvAi0WKC+UyuJ8SazI5gPM
 hbAtND4bHLfD1HZKXBkUmF+rQbsaO6GcmT7I+0pRoAPGIaCZ2IhD0JbDpzZ3cGPDWucqBJba
 Z0iPA3wwaISDAyVICWF3MFV+/Mq5ngj5T9eyMLABYh9U2nkS6owKSSKWna4j4uFxd0hZsy+2
 nMlAL0oo+5teug9xPa32jPq7xLhdrazMdZDsDksLlWFtyssHfsWG1SYczEgNkHmpDo1L/sqq
 iUn/4UBbU215oWRBDsnfKi4Xi67N9k0Q6c9bbRuwqcnSW+fkNhNyKE7rgpLicwLCEbzYxBOe
 twrhKknosSAhXakCvn4d/UExlsi0qvuHIn1fUelnpFTOIlGfVsRRx2xjIlLH4sJlOz1GkcKp
 gkMCgc3ocjTXqKK3TC+mV/yt2lWXo+Wh+AX0gZo8SQlzxbhmpwwUcUzNEW2i5ozuNwd7BUo+
 Dfdqh4nrBHScEbKap7GecaWMOyTmjAWwjFPm6eKUnuUKsHJ3XOoZjq56hd3pDmRLUYiJ8p3J
 jRWlJRsmA/P0roFM2VxZVOtgvARW2sNA6dg/22J6IJzIEUaICbQxFreWpe5PdI+c9vcfEzc8
 zDTa5rPw==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.87,184,1631577600"; 
   d="scan'208";a="768926661"
Received: from rcdn-core-5.cisco.com ([173.37.93.156])
  by alln-iport-7.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 26 Oct 2021 15:11:38 +0000
Received: from mail.cisco.com (xbe-rcd-004.cisco.com [173.37.102.19])
        by rcdn-core-5.cisco.com (8.15.2/8.15.2) with ESMTPS id 19QFBcmm016535
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 26 Oct 2021 15:11:38 GMT
Received: from xfe-aln-002.cisco.com (173.37.135.122) by xbe-rcd-004.cisco.com
 (173.37.102.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.15; Tue, 26 Oct
 2021 10:11:38 -0500
Received: from xfe-rcd-001.cisco.com (173.37.227.249) by xfe-aln-002.cisco.com
 (173.37.135.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.15; Tue, 26 Oct
 2021 10:11:37 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (72.163.14.9) by
 xfe-rcd-001.cisco.com (173.37.227.249) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.15
 via Frontend Transport; Tue, 26 Oct 2021 10:11:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hpH6Q6chuSVSfIc3gcsBQnL6Ujo9BaE/MumvqaQD4YpO60suWCcOhsYcVN73CeXccI5yznQfd1N8VQHNRdm+Wa3cGVdBFyeCuqS1EDlbDg8qAsrcQAi+yYmuDCDlUSTzCaeZkHmMWgvAkdMokJYpb0Dco3EPMPLHV4S2CuW0/TYl8pjU7HZ8LX7Hpkpnw6w3AmcfncP4j6C5CWnSoSZvNkf3uMvx8+2HVk6QMxw8UVYRRU3pkmHoaoTQNTlAWaCunWh/xpP1lE+t1Dz5st3ahxSfMYvq6niun4xZhrmp1JewVqlkJPi1YlwEs7zyIYej9BsFIZQTGFLkU/bfTb++QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mF5vORqAKsX5o3mRaFSxZ9T/pjeM6tuJEjxennE+ZXc=;
 b=BcwWDnOtSt7rMvdp8rB/OnGfLVJ7zJygArKrdBeZTMAHhwD/W28Wq2F1FlEsFjNcyqXmkH+HUcqMeNcFTv9kr6RJNqdxvK9mKpCJ8E9x++Ky0EQApmLKoTcNLtJIjPmKyLTucgWKhgFXin0cil/2wouI5dlBM8+68jbwXQCEJfpfGH+hGwpOADNpH8fycqHMmAuLZstLkG2+wwXHtUW/y46PwuezqIMbPLqrliWGQQmoRLr31xnZojkCwh04T4uCOFzujQEPZFQsW4gwpxrLQoXTy/FKJiZPI74DC35j8eHd41FGN1RrHPFRcaG+kpTnmdZlFlfrDl+Zi9YJacO4WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.onmicrosoft.com;
 s=selector2-cisco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mF5vORqAKsX5o3mRaFSxZ9T/pjeM6tuJEjxennE+ZXc=;
 b=sYqVrDy2fBZt87P7Rskl/+IzdGPRHWG6XOG8qTdTffzaPbZ6gmDdunBw75oRagi73F1wqaLW5SMbmHO2gcezgDLE2Osc3u2WKKKkDS9B0chAKURCkt3LH8+To29Z5DhxUb1821prRf2ctOepderwwo5orat55+MD/hcxBkF4Mi8=
Received: from BY5PR11MB4072.namprd11.prod.outlook.com (2603:10b6:a03:18f::11)
 by BY5PR11MB3877.namprd11.prod.outlook.com (2603:10b6:a03:186::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Tue, 26 Oct
 2021 15:11:36 +0000
Received: from BY5PR11MB4072.namprd11.prod.outlook.com
 ([fe80::8ac:6ba5:3e36:48cd]) by BY5PR11MB4072.namprd11.prod.outlook.com
 ([fe80::8ac:6ba5:3e36:48cd%5]) with mapi id 15.20.4628.020; Tue, 26 Oct 2021
 15:11:36 +0000
From:   "Ryan Hodges (rhodges)" <rhodges@cisco.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     Ryan Hodges <rphodges@gmail.com>
Subject: git apply --indent-to-add deletes other files from the index
Thread-Topic: git apply --indent-to-add deletes other files from the index
Thread-Index: AQHXynvEQ3cmWcCZkE2s8lirVrR3Xw==
Date:   Tue, 26 Oct 2021 15:11:36 +0000
Message-ID: <0DB10E05-094D-4382-AD1F-657878B06A80@cisco.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=cisco.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 31138d00-85a7-4187-66a9-08d99892e766
x-ms-traffictypediagnostic: BY5PR11MB3877:
x-microsoft-antispam-prvs: <BY5PR11MB3877FB58613923F0CCB034E4A0849@BY5PR11MB3877.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1r1Ua/Y8HVfOS7UO2VvPGJ5Exav2Ejnuu5IPktAgDiWZV5ReQ/P71qN8jQyHnNjKXkUy/Em1gsTBlhH9DJhycfyH/wR6OtatVR8Z4/RjMMds6YR7qE3GnbgaZJkX9nl0/PEmM1v2DYtt1yE5eN8syiJVAO/VfQ25UgBz7huP5JU66zck07guJuWMSfrSnpE2xqUKf7NIjwhf7D2Osc/CMqe4PBRTO1l6QsUrbAcrukACz1AVU8QonYVjwIMbi+a+RXF80PNC7vdnbMPGIIj1513BNEp0BNSm83kObjU2SjdtnGLyaaP1Szg6UMKH9RhqaldeJwn++ece7xtEu0PkCkDoOvUa3VXmipzuRdQ6UydLrvExehmhnIkASd8JsJj7sHtHutucS53g9ySJVMhZhPpijQ8Po8OmIXVvRMtd8f4XLX08WsBp6x7QbbejO6dtKRTGAnNknbvIqTm+7OD+032CnwS/644ejZdM0xC0dr0pi68RiERwq3od8vSS+XFtGen6DgcpK8ETlp14BvuSnV1RnrbXcyGMBfuyd8nZmn8Cj6TYaDFsrw7TDa3KMKSrvyH0so4XaCHOZS+8R9ok9jE9WBF6Vtg/evTT/OlYYQD7NCZ1uA71r9pIKGaatOIWHWN7YB/kM5fshCudxpWj6dFolWnUnexO7vGG9Kizpf7SGnen7Cv/TwqSLGGrElAmBJso8YttcduJf95TjqKfe9acqIxn1IfvusOolSmGYok=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4072.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(8676002)(33656002)(8936002)(2616005)(6512007)(316002)(86362001)(71200400001)(66446008)(6506007)(83380400001)(66476007)(66556008)(122000001)(6486002)(76116006)(5660300002)(66946007)(4326008)(38100700002)(64756008)(36756003)(38070700005)(6916009)(508600001)(26005)(186003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L25RekIxeUN5ZmFrVkZvY21RTEcrMzI1WlZLVGlyS0lBdzN2QmdaTU9PVisw?=
 =?utf-8?B?TlVaSzNURFpkdXhneUhhK09VOUZKcG5BMXpMWEZpcW5Fb1pwUTNTdUdUa2ha?=
 =?utf-8?B?a2treUx3dGwwMGNaQlFhMjdFN3Vyby9yekl4TWpsUFBRWmZZcW96b1JCWmdu?=
 =?utf-8?B?OGsvR3ZrcitKYXk4YURYTTBXb0J1ZDNwRDA5RFBTcnNDU3Y4My9jNkFnRFA4?=
 =?utf-8?B?MlhjKzVNcWU5ME1KdU1vUWd5MmNHdkNYM0pxV3Z0dG1qZ015ZTVna1lFTE9s?=
 =?utf-8?B?N25uQStJV0oyNXdJLzkyTElKSU8vTW5lRVI0M0tjNFUrZC81TldkeTNZS3pY?=
 =?utf-8?B?bFpmM3AvMUJLclhpVjVpK1QwQU5EUGM5aTRpNEh0VmVxVmZHV1FZNDVtQUlO?=
 =?utf-8?B?MGFsNzIrY01lTVYwQ2VVK3RpVUZHQmdsbHZDU3Z6WXF6NHFBNlFySlhoTWk4?=
 =?utf-8?B?dGNuaitOZThKekNEZnJTNWN6QnlDVHJVc1Q1ajhUYnBsemNFYjBmcncrK3dv?=
 =?utf-8?B?ZDFtV0lzZXRTcnpRKzkxZnJuUy9aczVsaGI1OVA0S3dGUTJMMVNvL0lWUFR2?=
 =?utf-8?B?YXZLNWJhVERkVjN0N003UEhlUnNmYThTYzZCZjBpY2NWZ2pma1NraFRMR3JX?=
 =?utf-8?B?WE10cThxaklycEVQNytQUTV0a0RhMFNwTlhXNE5sSXZNdFZoR3FDak5penkz?=
 =?utf-8?B?U2VDbGszRVV4d3RzazFHZEJrTUZ4SHRkMjkwanFrUmo1b293ZnNLSmhScmd4?=
 =?utf-8?B?aGtNdUtUaW03SmNxNi95N3grNUw3cmp5TmF2U1ZQWTlnQ1JJcUgzSlg0bWpp?=
 =?utf-8?B?anJNQzExSW81NGtBY1pZNU40YnlaQlEvTmtkbHk2aFh6TGZsMDNxMUJJR1FU?=
 =?utf-8?B?eWxxN2ZjZkduTldqT3pKMWdoUTRhRldaRzVNcEVUdEE0SUNkSEZBTE5hdzBy?=
 =?utf-8?B?M1l2NnZmTUR6eUQ4aFE0NEtIQndQd3RuY3BCa1dVNHd6NXlyM3liTnRzQUV1?=
 =?utf-8?B?Qll3cUJSQThSSVo5cW5FU3NuY29UcUYwU3AyVk9ib3VMbWhTenlIM256NCtR?=
 =?utf-8?B?eHBnWWlZdjFXUlBiNnhnWUp2emJ0VkVWc0hYRDd1TGROTDJqb3ZDZ0gyazJX?=
 =?utf-8?B?akZmZ0hQSUE1ekhzanB5YmtwTXlRNHF4b0JuY2tIbkJPMkZreWl0M0VUa3Rx?=
 =?utf-8?B?YWlVbzhzamljWTJCYUFVUSszOFdiWWkvL0RURUIzNzJ5bnVPbjJkcjN4dDdp?=
 =?utf-8?B?MENCZzVVam1GcHBsdkdZN1pWS2hXb2VHRUhwa2ZYcE9ZZFEybElOalNURUVC?=
 =?utf-8?B?U0hLUmRlK3VzdUozSXdtNi8wS1FwNEJJSTdDRmlhU2Qvay9aYUkxcDRUWWFt?=
 =?utf-8?B?bTJ6MktLT0NVcTMwdm9sL3BaNXVtY2pLRkZ3L0JZZmxUTHpsamxJYXQvQWdy?=
 =?utf-8?B?ditLUkVMK3dSeU5pR3BWdGdRY2hRdzRKd0EzMFZTUU42a3ljSWNZQnUxNHlU?=
 =?utf-8?B?UXVobWx4VGZhcS9GVTFwSmkvRjBrNDlVV2trQXE4NzlDMHMyMEp1MFBMamY0?=
 =?utf-8?B?ZGdhNFRoQ2NENWdIajNkYzZTd1RqWXBsUnNQN2lzcWxzckViK1Ezd0lVdytL?=
 =?utf-8?B?Y29SckVEbE5kWkp5U0NheC9XSjlibGpTK0Jnblk2dHVKcTlIS0Uvb2YvWkFW?=
 =?utf-8?B?MTVITGdBQTJzVkJPMHdXV0JWaWNTaHVlUHhkSEthSlFnRFN3ZThhRDQ4cURa?=
 =?utf-8?B?V005Y1k1dGlKSEtDYUdVYzhqZ0Rya2xCUkdLRCtBbmNJNGZzc1RWdFhVYkxB?=
 =?utf-8?B?N01FajFuSHFvVkRlczJ3enRnS2ppMkFkZE1KT24xQXhNckFhbVRqMVdBaEFC?=
 =?utf-8?B?SVNIZk1mbEhDZDd6Q3FJSmFPZmZQTWF3MGtFbHZhbkR3VXpoSTdHdGpTR2pX?=
 =?utf-8?B?YnhnbUlzZWtxcjRrdjlEMFBuTWRJdTFUV3RTYlZEaElJUWk2U2R1dEV1WGt6?=
 =?utf-8?B?M0ZrRUJkbDQxRFBMZXFiVlVUOHZHWUFIcjIzVmN5ZmtZblVJNXdBUVJMRnJH?=
 =?utf-8?B?c3pmbDdndzgxeEFaQzZCL3g2UlhmeUo2ZUR4S3dkUlpiSEg4T2F2bkczWFdG?=
 =?utf-8?B?cU9rZVJRaCtmOGJ6MVB3aWpCVlROd25uTDdpWTcxNmZwNmdTMGRuVzdDdHRm?=
 =?utf-8?Q?1klcRo9HPLQNHfCvGuxAXIU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <926AFD9120BA0C4EA4507C61A6A08E32@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4072.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31138d00-85a7-4187-66a9-08d99892e766
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2021 15:11:36.3511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iJZFXse3gs4Z5vk9s3aQ/3is2Gr1N7qD9uCIPpC+XJCo0SJPmi7Q0jiWbxm7UpMG/3Mt0w8l9E1B5ubtFBc5MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3877
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 173.37.102.19, xbe-rcd-004.cisco.com
X-Outbound-Node: rcdn-core-5.cisco.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGkgYWxsLA0KIA0KSeKAmXZlIGdvdCBhIHF1aWNrIHF1ZXN0aW9uIGFib3V0IOKAmGdpdCBhcHBs
eSDigJNpbnRlbnQtdG8tYWRk4oCZLiAgSWYgSeKAmXZlIGdvdCBhIHBhdGNoIHRoYXQganVzdCBh
ZGRzIG9uZSBmaWxlIHRvIHRoZSB0cmVlOg0KIA0KW3NqYy1hZHMtMjU2NTp0LmdpdF0kIGdpdCBk
aWZmDQpkaWZmIC0tZ2l0IGEvYy5jIGIvYy5jDQpuZXcgZmlsZSBtb2RlIDEwMDY0NA0KaW5kZXgg
MDAwMDAwMC4uOWRhZWFmYg0KLS0tIC9kZXYvbnVsbA0KKysrIGIvYy5jDQpAQCAtMCwwICsxIEBA
DQordGVzdA0KIA0KYW5kIEkgYXBwbHkgdGhhdCBwYXRjaCB3aXRoIOKAk2ludGVudC10by1hZGQ6
DQogDQpbc2pjLWFkcy0yNTY1OnQuZ2l0XSQgZ2l0IGFwcGx5IC0taW50ZW50LXRvLWFkZCBjLmRp
ZmYNCiANClRoZSBuZXdseSBhZGRlZCBmaWxlIGlzIHRyYWNrZWQgYnV0IG90aGVyIGZpbGVzIGlu
IHRoZSB0cmVlIGdldCBtYXJrZWQgYXMgZGVsZXRlZDoNCiANCltzamMtYWRzLTI1NjU6dC5naXRd
JCBnaXQgc3RhdHVzDQpPbiBicmFuY2ggbWFzdGVyDQpDaGFuZ2VzIHRvIGJlIGNvbW1pdHRlZDoN
CiAgKHVzZSDigJxnaXQgcmVzdG9yZSDigJNzdGFnZWQgPGZpbGU+4oCm4oCdIHRvIHVuc3RhZ2Up
DQogICAgICAgICAgICAgICAgZGVsZXRlZDogICAgYS5jDQogICAgICAgICAgICAgICAgZGVsZXRl
ZDogICAgYi5jDQogDQpDaGFuZ2VzIG5vdCBzdGFnZWQgZm9yIGNvbW1pdDoNCiAgKHVzZSDigJxn
aXQgYWRkIDxmaWxlPuKApuKAnSB0byB1cGRhdGUgd2hhdCB3aWxsIGJlIGNvbW1pdHRlZCkNCiAg
KHVzZSDigJxnaXQgcmVzdG9yZSA8ZmlsZT7igKbigJ0gdG8gZGlzY2FyZCBjaGFuZ2VzIGluIHdv
cmtpbmcgZGlyZWN0b3J5KQ0KICAgICAgICAgICAgICAgIG5ldyBmaWxlOiAgIGMuYw0KIA0KSXQg
bG9va3MgbGlrZSBHaXQgY3JlYXRlZCBhIG5ldyBpbmRleCB3aXRoIG9ubHkgdGhlIG5ld2x5IGFk
ZGVkIGZpbGUgaW4gdGhlIHBhdGNoLiAgSG93ZXZlciwgSeKAmWQgbGlrZSBHaXQgdG8ganVzdCBh
ZGQgb25lIGVudHJ5IHRvIHRoZSBpbmRleCBjb3JyZXNwb25kaW5nIHRvIHRoZSBuZXdseSBhZGRl
ZCBmaWxlIGluIHRoZSBwYXRjaC4gIElzIHRoaXMgYSBidWcgb3IgYW0gSSBjb21wbGV0ZWx5IG1p
c2ludGVycHJldGluZyB0aGUgZ29hbCBvZiDigJhpbnRlbnQtdG8tYWRk4oCZLiAgSSBqdXN0IHN0
YXJ0ZWQgbG9va2luZyBhdCB0aGUgc291cmNlIGJ1dCBhIHF1aWNrIG1lc3NhZ2UgZnJvbSB0aGUg
ZXhwZXJ0cyB3b3VsZCBiZSBtdWNoIGFwcHJlY2lhdGVkLiANCiANCknigJltIGN1cnJlbnRseSB0
ZXN0aW5nIHdpdGggR2l0IHZlcnNpb24gMi4zMy4NCiANClJlZ2FyZHMsDQpSeWFuDQog
