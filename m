Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FE71B4233
	for <git@vger.kernel.org>; Tue, 21 Jan 2025 21:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737495141; cv=none; b=dT8GdYGSkC0ZHYk4scM11P4d2EgR6qMDd6k9QmNgCZc20kcfPUbq7rR41HIFnd0O6qRqmFDkW2PNvahIj80aXbMuzXyHbYh7T9xcVSb55OmZiy/esDjU4dQYA6KD0pHrnMY55722Gyp7HAaONG0RASmgGpIPo/8oWVJHcppnhGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737495141; c=relaxed/simple;
	bh=4adHDktWKN+OJgFCCE3sGw7MN0Htbbuaxfu9EgfjlHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZaM1Lb8FmepwEc/AyJbWe2+b6q0IadNaXdzbik/JPWAXyDTLqcuIeSRWpOOjmOBWeokYTcJf7q2XF1MxGjOUDZDHGXGl58RPJaUxr0mc3oj03hVo8c7UzO4sDAsdwfTF7AEugeb/8S6FpotHKHnveTKttQ8d0rmHF8T5+xkPe0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S6jFQAYm; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6jFQAYm"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9e44654ae3so873885966b.1
        for <git@vger.kernel.org>; Tue, 21 Jan 2025 13:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737495136; x=1738099936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4adHDktWKN+OJgFCCE3sGw7MN0Htbbuaxfu9EgfjlHI=;
        b=S6jFQAYmuoHUTr1kLp+CqPf9RE6kTSG7pIOraRVn2cIjmj21by2q3KGnjzaYciK0n6
         DYcgBlSziRz+pl7cJ5orkUnAjQB9Er9Dh8E4vhU31mP5uqbZUwOJPQMJN/BYituI7mGH
         kwS8bkEPe73PmWqV37VS5pCtRcyM3IoECuawjEVv22+i6WKGhKYYd26cObFIE4jzC0uY
         vJOGpZW4rhWk3Q2VKAyLMAQZpmLpD8Xe3tCUNlzadC8sP7BI8wCxUhqr3a5DCw4wnBT6
         8GNgSKcDbLtYXChWLbq4ZsUqInJw1Hu1JxlZcEVinyrDLUm3KCc3f8sRh/QzPNhxrIEn
         zmlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737495136; x=1738099936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4adHDktWKN+OJgFCCE3sGw7MN0Htbbuaxfu9EgfjlHI=;
        b=Jl1cjUnWz9jXlnHNvn4VGBGnC7sDDlt4GR6qljq+4KepH2u0yHHpeXkavcMIoX4FCR
         sEHLEvWOf6j+bVL9MywSiArReagqb8/6VggnWWSYy/18RVczOc5pPkL6ggD5tnGGQi+S
         rO7jt17lOCPmUI386Z2jgQ5Gh50bqYlx3tx4GioR0KbJHjaoNXwvulSanNyvHo+Lau4i
         qLCwSeWQMJLuOEJmglY1iemaCJUyb0ycQuwI6YLInMaH+KsURh1rwdqTT8PKYKGTHEze
         T9XekEdFDBmbelNvnIge5OmYBKwQtX2Dj9dUy2s5cful/g1ugNb2mN8OrqWjCZ3/B3nH
         Uf5A==
X-Forwarded-Encrypted: i=1; AJvYcCUXVIn9VF6XV9XQtHrYik8/ld7i9lDS8mKANqS7e7bKB1BFT0dsI2j06J35REXgzXC3rhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwemB/hAxmmm1o4kauUUbdfwVZLH3fWvzHBKzYOXgjsRWs0hk3Z
	hvhi/3yosgqtlvjA4fMEPpx0ezhWajJiZiIQ6UdeCP5BH+3PINa0n/nk5j2ZtXJFnz16cyJG55l
	9yAwLcj2k2knxiW5kdtZ0ZJeGqRY=
X-Gm-Gg: ASbGncv7Go1Uj+jfpfi35BCm79LabJTttkBVcSDtKgTuhrQNqJ0r7X35WdMUfB9UYq7
	HyAqBMBzKcNdQMqmUFVlAv2c6w9ZWdBrFoqIhJyymQFNUiMPVBqRF+/Kbv6GU+/uoMcXgUrU+Ho
	zhebfMays=
X-Google-Smtp-Source: AGHT+IEaCGdkLF37b+CZWzcQxvjjYw00jZRwUZOc98Dt6vN0qfcssY0HTNqU/CHCraOCXI6E7XCOAqSVBvpPBAUcbHk=
X-Received: by 2002:a17:907:6095:b0:aae:bd4c:22c0 with SMTP id
 a640c23a62f3a-ab38b1100b4mr1578290866b.19.1737495135562; Tue, 21 Jan 2025
 13:32:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <DB9PR05MB110863344D3776D13B436F563C1E72@DB9PR05MB11086.eurprd05.prod.outlook.com>
 <CAJoAoZnecm5y8243R9JsGjRDuv-Mb=UAwa+Hbj5CKDKNPBLB4g@mail.gmail.com>
In-Reply-To: <CAJoAoZnecm5y8243R9JsGjRDuv-Mb=UAwa+Hbj5CKDKNPBLB4g@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 21 Jan 2025 16:32:04 -0500
X-Gm-Features: AbW1kvaZDX9flfvj_BykmP2QcqGkT-O2MqHsLERHNboAxL7DPJH83RBN3bsqOOM
Message-ID: <CALnO6CAEaOUNwMpOTF8wKVd7LAv+UiU5W62ZCBc0U-K_JhHU-g@mail.gmail.com>
Subject: Re: [Feature Request] Allow batch removal of remotes with 'git remote remove'
To: Emily Shaffer <nasamuffin@google.com>
Cc: Christian Fredrik Johnsen <cfj@johnsen.no>, "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2025 at 4:16=E2=80=AFPM Emily Shaffer <nasamuffin@google.co=
m> wrote:
>
> On Mon, Jan 20, 2025 at 3:07=E2=80=AFPM Christian Fredrik Johnsen
> <cfj@johnsen.no> wrote:
> >
> > Hello =F0=9F=98=83
> >
> > I would like to propose a feature enhancement to the 'git remote remove=
' command.
> >
> > --- The Problem ---
> > Currently, 'git remote remove' only supports removing one remote at a t=
ime. However, it would be useful to allow batch removal of remotes, as in:
> >
> > `git remote remove remote1 remote2 remote3`
> >
> > This would simplify workflows for repositories with multiple remotes wh=
en clean-up operations are needed.
>
> Hi Christian, is there a reason why opening up the config (`vim
> .git/config` or `git config edit --local`) and batch-deleting remotes
> from there is undesirable? If this is a solution you believe only
> power users need, then I'd posit a power user can both list all
> remotes *and* remove the offending ones in a single editor pass,
> rather than having to run multiple `git remote` commands, anyway.

I'd posit a power user can also do something a bit like (Zsh with GNU
or FreeBSD xargs) `print -N my remotes to delete | xargs -0n1 git
remote remove`, or (portably) `for remote in my remotes to delete; do
git remote remove "$remote"; done`.

I couldn't find a comparable command beyond `git branch --delete`,
which _does_ take multiple branches.

--=20
D. Ben Knoble
