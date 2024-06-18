Received: from smtp2.e.amses.net (smtp2.e.amses.net [213.161.89.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3F71CD29
	for <git@vger.kernel.org>; Tue, 18 Jun 2024 15:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=213.161.89.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718725311; cv=fail; b=t1LJk+BhBvLFjtZyNn/cGQJsxJ1pc8a+PvmElEwLDlKKrmHmmQpGLWvYRGEl82JC+zg4PSBi1hUuqYFR4KVl2kfe9P80NT7eW1VO9bMXfzRWz7a6ynUgL1d6PuWHGMAMOCvmYc+otRLDpsUQl7APof9rVTcFJxnHavsKRYV05cw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718725311; c=relaxed/simple;
	bh=ge3Bj5e08MCT3xJfz1A4PsT9MnLMwwojXwwGkF2i8lU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V4ck67NU5whL/ih+QaFdnMFfm1vowVo/m5fBHfGszScg28pcOseuPRSNkRyZ4KbkYPM0AeBxKd1wo0db1Oi31xOcoKij3rsDuY11OSASlJYFyn28qtHBknUmZjK6So9tFbwO/DKNYF8DX/nkSpqwvl/EV1s0Mk050vTFiqJksK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nhs.net; spf=pass smtp.mailfrom=nhs.net; dkim=pass (2048-bit key) header.d=nhs.net header.i=@nhs.net header.b=uqd32eFG; dkim=pass (2048-bit key) header.d=nhs.net header.i=@nhs.net header.b=pya847Xs; arc=fail smtp.client-ip=213.161.89.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nhs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nhs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nhs.net header.i=@nhs.net header.b="uqd32eFG";
	dkim=pass (2048-bit key) header.d=nhs.net header.i=@nhs.net header.b="pya847Xs"
Received: from smtp2.e.amses.net (op-hepims12.ops.amses.net [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3695A1AA544;
	Tue, 18 Jun 2024 16:41:46 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=nhs.net; s=secureHL;
	t=1718725306; bh=ge3Bj5e08MCT3xJfz1A4PsT9MnLMwwojXwwGkF2i8lU=;
	h=From:To:Date;
	b=uqd32eFG8ZE8Cxxfwi8oeDp85lgHPeyga2XRP4xedeBDLad62Qr0YsZXR8f7yG+ik
	 A6YvzRdBsIr/7yv/OTlCLIbWmFwZ+vlMqlDeItOQ4J9oENXXrSWuoPyBi/Zia7Sd8J
	 dJXcRUy7GWpZvovmCRNjMX30cKZ3j8ehWAObP4ejoFVFo8XogCd3bFUB/s52la1614
	 EuCEM3OvTbsI9fk2+FYpBjMWCT9bXmMx+Va8h4e8itezij4i6koOfdFXoDBMz0pQKN
	 Uuz0D+F8kW0Ke/tf7gD2YRWnlPT+HuVjSakIvt5SKihOa6NcnUbqig98B3SBZDmqs2
	 U3vB0X7Hb+DEg==
Received: from smtp2.e.amses.net (op-hepims12.ops.amses.net [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0CFA7AB4BE;
	Tue, 18 Jun 2024 16:41:46 +0100 (BST)
X-IMSS-DMARC-Authentication-Results: spf=fail (sender IP address:104.47.85.104) smtp.mailfrom=nhs.net; dkim=pass() header.d=nhs.net; dmarc=pass policy=reject action=none header.from=nhs.net
Received: from GBR01-LO4-obe.outbound.protection.outlook.com (mail-lo4gbr01lp2104.outbound.protection.outlook.com [104.47.85.104])
	by smtp2.e.amses.net (Postfix) with ESMTPS;
	Tue, 18 Jun 2024 16:41:46 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=US4t3raI2LsdWcDNHRzynFaES+ALj6xiIkU974phMzgnpNojjcEjUEzWb9lSIP+Br5hIDbXTszhh8mSWnbO8Qup1F9idPzplDa3/gs/ZGvzUBxa3e3jwoBJAhyfafR9UztsrYn7KVZlvhlVNAFAHQBTOmuK8yLOyoQWPKlTeo3SGPsrEAvNu6qcMs6kSW/8yo7up+aZecfQrulJew+J7xe0oeFBLjaeiF3yVqvzXxzzlvLi4u8I75U6nugZMpH5q3ov2rdkvzbAsCaaWy6FVLq63hOpW4MhOaqrSgm4q5iV1hDsKaisBDa74J4vMCT0dIztL1/SU819cWQn/B1MlpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ge3Bj5e08MCT3xJfz1A4PsT9MnLMwwojXwwGkF2i8lU=;
 b=YcCKHJyXvWQlf6ldWpsHfUsqagg4WAZqNRKChnLNeKcAkRexM1LuG0sie9n6KXG3kaxCc6RyrO69gOIkG+bPC6khBFGIo5CpWrz5jAl+UGlyCC/4DSw/Krg1BLecZZOU53C2/yJPZJb7m6BN4F9G1nNfmx14b9Bl4rtw16mB9a3cTNDxDVU3B41mu1EgHIOqIC8SGG2ORp/iCVNFsrmrj/t9NNrREYTqWivYtiS6FuCVV0ORD/E2VQIvTtr0H8t/ea6cKqeuvgFgayJE9atimDbXTEiHYPOglVUdHdy+8GZ5+2ErChVb9nQTa7U/92/io2jmhm0YGetjNN4cNkko9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nhs.net; dmarc=pass action=none header.from=nhs.net; dkim=pass
 header.d=nhs.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nhs.net; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ge3Bj5e08MCT3xJfz1A4PsT9MnLMwwojXwwGkF2i8lU=;
 b=pya847XssumEHmHwIWxhisAdapq0Xguh+RVGW/ZsxlkVYMF3IAqrllI2svbrRefNccMf0xZmKW+xR1EONvnD6ZCBXcTVJXSRq8oYJ4GXw/mnUHYkL8+PYSXtIDL8iwQ7bIRf1+AHyF33b8ds+lZxGYAhgcjVgUasV1dfX/I0h+5TyYLpeOgLvD8xR/oqZ7O2iu29KA4n8Dr2bd2KD0QGbPnweM4GkqppWdz/VFe57hSUrJNOxbJAv8tC9aUvS/EefGT1/oJ7BopVUfuMeilAlfvTrCHX0VXSjSCxc8mB3A+1/CjKfQnI4EcgSqH5jlCGx0GBU5Ctc9XmdkgZEZLDMw==
Received: from CWXP265MB3013.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:c9::7) by
 LO2P265MB5231.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:256::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.30; Tue, 18 Jun 2024 15:41:40 +0000
Received: from CWXP265MB3013.GBRP265.PROD.OUTLOOK.COM
 ([fe80::fe46:bee0:8a7e:73d3]) by CWXP265MB3013.GBRP265.PROD.OUTLOOK.COM
 ([fe80::fe46:bee0:8a7e:73d3%4]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 15:41:40 +0000
From: "ELFORD, Richard (NHS SOUTH, CENTRAL AND WEST COMMISSIONING SUPPORT
 UNIT)" <richard.elford@nhs.net>
To: Konstantin Khomoutov <kostix@bswap.ru>
CC: "git@vger.kernel.org" <git@vger.kernel.org>, Konstantin Ryabitsev
	<konstantin@linuxfoundation.org>
Subject: RE: Multi Factor Authentication for GIT software
Thread-Topic: Multi Factor Authentication for GIT software
Thread-Index: AdrBebL9yHElB3LbRFGDm3JU1U9sTAAC3eWAAAKrEoAAAVT8MA==
Date: Tue, 18 Jun 2024 15:41:40 +0000
Message-ID:
 <CWXP265MB30133DAED31B87A03D0AD53481CE2@CWXP265MB3013.GBRP265.PROD.OUTLOOK.COM>
References:
 <CWXP265MB3013B13F4BC4D7574E6E86E281CE2@CWXP265MB3013.GBRP265.PROD.OUTLOOK.COM>
 <20240618-grinning-kagu-of-examination-bb4e1f@meerkat>
 <20240618145729.47d34yxe7gw36jyn@carbon>
In-Reply-To: <20240618145729.47d34yxe7gw36jyn@carbon>
Accept-Language: en-GB, en-AU, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nhs.net;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CWXP265MB3013:EE_|LO2P265MB5231:EE_
x-ms-office365-filtering-correlation-id: 042eac91-9bff-43b6-573e-08dc8fad25dd
x-egress-defend-domain: nhs.net
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info:
 =?utf-8?B?WU5JTC9hSUdoa1A0aXhSSUNQeXlORzR1V0JSV3hQdmgrbm5zdmU5WW15M3pp?=
 =?utf-8?B?MXkrRnV0R2tiNWtWNUdhMHVaQ25lR05SZzZ2UzVqMzZZTmRIdDVSRXo3SXdF?=
 =?utf-8?B?NDNua2ZSVDNsWkVGbzdkc1Qxd09iWXFsTnIrMFN3MnU3V2lSaHBLT1ZHT1Jr?=
 =?utf-8?B?cTdxbi9xUWtVbEZXT1pYL1BiL0lXbnJnL2tsRWJrSGlML0tZVWxFdHV4a3dv?=
 =?utf-8?B?aC9ybisvMHZNYzZZblIyWmg0d2FwcXI5MWRzSThOdVl1UlFFNUVaYWFJQWYr?=
 =?utf-8?B?aXo3RHl5b1UrUnE1bVdEam11K0M0V3pQL3BzOUFqS05zaWNoelA5NXErUkVp?=
 =?utf-8?B?TTE5RW04N0RsVVBBM3M4NFRaN2JlMjBUVXo5dkdnaStFT1RHZ2UzcTNMcStx?=
 =?utf-8?B?ckErc1lTWkRKYitnSllzMW10ZXc2ci9ZVit6dlZMMG1NOGpObTFiZ0VaUXZs?=
 =?utf-8?B?d0Y5dEhnTGEwR2RtZVBhc0JRZUg0RVhvZTU5clhDRmZJckFJV0pLRUdEWmxl?=
 =?utf-8?B?SFl0ZExTWTRkZDNNcDhXb2VMM1B0NEZTK1U2a3NFMzlRNWlVRzBTNzJUeFEw?=
 =?utf-8?B?clNQQWh4UTZsMkVtWmY1NXEwTys4WGErb2ljOXNCd3pRb2VTUnUvVmRmOGQ1?=
 =?utf-8?B?NXRYZVdiVnlmbm16VEpGYXJSeWhhbkM0aENVYmpFM0JaNHVEZzB3bFZyTnox?=
 =?utf-8?B?NCtwYlhQb3I5TjdmOENNT0cyQzF5K1JIN2VaOFJsRDJUNFRmN1JaYkYzNTNX?=
 =?utf-8?B?VzJzT0o0SU80MXl4bkdkNlJsMjJDYVdWYnc2NkxnaFg3aE80c3lrbkZiMnRV?=
 =?utf-8?B?NWphOXpxVEFaYzN5NktMY1BmT1dNSWxRaGUzaSs1WFkzQlZBOHArbm5rV1ZL?=
 =?utf-8?B?K2E0K3ZRS0kvdkRHZi9SZTBHVUwrNDNHUEQ2cHptWEpRL252Z2hKWjZDYWlh?=
 =?utf-8?B?elRmV3NSYzZEVjFEMFoyU0xwRlZuTFgwUU1pQldsZENIbWpDREgveDBWMXd6?=
 =?utf-8?B?anlqdU5LZTZvTU10WkZCRVM4Qkx5NzZpa3htaW9qR1ovL3JpWFgrSWdrNXll?=
 =?utf-8?B?L2cxMk5OK3FXNkhPN0l4eVUvUVVLaHpuZlh3d25VTzZMRGpESHNMYUVhSHNz?=
 =?utf-8?B?SVVEbzFXNXZ3S0d2MTJLMW9CcW9hZVY4c2VIRUFKOGJ0Tm9ET1ZzWXEwUkhU?=
 =?utf-8?B?WEtTUEFORTRwVFpkcGtSQkM5QUtRbEpvOGpBYTVXZWt4SnhhdUpEeUM3N1Bs?=
 =?utf-8?B?Q1RBVExiTlh0dDg4NlZpSWttRzR3aGdTNzFxZjVsYkJBbExSR294cGFXYXdm?=
 =?utf-8?B?bStsMDZ4a2ptTmp4dVFvVHI1bGNSeUZNZTNMV2hZbUtoNHIwYURVdExsTkFH?=
 =?utf-8?B?SkxIZE1ZNDN6ZUJlb3p2NXNpTjRLT3ZoMDdrTWNYUjIyNUJmUzN1QkRlM3Yv?=
 =?utf-8?B?UkgwUXNVbmNnTWVaR2NSd1B6bVc5c21FdXpSeFQ2U1RBbFNsdWJoOGVhVjZV?=
 =?utf-8?B?dDBTcFpCNmtqeS96WElBaTRkNXQvL2czSmtURWw4T25JWWlDQnlJZmNIekwx?=
 =?utf-8?B?TGtpSFRPUDBMbDVSa2VGdDhnVDFJenhZYzdtTVdVTkNRVWRzcFY5QVFwR1Y2?=
 =?utf-8?B?RThvaE9ydW5aVFN3Qm5Ycm1SYWkzLzBUVzQ5dGkrYTgvYzR2cklSTGF2Nldr?=
 =?utf-8?B?djBRWlRIVjZQVXF0MmFxbEFmVTEwcFVnMWhwTW5NdXJnSnVXZCtPR0kvbllo?=
 =?utf-8?B?NEk5MEdTL0p6TXJzeUxIR2F3ZGFSblp2QkJzVUY2dVpuUkpPOVlpbmpwdExV?=
 =?utf-8?Q?RfLGTsqdxuAQ5zbQzI9tnCUKbadHl/b80/Wm4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP265MB3013.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QU9HK2NhRnJDMDh0UHpyWEJ3RDdQTllGOFMzWml5NzI0QVg2clA0MHlDTG9w?=
 =?utf-8?B?QjV1VW5HSFJ0ZEpwVzVYaW9pMlpYT3FYOHNReVZLaG1Waldla1UwcDFXcUtV?=
 =?utf-8?B?Y3lnVDA2dG55dThsN1llTnlPSjdSYnNuSU1XQlYwTWNkMFZRcUxpc29rUFBL?=
 =?utf-8?B?eERQcy9nUnZTMTNYNFJ5QThDTGFKeWw5UnNWbmRkUzI4cUREMTBFbFdUVzFK?=
 =?utf-8?B?ZmNnTExpUVRFQncwdytvTVdUQkc1cE5vN3lZZ2lOeW11TGJWV2p2WkxFM3JV?=
 =?utf-8?B?WjFwclAyank2blJRVWJXaytHTjlCc29VMjlXbVFra0g0c05sOGViM29maTdx?=
 =?utf-8?B?MEpKR1I3eE9xalpKbDJ5VStiTDhsZDg1RFRoVmxPcHMwZytwVXF0bVZQampq?=
 =?utf-8?B?ZkZsY1l6RWVEWUtsaXJYalV5cE9PbDc1NEt0SFdRc1ZDS3VCZVI4TnprUm9T?=
 =?utf-8?B?ZHkzbU9FejlPbkVONWMwSzN3STdGTUFKTFdjSTVjQlF1dVZsR2I5dlloUzFM?=
 =?utf-8?B?c3IrcEtRNm9jZGFWWVZmRXBKVG8yek1sb3MwNUt6SGpoZHVYWjh0RCs2MEVo?=
 =?utf-8?B?Zjdpcm40aW1ZU0tHM2xKaC9ucHA4SmErTE9ONlNtaUVWME9HTkFrMEdaL0Ft?=
 =?utf-8?B?ZDlBcStQNUhNcmZoTkdQY3UzQ0wyT1diYzN1Z3dxT281eldmTFJMTEJ1RnpL?=
 =?utf-8?B?eDZIVEh1dWVwUWN2aEVGWElwbUJjZGt6amkvMldNRlRNQ1ZhWDdQOTNyMjY2?=
 =?utf-8?B?eDVQVERJMi9kT3FNWCtjQXNieUxMKzJ2dllKSHBCajJ6QVc3WFRxNWhIRC80?=
 =?utf-8?B?UXBqQWtqNFlOTDBGVmFTbzZaZlg0UlhSUkdZdmQ2UEIvdTRtbXdocTlwd1R2?=
 =?utf-8?B?UU5LQzg4ZnRUOXRBL3d2UmZOUXFkU2ZoYTdEVmZ6aFp3Q2UwUUQ2eFZwemlT?=
 =?utf-8?B?U1NReFBkWFgyM3IwUUIxNjU2UitkbzRxV1hYQ1RNVG5Sb2FGWW9jUnFEbDRT?=
 =?utf-8?B?NlBQcWdPUSt1S0p5MGtFdzdwb2wwYjlaQUY4Y0JhRHRTZ3FTQmQ5RUhWUEgy?=
 =?utf-8?B?TTBpT2tSaVNDRWtabk9oc1VZNXBzMC93TDROQmlNUlRyWVdFeDcrb0Z2L1dD?=
 =?utf-8?B?alMrdjF6RzZUbG43cWh5RmVueE4zN29tM0xETHFML1JIdElMYmJZTDRPa1JO?=
 =?utf-8?B?RjRsTUJpelZWMDVQd0tBeGtqNDVJTWkyTTR4ZmRuOWVNbUs3VnN4a0RBS0lF?=
 =?utf-8?B?R0ltNTB0QjF4NFJzZ1h2M2Rzc3RnR0pBWjBzby80akdQdXZ3dThEMjFJNURn?=
 =?utf-8?B?MVphZHFRM1Y3ekRmajVTRmptYktBc1Jyc3hEZDFwOUFDOGFIUlRhNVd0c1BZ?=
 =?utf-8?B?dnVqRVNod3VMd1Ixa3dQTUg4MkpVNlBSSlhuNW1sZy81Ymo1aUtUSnNMcC9F?=
 =?utf-8?B?VGpmVWZlaWdnNi9VZ3FlbEE0WjZJb2xQZ0p3SkxMTldrNG1FcTl4c2NpNE1u?=
 =?utf-8?B?ckJBdXFDcFBFUmhGT09taG5ucFZJaVZ4bUtDNzAvdnViU1J1dU91MXl1UXpL?=
 =?utf-8?B?YngzVi9qeC9Bc0REQU80NWVoTFNMWnRqNzU2M3dmVWJsRmJrMW4rUUJXcG9P?=
 =?utf-8?B?dmFkbmt4aEdRUXpHUitTUDBoNU5ubkwwUmZIWHNvUVVMQmtqVXdlRjloMHc3?=
 =?utf-8?B?eHBJMFB2b3lmTldmTEV0RlFuVXFnOVFRU3A2T2g3czdIN0NxYk5wUStQbTlY?=
 =?utf-8?B?SHRjaFgzRk5SUWlzYTNNa0lGUXF3bDdGa1FDNGc3SWtIRUZmcURaQnFKQm04?=
 =?utf-8?B?bmtMWm4zR3d0OTJQU1I3U3dpSVIvUlBLSWp4THp4VEh6b2tuT3NPNXBWS3FC?=
 =?utf-8?B?V2J2Z29GOHlmZm4xOUM3em84RGxlSFh2U0NYYnlpbVIzaGppeXNLcW9FTFBt?=
 =?utf-8?B?c29PMHJ0blBDN3BpQ090YXFxVHNEODFPT2dySHhwd1ZHcVhxZUJsSlhHUkpx?=
 =?utf-8?B?akx4WXcrT2wwem03MDBZeEtxWDFjc2JDQXNnNDNrUUZta3VRRVBiRDBHNGZk?=
 =?utf-8?B?MzJCbzBheklFQXhmMFhxK1NXUHF0SnpMd21uOFlpSjFzYkx3UlFJSGtKVE1R?=
 =?utf-8?Q?1Rctyb/8dMtTe7ZefNeEI64Ds?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 042eac91-9bff-43b6-573e-08dc8fad25dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 15:41:40.6725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 37c354b2-85b0-47f5-b222-07b48d774ee3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HCB2Qq6ZvJV6HsTCylEaI0/HkWctwVD+0mFI59DjWpxAQ+IbbQdvNeCKzKMn2btRxIIQRX6gALhvhlyXmXBU6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB5231
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSVA-9.1.0.2195-9.0.0.1002-28462.000
X-TM-AS-Result: No--25.499-5.0-31-10
X-imss-scan-details: 
	No--25.499-5.0-31-10;No--25.499-5.0-31-10;No--25.499-3.0-31-10
X-TMASE-Version: IMSVA-9.1.0.2195-9.0.1002-28462.000
X-TMASE-Result: 10--25.498900-10.000000
X-TMASE-MatchedRID: 9smUWruGJI5DZFBd1jLr/mGYAPMKo6+zpR+m8tBi6ZJuwe1DQn3m1MVy
	WDnNlFg8MsZW/qxDjpOvaHVEeXCQcajR7PzpetBAoU4XBOj9D8w2LwvzxRX0gKUdWCJez1mfXyC
	R2a++D/Z8TeoWnVPgpmQp5D2cB9O6Shs77ng+LAb6zT5BlgBw3wYAPqHoVmYR7zyq0taM3piYpm
	B4zAaUDjP0nv6v4BMn3I1MuolUFa0yTrSSUnUH2K5i3jK3KDOot3aeg7g/usDCPXSO232P7zqFl
	xhj7txCcEp+Z6/5wb/sOJtxJXQaPanpo2XyRBQQ1XqCcX1Kf0AxEreX72bHnh/THH4EgJNXUArJ
	nwHoG3RRg8k76qK8bO7Ycd2lqkT2BN8atkKwQ1HN+qWlu2ZxaI9cl6uvFQW6hCAQPO9JURI29dA
	efPG/Ie/p5jFdZYbKQx3J0Ej+Sj4DFgoHQs6fmsNfnKJsqga9yqyllX6UJIvuUsaVMCjJLbK6Gm
	KppGdqs1lTliPiUocnAvXt4vQOqKz/CEE284FikYD8wAZKsSDVbMYBwo6uowrkj7klVufu6JXPM
	rOkUywBuxjiu+3f9Xsf3f6vHmfPmfVZDlZPI4jOj/hxK35Y1Q2y5A4HtQVbQYaknL+rSlqjxYyR
	Ba/qJRVHsNBZf9aRsdCpaw4vRjnaQDSCfLwDrMRB0bsfrpPIqxB32o9eGcn/ita+mP1RyAP90fJ
	P9eHt
X-TMASE-SNAP-Result: 1.821001.0001-0-2-1:0,12:0,22:0,33:0,34:0-0

SGkgS29uc3RhbnRpbg0KDQpUaGF0IGlzIHZlcnkgaGVscGZ1bCAtIHRoYW5rIHlvdS4NCg0KSSB3
aWxsIHBpY2sgdGhpcyB1cCB3aXRoIG91ciBJVCBwZW9wbGUgYW5kIGZpbmQgb3V0IHdoYXQgdXNl
IGNhc2VzIHdlIGhhdmUsIGFuZCB0aGVuIGdldCBpbiB0b3VjaCB3aXRoIGFueSB0aGlyZCBwYXJ0
aWVzIGFzIHlvdSBzYXkuDQoNCkkgcmVhbGx5LCByZWFsbHkgYXBwcmVjaWF0ZSB5b3VyIGFkdmlj
ZS4NCg0KDQoNCkJlc3QgcmVnYXJkcw0KDQpSaWNoYXJkIEVsZm9yZA0KQnVzaW5lc3MgU2Vydmlj
ZXMgTWFuYWdlciB8IERpZ2l0YWwsIERhdGEgYW5kIFRlY2hub2xvZ3kNCk5IUyBTb3V0aCwgQ2Vu
dHJhbCBhbmQgV2VzdA0KVGhpcmQgRmxvb3IgLSAzNjAgQnJpc3RvbCDigJMgVGhyZWUgU2l4IFpl
cm8sIE1hcmxib3JvdWdoIFN0cmVldCwgQnJpc3RvbCwgQlMxIDNOWA0KDQpDYWxsIG1lIG9uIE1T
IFRlYW1zIFQ6IDA3Nzg1IDYwMTYwMiBFOiByaWNoYXJkLmVsZm9yZEBuaHMubmV0DQoNCg0KDQot
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogS29uc3RhbnRpbiBLaG9tb3V0b3YgPGtv
c3RpeEBic3dhcC5ydT4NClNlbnQ6IFR1ZXNkYXksIEp1bmUgMTgsIDIwMjQgMzo1NyBQTQ0KVG86
IEVMRk9SRCwgUmljaGFyZCAoTkhTIFNPVVRILCBDRU5UUkFMIEFORCBXRVNUIENPTU1JU1NJT05J
TkcgU1VQUE9SVCBVTklUKSA8cmljaGFyZC5lbGZvcmRAbmhzLm5ldD4NCkNjOiBnaXRAdmdlci5r
ZXJuZWwub3JnOyBLb25zdGFudGluIFJ5YWJpdHNldiA8a29uc3RhbnRpbkBsaW51eGZvdW5kYXRp
b24ub3JnPg0KU3ViamVjdDogUmU6IE11bHRpIEZhY3RvciBBdXRoZW50aWNhdGlvbiBmb3IgR0lU
IHNvZnR3YXJlDQoNCltZb3UgZG9uJ3Qgb2Z0ZW4gZ2V0IGVtYWlsIGZyb20ga29zdGl4QGJzd2Fw
LnJ1LiBMZWFybiB3aHkgdGhpcyBpcyBpbXBvcnRhbnQgYXQgaHR0cHM6Ly9ha2EubXMvTGVhcm5B
Ym91dFNlbmRlcklkZW50aWZpY2F0aW9uIF0NCg0KVGhpcyBtZXNzYWdlIG9yaWdpbmF0ZWQgZnJv
bSBvdXRzaWRlIG9mIE5IU21haWwuIFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBh
dHRhY2htZW50cyB1bmxlc3MgeW91IHJlY29nbmlzZSB0aGUgc2VuZGVyIGFuZCBrbm93IHRoZSBj
b250ZW50IGlzIHNhZmUuDQoNCk9uIFR1ZSwgSnVuIDE4LCAyMDI0IGF0IDA5OjQxOjA1QU0gLTA0
MDAsIEtvbnN0YW50aW4gUnlhYml0c2V2IHdyb3RlOg0KDQo+IE9uIFR1ZSwgSnVuIDE4LCAyMDI0
IGF0IDEyOjE5OjE5UE0gR01ULCBFTEZPUkQsIFJpY2hhcmQgKE5IUyBTT1VUSCwNCj4gQ0VOVFJB
TCBBTkQgV0VTVCBDT01NSVNTSU9OSU5HIFNVUFBPUlQgVU5JVCkgd3JvdGU6DQpbLi4uXQ0KPiA+
IEkgYW0gd3JpdGluZyB0byBlbnF1aXJlIGFib3V0IG11bHRpIGZhY3RvciBhdXRoZW50aWNhdGlv
biBvbiBjbG91ZA0KPiA+IGhvc3RlZCBzb2Z0d2FyZS4NCj4gPiBwcm90ZWN0IHNlbnNpdGl2ZSBk
YXRhLCB3ZSBhcmUgc2Vla2luZyBpbmZvcm1hdGlvbiByZWxhdGVkIHRvIHRoZQ0KPiA+IE5IUyBF
bmdsYW5kIE11bHRpLUZhY3RvciBBdXRoZW50aWNhdGlvbiAoTUZBKSBQb2xpY3kgd2l0aCByZWdh
cmRzIHRvDQo+ID4gc29mdHdhcmUgcHJvZHVjdHMgd2hpY2ggd2UgaGF2ZSBmcm9tIHlvdXIgY29t
cGFueS4NCj4NCj4gVGhlcmUgaXMgbm8gY29tcGFueSwgc28gdGhpcyBxdWVzdGlvbm5haXJlIGlz
IG5vdCByZWxldmFudC4gR2l0IGlzIGFuDQo+IG9wZW4tc291cmNlIHByb2plY3Qgd2l0aG91dCBh
bnkgb25lIHBhcnRpY3VsYXIgZW50aXR5ICJvd25pbmciIGl0Lg0KDQpSaWNoYXJkLCBJJ2QgbGlr
ZSB0byBtYWtlIGEgcmVtYXJrLiBNYXkgYmUgLSBqdXN0IG1heSBiZSAtIHlvdSdyZSBjb25mdXNp
bmcgR2l0IGFuZCBHaXRodWIgb3IgR2l0TGFiLiBHaXQgaXMgYSBmcmVlIGFuZCBvcGVuIHNvdXJj
ZSAoRi9PU1MpIHBpZWNlIG9mIHNvZnR3YXJlLCB3aGlsZSBHaXRodWIgYW5kIEdpdExhYiAoYW5k
IGEgcGxldGhvcmEgb2Ygb3RoZXJzKSBhcmUgR2l0IGhvc3Rpbmcgc29sdXRpb25zIHdoaWNoIGhv
c3QgR2l0IHJlcG9zaXRvcmllcyAiaW4gdGhlIGNsb3VkIi4gVGhleSB1c2UgR2l0IGJ1dCBoYXZl
IG5vIG90aGVyIHJlbGF0aW9uIHRvIGl0Lg0KDQpTbyB5b3UgbWlnaHQgd2FudCB0byBmaXJzdCBj
aGVjayB3aXRoIHlvdXIgSVQgcGVyc29ubmVsIHRvIG1ha2UgaXQgYWJzb2x1dGVseSBzdXJlIHdo
YXQgcmVhbGx5IGlzIHRoZSBpc3N1ZSB0byBkaXNjdXNzOiBHaXQtYmFzZWQgc29sdXRpb25zIG1h
aW50YWluZWQgYnkgTkhTIGl0c2VsZiBvciBHaXQtYmFzZWQgc29sdXRpb25zIHByb3ZpZGVkIGJ5
IDNyZCBwYXJ0aWVzLiBJbiB0aGUgbGF0dGVyIGNhc2UsIHRoZSBxdWVzdGlvbnMgbGlrZSB5b3Vy
cyBzaG91bGQgcHJvYmFibHkgYmUgZGlyZWN0ZWQgdG8gdGhlc2UgcGFydGllcy4NCg0KDQoNCioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqICoqKioqKioqKioqKioqKioqKioqKioqKioqKioq
Kg0KDQpUaGlzIG1lc3NhZ2UgbWF5IGNvbnRhaW4gY29uZmlkZW50aWFsIGluZm9ybWF0aW9uLiBJ
ZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50IHBsZWFzZToNCmkpIGluZm9ybSB0
aGUgc2VuZGVyIHRoYXQgeW91IGhhdmUgcmVjZWl2ZWQgdGhlIG1lc3NhZ2UgaW4gZXJyb3IgYmVm
b3JlIGRlbGV0aW5nIGl0OyBhbmQNCmlpKSBkbyBub3QgZGlzY2xvc2UsIGNvcHkgb3IgZGlzdHJp
YnV0ZSBpbmZvcm1hdGlvbiBpbiB0aGlzIGUtbWFpbCBvciB0YWtlIGFueSBhY3Rpb24gaW4gcmVs
YXRpb24gdG8gaXRzIGNvbnRlbnQgKHRvIGRvIHNvIGlzIHN0cmljdGx5IHByb2hpYml0ZWQgYW5k
IG1heSBiZSB1bmxhd2Z1bCkuDQpUaGFuayB5b3UgZm9yIHlvdXIgY28tb3BlcmF0aW9uLg0KDQpO
SFNtYWlsIGlzIHRoZSBzZWN1cmUgZW1haWwsIGNvbGxhYm9yYXRpb24gYW5kIGRpcmVjdG9yeSBz
ZXJ2aWNlIGF2YWlsYWJsZSBmb3IgYWxsIE5IUyBzdGFmZiBpbiBFbmdsYW5kLiBOSFNtYWlsIGlz
IGFwcHJvdmVkIGZvciBleGNoYW5naW5nIHBhdGllbnQgZGF0YSBhbmQgb3RoZXIgc2Vuc2l0aXZl
IGluZm9ybWF0aW9uIHdpdGggTkhTbWFpbCBhbmQgb3RoZXIgYWNjcmVkaXRlZCBlbWFpbCBzZXJ2
aWNlcy4NCg0KRm9yIG1vcmUgaW5mb3JtYXRpb24gYW5kIHRvIGZpbmQgb3V0IGhvdyB5b3UgY2Fu
IHN3aXRjaCB2aXNpdCBKb2luaW5nIE5IU21haWwg4oCTIE5IU21haWwgU3VwcG9ydDxodHRwczov
L3N1cHBvcnQubmhzLm5ldC9hcnRpY2xlLWNhdGVnb3JpZXMvam9pbmluZy1uaHNtYWlsLz4NCg0K
