Received: from USG02-CY1-obe.outbound.protection.office365.us (mail-cy1usg02on0040.outbound.protection.office365.us [23.103.209.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9A71917D0
	for <git@vger.kernel.org>; Sat, 24 May 2025 11:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=23.103.209.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748086448; cv=fail; b=bn/ZrWPfMwiMS/v3E/ApkXqwM88JR4wE6sNLjm6B7hxzcFF4tXcsPgOBVfAZAmUHsetK+6HDOBaR2dNf5pTK315Ccw372qzrBBPqHtIIaV+0tcfD6BUch95YDywsbJ1EEmvzeqibKIlTOuzGppTIBAPlwGVNUT6/KkWps62Yttk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748086448; c=relaxed/simple;
	bh=Spr+uvyvQEefp1Zf8kLqpmHF4iS+xROhEJtucELJFGQ=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=STMQun1oc+TfXPLP1UvGoAe2QLPSkbi1nkBNELBvzZa2DUZUQkk1MiYEUcNRCqPQwzDnL6sC1DBEhsYy26fyzZNfUpVwWQx6pSccDY8dTqhhFeIahX3bbrOt9w2LkTzeFBLQjrve3Y6ClEM6eSAEN0yv7yVPf5N3KXlhlE6JJL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tsc.com; spf=pass smtp.mailfrom=tsc.com; dkim=pass (2048-bit key) header.d=TECHSERVCORP.onmicrosoft.com header.i=@TECHSERVCORP.onmicrosoft.com header.b=lktOjFS8; arc=fail smtp.client-ip=23.103.209.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tsc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tsc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=TECHSERVCORP.onmicrosoft.com header.i=@TECHSERVCORP.onmicrosoft.com header.b="lktOjFS8"
Received: from BNAP110MB1837.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:1a8::20)
 by BNAP110MB1855.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:1a1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.22; Sat, 24 May
 2025 11:18:43 +0000
Received: from PH3P110MB2161.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:1b4::12)
 by BNAP110MB1837.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:1a8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Sat, 24 May
 2025 00:12:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=RTGqyh6umgtcPcDOtD+PBWFgy4Y2/uSxhc9VEKCKxJS59QZRg1RvMUGcZuEcnaUsixi4CANSLju9OyqI7j+jODctwLYbBnsXoeEG7gFhzVcjbTX7VSMfawZ+hfeBTHp1AQqcVfjJbZXJh1+wOR+uBcvtyBNGbdEggf8jj4Q8oLdWhgKa+5GagKkbvkjC4Vknrc0Gs3czANQ0HrZb6I5iLFS94UUzgcB4uVsgeAy9sqiFYl8BJS02SSDpWkNnnmoAa0HZk/dl/b0JunaaPKCuzrwJAIP/Jj5LIz8c81XZNrOBlnJsfgR3p008cHtoUBCi5d2oChVibzLGKQIaPZ8/7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Spr+uvyvQEefp1Zf8kLqpmHF4iS+xROhEJtucELJFGQ=;
 b=fx69VLihjik3UQ1FKNvpX0hsWQnjTCAv1E0HaOYUFPiCiviWUeoWEhfpWLmLiTxu6TysE+mMm4enfODR1gOhChrDntdGru55GiGKIFmXf3xTPXpJZLmagPbhMQKlEA1Dqq7MpKHIyseDpl8EvOy7WY78UJylPLKzLl8Otpu/wZIo9hSwIZ9Viv97eQ5yLl034h/EvOO8SaejjJEitHr0EekHYoSRTO/4o4eVt4fFH4ZbKZYovUMXNV7vpyt8ueLF0BQezn8ILb18kMORS+XjrVGYfq5uJA4n6DYLeB8cXMST/lNrwqPrchIqezKejdKXPYmr4b0k5/xJaqbFL56GWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tsc.com; dmarc=pass action=none header.from=tsc.com; dkim=pass
 header.d=tsc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=TECHSERVCORP.onmicrosoft.com; s=selector1-TECHSERVCORP-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Spr+uvyvQEefp1Zf8kLqpmHF4iS+xROhEJtucELJFGQ=;
 b=lktOjFS84Gl18ErxM00MqVaVbKVsHAoWuA3lHoXRIcvLHZTVKXr6npGrxgeqG83GRQMc3DruL01kZ5agJJnhHBV/5puKGWQVfqVqJ3evGnRjPjl1XAmkjQLYJzFC9g2zzuDdfh1LSqu5ADirAABE9InqPkTfi/nwoQ/dkwS5gO5wSIUMkLTLDMRN/vbR+IBeLTsVHPIeivc5y5ugST4lwBSzBvlt6DcywlpTKW4LQd46RevEfFRVKrmsiUK5NmNY/aNlQk2hQFA00uGOJn8Gft78W9GCTXDcdGbeyztMGN9c341ZB+3q9F2YvFx2hVIi2rhB7sG+BlEI+G/EyTum7A==
Received: from PH1P110MB1153.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:18c::19)
 by PH3P110MB2161.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:1b4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Fri, 23 May
 2025 19:17:37 +0000
Received: from PH1P110MB1153.NAMP110.PROD.OUTLOOK.COM
 ([fe80::d02e:b1ce:2c53:255f]) by PH1P110MB1153.NAMP110.PROD.OUTLOOK.COM
 ([fe80::d02e:b1ce:2c53:255f%4]) with mapi id 15.20.8746.032; Fri, 23 May 2025
 19:17:37 +0000
From: "Wilson, Chris G" <Chris.Wilson@tsc.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: git config submodule.<name>.url cannot be a relative URL not
 sufficiently documented
Thread-Topic: git config submodule.<name>.url cannot be a relative URL not
 sufficiently documented
Thread-Index: AdvMFtQ4rqbvBkzpQemHg3ZY4IvC7A==
Date: Fri, 23 May 2025 19:17:37 +0000
Message-ID:
 <PH1P110MB1153A29A736A5EF7F3DCD0F59C98A@PH1P110MB1153.NAMP110.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=tsc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic:
	PH1P110MB1153:EE_|PH3P110MB2161:EE_|BNAP110MB1837:EE_|BNAP110MB1855:EE_
x-ms-office365-filtering-correlation-id: c1996c7d-b47b-4b6b-8b80-08dd9a2e7aff
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|41320700013|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?hCEvVZ6+joJBvmW4AQuRd60feLh3W1F7z1/GeGihrle2yMLYJ3bR6CCqyF+m?=
 =?us-ascii?Q?uae+Hnk8x2JUQ2tdzCBpmPOyfWTBVJJV7FIgH7W3qEgNzBO5IZHuL0dhxdch?=
 =?us-ascii?Q?hiT6EgoPJSC41NkwJODS3ZTfDuQgbiiFL3xJIZPkji3yV9etFYPiFB5iSQI8?=
 =?us-ascii?Q?rXJvGfaG/zSpuPAD0/0msLpkYDMSXnKuIZosByAC5O7Kk+9TQb/ee5gJkr0h?=
 =?us-ascii?Q?rK5rRoLRCjKLU8i3BxDL4Ng8kQmRH/30S+nfh5pon8+Vf6nUBPxv7bAutLT9?=
 =?us-ascii?Q?p86VaeFj2ZvY6r95J+B1aGKuakS/wP+XXOzK9xy8bDPMtODH24gQRHfmohQ0?=
 =?us-ascii?Q?jiFesLH1whbbnfwwF1+75QeECCPpvsZrTyP6GYEPXQSDRV/HjXwVvpn/AT18?=
 =?us-ascii?Q?ZuoDya/snkRbH9Crx/X8smlSDR5C34h2ivKK2sj9x+WPyFd/5OHzmT8f/QzJ?=
 =?us-ascii?Q?lpajVw2Rp+93m4IRaunvcbKP9PLyA9wIDJeznQVejJazpne3lAyr7NAsqu9P?=
 =?us-ascii?Q?fwIOc+UKU9pcNMDjqnjA0lS/f5/fDgjeo8tCfGOR9pdlRqyd4IS8S10de0mm?=
 =?us-ascii?Q?SOOLHxs0GsGeXghIu5PXO8uBcguv/29eVlKHczrHr68yPUGypZxJk8LrBtYB?=
 =?us-ascii?Q?7oZD/vjXZl2QV5JvtMFs9Ri1JvChCzvUL48ZcdhaYluWwgGL8xo0YoeMpoeD?=
 =?us-ascii?Q?ToxzHN9ffPG+succlHvtTMFv+1JFXXjYuRohd3OjpNe3C4stbbnkt2heQalM?=
 =?us-ascii?Q?NT+dYtahUf7vUVB2A6h3v4WMpu90hIuf1PRFfMZ4FAio4WrEpXtJK5aRskNe?=
 =?us-ascii?Q?Ek/avYGQVhAYNklS5dFR/dqSdKLxg1rqXh5IB8DBRZAU943DRvGxaL4OE2Qc?=
 =?us-ascii?Q?Vb4p0p07DkSL/q1XzWBlKRJt4NrPSivw3axR2/uBz90VDb1qwGpo87xs0zVq?=
 =?us-ascii?Q?OV7yK+P98sn2W4ZbLxRex9Y+ROUURQZlQbYwRg5fHWt355Jq9X/QcW1o0UyT?=
 =?us-ascii?Q?c8fw1lenol67XY/MXko9z+V1QjPjnm6QNxf92zwlRSW0GVqRYagzNXel+MRm?=
 =?us-ascii?Q?g7+dXvOa2Wyn0C7H/y/9uSvTpAwySrfAw0YosO1lNtUB5+mMe9q0Sbr3u0oo?=
 =?us-ascii?Q?466Wmk860vXgBoFUgCkUE0CJ/ifJgzPism0qN5/s1KhCT45YiFIz7ZlDfVtG?=
 =?us-ascii?Q?3EoyQ60O1rvc92chI5PiJVsc12q5f7tBUatDaXzeoOUrE1yhRIIcraFHsAr3?=
 =?us-ascii?Q?QW2mIwnpSeYyf70iOpeFg9tS10tccRgnVd+CkgSWr7LGv7c6hR7NR4l6X51V?=
 =?us-ascii?Q?vmK86gdMiOCkgZQQs6gCjUlmBpEEEDifjXDXhqUtgcyMnsDASrxY4k6PjvUa?=
 =?us-ascii?Q?yDmCBbT6yrha8YHivJMKW74ZgEyQchbQ8F+qs0Ac0m4eKpue/ckv0g7Mt3pV?=
 =?us-ascii?Q?nYuBB3VtVpU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH1P110MB1153.NAMP110.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(41320700013)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?KnM1urCwmulf0KpqGdM60YPV8FNbIMN1p6Y+UlXTmi9F542zqrLKADuI6afV?=
 =?us-ascii?Q?AR+SeWQpvbqkbEaVkxnEp3rdGI2XrLlgq8eP7zQW/tOA53RjLf0JbVIl6Jqk?=
 =?us-ascii?Q?7fVT3/DjCOuIVd+Bn5ZYJVN9XzK2KlP734RP+Ds+OH/P15SfRT9DTfwnDAZ/?=
 =?us-ascii?Q?dL1dZ6ZbX03XnMGSyQMRWj+KCZAcMoXn/n9pGam3YXDXNNpsl/28veWZiBUP?=
 =?us-ascii?Q?bg+oZD6YYS269S6WN/JHJ1miNVeWSP1RBq/KRPDkSnqbUItKpSNzRK+7Z88e?=
 =?us-ascii?Q?DX5ZHkBYH7975dnwrAFlpkTOsiYOo2KQECBjaFtryyDDDkPvHzFOV5g74ExT?=
 =?us-ascii?Q?rv4WfU+BAbJxWv8XYdgNWtyCDYvLgukcxNdp2lAyVKkAZ0VAFVcv2w7sKadP?=
 =?us-ascii?Q?ApKUoDn+VojzQTB08iNtYP1hsQsqcV5gmC/z/v9wAxr+XyjqntuFXnyEDSe2?=
 =?us-ascii?Q?c7GpzHu4bRbxGbeFSvQDRifD8APAkZ0Y/xUq55bU6KLDOrrkiZStFKQ7N6ua?=
 =?us-ascii?Q?xmW2KMf80C8obkJ5snSMcSDXJ7ruS/uOFfkGreRzR75NP1ZJRf3DjHCfxE2w?=
 =?us-ascii?Q?fYzDBJyyyBbn7YvPcL90+rW/NCa5Yqy1YXrxBdE19OBc5LHUET3t3TABEvtN?=
 =?us-ascii?Q?hYDj4+R1EfCKdscQyWH1gf/Ox3y1tbc8eqZBwLTGWnstzztJA5RYC8OoHkGi?=
 =?us-ascii?Q?FU1mwGWVB1yo0BFCAr/G4oCRHdSspg2p21DWir6AMAKYW+FS6UYBfuVgVGib?=
 =?us-ascii?Q?DVZ6+QVuaikjjlf/+beGYznPcleZRlqpg3p/YWoRB4s7IEI/Hw+2aS3xcdMW?=
 =?us-ascii?Q?HU9W1fvTBlxx0rzksqApTRxDsF73yp2Et0IfgNrCq0RNoeLLjLWgbcGXK+bs?=
 =?us-ascii?Q?03Kcnwz/5IbpllDD0Zc1kiJUfHL9kdFbobGp+YK+11yuwp8OMy5vf4gFBZVI?=
 =?us-ascii?Q?5t43dpZEughJP09+4idloFKLoyfrW8MJy0yihZFpIe3MBjEtjS6J1+bo3XIF?=
 =?us-ascii?Q?jZPZBWTeYwkYWU0/hKjHlwiwYMTWe7z0NSA6f+ym333H3uV78KeVnqToow3F?=
 =?us-ascii?Q?yQpQu1F73LrGTOMjVBvuCY5rRKAyrLyeuibfdekSa8Qy400LR2OdD2632QiJ?=
 =?us-ascii?Q?6Ba1o84AeiHO5L2UOlbhkM6XUphq69tEBsgd9O2k5D7GXYMRO0MH8zJBwpJ5?=
 =?us-ascii?Q?E3tJ/0D6vSaAvsDJcTLOBQsdABVQZV0BE/9T+GiJ8z4Gsj4vcY3DHSk+dsWt?=
 =?us-ascii?Q?KALUbu7rdbJTHLJ0XIyZQWuc330EWDr8lxJKgH8giFxFT5lVe5KH8fWlsvqd?=
 =?us-ascii?Q?k+IOexS+Uj3+DJ1TjHF9xTPNwN24IFXaGQ4C1GJiW8Sqo3vl4IGxBbKfy9SV?=
 =?us-ascii?Q?5DevZayL05mslVuIBhvd7njR4UytkxSzUBBYI5Kx/aFkXaLPw9LP4j9aq6WJ?=
 =?us-ascii?Q?Jo/ZClDXKWZTJ0bxaAZp8Z15De7vi7/os5v4BzMLTByLcDRH5nFX7IJ4DFRz?=
 =?us-ascii?Q?MNEOzMUbfOi0Wpw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH1P110MB1153.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c1996c7d-b47b-4b6b-8b80-08dd9a2e7aff
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2025 19:17:37.9141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e6584d66-000c-4674-a5d8-13549627515e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3P110MB2161
X-OriginatorOrg: tsc.com

Git Team:

Thank you for all the work you've done.=20

We recently ran into an issue where we needed to modify the URLs of some su=
bmodules in repository as specified in the .gitmodules file from an absolut=
e URL to a relative one for a CI/CD system. With a desire to leave the orig=
inal repository completely untouched, we played around with using git confi=
g submodule.<name>.url to update to a relative URL. As you probably already=
 can determine, this didn't work. We ended up having to sed the .gitmodules=
 file in place.=20

I propose an update to the documentation for git config (as I found in http=
s://git-scm.com/docs/git-config) to specify that submodule.<name>.url must =
be an absolute URL and cannot be a relative URL (or will be treated as a re=
lative path on the filesystem).=20
Alternatively, an option in git config (or maybe git submodule?) to treat t=
he provided URL as behaved in .gitmodules would also be appreciated.=20

Thank you for your time.=20

Sincerely,
Chris Wilson=20





