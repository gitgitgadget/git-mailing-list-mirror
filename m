Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0368D29ACC5
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 14:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771598852; cv=pass; b=cq17cg/FOkjucLoYOxJA1rg+dFsnGSvvHkBDB3DfOH2p1M3dSEeSFFhl+Jb0D9QNRdCFEfKD5fPkPwIvSUh5EtHfYo/0sXvczrLQ6MqoHjjHSRiz4Vgn1wMLF5Hcs1i2xNQeyuhvEGPuXEZWfjP9JM14OgeZZBuC1SY/OUHx7cM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771598852; c=relaxed/simple;
	bh=ZRHPPmVeEPzLyPoKB4NtChQegK7iP58mxfdNqgzPrOk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IKooLQBmoCX+VSZpdSsK3xcD5HU1uDkzFtJJCeRxsNvjXdPOt1q0GiImCsLREVpjHxN36TvnYpx2WFogxOUM1lK1O6Iolbpuwzy3rRdCAHO3eAaeGLOFjoqrxhenL07jzorSfSq1CAqVx7JZXa+siJuL14O0nMHW+8JXxYBFCgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=P4MDnHvV; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="P4MDnHvV"
ARC-Seal: i=1; a=rsa-sha256; t=1771598838; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TuHNO7TMs5TrXgQI/DEnDjtHCf9fSyA602k7fKel2E7iYWAhFMaNILEqB1we2xi1PjcsXXyDFkly2vOj48IMPRT7pc/Y9nEEUauHsPLYRwqqDpd9qXbeoNNp4bukpvc227TMsWLF/+XnjPs5ja1WJ88/k3GJ+vqo9DLqrhiKFms=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771598838; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=f306+WsLrHFCuXd8Y/5g+5brw19SwLTo9/MVumuXSiY=; 
	b=WEdpkchzVAM3RQqKBNGapXVWICUTQnnCOfzlU6tRrvJ5Fc12RLtVHyf/qkYjPCDeltt7knC6Mvt40R1Ddd4H7C07wQSAcbXMM1HWYWFizDl8EFLtXIynZX3BSsAZNVZGUbsLpifX2pGJzcLX35HwYzdYBaeKMKD899ukKhDybew=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771598837;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=f306+WsLrHFCuXd8Y/5g+5brw19SwLTo9/MVumuXSiY=;
	b=P4MDnHvVSOv5icbtQQ/1OKtqpEwYeUeG2e7SFWr07nPTRZJsVd1aN5DUciT9J5Cx
	7f1M7rIcHswStjr8XNl3yJYZVQXA0iyXBcECvWEbibV62V37wz4CrP++8MU9JKG24PC
	WljlKYkBhf5KMHRezC0XKIgmODI+mRlFwoC3t+HI=
Received: by mx.zohomail.com with SMTPS id 1771598836577248.47180521043526;
	Fri, 20 Feb 2026 06:47:16 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Emily Shaffer
 <emilyshaffer@google.com>, Junio C Hamano <gitster@pobox.com>, Josh
 Steadmon <steadmon@google.com>, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2 5/8] hook: allow disabling config hooks
In-Reply-To: <aZhXom2cD8juWYs4@pks.im>
References: <20260204165126.1548805-1-adrian.ratiu@collabora.com>
 <20260218222352.55393-1-adrian.ratiu@collabora.com>
 <20260218222352.55393-6-adrian.ratiu@collabora.com>
 <aZhXom2cD8juWYs4@pks.im>
Date: Fri, 20 Feb 2026 16:47:13 +0200
Message-ID: <87qzqfwjym.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Fri, 20 Feb 2026, Patrick Steinhardt <ps@pks.im> wrote:
> On Thu, Feb 19, 2026 at 12:23:49AM +0200, Adrian Ratiu wrote:
>> diff --git a/Documentation/config/hook.adoc b/Documentation/config/hook.adoc
>> index 9faafe3016..0cda4745a6 100644
>> --- a/Documentation/config/hook.adoc
>> +++ b/Documentation/config/hook.adoc
>> @@ -13,3 +13,10 @@ hook.<name>.event::
>>  	specified event, the associated `hook.<name>.command` is executed.
>>  	This is a multi-valued key. To run `hook.<name>` on multiple
>>  	events, specify the key more than once. See linkgit:git-hook[1].
>> +
>> +hook.<name>.enabled::
>> +	Whether the hook `hook.<name>` is enabled. Defaults to `true`.
>> +	Set to `false` to disable the hook without removing its
>> +	configuration. This is particularly useful when a hook is defined
>> +	in a system or global config file and needs to be disabled for a
>> +	specific repository. See linkgit:git-hook[1].
>
> Nice.
>
>> diff --git a/hook.c b/hook.c
>> index 8a9b405f76..35c24bf33d 100644
>> --- a/hook.c
>> +++ b/hook.c
>> @@ -164,6 +164,21 @@ static int hook_config_lookup_all(const char *key, const char *value,
>>  		char *old = strmap_put(&data->commands, hook_name,
>>  				       xstrdup(value));
>>  		free(old);
>> +	} else if (!strcmp(subkey, "enabled")) {
>> +		switch (git_parse_maybe_bool(value)) {
>> +		case 0: /* disabled */
>> +			if (!unsorted_string_list_lookup(&data->disabled_hooks,
>> +							 hook_name))
>> +				string_list_append(&data->disabled_hooks,
>> +						   hook_name);
>> +			break;
>> +		case 1: /* enabled: undo a prior disabled entry */
>> +			unsorted_string_list_remove(&data->disabled_hooks,
>> +						    hook_name);
>> +			break;
>> +		default:
>> +			break; /* ignore unrecognised values */
>> +		}
>>  	}
>
> Somewhat similar to my preceding questions: why don't we store the
> enabled state in the `struct hook` structure itself? Like that we can
> for example even list disabled hooks in `git hooks list --disabled`, if
> we ever wanted to do something like that.

The answer to the preceeding question is unfortunately no (I tried it),
however the answer to this question is YES.

I took the design decision to "filter" disabled hooks at config parsing
time, however I had no idea when doing it that we might want to run
something like "git hooks list --disabled".

I'll change this in v3 and cache the disabled config state instead of
filtering out disabled hooks completely.

This way we could still use their information as you suggested and we
could even enable/disable config hooks via git commands, however that is
yet-another-new-feature and this series is big enough and should be just
focused on adding the "base" functionality.

So in v3 I will cache the disabled state add the `git hooks list
--disabled` feature as well, but stop there. :)
