Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0995717C68
	for <git@vger.kernel.org>; Sun, 22 Dec 2024 12:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734870014; cv=none; b=s/szi8ezWmSiKtpOCLgB84OjdTXiHgSme+TNjIphid/EfEcDCeU/g+koZSiR+1PzeGGnZXHQU4NGZwIXUlhEy+DNhI1r7D8rqE2SjGNStNkU9lfNgT0Ig0ksxXZRK+JZeaEeg/ZJGOCn4e7feX3XTtEW5GceHguQ5xmilD53Ws4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734870014; c=relaxed/simple;
	bh=x/2B/HcYGwRKrLam9NDqcHF15mLqO/iytDSY0XuuDQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=knl6rdOVezHaMsQ1MCn+nujxar2wz9yKDP9Z84Rky/vuZSCisvvw5765+9pwerwqScLX8PsvocyZYSGC0WzPbblNu3jMoF9KXLW4xYyvlrDM4S7NgZqVkXUgX2SiPGwWlR2n7y/gcE5T/2rzPef4s4bifStjaZcRmB/RhnFFqlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FnM6omeC; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FnM6omeC"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2eeb4d643a5so3166418a91.3
        for <git@vger.kernel.org>; Sun, 22 Dec 2024 04:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734870012; x=1735474812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kzmcEjbxGzwVCcCnlMRO3GrqiqZqEpNInGkFNTSh/5s=;
        b=FnM6omeCJqEm+hB7Lcl5L0otwvEQrK9btcc2CxXKsoXZah/pvWbMcE2gmKFDLFbx4E
         NDWVhEjWleKtrsKM55NlbEwB/j9IdCX9PzouhhcQoKwvxa8ibK9PvquYVSfidBpnnQ2N
         LvCgjF2WaDWq4BtPfHEd+z/M8hxu4rzPqVbenmAGXQpIRtGBD1G5ZX9ZNLqOhlmriEvO
         gcjjFYsw6c0O4OyY4b8T4V6Fq4VWLEkAiguPLYefQlNGNXJfp8CvTBqek2KmQH2wuil5
         l8ObBna7Sxn5sJW9DKggYJ77LUYds72FjkWp/8PKb7A6tUu6UVUG//FhbfWg/B3GTTUc
         gpjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734870012; x=1735474812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kzmcEjbxGzwVCcCnlMRO3GrqiqZqEpNInGkFNTSh/5s=;
        b=mch9Xl673W15PoVYDWQg5zgIDaenRv1psxay661gFra3rcYkeIaorh3CiZiGnX2VoY
         6s0Z2f+DsiaSE8S0N5mz95y1C4T3wVGLqM6ptg2RyOF+d20NEtwNHuh/0IAhPLY7V2jn
         DKXPoQxSZf1HsRn/44sk0hfj33b8BSc58ybekHaosQcCJXnmaYaqZuq9UhDNGMYfLrY9
         w5dli56n1ZAh4qXLAOWHCFHaLmaua/tWcFaY0NDiMItXrUQR5vbCpRfm66cvdtYdRdv/
         GA+8gbNJJEWMWrooSLk/61Q6ZHMSN4NDAqJYD7Kz1MLGmLMt12pq+SuhTG3NY74IeDkD
         OKBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKBwusVO+MBnynstL2IYJB96wC3Bf38Y+94JZrXSEnX/ldrJXeWbEmXmCUjKnsi33AWGU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycd2YFhoehfY8ekWaCMFE3/+khEP8R6xuA9unnr/wHeV5Tq3Ey
	e2G/dyVKVLAkYofTZ99dawvZQSbElMkCvmySmkvPtsiUVS/3jqcRl5eLp646jlOsoQQR2znhSV8
	DMBHP5XLgokI7PgBnQkZeI9nxw24=
X-Gm-Gg: ASbGncsDwCPm5wZIRDdfnbWdriCEwa+8lPt2H2Q5/z+KWGsrI1A3h2u14PkwlVhERWE
	1bSOwDx8upladYODCuucHPExj3fVsBCt3Op5IdA==
X-Google-Smtp-Source: AGHT+IGOup7wcJu0a+hoVD23MkdC+90zQYbVL8IWK1gZHb4nPospupEy9EVUxv9nz6Wbpm7kgmK+fp5n5g/7Xc5vuHE=
X-Received: by 2002:a17:90a:d647:b0:2ee:c9dd:b7ea with SMTP id
 98e67ed59e1d1-2f452eb12famr14288840a91.24.1734870012180; Sun, 22 Dec 2024
 04:20:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG=Um+0v=BmmYjvBAXs4r4My6zYvpJvcE+0U6SAnxKUcd1-A4w@mail.gmail.com>
 <Z2Emh42DJkHFGWq7@pks.im> <xmqqcyhq3ge7.fsf@gitster.g> <CAG=Um+1NwB=ymwg+oM62f_W8G=3Gt14UFGe+S2MM3gTOdUcuHg@mail.gmail.com>
 <CAG=Um+0yFYeBQGznkVG6TJeN-U+qySbt-0EbvM6Vd-BcvSCT4g@mail.gmail.com>
 <xmqq7c7y13tc.fsf@gitster.g> <CAG=Um+0qGEf+pX0cjCA2Qti4NYwFeCb29zgS7k2Lu_0yfuEz-w@mail.gmail.com>
 <xmqq34iluhqy.fsf@gitster.g>
In-Reply-To: <xmqq34iluhqy.fsf@gitster.g>
From: Shubham Kanodia <shubham.kanodia10@gmail.com>
Date: Sun, 22 Dec 2024 17:49:35 +0530
Message-ID: <CAG=Um+2cdMcys2x492_i47-qdvx5aJ7k6r=xSH5a3JZtMZBEZw@mail.gmail.com>
Subject: Re: Consider adding pruning of refs to git maintenance
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 9:05=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
...

> Ah, are they using "git fetch origin +foo:refs/remotes/origin/foo",
> i.e., only selectively fetch the thing that they use and nothing
> else (again, their wrappers may supply the refspec to do the
> limiting)?  Now it slowly starts to make sense to me (sorry, I am
> slow, especially without caffeine in the morning).
>
> Am I following / guessing your set-up more or less correctly so far?

Yes. The root cause of the issue here is that the behaviour that `git
fetch` / `git pull` fetches all refs by default is undesirable in
large git repositories.
It's almost never what you want to do. We advice users to execute `git
fetch <remote> <ref>` when they want to run fetch (/pull) explicitly.

Ideally, `git fetch` would only fetch the current branch when an
explicit branch is not specified, and `git fetch --all` would pull in
all.
Now I believe git does provide a way to configure the default fetch
refs via `remote.<name>.fetch`. So in theory I could just set =E2=80=94

```
[remote "origin"]
      fetch =3D +refs/heads/master:refs/remotes/origin/master
```

which would avoid someone pulling in all refs accidentally.
However that has a side effect that now if you do want to fetch &
start working on a remote ref that you weren't previously tracking, a
command like

```
git fetch origin new-ref-branch-from-remote
```

no longer allows you to just start working on this new branch by doing
a `git checkout new-ref-branch-from-remote`.

If you wanted to be able to do that, you'd probably need to do =E2=80=94

```
    git fetch origin new-ref-branch-from-remote
--refmap=3D+refs/heads/new-ref-branch-from-remote:refs/remotes/origin/new-r=
ef-branch-from-remote
```

which is pretty awkward to type everytime.

Now to come back from this little digression, for now =E2=80=94
- We ask users to set both `fetch.prune` and `fetch.pruneTags` to true
(so that if a third party tool does do something, the damage is
limited and they don't have an ever-growing list of refs)
- Setup this job that cleans stale remote refs on a periodic basis,
which means that their ref counts heal over time (if they configure
all third party tools right)


> Now, the documentation should explain when this "periodically running
> remote prune" is an acceptable workaround and/or a useful solution,
> relative to setting fetch.prune, as most parts of the existing
> documentation do assume that the users, intended audience of the
> document, are using the bog-standard "git clone" result, that copies
> all their branches to remote-tracking branches.

Agreed, will update docs to include that.

Thanks,
Shubham K
