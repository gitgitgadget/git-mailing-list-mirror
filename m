Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06A01CDA3E
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 20:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728936433; cv=fail; b=kAtPapsNZQZoZXSos11ryzb0SetPlfNE0CeZbWeKBpaWDZokAw8rTy4tZePuf2Q6RvJUVYujvDy6J2mO59VfRNXe2rTu2jG6pxcX2D7FzllrbagcIQp58mLbcG8gFZBL2YhHrm7ZukdTxFEsJ6EBkHYLcDp0KXXocy0hdkGRc8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728936433; c=relaxed/simple;
	bh=XAknrxXeQsoVHGUbOjPrWY8bAB9lykocq65lHYYOlhM=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jHrh9bvXRaxMD5SoAchsPj3hK1Kuewbp8BviAUdT0e47eiYPplqtNmPRy/33ndB1epEC1Rz96qXG70Mjf6pzlqFiJ1GK/Z3pA8Nnik/pLgpBaKVZVGLtWZc1k97agF8+C8UfEYBhflfaOSA4vgLoDEweLh4SYH5bt9M5VD3uawM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RX3qhKri; arc=fail smtp.client-ip=40.107.92.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RX3qhKri"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ip3IlwnDFDu4MpVuKkYgOj4quazV020eeKU4q2bzuVBfyMruPY3xWT0SztaXLrjRDgolppeY8+NTuBwzN+sCCkaAW7tQepdqUBTgPXKQxJyE9IPNzNCgO1/vXQBxwqm6FOHmfmX5cWkKYVjnGR4nGRLgb6XX5iyJEwCsaK0kB6OQBPf1d17Cg6Ob+RT0iOFq8uQ5IlvKsOLeKO64LqyheHJV9z06jjlb2VQ7353/q49qkUgeAxBxQ29UxauX96f+zbH0AJOuBSeXuHW+/qyPvrbD5c1KhQTqIKolLg+EOJDga+FtNTHwoyFzsx3sPG64ALxLCYqyvVmrLylQPmuoMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XAknrxXeQsoVHGUbOjPrWY8bAB9lykocq65lHYYOlhM=;
 b=AEf5jaWrZWwc47Ve93wZjVOtAFDUZQD3t7RXlGy4QB6np4XJqOxX3ZYJ85MlvXHHNmkk34m6HW+VZP97ZpOxGpOlLx3IZBDhIi4EaH96ouEvnfOQ7lhTrAV/JyB8Ns22VxPs3ecnAcY7p92Tg2UFzD8qYB1+sZocBfGYiIa4l+v3Tbs2FUEG9GG2HnHLx8iNcgyAwqzA0cWTA4gdv4tjNSV3RfMKc40d4Pw+GfCVWs5+YogOwjBZIoDZPLiub7vQe6YN4HCE8oCSMOJ3GTs5B0nXwP7CRNmTXYmhLHklNytxpOwD3hXJUWTZqAJpICnhRnGGlzUzqGBzqCH8VCIb0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XAknrxXeQsoVHGUbOjPrWY8bAB9lykocq65lHYYOlhM=;
 b=RX3qhKrik/UhAQJSFx+XAyC8mdHVTS8bTm/E+ZZvzC6748X0AXu7wXPrceKbSRmL1fvvQ2ieluUBGY7ChHgj7QDNON18etFw7mo30jRPwfHPY6+v/KhRXi3wl2s84WgviN7imPd0QWhUEby3ll6jAtcRebEXbJZbPxizHgqcKRWaP7/U5yKSgGepmA0IoqGQDeq1hpD2ixbkI9+Ejl5YiVOgovPX//b0K/yJSmLg0mYcJYRxngJBsQkrfGWrLWNTjqLRgHh0dLxUT0wNnZpm7vknQx7btmsUAQte0WkCtdWZukE+DzUWVuXKBg4tS0j/KqJP/J5ilwuiHexrpMMO5w==
Received: from LV8PR12MB9407.namprd12.prod.outlook.com (2603:10b6:408:1f9::13)
 by DS7PR12MB6263.namprd12.prod.outlook.com (2603:10b6:8:95::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Mon, 14 Oct
 2024 20:07:08 +0000
Received: from LV8PR12MB9407.namprd12.prod.outlook.com
 ([fe80::d2ad:cd4c:2ee0:d85c]) by LV8PR12MB9407.namprd12.prod.outlook.com
 ([fe80::d2ad:cd4c:2ee0:d85c%4]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 20:07:08 +0000
From: Martin Fick <mfick@nvidia.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Should object repacking only update server-info for packs instead of
 doing it for refs?
Thread-Topic: Should object repacking only update server-info for packs
 instead of doing it for refs?
Thread-Index: AdsedKTJyToeQFUrRRytQtq+xwr2jw==
Date: Mon, 14 Oct 2024 20:07:08 +0000
Message-ID:
 <LV8PR12MB9407CB282D1FD4998C659D29C2442@LV8PR12MB9407.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR12MB9407:EE_|DS7PR12MB6263:EE_
x-ms-office365-filtering-correlation-id: 3ffcd1a5-d9af-47ff-ce57-08dcec8bc80e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ayB5MdTDH76f58bdUO4v+4ceCzlI+E+UU5R/T4T9G0NESBNMNJ3vbAFoZox3?=
 =?us-ascii?Q?SGetR6YnxE5UW9xtf48DnFxEprb28SWn1/d/nW0ANumGFnI5tpUPJh95VXh+?=
 =?us-ascii?Q?9fW1I6puwXQi4tjpDWCjSADETeGlkb9/A1mhVWp/bOa9zwESojyzBzQliAIB?=
 =?us-ascii?Q?iQ/DYrLeEkAjj32GoFe6h4YCpuGeJkmy+YbC1UNmE5iqfmTWDn5bePA7ZHZK?=
 =?us-ascii?Q?89RkDyzYZkJrVilSOsEjB0XiHXDyOrNn3Na84Oj1yxXgll1HsTuSpXUv7Wus?=
 =?us-ascii?Q?pWQ0fDAAeZcpWhBcGjwqdwG2Q9E7YBi+xudDC0Hh4zds9q4/ONIoqlvK89EB?=
 =?us-ascii?Q?kpdyEAoRRkJ0HC8Kax/TxNwrhDG4AB/d2U1NGS9Em7zmgT7PRIfexjOjkqV6?=
 =?us-ascii?Q?o+23ZAv+//krsExq1DQLTFwnhADW27qxtNnYh7ZFoNSvIylS3Bevi4c7hzHy?=
 =?us-ascii?Q?B2bEBhFBsC65afLOV65MJXYVVs03qTMywtNM2rWDs61ufm3QA2UZb+Tz69g6?=
 =?us-ascii?Q?lCpzJovHXfTQZBk09kmAsNkFj07//Q5sgPdMSZ0cvjh+WC4U3BK1fvjzEmjy?=
 =?us-ascii?Q?Po2G9+4cDlOSy5AgkfjDuuUewihtPUIl59/hhC2SCEVjLH/+T3pEvZ7pAuPX?=
 =?us-ascii?Q?jROWwpMq8GzXIkROqMr9kKaX03IDtvOdkpxND5+9XdRH2XnXg5IXMgbzj3N9?=
 =?us-ascii?Q?xKF0vNLaxLSnz9GsNsoYwtZV7hbRFr7gV5B09yrb1VU5akO+C5XNf4XwZrSh?=
 =?us-ascii?Q?kkoBIZMsJmjpZ0SOYYrYq0ffyuKup6Zsu80g6zIZ3Ji0Uhd48mNm2xkDbUVC?=
 =?us-ascii?Q?bUhoSxJNEA1HlHMQ6r0xENbL2L7pOjJlBnX/ahb/O5RHNKOYhdFPrUV7OjPc?=
 =?us-ascii?Q?WKra6FkMuOPRS9oD/GMOc2htxOgLW504zMaCyjlnW7mbnY7S3HCz9Nm5G4OE?=
 =?us-ascii?Q?eBkI5H3jryE4Y4ONeBDWzZBl2JKJFNZTzyxqfPWgvoEdmiudcZ1RtD0MRO/C?=
 =?us-ascii?Q?jknGbIiLAZKCv6VAlI0euRZDWNP90j+1HJunEFwQ1/x4h7iey96oe1aYuM8+?=
 =?us-ascii?Q?YYl+xNLBOGg+2u1Z5UC2LhN2vinUGM8xtfETxt10UyTeha+T9movxezOI/4W?=
 =?us-ascii?Q?Cz2mXeHmhwoXNYWmLDrYgmXKzdBqrD1RHN1qpAFbxOk46J50KqxGIjP4oWCk?=
 =?us-ascii?Q?JhwIHQikLAWnnfjp7FA9s/10SHT3gL8nqjuyhhIYbuOILvHZLlXDsq+tiQi5?=
 =?us-ascii?Q?LMoOQ65p73HMyQSZYhAMkb1qFhiNEfJ/T1dG1/LZcxyUJCKJpwIoX8A2Mw1k?=
 =?us-ascii?Q?ds6qj0+Zsmuh7dHy5W4oCOOfiSfp6y4GRYQEQ6J6b11Arw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9407.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?woiJYWYDodVKBA+7XqtOBo1TLlA0/vqoxGqzXkfLYBQPGUPpd0oetPoHEda9?=
 =?us-ascii?Q?y3I/eAsCQlU/RFQsoxK1zJg9Afrh7f6Ng3HbWhukUYkcq8GKuvNuGXWBcS3c?=
 =?us-ascii?Q?YC5TNYtgTKuWPGXHA6/HXZ6W0JmCdoWznl6DJ4R4Qwmoo7VSwPKASAiG9efv?=
 =?us-ascii?Q?zKEjl8jhXqNnhBJDTbYpfX9CKMh0wG3zdtKygRMb8dWU5hb9dSQDhSr43bDO?=
 =?us-ascii?Q?PZw6UVp48zhL1qenmsUdBBcMvipPl/QIAP9YxagOwz5yUpz50Lwc3Qx+hABU?=
 =?us-ascii?Q?jp+GR6NZ0offYm6EQXSp5EqViQCQ0plJw77Pkqcjo+DMgp04bhXAjznLxHKy?=
 =?us-ascii?Q?4s+mR+LZM3LaUSfkWbruJwMf3aDFAnVKHS7qD1zqW+r3KqJShwYjD5azKbZR?=
 =?us-ascii?Q?/AjUcOjIV2gihpcTMhDbpEhVk2woZ7BeoYea5HGKDfpL0tYQXIk/xeyhgXsE?=
 =?us-ascii?Q?DITct0tpVQIQT+Ebukq4fzIgrMeAxiLCZXaqJ+WDp8Y02dCfAfi5L4MltUlD?=
 =?us-ascii?Q?cncpgxQ39sjBCovF7PxITJ/ym21SarxVIc5RxYzj6gA6KRZ/F8G6RNKGTftS?=
 =?us-ascii?Q?qqApe0siN53S6dPKhQ6gxfTreiP9fvVtm9VnnlcfhdjZLBHhsn1zOf+MF5+R?=
 =?us-ascii?Q?jSS1Y1EBUt6Wijs6Zeh4nm0GrLjgEprl96QxM8c/SdBoJBJpDrpwybfkcZ0F?=
 =?us-ascii?Q?l/TpZc4he4JPEW0vs3z74c53qZmidgfGOxnAc9C5Yw6SDSXZbX2UtU5oBOCY?=
 =?us-ascii?Q?7jR5OGKbv9f8NF4OivEr/Q4LOsIynU0BdQcV2IsGyhhB03/Y27Q5zP/PNqfp?=
 =?us-ascii?Q?hmgNTNZlvNbbY8kcdXmgmpbtKaisAuMcwEHLMqyel/db6UvObq+SG+wN7Vk+?=
 =?us-ascii?Q?ZPXlLOcCFIP1mXzt9QQ9nNEAQU+BGROlmpRgqD1x7OldmrcLbtR0us8hGB4Y?=
 =?us-ascii?Q?KdDKkchV0MAB7YAHxM9zXJM8RdOt6nB2tbruVA7jrk4VxG7i+0aeybXuI8yK?=
 =?us-ascii?Q?TzNhO4ZzRT/WSY4H0hNYt/0eXe6N2OCJJyVAL8hiLkQxJD54YkbGluyG9xv5?=
 =?us-ascii?Q?TzNtA3D46mpbqmBLnq2UpVSnGysaxRsBu+0pcZXojn7LJ46iQS5bhMY+H58D?=
 =?us-ascii?Q?pKu3cdrFjr6SVc0s9zkLVqP/qKuXFTyHvefKSMdQ0nb2CAJUfpBREM4tKnjS?=
 =?us-ascii?Q?lvo88yMuuP//13adRLXHcUNNBu+XkdIgXH66FoJhNbuBznWOJNyfhAgdECuz?=
 =?us-ascii?Q?GYA92ZcL+mgYYSBBqwJ1PG5yKZXlk6Mf7t6YpwsnTRJDAl3zDJINEdRDWfkP?=
 =?us-ascii?Q?WbORVQoVhiEzRZYybuR2OwGk8iarNFK3ydn8g6yNgmsNz/mpvl8QF+TqNG5r?=
 =?us-ascii?Q?+yiyLLFV9C7sNGgOqnnZ6z3DbMClR8V+Qd4VedKMx0FsJSqGnsAXyI+S51Lj?=
 =?us-ascii?Q?8HJLJws9l3+AdzdHg8dgWJzR4PU9WPNgHhUjeZJwo8JRRjcR3VjtnnQHNR+9?=
 =?us-ascii?Q?PKvlZuZojDFGW+9b1+Me9kkE5mme4pEKSoaGT39mj3RUi8q7xdXOOXsopSbJ?=
 =?us-ascii?Q?usR6ynqMprIykxD7KWc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9407.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ffcd1a5-d9af-47ff-ce57-08dcec8bc80e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2024 20:07:08.0351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NZpjbFwf3a1FUrl606UPUXILJzXM/V02Tn6sE668G9y2U2OC1F0hZCGHJZ2wa/wcZTJ2ULY3+kqap3J1Cnba2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6263

I have been experimenting with trying to run git geometric repacking after =
every push on our servers and have noticed that even a NOOP geometric repac=
k takes approximately 30s on one of my large repositories. Further investig=
ation determined that it was the update-server-info call that was taking th=
at 30s, so running repacking with the -n instead only takes 6ms in this cas=
e! I dug a bit deeper and found that it was the update_info_refs() call tha=
t takes all the time. This seemed a bit off to me. Yes, it makes sense that=
 would be slow, I have almost 2Mrefs, but I had to ask myself, why is this =
being done from git repack? It seems counterintuitive that an operation des=
igned to repack objects would be performing maintenance of any sort on refs=
? Should this be improved somehow? Should there be a -packs and a -refs swi=
tch to git update-server-info, and should git repack call it with -packs? S=
hould git pack-refs be calling git update-server-info with -refs instead?

Thanks,

-Martin

