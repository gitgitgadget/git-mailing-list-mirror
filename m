Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DA4C77B7A
	for <git@archiver.kernel.org>; Tue, 16 May 2023 17:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjEPRzD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 May 2023 13:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbjEPRyq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2023 13:54:46 -0400
Received: from mx0b-002e0402.pphosted.com (mx0b-002e0402.pphosted.com [148.163.140.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512CB1BFD
        for <git@vger.kernel.org>; Tue, 16 May 2023 10:54:45 -0700 (PDT)
Received: from pps.filterd (m0165942.ppops.net [127.0.0.1])
        by mx0b-002e0402.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GHoOOQ017181
        for <git@vger.kernel.org>; Tue, 16 May 2023 17:54:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vcentertainment.com; h=from : to :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=DKIM20181126;
 bh=p6xBC5aXH8rtz12rtEKGR6mK8bBnUmT7fdXGyxNlk1Q=;
 b=T2/r3EI+3QPUSJe1WNTQ3FVtTvTdTXmTcaLMgt08lBbThTAsCXmNtlKb8nk2KcmyeARM
 kqLThYJ48qJmy6/FQYMkJ8LU1sTIoDvhFHy06GUVE9DoNkbipfDE8pANAPyC1t3JHZDJ
 KsdlmYAmSNqUgKrURcBxX3b0n5vPVKBaqfBiG6V+y0bCOZ1MNnTDhcBZChqQ5eY6pAle
 x5dAqQdh/q4Foy6ew/PfLJgO3x8HRgPZ0FroZ7sgVfV6A7hLjZKAm8Vk8PXLp+3qMkFD
 BbxSTDkp95fez6jZRK6/vpIihgT/aqx1tvmq57Lb60a8f5W/zMNy+xNjTNcNhkF/m890 vA== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by mx0b-002e0402.pphosted.com (PPS) with ESMTPS id 3qj2g9euxn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <git@vger.kernel.org>; Tue, 16 May 2023 17:54:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nz4N13fylBRbBwtL5blPlchRadusDBG6YIuS96+A1dFIWmjtUcvVRHsmhhqC95A2wsp8cNMqV1fFuzT7YrBqDgIHty1p9u4oTp3xozRpG5VHjBmPMndhxuBslrMaoz2f4ekYVX1OhVPqUNjId+bjxN8mAdbLRG7GziP6czLqsqoV4CyX/u/qwh8q4HiH7nzD7dSzeD67nbz1dH16uSUm0AfJTShhRB+58vlb7mFGJGBEiV65faCIJ2uTm1VG0r3PGCvHMbbw5QrKgpc3F3ePp7g/LY6JDndvtQ02FrTQG2212D8k6feM/4eZMYPJzbAoF0IolTFYSmQtxkKM1VE6DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p6xBC5aXH8rtz12rtEKGR6mK8bBnUmT7fdXGyxNlk1Q=;
 b=JUe5xreA8FEZZ5v51OntPoPCM0nfMol8UjF8LnVGfKkwBGEY6ZSNoksYFQJdpSzxMemQ/G+Vc89HIzHBzy81utPTJAH38TKtaWs8H0IsRa412Ud/MRRdXhbPADD1mKquXk+dRy087hJfKxvqQLhke738JCOfPcmwu5++7cGdSQ1cN1H3O4fb7grrnD2BeZLcRJndTMLW1EG4SWM3zEGA3eIkEHS/gSKdIb1HvpOl7NoXMkzgWXAhy/1zEZSrWUgAGU98r8TSzExq8GuUAz+O03wNM4c6XIU+OnO/lTZWONKvpp39DvDwfzw0RalpNjVOzQdNhLN0Ju4PKwQJhNhHVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vcentertainment.com; dmarc=pass action=none
 header.from=vcentertainment.com; dkim=pass header.d=vcentertainment.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vcentertainment.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6xBC5aXH8rtz12rtEKGR6mK8bBnUmT7fdXGyxNlk1Q=;
 b=tPeK/ol7UP5W3XqWSdej3SuqPS5rE6HWiuZTwot7e/9fYkp6RA6hSSgF2V9MlGg8QjgyK6QQh6DfFW2UYH4yMUJmy0RMVCJvLiGuSJAY+eLZ55e+tJIBi603XvQ9ppHmnl9HQAdcqpqT4/KliaFF36vmPA4oAkvXQ7S3ncjlDJbQkCkYp8T5SwDCU+rP1HUGMgUDobAxzRt1iQzTu3WUgP8Yq7pK9y1Y7FX0/OVuP6EUjc9QaKfsqnqqhxL3SihKF1L0/Sqv9NpmKrekhlM4Iekbq75YyYKbTaC6lbScRMFslCh2B4BwwC7AWb0qM8oijF8jBpMCJHkAOk5e3CffVQ==
Received: from BY5PR14MB3654.namprd14.prod.outlook.com (2603:10b6:a03:1d6::20)
 by BL0PR14MB3796.namprd14.prod.outlook.com (2603:10b6:208:1cb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 17:54:42 +0000
Received: from BY5PR14MB3654.namprd14.prod.outlook.com
 ([fe80::de0e:df1f:c42e:3107]) by BY5PR14MB3654.namprd14.prod.outlook.com
 ([fe80::de0e:df1f:c42e:3107%2]) with mapi id 15.20.6387.033; Tue, 16 May 2023
 17:54:41 +0000
From:   "Tim Walter (Visual Concepts)" <twalter@vcentertainment.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: git hangs with --separate-git-dir
Thread-Topic: git hangs with --separate-git-dir
Thread-Index: AdmIHwP31fja9miBQ1mB5r1EdFLfeg==
Date:   Tue, 16 May 2023 17:54:41 +0000
Message-ID: <BY5PR14MB36544D63ECEAB9954C14407FA5799@BY5PR14MB3654.namprd14.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR14MB3654:EE_|BL0PR14MB3796:EE_
x-ms-office365-filtering-correlation-id: 014c9ced-c149-4cb1-44ef-08db5636a00a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jt5Duc+vJe1mF5+xuwOV19bcd64GZEcffbFNG0a0sn8m7+SfpzhGPID0/5jZyjYn59vvG6nVh89Er8lONGARTQFDNnSHQxwNvZ3ePu8yS7fcjm7MkW2YbAolpi2qlmxIitZGN+WaM4qnat7kYquhaozlxFVi353o+mNqlSYJLMf7qJVSvERXPgauKUPmT8QKyLYhejM5ImMfFG37p8OuDmSK3no3RQQQ37X+lhhQ2RGJhDIPAseoIXzZIzr4nGELPsjfRimc762w5J6EW2gqppES0vIg6qDdTe8+kiWhAIpHQGXYQ5g2AVSQwyhHDYpo4FG6DTdUZz9N7G3j/dkJhuSSykDHkQGJFb9zfWFscr0zjLap+qGuf2D05PDFYePq3/NiFsU651DoTcWQWAkMfNHfXjqr9l+dQJbtTjHm0/y4QJJypge9hW/5mVRTC66QhyN/WGSB9zjohifUDbJFlkXQLAtwy37q2c/BMZYPvRpqvIZW0MsPHgaMkPfFp3lRIN4jTx4zeWrKJWJz94ewa1epjGUr4XGtejwj3L0tr7UcayhmeUN+deUL08F/DhbCGbW0qQzsQLYRlqJtyPIHx2UuukBDpNAmVMfdc5G0vIjYywf1Qbz9gOFziiLDaF0jA33Xgpfm4niIIMrl4E5EAQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR14MB3654.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39850400004)(346002)(136003)(366004)(376002)(396003)(451199021)(7696005)(38070700005)(33656002)(86362001)(316002)(478600001)(76116006)(66476007)(66556008)(6916009)(64756008)(66446008)(66946007)(71200400001)(55016003)(52536014)(8936002)(2906002)(41300700001)(8676002)(4744005)(5660300002)(38100700002)(122000001)(186003)(26005)(9686003)(6506007)(83380400001)(460985005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?hhOgAtlrCLsal/A53/OAADMxma4Wo+HultnhPsmTfbYAxlItUiEyX5oI93?=
 =?iso-8859-1?Q?nEFEBW7TYKSg8+Uj8dHAxCoDrt8j45f2Xposurr1sGMRIucdqPch/afR/W?=
 =?iso-8859-1?Q?JdAo+zJ6YeB60oJ5tX7Akry/VmxhqUBVUhBfdxTU0iQA4xu8ngh/tZiKab?=
 =?iso-8859-1?Q?VUBAoEonrs2XoNTvAUo/Fu1D7ojnkmh97EUMm4kVtSbBjhNnx8NUl6+3YA?=
 =?iso-8859-1?Q?5dsEIkM1lLLAMUXIDN87zAJi6D9eWvZAgi6gXuD00lHtHw79HhqNEC1HSK?=
 =?iso-8859-1?Q?wrzvRE1Us5KdN5HioRW9XLsFzuzqBGILYIEkZF0HhTMNaoCXQdlMD5w0Yb?=
 =?iso-8859-1?Q?RICrJeaXFqqFUT6Md0btM0gPVMOzqbJ4cg1+pC7CbMiH+sTkU6qQL+AZ5m?=
 =?iso-8859-1?Q?0BSkA7KnYlufD8xyZpvCJ0l89jOWNP+zrzBi4sNdRyG1shKsveKknnEa8i?=
 =?iso-8859-1?Q?QJtBRradR95dV8i/n5vEL5EDRSCl21gKEU8rWsZ/5znwTKG8w+ptpheHhs?=
 =?iso-8859-1?Q?w1bDARMehvoGGFZjocTYd+ZYOJ7gm2bhJGtQAg62LJD8Ca5GeIzGp/YpHG?=
 =?iso-8859-1?Q?xPr6jd0UYdmgzW4ifw4qE8mLxxRALHKo8bq6jhkG5aUKOJBBexuNqyuDLU?=
 =?iso-8859-1?Q?jMHyR3RXhzYvTniCbeGOSS/7aScg/I5B7kkEB3ahBGvHwGOoqW9TTNrzrZ?=
 =?iso-8859-1?Q?Hu2G7meXjSRx+RjKVQsSd0YsZDrtkNtX6GBdS0T2eMzwkdNTrDABDXA71f?=
 =?iso-8859-1?Q?WnffxVyPYlhgRmZf9dOHMBhjGRx3i9Xkz4IRZj4C5OtVfYqVfmVUqSp8Vv?=
 =?iso-8859-1?Q?N27OqhxUv3yq/nX1B6IibR8Cj64RZz/7Rq8Nj/GafJerQD6fUTezqHaG12?=
 =?iso-8859-1?Q?ficn8sLeQLg7PmMHogGKjeG7Xqz3IwW6svgRCYOJIWV1DYHAuJNzg8ahDR?=
 =?iso-8859-1?Q?GEctzc06DzGwx2q5jQ5agieNUaEZujiEOWhnkCYMfU38pL08EWgWRhesC7?=
 =?iso-8859-1?Q?SbhHOUrOwRkiYIFSJXR9fE+72eVhoH5Q74BLn6o4dVQBi3cWBFXcHuc6iA?=
 =?iso-8859-1?Q?cKk/CxHT49cQjgs6Om+8G696myck5nTvUt+uLXnXfmGsfGXnJIE8vCcQ+I?=
 =?iso-8859-1?Q?48A16Yba9xGlQd2UWwf88URlq9uq/iMwkh/4SPXvN7c3a/T4GTGZGVBzt/?=
 =?iso-8859-1?Q?TCMWaEbiXDmNufoi0jlEYfwBVE2H8wHZHq9OYw4ngIRxVDlGobgMxLL3uh?=
 =?iso-8859-1?Q?VFRV8oipEuebIgFZlvl5/HBXPCqAquZqR51oarTgBD1VowUpQ7KJdWfjtR?=
 =?iso-8859-1?Q?KKLhmjwSUDSjpd0erJ0DG3XrkkEQoX3Egc5/9HHa6vF2b0RD5eVl9nUAhQ?=
 =?iso-8859-1?Q?mcaFPWAb6IfajmHKTIS0H1fYSLU1M67IkTS9AtLDNRjPBTmIftb4ARsv7e?=
 =?iso-8859-1?Q?j/2lqLpERsiAkI/8KGrR8vKyjgUHxNvVzEFYoShCMXn1BCplX/r/AU8fmt?=
 =?iso-8859-1?Q?4SP3dIUulyVOK10+VaXilN+ucA5CJA2M9+lYpuEJ3ebLWJVVUHTg3qMH7b?=
 =?iso-8859-1?Q?ys215IAuhidEVo+MTYdrKignExJBPDCpsAoB1Kw+0o9N465Dzjo/StGE+i?=
 =?iso-8859-1?Q?PA6+ocSwJZfNMv3fDn3cuqX96+hebufcK3?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ssytqoKrNgrGklzLQ2cja96w4UQ1lLQ3EWnY8b64IjI5KOH3ylcEmW5bMkuguvkJG4/ixag6KvoorAO+YraXbNFEuKA4IuYREMIn8lfFx0zqXmUEkVws1RD/G1HPCQinoYn5YrwpH/SQT4bGjeQlnJliIqeLGzO9JcOVEJwPF2OInobrF+8JkCSIA53niQRU/u4V/00DDQ2iC/C+VorleX/FPm4o91OzFTQDLr/IsZhBA/xpdvcbJg3axjK8tS1UyptHvCOJQiqv35SE9+KZBXK/HvlZ6lVGztNrwmRxAjKEaInX57tOQMRNZelXML2Qxh5laFeZI2+dgKCIHuOFY1LvqIHAuoxLAmBhu2aGSnXOFwKq7MkUx9Tt3CckYeHi6SF8VcUayRpWs6/11k/6zbzba2LDm1efs7k9GyEConw2xD1fobwWkFDQVcja7T06OUHe3NJ6m5Pittge2oKPIr/e7wH0rvCVuJXMjJUF6u+LhlDBZxzrfqGJxtjSXwYJ8dMvzozHjx4T1tXKAHmyhByTAFNIljoGG2BOyblPXxEMAgn3bkSTKwNJVx+ohwyxDXfH7y4HmKxGS6N9kpSzv6O8KX+UAT28XuoJ3l39yyC+fcfjHamLU9L67f8MqbEK1SpnpGiLoDo5rmCnBetLHsj+0ltRxEkWWup8PUVkRAyJZSx8+L5OngT1xj/5TdSm1oFj14CvCJCzxNzLKEAm+G2ob6Jk31/UOtCuRJb1t7hlijJVBiTqk8d9uAgTdf6mnuVmaiNz56+TIsCaCwLARw==
X-OriginatorOrg: vcentertainment.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR14MB3654.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 014c9ced-c149-4cb1-44ef-08db5636a00a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2023 17:54:41.6287
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d91c4a20-dda6-49ce-ab69-53dee8b047a5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0dh+wTNBHkXTAZ/QwabWAxPSFaVgxyGNAI6coZG+CjQzgltkTQjA50xMY3iO0oGqpkrpam2xEizg3jB3wFsaZ3w/KjPYMnUw++M9W4gQV/E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR14MB3796
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_10,2023-05-16_01,2023-02-09_01
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Windows 10 PC
large project
300GB
500,000 files
mix of binary and text assets.

cd /d D:\myproject
git init --separate-git-dir=3DF:\myproject.git
git add *

Git runs for a little while then hangs and does some really bad things to t=
he OS as well.
it seems impossible to kill git.exe even with administrator priviledges.
f: drive ends up locked and any other process, such as explorer that try to=
 look at it also hang
you cannot log out without hanging
or even restart
This then requires a hard power cycle to fix.

100% reproducable.

running git init without=A0--separate-git-dir and git add * works fine (tak=
es 3 hours,.. but works)
then I can move the .git dir to f: and reinit with=A0--separate-git-dir and=
 that works.
So this seems to only be a problem for the initial init.

