Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C08163
	for <git@vger.kernel.org>; Tue,  2 Jul 2024 00:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719878905; cv=none; b=oGlSJytqskp9FfmXb6KLyBDhnppxoHDlRnuBEjnV8Kts1CrXTtckEZCH3It3m/OG0x7I1QHAf6eRh/PsMqCNCQGE3/YPs7Qn47SA25GC24iFVf9+PQZ17N4aqOlhc0xrvztBnWf1/1ZHO/UpDM7aaUNI0LFMURmpnBQqOUB/MCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719878905; c=relaxed/simple;
	bh=znnP8fU7ly7vhWOxyfIsubeAUGuaU5Ls8WsiEWu4hoQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=UpcSZk8z17UZZV4ZIymrrRlvy/Kzpi3TETzIGvoA8WZMV6TOu5XrxNkeFx+v1PQUr0WmCyrTpmzzeaOTJf+ltTG/Jgky2KpzYsMHEfF/G4qRvRv4HWBeGKHxKnIOO1Z98ackLtYEYutRJ4G0XOQYwqEN03Tv+tY/kHaJjIPS7s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bmKU64jP; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmKU64jP"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7541fad560so4974466b.0
        for <git@vger.kernel.org>; Mon, 01 Jul 2024 17:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719878902; x=1720483702; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O1T/f5nzOv+5jzgV9AIq/KRO9DdfUSR9mPKsKeW4iEc=;
        b=bmKU64jPcK4wuaWDXMnYoL3IcYuGv0JYKB+oc39ploYhT0V7IT+PRtnpn2HODtCjG7
         KynODRIuKdPphgTn+Ldk94u5OzPXXFLOJn2p19/XXGwSe9ppflvKjSeqsZIZqtEXf9YO
         ANle0nBOjL6nm2UX7wLRVSTZ9VRiBP679a98OfGyxP2sgdW4GxB+fxQMLrxUOuhIp7LQ
         SJHP+xHd8SLQiZ3M5LvV/1VPhBKuaMKtc7qLQokn2CtzzpbXfP0HqxD6GCGj15CEgTjD
         ctCFYqWUmJpZQrntK3NZNijRhkdpzvWp+Ua5r9F9JgihmowYid0doKwYSP7piW9Tfz35
         MZ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719878902; x=1720483702;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O1T/f5nzOv+5jzgV9AIq/KRO9DdfUSR9mPKsKeW4iEc=;
        b=G0W04r3rNFEHVPgocCVnlIYd4ihZEOJ2CIXmMX2dHmDM63z268xCUsNIxfIp8gLVZR
         95ClRPfutSBhjYKp5P3LG6Yxxu09+6tBp4L/UgpW/iDfveoaprRpmagjzMX/YlnX+hZ9
         /dVAt8K9EU2Gxo4Z5PwiYPAr3c692qdBkbC2ucoURRzqauyJAZCN9VKonTX5elGDU7Hd
         q7zMSJvnOMiTZsjqDJ11o5KZJGc9ucJA4QAkmckDNnDqpMXwKkBqC2v5RmYhvo5fdRg0
         jeyd7IJAlvz3Tv62vidkJ9MTjJ2O/XQ1n7BgD9VpiOj9jdfyNana5gDxZhvQ5o4hu+J9
         t0bw==
X-Gm-Message-State: AOJu0Yzb93o+6SX2BbKMTogr8E+/Rl6kuHKmeooifg33FbDasEOo8Tee
	bG3GUzgp+y2ExiPuQiP2K85h0SulbOGW/rt3G0RlScT0sOSEnGkW/9os7Ie/OhR9yGI4xEXC4zg
	P83c/LVoJLPNoEExDh/+M4LQbroJcWGo5efo=
X-Google-Smtp-Source: AGHT+IEJRFtMQI7h3tqkKqERZgPGLHeAD/0vTHV2SRxuQNPdPGlbac9ka9InDUI5fh8rPwrHBkSmIxQ0q3MBywE9xWU=
X-Received: by 2002:a17:907:868c:b0:a6f:63c7:3083 with SMTP id
 a640c23a62f3a-a751441f03bmr568423266b.13.1719878901451; Mon, 01 Jul 2024
 17:08:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+osTZWaDpH_ZcEhHKrzcaWmHjTAiiWfPmf6C9u3NnzmY0PghQ@mail.gmail.com>
In-Reply-To: <CA+osTZWaDpH_ZcEhHKrzcaWmHjTAiiWfPmf6C9u3NnzmY0PghQ@mail.gmail.com>
From: =?UTF-8?B?SmVwcGUgw5hsYW5k?= <joland@gmail.com>
Date: Mon, 1 Jul 2024 17:08:11 -0700
Message-ID: <CA+osTZVMiZDihhiALb7fDO=Q5ntSmUFe6q1YpL=pkzC_tsmoBw@mail.gmail.com>
Subject: Re: Problem with multiples levels of submodules
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi again,

So I made a repro - it even fails locally (you have to explicitly
allow submodules to work with "file" transport).

Try the following:
git config --global protocol.file.allow always

mkdir bottom
cd bottom
git init
echo hello > bottom.txt
git add .
git commit -m Bottom
cd ..

mkdir middle
cd middle
git init
echo hello > middle.txt
git add .
git commit -m Middle
git submodule add ../bottom bottom
git commit -m MiddleSub
cd ..

mkdir top
cd top
git init
echo hello > top.txt
git add .
git commit -m Top
git submodule add ../middle middle
git commit -m TopSub
cd ..

git clone --recurse-submodules top clone_ok

git config --global submodule.recurse true
git config --global submodule.active .

git clone --recurse-submodules top clone_err

Note: If those submodule settings are set initially, then even
creating the top repository fails.

Regards,
-Jeppe

On Tue, Jun 25, 2024 at 3:54=E2=80=AFPM Jeppe =C3=98land <joland@gmail.com>=
 wrote:
>
> Hi there,
>
> I'm seeing a strange thing with multi-level submodules.
> Not sure what's going on, but it feels like a bug.
> (I'm doing this on git "2.45.2.windows.1").
>
> For a while, I've been globally setting the recursive and active config o=
ptions:
>     git config --global submodule.recurse true
>     git config --global submodule.active .
> This has the benefit that I don't need to "git submodule init" new
> modules since everything is active.
>
> The weirdness happens when there are submodules within a submodule.
>
> I can reproduce it by just creating 3 git repositories (I have only
> tried with GH hosted repos, maybe its different if done locally).
> Each repo has a directory within it, and that directory is a submodule
> of the next one.
>     top -> middle -> bottom
>
> Now, if I don't set the global config above, I can:
>     "git clone --recurse-submodules <PATH>" to get everything.
> Or:
>     "git clone <PATH>", "cd", "git submodule init", "git pull" etc. to
> again get everything.
>
> But if I set the global options, I can do:
>     "git clone <PATH>" to clone the top level.
>     "cd top" to go in there.
>     "git pull" to update everything, including submodules.
> But while cloning "middle", it gives me an error:
>     fatal: not a git repository: ../../.git/modules/middle/modules/bottom
>
> Something is getting confused and thinks there are worktrees involved:
>     ".git/modules/middle/config" has "worktree" line in the [core]
> section (this appears to be normal).
>     ".git/modules/middle/modules/bottom/config" is not a repository,
> but just a "[core] worktree" section (definitely not normal).
>
> This all works fine if there is only one level of submodules (top->middle=
).
>
> Any ideas?
>
> Regards,
> -Jeppe
