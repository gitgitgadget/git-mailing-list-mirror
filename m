Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662F354FA7
	for <git@vger.kernel.org>; Mon, 19 Feb 2024 21:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708378317; cv=none; b=L8zfj2zLWM0zpH1JltW+YcXwR58kHS/OgQkMDEpQT4yPrhgwD0bLM3AVvtOaGERt56EuCfKO9Tn4Lfu/gCdDhfBPDApoTHXOknMq8nVC9Pl2IRs9vnBQTBZEX6VbiYSb8ZwpZI43W6rQic0WInaGYFR2fQVyktPDj0wyAfonFzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708378317; c=relaxed/simple;
	bh=pokKywbQfAXVBkXuiLgS0ggK6m+DIJTobCSUvm1a4lA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l3mmWWTu1phCe8s3FXTQb5bTmWgnkoJ8sUuffpMFXPvSItRRhJrbRGDdi1fXj8/BJ9wAH9wI5m3bpccd9wS84kqcJwjSh/ZXP0vVKYJTaKnEMlkJNa5FEi+SMP590hh4MAI6VdCDKnpKjfcVL+yq6CA9LRjpkO4VSVJfgToyZ7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GqhHXMR1; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GqhHXMR1"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55a8fd60af0so7148615a12.1
        for <git@vger.kernel.org>; Mon, 19 Feb 2024 13:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708378314; x=1708983114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ug5ma6Aw2tLSLFh7ESy/IAaWlIub69eZMBTnvwMHTOU=;
        b=GqhHXMR1m0oCZ6XuikVNHwjcW0qew+NNO1IHXW2bBO0u6maRJHMyRGZdjXvtgYkWp7
         t7Hut58+x6mvMGTjExkRwCJo92XxDFc9FQ3kSWOM0nubN2FFjYlrMS0hHx+Fg6GIZU8c
         jZkWt60+rctPKPMealUcgih1YVBisXAFo8rzd9BCW0EkQvO5FiCJPSgKiEPnoEpLaJQx
         0BWhUkjzoQ3wxEZU1Zb6c6ASoFv6zr3GXuI8Sf+ayFLFWkQhKObtH3SgAK9ZHFSSRSf4
         GB6Fh01eckblUkPQeJt59NitGPpUr5V3ZPS+7noLxdEZmFTYUzdZX9noX+aCtJBcnm6R
         /9GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708378314; x=1708983114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ug5ma6Aw2tLSLFh7ESy/IAaWlIub69eZMBTnvwMHTOU=;
        b=k9n9FDqdbQTIQeGa6uT0U0tyayKZo/5o694ZDE4uoEgKXjhk2R0Qrry+Lqj6vGSSj3
         Y3+BcIFWgjlY6GtfYGPnFtWn6Qbce8qf++LCuDI1REb1Gukuq7uCvx8U6OUTtn1/1P1L
         oxAUbkCXFxkZqxPOKWIRnzmH71gTGb/ZvXCTYf78931e2yj1WuDivkXyUC/8XdKtIgHi
         JRs6LwWUUzloGjVcogtJxLXR5XNlrGpa0YlbhPZz7uEXDJTOp0cGB1epLvQHoZOuPny7
         EM26TbCBV+KA5l+E4GAiegPA6PlnBmSSVS9i7tRCzQkUYTG+B3IO7jnjShSE85F9hcDS
         0YhA==
X-Gm-Message-State: AOJu0YzcIa4JJYP6rgaZooqXV7CRlpTFw7zEckHPV5HNts7ztkq6kMJ7
	6Gb1VgnnyAaPG/N39nYL2rdMP+cUcRKNvnCHVjBuoIbmyu7sWPHaN5yJj35/81ReMNi+MaxjK2g
	37QFDoczuc6Z5SszTROtM5nUNGKA=
X-Google-Smtp-Source: AGHT+IEgfoo6opzX1K/dkj/MOefvJDVfNU/X/pPTw7e5ilFK3OoteBASWD8CYxj5zAx3935nxaBF0SgZ+iIYg9vPvVc=
X-Received: by 2002:a17:906:3b9a:b0:a3e:d75a:a56d with SMTP id
 u26-20020a1709063b9a00b00a3ed75aa56dmr1008149ejf.44.1708378313434; Mon, 19
 Feb 2024 13:31:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
 <pull.1632.v5.git.1708124950.gitgitgadget@gmail.com> <4372af244f02b71cc70f3a8e1b5591b3b9fec93a.1708124951.git.gitgitgadget@gmail.com>
In-Reply-To: <4372af244f02b71cc70f3a8e1b5591b3b9fec93a.1708124951.git.gitgitgadget@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 19 Feb 2024 22:31:41 +0100
Message-ID: <CAP8UFD1dE2EiSxohose6U9SGn+zeHPyVB=KZ2xdQi-v-a8d1XQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/9] trailer: prepare to expose functions as part of API
To: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>, 
	Junio C Hamano <gitster@pobox.com>, Emily Shaffer <nasamuffin@google.com>, 
	Josh Steadmon <steadmon@google.com>, "Randall S. Becker" <rsbecker@nexbridge.com>, 
	Kristoffer Haugsbakk <code@khaugsbakk.name>, Linus Arver <linusa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 17, 2024 at 12:09=E2=80=AFAM Linus Arver via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Linus Arver <linusa@google.com>
>
> In the next patch, we will move "process_trailers" from trailer.c to
> builtin/interpret-trailers.c. That move will necessitate the growth of
> the trailer.h API, forcing us to expose some additional functions in
> trailer.h.

Nit: actually this patch renames process_trailers() to
interpret_trailers() so the function that will be moved will be
interpret_trailers().

Nit: this patch and the next one will become commits, so perhaps:

s/In the next patch/In a following commit/

> Rename relevant functions so that they include the term "trailer" in
> their name, so that clients of the API will be able to easily identify
> them by their "trailer" moniker, just like all the other functions
> already exposed by trailer.h.

Except that "process_trailers()" already contains "trailer" but will
still be renamed by this patch to "interpret_trailers()". So I think
it might be nice to explain a bit why renaming process_trailers() to
interpret_trailers() makes sense too.

Also I think the subject, "trailer: prepare to expose functions as
part of API" could be more explicit about what the patch is actually
doing, like perhaps "trailer: rename functions to use 'trailer'".

In general, when there is a patch called "prepare to do X", then we
might expect a following patch called something like "actually do X".
But there isn't any patch in the series named like "trailer: expose
functions as part of API".

> Take the opportunity to start putting trailer processing options (opts)
> as the first parameter. This will be the pattern going forward in this
> series.

It's interesting to know that this will be the pattern going forward
in the series, but that doesn't quite tell why it's a good idea to do
it.

So I think it might be nice to repeat an explanation similar to the
one you give in "trailer: start preparing for formatting unification"
for format_trailers_from_commit():

"Reorder parameters for format_trailers_from_commit() to prefer

    const struct process_trailer_options *opts

as the first parameter, because these options are intimately tied to
formatting trailers."

And maybe also say that parameters like `FILE *outfile` should be last
because they are some kind of 'out' parameters.

> diff --git a/trailer.c b/trailer.c
> index f74915bd8cd..916175707d8 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -163,12 +163,12 @@ static void print_tok_val(FILE *outfile, const char=
 *tok, const char *val)
>                 fprintf(outfile, "%s%c %s\n", tok, separators[0], val);
>  }
>
> -static void print_all(FILE *outfile, struct list_head *head,
> -                     const struct process_trailer_options *opts)
> +static void format_trailers(const struct process_trailer_options *opts,
> +                           struct list_head *trailers, FILE *outfile)

This also renames `struct list_head *head` to `struct list_head
*trailers`. I think it would be nice if the commit message could talk
a bit about these renames too.
