Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC9CD512
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 23:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722469607; cv=none; b=QWSdJ6OVhqqfewcFeXWVJXmvq2BUB3JJqpMPm6gDV2+TUbDHY8iBFny2sAgClfRHVwVFCIO4atnE+M9RGGceDhM/qaCka0brAlry4FnhoU5LhxuO0zVMOtDH/rjeKLn+OH+F9Xhi4+jnZsS2ghCvXRK1elGkdSFb3VQnEugHzwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722469607; c=relaxed/simple;
	bh=1LmUamm8jWTA/sKhUJjhk3hvXMO3zfhlEBhi8Bnifko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dT5cx7Yxq3NC8PqULOLrYgc9+8PO5AThy7llwZ+szvmHmNnkQsxW7N5AE7gD1srca9KP8Bjj0N/rDN/O3ygVoBRKM0ZE9bAXDhahxjLFlGsSgaNNs6FFYXAs91vdu+54PwJyPfKyzJ7Ze/dbtUl5rIk6U8z2dHZZ/gZ2ItoI9tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gw2jZ9L/; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gw2jZ9L/"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5b5b67d0024so2235202a12.0
        for <git@vger.kernel.org>; Wed, 31 Jul 2024 16:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722469604; x=1723074404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4vfpohaJ9r1bkQgOvZuMcUgE7WODQeI3P58lrqbBBrM=;
        b=gw2jZ9L/ILHjcs4mqTlKFjp76jD1+v8dktoWwky1OsK3it5CEDAComULScbCXnkQqS
         TkBZat1QXYHnuW1KoDivEWJIp2iAc9dT5coeT+vLYrozEq4DF9Gm8gwzucnkLgJFO22p
         7sZolqDCsBOF7NadtzJnea2PdFg8T8uP2WJ+SV3jnH1GWfdBoG4bBzlKXICtwYXRHmm5
         JBp6DEYLHbwOoxKFLZ71MI5OkozBIYaKomXPDjXTfZu1VEa0Mbyc+38x3UPdTLdRnMqR
         AExuynV6phqgkLrPhxTuD0CMMv7mz/fcro9wLBqFYiLAyBxP6RvtvyDC45EWqdID0AD/
         dSxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722469604; x=1723074404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4vfpohaJ9r1bkQgOvZuMcUgE7WODQeI3P58lrqbBBrM=;
        b=uzBowyKsjh1nz85oQjRIAXboc3Hpps+jSZ8J3QCx+6jZ+IGFGVOzBevY9MZbQhxMQp
         zuYQBUSu152FABsaVIHCHRBJgKFmZySGb/qgnkAU53HFOzqBQ6TXoUYWlIBRk8Q4moRO
         SV8Yxn8Ll4Q1uKlTSCnUx3TVotNOnCERTAhM//It+Ic7JB9YgVAEDKpJG5jP1It2KGn0
         /z4JzJ7MC+LGqrBvNIKStshBQSv3JmHeJdB/DWxbWVdj/ec2qh+v8FucMNfZ8fEYi6zJ
         6R0XyGowSFdmBBZdIzFcrLz/faEuxojbEGyguIKuxP0kattUv2L7VNyVpk6qBXKs8dFW
         4FGg==
X-Gm-Message-State: AOJu0YyJqhsAoiH8ozNARaJ+JjZ4UzqFOCfcedqSbwgKc/O/VULD2E/8
	h8xCIbwRvI8v1uVgMBeVn1W0B03Y2wsX5XdvqO/4t34DstFEYzQUrJgIhRAFRn0TWlQITPA5hNM
	5Oh5OY/UzD+LWGb/1iXN53h0ZRpY=
X-Google-Smtp-Source: AGHT+IEoXnKb1pysm8Nvj+gbh+ofOwbrmThpeEYs8ajNGmYT2Wb3jgC/5AEEWwLe2eUzUdrvy1g1oTw0mjM6vo/kwWM=
X-Received: by 2002:a17:907:3f87:b0:a7a:a3f7:389d with SMTP id
 a640c23a62f3a-a7daf51863emr57656366b.31.1722469601662; Wed, 31 Jul 2024
 16:46:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANrWfmTek1xErBLrnoyhHN+gWU+rw14y6SQ+abZyzGoaBjmiKA@mail.gmail.com>
 <ZqqucpNgqSgZDPtA@nand.local> <xmqq5xslyyaf.fsf@gitster.g> <ZqrKeG+alFldB7OY@nand.local>
In-Reply-To: <ZqrKeG+alFldB7OY@nand.local>
From: Han Jiang <jhcarl0814@gmail.com>
Date: Thu, 1 Aug 2024 11:46:30 +1200
Message-ID: <CANrWfmQ89+NN0_O+=g51DkXHJANPYYMYN_zK8Os9JBiuZiHHQA@mail.gmail.com>
Subject: Re: git config set --file, key-value pair without '= value', gives
 Segmentation fault
To: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> but I am not sure exactly how we want to handle synonymous Boolean
> values here.  Regardless of how "true" value is spelled in the
> configuration file, e.g.
>
>         [section]               [section]
>                 key                     key =3D true
>
> I wonder if "git config set --value=3Dyes [--fixed-value] section.key
> false" should replace either of them to false.

'key' can be selected by `--value=3D'!'`
'key =3D' can be selected by `--value=3D'^$'` or `--value=3D'' --fixed-valu=
e`
commands for demonstration:

cd '/'; cd '/'; rm --force --recursive -- './test_git'; mkdir "$_"; cd "$_"=
;
cat >'./config.txt' <<'EOF'
[section]
    key
    key =3D
    key =3D value1
    key =3D value2
EOF
git config set --file './config.txt' --value=3D'^$' 'section.key' 'value3'
git config get --file './config.txt' --show-origin --show-scope --all
'section.key'
git config get --file './config.txt' --show-origin --show-scope 'section.ke=
y'

cat >'./config.txt' <<'EOF'
[section]
    key
    key =3D
    key =3D value1
    key =3D value2
EOF
git config set --file './config.txt' --value=3D'^$' --fixed-value
'section.key' 'value4'
git config get --file './config.txt' --show-origin --show-scope --all
'section.key'
git config get --file './config.txt' --show-origin --show-scope 'section.ke=
y'

cat >'./config.txt' <<'EOF'
[section]
    key
    key =3D
    key =3D value1
    key =3D value2
EOF
git config set --file './config.txt' --value=3D'' 'section.key' 'value5'
git config get --file './config.txt' --show-origin --show-scope --all
'section.key'
git config get --file './config.txt' --show-origin --show-scope 'section.ke=
y'

cat >'./config.txt' <<'EOF'
[section]
    key
    key =3D
    key =3D value1
    key =3D value2
EOF
git config set --file './config.txt' --value=3D'' --fixed-value
'section.key' 'value6'
git config get --file './config.txt' --show-origin --show-scope --all
'section.key'
git config get --file './config.txt' --show-origin --show-scope 'section.ke=
y'

cat >'./config.txt' <<'EOF'
[section]
    key
    key =3D
    key =3D value1
    key =3D value2
EOF
git config set --file './config.txt' --value=3D'!' 'section.key' 'value7'
git config get --file './config.txt' --show-origin --show-scope --all
'section.key'
git config get --file './config.txt' --show-origin --show-scope 'section.ke=
y'

> It would especially true if the command is invoked with --type=3Dbool
> but it seems that the --type option does not participate in the
> matching with the current value.

> I think I could be convinced that --type=3Dbool should treat "", "true",
> "1", "on", and so on as matching here, but I'm not sure.

It seems that `--regexp` and `--value=3D<regexp>` and `--fixed-value`
take effect before `--default=3D<default>` which is before
`--type=3D<type>`, so creating a special case (treating 'key' as 'key =3D
true' if `--type=3Dbool` is present in downstream process, and when
`--default=3D<default>` is present, requiring users to remember which
has higher priority or which takes effect first) would be too
surprising. (Currently you can use `--value=3Dabcd` to kick 'key' away
then `--default=3Dfalse` to turn 'key' into false, use `--value=3Dabcd` to
kick 'key=3D' away then `--default=3Dtrue` to turn 'key=3D' into true.)

On Thu, Aug 1, 2024 at 11:36=E2=80=AFAM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> On Wed, Jul 31, 2024 at 03:47:04PM -0700, Junio C Hamano wrote:
> > I would have actually expected the fix that follow your analysis (by
> > the way, I found it really well done) would say something more like
> >
> >       if (strcmp(key, store->key))
> >               return 0; /* not ours */
> > +     if (!value)
> > +             value =3D "true";
> >       if (store->fixed_value)
> >               return !strcmp(store->fixed_value, value);
> >
> > but I am not sure exactly how we want to handle synonymous Boolean
> > values here.  Regardless of how "true" value is spelled in the
> > configuration file, e.g.
> >
> >         [section]               [section]
> >                 key                     key =3D true
> >
> > I wonder if "git config set --value=3Dyes [--fixed-value] section.key
> > false" should replace either of them to false.
>
> I think it gets tricky when we talk about the implicit true value
> here for exactly that reason. Do we take true to mean just "true"? Or
> "true" and "yes", "1", "", and so on?
>
> I tried to match the behavior a few lines down in that function, where
> we only call regexec() if value is non-NULL.
>
> > It would especially true if the command is invoked with --type=3Dbool
> > but it seems that the --type option does not participate in the
> > matching with the current value.
>
> I think I could be convinced that --type=3Dbool should treat "", "true",
> "1", "on", and so on as matching here, but I'm not sure.
>
> > > I'd like to hear from Stolee (CC'd), who is the author of c90702a1f6
> > > before submitting this as a standalone patch.
>
> Thanks,
> Taylor
