Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF48267F58
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 06:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761029197; cv=none; b=ph8hCBY1JQQURrxnQ+IOycy6vK20qEv/1XoHcykJ+lmaO5W14IwQvCBFwCybx89hw1ptgqH3jSZ408enfTi5BqxF+BEywSyXddd9438c3OSXCZAlFY2wX4neQ3cHGofQmdbe/XRMSQTFgoLtguJVEp6SI2ADxO7bd+KjfWsUuFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761029197; c=relaxed/simple;
	bh=5H8BV4ZG8XEqgxCsgxjqMCcRjQNCqSn7BmRbxPv9tPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hSMhd1EHe3ppIOvVO4rbAtt/0JdpidPze/iOsMeVaZAeWtZqW0rNh4VFYo36xJhXf3pu0XCCKzm8McO+l6JzFRpdmpjSzg89FSaoTHFh9yAKVH76j68nN3+2clsko44WzpZWXhSc1wmyqYl3FFUcUHjvMMQMcxQ/l5bGD4rpxyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EBQnIEvt; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBQnIEvt"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-63bea08a326so7152885a12.3
        for <git@vger.kernel.org>; Mon, 20 Oct 2025 23:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761029194; x=1761633994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ab20ENoxBqdWkHx/NJDggTBAwC2EPeak/uMs3RCyYfc=;
        b=EBQnIEvtSJ4pURC4egkTUVUdZSt1scjOHwzjQQCowSuWMO4A630thZ0MCsTg7M7Oym
         e/m+OzMEETSWAj/Pq+m1mvbP6j3Je71Eh6v4ia9t4G7LdOt5SPPcyD3KIEiUkJUI1lDi
         oRZIIL5vUxytrn8jyt5poZJiPGcYQrpa2Gb7NB8yZEhVgCTBnAJFxFJpJvxRzjdr8gbc
         eWC2oyN7HKa5YFGkqNF/fBh+15fMmS+S37wtmz0SRIGEQMh+INXAbBb+S1m4YJ9xIjoN
         MeYMWAujhYeDl/O17QruGlW6PM7a7NKbElu/t2fAt8w0/xQDs8fNR5ZiiJdBTDmauSXl
         b10A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761029194; x=1761633994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ab20ENoxBqdWkHx/NJDggTBAwC2EPeak/uMs3RCyYfc=;
        b=fUDCqaJXtOjAGGfJ7z5cKfzsTZ8btRxYUJMge5yd9z/KuPwaviDQagnoWMb+4/bgLs
         wf0rAaP9amMyzx+qgU1cH5011tS4rUenUz7OI43CsqmJiOWWGl0NqBr/rCtJ4l3rIbbI
         oVUDaCfZSOOWDGGNTz3MCK4JTTQSYLfpQj0/AwIVc+lXnICMP6Y62axnSKyOKKQ62h9i
         mgJtLBmCLYzY0FHLi7pjbhpu/jYvm7KxiNUwX2QgIxWp5q56LQrODh9gCRL1xLzuV4cT
         al1+KaDrwN+3VIYfS3FUuPIjSWsU3qlRHZXqhwIQ2s0nU0ytJuNn4zjhq8Xz/vHB8NhA
         HdSQ==
X-Gm-Message-State: AOJu0Yza+iFM3IKDxACWI6oHJNHhTrBSkRgFDYLbuDXkkDHyr4nsvjSP
	Lwth3LsDSeOKoU18OqH2O5HhzzbIjjqEOCJoA2fYa/u47EIPx5lJiWFxSn6nF/Ti0fdVygYCmoC
	TJEMKcjpoQdvWrH8DJcA18hu8TvQrMQQXs1VG
X-Gm-Gg: ASbGncudECQ57OsYGmjl9ZY7Fnjcc5THXXwUTWD0RYJ0/hZE0wFuQfBBWCjXf1q4+B4
	P+MIpl99hHdBdWkTo+a4uQzC7N0xSMXtPJN2+TLGwI6MdewhsaUa+fqFLMZYRZ+YBWo47mv0EYH
	Ba3grA3u62GwJpozg4P0eea7Dm5ba6P/muFOSOrxStFYEBZoT76Lzv9WhQspMzxNseJUSWveeJJ
	oSOVsa2Y/nAA73QL3YPSypvuAaCDiZap0SHlexiVJb5Yd8ZXgN4R+8ePmYysmEQnHiGnwE=
X-Google-Smtp-Source: AGHT+IF3aD+bJpeVLDn95wii3CCX3f833PGxoQQGPGxiZJJWPxqZ3nhBN/TV3nXGUgq70ZPxawvm7dzBbJJE8/jemCw=
X-Received: by 2002:a05:6402:2356:b0:63a:294:b018 with SMTP id
 4fb4d7f45d1cf-63c1f650138mr15130791a12.14.1761029193917; Mon, 20 Oct 2025
 23:46:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1760997183.git.belkid98@gmail.com> <2879d9be3659a9c1ea554fff7814507caae24b65.1760997183.git.belkid98@gmail.com>
In-Reply-To: <2879d9be3659a9c1ea554fff7814507caae24b65.1760997183.git.belkid98@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 21 Oct 2025 08:46:22 +0200
X-Gm-Features: AS18NWC6dNq2eX3ljqkayivPBddb1YAsXP_JJE7OhZ5ugfSnP78k9vJNRoPCxVM
Message-ID: <CAP8UFD1J_B9W62bv=0yccQNGahkv2vco3arQOs0oe0DccdTeYg@mail.gmail.com>
Subject: Re: [Outreachy PATCH v4 1/2] gpg-interface: do not use misdesigned strbuf_split*()
To: Olamide Caleb Bello <belkid98@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, usmanakinyemi202@gmail.com, 
	kristofferhaugsbakk@fastmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 12:56=E2=80=AFAM Olamide Caleb Bello <belkid98@gmai=
l.com> wrote:
>
> In get_ssh_finger_print(), the output of the `ssh-keygen` command is
> put into `fingerprint_stdout` strbuf.

Nit: I think this sentence doesn't need to be in its own paragraph. It
could be at the start of the paragraph below.

> The string in fingerprint_stdout is then split into up to 3 strbufs using

Nit: above the variable `fingerprint_stdout` was quoted, but now it's
not quoted anymore. I think it would be more consistent to quote it
here too.

> strbuf_split_max(), however they are not modified after the split thereby
> not making use of the strbuf API as the fingerprint token is merely
> returned as a char * and not a strbuf, hence they do not need to be
> strbufs.

Nit: this sentence is a bit long. Maybe "however they ..." and "hence
they ..." could start new sentences instead.

> Simplify the process of retrieving and returning the desired token by
> using strchr() to isolate the token and xmemdupz() to return a copy of th=
e
> token.
> This removes the roundabout way of splitting the string into strbufs, jus=
t
> to return the token.

Nit: this last sentence should either be in its own paragraph, in
which case there should be a blank line before it, or it should be
part of the previous paragraph.

> Reported-by: Junio Hamano <gitster@pobox.com>
> Helped-by: Christian Couder <christian.couder@gmail.com>
> Helped-by: Junio Hamano <gitster@pobox.com>

Nit: Junio reviews all the patches and adds his own "Signed-off-by:"
to the patch that are accepted, so there is no need to also mention
him in an "Helped-by:" trailer like this.

> Helped-by: Krisoffer Haughsbakk

I think you mean "Kristoffer Haugsbakk". Please spell his name
correctly and provide his email address like for everyone else.

[...]

> @@ -845,13 +844,17 @@ static char *get_ssh_key_fingerprint(const char *si=
gning_key)
>                 die_errno(_("failed to get the ssh fingerprint for key '%=
s'"),
>                           signing_key);
>
> -       fingerprint =3D strbuf_split_max(&fingerprint_stdout, ' ', 3);
> -       if (!fingerprint[1])
> -               die_errno(_("failed to get the ssh fingerprint for key '%=
s'"),
> +       begin =3D fingerprint_stdout.buf;

`begin` is set here, but not used below...

> +       delim =3D strchr(fingerprint_stdout.buf, ' ');
> +       if (!delim)
> +               die_errno(_("failed to get the ssh fingerprint for key %s=
"),
>                           signing_key);

(This might be an issue that already existed, but I wonder if using
die_errno() instead of just die() is the right thing to do here.
Shouldn't we check errno before splitting?)

> -       fingerprint_ret =3D strbuf_detach(fingerprint[1], NULL);
> -       strbuf_list_free(fingerprint);
> +       begin =3D delim + 1;

... before here, where `begin` is set to something else. This means it
was useless to set it to `fingerprint_stdout.buf` before.

> +       delim =3D strchr(begin, ' ');
> +       if (!delim)
> +           die_errno(_("failed to get the ssh fingerprint for key %s"),
> +                         signing_key);
> +       fingerprint_ret =3D xmemdupz(begin, delim - begin);
>         strbuf_release(&fingerprint_stdout);
>         return fingerprint_ret;

I think this could be `return xmemdupz(begin, delim - begin);`, so we
could get rid of `fingerprint_ret`.

Thanks.
