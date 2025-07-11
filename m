Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD10521B9E5
	for <git@vger.kernel.org>; Fri, 11 Jul 2025 22:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752271938; cv=none; b=kLisHEs3OcEaBb0rIa0EVuqGhOULe68jwa2h9UuD/qDnq8JL2CIZhTpJ6sc7emTtXmkIBmgAgNOW885vuErPDcibEpPl7mgLJQXhrLZLex1XvqIP8UbvaToofXKUrLq6pPc6qCeYGDOKe4UqRrsf058h5t1gQvbXZmgQvivKa54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752271938; c=relaxed/simple;
	bh=HXJGHjrdUCQkKdzDkS8cLTA5SEBlw4Q3+5oRp8hozVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ose3kM2zRGMTNc6jeop0HSPxo5iM5y12yPzGI2YWewpIm4lOWt3V++MWl2f04u7GGiqBgJ9R96wll1oEHimtO8j/hasJZpY8zHV+8nJn4yyY7SMruIuCVaX4X9/0Vkl/mdKJT6X0hDrFrkZvqe1QENp1b6rdcoQwerue5kcDoKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nZz8qE9m; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZz8qE9m"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-453398e90e9so19547855e9.1
        for <git@vger.kernel.org>; Fri, 11 Jul 2025 15:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752271933; x=1752876733; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RoxFlYYe8mP74u9qHfrYlKTJRb+gORbngmUcQ1B+Vgc=;
        b=nZz8qE9mOd3cLIfk//zsWiU8h/A/bjtzrRmXOT+7c4OaZfTujWzMn/u88XLuNcgY7B
         CfTUiB4alim6A8VpOFT/y5zkhm0w5aOM+hrTUPmD1qENHyOZFkRNA511Zo1vbe8yeAqG
         Wj7HFxvbVoGc578rfpEZZxIa/TNNDGAOwft+hEeDDhAusfdiz47rEO9lkbhMeDarwyxo
         0f2S01FNcy4MwO+i94DgnGmkLuMEokWLjMJfx7Af6HqcPViczwc4KyCWZAXRX5ixDbhL
         GA5IKSQ/MZBIBch8JEKtEHitF99vi45NqhD6Afhe0NYeR/7wH3TwDSWJIp8kV9jlkpk2
         K3tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752271933; x=1752876733;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RoxFlYYe8mP74u9qHfrYlKTJRb+gORbngmUcQ1B+Vgc=;
        b=FXGfkl5jaIWauTZBIZNc7oeRWgYHJAtl9iiTrUqks3XgNi7gX8hveRMmeaAMemef9D
         5xfJqFRb+ggaZw1QaADEnSKasFJ/vzHh/UOHL3Hq2kHaJPvMYuD3rycbVyarqJ+OmlOa
         ISmqn54Tev57+V+kebtqD0jRn8osBgVQBaW8hoEm4mA+fQl+XB5fI8r1mpNNiOYE3qM7
         mvQs5QTDs/SpnJNDJKDTNAArvukmRKkWycpKusDwhKgngzuoku7kzwMNs4MQY3/OxGxU
         8OJxHQBMBR/YHz6/2YoSKhpYmDdszay3Zrh4pdtyMc/niN8DHx4rI+uPy+RPvwI/YDcv
         66KA==
X-Forwarded-Encrypted: i=1; AJvYcCU+KjzrQ/ZRL9v4wvsufCSWfCsEe8xKYU/IIIczjb52ZRISZ9OX3RdaABJNRMeMV0CP3Hc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yynt7h1peUvhdXcDfnB2xUvp7adYGBWmkXWjSPNUGmWLXPQ8P6T
	LU9Rk9PpfjnrBBsh9WIiyzfwh+5/qnqFncCt6idPS1IHKBoLO97KbWYL0jU81ijcEdxPGYoJSx/
	wSyyfeVxo25eHL7tUAjGKJnAGNoXqj3A=
X-Gm-Gg: ASbGncs9nl0Z1yEhdN6Gzkk1dl3BzK27CKEq88m5yFpG+pmy0IsxgwOo2RstAQB09sH
	Gp1755a8rq7/S4k5nxc2GO4BBzSk7hMftjdugC7j99gJIW2z0slXJpP6W2wAFjhMBkjpx490An0
	t97RQTDwiqSVWEPaZGHXnqwnTHXkdyguNKMzf2yI+/li6XFnqhxQdSryRllAcDWV+mUhqVW5EQT
	1gr47MHzygiMn3tci8MDW4z0PmQwvPLreSbSkFZ
X-Google-Smtp-Source: AGHT+IFaP3ZsWf5bpGT/XgfDIY33vyq7MiU/gxr83vxBSihvgsTqLiE/FNjjx6qWaBPnDmj4BVzv3KGOHS/rOlCaqnw=
X-Received: by 2002:a05:600c:35c5:b0:453:78f:faa8 with SMTP id
 5b1f17b1804b1-454ec151dc4mr47228925e9.6.1752271932745; Fri, 11 Jul 2025
 15:12:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710221641.857081-1-sandals@crustytoothpaste.net>
 <20250710221641.857081-2-sandals@crustytoothpaste.net> <r34i7fhxwbxhppc4ia7lpyr3xqj4tgusaeikaaonpwtywlywxw@ygfmv3f3q67u>
 <875xfypsom.fsf@gmail.com> <idgdx2au3zgpowozspvu6ttvehybtwwuqf5kwqga4yok7uo2uj@wno7evyjg6pq>
 <aHGCRLGHEB0m_cXZ@fruit.crustytoothpaste.net>
In-Reply-To: <aHGCRLGHEB0m_cXZ@fruit.crustytoothpaste.net>
From: Carlo Arenas <carenas@gmail.com>
Date: Fri, 11 Jul 2025 15:12:01 -0700
X-Gm-Features: Ac12FXx2PQ96YMFFwsBApjTGQ1gP1g3sYTiMBPPWczxfCBgnbDCvxZEQeWhmo7w
Message-ID: <CAPUEsphkzaibm2FMBoj-9nbFch7UgRvyvmzErmno0z+2k5X+OA@mail.gmail.com>
Subject: Re: [PATCH 1/1] http: don't send C or POSIX in Accept-Language
To: "brian m. carlson" <sandals@crustytoothpaste.net>, 
	=?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>, 
	Collin Funk <collin.funk1@gmail.com>, Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>, semtlenori@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 2:29=E2=80=AFPM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2025-07-11 at 20:57:03, Carlo Marcelo Arenas Bel=C3=B3n wrote:
> > except that it would be incorrect, as language tags are defined in RFC5=
646
> > and are larger than that.
> >
> > most importantly, deriving language tags from locales provides some ver=
y
> > useful tags when including the characters after the _, because zh_CN an=
d
> > zh_HK use completely different scripts, for example.
>
> Yes, that's true.  You have some private use and some irregular tags and
> you also have some tags that include scripts or country codes.
>
> For instance, Swahili can be written in Latin or Arabic script.  As I
> understand it, the Arabic script form is older and less common these
> days, so if I learned Swahili (which I would like to), then I might only
> learn the Latin script variant in a course.  I would need to specify
> that script in the language code to be sure that I was presented with
> content in a form that I could read and understand.  Similar concerns
> exist with the variants of Serbo-Croatian: some are written in Latin
> scripts, some in Cyrillic, and some in both, and it's not guaranteed
> that all speakers understand all forms.
>
> And then there's pt-PT and pt-BR, which are not always mutually
> intelligible.  Most free software I've seen ships these as separate
> translations.
>
> I don't want to implement language tag parsing here since we don't need
> to do that.  I would like to do the simple thing to prevent commonly
> used locales that don't represent actual language tags from being
> included and not overengineer this design

I think that your design of filtering C and POSIX accomplishes that,
even if it might seem like hardcoding those two values is a little dirty.

Moving the logic (including the filtering, which is already happening
for the `!NO_GETTEXT `code path adds several chances to modernize
and cleanup the code though which will be beneficial (ex: using and
strvec or even a hashtable to process the candidates, improve
validation and tests)

Carlo

CC Yi EungJun at a hopefully working email address with link to thread
https://lore.kernel.org/git/20250710221641.857081-1-sandals@crustytoothpast=
e.net/

.
> --
> brian m. carlson (they/them)
> Toronto, Ontario, CA
