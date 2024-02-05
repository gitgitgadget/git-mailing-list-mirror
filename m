Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675083FE5B
	for <git@vger.kernel.org>; Mon,  5 Feb 2024 16:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707151414; cv=none; b=gVQr+YlAeDa9jV5GVkv1AXpVbtPqb5xXdrjoDrV0SWOS8OcyZBnO4S7iQD32a6GWDncK0kfoWdJ1/YSfKK+asWZCV8Yw85uDH6AuEBu2AYKMcvD/R4e1IojHNPxpl8Q5UslcRLwNfEHYTHyukEQHyrOI+b5ZUIYy9fgdHzHzmDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707151414; c=relaxed/simple;
	bh=kEUytqHdV9XuQC/SDtX7Mq6/Xsud5BA0hv1poFGw01k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W7dqeJO+FTXeSIzEf6Z0Rppb0/AfqdKXgEpGB43YIzGdOrANz4SRsVOgAY0Q1M7yVw1QkehQow5GH5kVIfoi0zvwsCstG+eYtox8zGib3PsUQYAD09jJeh8qYhX6NEjoyd8Fi2/yTI2KZXcLuzAddR+uYqxFVLsr4aHlIfJOyXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nb5RK4zQ; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nb5RK4zQ"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a37ce4b2b23so107764066b.3
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 08:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707151410; x=1707756210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RVJ8BaAUXchHqFZKzmHNwXyolNB02oclljSr0583Erw=;
        b=nb5RK4zQdulS80XnCtMxUhHXiqcPyuAvFy10uiyT3h5KwN1T5fwSVOWsastJpcP9qC
         i93RrGsS3/FiRLmHTc4G9M30ejCS4NE8u6cIFf3NHlzEifwyGk9psiUncCRAXeoKsj3h
         Jwm3Ai+wxrPPnvc2zJw1gOWwDEjNtnqpvkOE0rHy9ra5MrkOygIRXrpbFc8vdq+izF64
         G/0w7Fz0EFLEUl7Ryrn1ojBcJXg7AxWsTIA/j4bhqSQvxPWR5CewZJxS1OlX/c6v2czc
         pVEE0tp3PoC3J5DCz8cxJi+2OoQMs92xlhN4gfhL+jUJTTqD+cu/AFjeGo6tw4Yg1QNv
         wDew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707151410; x=1707756210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RVJ8BaAUXchHqFZKzmHNwXyolNB02oclljSr0583Erw=;
        b=Goy0BoJlOZGOiP8axb4lGF5iSDh50yXUzbTd0kC4mK3r9/kyRd2kHvGUHY5HrWk7Ys
         jEK5WNrSSR6j6U3EIz63JxQzUXQ4P0xikKQwfISsy9tb3ZApdZPFdesio6f6oi8W+LY7
         rpJO9OkDzPEcjbHn4c3lxg8hOu/50e3QO95V5dAHYg9kuYP0p46KJ8P81ZPDP44rZ49d
         frReJMk2Lwqh3PVfXZvkjbdGXdLTCT9MCs++y9L6Cwm6GR62xjIr6I34xbtc3/dRmfuJ
         RBV7JcD3bvkaj0BD6eewwuCYFS9EwGO1MhOieSTd2b6xhEFOZDZUUaMfKj1+SvDgeVZD
         4PLQ==
X-Gm-Message-State: AOJu0Yz2Pvmk+yRO0AKX3no8jNI/S8KKBm9iQYCUf82KfiLmP7QQQBKT
	S+jURiGHmnciqbnWOO2aNiXjI2Y2+YVSSn5wF7VA9SWgsu8BkHOnxhqD03kt2Lf8sq6TzxkFYi8
	RZ/Ql1wB5QnEe5XWw6QIVlEFQEYw=
X-Google-Smtp-Source: AGHT+IFaWqCqoF2LUdX3gmr7flBVbj5HXbnz6dUXPahDFNs8trVDFQ9G1hD71dH1vqknHxfTwRZ0sai9oz8YD3Ezrp0=
X-Received: by 2002:a17:906:314c:b0:a37:4765:658 with SMTP id
 e12-20020a170906314c00b00a3747650658mr4822861eje.34.1707151410322; Mon, 05
 Feb 2024 08:43:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d4797f27-825b-4e2b-85a6-cc30f33934e3@gmail.com> <106b8e7be9ddc2d24670b01d54347dfcf9aef196.1707122040.git.ps@pks.im>
In-Reply-To: <106b8e7be9ddc2d24670b01d54347dfcf9aef196.1707122040.git.ps@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 5 Feb 2024 17:43:17 +0100
Message-ID: <CAP8UFD3F95TzytdpKO=LLf6Y_ejxwh9QtgAxRNKgMXW-72hjgQ@mail.gmail.com>
Subject: Re: [PATCH] Add ideas for GSoC 2024
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>, 
	Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>, 
	Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 9:39=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
>
> Add project ideas for the GSoC 2024.
> ---
>
> I came up with four different topics:
>
>   - The reftable unit test refactorings. This topic can also be squashed
>     into the preexisting unit test topics, I wouldn't mind. In that case
>     I'd be happy to be a possible mentor, too.
>
>   - Ref consistency checks for git-fsck(1). This should be rather
>     straight forward and make for an interesting topic.
>
>   - Making git-bisect(1)'s state more self-contained as recently
>     discussed. This topic is easy to implement, but the backwards
>     compatibility issues might require a lot of attention.
>
>   - Implementing support for reftables in the "dumb" HTTP protocol. It's
>     quite niche given that the dumb protocol isn't really used much
>     nowadays anymore. But it could make for an interesting project
>     regardless.
>
> It's hard to estimate for me whether their scope is either too small or
> too big. So please feel free to chime in and share your concerns if you
> think that any of those proposals don't make much sense in your opinion.

Thanks a lot for these ideas! I have applied your patch and pushed it.

I have a few concerns though, see below.

>  SoC-2024-Ideas.md | 129 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 129 insertions(+)
>
> diff --git a/SoC-2024-Ideas.md b/SoC-2024-Ideas.md
> index 3efbcaf..286aea0 100644
> --- a/SoC-2024-Ideas.md
> +++ b/SoC-2024-Ideas.md
> @@ -39,3 +39,132 @@ Languages: C, shell(bash)
>  Possible mentors:
>  * Christian Couder < <christian.couder@gmail.com> >
>
> +### Convert reftable unit tests to use the unit testing framework
> +
> +The "reftable" unit tests in "t0032-reftable-unittest.sh"
> +predate the unit testing framework that was recently
> +introduced into Git. These tests should be converted to use
> +the new framework.
> +
> +See:
> +
> +  - this discussion <https://lore.kernel.org/git/cover.1692297001.git.st=
eadmon@google.com/>
> +
> +Expected Project Size: 175 hours or 350 hours
> +
> +Difficulty: Low

"Difficulty: Low" might not be very accurate from the point of view of
contributors. I think it's always quite difficult to contribute
something significant to Git, and sometimes more than we expected.

> +Languages: C, shell(bash)
> +
> +Possible mentors:
> +* Patrick Steinhardt < <ps@pks.im> >
> +* Karthik Nayak < <karthik.188@gmail.com> >
> +
> +### Implement consistency checks for refs
> +
> +The git-fsck(1) command is used to check various data
> +structures for consistency. Notably missing though are
> +consistency checks for the refdb. While git-fsck(1)
> +implicitly checks some of the properties of the refdb
> +because it uses its refs for a connectivity check, these
> +checks aren't sufficient to properly ensure that all refs
> +are properly consistent.
> +
> +The goal of this project would be to introduce consistency
> +checks that can be implemented by the ref backend. Initially
> +these checks may only apply to the "files" backend. With the
> +ongoing efforts to upstream a new "reftable" backend the
> +effort may be extended.
> +
> +See:
> +
> +  - https://lore.kernel.org/git/6cfee0e4-3285-4f18-91ff-d097da9de737@rd1=
0.de/
> +  - https://lore.kernel.org/git/cover.1706601199.git.ps@pks.im/
> +
> +Expected Project Size: 175 hours or 350 hours
> +
> +Difficulty: Medium
> +
> +Languages: C, shell(bash)
> +
> +Possible mentors:
> +* Patrick Steinhardt < <ps@pks.im> >
> +* Karthik Nayak < <karthik.188@gmail.com> >
> +
> +### Refactor git-bisect(1) to make its state self-contained
> +
> +The git-bisect(1) command is used to find a commit in a
> +range of commits that introduced a specific bug. Starting a
> +bisection run creates a set of state files into the Git
> +repository which record various different parameters like
> +".git/BISECT_START". These files look almost like refs
> +due to their names being all-uppercase. This has led to
> +confusion with the new "reftable" backend because it wasn't
> +quite clear whether those files are in fact refs or not.
> +
> +As it turns out they are not refs and should never be
> +treated like one. Overall, it has been concluded that the
> +way those files are currently stored is not ideal. Instead
> +of having a proliferation of files in the Git directory, it
> +was discussed whether the bisect state should be moved into
> +its own "bisect-state" subdirectory. This would make it more
> +self-contained and thereby avoid future confusion. It is
> +also aligned with the sequencer state used by rebases, which
> +is neatly contained in the "rebase-apply" and "rebase-merge"
> +directories.
> +
> +The goal of this project would be to realize this change.
> +While rearchitecting the layout should be comparatively easy
> +to do, the harder part will be to hash out how to handle
> +backwards compatibility.
> +
> +See:
> +
> +  - https://lore.kernel.org/git/Za-gF_Hp_lXViGWw@tanuki/

From reading the discussion it looks like everyone is Ok with doing
this. I really hope that we are not missing something that might make
us decide early not to do this though.

> +Expected Project Size: 175 hours or 350 hours
> +
> +Difficulty: Medium
> +
> +Languages: C, shell(bash)
> +
> +Possible mentors:
> +* Patrick Steinhardt < <ps@pks.im> >
> +* Karthik Nayak < <karthik.188@gmail.com> >
