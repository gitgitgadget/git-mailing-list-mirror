Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D862B35CB82
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 15:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767974257; cv=pass; b=Puh1Oq6sD3A+HPjUBy1Xi++3rLmb8hrnRN/5BeroehMMmUEvSB3GZuNCak4VQ5Yyt1b63dRmSyV5Qqzyoz9aB1u2+DUw4om5ZUlq6TNdVKnox8cGxn7r/FRGQa1j8PNoWwCozAn6ahC7xKNwu7QfYxX/X8DQ2R3wtRKXlvPxts8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767974257; c=relaxed/simple;
	bh=i7I+il0D9fKCGrCLxzIjQOvAO70VXj4tr1QWvpa1s+o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WvLOKKBGkGLD3Osj/54eQ2lcfkMX2rQ5sJx86Vbm2nXJURsmh74nHkV0XRZ7+6Zmdr98LwQZCz4HerDWQxTi0utDY66ciYJjsI4fKGy30+ZuJINkO3MH79RZdkaOGmyKVBjhRQp6vF6tVh9qNAP50vD3a9yetyxto8lf5gTFkGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=Rw+WWKRV; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="Rw+WWKRV"
ARC-Seal: i=1; a=rsa-sha256; t=1767974245; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=iML+IVIaj9hP6tuhRbrwkr7jxMs3xks0FoHrpgYlDDcnxdj3ojHcDy+NnBessReYjf04QDuuYedTCMH7vX0BrnCY0ffdRKMq9DUR1Kh/uPkiVYnjKG+hvB8EGSriQhZbzQy0erHtjKJ4anBSmCssiUenurMt5Qs9qFIFrBAIID0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1767974245; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=rY9UjzgVf+dwHhNfWRb+g+eJt+h+oif6+N+pca6PJpg=; 
	b=f/UxwCaAwXSpRRClYvGOrXofum5ABu81Zw3Tn4eKdCF0Rk76i7ppEXdaTbwEIElkUhmKuqyA/lOzcHzkoE6RwhEYHsfHj64jLzlIwTXZey/L9IkKKwPV+4qDK70u0+IesvPTt0zCiODkiFCpHI7EqI4ljFNpjcvd54Y7idYKG+o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1767974245;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=rY9UjzgVf+dwHhNfWRb+g+eJt+h+oif6+N+pca6PJpg=;
	b=Rw+WWKRV81p4qFwqlwxMA1XefeHB2te3oj+k6Tvu8pNMSdUQ4x0SChZtUdnPb5Us
	tDAs+25MHBWD8GqIGYCE9mJ3y69bz+Im7l7YR7mezI8BW3e+FlierAjNc/CZpm8x5NM
	T3Y98He4sU72ofs7RL5LWA/5MGQV+IuwU+TIoupk=
Received: by mx.zohomail.com with SMTPS id 1767974241921786.1646772224728;
	Fri, 9 Jan 2026 07:57:21 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Emily Shaffer
 <emilyshaffer@google.com>, correctmost <cmlists@sent.com>
Subject: Re: [PATCH][next] hook: check for NULL pointer before deref
In-Reply-To: <aWEkCqABozBzT-QS@pks.im>
References: <20260109153528.476163-1-adrian.ratiu@collabora.com>
 <aWEkCqABozBzT-QS@pks.im>
Date: Fri, 09 Jan 2026 17:57:18 +0200
Message-ID: <87ecnywzhd.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Fri, 09 Jan 2026, Patrick Steinhardt <ps@pks.im> wrote:
> On Fri, Jan 09, 2026 at 05:35:28PM +0200, Adrian Ratiu wrote:
>> diff --git a/hook.c b/hook.c
>> index 35211e5ed7..c257bd3940 100644
>> --- a/hook.c
>> +++ b/hook.c
>> @@ -148,12 +148,11 @@ int run_hooks_opt(struct repository *r, const char *hook_name,
>>  	};
>>  	const char *const hook_path = find_hook(r, hook_name);
>>  	int ret = 0;
>> -	const struct run_process_parallel_opts opts = {
>> +	struct run_process_parallel_opts opts = {
>>  		.tr2_category = "hook",
>>  		.tr2_label = hook_name,
>>  
>>  		.processes = 1,
>> -		.ungroup = options->ungroup,
>>  
>>  		.get_next_task = pick_next_hook,
>>  		.start_failure = notify_start_failure,
>
> What's omitted here is that the next two lines also dereference
> `options`. That'll also have to be fixed for the warning to go away.

Thanks for spotting this. Will fix in the same way.
