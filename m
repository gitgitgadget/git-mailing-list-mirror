Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993E0347BC7
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 13:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771595633; cv=pass; b=kS4ve99lcxlbHrSxtU4JCNFid3ST3cqRDxRdFRwUMiRuFpDM91XOsWSCsoJr/oxbMB/oGz2rhVsQJAps8l22NLozbAfotLepjeqMqR954M7A1SJJsLPWNp7OJhskkccFZXckm1RjQkgJX40ThoMBsE4los8sdMr3Qxdlc/Md2V4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771595633; c=relaxed/simple;
	bh=toAfQnOPx5+yeimaIA6HXHbuT2qE72Fb5ZkPUoOHQpM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pxAQ7BDePYIdZei9RJ7e50ApTlvQiEN1PDS3AVMfJYfshOYPllJyNWf5p/+bazip+XmXuFqFFaYkOFZJL1XTt3LwQwCspQfo787SyMO359LUIlZTfxBXQ+p8SMI0NPUgOMt4Y85bwfaFj8PQQZBSZbYokTfdZou4QqTxpxxypRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=AyuILVVs; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="AyuILVVs"
ARC-Seal: i=1; a=rsa-sha256; t=1771595619; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=O9taLFZYiliuy5wo0ga6CsMxddTybxUndGDtfZ3zlkUfc4mO+PsLnQZfveHSf1KPF0HtuYrUP7ZDYp4OvYO8VPB/OodqA3o1f1iEhriyP8zMz//P5cgwStAoci1f0IGkfvMCDzlANicU8PxyrPWBQQyRjin8TrVpoVHROUBjGZk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771595619; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=x1v6kUhjfT+CUq8D8XQC6Bc7sK4tjKD+083Yhey1Yps=; 
	b=ISW44iaVhzMpDGGqEukThqlidH6MrMCuCxAT98O5zkCnZnJhpwsLKceXCkQ32OZPWIKDD5HBUOj6UwaVhr/SgfofrzqV7a8ihYEv+0ULbGXui2i5f44NlOROZJ2ibU2DNSgCU52OO3BVkZT4uLi6cOC7hmMrB2DBQBIieiMzprU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771595619;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=x1v6kUhjfT+CUq8D8XQC6Bc7sK4tjKD+083Yhey1Yps=;
	b=AyuILVVsQVYrCe0/oMvgTuPHOD4wh6m48ajL7MBV41tFMJhNOyo8PcOFjG/8ARjJ
	VfMvRMC8jDlwIMrT4Ohjv48zUenCiBSLfRJSDJHP0/UzPp7Yr947kYMUwyxgqfQm1z7
	gxVZNwbY++rWVfS2vsG9NZdCmerPxzmVshHQTSAE=
Received: by mx.zohomail.com with SMTPS id 1771595617181249.21915315181093;
	Fri, 20 Feb 2026 05:53:37 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Emily Shaffer
 <emilyshaffer@google.com>, Junio C Hamano <gitster@pobox.com>, Josh
 Steadmon <steadmon@google.com>, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2 3/8] hook: add "git hook list" command
In-Reply-To: <aZhXlrWRGDS_Bhvm@pks.im>
References: <20260204165126.1548805-1-adrian.ratiu@collabora.com>
 <20260218222352.55393-1-adrian.ratiu@collabora.com>
 <20260218222352.55393-4-adrian.ratiu@collabora.com>
 <aZhXlrWRGDS_Bhvm@pks.im>
Date: Fri, 20 Feb 2026 15:53:34 +0200
Message-ID: <87wm07wmg1.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Fri, 20 Feb 2026, Patrick Steinhardt <ps@pks.im> wrote:
> On Thu, Feb 19, 2026 at 12:23:47AM +0200, Adrian Ratiu wrote:
>> diff --git a/builtin/hook.c b/builtin/hook.c
>> index 7afec380d2..51660c4941 100644
>> --- a/builtin/hook.c
>> +++ b/builtin/hook.c
>> @@ -20,6 +24,61 @@ static const char * const builtin_hook_run_usage[] = {
>>  	NULL
>>  };
>>  
>> +static int list(int argc, const char **argv, const char *prefix,
>> +		 struct repository *repo)
>> +{
>> +	static const char *const builtin_hook_list_usage[] = {
>> +		BUILTIN_HOOK_LIST_USAGE,
>> +		NULL
>> +	};
>> +	struct string_list *head;
>> +	struct string_list_item *item;
>> +	const char *hookname = NULL;
>> +	int ret = 0;
>> +
>> +	struct option list_options[] = {
>> +		OPT_END(),
>> +	};
>> +
>> +	argc = parse_options(argc, argv, prefix, list_options,
>> +			     builtin_hook_list_usage, 0);
>> +
>> +	/*
>> +	 * The only unnamed argument provided should be the hook-name; if we add
>> +	 * arguments later they probably should be caught by parse_options.
>> +	 */
>> +	if (argc != 1)
>> +		usage_msg_opt(_("You must specify a hook event name to list."),
>> +			      builtin_hook_list_usage, list_options);
>
> Error messages typically start with a lower-case letter.

Ack, will fix.

>> +	hookname = argv[0];
>> +
>> +	head = list_hooks(repo, hookname, NULL);
>> +
>> +	if (!head->nr) {
>> +		warning(_("No hooks found for event '%s'"), hookname);
>
> Warnings, too.

Ack, will fix.

>> +		ret = 1; /* no hooks found */
>> +		goto cleanup;
>> +	}
>> +
>> +	for_each_string_list_item(item, head) {
>> +		struct hook *h = item->util;
>> +
>> +		switch (h->kind) {
>> +		case HOOK_TRADITIONAL:
>> +			printf("%s\n", _("hook from hookdir"));
>> +			break;
>> +		default:
>> +			BUG("unknown hook kind");
>> +		}
>
> Good that we're being defensive here.

Yes, I remembered correctly then, will add a BUG() to the other patch as
well.
