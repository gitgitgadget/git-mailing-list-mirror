Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094A350A7C
	for <git@vger.kernel.org>; Mon, 12 Feb 2024 23:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707781169; cv=none; b=nF1qvDTQ7kJJgeH0ibutPuMnGMq7vF2ijmnq5DMav5OCvDVhf/b9EgjP7LsW8wqhusxRS1Klg71wN9uZF5hgXvbKPHS49BaMgSp4PFAyLZ0SGkQG6KwJwRcssnmWY5LlLaHNYkLXvHoWujdv16Qu/wSp3l+OrJFg+T+77ppXCPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707781169; c=relaxed/simple;
	bh=PHblYfh8i4zQs1Aq6BJ8mTqg41Bz6xC25dyOy2zNRhU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KSqT95oGcWe/FzWAFQOe7v3l830Zjc/xmBqoC9SxoGLRHlTiyk1+n6koRMCx3nPgGobOZxA1hF33Sv7ZRRZQ54+d8dwzP5vwrAcg5NKM6VBF2D1jnm7DUv6OFXs+e0M5h+GaRZagdOQG/A0fuJemmRN4d/jNdr9gjgktXtu/3sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lV+inkRh; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lV+inkRh"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a30e445602cso928873966b.0
        for <git@vger.kernel.org>; Mon, 12 Feb 2024 15:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707781166; x=1708385966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hxs5T085DA0Hj1BS5frdO/hLiHjN31odN80ipmAml7U=;
        b=lV+inkRhWiFfggMk56QpMwmeuc+gJ99Vc/r34gT4AB9lUKx8Ta8jVsHHzIl+iaseVm
         c0dTvSjedc5X9Ip3R4E5I2V0EQ5A9JGyt7fctNC9T9q5Yz90sTV8lAtYP2GtcH/lWedR
         jfPsDq4/o4h9Mc2mK8h61a7oOyErmlLF6miLSVBYwVx1keeSkiJ7tMfyNFWwtAMR8OtI
         8DdytlFstw+lnmCMKsE8TIFkzgCupa4xgHKj1Iwpn+U+T7tlKMshuuLGiTEUgrhvGmd6
         xqshNNJseeyz7mI6eZjbVUx8cwf11B3m5z5VfFsxbCYdWZYNAbcfhgs24xHtLhZrFrIN
         8sIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707781166; x=1708385966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hxs5T085DA0Hj1BS5frdO/hLiHjN31odN80ipmAml7U=;
        b=OrgzrM9H0Eq0E0JVvZ+SDM61fWvrvjOQ8QWlZexh2JU+CAKlFw7Dqj/+OQWfxzcJUM
         IBDeHEvFwYhOl1NmJfenEeNqUDZIEozaOxpn78GUF5BQ4qdz9LmF1eZkV2Wn6GAF/OJt
         f5kjTnp+M4fkiL/AJGxYK8L4yGUL+pnjnKn87mxJEHZdEoNP9Urtn0f/1YimpKqrfXXs
         IzDl/pnLivtUcIbCwjlv8IKj+NT/lmj5lz4EVRH6As+zE6WOcP8C0cfT/CN/ljY96MMH
         52lt6LiLVXRUrDvLcD8wrGnQlX6EX5aAcvvjyXjvh3ynxIhhQv4tbtbJhqxhFlGs1HaT
         iMug==
X-Gm-Message-State: AOJu0Yz8kW/umf8iqnN34rAK5drOJCFWS+5EFV4bwS5RRkMLq+AgGDug
	8ZRlOEd9Tl7o/li6kT3/HudQslt21FP5mRWdch5XbeBayHZ+2/PDqgXwKLNkaYa42fscCf8j2ru
	YbfYc/HqFYH286S9xrZ2Nrk2aioY=
X-Google-Smtp-Source: AGHT+IHh+8qejbNuR5TNCdKcc/zyscV3GjRjOv6/wxms8wkc5exyhFe80b8IKw+I/1N7G/dPPs+Ob9IAnjvm/am+8a4=
X-Received: by 2002:a17:906:e256:b0:a3c:8586:c4d8 with SMTP id
 gq22-20020a170906e25600b00a3c8586c4d8mr763494ejb.2.1707781166194; Mon, 12 Feb
 2024 15:39:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
 <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com> <94bf182e3ffbf8ed6e20cd77b2e46e5b83c44d34.1707196348.git.gitgitgadget@gmail.com>
In-Reply-To: <94bf182e3ffbf8ed6e20cd77b2e46e5b83c44d34.1707196348.git.gitgitgadget@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 13 Feb 2024 00:39:12 +0100
Message-ID: <CAP8UFD3pcyRYaJLBmiDdN3sdvRzo==dx-CQKoX1w1n6Hsg5+-g@mail.gmail.com>
Subject: Re: [PATCH v4 22/28] trailer: prepare to delete "parse_trailers_from_command_line_args()"
To: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>, 
	Junio C Hamano <gitster@pobox.com>, Emily Shaffer <nasamuffin@google.com>, 
	Josh Steadmon <steadmon@google.com>, "Randall S. Becker" <rsbecker@nexbridge.com>, 
	Linus Arver <linusa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 6:12=E2=80=AFAM Linus Arver via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Linus Arver <linusa@google.com>
>
> Expose more functions in the trailer.h API, in preparation for deleting
>
>     parse_trailers_from_command_line_args()
>
> from the trailers implementation, because it should not be concerned
> with command line arguments (as they have nothing to do with trailers
> themselves). Indeed, the interpret-trailers builtin is the only caller
> of this function inside Git.
>
> Rename add_arg_item() to trailer_add_arg_item() to expose it as an API
> function. Rename new_trailers_clear() to free_new_trailers() because it
> will be promoted into an API function; the API already has
> free_trailers(), so using the "free_*" naming style will keep it
> consistent. Also rename "conf_info" to "trailer_conf" for readability,
> dropping the low-value "_info" suffix as we did earlier in this series
> for "trailer_info" to "trailer_block".

That's a lot done in a single patch. I think splitting it into 3 or
more patches would be nice for reviewers.
