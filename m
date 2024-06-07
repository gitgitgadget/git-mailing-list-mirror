Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BE81581E3
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 08:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717749105; cv=none; b=eYgcRUo2ogY2BK0ZVCT7n/i8U/pBvAytaFXCsDSHAvUrAiZjiRY093vtBhH7hqbXePeeDNPhPhJOXnzn9aqJDxPR+bjV2knArQ+QysC6hVIR73+d1MBP/7aiZSRmdSQqCZ4DxknL36CDgjgplsWCOVHM9XdlBURm8CYVJa5o8RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717749105; c=relaxed/simple;
	bh=WnXio9gYPHpOS6dOazBCKGjoZ0PlCqjfxrFqVO/hZuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E2/OVRHtn0Bvcp6InCUApY4HucZRaVYS8m9ZWToZvHC9cVj9LxXCb8pTSoIxaplu2rhqGSSPKoGVOKcsVNO+IvNFv9zYUD1kDmecZ//6zlnXnlRPMIz/R9UwQlAASM8Xwb6INIhctBxIDL2hB5rPJ10YE2EAnpZzRE44bfAwHow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A7pBLbx/; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7pBLbx/"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a6267778b3aso207827866b.3
        for <git@vger.kernel.org>; Fri, 07 Jun 2024 01:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717749102; x=1718353902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aoSffvQs9kCXvkXlsp/79ecejL1CJiLR/18oFuqQjZg=;
        b=A7pBLbx/klVw1wS1n3eCf7jvNwXJ6Kw1QA5eL0HKst5pWGo18SSWd2ytViVxgxJGnR
         sUgsbADSB50pqOy2TYNEq/IHc+90RGDkw2+OqnRRiS8xaXAQkR4OV2vlNTTNC1C8/ZVi
         rUN5HRfxsGHBMFuHO86ewrJfb1hTf6vTGi28W2GhY5Chc+gT/sr9fK7cnvJeVuf7YVpF
         joW5iUN/p4fYw7MghJpZWGIaILej0DSSjxL9vT+lWS8EnfhciNZ6Nz47n1v1+aLXjahV
         evlCYYQ3JM/yEc4D62u9IBbOdNIgAwd3Ja9Ye4scsEpcj+Mo+LOg0kJlgx5bFMs09/Th
         MaYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717749102; x=1718353902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aoSffvQs9kCXvkXlsp/79ecejL1CJiLR/18oFuqQjZg=;
        b=F3ALRkIBT9JXte7+3DaP0JKQXyZOsGUAY8/0P1XEa8hMMqo+lJ5SKkRHDWJr9DZ5r5
         9Hrb1ITCJCq/cukrFSDPl8DdZJAfu7VGAsfJmGbARoP5CHVsiMmw/j7Q0ioLFBXD9d0x
         /w9jWT9AaLEpNC7iAaGZHL7cgNmjNzbbicw8wYaK5Hf6mPnqTg4WA6oT6YYO+ZwbPrcJ
         2n9IxlfR8NQIiPqTSOhzvRjxnkwkFy6G+FGUSu4R2xuz8JUpTjvOKJCRhJ8wIFXScBU0
         c66Odmh15DExAY8TekqMQwxaAdR22+LG518paCn3b5jMNgQOKUwTs/Btth+HfPcxzFlR
         XdQA==
X-Forwarded-Encrypted: i=1; AJvYcCUPgkUaXnrPVRDWzfOMdOezGbDtGTBEpypAnXOnPmx0IiCypi9MPd9e2COgP8XtH8rH5xFkU62SU6zk/3YBj35OTIBL
X-Gm-Message-State: AOJu0YzuLHLIJ3Ll60qn87wcrtvai+iyIhNcjmrinl5WhFuIUYl2n5OF
	+5FC8WXOBlyj3RQGPaX4RKnxCTSyU9QofCp70EWSsWkKTOexeLKhc5ZrZXfWcdPFJDMwncP9PJ2
	dMPbMKrXF6MD6rn89aZBOKsIsQjI=
X-Google-Smtp-Source: AGHT+IELarYKckrWck1TFikXy8M4gBGEnjxvRNGzv2bJoTBEWznNmKKuzZEETk6kn71RYa0oSnAb1+N2/0jvWJCNDDo=
X-Received: by 2002:a17:906:55cd:b0:a6a:bcd1:6e85 with SMTP id
 a640c23a62f3a-a6cdb9f3e31mr136506166b.75.1717749101710; Fri, 07 Jun 2024
 01:31:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605134400.37309-1-shyamthakkar001@gmail.com>
 <xmqqo78dka99.fsf@gitster.g> <dohbd64jxuahelut63esztozdozqrhx5rgv5m4t3wt5gz6v6kv@6q2aivlcvxcq>
In-Reply-To: <dohbd64jxuahelut63esztozdozqrhx5rgv5m4t3wt5gz6v6kv@6q2aivlcvxcq>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 7 Jun 2024 10:31:29 +0200
Message-ID: <CAP8UFD0r+YYxAvN2Ej1mGa2Kt5M2dQgQEGLraB3iQ30cPWuA6Q@mail.gmail.com>
Subject: Re: [GSoC][PATCH] t/: migrate helper/test-oidtree.c to unit-tests/t-oidtree.c
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	Christian Couder <chriscool@tuxfamily.org>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 1:35=E2=80=AFAM Ghanshyam Thakkar
<shyamthakkar001@gmail.com> wrote:

> > Come to think of it, how is your check_each_cb() ensuring that it is
> > only called once with "123" when queried with "12300"?  If the
> > callback is made with "123" 100 times with the single query with
> > "12300", would it even notice?  I would imagine that the original
> > would (simply because it dumps each and every callback to a file to
> > be compared with the golden copy).
>
> That's true! I did not think of that. What do you think about something
> like this then? I will clean it up to send in v2.
>
> ---
>
> struct cb_data {
>         int *i;
>         struct strvec *expected_hexes;
> };

It might be better to use a more meaningful name for the struct, like
perhaps 'expected_hex_iter'. Also I think 'i' could be just 'size_t i'
instead of 'int *i', and 'expected_hexes' could be just 'hexes'.

> static enum cb_next check_each_cb(const struct object_id *oid, void *data=
)
> {
>         struct cb_data *cb_data =3D data;

Maybe: `struct expected_hex_iter *hex_iter =3D data;`

>         struct object_id expected;
>
>         if(!check_int(*cb_data->i, <, cb_data->hexes->nr)) {

A space character is missing between 'if' and '('. And by the way you
use 'hexes' instead of 'expected_hexes' here.

>                 test_msg("error: extraneous callback. found oid: %s", oid=
_to_hex(oid));
>                 return CB_BREAK;
>         }
>
>         if (!check_int(get_oid_arbitrary_hex(cb_data->expected_hexes->v[*=
cb_data->i], &expected), =3D=3D, 0))
>                 return CB_BREAK;
>         if (!check(oideq(oid, &expected)))
>                 test_msg("expected: %s\n       got: %s",
>                          hash_to_hex(expected.hash), hash_to_hex(oid->has=
h));
>
>         *cb_data->i +=3D 1;
>         return CB_CONTINUE;
> }
>
> static void check_each(struct oidtree *ot, char *query, ...)
> {
>         struct object_id oid;
>         struct strvec hexes =3D STRVEC_INIT;
>         struct cb_data cb_data;
>         const char *arg;
>         int i =3D 0;
>
>         va_list expected;
>         va_start(expected, query);
>
>         while ((arg =3D va_arg(expected, const char *)))
>                 strvec_push(&hexes, arg);
>
>         cb_data.i =3D &i;
>         cb_data.expected_hexes =3D &hexes;

Can't we just have something like:

        struct expected_hex_iter hex_iter =3D { .i =3D 0, .hexes =3D &hexes=
 };

above when 'hex_iter' is declared?

>         if (!check_int(get_oid_arbitrary_hex(query, &oid), =3D=3D, 0))
>                 return;
>         oidtree_each(ot, &oid, strlen(query), check_each_cb, &cb_data);
>
>         if (!check_int(*cb_data.i, =3D=3D, cb_data.expected_hexes->nr))
>                 test_msg("error: could not find some oids");
> }

Thanks.
