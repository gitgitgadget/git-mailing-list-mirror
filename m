Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193E83A1B6
	for <git@vger.kernel.org>; Mon, 22 Jul 2024 21:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721684133; cv=none; b=lCqVjlgtbQoTSEcmBRlYNBj9NjNEBUGvsChOKeXMGkt9Zkywk+SK911G6yj6MzQemIOVwACRvOJT6ejk//ljhlGI2Yjqg5xQNY1Z7mE3EnNs/YSs2zxHeadfVhGVn4rncusiWoEseahpe+kd3x+zd4+6fsoObR/vNlnMXIO9oRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721684133; c=relaxed/simple;
	bh=4rWYUgojzIuiO7cdkowFhPSz2gP6T1mt6KNcGXhiFCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BtS+BQchCExKe2qmR9gFlXJBYumBr78K5hroM2raW7hp8CCHN6WxEpi8dBfwb//lASt0bIAGJ8cKI/sRaT7ZmkYTU11/HFUGS0aEPYi5VzQBWHnu89YG+U/NGDPrPWo4xJtG62HAifPUUX2UgAMuvftP5yRRJ9ANRiGXOM4PwFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=orFdFuLD; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="orFdFuLD"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ef2c56da6cso17447591fa.1
        for <git@vger.kernel.org>; Mon, 22 Jul 2024 14:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721684130; x=1722288930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v0Nt9zZ+oFxokBRwjcbLtdmNVc6pG5opBWJlv5X4Sc8=;
        b=orFdFuLDjL864WfYyxLkfJ4eC6QX4VWhiG8piDwwOdoNR3+h0cS2jrcNwuaKQ0al7A
         CxAHLdv6MfMuMjtyvpMxle+fOWcZU7wsmdztRM/qcYbTIeWYxlL1vcS0aA7PETwIRaJt
         Jdo+w+rN1e2DEKDTzsdPEh7+Sq0r5OX5OIP4heoQolAk5oKKaVW/Sev/W0oasmFBNTxQ
         ZcUhG8ULVsVmuJlrEJu4NBmcJ/8ixhJYj2fdOGuDJVibi0e/ooZIw2WcPpF2t6RqYF8v
         GEvEnq0xgIBxwdx9W0AHAQgYnwG8CWLRY1wDgc6bBI+O5s+y/0ccY5vDIhLZmCaKyVji
         2puQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721684130; x=1722288930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v0Nt9zZ+oFxokBRwjcbLtdmNVc6pG5opBWJlv5X4Sc8=;
        b=v0XnyWtlkbqpjSpLKFuORuSE+gibyAI2pJojNVJL5itq6rTW5HrrSWyDcmYvf5/rrR
         8F92gkyBLYkHwVzpdrXdcedFCZmYlMZEaX2fZfpLjpGDj+ijP1hacctiQhuqauWkXYQa
         erFaP0quF+jpq/Dx99qCC07UTk7BPyvaGC9QDoRDuYEt6Am8JNmeNlND5AD70mklZxNB
         ti3yFKEIk3DoZ3V6khrqbGgvcZWQxxokFCIMnKmr9q6c0wUkuPxKjQrpq790i+OflvkN
         QZgdTZ1lakdqxq0JLu7QIkDZ2ktcsjoK+9gmZjvT9o9mMtnwGqCRdcl6axeIMkraEXaq
         DJ3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWaktTOZLi4t7vXTTCfZ+XkuPZtRltv0Y7Qa++aZVlDHWWAkUJ0B2pn5CddgvgoTZC8h5GDQOzGI+KUCXhZ4KNKGrJY
X-Gm-Message-State: AOJu0YxZWbxvL33qRIzJ/YZ0OzsUEkH/hg0usHsbWo0r8UgcEFLoQbAJ
	wbwxQk8A8uRgRA/0tzSF9+XGg38XxQ85cleF8nF8aOgFgKeLdDLSnoayY0dbkdTbwC9f1Me3UZw
	1shVGINPL74Dk2vow8KdHP3A18jhLt010aPe0
X-Google-Smtp-Source: AGHT+IGcym7yUlAN+w0eUZSY62xC9MG7JSbFvP4oGoPk5KXeRs4QR+3kHzxMRX+LVzxeuFELk18aad5vS+JFGTXgbEA=
X-Received: by 2002:a05:6512:3b82:b0:52c:d8e9:5d8b with SMTP id
 2adb3069b0e04-52efb7c7e96mr5576170e87.25.1721684129767; Mon, 22 Jul 2024
 14:35:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722065915.80760-1-ericsunshine@charter.net>
 <20240722065915.80760-4-ericsunshine@charter.net> <CAO_smVg8+WCG0dWZNPVbDM4gBJLLHrg96nOCzje6B3hUGneDGg@mail.gmail.com>
 <xmqq34o1cn6b.fsf@gitster.g>
In-Reply-To: <xmqq34o1cn6b.fsf@gitster.g>
From: Kyle Lippincott <spectral@google.com>
Date: Mon, 22 Jul 2024 14:35:18 -0700
Message-ID: <CAO_smVhd_fWkC1=9r_ASCEPoM_rRap3DAWq--nq+6dQ8M8qzjQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] check-non-portable-shell: improve `VAR=val
 shell-func` detection
To: Junio C Hamano <gitster@pobox.com>
Cc: Eric Sunshine <ericsunshine@charter.net>, git@vger.kernel.org, 
	=?UTF-8?B?UnViw6luIEp1c3Rv?= <rjusto@gmail.com>, 
	Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 11:10=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Kyle Lippincott <spectral@google.com> writes:
>
> > Is there an example of a shell on Linux that has this behavior that I
> > can observe, and/or reproduction steps?
>
> Every once in a while this comes up and we fix, e.g.
>
> https://lore.kernel.org/git/528CE716.8060307@ramsay1.demon.co.uk/
> https://lore.kernel.org/git/c6efda03848abc00cf8bf8d84fc34ef0d652b64c.1264=
151435.git.mhagger@alum.mit.edu/
> https://lore.kernel.org/git/Koa4iojOlOQ_YENPwWXKt7G8Aa1x6UaBnFFtliKdZmpcr=
rqOBhY7NQ@cipher.nrlssc.navy.mil/
> https://lore.kernel.org/git/20180713055205.32351-2-sunshine@sunshineco.co=
m/

Thanks, this one leads to
https://lore.kernel.org/git/20180713055205.32351-1-sunshine@sunshineco.com/=
,
which references
https://public-inbox.org/git/xmqqefg8w73c.fsf@gitster-ct.c.googlers.com/T/,
which claims that `dash` has this behavior 6 years ago. The version of
`dash` I have on my machine right now doesn't seem to have this issue,
but I can believe some older version does.

> https://lore.kernel.org/git/574E27A4.6040804@ramsayjones.plus.com/
>
> which is from a query
>
>     https://lore.kernel.org/git/?q=3Done-shot+export+shell+function
>
> but unfortunately we do not document which exact shell the observed
> breakage happened with.
>
> The closest article I found that is suitable as a discussion
> reignitor talks about what POSIX requires, which may be more
> relevant:
>
>   https://lore.kernel.org/git/4B5027B8.2090507@viscovery.net/

This claims that `ksh` "gets it right", and I can confirm that ksh
does behave this way on my Linux machine.

Having just looked at the POSIX standard (I don't think I'm allowed to
copy from this document), the POSIX standard (POSIX.1-2024, at least)
explicitly leaves it unspecified whether the variable assignments
remain in effect after function execution.

Thanks for indulging my curiosity; should we include a statement in
the linter along the lines of `# POSIX.1-2024 explicitly does not
specify if variable assignment persists after executing a shell
function; some shells, such as ksh, have these variables remain.`?
