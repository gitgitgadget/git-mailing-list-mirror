Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6A681AD8
	for <git@vger.kernel.org>; Tue, 26 Mar 2024 09:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711445583; cv=none; b=LtDuXhH5Lu01ztD2i+XQpk5g/qXDZ8QDSF0E7fY566IJN72RjP33BzNTGbRC8HZFegHb5X19/jRYOfe57dXyy/oXjY1o+7glUaUjiwzOWbHKm34D9WvpnqYUkR0FNggnHJEZCmBUrVZdCqYkblGSoQGo6OWKdZy9f4LTZOaiTSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711445583; c=relaxed/simple;
	bh=Y4gnZ29j9GY5NcCC6jOj9AhO5dUNIvMQndda85Ia+u4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=et6DmgaboreCGGKr8l//aBWMIHR6VzZbwctrCaPxV4o9CCeXrAI55iOkOslG/aA8T+D7f2LR/3RsK9lrILGxvHk/xAsjWDcBxrIhGciqXZf4IjYCfQtuJ/PrKgAYrQ5TYZcuGnuguH4S4DFFCsKJUftGOA14EaU/j3i8ksKQc1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGL1d6s/; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGL1d6s/"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56c147205b9so2813831a12.0
        for <git@vger.kernel.org>; Tue, 26 Mar 2024 02:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711445580; x=1712050380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=016H+Xv2FypmmPupMPfsMpgIdoKv0+jeQpRbQ/mdqnU=;
        b=kGL1d6s/tBjyNdiT8Cr0y/tR9EaWPP8twZ0a55NsQ5LDWYRVvyG2BP7Yd9EljrBqpe
         TVf1UaUoqPy9lcrMQVvj5dKbo0HOAIDivWRM5Jw37rDHa+Of+M0LXqCsCi6kObZw84/2
         uGmwGfCfVGX9bktCjKeAwMCV1O92PrjQ/PwON2w4nFg+nToTfv+GLq0E87lYRCZh55Yv
         rZ3/pKW6174pO0o60036Qy1xxoKLRwMC1UD8PaQaWkTZRHJ+8uMTkH07xA86Y74P0ii7
         bwn3pmknga4h4aBvhc1Egrn5TzLJAGGKPY9Sq2S6g8ucFL3052ETm7rgbQtwEfaKZvdL
         FR4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711445580; x=1712050380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=016H+Xv2FypmmPupMPfsMpgIdoKv0+jeQpRbQ/mdqnU=;
        b=QltZOwnXF/urKxnaMZ9P5a/kmaJDZbDSKMMJjLcIOFg/SOv/rJTlJHhmiEDqQ/C/5T
         4YragGmkzBAOjhog21+Vn95GLTUMXHdHi0+AL501lu0B6wdRu6Zyg+tXvkOhlB1wiqGa
         D4trmD6140H0E61eXvaBCuKzOiSmpabLng1yP5LLOgod2midpgGVlPhBEldWYRVKbwKb
         w5SAyLtJBlMkRWAWMi6V1FO34CTBdjic0zLoQURsuv6MA6aGYvvQjqop4JUAjpE7YY88
         OtQaFSgKXBq+poyK+lG9/O2ZtprU2Kcv/219UGscNitYlfuT2fp98VeFdrbJuT9h44E7
         aTsw==
X-Gm-Message-State: AOJu0YwrgPCbS9A4gnHLROANQFTwqwWXyzPbWLz+MVyNmLCX6jpPbc/q
	pXRVMk+lrDt11JzbityEN87kR/RuVmSkJVYY1ug+VT10h8ghlEwuY5/NK+f9fhNe0diKUMnuCzj
	9PPXw9Y6RNafXzjwKzMllXL7HJsgq1cEe9oj/Qw==
X-Google-Smtp-Source: AGHT+IH7g5lhVaEkUX+AsSv/D/HBq3gTAl7M8im8rKxOfGIBT4kfbR3vwtEcATCOkSe1f0ecnC/Tl3NhVHZ07+6MekQ=
X-Received: by 2002:a50:c350:0:b0:56b:d1e6:efbf with SMTP id
 q16-20020a50c350000000b0056bd1e6efbfmr661318edb.20.1711445579590; Tue, 26 Mar
 2024 02:32:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP8UFD2COoXfDdS1eg5DR_0NL8bOhCHvXUkqkfzLbSejRmgwSw@mail.gmail.com>
 <20240321202218.13648-1-shyamthakkar001@gmail.com>
In-Reply-To: <20240321202218.13648-1-shyamthakkar001@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 26 Mar 2024 10:32:47 +0100
Message-ID: <CAP8UFD3xiGH72BRdQ=76npUKp8pCF+cLXoNYkUFUNKyejWDSAg@mail.gmail.com>
Subject: Re: [GSoC][RFC][Proposal v2] Move existing tests to a unit testing framework
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org, kaartic.sivaraam@gmail.com, ps@pks.im, 
	karthik.188@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ghanshyam,

On Thu, Mar 21, 2024 at 9:22=E2=80=AFPM Ghanshyam Thakkar
<shyamthakkar001@gmail.com> wrote:

> @@ -294,8 +325,28 @@ have not setup the blog yet, it will be at:
>  ----Availability----
>
>  My current semester ends on 30th April and my exam/viva is tentatively o=
n 7th
> -May. After that I have freed my summer for GSoC, therefore I will be abl=
e to
> -give a minimum of 35-40 hours per week.
> +Mayand I will graduate after the results are out in June. Therefore I wi=
ll be

s/Mayand/May and/

> +able to give a minimum of 35-40 hours per week after 7th May as I have n=
ot taken
> +up any responsibilities in the summer for the purpose of GSoC.


> +----Stretch Goals----
> +
> +These goals may not be achieved during the GSoC period, however, these m=
ay come
> +in handy if the migration is done ahead of the schedule or it is determi=
ned that
> +the number of tests that need to be migrated are not sufficient to cover=
 the
> +allocated GSoC period further down the line. These can also be done afte=
r the
> +GSoC period. (Note that these are just personal observations/ideas and m=
ay not
> +be accepted by mentors, hence '_Stretch_ Goals'.)
> +- Enhancement of the unit testing library. An example of the need of doi=
ng this
> +  would be t-ctype, which bypasses top-level macros such as TEST(), in f=
avor of
> +  custom logic with the use of internal helper functions.
> +- Add more helper functions in the unit testing library such as handling=
 and use
> +  of parameters defined by environment variables (which I personally fac=
ed in
> +  implementing t-oidarray.) I am sure there are other such utilities whi=
ch might
> +  be worthwhile.
> +- Adding support for performance related testing through unit tests.
> +- Working in other areas of the codebase not related to unit testing or =
doing
> +  other tasks as specified by mentors.

This makes me think that it would be nice if you or others interested
in the "Move existing tests to a unit testing framework" project could
review Luma's patches that haven't been reviewed and merged yet. See
the "Key Achievements" in
https://lumap.gitlab.io/posts/outreachy-internship-conclusion for
pointers to the patches.

Thanks for updating your proposal anyway. Except for the typo above,
all the changes LGTM.
