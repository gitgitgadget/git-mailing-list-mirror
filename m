Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1163135A6F
	for <git@vger.kernel.org>; Fri, 16 Feb 2024 20:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708115234; cv=none; b=QNyRcEcIc4vbF/0Sik9wkBZJYlB5YfRVpsE0hoftXB7Sv10uQSJnjjY7ga/xNfdnDAavmjaoxDFK6xS2VO0BgMEfSf5ppdPeaolykleotUnetKy3S08n85nGMNNbKbiGKYOrVoKXJjmSYeOuLLQiAcYzwbDq0qIXwMUa9FOTg6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708115234; c=relaxed/simple;
	bh=r3n9zIyvWCnUF8Hir/r/XFRsPtTrzvnOkmJL3CxFo7Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e44E0aAuIN7VuBESL56iX3vbi1pfet5weO3GpRyp4NKBlwjpWq/57YT0s3ngg7Inq26sIOHr7qaATHZSkZSz8innUBG1nP8uF428qae0drAkxJU7bl4+3E5lKGC3jnet5Oxq9zu1z5TDUrwq7UnwflG0twVOiC0q8qAr3nucojY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cgNFABJh; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cgNFABJh"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-607a628209eso45614007b3.3
        for <git@vger.kernel.org>; Fri, 16 Feb 2024 12:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708115231; x=1708720031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nWtLSm+TmtlKarSzD6EzapEop3T5rSf7YY6Espj0rsM=;
        b=cgNFABJhl8mUrrnXs9Z41isLnQp0hqE21fhcp8eeGHqBofzcBU4HEJbr3PurEVyXbh
         Zo/oztLANxhuY7wlyJOaVBeR+ObzdN421mVTlD5bBJui0CViniQ09ybK6k4C0mHLfZm9
         DyiHD89O/tTAMdmAe+HWtHjThjBNmc7sWhrvLv4XRtr9QtHYuyQsaDhEymbEI8qL8BnH
         isE1DX71wv2p9fucDRAbXGeBXC5CPyP/fTVUksVokaGaZCZPKoNB0uhy7Tu9pZzFBRw3
         R92juZudnGTRicjncEGxFQeuIZL3407yMeLgpXBF4CsQPYv1CJx0CR2q4UyOUaKi7qYg
         TxpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708115231; x=1708720031;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nWtLSm+TmtlKarSzD6EzapEop3T5rSf7YY6Espj0rsM=;
        b=Hki5YBNxtE2Iu9Vjz4XwA9NU/yqq4Ev52o2bmQWt1r79Krh0M2mwPfC6W01oI02fFy
         KKxVcQXtBgkr5HLB5jvJsdwPDHh0HPlWt+kLRNljLO3rF09a/migRpZCHfaPaqn3V5eI
         dsyO+teA2LnxM8vMiUXwupBcEP/RunVO/bRbPpUsE3ckA7MV7O1oEygcylHYA8uHwFon
         bd75bjO/CpkoTs3AGyD9NQe2FrNq77stFB6QqCVRtj6K6pMpeRoweht/AswEV9hnjWFn
         vJNS4w24KeZPrB8zH4qqE1N+H7CLy6/8HBYNj5NTowuW+OH9kJeEYGMiyfWzEItVsAh5
         V8fg==
X-Gm-Message-State: AOJu0YwzF+Twv5HB4ejZlsohKxLPZCN6eEHzfwVKYRsPkvEvpO9mbnEc
	ZWkfNjiaQNBDo+IIvxszjkRCHYKF2WhEtSWUMIIgMjBqAIGI4VmQ7tDNjSHl/ficXx9FUkwqosq
	meQ==
X-Google-Smtp-Source: AGHT+IHjC527KEljM1hk923NLokavWa/rqem2EJ2ZdNiniPV7u3au6iZvBO40awCodu+yP1m7sdiFt2Zo90=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a81:5253:0:b0:607:9250:f698 with SMTP id
 g80-20020a815253000000b006079250f698mr1261376ywb.3.1708115231642; Fri, 16 Feb
 2024 12:27:11 -0800 (PST)
Date: Fri, 16 Feb 2024 12:27:09 -0800
In-Reply-To: <CAP8UFD0BfdVQ6p8SH6RVRYF4=+-V4PAtKg9LdUEeL_GnSqozzg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240208135055.2705260-1-christian.couder@gmail.com>
 <20240208135055.2705260-3-christian.couder@gmail.com> <owlyle7o9iyf.fsf@fine.c.googlers.com>
 <CAP8UFD1aJD5i68ekHuq0UG14X19y=Eo6qKPianF8MKNf6iZ_WQ@mail.gmail.com>
 <owlyy1bl8b8u.fsf@fine.c.googlers.com> <CAP8UFD0BfdVQ6p8SH6RVRYF4=+-V4PAtKg9LdUEeL_GnSqozzg@mail.gmail.com>
Message-ID: <owlymss0889u.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v2 2/4] oidset: refactor oidset_insert_from_set()
From: Linus Arver <linusa@google.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	John Cai <johncai86@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Christian Couder <christian.couder@gmail.com> writes:

> On Fri, Feb 16, 2024 at 2:10=E2=80=AFAM Linus Arver <linusa@google.com> w=
rote:
>>
>> Christian Couder <christian.couder@gmail.com> writes:
>> >> so perhaps the following wording is simpler?
>> >>
>> >>     Like oid_insert(), but insert all oids found in 'src'. Calls
>> >>     oid_insert() internally.
>> >
>> > (What you suggest would need s/oid_insert/oidset_insert/)
>> >
>> > Yeah, it's a bit simpler and shorter, but on the other hand a reader
>> > might have to read both this and the oidset_insert() doc, so in the
>> > end I am not sure it's a big win for readability. And if they don't
>> > read the oidset_insert() doc, they might miss the fact that we are
>> > copying the oids we insert, which might result in a bug.
>>
>> When functions are built on top of other functions, I think it is good
>> practice to point readers to those underlying functions. In this case
>> the new function is a wrapper around oidset_insert() which does all the
>> real work. Plus the helper function already has some documentation about
>> copying behavior that we already thought was important enough to call
>> out explicitly.
>>
>> So, tying this definition to that (foundational) helper function sounds
>> like a good idea to me in terms of readability. IOW we can inform
>> readers "hey, we're just a wrapper around this other important function
>> --- go there if you're curious about internals" and emphasizing that
>> sort of relationship which may not be immediately obvious to those not
>> familiar with this area would be nice.
>>
>> Alternatively, we could repeat the same comment WRT copying here but
>> that seems redundant and prone to maintenance burdens down the road (if
>> we ever change this behavior we have to change the comment in multiple
>> functions, possibly).
>>
>> > Also your wording ties the implementation with oidset_insert(), which
>> > we might not want if we could find something more performant. See
>> > Junio's comment on this patch saying his initial reaction was that
>> > copying underlying bits may even be more efficient.
>> >
>> > So I prefer not to change this.
>>
>> OK.
>
> I must say that in cases like this, it's difficult to be right for
> sure because it's mostly with enough hindsight that we can tell what
> turned out to be a good decision. Here for example, it might be that
> someone will find something more performant soon or it might turn out
> that the function will never change. We just can't know.
>
> So as long as the wording is clear and good enough, I think there is
> no point in trying to improve it as much as possible. Here both your
> wording and my wording seem clear and good enough to me. Junio might
> change his mind but so far it seems that he found my wording good
> enough too. So in cases like this, it's just simpler to keep current
> wording.

Sounds very reasonable.

> This way I think there is a higher chance that things can be
> merged sooner and that we can all be more efficient.

Thank you for pointing this out. There is definitely a balance between
trying to find the best possible solution (which may require a much
deeper analysis of the codebase, existing usage patterns, future
prospects in this area, etc) and getting something that's good enough.

Somehow I was under the impression that we always wanted the best
possible thing during the review process (regardless of the number of
rerolls), but you make a good point about "code review ergonomics", if
you will. And on top of that I fully agree with all of your other
comments below, so, SGTM. Thanks.

>> >> > +void oidset_insert_from_set(struct oidset *dest, struct oidset *sr=
c);
>> >>
>> >> Perhaps "oidset_insert_all" would be a simpler name? I generally pref=
er
>> >> to reuse any descriptors in comments to guide the names. Plus this
>> >> function used to be called "add_all()" so keeping the "all" naming st=
yle
>> >> feels right.
>> >
>> > We already have other related types like 'struct oid-array' and
>> > 'struct oidmap' to store oids, as well as code that inserts many oids
>> > into an oidset from a 'struct ref *' linked list or array in a tight
>> > loop.
>>
>> Thank you for the additional context I was not aware of.
>>
>> > So if we want to add functions inserting all the oids from
>> > instances of such types, how should we call them?
>> >
>> > I would say we should use suffixes like: "_from_set", "_from_map",
>> > "from_array", "_from_ref_list", "_from_ref_array", etc.
>>
>> I agree.
>>
>> However, I would like to point out that the function being added in this
>> patch is a bit special: it is inserting from one "oidset" into another
>> "oidset". IOW the both the dest and src types are the same.
>>
>> For the cases where the types are different, I totally agree that using
>> the suffixes (to encode the type information of the src into the
>> function name itself) is a good idea.
>>
>> So I think it's still fine to use "oidset_insert_all" because the only
>> type in the parameter list is an oidset.
>
> Yeah, here also I think both "oidset_insert_from_set" and
> "oidset_insert_all" are clear and good enough.
>
>> BUT, maybe in our codebase we already use suffixes like this even for
>> cases where the types are the same? I don't know the answer to this
>> question.
>
> I agree that it could be a good thing to be consistent with similar
> structs, but so far for oidmap there is only oidmap_put(), and, for
> oid-array, only oid_array_append(). (And no, I didn't look further
> than this.)
>
>> However if we really wanted to be consistent then maybe we
>> should be using the name oidset_insert_from_oidset() and not
>> oidset_insert_from_set().
>
> Yeah, "oidset_insert_from_oidset" and perhaps
> "oidset_insert_all_from_oidset" would probably be fine too. Junio
> found my wording good enough though, so I think it's just simpler not
> to change it.
>
> Also it's not like it can't be improved later if there is a good
> reason like consistency with other oid related structs that might get
> oidmap_put_all() or oid_array_append_all(). But again we can't predict
> what will happen, so...
