Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3417D19C546
	for <git@vger.kernel.org>; Wed, 18 Mar 2026 19:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773863435; cv=pass; b=Yt5zWnjf8B+soPE1gyE5HWxwywMR0dINEFUL/xqGe/sH/KJZRb/LUfpybGNPUXmSPytSdHlvE10vI5BpMhtfB7B90sGusbXVI4KVVJdnr4fEUiIi/O6Rb7iFT9mvdi8y3dfMAm6ryUqKDCjMcQoFNcIKVhNRK4t8+e14WVvr5QY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773863435; c=relaxed/simple;
	bh=OMuWnAGIgFuDqAhp7tIJOg/X+lOGcxpWqFiSksWwprw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G2RYQ1Az2kvLGADNjS7pwbM1fFZCaB4tLhCa946iffKLTtQR0GKwbY6IcSob7heaW2IgVYJsl8QnAiBbEVxV4iPUTlINb86xRddPagLm9Z62YXjRJvUaZ7q12oKlvjU5ECaMGynjaAX2R/ai3oH6ypmLIW95lgXnjt7hd11Awo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=jmpVhPDs; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="jmpVhPDs"
ARC-Seal: i=1; a=rsa-sha256; t=1773863414; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ceRt5dycyU1dWvVubX5/Lt62Ne7DWzGo+UB4YOnqDzaGjBeqaGp3BOBIJS6MBcx4z4XF+L3By0V/kCMI6uEWVvXgypvoXC0Ij8ya+FycMK/VD/RreGA9i01BhVx2F4sIpgmvCxzBf502Em1z7poML2wYeDmJeUWyttgNrnMD+XE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773863414; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=yV5JFSOqyHcc/9Im6y9MvqizGhhQaGgc/jTwWY5uLSY=; 
	b=PEa6tyUmVw3tkIf4vXEhBQ1ird1cPZTUBl8txmDvsBxns0EI+nLJEvhhwnCawcOwAzzsCFJxZWC5HPzFj+8uCW0ac/YSBMHUyq+y6kKOIfvmgjCd0ewWLqQanwplAwEItCp4iQ4i/xCtBG4MASHKs6dbz5BCk1BPyTHzG9PrWIw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773863414;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=yV5JFSOqyHcc/9Im6y9MvqizGhhQaGgc/jTwWY5uLSY=;
	b=jmpVhPDs0wv89Izl9DPZ3snP09o1+hwiM8zHz6jq2JdejgmM7uNCW5fjhcRNXiU8
	UHeyzLjyNlX84PRxE7es/EIxDKzAgNYiQQ2sMnc9kookeyfA0deWTYDStYA+BrXtcPi
	/WORLHAWEMTvpQLSXRWUICFq40XbEF55bJQt+7V0=
Received: by mx.zohomail.com with SMTPS id 17738634128408.939589551827567;
	Wed, 18 Mar 2026 12:50:12 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Emily Shaffer
 <emilyshaffer@google.com>, Patrick Steinhardt <ps@pks.im>, Josh Steadmon
 <steadmon@google.com>, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>, "brian m . carlson"
 <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 8/9] hook: introduce extensions.hookStdoutToStderr
In-Reply-To: <xmqqy0jrobqn.fsf@gitster.g>
References: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
 <20260309133739.294555-1-adrian.ratiu@collabora.com>
 <20260309133739.294555-9-adrian.ratiu@collabora.com>
 <xmqqy0jrobqn.fsf@gitster.g>
Date: Wed, 18 Mar 2026 21:50:08 +0200
Message-ID: <87pl5029zj.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Mon, 16 Mar 2026, Junio C Hamano <gitster@pobox.com> wrote:
> Adrian Ratiu <adrian.ratiu@collabora.com> writes:
>
>> All hooks already redirect stdout to stderr with the exception of
>> pre-push which has a known user who depends on the separate stdout
>> versus stderr outputs (the git-lfs project).
>>
>> The pre-push behavior was a surprise which we found out about after
>> causing a regression for git-lfs. Notably, it might not be the only
>> exception (it's the one we know about). There might be more.
>>
>> This presents a challenge because stdout_to_stderr is required for
>> hook parallelization, so run-command can buffer and de-interleave
>> the hook outputs using ungroup=0, when hook.jobs > 1.
>>
>> Introduce an extension to enforce consistency: all hooks merge stdout
>> into stderr and can be safely parallelized. This provides a clean
>> separation and avoids breaking existing stdout vs stderr behavior.
>>
>> When this extension is disabled, the `hook.jobs` config has no
>> effect for pre-push, to prevent garbled (interleaved) parallel
>> output, so it runs sequentially like before.
>>
>> Alternatives I've considered to this extension include:
>> 1. Allowing pre-push to run in parallel with interleaved output.
>> 2. Always running pre-push sequentially (no parallel jobs for it).
>> 3. Making users (only git-lfs? maybe more?) fix their hooks to read
>>    stderr not stdout.
>>
>> Out of all these alternatives, I think this extension is the most
>> reasonable compromise, to not break existing users, allow pre-push
>> parallel jobs for those who need it (with correct outputs) and also
>> future-proofing in case there are any more exceptions to be added.
>
> Hmph, I am a bit surprised that this is not hook.<name>.stdoutToStderr
> controlled per hook process.

You may laugh at me, but making this a per hook process setting (or
per-event) didn't even occur to me until now. :)

I think we could do this and let the user decide if their hooks are safe
or not (i.e. do they expect output on stdout?)

Or even better:

Since we now default to jobs == 1, that already keeps backwards
compatibility  (initially in v1 I turned parallelism on by default,
using the number of cpus, so this extension was unavoidable).

Therefore if the user opts-in to parallelism (via config or -jN), we can
just document that output will go to stderr instead of stdout.

>
> If we already have consensus that giving output to stdout is a
> historical wart that we would rather want to fix, then this
> configuration is probably good enough.  It is certainly a much
> simpler approach, and there is no need to make finer-grained
> customization available when nobody wants it ;-).

Agreed. I don't think anybody (including myself) wants this extension
and if we do what I suggested above, we can drop it and don't even need
a hook.<name>.stdoutToStderr config.

Will drop this patch and the next one in the re-roll.

>
> We may also want to consider "fixing" it at Git 3.0 boundary, if
> that is the case, though?  I dunno.  I weren't following the
> discussion closely enough to tell myself.

There's only 1 known breaking hook, however now I'm convinced we don't
need to break backwards compatibility with my "even better" approach
suggested above.
