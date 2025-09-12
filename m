Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD32155CB3
	for <git@vger.kernel.org>; Fri, 12 Sep 2025 13:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757684856; cv=none; b=tBpkl9VvWLwoBFnkQQEf9TsJOIv/WujuLFbIZsxRFYG36d4/rLiO774C3hntXLbeqDav6DwUwcJYB8JV+a/1naHYALzvBK386svFX/lerwc3JVhoKC5KOqPi+O4aThlXwfW8siMCBqkbIhGkoiLJ4Q7f2AngWS0Nt5aDRIn5sE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757684856; c=relaxed/simple;
	bh=FtPypTobgKYKVmR2tH9vY+TxXfZ3qNcdaSLDECOawe0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PFzQ5sT+wN7aoUTmKxv9zUu+zltkTfmU/RbiKTANXu0JkKa+ev08XPRr45U9awlVmcwFGH2eDuELHOrM8/JUG652fuBe1o2COIpm4T9YUtGigOHS6EaXotGW+XMKo+ZZuU8cHP99cbC9HGjvhFH7r5EyIXaM/scttQxxTCcAxGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GY6yF8ca; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GY6yF8ca"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6237202020bso3194796a12.3
        for <git@vger.kernel.org>; Fri, 12 Sep 2025 06:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757684853; x=1758289653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fwBmT6AMNfTYDqsIDNO9Wxk2ePZHEm6kxtxP44uLc04=;
        b=GY6yF8ca5b3bN57n7hGKfdfeCIpq1s0GftQCVppxHnsWEOf6cS5WFcZzUy+0LDKMzP
         9W1ATmtNS67w0XdnVPSf/gPA6uIXG0fW6N9evZ45tS/uvLw0KX31AU7KeoExyq6PS8qH
         fm5ZThG9DM8TsfnPbGNGld5jIaVrQr8r96Rgw6U/0QTZzz7xWlaDLgtdD0k1UhjU3KPK
         DmEZz4aFkdvSysxdybzyL5/1E0nuNmq0P4lMTiQydZRhVp0KvrnsUaQcWK+yhCw4UnYy
         oxKs8l64iWN1LkQshdQbyRcKeIC+qaJwB14dR6DkfwlQ01a2hKR3Am/1JdqrnUCWNh1T
         kDmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757684853; x=1758289653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fwBmT6AMNfTYDqsIDNO9Wxk2ePZHEm6kxtxP44uLc04=;
        b=FmS17WWo8rux9iyIXooKWqapEnzA8XldX+f2q1yAyMlScdymmSmFQli4g+hHIfQyh7
         tYyq4FgvP2TgJXODCq9VU/D7dji7Nu7vscAADEYPhNPAnJs2oamHzAtF5/xLwQl/g6Fy
         UG81xSKxKMmsK/EXCJWonoxV+JGK1tFhweGzfjLk8Fg6uo3pg+4F38yUZgXoYNxiAUBy
         EjYtxg+3xaxgveWrliifOUrGJmD649iDNBtalwFmaW9KANV4F5KD+5wCCLAIJta5GCMo
         imYskmXU1ywBUmhQVnHnCtasSNdUBY+newwmvqR2r2KkemHbJzD3huSGXqTK1oo5Iu/n
         caQw==
X-Forwarded-Encrypted: i=1; AJvYcCVpGlDK6vkMvwBO1tSYt8pbjRdYtDkwFmKZ0MVuRVg0jyJ5yXTG/8a0BtyD6qVdhRv0XbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJyJSyLk4QBEGPZ1hGZveTT7HJjW1DpJqVCNY9Sx1pxRH7usdV
	js8BFyMhEu1ppWKlDIKJTs+FN/oPA1BhzB+qjJpXK+4/IGvdD8E3hTG3cvG8nrJTJKrIHykCChi
	FUradA5mFp/aWQTh6mQ+1VwgWwKz3ag0=
X-Gm-Gg: ASbGncuFDsfKngUjJvQvpIItHXk69pY+4GrhEXARqtAnbXSi8HOURUls/0VoUouAy8d
	0aqQ1pFvvZWKG6hY2KUyaC+vY7qtieKnl5ppLNccJYoMHvajkKmAf7V59gNf16k/Unuu3jiolvF
	bj9uxx3JMSMFwjyklL07k50nJVUT1v2fCnkI0pbS9v4dFzTrbKwRnC0yEC/xrm4CB/GdZbOkzUe
	vjD5YZsBw==
X-Google-Smtp-Source: AGHT+IGMTVREXnqlQNSgv4rhT1AFOjn5gAAQ7TArpplL06WQpkoJBqbeISa5KcqKCadfEKO6F1CepJtUpCXzwFvBBjA=
X-Received: by 2002:a05:6402:524c:b0:627:f13f:5e90 with SMTP id
 4fb4d7f45d1cf-62ed82fe0c8mr3149351a12.26.1757684853157; Fri, 12 Sep 2025
 06:47:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910080839.2142651-1-christian.couder@gmail.com>
 <20250910080839.2142651-3-christian.couder@gmail.com> <aMJm8rSOeQsO_qTG@pks.im>
 <xmqq4it9ornz.fsf@gitster.g>
In-Reply-To: <xmqq4it9ornz.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 12 Sep 2025 15:47:21 +0200
X-Gm-Features: AS18NWAR0Ptg3o0sC2kJP9uU0m2iR3uYZhbSqlVOP-LcBlowpiyCzq4t5wjwFkw
Message-ID: <CAP8UFD1ULfGqzQwn1ZhgCdS5Ri_Y3rd-F+=-zsRKtKFg0k4hVQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] fast-import: add '--signed-commits=<mode>' option
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, Elijah Newren <newren@gmail.com>, 
	Jeff King <peff@peff.net>, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 6:55=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Patrick Steinhardt <ps@pks.im> writes:
>
> >> +/* Process signatures (up to 2: one "sha1" and one "sha256") */
> >
> > Hm. Does "up to 2" indicate that the commit may have two signatures at
> > once? If so...
> >
> >> +static void import_signature(struct signature_data *sig_sha1,
> >> +                         struct signature_data *sig_sha256,
> >> +                         const char *v)
> >> +{
> >> +    struct signature_data sig =3D { NULL, NULL, STRBUF_INIT };
> >> +
> >> +    parse_one_signature(&sig, v);
> >> +
> >> +    if (!strcmp(sig.hash_algo, "sha1"))
> >> +            store_signature(sig_sha1, &sig, "SHA-1");
> >> +    else if (!strcmp(sig.hash_algo, "sha256"))
> >> +            store_signature(sig_sha256, &sig, "SHA-256");
> >
> > ... then the code here seems to indicate otherwise as you only parse
> > either the "sha1" signature or the "sha256" signature, but never both.
>
> Correct and not quite.  The caller can call you twice in its loop.
> But if the input was malformed and had two "sha1" (and no "sha256"),
> this will not barf (as the original, so it is not a new bug).

store_signature() should barf if it has already been called with the
same first argument:

static void store_signature(struct signature_data *stored_sig,
                struct signature_data *new_sig,
                const char *hash_type)
{
    if (stored_sig->hash_algo) {
        warning("multiple %s signatures found, "
            "ignoring additional signature",
            hash_type);
        strbuf_release(&new_sig->data);
        free(new_sig->hash_algo);
    } else {
        *stored_sig =3D *new_sig;
    }
}

> In any case, I also found that "up to 2" comment somewhat strange.
> It was more understandable back when it was near the loop, but not
> here.

In V2 I just removed that comment, as I am not sure it really helps.

Thanks.
