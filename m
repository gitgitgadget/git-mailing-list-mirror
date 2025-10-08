Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B59223DCE
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 20:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759953735; cv=none; b=I84omIe+tPW9gj69J+jUn+BlD2Chzyjy70er+Iwddpie/ohKjuL6AdWFzyoDratOKkKdD+KCS97C6Yr67BIwFtL2JW2ThRC0anvq2sfNYzs8r6rVJgVZ65KN2J/PnXDV3ZyYGPx7ntQVVsN/Ud9pW9H49nlxlVV0mz8H9twZsiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759953735; c=relaxed/simple;
	bh=IAFevB92oTYCdqJedc54/ba0VejQJhdlqf/rdf9Bqyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IVFPRHL4fIFtcf67RTf+wYiTlQn7tZKYjGhEH4soHNklNMGM2QWpU8GwC4NBfMKUoeTqtv7dO//DeHe6QCf9wnoC8wGbCzWd3qZ2inDp6mqxCjcHkp2Tyu+vl+ISf929cew3RQ/gI0fWZ+OZVgcEfpfAQWBQw7AZvHQsKn+3cHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1AoFnvg; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1AoFnvg"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b63148d25c3so221628a12.1
        for <git@vger.kernel.org>; Wed, 08 Oct 2025 13:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759953729; x=1760558529; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HTXUZDEQaTe1WiH32EjXMIGDfZISI+K0ZVh+VoKJdf4=;
        b=F1AoFnvg+J40HCjOhv6x9xVLgV15wXnvQt5SAke74wA6027DNw+DdshjDv4eXnT3zO
         voJDOVLFLvynewP3E4WvR2ZSwTpaaT3tvALqm46ZOF1N3V95OsX/H4j5To/Rz2uo7TfT
         hn9c++J24HrE/JlBxWPbiie7Ksq7n0wfMLV5mO9JjIp99RF7cNwRJg85yQDdtRAAdYaO
         dAjb02m7Eza03EaQHA3s7PF9HKJkFEeWRJFWi4yLU/el/B3ANPqfsoFy7A7cI6RNTvrs
         +OORY3SRhPks4mx1Xc3VfEOMt0PusqAbrN+xH9dDhU9Kw2Iwd9HFjUle3F2InE71J8hL
         JsPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759953729; x=1760558529;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HTXUZDEQaTe1WiH32EjXMIGDfZISI+K0ZVh+VoKJdf4=;
        b=AM6yDq6M95rSa5qKSnPi6SWAeiINuQ75xfoSf8Ct5dmCQTPh/NXzA2J5m039YoxRWF
         nFg0w+z6ccBHHdjv/22U9EAxN485CYkYuPyn+BRSxycyOBIovmIZCFQD2T42CdnzFVk7
         uS/8OcgspUJ/EdXg9yxFVZ1sWkAVejThSs/FTyCYTuktcirOuKGZHr/7AsCzO37JM2zy
         98gu09SPWoUS1955ji4hXOFgymnC78eK07Cuq5dKp2B2IJwi+Wnqp8/5PkC5ml7lBly3
         qYVynWbFnXKJzyFz/v8ShCcdqH4paMUS6J998kKtqZvvXPe4hY18x3h8CqtzP70IdatH
         ljdg==
X-Forwarded-Encrypted: i=1; AJvYcCWiiQ7CmIUGyejgb6cQSANq5hDNqz0eNnHq48CIEL7LR0ZmZVYOy62SHfZpQJRv4hctz7E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylorv8OufnQbCkFQfzIAylgRvyAun+vsR/lB5EdP/x1LshzJy+
	/1yoypeFV7Foqq8wDBP4V26H/pz5p1fqRNdAFwqWB+jF9pfGqfgqs5vW
X-Gm-Gg: ASbGncutFib/XvDEh5ZjzW0I86fDHdXafn4gnaI1ixJYaokh/VXoymxDseclSGvKqr9
	J9jUeT1I0DVZ8CF2KhjbTjwjz1UTcvzrAvgmtVwAomQyEyxe8ZZcSYXrEAiTURE5B0mnMYOBQa+
	fp63Y3A44sMcjI5bhmJ5DNLVTF5YknZcRnhgWon6aLUP8/bHuGZUQuQfQtwS6Qrz1MOuJjofLmE
	xgChkXaoAQkt+rlvF9jHaN+YeP3C0ZzEv6vMiq5oAfrBmr/Izx/udeBfiRfIoDBe/J9QYLNoWpx
	uaaNDRYFbsVADzgxnHgXnBbFvn8BX6f8j+ToxwEJrYRkAWsRM+/Z/WQwq/9gVq2yx3s+rx8QJ8u
	8816KJyTVEXdZsLpCkA+i0tqAUv6yu0wglSj1ZOoDxX7STdyB/iAP3DtSHWgEZFLEUoIW0mYuXP
	wESoVqNCzd0r86cbaYSYrhMuaiV2zLFLDqJYIsIRtKAfPEFvrEw6bYqQZa2VDxkf0PS2pBl+82W
	DAqiD8ez0i3/xz/fhTww62++1Va0pwOlA==
X-Google-Smtp-Source: AGHT+IFM/TM/U2ZgW+tRl79G2L8XU+2HNenHhc2cTLxBWOysZFcKopT7qImqotRU+w0/mG40BaeCew==
X-Received: by 2002:a17:903:1448:b0:27e:eea6:dff7 with SMTP id d9443c01a7336-28ec9cd6942mr96038245ad.27.1759953728945;
        Wed, 08 Oct 2025 13:02:08 -0700 (PDT)
Received: from ?IPV6:2406:7400:56:dc83:454e:4cd8:e34b:b52a? ([2406:7400:56:dc83:454e:4cd8:e34b:b52a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f35382sm5491055ad.85.2025.10.08.13.02.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 13:02:08 -0700 (PDT)
Message-ID: <38742a2f-5c5b-48f8-a9fd-acea47b7ce71@gmail.com>
Date: Thu, 9 Oct 2025 01:32:02 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/1] replay: make atomic ref updates the default
 behavior
Content-Language: en-GB
To: Kristoffer Haugsbakk <code@khaugsbakk.name>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
 Christian Couder <christian.couder@gmail.com>, Patrick Steinhardt
 <ps@pks.im>, Elijah Newren <newren@gmail.com>,
 Andrei Rybak <rybak.a.v@gmail.com>, Karthik Nayak <karthik.188@gmail.com>,
 Justin Tobler <jltobler@gmail.com>, Toon Claes <toon@iotcl.com>,
 John Cai <johncai86@gmail.com>,
 Johannes Schindelin <johannes.schindelin@gmx.de>
References: <20250908043620.57848-1-siddharthasthana31@gmail.com>
 <20250926230838.35870-1-siddharthasthana31@gmail.com>
 <f0abdc27-6850-4b9d-b4eb-a1c92f731142@app.fastmail.com>
 <61107972-5755-49b9-a126-9442418ddff0@gmail.com>
 <6d19a0c4-f000-43f5-b2e1-f84f341063a9@app.fastmail.com>
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <6d19a0c4-f000-43f5-b2e1-f84f341063a9@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 04/10/25 00:35, Kristoffer Haugsbakk wrote:
> Good evening Siddharth
>
> On Fri, Oct 3, 2025, at 01:36, Siddharth Asthana wrote:
>> On 02/10/25 22:44, Kristoffer Haugsbakk wrote:
>>>> [snip]
>>> On the topic of changing experimental commands: I really like the
>>> git-for-each-ref(1) (git-FER) output format design.  It just outputs refs and
>>> related data.  It’s not a command for “bulk delete refs” or “check for
>>> merge conflicts between these refs and upstream (git-merge-tree(1)”—it
>>> just supports all of that through `--format` and its atoms.
>>>
>>> And for this command it seems to, at the core, output a mapping from old
>>> to new commits.
>>>
>>> Now, I’ve thought that a “client-side”[1] in-memory rebase-like command
>>> would need to support outputting data for the `post-rewrite` hook.  And
>>> is that not straightforward if you can use `--format` with `from` and
>>> `to` atoms?  (I ask because I have never called hooks with git-hook(1).)
>>>
>>> I just think that (naively maybe) a `--format` command like git-FER with
>>> all the quoting modes might be a good fit for this command.  Then you
>>> can compose all the steps you need yourself:
>>>
>>> 1. Call the exact git-update-ref(1) `--batch`/`--stdin` or whatever mode
>>>      you need
>>> 2. Write a message to each reflog if you want
>>> 3. Call the `post-rewrite` hook
>>>
>>> † 1: c.f. server-side which I get the impression only wants to do cheap
>>>        rebases
>>
>> Hi Kristoffer,
>>
>> That's an interesting perspective on using --format for composability,
>> similar to git-for-each-ref's design.
>>
>> The constraint right now is that git replay's output needs to work
>> directly with update-ref --stdin, which has a specific format. Adding
>> --format would let users customize the output, but then they'd need to
>> transform it to the update-ref format anyway for the most common case,
>> which seems like extra work.
> git-FER has a default format and could still use that (either the
> current one or your proposal).
>
> git-replay(1) could also concievably support ready-made formats, similar
> to “pretty” formats that git-log(1) & co.
>
>> Your point about post-rewrite hook support is well-taken though. As this
>> command evolves toward client-side interactive rebase (which was Elijah's
>> original design goal), we will definitely need hook integration. At that
>> point, a --format approach with atoms like %(old) and %(new) could make
>> sense for letting users extract the commit mapping in whatever form they
>> need for hooks or other tooling.
>>
>> For this iteration I am focusing on the simpler atomic update case, but
>> I will
>> keep the --format idea in mind for future work.
>>
>> [replying to this part
>>
>> Do you see a specific use case right now where --format would help, or
>> is this more about future-proofing the design for when we add
>> client-side features?
> I have been using git-rebase(1) for a while with a post-rewrite script.
> This is used for interactive rebases but also just keeping up with
> upstream, i.e. a regular rebase.  Then I was idly thinking that
> git-replay(1) would be faster for the plain rebase case—but it doesn’t
> support that hook directly.  Okay, but I can get around that: I can
> parse the output, yank the commit OIDs, and run git-rev-list(1) on both
> of them to get the mapping I want.  But it would be really nice to just
> declare the correct post-rewrite format and be done, without having to
> parse anything. :)


Ah, that's a concrete use case! You are using post-rewrite hooks with
rebase and want git replay to support that workflow without needing to
parse output.

That makes sense for the client-side evolution of the command. Right now
the focus is server-side where hooks aren't typically needed, but as this
moves toward replacing interactive rebase, proper hook support (including
post-rewrite) will be essential.

I think --format with atoms would work well for that - you could get
exactly the format post-rewrite expects without parsing. For now I'll keep
the simple update-ref format, but this is good motivation for adding
--format support when we tackle the client-side features.

Thanks for the concrete example!


>
> Beyond that though I’ve been thinking about more hypothetical “client-
> side” concerns.  I mentioned writing to the reflog.  I imagine that
> server programs that just want to be able to efficiently “rebase”
> branches to the upstream don’t need that.  But client-side programs
> might want to write to the reflog because they want to mark what the
> update is for; you could have many kinds of client-side “update ref”
> programs and want to leave breadcrumbs about what was done.  There is
> more experimentation.  Whereas I imagine that a forge has maybe a small
> set of “update branch” commands.  I don’t know, maybe I’m rambling at
> this point.
>
>> Thanks for the thoughtful feedback!
> Thanks for the consideration and reply!
