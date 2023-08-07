Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE4FC001B0
	for <git@archiver.kernel.org>; Mon,  7 Aug 2023 15:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjHGPrQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Aug 2023 11:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjHGPrO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2023 11:47:14 -0400
Received: from mail10689.corpmailsvcs.com (ovarp0689.corpmailsvcs.com [149.111.143.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D523E10EC
        for <git@vger.kernel.org>; Mon,  7 Aug 2023 08:46:47 -0700 (PDT)
Received: from unknown (HELO mail10687.corpmailsvcs.com) ([10.188.14.133])
  by mail20689.corpmailsvcs.com with ESMTP; 07 Aug 2023 10:46:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=wellmed.net; i=@wellmed.net; q=dns/txt;
  s=dk.sep2016.2048; t=1691423193;
  h=from:to:subject:date:message-id:references:in-reply-to:
   mime-version:content-transfer-encoding;
  bh=xS6mJyao0S4p9zu7hIzWNzIyrV2Vqv+GIlyjUBySS9M=;
  b=aPe2lVQX2Zny2R7+KNi7ubVpbKbBnlWlUp0CC1wr0xKgwTWmmZ/dyiGv
   3jA4zGvxWhPmKn9jm6vtS8HlhUHOsI4Jh5avb/DI2aaCySTO3wamco14v
   2lVV7bYLqYcBi+Q0k0dsZhU0XZc/i+n/Ya/WmbUyVIzInriVSrvRv+rYe
   P6omgWzpppUIKhoXbMMhshrKm4sKZEBzu8eORBxvNyFo+vXSE4XbWEQv/
   tMG947HNhsDNAV9jDUeklGTdFzpVqMK6t4dUoN3yBznHyK7oad2cyLl78
   MqJ2m2Qs+49dwktaBMgNUzKlJHRRW4oDOzDKFQBUYZhNzDG5K4ddeWeom
   g==;
X-REMOTEHOST: mail-mw2nam10lp2100.outbound.protection.outlook.com
X-REMOTEIP: 104.47.55.100
X-IronPort-AV: E=Sophos;i="6.01,262,1684818000"; 
   d="scan'208";a="50188403"
X-CONF-FOOTER: True
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by mail10687.corpmailsvcs.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 10:46:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eUOrt1cSH6zIw10c918IUDht6cXfnGBRLVUEFcyalNx1CdrOt9/6sJBZ0O3yzOSROFjZgeforGUGZMml18aPxadgx+cCI+blSfrrF3YJygP5+a9CE+PcsgTTTHZ5GJrWE1qYrLfI4AGMYK237Q7rxdX0IMcFDMRZJZru4VjOuk3QT5k99tvhrLa0wW+KlX05WU6xXzUjjc/m+lokBbdMSFlfJ5LRAarIcoV4uW6kdg7YDR8cx5b6Hk9lLTEr3Pxcff1XaOdt0toNSh+KWHiakwe1YIgRlFmhokZZBoSgIL9voN4m83wGGIsHb9o+NAmkJ21VaDnrr9c60IlM+xrAHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1gixEX4FuLrYTSB4oHrjrk8p7Wd66we5Zvf9+jr+bko=;
 b=m0gZaoVTcpDEd04v4AtCLHF33rIumCcLulTdmxEZzzsYuJjy3esvukE2KzmpDlQsMB4yXwacLxf2mjJPnY5HQJVqbpto8rb49uH8VGJ3Y77hpthLVLXHphq9/gFY/lDPp2N9BtQUJtQ+K9OSYJMUIIBIlj++d5JqNO/EJXKARz1dThfZpWwHiqvxw7aMN/99O3l6NWmH8uT/3C/cP1O6kXtF26lDECFV556wTryLDnrvTPA2DnTe+6sTk+uTCsMpuu5HQBRsjrzQAohf2NFC0UYsdt+FC5hT2lM5pbxMgNBTHAPTEKehpha1ZsTLgAcli1e/idbcviveEYsNO8EDBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wellmed.net; dmarc=pass action=none header.from=wellmed.net;
 dkim=pass header.d=wellmed.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=optumcare.onmicrosoft.com; s=selector2-optumcare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gixEX4FuLrYTSB4oHrjrk8p7Wd66we5Zvf9+jr+bko=;
 b=bItbI4Ktf7wp6+zARnBjwvExd/XTSx5QXsmBYTYna9UgT40PP3leqeimHo4N5zJd0vxq3vxM/3E5pOFiQzwWw4omXdYh0PgtQH9EBe1HrdfSpt+Ahes88sfNsUkI7YhtlF7PeAKLyd9c7SXSJJ0pH5vTddZkP5+IurPLhJ8F66g=
Received: from MW2PR12MB2555.namprd12.prod.outlook.com (2603:10b6:907:b::24)
 by MN2PR12MB4159.namprd12.prod.outlook.com (2603:10b6:208:1da::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 15:46:28 +0000
Received: from MW2PR12MB2555.namprd12.prod.outlook.com
 ([fe80::8baa:c5b7:42b2:9dae]) by MW2PR12MB2555.namprd12.prod.outlook.com
 ([fe80::8baa:c5b7:42b2:9dae%5]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 15:46:27 +0000
From:   Paul Watson <pwatson2@wellmed.net>
To:     "rsbecker@nexbridge.com" <rsbecker@nexbridge.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [EXTERNAL] RE: git bug report
Thread-Topic: [EXTERNAL] RE: git bug report
Thread-Index: AdnG8xecm6DeBHiFQeKkAf96rNThYwABgX+AAACQyhAAAPe1gACRr+Tw
Date:   Mon, 7 Aug 2023 15:46:27 +0000
Message-ID:  <MW2PR12MB25557AAF161A92E862AE5EE2870CA@MW2PR12MB2555.namprd12.prod.outlook.com>
References:  <MW2PR12MB25558D1886C4AA2A95A5FC618709A@MW2PR12MB2555.namprd12.prod.outlook.com>
 <015101d9c6f9$218ceb20$64a6c160$@nexbridge.com>
  <MW2PR12MB2555BB4CEE6BA6B38F4381428709A@MW2PR12MB2555.namprd12.prod.outlook.com>
 <015901d9c6ff$43606050$ca2120f0$@nexbridge.com>
In-Reply-To: <015901d9c6ff$43606050$ca2120f0$@nexbridge.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wellmed.net;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB2555:EE_|MN2PR12MB4159:EE_
x-ms-office365-filtering-correlation-id: 5b5ad680-4e3a-4850-c351-08db975d7665
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  1a9cva5SSwRoAr1AiXRCzuHh6o0x47tjLSAS48Ib3+Bk/agE0ZBcHgcE8+HUzwo80qB1R6MYpCPZmIIqZIhbIwtdFiu3bboNaS557pdfqrSoAGI69/NV3pZwiUSaWm86f47Q1equ7tFLQmzawX8jnbBx0If5V1CoK/Rpmwz9hOOx4caP0zU1ME0PvqJICA5NfRzqbrYTfInhmxghw3wB4UaSeH/gwRAmdS8MNGg3ZctHw9tu5so7ugSZF84nExKFTyiTRnd9wlGDwZB2PGzEL6UE1XHh+7rGIAiy5WvtPV2q+wlqmg7fKU9WvxzZLZzU+3EcYr6fDgRM3c8tYkTF4jxtOx8mpsD4BMIzXn0KzoDlyME9A20ZKHeq0SqIUyPcILYS+Do2dpsRkGgLrrNR0rh6VVWEAFAJ9QpwZTzDusyz6gqB6Gkod+dTajT7/KCdPQ9As93zXy8E3EdhkFrXTXZG61uJ+goC33qcOYRsskIL1n1Y9e+HDngcWTTY4fVP1i5vBqpGSi2fY5DE02F/rG+wXvX6TUnDEnMCm21H5x03mDqQgBaIi19v2t/7gQtFDtlvqK+/Sk8Dhix+Cq5XTAgkW7sWuzH7o/T8CNhN4yYpPU3ImUZ6BzXmlMnFn7aL
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2555.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(396003)(376002)(136003)(39860400002)(1800799003)(186006)(451199021)(55016003)(110136005)(2906002)(8936002)(316002)(4744005)(5660300002)(38070700005)(52536014)(8676002)(76116006)(66946007)(64756008)(66446008)(66476007)(66556008)(38100700002)(86362001)(478600001)(33656002)(82960400001)(122000001)(71200400001)(9686003)(7696005)(41300700001)(6506007)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?UGZyWDVVNm1pWlgzU3NVNnowVkJsSlE4SGN3bGJ4Tlk5aU5TaHpEZ0dEamU4?=
 =?utf-8?B?NllndW5ZZlpCR3Y0eFBUWWpRWExTRlZIWU4rUEJnZkVuSEF4ZkVteUduaXE0?=
 =?utf-8?B?THRMTWFpOVpHbVdSb3VjOTY5R2sxTlNaWFozSExUQ2IrWjc1OG5Da0NMN2h1?=
 =?utf-8?B?ZjRkTUVyYlJtUGNobURXcjRpeVJBRk1keFBTTjQ3blRRZE8vNFQ4ajNoejFJ?=
 =?utf-8?B?cnJCdkk2MU1IVml0cmZTSFRKZFpCY0xjMXIySzhSSmN2dGpjTGEyQ0txMUU3?=
 =?utf-8?B?SUVCR3o1aEJxU0hEQVdFRSt1d2xDSEcrZ1UzaXl6ZkswQTJnalB3RTE4azF6?=
 =?utf-8?B?TU54NE9IWWVWSWZ0YlRNNi9hL3NrWEpLc0ZNYW8rVWxqT1Z1MzJrM041eEtE?=
 =?utf-8?B?WTQ1OStXQlEveHJlUzNjNHFmWVkwWkNTaFVsbHFuNjV5dmtTWTJXTWxZaWto?=
 =?utf-8?B?VCt2N2k1M1JyQ2pwQ0xqUFA1WUpZOXNGTDNDWWxGcWV3Wkx0RFNlNFVLK0Ir?=
 =?utf-8?B?Z0VrREhnd0dHanU4V2FTbi9QV1FwOWZWV0NsbUVBSXNPNjVjR0pSMjlwenRK?=
 =?utf-8?B?Mk45czBhaWdyVUNEcjdLNnpLSlZNSXJVbGg5c1BBVktDOXRFY1JDY0pWSVY2?=
 =?utf-8?B?V0hweWVySDZTYzdLWWpFQ1lzQTBWQTk2ZWRUYU5FOUZSMFZ2czMxYUp4TW5N?=
 =?utf-8?B?Z1Z6VFB5U3RYQUNEUThKRXFvSHRWNE1BZWUwMW9Gb0puY2Y2d0M5bUo4WWRO?=
 =?utf-8?B?MGVkcU9QaEFrdTdmLzgzQzFUdmlybWFNWTN1QzRYMHEyR2s0cnF1QUxGTWw2?=
 =?utf-8?B?UVVKY2IrY1RYWWxQdU15eGJObk1YNW5COE8zc3c1UEFXTmRQcjZwb2x6TUlu?=
 =?utf-8?B?eE8rL01qWFNjaUFGWkJBNi8rRWFTbHJBN2hSenlWd0tSN0FvMlQyeWsxc0Fh?=
 =?utf-8?B?MUp4SDk4TUtkVTFycDI5aHpubzVZekp1OTFsUWFKT05manFHSTI2OVNXUjdq?=
 =?utf-8?B?WHZmYXJiV1o4YktTejJxeUFIb0JzMDhJTDFscGlkRXk3QTEwSlhFZldyWmk5?=
 =?utf-8?B?YkZ5cUFtcldBNGxqT3Z2RlQ2U1hvamJ3d1NoY01yU0pZZ2pDMy9TRUQxN2tn?=
 =?utf-8?B?QjJTd0x5Z1lxREw0TTNBckt5TjM4WHhYTTF3K0wyejVMd25hVDU5MDBIemg1?=
 =?utf-8?B?Zk1kVk8wNk5YOGhmSGVuQVlZTE4xZkZNM1ZpRTRiYUpIeUJsZHFWVXBNcGlX?=
 =?utf-8?B?ZzBxZ29lc3VpNXlabkVELzhWUTBZZ1l6blJaRXozNmwvWGZqRGNkN3VuTlpa?=
 =?utf-8?B?TEZ2a012OG5DMHZnMG9CdFA3ZFkwbzQ3WGtyaHZmalBIR1hrMkFuekdvMWpl?=
 =?utf-8?B?SkJaNW0yazZMNjlDTUx0ekVhd1RIb2FyM0tYSm4vUEpEUnM5YmpBN0JJNWdl?=
 =?utf-8?B?eDNUVTYyOFNGR3ZWd3BkNmY3RXBQNkE1SGJrM1p6dFJybXhPbnpnZzNLTWNE?=
 =?utf-8?B?eUZZN2ljVXNWR0Q4Vm9HdGZqMGxseGJlbU1CaTQ3Z1FieHNDcUY2SnhUdDFS?=
 =?utf-8?B?SFM5Yk83Mm51VFUwYW5GUndwS1R2NWNNTkxZWnhoQWFvVk1ibDVSeXpuTGUv?=
 =?utf-8?B?UmRaSFR5TUo4ZUhDRTV4NUF1cEJ4bExUcGc2LzduRWkyTjdBMnpOV2M5cWtX?=
 =?utf-8?B?WkZCNmpDQXZWdWVqbmh6V3NJL1BwWTlUYmk0QzR1SFhWellCTm9NTjJ1UE1o?=
 =?utf-8?B?TVQrM1Y0V2ZxcHhMTnY0TFRpRG0xek94MksrMUxxNTVXbVFDS1RaSm1kRHRT?=
 =?utf-8?B?czZ1aDc1b1ZWamk3aDhvdnBrYkQrc0NMbW14KzZFcmR6aE04TTlFTWlEV1Ix?=
 =?utf-8?B?M0s0eG1NbjFSd0xmYVhLaFJhbndpcGNIcjJCMloxWGZHN2ltNXlhMnBCZDFG?=
 =?utf-8?B?aTY0YStMZFpwSGtGTUxMOUY0ZkpzbHNHTE9OUDM5NDVzOE1Bakx1T3c5cUlv?=
 =?utf-8?B?Qzh3TnFzbnlwUUNJS0NpeW9YM3hZbU1HV0IweDlPbVkyK2xOVTdSL2c4RXlS?=
 =?utf-8?B?aU13enNUakJzNzZNSm5GZHMwVnJPaE5Tb0hvazIzdld5cU1WVWZHTm56N09i?=
 =?utf-8?Q?U+/M5EPLTlJQwGfT886MmgZ8Q?=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:       w1MRdW4rEdLn/HfbI8no2WJnx+7a9x5Y8MdkiBfY1dlinQTFDhRurKfu/Vo/wcg/v6twesrRoGBjNk1ZjvBhNQ2LOU7pN+jAe9DhOAETeJJSSr4LBmukrZ+8Th6qneEOefU0uVg/9dBsb1xlkhVaUeRe5dAoMHqo1BR7gbjcE5+UDcrfyRXUxmQPtFHciRBrCYHZfEZlWwLUj4AkLekJnXOQ6s+4VZGKhqvdM1bnkuHzavzO7BuRzPGZoQ4Ml3cRmrmf9TiSyq/Tf3Jck9UbyiHL4jYMQLOFfISo4vr4TPkT3D76jdUv1pi99RQh7rUxZx+m8KHeh6WXjBHiHtFFMSBElU1Rl+Q6Flyr3F2uEutdxpjJtv3mi5rITEKQueFZmnQmWk+ZvJmHSbojMKE1mF3wkAcgl6+PJPFf6wjEBlM9fmbaG5DSefLKC8ECMm28LlBB053qXhMFhKY/HgTd71o7w3QHPYjxgLB9tS007bCRaBSF+fv1gizydfrKPVTpcrb4NyHJ3a2RPm3niHN6TnYGrWSEE92lPIcFy3esFm5IoxcuHf0v81V1Px6kcsmgWfKksTrTD/3LsGgzQ+b7TJZDhcc0E6rLhdwo/YsGt7YJSHbLJM9hv5OpZ8ix8rSUNfOqM9oXRF5kcVKFOElQVK0SF/BVKSvROVrDalImduKtYifxCqRMvseAlwfy3nI+r6ri91WFhWErP7H3S1VnuFUJgP7KSDMvgmEJdn7bBuR4pkt0E0bcpR/mboBqcbG7gW9ndEFxbZGKkl6egRafJA==
X-OriginatorOrg: WellMed.net
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2555.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b5ad680-4e3a-4850-c351-08db975d7665
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2023 15:46:27.6857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 85f46a4d-265f-41b9-aaef-c494b7617e7f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fb+Od3lphHb8yI3pjXTuZW0C9TG8mFUJvRFw1dvjkWe0XdVtozd6WuNyMSVavNpWpOD+IAsRjGTiGbHh0MwioA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4159
Content-Transfer-Encoding: base64
X-IP-VFilter-R: R
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

RnJvbTogcnNiZWNrZXJAbmV4YnJpZGdlLmNvbSA8cnNiZWNrZXJAbmV4YnJpZGdlLmNvbT4gDQoN
Cj4gSSBhbSBub3QgY29udmluY2VkIHRoaXMgaXMgYSBkZWZlY3QuIFRoZSByZXN1bHQgb2YgLS1z
aG9ydHN0YXQgaXMgdG8NCj4gcmVwb3J0IHRoYXQgdGhlcmUgYXJlIGRpZmZlcmVuY2VzLCBzbyBp
dCBpcyBwb3NzaWJsZSB0aGF0IDAgaXMgY29ycmVjdA0KPiBoZXJlLiBPdGhlcnMgbWlnaHQgaGF2
ZSBhIGRpZmZlcmVudCBvcGluaW9uLiBJIGNhbiByZWNyZWF0ZSB3aXRob3V0DQo+IGluY2x1ZGlu
ZyBhbnkgb3RoZXIgb3B0aW9ucy4NCg0KVGhlIGNvZGUgaGFzIGFscmVhZHkgZG9uZSB0aGUgd29y
ayB0byBpZGVudGlmeSBpZiB0aGVyZSBhcmUgZGlmZmVyZW5jZXMuIFdoeSB3b3VsZCBpdCBub3Qg
cmV0dXJuIGEgbWVhbmluZ2Z1bCBleGl0IGNvZGU/DQpUaGlzIGUtbWFpbCwgaW5jbHVkaW5nIGF0
dGFjaG1lbnRzLCBtYXkgaW5jbHVkZSBjb25maWRlbnRpYWwgYW5kL29yDQpwcm9wcmlldGFyeSBp
bmZvcm1hdGlvbiwgYW5kIG1heSBiZSB1c2VkIG9ubHkgYnkgdGhlIHBlcnNvbiBvciBlbnRpdHkN
CnRvIHdoaWNoIGl0IGlzIGFkZHJlc3NlZC4gSWYgdGhlIHJlYWRlciBvZiB0aGlzIGUtbWFpbCBp
cyBub3QgdGhlIGludGVuZGVkDQpyZWNpcGllbnQgb3IgaW50ZW5kZWQgcmVjaXBpZW504oCZcyBh
dXRob3JpemVkIGFnZW50LCB0aGUgcmVhZGVyIGlzIGhlcmVieQ0Kbm90aWZpZWQgdGhhdCBhbnkg
ZGlzc2VtaW5hdGlvbiwgZGlzdHJpYnV0aW9uIG9yIGNvcHlpbmcgb2YgdGhpcyBlLW1haWwgaXMN
CnByb2hpYml0ZWQuIElmIHlvdSBoYXZlIHJlY2VpdmVkIHRoaXMgZS1tYWlsIGluIGVycm9yLCBw
bGVhc2Ugbm90aWZ5IHRoZQ0Kc2VuZGVyIGJ5IHJlcGx5aW5nIHRvIHRoaXMgbWVzc2FnZSBhbmQg
ZGVsZXRlIHRoaXMgZS1tYWlsIGltbWVkaWF0ZWx5Lgo=

