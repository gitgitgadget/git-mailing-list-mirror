Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBC217545
	for <git@vger.kernel.org>; Sat,  9 Mar 2024 01:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709949438; cv=none; b=pdbcTF6XTOcdYaYOcJIeV2L/veRnrHzPAYp68ATPG/4q4Qm5nnobm08+VXvXv6etU+BrTGvfucJQiOoDfmT0mG5F4W8pS5k0Xdly++Fy2HqPDoBoi2H2T313UNL5t9Q+x1szV3Su9wKSDwOwzT3Hx8ZvjdYmoGXYWq4jvP+wGOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709949438; c=relaxed/simple;
	bh=zfbqKeJd6B0XnrNRqAdSaXVbIFaNpSwX7egxP6+Qq1o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ig0SOkFH4nwPTQGDAv0KynRCAyybG2EmHGrw/fWFAv7aRcZ8/+kxsGW8oDX7pPz3ymtg0aXfKhz1dRXzP9zQaka6NXKU2gV0oFDpYAOoXuqZ0vs+2HNDEKR9VVWLZrnzKGV0LaAEBUMFy5GrQXud0aV/mPkne3TtZqaQw28ZPko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TfuGQcdK; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TfuGQcdK"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcd94cc48a1so4379752276.3
        for <git@vger.kernel.org>; Fri, 08 Mar 2024 17:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709949436; x=1710554236; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zfbqKeJd6B0XnrNRqAdSaXVbIFaNpSwX7egxP6+Qq1o=;
        b=TfuGQcdKQv3u8OZk5Y7zP8WM5SwCIma8VR82vledDT6uq6NvYDgp39msSH1wWI93VN
         ToENC3NfLZCZkgUL5IPQxwjIJ06nh4QoeeBoJ5pMVkkeP8R5BGv1qkLxNQ1nMzCptQKX
         HbYkRzjSnF0aAXtEGIJoS1801mZLdLwTac3q6kTXzbBfExJDLpRi5RXcDt26uW65Isy8
         JQcEZ6B7iQ4lYxDvYoLfOMrgyybM2POWztwDrf/t9MJ+YzyrdKmcYJ5qj2wuroVH2OAw
         nx5prCxpxpWfqd5UX2HSvQKaUg+B+suGfa8FtEZcJcpIdly2Ey3IKUwZoKV5sKDrHIVB
         s93w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709949436; x=1710554236;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zfbqKeJd6B0XnrNRqAdSaXVbIFaNpSwX7egxP6+Qq1o=;
        b=PPuYNdJeeKG9VFp3Zhli8avd80wpVdU3anDPCaWnZ9ZkhOQyeudCqa4gA7x8i7j20Q
         9gyO2djo/gE9Jf2/VWtTc+cgiMuUqrnUbm16b7U0cF8YYxa3Os141XDeayfsKQsGiHQB
         1XcxgaMiWQZ5IlVHb4kmrbv30j5YgCS/EvxbgkmCh9cULMDC57Y7XFEnDy+ZD47gJhSC
         pXaYnkJUF/FrtQtpnQ7lb0PgcPKn0OpQd2YONZyxuaI2rBZLg0CJMlams/4ByPOe+Piv
         6FSkhbX46VQLy4gFTjUGFgGaKbYzPYk1cMwielJqaKSOm18w+7mLvG4p6QeSnvMSxC8y
         9Kfg==
X-Gm-Message-State: AOJu0YwlgdyCqam5cal3V2GUKwWqStGlXLkKAsBIkk6Rzr9dXjkEHzul
	W6XL88sowo3sdaxSX+yLi8lHPSeWR39QDGC4ucAmIQ/KMAiExzZvMzkeGNH/QsHs3OCoGD/Uefh
	qJw==
X-Google-Smtp-Source: AGHT+IHRkEgfPZ0waUlKfC/wtX81fZl0d2ztccuMkndxpEJYTpep5HfE7Hj8sIeiKqDbWwzh5+IRA0CiUGg=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6902:70a:b0:dc7:68b5:4f3d with SMTP id
 k10-20020a056902070a00b00dc768b54f3dmr121376ybt.11.1709949435918; Fri, 08 Mar
 2024 17:57:15 -0800 (PST)
Date: Fri, 08 Mar 2024 17:57:14 -0800
In-Reply-To: <20240217052932.GC539459@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <xmqq1q9mmtpw.fsf@gitster.g> <20240215053056.GD2821179@coredump.intra.peff.net>
 <xmqqv86pslos.fsf@gitster.g> <xmqq1q9cl3xv.fsf@gitster.g> <20240217052932.GC539459@coredump.intra.peff.net>
Message-ID: <owlya5n8416t.fsf@fine.c.googlers.com>
Subject: Re: [PATCH] git: --no-lazy-fetch option
From: Linus Arver <linusa@google.com>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"

Jeff King <peff@peff.net> writes:

> On Fri, Feb 16, 2024 at 09:22:20AM -0800, Junio C Hamano wrote:
>
> [...]
>> Add documentation and note that for this variable, unlike many
>> boolean-looking environment variables, only the presence matters,
>> not what value it is set to.
>
> Yuck. IMHO depending on GIT_NO_REPLACE_OBJECTS=0 is somewhat crazy, and
> we could consider the current behavior a bug. It's probably not _that_
> big a deal either way (because I would not expect anybody to set it that
> way in the first place). But I wonder if being consistent across
> variables trumps retaining weird historical compatibility for such a
> far-fetched case. I dunno. I guess this is https://xkcd.com/1172/. :)

I totally agree with your take on this. Would such cleanup patches
(e.g., changing the behavior of GIT_NO_REPLACE_OBJECTS=0 to be "false"
instead of "true") be acceptable as #leftoverbits?
