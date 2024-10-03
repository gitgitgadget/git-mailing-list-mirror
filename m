Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3976E170A15
	for <git@vger.kernel.org>; Thu,  3 Oct 2024 12:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727958206; cv=none; b=SXzWY5NPPT/W9aOoqITIzdcf6DidtnR+SOmExr7LbPQ9ycBU0kNmJ9SBFVYCkog22zyNQ7Ozzgi5fxRdUfVfzEUAEGpgDBCiaiwfmG6GXaSM7iPagW6cmPXtxheYTV+eNqMwjgaRy5YKZIPf7C3VSUzQBTaCjGmhyGPHLH4Nlqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727958206; c=relaxed/simple;
	bh=IcWUBhlXGqWpXDibDPvLgT2ByRZgiNXjRWAQG6A0iao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H9eOp3js3dJ/GQ04N2MX1+YEhE7ygR0smHs7Vq+8HwZ9noQZW8zcUCP/PlZjBZPPPl/XJfOj+/TOVSlaqD75mxRFk81T+NjDJMFCCMUD9uiWkwoHyy4U3403vR3fPhMP4UHwvsw9gQK8ZSHesPAscfP04h3PPb4Qvy0o/Bq6Zjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P354WLwI; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P354WLwI"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-71100987d1cso547336a34.2
        for <git@vger.kernel.org>; Thu, 03 Oct 2024 05:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727958204; x=1728563004; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZinnOSAWnOchZ0m9lmYFJFwowMdInejS7F8hwxjOssw=;
        b=P354WLwI9Zmxg2Y2B7Kv6k6N/g6YCkUMQW2XHTVHIVaOYjjfVQPyAlv2zbbtLv/PPh
         L9JLu3N3E+0ecj5ALK2wA472NGyxoFBUG0++gXz6Tpnn+r/ORqugSh6nLc2vOjf+f8/Q
         eTPzj8K3eyqMuafKJZnylump6SsA6mpcYx75ZX1ZspIGGfo/QctlfdTCB6eNdQ+W8gh6
         A01hPKrHksJ+AmmtBhGfIf8C8CrCQ4l1osvGVw7i1bAtN12+ggN6rDu2Y4D9j1hqOEaT
         ht1nqbemLIW9c+Z6yqPJ/xvGFCQZ662zSyPZF9amn5xX0d8BFqwH+Q5i6sbO9jmhbAcZ
         SqHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727958204; x=1728563004;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZinnOSAWnOchZ0m9lmYFJFwowMdInejS7F8hwxjOssw=;
        b=XZt0GCLuY3RyifkEUDjDfVgZ+WJteR8Uk+ikiLFwRM9hmnQQRTTb5uRJEjWXqsiq1o
         7JVdhcsIb3kCBVomCsVkFxWFfsacMqnatnbuquIrcE1oFK7lXLhD1HsxUyz08Oh2lbBi
         gWdzFklA5xVhAFwDmWiSRHBUwwBf8knESPvkV4EIyErbeqfu+gz3XDy/ywdt+GkS36dr
         bAAE4qRn38c1Awt9lTYBkqglxPpCh/ybwPtuWyFPqkHLJq9xr3CB21KH9jsC8m3qRu4N
         xi6vXkK1Osgzo3CvOqmYEqLDuv5zgV/dHPHojRpQOWoNUDuQFIhUuHhJ5tvXtydNnfxT
         Wv7g==
X-Forwarded-Encrypted: i=1; AJvYcCWVr+JIyxEPuw41jfFaneIgyRRidIbiYE85CCsDRB4nJUlqWWSWkx8MvuooZSOoB1GMu78=@vger.kernel.org
X-Gm-Message-State: AOJu0YwII6v3Py7q5FY+5rEQP/e4soPMSwvgjbPPRfcp3rMOzjELqg00
	ETWEkNeTd/qwKx5iOfhc1+9TuXJuu1Y4DpprrAjUl/nI7VfLlbZM
X-Google-Smtp-Source: AGHT+IGM/G5lnTx1/PFNQb076xmeMMa0D4u4vif7PrF6DN05OwrleW+x6K+M1OU5j2qGvx9uQYiXhg==
X-Received: by 2002:a05:6830:6306:b0:713:6f24:39b8 with SMTP id 46e09a7af769-7153cd9c285mr5074743a34.19.1727958204313;
        Thu, 03 Oct 2024 05:23:24 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:b038:cb50:a5ce:b021? ([2600:1700:60ba:9810:b038:cb50:a5ce:b021])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71547f07d1bsm308267a34.10.2024.10.03.05.23.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 05:23:23 -0700 (PDT)
Message-ID: <cf5fea7a-c711-4d35-9c6e-fe96778a3f85@gmail.com>
Date: Thu, 3 Oct 2024 08:23:22 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] line-log: protect inner strbuf from free
To: Jeff King <peff@peff.net>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, gitster@pobox.com, ps@pks.im
References: <pull.1806.git.1727885224966.gitgitgadget@gmail.com>
 <20241002235639.GB3455554@coredump.intra.peff.net>
 <1fc0d162-9814-4d94-ac67-2ea8e40495f4@gmail.com>
 <20241003061136.GA351404@coredump.intra.peff.net>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20241003061136.GA351404@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/3/24 2:11 AM, Jeff King wrote:
> On Wed, Oct 02, 2024 at 10:36:33PM -0400, Derrick Stolee wrote:

>>> I do think this would have been a harder mistake to make if the callback
>>> simply returned a "const char *" pointer. We'd lose the ability to show
>>> prefixes with embedded NULs, but I'm not sure that's a big deal. It
>>> would also help for line-log to use the existing helper rather than
>>> inventing its own. So together on top something like this (which I'd
>>> probably turn into two patches if this seems to others like it's
>>> valuable and not just churn):
>>
>> I do agree that changing the return type will make this easier to prevent
>> and the code should be easier to read as well.
>>
>> Your diffed patch looks pretty good. I made an attempt at guessing where
>> you would have split them (first remove the duplicate method, then change
>> the method prototype and callers).
> 
> Yep, exactly. I actually ended up with a third patch which is a nearby
> cleanup. I'll hold them back for now, though. Your patch is a regression
> fix which we should prioritize (though it sounds like it is in 2.46, not
> the upcoming 2.47?). I'll post my on top as a separate series.
> 
>> I even took some time to attempt to remove the static strbuf from
>> diff_output_prefix_callback() in favor of using the 'data' member of the
>> diff_options struct, but it was not incredibly obvious how to communicate
>> ownership of the struct which would need to store both the graph struct
>> and the strbuf. Perhaps this would be good for #leftoverbits.
> 
> Yeah, I think probably "struct git_graph" would need to own the buffer,
> initialize it in graph_init(), and then discard it in graph_clear().
> But that gets weird because apparently you can set the callback without
> a git_graph? Looks like that is triggered by "--line-prefix" without
> "--graph". Yuck.
> 
> But in that case we are just showing the line_prefix string, so we could
> return that directly. Something like the patch below.
> 
> The whole thing feels a bit over-engineered with the callback. The graph
> code is the only one that needs anything beyond a static string. And the
> way --line-prefix interacts with it is odd, since some callers override
> the callback (e.g., "range-diff --line-prefix=foo" is accepted, but
> doesn't do anything). I don't think there's a bug anybody cares about,
> but, well...it's not how I would have written it. ;)

Thanks for exploring this with the diff you sent. It's subtle, but you
did a good job of recognizing that when the callback is used without
a 'graph' value, it returns opt->line_prefix.

> +	if (!graph)
> +		return opt->line_prefix;

I was wondering why there was no need to edit graph_setup_line_prefix()
in your diff, and this explains why. Your change is simple enough to
handle that change while being robust to a future assignment of the
callback data.

For what it's worth, I attempted creating a custom callback with a
BUG() statement in it and the only test failure was t4013-diff-various.sh.
That test is very non-standard, and it did not recognize the process
failure, only the output difference. #leftoverbits could make that test
fail on process failure.

Thanks,
-Stolee

