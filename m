Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC99FDDB8
	for <git@vger.kernel.org>; Thu, 18 Jul 2024 14:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721312595; cv=none; b=j0jlmJdp9m+z2TiZ0q2KK/LAslZfpi+UmjuHDV+sMQeVSldSqNjAWdtszSxDmjYZod3TyaPgIIV++8oviirsb3bZA+4fXyE8SNADiZ42xdvhvOWI9fUTqx5hIsbchmvwDHs0YiVJANMTgx38ii/E89APLSQorsSNSlS36G1karM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721312595; c=relaxed/simple;
	bh=hNBDfQjIlt9OG9BJTtX7ruTaDSXQwzGJUAs8bduuddg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=JN54aML/Vb5h7QZhLFnuYOZWQtMu4iMa5hKGbgyMs9kxw4OwQ4ogqX8bfluqRKsJp8kBvM7JUeHma6svIM4tWPmL/VsFPLZAPW+8vxNLCETR44JWcJCiJvMAFWs9UUMlEqDz4aUFX35hVGAIAJ3nAC7bEqWOSOEuq2NNrjT2sjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j89SE+BQ; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j89SE+BQ"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a77c080b521so87772566b.3
        for <git@vger.kernel.org>; Thu, 18 Jul 2024 07:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721312592; x=1721917392; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XwgJI8U+FzBprpqjR/cMI9u0pcuqo2+dMx6U14w+6lM=;
        b=j89SE+BQQcXdUJPt5NnuKpMGI09iejqmVQrd7WPIUntkn5GkaVsyNj7lJoyp0v4+mE
         ASHmdZFXBTZXmMCV6a1AdFG88n1iZC7od5H6fOgrUgiwfbuxi8+3rOlA6h/AJrQrLiJS
         VfWUoQ8oyvn+2x+ckJXtH/PWgVFHZ4wjVWfykoEIbGdv1SVMQFrBtvadhZE7U4nueiXh
         G7SF9hN01lzVkkx6GZBlWW3NpqGSMgZzh/O1P6yE4t4iDRFehGyAbdsa3aZt26ejaxGf
         XJOAN0ICpDRH5hHXvGYvFVg6MyZydZPmTWJH7x9L9EoQSwdy8pfvzMGTcN3w6VIwhY5L
         2gFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721312592; x=1721917392;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XwgJI8U+FzBprpqjR/cMI9u0pcuqo2+dMx6U14w+6lM=;
        b=X+yFqwBesNiDHV3HQfAGHmIBoyk2+UfWkpOgndFMz1DCEuevV6KTzjy0N9OMNzFw40
         VE5f7QtXHqCS6KNvQ6oqhCa5H7wLziOkaTIfZHX5Fea4D4v8V8T0FGRQ7Ckn8Fd+QSn7
         lywIScf3V0cVhkLEy84Rl7bj2WnjKqvpJeTyoggliEewaj7/XZKQzWFZTtpwA13ZKRe1
         k37tEqgCrWYpm03OP/icsipNkARf6JDfvManXgQ+hj1T6ljSmxFAraZb8QZ0olX4Ixfl
         VOk2oTdNCftrLA4/bpaXLLx9YwTL0XnRCjLZltQN+j4V9X+OV7aSjAXw1AnHxj/pARlD
         mZIg==
X-Forwarded-Encrypted: i=1; AJvYcCVNKhDobXR5KrUW3YjJqPzc91ubwvCdJz3Apstr9rcXN+Z1ZhOIGVd2C+6TUMsVNRFBTbs90/ElOWWpjEEhrCR5LSPD
X-Gm-Message-State: AOJu0Yy8XOtNGzHpMH56xcw4zVMxDK0CaTb+OBA0PZftcqAQM4s73Ho0
	j+wF5FandhNDDsrO6f/1gVkVxZ7OnUD6elE4jOjWajW+kLRPlf3A
X-Google-Smtp-Source: AGHT+IGwUvL6fKCPikvc2+sn1D2UC/V+kR0kZsFoag+RZAgrwTdJfS0SM4Kmi3gi+D+5lsDbIaMfcw==
X-Received: by 2002:a17:906:456:b0:a77:b5c2:399 with SMTP id a640c23a62f3a-a7a011ad7dcmr334636466b.31.1721312591830;
        Thu, 18 Jul 2024 07:23:11 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:600:8501:575d:f6b:be83:bc74? ([2a0a:ef40:600:8501:575d:f6b:be83:bc74])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc5a3a93sm568839466b.6.2024.07.18.07.23.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 07:23:11 -0700 (PDT)
Message-ID: <3220d5f6-b771-4972-9c63-3f39d9ff1450@gmail.com>
Date: Thu, 18 Jul 2024 15:23:10 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [RFC/PATCH] add-patch: handle splitting hunks with
 diff.suppressBlankEmpty
Reply-To: phillip.wood@dunelm.org.uk
To: Jeff King <peff@peff.net>, phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>, Ilya Tumaykin <itumaykin@gmail.com>,
 git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
References: <9b31e86f-c408-4625-8d13-f48a209b541b@gmail.com>
 <ab974e62-098c-4200-bee3-7de8d9115516@gmail.com> <xmqq4j937pyf.fsf@gitster.g>
 <20240710093610.GA2076910@coredump.intra.peff.net>
 <d5d27cad-bacb-4a79-bb50-e65d2bb6808b@gmail.com>
 <20240711212628.GA3648684@coredump.intra.peff.net>
Content-Language: en-US
In-Reply-To: <20240711212628.GA3648684@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/07/2024 22:26, Jeff King wrote:
> On Wed, Jul 10, 2024 at 02:46:30PM +0100, Phillip Wood wrote:
> 
>>> It's tempting to say that we should just make sure that we generate a
>>> diff without that option. But we may parse diffs not only generated by
>>> Git, but ones that users have manually edited. And POSIX calls the
>>> decision of whether to print the space here "implementation-defined".
>>
>> Do we ever parse an edited hunk with this code? I'm not sure there is a
>> way of splitting a hunk after it has been edited as I don't think we
>> ever display it again.
> 
> Hmm, I just assumed this code would see the edited hunk, but now I'm not
> sure. Note that the changes required do go outside of split_hunk(); the
> initial parse_diff() needs to decide whether the hunk is splittable in
> the first place (as an aside, that puzzled me at first why just changing
> split_hunk() was enough for the case that started this thread, but not
> the one in the included test. The difference is that without the empty
> line as context, the hunk in the test wouldn't be splittable at all).
> 
> But looking closer: yes, I do think parse_diff() is used only for the
> initial patch.

That's true but I've realized that we do in fact allow the user to 
re-display and split an edited hunk. If there are two changes in a file 
then you can edit the first hunk and when prompted about the second 
press 'K' to go back to the first one and then split it with 's' (I 
messed up my test for this before sending my previous mail as I changed 
two separate files rather than putting two changes in a single file). So 
split_hunk() can encounter empty context lines even without 
diff.suppressBlankEmpty being set as lots of editors strip the leading 
space when the rest of the line is empty[1].

As we haven't had any bug reports about that I suspect people are not 
splitting the hunks they edited which I guess makes sense. I think there 
is another bug lurking for anyone who does try to split an edited hunk 
as we don't update `hunk->splittable_into` after it has been edited and 
the edit might change a deleted of an empty line to a context line or 
vice versa. We should make sure any garbage at the end of the hunk is 
discarded as well so we don't show it when we display the edited hunk.

Best Wishes

Phillip

[1] When I added the code to recount the hunk header rather than relying 
on "git apply --recount" initially it did not support empty context 
lines and we received quite a few bug reports pretty quickly after it 
was released.

> So we really would only see git-generated patches here.
> Which I think takes away my ambiguity concern, but does mean the commit
> message is wrong.
> 
>>> I don't think we'd ever generate this ourselves, but could somebody
>>> manually edit a hunk into this shape? When I tried it in practice, it
>>> looks like we fail to apply the result even before my patch, though. I'm
>>> not sure why that is. If I put "some garbage" without the blank line, we
>>> correctly realize it should be discarded. It's possible I'm just holding
>>> it wrong.
>>
>> When we recount the hunk after it has been edited we ignore lines that
>> don't begin with '+', '-', ' ', or '\n' so if you add some garbage at
>> the end of the hunk the recounted hunk header excludes it when it gets
>> applied.
> 
> OK, that makes sense. And we could never rely on the hunk header in the
> edited hunk anyway, since the whole point is that we have to recount it.
> So the user must accept that an extra blank line is potential context
> (and that goes all the way back to bcdd297b78 (built-in add -p:
> implement hunk editing, 2019-12-13).
> 
>> I think your patch looks good. I did wonder if we wanted to fix this
>> by normalizing context lines instead as shown in the diff below. That
>> might make it less likely to miss adding "|| '\n'" in future code that
>> is looking for a context line but I don't have a strong preference
>> either way.
> 
> Yeah, I had a similar thought, but it got messy because we have to deal
> with the source buffer. But the extra "char ch" you added in the patch
> below fixes that. I think the result is better.
> 
> Looking at the blank-line handling in recount_edited_hunk(), we also
> handle a CRLF empty line there. Should we do so here, too? If so, then
> it would just be a matter of touching normalize_marker() in your patch.
> 
> Do you want to just re-send your patch with a commit message to replace
> mine? (Feel free to steal the non-wrong parts of my message ;) ).
> 
>> ---- >8 ----
>> diff --git a/add-patch.c b/add-patch.c
>> index d8ea05ff108..795aa772b7a 100644
>> --- a/add-patch.c
>> +++ b/add-patch.c
>> @@ -400,6 +400,12 @@ static void complete_file(char marker, struct hunk *hunk)
>>   		hunk->splittable_into++;
>>   }
>> +/* Empty context lines may omit the leading ' ' */
>> +static int normalize_marker(char marker)
>> +{
>> +	return marker == '\n' ? ' ' : marker;
>> +}
>> +
>>   static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
> 
> Minor nit: missing blank line between functions.
> 
> -Peff
> 

