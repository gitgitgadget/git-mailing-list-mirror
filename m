Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2034.outbound.protection.outlook.com [40.92.91.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1124969300
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 14:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.91.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707488490; cv=fail; b=ZJUYVG+EYefdoGoWfslEgq68sqdzE1RFy2+XYAoi5IfBnntaPnU2J2iVJ7jZVc35n9cAWAwIqIfd7PU/Jyf6yTUTXTAwvYObpFCo9ivoUHx6JsltJwkAjIk3M9b9Z/JzBI5wdLqzW49VFCrFC4nuGiOa40s5a0L1agBUOMhwzfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707488490; c=relaxed/simple;
	bh=uEFgGeXbgF/58AHg+H+Y15yKHNuf+dqAXCwYeYWnJFs=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hve0WhULWcSSQfL/4s2I971EW0zk8qLCikNWnt4tiVRYRXpSuZ6uCoig55xLTanrpbuWh1raR51IfV5KbqdFlurW+VRR7c4B7/S8dr328eyhvPlAvOTHRghAa/jR/7m9+PnW7Bx8z2PgPz0oJtDFLeUTwxTOhqWqmbTNNTUd3dA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pascoal.net; spf=pass smtp.mailfrom=pascoal.net; arc=fail smtp.client-ip=40.92.91.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pascoal.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pascoal.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gC7A7Xwbb5zwGObqAvIWFtdOOiJ0fQECPMgzVt1e2rD7OkmNOJ2d8cFXviy8G7gjHCKFdLED0ZcTcWXn/ewrETIEjTzvdNgt80HJwjrsAglLFFb5ZXM+s8dKlJrfuJNNVGOfECXleTVzT5Fjl/frfVOehjbGm1HL+FE0mRsUC2W3h4SnQmE5jKLsQd+bimejjWVylHq9/dlU3kDH2cU7pIL465AE++dnQx7nqUz5EOkrYi2qCPB8irOwPhc9k0j68wxLLfGPBvHCGcf7S4HpwmIbbCQdbT3V5HqmIZVVNlPZWzpaHANBB7If9G8wMFjOlBLru/1lk25/ypiMob8MIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uEFgGeXbgF/58AHg+H+Y15yKHNuf+dqAXCwYeYWnJFs=;
 b=KcirwqTAxkkGzhswVDuUsztJhgChxHJBVsGfr0Kj8+wCJldtpf+YVQAjrNcrpbdPYgKYEwspJ8x8bzGqHcqIWo6VshvtgaIE4YjgZ1Zos/pKMTUaFWeA5VWNfJ2xgkBUmi1jmAU6CVV5qo2xJzfBrvK4h+8Y1qdp0JllIdzD5NMrkCDAWwwIO9DL5Uvbgr4huRQTjpwht3mt568ABx1g+xpH6FTkFi/MFam4HPK2elEznWxccDJDMF1wyQCwqiGvi/3T+WuF2oRJ7jP2HugCVUCG9tzvEcGQH1zQzYFzauz/sMvfsmxpSVchOnytAkXU/3DfLko4NjBQy0/3Lgm/jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AS8P189MB2197.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:539::17)
 by DBBP189MB1322.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:1ef::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.27; Fri, 9 Feb
 2024 14:21:25 +0000
Received: from AS8P189MB2197.EURP189.PROD.OUTLOOK.COM
 ([fe80::6cd7:fa17:b579:264d]) by AS8P189MB2197.EURP189.PROD.OUTLOOK.COM
 ([fe80::6cd7:fa17:b579:264d%2]) with mapi id 15.20.7249.039; Fri, 9 Feb 2024
 14:21:25 +0000
From: Tiago Pascoal <tiago@pascoal.net>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: git column fails (or crashes) if padding is negative
Thread-Topic: git column fails (or crashes) if padding is negative
Thread-Index: AQHaW2Ly5u309BDu7EiGNqQlrtIpqA==
Date: Fri, 9 Feb 2024 14:21:25 +0000
Message-ID:
 <AS8P189MB21977ACC4866D9836DA29082BC4B2@AS8P189MB2197.EURP189.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [V38wF3WDJ1AjJX69kqY1XAdS4GO3Pn/1]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8P189MB2197:EE_|DBBP189MB1322:EE_
x-ms-office365-filtering-correlation-id: 6acba080-1924-4b9d-c57e-08dc297a65dc
x-ms-exchange-slblob-mailprops:
 znQPCv1HvwWAQTtJnGq9iOeerYYr2XRU4UFWbpQ49o2r57cmr4r7dJR1oAuLRhvad1vMfwN9w9iWMSSIIpdCJ1AF9JeMbiJ1kbkzUDuEP2dz1LpkR3ku5MrrCVXqwngWAzK4SuA7su18VlS9SSy68HZKDRINiHFw9ZQdCQI3vt5jzXjVby8Qjl8mVTeWoEia6gNV2xn8maiRzi0poPJT3yMayilePCy1peyw5hdE4QGm8nU8FJRt7nzbjMGw3zuise+gDW5tjUDLhyfNsdEW6IcPa4FT/0iAiqyaX98sewxvVIs6Hu619AuVHfdMrTr7MRa/X7x/8yVSpSr6OGZVgBLOkpJ1bj1O5WsqmKJSxTf9h5J8R+dF4IcdMB5IWyCh5cH8KpuYwE4VT9qMM0IFB8HML9qRuijrEUkIi3XS5yfurkUs2BTmJR1tqXWVGg27GCEISU5+pJiERPaBgzNssoT+ybOcPjrwta7iQ112gtmTBkcuHC6GgSaRUiEoo6xhJ/WzuxjhyXZkPNSJWfjUUopxKhXoBZzKgLOSHYU5e4LdS4kYhR9dib1kgJPTAlzn/Trj0QEY7zAxAWbn67uMkdzrvJAhwTT3SrVyG2+ZMm+QRUYZHPIeICocM4spCLmiCDxLzz2JWpas9XhpesmLGjiYDj2gjc3RhJX9nEMFwdGSEr4dvjA34AoRcWyfRMoCkGscU4H5zCy5QT1R7DT7mTKbRmy8gVkhd2DlZZLx4iC2pICfMhnWTUXo1kRVXtvYU4xwhJgG6eY=
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 iK+CgaiqCEH5TSSjsrisKj1YGJhAtOrGSVrijFxIMxMBYM+xTUXrWQsIfaz9wnTk2UJjUpI+dzpplmX/9itWn/XVpkGHOzcT1aLH7+ZCeKRscdy0K5i2LxcjLj6DRrh3Vjro08L5SZAnZ4GgbqI2xfGXd1GhqDwRAGMJi3ifd1TPEeM0TpyaReIoU/pY+G0xkNM9NcdofJnTOFPpmLPvCWnFyt5/jCk/j7RQNMThn9/BEISh135sFfTnyA/dOLxrBNJ1zUa7ltpZs+dRB3R98fe3HfTSz15YF4jh7JS1Hv3pd8T1ycZQ7AwoUFhOVTKgXFf2WcOOBiuX0AydwOWlxF/zDkftRIEEBiFRGs3ugDoVl7o+KtDZrG23YYgHZxme5mqZ7S8klDfWjUutDZN9nyxZEfXwQ5SFHIimtq3r8KUSulh9yq35iZP5qvWe6X4T97mgrnO5LoWqxs9TDxPddkWmuxa8pvmy5WxbkCss3NL93iBX1/6RI0dwAflIRHlpQD05PZ0eq1AmWhhSF61eXmtegC7xVvLvFfTP3ZUb+0zBLgzA6/ANrvorxJWk7Hvc
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Q9hZ7EcvjyhAFcynChUQ6H6Wz6altAjcFLZuL6qFT0LaqT16x4s3JRBesS?=
 =?iso-8859-1?Q?CSzQFdODBY9uMaNgwJCFfAGqrZ80lccSi6mDH8CdStlZ789opWQCGG+OVK?=
 =?iso-8859-1?Q?oW0sRPLsZGJg3XI12GEyOe9HX175lz82GnSZy2R7kRZFgElgXORwK/Vgmb?=
 =?iso-8859-1?Q?M3PLTIx54YrdvAr/wQOPAVHqKCehlizYWWVOZTLv+BOlAuCE3AnNs8Okis?=
 =?iso-8859-1?Q?z6XMDkPQxpToyxkg/zs+F06bQWHFktFEQY7ulMAUO3OfawkaldEE/1/P9o?=
 =?iso-8859-1?Q?ZJ2jcnFmhgPYnUMSfaPuzmUY3bD36kaC3oSK7PWT1Ecov0yS1gRjZoipB8?=
 =?iso-8859-1?Q?41TEHUAo4mcFY4ATXIypvVWn5huZ7fsfScKVlVcm6V9WSQ1NptbGoABlxm?=
 =?iso-8859-1?Q?AGdXHFvhXnEmrlXMPnkrx1iDvhsqfqDsRnvB/K68eFLzVnezbND1csqHpv?=
 =?iso-8859-1?Q?HLknWbiz3qAPl0BP3Gf8cnAKxFQGtJLNGmAzvtbs8QsxbKJHOzhNTAGNhQ?=
 =?iso-8859-1?Q?s4oVA9Wp0hRihrpt21F6EPxIsYg4w1fLVgzivYp5lb9VAijApRXIhRHby3?=
 =?iso-8859-1?Q?n+Vtlym74f2LcQh0u7LZLIF+w1kqA6mNNu8kWD6vkb5UjoUK3sDTorqy1+?=
 =?iso-8859-1?Q?LqHyVL4Eon4pkTadkprd6gSXHlHmXwkHHmvFR3BUK9k5VHstYFlDcrvmUJ?=
 =?iso-8859-1?Q?5jKkA+ggCg7KDUk4qgAE51q7I6soq35axaTAkil/gk60o9Or54LsOB+o2P?=
 =?iso-8859-1?Q?Rnsfo20b5sjBRhjJoNnIO1SbkG/MksmLltKqtjRbXzklT+k9ZntPuA2L7Q?=
 =?iso-8859-1?Q?qput2IfDkedQpg6zFuHgpz/QtLwqnsxDtE9IPt7JkIvW2S71k6kjNcDghl?=
 =?iso-8859-1?Q?N9L4rcfo44opPK6cNa0Xs7xG0o5T8sdXpnZrIQjohMtGMPL8sTQI4Y/SZ2?=
 =?iso-8859-1?Q?w3GHSE/KNcPuujY34qkHieCJ0uER+cexaiKjuOcBAqsq6ax/GtOjFjsh/E?=
 =?iso-8859-1?Q?/MdfbuVEFH1NY3Ue1xa6Je3WLD4Dg58HmD36zSNaVtF3149MZ/XJqxJm6d?=
 =?iso-8859-1?Q?I6v9tyGGUorsXmOCQvcCpIhU+9uJMT+yyLtFwRwtvbSdHaVLgPddJ5rXh5?=
 =?iso-8859-1?Q?+h7i51XCmj9srUP2rvr62bHFdvgRliaa6Qv86KzTUndMTVEAXufyhjnM7e?=
 =?iso-8859-1?Q?Jy/rSFBjAfuAt9PtFzIsWhNg5j+/G/RZ78P+ys/Q/XC0tgdm/t2JKuBz4a?=
 =?iso-8859-1?Q?ZIEIQGkkdkVEwFHNdSGA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4734-24-msonline-outlook-c54b5.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8P189MB2197.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 6acba080-1924-4b9d-c57e-08dc297a65dc
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2024 14:21:25.1060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBP189MB1322

Thank you for filling out a Git bug report!=0A=
Please answer the following questions to help us understand your issue.=0A=
=0A=
What did you do before the bug happened? (Steps to reproduce your issue)=0A=
=0A=
Call git column with a negative padding value, e.g. `git column --padding -=
1`=0A=
=0A=
If the number if bigger than -3, the command will fail with the following e=
rror message:=0A=
=0A=
=A0 Floating point exception=0A=
=0A=
If the number is -5 or greater, the command will fail with the following er=
ror message:=0A=
=0A=
=A0 fatal: Out of memory, malloc failed (tried to allocate 1844674407370955=
1615 bytes)=0A=
=0A=
eg:=0A=
$ seq 1 100 | git column --mode=3Dcolumn =A0--padding=3D-5=0A=
fatal: Out of memory, malloc failed (tried to allocate 18446744073709551615=
 bytes)=0A=
=0A=
What did you expect to happen? (Expected behavior)=0A=
=0A=
An error message indicating that the padding value is invalid and not a cra=
sh.=0A=
=0A=
What happened instead? (Actual behavior)=0A=
=0A=
Failed command or even an OOM error depending on the padding value.=0A=
=0A=
What's different between what you expected and what actually happened?=0A=
=0A=
Anything else you want to add:=0A=
=0A=
=0A=
[System Info]=0A=
git version:=0A=
git version 2.34.1=0A=
cpu: x86_64=0A=
no commit associated with this build=0A=
sizeof-long: 8=0A=
sizeof-size_t: 8=0A=
shell-path: /bin/sh=0A=
uname: Linux 5.15.133.1-microsoft-standard-WSL2 #1 SMP Thu Oct 5 21:02:42 U=
TC 2023 x86_64=0A=
compiler info: gnuc: 11.4=0A=
libc info: glibc: 2.35=0A=
$SHELL (typically, interactive shell): /bin/bash=0A=
=0A=
=0A=
[Enabled Hooks]=0A=
not run from a git repository - no hooks to show=
