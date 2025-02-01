Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567AE2AD20
	for <git@vger.kernel.org>; Sat,  1 Feb 2025 10:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738404577; cv=none; b=IIIMN43vjuuZi7/uStO2B5R0zfEYBjLC8hjP6UlABuC6eDjaZffwc3XkPCa+Uq57Von26zs73+dtR31OtBNuQ1q4z/HdaEAZF9Gi6h2xW6g2OhhdDIHvW7j1esRpFEWMUIwb8b/LT1g3mZ3+HsjcN4zRBQtbv0QmV0GIgUEePEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738404577; c=relaxed/simple;
	bh=LB/4w92tb31LmIKtvYhhRa0glcxjKaeBP5s7N2gp4Bg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ryFyX/yIaKDH0O6vKckaTEGwYbSg2cY17FE1O5jdmvUNzB3CGFlCA6OCw1ctg0Tf4Ya6KI/20STyt4PDrfGTKkr7lwmbXFjGSjCHzBlG3ao2UYjyTHhIlQs3jLR8KjaYetARiZ9cjOk+nOrZk/jTV/0JvpO1VfO3Yw+TEV5oKIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aWNsuFjn; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aWNsuFjn"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a9c9f2a569so19338615ab.0
        for <git@vger.kernel.org>; Sat, 01 Feb 2025 02:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738404575; x=1739009375; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oz5eUF+e//WiHeDhmbJwqp2Wqi8vU1b2YLAl7T81ySk=;
        b=aWNsuFjn35TRCNRex5hiM+vacOCgiIsn8Q9N5iHiXGsvjyotyvi7XrxzbVIhkVZDOV
         okoGkplBSzLENFbDs8RxF/9swCLNE/aHYeGw67C1eER8Iaz3jSnPb858GlECxncgjqr/
         Ua01+C39ubH0B6MXr7/EJ6SACjPAAZ6Hfw1AzoNXWUQepLyVmcSCIGhIYJc4jD/JwV1O
         HW3jS6u1BsgSkBTa8XLjKTpYqbIe54M2cxaq67OK4TT2fncS5WWcVbgRiMcUKBCHuunU
         tGV+r2ETP4tIRTvGXDskz3z172efVKgVMobWHtd34gqpRLDyl3sWwq5VuW1Nc/JmOV6P
         00+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738404575; x=1739009375;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oz5eUF+e//WiHeDhmbJwqp2Wqi8vU1b2YLAl7T81ySk=;
        b=UvpIi+hozVkWbGaet7eE+oDrC4mq6g+E+BtQ0WT9btqpY4pKa15UJhkz7l+rNOwMF+
         E7t1JeYxeAlQFY2p2Sa402vZe/GQnlUOowp+sfW/sQ35NYSs7091kwmgRL8S5xkGkVv/
         6rVVoi5Ycq1IKtKdHcAUn5XgyjzpvpKyMJ4uoTqWzf45dcMFjeUpUVbsqhyHMTw0nQS6
         my9ptFfh32R+pKFjUawxfQfyjkKFnYMr2pRH60zr8KvClX4nOSm6nfMS3uGo78gghAp1
         1KAeh653hNIAjwmJmfGvz5IFOAxw6lkyEcYoNgiBtb9jezvHIY58FkA6bi5HVTv+qPY9
         /zAA==
X-Forwarded-Encrypted: i=1; AJvYcCVjLbKYovigxr2wDwHF948K51kOyn8HZIcV6l2hlD6IqGbXOdLs+Awg1Z6oGoCUnPSxp5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr7KHJCK/F1oaQrNy5MffmAAGRCizLUlZh0hc5GaWZ7NunmGZa
	A/WJmJNkhCFI52SbPJJ8i8uwypd+uQV/dUKNWOcs/2vDhaUv/nM3ceTuYmtrBmXXFFQbUv/As+z
	uxDisS/cOLIDs4eQRi/6l8RLLJAM=
X-Gm-Gg: ASbGncsjQtgQjUGc9XWDO7jGsjRnk+KhQEAsMFgS8vmA3LZx+HJYAti8PrYBD4oPJt2
	iVDpA/Z8zv2QwUXUkwN5PySyz1FnCv4T2+qQdN+3HsDr1UT5HIttprZ71tvT9/zwTCoye8fxXFg
	WZcwJoJiXwdpfBfmxJqGqIbeX20RqKZj0=
X-Google-Smtp-Source: AGHT+IG9zH1ovkTE0+pvNGWQZCA89vaWwPCLrItBsjTJKwfUAYUi9egp2lG+CVVqRasLEg2iN6B0Q7n90tbgk0Dwgek=
X-Received: by 2002:a05:6e02:1707:b0:3cf:c5b0:6a0c with SMTP id
 e9e14a558f8ab-3cffe3d1744mr133347945ab.4.1738404575211; Sat, 01 Feb 2025
 02:09:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAE-bwUQ+0ERbvC=SS=-R_K4H3p2su+=Ogf7BSkyq5J4GmmRYw@mail.gmail.com>
 <Z5rhXrkbhINwFDXT@tapette.crustytoothpaste.net> <xmqqy0ysfc2t.fsf@gitster.g>
In-Reply-To: <xmqqy0ysfc2t.fsf@gitster.g>
From: Mike Weltevrede <mikeweltevrede@gmail.com>
Date: Sat, 1 Feb 2025 11:09:22 +0100
X-Gm-Features: AWEUYZlARvOZHDTsPAxJ0u5oIkFJi3JUQqkCxledTaPeQEJVA_hv7yI_1f4Ctus
Message-ID: <CAAE-bwV4z8WO2v7FF+kAfNVU8Cd3RsRJV5rLitwZrr=s+PocXw@mail.gmail.com>
Subject: Re: Feature idea: Git hook for pre-checkout
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all,

Thanks for your swift and elaborate response. I think that those are a
very clear explanation and it makes sense to me to take a look into
the alternatives you propose.


Kind regards,

Mike Weltevrede

On Thu, 30 Jan 2025 at 18:25, Junio C Hamano <gitster@pobox.com> wrote:
>
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
> > On 2025-01-29 at 10:49:15, Mike Weltevrede wrote:
> >> Good morning,
> >>
> >> I had an idea for a feature in Git. I am not sure if this is the
> >> correct channel, but I could not find anything else. If not, could you
> >> please let me know the best way to submit this?
> >
> > This is the appropriate place to make feature requests.
>
> Yes, indeed.
>
> > I don't think this is likely to be adopted.  We intentionally don't
> > place a lot of restrictions on local actions, ...
> > In addition, this change wouldn't really be very effective, ...
> > `git push origin my-feature:refs/features/foo`.
> > It also sounds like you're trying to implement a policy decision on the
> > local system, which is the wrong place, as the Git FAQ outlines[0]:
>
> Thanks for raising all good points.
>
> Even though I am negative on adding a hook that does not satisify
> any of the "5 valid reasons" [*], this one squarely satisifies (1).
> But I fully agree with you that it is ineffective as a policy
> enforcement mechanism, and a local hook should not be used as such.
>
> Having said that, giving reminders locally and early to help users
> avoid making mistakes that will be pointed out at the remote at
> reception time via their pre-receive hook, only when the user does
> "git push", can still be a good friction reducer.
>
> So I am not opposed to an idea to have a mechanism that reminds the
> users of project-specific naming convention of branches and files
> (think: cross platform projects that have participants from case
> insensitive filesystems) when they create such a thing anew locally,
> especially the project would have a rejection mechanism when their
> participants try to push their changes that adds such a thing.
>
> Here, however, again I agree with you that a pre-checkout hook will
> not be an effective mechanism to give that reminder.  The mechanism
> must sit at the ref API layer in order to vet all ways of creating
> (or renaming) a ref in order for to be effectively restrict branch
> names.  For pathnames, the mechanism must sit at the cache API layer
> to tell add_to_index() what names are problematic.
>
> Thanks.
>
>
> [Reference]
>
> *1* There may be slightly updated versions of this in the archive, but
> https://lore.kernel.org/git/7vbq7ibxhh.fsf@gitster.siamese.dyndns.org/
> is one of them.
