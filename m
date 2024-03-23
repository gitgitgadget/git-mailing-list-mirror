Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9674B1E526
	for <git@vger.kernel.org>; Sat, 23 Mar 2024 15:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711206454; cv=none; b=VlkQ9OeRi4tPBG8kN4CQxwS9qRwicvv2vhcvAHwnO5vMWWJidjyE2l2yCCPTtVoZGzQRpSJq/o1TSCMuk7Z2Y7i0fBssbcpsC1uy8h31QYLgm10P7b9M5JH/MH0+Lr9MbDdJzUd7BrdpsxZgzwZBMRmGBJ7u8tEFglA8V4T1GYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711206454; c=relaxed/simple;
	bh=KrEcXs2vU9CHd9imCkbU8h78xY5+7RbGpsmHtHmKdxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=et/YLkNzzRM4BLREXwg1W7Vere13/qW+xWme15PHVgmiZ0UZOhbISgWSp02AYscv1HbDalQisrAPQe7MvZ3gHSFDsPcExfbqY/y29f98q+IUewngYOekKSg6QbeU69Kaz1TOI8AOU7t3xHVjnm0sFVZDiL0lwFQpLzJq2AQDLok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QkYHBYvb; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkYHBYvb"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4d47000f875so1052691e0c.2
        for <git@vger.kernel.org>; Sat, 23 Mar 2024 08:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711206450; x=1711811250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KrEcXs2vU9CHd9imCkbU8h78xY5+7RbGpsmHtHmKdxY=;
        b=QkYHBYvbcnnCHn33br+dNSqryY+wOunjeH4CioA+Fr/okWD+dZ8Eou2a7sxMRVHhD3
         qC8DNR3JLq+kjg8fFifDBSdC4KdT+huS8OQgz7J8SdxSLDnJ9hUWdkyocSAuXwZIIQL4
         xgwOnA2aT8hReINAggFjxW44ezCRDRy4SO195VzGd5uxiS8/DtzRZv4MjDi9N9p7CFlu
         7SqOBAVyqGw7LVKgEW1B/0COvP7M2hvo96SkylPxsbDgR3wo8zYp3pnhW4w+vnKbsbTd
         0IAvvAqnPcN1AaYF2Yl1mb2n7KJOsHWkvijLLppy31/aN6ap0Y5LYMnO6Y5Z01IzNN5N
         RvKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711206450; x=1711811250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KrEcXs2vU9CHd9imCkbU8h78xY5+7RbGpsmHtHmKdxY=;
        b=FNYbct8P2gUGv3ci/SU4xn1+G0gXCDIoiW3KMZI4v9Y3EeHdbVfVF0Y5J6srsyWYbf
         dhRLfBZiKYtvnJqf0YJBaalvkzUyaovVFY9TUvPO4koeBymuvUWWQUVUe9p3qb6WusWB
         1hDbYmPSyrcolRreKCdMjWu0cOPvtc2SPlaTkDMf4e8mA5M0x5a9RRc1aUOWf71xEoH+
         uR4dPeqmt01edvPaJa/UgfEOIvAoQiOEOboGERkfJy6aikq9g5IOnrKWpwMryhKuJ3jU
         UotM60I6vwdmx0E6Yk/Uk42rKCpR9SS4L0Fs0IFmNXFJFuXtVdihQp4t7qfsN7x6ct91
         Fbtw==
X-Gm-Message-State: AOJu0YzAlm7WBWnjo079KUUecFriw9/HtinvyN1b7VUiiwU5qSl4w2Hk
	OB1UjcZEbvTNqPvo8Ex0jR5T1UIEeVDmybL+AzrOYi4faws+L7C2knrUrucFYOC1TydxNPIh80C
	KF525ZN/p6+0MrVxvcPzLEQr8tUOBI6loD8I=
X-Google-Smtp-Source: AGHT+IFPxLCmA3xeUGrK5bfdqF1HRDDPikYI19WtuzaU/MTQ31vmzF/NDJD9zvI3j72Wv8PzBQ1Gwg1Pn94nxRBxGgE=
X-Received: by 2002:a05:6122:1682:b0:4d3:3adc:b639 with SMTP id
 2-20020a056122168200b004d33adcb639mr2204706vkl.6.1711206450343; Sat, 23 Mar
 2024 08:07:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319185938.243667-1-utsavp0213@gmail.com> <ZfwmMKLBjtYvUPUV@tanuki>
In-Reply-To: <ZfwmMKLBjtYvUPUV@tanuki>
From: Utsav Parmar <utsavp0213@gmail.com>
Date: Sat, 23 Mar 2024 20:37:15 +0530
Message-ID: <CAD6u1kgiLmes_CCzr2sp6NFDgxo8c0ZQp793H66+_iMtJ+CdqA@mail.gmail.com>
Subject: Re: [GSoC][PATCH] userdiff: add funcname regex and wordregex for
 typescript language
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Please be mindful that we typically wrap commit messages at 72 columns pe=
r line. Furthermore, we don't typically say "This patch", but rather use an=
 imperative style. So instead of saying "This patch adds a biultin driver",=
 we'd say "Add a builtin driver".

Thank you, I'll keep this in mind. Although that wasn't the intended
commit message.
I tried to create a single patch out of the 4 recent commits and send
it via email and this is how it came across. So, the 4 lines after
that are the actual commit messages.

> > gitattributes: add typescript language to hunk headers support
> > t4034: add tests for typescript word_regex
> > t4018: add tests for typescript funcname regex
> > userdiff: add funcname regex and wordregex for typescript language

> We don't usually provide such bulleted-list-style changes for each of the=
 files. In this case, it shoul be fine to say something "Add tests and docu=
mentation for the new driver".

These are the original commit messages ':|. I apologize, I'm still new
to using a command line mailer, so please bear with me. I'm learning
how to use this well. On a side note, is there a mailer that you'd
recommend?

> Last but not least, this message is missing your signoff.

I believe I made a blunder while creating a patch file since the
commits are signed locally. I'll take extra care to review my mails
before sending from now onwards. Thank you for your direction.

I'll submit a follow up version with patches for each commit.
