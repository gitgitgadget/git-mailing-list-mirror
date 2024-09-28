Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F5E14F119
	for <git@vger.kernel.org>; Sat, 28 Sep 2024 09:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727516966; cv=none; b=hdt1eU91UuYVOzXdGaTR6rzbr49h9dAysdlvYjdregtw5BNThvkaRNVQOt5HCnOUfqjPQMiiNQmtwv/Bsn049kKSl0xjoRsH8XmirjleOzQiQARjxPimeZSl0z5qQ15jZ1xeWsYDwXj5utwKgjjX7eLkdRJORujY/OG46pwfOks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727516966; c=relaxed/simple;
	bh=qHoB5J7a5zkbFymwer/HdbbJKijAt1K/XG+YR55qz/U=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=CF9HOzrENwBuyNa2GdTHdwoSzLsA55xTzhraf0EwNeE60P2gTsItOtKUOl1u2QpiXzbxQ3ckbumq4xAg2EepsvMiVs/ceGAi1xc6EFPB5s72Ki5400MyCghTXexWWUlP1zULRFcJyKzw695czWA4+0Gjm0QUxvshIPfR6SMc4KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R/5Ufp/S; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/5Ufp/S"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42cb6f3a5bcso35330305e9.2
        for <git@vger.kernel.org>; Sat, 28 Sep 2024 02:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727516963; x=1728121763; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3a4DjZgybpIIfZ5fxrwxDbCYvQtWoSZQ/Iiqrxxu+NI=;
        b=R/5Ufp/SzJu5s/iTzmu0NyjQoC/9SUgAoypw3JaKOiH9IvnPjmWV1BQxpw06BkQ+jp
         rKw/IBgTY8wWRMCFdbasRQzyEv40F4+AEzaW1o61LSUuI7cFiwPL7LcL12AZuML2QGR5
         O4WGyEGjzNjsX3cdVXAdobXEq9XvP45W3wbL4RVtwz4u3X5UfB0LbL059hOcXaUejfRi
         4tcN+a+KaF2Z3v/Rw2aeDeZ6Y5mb0RWhIMldvXuh337DR5vZA8d3bN/5KFY6HY2PS3f3
         2Y04xjv0ueYOGx2iKFXqbmYMhjeDwZ8JgbG8z37nPiRL9Knmg4GNWtYd5cg/2yQSPQgc
         mQ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727516963; x=1728121763;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3a4DjZgybpIIfZ5fxrwxDbCYvQtWoSZQ/Iiqrxxu+NI=;
        b=L93gADmHHVKommfmggqkaWlLDavfB9Ech1xKMI7mlnUN8n7t8Mf37kqUHorHS/95Y+
         WAIuXfqZEw4SrDUOHWgRNQdpKd3TU92tSRQ+JXAK/8unhKC4FzwhQDzt5D9F9VKoTC1O
         97lbtVHIVSQD0NYWxaGZC3hQMM1UBS3i66HvNGo3IWK4hczPkpXrKwha8E8qFkkOaAFt
         W4vB5e6IE1OOhUfNE+uFz0k/Ysk7PigmbzWfWbhhgLx2k6Qj2V01jobP6ByYlff11ZdS
         ScMlAKsP2h4+eUqKxE09SJ8i23wx77DNphtbLUVa6btGwUngVQsX+qdSvOdilwTvPjmk
         Do/g==
X-Forwarded-Encrypted: i=1; AJvYcCX6Ttq0Jt6f0xN+j3qAD9iInddCxLL746ObL0Wu0rfIy81OuyMOrsH7YfXWGuQy+wN/23c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcXV1AZ3tcxJOxwLqxHJ222/77uwf6IIjq1xYWIfNfN+uCIzyQ
	G+43oMUSznIJzZdXVZTiRzL4CLNKocejmkdgy1sgcIVSNtagJkCM5lKA5g==
X-Google-Smtp-Source: AGHT+IH79Hpt38HNebs4w5YEbSmC9dtn0WF8pfIb/b6kWs9ENNI/5fN4kJrw7lWQC2YQbZUqCeyw9A==
X-Received: by 2002:a05:600c:46c5:b0:42c:b62c:9f0d with SMTP id 5b1f17b1804b1-42f5844c0acmr60079765e9.17.1727516963124;
        Sat, 28 Sep 2024 02:49:23 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:61a:f001:1402:4f50:9447:3e15? ([2a0a:ef40:61a:f001:1402:4f50:9447:3e15])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27da39bsm231648866b.90.2024.09.28.02.49.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Sep 2024 02:49:22 -0700 (PDT)
Message-ID: <aa981bb7-dd3b-4e63-9769-0fc2559983e6@gmail.com>
Date: Sat, 28 Sep 2024 10:49:17 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: How dangerous is --committer-date-is-author-date these days?
To: Johannes Sixt <j6t@kdbg.org>, Git Mailing List <git@vger.kernel.org>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>
References: <6af09726-e3bf-4903-87ae-9524ad334678@kdbg.org>
Content-Language: en-US
In-Reply-To: <6af09726-e3bf-4903-87ae-9524ad334678@kdbg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Johannes

On 28/09/2024 07:59, Johannes Sixt wrote:
> The option --committer-date-is-author-date of git-rebase rewrites the
> committer dates like its name suggests. It is not uncommon that commits
> are rearranged and cherry-picked. Then, as a consequence, author dates
> are not decreasing when walking back in history. Now, if such a history
> with a non-monotonic author date is rebased one final time with
> --committer-date-is-author-date, this creates a history with
> non-monotonic committer dates. I recall that this is not a good thing to
> have since it can confuse our history walker.
> 
> - Why do we have --committer-date-is-author-date in a porcelain command?

Support was added to the sequencer to reduce the differences between the 
two rebase backends in the hope that one day we'll be able to remove the 
apply based backend. Support was added to the shell based rebase in 
570ccad33e (rebase: add options passed to git-am, 2009-03-18), there is 
not much discussion in the commit message or mailing list thread [1] 
about the motivation for adding this support.

[1] 
https://lore.kernel.org/git/1237409629-4289-1-git-send-email-barra_cuda@katamail.com/

> - Should we remove it?

It is only a problem when re-arranging commits - even then I think the 
commit walk machinery has some tolerance to commit dates that do not 
increase monotonically in order accommodate clocks that are out of sync. 
It is perfectly fine for non-interactive rebases (or just squashing 
fixups) so removing it seems like throwing out the baby with the bathwater.

> - Should we require an explicit --force instead of implying it?

I think we'd want a convincing reason to change the behavior - the other 
options that require the history to be rewritten all imply "--force" 
rather than requiring the user to pass it separately.

> - Should we issue a big warning about the consequences?

It would certainly be worth adding a warning to the documentation. To 
issue a warning at run-time would require us to check that the commits 
are actually being re-arranged as there are plenty of reasons to use 
"--interactive" without changing the order of commits.

Best Wishes

Phillip
