Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE72605BC
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 17:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707847070; cv=none; b=Mka643cGymsG8hQREevdJhHBIPB8eNM2AbwErniP1yHfSHLPck2ClIkMNpMthRhGjK1A22Dt3bzwd8EzEnfJSricoJy0bT1VUFfc4THJJzBFyjhSd7Lfehksw0RGKJz9iW6IfYaes8VIxIv4WejrF2SVCl6Q0e6uPYlcPSPv0y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707847070; c=relaxed/simple;
	bh=eMgsYfq4t1C06iD9H7dQA5mZLpZY8hxHdL0b0Nni9b4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KSv0gd4ug00qiJjinuyAavwIJ1ZAPWRD4WJymEpeWrO3+clNu+tBDAYZ+NVavTGpbi0QHfArHoxoHlj/sXLmE9W8BjHn8Bld4a/XKDQeJ4vqy0w6rWuY3inp/2FdIXLC9uceeHgGEVYuKR7KaLwweP5rN38XGe5qUGDYZhio5SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4iPPEplp; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4iPPEplp"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60799671960so10853957b3.1
        for <git@vger.kernel.org>; Tue, 13 Feb 2024 09:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707847068; x=1708451868; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eMgsYfq4t1C06iD9H7dQA5mZLpZY8hxHdL0b0Nni9b4=;
        b=4iPPEplpdDNs/9yQPpKUSk8xoLVngf1FWhNVsFvYVKxRa0iw31tF0r5PIguSYzLvD4
         aBd+hnxhFwNAwumBGBhU3iGrqDbfP+fhLcMdrjEdax2OGZYSrVfHt9tgMCTgJgrnXifR
         QbakN4uD5W8QFeODMzivqUCRbof/ljcPDaC5TcMFCF5PDO3AVwwG9Ml2700yum98st1P
         u2ESJEpN+sJAmc7GKJVE+0B63BSz4t9BHxM5gWGbhnn5b6X33UQ39LcvdZsHCmLpNg80
         mPh45v0jktLCH/JnYgzsVwr/MmsWhrVVeIY7kI5zz4qJ8GDNdqU3FwfV5zn3zDLS8JN+
         xUNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707847068; x=1708451868;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eMgsYfq4t1C06iD9H7dQA5mZLpZY8hxHdL0b0Nni9b4=;
        b=Adi3T9ylnRWkUoh5jf9WaAXDBgVAaIVzHonwi2f1TmYzsJhYYsntx8faCJ8mnUNfp/
         WO60Nw51RM4/aiiaFxu+CW9jZj7NTBnH9o3v4f7B4afga3cqC5UvElTyZVQ50BVRzhaQ
         SXq8zOphicFhKeLs9PlreP1gtdxMT4qAail22fzvef+lIL0ceJd7IHbbe0MCWyqL+Ysr
         y/ho3RlfIK/cQbEvBW5ndxoYzC/SoZLvNJmGT1lWJPqvQUxqwbn8MqM8cdwnIPr8hn51
         UCpgKfLLx9nnsEdoXl3cjsdqQof0F1gjTeoNtnr0lWeeStgAtOMD0B7YE4EIFjUDwrO+
         117w==
X-Gm-Message-State: AOJu0YwzaWJd0gkFA1qDTF6C9XN1C4ZEX+kIW1RdsxGPf/TAX6qNOZQ9
	X353s+fkggF1p7uz3l7SabeD3bE01U3/dNgsuziLFiFG38hJMsknRgQljWZbEDAcxlsZyvcPAF0
	3cg==
X-Google-Smtp-Source: AGHT+IFvxvt280gqleaFfgS1j5/5zKcrE2dGhLvoQlyuA3sSOOlyMu/rhgCuqw5KTSBl2BGw/08D18e7kHg=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6902:1007:b0:dc9:5ef8:2b2d with SMTP id
 w7-20020a056902100700b00dc95ef82b2dmr3721ybt.4.1707847067888; Tue, 13 Feb
 2024 09:57:47 -0800 (PST)
Date: Tue, 13 Feb 2024 09:57:46 -0800
In-Reply-To: <CAP8UFD0XjHtwB55XDajJia994TmUwub4L73QxhCQ8yTXc8++Ww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
 <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com> <3bfe4809ecbc5aa0ea52daee7684289398cb88d4.1707196348.git.gitgitgadget@gmail.com>
 <CAP8UFD0XjHtwB55XDajJia994TmUwub4L73QxhCQ8yTXc8++Ww@mail.gmail.com>
Message-ID: <owlya5o4b61x.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v4 23/28] trailer: add new helper functions to API
From: Linus Arver <linusa@google.com>
To: Christian Couder <christian.couder@gmail.com>, 
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>, 
	Junio C Hamano <gitster@pobox.com>, Emily Shaffer <nasamuffin@google.com>, 
	Josh Steadmon <steadmon@google.com>, "Randall S. Becker" <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Christian Couder <christian.couder@gmail.com> writes:

> On Tue, Feb 6, 2024 at 6:12=E2=80=AFAM Linus Arver via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Linus Arver <linusa@google.com>
>>
>> This is a preparatory refactor for deprecating "new_trailer_item" from
>> the API (which will let us deprecate
>> parse_trailers_from_command_line_args()).
>>
>> Expose new helper functions from the API, because we'll be calling them
>> from interpret-trailers.c soon when we move
>> parse_trailers_from_command_line_args() there.
>>
>> Move free_new_trailers() from the builtin to trailer.c because later on
>> we will adjust it to free arg_item structs, which are private to
>> trailer.c.
>
> This patch seems to be also doing too much.

I assume you mean that you'd like for the movement of
free_new_trailers() to be separated into its own patch, separate from
the introduction of new helper functions. I agree.

Will update.
