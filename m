Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AA7186E2E
	for <git@vger.kernel.org>; Sat, 14 Feb 2026 14:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771079427; cv=none; b=TgFYy6Dipn03XERgGcjOEZtjSSjLpaAu3F99YG1yxQeuHmlzs7fG8j7LegjCie+Z5Bj8QiKzBEJI6GlPUY27HomNuC4rjZ6lAUw5Fec+SDeakmyCVv1x26f34tPW82vtDx3qRFKKmW9P+biqFF7e56HrO4xiAJBfAHkft4Vi/aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771079427; c=relaxed/simple;
	bh=5HdqEznKY0EL1NIVVW1zjFpJvODDvTeDz+HS6tLm0b8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gMdA+hF+bmsaqARlJY5brFpetBKuGve8RhLf3ZADF/ksFEnpdUUrbIlaDOAG+bnA03XpR5iNQqcdvwZMrKcqJxx27l7K2UIxlkgxpD72KzXteE2QWVRcpqn10DqP23aaVOgNLcWkNo75JRStXDRGdKWqJ+4dml86vfmKLbeHHzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cbMA0fpD; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbMA0fpD"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-4375d4fb4d4so1436164f8f.0
        for <git@vger.kernel.org>; Sat, 14 Feb 2026 06:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771079425; x=1771684225; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=86uz/h1ncx+7aW+5KDx74lwFzpu0o8ir8iMul250xn4=;
        b=cbMA0fpD3YIeVHDg9h7LXjxWc937i13lIrxOHV/mfHap/9AmDqqojj2E5xQRqp+CPc
         NshUfp2kA0zNL/jtIXGuofQZYNVMziTFSKH2A9+3psb6DGSL25O+EgW1A6dJT4iZdqc0
         HdYfP0aQBCiCKY5i9fEF/Qh/0mpQezKerTBpq+85QROIPcqaC5Y5EIYODNRGUPl7hJ6N
         rR6/1abvI7s5nZIzVIzgIzIWb+N0lzl+vu2xpv+RMI3x8ijxQB/dsFqACKM6JVgoLNJK
         lHVWyKJKJK0HfjgVPpcigbpb0xXEpaGOZRSx4Lf90J+QyH/voFdgqFHQhRZY+9MfHIo6
         s05w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771079425; x=1771684225;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=86uz/h1ncx+7aW+5KDx74lwFzpu0o8ir8iMul250xn4=;
        b=volHfLbRaGcasGC02uOeVOio2QP60eJ3uUO7I/hVmn4Ml2vZF1/7Lxku90+GVF+FCg
         cnmnVzcNWCtJ2YZ+oPa0EJpJNshIvqc8pfzkIBHvofpdgeqlTrHAMqM+YPKxMqDgXl8H
         4CTEWCfzx0cU+seQrUZNNynRjYxT/afC/LJJy00SvrRi7i1zl5P9WtpNUpfl7VisdgT0
         qznKYI4Q5oEerXFJZNFNgg+BuH83+9HKQXgrLXIuOy6S6wXvfJsy1pN8jWoC6cFMtWT3
         skai//yp/WsWvLq0gbBIz2LIjBFnfHzbsBhB43JyEIiydTDD/9UJhQ7/mvzJyPeInW5N
         U/rw==
X-Gm-Message-State: AOJu0YxdQiPAAoKZ8+wki7hd+hztv2AbLnOUM2vbAmmXJS+O3dhd12zL
	glRqQCmJzc1cdDft2oK8Y6Z4gmLCGh28/d3HzPBzPvSvMh9Et6ugXoty
X-Gm-Gg: AZuq6aI6yHL48zV+7EASnHSjph7fdX1oxSIUH8o+Wcaq5SjadgDn7PF+SBIDEp2IHhB
	iAGA0rzjt8v0kPmG4ObgiqLcVLmsNQ114utGap8LCwtwwdG/O7ctRgPM5lk08G5IkvnuVrJUD4f
	ao8puS2HUWR3IpyHZmHw4LyJG6XWr2KjokmacfEBHT6kUh60wEZPE3pchr/WQvb1fFwDaDjvnwO
	07yXxOPNoQxpPjRXI2q298sKo2vBJW8VfYqV47r8tKvdqXSHzvGVdHyZOnzT/IOBAR8MTomyWe6
	auhE+4JWjeH+zhJPTS8yfT+69sPmBkpzeou2ARwpYravUaP9+/yjAfZkwrWTpyxHRgLxmRz7BK+
	Pnx3CYQP0W0enxJCHX9NCtFhxOq/fJCVlUMJn7LMapAJ2qUthqdQI8gMP3RMElQZO5s+QlAxz5N
	cwsokcNVcCIftFMJS6eZaiORZWt5Tydu1tavL2++cg+Lh63A+uxxM1M5u+xIqa78YdyQffOc8UI
	LUkEQ==
X-Received: by 2002:a05:6000:220d:b0:436:1d80:b663 with SMTP id ffacd0b85a97d-437979279dfmr9740855f8f.58.1771079424553;
        Sat, 14 Feb 2026 06:30:24 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:68d:f601:6840:9d65:3109:8533? ([2a0a:ef40:68d:f601:6840:9d65:3109:8533])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796abe3b3sm15668401f8f.18.2026.02.14.06.30.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Feb 2026 06:30:23 -0800 (PST)
Message-ID: <ebc16a74-0555-4951-8ec6-ff7fce6b6fcc@gmail.com>
Date: Sat, 14 Feb 2026 14:30:22 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC][PATCH 2/2] worktree: stop passing NULL as primary worktree
To: Junio C Hamano <gitster@pobox.com>,
 Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com,
 Eric Sunshine <sunshine@sunshineco.com>
References: <20260213120529.15475-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260213120529.15475-3-shreyanshpaliwalcmsmn@gmail.com>
 <xmqqcy28jmzs.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqcy28jmzs.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I've cc'd Eric for a second opinion

On 13/02/2026 22:29, Junio C Hamano wrote:
> Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:
> 
>> diff --git a/path.c b/path.c
>> index d726537622..4ac86e1e58 100644
>> --- a/path.c
>> +++ b/path.c
>> @@ -408,9 +408,7 @@ static void strbuf_worktree_gitdir(struct strbuf *buf,
>>   				   const struct repository *repo,
>>   				   const struct worktree *wt)
>>   {
>> -	if (!wt)
>> -		strbuf_addstr(buf, repo->gitdir);
>> -	else if (!wt->id)
>> +	if (is_main_worktree(wt))
>>   		strbuf_addstr(buf, repo->commondir);
>>   	else
>>   		repo_common_path_append(repo, buf, "worktrees/%s", wt->id);
> 
> This is curious.
> 
> We used to treat "wt==NULL" and "wt->id==NULL" differently.  Now we
> use repo->commondir for both.  For the primary worktree, it ought to
> be the same as repo->gitdir, so it should not matter, but makes me
> wonder what the reason behind this difference in the original.
> 
> We have been assuming that wt==NULL and wt->id==NULL both meant the
> same thing: "we are talking about the primary worktree".  But the
> code around here before this patch seems to behave differently.  Is
> our assumption incorrect and are we making a mistake by conflating
> these two conditions into one?

My understanding is that wt==NULL means "use the current worktree" and 
wt->id==NULL means "this is the main worktree". That would explain why 
we use repo->gitdir above when wt==NULL and repo->commondir when 
wt->id==NULL, as repo->gitdir is the gitdir of the current worktree and 
repo->commondir will be the gitdir of the main worktree. If we look at 
the code in wt-status.c that's passing a NULL worktree it wants to know 
about the status of the current worktree, not the main worktree.

I think that we should add a new function

struct worktree *get_current_worktree(struct repository*);

to worktree.c that constructs a struct worktree using repo->gitdir etc. 
The worktree id is the last path component of repo->gitdir when the 
repo->gitdir and repo->commondir differ, otherwise it is NULL. Then we 
can use that function to get the current worktree rather than passing 
NULL when we call wt_status_check_{rebase,bisect} from 
wt_status_get_state(). We should also think about whether we should 
change wt_status_get_state() to take a "struct worktree*" rather than a 
"struct repository*" instead (I've not looked at the callers to see if 
that's sensible).

With that, we can gradually clean up uses of wt==NULL in the rest of the 
codebase overtime and eventually remove support for it from worktree.c 
rather than having a big flag-day patch. I don't think we need to change 
uses of wt-id==NULL.

Thanks

Phillip

