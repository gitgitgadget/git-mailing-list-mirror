Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E896110E6
	for <git@vger.kernel.org>; Sat,  3 Feb 2024 01:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706922556; cv=none; b=Jlf5q1QbKYC5A15C9zKTgS1HADSsslfSGIkX3qrnXhhyLuY9M5n9ykRlZ3eoEaXW9YqTPsEBkRkq/m76qeHFs7sBKSmdB+eYj/PnAVM1jSvyPo7lHJx2/23WPw75m0MWLwyvZ1yKn8W9lr2ZKFmJ3tWFD9ZjpUBdadgHS5CYVAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706922556; c=relaxed/simple;
	bh=chC9IbZtBoOMOSn62rRkVRKG01RejmZCGUqxfnY0qtc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j63p5lLMwvW9eJg8GNBiSJleiTAYz4n8Tz3FnPSk1R1wR0rCAHuI+Ro+itEcX3vuiiT2KNXhtzsYVsdNHy2fI+WYxGRAXQ4GNNtoqEgAlyNombDuIPjViR4aSMK1p2p1Hw6zF/iztE2uxt+ZiE9VzrzPAEDO7eNcaIvKubVLvaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rXiu+6Oa; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rXiu+6Oa"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b26ce0bbso5156530276.1
        for <git@vger.kernel.org>; Fri, 02 Feb 2024 17:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706922554; x=1707527354; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GWhkSdbdAzAIN5PKoM0pIW4wElW2EOAVtoCeg7AHTXo=;
        b=rXiu+6Oav2RlWpNcdWfJI6BCoy6dlo4Xc6flYyfwQdVd6nY1IEH10lXfLzkN1MQr4O
         lNZs11YYui+TeVycDdxPCEQpTZ5NmyAFV6cKuEEaK99qokkJf48ZVo2HmP1Xw1uAPRlm
         mVfNQg7bY/JYw6GB8S8sj/tJYss33JW/5OjXTzzbzodaDw+piGDB9N5rlHwGM1XBqmO7
         j9sfd+QbunQc6X+1SfcD6OqJxRSsedFzRwoTmh6vTwYbyOPSsXy2hAqLp1yMnUU71I/B
         DdHyEGllfCeoi45bf9IsaehinOrwS2u4TMgEbU/D7GDVeTi3UaYPa3A1LGgf9g1r2NTW
         Yd7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706922554; x=1707527354;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GWhkSdbdAzAIN5PKoM0pIW4wElW2EOAVtoCeg7AHTXo=;
        b=WQ/OR4J16GPUGBuVpZuqZAcc2giq++TWqT8om/S6O90BxON1jU57xITBM7pRHGb+Pw
         WR/93aRK7cKnn70BXqLh0PWnZC4am+AD7YvuwN0sc4DDII1orvGcUeMtuhSuyffmS4CQ
         DG5KmrT8PG4fwSGOM9mUi7WgzFFs3uRTWlqb7UbDMummInEnF+sqihQvY+Mn9uvqtedR
         TS5rDFncptMlxplTTHbMIhH01TaTs3lg0dLbyfmQY0qSrLBh2ASG/txl9TAZd/vLU6V7
         tap+U9nJtarT3kCUrokaqpiL2o0yQ/F2UqEbhYnuRoD8O4dDigUVItK4+UO6PHU9FRjA
         576A==
X-Gm-Message-State: AOJu0Yzw3ymi4013HwUReYPIcXUVXdvGfojtFKvRfgEuENh4VydWzFH2
	19w7/LXE1p+DOHbzxXN9xfwdWZJ8Y5h8vxpOrdJjwQiT8jaSiLGYfH/i/hv/nk0N9ZG8Zd44do6
	FUQ==
X-Google-Smtp-Source: AGHT+IF/90KVLDgJglXVC2sP2hOIcoyIjkED5lJkfuK+bDLe0JJxUv147eNV6q/uAyKNzDV/1UKi26EPOUA=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6902:260f:b0:dc6:e90a:7f23 with SMTP id
 dw15-20020a056902260f00b00dc6e90a7f23mr1114490ybb.13.1706922553887; Fri, 02
 Feb 2024 17:09:13 -0800 (PST)
Date: Fri, 02 Feb 2024 17:09:12 -0800
In-Reply-To: <xmqqplxgyq7f.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1632.v2.git.1706308737.gitgitgadget@gmail.com>
 <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com> <c19c1dcc592186d8da2857692f4ebbfe35adfac0.1706664145.git.gitgitgadget@gmail.com>
 <xmqqplxgyq7f.fsf@gitster.g>
Message-ID: <owlycyte1hhj.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v3 05/10] trailer: make trailer_info struct private
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
>> Make this struct private by putting its definition inside trailer.c.
>> This has two benefits:
>>
>>   (1) it makes the surface area of the public facing
>>       interface (trailer.h) smaller, and
>>
>>   (2) external API users are unable to peer inside this struct (because
>>       it is only ever exposed as an opaque pointer).
>
> At the cost of an extra pointer dereference every time the member of
> the struct is accessed, plus the cost of allocation/deallocation.

Added to commit message for v4, thanks.

> Which may not be a huge deal, but I wonder if the approach to name
> the member of the outer struct with "private" that seems to be used
> in other parts of the code (e.g. the .private_size member in the
> hashmap structure, the .refs_private member in the repository
> structure) or even a documented convention (e.g. raw_object_store),
> might be more appropriate here.

Having gotten my hands dirty with the pimpl idiom, I think possibly the
best thing about it is that the compiler can tell me exactly where
every Git subsystem outside of trailer.c is accessing members inside the
(newly private) struct. So it's great for checking existing usage of how
things are used already, day-to-day. Not being well-versed in shortlog
or sequencer internals, these warnings from the compiler for these
functions (trying to peer through the opaque pointer) have been very
informative.

I think it would be reasonable to drop the idiom if the additional
performance costs (pointer dereference, allocation/deallocation) are too
much to bear. For the trailer subsystem I don't see an immediate need to
focus on performance though, so I think it's fine for now.

> If Coccinelle works well (which we
> may be having some trouble with --- cf. <xmqq1q9ybsnl.fsf@gitster.g>),
> we should be able to catch external accesses without having to hide
> the implementation details via an extra pointer dereference.

That's true. But that would only work for trailer API users inside the
Git codebase. Eventually I envision projects external to Git using
<trailer.h>, and in that scenario we would _really_ not want to let
these external users peek inside structs with members named "private" or
"internal" in name only. Murphy's law suggests those external users will
(naughtily) depend on the internals, and that would place an undue
burden on us if we ever wanted to make large changes to these (public)
structs because we might break them.

Another thing to consider is that if our API users ever want to get more
flexibility out of it, they would immediately come to us if we used the
pimpl idiom (our users are bound by exactly how we define the API). If
the structs were public, then they would be free to implement new
functionality to extend the API on their own, without ever letting us
know. If there are folks making small (unofficial) extensions to the
API, I want that to happen _in_ this project, not outside.

In summary what I'm saying is that this idiom gives very strong guidance
for desining an API for both Git-internal and external-to-Git usage. I
think for at least the trailer subsystem it's worth trying out. I've
pointed out some of the same points in the cover letter also.

>> @@ -176,11 +176,12 @@ static void interpret_trailers(const struct process_trailer_options *opts,
>>  	strbuf_release(&trailer_block);
>>  
>>  	free_trailers(&head);
>> -	trailer_info_release(&info);
>>  
>>  	/* Print the lines after the trailers as is */
>>  	if (!opts->only_trailers)
>> -		fwrite(sb.buf + info.trailer_block_end, 1, sb.len - info.trailer_block_end, outfile);
>> +		fwrite(sb.buf + trailer_block_end(info), 1, sb.len - trailer_block_end(info), outfile);
>> +
>> +	trailer_info_release(info);
>
> Interesting.  Is this an indenendent bugfix even if we decided not
> to take this patch?

Nice catch!

> No, I have not fully decided to be negative on
> the move this entire patch makes (even though I am leaning towards
> saying so).  Just hypothetically, even if we wanted to keep "info"
> here as a structure and not a pointer to an opaque structure,
> doesn't this hunk fix a real bug?
>
> Well, technically, not quite, because the members referenced in that
> if (.only_trailers) block are still live in the info struct.  But it
> still smells wrong to access info.* after calling _release() on it,
> and this fix should come before "info" is turned from an instance to
> a pointer, I would say.

I've promoted this change into a bugfix patch as the very first patch
for the next reroll. Thanks.

>> diff --git a/trailer.h b/trailer.h
>> index a7599067acc..e19ddf84e64 100644
>> --- a/trailer.h
>> +++ b/trailer.h
>> @@ -4,6 +4,8 @@
>>  #include "list.h"
>>  #include "strbuf.h"
>>  
>> +struct trailer_info;
>> +
>>  enum trailer_where {
>>  	WHERE_DEFAULT,
>>  	WHERE_END,
>> @@ -29,27 +31,6 @@ int trailer_set_where(enum trailer_where *item, const char *value);
>>  int trailer_set_if_exists(enum trailer_if_exists *item, const char *value);
>>  int trailer_set_if_missing(enum trailer_if_missing *item, const char *value);
>>  
>> +size_t trailer_block_start(struct trailer_info *info);
>> +size_t trailer_block_end(struct trailer_info *info);
>> +int blank_line_before_trailer_block(struct trailer_info *info);
>
> And we need new accessors, which is a good change regardless of the
> answer to the "do we really want an extra pointer dereference?
> Shouldn't the existing 'private' and 'internal' label we see below
> sufficient?" question.

I am very surprised with your response here, because I was expecting the
complete opposite reaction from reviewers --- something like

    Hmph, we have to write accessor functions now when before we could
    just reach inside the struct directly? Isn't this just adding
    needless verbosity?

(perhaps with more dissatisfaction). Something tells me you meant "bad
change" but accidentally wrote "good change". Am I correct?
