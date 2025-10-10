Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E70D1EDA3C
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 00:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760056977; cv=none; b=BWAk826hTeMAU18+jU09tlfCHF117UaeFCF0plrjKrqM1gmw+IYdHg0jKCZa2kUGsejeYTlFwMZgFpaQqkG6L4hhjO0q+RjJsxHRbNmUh6NCIbyDPg7Gp+SQl8QwjOrIzmEkv+KklW4SyzR04rqvKrR2zCs2yu3trqQ1cWjiyRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760056977; c=relaxed/simple;
	bh=xxDU2G/5cqECO083mk+z3p8RX1m3qNTnWG8rDoKd4Qo=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=gBZatuizA/GpuV5ilmuY0WRiqgdNF+KWSCnqErzqQ5iAcvK2qujej2h1zVlR3poSSrU4axiESLMjF0fpizeGCn0tS4nm/X9IfDyhqh2blHXv0NfC35Be5OISBmePcHNzf9BFNSpf0PZOecwqdga6WVJnMLYbztWGMsEcPfuRYdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TjcFWCH7; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjcFWCH7"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-72e565bf2f0so16397067b3.3
        for <git@vger.kernel.org>; Thu, 09 Oct 2025 17:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760056974; x=1760661774; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YzYZYGTA/bIjI3GkMYGi15ERzIFuvX7J4Zf0qqcTmrU=;
        b=TjcFWCH75BGplCUOzZcN8ntJWDrocc53bPSypVwmJ478KB+BLyDIRG++FGZUstWjTk
         EqNHhWegt9wfGgbmR/dCa112pWWPevtd6DtQQaUqlIHxyLYrbU5tPukACLiU9K3yBRQc
         ZkVuAhFA/DhoDnrR4+ClSi9QBYmaAuyW4HIbHtxRcH6VWhd6B/E9uBWMnpvJUhj3ElXz
         CdeWsz5npMlYF9AXfid48KaMnqQ8n+kZJqpEuA/qT7ofmWKw+mE+TuaWaV0/K5nMwQuQ
         jfO836QzsGX5ub4CkLGAJ5oSEYfUk8owpA2pYb/aDd+sqHSNCMxaQkqMx69ikMhpnLGR
         bP2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760056974; x=1760661774;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YzYZYGTA/bIjI3GkMYGi15ERzIFuvX7J4Zf0qqcTmrU=;
        b=LdEl//y7YsDYq1MzuvtlOjaWQmzM5qNxTnlk4tbFLb0jW2kJFLFExZvGnvd8nL/hLS
         RFijc1CZAXew6yItfjZ2b0pBJ5k27s9MofzXfI7idb4XVR6buoUx0PMCb83kFFkoJS+8
         3YaOJLY8tgxZt8i2suLUu0q1BA0sZPVlFIdkFV4gZQ1bfPZ94Mi/eKY+amAyYd+xXXIT
         zW3qf6365J9CK0U6TYkXQOY9WHHRKU6KHKNdEd+wosKtCSnjLSO+qrCKo/O3a1T8lSjg
         auZTImnDB6DAVcGixdsWyM9Ixp6PR62TBCVczSk/KYu+3GzEbvtFz/LR9jN0tpC13wf0
         pY/w==
X-Forwarded-Encrypted: i=1; AJvYcCUZmca9s7uMxph5lDnLTo/Ad8rpR7ZgkjVuICU0W7NAgPk/H9+T545aVljFtXmz37LXlm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZNX8mVRYVZ/Dbi5eRvBHgDAq4XsHdijXcFODNSff06zpwPB5N
	8uMQqIKbjJno55MR5WXTHRa1j+9aLHZfeEsfcLAS6nJJNwyDeL9eYhRptVGT3Q==
X-Gm-Gg: ASbGncuffyuR22Ev3o9e4TAgDI/k2rauzRFrDA5VFPoizZKltywN0tJ3o6oBIlbZ8VJ
	/sYHZ5kno0gxZUa2bF9gve66W3DDE0t6fUHISOwp8DDsRhsgRZo/Fezz2+iro/ZSQhpDIFc728R
	eEuLLrIRiu/TGvwFMeDPJHvRYVb29lg60nv31Sutc3iOZsTbPkbB7Q+hpUo9ewpdvLkLYn7C3Dw
	+7fxrVyTLo/5U0YkXadYb5Q50DofcSIOEqRW6AS9RzqsYq8hRWaJ7K0sCjEmpyQN5YVVJE18M5B
	QShLj9QRUZKSJs9hrFbae3HAfz1V0nlyNAqajrgUs8gAMVhy7xP8rbjmlomGjik/uX6IS6KnvM1
	fbLef4XDrNtsdWhSuxR7cYHgetO2xfwrtaQYqbFPIMjj8wrtJ7XmuNbH5nU/nyMuFtyW/I6Bvaz
	+NfrDfrsL7
X-Google-Smtp-Source: AGHT+IGXigph+U1JRG3ZDYG7xZJTLSAy58rT7E3XVaSADROGkL9g3ETrdPgohZJFNyQaAAj4+cKWPQ==
X-Received: by 2002:a05:690c:6605:b0:77e:6b45:d156 with SMTP id 00721157ae682-780e125304bmr117144557b3.0.1760056974391;
        Thu, 09 Oct 2025 17:42:54 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:addc:817b:ddab:687])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78106dc47bfsm2560707b3.7.2025.10.09.17.42.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 17:42:54 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] doc: add a explanation of Git's data model
Date: Thu, 9 Oct 2025 20:42:43 -0400
Message-Id: <F485A91C-2F1E-44DD-9179-0B47426DA3B7@gmail.com>
References: <b2a9b8ca-8f2a-40f0-a724-0da707902985@app.fastmail.com>
Cc: Julia Evans <gitgitgadget@gmail.com>, git@vger.kernel.org
In-Reply-To: <b2a9b8ca-8f2a-40f0-a724-0da707902985@app.fastmail.com>
To: Julia Evans <julia@jvns.ca>
X-Mailer: iPhone Mail (21F90)


> Le 9 oct. 2025 =C3=A0 10:21, Julia Evans <julia@jvns.ca> a =C3=A9crit :
>=20
> =EF=BB=BFI collected some feedback from Git users on this v2 document. I'm=
 expecting more
> feedback, but here's an initial brain dump of my notes. I mostly wrote thi=
s for
> my own use but I thought it might be interesting to other folks too.
>=20
[snip]
> references:
>=20
> - Two people pointed out that because references are often stored as files=
,
>  you can't have two references named `julia/ticket-number` and
>  `julia/ticket-number/task-name`.
>  I'm not sure if this is a fundamental limit of the refs data model
>  (does the reftable backend have the same limitation?), but it could be
>  a good reason to mention that refs are often stored as files, because
>  it makes it obvious that you can't have a file and a directory with
>  the same name.
>  Obviously this is an issue that is affecting people relatively often
>  in practice though so I think it's worth mentioning in some way.

I don=E2=80=99t think the reftable backend has this limitation (?), but it r=
eminded me of another important one: on case-insensitive filesystems you can=
not have both =C2=AB julia =C2=BB and =C2=AB JULIA =C2=BB branches!

This occasionally creates problems where someone cannot fetch/clone what has=
 been pushed.

Anyway: it=E2=80=99s worth mentioning the files for that purpose. It would b=
e nice to improve the UI as you describe below to continue to be able to nat=
urally interrogate Git without needing to know about all the storage formats=
 (recall that cat-file works just fine with packs and MIDXs!).=20

> Overall: several people suggested mentioning more about where things
> are stored in the `.git` directory, which I just removed.
>=20
> I think I want to avoid this (not sure yet), but I'm going to think
> about the underlying motivation for this suggestion and see if it can be
> addressed in a different way.
>=20
> Some ideas for what functions discussing the `.git` directory has:
>=20
> 1. Like I mentioned above with branches, sometimes the implementation caus=
es
>   some extra constraints like "you can't have branches `julia/ticket`
>   and `julia/ticket/task`". So often people like to know a little
>   about the implementation because it can help predict some of the
>   holes in the abstractions you're using.
> 2. It lets you view the "raw" data, so you can be totally sure about
>   what Git is storing. This is nice because Git's UI can be very
>   inconsistent sometimes, so looking at the raw data gives a sense of
>   certainty about what's actually there.
>=20
> I tried to put together a list of ways to look at the "raw" data without
> looking in the `.git` directory. The ways for objects and the index are gr=
eat,
> but for references and the reflog they involve these pretty complex format=

> strings, I'm not confident I've gotten the format strings right and IMO
> they don't inspire a lot of confidence.
>=20
> View an object with:
> ----
> git cat-file -p <object-id>
> ----
>=20
> View a reference with:
>=20
> ----
> git for-each-ref <ref-name> --include-root-refs  --format=3D"%(refname) %(=
if)%(symref)%(then)%(symref)%(else)%(objectname:short)%(end)"
> ----
>=20
> View the index with:
>=20
> ----
> git ls-files --stage
> ----
>=20
> View the reflog for a reference with:
>=20
> ----
> git reflog show <refname> --format=3D"%h | %gd | %gn <%ge> | %gs" --date=3D=
iso
> ----

[kept for context]=
