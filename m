Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B5427EF8
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 18:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="z6QTSx9s"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2058.outbound.protection.outlook.com [40.107.96.58])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97149133
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 11:48:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XBm3KcHYH4/ILmUmYKBgOW2N5SdHpRyn2/yQ67WyAEseX+VWxSkf7b5JhmI6o+8L9pLHbdzyB/mYE8lXRbz7KpiUbdnlEc65x53BZkDccr7tak8HxcMxXj58WpYxl8p2GpHCWucvjb5yPEwMdUmwLpDMmKkDoSy5t/4FyD0g1KoqCLB7e20X2QTr6I3iEXQ+t00otuFgVxMfm5enua4mcSdbS/PDz8mFL+iG5jg+2TeTEk6+4wW2eCMeOCBsm4/t7vXachlPMCIxZnP7nQEKvRKmY4/6Dd9M3pM3VFVVKdWWacYnjzXNtjOmd9vqNZy5oofS0biwbELUZq72vZ6KzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T+SatqYnlUQwX7xvrg6e49J/JjBIXXquHj1HQktkFXo=;
 b=LJ2vn76RUF8T/AIffmJGKbdGnoiI38F3w2LUfSz6GpVB4r71a0MO34BxAaX+eplTrJOS0b/g7Q6yZhXiREzJG7X+CkSqUvWvBoqiDd4tkb9uNDiLPPtJFpG6m4n2nhTWA/0EITAZS8TnIcglMV6hWIhULq9knjR5HVCc7tVyZ5dYaCUkRXoCN2KTBSzzpjqVvSAGZtS9ct0x2VKL7QXtTDwz6tL3kBWNtZ5KJm1TKvFFhZvhBZfWC7FEI+XKV2k1qwmVqWUgcWGp3zZ1lD6Z9hHd4dfvtBJz4vcruKNzTxg8R7FPQF3jC1+95BCR4wgycDzyc4xi7PAj5+bBaa0xNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+SatqYnlUQwX7xvrg6e49J/JjBIXXquHj1HQktkFXo=;
 b=z6QTSx9szSlB1k/YdcBLb7Dwgcxwq+Z5vsUjticuIL4Ifajvlzc5LqvM3fMocph+/zCC0uv6yTzgabNMMIBrBeqZvwFztzFEZq271rbUrYnhamr4WE4qsMnzLz54Ps8xe+pYonpk9KdF6zHtp97ELKcsnEFyBVl0v6OltshbA3c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4365.namprd12.prod.outlook.com (2603:10b6:806:96::22)
 by CH2PR12MB5017.namprd12.prod.outlook.com (2603:10b6:610:36::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Wed, 25 Oct
 2023 18:48:46 +0000
Received: from SA0PR12MB4365.namprd12.prod.outlook.com
 ([fe80::1b2c:f2cd:1534:b38f]) by SA0PR12MB4365.namprd12.prod.outlook.com
 ([fe80::1b2c:f2cd:1534:b38f%3]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 18:48:46 +0000
Message-ID: <0bea6645-b21f-499d-bfe0-dc6ac56814fa@amd.com>
Date: Wed, 25 Oct 2023 14:48:45 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] send-email: move validation code below
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
 <xmqqil6v3cgq.fsf@gitster.g>
From: Michael Strawbridge <michael.strawbridge@amd.com>
In-Reply-To: <xmqqil6v3cgq.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR07CA0025.namprd07.prod.outlook.com
 (2603:10b6:408:141::28) To SA0PR12MB4365.namprd12.prod.outlook.com
 (2603:10b6:806:96::22)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4365:EE_|CH2PR12MB5017:EE_
X-MS-Office365-Filtering-Correlation-Id: 3558bdff-6d1a-4d60-7101-08dbd58b04d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BrIsqgXCIJ4Ehk2xUsEnc8q4PLM3P1wFyPbVlxeCA1ekxyT7ykiWz+Ot8emf8vajWnWbz9fe+/yL0kaON5OdMsl3xLdYIgZnk/0ag8oaXCN+Xw8mvw5xgE49PaIWs+N6f1sh6ebGdJcbZCD7rR89pMQl7w0VmTRuOWl4aCSrxBhDzWJ18EFFkoskCoVI+wtYv0TLL6eNZJUJHbXqP6gCMVmq3lYCK+LWOH9R1pvTx+BEf4/tBVyajDxep2PJQ31K444Noaj4QJCo938lcvxocWWrtNHZ9186xLxkGactCqeJcrEB4BbhC6/OM3o7mWzgHWGjkGOshJwh5E91zexIkPBWIypaTK+uhKxqIkYmtBDY1ddkq4qNtjObfeAP37yW1x31bqz9+hLFBS5McrBkQiueK6S9w5CG9o0sVF4Iw9xHCi+AebUgrR/oNiUv7NHVdfER+6Ud3b99buh7YT185WWQIGoSifpmHdCD+RrB4s1mjZGDDFhawADgr/tgbdM4c7HUEj4iMIfzkJpDISXZ67H9bSerCHdru8HD1YwjkY4HpL5FTr5FTGegkN7pdl+fVi8T6eHpDn1Myj/X3FUNBEBk8tLycur9iyC+m3sJH/eCy0TibAm9QUBVRydLZZspizng4vN7aBdLHV/OIXczwA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4365.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(346002)(366004)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(31686004)(26005)(38100700002)(2906002)(5660300002)(4744005)(66946007)(41300700001)(86362001)(44832011)(31696002)(36756003)(4326008)(8936002)(8676002)(6916009)(54906003)(6506007)(478600001)(316002)(66556008)(66476007)(83380400001)(53546011)(2616005)(6486002)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0RNK1VNcmhSTEdKNEZ0U0tUdGVYa3RDNDhiTmZlVzlLYjMyeDNtSUgrbmpZ?=
 =?utf-8?B?UXZQVTNhems3YnN2TGNTRkZWcTBhYmt4UEllYWNkL29XZ0Q1NjIxWHpvZGxM?=
 =?utf-8?B?VTZwLytoUk05c1p4ZFZoRlY2bEhmekdudFgxbjdGRW9IclE4Uk5zVzQxR1BN?=
 =?utf-8?B?YkxHTVpLeFlHa0tLMEdPUTFTZ2xjQ3FkNWVBYzVyZkFPRzBPazhHaHZvdkk4?=
 =?utf-8?B?aC8wdnhUK2dhZ1B3WVBEYTVxcFVuUDF4alFldUZTTHU1b3VENjFoU0txeVB4?=
 =?utf-8?B?T0FGTzFnV01kOW1KM2RkRW5tTysxcWdCRXBIanJRdnFFMk5iaWVIUHJGYzQy?=
 =?utf-8?B?WnZKRWUwM3BBcHJkaGVYRXVmUEM0OGFMUUg2ZzZrYi8xL2Y5WUJoMWpScER5?=
 =?utf-8?B?V09lWnVQZlcwWHF4WlMyd2sxWWthaHBqT0d5QmtIakJ3cUI3blFUTkNScHg3?=
 =?utf-8?B?T0g0L09JWGZSMWpOb0s1NlBDbitaMVpzNnlHbHdPMThkWjVmRHdzcHArT1Ex?=
 =?utf-8?B?SThNWTNTbjZTdE1PVWdyajNFbld0NU1Gd1luUktvRjVkOWMxQ2lOZk4rMFJo?=
 =?utf-8?B?NTRZdjFnMFoxYjNIN005NUxqWFdKNHQwSUdLWDZ0ckZqa05ZYmN5MWtJSk5y?=
 =?utf-8?B?UkpXYm53VnJhZXpOMTVkWERoYmF5bWNPQU5RZFhueTNPcG92bmdnRi8vODkw?=
 =?utf-8?B?Um1vb2p6Z2c0cWZQTmYxK0QxOUkwVEtubnRrdjBZSFNkTHpWN1N5UUNvSDRP?=
 =?utf-8?B?andmU2Jhd3I4Y3NXcTZrbWRGNUlrQVd2SVhpYUVvOFYyNk1lTldlVk42U1dW?=
 =?utf-8?B?M3RZVnFmY3VybC96Z01wZ1EyeGE1R1NxUGJrQXg4Z0hZOHBNa0ZhUWlWWEtN?=
 =?utf-8?B?OVppdEpXS25XQ1N2M0ZoLzVLWlN4OEhJTjF3c3lybkpsdFJPY3lQU0tMZUtr?=
 =?utf-8?B?R0VtRHQvMHpOQ29Cc0ZUS0IzRXc1Z3dxbjJYK3VsVjh1dEF3ZlMrTzg2Y29t?=
 =?utf-8?B?ZXhuUzl1NHErNUZkQzJad0N1bE9jMlVQNDVxM2hHakZDbjJrTDZaK3A0bHM0?=
 =?utf-8?B?b0w0M3l3bXZPWDZmK0lPTUkyY1RRU2dFcUQ1RDVtaTBvN0p4VE5VaE5hdE80?=
 =?utf-8?B?cjBmWW5QQ2t4U24yUGtzOVFOaWNGcm1jUlFIT1RIVmxrN2RqQzVLN1lUMFZW?=
 =?utf-8?B?VERMVkJDbDdnQ2x3eEhicHEyR0RYMDUxNE5JTHI5TE5PQ0k4c2EycHZnTUdk?=
 =?utf-8?B?QUprdTlTT3pZZFEzWDFpQWpITFBDV1lpSGp4MlBaQURZdExlR1pPaVloVXhL?=
 =?utf-8?B?S2ZuT21QSnNSTmJpWnhiZWxEb2pIejhqOVZzSUhwZUdlRVd6ZjFIeE55YTI5?=
 =?utf-8?B?TlFVKzFrdG5JSU9IeDRTeE55cEMyeHBlYzVIWm13V0ZTYnVvMmNDZ2RPNFpY?=
 =?utf-8?B?RWt1cWY1RVQvTzhlZGdzK2dYTW5XTmh6REdWajdWV0ZKRStlSVRDZXhYRllS?=
 =?utf-8?B?bjFPL201N3RxNURXYm1icXdzWnBONlJxaXZlcURjcFBvSlpTRWk3VkwvRmo4?=
 =?utf-8?B?dkZvTU1KRWZSWUZ6Qy9xem5ucitUb2swMnczS2V4UFhpN3hGcE9IcCtzK0Y2?=
 =?utf-8?B?alZHNU8rbW9JOTg0SU83K2Rlb1A4ajdSalRNSytrdEJVTkZUM1gwbjN6SFBI?=
 =?utf-8?B?QzZRUGhxcmdyZ1c5VzRMMm5nMGZyUkN2V09GMHFVT0laQU16c0lvZGFVRmJk?=
 =?utf-8?B?N2R1eTUrbzRLVTkrQ01RL2EySXdGQlcwR3g2aHdiempzL2svNHFBRkVtK3Qz?=
 =?utf-8?B?UTNZTlpxSTZFZ1VBZ2FmVzU1cEZmQkZjS1ZQcnpqQWM3aUlPWmtSRmFsTlVP?=
 =?utf-8?B?UFNMN1dYWnowekQ0aWFaekY4UUxSTlEzYTM0a1hRSEU2WXBNUjAvVjF2SlBW?=
 =?utf-8?B?Ykx5aWttN3lNc3JXdWYzeE1JVjhORmdBMWhRcDFEWXpkbGZUelk2TVVWaGI3?=
 =?utf-8?B?U1dJZldEbmpUa0thVlc2anJ0K3FXcHpLZWFHdWZWTXZuVnB3R3JVNFE1bi9B?=
 =?utf-8?B?MVVFSkNmT2ZraE41cDFkeWEwZEg4ZzN3b2hwRjJUbGJvb0tNK2lPblpGczZh?=
 =?utf-8?Q?I3q/+G/a3pxqpadenmpM8bVLE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3558bdff-6d1a-4d60-7101-08dbd58b04d5
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4365.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 18:48:46.2581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rRrIch92ZGoTgjTJPBhhnNxGZ2q7cTgncuRdOnD4FALeIakMZuq2223xMapDA8C0JqMLHw5Kjodvmv2erN14kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5017



On 10/24/23 18:03, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Michael Strawbridge <michael.strawbridge@amd.com> writes:
>>
>>> Subject: [PATCH] send-email: move validation code below process_address_list
>>>
>>> Move validation logic below processing of email address lists so that
>>> email validation gets the proper email addresses.
>>
>> Hmph, without this patch, the tip of 'seen' passes t9001 on my box,
>> but with it, it claims that it failed 58, 87, and 89.
> 
> FWIW, when this patch is used with 'master' (not 'seen'), t9001
> claims the same three tests failed.  The way #58 fails seems to be
> identical to the way 'seen' with this patch failed, shown in the
> message I am responding to.

I'm sorry to have wasted your time with patch 1. I had done the other manual
tests but ended up forgetting the automated ones.
