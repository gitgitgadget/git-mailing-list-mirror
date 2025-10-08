Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988E634BA5C
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 21:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759959044; cv=none; b=P2/WnS88zUxfmLXCTTlh4hf+PDam0Z8gXLK4UFIgxAp/vM0M72b+fGehM9zPSNv7g74SeWnIsuz5fWwuEilsj/PTuN+lpbTAMtFiz8HSDNEjFtR9wXGnHfMUb3fvguzfatZLX0Pd0hfgpa3qoCVIj0Ak9lnl9XI1eY06Yo5IpFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759959044; c=relaxed/simple;
	bh=Fa9GbPK41V/k3yQbNu7BsArBziORDwR1A8GET0WVkJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EJy9MmUWDT52+hfxCQL70+01ijK1xpyvv7w4reoTrfhD12ekk2KReQkogo+C95jY6Zhae9ip5EIRQdNV2JDdk8vN0aUevJeCl965PrkQgyUIHCbo5vJdY1nKLLsx309DdjX7Wo25ARB7hoyElLBTR3ROwLlVjKrOrj6LtWvt2qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z0vCRWsI; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0vCRWsI"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-42f788ffec0so1543695ab.0
        for <git@vger.kernel.org>; Wed, 08 Oct 2025 14:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759959042; x=1760563842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JV4vI5ASHUkNKPoQdjUFxHZg/q9HYC840+9X+voAz7s=;
        b=Z0vCRWsIVEIRcxj6i3s73D5RaMeni6+l79HTMgSIcNrT4DINQGo5bqpRLLYE3MaE9t
         2agN0QWcAgcaSGRAcdeNAWSyNq/epkzNZqo21Yss3QsWfW28+HC6oQzTwm/y8BqTD5ep
         Bv8+B81Run3wLmCKfYLXeY2isW0kni6AWCeTlwTh/JOG9J+MCi4Gss/NTIRMJBn1duLY
         Mg/eioFN4AsVksyjHzit0qumu89izeu3UZ5cgg/H+eEyixIyZyQHbtKBqMwL8rveINjR
         uJfjR6uD2T6BwuT3qJ+4C/uGvAJvA05u73Dgp9lGXCSaxmcE0KqyZyNlKu1WBHh4FBMY
         /hcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759959042; x=1760563842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JV4vI5ASHUkNKPoQdjUFxHZg/q9HYC840+9X+voAz7s=;
        b=P8lK6dmPYNBAV82Tvt3I4hMjU1IIWim9+uWKN08tmD6G8DXlHPnKHYf64PEGdmpSCw
         VBwBvcAe3vbF7EAk+Ho70J5FZz9WwKxtoyTDaVMQI/0w88xboHYIUnz7eBYnuMtLqG8y
         rLi5ju40Gj7in2eTDgoBIAYTzjnegdsBvVwBGvS5aA/NSXbWajEYYZ8/bhBldW7mp6Dk
         yn59UpTqvkoUyPsap7EK/LnO1NbzythDi5M1RrXUzzb83uixX7WXyD/T02jeoCc8P0ks
         iYM+i10YU3UL96zZYjvtyJZRTz7TEXcGIFOoZXtgo1SMHOHxVzD3/7TPUIzMxv5pDzdM
         4RKw==
X-Forwarded-Encrypted: i=1; AJvYcCWnTy73xqfHk0Ns97u6cAWHpuCT7kaIoOo1eIg3ldByLCkBeqI5PPNp5lR/CZyxmGr+Fm0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs2sOuY9peaULHeyAm3fXcc90FJlkkpLgPxVtfrF6Bv40/7GoF
	7WTqNhNHwhqnQpiK4Sq6USFJ4RlCqZbnD7AOJfz+RDUURYbTzL2JpTm9rh/px+oF891iji2X1xr
	h9GRVhTv8C0sp1aBpOpiwe1nIoy04+PU=
X-Gm-Gg: ASbGncsVjZmajyFRgw63/bFFj60v19mEkQ0/AduJtb+jwTkifZaV5J22PNhkccJ/nid
	RLEoKVSxoIlNFTY+AjWyesgy0FuSwEbOAdLvKiXKS1HyJEyLICHdR+4pnwkszcUKZKdBPdyc28E
	p3ONktrUNS/UfU/LgJSpKNemvsuGhNrM+UUQBadcWqnQ2IVfH2xvcHxqJhpEciKQWBX3KzeaW7+
	bzYG1wKyMjoKdUMY6fCQT3DRjQ2j35J7GH/fPtWza2N9GW2gfY7LFG6vxnRhNJw
X-Google-Smtp-Source: AGHT+IGtBElEhtlrHKD+PQE0FEjGYQSX/Y6Wv1AMoYnvkav6sIOUvuEBlHHxT3wVn4FIZditkDQyWxfK+Gi7ZELs3ao=
X-Received: by 2002:a05:6e02:12cb:b0:42e:7589:6290 with SMTP id
 e9e14a558f8ab-42f87377de2mr48616875ab.12.1759959041431; Wed, 08 Oct 2025
 14:30:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908043620.57848-1-siddharthasthana31@gmail.com>
 <20250926230838.35870-1-siddharthasthana31@gmail.com> <20250926230838.35870-2-siddharthasthana31@gmail.com>
 <CABPp-BEh7VEM6UQjkK3CxJcv54vEmueTmh9+-SyTKUxgy7Mkcg@mail.gmail.com>
 <0fba2f5e-03cd-439b-90bd-f613fcc4ae23@gmail.com> <CABPp-BE9TV58duojhF_+R6bKDF6-L0md6j+1VeRFd8CJWF++LQ@mail.gmail.com>
 <xmqqh5wfu3o6.fsf@gitster.g> <ea7aa170-400c-47fa-b3f0-2623fcbfcaea@gmail.com>
In-Reply-To: <ea7aa170-400c-47fa-b3f0-2623fcbfcaea@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 8 Oct 2025 14:30:30 -0700
X-Gm-Features: AS18NWCmxHrD8Lpi3eTmTWAOhcykKW99_eiRV1LCyJnycJJ8JmllKLXv_4Kj9gM
Message-ID: <CABPp-BEuK1MWxmRc-a=1aPqLbXEZVF0qgHtYv_Z-1mXm3Ag5_w@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] replay: make atomic ref updates the default behavior
To: Siddharth Asthana <siddharthasthana31@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, christian.couder@gmail.com, 
	ps@pks.im, code@khaugsbakk.name, rybak.a.v@gmail.com, karthik.188@gmail.com, 
	jltobler@gmail.com, toon@iotcl.com, johncai86@gmail.com, 
	johannes.schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 1:06=E2=80=AFPM Siddharth Asthana
<siddharthasthana31@gmail.com> wrote:
>
[...]
> Elijah's --format idea from Kristoffer might be a third mode eventually

?

That was in no way my idea; it was all Kristoffer's.

The --format idea might eventually be useful, but to me the --format
thing seems like something you'd add to a very stable command, like
for-each-ref.  I think it wouldn't make sense to add to something like
replay in its current state since replay is "four times more
experimental than any other command"[1], where we're changing the
basic output format, where we bail on any conflicts or merge commits,
where we recently discussed whether to support first-class conflicts
and using that for handling conflicts instead of halting upon the
first one like rebase does, etc.  I feel much the same as when a
similar flag was suggested for merge-tree (in order to let users
control the exact output layout of the information it was already
printing, when it was known that the information provided was
insufficient to solve the user's problems)[2] -- it's premature.

[1] that might be slightly over the top, but it's still a fun
"statistic" of sorts -- see
https://lore.kernel.org/git/CABPp-BHWjyRv_f_HKkz10Q_cOZKPvpgf=3DSEUR1Thmbtt=
kQT+Uw@mail.gmail.com/
[2] https://lore.kernel.org/git/CABPp-BG25_TutatgNmK6vgq3akxpYHQ8QBnz-65_F_=
3oCA1nJA@mail.gmail.com/
