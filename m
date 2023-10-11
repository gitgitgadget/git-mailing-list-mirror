Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8044BCD6E54
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 10:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234416AbjJKKLq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 06:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345729AbjJKKLf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 06:11:35 -0400
X-Greylist: delayed 303 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 11 Oct 2023 03:11:32 PDT
Received: from smarthost2.atos.net (smtppost.atos.net [193.56.114.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF478F0
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 03:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
  t=1697019094; x=1728555094;
  h=to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:from;
  bh=5eFdcP2EimaW6DkbVP0PRuiNQQpDxwsIf+Y0ssTvulo=;
  b=p3b3i2JpHCPvokRl/bwQ7zXDfJoD5CsZS4tvcRRwxOTtEyszgdhtm/Ne
   vRUxLambOf5kgoHrXmrAVMfQ38jphDCsnniQtOsCu9TlVMyOHQjtvavnF
   bgM9l3Fv5fpfOFh4yJAgTPwqf+YICETlltTgkKz9HkIraGt262v+MCWWV
   eNlbXLNPqPcf5qejUeVdzPZUE7YqKaXf4YahHof8N1wuvJz+/mDnuEoh0
   y/SvNowNEpzk0q+VNRG5cfWt2R7b+6jfynWoplR5mIzcn9xWMj9I6yXxE
   yXpXAj/yc1SVB9lRaNnDyDXM6xV3ko2TLPXy/9L+CLagSo8rcpA+vZXXR
   A==;
From:   Richard Kerry <richard.kerry@eviden.com>
X-IronPort-AV: E=Sophos;i="6.03,214,1694728800"; 
   d="scan'208";a="574870866"
X-MGA-submission: =?us-ascii?q?MDHVHXtTHAzO4xyKeMSHOTYFWfc4t5B6IYaM1B?=
 =?us-ascii?q?4W4+nsyhl32qZ345azkRs/WiHYUu5FBNSNeISMUOL0BRDkTInI28qlFM?=
 =?us-ascii?q?Aafq6PYrpenv/bC6BkEcDBo+omwOAU3qhhr2WUKCCoBxRHB1TpNU3non?=
 =?us-ascii?q?Se?=
Received: from mail.sis.atos.net (HELO GITEXCPRDMB23.ww931.my-it-solutions.net) ([10.89.29.133])
  by smarthost2.atos.net with ESMTP/TLS/AES256-GCM-SHA384; 11 Oct 2023 12:06:28 +0200
Received: from GITEXCPRDMB21.ww931.my-it-solutions.net (10.89.29.131) by
 GITEXCPRDMB23.ww931.my-it-solutions.net (10.89.29.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 11 Oct 2023 12:06:27 +0200
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (172.16.214.171)
 by GITEXCPRDMB21.ww931.my-it-solutions.net (10.89.29.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 11 Oct 2023 12:06:26 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O8t2odScq1DSaL9DLnnKM8TRb32YkybYozebwLq0iuMRGpr9e/RHLm/WRvIyUyD4iHSTBHPaOjGAv/y9W6H+6yuTxug1VuxB/0Z5u8iMGL9k6xyNkFVlmzrAgJfWG2WGE16X7Vx362mlNXYwE/EYMmIILPm56qt+38aIRNj+m+uB7Bksylb8+HZaZ7Xy2VGo513w4qMDCB0z8EtS5q3GpKQ58ZQxx9RMk6nNx8leZdwQZ942cPiGT07TgOYMhlr+IA8KxDlG3a4enNUt+l4yKnnOTBAbd2FVRRN2+McgDJOzwU1P0c4E4FeVwQdNCVpV81WZZ3o9lZk1v6tTc1OBAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jw4dCR6mY6MT8iz3pWTQrRvVMsJLv9r4SI9xPea9FKI=;
 b=BmR6iWQvHLgIH+P5PU9b1Bhqz/6v86Ktmr47KvQpEz9+VWjv3ZU3lf0H7aYVNrrMCXXPQZU+w2ztgB8n6HCg7yFxN28jO7RBT/TnolQ/rK39WAaxyp/38TitXruTJZ9OE9+Q7j9kWNHUea70HIS+IqNW6YOnjmhfvFxgSe7Ggho5jDQRgEt/mULNUKGnPBF0qDSJ6cjDG0yRW43BygCrLjt+dWqT6JllgU6YqJl62NaU6QmXjIlQUXYdCQ+WFfOhZmagaf/7whU27TQhiy8KFmmdwztJ4rBZCvgNUgffOfV2+tcDITLqGNPur0g6Wkpr6SXXiTooQ6MV/HfzJhY8kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atos.net; dmarc=pass action=none header.from=atos.net;
 dkim=pass header.d=atos.net; arc=none
Received: from AS8PR02MB7302.eurprd02.prod.outlook.com (2603:10a6:20b:3f8::19)
 by DB5PR02MB10138.eurprd02.prod.outlook.com (2603:10a6:10:4a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.45; Wed, 11 Oct
 2023 10:06:25 +0000
Received: from AS8PR02MB7302.eurprd02.prod.outlook.com
 ([fe80::24dd:571e:29b0:aca2]) by AS8PR02MB7302.eurprd02.prod.outlook.com
 ([fe80::24dd:571e:29b0:aca2%6]) with mapi id 15.20.6863.043; Wed, 11 Oct 2023
 10:06:25 +0000
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [RFC] Define "precious" attribute and support it in `git clean`
Thread-Topic: [RFC] Define "precious" attribute and support it in `git clean`
Thread-Index: AQHZ+3fqBVUJcOhJWEObFSh9sRP3prBDQI5NgAEXGAA=
Date:   Wed, 11 Oct 2023 10:06:25 +0000
Message-ID: <AS8PR02MB73027943EE0A30DD8DAAD4639CCCA@AS8PR02MB7302.eurprd02.prod.outlook.com>
References: <79901E6C-9839-4AB2-9360-9EBCA1AAE549@icloud.com>
 <xmqqttqytnqb.fsf@gitster.g>
In-Reply-To: <xmqqttqytnqb.fsf@gitster.g>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_ActionId=9ddcd97d-f5b4-4846-9df9-c2c8697911cf;MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_ContentBits=0;MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Enabled=true;MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Method=Standard;MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Name=All
 Employees_2;MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_SetDate=2023-10-11T09:42:48Z;MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_SiteId=33440fc6-b7c7-412c-bb73-0e70b0198d5a;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR02MB7302:EE_|DB5PR02MB10138:EE_
x-ms-office365-filtering-correlation-id: 387d7e4d-234d-4ff1-5e31-08dbca41ba61
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fz1Jb4OWg/UvnUGdReCrHtAxSypOWUlcxEL/3B9dyr63N4qHhr/wbaPvN5rzeqs5DXJpdW6aOpYfIZl4sSV1HOf6GhlrmYoum9YZWkVdqewe86jJVGxq9QC9J/skPMbdtKpaWfK6/235MDUkS+OCqy/sjYWGNgK9rtNSxX4uNzFqGRk06ZLd0obWWXitQ0WBLWG/DD1hblGdiMqSZaS0WveRY17mT4FhlAklPGpWATLjnekKK9VOgxg54n63GgWtU8gasM0tCYrpksIbptF7VZWAZelrK1orUYboFsMd8CiCU2VTbcx+Jh1SWyNMrcwbG2muz7kJ6Gl1i3+YXteFeyT73wnz5lGlI6COy4La58gfc3DoJdJDK7tFiUOH/zrAD2APhEaj2PNmUjvZ8DD87Yt0QVNKLxxoa5D16FegCT+00usPMYVuuvqWDtDiqIhjZsLi2uzEProXW154RGAZLs8hoCqfc1XxvXY532Kqv01967+IyfjisU2r3iH1bvqDFDfp5t75i+J2OMS8EY7QSvkfzxyCHL9t8/9lZhp+1qOFIa0qDtorOSDZ9DZjJOOI8dEPW/OWe1yABy+LDBEekLXG8Jy/Qfu1ayR28Uf3/WTPK20ARr3ygLBngTESKDVQepwL6DMjpMPqBxxDTLK7DQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB7302.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(346002)(39860400002)(136003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(26005)(6916009)(66946007)(66556008)(66476007)(66446008)(64756008)(316002)(83380400001)(55016003)(76116006)(52536014)(5660300002)(44832011)(478600001)(86362001)(6506007)(7696005)(8936002)(8676002)(71200400001)(82960400001)(122000001)(2906002)(38070700005)(38100700002)(33656002)(9686003)(41300700001)(81973001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?x71g87Pp79kzXnn8k7O+gZcOJOVZn4EWWVvrVqWfXKYcnrObcHr3bMXOfkpn?=
 =?us-ascii?Q?GUerQtNcrcjdceMM8027RYcPDWMGm/Q1ot8/IWgg9JtcNLG4T/EabHOZKAzP?=
 =?us-ascii?Q?rwGIxHVVAHjhd05ZewfTie7em34PQdhoFxXJaItT694hT7y8krqrBd+WHEMw?=
 =?us-ascii?Q?kP+YL5/ZrDIRHfVub6LXuM9oj2t/tWJ6YqZSaCo9+myOzRtlR8py9RrhvHcd?=
 =?us-ascii?Q?258+t130Rw7tciTD7h83OTX12Er4ouPZB8FufJ/iel9VniTYaHfatIqcRnrc?=
 =?us-ascii?Q?++WvSVkKVn9ib7bddopP80mWR3I+fZR5JQYuIp9fdMHVhhx1szujh8LDrZwM?=
 =?us-ascii?Q?QYEsHYcdL23whTKJ4mOYkOARnBQxvEwbMEDd51tFD1PbXspXw2EwupvkKqAO?=
 =?us-ascii?Q?k2ud83m0BuLTmbxfZ2s1WFdPKDJ1vPTHeVrWT7jCj1UA8x8FVfV0nT8PX6ia?=
 =?us-ascii?Q?9LoMRnOKWQ3LwSjNesqUejJoN/5yQIejgxmERljftpmPCw+/w+vRoSRO8aZ7?=
 =?us-ascii?Q?gs6OrPDLqKkIptM5bWhSBZIJU3xtyPiKC4KQ3daUUTrQQuIde+Jh5Cy2WD0R?=
 =?us-ascii?Q?w//VHrPyarzQslAm9zPDOSDAxqm/OiMqNIos2tJbLmHDyBWIiBSESPuCp1YV?=
 =?us-ascii?Q?sG7FObwvgPtojns3LgCB3MruTW9EPxSEumfhYCCABRNVX2jvARWrkBwDCayI?=
 =?us-ascii?Q?ybVXB5CUtmT6i0zzlfwZCiIhv6npPlQ7waov4mdarzD94Lxn2bahS7nqAww8?=
 =?us-ascii?Q?AlFYV6jmwbnmjuXxFj1sfjmX3ZwVvfyOeHWdFA1AJJc29YYHo2hq3qYMZlXK?=
 =?us-ascii?Q?/XM++onH7FuV5AwTHcpdIWyGfqtxkDnDfsHPwvECacylMW/bA7f/ug03J8mB?=
 =?us-ascii?Q?v13u25MS1vTA/3BUmstwmYWA5U+zXl2DspyQaAdI/MyVfZIbcb0Ly6Z6cVRc?=
 =?us-ascii?Q?xQuMq+9evxX8VyySq9tC7zAFVhFbckFI1cli2TdrTM893ul4o7vYSzNYKX+l?=
 =?us-ascii?Q?sfvCSjfngkR/rhfzgnciVODVkahbAGJrpiXZUBC2saA4Ndx09Ugu4uNpScKm?=
 =?us-ascii?Q?2UXo+yVuDPBraCUIIdIwy47NxorXF/ZQ/qZBYCL2NwJibISIVY0KAyZLoljZ?=
 =?us-ascii?Q?hzRieHorEP1CFItoxxKb2ZYetyq3PjIbhtES+zYhmR5rNAe960NRAaxr5bbg?=
 =?us-ascii?Q?wD0RUV0sPGB0DjX7TNN7VmTXIiDb19SovksWj3Fmioq2izppRiGFOdezlHrQ?=
 =?us-ascii?Q?o29ZGDdJzqz+oy9f5ZG7EgG0gvr9dd2OvXEBSbFSEWjWhiFHsFfL/0epMK7x?=
 =?us-ascii?Q?J2EDnaXMEkM7elfH+dnzFEZ2k+Ff9EVI5UgJl4qYH+kZLOaOSrgi4OV5Ujao?=
 =?us-ascii?Q?wN4LJTa1msi0v2Ae/KdM52J9/z4zq1McEgKbauwCdNpFQNbGvtmKvfEAMUyG?=
 =?us-ascii?Q?V/GrYKgBTMDib0R+pMbLZW028Ie+m++Uyz4s9R0IdLrM3BrVq6cAKmr4Jlja?=
 =?us-ascii?Q?3XID4B5DEny6B5y6v08EJyH6xMK7lxDnz+wogtoU/a7FqozNagEEAhOAUAfb?=
 =?us-ascii?Q?vXPQ0twKNBkgP5eZp2bR3oFRVU736vHAzbyASN4k?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Q0B74f5bvJW/teBbI12crGePki6LQ0mYRK/F5JAbH/jroxYBjup1vENbUx6DbORiC83x0ut8vKUGl0xPOxwAwAR4SUsHmN2FsE55+FH5V+WnodT+vyXtqo5nRyMg+ejI/7XWELYgfLzkUw4yb+bMKcU0VqeC3QcYXXjBAFAtWIZnIeSNqrDZaxHG7sfgMMITPGo+/t7KEYrACQjei7NHbsPjlo9hxSUSg9DUz9mGnnQQmO8UajFlgMEMpA10Z6e6A+2TvOG0JxGh0oQDl/6i8CviSE9TQFJdB6c5SSzgjIuCYpS4R7OJjUydM70XYxBDXfGPe001e4EmGheI5HQRZh2I/PBXZ2sNHAAgK6BdB44cytDT4ObIpaRx7Wh/FNx8Rshv6+IAPRkzad7ahZOjeoFIHnJ7kpdo1F1DVMLUdkFGpGp9Yu2/RK/j1LrH44ED3kghcU+F+ctnl+VjDlzEz7bcjtZxWH0e6RjAXddOJsJn4UtV9W47uXLXx5E+vrNC3lklB1T+uEr1QEclW848C6H+QDXE4QYUP3bYZL+LMAJw54P50XmLHJQjPIkTqh8HtAhMauSOlo4zObNaS1HA8StPbzDBaAL8jHmzDO+T5/3MQ70IaT3R8ngBqMekRhrWN9ddtWUb2WK2FLT6B8+YYzZI2Q0PwkFMQ1VFLeYp75Jm6P7pY/+1cNlYW69XGp3OAJZUXvFGgjM+f3xxPRYR5EojqDO/Z/cza/AbN207F+8qd+jfo9wKsQYF1pGxE7PBMKH6eTKpt/NjJKksU1aQdPmPagSYlESQt5xrsjaaJ7uxsQ2WvOZ4/nL1FB/bb4yGGSNKAjOQPzbkguM9j//krg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7302.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 387d7e4d-234d-4ff1-5e31-08dbca41ba61
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2023 10:06:25.1323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 33440fc6-b7c7-412c-bb73-0e70b0198d5a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WIjSla7ODxnezKpympGMFWOr2Sv+Cu2DKjppT7TcpULuFkUhdPRNhnjyPT2PiOYlTpF+qjjFFHf3aiTAxdUvNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR02MB10138
X-OriginatorOrg: atos.net
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> > I'd like to propose adding a new standard gitattribute "precious".
>=20
> ;-).

The version of CVS that I used to use, CVSNT, was a lot more careful about =
the user's files than Git is inclined to be.
If CVSNT, while doing an Update, came across a non-tracked file that was in=
 the way of something that it wanted to write, then the Update would be abo=
rted showing a list of any files that were "in the way".  The user could th=
en rename/delete them or redo the Update with a "force" parameter to indica=
te that such items could be overwritten.
Git has tended to take an approach of "if it's important it'll be tracked b=
y Git - anything else can be trashed with impunity.".  Over the years peopl=
e have been caught out by this and lost work.  It may well be that in a Lin=
ux development world anything other than tracked source files can be summar=
ily deleted, but in a wider world, like Windows, or environments that are n=
ot software development, or that need special files lying around, this is n=
ot always an entirely reasonable approach.

> Over the years, I've seen many times scenarios that would have been helpe=
d
> if we had not just "tracked? ignored? unignored?" but also the fourth kin=
d
> [*].  The word "ignored" (or "excluded") has always meant "not tracked, n=
ot
> to be tracked, and expendable" to Git, and "ignored but unexpendable" cla=
ss
> was missing.  I even used the term "precious" myself in those discussions=
.  At
> the concept level, I support the effort 100%, but as always, the devil wi=
ll be in
> the details.
>=20
> Scenarios that people wished for "precious" traditionally have been
>=20
>  * You are working on 'master'.  You have in your .gitignore or
>    .git/info/exclude a line to ignore path A, and have random
>    scribbles in a throw-away file there.  There is another branch
>    'seen', where they added some tracked contents at path A/B.  You
>    do "git checkout seen" and your file A that is an expendable file,
>    because it is listed as ignored in .git/info/exclude, is removed
>    to make room for creating A/B.

So checkout aborts, saying "A is in the way".

>  * Similar situation, but this time, 'seen' branch added a tracked
>    contents at path A.  Again, "git checkout seen" will discard the
>    expendable file A and replace it with tracked contents.

So checkout aborts, saying "A is in the way".

>  * Instead of "git checkout", you decide to merge the branch 'seen'
>    to the checkout of 'master', where you have an ignored path A.
>    Because merging 'seen' would need to bring the tracked contents
>    of either A/B (in the first scenario above) or A (in the second
>    scenario), your "expendable" A will be removed to make room.

So merge aborts, saying "A is in the way".  It is entirely conventional to =
have merge conflicts that the user needs to resolve.  This is just another =
kind of conflict.

> In previous discussions, nobody was disturbed that "git clean" was unawar=
e
> of the "precious" class, but if we were to have the "precious" class in a=
ddition
> to "ignored" aka "expendable", I would not oppose to teach "git clean" ab=
out
> it, too.

Indeed, if something is explicitly precious then nothing should summarily d=
elete it.

I know this goes against some stated design decisions of early Git, but in =
the CVSNT world *all* files were considered precious and would always cause=
 an update to be aborted if there were any inclination to replace them.

An option might be to state, in config, whether a project, or everything, s=
hould be managed on the basis of "all untracked files are precious" or "fil=
es may be explicitly marked precious", or, as now, "nothing is precious".

Regards,
Richard.

PS.  I think I've caught all places where my fingers typed "previous" when =
my brain meant "precious" - apologies if I've missed any.


