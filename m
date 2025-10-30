Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C66C341645
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 12:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761828930; cv=none; b=AtoiWBPQ3lYotcAd3QYsaCxhI7labXD0FvYlwIODbW7deI/Aw87BaaK3teXZ5mMjlJgTbg+b3SKwtA9urlQ/TEaf89CBR0del7QNBcM0+rMaN6I326e8Z85hlZH41k4O3zIBYTvGDwUeuWEEak0NZDeBwuS4pbSbV228GgbkLtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761828930; c=relaxed/simple;
	bh=VsGr8P34YN2jkWQdLMJh0B3pChrJ4RwnnH0rlTYFEFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p6UA72dXnfiT6PBA9S5Pzmr8osPsXz0vDwPQcxBwS4azq7SWOWm42e5hpYdiweDoam9Ah1Fuw7xWuVmaiYKtkwAb5gO+P+A33i8gsKHExCXziRaKhfancv5Cs7EL68LPXAmFM/ZeM7uqwsL9LUlTgqePvG067jbEpTgOlAvZ/uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hz0SapDz; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hz0SapDz"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-63c3d7e2217so1615925a12.3
        for <git@vger.kernel.org>; Thu, 30 Oct 2025 05:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761828927; x=1762433727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VsGr8P34YN2jkWQdLMJh0B3pChrJ4RwnnH0rlTYFEFc=;
        b=Hz0SapDzEovijl70KdEr4C8V8C+KlDaR6XHrTccR80rU7T7TZPBnrjeqM16JRoyWaM
         lPE9TP3IogWRvqJgNUWTCh+2WMmMHsGxhojVQ0LgoRxjoHLeQc+5MkNqxyUUAhJ0YSAq
         qNxRYPLcsOe6z+KWbNLWDwKD/RS92jJMraVVjrtlA6IScHSOYC+eEV3KhwbHXvDdKJa3
         2LS54aMKemu5xeVzRKw5M87zJHSp3gYLzYYiiiKTLpOvcQjuxW8H3KhfDLMd+Gy/yAaP
         LR6JbavewJ0/XD6OWpM2ICZJPqtMeKAO8PzIBtci54eC9aWdc9fYMFSbgBrpYBVJGhqH
         UbMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761828927; x=1762433727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VsGr8P34YN2jkWQdLMJh0B3pChrJ4RwnnH0rlTYFEFc=;
        b=iqAmAdixzPfvX+LgKt+eRYPov4r+suWYRn3vSj4/lHAKK+nRvmDm+xhRoq38fwwlLS
         Vki3+811888PB2Zb0J5KVQ/fgGL9KspV2Ki7r00xB0vUN9rFpWveQfDgYVjyaWREsXy7
         +Gwa+VLypu5H//vBXECwCMkx/K8qRdLNDQAEf6o7IcsrTEHGelnP8gIMOg9skSFYJo77
         Ydva0AbbLUs2Wa63BlYNXcl57zF6AtSs3eNxv2pvOc+/mP3hkmCT8caa35cSJIpiNgcn
         m+zbF8KYkwYR+zR0msV3As/TQp35pgckbCYhYEEdJu2AMZJFQO3UEHnmHydfvtfBOIW8
         XpJw==
X-Gm-Message-State: AOJu0YzuU3k8auAqwzFcgII1lLOUw1f/R5GV5xbgWSNz1lQHr2gUN+tP
	AajzOMqia05sw0ATZfyWWWMUYUrDO0VkWrRlwtJDk2ayxH5MkZVwhUIjeKEMcuGh3XGC3ZUdw1a
	xeYc27FhmIwumrfGWqaSCOf9cGTolCskCPg==
X-Gm-Gg: ASbGncvRbAlaf1b6zbzBbsI9tQPz8pBuSdiucEpyTZ+ZWaHHW2a+PlqRrMDnCEofyu3
	g4zItC/N8Dqhv+bHBQp0PmkY2BT90+xQzH0f4VksTX9lgUuzJgfaTDaXK8uZma4pTALsAbb3vjg
	MSXfIAtx6D5mn67LR1RrpNtLtZxc8NBAlAp7daKyEknMXubLj8ahDVB/GkQdDb0YJ4VWGkk7LI/
	Z2/XCHfhyMmLxd9jhREWYmTmsMRFyg/I/9W7dO8EdwTZ2GQehw7JH59sns3t9QrH+Z9WTrwZErs
	K0Pbsp7m/jOgsGkP1Q==
X-Google-Smtp-Source: AGHT+IF++PjUy2gKmIF0ghgaH7ajMv6Pv1n/7Sl4T0ABnhiQxEfcFzbgqP7AVGH9+ovBaRG2e3SqZmg+EFEcklhlilo=
X-Received: by 2002:a05:6402:35d4:b0:63e:802f:3682 with SMTP id
 4fb4d7f45d1cf-640441aef01mr5940349a12.6.1761828926830; Thu, 30 Oct 2025
 05:55:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAD=f0L9anYu4LKWGDKrwzBBytMunJ3UjTehNN9m2DigG8yCNHA@mail.gmail.com>
 <CAP8UFD0a+RxQ-pPWrmwOYhBic6Oy9C1NeA7EmEyj2KYYDyS4QA@mail.gmail.com> <CAD=f0L8=eBJjj77xBw7m7WcQf80sYbF-X1wbFc9ToC9F0AWVAQ@mail.gmail.com>
In-Reply-To: <CAD=f0L8=eBJjj77xBw7m7WcQf80sYbF-X1wbFc9ToC9F0AWVAQ@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 30 Oct 2025 13:55:14 +0100
X-Gm-Features: AWmQ_bmrdlFdkJDK48MndqS-jtFDsqNtOXfU7YcxjoXh7gDzxLcfCZvZcfi1QZ4
Message-ID: <CAP8UFD1v7yec7JwBGekJPvcq7kNJPuPTgWOVn+gBaw1+Sh2mdA@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BOutreachy=5D=5BProposal=5D=3A_Refactor_in_order_to_redu?=
	=?UTF-8?Q?ce_Git=E2=80=99s_global_state?=
To: Bello Olamide <belkid98@gmail.com>
Cc: git@vger.kernel.org, Usman Akinyemi <usmanakinyemi202@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 11:59=E2=80=AFAM Bello Olamide <belkid98@gmail.com>=
 wrote:
> On Wed, 29 Oct 2025 at 16:51, Christian Couder
> <christian.couder@gmail.com> wrote:
> > On Wed, Oct 29, 2025 at 2:18=E2=80=AFAM Bello Olamide <belkid98@gmail.c=
om> wrote:

> > > I also studied [3], [4] by Ayush Chandeker,] and [5] by John Cai to b=
roaden my
> > > understanding of the project.
> >
> > Are there some cases where strategies other than writing new accessors
> > functions were used?
>
> Yes there were cases where the functions were adapted to use
> exactly what it needs down the call chain rather than writing new
> accessor functions.
> An example is
> https://public-inbox.org/git/20250306-b4-pks-objects-without-the-reposito=
ry-v2-1-f3465327be69@pks.im/#Z31csum-file.h
> where the global variable `the_hash_algo` is replaced with an explicit pa=
rameter
> `const struct git_hash_algo *algo` in low-level functions such as
> `static struct hashfile *hashfd_internal()` and the call sites adapted
> to use r->hash_algo
> or the_repository->hash_algo in places where the subsystem has not gotten=
 rid of
> `the-repository`.
>
> This is also a strategy that can be used to replace global variables.

Your answers are appreciated, but, just to be clear, I think it would
be nice if the answers to my questions like this one were part of a v2
of your proposal. If I don't see a v2, I am less tempted to discuss
this further (which could hopefully help move the analysis forward and
make your proposal better).

Thanks.
