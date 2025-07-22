Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011027.outbound.protection.outlook.com [52.103.68.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01FD2C08B6
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 13:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753190794; cv=fail; b=gT0UnIvDrrN217mmapXKw0yY2HtfgIQBsdydNKsXNUfezNkoD91KhdhpJDZUWD/r4XcRl0QJ+yMZY4sMyT+yLVd6g2rGPGm3AswCITnlbcKLmqE+WZtEZh8cQc8qTcFC408sateF6ERoj2zAYooRz1JL8gTl3rUxVtnfdarPa/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753190794; c=relaxed/simple;
	bh=SBm67IJxs02ri8jmaV4Dw7SN30eZZCsqnFdzWIz7yik=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 Content-Type:MIME-Version; b=QQF3i8hCnstqiH2rNzvDvoQzu9YjJQJQ2rVl/6jAwP2NVQC32zKKxlUoLW1Rwg2GttL2xPs3SOZ4mlUivM0lncNDi/i2yt3mDfF9CEUl4/so7pMf2JyevRRE+YgHxxGV9+aIiqhqmlNV09cS/KByXcsiwKqwCa8OVlg1XvPwZOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=OfdtF3Qe; arc=fail smtp.client-ip=52.103.68.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="OfdtF3Qe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=voufVzt+nIeHQKoDkJwbEssttPqb+ObPo1kteat54zbhXkn5nflRYRsqg9WeFodBkwi66ePpV3cWXOJWbt+DH0vmEwffhZc6Kk5Tgvdi6swk2dUiB4hzbk9L2ABwtv1GsThWuW4/ltiOQbeWzHNQt8OJN9V36ug07ezga2btAxYX6EfhpreDpKryiq3+FgPo//9lhQGhddHzwaiFeWXtoHKbWtaDN6wP9AirqhgpQoAhq1EZ+7tOfe+BbYesgMAEYVuQkPhTE1KAEPQzf4ZKCcJ0zvf/YMuTmYxjOV6ni9KyO/OJpHqE/pqsEzkUqlRmnRfhoUbsZCCBbCziXJoHIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SBm67IJxs02ri8jmaV4Dw7SN30eZZCsqnFdzWIz7yik=;
 b=DE8PZV+mGA5tVo9e5j08/iFvqoE3IJ5Vv624ADtAmtYv2fKkYHYGFSkx2d0q1bIC0LtaQJpV0X9+I1OMLZ3eOQnpzSRM03ds3xlyfIVO3pf0BTvy0MwqOC/KWKB234Y51JBuRUdsK0tf/FXKnKrAa2TQfq33uIoDeUlERdeTPSincS2ohq3PIBPKqcQ3PZftNT2qz/You34iOKE0IvzeKRrc+m4s+a944dqkuy7r0pq2UFPdcEW1BpUW8o3bm2XCeMmrnrsDQ5THYVAol4fnKaaNE2VDie8obOYrYtojg5ge+WdMY9b88CnWnc8eaHdniZPyyLYn3YEz219LgpbGyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SBm67IJxs02ri8jmaV4Dw7SN30eZZCsqnFdzWIz7yik=;
 b=OfdtF3QeUT2JtnZ7932jxjZ6vzSRf6aIF9tA+QVtKoTg8JOYR3k/UA8uM6hulk426Qs3ynpaFDUL/Nv5uc77eDV2Q3YaAIq6St72Kx49QQbs8TPyx5+A8fVdL3DXjC99Z5T0+IbKfzmzzMbQhfKoNo5MNgOs8KEaQxF95li7+kBhaHCTudDH9k4oNM+65P8sWgRf9ao9ENext/7zTgIIDsTFlUiG52/ENgdRy8RZ+FAMR6rE9/yhbITgrpymOFaAdo0qq0/3zCQoJngWqw7t3ZUysJ35AmXgPHFuzuclUvO07wnOP/4PIqGx7R8ht4Q0s55R2N5mZmt22yesoYwN3w==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PPF3AC99FB25.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c04:1::1a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 13:26:27 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%7]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 13:26:26 +0000
Date: Tue, 22 Jul 2025 18:56:21 +0530
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>,
 Eric Sunshine <sunshine@sunshineco.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Ben Knoble <ben.knoble@gmail.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_send-email=3A_add_ability_to_s?=
 =?US-ASCII?Q?end_a_copy_of_sent_emails_to_an_IMAP_folder?=
User-Agent: Thunderbird for Android
In-Reply-To: <xmqqtt34uznu.fsf@gitster.g>
References: <08528f201acc1038ebc5861321395d17516094fd.1753003385.git.gargaditya08@live.com> <87a890182591c9c21061e85834fc99a766252611.1753092192.git.gargaditya08@live.com> <xmqqpldtxsp7.fsf@gitster.g> <PN3PR01MB95976A7BE0F9A54E836FA2F5B85CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM> <xmqq4iv4x15e.fsf@gitster.g> <PN3PR01MB9597B8D3D84D9F7660F15E94B85CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM> <xmqqtt34uznu.fsf@gitster.g>
Message-ID:
 <PN3PR01MB9597E6071DC91F5256930AF1B85CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MA5PR01CA0025.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:178::13) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <B926600C-3B04-47F9-BEF6-BE310792F394@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN3PPF3AC99FB25:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c8ae318-bad1-4b4c-6247-08ddc9235c0d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|6090799003|5072599009|15080799012|440099028|40105399003|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c294OSs2elU1emx2bzIxZHlPcGVlcThrTEdWN2tYNnZFZWxDWUl4MmVXdnhL?=
 =?utf-8?B?TnVjRWdyb2xBK3czR0VLTTAxallJWDRtZmh3Q3o4Nm1kVlRnRnFHbUptQmcv?=
 =?utf-8?B?YW1hYlYwa2pOdmNndE1ic280Y3B3UGFLSDI3eTd1S1l4dktxRVljbjFLL3hn?=
 =?utf-8?B?aFRzRzdJTjE0V2lYckh3WDdGY3ZBd2tMRnd5WWxWTDFNeG1VMUhoeSs1MXFs?=
 =?utf-8?B?MXRFd1d1ZkVpNVN6V3I4RnBHMllkMENiWCt3SEFoZ210RVRTVHhvSFFGWnNE?=
 =?utf-8?B?ajBxcEE5MGJXWVQxVjcxdUhtMEVRZjNqN2tuemlTTHdab0JWcFV0WU9xaEZo?=
 =?utf-8?B?V2RTRjg2b0FJQ0plRmpISFFQVGxrUXdsZEozb1F2SzlHdmFNRlVjRS9odHZE?=
 =?utf-8?B?UlNBMTVhcVV3Uk5PZmZyWHVYYWoxNE85UktKSVg5cVQ5MzZrZ3Z0WHdoZWlZ?=
 =?utf-8?B?YkVETGVZa3Mxckt6aE1vbENhUHpQWWs4RWZHT2ZLNEhmTldDZmlackZLcUM1?=
 =?utf-8?B?Rjl5SGxVMmdIak15OU41ZGd0eXo1M2V4SHZmVUxyak5yY29XZjVGQlFpRjJQ?=
 =?utf-8?B?eHhDVmI5M0RJdjI1OWdWUEJ6MXB4L3FQT2doaWpDTGYvR1JnS3RwdEdmOXBt?=
 =?utf-8?B?U2JPT0JlcjFnTkgzc3BsVmFNaThNZUxEbTQxK003dGk2dHBMck1GZG0ycUFE?=
 =?utf-8?B?OW9Cb1g5WjQrejFWWEJ3ZHRUNkw0K1BLUFFYYjFFVTRCWitWODZadWhzZlFE?=
 =?utf-8?B?MFpDeHlYbmpTY1RuSVlNUjlQSU1PS2M2OC9sclpUdEwvR1NvQlkwMm1BRmhO?=
 =?utf-8?B?SVFKUk1UNmd5SjdHbi9oRGdlV3J2WjBHNW1rZlY4UTVPVUc1MEk5bU14VnZJ?=
 =?utf-8?B?OWJwTUx5RUZNdzh3dkhEZGkxWmw3SWdad2UvN1BhcGdnRVUzS3ZWR2FOUWh3?=
 =?utf-8?B?VzV6NEpYQU1hZWZYTWErLzloUnd6R09EK1pWN1ljZTlBdC9GTk5jVllyWnUw?=
 =?utf-8?B?U0VaQ2RTQllWMlZJaC9PRnVtS2hXWDZzYlhzZ3BZZGdRdGZLTTRpNmtlQ2VC?=
 =?utf-8?B?K091RlR4NWtjWkdSaUdpT0YzZlVzRWE0MXJqaUszL29DR0U1Q1N2bUlhYVcw?=
 =?utf-8?B?KzBKY3F2dG5idTR6OEVXb2xWU2tBTXlMVnlkb2FUeVhTWCs3RE5ZUk1HVGI2?=
 =?utf-8?B?QURPRDk2SVIxcVhPRzEzd3hUV01rZ3JiZTlNbXp2RG1yY1IrTDUyRUJrQVFh?=
 =?utf-8?B?RzQzVUxNazhpNyt4RERsWXBtVFVLR3BHK09SRWt1Y0Q5TWhsZjNYNnBsTkJ3?=
 =?utf-8?B?NUxxQWhWM0hReWVLSGgvbnRFZ0FXaEZwMkhpeUdxYWFzR3dtNnY4c3RjS3Q3?=
 =?utf-8?B?K3pORElqVGt4Y3JObjEzSEIwbjY1dWJvNHJaeHhLc2NsZjcxdmRiaXVyM0pz?=
 =?utf-8?B?RnEzRDBJTzA4OEVxd24yWVRuNDdTcGRvVzZaNi9BPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHhLeTV0aDZUZmQ0U1VuQmZBSG5lTmJFaVJ6OWpSdjdiNitXc2xMUmM3cWVs?=
 =?utf-8?B?RGFtdmQwTFJHSGpoQ2xqODBiSUpWQkV2MlplY1FRbmp4TTJOU2IxWDhIL0wr?=
 =?utf-8?B?RUVCMFdKRGxoaHJiNVdqSzFHK3M0dUFnbHNYcmloYlVVZWVuWDRlMGtPRWtD?=
 =?utf-8?B?R1dpdE9jL0lCY05yVWQ1QVNodkdJNjFmS1VEb21lYVcrWVY0eUh2UlV3SU84?=
 =?utf-8?B?VGVJZjNZTWwvSjdUT1pWTjF5ZWxRM2pmc21IaTYrQTg3U1hvWWxwbHE2Z3Jr?=
 =?utf-8?B?dkFzc1dlOUZlZ3YrS00wMHZjbjlVQklxekZtallhSWdhUmNRU0U0Zm04Qy9w?=
 =?utf-8?B?dzVnVENTUDRNVk4zMUg5SHFZTlZzNUdXT0Z0Mm5oTEQ1MUxKSlhhZmpieTdR?=
 =?utf-8?B?WDk4MFVRa1MybGNJZkRGelRZQ0l6RmhEWFNwUlIxYndaUGR3a0N6bFNjRVQ4?=
 =?utf-8?B?TGVwZk85eXByd0ZLQUFoSVpyTWluUE5TU0NQQ2hUNXNtMmRKOTVoeWF3NHlT?=
 =?utf-8?B?VDdpT0ZIdXNtTzd1RUFjTk1hakJzWGk0L2UvY2NaNXFJVHE2cWx5cmQ2U0dL?=
 =?utf-8?B?S0R5cFNmZzQrZEJtQjl6dGMxelpYMDNaT0l0ak1PRnJTeXlHQkMzdlU5dFFv?=
 =?utf-8?B?OHo2bVB0SzFtUHJjU282U2hQRHUycjFqWkpSb3V6TGROTmR3djNuOGF4VEFH?=
 =?utf-8?B?TVZzWkMrWGVINm5vd1ZXWE5zUGw0WXo2QzJ1RStEN3RuUnZONzdkNXBkcytO?=
 =?utf-8?B?QlAwOGtzdmFXRkZ6b2x1RkNQWCtEMHZyNGNsVSt1STFmU2tYSnhmL0lNV3JH?=
 =?utf-8?B?UGtaN1MyOEU2aFNTeDd2anh6K2owb216RUQzVkxtdzB1RjZORmFhWVF6QTF3?=
 =?utf-8?B?VHhSdmZxSVpQdVFqQ2JrNHllYS96am5RdHF6NmNuMi96S3FkQzhLQmd4a2RS?=
 =?utf-8?B?Z2hXZ3NXcVJESDBRTURlRUQ5VDdGRFlLcEMySlJCTHhzSUxxS1FDbmwyMTZs?=
 =?utf-8?B?VUcvd013bXNUblhtN2o2ZFFNQ2V4WVJ1MW44L1pVOGFFRmsrMDg4RThpTlE0?=
 =?utf-8?B?YWpMNTF3bmRjWUhBalZKcFJjd2lXVUZiYmJ6azlKcnBhRkdIamNNTjBHTlFr?=
 =?utf-8?B?RkFPQ3BUZjVFOE8za1ZWYXJITnYybUE4UTlpZXpKRXdpcnBiTVE3ZHhYQjRm?=
 =?utf-8?B?SGJFMWtGQXZzYjBhQWR1bk1nQUxCQUxvQzBUaktUSTJzU3JOMk9oUll3UEFx?=
 =?utf-8?B?Q1dTdjZrMGp2TUgxWThOdGFMTXhha1ZHNjdGamJsRyttM3ZCbm9IWFd1V1F3?=
 =?utf-8?B?b3VXQkZmMHJKL0U3V050QUtqaWx0MXZqeWIzUUdaTzVsRmVBcFlFSDJUcnRn?=
 =?utf-8?B?TnRmaENiTllqM3NoK1hsaXowZTlUTytoZDUzRlJsSE15cFlPZUdpWUpKL0hG?=
 =?utf-8?B?VzFma3FIQ3BTbGltUTZEVFlRTnJHQ3d6alFmZFArSmlyOTFPSzF3TkcxOFVT?=
 =?utf-8?B?VlJMNE5BZ0lVeGhxa1FYMkZvMlg4R2JRRzljTjcwTGw3WEtsdlAxaUdJOVRw?=
 =?utf-8?B?Ukx4bGwrYVp6Z3NwN1Z2MjFkSWM5MFdxV0ZKOGhzVkhERDBSMGdJUXJKZGhU?=
 =?utf-8?B?c1R5bE9sUlVER1JIc1VNY3JhTlNrSHA2bEhnWGRwdDYvRlZnTHpITGtBbS9O?=
 =?utf-8?B?cGY3UFQ4dHplejhsYXNJekpSUEZscVprVmhCQk9VMWdxTGNtR1RHbVUyWUxS?=
 =?utf-8?Q?IyDTxlfzM9PBjSJsmc=3D?=
X-OriginatorOrg: sct-15-20-8769-5-msonline-outlook-acae4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c8ae318-bad1-4b4c-6247-08ddc9235c0d
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 13:26:26.6844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PPF3AC99FB25



On 22 July 2025 6:54:05=E2=80=AFpm IST, Junio C Hamano <gitster@pobox.com> =
wrote:
>Aditya Garg <gargaditya08@live.com> writes:
>
>> I'll rename it to imap-sent-folder, but the name looks more like
>> it is only for "Sent" folder, and no other folder can be used. For
>> example I like to keep a copy of the emails I send to git mailing
>> list in a seperate 'git' folder in my mailbox. I can set the
>> folder name as git, and thus have a copy saved there. What do you
>> think about that?
>
>Sorry, I am puzzled.
>
>The reason why the option "--imap-sent-folder=3D<you-name-that-thing>"
>takes a value, and not a "--[no-]imap-keep-copy-in-the-Sent-folder"
>Boolean, is exactly because you want to give whatever name you want
>it to use, so I am not sure why you are even asking that question.

I asked that question because --imap-sent-folder gives user an intuition to=
 type in the name of the Sent folder rather than any folder. Anyways, I am =
fine with any name.
