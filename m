Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0568970816
	for <git@vger.kernel.org>; Fri, 25 Oct 2024 16:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729872416; cv=none; b=ipZbpiwHTATUDOnwzqoguxzrAerR391gTaBOPTOWAhpZX7IxGYAiOHlHZLJaAtl7qbm1bU9UA4F8QWZx2QTJ3HqhDgELF7AMbzOT2f16/yQbQw5Jxt/acHolRCWouDpEIYeH5rOBCTYLdjOhE5RgSdGIdKUZhI4JzMdqFj9zbBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729872416; c=relaxed/simple;
	bh=yhfokTeW8B5UBi5JIrlzRzrXsFuKJewnOFk4GQXCBRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fWepTTIX138UZ1WdvZWwXlaZllNT/Dr1juNlYyypvdkDxnP0IzsojbXfWd7WmOLeFdoE7dRDEWbrYtpgNfR7Ynwqxcy2oo6JcVI39GRx2OmamJ4JaMK7Dp3llySmXtgrENe6CgCvtE8hpE0gqHqGApD1M99K+oQI4GfP2km/Lp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hC+MhFv/; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hC+MhFv/"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e2918664a3fso2053775276.0
        for <git@vger.kernel.org>; Fri, 25 Oct 2024 09:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729872414; x=1730477214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W2AI8uAQC5c7ntsHiIRC3MRs85xm7eYjnx6gOdDOs1A=;
        b=hC+MhFv/8YeUCDVIkqKkcY+/KaaSMH9CpU2OGwoTEZ27DUwuqgUa69WPR3aYRcQU20
         twiyPBruq93GY4prW5Rt2PiRtUzSuQZ6gokbugmgKDCc0nQ+MbWlpnCx+fVYbHkLrkZK
         lG7GG1H/eGkbQun81QHjbsBhBxlADV0FTuNAKrmCBfDqDsV0y29qeoRG9Q8dX/6AOORj
         AmavECzYkkqUQ2GlzNeYO3rrpBgL8Fc24pUJN8uOYdsvNzGaidWcdotRVDaJiK6Xc6/1
         OWUE3j0JERqauigESb/Y8GqfKzuoFdCdQyA7sBh8HP+RZKIMLNEMxt0Ixc+r2Gl3sFoA
         etAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729872414; x=1730477214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W2AI8uAQC5c7ntsHiIRC3MRs85xm7eYjnx6gOdDOs1A=;
        b=i4BN1A2rdPfHr4qXo3HJKQ9ifH6mx+TxQY0OeJT9GbYOkW/8W1CN5dOLxbZrWyz3DM
         fsFxc1LvNiv3uz/Tn8LfAqo5pbLBdsxfFR8u6NG09w0Ose5Zeq8+lPoKObs4vGtijwWM
         2BMgDoHdFQ8xm+krDsL3joknzz57/PFLLG/mRZHehofZxHdZxZUGzJp6GAXIathpB3Sd
         erZDIcLbvPgpfetCdthRHKimBO/dqXoaNl2xT6dXq0XWvEqk3PNHR/xoov2iLDSJS/nc
         0YmhG2BpFkKJdWl9HpsGCpa4vRYZlEASAAKUobRYGL35VPl41U47GRvU3ZwARL1/6rdg
         Rt7Q==
X-Gm-Message-State: AOJu0YwHSkjLv79frRSfRSWO4tGSjs8q3XCphyqap9onyq7XxkpZgXpP
	YjdeuNyihLUHOoL2DxCjM73syf4qQfte18troCRTXP0i0kYXtxqfNWQ6gCEfFZiWxF+FeVlr7ty
	sgfFC9wly3gLUv0WngUCJqWIALfk=
X-Google-Smtp-Source: AGHT+IH7m+iC4oh0lkdzPI6xd/iJ4okSbst7ImpH/Fbr/qakk4u0IpPfU6a7aLb0jPlMGeHEWid1pojvJruu5m+XrLI=
X-Received: by 2002:a05:6902:1587:b0:e20:2232:aaa4 with SMTP id
 3f1490d57ef6-e30872d09demr55423276.19.1729872413875; Fri, 25 Oct 2024
 09:06:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20241024205359.16376-1-eric.peijian@gmail.com> <20241024205359.16376-2-eric.peijian@gmail.com>
 <CAOLa=ZSb6p_z8jJHSWCfqD6bdTNNXQw-Dq6DsQWt+o+cyQ3x9Q@mail.gmail.com>
In-Reply-To: <CAOLa=ZSb6p_z8jJHSWCfqD6bdTNNXQw-Dq6DsQWt+o+cyQ3x9Q@mail.gmail.com>
From: Peijian Ju <eric.peijian@gmail.com>
Date: Fri, 25 Oct 2024 12:06:42 -0400
Message-ID: <CAN2LT1CEPdTAxCEpKtd+8-5zKYSnh0PMqEXgAZ++TTMPPKrD1g@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] fetch-pack: refactor packet writing
To: karthik nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, calvinwan@google.com, jonathantanmy@google.com, 
	chriscool@tuxfamily.org, toon@iotcl.com, jltobler@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 5:52=E2=80=AFAM karthik nayak <karthik.188@gmail.co=
m> wrote:
>
> Eric Ju <eric.peijian@gmail.com> writes:
>
> [snip]
>
> > +
> > +void send_object_info_request(int fd_out, struct object_info_args *arg=
s)
> > +{
> > +     struct strbuf req_buf =3D STRBUF_INIT;
> > +
> > +     write_command_and_capabilities(&req_buf, "object-info", args->ser=
ver_options);
> > +
> > +     if (unsorted_string_list_has_string(args->object_info_options, "s=
ize"))
> > +             packet_buf_write(&req_buf, "size");
> > +
> > +     if (args->oids) {
> > +             for (size_t i =3D 0; i < args->oids->nr; i++)
> > +                     packet_buf_write(&req_buf, "oid %s", oid_to_hex(&=
args->oids->oid[i]));
> > +     }
> > +
> > +     packet_buf_flush(&req_buf);
> > +     if (write_in_full(fd_out, req_buf.buf, req_buf.len) < 0)
> > +             die_errno(_("unable to write request to remote"));
> > +
> > +     strbuf_release(&req_buf);
> > +}
> > +
>
> Was this function meant to be added here? I mean, there is no reference
> to it in the commit message or anywhere else.
>

Thank you.

The `send_object_info_request` function is used in `transport.c`
`fetch_object_info()` in patch 4/6. Its functionality is similar to
`send_fetch_request()`:  sending the object-info command along with
sub-command (e.g. size) and arguments (e.g. oids) to the remote.

I guess Clavin put it here because
1. it has similar functionality as `send_fetch_request()`
2. `write_command_and_capabilities()` is only visible within `fecth-pack.c`=
.

However, I believe your comment is valid. Adding everything to
`fetch-pack.c` makes the file overly bloated with functionality
unrelated to fetch-pack. For v5, I plan to address this by:

I will:
1. move `write_command_and_capabilities()` a level up to connect.c
2. add a new file f`ecth-object-info.c` at the same level of
`fetch-pack.c`. This new file contains the logic related to
object-info command, i.e. `send_object_info_request()` and
`fetch_object_info()`
3. move `fetch_object_info()` away from `transport.c`

The dependency WAS like this, as I pointed out in a previous reply at
https://lore.kernel.org/git/CAN2LT1AM5rYpwjZ+rhYerxDkL6mbxr7iDc=3DwvuhvNKS8=
VVXQ8w@mail.gmail.com/#t

`transport.c`  -> `fetch-pack.c` -> `connect.c`,   where "->" means
"depends on".

In v5, it would be like this:

`transport.c`  ->       `fetch-pack.c`         -> `connect.c`
                      |                                      /
                       -> fecth-object-info.c  ->

Let me know if that makes sense.

> [snip]
