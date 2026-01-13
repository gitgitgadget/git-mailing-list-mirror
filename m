Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21630392B7F
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 14:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768313539; cv=pass; b=M44MqIMPYhp1XeDRlEIy6xO76lPVoZXLSXVda5hmTx2O6CydJuaLZihOd0thRbCAG/VBo4/2VCWvq7ZjUkbw50+W8CEdctMrzxZqAgJcyJ39PZ1CzesC0mnrPk/TXe6bcryuOp1k0U5tE52pqTdhd978YtidRc/Fh2jVb7Df5Vw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768313539; c=relaxed/simple;
	bh=GYSXiZP5+MSlr8Rzz8TxrIBM2xrUNTdBKT/j23Huw0k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mx48ZrjtqkDB6IOUhOWsB0nLTR2a4YDmpkHyoGeDhiRD4+y7BAViIx3+c8MhG9nLbfEAPWSGqGPPor8CbBeVTh5uq0p+0sY8ymvG1wW5L+kR9ld/YFANT5m6ea05Ojb6STtF/kWlRgxVMntLd45flgX51IXYNQwPBcUpzS4Fgcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=eEI/8lNd; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="eEI/8lNd"
ARC-Seal: i=1; a=rsa-sha256; t=1768313524; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ifOoj7X+P7iWrd66e++6KaLO5RtsOpMktCNRO/eoSk1HeqlEnO0eFy8PenKKqe1y0uAlxPAsxuTHXGzdwq4oCSP5F0yN/DhkGyXKGVeike03wHWuFf/H7fJftCOKi0gEu6qMbNqhm3nHYkxzVTLEQkWByOH0iWm5sk+CUioDLvc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1768313524; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=LyhxTNWgx/oVsaCN34gamRepJqZYUy36IRR9qv8coI4=; 
	b=RIoC1H/gRnxd1WBBzQuDjKyxszMoQu4KgeePEGnyT8LST7L2FJUrBmhieRrMuyzQHL79jSSRG2oc42ml+gVZiGdonfKyDKOGBKLLMOcV5wfRZ8x53e4waunhFYr4ZfVFv0D1pmEIoRN+vz2sYl6Gz4ZvegQTbbBJePqbDkYzcj8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768313524;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=LyhxTNWgx/oVsaCN34gamRepJqZYUy36IRR9qv8coI4=;
	b=eEI/8lNdXCkxTnTGH2nT+WwItzAnw+1QYSYEiiMp3eC6DUZnuHH598OdzWLxM3oC
	0mrJ57P+vmZf2Re2hEqJ85FISdXewS15GddEk+SY/e4tNN/+Br4ZJONDEl/YdbnQ6vO
	YSeoSvU2LxKs0oFg4u/JFqDbGuzWeRYpSR49hZBI=
Received: by mx.zohomail.com with SMTPS id 1768313522513965.4381470202206;
	Tue, 13 Jan 2026 06:12:02 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Emily Shaffer
 <emilyshaffer@google.com>, Chris Darroch <chrisd@apache.org>, "brian m.
 carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] hook: make stdout_to_stderr optional
In-Reply-To: <xmqq7btlliip.fsf@gitster.g>
References: <20260113115633.230479-1-adrian.ratiu@collabora.com>
 <xmqq7btlliip.fsf@gitster.g>
Date: Tue, 13 Jan 2026 16:11:58 +0200
Message-ID: <87jyxlioup.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Tue, 13 Jan 2026, Junio C Hamano <gitster@pobox.com> wrote:
> Adrian Ratiu <adrian.ratiu@collabora.com> writes:
>
>> diff --git a/hook.c b/hook.c
>> index 35211e5ed7..ebd9d9e26e 100644
>> --- a/hook.c
>> +++ b/hook.c
>> @@ -81,7 +81,7 @@ static int pick_next_hook(struct child_process *cp,
>>  		cp->in = -1;
>>  	}
>>  
>> -	cp->stdout_to_stderr = 1;
>> +	cp->stdout_to_stderr = hook_cb->options->stdout_to_stderr;
>>  	cp->trace2_hook_name = hook_cb->hook_name;
>>  	cp->dir = hook_cb->options->dir;
>
> So stdout_to_stderr used to get always forced to 1, but now the
> value comes from the hook option, which ...
>
>> diff --git a/hook.h b/hook.h
>> index ae502178b9..2488db7133 100644
>> --- a/hook.h
>> +++ b/hook.h
>> @@ -39,6 +39,11 @@ struct run_hooks_opt
>>  	 */
>>  	unsigned int ungroup:1;
>>  
>> +	/**
>> +	 * Send the hook's stdout to stderr.
>> +	 */
>> +	unsigned int stdout_to_stderr:1;
>> +
>>  	/**
>>  	 * Path to file which should be piped to stdin for each hook.
>>  	 */
>> @@ -93,6 +98,7 @@ struct run_hooks_opt
>>  #define RUN_HOOKS_OPT_INIT { \
>>  	.env = STRVEC_INIT, \
>>  	.args = STRVEC_INIT, \
>> +	.stdout_to_stderr = 1, \
>>  }
>
> ... defaults to 1 for everybody, unless a specific caller opts out
> by ...
>
>>  struct hook_cb_data {
>> diff --git a/transport.c b/transport.c
>> index 6d0f02be5d..8f0e5987ab 100644
>> --- a/transport.c
>> +++ b/transport.c
>> @@ -1372,6 +1372,7 @@ static int run_pre_push_hook(struct transport *transport,
>>  
>>  	opt.feed_pipe = pre_push_hook_feed_stdin;
>>  	opt.feed_pipe_cb_data = &data;
>> +	opt.stdout_to_stderr = 0;
>
> ... setting it to 0 in their hook option.
>
>> The last batch of hooks converted to the hook.[ch] API introduced
>> a regression because pick_next_hook() always sets stdout_to_stderr
>> for its child processes.
>>
>> Pre-push is the only hook API user which requires stdout_to_stderr
>> to be 0, so it can be argued that pre-push needs fixing, however
>> this will likely break many pre-push hooks, so it's better to allow
>> it to be 0, i.e. to match the previous behavior.
>
> What was the previous behaviour of code paths that ran other hooks?
> Was pre-push the only one that didn't divert standard output to
> standard error?  This patch does look like a proper regression fix
> in that case.  I browsed "git log -p 1627809eef..c65f26fca4" (i.e.,
> the change for "Merge branch 'ar/run-command-hook'") and random
> sampling (like run_receive_hook() that used run_and_feed_hook(),
> which set stdout_to_stderr to 1) seems to indicate that it is the
> case.

Yes, your understanding is correct in all the above.

Each hook used to set the child process stdout_to_stderr to 1 with the
exception of pre-push, which regressed.

As Patrick noted, we are also missing some test cases to verify hooks
write to stderr and pre-push to stdout.

I'll add these tests and send v2, unless you want to land this as-is to
fix the regression ASAP, then I'll add the tests in a separate commit.
