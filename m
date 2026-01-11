Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EA4340298
	for <git@vger.kernel.org>; Sun, 11 Jan 2026 14:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768140757; cv=pass; b=EFkaxSqFW0kbbRGMsjPetJaFlIhXZ9YDtDeEtwSQkWME+dzfd84gmZD1/7mxDv7Mj6AklVn60XHqCp/O+wAPkbsXgw2fXGGC59cHjiE4nd8+w8K/NCJlzmIl8wtBYjTkw+uOaSsfhMT8P7atcWJxlJ7bKLJCo0HlVyOXUAgZsqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768140757; c=relaxed/simple;
	bh=LwGHcRqJtiC5x2NUs0xn9Hfm3guSQZ5FYs+k7A+41yw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fSRhonqCtYGizw7NvLGsboMW3XuDtKkwCLrjZJ6tu7rgCU6jUokut+7+6qp0MCLe6cCjHgMz/Zd612+BxH9R/NxO6Kh9i94ER2nZXaK7KzIliMx/qjB0oVOteJcGKu7irzKDvoMwpI/Nchmeop0UFBxvGtgWtTVv6hDVVAqKEVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=UqDseaTX; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="UqDseaTX"
ARC-Seal: i=1; a=rsa-sha256; t=1768140745; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KV9XyVqC5jjL7A9uDHEyZuk4ztOSxKfzBxc1jd3sjwWjj0/lQ5/kdwG8qk+SfJ039QKc323nxL8SfbhqSfBSfgzkNLe7lO9UCjMRkYsl2wcNXrwavlRSofoeO9PeYV54cSME3tj2YHx9Ou34hpylXg/eqrSZxgQ+f2C9+leE4fM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1768140745; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=InRGb/Wzx3x87k92vgo9tWlGctUldSS/5zrEhuMxKCE=; 
	b=FMTK14fPG5oVSpiIu6pM279RkTULuZihh7OxHfqBnpwP7XjTrEvYg1V+3+K7QtyWXQHt2bhWTHbWF8R0X1OD3Q6fMMJoypD+bAv/qc2grxOiK53eOC2PGrjxOGW6bEZPrDZvyA+7V8vkRZ73AthK5EshQgx5sfkOmqQZpM9PDmo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768140745;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=InRGb/Wzx3x87k92vgo9tWlGctUldSS/5zrEhuMxKCE=;
	b=UqDseaTXeiOtW2waAvniHUgSOxdgR7jtzLTd1Msts0PaEfaPGFuH6mxE8M7t4DQ2
	MlVJOdM+g6f8l5WLH2rShWxYUqOg6UTsSPAU22yuud96P9MR2WgrE98v49bDai1qBHW
	PkhFpkC/ewiTGH3HwN5CGAoxEQppyjQZvAZ99eso=
Received: by mx.zohomail.com with SMTPS id 1768140743437438.14218075256645;
	Sun, 11 Jan 2026 06:12:23 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Emily Shaffer
 <emilyshaffer@google.com>, correctmost <cmlists@sent.com>
Subject: Re: [PATCH v2][next] hook: check for NULL pointer before deref
In-Reply-To: <xmqq344etd9v.fsf@gitster.g>
References: <20260109181912.689409-1-adrian.ratiu@collabora.com>
 <xmqq344etd9v.fsf@gitster.g>
Date: Sun, 11 Jan 2026 16:12:18 +0200
Message-ID: <87ecnws0fx.fsf@gentoo.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Fri, 09 Jan 2026, Junio C Hamano <gitster@pobox.com> wrote:
> Adrian Ratiu <adrian.ratiu@collabora.com> writes:
>
>> Fix a compiler warning (-Werror=analyzer-deref-before-check) due to
>> dereferencing the options pointer before NULL checking it.
>>
>> In practice run_hooks_opt() is never called with a NULL opt struct,
>> so this just fixes the code to not trigger the warning anymore.
>>
>> The NULL check is kept as-is because some future patches might end up
>> calling run_hooks_opt with a NULL opt struct, which is clearly a bug.
>>
>> While at it, also fix the BUG message function name.
>>
>> Reported-by: correctmost <cmlists@sent.com>
>> Suggested-by: Patrick Steinhardt <ps@pks.im>
>> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
>> ---
>> This is based on next, because it fixes a warning introduced in next.
>
> Actually the problematic topic has been in 'master' for a few days
> already, isn't it?  I'd apply directly on top of ar/run-comand-hook
> topic.

Yes, that is correct, the commits landed in master so this patch applies
cleanly there as well (just double checked to confirm). Thanks!
