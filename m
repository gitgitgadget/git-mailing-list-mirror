Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D83433F8C2
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 13:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770731810; cv=pass; b=AzWOuH5R6ZyNG99B5YQQLXOJ1dYa6e1Unt2VPS7W79RsVp4/l5xqOLoBF2i4lMzcQQgQ7m6QrhY81B6E5Cgqxgo0hZ1kpWSomg/RwZid4OX9ITzMqzc2LQ290hZXnH6/fijbg250ij3txtoI8IMoP8I5oQhzBCtDnUBKN/7imHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770731810; c=relaxed/simple;
	bh=F9z0clVC8tUw4pPtXnRx4Rl5P915qPBExa2hC/sZV8M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=epuAGWjcDE0v8XiXP4wihq+lZ907Xgu/XNYEynqWDokzcS1kLXJLKHsVhJsskbhB3Ae/HZ6pklGaZeRSVooK49+kFuevbhULGj7MfFbQvsOpx+zJJtrUsmN+za1/Ac5fuvwhcsJkUCHgTa4QPUaFukr3bkTGlKGoi2NYHKVoUHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=IOe0tL7O; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="IOe0tL7O"
ARC-Seal: i=1; a=rsa-sha256; t=1770731794; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=U7877oVkj+baPT66dwL6V7R2ATjpyvq/cXt2n6MfGOaaNkqUiTAfxlZCparsdnw04rE+zSRnJZ5FpoULpRo0sQYKSpcPbpTClYJFDypQ8slLjchrFsrAPYDDAxCIDm6ybouUC66FcEFd9o/aku0S1gvoZNZvePkpp3oPcXyC+w0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770731794; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=fCMEEuosOG8Wtw5gsbl/GRtQq01rFhg9KGQai1CNXiY=; 
	b=GzHLncBjjDc36O55rq4N6MknRl99FFsm8NC06iTZBH+VMkxYgLLD3RYtacHsgQbDs0iTjNtBjLlr2wRXC+VEds4uP9Ul3aw3D+8d6lzfX18K69yzvYn85SYAmd/L/nxc7rPH2MxxynTP8B6gcu+UqvEYPdM1FUTvpPEwfO5+Uf4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770731793;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=fCMEEuosOG8Wtw5gsbl/GRtQq01rFhg9KGQai1CNXiY=;
	b=IOe0tL7ODCoCGiRnmLz9zKqIluxDKTmiaFww2VQRR+lop3ZHiXvhhMTDPDTYvU8v
	GHwZ0w3bYSFpI9I4nJkV0LWz17nfSDr4W0WYtxPaNKYutt7sTQx/6trwI9QnsZfI1FJ
	UW77t1HMC3hM/wQq1zk0Bjtbea4j1Opd8j1iQJTo=
Received: by mx.zohomail.com with SMTPS id 1770731792618600.9612052176412;
	Tue, 10 Feb 2026 05:56:32 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Emily Shaffer
 <emilyshaffer@google.com>, Junio C Hamano <gitster@pobox.com>, Josh
 Steadmon <steadmon@google.com>, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH 3/4] hook: include hooks from the config
In-Reply-To: <aYs2GGTU6UJWJFOf@pks.im>
References: <20260204165126.1548805-1-adrian.ratiu@collabora.com>
 <20260204165126.1548805-4-adrian.ratiu@collabora.com>
 <aYnu9gJATVJeKEjZ@pks.im> <87343920ny.fsf@collabora.com>
 <aYs2GGTU6UJWJFOf@pks.im>
Date: Tue, 10 Feb 2026 15:56:28 +0200
Message-ID: <87zf5gzoqb.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Tue, 10 Feb 2026, Patrick Steinhardt <ps@pks.im> wrote:
> On Mon, Feb 09, 2026 at 09:10:25PM +0200, Adrian Ratiu wrote:
>> On Mon, 09 Feb 2026, Patrick Steinhardt <ps@pks.im> wrote:
>> > On Wed, Feb 04, 2026 at 06:51:25PM +0200, Adrian Ratiu wrote:
>> >> +	/* Extract the hook name */
>> >> +	hook_name = xmemdupz(name, name_len);
>> >> +
>> >> +	/* Remove the hook if already in the list, so we append in config order. */
>> >> +	if ((item = unsorted_string_list_lookup(data->list, hook_name)))
>> >> +		unsorted_string_list_delete_item(data->list, item - data->list->items, 0);
>> >> +
>> >> +	/* The list takes ownership of hook_name, so append with nodup */
>> >> +	string_list_append_nodup(data->list, hook_name);
>> >> +
>> >> +	return 0;
>> >> +}
>> >> +
>> >>  struct string_list *list_hooks(struct repository *r, const char *hookname)
>> >>  {
>> >> -	struct string_list *hook_head;
>> >> +	struct hook_config_cb cb_data;
>> >>  
>> >>  	if (!hookname)
>> >>  		BUG("null hookname was provided to hook_list()!");
>> >>  
>> >> -	hook_head = xmalloc(sizeof(struct string_list));
>> >> -	string_list_init_dup(hook_head);
>> >> +	cb_data.hook_event = hookname;
>> >> +	cb_data.list = xmalloc(sizeof(struct string_list));
>> >> +	string_list_init_dup(cb_data.list);
>> >> +
>> >> +	/* Add the hooks from the config, e.g. hook.myhook.event = pre-commit */
>> >> +	repo_config(r, hook_config_lookup, &cb_data);
>> >
>> > There are cases where we invoke the same hook multiple times per
>> > process. One such candidate is for example the "reference-transaction"
>> > hook, which is executed thrice per ref transaction. Would it make sense
>> > if we cached the value in `r` so that we can avoid repeatedly parsing
>> > the configuration for this hook?
>> >
>> > We could even go one step further: instead of caching the value for
>> > _one_ hook, we could parse _all_ hooks lazily and store them in a map.
>> 
>> I think this can be done, yes, though I'm unsure of the performance gain
>> vs the added complexity. Since after the first lookup the config files
>> are hot in the OS page cache, the next lookups are cheap/fast and we'd
>> be shaving off only a few microseconds of parsing.
>> 
>> So I'm unsure if this added complexity is worth it or not.
>
> Maybe I'm naive, but I don't really expect there to be much complexity.
> Quite on the contrary: if we unify all configuration parsing into
> `hook_config_lookup` I would even claim that this cache would almost
> come as a side effect. We would simply iterate through all hook-related
> configuration and build the map of all hooks as we go.
>
> Whether it'd matter performance-wise... I think in certain cases it
> actually would. The mentioned reference-transaction hook for example had
> some worst cases in the past where it would execute thrice per reference
> update in certain code paths. In the worst cases I've seen it execute
> tens of thousands of times in a single process.
>
> Sure, these are outliers. But such cases do exist, and I expect that the
> performance impact could be non-negligible here if combined with
> non-trivial configuration.

Ok, I'm convinced. :) Will do it in v2.
