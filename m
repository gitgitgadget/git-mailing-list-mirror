Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E9B5661
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 06:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733897631; cv=none; b=dk2v4cHRvISkfmMhubK5bYXxEb8AczSzfGkKrnNyxF+GwBkSIo40j+jtIU4C1p4Uhb9faQYDcFSz6xupChiYoCypKfe3M6HtTxfNfCZypMC9UOHzzYAEDxf+KEu0PYA3bHuUpMEMKftZmYHNso8B+AWiHp96pTyUjixkq/p1SZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733897631; c=relaxed/simple;
	bh=pLTxRxONlMxIZjGz2HNsmBCGIY+Q8o5jo0rRbznmnmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KHea/QjiuL123HXcTMd5qDtu/rsWUcl+tBvlhVGVvb0ixjVltz/r/t5SmfXnlVB6oaax8IbObtcj2C0LFjPmRzHGK4rOXz0Yi+yXj14j8n54TGPeSxevRl9R01NguQIJ65vL+YqN2YjUsVZmG5o5lMpDHNgv42kNlntouzO0hgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=evc71byK; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evc71byK"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e3c8cfc9c9cso94582276.0
        for <git@vger.kernel.org>; Tue, 10 Dec 2024 22:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733897629; x=1734502429; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Gd8A7xsBxgGFpcZ4WR04X2lwUIsd/ZZRQyAAGxTZrFI=;
        b=evc71byKrRja8lOsLfou4RMgl+njXpuYFjl6N57UiYkwMYsebOdgF9A5fWeGV9+ONk
         gpHaJ15FgNaV9dXVKLT1Ip0eN9//c3iRRAmD6Hpde/AgGzh8Vuurw9Emx2mmbCkSSBRi
         vivvFDywIRW9wuuJRgpIoosCjxIU/tCRKF4jbca42A5Pi1Imzq1XZVzkQ4iqYFI0aboe
         3VOzPyy7g7QTDpORlLo/06LGVb7xgiWoZJos3JBxFCvUxMc9DLfExR5b//OlDwK60+Qu
         nE1tmPEAnMcXij5vNixuFe/wszaQdMb1YrJaqykJJ5DmI3beTu9yubmLgJnweT/Tj0K1
         krlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733897629; x=1734502429;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gd8A7xsBxgGFpcZ4WR04X2lwUIsd/ZZRQyAAGxTZrFI=;
        b=XkI5JP2csn44FiRa70l5BxdoDf+PnLcCQ/BM+PeosEmHM7Q8LKwMkRwyRqGv8io4Y5
         eRj+qN9c2XhI/FtYEl2Y1yfVtQDeM0YNtpMWVIVO/wo8J4XQ3+4agt7idLvn/5F23/wD
         mqnk3C24FDsWaK0lWcbZKFyk22bcO+HYSqaLoPBDxdj602vCreWQBG2uDw1XvQBGulcd
         OwRX/W+qdklvQuj2125lCohPs7dSBmcliSJcvoF6lFxUdzWrrbB5XLpIsO1ks8/P9XDh
         Z6HuixNHGSyc3F0Lzx8qeQsepTmZc8XgrH/XGiddwXjTL1GeZ8znIpAKZ5sxRdtYM+5G
         mLMQ==
X-Gm-Message-State: AOJu0Yz0L3BsWqw1l9H1+fflWktwpysYztYUPFaWwtp2tRWJYT6HE5UD
	GRbls62LIw5iuUHISlqSxlWtGuNfNRCYnpqdKoRFl6pv3lQWyOhM/UObRVtRJ8AAhp/7vn7z4gT
	7reVIUVgMicme2jyUHP6reVBU/RU=
X-Gm-Gg: ASbGncvalapQFZ8l4Ti0IvN8CAv6GwW3viXe0anv96GSnG6WXWgdidn0cPkEbTFsPcI
	zRU4R0puw1RLcJlw7hmpqH1rc4r7OHVW5
X-Google-Smtp-Source: AGHT+IGgJXsZ2fbtVvIc90NaeVmU90nMuTN3Ch6EPBLRfXbOXmx2y+NTNVh0LDxS+oQwhYijQghfbj1w6faSvoFX1no=
X-Received: by 2002:a05:6902:2e10:b0:e39:97c3:c177 with SMTP id
 3f1490d57ef6-e3c8e44d2bbmr929581276.2.1733897629033; Tue, 10 Dec 2024
 22:13:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241207135201.2536-1-royeldar0@gmail.com> <20241209165009.40653-1-royeldar0@gmail.com>
 <xmqq1pygo2ti.fsf@gitster.g> <CAOfFamkEmJgUUj8C_TGbjgKs35vSBzNCDpLvK+utqnTtxd5iHQ@mail.gmail.com>
 <xmqqikrrjdds.fsf@gitster.g>
In-Reply-To: <xmqqikrrjdds.fsf@gitster.g>
From: Roy E <royeldar0@gmail.com>
Date: Wed, 11 Dec 2024 08:13:38 +0200
Message-ID: <CAOfFam=_G=EPkw-fCQD___gFc3U7rwnVr_uteKG9-USK8=veRA@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] git-submodule.sh: improve parsing of options
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Eric Sunshine <sunshine@sunshineco.com>, 
	=?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> wrote:

> Just to make sure we are on the same page,
>
>     --foo "hello world"
>
> is an example of an option "foo" that takes exactly one argument, a
> string which happens to have a whitespace in it, and is an example
> for which "variable has the dash-dash option, equals, and its value"
> pattern would not work well.

I'm not sure why then this pattern would not work; when the argument is
passed to the option in this case, we set the variable to "--foo=$2",
so it should be fine (like you've written below).

> If we can pass it as
>
>     --foo="hello world"
>
> then we are safe, as we can do
>
>         foo="--foo=hello world"
>         ... later ...
>         git cmd ${foo:+"$foo"}

All of the options with arguments of git-submodule--helper can be
passed as "--foo=...", and spaces (or other misc characters) that
appear in the option value shouldn't pose any problem whatsoever;
the logic in parse-options.c::parse_long_opt confirms that.
