Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E4813AF8
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 13:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eIPWPuPf"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656611AE
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 06:11:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cbiA9OtuPXyUgNrLxPTyDBfAJ0dmRY3TfzkMUSpHkAZ07M9W/9qSYfl7WqUY6pV9ibwc+4CjEGneOpVQqYbPmWzNTiG01vfRnHgkaDiMeQHAEDBDz+oBOqkTz2tPNQmIyj48ljKSCeJ6sztJIlp5q0aluQvcMLtGunin9kAhXzfIJjAadrRfJWoCfMvvaqIoeL6mCQ5Gm+EjZvORSxwuI2pMdVSwSS1GQU9aaFC0zf6EQIlkT+81AoKI0p+LMmut0G9uF9tKDnU5lhl3x1tUfb1ApSvVM6IlxrqM+agvmhZ9l8QS9/4ZZ/TJjQCx2NA4988jUBOHQ+OfeuJ0+QRIVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FmvkNuBvwSw0SdFAhyN6oHo9um8xyAVarwq0hED+3zA=;
 b=UnTO+BNLcPg+DIECJNETBThiN9THUWRNGUklE7SVr7naC79c862rsq0PWo/01sMFjZcUnepYxrVf/GJJZc3405JHF/pO28ozHTv95rrYsSzReUaYr0V1MCq6yHUyF7qI3qkM3oEBh5nAnmbWdK5K/0vQRYoecniIjCOssxuhPtZSFHCH5nd86NnDAgzlILI9wxlOA1o+yUo9f/ni7Rgdtl+NkTVbq9vReF/zKMufj9dYPtXa7AwQG55wh778LSK95afQRlrJMN07GbJviffD8GOOQlnZRY6RaEh3QPG4lbidGThOdcBj3f5borDKmX4jcz5x3pa8J3TE8I5c2kc2cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FmvkNuBvwSw0SdFAhyN6oHo9um8xyAVarwq0hED+3zA=;
 b=eIPWPuPf/hEnQ0w7tX9eT1aOLXmlFOf7YJjrTyFNojIC9OJLHH5zcyr68565bCMCR9QsKwAhPeMOi9GohTawDEhLxOzfwMqBwfZn/7MIgxeG231bVv7Ey/T+0eRNBZ2918GOehtwpRkdBqd0H2baAYHpVNv+sM+94P415nWkDUo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) by
 PH7PR12MB5760.namprd12.prod.outlook.com (2603:10b6:510:1d3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 13:11:16 +0000
Received: from DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::a0be:f6a8:2c72:ae90]) by DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::a0be:f6a8:2c72:ae90%6]) with mapi id 15.20.6933.019; Thu, 26 Oct 2023
 13:11:16 +0000
Message-ID: <7f4620d7-69bc-4237-a46e-4ed7249c00d8@amd.com>
Date: Thu, 26 Oct 2023 09:11:13 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] send-email: move validation code below
 process_address_list
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, Bagas Sanjaya <bagasdotme@gmail.com>,
 Git Mailing List <git@vger.kernel.org>
References: <7e2c92ff-b42c-4b3f-a509-9d0785448262@amd.com>
 <xmqq1qe0lui2.fsf@gitster.g>
 <20231011221844.GB518221@coredump.intra.peff.net>
 <xmqqzg0oiy4s.fsf@gitster.g>
 <20231011224753.GE518221@coredump.intra.peff.net>
 <b4385543-bee0-473b-ab2d-df0d7847ddf3@amd.com>
 <20231020064525.GB1642714@coredump.intra.peff.net>
 <20231020071402.GC1642714@coredump.intra.peff.net>
 <20231020100343.GA2194322@coredump.intra.peff.net>
 <xmqqil71otsa.fsf@gitster.g>
 <20231023185152.GC1537181@coredump.intra.peff.net>
 <393f598e-c7cd-4dc6-a221-9aed7ffcc2b1@amd.com>
 <ee56c4df-e030-45f9-86a9-94fb3540db60@amd.com> <xmqqmsw73cua.fsf@gitster.g>
 <xmqqil6v3cgq.fsf@gitster.g> <ddd4bfdd-ed14-44f4-89d3-192332bbc1c4@amd.com>
 <xmqqlebpr1se.fsf@gitster.g>
From: Michael Strawbridge <michael.strawbridge@amd.com>
In-Reply-To: <xmqqlebpr1se.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0092.namprd04.prod.outlook.com
 (2603:10b6:408:ec::7) To DM6PR12MB4356.namprd12.prod.outlook.com
 (2603:10b6:5:2aa::8)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4356:EE_|PH7PR12MB5760:EE_
X-MS-Office365-Filtering-Correlation-Id: bc359ba6-0b2d-41c8-56b0-08dbd6250959
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ytIp35NljDqNAAGqI89uaAKn2JKyGS0aJv5znzY6bcTWpnAzTr/LUO/Ilic0PeRch4UVObkLTJrYr4YoSsZgc0mbP0/fncVTEtG7+GEr+Hqx4ftPf0jiU9sChG/uPzm2KS1ET2xuvDFAUNF4FvdrPCunepeOop/dgLMWMCTyN6EEIWGWSekNy0gprUFFQBSs9cXw8BzkBw4j6+1U1Mq1FdqTatn6udsHHwhGoo2rexFVOIwLIKWNyG9JloXCHB2nHkbDguimQdQKMm2Z7JqDsnMrMM5yd2oSfoaeZlp+HHCsChHcKxeqgvEFOZOY9xcG7phExDiaL3ZyZsBXFClTfIPWd4yxejDHhC6OuX0C3p7gn7JAbRifblgSipy1rym/ScX+H9d6PltXgmWUiWUs+L75vPFvtgDEnQ2PNMIWzwPJ9hIgt0ccCCXUOBU8JxXkTrkMIjVpTvmX4QhS0CiBGLMORl+Uas/JVaM74qy1W+PT03n3Tm0cel1LlC5KoecnCU38UI1dOFKWun7uD+TLzG6euE7nS/zO5+IBv+My3szI+tC1Y2Nga/Gy5hwS555TnUASgsV2LNYm/ld3iVgdr1URulmZxw1NIt1Hx/YMLpbRULuxjfqPSzWSne5/vUBbXUrzM1nTRBM91wO/clwy2Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(136003)(39860400002)(396003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(66556008)(6916009)(316002)(66476007)(66946007)(478600001)(6486002)(8936002)(4326008)(36756003)(31696002)(54906003)(44832011)(8676002)(2906002)(41300700001)(4744005)(38100700002)(6506007)(6666004)(6512007)(26005)(53546011)(2616005)(5660300002)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QWIxb3R5QThIVVZZQlhrNHlxV3J5Y0xFQVBRY1ZobnplNUEvRFNiZjV6R0dm?=
 =?utf-8?B?TkU1N3hzdmdoYXFETnVPK25NU21zcUUzUExkMkozYnY4czY4RnBqdk8zRXFQ?=
 =?utf-8?B?ZTZJcm5LQTJaQ0dRa2d0OENqS0VCZllpZ0Z4RXYwNjZSUkNrUnJkMGQ3Wm9q?=
 =?utf-8?B?ZWJxWlVncUkxTEVNd1ZRVysxcFJzNC81azNjNDBEVmUzOE9VV083SHROcUVy?=
 =?utf-8?B?dmsrcXd2S0txU0p3RDVEbVZEa0I3U204d0pIMGdsTXZSZ0ZtR1hNUHV4ZE5R?=
 =?utf-8?B?WENtYjJxOHdndGFjOXFQSit1VVhtQ3dkbTY3SlpzcXZWd0tla29hWk5Gb0Vt?=
 =?utf-8?B?RHJWUUJDemdTcmhYaEI4K3ZodURjYVFad0l6ekdUckJpd1JZbzFyS0xkTHlJ?=
 =?utf-8?B?Q1cwRkFVcDQ5Z0tPazlqelJ4U2lRZ1VVekNLaUlKV2Y4S0VWcEdFaGpLZEVq?=
 =?utf-8?B?bHlCY2xwQ0J3WnJnaGU3Tjd1UWVjM1NxVzZxVFJkY2x1cjVvNjNaQmc2dFlL?=
 =?utf-8?B?aU4rQlRZbmM2ZW44bmVYT3dJMXpJTmM1SjNEV3ZXdjlCNGNwNk1YTkJvSWlD?=
 =?utf-8?B?MUVieXNOMTNNVmI2U3dSQUhwSDJSZ1pib3lxaUtWRDlnTjZ0RGVNRXJsQTZa?=
 =?utf-8?B?TGJFTmdGUEx3R0RzanZ1bHc4TnphTVV1d1hoQWtaU0NUTEtKRy9YTkcxTUNP?=
 =?utf-8?B?amI3SkpYNklIN2ZnUkhkdXVPRFlLWit2ekRnaXhEVzhzMDUrbk1iT3FkMHVy?=
 =?utf-8?B?MTNQRWNEb292MnhvWU55cFRwWTlGd0JUeDRKRFVJV1kzcmhyNC9kc08zakVz?=
 =?utf-8?B?dlhmKzFrTlFJQmtOaG9hazV3STkwZFVGdFQ2aFc1WXJFTFpyVjJacFFWV2RE?=
 =?utf-8?B?YmtTWEtmNERiTnpOT1dxbEJTUkV6V2QvYldRbDFXbjMzdWEvcDNmUjlicXE1?=
 =?utf-8?B?Z2RWZlFrSmEvZ2psM08zaWRMYlFXWWRwWE1PdHplZXRka0h1MjBkbEFlUS9l?=
 =?utf-8?B?ZUVLV3dIQ0lnWGFjQmVnNGo5TVdYMGxXZlo1Rjdra2JXTzVDRDNYNkdpclpF?=
 =?utf-8?B?MjYwTnQraDhrSlR6KzQ2ME4yanRqY0IzeWhYekVqZ2JUYVBlSEl2RzNFS2Iw?=
 =?utf-8?B?Ri9qTmdGZE85bXlVNU5jVFhJQUxkdHVFemUvSHYzblV3ci9tRGJZU1pKUUpz?=
 =?utf-8?B?MG1hU2VjUXNTajlPV2hObjhQSXZ1UFAyM2FTZnlUc2loejhaNHhzN1FqK2NS?=
 =?utf-8?B?MFNjOGRxcUpMNjJSWmlhUzdlekpIREVocGhkbW9xb3B1L2NnTEVMVndTN0RV?=
 =?utf-8?B?dGxrMll3U2FYci9WcmFWdFY1c3k3Ty9hZm01VXNSOHNRYWViN2pzTmkzR0lO?=
 =?utf-8?B?Z0YvdFg5aDc1UFZDMGRwem9BSnFVSHVSZVlUaGQ3YVUvQk1xampwU0tPVXlu?=
 =?utf-8?B?SzZnNDU3SEc2OTRtZXNMMDIzbGhiL0t1KzAxTlE1RDlmWTFPR1JadTNnWi9x?=
 =?utf-8?B?U1FaNTlUNmg4bWNIL1BkN214SWlBdXlVTVpzWDNoNHRBaDV0QWZqRjZHaVpJ?=
 =?utf-8?B?TFlUTXNURDlFcnVyTm1oNXNJYmI0b3hpRU1ZUUZCeENabHpPMWlZRzI4OUU1?=
 =?utf-8?B?YXF0bFFzMzNodS8wSGJEYk42MEwreUlRakVrTFFpeTlibmF5ZHNMaFI0ZFYx?=
 =?utf-8?B?a2Z3VFJybTlTUHVKYkt2NUN1TngxQXFORndPM0tCbFdaeXUveXNEWm1xeE5y?=
 =?utf-8?B?K0NLaVJhOHFpbmUzQy95UEIwU0JNT2RKQktuTFN3UEFGM2pFWUt1eTJYWE8r?=
 =?utf-8?B?N3RDZ3JLMTMySkRSMXZOVXNYZHpIaGpZdVFmeW9aN3NIQ0hxQUJZRVhDVndK?=
 =?utf-8?B?eUlvbkhvWHNwaFAvQXY0c3RWbmY0Nzk5aks5VTVaM2htbG83di9rMDQ5UnAx?=
 =?utf-8?B?amMrSGZTYXhIdHpuZm1PUWI3VHNMcHQ5UGcyUWk1K1l2bHdMUm9aTWwrdUI3?=
 =?utf-8?B?Z09CNnRoR1lPQS9nQ2p0TktJZTI4cGVBU3JLZFU0cnA0ZUdXSUpsYTlRRmJ1?=
 =?utf-8?B?SlI3SXhYQnZldmJpVXVLSGtYRHMxaHI0a2N1NE11LzdNdUNGeFdmSkVqa3Zo?=
 =?utf-8?Q?e0YkGYluxQvId0CXE4fCuNylE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc359ba6-0b2d-41c8-56b0-08dbd6250959
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 13:11:16.3379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oGkIjbdgYrjU0o1rJgbxZP3LLWYmQW2CzyMuTXWN+bd0SMsM/ns1gvk2557bT4RDDDfYi0Vxn4ZrLtETY/F+DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5760



On 10/26/23 08:44, Junio C Hamano wrote:
> Michael Strawbridge <michael.strawbridge@amd.com> writes:
> 
>> From 67223238d9b1977d20b1286055d7f197e4d746e9 Mon Sep 17 00:00:00 2001
>> From: Michael Strawbridge <michael.strawbridge@amd.com>
>> Date: Wed, 11 Oct 2023 16:13:13 -0400
>> Subject: [PATCH v2] send-email: move validation code below
>>  process_address_list
> 
> Why do these in-body headers to lie about the author date?

Sorry.  They weren't meant to.  I have been amending my local commit
rather than making new ones for every version.  It seems that when
I do that, the author date stays at the first time the commit was
created.  I wasn't aware of that unintended side effect.
> 
> By the way, the in-body header does seem to support the header line
> folding (see the "subject" one here).
