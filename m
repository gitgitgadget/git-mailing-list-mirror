Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A68920DD40
	for <git@vger.kernel.org>; Mon, 26 May 2025 14:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748268069; cv=none; b=M5kBp4NJT0uc977UIrqPm5R6SztRKwNHzcJw4cWpi7fk54SU3SHxlqmsPpdjy28ArEcFpILkjVgFSg3rm8DSNhgrV7XHhTnUj98wsVuZuveyf+6iMeYC2fG0XNC4Zhsgv80J//94mB/acHndWKp6VyJca5ja7MilgaFVFUjGHmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748268069; c=relaxed/simple;
	bh=vmqOWkKPyAPvinOcat/W0KG3TLwI+vS0nEtGc1qmsU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ds6fNstxUtUn1Gt9qvAUyDL5QUkZYH4ap5bN6azvVY+zkOvTKnutKxFVqLBMFtrhEfCdeH1DaOtXE0WMLB3f8iE80W/Kt8QjhUH4Y4ToZ4UQ/HTgnsqgZSjJkbtqpzYxn2v8PIkxxEOhQnlI/SioY8pYAe1H88PkdS8Srztci9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XTGeEwkr; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XTGeEwkr"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ad574992fcaso432120266b.1
        for <git@vger.kernel.org>; Mon, 26 May 2025 07:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748268066; x=1748872866; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5nnX6HF5FDW5bfd8/1at8hNrjEhYkjYdnKMC3LVaOtk=;
        b=XTGeEwkrv9zckz6onShtJ1yMvAYUoZfV60QrMQ2HBugiYBtznnNO6nKVGHKvsuEeXq
         at13+QAXecYbOxFckDkPo4ImZmlAmrq8iA47Nqih29HtcnAUjGtpTAfokd9jrj2nwcXp
         hMB6P9GujMxsFwtR/mM800fbFkej54AxEsXXWHEAFGMjqiLO2qzbMD63b43jW6zGdW03
         irajNBOnnBfV2MjWTxNL5P6468mwNhqgPlo512+7KlY/30vjDyhusWPZrtvXPkmLlJSt
         /gjIhE7N4IlZMUAYGnQKKH7qNfoQnd4cT5/4/d7BSlwb4GEBMsrjYlSZ3jltA4Wcav6b
         5DGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748268066; x=1748872866;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5nnX6HF5FDW5bfd8/1at8hNrjEhYkjYdnKMC3LVaOtk=;
        b=r9PQrciW91WvA0TQl8xdXWNgV2AZamDERzSgKyl/6O5ZK+WzhV1dXhJ0RfRpf69HA+
         mNwKv+suQJHdSYfc/pFTaLukT2a+a8yZ5x+De4HNin2jX49COCyYjV2qZuGJloavovTc
         s2vmyT2RUSn1foVvQgZE79DIrVdOL/20LyGB8jIuySbTgEyjKPEQu+q7JpxyqCl3Snbd
         rMgrfWpZ7NEa2IjaeYmTuMB8wBI9iyF9VTbFdSsFYIi/8rSK5Q0KKS770PzDDs7Oiw77
         Sg1gEY3JOTzw5TnqyL0yNSqAgNS7xuBr1g7Yy9oNzW5lEujeWlvPTZUDKsch/8dEyyxQ
         XHoQ==
X-Forwarded-Encrypted: i=1; AJvYcCV414pm/OXiUb75/DYM60XhZbhbJD8Hd2AHyEiJWPKZRhyDZaGdxisfrkECaKZGBHkjSmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU9FAqU3WehXwYYuoI9/Zrm9rVLpzkecU4QMjeygxeT3CGq6eU
	bWLlqt9Sj7k6rjSWSBp1IF3I3oNgteG4tlb3rW0h4raqbcD98iFl1D76
X-Gm-Gg: ASbGnctNQHjliTA44BDzDWTjzzWn56+pR5OyQ1FUxpNwVl227y6nwsWpwQWtkSYE6w2
	sO2ObCOwzcrk5TeAzmkmqdAoqoBgRJUbpxpc4Ot4oG+k6gJuBYanXFZ8yVdybs+oABZPxm5pFXq
	+3qvPbAKJ1J8i7wQ+yfRMU9cf1moEDNmq7U6u5XdscOy8CcEfG1sJauPrlqWq9ubiAVKANt3PJL
	DBsnDfNeGJM548oFFGMZh1Y+VG6DPoB0Rw1p3pfd6HGi55BD0vs8jOR+jI3Tub6i5OJzhVlMeVj
	oa11vWsby5s3vPcTGgDbTD3zbLiRul9Lp5ynG1h6P6JYzPyBhrWxrBexocnfRygWRol6Lk+2HgS
	MICN1+AOuJBcBrLhBWYbAP98+yHw=
X-Google-Smtp-Source: AGHT+IFLmn9x+dlDHA4A9LDMBykdS/w1Xm0Pfaw7AwL8uw4tI6rS00bj+AIkGl1EEmTEy7nUztFWMA==
X-Received: by 2002:a17:907:7ea3:b0:ac2:a50a:51ad with SMTP id a640c23a62f3a-ad85b0d1dcemr857200966b.14.1748268065321;
        Mon, 26 May 2025 07:01:05 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d490910sm1694223066b.135.2025.05.26.07.01.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 May 2025 07:01:04 -0700 (PDT)
Message-ID: <66e92d69-8372-47cf-a350-95365f72ca1c@gmail.com>
Date: Mon, 26 May 2025 15:01:04 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] notes: remove trailing whitespace from editor template
To: kristofferhaugsbakk@fastmail.com, git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
References: <c59ae2c0c7c8420ec1c5bedb87f28c7f5b573a60.1748122397.git.code@khaugsbakk.name>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <c59ae2c0c7c8420ec1c5bedb87f28c7f5b573a60.1748122397.git.code@khaugsbakk.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Kristoffer

On 24/05/2025 22:35, kristofferhaugsbakk@fastmail.com wrote:
> 
> diff --git a/builtin/notes.c b/builtin/notes.c
> index a3f433ca4c0..ca4782eca19 100644
> --- a/builtin/notes.c
> +++ b/builtin/notes.c
> @@ -180,6 +180,8 @@ static void write_commented_object(int fd, const struct object_id *object)
>   	if (strbuf_read(&buf, show.out, 0) < 0)
>   		die_errno(_("could not read 'show' output"));
>   	strbuf_add_commented_lines(&cbuf, buf.buf, buf.len, comment_line_str);
> +	/* strip trailing whitespace introduced by blank lines */
> +	strbuf_stripspace(&cbuf, NULL);

It doesn't make any difference at the moment but I'd be happier if we 
stripped the trailing space from the commit message before commenting it 
out. That way we know we are only stripping space from the indented 
lines produced by "git show". If in the future this function were to 
start appending the commented log message to a buffer passed in by the 
caller rather than a file passed by the caller we wont mess up the rest 
of the buffer content.

>   	write_or_die(fd, cbuf.buf, cbuf.len);
 > [...]> +test_expect_success 'git notes add has no trailing whitespace 
in the editor template' '
> +	test_commit --signoff 23rd &&
> +	GIT_EDITOR="cat >actual" git notes add &&
> +	test_grep ! " $" actual

Should that be " \$"? What you've got seems to work with dash but I'm 
not sure if it is POSIX compliant or not.

Best Wishes

Phillip
