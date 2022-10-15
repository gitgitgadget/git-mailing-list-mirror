Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA85C4332F
	for <git@archiver.kernel.org>; Sat, 15 Oct 2022 10:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiJOK4r (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Oct 2022 06:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiJOK4q (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Oct 2022 06:56:46 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03olkn2098.outbound.protection.outlook.com [40.92.59.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAE34E618
        for <git@vger.kernel.org>; Sat, 15 Oct 2022 03:56:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HeRvY3R+I6Xpls/LD1KDOtpwxUsFC/EQQkOXG55+nlS0/vkr6zlYIe5ZtXyNdo+Xocj3MBZNFGawnsEvP0E69jsxNIPBJL4Zx1d0PNkhMjVNXDXFPEeYzsUQUYsta5XVEo91dcVxEq/sy+anfpOV56Gt0V0j7EfjicQ+6hLSm3tm3+LmnvAREMhe9//iPycwYfwtfbrkrxWv9t2Tl+BQY2twyYRATktri8SJ1cztZdRwFN0IdvVB/0OtqI0Dk20Cac6X/FLR8VJZ3Gn0UmT1OMsi6RE/4XftWA6iv0Z2SVon93G9VnKGQaXQhn/mgpwhqxDNZzOv1+mm23II7uh9lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WlU5Q2YVx9xjfw33twznUqi4WWMxI8++SxQL7owsqag=;
 b=Uy8roWTXNEq3eH8UDVt4svh6RfPio5n5l6DiCf1K0wRS6gDQb6ZEsklLuOSHhZLsHJX3TMczwc9vHHt63+lyBVuabL6Tu/kvr9RZBpdKzXWHJQQ6N+Hn9BHndLbSDRMSzIzJzbu3EVugUtLE75UExH2C6jS0hG8Y5/2Ca90G1LB/C3NE+cxfIuK4KaTFPDc/GTX747wBy6/uPSv9UKyBuR9avnc847N4vJEANnfjUtxanqMPPg5tg40SYnEmgkD2YCkcj878tWWCe8+L3OUTUjeh0k6pK+YMBVxkp5aBYqTDld/RF2eiHXf1FUSrlleeLSnbUH+xVSaaarpP8O+Kpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AM0PR04MB6019.eurprd04.prod.outlook.com (2603:10a6:208:141::13)
 by DB8PR04MB6858.eurprd04.prod.outlook.com (2603:10a6:10:113::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Sat, 15 Oct
 2022 10:56:42 +0000
Received: from AM0PR04MB6019.eurprd04.prod.outlook.com
 ([fe80::f4a7:7eda:2353:ef81]) by AM0PR04MB6019.eurprd04.prod.outlook.com
 ([fe80::f4a7:7eda:2353:ef81%7]) with mapi id 15.20.5709.021; Sat, 15 Oct 2022
 10:56:41 +0000
Date:   Sat, 15 Oct 2022 12:56:38 +0200 (CEST)
From:   =?ISO-8859-15?Q?Matthias_A=DFhauer?= <mha1993@live.de>
To:     Jeff King <peff@peff.net>
cc:     Elsie Hupp <git@elsiehupp.com>, Junio C Hamano <gitster@pobox.com>,
        reto@labrat.space, philipoakley@iee.email, git@vger.kernel.org
Subject: Re: Multiple --global config workspaces?
In-Reply-To: <Y0m64fHWIjZoXoTQ@coredump.intra.peff.net>
Message-ID: <AM0PR04MB60197E29A9D11F3689C03225A5279@AM0PR04MB6019.eurprd04.prod.outlook.com>
References: <C4E3A512-2E2C-4EA5-9F2E-3662BCF0F165@elsiehupp.com> <xmqqwn96x61t.fsf@gitster.g> <Y0Vr/4IeA236nxzF@coredump.intra.peff.net> <03B277AB-DE33-443D-AC9C-FAB7A2F93AB3@elsiehupp.com> <Y0m64fHWIjZoXoTQ@coredump.intra.peff.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-TMN:  [5DozeqFzfjPXSjcweRvH9m3e9CBsM17C]
X-ClientProxiedBy: FR3P281CA0010.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::9) To AM0PR04MB6019.eurprd04.prod.outlook.com
 (2603:10a6:208:141::13)
X-Microsoft-Original-Message-ID: <fe736125-3260-3282-9c87-32a2ddfa3965@live.de>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6019:EE_|DB8PR04MB6858:EE_
X-MS-Office365-Filtering-Correlation-Id: 811eb190-2755-450d-48bc-08daae9bf0b5
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UnulpAGWhwKqUbJPfXMik5CYcCOtLM/i6PqJM93paI31X7lkeRdl/XHnyjG4yykFxoIIyuV4vZldcp7Ri7jQescXiDxLSehDbm5fMUGH9NPLXuzo1Nne0eJorARjaVzeUUDJKOeZ5UFbSt+N1hibDQRFclws1ANXyaUdY/E7jCJqGsAdqi0yY1u9jcepMnQDtAeeOHhsW+r7BxdGSO7IatdxHGzcWFRJgdxZ7W4lRq4xJG9HvIT+N3lJeOoVIPmjkJOmIwnMUNSRiY5Foz7uJ3227DvoCMVPw8S/eeVUGblN0ObgW5nhePwt8r0epl5gy98i8FMRh74XL39ea7lYYM6YN5wyamJXznk4V/36lEGyGKo1RXnsv0ZgefZHFvFcKuvIurqEktni1/7/fR7gAe02HVfxPsCwwrTUHtiGASgPbnaQRAWRNQFQypGFUXOwpOnKT2VwH/Bw6kV3iHtkBQ9KhIGdzsavpdnA7Qs5u+2EdM/uJZzuwTRPgkExQL5vNqEbdpF9fvY/W8BkRriDpQ8XbxjWtPf3uOVN4XXtufcZ7VUHAAjbXUXqNUlFws5Wh+1c2G7pB9P+NJEKLN0QTCGa0duY20E4ktALFjYHcf6RHCNrgri68FHON0sEXlEZG7Ke7p34M6Syc68KCxu9ieDHO5SF1XhUujP1nGoHKokIOyabWgjsozNjNZ/x/bBi
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bmZBJv4Tu5ljB2BjUwC5GAMW8Y/49tlaTXK4/krSu52oRa/RnxCa8M4iKywt?=
 =?us-ascii?Q?5eGjDBbea1P6oTRgSsDAIv0GG+QZK3AlGRvWr9VcNOy7xqB1cZHp804ceJ+f?=
 =?us-ascii?Q?+W+02uMziUnjTiZyuCxj9QsKPFKa5HNT55l3Adb1VK1XurGLm76rzgyNgw8e?=
 =?us-ascii?Q?6ztOEzMzma/8mDRf5lBWbQqzjHvgg8LkqEbPaVHg7xojc9xknBBlEd13YRAZ?=
 =?us-ascii?Q?KONzRHGlNsVY1DqGIw7omOc2NTK+Sdeo6p2C7N7y0F7nm5AFtpxP0dzKsBlE?=
 =?us-ascii?Q?CUWKlNNzwgctnW0wdgGxxKxF9amZTDP128Wsq/8frkzUWSpPZOEvz/a7e2uO?=
 =?us-ascii?Q?vOmyjBPCiBLaildAiv3uGVZhTP+KrA9nCiZiLHEYcJ42n1DB3OsmyEYUpbzd?=
 =?us-ascii?Q?Px2zWxRmI6jGXGd84WaReU7xF/Se0SVIv0FLXwx5NpIBcvfcO6CPIWlVajwZ?=
 =?us-ascii?Q?m2+RkZGr6CUxr2ivB9Q2E5xJT9VWOBBiYjk73dXIa1ro4fbStBTOghGhUzyK?=
 =?us-ascii?Q?d9T/MvykZHzUoNQgYmmVY/11lUt/8XPPm0m0tui/rZwu0JBPP3mDIplYv4Oc?=
 =?us-ascii?Q?nPisFyJjrpGsDVcksuqVRutBVPs48dkM2/9BIJB9ymoE97yvgFu1FrkRPr+r?=
 =?us-ascii?Q?SPwbuc23gvV8otWagoi7QxCn2lK3c8Ky2ccCQhu9syx2+2vzn2cq1ZlZQFbf?=
 =?us-ascii?Q?H7jFFUBHbW9jEH+DjnlZGatIAGMTu4NwadecuG3v1fo87j3muZLGF5pprev8?=
 =?us-ascii?Q?b3JpzpFvDLR5fs5dRGZWhSFFY4OGhWgftGPy6huUSn1hX0Drq45bba0b7228?=
 =?us-ascii?Q?uE49Hu8tpgle9CpN8G4BwLVDRvzUTVwV21h0WF8kNkdhNjoF8mD8ftW82Wb/?=
 =?us-ascii?Q?TPPstZbUSiTE1FUXUXurpX3u1vK2zBbFEiOGsk9owLhSouQs6zyEJOkXH8vk?=
 =?us-ascii?Q?fTmtNC6QWWiKdoO7ZafF15OjgT13rbRZWSIfVzFfqCAh80hh00Qfwd6JGAkj?=
 =?us-ascii?Q?ppwa+T0Cd8gAAA+FtP78ac1I+uxFhI2X7ksB4zGAaD0W2otlso/k65Yu6KBI?=
 =?us-ascii?Q?tV6D9YgPSiKd/Lq1huueOKL4GnF/BvIlBuvEp47cHst6dvRF6r2WZdSpimuU?=
 =?us-ascii?Q?EBEsiJa0BUsUY0oaMYIIlhb1Tuns8N7CqwRmjHpD81EWq5huZqvRh45SCRS/?=
 =?us-ascii?Q?fI5eefbuk7rxoOpZUJZkqjR4x5c/O3dLtnZBASAEs71jtzpxuChsKj++SJEP?=
 =?us-ascii?Q?MvVEu3d1vcO1DORBt69a?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-03a34.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 811eb190-2755-450d-48bc-08daae9bf0b5
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6019.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2022 10:56:41.5109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6858
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On Fri, 14 Oct 2022, Jeff King wrote:

> I'm not sure who to poke about updating those other sites (or even how
> old they are). The git-scm.com is maintained by Git folks, and always
> has documentation for the latest version. It also shows up at the top of
> Google results for me, but given how personalization works there, I've
> no clue how common that is.

die.net is often quite high in the google results for me and from 
experience seems to be a common source when looking up man pages online.
Their git related man pages seem to be roughly from around Git 1.7.5. 
They do have a contact email at the bottom of their homepage. I'll try to 
poke them.

Best regards

Matthias
