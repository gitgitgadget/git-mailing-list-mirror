Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA852BEC43
	for <git@vger.kernel.org>; Tue,  2 Dec 2025 22:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764714595; cv=none; b=Mc+Z+7I58h7kMoURbPfCR3c7bTCILJhdncBerj+PI4lOSFZOWaWN87/dKHx5hnPPknzvLox+w7r3WpJsvmvnjPKNZGqTJj6prRUpAOSGzffIwPBToKwPUv/if2TJQqBEh7kQXdc779KbzedpQu7/KbM66i9GabILwbinYRe7P1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764714595; c=relaxed/simple;
	bh=4K16relcEOi/jKCpISWZuP3DUOo/GULIixPLWJiiMPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dLHw30y7sUPaNDvNvuR70OhW1yvVxC62qM5WJrcgSpDADeJN+Hv9JhQSm/DOlVarcYI5HUEM3vnorzqjR2EsHg5gL2b+Fo8amR6UHifm5J6CL3hf5jueP+l0sJNLGbqQkAlHHWpNgiisGU+7wFIHzUYGKnahId/SlXoKUETXNNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NOWidQkZ; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOWidQkZ"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-343ff854297so7938344a91.1
        for <git@vger.kernel.org>; Tue, 02 Dec 2025 14:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764714593; x=1765319393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GKj5T0NMEo1vCJhfHgvC+uS58TQqVhllOmDCDTJ7YHM=;
        b=NOWidQkZJi4/FoNa2Tx//pf5sUKKaQzwA+e9qo1Jvg75HV1CztB4CoOgRbvgoYmcTc
         ndxvCBzbZM3GXUHxT7gVa7LDbVwbH5QIeofZd9xGKoO2gZ1Nstf+Yts9EL0WfGMLnVLp
         G7bBl6gU+eV6ejtLCCuLulSpjTIwdtgAcUpsfSC5PXwMDKW1l3I+Py++tlX0uY0nsvrg
         iZS6Iz6/ZUh+QL14+2kzHMcMrJ6oz/bGwVvjDfI5m3lmMa4BYRIMXHEtfQd/WTIblgsy
         ORoQqa19GO+OOGXzp71ysijOEBxrIr18OtUOQ7UcjmqCwfOq9XAFx7/ifJXYyLn3UrZR
         hGOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764714593; x=1765319393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GKj5T0NMEo1vCJhfHgvC+uS58TQqVhllOmDCDTJ7YHM=;
        b=G+O4B7kQ7ecRPNzj8esO8BPejCZhSRgjpSX8wJEHzDeoqMVn1KQksoTMCpgN7lPhYY
         DPzrN4bp6qP9R4ndxNgCH9tm6aBM2QZqobzGy6Qq90Jc11DrV5W2mgYVMKfWNFexM0Ho
         I3qWH7QwwNAQ0p4LDNmyacgkukZAayTl1H1WDrvub9s8t1X4THB/SSB22hRnLch55VFd
         bbUJJLeeE7QXwqfvEDxUytQRVFv6fkSuS4BSlMLBSgV61p51SRzIHowFZtmnAV+8VBUt
         Uj+gE9te5RketPtgB5yhnACSUo95Qs0//6kDVKQg8XzZwZ/JUn2EVMBGKd0caDog6jzo
         O9yA==
X-Gm-Message-State: AOJu0YxjH5NRQ5a4eZkijdv32edlyGH4KysykAY7qqhI+w1pAKDXsKAj
	kzBSfXi7LvYPXKaf7W0qTT0F1AKtAv/B4yxxVj/XbhpUKUdHNbYVUDKblKXhSDpSS4oXY+QfAQZ
	E/3RqbBWRnuTfAboxTCuI1sT+HgJNUOReuw==
X-Gm-Gg: ASbGncsn3GY+wiIGcBFf3zqou/mf9DasuGN7hcvhH2jM0cweJQnk701DVE4StEkFU5u
	6V94ZaPRKsp7eD1b35iqykYdgyHuOxk/MGSoqkC6M9nzO2FBBr1mJ4w1eMiZgKSsfmyejaYJbOx
	FrhoiIk8t+3EhibdWtHGOPDh7H0hDJhzwrGt64BSfMQptc9/Cek+URDXkf/8Rf48dHkKCuFCzqT
	WAKzo3l8t2ISoaeiZps0uurO3fPoLMba+Uwmje6WnUyxbdtRv8bIyLXnwcOMvbJ7nEXqRyEeMxs
	8Zj8IdybgRjNW2xhCVO5ssppSYS4Hw==
X-Google-Smtp-Source: AGHT+IE0G5/XTww86rwDvWj10o8urhLCKdabbMd92oT3gcSYapiZH5aMbLbAZRnbySH+F4Y+8m6LQ6nfZfSGXPHnYH0=
X-Received: by 2002:a17:90b:2752:b0:343:cf66:cd9a with SMTP id
 98e67ed59e1d1-349127c9c43mr293628a91.17.1764714592722; Tue, 02 Dec 2025
 14:29:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2011.git.1764688047077.gitgitgadget@gmail.com>
In-Reply-To: <pull.2011.git.1764688047077.gitgitgadget@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 2 Dec 2025 17:29:40 -0500
X-Gm-Features: AWmQ_bkupWVdjgtfRQA-4uORcJXfBgpRNBs66dT0XDp-uAFt1XWBob2NxFmqNB4
Message-ID: <CALnO6CB1igUL7nv6ByUmwMRc9tqEvs=18wD81GNpaA=FLpL2vw@mail.gmail.com>
Subject: Re: [PATCH] lockfile: add PID file for debugging stale locks
To: Paulo Casaretto via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>, 
	Paulo Casaretto <pcasaretto@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 10:07=E2=80=AFAM Paulo Casaretto via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Paulo Casaretto <pcasaretto@gmail.com>
>
> When a lock file is held, it can be helpful to know which process owns
> it, especially when debugging stale locks left behind by crashed
> processes. Add an optional feature that creates a companion .lock.pid
> file alongside each lock file, containing the PID of the lock holder.
>
> The .lock.pid file is created when a lock is acquired (if enabled), and
> automatically cleaned up when the lock is released (via commit or
> rollback). The file is registered as a tempfile so it gets cleaned up
> by signal and atexit handlers if the process terminates abnormally.
>
> When a lock conflict occurs, the code checks if the PID from the .pid
> file is still running using kill(pid, 0). This allows providing
> context-aware error messages. With PID info enabled:
>
>   Lock is held by process 12345. Wait for it to finish, or remove
>   the lock file to continue.
>
> Or for a stale lock:
>
>   Lock was held by process 12345, which is no longer running.
>   Remove the stale lock file to continue.
>
> Without PID info (default):
>
>   Another git process seems to be running in this repository.
>   Wait for it to finish, or remove the lock file to continue.
>
> The feature is opt-in via GIT_LOCK_PID_INFO=3D1 environment variable.
>
> Signed-off-by: Paulo Casaretto <pcasaretto@gmail.com>

Sounds interesting. I think by the time I wish I knew what else was
using the lockfile, it's too late for me to alter my environment.
Perhaps (in addition to allowing the environment opt-in) we could
opt-in via configuration? Or is this really only useful, say, on the
server side where the environment is carefully controlled? I don't
relish putting this variable into my environment to take advantage of
something that looks very useful.

Are there downsides that make it necessary to be opt-in? I also
imagine this could be a useful default; occasionally folks at work hit
something similar and ask "what's up with that?"

Only other thing is: just because a process X is running doesn't mean
it was the one holding the lock, right? Since PIDs can be reused.

--=20
D. Ben Knoble
