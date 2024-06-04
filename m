Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B69A12DDAF
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 22:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717540141; cv=fail; b=BDhuNtrFCB1RDrbVjoTOrmFhlIeXVORGDo8gdoQ/6ObhsLWLhweagL/ymVpjczHbriwXgDZPo2OxRY5g10/MXUp/ex9bbcKIwHXs6zFaAu0PCIRWxCJqtHnXPREt9lPVyQ6vUhcOJTBiFQXJOjTg6K5HIzbFje0NYbBtn4JhUHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717540141; c=relaxed/simple;
	bh=8wqLfR2xYuZAskIh7tSoGl9iVE0nZnbMQIpcySrQFTQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=M/vG9oGgQMvn0kwAXh1RrkviEISkPXQO/J187kK+pqLKjnKCnyH1uoZRuNSxgk/jpcg4/bAzrDd3BtpE0Z+1qCQvqRAy1yIUqsi1a3BJyqHoGsGauJwp0PCecMwDSwBdlg6XCskKxq4U36KotubGkRQ3+TigUN0vhItTlk/hQvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SxVKkK/w; arc=fail smtp.client-ip=40.107.237.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SxVKkK/w"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VIY20PujW4ZRcUW/ucJubsW1HFTEFqiNOqrSktiaALztx+o6B/87i9TLwBEdGYfawqn3CoHg6Ai/NjDk76ucqAhDcxupcM/DH1/Ec+FCcsOvRBrnOiABFsfig46yzL0suqZap2UKK+S/hUDaWxrUvefvl3u3Dv/T9UjYGeR+/IzSixlC8A75vMAKf/CIYA/MsUrq+AgH0k6fLzBeP+gm6LynSsLp6dGhYFcJaPXse5gaAudNhMrU/EKn+r4ScQeZxDrnIMQe028F5caf5WySSZE7u5BYfsDkuRChBr3pZWFlGM0YFBRBnbbZtd0Ez37ENFPmiQZ+5UwDUuAfQ9+rpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LZoh+OOnGWGT3ENmp35DArGn3pvHJXMv5B8WaAB0GNA=;
 b=jO5ckTEwGOg+eBUiEC2bkVUVKE+ZT9e20lbcxfae77qUpSdIGCkTo6edTTr8ZxNj4PupBALSvTtPBYPMXSgb+did0zNR+z9Y38IBFZiE6rkG4FGDKCdT+AObMrbGsKfPoHuuxHBv0W57hEwto9PrG/OPedTJlY6QsEWniBBYfdonODNr8RZYOtwGAwqKn5dMnG041ysQAFERFOh8vy1jokf0SNGiPGgmb/7Gzy11fOm3ok8G/9x1mxVoBHecxRlwKj3KrscD9zWT444q8OU9DVK6IOLEPgnVyObRBB8JaPSgRM7sSSrKoKKBqw6mDFhUrpwWtHVeGp6bcjtrsjKqQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZoh+OOnGWGT3ENmp35DArGn3pvHJXMv5B8WaAB0GNA=;
 b=SxVKkK/wVqZGszcNmJca6APPkLC8ncvuGXOVhA8lPelCXxOqyolGJ7LGV0MSiuWKr6K/4oMMsiMe/b5KzwXj+RrpI/CE885sezc8rRpD6qmiVRrERf7ZhxJnhhCCGA8eDyXkjEjqUBpYiy0wnK4hosAzBXjI1Q0j8hxn1vpRkBQ9hdGOmb9JKLEPelE0GW9NH2Lz1YcXaeScnBKkbKUT06rWOt1UjKfM6RJLU9VSgZHORn3sKqmRugi3SC7U6xqUq0e2lZTDtcvwjIM9ZwprPpBvR+RY9HTpyClYuwgsJB88xOqpzOhs91zy8z103k3uEU/5NhTlZ48GnrAEQSZZjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB8775.namprd12.prod.outlook.com (2603:10b6:510:28e::19)
 by SA1PR12MB7409.namprd12.prod.outlook.com (2603:10b6:806:29c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Tue, 4 Jun
 2024 22:28:54 +0000
Received: from PH0PR12MB8775.namprd12.prod.outlook.com
 ([fe80::bce1:cfa8:f5cc:dcfe]) by PH0PR12MB8775.namprd12.prod.outlook.com
 ([fe80::bce1:cfa8:f5cc:dcfe%7]) with mapi id 15.20.7611.016; Tue, 4 Jun 2024
 22:28:54 +0000
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Aaron Plattner <aplattner@nvidia.com>
Cc: Junio C Hamano <gitster@pobox.com>,  git@vger.kernel.org
Subject: Re: [PATCH v2] credential: clear expired c->credential, unify
 secret clearing
In-Reply-To: <4521d5ab-c0e8-44d5-90aa-72555681219f@nvidia.com> (Aaron
	Plattner's message of "Tue, 4 Jun 2024 15:19:14 -0700")
References: <20240604192929.3252626-1-aplattner@nvidia.com>
	<xmqqo78gtldz.fsf@gitster.g>
	<4521d5ab-c0e8-44d5-90aa-72555681219f@nvidia.com>
Date: Tue, 04 Jun 2024 15:28:53 -0700
Message-ID: <87y17kbavu.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0041.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::16) To PH0PR12MB8775.namprd12.prod.outlook.com
 (2603:10b6:510:28e::19)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB8775:EE_|SA1PR12MB7409:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ff1efe5-fba9-496d-330b-08dc84e5b7cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8L+n1o5k7GjZ6X+DEVR+GiOx7e/HI8o8Nh3JpiklgDT386SpEt/Zhrv5s+5u?=
 =?us-ascii?Q?XjhRTJlxFrCCyvlKP6Mm6OgtQcdHbve5rxGzbbgsvjp+cW35uzVF73JvBtj+?=
 =?us-ascii?Q?ZCJ2r8q6ZFtjQr/UidPMVFtW+UdK2FmPMx+kkpmdBA5KMXUjfFYWJs1QQUPn?=
 =?us-ascii?Q?/dnilvqQRGPMp2qLciIUGOCDVXwPxai07WvdWEt/PpeHc9xZ2CZX48AU+Zvy?=
 =?us-ascii?Q?VDj5qz5qhE3Bpb3ZWoJZfAEm+tIDvDN0T2X+HkYMaru405V6cTVIwJfEnZw+?=
 =?us-ascii?Q?JNBxGOvAa+cwHXAn/Pr8XLjM6SgGF2+uXctxD9xFjR9iMgXX/Z5Yxgy0o63K?=
 =?us-ascii?Q?7avIgN2rRBUvHQ6JPoqwHgh06PIbFG+38NpUDPr422h4cPeGDPuZUhpgKLgY?=
 =?us-ascii?Q?YJM5jvp1UMYXxDu6XH0YCoZfLa59KfiE6ze69hu6qEnLiiOJrvcbzbw9ERgs?=
 =?us-ascii?Q?vhLGIJobru2PxXrlTpY5orYWtv8jIuZRJLGEqi4R+sE8BOu+Rn7MpBTUJJ62?=
 =?us-ascii?Q?T5XaaPg64/IzLI8ClcEJxb0RfP4kN+vlrpWTI8N1lEnG4G3Wn1d9ZsiPm06S?=
 =?us-ascii?Q?KK66HIzJvs+kHTFx5fncPBq7r6CD76QeTYyPxidF7Bel8hzKxBE9TrmjWst+?=
 =?us-ascii?Q?7R4oNr6jhH3h2bU7FTTCfMrkrVhs6Wsy8uJZj1PFl0u+UPrMzoDK70rmkdCp?=
 =?us-ascii?Q?5Cpgy40lX6VnsQaQ1uPNT1x26gVHBW//yrLhV1U3gzI+m6FcPzgegDwpKOIS?=
 =?us-ascii?Q?2noD2K4a2dmqexphfR6/aIVEjnYGKSmdy+FUBbQH8MOftJs15ugl5JJ+QVqc?=
 =?us-ascii?Q?l3f6Uw36dABdxVqt+QzYxUbAqrYAUPGNnfC3gdddU5cy1YpB9565SxOHd4Ye?=
 =?us-ascii?Q?S3aLY5FgkaNhbxgKqxYQlnXXhs8vtiujojGDBt+eyLV8mBwonKgeR+9xnozZ?=
 =?us-ascii?Q?AtXCVZbh+jO/AOVGXu+9nu7gf+TpSP60+lg49NhGcrxs3Q9O44p8ZqkNdcRo?=
 =?us-ascii?Q?bB+OD9V5I0pYjqEMNmSk7GTrYZ1lzrVHlmE2JDBqG7egOcGrtrOuKL6/YFZS?=
 =?us-ascii?Q?avz7nHQnTCpTCOCz8VqJ22dHeu03oZTYHScWsMFhO8mQf0prDJ/qwjPy++ep?=
 =?us-ascii?Q?d84pVaVFfpnzxoR29BG8kkVWvnRqmZ7tGcb6pu7A/Ns/9bHPuuhJdyFTsU1b?=
 =?us-ascii?Q?JxueWykwz5o67VjCzB11ZbvsJHFICpyDukE0Q2wo7Xwx7Qxi+Y8a9u8ay7yz?=
 =?us-ascii?Q?6eYmNqAK9N3Z8WdkLydbb0jJmSNJ/qnMSTGRxoacbA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB8775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q46GCotpTHlsj5C1WAst9AxRTCsgjnilLM49O0m8qN90V+ILH1BYbielqp0L?=
 =?us-ascii?Q?sGDc4qEhAzLOzRdN36kvghRyIurAsU1H1POq3HJgxuCPpI9Mk5A8vRyj+ahH?=
 =?us-ascii?Q?E7psWQxI12qFOHi80t5iHb4xgMAUsl8DtIilKSY8p7CnNzQNx3AdG8nRGoOu?=
 =?us-ascii?Q?kqXf5HO8s+WutlZde6b9RAYb7A5HhrUzjFyiXTMsrGcmICRAdL1wF8Ex0qdy?=
 =?us-ascii?Q?uG/5ntGXduP/aNyHQARsOyUee+ANUwPhMkGdCZwz94dJf0JGLjLGAipz0zS2?=
 =?us-ascii?Q?QJXGz0AHSw76Jrsn/yoZTOpbvaiq5Un7msptomK1hthqkET6pS12vn+LcAEG?=
 =?us-ascii?Q?qYcd4EOUbkT2uRBfFb0HZTyHFMd8ExPCYYpO3QpxqB87w8jm7nVzVk3qSjlG?=
 =?us-ascii?Q?ExPjjS4SZqF/9WhXn3BF0eMeW5/ZXpv3OnYdBa6Q2PNxvBqguf4etM2nJLCu?=
 =?us-ascii?Q?X/f7A3MiukwGolKS+dwj6WzX0dg9QF+7bXt7uKSDSOXi+P+O9Dy+gJ3V8pk5?=
 =?us-ascii?Q?raewWf+xlJwtBOCRAxqOgtktjQWAPStH2g7/tFnfOF1mD57tnprB0uajT/Yr?=
 =?us-ascii?Q?SBqUgVsrKhVAQ8L7MLS2M6wyNist6iZQtm2IzuTwG1ng98u7cxDabeklYeji?=
 =?us-ascii?Q?II8g5QUMGuCJe1A/fw5QXhaZ1Vo4hh8XvoRLeH4drSJlqumDv6ys2XG+lfNS?=
 =?us-ascii?Q?mECgPNHKnFEo4VZQonj0NMs+jsMc2n4pGkmAu3kdUXJz0cyX7H7Wfi1EsOw9?=
 =?us-ascii?Q?j6gGl7b1KAsXcypvc14NaK+YtFUul+ggq/cmb4Gxx6GlZvzxuIOZoZxYUWQH?=
 =?us-ascii?Q?V5CFTBL+fQcqGVZUMaapL40wiOVRvdFsCgGE48ra8h1EorG+sErfNI+3J8A5?=
 =?us-ascii?Q?F7rOp2BSwXQS/hEuLWboYNntRs1qXtgjLEPVRbesWIq9fwyiuK4Nzjd9+S0h?=
 =?us-ascii?Q?qZVz/vwfY3/1Ls9HiI1u28nQunxlzjEcxu8infSyw6822IJzVY+pJIzd7bGb?=
 =?us-ascii?Q?EGHF8SQZwO6otkU/+iZgoysI+TuxNfVYXzUsK5NWNyQkJXFoaZbG2UHsLmyv?=
 =?us-ascii?Q?eR/nBExEUWz2UcvLsL8uTgQ+ktTJtGr3VmeFbQi1vd07/jtj2FoYxqvZZy7p?=
 =?us-ascii?Q?IrrqrKPD1txqbBmAY+usSThZ1VdhTn/SOoBAio7Nzzk3cuN9EM3RJZmQU/Gx?=
 =?us-ascii?Q?C4A9u7nmXsKMra4KDQ9OknYcFb0dg4XN/CkSec+qYOa+Ib2wAZRoWYf7FV+O?=
 =?us-ascii?Q?bqvWbprEd9kug9EGwiOou7qBeHEU9dXxiG5kLr2dTv4eY4fxv73trUQX9S74?=
 =?us-ascii?Q?lddbLbR/Cs9aWFjJSl+8pxocvRJlvaD82TZyvjU0wW3ss1dmscfx1luUMVoq?=
 =?us-ascii?Q?i9b/a4QSUJ/axgdVBCrWEVFA+yE59ceXbcbyeWmmqS+IPKnw7SBgMx8PXgAJ?=
 =?us-ascii?Q?z08r6cG8sV2liwU5JuWfXkZWAGvwI2mrZslYpOa3xeNCHcc3kyfZ5SbxqY7u?=
 =?us-ascii?Q?bWCZGzmt17YDSTvrSL5Km6ZiQSZ+E5eQ3YiswarWAHpGefSkoz2negekyeo2?=
 =?us-ascii?Q?rA7b3Zn/fRBRFEp8H4hQasc/XQfH1DYzQlk7/rz2F/YLg4Amufz6fmFWO29N?=
 =?us-ascii?Q?eGs2zikij6d9NC6GyBnfatvA23OTtA1kxTeK+P5S8sVcFBKhRn+bEZcE7c77?=
 =?us-ascii?Q?3nz2wA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ff1efe5-fba9-496d-330b-08dc84e5b7cd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 22:28:54.6919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BeNSBgYb9m8rXl84YB5I26Qqfqk3WCzu+q5Yreu5gfzPcHuR0gNKjgsYEV5nPWluR5ZASE26SuTulFyPS4FDNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7409

On Tue, 04 Jun, 2024 15:19:14 -0700 Aaron Plattner <aplattner@nvidia.com> wrote:
> On 6/4/24 3:04 PM, Junio C Hamano wrote:
>> Aaron Plattner <aplattner@nvidia.com> writes:
>> 
>>> When a struct credential expires, credential_fill() clears c->password
>>> so that clients don't try to use it later. However, a struct cred that
>>> uses an alternate authtype won't have a password, but might have a
>>> credential stored in c->credential.
>>>
>>> This is a problem, for example, when an OAuth2 bearer token is used. In
>>> the system I'm using, the OAuth2 configuration generates and caches a
>>> bearer token that is valid for an hour. After the token expires, git
>>> needs to call back into the credential helper to use a stored refresh
>>> token to get a new bearer token. But if c->credential is still non-NULL,
>>> git will instead try to use the expired token and fail with an error:
>>>
>>>   fatal: Authentication failed for 'https://<oauth2-enabled-server>/repository'
>>>
>>> And on the server:
>>>
>>>   [auth_openidc:error] [client <ip>:34012] oidc_proto_validate_exp: "exp" validation failure (1717522989): JWT expired 224 seconds ago
>>>
>>> Fix this by clearing both c->password and c->credential for an expired
>>> struct credential. While we're at it, use credential_clear_secrets()
>>> wherever both c->password and c->credential are being cleared, and use
>>> the full credential_clear() in credential_reject() after the credential
>>> has been erased from all of the helpers.
>> OK.
>> 
>>>
>>> v2: Unify secret clearing into credential_clear_secrets(), use
>>> credential_clear() in credential_reject(), add a comment about why we
>>> can't use credential_clear() in credential_fill().
>> This does not belong to the commit log message proper.  Those who
>> are reading "git log" would not know (and care about) an earlier
>> attempt.  Writing the changes since the previous round(s) like the
>> above paragraph is very much appreciated as it helps reviewers who
>> saw them, but please do so after the three-dash "---" line below (I
>> can remove the paragraph while queueing, so no need to resend).
>
> Sorry, I wasn't sure what the convention was since this was my first patch to
> the list. Thanks for fixing it. You can feel free to properly wrap the last line
> of that comment that I missed too, if you if you like. :)
>
>> Will queue.  Thanks.
>
> Thanks!
>
> Rahul (CC'd) and I had a series of patches to add something similar to the
> current authtype system but hadn't gotten around to sending them to the list
> before this more flexible mechanism was merged. It's nice that this worked out
> of the box with minimal adjustment.
>
> The credential helper he wrote is specific to the Microsoft "Entra ID" identity
> provider system, but hopefully it'll be generally useful once this stuff is in a
> git release. It really cleans up the authentication process over https for sites
> that support it.

Aaron made a commit to make it work with the authtype/credential
credential-helper infrastructure that landed in git-next.

  https://github.com/Binary-Eater/git-credential-msal/commit/f71ca9c72ca1a2cf73373de76909f6007ac689cb

The support for authtype excites me since a number of large Git
providers like GitHub/GitLab/etc. have utilized Authorization Basic
incorrectly for supporting different authtypes with git previously.
Hoping they will move away from this practice in the future with this
enhancement.

>
> -- Aaron
>
>>> Signed-off-by: Aaron Plattner <aplattner@nvidia.com>
>>> ---
>>>   credential.c | 19 +++++++++----------
>>>   1 file changed, 9 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/credential.c b/credential.c
>>> index 758528b291..72c6f46b02 100644
>>> --- a/credential.c
>>> +++ b/credential.c
>>> @@ -20,12 +20,11 @@ void credential_init(struct credential *c)
>>>     void credential_clear(struct credential *c)
>>>   {
>>> +	credential_clear_secrets(c);
>>>   	free(c->protocol);
>>>   	free(c->host);
>>>   	free(c->path);
>>>   	free(c->username);
>>> -	free(c->password);
>>> -	free(c->credential);
>>>   	free(c->oauth_refresh_token);
>>>   	free(c->authtype);
>>>   	string_list_clear(&c->helpers, 0);
>>> @@ -479,9 +478,14 @@ void credential_fill(struct credential *c, int all_capabilities)
>>>     	for (i = 0; i < c->helpers.nr; i++) {
>>>   		credential_do(c, c->helpers.items[i].string, "get");
>>> +
>>>   		if (c->password_expiry_utc < time(NULL)) {
>>> -			/* Discard expired password */
>>> -			FREE_AND_NULL(c->password);
>>> +			/*
>>> +			 * Don't use credential_clear() here: callers such as
>>> +			 * cmd_credential() expect to still be able to call
>>> +			 * credential_write() on a struct credential whose secrets have expired.
>>> +			 */
>>> +			credential_clear_secrets(c);
>>>   			/* Reset expiry to maintain consistency */
>>>   			c->password_expiry_utc = TIME_MAX;
>>>   		}
>>> @@ -528,12 +532,7 @@ void credential_reject(struct credential *c)
>>>   	for (i = 0; i < c->helpers.nr; i++)
>>>   		credential_do(c, c->helpers.items[i].string, "erase");
>>>   -	FREE_AND_NULL(c->username);
>>> -	FREE_AND_NULL(c->password);
>>> -	FREE_AND_NULL(c->credential);
>>> -	FREE_AND_NULL(c->oauth_refresh_token);
>>> -	c->password_expiry_utc = TIME_MAX;
>>> -	c->approved = 0;
>>> +	credential_clear(c);
>>>   }
>>>     static int check_url_component(const char *url, int quiet,

-- 
Thanks,

Rahul Rameshbabu
