Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D905F502
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 18:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fb1mkj4C"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2072.outbound.protection.outlook.com [40.107.96.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1E0115
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 11:47:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CTfFzLPABc2OOr34OJJlhpN7OTo2madaqipkPzYNuhTYKUuKHB+fU2kVE8XDyvA1H1hYeGiEWABN5lLIQESrWJ6Fw2Vc/KDmkgn2umXBewkALrvu/HkS/WmKVLDfHBCOieqbId1ixC0klouYnPVs/n0s8JL4GuDUHRwVRfCow8j0Cz0Fff2O/LDr7GRF0mYgLYIF4jHa0pSbIsfNOSv2uhGQwssXhVwRA3/VcC6c5v0N4b46TM9Yu3210KFWUzfwhPGK2+J3wRTN3nCsbGGRjVhtCO6bjhCsCA06AA8FyzdqYWjJkpApztIZ+Iw12yIcgamf6K0nNxVhvmZme1GgGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3xfZ08CbP1scokLUc/5dhtlWtGqFUJzg/4vi/pQoUF8=;
 b=CDsZhZ3eI32iWLv21cWFAgiqaYoIouiVMBvDhWPqIN2COqXxIGrIZxxTweOkbIJpd1RIAjch2KILE8oD7+6rthiOCrlKePz2YvIjkmjZ70gemOf82Yevplo0h95RmnF6NwyZOr4QYpjjelFwB1t6C9pT9ey/GOn7iAhs4N2KcBiBUWRpN1Ng27GqzQ3PIs99om40/bbcX9vwsrI5vpBN5nYrB7w/aGKC8LyGK5FeOrUKvsCrRtDpAY6HCUVVOsqOSJ1bYWCsch2q9pJT8ImRLLdBhniPEkBEP9lZcIVg3gYWD0AnjDE1ubEAkykR0YcEQNTqFJ/CdB9JgsgYVdfS9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3xfZ08CbP1scokLUc/5dhtlWtGqFUJzg/4vi/pQoUF8=;
 b=fb1mkj4Cbh1dzywF4Uh2ebnus9XGdMCJNUeBLAhvomLtZBmCeo6gU80am79g882d896Gp+zIwFZj8z+c04iZ5Wx5cMV79e+YJ9Ve8twv4z0QkmdCyDbVR1VdoW3an2b61Y1mdM3posQS9D/m3REhV7v+aZIqEXWR+/FoZFijY/U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4365.namprd12.prod.outlook.com (2603:10b6:806:96::22)
 by CH2PR12MB5017.namprd12.prod.outlook.com (2603:10b6:610:36::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Wed, 25 Oct
 2023 18:47:51 +0000
Received: from SA0PR12MB4365.namprd12.prod.outlook.com
 ([fe80::1b2c:f2cd:1534:b38f]) by SA0PR12MB4365.namprd12.prod.outlook.com
 ([fe80::1b2c:f2cd:1534:b38f%3]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 18:47:51 +0000
Message-ID: <907b2699-5792-4cb0-a727-44e514c2480d@amd.com>
Date: Wed, 25 Oct 2023 14:47:44 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] send-email: move validation code below
 process_address_list
Content-Language: en-US
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
 Git Mailing List <git@vger.kernel.org>
References: <xmqqzg0oiy4s.fsf@gitster.g>
 <20231011224753.GE518221@coredump.intra.peff.net>
 <b4385543-bee0-473b-ab2d-df0d7847ddf3@amd.com>
 <20231020064525.GB1642714@coredump.intra.peff.net>
 <20231020071402.GC1642714@coredump.intra.peff.net>
 <20231020100343.GA2194322@coredump.intra.peff.net>
 <xmqqil71otsa.fsf@gitster.g>
 <20231023185152.GC1537181@coredump.intra.peff.net>
 <393f598e-c7cd-4dc6-a221-9aed7ffcc2b1@amd.com>
 <ee56c4df-e030-45f9-86a9-94fb3540db60@amd.com>
 <20231025065033.GB2094463@coredump.intra.peff.net>
From: Michael Strawbridge <michael.strawbridge@amd.com>
In-Reply-To: <20231025065033.GB2094463@coredump.intra.peff.net>
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
X-MS-Office365-Filtering-Correlation-Id: eee96605-4ab9-4c7c-0a49-08dbd58ae403
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BnKZyxQciC56h/kSRthpyjPUq1OhQZppZenvWUypLL9CKQURhLruwpD4sz6OCsp4pD6nPvUU3J+53b6FNIe8iIPfsaHsLaLHEWsnXtMcorLOOSbCQ6e8Db988VOonsX0nbG8yPulzokEHcn8zXu1ih9OntrqqATwQd/6wn2AyyzKZilyHLNd2zfd3O9FC/tfDb5qHrssL5uXst1AMw6bHPyEwQyiRxxX6dMCYtUv9w4HaLbjkincDPA15jA9orZA1nueIt9oDbrCTdJL9XaV2TRsdWEMLrJ4ZnU2bmoWsneqK8cQzXEcn6g1wEgaC5NRExSt94nC/MCIQQPK/Iw8C6CQCCcLxci2Hre/Bfr+ANYEScMUe3YyNS16BUopKSTFjq1Cda9rMGBkO6GJiU8TbwKtX1r7enkqlN0oRo39v8CV6oslnVJcwpJYi+0xdZPn6Cuib2Yye6TUXiQEQ0dwbacWflrITk6/upDcZPD5soil/XHXLCkG8HyuhqMoGR4rpljgU6rbLkdwZNfEtAYsXgb/i5Xl1up3lkhN3GxIKenI2zMZ3cSbWkDZJt/E6D9pMPsvZ+3GTUuOq/LWQZp1lIXMpM7OMc6aM6Ji0NCSED8YmJt26McRRYH5ou5lFA8q9xcctY1Q+V3Fglpk2ZMjRg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4365.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(346002)(366004)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(31686004)(26005)(38100700002)(2906002)(5660300002)(66946007)(41300700001)(86362001)(44832011)(31696002)(36756003)(4326008)(8936002)(8676002)(6916009)(54906003)(6506007)(478600001)(316002)(66556008)(66476007)(83380400001)(53546011)(2616005)(6486002)(6512007)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHkrVEt0cVV2UnF2cTFWeEdjWnh5U1pTZ0tXYis3ZllSdVFCdXJCbXV3Z2lm?=
 =?utf-8?B?WXRXdVNRbnBTdEVDREFVVXBmUXNnUGNhS3hsOGNJVFhXQVl6Nm5YK2ROMVpM?=
 =?utf-8?B?MmQ4dnQ5UlJRVzQrUkhqN2hMNkY0ZWcwQ3NsUzFTM0V6RkxFRnVzMzkzdldO?=
 =?utf-8?B?V0ZibUp1VVdTMUpFQjlBMjhvMnJITHpYNUdMUitxNEJUWlp6V3d5SWh5dlh4?=
 =?utf-8?B?ZGN6TWRSZzl1cU4vUmxoTGlySHEydGRTUUloVGxMSDJsSndDSnlackZiSlFt?=
 =?utf-8?B?Z2JzRkFYR1MyK09DZDdWTnRqckxYL0g3eWZhOElCYnI0M1hJTURZWGYrN1li?=
 =?utf-8?B?NWtKWldkZHU2NmpsQ1d5ZFpHQ200R3VnOW5FckJ5ODFVenI5cTRZbzdMdU9x?=
 =?utf-8?B?czN2UWIxOEZSejJpam1NRzdpeEhvby8rcmRhWHRFZGNXZDVBTWdxMkVzc1hV?=
 =?utf-8?B?dzZlYjRjT3lqZHYzenN4ZTBYekg5MU5vY3V4TVhkL1VFRXhaU1l1bnlwNFpE?=
 =?utf-8?B?aWgyU0pBdGgwdnVFUW9GVHZIU1lrS2dqV0hqTjJGK2Y3cGJPKzJpVXU4TVF4?=
 =?utf-8?B?aXZRM1ByUVRKQ1JCcG9UNDc2bTN0emI2TDdkdCtaREVZVGZJdTUzcENRVnV2?=
 =?utf-8?B?d0xEVW9DYUpBcWk1SDFXeEdxWlZ2NkhMK090N2c2QXBEd01XYnB6TFdCWTZ4?=
 =?utf-8?B?UUFiT09BWTlnVUdQc1pFMkdaZVBqUzc0aFdYQlI2MDNJRzJmNGoyeVBhaW1a?=
 =?utf-8?B?WWdXT3FqZXNBbWJlc0JlUGlGbUNwcGtuQ3ZuM0ZhMGkySmpEb3VkTy84Yktx?=
 =?utf-8?B?M1BKbUM3aVJYY0VLY1c5N20rRDQ4ZFBaWldsQjlRU2FlV1Z0VjJmcWZCUUgz?=
 =?utf-8?B?eXI1Ulc2R0xjckU3Y01ZU25yN0RsTVZLSFdtWEsrbVBFZzNBZDRYTTVCbVZL?=
 =?utf-8?B?Z2dQZzU0S1ByZTRaMzgwWU5WV0FuOXJVZkI5MlZBNUJNSTNFcFNVaFExZVNu?=
 =?utf-8?B?eEl1dTl1U01zU2c4amZMbldQQVlxdzg3OWxLbE9XQU1JYlJoMXY5Vm1GYUNq?=
 =?utf-8?B?T3VVVWlIM3IvVkQrMlBuY2NzQjFMb0dVQkh6RVY0MDJjb3p4YjhJb1JxcnU3?=
 =?utf-8?B?WEpXeUFVeTBCU2psL2ZSL1kzNUs2S3piQlVMR0ZOdjF6ejRrYmJqeExNQjFi?=
 =?utf-8?B?ZmFpMlpuOXJvSWFiWktKRGlBRmJiZjYySmw1OUJwWmt4dFhBNWtoUmtRUU04?=
 =?utf-8?B?UWlhK0V2ZjZWZXV1WXFUQmtMbWsyY0hVMC8yWjBlNFBEMlRxTGV6TjF0S3A2?=
 =?utf-8?B?VGNiTjhNQngxRXhiQVExYWxRcmNCSFlYTGZCb0J6N29QVWdadm5aMTMwZGFv?=
 =?utf-8?B?cjNSNGFzV2pPa1lzbTd5WjU1VVEwemlQQXVlTFVVZ3Y3bVJoKzhkdTkwaG92?=
 =?utf-8?B?dS9nQWc5ZWRwRFhvZHVlbEx3NXU1US9GSmJKYUQxV2pCR09uYVBYWTBheW53?=
 =?utf-8?B?N2ptYVRRZDN1S1pYc2VYcG1UTVllc0E4cVUwQnlHbDR5bm82QWlseHQrKzNs?=
 =?utf-8?B?VXdCdWw3NHJuZFFxYnJ1ZlQ2NDFNaHV6aEVSL1dNRlBJWkdHN3RjRkY3MWo3?=
 =?utf-8?B?VmV1U2hHTzJzTEN5K0dhTDNISVJmLzNSMXRFdHUzcEhCRlduSmV5ZDlyV1ll?=
 =?utf-8?B?L2JVV21FMjBUT0NSbGF1eXk2aVlyWmRDeENDVmszZ0lBT0ZmTExweEd0a1ZL?=
 =?utf-8?B?RkFFcitvN2hLaUJua1UxTEVKVFBjZnNNcUdVQXFuSVJMWlRhSktJWjl0Tk5p?=
 =?utf-8?B?eUE2cnZNUSthYjc1NysvWWNGYzZST3RCRnRKdWJqL3QxMThPM09KMDVzcUtX?=
 =?utf-8?B?eTlrVFcyOUs4c2RLZTVWajlQODFONjNZQVRPcTczUkFjbXNyV2hnTlhyVFA5?=
 =?utf-8?B?QnhQS2d1Zmh4YVAxTFJmY1hsaHhNTGxsdGVuNTIrWHhYVzAyRFcvbnB0TEI2?=
 =?utf-8?B?WTBDM21lQVh3Skl0Nkk3bFIzY01UWWtHa2tQWnFURlF4bmMrTjhEd0tUS29F?=
 =?utf-8?B?aThneXZZeTk4ZlR5SzJMMEV2L2kwK2ZxN3orS2dZVGcrRHlEVEg2Wjg2VGM1?=
 =?utf-8?Q?GF8VtHJtuk3sE0wvNxvVOPTnt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eee96605-4ab9-4c7c-0a49-08dbd58ae403
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4365.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 18:47:51.3848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wi0KtqUdSZ/AsHE3ouEQpsQkEaEuPbkP/9Q+8TNXB16R9UFvbFA+gAvuP2EM5atQZar6pR70WxxTeawnSVAYTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5017



On 10/25/23 02:50, Jeff King wrote:
> On Tue, Oct 24, 2023 at 04:19:43PM -0400, Michael Strawbridge wrote:
> 
>> Move validation logic below processing of email address lists so that
>> email validation gets the proper email addresses.
>>
>> This fixes email address validation errors when the optional
>> perl module Email::Valid is installed and multiple addresses are passed
>> in on a single to/cc argument like --to=foo@example.com,bar@example.com.
> 
> Is there a test we can include here?
> 
>> @@ -2023,6 +1999,30 @@ sub process_file {
>>  	return 1;
>>  }
>>  
>> +if ($validate) {
> 
> So the new spot is right before we call process_file() on each of the
> input files. It is a little hard to follow because of the number of
> functions defined inline in the middle of the script, but I think that
> is a reasonable spot. It is after we have called process_address_list()
> on to/cc/bcc, which I think fixes the regression. But it is also after
> we sanitize $reply_to, etc, which seems like a good idea.
> 
> But I think putting it down that far is the source of the test failures.
> 
> The culprit seems not to be the call to validate_patch() in the loop you
> moved, but rather pre_process_file(), which was added in your earlier
> a8022c5f7b (send-email: expose header information to git-send-email's
> sendemail-validate hook, 2023-04-19).
> 
> It looks like the issue is the global $message_num variable which is
> incremented by pre_process_file(). On line 1755 (on the current tip of
> master), we set it to 0. And your patch moves the validation across
> there (from line ~799 to ~2023).
> 
> And that's why the extra increments didn't matter when you added the
> calls to pre_process_file() in your earlier patch; they all happened
> before we reset $message_num to 0. But now they happen after.
> 
> To be fair, this is absolutely horrific perl code. There's over a
> thousand lines of function definitions, and then hidden in the middle
> are some global variable assignments!

I agree. Following where things are initialized seems to be especially troublesome.
> 
> So we have a few options, I think:
> 
>   1. Reset $message_num to 0 after validating (maybe we also need
>      to reset $in_reply_to, etc, set at the same time? I didn't check).
>      This feels like a hack.
> 
>   2. Move the validation down, but not so far down. Like maybe right
>      after we set up the @files list with the $compose.final name. This
>      is the smallest diff, but feels like we haven't really made the
>      world a better place.
> 
>   3. Move the $message_num, etc, initialization to right before we call
>      the process_file() loop, which is what expects to use them. Like
>      this (squashed into your patch):
> 
> diff --git a/git-send-email.perl b/git-send-email.perl
> index a898dbc76e..d44db14223 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1730,10 +1730,6 @@ sub send_message {
>  	return 1;
>  }
>  
> -$in_reply_to = $initial_in_reply_to;
> -$references = $initial_in_reply_to || '';
> -$message_num = 0;
> -
>  sub pre_process_file {
>  	my ($t, $quiet) = @_;
>  
> @@ -2023,6 +2019,10 @@ sub process_file {
>  	delete $ENV{GIT_SENDEMAIL_FILE_TOTAL};
>  }
>  
> +$in_reply_to = $initial_in_reply_to;
> +$references = $initial_in_reply_to || '';
> +$message_num = 0;
> +
>  foreach my $t (@files) {
>  	while (!process_file($t)) {
>  		# user edited the file
> 
The above patch was a great place to start.  Thank you!  In order to address
the fact that validation and actually sending the emails should have the same
initial conditions I created a new function to set the variables and call it
instead.
> That seems to make the test failures go away. It is still weird that the
> validation code is calling pre_process_file(), which increments
> $message_num, without us having set it up in any meaningful way. I'm not
> sure if there are bugs lurking there or not. I'm not impressed by the
> general quality of this code, and I'm kind of afraid to keep looking
> deeper.
> 
> -Peff
