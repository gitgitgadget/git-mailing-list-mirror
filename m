Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0389F42A8C
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 20:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741292694; cv=none; b=NunlYxVdaaa1ByJ336oN914O8nCDEnwngUU/uX4M1tUU9FQdD2OlcFD9CfYnPI02SXUnCr78Kr1kczxhoTSGyH6L9Gg3nhqsdg1qVsRkOJ7SENg0EA3UWWYbHj0mde+s05M5ITttTrWSjNWjej/qaoGVFqy++XrHZ3OAQfR5NoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741292694; c=relaxed/simple;
	bh=1zr0Xalr9XrpSzoSMHjgDmQ+HDdc0q5FKLfwL+ZKzDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rm716+b4wEm+k4OEAD1P+3s6DUANYTqQn68+PZ7vrwPBAf9/6h9rL9e7luk2vJGZO7yjtsb9R2nli/iBWF+O0Lw44iSbiByZxS6OK912vCMb1iYzAd1XHf0iinQLnN+ebRGuwxhMioiOoBDfoiVUV09aYgyhPzXqzNtwg2W+BDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSpRcve5; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSpRcve5"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-abf4d756135so188101166b.1
        for <git@vger.kernel.org>; Thu, 06 Mar 2025 12:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741292691; x=1741897491; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3jYzYpVGiid1iTM8BHdzBH3oI2knLkIhmJAFxJbQI2Q=;
        b=BSpRcve53WWDQggfUViaImyMHUJCcRDmdzAt6NDczh25/0Or312pdMnWHVssLqKAGG
         EiTj0LwPWQCFwkj7Jc7pWvZmXUE+b3zIpL7PzN/7AYiKQJsQA3KPZsle6hvFn9cu3t9H
         sIqkPIGyrjsCgkXxVxHly/wG6bA+vCg0JmITRFQDvgubpKLEnZpK0hi5AZIm8GfxgX62
         lf8/Rq11n26eP3xtGaQ0Z/EMQS3ASgPVX1uyCuVZzDbbD1uWYY1vwoKP3bPSAx1h8E93
         kLB47eWSaCOZNKqw79lj0QzwRX25t7FGsp3sOZKTaSL8BTdWrB79ycte17mWVPbW07ue
         QkvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741292691; x=1741897491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3jYzYpVGiid1iTM8BHdzBH3oI2knLkIhmJAFxJbQI2Q=;
        b=Fq0QO9VzBNCvxgRR5kTcU25zqSfDB1cwTWZ4smpfpNCO5Y52L86JW43Qbt623J2LYe
         4Bjjtr0/p3X0qdus2pH9VkjBxh+lAZ7kqk7Ukq2RjuvFPOKSZZj5LyG9CZpnhU3BrNXJ
         iktXzfZgJg0Ixfy7qO3yrLz9KepojtXBHQdnwIAR9bNTO2Kl+UalZY1AQ7WcmZhz7Xfa
         DkTlo95/G16Xak9/xyb55J7A7EpJ0KwCFmzoQFAfCFXF4/KTd28pu0pTVNOgC9NzSt9F
         UrEpgd9JlHr2bclr665Ik5cEpunn0aM9LZMP6/wK9ZvcxayCUUrL33doE6tXz0q7eZJK
         UOZA==
X-Forwarded-Encrypted: i=1; AJvYcCV7Osm5qaYDhCwDby/+bCA9ZqRAVcfyQfgoyfiC3Hcj6xivtvCrRxk4AqwfpDrk/6qb9pE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/FSGeK3qQx+60kmHFuRIWJLYWK8HQK/7JV9D0bYmaVDDTME9h
	gzrpdm6Y2TAoUd9pThWEIEocP/djHQiP6BGeP8iVNFmohzW4ftx2+Ula82g61igp0wibZhXEkcU
	SOs3r+IpoURjTHo5fU8PNhncUFcg=
X-Gm-Gg: ASbGncsnb5vkrjHH0Dv5lINfDSUWD/ZvhrlnAdwrlxotgr4PQaUcvt0WLtYInFIA2ez
	9cjNM/p5p7zCT+4OoemK983/9LXliAmEl2V1idwO3p3wBXJXEJtnoVKFZlrx8kPKXxwdHbWu0dM
	PyyOoD6kX4AcTmX3to+3VE+FGaHRzODeDVDswYaOOT8xPFOd7RY2QN8kfN
X-Google-Smtp-Source: AGHT+IGxbavGioVbf8Ml++VcNe43eb/Vtpf3g8YzNhnX7mwuFgD66hUGflpR0be4doSu6BnYCVSsVMN9IaQkDyi9j/Y=
X-Received: by 2002:a17:907:1c9c:b0:ac1:e881:8997 with SMTP id
 a640c23a62f3a-ac2525e0444mr52180766b.3.1741292690848; Thu, 06 Mar 2025
 12:24:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1901.git.git.1740901525.gitgitgadget@gmail.com>
 <95ffa62df6ce394249a8ddabb84fb2b517825fe3.1740901525.git.gitgitgadget@gmail.com>
 <c03192bc-68d3-4645-9bd3-93a338a7496f@gmail.com> <2323bb52-f43d-4f40-8955-4c648677a93e@mandelberg.org>
 <65d903c0-6b4b-4a55-b7e4-4a277417f0f1@gmail.com> <42dfc06e-8eb1-46da-9971-9d102f1390ad@mandelberg.org>
In-Reply-To: <42dfc06e-8eb1-46da-9971-9d102f1390ad@mandelberg.org>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 6 Mar 2025 15:24:39 -0500
X-Gm-Features: AQ5f1Jp6G0Stx941GSWnt_YsS1qt3IelsjT54CoH3-mtbgrdK-KrfGtqGZY7jVs
Message-ID: <CALnO6CBDjQgc2TNaXbBWiUNqWV=RgrL2Ry-7HzRu3Ozuqazzvw@mail.gmail.com>
Subject: Re: [PATCH 3/3] completion: fix bugs with slashes in remote names
To: David Mandelberg <david@mandelberg.org>
Cc: phillip.wood@dunelm.org.uk, 
	David Mandelberg via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Jacob Keller <jacob.keller@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 2:25=E2=80=AFPM David Mandelberg <david@mandelberg.o=
rg> wrote:
>
> Op 2025-03-03 om 11:36 schreef phillip.wood123@gmail.com:
> >>> local sed_cmd=3D
> >>> local remote
> >>> # ref names and therefore remote names cannot contain '*?[]^' so we
> >>> # only need to escape '.$/'. Using 'sort -r' means that if there is a
> >>> # remote called "github" and another called "github/alice" we will tr=
y
> >>> # and strip "github/alice" first.
> >>> for remote in $(__git_remotes | sort -r)
> >>> do
> >>>      remote=3D"${remote//./\\./}"
> >>>      remote=3D"${remote//\$/\\\$/}"
> >>>      remote=3D"${remote//\//\\\//}"
> >>
> >> Just FYI since it took me hours to figure this out myself: I think
> >> this would break tests on macos because of an old version of bash that
> >> handles backslashes weirdly. I think removing the double quotes would
> >> work around that issue, and be safe because word splitting doesn't
> >> happen in assignments.
> >
> > Thanks, I'm not familiar with bash's extensions to parameter
> > substitution. The completions can also but used under zsh (git-
> > completion.zsh is pretty much abandoned I think) but it looks like bash
> > and zsh agree on this expansion.

I don't think "abandoned" is the right characterization=E2=80=94at least, i=
t's
the completion script that Homebrew-installed Git users will get for
Zsh, and it does re-use the Bash completion scripts (which therefore
ought to stay portable between both if possible, otherwise we get
stuff like 8776470cf3 (completion: repair config completion for Zsh,
2025-01-06)). The Zsh script has seen some fixups over time (such as
my own 3c20acdf46 (completion: zsh: stop leaking local cache variable,
2024-04-30)).

>
> The tests don't automatically run under zsh though, right? Maybe I
> should try to figure out how to do that in a separate patch...

Correct=E2=80=94which is how bugs sneak in ;)

I'm willing to manually test the patch if I can understand how to
reproduce the issue=E2=80=94it sounds like having a remote name with a slas=
h
is sufficient?

I started trying to test Zsh completion a while back when working on
one of the patches mentioned above; I got as far as this hack [1],
which is to say, not very far at all.

[1]: https://github.com/git/git/commit/d8918195f18a503aa1a42fed3c66a0af8d04=
131f

--
D. Ben Knoble
