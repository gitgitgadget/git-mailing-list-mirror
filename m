Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338D27E9
	for <git@vger.kernel.org>; Sat, 24 May 2025 03:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748056244; cv=none; b=WRbWBACKVo0vGFM3RSUEw0BWnDW+v4cDFVTj81tGmnU8t7NVjG4taTT91jz44sM7mDl/rBK0LE/LsOp9mhow8o26Y4K7nJuVLD52QZuAfu/S46MHJvTSKdsT27s6IKGUJjrhY87PiFVDglNF2c+GUH8QovO6euPcsCTdCYqcwvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748056244; c=relaxed/simple;
	bh=uZzCpscutYkhUoejP7QA4OpSnEr9JH8LsBVAIm/qgSs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=R7Jf41rKpKARzScfFYsxemJDK9tOGCRNHvlCm34nDKcdJt5F7GisreaJk4ZOb3bvEE/F7UQVpYr2xWHSerdcW58fHcMDqIdnzO61R20h76eFSMiK3UdAK8n66J0KyN6kqXYp4+/Yan2TZCt+TkbxPUHySTdTdxKW1bZ0eKOMcW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nBrqoktD; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nBrqoktD"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c54f67db99so158580185a.1
        for <git@vger.kernel.org>; Fri, 23 May 2025 20:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1748056242; x=1748661042; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dkfsGfWimu++csueREGcugWZbW/pbu4DPgJR6AjOHqk=;
        b=nBrqoktDiv041K4+NF1tZyCYyOLC8UKH6PStuc+eD9d5sdI/Cw7bp1Qx8ztSNhHrAj
         FUW/NL1vkmzVhQAKB8G3K+vwyQD4P7Xbvql6qtYHFMh9N7dRpoeqk5kxIm97YWr/icR1
         WA6UU2fB8zjCGExAE+TweMKOlSnYanV9wms+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748056242; x=1748661042;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dkfsGfWimu++csueREGcugWZbW/pbu4DPgJR6AjOHqk=;
        b=ofbpW6An+YUp8X3z9xYwmjjr5gQJlsImr7K1sPDymwr+v4Z5HIj7+kUX+gGU1nP5G8
         Uc/ohuBMSt7ktOXMCFFvqcY0nIVaNlupX1/9kN0un9SvedU2qg7dmiqx3TFsKvFcWt7s
         MLm90CrzdlfClaCBkicrcTVd1wXm1oZZC73h7VpjvaZnzJqbMAMT5FM3NGZU3cgTKrpy
         gknb/NZ9q4oA5ij0iIdQOPdoRyNbkSz0Dy6QsBdqYpjM0FhR6KFLgzThBknPlp9nDQOo
         pLvNhbcVCdvG5m6HpO4xtOL75QUzl2Vc6nyaACN3ZtbLoDffl9pg6qANwobtXbZbsOG9
         C6eg==
X-Gm-Message-State: AOJu0YyRh7hHUWcvKM+zynPLWSLFpi6gpkXvPmLWbP0wxAWXGVp0YYvn
	UkfP9nGBXWG9+HlUIN96h4mZAsoDQTu7TUIilsmU2fHjqjlAAGq67RBtltDWnuoj6xPtWyluF9l
	scffNpQ==
X-Gm-Gg: ASbGncta4YFzmiW0OsqygaxfIk1ajewXBsfPjuXCd7+LgIkIfoXhLIiygYw7YMvCk/E
	lBUDh0ynU9r8KrWpTJEBUvO2AqgBkvmbxl2SSelqAaNzq0SzGVjmGz/ekVhQppDZ70gAS6ELrYu
	2jblSQJpM+gr/d04UwNzNaPQ0GVuauzTNXljGUGlTTcXAWf6peSbTjaUg/BONeLevnhOJ076Iif
	dvrBR/N0tm4rcc+jdmjGOrxFTzY0eMzQByusSyhZtRF6vMR9iOiPmgWRMaCKfzrO17d1TVkQwQ1
	o9QgRMQwQsi6AbzKV7dWR59LiYol1qo2+1nla3n7rgTAtzjbtbNBwrBnPq9pMq85ppRwCGRk42J
	i0ULDEQ3Tl3CHXWmv7yhYcgRj76hKmyCnBCZoI0A=
X-Google-Smtp-Source: AGHT+IE2pIPzWf3doJtJB4WYmjXHo488kgk+Z5daNdiDACaaeAqGX7aM+dFEZmvwhsKRB+RyqWeKOQ==
X-Received: by 2002:a05:620a:4246:b0:7c9:38ce:becd with SMTP id af79cd13be357-7ceec49d71bmr260653385a.22.1748056242039;
        Fri, 23 May 2025 20:10:42 -0700 (PDT)
Received: from [2600:4040:9ce0:6400:e585:dc50:f5e1:64e7] ([2600:4040:9ce0:6400:e585:dc50:f5e1:64e7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd468edf57sm1265816885a.114.2025.05.23.20.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 20:10:41 -0700 (PDT)
Date: Fri, 23 May 2025 23:10:27 -0400 (EDT)
From: Mark Mentovai <mark@chromium.org>
To: Junio C Hamano <gitster@pobox.com>
cc: Git Development <git@vger.kernel.org>, 
    Chandra Pratap <chandrapratap3519@gmail.com>, 
    Johannes Schindelin <johannes.schindelin@gmx.de>, 
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2 1/2] t4129: test that git apply warns for unexpected
 mode changes
In-Reply-To: <xmqqmsb2vr6z.fsf@gitster.g>
Message-ID: <d14135de-ddbc-0875-3ffe-700a2fd33d90@chromium.org>
References: <20250522220235.8650-1-mark@chromium.org> <20250523172154.93810-1-mark@chromium.org> <20250523172154.93810-2-mark@chromium.org> <xmqqmsb2vr6z.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

Junio C Hamano wrote:
> Mark Mentovai <mark@chromium.org> writes:
>> diff --git a/t/t4129-apply-samemode.sh b/t/t4129-apply-samemode.sh
>> index 2149ad5da44c..082e56db651e 100755
>> --- a/t/t4129-apply-samemode.sh
>> +++ b/t/t4129-apply-samemode.sh
>> @@ -102,15 +102,23 @@ test_expect_success POSIXPERM 'do not use core.sharedRepository for working tree
>>  	)
>>  '
>>
>> +test_file_mode_staged () {
>> +	git ls-files --stage -- "$2" >ls-files-output &&
>> +	test_grep "^10$1 " ls-files-output
>> +}
>> +
>> +test_file_mode_HEAD () {
>> +	git ls-tree HEAD -- "$2" >ls-tree-output &&
>> +	test_grep "^10$1 " ls-tree-output
>> +}
>
> The script is about testing executable bits, so it is fine that the
> above cannot be used to expect a symbolic link (if we wanted to
> support it, we'd just take the whole 100644 vs 120000 without
> support to let the caller give abbreviated input).
>
> But then it is curious that this asks the caller to say 0755 vs 0644,
> not 755 vs 644, which would be sufficient.

The leading 0 was because I prefer to present numbers represented in octal 
in this form.

On the basis of your comment in the 2/2 patch about using 000000 for an 
absent file, I'll change this to use the six-digit form uniformly.

> Very portable way to add an executable file.  Would work regardless
> of the filesystem.  Very nice.

Thanks!
