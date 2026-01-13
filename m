Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7632038FEE8
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 13:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768312549; cv=pass; b=TkU4EANggdql3svZR9zI0Swpgc1rPmEIaQpVbX4hYAhzWluB64Oh63FrJoTP+4w3txjCE0ZZAfMre0IaLS56ebcA28Qm4NCno3nmZxgcl7V4zKspWZvOc5FW1bhoqxjCjKxFAnYhPajoITbvSzSkYHARWN+zrA6epuvtl75CEdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768312549; c=relaxed/simple;
	bh=LSDCQ4BZz4MRTnB38NYkwpkupehm2JLXDJZfoZzTpOQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KFjr1D98p9aERam1V5y0Ln+Bfh6EizaY3xVUyZZWeL+lxogPRvcMrbDDnlEnZgscPQcRVJioSMx5YAAeNRLwpZoFszFSxrvmveCEqeibbUZ9FgfdWQX3/g2aSgN/NIuVwuXx9aEBV5FTCq35TVKFluQI9Rm9h9nujuI5PTetln0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=LowOEk+x; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="LowOEk+x"
ARC-Seal: i=1; a=rsa-sha256; t=1768312531; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Mk+TsK62YPzwLTlRBzkQhXAKvfH+vmW40w3tKy93YOSFRGKI9C2jHk1sB7+vk+Ax9xMxQuLCHRQFS0pTMtzXVca3idt/ljIprxG/qQgoA84xebjIbXUpG8Nf+NYzOj4dEDZonoxZaEvB458FL19Fy9XbRrB5ZVEMFueVA/gW8HQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1768312531; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=zegPgWfoIpnCcSvmFUz9CgHlfLJDn3gq/wRvOXjRKwI=; 
	b=U0p6tWQgAEzRY0QmlCp7GiK65RTnUIqROujojM8ENwDIhNGaPtLQxZ6pakggsaOpPTi52mdkRXiIrVBsat14+NBBdW+UL4xiL45BN5pa75o92AXnrCcft/ANNaXPik7Gp+6Z/IpSXuCmw93WtslTkpIBlo+2rBMjy41X3a0gMFU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768312531;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=zegPgWfoIpnCcSvmFUz9CgHlfLJDn3gq/wRvOXjRKwI=;
	b=LowOEk+xhw/0cBMasHcWR4LN+RAkJ3JdQCokWWs2Lct8AZiROgDHuB16SJGsk+FO
	QHpV9nKl+CJyuDmL41XBni21b8B3i53FWmbGIgQ2HsFYA20eVjF2bQxl1Zs2ZcISb8a
	9kasL8f0+7oFGcwSNywDLZai3sXRQhvpbvz3DVu8=
Received: by mx.zohomail.com with SMTPS id 17683125287381019.5163981136584;
	Tue, 13 Jan 2026 05:55:28 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Emily Shaffer
 <emilyshaffer@google.com>, Chris Darroch <chrisd@apache.org>, "brian m.
 carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] hook: make stdout_to_stderr optional
In-Reply-To: <aWZKYAxhavFc1ZaH@pks.im>
References: <20260113115633.230479-1-adrian.ratiu@collabora.com>
 <aWZKYAxhavFc1ZaH@pks.im>
Date: Tue, 13 Jan 2026 15:55:25 +0200
Message-ID: <87ms2hipma.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Tue, 13 Jan 2026, Patrick Steinhardt <ps@pks.im> wrote:
> On Tue, Jan 13, 2026 at 01:56:33PM +0200, Adrian Ratiu wrote:
>> The last batch of hooks converted to the hook.[ch] API introduced
>> a regression because pick_next_hook() always sets stdout_to_stderr
>> for its child processes.
>> 
>> Pre-push is the only hook API user which requires stdout_to_stderr
>> to be 0, so it can be argued that pre-push needs fixing, however
>> this will likely break many pre-push hooks, so it's better to allow
>> it to be 0, i.e. to match the previous behavior.
>
> Okay. Do you happen to know whether we've got test coverage for those
> other hooks? Would be great to verify whether changing
> `stodut_to_stderr` to default-disabled causes at least one test to fail
> for every hook we've got.

No, we do not have test coverage in this area and this is also the
reason why this went unnoticed.

>> We can introduce an extension for the breaking change of all hooks
>> sending stdout to stderr, however this just fixes the regression.
>
> Is it really necessary to change this though? I wouldn't really want to
> go there without a good reason.

I'm still running tests on the full patch series, however the answer up
to now is no, I do not think we need to change this.

This means we can keep the existing behavior as-is and just introduce
some tests to detect when/if stdout/stderr output expectation regresses.

No breakage/changes to existing hooks.

>> diff --git a/transport.c b/transport.c
>> index 6d0f02be5d..8f0e5987ab 100644
>> --- a/transport.c
>> +++ b/transport.c
>> @@ -1372,6 +1372,7 @@ static int run_pre_push_hook(struct transport *transport,
>>  
>>  	opt.feed_pipe = pre_push_hook_feed_stdin;
>>  	opt.feed_pipe_cb_data = &data;
>> +	opt.stdout_to_stderr = 0;
>>  
>>  	ret = run_hooks_opt(the_repository, "pre-push", &opt);
>
> The fact that this was able to sneak in without anybody noticing shows
> that we have a test gap. Can we maybe have a test that verifies that the
> hook output goes to the correct standard stream?

Agreed.

I'll send a v2 containing a stdout/stderr expectation test for each
hook and remove the extension commment from the commit message.
