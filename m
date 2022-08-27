Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5D1ECAAD5
	for <git@archiver.kernel.org>; Sat, 27 Aug 2022 20:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbiH0Um3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Aug 2022 16:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbiH0Um1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Aug 2022 16:42:27 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60126.outbound.protection.outlook.com [40.107.6.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3EF16584
        for <git@vger.kernel.org>; Sat, 27 Aug 2022 13:42:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ARnMM0ZgVswlizeuOjFdy/Nzb1Tia+K8bNceMppC1ecWZ/5PmH+4tVlQG8camlF8UyqnQY+/RfY36WnwuSbdtlwE23UzeEFE8VQvyx64zq7o7ZIMpzomFYde6L6Z73gpqNJR1+LOGihRrDHSHLPSu2jSYfOIfxfAiQwrQoe4lJ7st9HVIfGY5jQXfF3hANzeNCIuwRCPQbnW1wKxoclQjvsAiBh/AFiZlQpbdDhpE3S+1o4oHU5wP/kEo69GA7OMb4yIkTANZpxvEWdnX4ud4PRslqcEO9cbXo98Dy90xbnwGJGRcIj2LMZWInsFo/g0i2zkEnReRCVa82lKmi3n2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DbUtrj/lfq86t0oYjcthqFTeD2Y/L9gajUyi3tb7ZUY=;
 b=BEfn7wC+hP1bbsoY3psTVOdOkFGBcCpDEMUtH08VRuce+CtHeyGIr+GM/bUcOHN93IKvHPcWcfiT/jp7svUNo1BoH18TlP/xVVno/u2FfRRaQws2P6g8nhQEP0CQxD2lyxt/Jqf/XqQylknn5GBpFvduM02FyA4RzZS1/fAmkd78e4g5j9w1p33BVTHkyWx4nxWUKO9ko6DYXiYpQ7/If4ZxDRhZLpcm0WqvQmBOy032wcBXYspbGTvMRCa6rsyE0EWvI3wANP3lhLtGmezFt6Nxpl/y4y5rEOVbAB29+f4JKPrklkFHqn4MZNfs8BdoOS9eOjXPTmPaZqSyA1KjZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sparsetechnology.com; dmarc=pass action=none
 header.from=sparsetechnology.com; dkim=pass header.d=sparsetechnology.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sparsetechnologycom.onmicrosoft.com;
 s=selector1-sparsetechnologycom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DbUtrj/lfq86t0oYjcthqFTeD2Y/L9gajUyi3tb7ZUY=;
 b=2nDslJqTRwhx0aewVjqtTdWTe+Qkbe/z0ip9E3eMbPQbMUzT5OeKszmTPs8O07pdFvlhfsPprNWK8tOEO6zPEZLXsUWshKyKe/d7lH7uYy5/KvmZ2IaGMlh9Ggh4ImWyNeZzTljzfW+0b4UXMPWzSbZCLTOOtPD4Tuic1bmpKsA=
Received: from AM0PR08MB4323.eurprd08.prod.outlook.com (2603:10a6:208:13d::13)
 by GV1PR08MB8081.eurprd08.prod.outlook.com (2603:10a6:150:97::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19; Sat, 27 Aug
 2022 20:42:22 +0000
Received: from AM0PR08MB4323.eurprd08.prod.outlook.com
 ([fe80::d491:a986:c5e7:d83e]) by AM0PR08MB4323.eurprd08.prod.outlook.com
 ([fe80::d491:a986:c5e7:d83e%7]) with mapi id 15.20.5566.019; Sat, 27 Aug 2022
 20:42:21 +0000
From:   Caglar Akyuz <caglar.akyuz@sparsetechnology.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Ambiguous 'HEAD' issue.
Thread-Topic: Ambiguous 'HEAD' issue.
Thread-Index: AQHYulLK5nx0XyLHc0yBFLDTESNSQA==
Date:   Sat, 27 Aug 2022 20:42:21 +0000
Message-ID: <AM0PR08MB4323160241D4341FB1B99CC2FD749@AM0PR08MB4323.eurprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sparsetechnology.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 11064520-24ef-4453-7205-08da886ca3f9
x-ms-traffictypediagnostic: GV1PR08MB8081:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7N3DWuNk0PF4ha0G9oFHugj13zifQ8zAmPtfkVtMggEcnJdam8HGOibGtWsD4RUtvYeoHUnIe1XsT2CCT5hfi1f9l/Y/JovleYuDbo2HeDyteCJDZ/O507nT4g2BSybnL45F+h/fNtulnZViimV7C1LuWrFSv9+HFzRfJB/SJ7jdqe5wTFTUY4IbV+XxH6zF2I972HmquHKXNc+wWEdjoTqjIEetds2TtCJXSbLC0uKnc1Iur4SCRxYbx6yBCC0yxbAKd941643B7IcFdoT+xTFzvtrchWqQx2sMN19UTRGL0TykU9xXcGoy34TBzeDNhcNUk+8yKY7/G3UOM7TdxHW1b7f3Td1c9BTcnl19XtTb+ocVXWx8KoZwWPDGrPxx58OBtzJkS3U0i/g23UDWrh1w73u5FMtE8Fo/5vzoHbItEg91n7rahnruWeIHDciZq2oWr3RLD+cYqNQ9TzcICFyyxKw1yOR8Rq/QNI9lHu4fAQJW/uG0NAeW8ElT4B8ooIITlpynrmmcrUgW3rCr6kRgwuykuTsHCazvxzVK3S8YRIXpAWSLfKyxt5ANj/7xVZsqPPnlSO/s6hYYuGQOFH2IA/MdcPZADavlc+pHr9oDX0uHnzOQhE9CZlgvNk5mdjemGTy/f3Tq8d5KpyQfTG0lGUXTG7OKdGloT0Qd+rkOLc0TwSJvPMNbLfAZNS8kUvOkWB4BVAjlRzTjnbsHdL9aeXQqmYcPN6pjhpAR9xrZQH7mAxa3N9yD2HM1iAuE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR08MB4323.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39830400003)(396003)(366004)(346002)(376002)(86362001)(186003)(6916009)(91956017)(316002)(71200400001)(26005)(2906002)(44832011)(6506007)(83380400001)(7696005)(33656002)(9686003)(38070700005)(122000001)(55016003)(41300700001)(8936002)(5660300002)(478600001)(4744005)(52536014)(76116006)(38100700002)(66556008)(66476007)(66446008)(64756008)(8676002)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?CMglitNuORH9IjBEZauP0SsYsKjvisy0g5a4kcjbvUeWZ/ZrogT1/sJuMT?=
 =?iso-8859-1?Q?jxTZaOukRm/qU9hsbgi+g8oXUodROjF+yhSYnRwUiNEu2aif5VE5W4k1N7?=
 =?iso-8859-1?Q?kJPorMubgUKQVTzo6I+g9k/TGDcVCBPdpgxvf63IK4n2j1BjmX30SdUHfU?=
 =?iso-8859-1?Q?Iur5rchIh25x1DPsrOjSk4XrNRQO2fy+s+oCz9RkFGf50bKxyxROoePeNI?=
 =?iso-8859-1?Q?N0zfItka/eO23VvF3/uZSeUbPys4CID+DB/3gSH7uOsdhntaGKnX7NOitA?=
 =?iso-8859-1?Q?/KfZy04Igq991mwmjQJSXHEiOAp5LPJ/WZFGIescusw0sHhzhNOWq9WURK?=
 =?iso-8859-1?Q?4NPRpptOUPFx87S/hmowpmi7m8Cr0ozmyl2hNgD/IdInG8rbGNO/rshdWZ?=
 =?iso-8859-1?Q?Jb49A40GAu2mebAP9Kh7KS7twLfxFc/wAFVsFKUKLmkVtIAZnqfyi232cd?=
 =?iso-8859-1?Q?kd1sDD3SDljKbdW+gr7EJyl4EeZSS3wYeGTdxnHF5X4GdQtLqDFet8GgRW?=
 =?iso-8859-1?Q?amUvK9o33mTlaP6Eo8HoejFg0DA0rq0/F+VBm5PXZ6s5zTJ1T8MLNpI0C6?=
 =?iso-8859-1?Q?h0zRnf3HUBw69PRy8Y5wYgowXFQbxo8Lhi6OvunjrOJOykD6miO+5Atsdo?=
 =?iso-8859-1?Q?BbgwoDDuopA8c/pLaBnYxJ0TNmG1tTkEfJNqQ3toMIbsjss8Q0MGHwTEcl?=
 =?iso-8859-1?Q?gvGkSjIeOt6JBtEPDO08Su2sOi6Abqx+BNZqUGNzObOmC+CEX20VQpviDd?=
 =?iso-8859-1?Q?zF+/8slx9WqMFNPwMtgUiEIvFOlLKqBqMGH3MgImDYDhRzkukrS9bUpaU6?=
 =?iso-8859-1?Q?wwdp4gGKoxVLO/tfSzeuUOVZEbKasVKssRZ6okZsKGRI83ygP4jiVtmaiJ?=
 =?iso-8859-1?Q?iykRbnna8yq9yDmU4cADcMuMf1p6yYA2b56zkmdl45CPNI2leMntP6K7vm?=
 =?iso-8859-1?Q?xsIuhQYm1duWcKruT6AA34Sd2GahWoC0U9G1c9ZC+tkwqyWDjX5PHuHBbA?=
 =?iso-8859-1?Q?saXpTrghTVd/6ZQqw2J/pzFW75nL6mPvggRAvEU2MU59kP2n3UCwiiDYUX?=
 =?iso-8859-1?Q?ea9nA45OPi5X3zfL/678zxDh8gsdZc7nEJX0dI5ajPSEPyIAAu/bv4RElZ?=
 =?iso-8859-1?Q?fYVZnWbLprXXSUch3xkC1ui5JFByAKXt/unX8TYeKXRjUQB0dUfR6w4ZEa?=
 =?iso-8859-1?Q?SbfhCvAbW7Ey7vC02U4ptmf14eyv+HLJ/a7803MjhDwevqOPhbnf9tz4Bo?=
 =?iso-8859-1?Q?XSe8gvY8+tpCH0V2tEVoqYY8VkM3qSOXogdEMlAwvAyCgU4ZpKAIBkje1c?=
 =?iso-8859-1?Q?AO7MGqVBKC8a40j+/8EWzr9OOSTknnaK3Hr+6i21DWnpRZBIHVsr+UPmbR?=
 =?iso-8859-1?Q?qLppDsuk9VBNp0YEtoGCTW+tLHyVG2uqrhsMLRO2QXlQSkMqg+QakmkTX7?=
 =?iso-8859-1?Q?lTddPCamyKX7pmAOFzcYVwHDQlxZIKvrtjozJOPRZYBy4C0JqY+YRl9mE/?=
 =?iso-8859-1?Q?6RMdhXIMkZnG5WE5lqPkAjixdCQh9L29ZdKwpsPJB/Q5+ZpLQCz4LwNYWI?=
 =?iso-8859-1?Q?LsOFN/0SfHwGflgApeQs+fwgm7rDqyV7vhBB0z+IOTxmz5Bo4loyYjcRzq?=
 =?iso-8859-1?Q?dFXi2o61mh8kIIjIGMcllrseOzimd+bQouL5EZ0AmrvCX+AKN6k1REaQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sparsetechnology.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR08MB4323.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11064520-24ef-4453-7205-08da886ca3f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2022 20:42:21.5069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0fb7b744-90b4-41ff-95c2-686d3964ba8c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pnH+jqF8Dl0uWlU47v/qBt0XBnpbP8CyG4YT0fRrg1JR4okjYAPQhmXiEJ/iPVWH/8DH524uqjHzVOKHKPyuMbCjVXDnhKi/ty3IEcurciCnxLZvNVPYuf6kTAH9H68B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8081
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,=0A=
=0A=
Recently I changed one of my repo's origin URL from gitlab to github.  Afte=
r this switch, I start getting:=0A=
=0A=
  warning: refname 'HEAD' is ambiguous.=0A=
=0A=
messages when I use 'git status'. I check various things if I have tags/bra=
nches to blame but cannot find anything:=0A=
=0A=
* git show-ref | grep -i head -> nothing suspicious=0A=
=0A=
* find . -name HEAD | grep -v modules -> only .git/logs/HEAD and .git/HEAD=
=0A=
=0A=
* git branch -a | grep HEAD -> nothing=0A=
=0A=
Do you have any suggestions for a possible fix to this?=0A=
=0A=
Thanks,=0A=
Caglar=0A=
=0A=
