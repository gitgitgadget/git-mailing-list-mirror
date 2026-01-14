Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85D437F8B0
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 08:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768380439; cv=pass; b=on2B1RjEwg5I0QeTeONpigVExEHSO5syAX5KIiAVnXBWmV7VklKrcFs96O0yH4w2/ZF9pUxM/Q2uEklaylMUDQsmtuBBNPRrV5CReHGStNNAZbguTgbo7igcYoi/BxQqmjZCjkAdrFsOv1kzij7ZEdB8fzS9UHhXbwuK42feFR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768380439; c=relaxed/simple;
	bh=P49juaUB2MH0WAbaUQD6YLYfHcm7OJHmiM9vlRDg1X4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nlniX64BLdmlDGZVfxKe5NQBpXY6/gKBIpCDwJgS/xZyToA/jKjTtGE+KS6068blIJzIdrs0Y4yIgmyqPLu/tE8NS1sLQhQ/Z/F2ogTROzJ9NyOj5qw2uoD+pmvBdfiWehQ5sQddfnOp1HslFzbNPr6INpQB75TAyxw8n+mO14E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=lKJEB+ce; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="lKJEB+ce"
ARC-Seal: i=1; a=rsa-sha256; t=1768380406; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SNMmDbIyngHbOZO07Ckeh7/Dey84kConAPmZk/ZoS8oQHdBOPIUU1KofDMP7kWsABa7z7HtZkDK+NMc0+ygdovAYOWfZW4AkpS2Zer/KlVG7MMUi3xR5ATJGQuS8/tIMgZr5OvIvpi8Wp3GfLCA+QyzQtJMMmztQWocX4zGKA+I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1768380406; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=WR2Sq5/GNtdJi7AZVaFGbrAPm/kV7Gwtg4PfkCS2clk=; 
	b=BG87YPpttNAY4KLJPjAj/0deH7bTUQxBxlcK5v0wmklBcEyZPqmeNjfH0Mgam/vwQQHbMQlX2B6uULnSpAXBitNar97K5TuiIpAPnqmuaLWUF64WyrvaGoeB8kxBBl16w5uLylAfCqzeeCbvRN+ri4VNwDTkX2otylmQ5YORpYM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768380406;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=WR2Sq5/GNtdJi7AZVaFGbrAPm/kV7Gwtg4PfkCS2clk=;
	b=lKJEB+ce9FYyS+Cr//57lXA/lW+eNkdwpDwHzT1v5GRpCuDkLnP2C2BWffVTsrry
	zwcOIQdWs8DIaDPwm7ZTLbD+Ngl/cF9PP/quniwTD8SO5mFLTjyWxqbf0aedqbAN/kY
	gjl/d7II7XGVhrSRoRyZZZldpCZwYaIJWFo9LUt8=
Received: by mx.zohomail.com with SMTPS id 1768380403970232.63402825126718;
	Wed, 14 Jan 2026 00:46:43 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick
 Steinhardt <ps@pks.im>, Emily Shaffer <emilyshaffer@google.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Chris Darroch
 <chrisd@apache.org>, "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2] hook: allow hooks to disable stdout_to_stderr
In-Reply-To: <20260114031257.GA858646@coredump.intra.peff.net>
References: <20260113115633.230479-1-adrian.ratiu@collabora.com>
 <20260113234528.1749921-1-adrian.ratiu@collabora.com>
 <20260114031257.GA858646@coredump.intra.peff.net>
Date: Wed, 14 Jan 2026 10:46:39 +0200
Message-ID: <878qe0zimo.fsf@gentoo.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Tue, 13 Jan 2026, Jeff King <peff@peff.net> wrote:
> On Wed, Jan 14, 2026 at 01:45:28AM +0200, Adrian Ratiu wrote:
>
>> Changes in v2:
>> * Extended hook test coverage to detect future regressions (Junio, Patrick)
>> * Reworded commit message and added explanatory comment (Junio, Patrick)
>> * Set ungroup = 1 because grouping overrides stdout_to_stderr (Adrian)
>
> I have not really been following this topic, but I did read (and
> reproduce) Kristoffer's earlier report about reading stdin. The fix here
> was not quite what I expected.
>
> In particular...
>
>> @@ -93,6 +98,7 @@ struct run_hooks_opt
>>  #define RUN_HOOKS_OPT_INIT { \
>>  	.env = STRVEC_INIT, \
>>  	.args = STRVEC_INIT, \
>> +	.stdout_to_stderr = 1, \
>>  }
>
> ...I expected to see:
>
>   .ungroup = 1, \

Good catch. I actually missed this in v2.

I will drop ungroup from this patch in v3 and add another patch fixing
Kristoffer's issue (rationale below).

>
> here. The stdin issue goes back to 857f047e40 (hook: allow overriding
> the ungroup option, 2025-12-26), where the "ungroup" field was added,
> and various code paths set it to "1" to match the previous behavior. But
> any paths that were missed, including run_pre_push_hook(), would see a
> change of behavior (and in this case, a bug).
>
> My reading of 857f047e40 is that it meant to give callers the _option_
> to switch the ungroup behavior, but not actually change anything. So
> wouldn't we want to leave the default as it was by initializing it to
> "1"?

That is correct: my mistake in v2 was assuming Kristoffer and Chris
reported the same bug, when in fact there are 2 separate bugs requiring
separate fixes, so I will create 2 separate commits in v3 for each.

>
>> @@ -1373,6 +1373,15 @@ static int run_pre_push_hook(struct transport *transport,
>>  	opt.feed_pipe = pre_push_hook_feed_stdin;
>>  	opt.feed_pipe_cb_data = &data;
>>  
>> +	/*
>> +	 * pre-push hooks expect stdout & stderr to be separate, so don't merge
>> +	 * them to keep backwards compatibility with existing hooks.
>> +	 * run_process_parallel(), called via run_hooks_opt() below, will buffer
>> +	 * and merge the streams when output is grouped, so also set ungroup = 1.
>> +	 */
>> +	opt.stdout_to_stderr = 0;
>> +	opt.ungroup = 1;
>
> The other unexpected thing is that these two fixes are grouped at all.
> AFAICT, setting ungroup to 1 will fix Kristoffer's stdin problem without
> changing stdout_to_stderr at all.
>
> But I'm still not entirely sure I understand why the ungroup setting,
> which supposedly only affects stderr handling, causes the hook to fail
> to read stdin. Poking at it in a debugger and via strace, it looks like
> we are in a poll loop while feeding stdin, even though we are not
> checking whether the child can read! If we instrument like this:
>
> diff --git a/transport.c b/transport.c
> index 6d0f02be5d..7381450123 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -1342,6 +1342,7 @@ static int pre_push_hook_feed_stdin(int hook_stdin_fd, void *pp_cb UNUSED, void
>  		break;
>  	}
>  
> +	warning("called pre_push_hook_feed_stdin for %s", r->name);
>  	if (!r->peer_ref)
>  		return 0;
>  
>
> and then run the push from Kristoffer's recipe under strace, I see:
>
>   poll([{fd=7, events=POLLIN|POLLHUP}], 1, 100) = 0 (Timeout)
>   write(2, "warning: called pre_push_hook_feed_stdin for refs/tags/gitgui-0.6.3\n", 68) = 68
>   poll([{fd=7, events=POLLIN|POLLHUP}], 1, 100) = 0 (Timeout)
>   write(2, "warning: called pre_push_hook_feed_stdin for refs/tags/gitgui-0.6.4\n", 68) = 68
>   poll([{fd=7, events=POLLIN|POLLHUP}], 1, 100) = 0 (Timeout)
>   write(2, "warning: called pre_push_hook_feed_stdin for refs/tags/gitgui-0.6.5\n", 68) = 68
>   poll([{fd=7, events=POLLIN|POLLHUP}], 1, 100) = 0 (Timeout)
>   write(2, "warning: called pre_push_hook_feed_stdin for refs/tags/gitgui-0.7.0\n", 68) = 68
>   poll([{fd=7, events=POLLIN|POLLHUP}], 1, 100) = 0 (Timeout)
>   write(2, "warning: called pre_push_hook_feed_stdin for refs/tags/gitgui-0.7.0-rc1\n", 72) = 72
>   poll([{fd=7, events=POLLIN|POLLHUP}], 1, 100) = 0 (Timeout)
>
> So we are hitting the poll timeout for each ref we consider, and it
> takes forever to actually write the whole input stream. Which seems like
> a bug in using feed_pipe without ungroup. Either:
>
>   1. We should write everything to the child as quickly as possible,
>      assuming that we do not have to worry about reading back from it to
>      avoid deadlock.
>
>   2. We should add the child's input pipes to our poll() call so that we
>      can tell it is ready for more input (without hitting the timeout).
>
> Setting ungroup=1 saves us from this because it means that we'll skip
> the poll() call entirely in pp_handle_child_IO(). So we end up
> effectively doing (1), which is OK because ungroup means we are not
> reading stdout or stderr from the child at all.
>
> But it feels like this is papering over a bug, or at least providing a
> dangerous interface. AFAICT you _must_ set ungroup if you are going to
> use the feed_pipe callback. And it does not really have anything to do
> with the stdout_to_stderr flag at all.
>
> It looks like feed_pipe feature is new-ish in your series. Maybe it
> should just be a BUG() to use it without ungroup?

This is all very useful and it proves there are 2 separate bugs here,
requiring two separate fixes for both Chris and Kristoffer.

The logic in v1 (without ungroup) is enough to fix Chris' issue with
stdin and for Kristoffer I will do a smarter fix which implements your
(1) suggestion: batch more than a single stdin fd write in each poll
call so we achieve comparable throughtput (no added poll latency).

We already do this for the receive hook in feed_receive_hook_cb(). In
this case we just need the callback to process more than just 1 ref at a
time.

I will send v3 addressing your feedback, it is very much appreciated,
Adrian
