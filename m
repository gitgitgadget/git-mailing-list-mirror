Received: from mx0a-001b6a02.pphosted.com (mx0a-001b6a02.pphosted.com [205.220.164.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDF125569
	for <git@vger.kernel.org>; Sat,  5 Apr 2025 11:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.164.217
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743853455; cv=fail; b=s8PwjIcVcRILrmmEYuoxL/TI1h+8OIY8/TZ0BqoYtaxViAPHKImL9ZWiksIAU1j/7mMUh9C/JONR5zKUYLFkGrqOMNQju9HRAy5hdbkv2FpBAvXqou+9dq40sW9EaWnTF5SnRSLt8kULSUBazd3994sA8h6c1yvdmyHj8SWbA2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743853455; c=relaxed/simple;
	bh=dAHqfUuHJygNfEF3T9z/1RStyErStrsH2xGceo07MNk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=d3RtqxqiwaPHGutapSm+WN5/1fbyU+qo1W6MaLdDyy97jWKrpttOhZqYZXRza6fM+5odHVNVgcqeQTensSzVqIOGxrt6qSzSSWqdQC6WtB4Oh0jpMS0wGvoiFf5NDrU/FjHn0dM0c6rC4tYAEwb629BzsIBtAPf6A+8hSaJaPR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadridge.com; spf=pass smtp.mailfrom=broadridge.com; dkim=pass (2048-bit key) header.d=broadridge.com header.i=@broadridge.com header.b=WmM/8Z1W; arc=fail smtp.client-ip=205.220.164.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=broadridge.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=broadridge.com header.i=@broadridge.com header.b="WmM/8Z1W"
Received: from pps.filterd (m0214201.ppops.net [127.0.0.1])
	by mx0b-001b6a02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 534HYUIV017812
	for <git@vger.kernel.org>; Fri, 4 Apr 2025 15:42:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadridge.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pps1; bh=acTiNxvD5z8FPMFkTEn5c5cKB7oDlV/5/4MsOVyFDQY=; b=WmM/8Z1
	W+3aHapf+d+f2AQO52L/bzfWqGkO+sckL1YQOw2Da61Wxe5ri4iQihos+vUZ9bwP
	D4V1js5IKdgkRhyEETciHimOCrngO7fnssrHsAYx98tGwpLyOZo3ejwkrGDG2JAc
	z3sFPKxegXt8SXpLIFbWdtfmSBhq7CguiTYKKZalh4lxar/mBtnyCBuUdG3ht/Ij
	/VHAd+BRGLXHp2XnJHpf9+dEnRpqXg1o11lAHDYSnd9p7F+rCanXoiJU30VR+Nt3
	ogpIU4Nb+oEwRjPYBsBI3CeIlmN6F8F4FyuNDK81bWOkNs9mYNnKKDTJ3q5mtopG
	u07tG31E6cbMJFw==
Received: from gwm.broadridge.com (central4-gwm.broadridge.com [167.212.42.154])
	by mx0b-001b6a02.pphosted.com (PPS) with ESMTPS id 45tkxrrbrk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <git@vger.kernel.org>; Fri, 04 Apr 2025 15:42:12 -0400 (EDT)
Received: from CLIPVWEXMAA1.bsg.ad.adp.com (10.17.79.181) by
 CLIPVWEXMAA3.bsg.ad.adp.com (10.17.79.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 4 Apr 2025 15:42:10 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.25.150.21) by
 CLIPVWEXMAA1.bsg.ad.adp.com (10.17.79.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 4 Apr 2025 15:42:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OGTfnpbN8BWePSJ0uxPUc2B+K+nekJ/ZpYCQ2XID3C8WHL+R9VUV0MzpCo/dj3CZmQfFUMFWK8auDxkj4h4e3T2teLv0XvTlhm6evXYOedd+LsGpr37hpUMbiV6SLMZB3B+ypo+/yFQlw+7YF2TUD5+99NlWrYo46GUV/4Ge4UH76xkBPm21qm1k+OPEOUxkQ3og/wpPoTTpmo27clVn11m4QEXuXB8eanfWq4lORYMknZmp5WXs3GHP5itK2VrYMMThPNd0T/bJyKcD5Z6/fO+NQoQtIm212eomxNfvujiA3Za90v3kKX5dTg59N3ISJfvR9nXs6Cg4JrECCi4wHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SUY2GNv3sbi3qRRHWcLYF1NgY17jAnIgeJnUlJlEzEs=;
 b=I+FC+a6K7UMQf/tLZ/TkehLZW6zGcdCYPjO/JKVCsdCBT4ASbOfajPoHZOcAxTSIVoJBGUBF4VXBNltgU9/W39Lw9F3Spco1Ky560bOp50uzkFBRE5X/5bHmj+lpUvqL6mdX24vbLmOVZKWo+lkxsNkj5Nfi76F+uzOrIdUHs2C+B9F+CwD7q8OMtrwCvsLVgvLrWWEmskuWIw7PYyuYXFcAxQ8qYDD0rQWBykH1HncZSx8ZRPePlcO6e8IfO1dgqHwKYVNtZUscrlCZWiJEP6rjA2T3EhoL8QdYWiXRpTkrn5rvm2bCzNEOrOwrG1xWTFALwz/dV3zsTwlxx8pCGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=broadridge.com; dmarc=pass action=none
 header.from=broadridge.com; dkim=pass header.d=broadridge.com; arc=none
Received: from PH0PR20MB6183.namprd20.prod.outlook.com (2603:10b6:510:290::14)
 by SJ5PPF423D5310B.namprd20.prod.outlook.com (2603:10b6:a0f:fc02::a8e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.39; Fri, 4 Apr
 2025 19:42:09 +0000
Received: from PH0PR20MB6183.namprd20.prod.outlook.com
 ([fe80::7c20:3b8a:c063:dba5]) by PH0PR20MB6183.namprd20.prod.outlook.com
 ([fe80::7c20:3b8a:c063:dba5%4]) with mapi id 15.20.8583.041; Fri, 4 Apr 2025
 19:42:09 +0000
From: "Torpey, Bill" <Bill.Torpey@broadridge.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: problem w/recursive, submodules?
Thread-Topic: problem w/recursive, submodules?
Thread-Index: AQHbpKcEtHRrZTLb3kyA8FppRK4eTLOTmxoAgABLEZs=
Date: Fri, 4 Apr 2025 19:42:08 +0000
Message-ID: <PH0PR20MB6183CD9646B42F0DD552166792A92@PH0PR20MB6183.namprd20.prod.outlook.com>
References: <PH0PR20MB6183E53678E814C2B473BE8B92AE2@PH0PR20MB6183.namprd20.prod.outlook.com>
 <9274ED7A-0267-43E3-9AE1-DC0BBEC81E69@gmail.com>
In-Reply-To: <9274ED7A-0267-43E3-9AE1-DC0BBEC81E69@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR20MB6183:EE_|SJ5PPF423D5310B:EE_
x-ms-office365-filtering-correlation-id: 705d1d86-65b4-4bab-c1e9-08dd73b0c98c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?MfwNY+NqV9a4Glp4mPgZTBTPJL10B4cnihWoJ4yzGjK8aW46zQy+4j5WyP?=
 =?iso-8859-1?Q?l1TgZmp0gm57L8eqdgCgqhIbLZ0J/pLpRezTFTX1C4RTrqXCoES+s1oj4c?=
 =?iso-8859-1?Q?SeXxQcchWm0rmqZdgk9TtbJkClJRsZKquYgyPs/w3JQ9YfK91Nmmho4Y7X?=
 =?iso-8859-1?Q?w/1nyqCif7pwMCLOscNbqvLPlF2tSuCOitZGJVuQ/v6/hRbpPnrNepgOiT?=
 =?iso-8859-1?Q?bIW+n8lcEqLvY0zIZubGVXXvn3pkvRfUyG56rQQAq5N66f5sZ2Ln8XEuoM?=
 =?iso-8859-1?Q?B5QBpKG3FURCiq2+xmi75iUWc/EqGbekobkmYCGrMnNbMiUO6qYaIkizhf?=
 =?iso-8859-1?Q?BgmcodWuAXKu0gswP8Zxyi6n2XERPqRPzZ2gzE9S4RzNucZOuCxD8FBaUO?=
 =?iso-8859-1?Q?Yp0I3XOa7/GQUEARId+A79Vhp8N5kVrl9HXE5MVIE+gzhEuBf0tdkxmDaz?=
 =?iso-8859-1?Q?0Qst9WEV9Yz5Q84BjV4pfU4PvLPeEAIirJuHbncW1FbPn6vNV6KRNb98f9?=
 =?iso-8859-1?Q?+f00eKjcmCDgZWWPiqt4zTF/GtiiOKoULnovtMmRpg4fLsztE0qorLS0Os?=
 =?iso-8859-1?Q?4+HDwTzwI8jLWCalsOvF6kwxP6zYIyUM0wzvB22o5XNu/AjZ6dj7NyUMOH?=
 =?iso-8859-1?Q?ZjFihatSeGAtV3+P1juD/3Jvt9He+TJv3U4qQ6IkbRCc4kChth5XzX0YXB?=
 =?iso-8859-1?Q?V5f40GtFEccVbrIHU2DcuiIXKEC6GioTjzAhQB3Y1OQHcs8NFEsOr5i9FN?=
 =?iso-8859-1?Q?AEanJd7mZxG8dSDucScIPWKdeb1HuMK/ctHfgwJRs2AVCbObmd1jEh5Wc3?=
 =?iso-8859-1?Q?AswYy4UFUU8DQP1iPKKhLHWCmUb5iXfSqgFtzVSK1Xm62AvySroaZR73f8?=
 =?iso-8859-1?Q?Aknd0LZ2ehenHntqge99CwcOlLze+fuQqt7VeQDMmvFaeP+1JKkDeNsbkE?=
 =?iso-8859-1?Q?d/db9GVgOXCH26fnvwS+a+qBH33ZcIHRsDcdT23TdMEuGtYTAIg513D3RH?=
 =?iso-8859-1?Q?oyFvEkl3Z8MdUmcoa5ztW2PPtLyRIZJdWe1wZR4SG+PpP0sgW3GtpH6NIh?=
 =?iso-8859-1?Q?CiQSmifmEPRlWnmI86iEQp2EW93DmpDEnwOALzbpprL+u2oq12KIAHj674?=
 =?iso-8859-1?Q?gMBrYh3mDGV2LvRAsvk7tfK4N95UdJQFy/C15zOb+Y5V8lxEJ2KrGdfWyf?=
 =?iso-8859-1?Q?Y4yvtVUIE8ieto7OzSQI9dqUdBQwO2VzvWVyWEO2LPpfDmfDl9rc6Vi3D+?=
 =?iso-8859-1?Q?u6QyBPDCRGuGXFfxjH6dygsUCxPGoC7eqjwCmGutD4TTKHQT7utKvqzPvG?=
 =?iso-8859-1?Q?N3kHnSnl4iqdBT/NNnlrm51U2S4+w1tNlOiBpVNqQcxXYho+It3RGNxWRP?=
 =?iso-8859-1?Q?kZmGgMFaoX/JWEMZG/qaeLdcshPogS81KeGmLNyz2/a/ZNcj4NJz6T/GlZ?=
 =?iso-8859-1?Q?W6AVgKTzmEf02fxquoTiPl1rRMDp7PW1Dbkt6WNKTDdswEOwbfxYjgHkqV?=
 =?iso-8859-1?Q?wLSqc5eMJKP/Wu9VOwR25O?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR20MB6183.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/TIFT/itJCR0wvpTcC43Xkzb1VpUy0pPkZJ3XWccZk6aIJn+xa4zlG+idc?=
 =?iso-8859-1?Q?NCXduZrB8I2PzlK0tAiykw+QpmABZaA86xZIOpwml1STKIT2+8JP+e5V1g?=
 =?iso-8859-1?Q?HiqmbBba+g+yvlGD6taFfPcfWCKT3ONk9xNnVEBmnPiTfONwn4jJP6YXO7?=
 =?iso-8859-1?Q?TKDcWG2rz7GXJzROFzSWSbYFzuHIf992SilFG0IFzPqoIhTePhkGHOzLKa?=
 =?iso-8859-1?Q?ekfKOcN7NNgXxosaV0B6yJ8SudQl8ciiFlwkBRdAxdTtLnPZQv+WSNYCcv?=
 =?iso-8859-1?Q?P1xc46JoGxU8BxYHVSrvgS4+HE/hj93Uxgi8j72GZArOebPUFYV/nNG07u?=
 =?iso-8859-1?Q?r5+w+fKA8+Nu7dg63WiXqIfcb+FED8cPnU7YqV5u3kw6cKEOevmF41G4Sq?=
 =?iso-8859-1?Q?p3F+eaBPOuKAJlBvTJWx0zJD0UDg90Mi3cBwUY0E2OWYDO8fktouzNWKVW?=
 =?iso-8859-1?Q?lcFWIvhrePq27nIFsevbnrxpe2I6Mfhyw6pT1ynWkyyfGcOouXtjLyE81a?=
 =?iso-8859-1?Q?yyRl0UxDX5kehxN3YcAzEE1jx+gkPaAmsUyxgptyFbKtbTJ6BAhh3BJDbT?=
 =?iso-8859-1?Q?ZJaL/LAITUMgInB6GxJHAB1fihbf+ID/+H69ug9pt58sUuh7S6JOZBN6Pd?=
 =?iso-8859-1?Q?y36VXjju+XlJT3vBOgpFUsQCbt9TTtRq47/H9gUToODtvg0cEuqFHc6vIH?=
 =?iso-8859-1?Q?FrB17RF8nz6zq7/LzXWAGdUxOlkvX0Ngj5lkZJ4H5v5gY72yTIKTUWtks/?=
 =?iso-8859-1?Q?znRHKkgJDBYrajfqG4ATC1XQbclyeuFHKmg51MhxtoaVdVHihSDTJ82Y+u?=
 =?iso-8859-1?Q?bKftqQg9HVVh7kUqNdghffXyEe3VqRLLtmE0nmJqqsv9z2gEZ38RaqNGIZ?=
 =?iso-8859-1?Q?fkXSuRvWBUgDLlxBntryCn9jRDhPdOXJu3r7mo/t8zQTZ1y9QF2SQ7KlhQ?=
 =?iso-8859-1?Q?0B8b7/B1PtZMyz0kVbb4aaP/loa9pdAn78KoF+VJrJLcZbWiimISBwQUj3?=
 =?iso-8859-1?Q?bHyQ+mt5iLJZWMO5UjvfOB9eRENPSKibwyHSWQHB11PGujDh66iCUnXb7J?=
 =?iso-8859-1?Q?9yYNBexbhdFGOVe86fAOM3M6SzNbUhG7Bos5E3oNXol5nDOvgjpEhb0oYX?=
 =?iso-8859-1?Q?31pn/EMPEA4lLtGMuyDPbvYe//CwQDlCGHMx9jVZJxF80/baDHlF+KlMWm?=
 =?iso-8859-1?Q?dP1tfabw2ZTHdpSAZjFauC5yfGTvrU9sKBirrb0g6Hxu/W5buSEwYnOQ/Y?=
 =?iso-8859-1?Q?SUloBogbmZSCJgtMcAYnQmJlSVLsS4+6Lvh3u0p2vlOnEElBDOHpBFYbLs?=
 =?iso-8859-1?Q?A/FlFF6/o5amyghH/ml+xnPDGkfYo/gMGyHiL9vbinpFDr7otGHxVgDZuM?=
 =?iso-8859-1?Q?Ec8hzwZ2b6n48FJgu4lBjOLINUd0TDDD1qEPl33nWzuedGytOeNn1xjSoM?=
 =?iso-8859-1?Q?Y9Igo2+rs3U4uEjho5Irxgx4R35ithjfcfdFLC+9Biq+YmHOMqyouzifYU?=
 =?iso-8859-1?Q?iBmuy1uOw/aA0Lm3Fd12oQzQ16VttxmbxF64GWXTVlzhIIgLgenaDf4D42?=
 =?iso-8859-1?Q?czeo6mQtphHuptEauNdjHZqan9V6Ee8UsdpyGHHXGWomm52Gqkjn6myC//?=
 =?iso-8859-1?Q?AuZMtvjkofGOvoiFd012qMvZmZDAQojyT2?=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR20MB6183.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 705d1d86-65b4-4bab-c1e9-08dd73b0c98c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2025 19:42:08.8904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a3198c8c-0642-4649-849d-daacc3298f83
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i/7sd7RBUlO1ZLjQ0RkIw8mGN4sPDKGdlNsVh25MtxBqFFLMBYnToQ5edtTg3wdJGHwopOax+6c9k9j966etojbGw30YTv+KGKqYg5ewMXc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF423D5310B
X-OriginatorOrg: broadridge.com
X-SYMANTEC-INSPECTED: YES
X-Proofpoint-GUID: eiBwpQ_Z4pqfBhL7FvYR6hKdoDf8pjhU
X-Proofpoint-ORIG-GUID: eiBwpQ_Z4pqfBhL7FvYR6hKdoDf8pjhU
X-Authority-Analysis: v=2.4 cv=U+SSDfru c=1 sm=1 tr=0 ts=67f03614 b=1 cx=c_pps a=YnOVPckIGGBkTk0ctD2pUw==:117 a=YnOVPckIGGBkTk0ctD2pUw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=XR8D0OoHHMoA:10 a=NEAV23lmAAAA:8 a=pGLkceISAAAA:8 a=UAifTlDqAAAA:8 a=VwQbUJbxAAAA:8 a=rKiB2GsMK9whjEvzUT0A:9 a=wPNLvfGTeEIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-04_08,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 malwarescore=0 phishscore=0 mlxlogscore=847 mlxscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0 impostorscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504040135
Content-Type: text/plain; charset="iso-8859-1"

- I'm afraid that we're unable to expose the internal repo because of co. p=
olicies.  Other than wrapper scripts for our internal dev. environment, the=
 only thing of note in the internal repo is the .gitmodules file, which con=
sists of the following:

[submodule "staging"]
	path =3D src
	branch =3D staging
	url =3D https://github.com/nyfix/OpenMAMA-omnm.git


- We've found that the problem is avoided if we execute the following comma=
nd *after* doing the recursive clone.  Not sure why this is necessary -- sh=
ouldn't the recursive clone handle that on its own?

git submodule update --remote --recursive


- It sounds like you're suggesting that we need to go into the submodule an=
d manually checkout a specific commit?  Shouldn't the recursive clone pick =
up the HEAD of the submodule branch?


If it sounds like we don't quite understand what git is doing here, that's =
a fair statement ;-)  In particular, only the submodule branch is exposed t=
o us, but it sounds like git internally stores the commit hash instead?

Thanks again for your help!
________________________________________
From:=A0Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Sent:=A0Friday, April 4, 2025 10:59 AM
To:=A0Torpey, Bill <Bill.Torpey@broadridge.com>
Cc:=A0git@vger.kernel.org <git@vger.kernel.org>
Subject:=A0Re: problem w/recursive, submodules?
=A0
This Message Is From an Unknown Sender
You have not previously corresponded with this sender.
=A0
> $ git clone -v -b master --recursive ssh://git@<internal>/nyfix/OpenMAMA-=
omnm.git

It's harder to understand the problem without being able to
reproduce it. Do you have another example with public
repositories?

> The commit hash from the recursive clone is the hash of a different (more=
 recent) commit:

If I understood it correctly, it looks to me that it's
another case of one of the most common misconceptions about
submodules: they always reference a specific commit instead of
branch or the latest commit.

If you want your repository to reference other commit of your
submodule, you'll need to manually change this and commit this
change. One way you can do that:

cd <submodule>
git checkout <new commit of the submodule>
cd -
git add <submodule>
git commit

Note that you'll need to do that every time you want you want
your repository to reference other commit of the submodule.

This message and any attachments are intended only for the use of the addre=
ssee and may contain information that is privileged and confidential. If th=
e reader of the message is not the intended recipient or an authorized repr=
esentative of the intended recipient, you are hereby notified that any diss=
emination of this communication is strictly prohibited. If you have receive=
d this communication in error, please notify us immediately by e-mail and d=
elete the message and any attachments from your system.
