Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD682EF66E
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 20:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757535978; cv=none; b=AOT+O27oHYhiqrQ8rbEFMfCTk6wmxAOgxe1bbJ4JF48qMNSUuiiakruKtKec11wgEormGb6QBoRYZ2xkYJRnf9qRZCPBUT1nDiM+OoNGUXbB8oIT/YKKZ2KMsawv2+EiXK2gt8InF1kTT9xV0zrkD+pcnN4KWw/jlYORtlpUDdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757535978; c=relaxed/simple;
	bh=oXf21hOC24n4Fr7dKooDVqgepdoBMSZcGxi1xowVEWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mp8fjRzDZc1nYD0csILPHq6lWVKvO5UV+omhcOhKBXc8wto690K+PTFS6meqDL0zXZkT1WZhnlheasB5P1HAwKwlBjDWHWfx4IkryzG3OkO7+U/llNQVilkcvwsjweBVIxr6UJDwRbe/l28SKVAvYTxf2iL6u0GrNr6RSPzsvbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vo+/oLQl; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vo+/oLQl"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b4d4881897cso43865a12.0
        for <git@vger.kernel.org>; Wed, 10 Sep 2025 13:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757535973; x=1758140773; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RMQ2oPRGaVicfoE0HkdC/qaJiCO9Dr1s4Ho4C4YlRko=;
        b=Vo+/oLQl5kG0k0aQfcn6ZrWx5b1FSTdyV7/CBlmalUva6Et1ct+tXvmjkCnsJCF7d+
         HgT5gn95ZMDilIX1BjD5VVysLNsPPeTihI6a4PtVYxrona7CKpWiRkn3sn/umzM/YFQi
         ECRiTgT05bLn1DvJmO6uPgGq/onagF1bml3wergC7R1uAHe5DFAKVMXMX/7EYLCpIFI9
         qDuvHG87nSt5Yxy8YYuacMhUfyZIebGnLa3N0PbxiC6pkA42eNorhwV8VdbQAGhGsgYV
         BSNYFZgv1B+Jr0iVVRKRFeThenm0b0gRCsc6khtx0hvYXnAhUI0j34o1oQgqxISZo4wX
         9l6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757535973; x=1758140773;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RMQ2oPRGaVicfoE0HkdC/qaJiCO9Dr1s4Ho4C4YlRko=;
        b=aQ8JEQOvsJvKjz93sXTm5sAkkUmrJTxvOGrqwPbQrCv3Hz5kd4E7dg8jRuQEQRB8Ur
         iu/QC0v1vM7ZAbv2y6kMyhtEatGt5F9TWRA5+4KGopiiOAJKpcjh8vukJ2YqBLqXXZTR
         UM7Zv5mOlnOoL9raP299RmW5F4ahayks4Gylb4jE2g8/kXKf3S6S8GYRqnw6dr7/x8RT
         AnkElU0o/mwX3Kmd6PX/iVNp4TKxa0NeCbZmnMBMckuINPpSIRNto++qoi2eZbn+CDtG
         2DpL+chYRxKUFqP7rrAWLF4uJC/nAcoVX2IuPQLKWKu60K5xpy/loBooroZm9H4t/SrP
         GyUw==
X-Gm-Message-State: AOJu0YwKiRdvGSCQNwif62kR9FRXzvYsqpmIveS1ugs2msv9l06R6Umr
	i0N0kF0CQpUFiHM0uu4P37tSoym0Jf24983MrO8ECqUF/FiNoW/O9toY
X-Gm-Gg: ASbGnct3SUO1mdAVe5+jKOzHbo1ywgvgjClqpyweww5cUTyBGbVKJ1ZWqokJxMKj3RW
	gJrVOP9ZmQ9UunYNggH73pdVAjD0mQGe1PJrEtB4/GMYJFa1Ov/Df8cOi0axuTr9vx00moqDvV0
	2kzS7PQzCsoFouc1IZuqTFCB7F71JMLyqcSqzMTTWClCeMQkneZ5Xp0nJSZnOHr0q/BR7EAw/If
	MQY8gOJrv/eSRWGE8yN2gJQ3aa8PwHG1EK7q0upZtMATiw0S02jcxGkl+u4z6OG9D3RZqYSCAOi
	5oj+oXhBUEUi8cBHBkppCxZgyOr6NrDdf6KOzgWYxpraKagocEzUPGI/iNK1AQjfFTQGUhwmuj7
	Bfh27/DquOUGInNRA5yLj0Y7TaokOTpk22NqpXq+nkpnqPt/JNv9S6EVh4XmZEPu44ZhG+39MxC
	gDu2yOB2sKnSDN7cQR7Hqs27Y=
X-Google-Smtp-Source: AGHT+IEb4P/hVqOa4PSDLimQLVtchc2HYPOlKTF/csG6Bkv2Wbg++wynkMk3AVgtdFu2XPCbvWu7lg==
X-Received: by 2002:a17:90b:1344:b0:329:d50e:2f1d with SMTP id 98e67ed59e1d1-32d43f96f7cmr22979054a91.20.1757535972945;
        Wed, 10 Sep 2025 13:26:12 -0700 (PDT)
Received: from ?IPV6:2406:7400:56:7e97:9da:149a:656d:6410? ([2406:7400:56:7e97:9da:149a:656d:6410])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dbb60fc17sm3563260a91.24.2025.09.10.13.26.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 13:26:12 -0700 (PDT)
Message-ID: <58064c0d-1139-4c57-ae34-756e52bf5695@gmail.com>
Date: Thu, 11 Sep 2025 01:56:06 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] replay: document --update-refs and --batch options
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 Karthik Nayak <karthik.188@gmail.com>, Justin Tobler <jltobler@gmail.com>,
 Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
 Toon Claes <toon@iotcl.com>, John Cai <johncai86@gmail.com>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20250908043620.57848-1-siddharthasthana31@gmail.com>
 <20250908043620.57848-3-siddharthasthana31@gmail.com>
 <CAP8UFD3Db-n3CY=KBpn-2Nt=SYY=5ckF3J_4ho6C19SVcrfdsQ@mail.gmail.com>
 <7f90e1b6-acba-40f2-9e51-ad09c2bf6999@gmail.com>
 <CAP8UFD1J8fgjZ+din3P_=FjZZFJ+ocqvwTFjBNjpnhrx6=nMqg@mail.gmail.com>
Content-Language: en-US
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <CAP8UFD1J8fgjZ+din3P_=FjZZFJ+ocqvwTFjBNjpnhrx6=nMqg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 09/09/25 12:56, Christian Couder wrote:
> Hi Siddharth,
>
> On Tue, Sep 9, 2025 at 8:36 AM Siddharth Asthana
> <siddharthasthana31@gmail.com> wrote:
>> On 08/09/25 11:30, Christian Couder wrote:
>>> On Mon, Sep 8, 2025 at 6:36 AM Siddharth Asthana
>>>> Also document the --batch option which can be used with --update-refs
>>>> to allow partial failures in ref updates.
>>> It looks like a --update option was also added by the previous patch.
>>> Is it documented here too?
>>>
>>> Why was this [--update | --update-refs [--batch]] set of options
>>> selected over other possibilities like for example
>>> [--update-iteratively | --update-atomically | --update-batch]?
>> I was trying to provide both simple and advanced modes. --update for
>> users who just want "make it work like piping to git update-ref --stdin"
>> and --update-refs for those who want control over transaction modes. But
>> I see this creates confusion.
>>
>> Would you prefer a single option like --update-refs with an optional
>> mode parameter? Something like --update-refs[=batch] where default is
>> atomic?
> My preference would be something like [--update-atomically |
> --update-batch] first. (Maybe names like `--batch-update` and
> `--atomic-update` are better?)
>
> And then something like --update-iteratively could perhaps be added as
> an alternative, if:
>
>    - it works exactly the same as piping to `git update-ref --stdin`, and
>    - some users want to use it to blindly replace piping to `git
> update-ref --stdin`, and
>    - we document that it is not efficient (compared to
> update-atomically and --update-batch) and should only be used to
> blindly (bug for bug) replace piping to `git update-ref --stdin` when
> performance is not an issue.
>
>>> Also how does this --update-refs option compare to the --update-refs
>>> option in git rebase? Is it working in the same way?
>> No, they are different. git rebase --update-refs updates refs that point
>> to commits being rebased. --update-refs updates the target branches from
>> the replay operation itself. The naming collision is unfortunate should
>> I use a different name?


Hi Christian,


> Yeah, my opinion is that "rebase" and "replay" are commands doing
> similar things, so having an `--update-refs` option in both commands
> is a good thing only if the option has the same purpose in both
> commands. If the purpose is a bit different, I think it's better to
> use different names to avoid confusion.


You make an excellent point about the naming collision. The purposes are 
indeed different:
- `git rebase --update-refs` updates refs that point to commits being 
rebased
- `git replay --update-refs` (in my patch) updates the target branches 
from the replay operation

Since Elijah and Junio have endorsed making ref updates the default 
behavior, this actually simplifies our naming significantly. The new 
design would be:
- Default: atomic ref updates using transactions (no flag needed)
- `--output-commands`: print update commands for traditional pipeline users
- `--allow-partial`: enable partial failure tolerance when some refs 
can't be updated

This completely avoids the rebase naming collision while providing the 
atomic transaction behavior that's important for server-side operations 
like Gitaly. The default behavior gives us the reliability we need 
without any naming confusion.

>
>>>> +--update-refs::
>>>> +       Update the relevant refs using ref transactions instead of outputting
>>>> +       update-ref commands. By default, uses atomic mode where all ref updates
>>>> +       succeed or all fail.
>>> This seems to imply that --update doesn't update the refs atomically.
>> That correct --update doesn't use transactions it updates refs one by
>> one like `git update-ref --stdin` does. Should I make this clearer in
>> the documentation?
> Yes, please.
>
>>>> Use with `--batch` to allow partial updates.
>>> What about --update, when should it be used?
>> Good point. My thinking was --update for simple cases where you want the
>> exact same behavior as piping to `git update-ref --stdin` and
>> --update-refs when you want transaction guarantees. But I am starting to
>> think this distinction might be confusing users more than helping them.
>>
>> Would it be cleaner to just have --update-refs with the batch mode
>> option and drop --update entirely? The sequential behavior can be
>> achieved with --update-refs --batch if someone really needs it.
> About the options that should be implemented, see my opinion above.
>
> About possible confusion, I think that to avoid it, it is important to:
>
>    - name the options properly (see above what I think about the
> `--update-refs` name), and to
>
>    - document thoroughly how all the options differ from each other and
> from piping to `git update-ref --stdin`
>
> Thanks.


Absolutely agree. The simplified approach with default atomic behavior 
eliminates most of the confusion points you identified. I will ensure 
the documentation clearly explains when users would want 
`--output-commands` (for custom scripting) versus  the default atomic 
behavior (for reliable operations).

The atomic-by-default approach also means better performance since we're 
using batched transactions (addressing Patrick's reftable concerns) and 
better UX since users get reliable behavior without needing to 
understand transaction modes.

Thanks for catching the naming issue christian - it led to a much 
cleaner design,
Siddharth


