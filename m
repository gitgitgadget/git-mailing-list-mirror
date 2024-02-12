Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9167D51C45
	for <git@vger.kernel.org>; Mon, 12 Feb 2024 23:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707781059; cv=none; b=d4kV+cUA3a8vLqW59FF2WyA6dloExt9TCvRrlp6MSnG2XCTRgV19xX5tZJfakYx7bSPVJ62xM2B2zgWp/fsZxz1a0aEgz/2y4sIAdT9LV1pBjV+3XhL+ueGvO+iJjk6STeK0/jHVkXBUZeh9jlN9pFiRSQuavV5CKxMHJ/9Ui8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707781059; c=relaxed/simple;
	bh=E70B2KEzKb75/FAeTXY+qpv9XE7azhKI1P2pnYC9LZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bDo0lxgcfclz6hNTDA6wmNf6Y4dizzstuXDKoW/k6vHlmPi0FRSv7FXHmoZGVDHEc0eN/aXuef++XY6W42byayDj5e8oNnvO3ijNDBdX8ffZZnUIEiA4MZFxbllB3ibNGgHHiruFzpi37HyPhsVn1N1yNuZCYI03wHYqA5wU9C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iV8Nru6d; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iV8Nru6d"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a389ea940f1so407533066b.3
        for <git@vger.kernel.org>; Mon, 12 Feb 2024 15:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707781056; x=1708385856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5jhic3RsokoiBbptgT/AYpq9AH2uPkanuVR3s68YD7M=;
        b=iV8Nru6dnMIMuiVCaX6eOYmtmBBPcw6r5xl1EdV228ulGPGZtgB2E7TxR66Qek4z5i
         N7rose3GOwNIn2z1HPriC9fyg4HQGZtxUfZXIjJ+oWcrwVwlNNWZSBLh9H55gvM77tH3
         O1AP/XwLIeJAF/1PYZjFBvlAgprU+hSTfn9GqC0tk9wAXGyTcLQ4dflORaaYrt/+J6Kz
         7RdzLj25plY6cg+bSCxiJw4+BHAV0l1UMVSyKtxZMws781MCFZmj3qdtevk842Yz0VEm
         evN+s+evaE1l2Ojwe+C078uZsR0Rask6Uy+TYjGFDt48MkYCkIGRuOjfohcDpEmxCvT4
         4K1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707781056; x=1708385856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5jhic3RsokoiBbptgT/AYpq9AH2uPkanuVR3s68YD7M=;
        b=WlPENiBdW3R2KkW0pLV419CcPa8SUMUiz4BGDzTB/wqnh4OAK3L6VqNq8OLD8xaUz2
         vDSRXbysAzwluplRw424/sXjxaQR/IetGSiYtHPLy3vRr6FqXuha7KlOBguZ3313d3RB
         ovOUaX3tQxV8HADThijulbpOv0OEAyvbeYwZ1SId29AVX3SaxKlRcaadUHE+Pm4wRd4Q
         hUgw50RtX+5wKPfpZejhHcCUuN1YM0QoshBx6Da07iS1W+id2AjBPwXaGpGQgclimvlI
         AuzVTWe1lpAmQs5sIyVoG4aUeC6FjuiK2kBRg/r6IPPagWIMt54TWLweLXWN3J0D8I4f
         SIMg==
X-Gm-Message-State: AOJu0Yy+uTuan1IJUgdKm4BNpiBO0khKMDqJy5JKNA6G4s7EhZa4fyf0
	QqqlKYoxpjUuq8iaZ4HhSQRmbSbvt7b4A4iaeWFBhlLxMiv4tYSa3E7L1urxPvPX2z+kTw5xXe4
	hRjOOofS6C7zuRkxCtnQHiprLOCQjz9Yialc=
X-Google-Smtp-Source: AGHT+IG/LCJskZUap6OnHlwUxqH6C8JyZvKlo8N5XVEEXhKa/tHrTPMVyDKzeOBEKTmb9gZaRNQHkqD5hy+I+WJDltQ=
X-Received: by 2002:a17:906:a8d:b0:a3b:ad01:f66e with SMTP id
 y13-20020a1709060a8d00b00a3bad01f66emr6214888ejf.25.1707781055217; Mon, 12
 Feb 2024 15:37:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com> <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 13 Feb 2024 00:37:23 +0100
Message-ID: <CAP8UFD3qLGua5PTA+i29N+yJH8iKVBPwUn=S606B2E+s959JFQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/28] Enrich Trailer API
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
> This patch series is the first 10 patches of a larger cleanup/bugfix seri=
es
> (henceforth "larger series") I've been working on.

There are now 28 patches in this series.

I took a look at all of them, and I think that this series should be
split into 4 or more series.

For example perhaps one series until the "trailer: move
interpret_trailers() to interpret-trailers.c" patch, then another one
until "trailer: finish formatting unification". etc.

Also I think it might be possible to avoid some test failures
introduced by some patches. If it's not possible, I agree with Junio
that it would be nice if the failing tests were changed to use
'test_expect_failure'.

Also it seems to me that many patches towards the end of this series
should be split.

> The main goal of this
> series is to begin the process of "libifying" the trailer API. By "API" I
> mean the interface exposed in trailer.h. The larger series brings a numbe=
r
> of additional cleanups (exposing and fixing some bugs along the way), and
> builds on top of this series.

[...]

> With the libification-focused goals out of the way, let's turn to this pa=
tch
> series in more detail.

I like the goal of libifying Git the trailer API, and the way you want
to do it seems reasonable to me.

[...]

> In summary this series breaks up "process_trailers()" into smaller pieces=
,
> exposing many of the parts relevant to trailer-related processing in
> trailer.h. This will force us to eventually introduce unit tests for thes=
e
> API functions, but that is a good thing for API stability.

I am a bit sad that this series doesn't introduce unit tests using the
new test framework in C yet. I understand that this series is mostly a
big refactoring and maybe it's better to introduce unit tests only
when the refactoring is finished though. Anyway I hope the next series
will introduce such tests.

> In the future after libification is "complete", users external to Git wil=
l
> be able to use the same trailer processing API used by the
> interpret-trailers builtin. For example, a web server may want to parse
> trailers the same way that Git would parse them, without having to call
> interpret-trailers as a subprocess. This use case was the original
> motivation behind my work in this area.

Thanks for telling us about this use case.

> Thanks to the aggressive refactoring in this series, I've been able to
> identify and fix several bugs in our existing implementation. Those fixes
> build on top of this series but were not included here, in order to keep
> this series small. Below is a "shortlog" of those fixes I have locally:
>
>  * "trailer: trailer replacement should not change its position" (If we
>    found a trailer we'd like to replace, preserve its position relative t=
o
>    the other trailers found in the trailer block, instead of always movin=
g
>    it to the beginning or end of the entire trailer block.)

I believe there was a reason why it was done this way. I don't
remember what it was though.

>  * "interpret-trailers: preserve trailers coming from the input" (Sometim=
es,
>    the parsed trailers from the input will be formatted differently
>    depending on whether we provide --only-trailers or not. Make the trail=
ers
>    that were not modified and which are coming directly from the input ge=
t
>    formatted the same way, regardless of this flag.)

It could be a feature to be able to normalize trailers in a certain way.

>  * "interpret-trailers: do not modify the input if NOP" (Refrain from
>    subtracting or adding a newline around the patch divider "---" if we a=
re
>    not adding new trailers.)

It could be a feature to be able to normalize this too.

>  * "trailer formatter: split up format_trailer() monolith" (Fix a bug in
>    git-log where we still printed a blank newline even if we didn't want =
to
>    format anything.)

I am not sure this is a bug fix either. It could perhaps be a normalization=
 too.

>  * "interpret-trailers: fail if given unrecognized arguments" (E.g., for
>    "--where", only accept recognized WHERE_* enum values. If we get
>    something unrecognized, fail with an error instead of silently doing
>    nothing. Ditto for "--if-exists" and "--if-missing".)

It's possible that there was a reason why it was done this way.

I think you might want to take a look at the discussions on the
mailing list when "interpret-trailers" was developed. There were a lot
of discussions over a long time, and there were a lot of requests and
suggestions about what it should do.
