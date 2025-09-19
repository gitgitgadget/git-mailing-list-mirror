Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CDA25DAF0
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 20:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758313564; cv=none; b=h6OJ96E3VcCyAx3BYO2ue2KFzV4t1e7nNDo9ETlid2sHIJypgnIQx8NIPbAIQpt8beXSc9Bz3jyUKrHGtNhtNNDNOlYPXH1lrat/dBZ5XJNmk+CbbBQIgHnBA+a1/649jxq92v3p49wT/F1z09F+9cB8ASkijhMwiEbCT1QKz/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758313564; c=relaxed/simple;
	bh=zZyWMj345JMK6t6kCUqIwRN4Hnmqthcj+sM0JwqTn0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jr4xlY/nbHH/4n033esPPkuajcyT+NYkf12CvTviJZxueJw5Tvbq/DKCpG77QLhQZRhrwUamf53GrNUBIKKBBFjA3zMAsEvW3igq3iUAykQfFT3fbNDpm4raJUJ7RrPWgmTCHWycGm1TsADdGy83+HRUE/dpoL84/KBH5Wd2Rj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T9OKhSBs; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9OKhSBs"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3612c38b902so24711601fa.2
        for <git@vger.kernel.org>; Fri, 19 Sep 2025 13:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758313560; x=1758918360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zZyWMj345JMK6t6kCUqIwRN4Hnmqthcj+sM0JwqTn0w=;
        b=T9OKhSBsDrot9mXWMATv6xrIKA2GMbmbikeXg/X1363HlJhoEA3THWbM0149UjRUmQ
         D4YEot5uDfWVJUBTGYjyLe/CKGWg+aAu5nfqubKZAn/jnXaOOq0kI5RjGJPExRjJrrGk
         ZGcfHSCwjtXOuzT4xAAjMESlTv2w8FaMcgedbrsSquKRyXK8ws6Zmo+ppUnhl805NXTx
         JgtsjPMxltk5I6r3BELNcYfYoALui9SqCfZMep2Jf0nmpwfiWDHbTRDmLXcqP2W2e/IW
         4WhXSU4E0cvnlldPCUwmBZ6p5q4GL13sxqCmD+/PZtMoux5g6awYA6MfGchRXsvS2x0O
         ioGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758313560; x=1758918360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zZyWMj345JMK6t6kCUqIwRN4Hnmqthcj+sM0JwqTn0w=;
        b=vSdg4tJKYgG4myBhwd0paGEhzv42PfRqFVygQSHh4nyGf/5+hhZxtsisCji2CnJVod
         L2CaYrsWdw3BBo5KcHK79B1MJB5kZTSxg75p2Rjw9EivzHcBYeVEEBN+P0n/slIxncs5
         bHBQscK1ngFYiB793O0exHpsZTLBnuoK8ADOqPcxhMKwZ4ya0/23slxoAj0GUxJbj2CP
         z+nlTiVAvM62ORQ1eWwHmrB+fxfE8+giOwB81Yt2y2cclPrvyeJ6NTlIQ6PrDazSlS9N
         DjLkqdTyAy/tZFPyhkDyfaVCDczOz4Us0oNAsxpP5hGhhZPKJ+St5bCDJUFS2CR8pxXn
         MxBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXL/k3SZfedlsMzSq9K/NYdeo6BZpmwK51J/r0zU3hjSyWmg8CcNHVttREtEOMK0PSII8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDjwb1QbTameMq0X1g1pGL8kb1OYs3tFF6CAg9+urU4yDnnYSI
	PfKdi4EcGMuAQEdOgje1qSOS2e+oOHbXi7N3Tq7c3TSOqAPun3qRBsASmVeucyUsCucpDJpcL8R
	QfOSmmbR8sdio+5WoWfGAlnRIB5Jjh9g=
X-Gm-Gg: ASbGncu1iyp5PydEQlZEr+SMk0IzfJ+x49ReAk3bk1ZSjlcxDJEy5d8K4qGtodqqnxQ
	1FzZxUgZir6hQ1n+N6vdTaVYZWjZzhDB12VPVLqIAkMFTUFTUAYMhmq2kBiWlPIsJdkQM/4qRO4
	a6D31RN1rH61CeqDcFJqf+ZC8I9NsvW6Q6KIUINNAKPfUyoqClHSqHHte7Q43xNvNx8kWdpJcVv
	zhHySt+
X-Google-Smtp-Source: AGHT+IHSqE0Gn6QZxAOX5rY/cLvcPvC3iJQScrBuoX3diEUkIkQIK1hCuv2CFmfU/MmU8JkHUVSV9Zf2kGE+MPIDfDg=
X-Received: by 2002:a05:651c:144:b0:363:60ae:f777 with SMTP id
 38308e7fff4ca-36416fa7829mr15852431fa.25.1758313560240; Fri, 19 Sep 2025
 13:26:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
 <pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com> <6a27e07e6310b6cad0e3feae817269b9b8eaed69.1758071798.git.gitgitgadget@gmail.com>
 <CAPig+cTZch_pvfurtjBTNphMeRQL6jSBSjNY-4mffjoXZ4eqcw@mail.gmail.com>
In-Reply-To: <CAPig+cTZch_pvfurtjBTNphMeRQL6jSBSjNY-4mffjoXZ4eqcw@mail.gmail.com>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Fri, 19 Sep 2025 14:25:48 -0600
X-Gm-Features: AS18NWCw_utff3JamS8dn6B5gsApDrfetwolWqG2Jvl4STCUPkJh0U7iG2JRsTs
Message-ID: <CAH=ZcbAO8143RLqhriPY-W6=TzOFa5_CBfbJmM1-WWFhjAJrxw@mail.gmail.com>
Subject: Re: [PATCH v2 13/18] build-helper: link against libgit.a and any
 other required C libraries
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 2:51=E2=80=AFAM Eric Sunshine <sunshine@sunshineco.=
com> wrote:
>
> On Tue, Sep 16, 2025 at 9:18=E2=80=AFPM Ezekiel Newren via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > build-helper: link against libgit.a and any other required C libraries
> >
> > Don't link against the C libraries when building with Make or Meson.
> > Run cargo tests like this:
> > cd rust && cargo clean && USE_LINKING=3Dtrue cargo test
> >
> > Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
> > ---
>
> Perhaps it's because I haven't been following the discussion closely
> enough, but the above commit message leaves me entirely in the dark.
> After reading and rereading it several times, I suppose it is trying
> to address some difference between building with `cargo` vs. building
> with Make or Meson, but it gives no explanation of what the
> differences are or what problem it is trying to solve. So, please
> enhance the commit message to begin with the "why" and then proceed to
> the "what" or "how".

As I partially explained in previous comments about my commits. I was
trying to get the Rust compiler to link against libgit.a so that any
Rust code that references C code in Git would work in Rust unit tests.
The way that Cargo invokes rustc and links to libraries can be
controlled through build.rs. To use an example; When build.rs prints
the following lines to stdout:
cargo:rustc-link-search=3Dnative=3D/path/to/git/build/dir
cargo:rustc-link-lib=3Dstatic=3Dgit
The first line tells cargo to tell the Rust compiler to look in
'/path/to/git/build/dir' for objects. The second line tells Cargo to
tell the Rust compiler to link against libgit.a. Telling Rust how to
link against libgit.a is only needed for Rust unit tests that
reference Git defined C code.

I'll drop build-helper for this series, since it only helps with
linking against libgit.a for Rust unit tests.
