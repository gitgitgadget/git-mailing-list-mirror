Received: from smtp2.e.amses.net (smtp2.e.amses.net [213.161.89.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56CB14D6EF
	for <git@vger.kernel.org>; Tue, 18 Jun 2024 12:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=213.161.89.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714321; cv=fail; b=gnT4VMDJ6a4F7D/DftV0dsN3nHiHRz6Ejm0I3UzaxbBAK5ZBMWT8jZ+4fxz/N5YUqYUjPHVbFFXbZByMfOF30okPb7JiO8HixqESNPw6LT3rMX+qZhVpIH5PcxJIW+fhWyBhnSs0r7MPLjKn7Vo0whguJHAPBBPpwbuNQ5/LEmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714321; c=relaxed/simple;
	bh=25ch+dYOdKl/MBlbUXk4VUXL0s0GR/wdTGAllNmZ5as=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=IzLQBihD25f5QXgLXERGygwuKKD7C7liBNo9XJSBsIzYdO6pE4BGrvWdN5/4RitDd+U956s8gLeG9jewgTsztq6TybRIJLNugN+srzfOPEFeYNxKqS+8Li7CGAAopgaydbVrOMV2B7oLWPRhulF+7yxfSDT8zQdrsdp8bYj4Jmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nhs.net; spf=pass smtp.mailfrom=nhs.net; dkim=pass (2048-bit key) header.d=nhs.net header.i=@nhs.net header.b=J+DhUjEz; dkim=pass (2048-bit key) header.d=nhs.net header.i=@nhs.net header.b=ZFzXx59i; arc=fail smtp.client-ip=213.161.89.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nhs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nhs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nhs.net header.i=@nhs.net header.b="J+DhUjEz";
	dkim=pass (2048-bit key) header.d=nhs.net header.i=@nhs.net header.b="ZFzXx59i"
Received: from smtp2.e.amses.net (op-hepims10.ops.amses.net [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CDE881AA187
	for <git@vger.kernel.org>; Tue, 18 Jun 2024 13:19:20 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=nhs.net; s=secureHL;
	t=1718713161; bh=25ch+dYOdKl/MBlbUXk4VUXL0s0GR/wdTGAllNmZ5as=;
	h=From:To:Date;
	b=J+DhUjEzZumG9btVAM7h/8DQFr6aQHlgRCcC9b034FrONhYE2wG5PFsGxGxzArA6T
	 OKoDbVlHT+gki9hLck6c9TVKkniNH4qMx367lKVkOiogqlZ6CxNn2l9F+Nyd1v12BX
	 B1xL1xSDHeZiNG7SNpkq0pYcJTJu+nxRhDn7HSAqNG5xx0wh5L9GsRe3dOj0ahPC18
	 /tEg63i9Srlg+w6Q1U1loxsSQ2hrERnbKZQK+c5r7BN0j2rmFHluQvl8eevNKokMT6
	 ARdaw/ywk3Q8XuJE+JTXAFKyupaelAHx5XihzF11yguvo8kgEvhYseCGHySOalfF9G
	 TO2sBEKQVGRrA==
Received: from smtp2.e.amses.net (op-hepims10.ops.amses.net [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A76331AA1EC
	for <git@vger.kernel.org>; Tue, 18 Jun 2024 13:19:20 +0100 (BST)
X-IMSS-DMARC-Authentication-Results: spf=fail (sender IP address:104.47.85.41) smtp.mailfrom=nhs.net; dkim=pass() header.d=nhs.net; dmarc=pass policy=reject action=none header.from=nhs.net
Received: from GBR01-CWX-obe.outbound.protection.outlook.com (mail-cwxgbr01lp2041.outbound.protection.outlook.com [104.47.85.41])
	by smtp2.e.amses.net (Postfix) with ESMTPS
	for <git@vger.kernel.org>; Tue, 18 Jun 2024 13:19:20 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jXd7PeDI5o0/m1fBFkROHQ7rq1I3SLeE4umxWFkiCcTHtX4DSROy3lsdQsP5GD5fttDBfBDoSOeOndAQGmaCqVqHDbaJfgWqRf/d87Fl8PAoq2allGHRfIRW9onAvoQeBIhPZHzw/sU4MkWmfiJkGhkLxlgMDy9AsJejhgnbNtHcWYn04NzrvYL62+RIlAtirZOjKDf00M12MuLYyIGmd4k6O2Y9aTEIDt10QcHbPjZ4kCastxi6FL5rB4tXJU0fhF9AmidBCh4EXb6SeiBVjLPtxlQJ426n3bQ8gPjPu+BazFRPF99z+PDi1jxczVnRLRwrhA0aI4jvKMHeOLGqcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25ch+dYOdKl/MBlbUXk4VUXL0s0GR/wdTGAllNmZ5as=;
 b=Yx/GIBwRE0ydvilyulE6I21Z4hLpdg0a5wz4R3PhNu8m+Wiqv3lYilJiEhZrvIAd6VAw2suMTc3u1BT8b4p5mJReaw/VKL/Is2Pmia67JjQzFPbWMnbz3avytvpoPAs5fEYtQIUWXKlaVzBzysNm+4fvourK87nMtKQhzvXm6tdHUIVaNi4p9ikFt9pb0I1zNUstdQUwAIPYue0qkN/s8RWnxJAkvQRnIoW97usx8+ecK6qTlWi8u4Vqa/awRoar7OPdgXKwy6zF37cWaYKc3aEMLEURvKscQbrTsD6j1v1/BGE/vC6FN6LsPWpgeRaE5DRuCb5QeO5S3bIChidwwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nhs.net; dmarc=pass action=none header.from=nhs.net; dkim=pass
 header.d=nhs.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nhs.net; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25ch+dYOdKl/MBlbUXk4VUXL0s0GR/wdTGAllNmZ5as=;
 b=ZFzXx59ilBIFzbDlPd5VznGC4q35nd6FMtaxrIQrPBoyrib5qnh8LZlDMZNf7dQyOJPx7g2mIILmz/jvWFU6GCltbS4uIgtQogGhGkSBGBCVwQ538QB6HrGEPJ5csuMm2utQoqut5C+TtPvdtA1Kq8T2nZMHqMjqSW5sFRJEjwjNe0x1zdUDl/qrjoix3UnSaIqWEvcXBn9FYq7T57ZQfKsWQBXd7YBrYbHaTUR7JnA3y3ljZQwl4SZRIU/VEFWGzsfk54Nhp7JBoG/Xh244XuQzyaSSgy4/2DLrPaPAYJwOREfY0KqAClq5JhdUeu0vt7WTrRyBFw4XWe3+V10zTw==
Received: from CWXP265MB3013.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:c9::7) by
 CWXP265MB3639.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:f8::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.31; Tue, 18 Jun 2024 12:19:19 +0000
Received: from CWXP265MB3013.GBRP265.PROD.OUTLOOK.COM
 ([fe80::fe46:bee0:8a7e:73d3]) by CWXP265MB3013.GBRP265.PROD.OUTLOOK.COM
 ([fe80::fe46:bee0:8a7e:73d3%4]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 12:19:19 +0000
From: "ELFORD, Richard (NHS SOUTH, CENTRAL AND WEST COMMISSIONING SUPPORT
 UNIT)" <richard.elford@nhs.net>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Multi Factor Authentication for GIT software
Thread-Topic: Multi Factor Authentication for GIT software
Thread-Index: AdrBebL9yHElB3LbRFGDm3JU1U9sTA==
Date: Tue, 18 Jun 2024 12:19:19 +0000
Message-ID:
 <CWXP265MB3013B13F4BC4D7574E6E86E281CE2@CWXP265MB3013.GBRP265.PROD.OUTLOOK.COM>
Accept-Language: en-GB, en-AU, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nhs.net;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CWXP265MB3013:EE_|CWXP265MB3639:EE_
x-ms-office365-filtering-correlation-id: 01032a3f-c5f4-4b16-3018-08dc8f90e139
x-egress-defend-domain: nhs.net
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|366013|1800799021|38070700015;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q2dPSm5TSUdzVnJvWjBlOWZVazNjcm1nQXVQay90R3ZxNFVVQmcwSXprSlBD?=
 =?utf-8?B?bzlaTCtIY2owQVVKRFNaNVJLT0xkL3c4THpzZjM3VUs3RDJFNEN4bEhGeCs2?=
 =?utf-8?B?KzlsN2dEUmdZclJwUStBUXhxTjVHOGlYa3JHc2lxc3Q5bnJmNjRWS29YS0Rw?=
 =?utf-8?B?aUpTakE3WWp1QkQ3b3dxekNsd0N2UmxUbDRCSzVLOUp3Si9HRTZhd3hseGVU?=
 =?utf-8?B?aW5mYVh0MVlQd2FiWHU2Tzc4bnRNMEkrVk5JMWJZWkhRdEU3WnZHOStYTFNw?=
 =?utf-8?B?S20xWW91a24zbStBWitBSHd4RHF3MmVaTGRYOTNNMnNmUnNFbzR3UTlqQzcw?=
 =?utf-8?B?UzRXNFdVcGg3VnZYcEk3Tkdud0xzbnpUcXptemxkS0lwYTMrMVFiWFhLcitx?=
 =?utf-8?B?Yng3QWJTTWx2M1JPNmlFaDJSUnpKbWN1cTR5S2hQRytuU0thdFBMV3BORExX?=
 =?utf-8?B?UVFnaCt4Z25NNTJvYWxRTGNYRjV2RFNWTm1RWGw1YTZWZ0V6Zm11MmplQXV4?=
 =?utf-8?B?b2VaeHFDd1Z2SEs2RWkvUVIwWmZ3OEZQbERIUExvaHh4ZDByd3Q1NEtzK2dQ?=
 =?utf-8?B?NFZjM1B5a1NPbERTcVdsTnY1QSs4RXFlK1hMOWxCdnF2ZVFXSktmemhVbjEw?=
 =?utf-8?B?SzdwWmNwZEp5T0dvSmpaWFpseVEySUl0VFBwR0pXQ21WaXpDblpyeG1zMW9S?=
 =?utf-8?B?eDhVczBTVUFGT2xrVHQxWWdmZGphTDFjQ1V6cDBUdTNaZDQ4UXJSWlc3RTRL?=
 =?utf-8?B?SVJLYzhiejhPTU9mbHFieU05MVJJRXVmckVHNzU3OG0zMWpHZ29QYnhDallB?=
 =?utf-8?B?VEZ5NXlDb2kwTnk4NjFqVVhQcTNtOEMxeG5YeGwzQVJGWVZOYXhFMEFrb20w?=
 =?utf-8?B?eXM1VHIvMm1oRVkxVEJ1eDBMVklWKzdGaDlqeUJVTDNlODdGNmtaWW0wTFY4?=
 =?utf-8?B?Z2UzUkxQb3QxeTJ0cXJadjNqcE5lMzdKQ3B2MVdHQUZZNFRwMUVjTlY2WnNQ?=
 =?utf-8?B?a3ErWVJvTnJQbjlNZUJGTlFpWXcwaHlUM253RzA2VzFaY0dIeHFNZS9IR2g5?=
 =?utf-8?B?M1h6UytQV084Q3M3T1Z4K3pkcjI3RE5EN3k0SnpjVk9KUW5mZkZBRUkrWVJh?=
 =?utf-8?B?aFlyaXNJMmprMmMzeUZ6dnVlMzd2VnE0NW05c2l4WE1Xakp1SCsxc0o1VHpu?=
 =?utf-8?B?NXdnNkdMWkFTOHNaMDFMMTcyTURrWk9vYzFkbHZUbGNHK0RnOXhaNGxNWFE3?=
 =?utf-8?B?Z1Y3aUYvNmJsMXM0S1p0SlRUYjYxTVpDaThHbnJDb0FnRk1TVHllL1RCTm1x?=
 =?utf-8?B?Nm9kWXZpcTc5OC9rMlZiSWFCKzdaanA1ZlRWNDRRbXRsNlUvQlRHU3BFb09P?=
 =?utf-8?B?S09GRm5kbWpJMXpIOExCbGN4NkpLVWY1S1FFcjFRbzdGMkJTSWhvN01Yci9B?=
 =?utf-8?B?YktaMy90WXA4YnZ0UFBueHN2bXRQSitPWGZONmV0V3ZzZnlVSzZXNVFKaW9W?=
 =?utf-8?B?Tmw5em55b0xXUk9YRitONnRwY2J0RExrY2Y4aUNVS2thUHFHM3dGc3pQaWNV?=
 =?utf-8?B?Z2NMZTNsZGY4ZE96b20zV0xacmJvVGdQUHFWVURudDYrZEJ6UzZYM2p0U2RW?=
 =?utf-8?B?aWpLYmxIUkpYSlIwMXhtMGNHdmdWc0NsWDUwOEtEMUxDSjEyL1NzZU0yZGtx?=
 =?utf-8?B?NE1Ba1RmMnNNQkppWTJrM0twaS9RRXdIM3VjaWdkUFFtS05tbkpkcTg2SHJu?=
 =?utf-8?B?V0c5OUJHQ3JKZytEZEhHY3ZkY3MwazlHekRKTzNaUHlSc1ZkS1l1Sjc4Ylpa?=
 =?utf-8?Q?ceYuuRPbeWurA158kQ2++Ajw51jIhxTf6Sy6Q=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP265MB3013.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U01JSmdRMjNCUDkzdnBtS1NlR09RYVFvbENnTFdXT1lXNlhvblNWNjQxaHFU?=
 =?utf-8?B?dmNJd1NIZzU0TzFLVCs2aGtzdWNycnBaZ0V6VjVkV2MwMXQ1ZEo2eE84V0pX?=
 =?utf-8?B?UnYwVzBhSUhmODFJV3JxTW1WRWw3OWE4anh6U1k2L29JVytOVUVwQTRROGp3?=
 =?utf-8?B?NnRWeWE2b2lGZmhob0QyNUl3VVpOTWNXc0pHeVBXNS9FRFpBY0ZJVnpzeW5u?=
 =?utf-8?B?b0s1MVJkc2I2YmJPbXJZcEJ3M2xDaGhCcENTUDFXeEJCSmZnNjRROS9nRjhZ?=
 =?utf-8?B?QTdmMmFuZ3NoVHJsVWVLK2U2YitGRTNvRVRGNXBwMmV4NjVOd1d5K3BvRmZn?=
 =?utf-8?B?TndNbGJrc3VZNmdwT29wa2ZncEhVaHNEaDU3OHZpdktOZzlsYTg5TjhCeFNB?=
 =?utf-8?B?VEZsTkpFTDdQRmdaWmlHSEtqWDJvU0NkWjhWamF3d253eU01NVRibi9SbUta?=
 =?utf-8?B?SFNYOEpKVzBxZ2w2NW95QisybnFYTmMxUGdvT0QyTko1K3g2dmVyRUZGMURE?=
 =?utf-8?B?NjA4NUhmZS84WFc0RUtNSEdmaG52TXZHdFlCa29lVmc0aGNmM2o1Y3NNenJC?=
 =?utf-8?B?QW5GNlVCV3lNNnhiZUpwcExKWXRZS1pVVVB1bnpCR3FoQnp5YlkwWmpOYVN1?=
 =?utf-8?B?NDN4dGRsYVVNci9HZUsxNE1FeUNvZm1IeEtHTXB5MS92RmxwMEFRRG93cnVr?=
 =?utf-8?B?emtXZTl2WUo1eTNPMTRlVkZwUjRwUnFsUkVlWUY3dVVaN045eW5CL0U3aU9N?=
 =?utf-8?B?YkhwaEdkRDFJV1NySXUvS05wV1V6VVVRK0lKMFh3dlh1NGVjd21QOE9ZeEZW?=
 =?utf-8?B?UXNLZDIwK3ZWTXNONkZ2Q2lzU0RTLzFVRjJvc0RMYUZjV3ZrOStjQ2YrK3Qz?=
 =?utf-8?B?b2QzZ29jQkZnWDFtclA5UFFkWmp2UGE0YnVOSnFyNEZrWXNaaUZtMEZGK0M5?=
 =?utf-8?B?SVMycDNxL0FaNFhvelVadDlsV1JNaE1FVXZVT2FSWFhQRXJaNnFadXo3VFVJ?=
 =?utf-8?B?Ry9GM01QczdlSGpHUzdjVmFheW9TdnRibnZyRXJrdXpJQllUZ05VcDBKM1Fl?=
 =?utf-8?B?QUcxNVNaclY4TVlNdUJLRUgzNm5yQXk1YVMyZFlRMDdPOVpVd1FmdUNudFBX?=
 =?utf-8?B?MisxNkdDSjJZakIwVmhOWGZ3SFJJRE5VbTFJcm8wWTFhY0NtSThhVFAxZmhJ?=
 =?utf-8?B?RDZrUzV2MmlXTlEwY0ZCMlMrT2s5ZWlxWlA5TUtNM0hVQnFWbkkrYzVpcTVW?=
 =?utf-8?B?SlhSMDBCTGtKbktHelNuc0hRNVJ5YkE1TnpIbkV3WDhSeTJHaWdWY0VpaEFL?=
 =?utf-8?B?TTZMcE8wQWcreDR2NXVOMFF2MlRmS01Wejk2d2VmU3l4bmpOanBwbis3Rnl3?=
 =?utf-8?B?NDFEeWxqZlpIUjNMRWNOTUNvQlI4NnREeWZmc3Y5b2hMWHVpSDZ1UXpPaFRn?=
 =?utf-8?B?YU05SlVvdDBLdjE5cElseFJlcTUrcnJIVkNXMzZ6bk9QZnI3VzI3SlZEUTZV?=
 =?utf-8?B?TEhnTDBLL1FIK3BzUkIxTmtHc0h1MisvaTJFVWhhMS9IV1M0Sjcwb3dzbjVt?=
 =?utf-8?B?cUtZbWphMElBQmJGV3EyVWVMeVp5RmlhSVQ0bUlhWTVwMkt2T2xKZENmMk15?=
 =?utf-8?B?MEcxRjdSQ21ObEplV1hlSEpJMktJVmdGZlFpQVRrYXUza0grUkNDaVpGRjVI?=
 =?utf-8?B?Q3BMM0hJSy9qY3VRZ05XQThHeFlrV2VnOGlzdHdoM1c1YXVWcDhJdk10Nisz?=
 =?utf-8?B?Y3lUU05Fek5oK0pYd1FGNjRsODhIZk1wblJ0Z29JTXI5WTZZVzlxQlk2OUNu?=
 =?utf-8?B?K00weFd0S3ZFbHRrUmdkZzhnaDh1S05yRUptL2JVVXorSmNrQkZ2cnNKUWFB?=
 =?utf-8?B?Q3ozUnpraE5zVkJtTW52ZmV1cjJVdGU4cUZIRHRLcGhPdE8yWEwyYVdwL2lw?=
 =?utf-8?B?dmdpK2FzOGxoamJVNWk3NENNSUcyWFRubFNXRXlrbWRDTHRNMGNzSHpCL3E5?=
 =?utf-8?B?TldTc0h1eVZxUXJTUWRUdkUzSk5WeW5hR0sxeXZNbHM5NDlSMGNVSUh2U2xE?=
 =?utf-8?B?ZDc1em5yQ0k3ai9GemQ1Sjl5L2l3cTZvRFdGSDJPU0FvRmlQT01DSGlWVE9F?=
 =?utf-8?Q?p45qUq49Cx08C2rSMEuieSf1I?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nhs.net
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWXP265MB3013.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 01032a3f-c5f4-4b16-3018-08dc8f90e139
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 12:19:19.5957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 37c354b2-85b0-47f5-b222-07b48d774ee3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wTXn0hLbrAoeea2L1R5lqw/EpdB7f8o6BjIrsQq46XlAH8DpO9R+31FrATL3eaPgz3VFUe0TySkIOSQ5gqbLLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB3639
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSVA-9.1.0.2195-9.0.0.1002-28460.007
X-TM-AS-Result: No--12.996-5.0-31-10
X-imss-scan-details: 
	No--12.996-5.0-31-10;No--12.996-5.0-31-10;No--12.996-3.0-31-10
X-TMASE-Version: IMSVA-9.1.0.2195-9.0.1002-28460.007
X-TMASE-Result: 10--12.996100-10.000000
X-TMASE-MatchedRID: ZtVtsQBWa9PwRU42k2liJJKLzY5ZrthjfkuZtv/FS5qJe1B4NC2YA6Jv
	4V2TxsYRTVDp9ySUBe5Ho97MUKMvelkA85UedAzL4T0EFRcNxxS/GmbPrBAl6lNZ+3n6rYF8WnC
	BbC6wDBKGRvqOT3m3+9Uf8/gZ0Wa4N6b38v8EJEr6zT5BlgBw36n/3nyhTdZw12cVGkvCPnO+AL
	SwYLrKHTAeQzOM4yMG2xVlUD9eyN2XC3sMAGu+n/gWrMZvbmeHgRgPcwHZ1VtGMe+tDjQ3FrqTo
	rL333BQtQTfQKYWqkFuU5AEoDhGw/1+4M8qpQwg7lvwa2CRpf0nhzAhgvoq5yYOfgY+jBTi45ee
	sIUwtzOACjAOBvU6XB84WfmE/WgvLT5n6hcv+PeNyH/G92IcfBmyTBaqiJvc4EZYhAha+qrQQXl
	tEDZXyiebkrhmS4/woWjx8y7f3IlXQb4RzRujRAXGi/7cli9jCCo+lsDuynVuSHZsOIlkZIz3wm
	fxmqqhr33kQnBDTC2KQfHzsMI7dbb7K0jSYFpBzo/4cSt+WNUNsuQOB7UFW0blvOK72ebfnDsso
	Nzp4PTi8zVgXoAltj2Xsf5MVCB1goHTpsmNVvzI+J/9cwnC0hIe1e0XhI6F9xS3mVzWUuCRTpSQ
	iv9X7bRBGWsEXd5lWz1uQXWw3i4cJmGx1mvePB+FN6uTusjaXYRHhnTNf3OaOfAjZhyWcg==
X-TMASE-SNAP-Result: 1.821001.0001-0-2-1:0,12:0,22:0,33:0,34:0-0

RGVhciBHaXQNCg0KSSBhbSB3cml0aW5nIHRvIGVucXVpcmUgYWJvdXQgbXVsdGkgZmFjdG9yIGF1
dGhlbnRpY2F0aW9uIG9uIGNsb3VkIGhvc3RlZCBzb2Z0d2FyZS4gQXMgcGFydCBvZiBvdXIgb25n
b2luZyBlZmZvcnRzIHRvIGVuaGFuY2UgY3liZXJzZWN1cml0eSBhbmQgcHJvdGVjdCBzZW5zaXRp
dmUgZGF0YSwgd2UgYXJlIHNlZWtpbmcgaW5mb3JtYXRpb24gcmVsYXRlZCB0byB0aGUgTkhTIEVu
Z2xhbmQgTXVsdGktRmFjdG9yIEF1dGhlbnRpY2F0aW9uIChNRkEpIFBvbGljeSB3aXRoIHJlZ2Fy
ZHMgdG8gc29mdHdhcmUgcHJvZHVjdHMgd2hpY2ggd2UgaGF2ZSBmcm9tIHlvdXIgY29tcGFueS4N
Cg0KQ291bGQgeW91IHBsZWFzZSBwcm92aWRlIHVzIHdpdGggdGhlIGZvbGxvd2luZyBpbmZvcm1h
dGlvbjoNCg0K4oCiICAgICAgIFNvZnR3YXJlIE5hbWUNCuKAoiAgICAgICBOYW1lIG9mIHN1cHBs
aWVyDQrigKIgICAgICAgQWNjb3VudCBNYW5hZ2VyIG5hbWUNCuKAoiAgICAgICBBY2NvdW50IE1h
bmFnZXIgZW1haWwNCuKAoiAgICAgICBBY2NvdW50IE1hbmFnZXIgVGVsZXBob25lIG51bWJlcg0K
4oCiICAgICAgIE5hbWUgb2YgdGhlIHBlcnNvbiBjb21wbGV0aW5nIHRoZSBzdXJ2ZXkNCuKAoiAg
ICAgICBKb2IgdGl0bGUgb2YgdGhlIHBlcnNvbiBjb21wbGV0aW5nIHRoZSBzdXJ2ZXkNCuKAoiAg
ICAgICBDb250YWN0IG51bWJlciBvZiB0aGUgcGVyc29uIGNvbXBsZXRpbmcgdGhlIHN1cnZleQ0K
4oCiICAgICAgIElzIHRoZSBwcm9kdWN0IEludGVybmV0IGZhY2luZyBvciBIU0NOIGZhY2luZw0K
4oCiICAgICAgIFdoYXQgaXMgdGhlIFN5c3RlbSBob3N0IHR5cGUNCuKAoiAgICAgICBXaGF0IGlz
IHRoZSBsb2NhdGlvbiBvZiB0aGUgZGF0YSBjZW50cmUocykgdXNlZCBmb3IgdGhlIHByb3Zpc2lv
biBvZiB0aGUgc3lzdGVtDQrigKIgICAgICAgSWYgdGhlIHNvbHV0aW9uIGhhcyAzcmQgcGFydHkg
ZWxlbWVudHMsIHdoYXQgYXJlIHRoZSBnZW9ncmFwaGljIGxvY2F0aW9ucyBvZiB0aGUgM3JkIHBh
cnR5IGRhdGEgY2VudHJlKHMpIHVzZWQgZm9yIHRoZSBwcm92aXNpb24gb2YgdGhlIHN5c3RlbQ0K
4oCiICAgICAgIE1GQSBTdGF0dXMNCuKAoiAgICAgICBEYXRlIG9mIGxhc3Qgc3RhdHVzIGNoZWNr
DQrigKIgICAgICAgUGxhbm5lZCBkYXRlIGZvciBpbXBsZW1lbnRhdGlvbiBvZiBNRkENCuKAoiAg
ICAgICBBY3R1YWwgZGF0ZSBvZiBNRkEgZnVuY3Rpb25hbGl0eSBkZXBsb3ltZW50DQrigKIgICAg
ICAgRG8geW91IGhhdmUgYW55IGFsdGVybmF0aXZlIHNlY3VyaXR5IG1pdGlnYXRpb24gZnVuY3Rp
b25hbGl0eS9wbGFucyBhdmFpbGFibGUgdG8gYWRkcmVzcyBNRkEgZ2Fwcz8gIChFeGFtcGxlOiBD
b25kaXRpb25hbCBhY2Nlc3MpDQrigKIgICAgICAgRGF0ZSBtaXRpZ2F0aW9uIG9wdGlvbiBhdmFp
bGFibGUNCuKAoiAgICAgICBEb2VzIHRoaXMgc3lzdGVtIGhhdmUgQWRtaW4vUHJpdmlsZWdlZCBh
Y2Nlc3MgYXZhaWxhYmxlIGZvciAzcmQgb3IgNHRoIHBhcnRpZXM/DQrigKIgICAgICAgSG93IGlz
IHRoZSBzeXN0ZW0gcHJvdmlkZWQ/ICAoRGlyZWN0bHkgZnJvbSB5b3VyIE9yZ2FuaXNhdGlvbiAv
IFBhcnRseSBwcm92aWRlZCBieSBvdXIgT3JnLCBidXQgaGFzIDNyZCBwYXJ0eSBlbGVtZW50cyAv
IDNyZCBwYXJ0eSBwcm92aWRlZCkNCuKAoiAgICAgICBXaGF0IGlzIHRoZSBkYXRhIGNsYXNzaWZp
Y2F0aW9uIHN0b3JlZCBvbiB0aGUgc3lzdGVtPyAoVXNlIEdEUFIgZXhhbXBsZXMpDQrigKIgICAg
ICAgRG9lcyB5b3VyIG9yZ2FuaXNhdGlvbiBob2xkIGN5YmVyIGFjY3JlZGl0YXRpb24gZGlyZWN0
bHkgcmVsZXZhbnQgdG8gdGhlIHByb3Zpc2lvbiBvZiB0aGUgc2VydmljZSAoRXhhbXBsZXM6IEN5
YmVyIEVzc2VudGlhbHMgcGx1cywgSVNPMjcwMDEsIFNPQzIsIERTUFQsIERUQUMsIE5JU1QpDQri
gKIgICAgICAgV2hlbiBpcyB0aGUgY29udHJhY3QgZXhwaXJ5IGRhdGUgd2l0aCBTQ1dDU1UNCuKA
oiAgICAgICBOdW1iZXIgb2YgdXNlcnMgLyBhY2NvdW50cyAvIGxpY2Vuc2VzIHN1cHBsaWVkDQri
gKIgICAgICAgV2hlbiB3YXMgdGhlIGxhc3QgdGltZSB5b3VyIHByb2R1Y3Qgd2FzIHBhcnQgb2Yg
YSBidXNpbmVzcyBjb250aW51aXR5IGFuZCBkaXNhc3RlciBleGVyY2lzZT8NCg0KV2UgYXBwcmVj
aWF0ZSB5b3VyIHByb21wdCByZXNwb25zZSBhbmQgYW55IHJlbGV2YW50IGRvY3VtZW50YXRpb24g
eW91IGNhbiBzaGFyZS4gSWYgeW91IGhhdmUgYW55IGFkZGl0aW9uYWwgaW5zaWdodHMgb3IgYmVz
dCBwcmFjdGljZXMgcmVsYXRlZCB0byBNRkEsIHdlIHdvdWxkIGJlIGdyYXRlZnVsIHRvIGhlYXIg
dGhlbS4NCg0KVGhhbmsgeW91IGZvciB5b3VyIGNvb3BlcmF0aW9uLg0KDQoNClJpY2hhcmQgRWxm
b3JkDQpCdXNpbmVzcyBTZXJ2aWNlcyBNYW5hZ2VyIHwgRGlnaXRhbCwgRGF0YSBhbmQgVGVjaG5v
bG9neQ0KTkhTIFNvdXRoLCBDZW50cmFsIGFuZCBXZXN0DQpUaGlyZCBGbG9vciAtIDM2MCBCcmlz
dG9sIOKAkyBUaHJlZSBTaXggWmVybywgTWFybGJvcm91Z2ggU3RyZWV0LCBCcmlzdG9sLCBCUzEg
M05YDQoNCg0KDQpUaGUgaW5mb3JtYXRpb24gaW4gdGhpcyBlbWFpbCBtYXkgYmUgY29uZmlkZW50
aWFsIGFuZCBpcyBpbnRlbmRlZCBzb2xlbHkgZm9yIHRoZSBuYW1lZCBhZGRyZXNzZWUocykuIElm
IHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZCByZWNpcGllbnQsIGFueSBkaXNjbG9zdXJlLCBjb3B5
aW5nIG9yIGRpc3RyaWJ1dGlvbiBpcyBwcm9oaWJpdGVkIGFuZCBtYXkgYmUgdW5sYXdmdWwuIFBs
ZWFzZSBub3RlIHRoYXQgdGhlIGluZm9ybWF0aW9uIGNvbnRhaW5lZCBpbiB0aGlzIGVtYWlsIC9h
dHRhY2htZW50KHMpIG1heSBiZSBzdWJqZWN0IHRvIFB1YmxpYyBkaXNjbG9zdXJlIHVuZGVyIHRo
ZSBGcmVlZG9tIG9mIEluZm9ybWF0aW9uIEFjdCAyMDAwLg0KDQoNCg0KDQoqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKiAqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioNCg0KVGhpcyBt
ZXNzYWdlIG1heSBjb250YWluIGNvbmZpZGVudGlhbCBpbmZvcm1hdGlvbi4gSWYgeW91IGFyZSBu
b3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCBwbGVhc2U6DQppKSBpbmZvcm0gdGhlIHNlbmRlciB0
aGF0IHlvdSBoYXZlIHJlY2VpdmVkIHRoZSBtZXNzYWdlIGluIGVycm9yIGJlZm9yZSBkZWxldGlu
ZyBpdDsgYW5kDQppaSkgZG8gbm90IGRpc2Nsb3NlLCBjb3B5IG9yIGRpc3RyaWJ1dGUgaW5mb3Jt
YXRpb24gaW4gdGhpcyBlLW1haWwgb3IgdGFrZSBhbnkgYWN0aW9uIGluIHJlbGF0aW9uIHRvIGl0
cyBjb250ZW50ICh0byBkbyBzbyBpcyBzdHJpY3RseSBwcm9oaWJpdGVkIGFuZCBtYXkgYmUgdW5s
YXdmdWwpLg0KVGhhbmsgeW91IGZvciB5b3VyIGNvLW9wZXJhdGlvbi4NCg0KTkhTbWFpbCBpcyB0
aGUgc2VjdXJlIGVtYWlsLCBjb2xsYWJvcmF0aW9uIGFuZCBkaXJlY3Rvcnkgc2VydmljZSBhdmFp
bGFibGUgZm9yIGFsbCBOSFMgc3RhZmYgaW4gRW5nbGFuZC4gTkhTbWFpbCBpcyBhcHByb3ZlZCBm
b3IgZXhjaGFuZ2luZyBwYXRpZW50IGRhdGEgYW5kIG90aGVyIHNlbnNpdGl2ZSBpbmZvcm1hdGlv
biB3aXRoIE5IU21haWwgYW5kIG90aGVyIGFjY3JlZGl0ZWQgZW1haWwgc2VydmljZXMuDQoNCkZv
ciBtb3JlIGluZm9ybWF0aW9uIGFuZCB0byBmaW5kIG91dCBob3cgeW91IGNhbiBzd2l0Y2ggdmlz
aXQgSm9pbmluZyBOSFNtYWlsIOKAkyBOSFNtYWlsIFN1cHBvcnQ8aHR0cHM6Ly9zdXBwb3J0Lm5o
cy5uZXQvYXJ0aWNsZS1jYXRlZ29yaWVzL2pvaW5pbmctbmhzbWFpbC8+DQoNCg==
