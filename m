Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54352F12D3
	for <git@vger.kernel.org>; Wed, 10 Dec 2025 15:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765381220; cv=none; b=gv4RIfRYMZKs3h/3G2M/l4K8Q4EyRIMTe8q68ZKgHuwASL4NbAEr4rjGaWGvQpvzn5cHeE5SJnkxDVYrA1LWW1ASVl5Adxo1NigOUaztP/mIAnHKdct0T7uDCwM8aHdYEt0knpw8ROmqQIwVe7qtH02EamxC/+6vywb6A28he2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765381220; c=relaxed/simple;
	bh=B9/WF/W2HWW75h1pZ9B/VrzZzAuDsOoPTOyHyODJtCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mf+jUjSEAp7BYyGj/Bsx+WcJCf8wbXz3E4NdmOALdZ7ysW+wGijwgcGl7iXoxYYzdaoyzQ9+jlTWWJpBJ5Sf0KFloX08JUiSwqBoooxulSnXicFUEI9id4SuQsnO0VFtnTYPL45aYTSZfgcZDhD7v752yeou8HMlfZxNbtyg6kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OeBusXjs; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OeBusXjs"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-65727896f35so3897120eaf.2
        for <git@vger.kernel.org>; Wed, 10 Dec 2025 07:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765381218; x=1765986018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V3ey5Ked2jxBLZgwnUhx5fAQei7rAkX4TOPObSLBrgw=;
        b=OeBusXjs1fGnreekKA/Lf0EcxHuvNzGwosIj7v6mGGSv637XNjkAozPU+O9PouGmjc
         UEknyvLSE+gh0XDQiILZlvZxAbXisYgI7oRJmM0HRS7j6XPCxHr7SLzQ7/tdSz4Y/ib3
         J8nOB2uUAvNaJwlqKYPwHATQtmepon1eXCQqWsHyw73fT+eoNnsR6p3qo1ct8ZMPlDuX
         jeRPp4FmuD8cdShAEXhIxQKA9thxbRRLWMp/gtOOS7Px3YLZwWdmHJ4WNiURBoacM12N
         DRqhZSDE81Lz9LpTFoUBoVubtFZpoKRweciggXyS3wKZtTjp1ED1vgklUrn3kJW/wrII
         4Eog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765381218; x=1765986018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V3ey5Ked2jxBLZgwnUhx5fAQei7rAkX4TOPObSLBrgw=;
        b=o0GJRyBqp28cR+D5tNYzz4p/ArrsOnXVb+vbQkZjPP7sm4P+Ubs0ZptDy+fPLSnU9u
         ZG3Hr3Tfu3mHsIaBGxyCYwIO0WHN87Efxd8H7DqDraGDk1QNgf9ucQz6nFSGy1LbVgwr
         XMa2GE4BVZPzhRocw0KwssYoJUWWKada56elkOHKhfEjd+uEjhSg+PLa7Hs5/v5LD9gC
         PT1WLiroDirWgdc6UvO2wl/uhozYX1C8Nyo9DDVzsgm5IB3JA0J13e9IOslaVFmC19N8
         CmJ0/yOGGONpTWzh0a50szTBYbyw0SVXwvyndybcO0dWdw6Q/ZtbNnwZPvlNcpY+NL/C
         dKmg==
X-Forwarded-Encrypted: i=1; AJvYcCXghbmNGoToPg6gjNkhW3hG8ddUEIbcoKD68+B9+thQ13QjzrtT13cUcXPYEBUgfk6BNwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZOmEaYlSdKcX4yy809+zrN+SziYQu/QU3qPkOHkcupM6xPAiW
	JoyuVp4Cc1eBqbcrxP9UekWj69rT/wx2A/liEyw0sGG+vk+DUMlwR7yVyoJuWLQfUq5TFBOaPHF
	h3zVxUcMhD82GnjeqWLFbrRQqIc9dz5c=
X-Gm-Gg: ASbGncsE4LiCL1NQUMNg9CU10ZatqDXVR/ItegRtB0gy+7httFAS0DfVIPpckScXqOH
	6VDm0OpxbbGIkujBhjXquaGsDaf0vOAX1Bh8OxHHLr99EY1/LgJTwvv87vWx7EKf3McL3ElEcpB
	2UdON7lsnx8+3UZ5NqKfYqfnAOVew3daQYYhzN9eWkCkS6cW/yOSl/7F0q0vyDCJhp9iYbXFdyp
	XuBRqUcoWGfGqfEuqcSoFCEDruxibSGySu4vuk6XrxHhQuZ+f3xKoUVjsc1WuJimKUnXfreiVqN
	4UnEAESEwnSOsrKtOcvVRzeWebPN
X-Google-Smtp-Source: AGHT+IHFfYzw8UtcusOYV90WDMaDML2zyPGQh+RZH1/MAyjSZm28IL/V2EbScz3iCucIfzSG0lSCq7IFohcsQj8rDv0=
X-Received: by 2002:a05:6820:60d:b0:659:9a49:8f91 with SMTP id
 006d021491bc7-65b2abc1abcmr1819079eaf.10.1765381217883; Wed, 10 Dec 2025
 07:40:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CV_replay_conflict.101@msgid.xyz> <xmqq1pl6lzt6.fsf@gitster.g>
 <d2a72ba5-ac7c-490f-9f2c-6cf849e65180@app.fastmail.com> <7d0201aa-905c-4da2-932d-47666c923875@gmail.com>
 <202f7015-1e7f-493e-bd82-474e5cefdf01@app.fastmail.com> <xmqqzf7ri7q7.fsf@gitster.g>
 <74a705b5-bafe-4304-86ea-fd3873ae4fb4@gmail.com> <xmqq1pl2im8x.fsf@gitster.g>
 <85ce46a9-a097-462a-aa1b-904eeb7b89ad@app.fastmail.com> <12b0e7dc-4c00-4f0e-bef7-ff76f3054b71@gmail.com>
In-Reply-To: <12b0e7dc-4c00-4f0e-bef7-ff76f3054b71@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 10 Dec 2025 07:40:06 -0800
X-Gm-Features: AQt7F2rJG6cj8FpA3anG2uvwkeadfiEL-FRm2BEoHC7oo-IbpUExRsiJcaWmhEo
Message-ID: <CABPp-BHk+Vm5PvBJ12T50kZsZM1DFOj5eZ7sAPu8j3sanF8SKw@mail.gmail.com>
Subject: Re: [PATCH 0/3] doc: replay: improvements like "mention no output on conflicts"
To: phillip.wood@dunelm.org.uk
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>, Junio C Hamano <gitster@pobox.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, git@vger.kernel.org, 
	Christian Couder <christian.couder@gmail.com>, 
	Siddharth Asthana <siddharthasthana31@gmail.com>, Toon Claes <toon@iotcl.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 10, 2025 at 6:14=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> On 10/12/2025 12:04, Kristoffer Haugsbakk wrote:
> > On Wed, Dec 10, 2025, at 12:56, Junio C Hamano wrote:
> >> Phillip Wood <phillip.wood123@gmail.com> writes:
> >>
> >>> We do talk about "branch heads" in our documentation and they point
> >>> commits. We also use "tip" when talking about the commit the branch
> >>> points to so maybe something like
> >>>
> >>>       Update all branches whose tip is replayed
> >>>
> >>> though I think it would be clearer if we could say "commit" somewhere=
 as
> >>> that's what we're replaying. I find the concept of "contained branche=
s"
> >>> rather obscure.
> >>
> >> Thanks, I do agree that "branch head", "tip of the branch", etc. can
> >> be used pretty much interchangeably, and using "commit" somwhere
> >> would make it clear.
> >>
> >>      Update all branches that point at commits in the replayed
> >>      <revision-range>.
> >>
> >> perhaps?  I dunno.
> >
> > I like this. Or just
> >
> >      Update all branches that point at commits in <revision-range>.
>
> I'd be happy with either one

Same.
