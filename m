Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFA9C433F5
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 09:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A065A60E53
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 09:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235567AbhJLJZB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 05:25:01 -0400
Received: from mail-vi1eur05hn2238.outbound.protection.outlook.com ([52.100.175.238]:6624
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235306AbhJLJY6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 05:24:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S7efXFLuFlyoDe2HhBwi/jiVdhSLX13MWYTYCtv8+xmJhkmBLh6rKSqVn4TnlLya3WxfmAf/m2TyKTDNGQ8+CP6IFEAU2cMPdUViaBcY+g/qa8fejC3FmOgoarW4XZKsOqvvn51D8frhm5GMlbT9biFLpNDZy9U2a3+JOLmYebup98vHIYf82j4rUwj9qKcBEjFFl44wFo0Z88HHQtaxfNc+t8WXVOLiUmIFF13hTUFc8jmefi87iXXHF4LECk8h/rGEozy/A7NN4eQEYc94+lVtOmbaQVwEdVExxxszW5wE7ces3T4Pf7BXVaIwyl2FJvXi4RAU7d1XT8aSXCtAMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q0b1aoAS/b4pZp/mTheFibjPtN6eq0zP5jlURxpePmU=;
 b=Y6PKebPeQATh6G6GV+w+shb9SdW2Gt/8oyzsnLO5SZ/kMjD3HemLvf0RX7BZvQGcx8vRMMD/b1YUHBL2suFl6ctwbRqXsEOaidHy/ry21qg8yQndYmt4k+gjdu3isT6Eg/xkI3RrDXnQjzhrKZzrUgJMoEosghEBLulDTl/3IdSvJCg+BbSll8qWANRRvaZZK7Tm6Ktcq4WVccPbrarxtyco7wOsE8TmRM9Pd+deHRdZY42HqYCY3h9uhGHfHI2KnpAEMb3wg9nJo2DfmoVAJl8nfYOJ1k7O7gLGmBusK9UvdjqIfZcNAtvcJPEeTkXVEGEuPTB440zPYMm1+ANCkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=campointnet.onmicrosoft.com; s=selector2-campointnet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0b1aoAS/b4pZp/mTheFibjPtN6eq0zP5jlURxpePmU=;
 b=xZrK1VohvYI9ZDgJm9nmFZV27MnRKO7qpl8yrAfubA0awJ/2nCrh9YTBoNtAFDcWHbA+ebQAakF65Sa2CvpqmMYvCv1+fbic0K2eAG5BYlLS0rU5K6NWQi20loVHQMYrW7MNa4/nikHqlLIVHN2fSnTyHDs5nMss7QJIclmuxcU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PA4PR10MB4495.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:102::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Tue, 12 Oct
 2021 09:22:53 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939%6]) with mapi id 15.20.4587.026; Tue, 12 Oct 2021
 09:22:53 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH 2/2] fixup! ssh signing: verify signatures using ssh-keygen
Date:   Tue, 12 Oct 2021 11:22:36 +0200
Message-Id: <20211012092236.619822-3-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211012092236.619822-1-fs@gigacodes.de>
References: <20211012092236.619822-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR0301CA0013.eurprd03.prod.outlook.com
 (2603:10a6:20b:468::13) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by AS9PR0301CA0013.eurprd03.prod.outlook.com (2603:10a6:20b:468::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.21 via Frontend Transport; Tue, 12 Oct 2021 09:22:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f48a9dc-4ac8-4c2f-3c2c-08d98d61dea2
X-MS-TrafficTypeDiagnostic: PA4PR10MB4495:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PA4PR10MB449548065D2D0FF47D9121BBB6B69@PA4PR10MB4495.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/fwQJEM3AaANNcqWD6CMpuVYrT4Pei2jpKUGzIObbaW4dYm8Fh4ssUlhTD5d?=
 =?us-ascii?Q?76HWZryBQoJhb7KxPEsCmMEjVNCuQqmOLR1YqpzwK6+Np1he8HYm+IPCP2nh?=
 =?us-ascii?Q?uf+yXd51r746TdC3/PIh/PEtstHVZ4Sa5YI3z/efS3dsY7Wtr6iCItomwP84?=
 =?us-ascii?Q?qEUuWrGN5bFANxJNt1/gayEAjyaBDbLkyc+T2Hw5GA0/RKh5lu5zaqIa7WlO?=
 =?us-ascii?Q?obrJ6449R8fto+nB+MlfZhfMUbohucF7HQmZ7R0JaG7mgi+iIiQgvZIHBm8M?=
 =?us-ascii?Q?kRDvMMSa51/4fiorLY5SFqvT1VJmiNr46JY15OcXpXksEcy1H6aoFFDQ5oZF?=
 =?us-ascii?Q?WIPHyX2r8l6jvg+FdnRuLfLw6I6i7sjh4fuvXt9m6lc3b15X3vHesjoHoIaE?=
 =?us-ascii?Q?h7eK/aLYMDT39ZAa1vKs7LwXapiCd+k8jJuz0NgPq7m44aVAcPDYS7Ij2tYZ?=
 =?us-ascii?Q?/U7ocOMsFdUIX2e8+CwwdcXbvBoswCb2lWbby+qzs4bM4Z7rTPL891axDF+e?=
 =?us-ascii?Q?WBUgCyoPWCnzTi1nrG5RWWAMv7qYkzNJCrbNGogDYk4Y3nG+ctDnMpU0yKKp?=
 =?us-ascii?Q?upgGny32Ad/a57vOdEI34jCShY6nldDIJm6+t4vP0LjC+Lp38sWWH5Z/JWRw?=
 =?us-ascii?Q?SVsCnKeSDxLqdeCffz6j6VruQ02/B3H98ywEB2qXB8laV+gQz2VTZbhp9gij?=
 =?us-ascii?Q?pM+6AquMmIC6hteztblLsJwauuZMB7mgHMIzkxizTY86vWJl/wuKcKtQL0gt?=
 =?us-ascii?Q?m+y+EumFTB5Z+0ns8fLMyQkX7wuy3EWA/58OQYElN/cEOyBZJH7AllA9m3Pk?=
 =?us-ascii?Q?pv9RcnwItuYsptHeJB0T+tI+zncKYoTchep8GYcLqwx447VOALniFVFQ9Vvl?=
 =?us-ascii?Q?626JcpYqPO86SU7gB7cn8AN/HQRdO5n/78bt1Qc5iwGM2v3t20qDBL85bSHT?=
 =?us-ascii?Q?5BuKA66FT2SCNuPbQCsJhWpKd4gQEXnId6qXbn1p3FokBLRAO60kHmkn9pM9?=
 =?us-ascii?Q?jtuulkCmh02dxvoXxCLt8S6Apg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:OSPM;SFS:(4636009)(346002)(376002)(396003)(366004)(39840400004)(136003)(38100700002)(66946007)(2616005)(316002)(66556008)(66476007)(6916009)(6666004)(2906002)(508600001)(52116002)(8936002)(107886003)(186003)(4326008)(1076003)(6496006)(6486002)(8676002)(86362001)(36756003)(5660300002)(15650500001)(83380400001)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G1xh5BjIDapJqEbtKdrvTefwx2VV/tMd2Cgn/1ME0hNiMLiF8uzH5Mf3kOdW?=
 =?us-ascii?Q?g5fLSVLR1BgPaqJbFef04AEsniD4LKA432xOI3T1K3ZS4pYU4aBvFd/mwsWn?=
 =?us-ascii?Q?3E/Sx9/ITSgZl5ssnrJYvUu0lZZDbhKA6zggOTf58cDo+OlHmxWpYcQqd67g?=
 =?us-ascii?Q?LfIPAmfREsfnAFvBsYaMcpb2tdBCuCnXQhuFS2uOMQyltwo6Xoe2fPHPl/6y?=
 =?us-ascii?Q?V48LYlFAHeh1j9WqH8OFJ8zpqDXuJepOflYwxbbPPM1uJrq/zGyA9GB8aKSa?=
 =?us-ascii?Q?ZdCntRjfpZqeWGMCcq7jhxsqbGzLqJ82xds5PqjOmFO3+NXqTadPAmqsrshZ?=
 =?us-ascii?Q?ov+GkjE4vhpwP8DVMdkusd6gikhCC30wr/hAqgjdsrMiko9s75mEgCmm/Vjc?=
 =?us-ascii?Q?Z1l2VnfyHyF/6DuxRnqtqRckh6zOByid1lTSZGjUp5MMivGiS8Sydk5fZdEV?=
 =?us-ascii?Q?alqrInwLVSQlwbt6rM7H1v0yX3tdhKMO4hFk0c6fXoHhXaDUULPzyyf0RLus?=
 =?us-ascii?Q?7qkq6TCGveVY0JNIqyqtzt0jsUBLmzuYmh3RAXUKEFcQUVqxRbB34nIuszSM?=
 =?us-ascii?Q?CjHYEwrPIhvwztW3GjNfsJ+f+DnJqgc5lFFldwMraswCnOEYfgr58xJoSiy0?=
 =?us-ascii?Q?ccIPOJYiyNdfzTZUa4Tn9+SPB5JXOQSl4BvWJNcOvmzyc27ep/rUzZRAZpPj?=
 =?us-ascii?Q?PcLEGSFDpVzefR+Wql7MgwZ5wODf1F3GFhsfp8IQB9HPuCPYfdSTgSRCbXqZ?=
 =?us-ascii?Q?RyJJKM/QF2fTjFZX12f3qh6zxLeIpR2WOac0azPpORk+M173Udx65xipt6Wg?=
 =?us-ascii?Q?V9a3xbk0ue/23ZsK7DNYc0gBMTAd+D1+BCJ4ZDfE/HG77zxuJgt7rH0ch5AO?=
 =?us-ascii?Q?z3KS4eFGunNUZ3egpWI6wxHbJ960JRqFjC+L6Z2Sh1f9KAJWfdTFV8nCigMN?=
 =?us-ascii?Q?AQKcoT22vRXnb1M05pvhQNJMjfjxX6cxobQNgGhayRGVDXpiKAT463IQSv+R?=
 =?us-ascii?Q?xHQ7DFcWvkReuy51/k/5qfW0JI8AtPknItvwSInZ/oRpPCYnXfYJjHpM3TbB?=
 =?us-ascii?Q?yZjEq9fE1VN4SXye9TbvlS8GNYETUMOuutD0gmeWaEYZ3PACx2UMf+f7fU5V?=
 =?us-ascii?Q?DuNe0YhdL0WsvZNLOjQgZsaoKX/HljMy/LUqzbLRmWl0F9vC77rSbrH4fxkr?=
 =?us-ascii?Q?koG1F/ivLTu4KQUE66flsoNvlffnaysLcnxzNc8b1oWcWDh5TAsjWyq690fn?=
 =?us-ascii?Q?lnrU5Ybr4Yu+AqVBH86DPYlCyI9o6ePJPvjdkZbh3m2mcV0o9HZcDrSha4E6?=
 =?us-ascii?Q?3XbNlCWwli/ImLcvSuHVuW5e+7LyAawTGFFBaRmuga7eM01WjPJUBF/ajnfl?=
 =?us-ascii?Q?siGmPmmpxSsoG28OwNKyj8Z6A+gT?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f48a9dc-4ac8-4c2f-3c2c-08d98d61dea2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2021 09:22:53.6871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C0nR11Xlc6rhuDe2URahKxFoXXrpkc3WDOs1gmoUNwWIBWHa7k4g4oenLI8lnZtkU99HcF/WoETQ2t6XCx/iUvhnXPvzvux6VAP1RJxRHEU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB4495
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This behaviour changed during patch review and documentation no longer
matched it.
---
 Documentation/config/gpg.txt | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/Documentation/config/gpg.txt b/Documentation/config/gpg.txt
index 51a756b2f1..4f30c7dbdd 100644
--- a/Documentation/config/gpg.txt
+++ b/Documentation/config/gpg.txt
@@ -52,9 +52,7 @@ gpg.ssh.allowedSignersFile::
 SSH has no concept of trust levels like gpg does. To be able to differentiate
 between valid signatures and trusted signatures the trust level of a signature
 verification is set to `fully` when the public key is present in the allowedSignersFile.
-Therefore to only mark fully trusted keys as verified set gpg.minTrustLevel to `fully`.
-Otherwise valid but untrusted signatures will still verify but show no principal
-name of the signer.
+Otherwise the trust level is `undefined` and git verify-commit/tag will fail.
 +
 This file can be set to a location outside of the repository and every developer
 maintains their own trust store. A central repository server could generate this
-- 
2.31.1

