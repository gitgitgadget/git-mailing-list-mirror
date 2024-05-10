Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C5F446A2
	for <git@vger.kernel.org>; Fri, 10 May 2024 19:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715368149; cv=none; b=H9HxReuaQQiXXQ08eLr20+hY/8knwjmmNBHaVga7oOrGYAC8K/aCBvrWeglTc+lwZsujVG7pI31vEHwmVfowWCAb7ka1NID0PK4xEThNkM6c0CUCIi1CsIasc4bnRilBZlPbQ7Y2N1T3EINqPZ+JdYTksKrJGxZZ9xQbtlnoaGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715368149; c=relaxed/simple;
	bh=YvRIi2CYycveclEj8Nc9+u8rbwRVLxid5g8A6Ll/utA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZfyLnY1fdWH4q5aMPrqGfLqWgBN03kvYGFc9hUIJC81uNVuI7mg/ELWsgNV+gm8+gC8CXb2+nowcUXkAygOGhHcB/zET6j7Ekt+miOt3u+Xj0Kj4ZjUF6wLjGgn71WHmJ5Oh6rvfWkY2FSFUVsrLe9fmbM3tjAN6bV8Bio/cTps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Grpy5GCL; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Grpy5GCL"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5b2735f217aso1136385eaf.2
        for <git@vger.kernel.org>; Fri, 10 May 2024 12:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715368147; x=1715972947; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=IvVqx4oCSo7768XRj/e6eP5X8yu1oCliSFi49WDTSkc=;
        b=Grpy5GCLHJuNt3zRyKA94tUzFUlllveywYI5RmuUqmpT3B1jMx6Vmm4wh7H2guysls
         YjVAlOwOXGrzW7lL/ea3KLBs1Knd/zC+/nF87sdL1fgT1ZeobWjP6PKNR19yfpin348T
         coKR6f6EpFsRJiicYNRg8dmhHRTbsyouWW8K4qGaCLvHZkQ/9a2keYZ6yKlGvc9wLGBn
         Mhngz6OqofoHGrW1YVlxJYBo0lk2HwskjSHQzB8wFsjgUNY4ZH+VRvkLQ9/NKKZWbt9e
         qP7TAqENJ2L28wq1NNA6Buaya0jnLIEowI8x9VFv5vYcQ2h5laAT4ppo2HpZ038CQPYL
         CO5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715368147; x=1715972947;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IvVqx4oCSo7768XRj/e6eP5X8yu1oCliSFi49WDTSkc=;
        b=WqxElW5Y5gLkbbCvBmqdBIdZCkyB40lQ5mb1L8U8llTlbHcAme/Ea9zOh7qkBX0fnt
         IEcYroZJ1yAgg3s5Nm5vW1/jtg5wkch9PJqjpR8CbdeH3zCIQTE1JfNVmKd0wcif9C3m
         EVHgOWk22YYNvXr/bcdT56PAwE4u5rK0OMIuGOm4Jr9oW7dBsj7ducrSAxia/cgogdK7
         9TeLZ9BQ5iNBvtww1gBh1M8RZKRCxl+UjfljTlfIm2JTcp5WsetIPJ8XOwv0WwrPal5i
         cnSCOUcQrgXRJPkGhV0m3Q1SYZI8Z6lk9qK9Euizvm3R9fCd1YNVVohV39zrjBnPurc9
         i+Wg==
X-Gm-Message-State: AOJu0YyaWREGxqrjkJL9DYxH8KX1Xp2qP9Y+Ce93dHiANfnbOfGhjmYJ
	ob0njI3/2Ud40MdoUKiKnUqTOlAwB0+T1qvy5+By3ByioU3VVOLhTXwdVBw9waFWparkP66CtGD
	LgD+eAN0ZtVPV57Vql6lhkQcL9Uo=
X-Google-Smtp-Source: AGHT+IGyrBYQ6nI06ffljR+mpXCSzAUEG0lfKottMFRd3eK2cH5/sd+/Cj4yuo8qgBjAHIgNTUTLg5GWp/tVQDG+8Mc=
X-Received: by 2002:a05:6870:b6a7:b0:233:5b4d:ff90 with SMTP id
 586e51a60fabf-24172fcde08mr4773778fac.50.1715368146788; Fri, 10 May 2024
 12:09:06 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 10 May 2024 15:09:05 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqh6f564kp.fsf@gitster.g>
References: <xmqqy18issfv.fsf@gitster.g> <20240509211318.641896-1-gitster@pobox.com>
 <20240509211318.641896-3-gitster@pobox.com> <CAOLa=ZS_5+x7_xxppD8BE7RA0X+BFHPm=ffWg4JDgORqR5=sqQ@mail.gmail.com>
 <xmqqh6f564kp.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 10 May 2024 15:09:05 -0400
Message-ID: <CAOLa=ZRQGFPVD04n_3r5VjHjkxF4bWrW6Po7DyRVfeO9v08TXA@mail.gmail.com>
Subject: Re: [PATCH 2/2] SubmittingPatches: extend the "flow" section
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000000c783306181e4523"

--0000000000000c783306181e4523
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>>> +=== A not-so ideal patch flow
>>> +
>>> +To help us understand the reason behind various guidelines given later
>>> +in the document, first lets understand how the lifecycle of a typical
>>> +patch series for this project goes.
>>> +
>>> +. You come up with an itch.  You code it up.  You do not need any
>>> +  pre-authorization from the project to do so.  Your patches will be
>>
>> Wouldn't it be better to have the following sentences after the next
>> para?
>>
>> So the flow would be
>> - Have an itch. Code it up.
>> - Send patches to list.
>> - Get reviews.
>
> I am not sure what exactly you are suggesting.  "The next para"
> meaning?  The sentence far below that begins with "In the following
> sections, many techniques and ..."?
>

Let me be more verbose, I was suggesting to change it to:

+. You come up with an itch.  You code it up.  You do not need any
+  pre-authorization from the project to do so.
+
+. You send the patches to the list and cc people who may need to know
+  about the change.  Your goal is *not* necessarily to convince others
+  that what you are building is a good idea.  Your goal is to get help
+  in coming up with a solution for the "itch" that is better than what
+  you can build alone.
+
+. Your patches will be reviewed by other contributors on the mailing
+  list, and the reviews will be done to assess the merit of various
+  things, like the general idea behind your patch (including "is it
+  solving a problem worth solving in the first place?"), the reason
+  behind the design of the solution, and the actual implementation.


> Also, "Get reviews" is not a single step that is an end of story, so
> what you wrote is a bit misleading as a short summary.
>

I was trying to be brief, my intention was to capture the whole block
which, I agree wasn't the best shortening.

> The goal of this update is to reduce duplicates by describing a
> typical life-cycle of a patch series from the inception of an idea
> to the decision to include it in the next release here, so the
> proposed "decision making" document can focus on issues at a level
> larger than a topic of a patch series, and a contributor, especially
> a new one who wants to give us their first patch series, can learn
> by only reading these paragraphs how the world works around here
> with their patch series from the beginning to the end.  So what
> happens after "Get reviews." is a part of the same "flow".  Namely
> these three paragraphs---the original submitter cannot just leave
> with "now it is their problem" after they get reviews.  They are now
> integral part of the discussion and we expect to see them see the
> process through.

I see what you're trying to say, my comment was on the fact that it
seemed like there was jumps between the timeline of events and seemed
confusing, with my suggestion we still hold the same points and just
reshuffle the order a little to ensure that the flow of events is a
little easier to understand.



>>> +. While the above iterations improve your patches, the maintainer may
>>> +  pick the patches up from the list and queue them to the `seen`
>>> +  branch, in order to make it easier for people to play with it
>>> +  without having to pick up and apply the patches to their trees
>>> +  themselves.  Being in `seen` has no other meaning.  Specifically, it
>>> +  does not mean the patch was "accepted" in any way.
>>> +
>>> +. When the discussion reaches a consensus that the latest iteration of
>>> +  the patches are in good enough shape, the maintainer includes the
>>> +  topic in the "What's cooking" report that are sent out a few times a
>>> +  week to the mailing list, marked as "Will merge to 'next'."  This
>>> +  decision is primarily made by the maintainer with the help from
>>> +  reviewers.
>>> +
>>> +. Once the patches hit 'next', the discussion can still continue to
>>> +  further improve them by adding more patches on top, but by the time
>>> +  a topic gets merged to 'next', it is expected that everybody agreed
>>> +  that the scope and the basic direction of the topic are appropriate,
>>> +  so such an incremental updates are expected to be limited to small
>>> +  corrections and polishing.  After a topic cooks for some time (like
>>> +  7 calendar days) in 'next' without further tweaks on top, it gets
>>> +  merged to the 'master' branch and wait to become part of the next
>>> +  major release.
>

I wasn't referring to the above three paragraphs and I agree with the
points laid down here, I also happened to have missed reading and
responding to your mail on my series [1], around how to iterate your
patches and check for and resolve conflicts with other ongoing topics.

I think that would be a great value add to these points. I will smoothen
it and send it to the list soon.

>>> +Earlier versions of this document outlined a slightly different patch
>>> +flow in an idealized world, where the original submitter gathered
>>> +agreements from the participants of the discussion and sent the final
>>> +"we all agreed that this is the good version--please apply" patches
>>> +to the maintainer.  In practice, this almost never happened.  The flow
>>> +described above reflects the reality much better and can be considered
>>> +the "canonical" procedure to get the patch accepted to the project.
>
> I actually was expecting to hear more comments about this paragraph,
> which makes a lame excuse for naming the section "A not-so ideal".
> After sleeping on it, I think it belongs to the log message of this
> change, not here.  Future wanna-be developers do not have to know
> what process we wanted to have---they benefit from reading what the
> process _is_ in practice in a more direct way.
>
>>> +In the following sections, many techniques and conventions are listed
>>> +to help your patches get reviewed effectively.
>
> Thanks.

Thanks

[1]: https://lore.kernel.org/git/xmqqy18lpoqg.fsf@gitster.g/

--0000000000000c783306181e4523
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e1d64786f7503698_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZK2NOQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMzNRQy85NXc1QnNBSTlQUnl6d0pNNmlnVTZRbDByYwpNQ3h3S0l5UkNp
c014NWpDVlhoTkRkaXVlQkZwN1pFNnJJUEkyV25yT1daNmZGMjBxbDVMMWVMRitDRzFsZm5CCjlP
UTl3UFJPSGlyNlB3cXJhUEVnVnBjNUNNbTNpVnVxZHc5ZDJJb2lUczFSSDNGakF3a2lSdTFCMThw
a3NFYncKeWRiU3VmUG1aUmVMb0E2a1JPMjQ2VEt5cjJyWE1Pa1ZoU253U1pSRFFLVjBtQWR3Yzdx
Y29JV3pTTnRzcU5PVQpYWEZyTEhGMFdiakYrS2QwdC9lOFU0VitkN1BWOTMwSXlCSEtraEtLVzYz
Ym1lcGFFV09lME14Y05OblV6UStzCkx6aTV5UmduZFlYRXpVdDE1akJ5aEhjTVJJMkJjd1ZDU0J0
RDB6YW1RVWVIcVZ0Zmh3bFVaWGpkTWFJZldWYmYKZWdpeitaeUlWZ0F3Q3ZhRk91QTQrb1Zkb1Bu
RW5OckZBMHlEMGxJRk5LVDJzcUowTWFJdW85RFYxNWtBZWpMbwpLcXJzY2ZuVlFsUFE4QzFJNFVa
d2pTWmNySmttVFlLRU1zMW16MDFKWUxnYUo2eEJQMnZyN0V1aVA4cnVMYTI0CkV6RVRrMDY5RmtW
MWM2S2o2cGgzWkhERlZoanlEOUliMS9KOFZqYz0KPTMyekIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000000c783306181e4523--
