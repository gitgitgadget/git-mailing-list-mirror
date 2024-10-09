Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5DF18EFEC
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 10:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728468581; cv=none; b=oysR+Nkm9iqRumBzcqPNU3cF3lLKUJPt3c37lTDy5FPrm87L5lS7zJZ2KzNlcGNh/7Ra+dWLAxiiqn4QEeljOS8EsJQNNmlgYbSqTdoloTiT9Jq5JBNek6rFByeuAaPMvzUYljSwQxaCGm7ykV82pqf3+e9xP1RTMFo0ScVqxx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728468581; c=relaxed/simple;
	bh=aGUWl9K18rfMhB+0ZEsPTmuW8Ab0TmEI9hZDc2y7PyI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IMky3CGN/mEH4/zdPTMSoYsQ3QKdLOYx7lboc8O/GGXNGFY4tecP/3GDjPJGfzTaCthXhOGfKt2zQfSiWVV67roJ1Qsf3QF4CnnrQ8WxhgdDp6SgkYYxefE54jwJHhuiUapmMNiAR5Rbv5ziqa2ZZ8p9JhwpoHwB3rSWrz+KLkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lUiwT33E; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUiwT33E"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7e9e38dd5f1so4979889a12.0
        for <git@vger.kernel.org>; Wed, 09 Oct 2024 03:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728468579; x=1729073379; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=f6aQB/rn+N3TBsQPqn6HJLbXZILuc37EfRS7BvbvGZk=;
        b=lUiwT33ESITpv83NodBVhFahXuXxcc8UNKXdQtComwdBiD7nmeUmA+a83WpjrCsGhj
         /NkJ7HQSURScmj5aJ4PrSuZHU3kL+md93ExRGKyT/604xRJyG1vm92cht2cpj1fQX+tc
         pwkuPqXcvMej3sQTcnT5YVQWV+vIZbWTk/EJTvAwIQaQP7i6ZV+9j6wxCDtvBVac/imI
         xFKo4/5+x9kIA4lfuvkvvW/jbHgvYiI4rN6FX1yYCN8PCGV3e9PfKaKlwEJvBwafZPlo
         /EJNhAoVp0YGe93Q+73bF1TMBQpZHEd87y3yDF86t/Fgt8+xnonIVNGhklw3TpeWRoyW
         Rh0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728468579; x=1729073379;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f6aQB/rn+N3TBsQPqn6HJLbXZILuc37EfRS7BvbvGZk=;
        b=CBhi2Gd4P8wqE/1VTyJDXaparBpzAUiEgUgG/UGaQIsywohoEPwc2Hg+UPTx3x/C/F
         ZS2821vAV4lJ9nr9sa57QmCLPwcAMmIs3ymL598dhP5/nY4No82w80q5USbCoIb4FMbz
         nJ4aFaRw+E1zZu6fBhpK48zR+8D4gYZqdH11ewZnoxxCcxzW2uA++pW2lflt4dZQhE87
         YRIQyQMEk6OKd10LERu9O7OB4xCqcfo+CCwyhogO5w1XmR6AsjqkGjvRPS8L+tSg9iN0
         3y+sGVL8g9SRRsJjiJ0WVFWzveSwxYghk1GJFx5ZNDlOiLtwuByOpWl+vZ9McdOPZJOV
         jC/w==
X-Forwarded-Encrypted: i=1; AJvYcCWEsdY3fZyIgCFOOyOn7h0+Uyd2f8DzBpf/qR6F2xwTJDuldGbt9PewRSmtsjw/h6NJ2oI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLaT9tQXAWMZDFvUZuOFvNQl50DVLbq9bdNIKXoOypquXiTif2
	GFj4hLTHh1SH8U5UPuQt+AupyV8xlG1ZUAgYvgE1mM09NDr/NII6LGY7jnGXW+ZPf5BJpyYJlr1
	K3YlGwOl+KelIdZQ2Idtsv78AwEY=
X-Google-Smtp-Source: AGHT+IFhJw7MK2/Dktd677gXCUblf8gV5uU55xQ07GBCqBlSwIISg8pxY9BpmQ4WND6vAa6K6H+ALUMuS1cW2PbjB9U=
X-Received: by 2002:a17:90a:c481:b0:2e1:89aa:65b7 with SMTP id
 98e67ed59e1d1-2e2a233003amr2441200a91.9.1728468578832; Wed, 09 Oct 2024
 03:09:38 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 9 Oct 2024 03:09:36 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <ZwZPSA-J1RFQKYrw@pks.im>
References: <0084cc18b6d90ba14849a7f788939f4a1d0d61c9.camel@gmail.com>
 <ZwOVy4FltrEjxHn_@pks.im> <867f42bea10de470532d2f30eacceafa2b03d8de.camel@gmail.com>
 <ZwO-j0C59vuYsEnt@pks.im> <a8807b44026458097267932f429ef61d5b77aa4c.camel@gmail.com>
 <ZwPEwL-fKHBkUOcm@pks.im> <xmqqiku38w51.fsf@gitster.g> <ZwZPSA-J1RFQKYrw@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 9 Oct 2024 03:09:36 -0700
Message-ID: <CAOLa=ZRMqRnUn0daZ2O-TCbyJzmc6LVGx9Yc+V7VJapB+FyPCQ@mail.gmail.com>
Subject: Re: Bug: `git init` with hook `reference-transaction` running `git
 rev-parse --git-dir` fails
To: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?Q?Gabriel_N=C3=BCtzi?= <gnuetzi@gmail.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000a5bb0a0624087325"

--000000000000a5bb0a0624087325
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Oct 07, 2024 at 02:02:02PM -0700, Junio C Hamano wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>>
>> > `$GIT_DIR` _is_ defined during hook
>> > execution. So in theory, if git-rev-parse(1) behaved exactly as
>> > documented, it shouldn't even care whether or not it is executing in a
>> > repository.
>>
>> I've always considered "git rev-parse --git-dir" and friends were to
>> verify the validity of the repository before returning "Your GIT_DIR
>> is here".  Otherwise there is no easy way to ask "I have this directory.
>> Is it a valid repository you can work with?".
>>
>> So, I am not sure I agree with the above.
>
> Well, I'm not sure either. I was merely pointing out that the documented
> behaviour is different than the actual behaviour. Which of both is the
> more sensible one is a different question.
>
>> For what is worth, I am skeptical to the "solution" that tentively
>> creates a bogus HEAD file while the repository is being initialized.
>> The code today may ignore certain bogosity in such a HEAD (like the
>> ".invalid" magic used during "git clone"), but there is no guarantee
>> that a random third-party add-on a hook script may invoke do the
>> same as we do, and more importantly, what a repository with its
>> initialization complete look like may change over time and it may
>> not be enough to have HEAD pointing at "refs/heads/.invalid" to fool
>> our bootstrap process.  If we were to go that route, I would rather
>> see us pick a pointee that is *not* bogus at the mechanical level
>> (i.e., "git symbolic-ref HEAD refs/heads/.invalid" would fail) but
>> is clearly a placeholder value to humans, soon to be updated.
>>
>> Let's say if we were to create a repository with the name of initial
>> branch as 'main', we could create HEAD that points at refs/heads/main
>> bypassing any hook intervention, then call the hook to see if it
>> approves the name.  We'd need to make sure that we fail the
>> repository creation when the hook declines, as it is refusing to set
>> a HEAD, one critical element in the repository that has to exist,
>> and probably remove the directory if we are not reinitializing.
>>
>> Or we could use a name that is clearly bogus to humans but is still
>> structurally OK, say "refs/heads/hook-failed-during-initialization",
>> ask the hook if it is OK to repoint HEAD to "refs/heads/main" from
>> that state, and (1) if it approves, HEAD will point at "refs/heads/main"
>> and "hook-failed-during-initialization" will be seen nowhere but the
>> reflog of HEAD, or (2) if it refuses, we stop, and the user will be
>> left on an unborn branch with a long descriptive name that explains
>> the situation.
>
> I dunno. It all feels rather complex.
>
>> A much simpler alternative would be to simply ignore any hooks,
>> traces, or anything that want to look into the directory we are
>> working to turn into a repository but haven't completed doing so,
>> during repository initialization, I would think, though.
>
> That could work, yes, but it would limit the usefulness of the hook. In
> theory, you can create a full log of all changes in the repository from
> its inception. If we didn't log the first item, that log would be
> incomplete.
>
> We have another solution that is even simpler: just do nothing. I do not
> think that the behaviour we exhibit is wrong. Unwieldy? Maybe. But it is
> merely stating facts: we are executing a transaction in a repository
> that is not yet fully set up. If you don't want that, either don't set
> up a global reference-transaction hook, or alternatively handle that
> edge case in your script.

This does seem like we're putting the onus on the users, but ultimately
I agree with this. What the hook is doing is as expected.

Thanks Patrick for responding while I was away.

Karthik

--000000000000a5bb0a0624087325
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: b675fcf4bfec5a9a_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jR1ZsNFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOWhaREFDTmFLUVFTVUdhbUJrbHlJWU1IcXNFc2RzWAphdmsvc3hoTHJI
UktTbHMrbWU2ekxrSHA5bnQ5c0VsS1FjMlE2ZXlpYTRLQkVHVTFpSjZ1c1RPcVE4enluMkdkCm9p
YmZ2bllkUE5WWEhNYmxndllQK2ZBaHRxVDhnSW4wM0gyYXBmZFFTaFRnUjUxYUwydVE0UU9Fbi9F
ZnBUa2YKTGZjYnhwUUhvcG5LYzhEZDRFeWR2eXhjT1R5MFVXNlRkSjZ0REM5Q2Q0VXpicU45YURW
RFRNRnlUYkl0dVExNwpqRGFIa2EwVjh1TnV6ay9JMFRUZWkrbUwwRDFVbFlJSk5RYVFkekxzazEw
UXpmY2dXbzFibkM1Y0Y0M0JmTmhhCnhmcXlFV0JuVWUrNGs4dEhwQUFPRUtQcDVzck9ZdWkwR2xq
Zm9wMnJZZDZJeG8ySm96MG9zdkNBaEx0cnRZTngKSExPa1ZIVy80dndMbHFjcGpKb3pqZ3puSFl2
MkkyMkRPQzB6blpMS0xvbEVPbHY1TGpIOEtlQVVxaWdNVXlRawpVa2lVNFlYVHpEV2d3d0srTjc3
Q2VZM3ZUaXJvY05zZ3hrcVkzL3Z4RUE5L2xQWmNPRGJVSXJsczR4QmloRGRXCjYxQ0hRei9qenZW
ejMxZXdFUlZtZUVuSzJiV3Zmdm1WVU51MStLTT0KPUdRbUkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000a5bb0a0624087325--
