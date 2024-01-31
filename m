Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551B13A8D2
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 23:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706743795; cv=none; b=FexYfQbewzCwK5Orp8DHQAeMHBt6e5/wyEaDtiT9NcBSm2zOw4Ad4A5oaS1qFR0WMA8/hcXEZ2TIQmJOCIhipp2YpISyCbiaNi9Hs72iCGjZfYwqwyNv5yTDhxt6PWcP6SYEc0LSbuHpkQUD4eG0vAGromJ6sd+ZcLGOgD8Cd+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706743795; c=relaxed/simple;
	bh=YByMBpnJmIITnxNyVbZfSEZEzKnxoyuEHdDIBRlK/+8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aUAeVNjeyWapUpOPzfUAuO4JmtGs1kS1KpnhW7TYcEVLZIP5XS63E3A4txO5zfZ7wnf2ZX1vbX31+HgtuSz5AI58wkkGrNzssWVCI0nvirG2rjYuYfal/YlmNmb/jSRbhlqOqiqEDTRVhssiDiizIYqoas8zzZksm9RhK7ul4h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EoMTMvU5; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EoMTMvU5"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-295c3c55d0cso247518a91.0
        for <git@vger.kernel.org>; Wed, 31 Jan 2024 15:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706743793; x=1707348593; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x69/zrAi9w6GWTpUx3lAdQNP0pzza3gh7EDiyBtPE2s=;
        b=EoMTMvU5JV802j61z+6MBQJUrEHsovgc10as/HqeYNBgmgj9q+1lN+YijuLueBtwkS
         j+975YA9ofQ3imLSsRIijJvpnK3sqS530f09LPvo7bOIVDmNFydxGV17F3ljx9iZxhY3
         HU8rqWq/bXqy4o4InJt8YzdZU2W5AfPlx63Uj4kGnbG9xBeZOlk4FqdHuirej1hC75Jm
         2FrdMr+wm++asuEHgterqQSoXmN9sYB4QgL8SAZ+ZRpfT3DJ+aw1Bp15pwbJsiqZcT0F
         cbEorcr7ksrmGCrza1oUzF6v07AR2ivTIRq+CIH0JVQwzAMnh2H1lgcl4TAiXz4qaePm
         +EzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706743793; x=1707348593;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x69/zrAi9w6GWTpUx3lAdQNP0pzza3gh7EDiyBtPE2s=;
        b=VNmy0iJJdFzNEk0YKwYs0qra/NsjqKC+0lrz5JaoGaBZN5UbUFRAcQoazpVYC9P9B+
         P8fE9bbVCD/dmwdWbdENNkkizMoAZ+upGRAtY8+UPlfTT2YB/WAJMIRSOmNSbWNwRp/J
         uOyJ5JuZE6iTFFbd22nTIqMEu/BXqLk3YNujUT9v97kA8zxPxMexvvXH8nueAAjTZMLr
         Z1rLt5EFUoXwFQRrN/Xqu88oT1AENJfM9IWPPq058xGEcR4rh9Z5v/7gvjd8KWrHuF3a
         NJqP/2o/E6ZIKaiDZmSVly4zEwlIY+oXi9j2B0fzW+V+X2hDAhuK6gulLuW1YN1L28rx
         KUow==
X-Gm-Message-State: AOJu0YyFLDZE8Nmajx9XFyUuDgB7Aoy5S8MhRBWSiR4mFqfnYjUI6ABF
	k1yJyJfHozTJPUheYuXG1wRanFaEqp4/4+x55KF7hGQ14N1qhUGkzSCEE5JLEWBEONaZLfohGUN
	d2Q==
X-Google-Smtp-Source: AGHT+IFbLT8UU7smdwmE1tf9J1y2mJuu4Ax9AZLv3pY42uAOemhK8lUGP4pjF+WM6Dyg6QdjCW3VigPpmgs=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a17:90b:5250:b0:296:4d0:5840 with SMTP id
 sh16-20020a17090b525000b0029604d05840mr13396pjb.4.1706743793580; Wed, 31 Jan
 2024 15:29:53 -0800 (PST)
Date: Wed, 31 Jan 2024 15:29:51 -0800
In-Reply-To: <xmqqy1c545y0.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1632.v2.git.1706308737.gitgitgadget@gmail.com>
 <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com> <5c7a2354df0f4a29841f9ab8294ead0e1c3b9cf5.1706664145.git.gitgitgadget@gmail.com>
 <xmqqy1c545y0.fsf@gitster.g>
Message-ID: <owlyy1c513ps.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v3 03/10] trailer: unify trailer formatting machinery
From: Linus Arver <linusa@google.com>
To: Junio C Hamano <gitster@pobox.com>, 
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>, 
	Emily Shaffer <nasamuffin@google.com>, Josh Steadmon <steadmon@google.com>, 
	"Randall S. Becker" <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Linus Arver <linusa@google.com>
>>
>> Currently have two functions for formatting trailers exposed in
>> trailer.h:
>>
>>     void format_trailers(FILE *outfile, struct list_head *head,
>>                         const struct process_trailer_options *opts);
>>
>>     void format_trailers_from_commit(struct strbuf *out, const char *msg,
>>                                     const struct process_trailer_options *opts);
>>
>> and previously these functions, although similar enough (even taking the
>> same process_trailer_options struct pointer), did not build on each
>> other.
>>
>> Make format_trailers_from_commit() rely on format_trailers(). Teach
>> format_trailers() to process trailers with the additional
>> process_trailer_options fields like opts->key_only which is only used by
>> format_trailers_from_commit() and not builtin/interpret-trailers.c.
>> While we're at it, reorder parameters to put the trailer processing
>> options first, and the out parameter (strbuf we write into) at the end.
>>
>> This unification will allow us to delete the format_trailer_info() and
>> print_tok_val() functions in the next patch. They are not deleted here
>> in order to keep the diff small.
>>
>> Helped-by: Junio C Hamano <gitster@pobox.com>
>> Signed-off-by: Linus Arver <linusa@google.com>
>> ---
>
> I am not sure how I helped this particularly (say, compared to all
> the other patches on the list from everybody), though.

You made a suggestion to put trailer processing options first for
function parameters, which I've adopted in this series (but also in the
larger series).
