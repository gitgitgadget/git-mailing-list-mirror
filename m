Received: from outbound-ip157a.ess.barracuda.com (outbound-ip157a.ess.barracuda.com [209.222.82.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF45131A548
	for <git@vger.kernel.org>; Fri, 29 Aug 2025 13:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.26
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756473909; cv=fail; b=C4NmXdlZ8RBFQOmlG9MmJ3zh/Dni/uDkDhDPwub3L0GKo3f/z/IMEx+J/XxYxrFOmzP6AgvNNJRu+LPauVCyP6ElWk4sQA+lEKFh9gGlbdIzQZ+fAPWxlbZwgwKHcjG7RHl9MUuvWC9if1UWaVIgCr9IzLivdgRj20OAMfi/LoU=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756473909; c=relaxed/simple;
	bh=5kRwNy09xcMITPOJmcG7m9EW+fWVJ3ZlImhd2ncvuD4=;
	h=Content-Type:From:To:Subject:Date:Message-ID:MIME-Version; b=DjpI9jMYK8ximi/+6xAcLXZsZReIMY4uRRbyrrIujGPAH0sc895wi1Vmjdl2fQLSWkzYs+X3vGDGdnbrNIQWFQ2H3fsBoqW3oGgRYxTafoThljVu0CcIwVLujEIfoz4xqzJA6V1ku60UIPOImqNxpJCFHky8vwC7b5krVyMjVu8=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=masimo.com; spf=pass smtp.mailfrom=soundunited.com; dkim=pass (1024-bit key) header.d=DMHGLOBAL.onmicrosoft.com header.i=@DMHGLOBAL.onmicrosoft.com header.b=p1Cc30oi; dkim=pass (1024-bit key) header.d=masimo.com header.i=@masimo.com header.b=bBvmC/QP; dkim=fail (1024-bit key) header.d=soundunited.com header.i=@soundunited.com header.b=Bmaaeg8L reason="signature verification failed"; arc=fail smtp.client-ip=209.222.82.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=masimo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soundunited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=DMHGLOBAL.onmicrosoft.com header.i=@DMHGLOBAL.onmicrosoft.com header.b="p1Cc30oi";
	dkim=pass (1024-bit key) header.d=masimo.com header.i=@masimo.com header.b="bBvmC/QP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=soundunited.com header.i=@soundunited.com header.b="Bmaaeg8L"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2095.outbound.protection.outlook.com [40.107.223.95]) by mx-outbound42-20.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 29 Aug 2025 13:25:04 +0000
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=fail;
 b=PIT69HbWb9/5yWz1tci7e+I32cvpZLlA+BlZ4cSoMcnbRmFr2CYGpcYZIBxLWXADncEl3jWqLTA9AVTndxolSnvlkpS7XrmSkf9DooHcHfIeGayA/a8+5nuSo1YDZ8iRB9Y4jEULFqA5UVFnn4hQFhUvrcHjM6FmUj/8B2HsrYfPDX4+j9JWy8tGdbGE0IJXmcxsDEqlgAubjoKjujeu12srfXPy14xh+BGBSt7FWdl/iYiFVj26ZgL8k7V16oPU3Q1fARZJZWlrskTBMe/LywxmhQKzQURE8Twla5JSm2HjsNCaWuA7VvDo/45QCWlp7Fqd4hdrObFdOFUOXafx1w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TEtI3D5/HuJaNm82AAtG5Zd0/wL5V1PVUkC1WGOaPc8=;
 b=NP2Yd+70kpNaGnCuW73LQ4bv6wWW3pRgNrhiZbqj4zGfSzP307uUAu9LuCnxGE+578eP3377Ge23ZAKmvc1gH1Ozk8LY4yZKVq+Q3HbXO7zJTgf+ufpQqp9QBEnTEgOl4PFikGJbk2RTetnDaE0bQR2FkAB1uIEwRUxzz3h65QdbtOasz0IHRj8KR102hw50DcCgdbR9hb/w5+c1GvV9ghjgfJDRKsx3+CERmC8tw3FatVjt5JLIYnPogDyE1XRqD8C3olmduJEUQ72E04Hrne1w3Be7pWfitk4AIgIO1FvYkY5G706AZnd5dHIf9hFBp0FTzftJ2r7rSNcVzZJ5Og==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 13.66.130.121) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=soundunited.com; dmarc=pass (p=none sp=none pct=100)
 action=none header.from=masimo.com; dkim=pass (signature was verified)
 header.d=masimo.com; dkim=fail (signature did not verify)
 header.d=soundunited.com; arc=fail (48)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=DMHGLOBAL.onmicrosoft.com; s=selector2-DMHGLOBAL-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TEtI3D5/HuJaNm82AAtG5Zd0/wL5V1PVUkC1WGOaPc8=;
 b=p1Cc30oiLOJDvVsayVpL0CnzKKr56sWvsW+SbKhQxWr+kQm25iwG9H4JeLY6ism9bfG7gnz8T6j+ALh8/U87H3TaVBina2P5VrFZvb64XTKunzytcuylQLvD10+SHX50pS8s4yIeq0UatTxisDScZTG7T6i/YEQGwmtMH3dQTyI=
Received: from BL1PR13CA0316.namprd13.prod.outlook.com (2603:10b6:208:2c1::21)
 by CH0P221MB0534.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:10b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Fri, 29 Aug
 2025 13:24:57 +0000
Received: from BL6PEPF0001AB51.namprd04.prod.outlook.com
 (2603:10b6:208:2c1:cafe::33) by BL1PR13CA0316.outlook.office365.com
 (2603:10b6:208:2c1::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.14 via Frontend Transport; Fri,
 29 Aug 2025 13:24:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.66.130.121)
 smtp.mailfrom=soundunited.com; dkim=pass (signature was verified)
 header.d=masimo.com;dkim=fail (signature did not verify)
 header.d=soundunited.com;dmarc=pass action=none header.from=masimo.com;
Received-SPF: Pass (protection.outlook.com: domain of soundunited.com
 designates 13.66.130.121 as permitted sender)
 receiver=protection.outlook.com; client-ip=13.66.130.121;
 helo=btars-prod11-wu2-1-pa.odmad.quest-on-demand.com; pr=C
Received: from btars-prod11-wu2-1-pa.odmad.quest-on-demand.com (13.66.130.121)
 by BL6PEPF0001AB51.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Fri, 29 Aug 2025 13:24:54 +0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; d=masimo.com; s=selector3.c932p303;
	c=relaxed/relaxed; t=1756473895;
	h=from:date:subject:message-id:content-type:mime-version;
	bh=TEtI3D5/HuJaNm82AAtG5Zd0/wL5V1PVUkC1WGOaPc8=;
	b=bBvmC/QPCgss4PdlTHNHiuNN6I3TnXrMMtoC+Nb7tIRnFrq0qsrubp4uc/xWagMyebFmwZGr4Jr
	ZOF4nZGQEz7+APev6iNOWdbr1L+e1dynL77ZAZ74E0jVzsOS5TipZu12VmV0Lp8u0h0ZHMzrEx5dt
	kmJMVjqvjLnlSCCOAq0=
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.110) by
 btars-prod11-wu2-1-pa.odmad.quest-on-demand.com (13.66.130.121) with
 ESMTP via TCP; Fri, 29 Aug 2025 13:24:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RvD+z3VABaYIaRRgkAepxoab3aeSCJrd8WSGicxhkiVQqBzWxjd594h/5Su+8t3zqOSY5XttadbqZA/2adrjh4jqaSHvYeklmq4BTOqPzSYsP7WJ+qsrE5MV+r3uTWtSdjn3giqzmA+CwSwEoU79uiTjnNHhSQNa7ugdWM6pjWgXUIY4ii7JDn85ts9VZy4ZcNCWiIRsFmoPjNBqHgeESAxgBemEC+2qCa07FfQnXHDLDx90XgXrM23q2hxh/YtdHD0Ym2Eu6vvZVUt/s+1nXLjoTSN0mGCGHyKaX7QqkjNheZXQ8C5Zob2KLFCLa7OyVn32QoGPzMwEeXj+hJJ6JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TEtI3D5/HuJaNm82AAtG5Zd0/wL5V1PVUkC1WGOaPc8=;
 b=iibxLfJ/b90FNb2JxCGgxNYIqNQBNc5TC86Rujhzqy8ZedWVQQ4zxzhvZjO+OBjliosiImjKaMSixhCmBI+2tJhNjGDO9N210CKXrBdVNGXmJkgxZJsl69CHTvs54iDv/CJXifqrcEwuwEhsvmyckKX6CHMNKAEFuuT13A/56A2Mi7NahUoO8hT2EFQw2kOaiNXn5T+r4XQUFYG97IUyxeYD7Bjey6orVyrRLRyQFzanRF3gXaArdhylx53VOupE2h/kwurKvNoSjq+GDS08aqC5FUFUG01iUO3Z4i5htMutDxxFC6/WY05PcQN0+YnoKM9dbq79/tcx6Zi3kEvcNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=soundunited.com; dmarc=pass action=none
 header.from=soundunited.com; dkim=pass header.d=soundunited.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soundunited.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TEtI3D5/HuJaNm82AAtG5Zd0/wL5V1PVUkC1WGOaPc8=;
 b=Bmaaeg8L6TT6xwP2XQiP6oSuj7S0sXOS305uf8QQw5L698Tlb29kpOpYacyasjquDApQwFmTumW8bS8ujbo6FK/fGZmXj8iUfHKTXHoVQgaUbixEat3V7GgHA1utYHH8hqwlDWaYi3CsRxMq8h5oHG/z4T/dLfnBNgEu50Cn1jA=
Received: from BL3P221MB0449.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:358::17)
 by PH3PPF906193608.NAMP221.PROD.OUTLOOK.COM (2603:10b6:518:1::5be) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Fri, 29 Aug
 2025 13:24:46 +0000
Received: from BL3P221MB0449.NAMP221.PROD.OUTLOOK.COM
 ([fe80::e024:ef2:157c:ae26]) by BL3P221MB0449.NAMP221.PROD.OUTLOOK.COM
 ([fe80::e024:ef2:157c:ae26%6]) with mapi id 15.20.9073.017; Fri, 29 Aug 2025
 13:24:46 +0000
From: Anthony Clay <anthony.clay@masimo.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Whatchanged
Thread-Topic: Whatchanged
Thread-Index: AQHcGOf9Zs9ZVjauqUy1JnPHsslzCA==
Date: Fri, 29 Aug 2025 13:24:46 +0000
Message-ID:
 <BL3P221MB0449288C8B0FA448A227FD48833AA@BL3P221MB0449.NAMP221.PROD.OUTLOOK.COM>
Accept-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=soundunited.com;
x-ms-traffictypediagnostic:
	BL3P221MB0449:EE_|PH3PPF906193608:EE_|BL6PEPF0001AB51:EE_|CH0P221MB0534:EE_
X-MS-Office365-Filtering-Correlation-Id: 94ac72fc-ba9d-456d-a90f-08dde6ff71df
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
X-Microsoft-Antispam-Message-Info-Original:
 =?iso-8859-1?Q?Cgle1u8u1+wpajHJWohvRtAhu6xcH74FstA1YCoYmFeH+INMOXaKI3PP0e?=
 =?iso-8859-1?Q?9Xs9iBtbujH8BaVIuViSLzlsraT+ef6Kjv5NksXiYkiCq54yWh99k+ijZV?=
 =?iso-8859-1?Q?upFPe8IgJK5iTXgbBJYeovN72zNgiLmUPyN6ZZXbcBBeotFWiHygxZG0If?=
 =?iso-8859-1?Q?l9RiQKGY/Gcz5cD4AarcYfgft4PNFkES0zX2/fEidxWyUrdN8Yq1YKeEAo?=
 =?iso-8859-1?Q?k249X5totOYPEPjCJrg96pkoj7W7Ecp3YO/VFq/tUqzDxvOIzcDqYoF61X?=
 =?iso-8859-1?Q?AZZNiqKPkOs6eudnjXXdo9JbcY4nzR88V5yT3sNYscW1oyzgKurxVZ//Ro?=
 =?iso-8859-1?Q?m8hSWCBCipFBBCVNCNKoI4Jtaeu4ocERJurk+1EMtPU4yeKXcEAF5VZXaA?=
 =?iso-8859-1?Q?D3iDzPOQ3847QV0hWJwmo9OPeB3sY8xTcnnbouXDeioA/rh+OaifCPF8B0?=
 =?iso-8859-1?Q?m4bnMculCcYeY0k8MQG1ne3LVXL+Kn7vEEkCz7BTmzHWSxsZf4Uub7WsQk?=
 =?iso-8859-1?Q?Y0nF3Ss4g3v1RvCok2Nd70wQ+7UMMC7OEYNtVhsl5unqaEfH6kq2ajrc5r?=
 =?iso-8859-1?Q?a1gclKgAYmzcQeiZpqRO8pv0GWjw452bWG7rqjH7tr/GphQjHg4U/H7oUB?=
 =?iso-8859-1?Q?PpSv9sEpwaVF9BTzaDZMXL0IxeAX+paNmvb/TlmiME3Ps9WAzI7ZrMSxel?=
 =?iso-8859-1?Q?yaNgjXy56A77Hfo3Ne6p2XEu5ECn/xjZW3JQxUnoFJCDEdfgj1ifCyUVqS?=
 =?iso-8859-1?Q?7iL8u3Oif/lFWWAmapVAFCUQRjEsWe6xwz7mcyV0DfMD5gszblnw2cOlER?=
 =?iso-8859-1?Q?NWLZQtPbO8BJ3eEY/xYZmXZ8Ey53s9b08tAykiAI0VCAPyDfipQinCz0xR?=
 =?iso-8859-1?Q?lmomXVvg2bfM9DyI0La7ZOKmVnhJ6FdNYrP4cyoD8AuX0VdjyePXiZYX6J?=
 =?iso-8859-1?Q?G+p10QJ7XT4WkpzD/1xQ4msUOBr3U6rfXMOPom1UCqogfociFNSFP0A/1L?=
 =?iso-8859-1?Q?i5wWgeJtlEozzeFqEUWxdEfXrGrMYKJ7H4OnqidIQcKWQRV38GlAv93zD/?=
 =?iso-8859-1?Q?PkCk6kS1pybYu5fUNAxdI5Ocn/4mE4UcZ1OQG+c/OoLimnV3S0d/jkCpyz?=
 =?iso-8859-1?Q?XY8ezzQCf37vHL3cjlPi+VHwhZn3W8cVRFeMkfwdHbqh/FtB5d3Tn+Jl0J?=
 =?iso-8859-1?Q?TsiigH5Sf8klEjKOxhnQMYNhZIMTU2WT88qybHo+ec2KD3oMUTu92BrdY+?=
 =?iso-8859-1?Q?XgEOut7bZgbqNL65bINufg8WBf86n3uirvmZ3+Ap5uuC6+VCQ7nBW/poF+?=
 =?iso-8859-1?Q?kMSsJADE/ftWeU0JKwQRTXNRw/uErzY5yhb1xke0LawvJtG/YeXIyMuvRi?=
 =?iso-8859-1?Q?ZgqMbDdtV7PrJUvRfqmSMILhqOMWbTQ4CB63hMdRURy6kOh5owiUxtQ47O?=
 =?iso-8859-1?Q?/m9ziH1ilsGHhW2qPTos4Vw6p19LzZrg+q9ZTFMm4fJeGnsBF3NVnZ0CuT?=
 =?iso-8859-1?Q?uYtPxPExqRrVBVuEWZn38WnNgnFIxEcms5iiiGYp0v/Q=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3P221MB0449.NAMP221.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF906193608
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 BL6PEPF0001AB51.namprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	c0f3c718-46eb-4650-20f2-08dde6ff6c42
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|61400799027|35042699022|82310400026|36860700013|48200799018|376014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?Bnp2GUKq0QGf1UZyYNcZyPzQ/pveQhsnpnLRVndhfISdADItMycGFRdqRa?=
 =?iso-8859-1?Q?kaPpNECEMMjfBxBS8MRd5+eYGTDt8pTVAIPC1LQwZx/0gKx3A557QMTCxz?=
 =?iso-8859-1?Q?eUCnXzkiPR8U4XNMYLJ89uBpJC4z5NGHZCeTDq3FZHgETcauLR8xXj537y?=
 =?iso-8859-1?Q?QBWe8YYYNlGskf2EbnnPk8LoI/oZRW3qTW3QrcRSSMjdV9Tv//RSHTC6w2?=
 =?iso-8859-1?Q?+00vHHQoAl1Bgb9+FUAuOjjUGQwXMPP3CcxBR/yKlW50OPdDBYbejm3jzH?=
 =?iso-8859-1?Q?ag2/BPIlUMp+7XJwZxyKrvari3HDUS0wkH0KTZ2fCldSz+rXa6SIKeoUWS?=
 =?iso-8859-1?Q?r4NXG16Nf9ryJseTcUdu89/M7Xd/W6yzbSSEREUSH0gQoyPfEl8ik9tAih?=
 =?iso-8859-1?Q?Pp3J/0Id7vk7od5vv/danfJ+0FqIGcS00SkRk7hcubxkCEx25q/tpgZGzP?=
 =?iso-8859-1?Q?txRsknBIRLr92VFOVGVQ6aKj73x1c+PJL+mSD2s43UJOt8W0sJ8tjAMjiZ?=
 =?iso-8859-1?Q?igYhFDwQyzARhFHWqWY/xGVwfkcw8AVWEivCdmCIdm2v4Csr7Uk5suJ4Dc?=
 =?iso-8859-1?Q?EfrkJ1IBL54TXrgVq+GlKpYq1jc3Kl9SPEpmdr7M70EuNQgsY821MNAmtM?=
 =?iso-8859-1?Q?AMqmGfPJyB3mm68bw3yxEvymlr66pn9qEJnezSQYMGfHY4/rYKw+wlz9oA?=
 =?iso-8859-1?Q?puRayBeMJowQHiZVWb4alpD12utMtBov4/QzQbE1Dcy/u1tl1ACYRu1sLO?=
 =?iso-8859-1?Q?sD6yI1VmL6ZQk3n3/7NWK8TMnkBtsFiZr49kqZcHzF2PdhfnnyjIPYSdeb?=
 =?iso-8859-1?Q?Zw5MaZVH57u/EReSQZPPdSxYVLN4m0A9cbe6g+gY97zHzdlVZcQDPOO/W+?=
 =?iso-8859-1?Q?y2etGZ/gGryMb2p814pKCCxklJz4Mgcbo4j68yIXkuvKli303ijTLjMzqi?=
 =?iso-8859-1?Q?8ExvwxZmt+6nDWAWoaj541K1u7Yewmtc9+prYgnGIT5ew4+ytG5YnwLi7H?=
 =?iso-8859-1?Q?QfpXflo15zCw0kXoBzBtDd1EeMCyo8XUDUaZG21J3VOESu1wvGvGVtXpM2?=
 =?iso-8859-1?Q?vqiGvXEPunqNMEOBF7rLN8A8qYz0XzUZMnrzMrdmEmM4KHiwTZHoi1yAvz?=
 =?iso-8859-1?Q?BriCMN2qlRcQGDMTF6jGlsabaHQP+QxdvL6W2BcICg+tfK7Om7+BNQRvKg?=
 =?iso-8859-1?Q?GV2DZmmAQFzY9ZOzviHlXlVY+7soIIFoQBotlNM6hTIOOx0My/CGHuNgYL?=
 =?iso-8859-1?Q?bxExNJKgC05ySl17PaDs7OauzCKtYlyBg384s+QxR5AuDisJuGTXjIC5cm?=
 =?iso-8859-1?Q?J8iY8PExpOLlz1EfbsIPocb9yOPIGsZwJNTinLLXunuHQpgL/BQu0QL1qU?=
 =?iso-8859-1?Q?XAS44LbpVysHukwc+q2TtcKNOcbWjylV0il+2h4iMV65sZ797QIGZ08GP0?=
 =?iso-8859-1?Q?rJyuRN5cAS/4DdxXqhdlyyoQqXznfap27jeynzLNNBwCCGB6GzQq7C20qp?=
 =?iso-8859-1?Q?gB9OS3GlhnqnN1YSsFPcwNuTobRkWHfZtChUixKQC/WCQt4KbNmDhy4c6l?=
 =?iso-8859-1?Q?s0zAW/PrDrfmNnUQdaOAycoiBi4P?=
X-Forefront-Antispam-Report:
	CIP:13.66.130.121;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:btars-prod11-wu2-1-pa.odmad.quest-on-demand.com;PTR:btars-prod11-wu2-1-pa.odmad.quest-on-demand.com;CAT:NONE;SFS:(13230040)(14060799003)(61400799027)(35042699022)(82310400026)(36860700013)(48200799018)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	keMeBagu8g5q6LF0W4lCUHk3JCcHHFv3xZsbGzOMKe9h+6Zex8rugQvodrpUvsodjdwhVtY/fDMgESLnSS6Qyntlizxn9ybZpfyR5Y/CjRDZUMh5P/nCLS42rUN9NDWOKJFl7BOo/ZWppx3oYS8nx4CRDHQxGF8+53L5tW2nXSIWuMyYp/Ms/p7NbyD5UbFB3LebtDX1Jc6Yibupcgahb0LRfhzqL4elgXzPe9+A9qdK/igHMwIbs+qMpUV9pXGWKca76DGqDe5gPUBZD+OYLT6n6YdnO68kphB5OLueQq9AAGgh/sxHwtae/m9UQJiA3dqPePJVAh0HKmajAT1RAQo/TckRGM+Hni0018KZ89+tqVZ++BIsOwmSJzr1MnwLfwIJ8l/U+nhF/pm71C2sXtFaNLAMpGvWzEfsD4n7F8QelcqLzNjX3N2Zd2u84chtmCwOfpbcqEKV6KogpS+WqRvRHu2aDmQeI2WUD5Pnb4HR3s2dFMvOcUipFAKqtoUdpjTl9ShFR1f75WwHMSMW14EAO83fXMGuYyLmu05Lz0BnzxPQ2/93t1uq6lHErB6WscAZny9rcAVlUb5sGKX6oIRv+SbbJ4t5eOTjGgC0SqhuZcGEjMKwp49O1R4M3fLeFiK3cMwZk1rERqIwUDitcSQmLKkObZKHQS6eEiU8W2HubYqLJmd2HiCEVxYaM1UM/pEcFaI1kVcXnKej2XVvtMhKur8ODpVv0ZZpgsuZ+Ok=
X-OriginatorOrg: soundunited.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 13:24:54.5946
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94ac72fc-ba9d-456d-a90f-08dde6ff71df
X-MS-Exchange-CrossTenant-Id: 1dd98ced-2ee0-47b2-b284-37587f818155
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1dd98ced-2ee0-47b2-b284-37587f818155;Ip=[13.66.130.121];Helo=[btars-prod11-wu2-1-pa.odmad.quest-on-demand.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB51.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0P221MB0534
X-BESS-ID: 1756473904-110772-7679-4593-1
X-BESS-VER: 2019.1_20250807.1754
X-BESS-Apparent-Source-IP: 40.107.223.95
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVqYGFkBGBlAsxTA5xcDUxCTFwD
	gtxcjEPMncIDkt0cIs1dAozdgoxVKpNhYAmTS4c0AAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.267105 [from 
	cloudscan-ea21-205.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS77725 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

Greetings,=0A=
=0A=
Kernel audio driver maintainer, here. The first thing I want to know about =
a branch is "whatchanged" - it tells me exactly what I want to know with no=
 distractions. So I was horrified when I saw the removal nomination message=
.  Please reconsider - while git log can do it, I don't use git log... at a=
ll. I'd just have to add another alias that would be another thing to const=
antly collide with while using docker build chains with different (but usua=
lly older) versions of git.=0A=
=0A=
Thanks,=0A=
=0A=
~Anthony=
