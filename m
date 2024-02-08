Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4BB44C73
	for <git@vger.kernel.org>; Thu,  8 Feb 2024 20:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707424968; cv=none; b=hH7aBBF81siAtNc0/zcugrloM0Ph6UFMXYX6Te1VpDn1pLBQvBRx2oNInu5NiqEcC8U2D/cEUAv4V96bL0Bnus8XCdUGeUQ+AY9QRIeAJmZMLagn9mTNucxHNcPYXwBJ9iRD+1P+lxc0LMb0ZNVukak5XS2pVXxie1/sXTFw680=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707424968; c=relaxed/simple;
	bh=WOtn2ZYGQ4ffruVAGMLZrfGp/g7eY59LfYQnNweNo8o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bgFdwt7ROWTqM/u5/dHYrdlqlB+iwMY5yogzXILEK9VpJfVRtlfuEPdUPJYm31x2kVnWK4q264sqEqkJcISbN3q58Ark7vTrdu7eBesOJ2nDOuxEZx6AVCHQyasmN+SPTN5yZxomkUcFX8F+NfUISbm+UQN2SGtsJFouSXtIt7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xcA94DKD; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xcA94DKD"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60482420605so4257307b3.3
        for <git@vger.kernel.org>; Thu, 08 Feb 2024 12:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707424965; x=1708029765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tUekBMmWUXoBhsK5diXRvB+mMK19hoJpbdQR8/cJxKY=;
        b=xcA94DKDlU6yX7rqrrYQELQHP4qQtASu9KfgwP4TrWV9c6AF9iLBh1toti5KI12BVI
         onVXc6oSxb3z85P4gTFtTReerQtbnsf55WDVAM/QknnqZ6xJW3C5hTABuSs0d21Ysldw
         RS0Yc+aLlDYzBvXVg9ta2UjvCt6SwlT4LYSO81TSy5+K77Aj5arR1gXnLKA4XnDlfYa8
         um4S+AyAsnJOzU7i9aW11+TUeb/07BvHhT+4gr/MIEOUWngwtL/C2oMNZUz1DQwhMM2n
         MBjAuQdC/w9AyD9G8qXTb28GOyvxMPI1b+ej9okah/Nro6JO6x2Sv14V+HdVR7Ieeqd5
         5iKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707424965; x=1708029765;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tUekBMmWUXoBhsK5diXRvB+mMK19hoJpbdQR8/cJxKY=;
        b=SFZkihNNLwkM32upQ9kvfWOByDdQKE8w3KGjvD9obtdoy4a8ILQ5sQ5ndNqHrxST8l
         vEEFkvkqdJQxBySlbp48yxGeMmuX+7qJ5Vyo4wXXFQ0j+ux+AalXSuB7Qxs+lnTJsZzz
         13JWrbVrXysVWE+CpBXqcQ2+hA1IznXhIDyqtY1T4O2vvxtizdusiLkDWRKzef/GrkaZ
         GmGZPllv714aJ35PgreJiyWuJuNJG4tHGpd2vy2y3ED9sTMHPA6ZptqSXikDGStcs+re
         yiBgBLqhUSjC/aYIv6zwmBzIUU1TNfLBk5LoYXZ7m2tt1A2WgamCVbkOpk4hDh3PQUXr
         91qw==
X-Gm-Message-State: AOJu0YzZGuKcEtYPhnu+ua6qDsrysX82pAnO0MYPk7jUqGIgkxsxB6OD
	Ep12ccgoZxyJvlmox6JFucFbq06ZGhuRgio2EPDaBmgNYWfWe80g1x+LSRsDfD57yBfEZ3eew+8
	htw==
X-Google-Smtp-Source: AGHT+IEUeKBStMF6hsmDLTeF4q4t+AGFrvqokjsB6ERpLsN+SfJSNgsbC/50Jy4Tq/ug4D10WsD28JG4CSA=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a81:6d82:0:b0:604:9249:3f17 with SMTP id
 i124-20020a816d82000000b0060492493f17mr84729ywc.2.1707424965437; Thu, 08 Feb
 2024 12:42:45 -0800 (PST)
Date: Thu, 08 Feb 2024 12:42:43 -0800
In-Reply-To: <CAP8UFD148VDVto3_NwQcCkRGFZ1qHHDtYTXVxV_=VsOjgqJcbg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240201115809.1177064-1-christian.couder@gmail.com>
 <20240201115809.1177064-4-christian.couder@gmail.com> <owlywmrgmx2j.fsf@fine.c.googlers.com>
 <CAP8UFD3D=a-3cVNpjobOdq=F5dC+aW4qYu3fXCxTnDg=GrnSwA@mail.gmail.com>
 <owlyr0hom257.fsf@fine.c.googlers.com> <CAP8UFD148VDVto3_NwQcCkRGFZ1qHHDtYTXVxV_=VsOjgqJcbg@mail.gmail.com>
Message-ID: <owlycyt6d6ws.fsf@fine.c.googlers.com>
Subject: Re: [PATCH 3/3] rev-list: add --allow-missing-tips to be used with --missing=...
From: Linus Arver <linusa@google.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	John Cai <johncai86@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Christian Couder <christian.couder@gmail.com> writes:

> On Wed, Feb 7, 2024 at 9:48=E2=80=AFPM Linus Arver <linusa@google.com> wr=
ote:
>> Christian Couder <christian.couder@gmail.com> writes:
>
>> > It actually kind of "works" when you pass blobs or trees. It looks
>> > like the command just doesn't use them (except for checking that they
>> > actually exist) unless options like --objects, --missing=3Dprint and
>> > perhaps others are used. So yeah, the doc might need an update, but I
>> > think it could be a separate issue, as it's not new and doesn't depend
>> > on this small series.
>>
>> SG. But also, if there's a way to put invisible (developer-facing, not
>> user facing) comments inside the relevant doc file it might be easy
>> enough to add a to this series.
>
> It might seem easy to add/improve some doc, but there is sometimes
> bikeshedding. So I don't think making this series dependent on such a
> dco update is a good thing for both that doc update and this series. I
> will try to work on such a doc update soon though.

Oh, I did not mean to say you should add doc updates in this series at
all. I was just asking if you could add a comment with "NEEDSWORK" or
similar that only developers will see. Looks like asciidoc does support
such comments that are left out of the published text:
https://docs.asciidoctor.org/asciidoc/latest/comments/. I just tested
with "//" style comments (asciidoc has other styles also, not sure which
one is preferred in our codebase) and running "make" to generate the
docs confirm that we can indeed put in such developer-facing comments.

Back to this topic, you could add something like "// NEEDSWORK: rev-list
can take blob and tree objects also as arguments, not just commits".
This is why I thought it would be easy.

>> > "quarantined objects" refers to the following doc:
>> >
>> > https://www.git-scm.com/docs/git-receive-pack#_quarantine_environment
>> >
>> > So to clarify things, the above paragraph looks like the following now=
:
>> >
>> > "When such a command is used to find the dependencies of some objects,
>> > for example the dependencies of quarantined objects (see the
>> > "QUARANTINE ENVIRONMENT" section in the git-receive-pack(1)
>> > documentation), it would be better if the command would instead
>> > consider such missing objects, especially commits, in the same way as
>> > other missing objects."
>>
>> This reads much better, and is a good motivation to keep in the log
>> message.
>
> Ok, I have kept it in the V2 I just sent:
>
> https://lore.kernel.org/git/20240208135055.2705260-1-christian.couder@gma=
il.com/
>
> By the way, sorry for forgetting to use the --in-reply-to=3D... option
> when I sent it.

NP, thanks for the heads up. See you in the new thread.

>> Aside: it's a bit unfortunate that the meaning of "missing" becomes
>> overloaded slightly here because one could say '$tip =3D=3D ""' is a
>> "missing" tip becauuse the name is not provided. Subtle. Plus there's
>> some interplay with the "if (get_oid_with_context(...))" case above
>> because we will (?) hit that path if we do pass in "" (empty string arg)
>> as a tip to rev-list. It might be worth saying in the comments in the
>> implementation, something like
>>
>>     The term "missing" here means the case where we could not find the o=
bject
>>     given the object_id. For example, given HEAD~1, its object id (oid)
>>     could be 82335b23aa7234320d6f8055243c852e4b6a5ca3. If no real object
>>     with this oid exists, it is considered missing. Providing an empty
>>     string to rev-list does not touch the "missing tip" codepath.
>>
>> I wrote the above hastily so it may need further edits to make it
>> succinct. But the point is that this definition isn't spelled out in the
>> test case, which makes the "" argument for $tip that much more subtle.
>
> I think this is related to the --missing option in general (which has
> been with us for around 6 years already), not specifically to this
> series, so I think it can be done separately.

Ah, thanks for the added context. I agree.

>> >> OK so you are using this empty string to clear the expect.raw file. I=
f
>> >> that's true then what stops us from doing this at the start of every
>> >> iteration?
>> >
>> > I am not sure what you mean. Both:
>> >
>> >     git rev-list --objects --no-object-names HEAD ^$obj >expect.raw
>> >
>> > and:
>> >
>> >     >expect.raw #2
>> >
>> > are clearing "expect.raw" as ">expect.raw" is used in both cases.
>> >
>> > If we did the latter at the start of every iteration, then when we do
>> > the former afterwards, we would clear "expect.raw" raw again, while
>> > there is no point in clearing it twice.
>>
>> Yes but doing it that way would separate "set up a clean environment for
>> this test case" from "find the oid of the non-missing tip" from each
>> other in the same if/else stanza, which I believe helps readability.
>
> On one hand it can help readability, but on other hand some people
> interested in test performance might see it as some waste. So I prefer
> not to do it for now.

In most situations I would agree with "let's hurt test performance by
1%, in exchange for better readability". I think this is one such
situation. And also, it's not even clear if we can measure the
performance hit from an extra ">expect.raw" call.

But as this is a small nit, I won't pursue this suggestion further.

>> Now that I have your attention (was this my plan all along? ;) ), I will
>> take this opportunity to ping you directly for a review of my own patch
>> series for the trailers subsystem:
>> https://lore.kernel.org/git/pull.1632.v4.git.1707196348.gitgitgadget@gma=
il.com/
>> which is in its 4th iteration after many helpful comments from Junio.
>> Please don't let the patch count (28) raise any alarms --- they used to
>> be 10 but I broke them down into smaller steps to ease the review
>> process.
>
> I will try to take a look soon. Thanks for working on improving the
> trailers subsystem!

Thanks!
