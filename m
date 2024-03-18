Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5BC2206B
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 06:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710743380; cv=none; b=JDHoTg3S6+fKchFiLT7tTrgY4bdMFNWZs2Q/WVSgxx5D73K7nKaSrfEFS8GBfIeS8wAqy+BplgCpvSGfuE8Wv+rYPTW2iiv1UUZY2D7Z9s771USRGFYeeUrPRpDTRfEWOrY1UHL70EoEt4ooxVs/Gq+SPvI6cq5AZ2aBVsjHu4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710743380; c=relaxed/simple;
	bh=L4uTYrS1JLSvwvRbLLin20AU++DPWiUjxpJ/7TqhNkA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ql97lkfI4Ji2dzGxTgletyrsHzmIMeO2nEpmDffq2vfQJwVKSXLVLklrF8yWgX/R6nMsZmqGKiCADcZZ12JygZCYf8WmRewtXzt1+VqXcaJzOkOnk4yjAK/iPf930d+dPVGUZrpVo7NMZpNb8U4DJ5d/SabMDnihc++nmYQy3nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k6tLzsah; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k6tLzsah"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-610b96c8ca2so17567367b3.2
        for <git@vger.kernel.org>; Sun, 17 Mar 2024 23:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710743377; x=1711348177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L4uTYrS1JLSvwvRbLLin20AU++DPWiUjxpJ/7TqhNkA=;
        b=k6tLzsah9WOqmoQTku9UqfC0RVj5RUSEwfBoVYoCYmvEBwh+ykhJImWNpd7o5vkFEQ
         zTuyxB8eb9WHP9gTRRZ4WyfAGFaJfX4IX4MKilyo7OO/xaeypBQMw6qi1BHdwR0u8Q3s
         OECZsg8kKeOB39O96ETsGRCXxZ1Jaf3ZqonKF+roTaQ4EbDXUcmknXIkuL3OCbnzexw2
         It6/Ewcaexj/L7wpjDe2C8f5dyFewRYLTZ9Pc6DnkLiSG7sw4exqq6eZsTSuwQb7DXvf
         Yn9gbsIykcYe5V7h7Zptdf5u4rU1rK8yOSIygyncatoxrvZFlBxbu1pa8HI6Qt3Hr9b/
         R9Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710743377; x=1711348177;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L4uTYrS1JLSvwvRbLLin20AU++DPWiUjxpJ/7TqhNkA=;
        b=ibva+s5hBimVBLyds+3VcsSwPIy4qbID5qHphG1wS+RQoOqh81E+ooEdhz9BmVLL82
         UunTrcG9UN+nY4Rm4yt5P1h533lDrx8FULoI60I4tDnFgLx34fienbzdPBbH+FUzwM6V
         cQHSqQzvE3Oh4A3YZRUpjlsDSCwN8TO5H+34aaBd9zGYZJLswVmFOKowjuMVLKw8CIRs
         OI033mUo+sR//7Z4gszHtWOJ3hd97UBdAEUrKSDc501YQhwQZaErmAO5XU/sI7JllsSn
         vjfe3JGPA1G4ieDGJNPSy4qIPUV/wyfcVjMTEh9ZngHMENxtLP3IzL3/wH54ejlvdVPM
         EtGA==
X-Gm-Message-State: AOJu0YypdZbuJKkZh+L7nVFJcK7rG4IaJ09ihyrS23foBWREaNTRI9PX
	yPFQN1MVO/OWh+eAv4RojJkOkrQg6zLpnIWn5Fif7cmABJVpzCFxjxydFsezzPH3bych2WD5g8g
	Wdw==
X-Google-Smtp-Source: AGHT+IEn2m35h+/zgf3CF9rO1oAfrf4xdu7OUda9iDjoNOE4aGjqrRfbR3wjub2f1o79vU/dfYLNvB+lEgE=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6902:703:b0:dc2:550b:a4f4 with SMTP id
 k3-20020a056902070300b00dc2550ba4f4mr2820793ybt.1.1710743377341; Sun, 17 Mar
 2024 23:29:37 -0700 (PDT)
Date: Sun, 17 Mar 2024 23:29:35 -0700
In-Reply-To: <17bdc28ea2b88503.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <17bdc28ea2b88503.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
Message-ID: <owlyv85k2gts.fsf@fine.c.googlers.com>
Subject: Re: [PATCH] docs: correct trailer `key_value_separator` description
From: Linus Arver <linusa@google.com>
To: Brian Lyles <brianmlyles@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

"Brian Lyles" <brianmlyles@gmail.com> writes:

> Hi Linus
>
> On Sat, Mar 16, 2024 at 1:53=E2=80=AFAM Linus Arver <linusa@google.com> w=
rote:
>
>> Nit: This line was modified to have " each" at the end. If you did that
>> on the next line, then this diff could have been a touch smaller.
>
> [...] Is there a documented guideline to follow here, both in
> terms of preferred wrap width as well as when it might be appropriate to
> stray from it for reasons such as this?

WRT line lengths, probably 80-ish columns is the (unwritten?) rule. The
text files aren't really meant for end-user consumption (that's what the
manpage and HTML formats are for), so I think it's OK if the line
lengths are roughly in the same ballpark (no need to worry too much
about exact lengths).

When I contributed some patches to the docs last year, I was advised to
minimize diffs where appropriate, to make it easier for reviewers. In
this case it didn't matter too much (the patch being so small), but I
thought it was still worth mentioning. /shrug
