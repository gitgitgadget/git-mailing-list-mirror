Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4783A1FC100
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 19:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733253995; cv=none; b=KZZlxDnLTVodoP48B5q1N3rBtGQUI+l2/HXBN1LXHROyQEoejhewPBsF+NVqmA7bAFc5XJvT9z4fhFGxoZsauEAcmBWbbJZUs8PRiIGQ5syIGiLElw2MZkM79sNTFDqEIpPle0wO+pbSSfzuq1J7j/a/BEpGHMbbpoPvdYS1FMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733253995; c=relaxed/simple;
	bh=T5/ku9AfXNrwVkxV/jeRlQ2Hf840by/q9Q18s43EEWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rtxkAe0Rb3IJxptSQqr4K2e4L3wnubwYY7xkea0V9lqeWRhW4xPSTJyEKVhH+DojBxJC47ZoB0urWXZrbs9u0Tq7G3yTU1k4TAwF5G0pwuqZcY/B2CSGGhjN3+cHPwwvwa1CJYbQJeLJTVmKRiIvM/ghZOTsKDZePGJzMCAt7eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bkRNbJr5; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bkRNbJr5"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e39841c8fd6so4413389276.3
        for <git@vger.kernel.org>; Tue, 03 Dec 2024 11:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733253993; x=1733858793; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ybTRmrrLiEoTHSEdztZiF3/aG2wtxG2dwv9QefiWpyY=;
        b=bkRNbJr5tdaUnssBwf4I0Iom7ceA8Hc1NsjJ1pSz71B/pLQQLLNkdF7kOV6RPkPzvm
         mC5v0B7PklkfNWJOl4IV2Bqx7jALPPzAO9kufSod+fdF820vERLIdU0l/6dvYvuMbCCo
         Fplobvgq8BsN0+Jab0ave5vWpN9mIaVom9hFYQjJlIdhB7o0wioXoH8oKkPA6bJUD591
         mZugsQFcBjmig+sTuY4ZAkbRR+4PBiVDfUEgQ6El5tFLj4kZZJmNBa8SaXbWn04lfhxQ
         4ZFZ808aNlt1ES2F2cgJM/H0bRx3R81aZcojaSnIU3Hyn9jG1Zl7mhfrRuhZWXN0AKTe
         AlNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733253993; x=1733858793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ybTRmrrLiEoTHSEdztZiF3/aG2wtxG2dwv9QefiWpyY=;
        b=S2BDr/5us0f+vtG/ZthWsXCO4+mlTwgoan2xwZpyt0UNz58KFvMLQkrTJOd7vCHL7D
         bJ0NODjZYAUXK5fw0knObViYap7Qn5xkgo7/dN+tsxyhkmn0ffDpSM3qxncYvM/4/t97
         OerHk3pU5bScSutX0p3QgTDfyUo8qgjwZmV88tAOpWA0hE1GLJhbJB36UhzaoqCjhJsZ
         LF36Y2C97eUDARRouj9qL0lFeqpMwCSwSQXPNkjJ8wzywEdLMc3eGo0OuinWWKbh5L+c
         5tFwoXcyBYfTvFCWSO5uR+N9ofv8BxYaU54NWKvhBqWTV8MV9YeSi76/kvrsi0Tm5Gu2
         X3qg==
X-Gm-Message-State: AOJu0Yyo227WXU9z+UDtJVpjFD2762dtT0PIyHkxKKP28wZU2iJRCZLD
	V9seWbMXWMUJ7e1b8vndQOqhthQkAROeWrTztvvutfJJu8zXrAyBUyrH+KKn+ExfLFbQMTVkQN0
	lUc3tgAlUY1HMq2BaIQ6xgdrXT88=
X-Gm-Gg: ASbGncsGNXC8UK5sGJ7aPC8cGdF9Y8K8sc9aeUAJE61E4b2RE0b6UknGs3VQWKkdHNw
	x56BepEVPkiBEekpYjYcl5iPW5eylQmKQ
X-Google-Smtp-Source: AGHT+IGY2b387Vmhw+UKUVk+XdtL54QZ6ac7Uzeu9oqjQcWpLGKIJzzU7U5JcDmqcAHJqTFwhkJniesEbc5nzgKykaU=
X-Received: by 2002:a05:6902:2308:b0:e30:cc34:af1a with SMTP id
 3f1490d57ef6-e39d43712b0mr4383129276.35.1733253993226; Tue, 03 Dec 2024
 11:26:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20241125053616.25170-1-eric.peijian@gmail.com> <20241125053616.25170-2-eric.peijian@gmail.com>
 <Z0RIpRh0QlPWk3F8@pks.im>
In-Reply-To: <Z0RIpRh0QlPWk3F8@pks.im>
From: Peijian Ju <eric.peijian@gmail.com>
Date: Tue, 3 Dec 2024 14:26:22 -0500
Message-ID: <CAN2LT1Ao=oV3Ufv=-2Eiq2xj+YfEF8-Dw8SoANdzOx1FhJua0g@mail.gmail.com>
Subject: Re: [PATCH v7 1/6] cat-file: add declaration of variable i inside its
 for loop
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, calvinwan@google.com, jonathantanmy@google.com, 
	chriscool@tuxfamily.org, karthik.188@gmail.com, toon@iotcl.com, 
	jltobler@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 4:51=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Mon, Nov 25, 2024 at 12:36:11AM -0500, Eric Ju wrote:
> > diff --git a/fetch-pack.c b/fetch-pack.c
> > index fe1fb3c1b7..bb7ec96963 100644
> > --- a/fetch-pack.c
> > +++ b/fetch-pack.c
> > @@ -1328,9 +1328,8 @@ static void write_fetch_command_and_capabilities(=
struct strbuf *req_buf,
> >       if (advertise_sid && server_supports_v2("session-id"))
> >               packet_buf_write(req_buf, "session-id=3D%s", trace2_sessi=
on_id());
> >       if (server_options && server_options->nr) {
> > -             int i;
> >               ensure_server_supports_v2("server-option");
> > -             for (i =3D 0; i < server_options->nr; i++)
> > +             for (int i =3D 0; i < server_options->nr; i++)
> >                       packet_buf_write(req_buf, "server-option=3D%s",
> >                                        server_options->items[i].string)=
;
> >       }
>
> It's somewhat curious that you change the type to `size_t` while at it
> in other spots, but not here. Doubly so because `server_options` is a
> `struct string_list`, and `string_list::nr` is of type `size_t`.
>
> Patrick

Thank you.

Yes, I missed that. Will correct it in v8.
