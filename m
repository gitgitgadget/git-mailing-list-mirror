Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8B6C71153
	for <git@archiver.kernel.org>; Sat,  2 Sep 2023 13:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240991AbjIBNZJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Sep 2023 09:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjIBNZH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Sep 2023 09:25:07 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2092.outbound.protection.outlook.com [40.92.42.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D358E1A8
        for <git@vger.kernel.org>; Sat,  2 Sep 2023 06:25:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M1Hacjj4wy1fjt4mpKBoLJjxVpCHEtXpWLuyICxhuyNWKDPviob+tJLql3l7xvDqyyWfYGxvwCWFxK6M2MQTUsGn9+TShrdlqdh9+/bfwy/5llWcnj99bcFFDYVAv918Av15AimU5IvO+MwQxLCdgtC2glOokr1PdlFU14fInOVFjKk3et0p/Hrh6ybwk9ZhPLoawhHnIKI30cNvL93yNG53MO145yx81/huBS8cESVj5YlGoVdhTFnB6srCFYqS4EvNVdfCBQ8zSiXqCRffBTTWDJy3OrumChJMTsJyCyND2sxf/G0Xnkt+sI0pb68b/kMLkTooGNnJQfbIRqz9Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZSipocox4r7GwnSdqaZFdQyStU/fQ+bjnkeGNVxfJI=;
 b=VU0zzdX0ImTktPKu+oSQ1471D1egbYaL+WedterlhyO3mz59h8GBSDGQHEE3V/944IMJFQHRE0xzJ3VJlY55pBAIWvMqEEOKxiqfesJHDJbGT0Rf11XX8ENkqCdPMAtsx3CuFTpf2B0YjXXWurCmweK1DDe7m1G4b9Q1GaPdzXmn+xJqWMTypynQSPTuwzVFboMs+Sqqku1h03gW0sPY059Q+xMdtF+0njFnWgcSFPofbPnNuRdU67dV5SA2VUvE6KAMQS9TnVfXO0CuPdh7vuztcryzgXGPZqf1Pm5fnGN/vxfeE5HrSvKNv+4uobkbB93fOi+90kshfKGwo4fdDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZSipocox4r7GwnSdqaZFdQyStU/fQ+bjnkeGNVxfJI=;
 b=Gl0HWUKAANciqKH1pA8gbj7QG0XHoGIt2dYboONhoZ2chHh6QdCt4TOI7WvTKYQ6Q3SFpOX8S+Yk5YYWJkMB2d7lgfNIfwwKKkeOu7HAhQptRP19nupEzZV0NwLW0VnoL6mOTaiohlAb4IUO+wwFtZjl4/fiipLmjpU/JyGmbRtwexOEHfR11yCTKNCD6z+o0OTn2H36cBl/ZSIcstu5zFJzB10anknu31GVA2Cqa8qF0MQ+iNI4XB/13sbi5SNOnw8ZV+6SP1BUtVKU9Jf4RBfe93XvGhNhh35i01rJNqvVM2gM/20enVS0tloChv6o4yDK876CcHXc5V0OS5y0rQ==
Received: from CH2PR07MB7334.namprd07.prod.outlook.com (2603:10b6:610:ab::12)
 by SJ0PR07MB7519.namprd07.prod.outlook.com (2603:10b6:a03:28a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.15; Sat, 2 Sep
 2023 13:25:00 +0000
Received: from CH2PR07MB7334.namprd07.prod.outlook.com
 ([fe80::ea80:5f96:36c5:bb67]) by CH2PR07MB7334.namprd07.prod.outlook.com
 ([fe80::ea80:5f96:36c5:bb67%5]) with mapi id 15.20.6768.016; Sat, 2 Sep 2023
 13:25:00 +0000
From:   ross nicholas Oneil thomas <rossrecovery93245@outlook.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Hello world 
Thread-Topic: Hello world 
Thread-Index: AQHZ3aDfMGGqN8luP0WT2qVhel8mAw==
Date:   Sat, 2 Sep 2023 13:25:00 +0000
Message-ID: <CH2PR07MB733402912E8047DB89F81665FBEBA@CH2PR07MB7334.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-tmn:  [ot8yYAdCthmyuETyVNrWrnt0imUYQnrWjfn9expvH8U=]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR07MB7334:EE_|SJ0PR07MB7519:EE_
x-ms-office365-filtering-correlation-id: f3e204d0-c753-49d6-f1b5-08dbabb80234
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TjxzhvFCccjZmyBNmt+R1v5AAPhAfh9bWGOmnGqGSBIXZj7gt2QTLXLNaTH7uz2lvd1WTi1115ZqKzvha3a4b7YRO6QATq8fxkZNpGypvy5naJduOLJ3mW8yryfaTXBL142yRxmKPLwi2WguApjG4m0+AqmjgdtA9bzBjBT0BCKkwzEFWPcN7s/mrFjJ7ys46EVH9o2RPdDfa1AiqfWgLbUFFmAPIjyEBvzWIKowJtF7uMC0QdVFKfJ4vf9pQGW/kDKFTlMQu+qzj+lE3LcIzsD8Mc3Wn+QHco5iyJbVj/ESROrlPj24K2XJQ9VRGJwVJjHXh3wLE65jRd1Hmow0kktdTqGMQY+vfoeMYOiDkzri9LXfj/eb0+4iMyX1ITHecY/oL9XIuaoL2M4Ch1XCFyV+EPPE5vz//Z5fnPC18A9ykvhLhFOyYpOWbL/s8rU/P63+aXwjmNtpq08PaxZ/rPLfWr9UmrQzGqOnvHfXx+imPMsWz5mb+PZYt4ZCWBVFiI6aSlb/dZ7Ntbftv9HPJUSt193MulruXPcdEaC1oF8rG+2ib9dpX3qRtlt7yTkB
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8uZVgm6/Djo+7JPrBApW8XpcMcr5QzeIXi1d+SULXZYwqsF0PAzeFZCJX8o6?=
 =?us-ascii?Q?Ui4C3sgY/uVPAuBt+ulpeBMCZ2Y/GBX+9vOXzsuP50/vEmcweyXT52NySm9C?=
 =?us-ascii?Q?21ziOhGC4t9DiLCt4/QSv7iwzDTMfEfmUGeP8xj7DUu0UgOoJ+1w0mBSWemv?=
 =?us-ascii?Q?8JOWiNIOdPhLuJ1c13kQ+7hZ6vGvP7SZP1j5BfyKzjZpq0cC+FMyTA8upMtE?=
 =?us-ascii?Q?2QM81grejMNaTCVMIhkR6BwfDVmi7iimNMMmZjsdcQjVONExxb3SCLaXe6gI?=
 =?us-ascii?Q?i4npSBT46hcoxNCzcAWZ2Sgc3YU/fcm+K6RTfpF8jPQhQJ4YQlQ8IHqsCRt3?=
 =?us-ascii?Q?qdjgwy1AUHGXWZF+BgAmW7OpiEL9Xvjnki1BxGNyBFgMDT3NzYqsUozH8cRo?=
 =?us-ascii?Q?swhmZAi4qnagw5pwtoZA+XtlrWSP+5jC2//rK96O/YPv+vQKXxLAF+X2A3uX?=
 =?us-ascii?Q?0HxSWCkW5Vp3Voy++yxxre2NZ2xDGB4FHRtiFfuxm0NO1m+DXZLLkOUgrGnm?=
 =?us-ascii?Q?cOp/Q+5Txo4aHInure1umxXCNUg1/28FTsbgX+5VCkTA1cqCOzxn62c9uTBp?=
 =?us-ascii?Q?ygJRzQYNL5/rfkxF6VSA/C5VnY3bO7IPZ/Dry8/TZdh+9KZbTeGSixQJ6QQc?=
 =?us-ascii?Q?RvRdjb0q2/9s0q/9mUfw1hUKvCbIYVgvhRSG9TldzmSbDy7uD334VPxyQt2n?=
 =?us-ascii?Q?8+kqaEdtFbb/rLvHZ0NDb0y/S1AvLTJpfvgm51IO6batzgQe63uSxmJfI2+s?=
 =?us-ascii?Q?J6lTjsiYIkw4T7vsYH1Qy1cHpKOQUZ05mDItS1gu6r+i7XH2l8PKez4wZ9/X?=
 =?us-ascii?Q?kuWzuJDRmlx668L5HHbbYeG9ogqJ/0eyLGF2VaoT+S+oCfF3Pn++9bfrx/om?=
 =?us-ascii?Q?SuSMpXDGo4LER16nuNy+bWaFRJtpVAqqUrtFI+vBoJrQKvWeUiS6yMWuMrfL?=
 =?us-ascii?Q?G7nLiCOYAXzXz+q4/2agXThOJPA3MYonvhQNXCkY3TAeNmpqfNi30lpfC++D?=
 =?us-ascii?Q?ts/wkQP0OiC2vx4TlS+U0T6XnzMy4Dw4WqaOMiVeKgWxSioKgFOB/+seupVa?=
 =?us-ascii?Q?aCbJk0Hfr2CMllOrpu3f7syJ4yPPZCIZp9AxFJ9nCY9EzNICfD1LqDVg/1ii?=
 =?us-ascii?Q?ur4nM7DK18JLxZYyv/XlL6wU9kNvUwu9o3V0z3bCSQ4ELio2BZM4jLYXo/KT?=
 =?us-ascii?Q?XHVVivMFy+BVPMI8iWVWc3jb4xGRVNC/dRUNVa7hotHrz9XzX3T/mULK7Y52?=
 =?us-ascii?Q?EV0itddi1IpCiCodUmux?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3392C03CB8057D448B9484E6D7F274B5@sct-15-20-4755-11-msonline-outlook-5fbaf.templateTenant>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR07MB7334.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: f3e204d0-c753-49d6-f1b5-08dbabb80234
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2023 13:25:00.2243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR07MB7519
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello hello hello

Sent from my iPhone
Mr.R,Thomas =20
(559-816-2950
