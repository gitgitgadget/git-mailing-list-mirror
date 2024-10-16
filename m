Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9A9187872
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 18:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729104556; cv=none; b=CUjDQgBDKCDQqrakGtmbZZT6LjPPAa+37nbeDF51v186rGteYrprA4Et0rbvVW/ZuTxGGJda/AWyNHqC6zztPeH3lUjZGfIcEhonNVenKMqTQjGTNU2IRWLvMZf6eoJFldLxpAlDk/QTt8V+6vhQkREXMweJH+yCoE0vF8G8AEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729104556; c=relaxed/simple;
	bh=ZD4KX+w4wHRcYXvGYI0sF1jjJ7w1flytbaTzPbgUIR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=SDbwjXqqGDVd41DNAvp33IdkIhysPPFhfaU43arF8KfmgAT+f6Su0ICcRY9MPl4jmkZtKcKxvsH/q3QZ6USHHhbv3w33vVBTLZvsteXD7fvt/v2DNFHEf7i44awXQpGhkwo+WMzbi+Nx0mP4L0KnCkvdhFXOzGJp0a7l1Fb4m/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TpML3xsu; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpML3xsu"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-50d2d300718so71719e0c.1
        for <git@vger.kernel.org>; Wed, 16 Oct 2024 11:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729104554; x=1729709354; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZD4KX+w4wHRcYXvGYI0sF1jjJ7w1flytbaTzPbgUIR8=;
        b=TpML3xsugwnpNqu/yucYOi6lgFnL0epKCvKrybciB3xjaCcMWZeYszYr0Di0E6+Zde
         YOzGdaV7u9FriD7fg9pR1EwtKfbs4b/1tTgZx7QXhU9EkNqjUIzfBI9rhIOoz2SibYoS
         uVi6hic2ED2/e6uOoIcokqO7k8tryZ2/Wi95lJ195c5Kzylybgy4aJkQIR8fhlplqfPq
         j1lzGqPm8mkcTLlEaWw5mv11HA+eFiFsQpIBpvJ1njCGB0tT8M1YGvDwBM24rOgnlq0k
         TPCLBqzBBrWsZ99Mh9uxtiHNm4CDhy/seSEXMPkgIqKcpT7R3EwRvgsixM5hX6EnDz2H
         PY9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729104554; x=1729709354;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZD4KX+w4wHRcYXvGYI0sF1jjJ7w1flytbaTzPbgUIR8=;
        b=Wr4Q6Dyf7+919DLLL0p9F5Ex7NBVIMOj52yY1LcLVoGCrw38/F4GCEsIfDHykjjA2O
         EM3TkQ5Uu4AXnObLlFUa8zuSB3Z99JszmTNhEppDkuGv+GhHSWEnW/LQifTTjZOvgbvD
         RIDiebFSZulIbTzSym72DUFSmHURQQ8stkz6M05iOsWaWReTNrv/z4hprtTbKqxtjvPs
         mhfIrxOPu3re+GqHLkjL3vgOZa3Jw3CGss4IxxAcb9DOwNDh9NfeMkxNDL1GR+1sXLbd
         R+eXxjETTvWfcnYivThTTp0lXHEZ/nVvF8xztvS0oEFhd4zLqCKn0tlgnIQGv9h7W8mx
         nCNg==
X-Gm-Message-State: AOJu0Yw5IhGDZLXIWeMLCQLekXN3cPwlJFaeGoFke5di7O+v6+LlzjtR
	h4JGnHCINhi0vddGa6An3cjNE6hbt2J4OJMo9T62N6JxK/w5pfPrzDB7kumxgaDc6OgHkrgsSEP
	AMEVlg9s+869uS1PRHaACQ/x6GsMQMoFDo24=
X-Google-Smtp-Source: AGHT+IFKDm5onNrQ1B+N7WdvDQKvsOn4JRrt9pORuAGjSUe5rcByzz4sdifxiyEy1KdluMn72r+WDdjUKknxTKHulXQ=
X-Received: by 2002:a05:6122:a27:b0:50d:2df1:4c47 with SMTP id
 71dfb90a1353d-50d3774a163mr9905572e0c.13.1729104554051; Wed, 16 Oct 2024
 11:49:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH08wShkp6Mnz5itcbT=GyCY7_dW5eQWLy0yBFS8njUHumpQZw@mail.gmail.com>
In-Reply-To: <CAH08wShkp6Mnz5itcbT=GyCY7_dW5eQWLy0yBFS8njUHumpQZw@mail.gmail.com>
From: =?UTF-8?Q?Germ=C3=A1n_Ferrero?= <ferrero.gf@gmail.com>
Date: Wed, 16 Oct 2024 15:49:02 -0300
Message-ID: <CAH08wSh7Jzn-RoziaEM3mDcEEQqcnKpnrSZKPTD9yn9BmZgQxw@mail.gmail.com>
Subject: Re: git submodule update --init breaks if run twice in parallel
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry, it also happens on version 2.44.1, It just seems less likely.
But if you try enough times you will get the same error.

I guess this is just the way it's supposed to work, and there's nothing to =
fix.

On Wed, Oct 16, 2024 at 10:07=E2=80=AFAM Germ=C3=A1n Ferrero <ferrero.gf@gm=
ail.com> wrote:
>
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>
> What did you do before the bug happened? (Steps to reproduce your issue)
> git submodule update --init & git submodule update --init
>
> What did you expect to happen? (Expected behavior)
> Something like:
> [1] 334031
> [1]+ Done git submodule update --init
>
> What happened instead? (Actual behavior)
> [1] 333889
> error: could not lock config file
> /path/to/my/repo/.git/modules/path/to/my/module/config: File exists
> fatal: could not set 'core.worktree' to '../../../../modules/path/to/my/m=
odule'
>
> What's different between what you expected and what actually happened?
> The difference is that in the expected behavior (working up to git
> 2.44.1 at least),
> I got no error by running in parallel git submodules update --init.
>
> Anything else you want to add:
> In our scenario git submodules update --init is command run by tasks
> that are schedulled
> potentially in parallel.
>
> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.
>
>
> [System Info]
> git version:
> git version 2.46.0
> cpu: x86_64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /nix/store/izpf49b74i15pcr9708s3xdwyqs4jxwl-bash-5.2p32/bin/b=
ash
> libcurl: 8.9.1
> OpenSSL: OpenSSL 3.0.14 4 Jun 2024
> zlib: 1.3.1
> uname: Linux 6.8.4-2-pve #1 SMP PREEMPT_DYNAMIC PMX 6.8.4-2
> (2024-04-10T17:36Z) x86_64
> compiler info: gnuc: 13.3
> libc info: glibc: 2.39
> $SHELL (typically, interactive shell):
> /nix/store/izpf49b74i15pcr9708s3xdwyqs4jxwl-bash-5.2p32/bin/bash
>
>
> [Enabled Hooks]
>
>
> --
> Germ=C3=A1n Francisco Ferrero.



--=20
Germ=C3=A1n Francisco Ferrero.
