Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8B7139597
	for <git@vger.kernel.org>; Fri,  3 May 2024 05:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714714719; cv=none; b=RErEFbuYk6wH6xaaU9109rytT3RUyJ4vGqtRbyY5bS1KFSUN/kqzkK2FA9MkraNFvzk9/0Em89TblLjywkUsssRaEneGeR6pLwKFj1fk3Ki+aqBVlbWuLvNO9xRMv5LKOibMQ648hXlS65iyv996iQxBrJ3wADK/D7yyb/tM8mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714714719; c=relaxed/simple;
	bh=p/TxLhaqd0ocKTr2jVwxM6me6BmUCf+X4YOi1OujN6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Is4ILNxtvwt5lBvFtpr6aOB2GaZUNYUmMwcH28OWsD9++BpjVsCb5lcUo5TGqmSMGBjPXPQu4qhEsBqth1t4Esw1nxcRTVdGXvvV38xybFk5DbhmwfmTuAwPRqocL6jK1LBVr2gp2MMnNRXfQL66SZWYtiz/pvjY7ID8jbS/3eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NoZNlrIC; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NoZNlrIC"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a598e03836bso52075366b.3
        for <git@vger.kernel.org>; Thu, 02 May 2024 22:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714714716; x=1715319516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p/TxLhaqd0ocKTr2jVwxM6me6BmUCf+X4YOi1OujN6g=;
        b=NoZNlrICNBCAOWQ+M0/xAJR+ZZyTZKmK2qwQSRL3bdegKMKwu5TiTtafqHPEdZ1mIB
         ubsDadzdEZr6aKlDs67n6ABKOXQELow5xW9qNciDRu8K4iKtdHtYEGJMT7guZ217MYo6
         inwhZRWpsnLqC6XjXC4zdVT8dpgRB/ix1M6gmbdYAhblDYnOOGRVjC3WShFE7F32rDyi
         p1qGlI4FZ0Wph4pLsFbGRQCxOgv3PBsButaBg+EikyFWZ/luYg9KTKJ0F5VrBHjSd4rO
         JenQltNRXdhP/DFd4bEYYKPI82SluVCqgDngDhmW9KY8mGXx/ad6cJb0H6uoVyxTO8hP
         1bMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714714716; x=1715319516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p/TxLhaqd0ocKTr2jVwxM6me6BmUCf+X4YOi1OujN6g=;
        b=cBuHXQ8ODt9PfXpag9cD2q/xu6pHpjA2LRlva/HmX1u9fv1QrM9g0OGak6McwH1/pf
         DamFEWQ/q7/WkPVm8y/xliAe2Qm5pLt/TNkbk7zxJiiUv+jx7R1oIbo1ikKdrQr2oawe
         WnrEgUJa51vd5JBd3W9374jnWIp7sfIk4MtLcHPJxMHVYoeoT+yDjE7gh9ZTZfldxlQV
         qQX8ezZaJuI5Nc+X4QDvXB+YC+Mck0nsM3OFJBcSLPP8JcpLf0WqySaN2gTtbK60wmr2
         lyDC6mxuCldO0veR52JYiidUe0wiwCsc9W0HirTpsVwWoXzUCQ+FX7LYTU6BTCmo9tF2
         yNOQ==
X-Forwarded-Encrypted: i=1; AJvYcCU16CNTUB8BmcpJKXZkFYjNH3gr/tcskWvHM8D16EyoCX5qyp6rI0UV26Pk+p7jeuRWnvljYzU1UjZQdqRTjiM6NpgQ
X-Gm-Message-State: AOJu0YyFnikFePiPUnGEibIyziP8bAe5aZZAvgxJADiHM14SAedHK3oS
	FokHr8IKLMyn4R6iGBVN6SDB2v2r+PT7qKBWFvYsuy+ZJWVq6hin/013oQU8rlCSQbGR9nd3Pyq
	7pnLbNkqt8hOVhCQ6jXIHLF9ED78=
X-Google-Smtp-Source: AGHT+IEtTbbJ2Ut2b8W/F8FnWLTc3ptgqP+Ks2lKhlAr4Yp5TsXqu3i3sLSwJlp2qkNAoDfUzVWDC6d8HUndJvNK04Y=
X-Received: by 2002:a50:a69b:0:b0:572:9aa2:b75d with SMTP id
 e27-20020a50a69b000000b005729aa2b75dmr819790edc.6.1714714715701; Thu, 02 May
 2024 22:38:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKOHPAn1btewYTdLYWpW+fOaXMY+JQZsLCQxUSwoUqnnFN_ohA@mail.gmail.com>
 <20240501220030.GA1442509@coredump.intra.peff.net> <ZjLfcCxjLq4o7hpw@nand.local>
 <ZjPOd83r+tkmsv3o@nand.local> <xmqqfrv0ds7f.fsf@gitster.g>
 <ZjPTlrMdpI+jXxyW@nand.local> <CAOLa=ZRe6eWJ_ZyH+HRq=6Lh0-xZ=1X2Z2f3HW4+EVXNquaDTQ@mail.gmail.com>
 <xmqqbk5ndiqk.fsf@gitster.g>
In-Reply-To: <xmqqbk5ndiqk.fsf@gitster.g>
From: Dhruva Krishnamurthy <dhruvakm@gmail.com>
Date: Thu, 2 May 2024 22:37:59 -0700
Message-ID: <CAKOHPA==xgRBLXmyURkdZ9X4LqQoBHYy=XD0Q_KTQHbK54DOFg@mail.gmail.com>
Subject: Re: using tree as attribute source is slow, was Re: Help troubleshoot
 performance regression cloning with depth: git 2.44 vs git 2.42
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>, 
	John Cai <johncai86@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 2:08=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
> We could drop [1/2] from the series in the meantime to make it a
> GitLab installation specific issue where they explicitly use
> attr.tree to point at HEAD ;-) That is not solving anything for
> those who set attr.tree (in a sense, they are buying the feature
> with overhead of reading attributes from the named tree), but at
> least for most people who are used to seeing the bare repository
> ignoring the attributes, it would be an improvement to drop the
> "bare repositories the tree of the HEAD commit is used to look up
> attributes files by default" half from the series.
>

A hack (without knowing side effects if any) is to use an empty tree
for attr source:
$ git config --add attr.tree $(git hash-object -t tree /dev/null)

This gives me performance comparable to git 2.42
