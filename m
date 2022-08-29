Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C720ECAAD4
	for <git@archiver.kernel.org>; Mon, 29 Aug 2022 06:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbiH2G5G (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Aug 2022 02:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiH2G5E (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2022 02:57:04 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60129.outbound.protection.outlook.com [40.107.6.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A2C3B97C
        for <git@vger.kernel.org>; Sun, 28 Aug 2022 23:57:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c4jGcRQuNfInnbJBZwDbTToo8nIEYQNy42XqRU5fqIMEeOPOzlse0KXpDofMqjHBXip4F67GNUj8/d52wyMx3p8zzKatC+N50Q/syc1tNkqhUt28h/9UOA2Y3ZHrBH1x60p9J/yCEKKJTQM8Hy10TDUBuFn3hZlY4PTIjzHJFHPnW4SZ0bqMJMBQTCVJ4Ra+WeGe33r+5RZDyj4lSuhievrQnRdbLelpLuw086vzkm0i6C/9I72CtKlI0eaN9whzyDmq0Rwij/eU78xbJO4FiQMcIYAGghKjZEgnywUK5a6L98Rk9tXe9tdRaQ6gldVgn+nBKO8AEKbhdcM16LdATQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rfj6ipe4a0+LzUGYYM9Ix9XxDEV0iZjPOIjXiKV/YFo=;
 b=h9HtlJxFCAwth9dQTJoroJT1R8MrT4Tb04bucS31XgQOp2cbJvZBmjcTR6fdJSaaQ3ghcEvjhSpWywKi9jG6YJhwNbKeS8Tml5OiFqdUAwUT8ZYJBqnc1voGHNK2tR2JsVyIXRWBgz2c8qUSe607sahcRlHiU2//OC6YB33Ohca6Tv62ysxIXOL249zBs81VBZ8voBSc8Pa7ZvnlJhzdfiSGr/kqA7x7tyGgP9ctRZuwBt9Hr0v9kjagwoabJuvACKrRsWZPoCkvXVxrM//q/T1psDZUUsEbB//1r5mPzQZY6TcLwameEtrgUS9XumXM6x3HYmYqY16kTGrKYtKerA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sparsetechnology.com; dmarc=pass action=none
 header.from=sparsetechnology.com; dkim=pass header.d=sparsetechnology.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sparsetechnologycom.onmicrosoft.com;
 s=selector1-sparsetechnologycom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rfj6ipe4a0+LzUGYYM9Ix9XxDEV0iZjPOIjXiKV/YFo=;
 b=5Sobi+slMuOx5TguAF1nOaX6ula2GAWRKy8hBgGhqWRQ55b3pW2OIwNaYHpx2VEJX6Er+d4iX4+sT+5CBGsW66sV82EBPlW5ElCi06BbB/JId/PZeXqNpUAuzMUklfnXqXmIrd0GcqqqzV7QcXofj6+I1RxM1vcIXoBsFgF5njM=
Received: from AM0PR08MB4323.eurprd08.prod.outlook.com (2603:10a6:208:13d::13)
 by AM0PR08MB3650.eurprd08.prod.outlook.com (2603:10a6:208:da::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19; Mon, 29 Aug
 2022 06:57:00 +0000
Received: from AM0PR08MB4323.eurprd08.prod.outlook.com
 ([fe80::d491:a986:c5e7:d83e]) by AM0PR08MB4323.eurprd08.prod.outlook.com
 ([fe80::d491:a986:c5e7:d83e%7]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 06:57:00 +0000
From:   Caglar Akyuz <caglar.akyuz@sparsetechnology.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Ambiguous 'HEAD' issue.
Thread-Topic: Ambiguous 'HEAD' issue.
Thread-Index: AQHYulLK5nx0XyLHc0yBFLDTESNSQK3FbrGJgAAEXtE=
Date:   Mon, 29 Aug 2022 06:57:00 +0000
Message-ID: <AM0PR08MB432341F2A27E1133C7A31DEBFD769@AM0PR08MB4323.eurprd08.prod.outlook.com>
References: <AM0PR08MB4323160241D4341FB1B99CC2FD749@AM0PR08MB4323.eurprd08.prod.outlook.com>
 <xmqqsflfr1y0.fsf@gitster.g>
In-Reply-To: <xmqqsflfr1y0.fsf@gitster.g>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sparsetechnology.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a68cf58-a624-4d99-a3ac-08da898bac27
x-ms-traffictypediagnostic: AM0PR08MB3650:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fd3m/FlgtkR244C/3JgXg/EuL6nYwQCENLUJ1X1KvtxfRwsCuZSxnZe8G1Wj5DE+hvo5yoDi1AINu5tRZfMcfO695C2116SZiPZcqx1sobKqQkZTlY7P/UOV1N67rV4IaoY1fgC8LLzW97bnr9YxJbSZlj+yAE+C1O0wdesLL69FfJ5BZD56toB6SYSrDx10/bAMu+0jQkAOw741Qq+LOs2bZ9n9dDr4ODfFEJq5lMV+J6ILgZ9vQxNDEnPdkocLYXg94HetHdq+LtBJnHmZhYaXizVZ0SziEzVGIwD6kK7bFvJm3Xc2nPADEul7Wnw65oir4b3AitLk98qUWquc+NDmYK86rAe2IEgvar11H8Qr7AasOm4ftsOdUm3ooXB6InSmVDz26z6BrzxRXuWUQvPPAiciEuPk2UyO/ln6otBuYlY29HCr0XG8WV3Va02kN3lqEYYAbhRZUM3hEVg5OqkBXilauTyO5H3zbJVxcwPI/fkj7OeDJ2+Y3aZEZVChH7I1LbZIzhP3lLJAqGT5fAKuQ+ofTxtU6ru6MCLfFVobdebigoVlsBgg13BfdvV17glsGNhcwMP4tRIGhnr2zdzgXrAfsO0joDTCHZN06PwoPcfEO3RX0PB7ZGEhhb0ryLUcJ8E+zmgJ0Tbl7G0fcGROf96LGFgwKOQW6GefYkAxv4ZxUftUCLa0lks1mbkgGoXNpnshf1HmE0bVCuNL+AaYIZS3fyrOhU1ZqYxmYxa1f4A148gl5CTvVGo/mKiG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR08MB4323.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(346002)(376002)(136003)(39830400003)(396003)(38070700005)(9686003)(53546011)(7696005)(26005)(6506007)(55236004)(33656002)(86362001)(186003)(478600001)(41300700001)(71200400001)(55016003)(64756008)(91956017)(66556008)(66946007)(8676002)(66476007)(6916009)(316002)(4326008)(76116006)(38100700002)(66446008)(122000001)(4744005)(52536014)(44832011)(8936002)(5660300002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Q1Bzdi+1fAqfcqSqsO6EEAdwxTQlsrNYokgtiKLaj/HUpKUoWwd988SO1H?=
 =?iso-8859-1?Q?ZqZ7H7rJLK4vu9QCMUAjGzedp5DlHS/rVarmJh6Fv3EmSUCcbQ5eienNj2?=
 =?iso-8859-1?Q?2DBPMu4liExHQSIxLeBx09UM879dD6FaCKp4hpGek4WMpJntcIEjU3Oys+?=
 =?iso-8859-1?Q?ESryvTrDojMjL4ca5kx3vDY6Q9CvmNdBkQPQtj/fp3Q7YyMQt11czzhiGk?=
 =?iso-8859-1?Q?CPKs+mDupDMCL9gaMNv4QFSo+PThOh/bflKIhhWogiyVAh9z/YoH4FHDSJ?=
 =?iso-8859-1?Q?cFBwe6f/wRt+8k92AJK/r4WYgqrYoykJsru7TO+9z4rdkqrzmGlX83CVMO?=
 =?iso-8859-1?Q?HehY3nQnu8vGinU2i8PH9gku67IoS4HuGUjWyntxUGSx50e6vOlS5vXjrO?=
 =?iso-8859-1?Q?rfKnwGJ5ySoooyfAtYCB1JivURTnSRoJ1UoLI9YqBEYkVuORKMm5aVJZFg?=
 =?iso-8859-1?Q?Uou7kZcC9ACS7pjepVWOh0DNxnJ3BFnVqYlr90nLuvICfL2xNOAvSVZSB8?=
 =?iso-8859-1?Q?PcgosjUFQGTQ4vZQBg/IojfArsX2kTUN7Ddg8UYYYZtQ1TlS6ptjGhQZjk?=
 =?iso-8859-1?Q?iXO89PgeHQTeR07SeoWGe0pdBPQyJ3GfkZysZFm9vTIrClg/ejTkvyKStX?=
 =?iso-8859-1?Q?NejAeP4bGOCmkzsfbMedoHVOsPaM8dD4oCxhVatVRLwfbFZECVhqZmcsm6?=
 =?iso-8859-1?Q?KJTMmh/i6fmmpTwkqBSfJe1RoIoiHHp9ilulLRCWaHyHgivvSLzwRAuhML?=
 =?iso-8859-1?Q?RY2YEKJa3LUKPjDdhBUvEdfJRtaPHpUDaCzWQiUGEKV5tUqGQLWI+oZHEo?=
 =?iso-8859-1?Q?G5WErVZvy4EW4AsXSiY3dN3n6WP3vGMeoK9JUg7G56nbw+H7wHfPTKt3xJ?=
 =?iso-8859-1?Q?C2H3gt4ZaEd+VdB1PWhs0i+t2y/6Nl8cMDqW8O+g6bQcHNhQD1bnu7B3Wp?=
 =?iso-8859-1?Q?OhQH808rWXaLriogy8pV/mCthzk8ujRQk3ZohqWjE4IR/1JKIrAxgNBJal?=
 =?iso-8859-1?Q?YW8WprqxbeLbkUVfUhV5A8hvg2Uah8fyWBxjA5c13Cv5fCzEr628rvwWl7?=
 =?iso-8859-1?Q?8vMGkacwa39snFb3JoUnMOQLlEQ3BheQyU8CkTGRFLav5jypmdwaNLkfgG?=
 =?iso-8859-1?Q?GJ6xYRJxbayxweGsaN21R9FtQ7cgeSNBABsirXORNCrM+Qzh3+gHXW64xJ?=
 =?iso-8859-1?Q?QIsvBtxffbutR8SCRzL98FklLE5YMzHfOoA6iQxfgPnV4pw8Tg3SbvGuL3?=
 =?iso-8859-1?Q?sZvekzKTLonM9aoLGx5cNmZKwHRuQNK/3etiHHBFBW8xHM1GojClA7a1/v?=
 =?iso-8859-1?Q?UE53FhMszW+3uo+ZlaZy1yWZBjjNGJg+ztjO3gt1KJpuLrd/M3d6Zf8MIo?=
 =?iso-8859-1?Q?ody4gKjwbERs2elYWGpxMgGc7E22uBl8lvyL/8PuCc5FnY5Azp6vm7KiXE?=
 =?iso-8859-1?Q?Bghaz4iP5lNSVJuRg8m11PiwCBrVOdJgz9994+cGrec5tQlfbZMrUzBqax?=
 =?iso-8859-1?Q?KmUDBdMRM4bV1sNM2AfOTofm5NQTynP3lCxEM4RCEwcgP1S9daCWLwtN3u?=
 =?iso-8859-1?Q?Fp/d+WPwxKNTc3SS4L4djC9RaBujtc/SmSkpSKeuRq5tRMPtIf0D+4nQ7z?=
 =?iso-8859-1?Q?PqSDmN9e1WxOcwT2SVhTQAL+Gz+hzDoyBVYz68KdSN53P8sRDOtqSydg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sparsetechnology.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR08MB4323.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a68cf58-a624-4d99-a3ac-08da898bac27
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2022 06:57:00.7772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0fb7b744-90b4-41ff-95c2-686d3964ba8c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zidyi/wDJGCLp9JzkBh3t83Va3QCD+yx8QxBbK8ZOyNloYZMHvKg0Fs4n5xtYX0eDqG170OTWKkjCqk4qGP8N4LBg1jxr17NTWJ4tE4JAQwLhE8k/5XBpW1f4DTNfdHh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3650
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=0A=
=0A=
=0A=
From: Junio C Hamano <jch2355@gmail.com> on behalf of Junio C Hamano <gitst=
er@pobox.com>=0A=
Sent: Monday, August 29, 2022 9:36 AM=0A=
To: Caglar Akyuz <caglar.akyuz@sparsetechnology.com>=0A=
Cc: git@vger.kernel.org <git@vger.kernel.org>=0A=
Subject: Re: Ambiguous 'HEAD' issue. =0A=
=A0=0A=
>Caglar Akyuz <caglar.akyuz@sparsetechnology.com> writes:=0A=
=0A=
>> * find . -name HEAD | grep -v modules -> only .git/logs/HEAD and .git/HE=
AD=0A=
=0A=
>plus "grep HEAD .git/packed-refs"=0A=
=0A=
This is empty as well.=0A=
=0A=
>> * git branch -a | grep HEAD -> nothing=0A=
=0A=
>>plus "git for-each-ref | grep HEAD"=0A=
=0A=
This is empty output also.=0A=
=0A=
Both 'grep HEAD .git/packed-refs' and 'git for-each-ref | grep HEAD'  comma=
nds return nothing and still 'git status' is complaining about ambiguous HE=
AD.=0A=
=0A=
Thanks,=0A=
Caglar=0A=
