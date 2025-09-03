Received: from outbound-ip3b.ess.barracuda.com (outbound-ip3b.ess.barracuda.com [209.222.82.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71FD1F8BD6
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 17:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.185
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756920957; cv=fail; b=KuIVwIfduLuOR3+/sZv7XtuXklRtAbKo/TZS4M5Rj+/kFfZyBYNy2y2mCVq/GqWo8wpFkkSG7LRrKPK2GQJk/y+oBa/bWn5tr3BbpJU7TWvqW9ETTchlDc0ep17xnql0XLeBsCA3rvgljhuwyFOSU2jdo1f6qad5oHerMvrEoJw=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756920957; c=relaxed/simple;
	bh=ISkMVl06OGTWRXp1YnN5LGx9nSNa0M+fQktZDtrnBBE=;
	h=Content-Type:From:To:CC:Subject:Date:Message-ID:References:
	 In-Reply-To:MIME-Version; b=Mx99KTGrZpXoFZhOf7IcEOxoWbmYt7MiqTaVQEli54XXHcX8TRG6Ufjye6VelB3TidZZooy/bMJpqY51QK39MqTTAVAnz5boWd/isY0CAVzfuNevzmHfAMr9s8C0Q62uMTyd7TfLe9wlfOog3yVgvzIOluUyb0t7j+pgSGIY0TI=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=masimo.com; spf=pass smtp.mailfrom=soundunited.com; dkim=pass (1024-bit key) header.d=DMHGLOBAL.onmicrosoft.com header.i=@DMHGLOBAL.onmicrosoft.com header.b=Zy5uay9s; dkim=pass (1024-bit key) header.d=masimo.com header.i=@masimo.com header.b=L0b4F1Va; dkim=fail (1024-bit key) header.d=soundunited.com header.i=@soundunited.com header.b=KgLC3Llr reason="signature verification failed"; arc=fail smtp.client-ip=209.222.82.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=masimo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soundunited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=DMHGLOBAL.onmicrosoft.com header.i=@DMHGLOBAL.onmicrosoft.com header.b="Zy5uay9s";
	dkim=pass (1024-bit key) header.d=masimo.com header.i=@masimo.com header.b="L0b4F1Va";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=soundunited.com header.i=@soundunited.com header.b="KgLC3Llr"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2129.outbound.protection.outlook.com [40.107.220.129]) by mx-outbound16-36.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 03 Sep 2025 17:35:50 +0000
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=fail;
 b=IK4FlZFq1DMQZxO3az/IznBIDLQKJwu+K2HLAzwIhZccjTjOO/lLoRjfQN9DHhxxu8nbP8MReeBG+r6DGwNq/ugxcGBklUWph87h1uXwMw1fnI7jeYoPB/gSJJj9e/a9zoyo+0Mcp0CI/lO0eUcqifyx6gjmNkGsK9A8C01vHYtAYveUDJj6WvgakAtnyK/X3sLyBPCnFTQH7NuVMdwbCgYu5vTva7ADWnWq+OH1ik6B4FSg3c3/nRpPLfxrVVY9PVvMnqjnLF8/65jrIpdPHajX8Aaxv7k4I7T2FZicpFkVI4yIvIA6jOWJISmAwHeYHcK6CQ8NAD6xrFmiLeCkkQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ISkMVl06OGTWRXp1YnN5LGx9nSNa0M+fQktZDtrnBBE=;
 b=Hy2xVxGOrA06bOlGJvVce3MuTcVuKsScWMSr/QMJooK27N/pdshJIncNI61VrasuuUBK9Ixo7TjgMxNW+w1KHWJdWXJftnhj6fdGYs5N75MrGp/Q6TPRYHnA/6aRCQhWSaFjLwKs71kMlL/0jqFKiKEmQt9HkoBduQuPJZONtK1LpHSg2mXAryuEUyiajEW61Bh5MxMGU2LF8oAknzVSLoP7foSFQbehoQnk/bTtqvedLrRBJTvrSfhEWiWkhv3bik0JhQcvcrW2h/BmhzakuVEiRtE1vC0jr5gzc9kd/gC++mXTu64rfIb8xrqnL4KPEqi+dBD5VWf6vMc+SlWUaA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 13.66.130.121) smtp.rcpttodomain=peff.net smtp.mailfrom=soundunited.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=masimo.com;
 dkim=pass (signature was verified) header.d=masimo.com; dkim=fail (signature
 did not verify) header.d=soundunited.com; arc=fail (48)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=DMHGLOBAL.onmicrosoft.com; s=selector2-DMHGLOBAL-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISkMVl06OGTWRXp1YnN5LGx9nSNa0M+fQktZDtrnBBE=;
 b=Zy5uay9sHVia/4VAFdCwViP4tQ5DCJRqC7LcUT+5twaf+xd1RH1vSCax8JDolIeB5ZRLsDOvMrGa9dm2TVhZs55X9YtrEEjiJGWryJHxzz2jWKjbXgNOTmgwlLxdID3QQp+1eSkLvIjLRE1MlLuw7o38XNKf8RgDVRs3BnBmhG0=
Received: from CH0P221CA0027.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::8)
 by LV5P221MB2215.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:2f9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 17:35:46 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:610:11d:cafe::ed) by CH0P221CA0027.outlook.office365.com
 (2603:10b6:610:11d::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.17 via Frontend Transport; Wed,
 3 Sep 2025 17:35:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.66.130.121)
 smtp.mailfrom=soundunited.com; dkim=pass (signature was verified)
 header.d=masimo.com;dkim=fail (signature did not verify)
 header.d=soundunited.com;dmarc=pass action=none header.from=masimo.com;
Received-SPF: Pass (protection.outlook.com: domain of soundunited.com
 designates 13.66.130.121 as permitted sender)
 receiver=protection.outlook.com; client-ip=13.66.130.121;
 helo=btars-prod11-wu2-1-pa.odmad.quest-on-demand.com; pr=C
Received: from btars-prod11-wu2-1-pa.odmad.quest-on-demand.com (13.66.130.121)
 by CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Wed, 3 Sep 2025 17:35:45 +0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; d=masimo.com; s=selector3.c932p303;
	c=relaxed/relaxed; t=1756920946;
	h=from:date:subject:message-id:content-type:mime-version;
	bh=ISkMVl06OGTWRXp1YnN5LGx9nSNa0M+fQktZDtrnBBE=;
	b=L0b4F1VaSOlrEOei3yaf1PTxjW8ZjFwlq69uXVrCiWUs3uHtEoEc/+uhyZh1TeXr7fC0+43KYS1
	LB8YV9IKEJ6fkPO3yoDbN2lIZgiO+eUTJoNMDKidks/ICi9bDYgV/6hlhatmsUDjZYF94QWu8nVBt
	D7M/Xo1ODTRuLMhGIrY=
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.114) by
 btars-prod11-wu2-1-pa.odmad.quest-on-demand.com (13.66.130.121) with
 ESMTP via TCP; Wed, 3 Sep 2025 17:35:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fpFw1Xv6eXcbgbJh9vdpy603RZ+1XuE3EAr3NPxMnrb5fdYsW7YOKMEamF7ZbeAZf6cFsiT9UVDrIGlNB/M/tswcJiZCgGRc5O2vRYOvyOhrKNWnBi2YwUB3+3PA0u4sEHMFWvvie9k7lkC5yZIqL/G1425/vgcjKMQOhr9BGwngqr9zP1ZB2fHKRJDBHObeKAhmaXPq2eE+2omNPEEvbGwG7R7e1YIPwaRnQCGHSWWZt+EVEGkLZaW43t/XYVU6HEfs/p+yh7WMSFO5pTT657vq5ZNgEkRQ+q57FWltzf89fQU7BngZE2ci8HE1vnzQvp9QtaKNp9jN5tQWnYnocA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ISkMVl06OGTWRXp1YnN5LGx9nSNa0M+fQktZDtrnBBE=;
 b=Pdy1v6okKFiiP4UlbQsNsaRnr1FtMj/u3xhQwd1hBn9Oca1rHuEdgcXsTTJQZHNGskIdvlzOjYZttceX11RDhjCw0YWFWg5t0zFPS9Y9gRRalX/Ub4n8/7k0zSeZ0oTPUjziZdyNvyDLiJ3whGxQkDdGTPdQaYGfSmd8ElGq+Q99IakhvBOzjsIxGcTejpSeHcluP3k0YWm7tTlUkZgm2cebr/HY3GGnS6xyn1OvY+xJD5g0oRIpD/xkwwBaOodrQmaZSd2T8BmjKjdPEBQbkXvX8LkeQeIEsXKrrtMy3x6XafSqp1YQyR0cJkkte/u3qGyfplR43cEKOHpakxTzmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=soundunited.com; dmarc=pass action=none
 header.from=soundunited.com; dkim=pass header.d=soundunited.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soundunited.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISkMVl06OGTWRXp1YnN5LGx9nSNa0M+fQktZDtrnBBE=;
 b=KgLC3LlrKnolEzvYB12dG8qTrmQykS5jGLnpKj5433VyvFbuJ5N5ywf5FASnhWyjuviGyzG1VWHHPdBFYTYzSkz4mDw0EylLz9Ly7QAApLiQ4eLquM7UJq4xazPJYNi8T9WU62m9EgJEHAFFjNQWEO5Fy3MsBR1fm6X4albOucM=
Received: from BL3P221MB0449.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:358::17)
 by SA1P221MB1042.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 17:35:43 +0000
Received: from BL3P221MB0449.NAMP221.PROD.OUTLOOK.COM
 ([fe80::e024:ef2:157c:ae26]) by BL3P221MB0449.NAMP221.PROD.OUTLOOK.COM
 ([fe80::e024:ef2:157c:ae26%6]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 17:35:43 +0000
From: Anthony Clay <anthony.clay@masimo.com>
To: Jeff King <peff@peff.net>
CC: Kristoffer Haugsbakk <code@khaugsbakk.name>, "git@vger.kernel.org"
	<git@vger.kernel.org>
Subject: Re: Whatchanged
Thread-Topic: Whatchanged
Thread-Index: AQHcGOf9Zs9ZVjauqUy1JnPHsslzCLR6eWYAgAdGxxk=
Date: Wed, 3 Sep 2025 17:35:43 +0000
Message-ID:
 <BL3P221MB04497E3E6A13AEB178DD38F28301A@BL3P221MB0449.NAMP221.PROD.OUTLOOK.COM>
References:
 <BL3P221MB0449288C8B0FA448A227FD48833AA@BL3P221MB0449.NAMP221.PROD.OUTLOOK.COM>
 <20250830022718.GB567900@coredump.intra.peff.net>
In-Reply-To: <20250830022718.GB567900@coredump.intra.peff.net>
Accept-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=soundunited.com;
x-ms-traffictypediagnostic:
	BL3P221MB0449:EE_|SA1P221MB1042:EE_|CH2PEPF0000009C:EE_|LV5P221MB2215:EE_
X-MS-Office365-Filtering-Correlation-Id: c12bedee-3acd-4c8b-e0d6-08ddeb1050b2
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|38070700018;
X-Microsoft-Antispam-Message-Info-Original:
 =?iso-8859-1?Q?2FupkRnL3HJwuWN2WkGEM94u2PgCGFr/epf8KKkiIN6T6VJEklogpBI3yI?=
 =?iso-8859-1?Q?5myaQfJPjEQwv5vT8NldACiA7n5WSyl61ZvQYHlnWCTelP8PMzF3lLmlmm?=
 =?iso-8859-1?Q?HN9R3J2wv4zb8YT7ntm730Ad6JIBcEGKnZmm3xDu1xaQ2a3dLsPP4GSiwR?=
 =?iso-8859-1?Q?axtNuaNPh4Bc0A4tuml77NFDbZAKxtugkp8NroBqk1Kt/WqhPVAzmP3Zl5?=
 =?iso-8859-1?Q?eLL/MDMS9n9rutKSzibEE/XA4zizIXzhcQ7ot2WU5ufdB12ZIw3gVlQJ0m?=
 =?iso-8859-1?Q?JCxZeCoh0kXdLxN78UnkP9FwH1TDMPNIU9GSPUNt/Nj9cuRUg3jrfoZhsl?=
 =?iso-8859-1?Q?5efGVepCN9IAE93Arfld2+e5nH5sj/j82zukDmYcvDo64TAj8sykC+97JW?=
 =?iso-8859-1?Q?BOibQFjmmgXL+VQgYosNs6vAjSf+9KeZ3Q8sXf5G9MQvYhVucwzW3Mr0AY?=
 =?iso-8859-1?Q?JKDXoU3igz2aWs3OS+76TpNDX1Yuswi1XovGjMpplOxp6WjmLYbq/l/vBQ?=
 =?iso-8859-1?Q?VbYS6T9OWPcpG7wBA8x6Bi3IH+9IHm2YfcKM784fT63fCrrJc1polLwfjX?=
 =?iso-8859-1?Q?iq86tum+7d3ixWj+wZS9wqNyqmn1gLZig3gDXlwrsA7WaFyreEgv7sYG+k?=
 =?iso-8859-1?Q?CQ7wcMh46ZyQxbglLj1s5Jt2e3mooE1XgQNC1T8Fq3D3V9AFtDLIWqh1ud?=
 =?iso-8859-1?Q?ldHGUcU8tCarnPnhCc22Q7e8a9oMIV/HZ4FGBapUOKs1iNqYqyMnvw6yRe?=
 =?iso-8859-1?Q?glYf1u7LKbaXQvH1J0tP2B0KXvSlydkVGltV3dntdwHdIYUoAG6VcKJ2Wj?=
 =?iso-8859-1?Q?ihB6/naBgqr4P21aqq80Zk6HDE3LkoZ7vB3HA0/8cdErjdQre5Ns/CL7SI?=
 =?iso-8859-1?Q?LzqNAiB0NZYTduGvs3HMxAyOD2jyYrEVC3IZ/le5ZtXIs9jKqu7xogZPni?=
 =?iso-8859-1?Q?38YwruEzehzgT7dcue8ukdhZG4alpFwYvnhOMDCA1G1iIfYPDmWUqKLlVC?=
 =?iso-8859-1?Q?GmgGMCIvtNJXlzW3xspMuTPDzThSbsdzYzK/u85jFRFLsBCrUVi/zWI/Fq?=
 =?iso-8859-1?Q?4X6Xq1hFgZ5/HpuQHHJ9SEzo9Rag/D1eMvjBZQadxLhlplyoqNJiT/f8IL?=
 =?iso-8859-1?Q?z+wLsKrQFcRd4k4kEpvS6glRBH6wHqAv5llp0XAmHzoM7/PQ+MH6Mi3Lm9?=
 =?iso-8859-1?Q?EpTjUewFfuXa1wtKxiE1Y8/w+Bs0w2PZKWrmGQNV6q6oeLIagiJWLSuIog?=
 =?iso-8859-1?Q?tcyLDshKdKVpkp+16FuHkNxEYPrs1ocsn5sCv65qdDPdliARYj4txH8MGk?=
 =?iso-8859-1?Q?buo1ve9a5uqn5vIa7tNbAETpeBEgQ5ELtKjvNryZ+KOhP8yDwTpvMkJDNy?=
 =?iso-8859-1?Q?+EnK7dY2PXhDZ8wsGY2vklVO1jcQJih786pmkkGXs2bBF+l1jbQ2mmAb/c?=
 =?iso-8859-1?Q?J0aF5gqN4s52/ZD8KxdzqMvBiYFK4S+mx+lwaNl6uE8RXDYmJqEF3uK2hV?=
 =?iso-8859-1?Q?fhW9AVrDWldYep5mHpJUPGl1TTNB3ya8U1+fsB6v9fmQ=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3P221MB0449.NAMP221.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(38070700018);DIR:OUT;SFP:1102;
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1P221MB1042
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	1dd8c0ac-6571-40ca-6afe-08ddeb104f04
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|36860700013|82310400026|35042699022|48200799018|14060799003|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?LJPiIdfqrdS+xToOev9MF/9P67olrSEPFiCgoQCxO6eA9Fcoin0eDgFXoQ?=
 =?iso-8859-1?Q?NglCr01FHb04iME4cXcyuk3pw/aN5kwQ+8TiOlu8c5Njmvap4G786+0zbH?=
 =?iso-8859-1?Q?e7NyHns1A3ut1YCogBIQMyg4F82JnNhlxlo2OrnzLzIuCDwBBO/zl6lenE?=
 =?iso-8859-1?Q?zbtziXzFxQX9705aYwiPCLHGoMQZld+cnpjfG5SC2HF+t4tpDTyNf8uBP6?=
 =?iso-8859-1?Q?4dVBhMjU45cjajPPSCcZQTQn+t/Y8zW9OZl9/E/8N+yhzcgwDkNQqCmBcj?=
 =?iso-8859-1?Q?CGFHvEFrnRDsRrH9DoL4wBtbKqGRQzB7g2ZfaW/IOYi7vQjVbVVXhw6Bx6?=
 =?iso-8859-1?Q?GjFCco/ke1BWSLLwBtRdycZr3TMV+kgufNc9diAjXCDbfCZf/I/XNa73w7?=
 =?iso-8859-1?Q?x0KAfW149T3eZDjpYyk8ouOOVR5HbfFnRoxWACWufISaCLTIy/kILaXzuB?=
 =?iso-8859-1?Q?B108hVKO/H/7iGoSPsv2EcrQcEgwqwIi4BqhDD4oJeEOjvFQVPct8CxxFn?=
 =?iso-8859-1?Q?2wmCCcAFjI1b0e7HyvsWrVYYjN3VsjYd2Nct6Vtu251Ml3rMzqx2PauyHH?=
 =?iso-8859-1?Q?wozHTTGfMm37/MhG9owibPtYwbT9i82FazEjmxw/GTOX/fF5iyI+6++3Ev?=
 =?iso-8859-1?Q?KumE4l+0I7m/ChHIukfkNNC/IXo4UHIwnBjU03zpHJXcqmFulpdOBBuakq?=
 =?iso-8859-1?Q?40/tj83MnZGAUOffJXRe9GPT0mg1DlQEVvKnj/U+pMdX00NKHvB5tujUUN?=
 =?iso-8859-1?Q?HZQjuJ3ySgHvR6PvI4BCuSKwqK1pCTYAIpAbKMXwVyOT5O6ELIedHLToQy?=
 =?iso-8859-1?Q?RS29cGQIo7kL+yUgT4FVRwIqdZ5zHjNApRQ8p6lDbgX0/GctcdBpWdkW9s?=
 =?iso-8859-1?Q?LrXuNPFGASOA7Tiv9MOCPd+8m6msuS9vJSk8tXnE2+TgBjQX0fHuEpkA4o?=
 =?iso-8859-1?Q?HNdxUovE4ye7oNwvCj38n7m3he/QuqB9vNpkow1N3J/KETRgV1B83ejYc2?=
 =?iso-8859-1?Q?Dw07boXGaOJRJGR3tYlJwzZRdgPqakcoHfZdDwSepfnCgaMQzzslZ4bTEN?=
 =?iso-8859-1?Q?wqRzZHnYN5LY9/N4pNs4YsQQLElENgbgDfS+jZUNIQg+ngWSeGFlfWadKB?=
 =?iso-8859-1?Q?mZTW8SVezy7vxIBkUkZezVLpFYfZ/sVdTbJHqXTlPNKBtWejQstRqFMEep?=
 =?iso-8859-1?Q?kjTpFO/T2TsR8k/uooEqNBlhC40/5MN+lEpV8F9z/MUSBjbzpMJor5U3No?=
 =?iso-8859-1?Q?YyDTl55RYc0EYIAlzPbJ9DqujAMFaFcCQsxCBtexms9fNhZzzoNT12nDBD?=
 =?iso-8859-1?Q?Kxt2shY2m5EEA75Qzz2AeM+HaU5Gb5W7Llcr4o9rHLdarE6TdP0duAGUJ4?=
 =?iso-8859-1?Q?CJCmei0769GB4XLT7ltUdVzJ+GfBlZnSDNH2lS6fqafZH55aiTWZKAZquS?=
 =?iso-8859-1?Q?lsbjiiDH5I8b2OLR76WjPa5FhR3krRsIFuhMvd/eem56ayGSEI4WFep+qg?=
 =?iso-8859-1?Q?Sghufnh2GUDffeAYmfNqLYA/W4MiAG4wrDWKP5XmO6KMJS9N2FX5E4RqnL?=
 =?iso-8859-1?Q?xLv017QTeqTYMJaWpZReDteNP9l7?=
X-Forefront-Antispam-Report:
	CIP:13.66.130.121;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:btars-prod11-wu2-1-pa.odmad.quest-on-demand.com;PTR:btars-prod11-wu2-1-pa.odmad.quest-on-demand.com;CAT:NONE;SFS:(13230040)(61400799027)(36860700013)(82310400026)(35042699022)(48200799018)(14060799003)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yMtqph5DeKQHPzNqoqC+bab6oxalNJUwgxaHJTn+SKkjsZLYjanpS3GZZ2DoLNqVr93+DAVylsESps0lLGhd/btTUFUWrcChxj2HnQHH5hFim5XsKsB6WkOwX1J/w42vjzJs9J+Eg0WWN5/awLctrhjvn3zsjKRELU6GwzU589I8UJ/CWYKocmf7kSkTLuDy9DMTQ1tcZyA4wY30pv3QZGqwr9jcNP+awR/5KZRW/YntnBM1qyLvEnPRLUvHzyGaDM0G/8LeMiW1YsOpvsqeA6V+pMnD2yhUI0sgkb/x/5DgR0oFSfWVVIUkftrEiqYX2xYNSWuWpgBXJWuCsfjQ+cuHLSDIOAUplGFTW5gN55C2BaYTCmCiCyDoR4tN5PLD6oI46CwiLodXTTo6Z7fV3kdJw1WL9iLGbTAyMbYXvqGkjGRZ2gufalk8llwYbsGQlWCUk4+sln7po4funJZMmM4UjRMvbqt0pPQzqscnHOFeuHeuSc1v2PCWMz8gzv1oUmnwF4FZKd1HMzSQWHZzgjFTHEMBK14dgkCv/2esc2LeipKB7Z8zd4RsC+jjYIwn80Ffv4yftEQVHt0kzuAmkWMsl/4fswxbMxeuFQHmQg18u9+EyXNxFMUuO6+F2gPyTOSogeJQHFSreW9sZYIoQw/KcCNd8Df6lRv2uTrT5bw9ycQlNoQjUUo2msWOBfTRx+nFh53+wKiVrFnoNS7bTi+FMoEjHaZfhdSGyYiS/xM=
X-OriginatorOrg: soundunited.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 17:35:45.9479
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c12bedee-3acd-4c8b-e0d6-08ddeb1050b2
X-MS-Exchange-CrossTenant-Id: 1dd98ced-2ee0-47b2-b284-37587f818155
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1dd98ced-2ee0-47b2-b284-37587f818155;Ip=[13.66.130.121];Helo=[btars-prod11-wu2-1-pa.odmad.quest-on-demand.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5P221MB2215
X-BESS-ID: 1756920949-104132-7600-868-1
X-BESS-VER: 2019.1_20250807.1754
X-BESS-Apparent-Source-IP: 40.107.220.129
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsbmBkZAVgZQMCkx1cDc0sw00c
	IoKdHSzDzJLNXCMtU8JdUo1TzN0MBUqTYWAKd96ZlBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.267221 [from 
	cloudscan17-187.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS77725 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

Thanks for the response!=0A=
=0A=
Talking with a few others here, we did discuss that the git config alias.* =
would be just fine.=A0 =A0Being able to override deprecated commands would =
be greatly preferred as my git config is already imported - so one and done=
, there.=0A=
=0A=
________________________________________=0A=
From:=A0Jeff King <peff@peff.net>=0A=
Sent:=A0Friday, August 29, 2025 10:27 PM=0A=
To:=A0Anthony Clay <anthony.clay@soundunited.com>=0A=
Cc:=A0Kristoffer Haugsbakk <code@khaugsbakk.name>; git@vger.kernel.org <git=
@vger.kernel.org>=0A=
Subject:=A0Re: Whatchanged=0A=
=A0=0A=
Message originated Externally.=0A=
=0A=
=0A=
On Fri, Aug 29, 2025 at 01:24:46PM +0000, Anthony Clay wrote:=0A=
=0A=
> Kernel audio driver maintainer, here. The first thing I want to know=0A=
> about a branch is "whatchanged" - it tells me exactly what I want to=0A=
> know with no distractions. So I was horrified when I saw the removal=0A=
> nomination message.=A0 Please reconsider - while git log can do it, I=0A=
> don't use git log... at all. I'd just have to add another alias that=0A=
> would be another thing to constantly collide with while using docker=0A=
> build chains with different (but usually older) versions of git.=0A=
=0A=
Aside from finger re-training, is there a reason that "git log --raw"=0A=
doesn't work? It should work on all versions.=0A=
=0A=
On the subject of finger re-training, you mentioned aliases, which made=0A=
me think a bit. In a post-whatchanged world, you are free to do:=0A=
=0A=
=A0 git config alias.whatchanged "log --raw --no-merges"=0A=
=0A=
Before then, that alias will be ignored. For older versions of Git,=0A=
that's fine; the builtin does the same thing. But there's an awkward=0A=
period _now_ where whatchanged complains about deprecation, but does not=0A=
respect the alias.=0A=
=0A=
I wonder if we should loosen the "aliases cannot override builtins" rule=0A=
for deprecated commands. Perhaps something like the patch below.=0A=
=0A=
That would let you configure that alias now, and everything would=0A=
continue to work no matter which version of Git you used. Modulo the=0A=
already-released ones with the deprecation warning but without the alias=0A=
magic I'm suggesting. :( So maybe not quite as helpful as it could be,=0A=
but something that could make deprecations less painful in general.=0A=
=0A=
That said, I'm not sure from what you wrote above if it helps you or=0A=
not. If your problem is that the containers have random unknown versions=0A=
of Git, it would help in theory. But if your problem is that the=0A=
containers do not have your alias config, then it is not much help.=0A=
=0A=
-Peff=0A=
=0A=
---=0A=
diff --git a/git.c b/git.c=0A=
index 5dc210b7b4..7c4b5a17a7 100644=0A=
--- a/git.c=0A=
+++ b/git.c=0A=
@@ -794,13 +794,32 @@ static void execv_dashed_external(const char **argv)=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 exit(128);=0A=
=A0}=0A=
=0A=
+static int is_deprecated_command(const char *cmd)=0A=
+{=0A=
+=A0=A0=A0=A0=A0=A0 return !strcmp(cmd, "whatchanged");=0A=
+}=0A=
+=0A=
=A0static int run_argv(struct strvec *args)=0A=
=A0{=0A=
=A0=A0=A0=A0=A0=A0=A0 int done_alias =3D 0;=0A=
=A0=A0=A0=A0=A0=A0=A0 struct string_list cmd_list =3D STRING_LIST_INIT_DUP;=
=0A=
=A0=A0=A0=A0=A0=A0=A0 struct string_list_item *seen;=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0 while (1) {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /*=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * Allow deprecated commands =
to be overridden by aliases. This=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * creates a seamless path fo=
rward for people who want to keep=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * using the name after it is=
 gone, but want to skip the=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * deprecation complaint in t=
he meantime.=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 */=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (is_deprecated_command(args-=
>v[0]) &&=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 alias_lookup(args->=
v[0])) {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!ha=
ndle_alias(args))=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 break;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 done_al=
ias =3D 1;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 continu=
e;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
+=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /*=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * If we tried alias and fu=
tzed with our environment,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * it no longer is safe to =
invoke builtins directly in=
