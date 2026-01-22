Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B21349B1F
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 10:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769079557; cv=pass; b=AadrYXhNbONpwXrn8ul80UXlThFIfl/zvjsXOxTpfbRugqbg0xxzoCILXwWi/QvxOQU3BhcJe6qej89BChMeKJ5aidXQA9BRalCXkLN6w7bFv5RkE5Dxycij1FulABaRjFNv95Wzfm53cMEzlSjtVxTMCveLx5FUKWO0T+YvTmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769079557; c=relaxed/simple;
	bh=PLPvlK3XXAyF6mQbLt4qx2nWvxBBXRpfkefIZQYcmaU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ozJoj4+JbEonPw8Xa+iKRxTm3PXfJGTXXz9PZQ2vJYmV6qKapz7CQ7RMqgyvIeoijkFTmlPxDwC60uDiWPQpXkFWfEHirYYNYH3VkmguYWcfNLGXW12tqRZAkFKpW6k3Z6Z9eloyMAL7L9NkBnEsGY8d3vu6+VIHGHLd+mIPRwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=InubZDwA; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="InubZDwA"
ARC-Seal: i=1; a=rsa-sha256; t=1769079542; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WmEkhpb97L8H0UFeTWsSrzG55tInE3f34ge/776xOKD2jh0CgJBIY2Gy0DEzhsd9Gte01IBOd/yGoG9se8dpbkZeqge5nOpTg6Wpib1l44PjhGwJ7Y94/7fdF/sJZBzMpQKvg6vf8PVOrHDgqIYdwtLiFNj3nCp1Br0FyzttPm4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1769079542; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=zz9xlhwc0EdBFBhSqoooXjCLN2uRrRbw+iYZzjqiARI=; 
	b=OBEr5btLoIwuQkgPKuke9ny56srSv0f+ziBaxqtxaqQxoAcuVQPdbdw1UdU1eiNoHhumIvIo1t3V4XxfiNDrmpijLpZS0vqJjagAqXDtk+NzOIj23ezK0Hwx0uAuyhBrUMfPtyVAb7eUeH/EPBM4Hf6wWptGVsLfVePt1zp9Dzg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769079542;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=zz9xlhwc0EdBFBhSqoooXjCLN2uRrRbw+iYZzjqiARI=;
	b=InubZDwAnJ9x77dIWr1BvLaKE7+B7md1Cx5WJBBmSD1VfW2dHv9vcY/zG1on1A93
	5Rcu4ZnIyUvrjktb5xOef2SkOqoiMATg3H8gRiMB/1C0gVL5hRIsvz/l4jVQjHvJFZe
	GKLxHmw53wcol3l98Fyk6TGOzCdE+XFGpNeVjpeQ=
Received: by mx.zohomail.com with SMTPS id 1769079540191376.5790700468258;
	Thu, 22 Jan 2026 02:59:00 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Emily Shaffer
 <emilyshaffer@google.com>, Patrick Steinhardt <ps@pks.im>, Josh Steadmon
 <steadmon@google.com>, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v7 10/12] run-command: poll child stdin in addition to
 stdout
In-Reply-To: <xmqqzf66pnmz.fsf@gitster.g>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20260121215436.1473800-1-adrian.ratiu@collabora.com>
 <20260121215436.1473800-11-adrian.ratiu@collabora.com>
 <xmqqzf66pnmz.fsf@gitster.g>
Date: Thu, 22 Jan 2026 12:58:56 +0200
Message-ID: <877bt9rk0f.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Wed, 21 Jan 2026, Junio C Hamano <gitster@pobox.com> wrote:
> Adrian Ratiu <adrian.ratiu@collabora.com> writes:
>
>> Child input feeding might hit the 100ms output poll timeout as a
>> side-effect of the ungroup=0 design when feeding multiple children
>> in parallel and buffering their outputs.
>>
>> This throttles the write throughtput as reported by Kristoffer.
>>
>> Peff also noted that the parent might block if the write pipe is full
>> and cause a deadlock if both parent + child wait for one another.
>>
>> Thus we refactor the run-command I/O loop so it polls on both child
>> input and output fds to eliminate the risk of artificial 100ms
>> latencies and unnecessarily blocking the main process.
>>
>> This ensures that parallel hooks are fed data ASAP while maintaining
>> responsiveness for (sideband) output.
>>
>> It's worth noting that in our current design, sequential execution
>> is not affected by this because it still uses the ungroup=1 behavior.
>>
>> Reported-by: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
>> Suggested-by: Jeff King <peff@peff.net>
>> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
>> ---
>>  run-command.c | 61 ++++++++++++++++++++++++++++++++++++---------------
>>  1 file changed, 43 insertions(+), 18 deletions(-)
>>
>> diff --git a/run-command.c b/run-command.c
>> index aaf0e4ecee..dfd2aeda07 100644
>> --- a/run-command.c
>> +++ b/run-command.c
>> @@ -1562,7 +1562,7 @@ static void pp_init(struct parallel_processes *pp,
>>  
>>  	CALLOC_ARRAY(pp->children, n);
>>  	if (!opts->ungroup)
>> -		CALLOC_ARRAY(pp->pfd, n);
>> +		CALLOC_ARRAY(pp->pfd, n * 2);
>>  
>>  	for (size_t i = 0; i < n; i++) {
>>  		strbuf_init(&pp->children[i].err, 0);
>> @@ -1707,21 +1707,52 @@ static void pp_buffer_stdin(struct parallel_processes *pp,
>>  	}
>>  }
>>  
>> -static void pp_buffer_stderr(struct parallel_processes *pp,
>> -			     const struct run_process_parallel_opts *opts,
>> -			     int output_timeout)
>> +static void pp_buffer_io(struct parallel_processes *pp,
>> +			 const struct run_process_parallel_opts *opts,
>> +			 int timeout)
>>  {
>> -	while (poll(pp->pfd, opts->processes, output_timeout) < 0) {
>> +	/* for each potential child slot, prepare two pollfd entries */
>> +	for (size_t i = 0; i < opts->processes; i++) {
>> +		if (child_is_working(&pp->children[i]) &&
>> +		    pp->children[i].process.err > 0) {
>
> I find it a bit odd to insist that .err must be positive integer for
> us to decide including it in the polled fd set.  Are we safe to
> assume that .err file descriptor in use can never be 0 because we do
> not close stdin in the main process anyway?

Yes, it is odd and it's a weirdness of the run-command.c child fd
handling logic where .in, .out and .err are initialized to 0.

Patrick raised this up as well in one of the previous patches, however
reworking run-command to not use 0 sentinel values for fd's is quite the
big unrelated patch (I gave up after spending about 1.5 days on it at
the time).

Maybe one day we can also fix this weird aspect of the run-command API.
