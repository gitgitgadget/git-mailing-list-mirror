Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A30C2E0
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 07:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760080032; cv=none; b=VAi8MpdyTFt8NgC47uzj7gGGIxKdUvJRZ3PZsWZVdD0Aryx1fJJ9uMhP8HLh51+79KqzPp6cpRvnnKWouBD2We2rgzAwnsQHePKnIm46q7w4xA9bHDrQChNgMSjZ8wiHGiIvz52R8iTXAXtTz5P4a3CAv4KuzWtCJIIDqRaIulk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760080032; c=relaxed/simple;
	bh=IV6LfGe2vqnjVV2ZMKlbX5CA44rkN6VKRq+GSr3azYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nmryAL13s4kZr5E7/2oC41ISQBWiOPIQ6qGxBN3auPAIreQfCfwzm3iD9mtsHi2FQVr3eGCtQbbhvrYpyv7y0KNEQ5ysN419ruSa59l+MoYkUw5DYpHiX6QGJknqMpuZapB6JwyjMp72DHy986ZZ4uZKMzQgf6QYql85J8Ma/Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFX+i8mT; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFX+i8mT"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b3da3b34950so282189766b.3
        for <git@vger.kernel.org>; Fri, 10 Oct 2025 00:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760080028; x=1760684828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1J/FYIPrQKhfSQFCZxc7FRYj8dtZ30o71+AErYESaRM=;
        b=CFX+i8mT58S+3BMFB9CyVvzj6jTHH8CVsjT2RWfwPOktUtwlot9eWcNVmP5Nen43fM
         ROQ+f8MOkQVeFXxLrHiH7/Udxqybrf0+LUPpWgZEPAXKXbjw59jQEv5EjIEt8HHQW3Vb
         U3B/fM1bI2HPKzt5Dprb26ZQLrtdoOTM4CR7TgBbO2i3+M2kC5YBsSivA6SAwoMzN1d2
         4NmpQISKEyKaOqkKwCCGhQtU+lVFv50G6S087EytRTTnKVmGuX52e349KcgjpUuYHUKO
         I4/wgCdmVT/BGlP3R6sjLBO/zVYzSGaUqAXlQIBMdcAkcdXn1j/KCRNSjSDe6f7vJPNK
         2vxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760080028; x=1760684828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1J/FYIPrQKhfSQFCZxc7FRYj8dtZ30o71+AErYESaRM=;
        b=rRXHA4t7YxuEniP5JgxqPbMtSoae0YhDF+ola4fo4GF84y1u3sGAnSgYgku6vYiEJK
         DbSfHbQ+916UIOFtg2jQ56sNtfPFxjCnqmRL7lnBRPQ8zEtXFa9GuM+CGdRmO35OvLZv
         QDZYNaobSLVv1jblypdazIUKdDaQWfheRcqfyKBtpZzT/C7r3mRrixa2Bo6tPUBcioEo
         +1kIr5j9RWAZX6CeDaSg4CeEgQPXKW5AU9EUDisHSeRsskxg6qEOIapIRekuOMS1jT4E
         UXw2Awt/mACk456ju8NJ9dhFkjDeIMhazEj9rzbHqk98H+LifWsAet0h9SmcBZWdEzYO
         Ylew==
X-Gm-Message-State: AOJu0YyJTiR+AOCK83LciAQTksyjSTh5/m1x6WntrN7qRqduO0FbE52i
	TTJT+KlO2GF+37qQlP13vV69uE1N8v7B3AMeFQ1s70ABuKY29bPf4+97KcFuwu0UrMqIcq0D2a0
	KbC9Rj70CxICiyj7YVAJxCcmkcgfVYVw=
X-Gm-Gg: ASbGncsZLmni4FT/odqXbvN+KgVsgOZiBwG5mXUTc8FYMkKGXdGuGPCabnjwygp6mSY
	RMllZzQEVJrpmeCmTmO4YzFojzt2CZXJmKqZRmkodnKXtxg3aN4ZZTeD+7enPraMbqGKNXpNaCr
	AlCYIRboy06ioMd6MyugSb2krvlW8fP15y/zCnNwn3cDPxoxUefhZnpBGq/kqPpVsnCi7k1Abpd
	s28y+tpnTN+WzvVFUWPJypbYOmbw6shpSxu
X-Google-Smtp-Source: AGHT+IG8ZWtQlmmkWz6TD0RiBhuhs6deSPSvjc3o9EFdM/0NULM77XywS/QQ8IgFLAGew8AsbexENsrogpCmnTfP4fg=
X-Received: by 2002:a17:906:7949:b0:b3c:bb7a:c366 with SMTP id
 a640c23a62f3a-b50a9b62b79mr1013202766b.7.1760080027778; Fri, 10 Oct 2025
 00:07:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007122958.1089680-1-christian.couder@gmail.com>
 <20251009122457.1273701-1-christian.couder@gmail.com> <20251009122457.1273701-2-christian.couder@gmail.com>
 <xmqqsefrblk5.fsf@gitster.g>
In-Reply-To: <xmqqsefrblk5.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 10 Oct 2025 09:06:55 +0200
X-Gm-Features: AS18NWA7TNjSjTHe687OA5ihCNueBSlsSAteU3BmGcHvVa1EL3_FZTaa1-Nhb6A
Message-ID: <CAP8UFD10eMwKdacEzLumdXUghV2nYZViDT4o44u1qgXVU5Pzew@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] doc: git-tag: stop focusing on GPG signed tags
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>, 
	Jeff King <peff@peff.net>, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Todd Zullinger <tmz@pobox.com>, 
	Collin Funk <collin.funk1@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 3:19=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> >  -s::
> >  --sign::
> > -     Make a GPG-signed tag, using the default e-mail address's key.
> > ...
> > +     Make a cryptographically signed tag, using the default signing
> > ...
> >  -u <key-id>::
> >  --local-user=3D<key-id>::
> > -     Make a GPG-signed tag, using the given key.
> > +     Make a cryptographically signed tag using the given key. The
>
> Given the above ...
>
> >  -v::
> >  --verify::
> > -     Verify the GPG signature of the given tag names.
> > +     Verify the signature of the given tag names.
>
> ... it would be more consistent to say it with "cryptographic"
> somewhere.  Also what we verify are "tags", not their names.
> So, something like
>
>         Verify the cryptographic signature of the given tags.
>
> perhaps?

Yeah, it looks better. I have changed this in my current version, and
will send it in a v3 in a few days.

Thanks.
