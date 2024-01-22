Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB0C4CDEF
	for <git@vger.kernel.org>; Mon, 22 Jan 2024 23:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705965743; cv=none; b=Dx97i24MXvgYButijoeFb55z9Ae++mZshbB3tJvFXJSI4XGIX8QiS9acTNa00CvqVFUy1DK2P/8srRVo0Uva5tEqwphNj+jcXAGGwd1ksaxz/0NNvSY7W94ZMZgHh10fGG8iojIsmQSIhExSlIXwrd4oo8dGQGUQeCEp5sEfb/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705965743; c=relaxed/simple;
	bh=scoFoh8tIuHdMGIEIKDM/CSc0UnXNqM5IGOz0lpahpw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EPO5as2YeDxEzoiqhtwdZvEr+1rJ3EE5BdBAHGG5PXcrDFaOfWHLTDqa70VOSlrQiEIoIwDkpzoVWVcHnb85ZmNG6Qiy9R/fWCT2HDgAmkY4IZOXkmC30285612YwyTgsw1PgAnVxtm0f9p9m8fiwxk7efv1l2B4s6TVWgbw1kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zv/vUBIN; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zv/vUBIN"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc26605c273so5595661276.0
        for <git@vger.kernel.org>; Mon, 22 Jan 2024 15:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705965741; x=1706570541; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bl39y9KQE4nFX+mwYxXU2rUxuftXX7rTC8CUbmmcGi8=;
        b=Zv/vUBINSawNc2bGgaCsoNqpOsmCSiaKc7mEqIADHXE6QZT6qUqpRcdVdrJtg7aP0Q
         /G9Qff16xNRtmews/oIB3wZiwDdrwbAbMEIxmRsYsQC72+voZOjayUh2XdrV5cSq/ply
         MAySOv4s5PIRLYkrqmWIMB3NITuMyO2hOYHYb3jphQsMmiGwHIHc3M0NBlRNqfyXpyc9
         eX5xzYeCLJ3wEZvQqJAj3bLFf2ymKZb+zkNyeWNdIPi7/EqGsrfzuQ5d8KjqgNpD6qSc
         bU3RJoen72dbxMkKsKn2I4TysyR3IFKZcV1wbIVCa4UoGsQ1wl0Yd9yrRUB7dSxODQRb
         E13w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705965741; x=1706570541;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bl39y9KQE4nFX+mwYxXU2rUxuftXX7rTC8CUbmmcGi8=;
        b=ZlFeaqzTOJvc0bza3gYG2T+1jvSKbcwc/1Mnq24JU0TSLeyPDkijaBjvM1mrgxhf7W
         z3WNGcffuYrHvMtY1+3VaIEfNCcS7Ym0SEny1zbr4bAIAwITA3LuJSH88TgnRwcS7cUw
         T5zbx58/Yk6AQukQigJMBBr+ceNHkviNcmLRCEpA2VdKxq0rv0ftHMEiw2pDazPEuAgr
         6m9GWhsdOu6/VqbzOFHTPWdtCKxDhWn/9UUwH3URVxxBdyGP6qqjuS0dRyt8tXr7uuxG
         XIgwzJ0pWErjLzgH1EETfHxfReSitIIWpBYm7xuu3DJ+wm9U7X7tuO/M1U4b47xlHNob
         PvNA==
X-Gm-Message-State: AOJu0YxqVj1/iKNm6Gx+murYECGnClsKkOZepxg+4ut7GJTVulSVBBtZ
	gtwWTAjLFKtyi7JVxvFwY6BYNDbeogrm/3offpibsp0cdtdw6tJM42tELScUYzqjCZdctA8S3cf
	ymQ==
X-Google-Smtp-Source: AGHT+IEgovSiinawjo3nU81G3kERjuBlQBCV782ziG7HP7ERy5lUxthpTDahO+N9AOTHs1IyQH4l5228nbc=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a5b:1cc:0:b0:dbe:3e36:17db with SMTP id
 f12-20020a5b01cc000000b00dbe3e3617dbmr2319928ybp.1.1705965741513; Mon, 22 Jan
 2024 15:22:21 -0800 (PST)
Date: Mon, 22 Jan 2024 15:22:19 -0800
In-Reply-To: <fd4a9d54d9522973a4c22e43cb1d7964033d4837.1704869487.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1632.git.1704869487.gitgitgadget@gmail.com> <fd4a9d54d9522973a4c22e43cb1d7964033d4837.1704869487.git.gitgitgadget@gmail.com>
Message-ID: <owlyjzo1vtqs.fsf@fine.c.googlers.com>
Subject: Re: [PATCH 05/10] sequencer: use the trailer iterator
From: Linus Arver <linusa@google.com>
To: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Emily Shaffer <nasamuffin@google.com>, Junio C Hamano <gitster@pobox.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/trailer.h b/trailer.h
> index 50f70556302..d50c9fd79b2 100644
> --- a/trailer.h
> +++ b/trailer.h
> @@ -127,6 +127,19 @@ struct trailer_iterator {
>  	struct strbuf key;
>  	struct strbuf val;
>  
> +	/*
> +	 * Raw line (e.g., "foo: bar baz") before being parsed as a trailer
> +	 * key/val pair. This field can contain non-trailer lines because it's
> +	 * valid for a trailer block to contain such lines (i.e., we only
> +	 * require 25% of the lines in a trailer block to be trailer lines).
> +	 */
> +	struct strbuf raw;

Originally I used a strbuf here for consistency with the other strbufs
used in the iterator for the key and val members. But now I've realized
that there's no need to make "raw" a strbuf at all, because iterator
users will never need to manipulate the string that this points to. Will
change to just "const char *" in the reroll.
