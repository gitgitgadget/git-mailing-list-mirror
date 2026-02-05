Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA841E86E
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 22:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770328853; cv=none; b=ZEPCANNyL+fwVVof2GGzO9dxYC0xXL4wazKUUvYh1GTiJ1iSVIbpxhQyzfdMroEm4p/KCxXiE8sLcMnpUleo+zl/YVqK96v8Mn3W1P1XzLq71Rkk9/JM4JNIBmaObbTSq9dC4/HtnjSwLVfjLbzDuWBkzmhpqfIQ8kW1zaGPCvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770328853; c=relaxed/simple;
	bh=8NT2iFuBAfAkPQhHFYL1D3RgIqw5nwJ9n5pwJXD48JI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nw2Co1ProRrLC+yahCyOTPK+9I98LoBuI0lwSKJUE41MS6RrwSRJUawAlDQBjg+8OFveR8+goHIKMFW+6jPcmYk9laMMmfHrEXYFjn4wQ1RAFCJPjp0PG+qeAya3x/07dfXIscm/JGWTN3SiEiIDVk4rYjJvbwiJ91CG1uu+jDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eKFH+uK5; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKFH+uK5"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2b7070acfdcso69539eec.0
        for <git@vger.kernel.org>; Thu, 05 Feb 2026 14:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770328853; x=1770933653; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jGRtag+wuArWyMrJhUkzWLYlR/IxmExEpA69riX048s=;
        b=eKFH+uK5hoVB0DdxCuHWXG4FGTEdlRQ9DxdtBnwsN486Qk/idHvTp6Ky/11g7q9pG2
         dULXrJCb5jPUvi5rqMqSBS2/6CW8yCdp2s1D9rOoN835CXWi0u8icNtYsYLU3t94cklv
         9MHM6ZbpJT9UY4k/rWt+Y6Fhmi5Sq4PY7KQke0q5HIOaGsCEnK59L+QXgr0xHUFvL7LX
         +NMZWAD4dwxUF6TJbiQgnT5okAymXpUvv2wKvk8kfKixqzdGSaQUJV9jrOl7hw0UqqLz
         S2JqFP938phSfWpZOsuu1bXUqi4TKkRhHe5oOE9RkFe8A5TAnZcWXpPhI7VDNG1SDvtz
         qCdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770328853; x=1770933653;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jGRtag+wuArWyMrJhUkzWLYlR/IxmExEpA69riX048s=;
        b=WGJ5V3HxqErabqfTQ40aH3mfrTEtPYUcN8Z1zmN7olmu7pin1ystMVfKwPps+8l3VY
         MI5TvPoXdvAritBmKoA6FtTKQ/oVHzy5nUYV8VqGbE3dasinf4SPg/WxG2epSPNzfvgJ
         qfIHsYQrv1yyGxFQNvZDWWYWSzRWQgVG1bLYSZvj5F+fte8AViRGLtkdzlQeI6xakp0W
         UKVQWr0PHZTBnZY+ChYc8Z9jUitmdISTlHk05ojqA1W9klq1ZUS/7KzCWUaNXJS1cqWy
         /XL3j6H/v37q09oiN8TUzvspOXTP4Li9T5iCV9VHIcLSpsZQt7ZBwhR9E9/EjRjhmKZ5
         ddMw==
X-Gm-Message-State: AOJu0YyMhizAwi5cifb/tATOv05LaR0Yj7r6S1tjjJy6cd1m9L1MeT+6
	wc+tS4TPqqhTyDZYuORNSFdGlA/LV8y4yiJX3hr5iLrQJC3fReed+qkP
X-Gm-Gg: AZuq6aJluSHr1WRT3+ZxmzQz8/NodoU4P3kWamHjZs6bxBNSPGZVOJ61pDByxSRp8x2
	cuUIqcWt33yeTt2/GSZ47WKixQdF1utWYC4QwlDhrFUX+syOVCeT56Y7Y+vsyyU6HpJTMSGQQHq
	myU3bNw8YYWo6Mscz+T9uZ7y2pgzGB5A1PBTSnQl/qFcG6dML3zyMwKh0sMR0Apqxak2cPxCqIW
	S7d1qe3eFqguSWMGi6aW067xnIqOfUK1jdNkiPs9iaAxT84R1rhWjUHzLVMBwHyWvDQGWx/N01C
	qYfVmtFzWKBlatVFxxmNFk2Tvpjc/hqwD6TXTb7t9w1GFH/p6nHRONwntwSMJXZ9hlclOe9boQh
	CVWn5ftFZ6Wu2EdY1VkkVh3qdAlOcC0GHmH01U/QrwOkAqN40s/0hY7qtKzQaR8OtQAAa
X-Received: by 2002:a05:693c:2b0f:b0:2a4:3593:ddf9 with SMTP id 5a478bee46e88-2b856a45ee5mr253116eec.38.1770328852012;
        Thu, 05 Feb 2026 14:00:52 -0800 (PST)
Received: from fedora ([2601:646:8081:3770::996e])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1270433ab31sm423597c88.11.2026.02.05.14.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 14:00:51 -0800 (PST)
From: Collin Funk <collin.funk1@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Taylor Blau
 <me@ttaylorr.com>,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] global: constify some pointers that are not written to
In-Reply-To: <xmqqecmzm66r.fsf@gitster.g>
References: <342b01acd42f1fcaa3abefa38dc589e12ccb1134.1770261829.git.collin.funk1@gmail.com>
	<xmqqecmzm66r.fsf@gitster.g>
Date: Thu, 05 Feb 2026 14:00:50 -0800
Message-ID: <87343ec0kt.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

>> diff --git a/pkt-line.c b/pkt-line.c
>> index fc583feb26..3fc3e9ea70 100644
>> --- a/pkt-line.c
>> +++ b/pkt-line.c
>> @@ -384,10 +384,10 @@ int packet_length(const char lenbuf_hex[4], size_t size)
>>  		hexval(lenbuf_hex[3]);
>>  }
>>  
>> -static char *find_packfile_uri_path(const char *buffer)
>> +static const char *find_packfile_uri_path(const char *buffer)
>>  {
>>  	const char *URI_MARK = "://";
>> -	char *path;
>> +	const char *path;
>>  	int len;
>>  
>>  	/* First char is sideband mark */
>
> Everything other than this hunk is adding "const" to local pointers
> and compilers will complain if we depended on them being writable,
> so this is an easy patch to review.  We can trust even this hunk to
> compilers, as the callers of this function would be flagged if they
> tried to write through the return value from it.
>
> Looking good.  I agree with Peff that the removal of unused NULL
> initialization would have been much better done in a separate patch.

Ack. I figured it would be okay since I was already changing the line.
But noted that Git is a bit more organized than me.

I'll send a V2 later which splits that into a separate patch.

Thanks both for the review.

Collin
