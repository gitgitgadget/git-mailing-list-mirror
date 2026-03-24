Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B0E23EAB4
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 22:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774391622; cv=pass; b=Olse0CwENXbBHAyiJIXL0+ftsb2b2c/tfnDK040ebDrrmojU83Iojw/L6yusw5MjUX7QqMlIXzS1Y2bsa8Q3LTKbmRFjChC7cGLQHL3L4w5ihkl3YwZ3NZ0SDOcLyiID7bZcyOd5SzVlZk2vpw+4M0eN9C/vpLoD0QQMERY87YI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774391622; c=relaxed/simple;
	bh=Oq5tPTD8ywthpcZBy/pf1PAWbyRpyFaMWr7jC3mSyGg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UIDJtk8d0drGILXbUVtOEQL1yai9hvw/TZ1YSsRsAlK2G4q5tyoCEv3YkL+lVlQg0ZC6jZMfilCYuVMq+mqC1hx1iBi/8a8aY3I6PXxWe0nW3dBtMEE/OA/KOKWrwMgx2f8EtrrXPVDIsaNMixjrEonCY3tFooQciqA6n+qi1g4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=BwWlfGJb; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="BwWlfGJb"
ARC-Seal: i=1; a=rsa-sha256; t=1774391606; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=H0OP/V7BgQW2I1lBJa+sDc7knn7aKIGIhe3CGLMUaWaGB1v6T/gD9nhiY1UzMbObeAg7JMB3Xsl63/mxVohZndyTkGoPGZUFzAeVkIGkowdUmnvtNTjd+KghdZY/gRuHcbLFzQ4ryN492DvCePfLe7hZSK+pwF1ecWtdnhXw+3I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1774391606; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=NvdPEZ15dK53yiRKnkdm808/RSpI46bL8Wlm29HFcPU=; 
	b=VSokudAWKAilIK0+FfmcZV2987GJOz4AZ5IDAR4rCxirP3Ek4udK8yJkvsQJVFIxI1HHtZvUvSJKbaN0jSHj8qEfJ7XbaDlLAGBrKfDSgl8JgnDntgMEg26AKjlJQ+Vf2aDR+3iLA9ovz18tCg+dSaPwuF3+yXFTITwIkRhKRAQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774391606;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=NvdPEZ15dK53yiRKnkdm808/RSpI46bL8Wlm29HFcPU=;
	b=BwWlfGJbbOneqJsqX0E24bTJxnPVl6L0aM6cgxnaGccfAuxUhtsp6adi+WvvqnFJ
	GmEkI31Fu5BgDH/laHxs7LYssC+oRACQvBN0afuBzYlK5SheIowODmfNIV6y7pHBILl
	3wtHnV67+OLagIf0Ce/FdqeNO8+Gs/gZwMEGCFLI=
Received: by mx.zohomail.com with SMTPS id 1774391605394145.9579702728538;
	Tue, 24 Mar 2026 15:33:25 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Junio C
 Hamano <gitster@pobox.com>, "brian m . carlson"
 <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 05/10] hook: replace hook_list_clear() ->
 string_list_clear_func()
In-Reply-To: <acJNYPgOSO86hZYq@pks.im>
References: <20260309005416.2760030-1-adrian.ratiu@collabora.com>
 <20260320115211.177351-1-adrian.ratiu@collabora.com>
 <20260320115211.177351-6-adrian.ratiu@collabora.com>
 <acJNYPgOSO86hZYq@pks.im>
Date: Wed, 25 Mar 2026 00:33:21 +0200
Message-ID: <87bjgcdfim.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Tue, 24 Mar 2026, Patrick Steinhardt <ps@pks.im> wrote:
> On Fri, Mar 20, 2026 at 01:52:06PM +0200, Adrian Ratiu wrote:
>> diff --git a/hook.c b/hook.c
>> index 6dfaa7e9b1..f6bb1999ae 100644
>> --- a/hook.c
>> +++ b/hook.c
>> @@ -52,8 +52,14 @@ const char *find_hook(struct repository *r, const char *name)
>>  	return path.buf;
>>  }
>>  
>> -static void hook_clear(struct hook *h, hook_data_free_fn cb_data_free)
>> +/*
>> + * Frees a struct hook stored as the util pointer of a string_list_item.
>> + * Suitable for use as a string_list_clear_func_t callback.
>> + */
>
> This comment should probably live in the header. I also wonder whether
> this wrapper isn't a bit too specific to freeing hooks with a string
> list. Maybe it would be preferable to expose a "proper" `hook_free()`
> function that only takes a hook, and then provide a small wrapper
> function for freeing in the string list?
>
> If so it feels like we're going a bit full circle though. Maybe the
> original code wasn't all that bad in the first place?

I prefer this new design (suggested by you), because:

1. We use the generic string_list_clear_func() API.

2. Each struct hook owns its data_free callback, which means that callers
don't need to keep track of internal state (e.g. when to pass NULL to
skip cleanup).

3. The hook API itself is cleaner for hook.[ch] users, because it's
always string_list_clear_func(head, hook_free); regardless of context.

So if it's ok with you, let's use your new design. :)

I'll move the comment to the header (it's already there, I just forgot
to remove the duplicated comment in hook.c above the function
definition).
