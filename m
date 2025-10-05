Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD4726C39F
	for <git@vger.kernel.org>; Sun,  5 Oct 2025 11:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759662908; cv=none; b=rO3jaRjyRaLFzI9qy1HwAw2ynXmxVf/aZ39l2fU/Lf+e7WND8CM8Y4esXzPxVS1CAeNf3/wYeBsi5egYcejZs2CR2psiJ7mOPxwuXBS35g9QeqYTW8gYJuo9fCoTYGdc81ySEBZ44lnxMVJ1PGCXov/DHXEChfl4yYIFQU3Sy6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759662908; c=relaxed/simple;
	bh=CCl152L4vK+Z3oXgcX99Dtj1rSo3tANWDJ7/8dzRWS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RtsR+Opapg1PkrrNC72yGtsbwyST2f815tl02uC7B9ywagb0agMDs0zrH1cdP01ybfKiXkf0DMJWaVXqwD5GKUYHgUNjMhA/oaWARRvtb/42x1yvEjq3+UoykPQlJEL4PYJLZ6JsrZyqWRadNQAb+B/anpznsuo24xSqbJK204s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=acOb89A5; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acOb89A5"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-36c0b946cb5so32555121fa.3
        for <git@vger.kernel.org>; Sun, 05 Oct 2025 04:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759662905; x=1760267705; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=36kRqH0eiv1j5VHJK5MSG7l5GHCsUWjkAgy7HuK6vLU=;
        b=acOb89A5Abe/mcQX1zzcRdkY+E5cdpklKMRWp0lO/9weWvhssGXlTLi1wJNBuVl3Vq
         Sxgrn/bZCTIFVDx3x/PFyGc/TXCq+b6nKfGQE/8iW0jeWgSihkjDZqHYRoLzxhqeLgHV
         wRDpifUFh9K61Xd4GoAzz6oUzyggCVu5+ZaH9OLoNhlrgPqw/1YZue0vB0xdAqBoR/7b
         RuJNQd28sRVVT+HtUrqDTjaBPNhatO5AfTiRWcP1Mw+KzsSiBKs4lHAaKkYQLcrhkO7Q
         phZ14UEeju7wWEqV7261QiLesPTvhBU6dXZ8ZN0u1PMIPdLD6FFqf+3YEp65+kVzc7JR
         5zJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759662905; x=1760267705;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=36kRqH0eiv1j5VHJK5MSG7l5GHCsUWjkAgy7HuK6vLU=;
        b=cx7C3G2nTWakMABbocMzAhfjGfbsZgl2lz/gHUaceN4zlDP+tDN0YgoBpnZq5DQobZ
         EDT5mdSolaaSyGmOBFIuzKssATBiqvOauCv6UZL0JPFJy7JizBt+VHWH2H4cWtqevbFR
         B3aHBM7UsY2UCMiM/C7rz2ap2ASEPKtZInUndAeBZfgeTfMe6lx4Y2a6yo/nVHCrW6ju
         1odatOCUmkLKPS3JWh5JMHn7nt4LTzZc/P5jE1Gsdhb6CCrLw9kuQ4WnASAA4hcZlPoO
         nOUQ/HABtmwTURCYnyF6NqDzHL2lf/9SyUslNpXgFmEwLbpATK1PsLB9EZqHj607Wm5r
         H+dA==
X-Gm-Message-State: AOJu0YyPYXJSzwnGz6K/jpmWzsRt916fUvGkVpPHbIEAkPIRh1OjRPiV
	aVK/wsq0g2B20ldL8BnZHCzd6jEbTJW3bHMvmucQdOIEtinK3zQDXdCFkY1nyY3IYimhb1l6liA
	XADr0APQJkxxJH+N+wDB2s4Z99CmL/WyYhZtahbk=
X-Gm-Gg: ASbGncvvLbyr/CNwTUHb8pSjgMeTcsF5xrjaed/7G0eM5VJKsl9E4cToF/glvx56cJ1
	DtowHwRX/s5Xv/RKClqKB+OvmGZrl7/igUGWEMK6fUB6/L60iicq83JELBK0dj5RTmj+7upkIED
	/yGT9hvg2aAi6LRK/iVKWb7zEzJhLjc2OWD3OaYLEgYkHpverkgqyxnLdFR1akdiIn5SwzvmBF1
	mTZfpnkIFaLMEOvakxsIGmqiuYA7TYLvrufIqc=
X-Google-Smtp-Source: AGHT+IFJUcotI+OvTzFQ00g6w6ysoj1byGdqfLXoTPWSBAfMUulaCKY5kr6kMHzGE49WBUwHK/rwoDggN+2cUV8/0R0=
X-Received: by 2002:a2e:bd07:0:b0:36b:f63:2785 with SMTP id
 38308e7fff4ca-374c3837131mr30264381fa.27.1759662904183; Sun, 05 Oct 2025
 04:15:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANM0SV3+4k5tsgRw0g8-HoVSFGb1AwZr+2hCUXLriFGSd33WQQ@mail.gmail.com>
 <lrahpvp3nj4rtewf3zbf67qsvwhc4mg6irbmrhklbizxbhqwom@cc25oeqex4il>
In-Reply-To: <lrahpvp3nj4rtewf3zbf67qsvwhc4mg6irbmrhklbizxbhqwom@cc25oeqex4il>
From: Devste Devste <devstemail@gmail.com>
Date: Sun, 5 Oct 2025 13:14:52 +0200
X-Gm-Features: AS18NWAIBOXFjQdjwgD2o3FMpbzA-2xYDITese0c3tKSJJsn5Q-3u3EQWB2EV9E
Message-ID: <CANM0SV38YcQ+THbAyTR5cnaX3iDfb92qG8gyAzUaJ5jMK7FfYQ@mail.gmail.com>
Subject: Re: Untracked files cache not used when --untracked-files is used
To: Matthew Hughes <matthewhughes934@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thank you, this solved the problem indeed, status.showUntrackedFiles
was not set at all in my case.

However: it did not work/update the cache initially with the command
the IDE/GUI usually runs:

git config status.showUntrackedFiles all

time git -c diff.mnemonicprefix=false -c core.quotepath=false
--no-optional-locks status --porcelain --ignore-submodules=dirty
--untracked-files=all --no-ahead-behind
real    0m3.463s
user    0m0.000s
sys     0m0.000s

time git -c diff.mnemonicprefix=false -c core.quotepath=false
--no-optional-locks status --porcelain --ignore-submodules=dirty
--untracked-files=all --no-ahead-behind
real    0m3.423s
user    0m0.031s
sys     0m0.015s

time git status --untracked-files
...

It took 3.41 seconds to enumerate untracked files,
but the results were cached, and subsequent runs may be faster.
See 'git help status' for information on how to improve this.
...
real    0m3.691s
user    0m0.000s
sys     0m0.015s

time git status --untracked-files
...
real    0m0.773s
user    0m0.000s
sys     0m0.000s

time git -c diff.mnemonicprefix=false -c core.quotepath=false
--no-optional-locks status --porcelain --ignore-submodules=dirty
--untracked-files=all --no-ahead-behind
...
real    0m0.818s
user    0m0.000s
sys     0m0.015s

---

One of --no-optional-locks --porcelain --ignore-submodules=dirty
--no-ahead-behind causes it to not update the cache it seems.
Unfortunately, I cannot tell which exactly, because now, even when
unsetting status.showUntrackedFiles it uses the cache for
--untracked-files=all
This means, that if the untracked cache was created with
status.showUntrackedFiles all, it will always use the untracked-files
cache for --untracked-files

On Sun, 5 Oct 2025 at 02:20, Matthew Hughes <matthewhughes934@gmail.com> wrote:
>
> Devste Devste wrote:
> > It seems that using --untracked-files(=all) causes it to either not
> > use the untracked files cache (or untracked files are not stored in
> > the untracked files cache if they are in an untracked directory?)
> > Since various tools and IDEs use that hardcoded, fixing this would be
> > a massive performance boost for many users
>
> What's the value of your `status.showUntrackedFiles` config var? I ask because
> I looked around a bit and found commit e6a653554bb49c26d105f3b478cbdbb1c0648f65
> (untracked-cache: support '--untracked-files=all' if configured), which
> includes:
>
> > For most users there will be no change in behavior. Users who need
> > '--untracked-files=all' to perform well will now have the option of
> > setting "status.showuntrackedfiles" to "all" for better / more
> > consistent performance.
>
> Testing this out on a big repo (on my Linux machine):
>
>     $ git init .
>     # create ~100_000 files with plenty of directories
>     $ for i in {1..10000}; do echo dir_$i/{1,2,3,4}/nested_{1,2}; done | xargs mkdir -p
>     $ for i in {1..10000}; do echo dir_$i/{foo,bar,baz}/file.txt; done | xargs touch
>     $ git add .
>
> As expected, status with untracked files and no untracked cache is rather slow:
>
>     $ time GIT_CONFIG_GLOBAL=/dev/null git status --untracked-files=all >/dev/null
>
>     real        0m1.237s
>     user        0m0.484s
>     sys 0m1.150s
>
> Status with untracked files and `core.untrackedCache=true` is just as slow:
>
>     $ time GIT_CONFIG_GLOBAL=/dev/null git -c 'core.untrackedCache=true' status --untracked-files=all >/dev/null
>
>     real        0m1.250s
>     user        0m0.435s
>     sys 0m1.216s
>
> However, with `status.untrackedFiles=all` (i.e. matching the `--untracked-files` flag) it's much quicker:
>
>     $ time GIT_CONFIG_GLOBAL=/dev/null git -c 'core.untrackedCache=true' -c 'status.showUntrackedFiles=all' status --untracked-files=all >/dev/null
>
>     real        0m0.382s
>     user        0m0.214s
>     sys 0m0.568s
