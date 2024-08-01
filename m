Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C175518452B
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 10:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722509870; cv=none; b=CoFUK4U+/HOIqArVLQgfJvyW4V9uvasjrf1Fb0645/musbOxQCk7mQS7gYjQESV872Wy1xNEbah/J/GX5k/0HFe8HnUQQ/AIrEZTct5Ma0iInA2cz43TBBjogE+6BXgLhCyUfp7ZOFX1XO7HwOLsvuaKXxxhPBb3dwu+FO7RKRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722509870; c=relaxed/simple;
	bh=SzY62Bd01Wt156bxdTplLKqMSVXfB2qoo4AhDeWg0Iw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=swOeuiAJ8DKE8IBOQTVXRI/ssoZLGe6EQukhVBA/+M68gSydElDrO+hZT7XpxtyQbOob1qwvGQot/xegji3+8seaG3ArvlAzhucht6/ALwr4P6X1bKiOEBzkH8Vig+6JZDUrcs7yi32w/XeRjfMTY9On9MiNhk3nTpDfXqwWB9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S3sfmCio; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3sfmCio"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-367963ea053so4335331f8f.2
        for <git@vger.kernel.org>; Thu, 01 Aug 2024 03:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722509867; x=1723114667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TGHtRiql8bEk5ouKfSNbWGydlfpREoH4WmFXTM0qLVA=;
        b=S3sfmCio8yp2tk31ghXk/5GFfu6jO4EeDvAcu8zyohx9oMStntHxUkFOl6t8Bxhm/T
         PvRH6RTjym5D+pfO5FPYDY8CSdNubZ0LYs9PxVrfq/HQGKloR1p+ntUrUPJhDt7PWoa1
         cp+4dna4jLBZ4TjgC6v4D6J7vmoMZALlD79sun2DVp5l71k66+vvd8RLBPjaOw1rpQFA
         2fhqJfWyr4MXWuMB7uEAVFquZvrplyRBnPiCOUXv7/NayPhPJFSZAD1SWY+nmKyltnmW
         5uwxaRvGbfjVAzxUoDRVgI/DG/pDBS5SIw1fBjo3ryEntv3vQPwtIsEOMYHm90zhRwg6
         5G8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722509867; x=1723114667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TGHtRiql8bEk5ouKfSNbWGydlfpREoH4WmFXTM0qLVA=;
        b=iH+m5atmwQN7EfyCaOyWHyz0IaiabB8R9HnEMCQos4nKtjhwHuTjSYiqLtZFELTbmq
         GNa/4GrRIgW16WTz4q33NV5IcF2zKRMQDmlktOh0hl0yXydiMPYRoZmUTq2DESllA2SI
         +y+jAef6487ngc5QF7Jy89RKKasiA7tB6msy1a4vTmIasx9ub9mnea64lsksJEVf07Rw
         Sutm+KuQmuXyWIEaTponc1XkCIVVZrTpZlw74KDvcUPE5/VFxbt1RKRpJIowZiHmsC+F
         N1z+kWnN7ry7WwLhYp0INid6f2SMVu5VcJm5ts1Dvbd02rH6AM2zDH66umlp413vjO12
         9sAg==
X-Forwarded-Encrypted: i=1; AJvYcCVBq3I2cckxCrna7SAKqUBlBbhY8m0tTE5sMKao5bHNnMeKgnJDEORW9XWPtYaMP5b8nM6NNBFoPJKVg6E4FybgGUyq
X-Gm-Message-State: AOJu0Yx2IGfSXNGdFc3ERmqjqHpBZGMXzX88FStNx2RIw9kQazsT4D1i
	kxNkCqKMlzFcLrVyUXIo4wcLX7u/ff5Gur9yYsveMRtIGOavUOOrG7Kf2S+nvKDqj8cDK6azyt2
	7dzVBnAX3nrVZbyE8AWnPVayWaEJUyf30
X-Google-Smtp-Source: AGHT+IFJ7TpUWBsdN2ex9EBwZKLIzvq1CLSYJoNkRpZQOAFUvycVVXOtgzYOBF7YOMYjlzd/M6J/yhc5gxQTiRWfzr0=
X-Received: by 2002:a5d:4649:0:b0:366:f50a:2061 with SMTP id
 ffacd0b85a97d-36baaf769ccmr2211915f8f.50.1722509866645; Thu, 01 Aug 2024
 03:57:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEcKSiyo3dyNpGkE_FWE-Y710RV0H3EytM2psC=+by=4wP5qpg@mail.gmail.com>
 <20240731074228.GC595974@coredump.intra.peff.net> <9AA59434-916C-4978-B3A1-33FD70619BFC@boanderson.me>
 <20240801082556.GA640360@coredump.intra.peff.net>
In-Reply-To: <20240801082556.GA640360@coredump.intra.peff.net>
From: Hong Jiang <ilford@gmail.com>
Date: Thu, 1 Aug 2024 18:57:31 +0800
Message-ID: <CAEcKSiyf7JPypM93XLFJLjC1T-k9h6kushM7GqTyCBe8rico=g@mail.gmail.com>
Subject: Re: [PATCH] credential/osxkeychain: respect NUL terminator in username
To: Jeff King <peff@peff.net>
Cc: Bo Anderson <mail@boanderson.me>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I confirm the patch works on my system.

On Thu, Aug 1, 2024 at 4:25=E2=80=AFPM Jeff King <peff@peff.net> wrote:
>
> On Wed, Jul 31, 2024 at 02:07:32PM +0100, Bo Anderson wrote:
>
> > This is correct.
> >
> > The reason I couldn=E2=80=99t reproduce the problem and how few will ha=
ve noticed up to
> > now is that for most users the CFStringGetCStringPtr call, which correc=
tly uses
> > strlen, does what is necessary and we return early. I don't entirely kn=
ow the
> > precise criteria where the fallback is used but I imagine it depends on=
 certain
> > system encodings/locales.
> >
> > The patch changing this to strlen looks good to me to apply to master &=
 maint.
>
> Thanks. Here it is with a commit message. Hopefully Hong Jiang can
> confirm that this fixes the problem, and we can added a "Tested-by"
> trailer.
>
> -- >8 --
> Subject: [PATCH] credential/osxkeychain: respect NUL terminator in userna=
me
>
> This patch fixes a case where git-credential-osxkeychain might output
> uninitialized bytes to stdout.
>
> We need to get the username string from a system API using
> CFStringGetCString(). To do that, we get the max size for the string
> from CFStringGetMaximumSizeForEncoding(), allocate a buffer based on
> that, and then read into it. But then we print the entire buffer to
> stdout, including the trailing NUL and any extra bytes which were not
> needed. Instead, we should stop at the NUL.
>
> This code comes from 9abe31f5f1 (osxkeychain: replace deprecated
> SecKeychain API, 2024-02-17). The bug was probably overlooked back then
> because this code is only used as a fallback when we can't get the
> string via CFStringGetCStringPtr(). According to Apple's documentation:
>
>   Whether or not this function returns a valid pointer or NULL depends
>   on many factors, all of which depend on how the string was created and
>   its properties.
>
> So it's not clear how we could make a test for this, and we'll have to
> rely on manually testing on a system that triggered the bug in the first
> place.
>
> Reported-by: Hong Jiang <ilford@gmail.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This is not even compile tested by me! It looks like an obvious enough
> fix, and I wanted to make sure we don't forget about it. But anybody who
> can reproduce or test would be greatly appreciated.
>
>  contrib/credential/osxkeychain/git-credential-osxkeychain.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/credential/osxkeychain/git-credential-osxkeychain.c =
b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
> index 6ce22a28ed..1c8310d7fe 100644
> --- a/contrib/credential/osxkeychain/git-credential-osxkeychain.c
> +++ b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
> @@ -141,7 +141,7 @@ static void find_username_in_item(CFDictionaryRef ite=
m)
>                                 username_buf,
>                                 buffer_len,
>                                 ENCODING)) {
> -               write_item("username", username_buf, buffer_len - 1);
> +               write_item("username", username_buf, strlen(username_buf)=
);
>         }
>         free(username_buf);
>  }
> --
> 2.46.0.452.g3bd18f5164
>
